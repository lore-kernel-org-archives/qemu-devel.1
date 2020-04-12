Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EB7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 12:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63F620705
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 12:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63F620705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNcDE-0003by-Ux
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jNcCd-0003D4-9b
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 08:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jNcCc-0005qQ-3e
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 08:59:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jNcCb-0005pd-Ri
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 08:59:10 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N17gw-1jGiVN1XII-012aeJ; Sun, 12 Apr 2020 14:58:59 +0200
Subject: Re: [PATCH] gdbstub: Fix segment fault for i386 and m68k
To: Changbin Du <changbin.du@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200412104421.77975-1-changbin.du@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <df254e55-88ba-2d49-7397-c68562367f4e@vivier.eu>
Date: Sun, 12 Apr 2020 14:58:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412104421.77975-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C60LAwWXLleSuL/fJLm8adwy18SAvf11U4wQ6mBQWtLOdeIwV14
 nq/A5hO5o2Uih5yvP0WPTfhvwAFuSDIRhWYTMgZgyrTfDX5gZbgbFXvlq5t74eU6OFCF9n6
 65T+yZymhqPhxB5HE4qhVeH9UJGCJ0A8wDkYaoBxLZBxsX2sMRXtdoVKGuELmLjKuyDkShV
 PhU67LWiTKK8bhJ9lV0ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGoMeBM8ROQ=:US408o+Vh132NxWHQWPh4G
 /2TpKHXptjVWn26BPfXYq5mNuIz01p1je0yhTEZNgqFD+ePomeXoCShN05Krfb60Nc5mN3kzi
 sZghU5fAqtW0EoQ4tuOkcW5tiL9s6TkuKabbD2l2RFHTdPFrLcCjur3duxnnLmp3WTHmU1kK4
 SQ+BOe9r4Yua4y0io6uF5IG17upDNlOwzUZQrWeK0hibg+0hPtPZwQmPjhJgyvo3alRlxOUEW
 NXewq+xzFR2qXvjYL/hVoUWEknshbv618emKo3WIaYM4kJ8zIDZmu/11EpSF6zPsdqcITyJH+
 kuBtB48gip4u/0lIDiu05cDCCnb0l/spjL1Dowqpytt7Q/jwmFTQwzdDiCYoRQ5hMCYM4B7m4
 y5uuTkGPCb1wbkq4aGLIGbvbVgAgrFaZ2WmVuUiUj0uJ0PlOV7bw3kauJdAIL6K7w6ogcW1qH
 fqiYULYCpT9228IrAEP1oSaiAdhN/cAlXNjJBEb2ST8s2EZpVk5ubPxp4rIQOgE7vVOV/s/5I
 +QNJhRJ/qTdN4xEKohxmPc+6QVTPgadN7eFvMKj6PCAoLMQQbOGczbr3kenT5uOD7in1jzaME
 EMke1hfPjkJ8nL8qigl/KwJzVoLYZjRNGFdD7HIIdn0jxN1mNiIK6b6AOO87rgPSlYvKhH/F6
 KH1jdKY3uF3EfJpmGjbPrXQ0tUjZXjN4LwrBDPNvMQ4OJZvOZePAwpO9OetdPZanR/Fyn9hIk
 IEehCUOz7a27JA7vXZBCcbojQ2bkBFDDzBE8WrD0Z1AuV76EkiS5qWcTxdhksOJgA+xFJu3BT
 6VmgDAwrqIqeOzKHYqJL4jLVodwW1z3Rcmpw7xoahur8rO1m1ltkAcyGVG38cOOuRqKLnjp
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CC: Alex Bennée

The one for m68k is already queued by Alex.

Thanks,
Laurent

Le 12/04/2020 à 12:44, Changbin Du a écrit :
> With GByteArray, we should pass the object itself but not to plus an offset.
> 
> gdb log:
> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> __memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:384
> 384	../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: No such file or directory.
> 
> Fixes: a010bdbe71 ("gdbstub: extend GByteArray to read register helpers")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  target/i386/gdbstub.c | 2 +-
>  target/m68k/helper.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index f3d23b614e..b98a99500a 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>      } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
>          floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
>          int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
> -        len += gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
> +        len += gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
>          return len;
>      } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
>          n -= IDX_XMM_REGS;
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 014657c637..cad4083895 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
>  {
>      if (n < 8) {
>          int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
> -        len += gdb_get_reg16(mem_buf + len, 0);
> -        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
> +        len += gdb_get_reg16(mem_buf, 0);
> +        len += gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
>          return len;
>      }
>      switch (n) {
> 



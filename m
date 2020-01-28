Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9200D207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9200D207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSU5-0006kG-P6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwSTK-0005qN-R0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwSTJ-00062u-Pa
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:08:10 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwSTJ-00062B-Gf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:08:09 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N3sye-1jeYiA34nA-00zqbO; Tue, 28 Jan 2020 16:07:54 +0100
Subject: Re: [PATCH v2 3/4] linux-user: remove gemu_log from the linux-user
 tree
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200117192808.129398-1-jkz@google.com>
 <20200117192808.129398-4-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a9021918-ca59-98ea-9e2c-cc6498a1f208@vivier.eu>
Date: Tue, 28 Jan 2020 16:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117192808.129398-4-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:B8NyYeP9hutteEc8o8hJtKle5K2jYD3I6cJGUh8nbYfcIdQ1YPj
 1TQk6xPfe3IYmK9ZUGRGyBqA/U6JhAuYg/49mN1hj2jf0mFVgqL6v3YvEXabQmKZD1v5BVF
 SQCLlUQILARJMYMeM2g/h/qULGeW9oSWzWDt5yia0N9IO0XRr/9y5/XtqY1fO4MXLw3krhq
 dR8WJnIVsVBCwsvwTwPvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:835bXMEVikA=:f6MAR8snwKUvdjuQ6y6Hnu
 /H9TQvOgzNPQEBEmjsdiOdgwIXsvKIZgAIVmU+qrkHSk1m/2n39/XOtuavbxnIXM8VBwlAu0z
 1CfAcuoPbRP7uyqLAe+Y26EdZkNhyuOt6PIJXh/zL/yo2Iadi5/CKyCZ+wzt6FXXDQWIsdq34
 BoUysM9d9PFSUXwLdT2kpov1a31Tbw4LYL0YWoCmNLX7ASLvJHmCFWL9nLIN8yRnsbwaJE+ip
 lK9A+8Ac333cWXF6jLor0vbcnVuF6/MTMUeAmOgM5pij21QAGu4K9TGNfePn/p1Uelidecb84
 mSoICLWI3iyIsDg39eXciWvi9cgvj27NmfEfW81+M18cnL9ZWN7W8g/zumpTea6ko9rp2TUiR
 1Uf8Uopg8ulnoYb7LPThle1dFTpn79ZwvXDmz3PmIBz9e6LnVhFcogLWHqSzzTECeVkMkdWLQ
 +Cenouwt9rPiaat9xwTJQtrY0zfF+VxNgfTIhga34EQV2OkusSZhx9SuqeqCZONomxCzPGxHA
 FTMk3XcnX/xj7y26tpwFLbIOesfOeMuXzcZN3ZE2EtGZCT/efEzAdgqHqIHAz8/i+XCugXhiI
 AkoabNlP9rTrXYKOy75fALL438AfqL63oPOy6zRGBCcDu4sUSZwJ2WwEt71pkAnZuAO5KEI0p
 X3vVg6ROchepIThDUOqWGE0COvYYOmsQSyRb9fAEflDbcqpFAJmQax67xODsGMIA6XIlB2+2R
 zx//+2rdIj8dWqbP2FeElq6pt2Nqr4axlO458byeHXPvjeyfVAAm+cbGj5ktd6z7c6am1+kGe
 x8xIM17fJqgTkq9m/VzlHRq5VhXTbvsNtw/BEiVVXIdOusTLLUEh8K1BvppW+asVXUD23uC
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: riku.voipio@iki.fi, alex.bennee@linaro.org, armbru@redhat.com,
 imp@bsdimp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/01/2020 à 20:28, Josh Kunz a écrit :
> Now that all uses have been migrated to `qemu_log' it is no longer
> needed.
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/main.c | 9 ---------
>  linux-user/qemu.h | 1 -
>  2 files changed, 10 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8f1d07cdd6..22578b1633 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -112,15 +112,6 @@ const char *qemu_uname_release;
>     by remapping the process stack directly at the right place */
>  unsigned long guest_stack_size = 8 * 1024 * 1024UL;
>  
> -void gemu_log(const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start(ap, fmt);
> -    vfprintf(stderr, fmt, ap);
> -    va_end(ap);
> -}
> -
>  #if defined(TARGET_I386)
>  int cpu_get_pic_interrupt(CPUX86State *env)
>  {
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 02c6890c8a..329b409e65 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -210,7 +210,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      abi_long arg2, abi_long arg3, abi_long arg4,
>                      abi_long arg5, abi_long arg6, abi_long arg7,
>                      abi_long arg8);
> -void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>  extern __thread CPUState *thread_cpu;
>  void cpu_loop(CPUArchState *env);
>  const char *target_strerror(int err);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


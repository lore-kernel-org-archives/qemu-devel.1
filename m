Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847ECC282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 12:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4FB20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 12:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4FB20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUsgQ-00087Y-Cx
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 08:55:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUsee-0007MK-3l
	for qemu-devel@nongnu.org; Sun, 26 May 2019 08:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUsec-00030W-KK
	for qemu-devel@nongnu.org; Sun, 26 May 2019 08:53:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:36837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hUsec-0002uO-8A
	for qemu-devel@nongnu.org; Sun, 26 May 2019 08:53:34 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1N5UoU-1gWuYg1kgU-016vDm; Sun, 26 May 2019 14:53:16 +0200
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
References: <20190526074527.33632-1-lucienmp_antispam@yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ebd55ffc-2405-0ad5-e914-2abf80e50530@vivier.eu>
Date: Sun, 26 May 2019 14:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190526074527.33632-1-lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:FYEpaZbm9HekRbI1dC334lSj8nAI7bQjRbjv+W1PTymMVTQEMqe
	mckkYrytif0ZPNPl6nRj0feicYNc9VJ6CFrnjv1kl9BkF8Gn3y4iMhiIZodM2rKYfQaV3dA
	nkcYuLT7hkJti4bZuMWWrwZu5s2eP/ygqcUkAL0glbVx3WhAoGh5wDVPJBvjtFVWX2arVdu
	YJz3/EBqD3+Lk3313EZig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ittmMV0mR4U=:HavPebZcd3VspMXNKd65y3
	NXQLfSvbxaLxtg2aIMSckPKAi14OxIdV0qgco1jbLJPwTvl7/sO98Gb4rGStClc1pHV+SzoYE
	bVdZsyjDnMem3HqRGZNt2QIyGZ4Jd6ceOF9aUF9fN/hIeYIYJ0lbdshFzJSBQeZUgO3jy/WoZ
	NEUy16OOoJXmxAZX4Day1LCxymtL0mTQgvrI92YxYNatNrVV9AjiaiuBInVO1FjcGIhYXjxDy
	3ogj4arv5dnnGbggn9ay5Q+leyf1SSKTFMTiMC0BecaHfJ5uKCFiSSYMnMgJLAlr49mppEC17
	wFlnMJa+IvsYVDy2E/ZQEIBJWy+V8AE4DkEXCi68FigSmsJwIqYmGhXOfRAUjPl9fQ7B/kBEc
	kU/SJLAgQCLJPJJ0ndhGHa+9YvUUIdLXoSQl9aSaW7bxwOc9S8GAu7qOPB38pxamg8fBYPHn+
	nN6HILsell3PfclPtNewj6FAmdK37ssIqUQ8pLSlEnL7aRdFVSN+H6NFQtZzsTY0DtCmZ5kvI
	hEgR+D8VRIkyuYI+X2DyI96LWwaJzsV0rzil8DPPsBC2ncuFaeMucLHcEImKuh4xXWowswnIB
	6JRHNrRPJjWPyRJ+FtlZy7lncmCoSsR9kjzHiNqOrGCs8dWiXDBBhWv0E6AzrgB5hwhxXQxWu
	wIfrW73t/P8XKmZ4kIO2NnCOmfMiiaEmdRcdIIZwvr4lBb176Z9jY4OFDsxS3MP/4r831J+Q1
	yXcAlTll0FN8ON8gGlVUF7foLFEbJ3mFeWJLyA+8or34zY6MgtQFTO9SpJY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: Re: [Qemu-devel] [PATCH] The m68k gdbstub SR reg request doesnt
 include Condition-Codes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Emilio G . Cota" <cota@braap.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/2019 09:45, Lucien Murray-Pitts wrote:
> The register request via gdbstub would return the SR part
> which contains the Trace/Master/IRQ state flags, but
> would be missing the CR (Condition Register) state bits.
> 
> This fix adds this support by merging them in the m68k
> specific gdbstub handler
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
> ---
>   target/m68k/gdbstub.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
> index fd2bb46c42..f092044883 100644
> --- a/target/m68k/gdbstub.c
> +++ b/target/m68k/gdbstub.c
> @@ -35,8 +35,10 @@ int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>           return gdb_get_reg32(mem_buf, env->aregs[n - 8]);
>       } else {
>           switch (n) {
> -        case 16:
> -            return gdb_get_reg32(mem_buf, env->sr);
> +        case 16: {
> +            /* SR is made of SR+CCR, CCR is many 1bit flags so uses helper */
> +            return gdb_get_reg32(mem_buf, (env->sr | cpu_m68k_get_ccr(env)));

I think parenthesis are superfluous.

With that fixed:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> +        }
>           case 17:
>               return gdb_get_reg32(mem_buf, env->pc);
>           }
> 



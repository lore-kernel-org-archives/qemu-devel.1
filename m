Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25F2C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAF92082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAF92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbDV-0003M0-RQ
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJbB2-0001mZ-Bc
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJbB1-0004no-A6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:04:56 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46539
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1jJbB1-0004ku-3x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:04:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 321E881387;
 Wed,  1 Apr 2020 13:04:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aMTOxOGOhx_9; Wed,  1 Apr 2020 13:04:54 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id E0CE881385;
 Wed,  1 Apr 2020 13:04:53 +0200 (CEST)
Subject: Re: [PATCH-for-5.1 6/7] target/sparc/int32_helper: Remove DEBUG_PCALL
 definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-7-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <c30106c5-b9e9-0469-31b3-bbb14db31426@adacore.com>
Date: Wed, 1 Apr 2020 13:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Gaisler <jiri@gaisler.se>, Fabien Chouteau <chouteau@adacore.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 3/31/20 =C3=A0 12:50 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> We define DEBUG_PCALL since b884fc5e (2012-10-06).
> 7.5 years later it is safe to assume we can remove it :)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   target/sparc/int32_helper.c | 5 -----
>   1 file changed, 5 deletions(-)
>=20
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index 813b47dbb2..c56dd3df18 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -23,9 +23,7 @@
>   #include "exec/log.h"
>   #include "sysemu/runstate.h"
>  =20
> -#define DEBUG_PCALL
>  =20
> -#ifdef DEBUG_PCALL
>   static const char * const excp_names[0x80] =3D {
>       [TT_TFAULT] =3D "Instruction Access Fault",
>       [TT_ILL_INSN] =3D "Illegal Instruction",
> @@ -58,7 +56,6 @@ static const char * const excp_names[0x80] =3D {
>       [TT_DIV_ZERO] =3D "Division By Zero",
>       [TT_NCP_INSN] =3D "Coprocessor Disabled",
>   };
> -#endif
>  =20
>   void sparc_cpu_do_interrupt(CPUState *cs)
>   {
> @@ -71,7 +68,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>           cpu_get_psr(env);
>       }
>  =20
> -#ifdef DEBUG_PCALL
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>           static int count;
>           const char *name;
> @@ -104,7 +100,6 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>   #endif

I was wonderring what was this #endif above:

#if 0
         {
             int i;
             uint8_t *ptr;

             qemu_log("       code=3D");
             ptr =3D (uint8_t *)env->pc;
             for (i =3D 0; i < 16; i++) {
                 qemu_log(" %02x", ldub(ptr + i));
             }
             qemu_log("\n");
         }
#endif

Should we drop that as well?

>           count++;
>       }
> -#endif
>   #if !defined(CONFIG_USER_ONLY)
>       if (env->psret =3D=3D 0) {
>           if (cs->exception_index =3D=3D 0x80 &&
>=20

In any case LGTM:

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>


Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68741C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0FB206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0FB206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbKY-0006U4-BO
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJbJM-0005NA-QJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJbJL-0000H4-Kf
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:13:32 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:47073
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1jJbJL-0000GR-F4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:13:31 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id DBC738137C;
 Wed,  1 Apr 2020 13:13:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0VBHhkcR7KNf; Wed,  1 Apr 2020 13:13:29 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 916EF81368;
 Wed,  1 Apr 2020 13:13:29 +0200 (CEST)
Subject: Re: [PATCH-for-5.1 7/7] target/sparc/int32_helper: Extract and use
 excp_name_str()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-8-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <ae52a968-b47a-2e4d-0cda-7061efd946ed@adacore.com>
Date: Wed, 1 Apr 2020 13:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-8-f4bug@amsat.org>
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
> Improve exception error report:
>=20
> Before:
>=20
>    qemu: fatal: Trap 0x06 while interrupts disabled, Error state
>=20
> After:
>=20
>    qemu: fatal: Trap 0x06 (Window Underflow) while interrupts disabled,=
 Error state
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   target/sparc/int32_helper.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
> index c56dd3df18..9a71e1abd8 100644
> --- a/target/sparc/int32_helper.c
> +++ b/target/sparc/int32_helper.c
> @@ -57,6 +57,14 @@ static const char * const excp_names[0x80] =3D {
>       [TT_NCP_INSN] =3D "Coprocessor Disabled",
>   };
>  =20
> +static const char *excp_name_str(int32_t exception_index)
> +{
> +    if (exception_index < 0 || exception_index >=3D ARRAY_SIZE(excp_na=
mes)) {
> +        return "Unknown";
> +    }
> +    return excp_names[exception_index];
> +}
> +
>   void sparc_cpu_do_interrupt(CPUState *cs)
>   {
>       SPARCCPU *cpu =3D SPARC_CPU(cs);
> @@ -77,10 +85,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>           } else if (intno >=3D 0x80) {
>               name =3D "Trap Instruction";
>           } else {
> -            name =3D excp_names[intno];
> -            if (!name) {
> -                name =3D "Unknown";
> -            }
> +            name =3D excp_name_str(intno);
>           }
>  =20
>           qemu_log("%6d: %s (v=3D%02x)\n", count, name, intno);
> @@ -106,8 +111,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
>               env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
>               qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOW=
N);
>           } else {
> -            cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Erro=
r state",
> -                      cs->exception_index);
> +            cpu_abort(cs, "Trap 0x%02x (%s) while interrupts disabled,=
 "
> +                          "Error state",
> +                      cs->exception_index, excp_name_str(cs->exception=
_index));
>           }
>           return;
>       }
>=20

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks,
Fred


Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC00C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 15:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C34A2067C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 15:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="h0IwbTlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C34A2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyHO1-0007R5-A2
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 10:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1iyHMT-0006gC-FO
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 10:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1iyHMQ-0003Pt-1b
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 10:40:37 -0500
Received: from [51.158.76.159] (port=49476 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1iyHMP-0003PG-Ne
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 10:40:33 -0500
Subject: Re: [PATCH rc4 06/29] target/avr: Add defintions of AVR core types
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1580658028;
 bh=v8uPaG8boyAmmFbpT2akN55tc8LrO+xGf+buOGRiSi4=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=h0IwbTlm8dRg4kIZVQAtxXRnw7YzQWBQUaKrtuvpyxIoSpyyohJIDydCz7R5oRGmq
 Ix9K0UF3x0qwst8rjJyo7XiXrxcxg2vIUxrkp0dhuASMWcV02ZFN4GWat5AUrCyv7S
 6SqNqqDAzOfg1RZk5nkZAaHzMa9V4eYlKM8TQiLIbWFZmBJJnSiPZeQZcDgDkxKPKC
 cNivV8Hx8Sv60Ghoa3ppqothQHO+GiltRPPI3RI+YDWjtdJaPeZCG49j39uXMuMFIP
 NHAeY3ib10vpFejmhW3bmLnmSaVt8d8caCuXwDdifVS++O3OLLt+T5Gf+f9w8fNwfH
 acMRneKqIWdcg==
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-7-git-send-email-aleksandar.markovic@rt-rk.com>
From: Joaquin de Andres <me@xcancerberox.com.ar>
Message-ID: <87aab645-8ffb-dc0d-9d8d-bfeb4281821d@xcancerberox.com.ar>
Date: Sun, 2 Feb 2020 16:40:23 +0100
Mime-Version: 1.0
In-Reply-To: <1580428993-4767-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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
Cc: Michael Rolnik <mrolnik@gmail.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 1:02 AM, Aleksandar Markovic wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
> AVR core types are:
>=20
>    - avr1
>    - avr2
>    - avr25
>    - avr3
>    - avr31
>    - avr35
>    - avr4
>    - avr5
>    - avr51
>    - avr6
>    - avrtiny
>    - xmega2
>    - xmega3
>    - xmega4
>    - xmega5
>    - xmega6
>    - xmega7
>=20
> Each core type covers multiple AVR MCUs, mentioned in the comments
> before definition of particular AVR core type (part of this patch).
>=20
> AVR core type defines shared features that are valid for all AVR
> MCUs belonging in that type.
>=20
> [AM: Split a larger AVR introduction patch into logical units]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>=20
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>   target/avr/cpu.c | 601 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>   1 file changed, 601 insertions(+)
>=20
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index f41a887..e0ae055 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -215,3 +215,604 @@ static void avr_cpu_class_init(ObjectClass *oc, v=
oid *data)
>       cc->gdb_num_core_regs =3D 35;
>       cc->gdb_core_xml_file =3D "avr-cpu.xml";
>   }
> +
> +/*
> + * Setting features of AVR core type avr1
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at90s1200, attiny11, attiny12, attiny15, attiny28
> + */
> +static void avr_avr1_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +}
> +
> +/*
> + * Setting features of AVR core type avr2
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at9=
0s4414,
> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
> + */
> +static void avr_avr2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +}
> +
> +/*
> + * Setting features of AVR core type avr25
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, at=
tiny24,
> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, at=
tiny84a,
> + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, att=
iny461a,
> + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, att=
iny828,
> + * attiny841, at86rf401
> + */
> +static void avr_avr25_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +}
> +
> +/*
> + * Setting features of AVR core type avr3
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at43usb355, at76c711
> + */
> +static void avr_avr3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr31
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega103, at43usb320
> + */
> +static void avr_avr31_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr35
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atm=
ega16u2,
> + * atmega32u2, attiny167, attiny1634
> + */
> +static void avr_avr35_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +}
> +
> +/*
> + * Setting features of AVR core type avr4
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, a=
tmega48a,
> + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
> + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm=
1,
> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
> + */
> +static void avr_avr4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr5
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831,=
 ata6613c,
> + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega1=
62,
> + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega16=
5a,
> + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega1=
68pa,
> + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega=
16hvb,
> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmeg=
a323,
> + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega3=
25p,
> + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, at=
mega328,
> + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega3=
29pa,
> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atm=
ega32m1,
> + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, =
atmega644,
> + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega6=
45p,
> + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega=
649p,
> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, at=
mega6490p,
> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, a=
t90pwm216,
> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
> + */
> +static void avr_avr5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr51
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega12=
84p,
> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb12=
86,
> + * at90usb1287
> + */
> +static void avr_avr51_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avr6
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
> + */
> +static void avr_avr6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +}
> +
> +/*
> + * Setting features of AVR core type avrtiny
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
> + */
> +static void avr_avrtiny_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega2
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atx=
mega32c3,
> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
> + * atxmega32c4, atxmega32e5
> + */
> +static void avr_xmega2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +    set_avr_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega3
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, a=
ttiny814,
> + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny321=
4,
> + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega160=
9,
> + * atmega3208, atmega3209, atmega4808, atmega4809
> + */
> +static void avr_xmega3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +    set_avr_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega4
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
> + * atxmega64b3, atxmega64c3, atxmega64d4
> + */
> +static void avr_xmega4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +    set_avr_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega5
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega64a1, atxmega64a1u
> + */
> +static void avr_xmega5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +    set_avr_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega6
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a=
3,
> + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega=
128b1,
> + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192=
c3,
> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
> + */
> +static void avr_xmega6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +    set_avr_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega7
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega128a1, atxmega128a1u, atxmega128a4u
> + */
> +static void avr_xmega7_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    set_avr_feature(env, AVR_FEATURE_LPM);
> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    set_avr_feature(env, AVR_FEATURE_SRAM);
> +    set_avr_feature(env, AVR_FEATURE_BREAK);
> +
> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
> +    set_avr_feature(env, AVR_FEATURE_ELPM);
> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
> +    set_avr_feature(env, AVR_FEATURE_LPMX);
> +    set_avr_feature(env, AVR_FEATURE_MOVW);
> +    set_avr_feature(env, AVR_FEATURE_MUL);
> +    set_avr_feature(env, AVR_FEATURE_RMW);
> +}
> +
> +typedef struct AVRCPUInfo {
> +    const char *name;
> +    void (*initfn)(Object *obj);
> +} AVRCPUInfo;
> +
> +
> +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
> +{
> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data))=
;
> +
> +    qemu_printf("%s\n", typename);
> +}
> +
> +void avr_cpu_list(void)
> +{
> +    GSList *list;
> +    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> +    g_slist_free(list);
> +}
> +
> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> +    { \
> +        .parent =3D TYPE_AVR_CPU, \
> +        .instance_init =3D initfn, \
> +        .name =3D AVR_CPU_TYPE_NAME(model), \
> +    }
> +
> +static const TypeInfo avr_cpu_type_info[] =3D {
> +    {
> +        .name =3D TYPE_AVR_CPU,
> +        .parent =3D TYPE_CPU,
> +        .instance_size =3D sizeof(AVRCPU),
> +        .instance_init =3D avr_cpu_initfn,
> +        .class_size =3D sizeof(AVRCPUClass),
> +        .class_init =3D avr_cpu_class_init,
> +        .abstract =3D true,
> +    },
> +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
> +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> +};
> +
> +const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_=
type)
> +{
> +    switch (flags & EF_AVR_MACH) {
> +    case bfd_mach_avr1:
> +        return AVR_CPU_TYPE_NAME("avr1");
> +    case bfd_mach_avr2:
> +        return AVR_CPU_TYPE_NAME("avr2");
> +    case bfd_mach_avr25:
> +        return AVR_CPU_TYPE_NAME("avr25");
> +    case bfd_mach_avr3:
> +        return AVR_CPU_TYPE_NAME("avr3");
> +    case bfd_mach_avr31:
> +        return AVR_CPU_TYPE_NAME("avr31");
> +    case bfd_mach_avr35:
> +        return AVR_CPU_TYPE_NAME("avr35");
> +    case bfd_mach_avr4:
> +        return AVR_CPU_TYPE_NAME("avr4");
> +    case bfd_mach_avr5:
> +        return AVR_CPU_TYPE_NAME("avr5");
> +    case bfd_mach_avr51:
> +        return AVR_CPU_TYPE_NAME("avr51");
> +    case bfd_mach_avr6:
> +        return AVR_CPU_TYPE_NAME("avr6");
> +    case bfd_mach_avrtiny:
> +        return AVR_CPU_TYPE_NAME("avrtiny");
> +    case bfd_mach_avrxmega2:
> +        return AVR_CPU_TYPE_NAME("xmega2");
> +    case bfd_mach_avrxmega3:
> +        return AVR_CPU_TYPE_NAME("xmega3");
> +    case bfd_mach_avrxmega4:
> +        return AVR_CPU_TYPE_NAME("xmega4");
> +    case bfd_mach_avrxmega5:
> +        return AVR_CPU_TYPE_NAME("xmega5");
> +    case bfd_mach_avrxmega6:
> +        return AVR_CPU_TYPE_NAME("xmega6");
> +    case bfd_mach_avrxmega7:
> +        return AVR_CPU_TYPE_NAME("xmega7");
> +    default:
> +        return def_cpu_type;
> +    }
> +}
> +
> +DEFINE_TYPES(avr_cpu_type_info)
>=20

Hi! me again. Following the RC2 discussion. I've being looking in the=20
GCC definition of the architecture and as far as I can understand this=20
definitions are the generic definitions of the arch families.

  avr_arch_types[] =3D
  {
    /* unknown device specified */
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, NULL,=20
AVR_MMCU_DEFAULT },
    /*
      A  M  J  LM E  E  E  X  R  T  d S     FPO     S O   A
      S  U  M  PO L  L  I  M  A  I  a t     lMff    F ff  r
      M  L  P  MV P  P  J  E  M  N  t a     a s     R s   c
               XW M  M  M  G  P  Y  a r     s e       e   h
                     X  P  A  D       t     h t       t   ID   */
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "1",   "avr1"  },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "2",   "avr2"  },
    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "25",  "avr25" },
    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "3",   "avr3"  },
    { 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,      32, "31",  "avr31" },
    { 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "35",  "avr35" },
    { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "4",   "avr4"  },
    { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "5",   "avr5"  },
    { 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,      32, "51",  "avr51" },
    { 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,      32, "6",   "avr6"  },

    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x4000, 0, "100", "avrtiny"},
    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,      0, "102", "avrxmega2"=
 },
    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x8000, 0, "103", "avrxmega3"=
 },
    { 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,      0, "104", "avrxmega4"=
 },
    { 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,      0, "105", "avrxmega5"=
 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,      0, "106", "avrxmega6"=
 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,      0, "107", "avrxmega7"=
  }
  };

And then you have features for the specific microcontrollers:

  AVR_ISA_RMW
  AVR_SHORT_SP
  AVR_ERRATA_SKIP
  AVR_ISA_LDS
  AVR_ISA_RCALL

They are mixed in the file 'avr-mcus.def' for family and microcontroller=20
definition. Only looking at the family definition:

  AVR_MCU ("avr2",             ARCH_AVR2, AVR_ERRATA_SKIP, NULL,=20
              0x0060, 0x0, 0x60000, 0)
  AVR_MCU ("avr25",            ARCH_AVR25, AVR_ISA_NONE, NULL,=20
             0x0060, 0x0, 0x2000, 0)
  AVR_MCU ("avr3",             ARCH_AVR3, AVR_ISA_NONE, NULL,=20
             0x0060, 0x0, 0x6000, 0)
  AVR_MCU ("avr31",            ARCH_AVR31, AVR_ERRATA_SKIP, NULL,=20
             0x0060, 0x0, 0x20000, 0)
  AVR_MCU ("avr35",            ARCH_AVR35, AVR_ISA_NONE, NULL,=20
             0x0100, 0x0, 0x4000, 0)
  AVR_MCU ("avr4",             ARCH_AVR4, AVR_ISA_NONE,  NULL,=20
             0x0060, 0x0, 0x2000, 0)
  AVR_MCU ("avr5",             ARCH_AVR5, AVR_ISA_NONE, NULL,=20
             0x0060, 0x0, 0x4000, 0)
  AVR_MCU ("avr51",            ARCH_AVR51, AVR_ISA_NONE, NULL,=20
             0x0100, 0x0, 0x20000, 0)
  AVR_MCU ("avr6",             ARCH_AVR6, AVR_ISA_NONE, NULL,=20
             0x0200, 0x0, 0x40000, 0)
  AVR_MCU ("avrxmega2",        ARCH_AVRXMEGA2, AVR_ISA_NONE, NULL,=20
             0x2000, 0x0, 0x9000, 0)
  AVR_MCU ("avrxmega3",        ARCH_AVRXMEGA3, AVR_ISA_NONE,  NULL,=20
             0x3f00, 0x0, 0x8000, 0)
  AVR_MCU ("avrxmega4",        ARCH_AVRXMEGA4, AVR_ISA_NONE, NULL,=20
             0x2000, 0x0, 0x11000, 0)
  AVR_MCU ("avrxmega5",        ARCH_AVRXMEGA5, AVR_ISA_NONE, NULL,=20
             0x2000, 0x0, 0x11000, 0)
  AVR_MCU ("avrxmega6",        ARCH_AVRXMEGA6, AVR_ISA_NONE, NULL,=20
                 0x2000, 0x0, 0x60000, 0)
  AVR_MCU ("avrxmega7",        ARCH_AVRXMEGA7, AVR_ISA_NONE, NULL,=20
                 0x2000, 0x0, 0x22000, 0)
  AVR_MCU ("avrtiny",          ARCH_AVRTINY, AVR_ISA_NONE, NULL,=20
             0x0040, 0x0, 0x400, 0)
  AVR_MCU ("avr1",             ARCH_AVR1, AVR_ISA_NONE, NULL,=20
             0x0060, 0x0, 0x400, 0)

I don't really understand how do you get to the proposed family=20
definition for qemu. Probably is my fault but if you can help me to=20
understand will be grate!

Regards,
--joa


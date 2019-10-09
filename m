Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A37C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D22820679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D22820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFlO-0002tg-SY
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.abakumov@ispras.ru>) id 1iI7Yh-0008R0-25
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.abakumov@ispras.ru>) id 1iI7Yf-0002ph-0L
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:42:58 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52234)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mikhail.abakumov@ispras.ru>) id 1iI7Ye-0002oz-LQ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 04:42:56 -0400
Received: from mail.ispras.ru (localhost [127.0.0.1])
 by mail.ispras.ru (Postfix) with ESMTPSA id 06BF954006A;
 Wed,  9 Oct 2019 11:42:53 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 09 Oct 2019 11:42:52 +0300
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [PATCH] target/mips: add gdb xml files
In-Reply-To: <CAL1e-=gBEAiTMBHz_zXzJXPSzkaM9R1NtNaaPFrUg+JA4_nwCg@mail.gmail.com>
References: <caedac8d3f9f15f3245011b7d6b3f7bf@ispras.ru>
 <87a7ack180.fsf@linaro.org>
 <CAL1e-=gBEAiTMBHz_zXzJXPSzkaM9R1NtNaaPFrUg+JA4_nwCg@mail.gmail.com>
Message-ID: <b36ea61cf3566e8f154ec1f9e90867d8@ispras.ru>
X-Sender: mikhail.abakumov@ispras.ru
User-Agent: Roundcube Webmail/1.1.2
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: arikalo@wavecomp.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Qemu Devel <qemu-devel@nongnu.org>, amarkovic@wavecomp.com, philmd@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2019-10-08 16:37:
> On Monday, October 7, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org>
> wrote:
>=20
>> Mikhail Abakumov <mikhail.abakumov@ispras.ru> writes:
>>=20
>>> From: Mikhail Abakumov <mikhail.abakumov@ispras>
>>=20
>> Hmm the email got truncated here.
>>=20
>>>=20
>>> This patch add xml files with gdb registers for mips.
>>>=20
>>> Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras>
>>> ---
>>> configure | 3 ++
>>> gdb-xml/mips-core.xml | 84
>> +++++++++++++++++++++++++++++++++++++++++
>>> gdb-xml/mips64-core.xml | 84
>>> +++++++++++++++++++++++++++++++++++++++++
>>=20
>> Otherwise for the configure/xml:
>>=20
>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> I assume the changes will go in via a MIPS tree.
>=20
> Yes, this should go via mips tree. Thanks for taking a look.
>=20
> Mikhail, thanks for this effort.
>=20
> Is there any way to include MSA registers, possibly in a separate
> file, and in a separate patch? What about a separate file for FPU
> registers? Can you take a look at corresponding solutions for other
> architectures?

Thanks for the feedback.

Yes, I did it initially. But looking at other architectures, redid it.
Everywhere, one main xml-file is used for registers, described
in the target/gdbstub. And additional ones are appended through
'gdb_register_coprocessor'.
In the current patch, I made a description of the registers described
only in the target/gdbstub. In the future, I think FPU registers
can be moved to a separate file, but then need to move them from
the mips/gdbstub.

>=20
> Yours,
> Aleksandar
>=20
>>> target/mips/cpu.c | 11 ++++++
>>> 4 files changed, 182 insertions(+)
>>> create mode 100644 gdb-xml/mips-core.xml
>>> create mode 100644 gdb-xml/mips64-core.xml
>>>=20
>>> diff --git a/configure b/configure
>>> index 8f8446f52b..5bb2c62194 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -7466,12 +7466,14 @@ case "$target_name" in
>>> mips|mipsel)
>>> mttcg=3D"yes"
>>> TARGET_ARCH=3Dmips
>>> + gdb_xml_files=3D"mips-core.xml"
>>> echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
>>> ;;
>>> mipsn32|mipsn32el)
>>> mttcg=3D"yes"
>>> TARGET_ARCH=3Dmips64
>>> TARGET_BASE_ARCH=3Dmips
>>> + gdb_xml_files=3D"mips64-core.xml"
>>> echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
>>> echo "TARGET_ABI32=3Dy" >> $config_target_mak
>>> ;;
>>> @@ -7479,6 +7481,7 @@ case "$target_name" in
>>> mttcg=3D"yes"
>>> TARGET_ARCH=3Dmips64
>>> TARGET_BASE_ARCH=3Dmips
>>> + gdb_xml_files=3D"mips64-core.xml"
>>> echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
>>> ;;
>>> moxie)
>>> diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml
>>> new file mode 100644
>>> index 0000000000..a46b2993eb
>>> --- /dev/null
>>> +++ b/gdb-xml/mips-core.xml
>>> @@ -0,0 +1,84 @@
>>> +<?xml version=3D"1.0"?>
>>> +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
>>> +
>>> + Copying and distribution of this file, with or without
>>> modification,
>>> + are permitted in any medium without royalty provided the
>> copyright
>>> + notice and this notice are preserved. -->
>>> +
>>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>> +<feature name=3D"org.gnu.gdb.mips">
>>> + <reg name=3D"zero" bitsize=3D"32"/>
>>> + <reg name=3D"at" bitsize=3D"32"/>
>>> + <reg name=3D"v0" bitsize=3D"32"/>
>>> + <reg name=3D"v1" bitsize=3D"32"/>
>>> + <reg name=3D"a0" bitsize=3D"32"/>
>>> + <reg name=3D"a1" bitsize=3D"32"/>
>>> + <reg name=3D"a2" bitsize=3D"32"/>
>>> + <reg name=3D"a3" bitsize=3D"32"/>
>>> + <reg name=3D"t0" bitsize=3D"32"/>
>>> + <reg name=3D"t1" bitsize=3D"32"/>
>>> + <reg name=3D"t2" bitsize=3D"32"/>
>>> + <reg name=3D"t3" bitsize=3D"32"/>
>>> + <reg name=3D"t4" bitsize=3D"32"/>
>>> + <reg name=3D"t5" bitsize=3D"32"/>
>>> + <reg name=3D"t6" bitsize=3D"32"/>
>>> + <reg name=3D"t7" bitsize=3D"32"/>
>>> + <reg name=3D"s0" bitsize=3D"32"/>
>>> + <reg name=3D"s1" bitsize=3D"32"/>
>>> + <reg name=3D"s2" bitsize=3D"32"/>
>>> + <reg name=3D"s3" bitsize=3D"32"/>
>>> + <reg name=3D"s4" bitsize=3D"32"/>
>>> + <reg name=3D"s5" bitsize=3D"32"/>
>>> + <reg name=3D"s6" bitsize=3D"32"/>
>>> + <reg name=3D"s7" bitsize=3D"32"/>
>>> + <reg name=3D"t8" bitsize=3D"32"/>
>>> + <reg name=3D"t9" bitsize=3D"32"/>
>>> + <reg name=3D"k0" bitsize=3D"32"/>
>>> + <reg name=3D"k1" bitsize=3D"32"/>
>>> + <reg name=3D"gp" bitsize=3D"32"/>
>>> + <reg name=3D"sp" bitsize=3D"32"/>
>>> + <reg name=3D"s8" bitsize=3D"32"/>
>>> + <reg name=3D"ra" bitsize=3D"32"/>
>>> + <reg name=3D"sr" bitsize=3D"32"/>
>>> + <reg name=3D"lo" bitsize=3D"32"/>
>>> + <reg name=3D"hi" bitsize=3D"32"/>
>>> + <reg name=3D"bad" bitsize=3D"32"/>
>>> + <reg name=3D"cause" bitsize=3D"32"/>
>>> + <reg name=3D"pc" bitsize=3D"32"/>
>>> +
>>> + <reg name=3D"f0" bitsize=3D"32" regnum=3D"38"/>
>>> + <reg name=3D"f1" bitsize=3D"32"/>
>>> + <reg name=3D"f2" bitsize=3D"32"/>
>>> + <reg name=3D"f3" bitsize=3D"32"/>
>>> + <reg name=3D"f4" bitsize=3D"32"/>
>>> + <reg name=3D"f5" bitsize=3D"32"/>
>>> + <reg name=3D"f6" bitsize=3D"32"/>
>>> + <reg name=3D"f7" bitsize=3D"32"/>
>>> + <reg name=3D"f8" bitsize=3D"32"/>
>>> + <reg name=3D"f9" bitsize=3D"32"/>
>>> + <reg name=3D"f10" bitsize=3D"32"/>
>>> + <reg name=3D"f11" bitsize=3D"32"/>
>>> + <reg name=3D"f12" bitsize=3D"32"/>
>>> + <reg name=3D"f13" bitsize=3D"32"/>
>>> + <reg name=3D"f14" bitsize=3D"32"/>
>>> + <reg name=3D"f15" bitsize=3D"32"/>
>>> + <reg name=3D"f16" bitsize=3D"32"/>
>>> + <reg name=3D"f17" bitsize=3D"32"/>
>>> + <reg name=3D"f18" bitsize=3D"32"/>
>>> + <reg name=3D"f19" bitsize=3D"32"/>
>>> + <reg name=3D"f20" bitsize=3D"32"/>
>>> + <reg name=3D"f21" bitsize=3D"32"/>
>>> + <reg name=3D"f22" bitsize=3D"32"/>
>>> + <reg name=3D"f23" bitsize=3D"32"/>
>>> + <reg name=3D"f24" bitsize=3D"32"/>
>>> + <reg name=3D"f25" bitsize=3D"32"/>
>>> + <reg name=3D"f26" bitsize=3D"32"/>
>>> + <reg name=3D"f27" bitsize=3D"32"/>
>>> + <reg name=3D"f28" bitsize=3D"32"/>
>>> + <reg name=3D"f29" bitsize=3D"32"/>
>>> + <reg name=3D"f30" bitsize=3D"32"/>
>>> + <reg name=3D"f31" bitsize=3D"32"/>
>>> + <reg name=3D"fsr" bitsize=3D"32" group=3D"float"/>
>>> + <reg name=3D"fir" bitsize=3D"32" group=3D"float"/>
>>> + <reg name=3D"fp" bitsize=3D"32" group=3D"float"/>
>>> +</feature>
>>> diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml
>>> new file mode 100644
>>> index 0000000000..cc1a15ad56
>>> --- /dev/null
>>> +++ b/gdb-xml/mips64-core.xml
>>> @@ -0,0 +1,84 @@
>>> +<?xml version=3D"1.0"?>
>>> +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
>>> +
>>> + Copying and distribution of this file, with or without
>>> modification,
>>> + are permitted in any medium without royalty provided the
>> copyright
>>> + notice and this notice are preserved. -->
>>> +
>>> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>> +<feature name=3D"org.gnu.gdb.mips64">
>>> + <reg name=3D"zero" bitsize=3D"64"/>
>>> + <reg name=3D"at" bitsize=3D"64"/>
>>> + <reg name=3D"v0" bitsize=3D"64"/>
>>> + <reg name=3D"v1" bitsize=3D"64"/>
>>> + <reg name=3D"a0" bitsize=3D"64"/>
>>> + <reg name=3D"a1" bitsize=3D"64"/>
>>> + <reg name=3D"a2" bitsize=3D"64"/>
>>> + <reg name=3D"a3" bitsize=3D"64"/>
>>> + <reg name=3D"t0" bitsize=3D"64"/>
>>> + <reg name=3D"t1" bitsize=3D"64"/>
>>> + <reg name=3D"t2" bitsize=3D"64"/>
>>> + <reg name=3D"t3" bitsize=3D"64"/>
>>> + <reg name=3D"t4" bitsize=3D"64"/>
>>> + <reg name=3D"t5" bitsize=3D"64"/>
>>> + <reg name=3D"t6" bitsize=3D"64"/>
>>> + <reg name=3D"t7" bitsize=3D"64"/>
>>> + <reg name=3D"s0" bitsize=3D"64"/>
>>> + <reg name=3D"s1" bitsize=3D"64"/>
>>> + <reg name=3D"s2" bitsize=3D"64"/>
>>> + <reg name=3D"s3" bitsize=3D"64"/>
>>> + <reg name=3D"s4" bitsize=3D"64"/>
>>> + <reg name=3D"s5" bitsize=3D"64"/>
>>> + <reg name=3D"s6" bitsize=3D"64"/>
>>> + <reg name=3D"s7" bitsize=3D"64"/>
>>> + <reg name=3D"t8" bitsize=3D"64"/>
>>> + <reg name=3D"t9" bitsize=3D"64"/>
>>> + <reg name=3D"k0" bitsize=3D"64"/>
>>> + <reg name=3D"k1" bitsize=3D"64"/>
>>> + <reg name=3D"gp" bitsize=3D"64"/>
>>> + <reg name=3D"sp" bitsize=3D"64"/>
>>> + <reg name=3D"s8" bitsize=3D"64"/>
>>> + <reg name=3D"ra" bitsize=3D"64"/>
>>> + <reg name=3D"sr" bitsize=3D"64"/>
>>> + <reg name=3D"lo" bitsize=3D"64"/>
>>> + <reg name=3D"hi" bitsize=3D"64"/>
>>> + <reg name=3D"bad" bitsize=3D"64"/>
>>> + <reg name=3D"cause" bitsize=3D"64"/>
>>> + <reg name=3D"pc" bitsize=3D"64"/>
>>> +
>>> + <reg name=3D"f0" bitsize=3D"64" regnum=3D"38"/>
>>> + <reg name=3D"f1" bitsize=3D"64"/>
>>> + <reg name=3D"f2" bitsize=3D"64"/>
>>> + <reg name=3D"f3" bitsize=3D"64"/>
>>> + <reg name=3D"f4" bitsize=3D"64"/>
>>> + <reg name=3D"f5" bitsize=3D"64"/>
>>> + <reg name=3D"f6" bitsize=3D"64"/>
>>> + <reg name=3D"f7" bitsize=3D"64"/>
>>> + <reg name=3D"f8" bitsize=3D"64"/>
>>> + <reg name=3D"f9" bitsize=3D"64"/>
>>> + <reg name=3D"f10" bitsize=3D"64"/>
>>> + <reg name=3D"f11" bitsize=3D"64"/>
>>> + <reg name=3D"f12" bitsize=3D"64"/>
>>> + <reg name=3D"f13" bitsize=3D"64"/>
>>> + <reg name=3D"f14" bitsize=3D"64"/>
>>> + <reg name=3D"f15" bitsize=3D"64"/>
>>> + <reg name=3D"f16" bitsize=3D"64"/>
>>> + <reg name=3D"f17" bitsize=3D"64"/>
>>> + <reg name=3D"f18" bitsize=3D"64"/>
>>> + <reg name=3D"f19" bitsize=3D"64"/>
>>> + <reg name=3D"f20" bitsize=3D"64"/>
>>> + <reg name=3D"f21" bitsize=3D"64"/>
>>> + <reg name=3D"f22" bitsize=3D"64"/>
>>> + <reg name=3D"f23" bitsize=3D"64"/>
>>> + <reg name=3D"f24" bitsize=3D"64"/>
>>> + <reg name=3D"f25" bitsize=3D"64"/>
>>> + <reg name=3D"f26" bitsize=3D"64"/>
>>> + <reg name=3D"f27" bitsize=3D"64"/>
>>> + <reg name=3D"f28" bitsize=3D"64"/>
>>> + <reg name=3D"f29" bitsize=3D"64"/>
>>> + <reg name=3D"f30" bitsize=3D"64"/>
>>> + <reg name=3D"f31" bitsize=3D"64"/>
>>> + <reg name=3D"fsr" bitsize=3D"64" group=3D"float"/>
>>> + <reg name=3D"fir" bitsize=3D"64" group=3D"float"/>
>>> + <reg name=3D"fp" bitsize=3D"64" group=3D"float"/>
>>> +</feature>
>>> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
>>> index bbcf7ca463..014f1db59e 100644
>>> --- a/target/mips/cpu.c
>>> +++ b/target/mips/cpu.c
>>> @@ -181,6 +181,11 @@ static ObjectClass
>> *mips_cpu_class_by_name(const
>>> char *cpu_model)
>>> return oc;
>>> }
>>>=20
>>> +static gchar *mips_gdb_arch_name(CPUState *cs)
>>> +{
>>> + return g_strdup("mips");
>>> +}
>>> +
>>> static void mips_cpu_class_init(ObjectClass *c, void *data)
>>> {
>>> MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(c);
>>> @@ -213,6 +218,12 @@ static void mips_cpu_class_init(ObjectClass
>> *c,
>>> void *data)
>>> cc->tlb_fill =3D mips_cpu_tlb_fill;
>>> #endif
>>>=20
>>> + cc->gdb_arch_name =3D mips_gdb_arch_name;
>>> +#ifdef TARGET_MIPS64
>>> + cc->gdb_core_xml_file =3D "mips64-core.xml";
>>> +#else
>>> + cc->gdb_core_xml_file =3D "mips-core.xml";
>>> +#endif
>>> cc->gdb_num_core_regs =3D 73;
>>> cc->gdb_stop_before_watchpoint =3D true;
>>> }
>>=20
>> --
>> Alex Benn=C3=A9e

--=20
Mikhail Abakumov


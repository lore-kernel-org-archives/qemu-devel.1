Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD00C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BB420673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjosZDjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BB420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHphl-0000Q4-UW
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iHpgT-0007n0-K3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iHpgQ-0006cK-HI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:37:49 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iHpgQ-0006bQ-7w
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:37:46 -0400
Received: by mail-ot1-x344.google.com with SMTP id 60so14051822otu.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=0hfbj47cHnY7Sz2DoSXUc8d++2iQaP0yST9o9y/vrTY=;
 b=CjosZDjLmY1H/3ojhmpPyYQG+XvQmIuTrOKz/CTqSnw/Ab5j0qR+PlSrI4oIH4iIP5
 fUhn9vovH7CsrpYj9mIPegPBVT0aQprhLMjCd2P7sfbMjTHrk00dDjhv9YWlNl9fi9cA
 WehpOfz2DpxRhEH1LbXY3dBpTVbm8mOj8pjatAX91xBtIL0xUARiANTL1zpfmuNf52LS
 J5B+OVc8LYtWUIoht11AajKd/NIeZThCTkY5MPvKHT1Pqq4aoC4fmPTn3lvwJbg8+wj6
 4WP212BB5KUl3OvLiCbWlKobeiaqXc18I5CTu1Jn2yrEN5KmSZJVuaMRfBTL+omR8L39
 3AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=0hfbj47cHnY7Sz2DoSXUc8d++2iQaP0yST9o9y/vrTY=;
 b=mdPNmTpIP2S7G3iIwNQo67ED7J05fG8Tbgm69SMS0UmRYTTkGPHEeLe7JoVmjYRrXM
 JmtFgd2C/bSiVClPZ0QOQpX1110uP3L3SkHMj/9MkHbNYzO0ShYOF69+ulWUAeO9vRSJ
 xdIbYbo0gBupTpngccljLoVUm7lxhIN7gGFumSe2EfoxEpcXU9NPFqqP+YZVD6lIw/dB
 1ZTBtLXHC83CC4B+6asfrHvP/6/vRDMwq4ULutU2OPY17sbhSKkcCkQM5k2tIKM0yHlT
 wfCQUNF1Dq0YO3rvIKeBdOWXzBNTaBzT4peVUPkvxzHFpmaRrhC4GL74ZXfyOGhGJz2Y
 +l0A==
X-Gm-Message-State: APjAAAXt7O1owj7AeJHep+jMbS887SFi8K379Y+iPgTdU2rPwGRiSSs5
 rgfdv0/UYwz+AOkntxJtBPSx2LhaDcq/eo686VA=
X-Google-Smtp-Source: APXvYqzezT1ig9qlrnY4CAGLXpUzu7AP0GXTN7XHv+gynptRrhHRv8H3ik/txVIVfdMExc1N8Oq2L8owhWWjLbRiEu4=
X-Received: by 2002:a9d:5a15:: with SMTP id v21mr26066457oth.341.1570541865309; 
 Tue, 08 Oct 2019 06:37:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Tue, 8 Oct 2019 06:37:44 -0700 (PDT)
In-Reply-To: <87a7ack180.fsf@linaro.org>
References: <caedac8d3f9f15f3245011b7d6b3f7bf@ispras.ru>
 <87a7ack180.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 8 Oct 2019 15:37:44 +0200
Message-ID: <CAL1e-=gBEAiTMBHz_zXzJXPSzkaM9R1NtNaaPFrUg+JA4_nwCg@mail.gmail.com>
Subject: Re: [PATCH] target/mips: add gdb xml files
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fc978c05946645c8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 Qemu Devel <qemu-devel@nongnu.org>,
 Mikhail Abakumov <mikhail.abakumov@ispras.ru>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc978c05946645c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 7, 2019, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

>
> Mikhail Abakumov <mikhail.abakumov@ispras.ru> writes:
>
> > From: Mikhail Abakumov <mikhail.abakumov@ispras>
>
> Hmm the email got truncated here.
>
> >
> > This patch add xml files with gdb registers for mips.
> >
> > Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras>
> > ---
> >  configure               |  3 ++
> >  gdb-xml/mips-core.xml   | 84 +++++++++++++++++++++++++++++++++++++++++
> >  gdb-xml/mips64-core.xml | 84
> > +++++++++++++++++++++++++++++++++++++++++
>
> Otherwise for the configure/xml:
>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> I assume the changes will go in via a MIPS tree.
>
>
Yes, this should go via mips tree. Thanks for taking a look.


Mikhail, thanks for this effort.

Is there any way to include MSA registers, possibly in a separate file, and
in a separate patch? What about a separate file for FPU registers? Can you
take a look at corresponding solutions for other architectures?

Yours,
Aleksandar




> >  target/mips/cpu.c       | 11 ++++++
> >  4 files changed, 182 insertions(+)
> >  create mode 100644 gdb-xml/mips-core.xml
> >  create mode 100644 gdb-xml/mips64-core.xml
> >
> > diff --git a/configure b/configure
> > index 8f8446f52b..5bb2c62194 100755
> > --- a/configure
> > +++ b/configure
> > @@ -7466,12 +7466,14 @@ case "$target_name" in
> >    mips|mipsel)
> >      mttcg=3D"yes"
> >      TARGET_ARCH=3Dmips
> > +    gdb_xml_files=3D"mips-core.xml"
> >      echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
> >    ;;
> >    mipsn32|mipsn32el)
> >      mttcg=3D"yes"
> >      TARGET_ARCH=3Dmips64
> >      TARGET_BASE_ARCH=3Dmips
> > +    gdb_xml_files=3D"mips64-core.xml"
> >      echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
> >      echo "TARGET_ABI32=3Dy" >> $config_target_mak
> >    ;;
> > @@ -7479,6 +7481,7 @@ case "$target_name" in
> >      mttcg=3D"yes"
> >      TARGET_ARCH=3Dmips64
> >      TARGET_BASE_ARCH=3Dmips
> > +    gdb_xml_files=3D"mips64-core.xml"
> >      echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
> >    ;;
> >    moxie)
> > diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml
> > new file mode 100644
> > index 0000000000..a46b2993eb
> > --- /dev/null
> > +++ b/gdb-xml/mips-core.xml
> > @@ -0,0 +1,84 @@
> > +<?xml version=3D"1.0"?>
> > +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without
> > modification,
> > +     are permitted in any medium without royalty provided the copyrigh=
t
> > +     notice and this notice are preserved.  -->
> > +
> > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > +<feature name=3D"org.gnu.gdb.mips">
> > +  <reg name=3D"zero" bitsize=3D"32"/>
> > +  <reg name=3D"at" bitsize=3D"32"/>
> > +  <reg name=3D"v0" bitsize=3D"32"/>
> > +  <reg name=3D"v1" bitsize=3D"32"/>
> > +  <reg name=3D"a0" bitsize=3D"32"/>
> > +  <reg name=3D"a1" bitsize=3D"32"/>
> > +  <reg name=3D"a2" bitsize=3D"32"/>
> > +  <reg name=3D"a3" bitsize=3D"32"/>
> > +  <reg name=3D"t0" bitsize=3D"32"/>
> > +  <reg name=3D"t1" bitsize=3D"32"/>
> > +  <reg name=3D"t2" bitsize=3D"32"/>
> > +  <reg name=3D"t3" bitsize=3D"32"/>
> > +  <reg name=3D"t4" bitsize=3D"32"/>
> > +  <reg name=3D"t5" bitsize=3D"32"/>
> > +  <reg name=3D"t6" bitsize=3D"32"/>
> > +  <reg name=3D"t7" bitsize=3D"32"/>
> > +  <reg name=3D"s0" bitsize=3D"32"/>
> > +  <reg name=3D"s1" bitsize=3D"32"/>
> > +  <reg name=3D"s2" bitsize=3D"32"/>
> > +  <reg name=3D"s3" bitsize=3D"32"/>
> > +  <reg name=3D"s4" bitsize=3D"32"/>
> > +  <reg name=3D"s5" bitsize=3D"32"/>
> > +  <reg name=3D"s6" bitsize=3D"32"/>
> > +  <reg name=3D"s7" bitsize=3D"32"/>
> > +  <reg name=3D"t8" bitsize=3D"32"/>
> > +  <reg name=3D"t9" bitsize=3D"32"/>
> > +  <reg name=3D"k0" bitsize=3D"32"/>
> > +  <reg name=3D"k1" bitsize=3D"32"/>
> > +  <reg name=3D"gp" bitsize=3D"32"/>
> > +  <reg name=3D"sp" bitsize=3D"32"/>
> > +  <reg name=3D"s8" bitsize=3D"32"/>
> > +  <reg name=3D"ra" bitsize=3D"32"/>
> > +  <reg name=3D"sr" bitsize=3D"32"/>
> > +  <reg name=3D"lo" bitsize=3D"32"/>
> > +  <reg name=3D"hi" bitsize=3D"32"/>
> > +  <reg name=3D"bad" bitsize=3D"32"/>
> > +  <reg name=3D"cause" bitsize=3D"32"/>
> > +  <reg name=3D"pc" bitsize=3D"32"/>
> > +
> > +  <reg name=3D"f0" bitsize=3D"32" regnum=3D"38"/>
> > +  <reg name=3D"f1" bitsize=3D"32"/>
> > +  <reg name=3D"f2" bitsize=3D"32"/>
> > +  <reg name=3D"f3" bitsize=3D"32"/>
> > +  <reg name=3D"f4" bitsize=3D"32"/>
> > +  <reg name=3D"f5" bitsize=3D"32"/>
> > +  <reg name=3D"f6" bitsize=3D"32"/>
> > +  <reg name=3D"f7" bitsize=3D"32"/>
> > +  <reg name=3D"f8" bitsize=3D"32"/>
> > +  <reg name=3D"f9" bitsize=3D"32"/>
> > +  <reg name=3D"f10" bitsize=3D"32"/>
> > +  <reg name=3D"f11" bitsize=3D"32"/>
> > +  <reg name=3D"f12" bitsize=3D"32"/>
> > +  <reg name=3D"f13" bitsize=3D"32"/>
> > +  <reg name=3D"f14" bitsize=3D"32"/>
> > +  <reg name=3D"f15" bitsize=3D"32"/>
> > +  <reg name=3D"f16" bitsize=3D"32"/>
> > +  <reg name=3D"f17" bitsize=3D"32"/>
> > +  <reg name=3D"f18" bitsize=3D"32"/>
> > +  <reg name=3D"f19" bitsize=3D"32"/>
> > +  <reg name=3D"f20" bitsize=3D"32"/>
> > +  <reg name=3D"f21" bitsize=3D"32"/>
> > +  <reg name=3D"f22" bitsize=3D"32"/>
> > +  <reg name=3D"f23" bitsize=3D"32"/>
> > +  <reg name=3D"f24" bitsize=3D"32"/>
> > +  <reg name=3D"f25" bitsize=3D"32"/>
> > +  <reg name=3D"f26" bitsize=3D"32"/>
> > +  <reg name=3D"f27" bitsize=3D"32"/>
> > +  <reg name=3D"f28" bitsize=3D"32"/>
> > +  <reg name=3D"f29" bitsize=3D"32"/>
> > +  <reg name=3D"f30" bitsize=3D"32"/>
> > +  <reg name=3D"f31" bitsize=3D"32"/>
> > +  <reg name=3D"fsr" bitsize=3D"32" group=3D"float"/>
> > +  <reg name=3D"fir" bitsize=3D"32" group=3D"float"/>
> > +  <reg name=3D"fp" bitsize=3D"32" group=3D"float"/>
> > +</feature>
> > diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml
> > new file mode 100644
> > index 0000000000..cc1a15ad56
> > --- /dev/null
> > +++ b/gdb-xml/mips64-core.xml
> > @@ -0,0 +1,84 @@
> > +<?xml version=3D"1.0"?>
> > +<!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.
> > +
> > +     Copying and distribution of this file, with or without
> > modification,
> > +     are permitted in any medium without royalty provided the copyrigh=
t
> > +     notice and this notice are preserved.  -->
> > +
> > +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > +<feature name=3D"org.gnu.gdb.mips64">
> > +  <reg name=3D"zero" bitsize=3D"64"/>
> > +  <reg name=3D"at" bitsize=3D"64"/>
> > +  <reg name=3D"v0" bitsize=3D"64"/>
> > +  <reg name=3D"v1" bitsize=3D"64"/>
> > +  <reg name=3D"a0" bitsize=3D"64"/>
> > +  <reg name=3D"a1" bitsize=3D"64"/>
> > +  <reg name=3D"a2" bitsize=3D"64"/>
> > +  <reg name=3D"a3" bitsize=3D"64"/>
> > +  <reg name=3D"t0" bitsize=3D"64"/>
> > +  <reg name=3D"t1" bitsize=3D"64"/>
> > +  <reg name=3D"t2" bitsize=3D"64"/>
> > +  <reg name=3D"t3" bitsize=3D"64"/>
> > +  <reg name=3D"t4" bitsize=3D"64"/>
> > +  <reg name=3D"t5" bitsize=3D"64"/>
> > +  <reg name=3D"t6" bitsize=3D"64"/>
> > +  <reg name=3D"t7" bitsize=3D"64"/>
> > +  <reg name=3D"s0" bitsize=3D"64"/>
> > +  <reg name=3D"s1" bitsize=3D"64"/>
> > +  <reg name=3D"s2" bitsize=3D"64"/>
> > +  <reg name=3D"s3" bitsize=3D"64"/>
> > +  <reg name=3D"s4" bitsize=3D"64"/>
> > +  <reg name=3D"s5" bitsize=3D"64"/>
> > +  <reg name=3D"s6" bitsize=3D"64"/>
> > +  <reg name=3D"s7" bitsize=3D"64"/>
> > +  <reg name=3D"t8" bitsize=3D"64"/>
> > +  <reg name=3D"t9" bitsize=3D"64"/>
> > +  <reg name=3D"k0" bitsize=3D"64"/>
> > +  <reg name=3D"k1" bitsize=3D"64"/>
> > +  <reg name=3D"gp" bitsize=3D"64"/>
> > +  <reg name=3D"sp" bitsize=3D"64"/>
> > +  <reg name=3D"s8" bitsize=3D"64"/>
> > +  <reg name=3D"ra" bitsize=3D"64"/>
> > +  <reg name=3D"sr" bitsize=3D"64"/>
> > +  <reg name=3D"lo" bitsize=3D"64"/>
> > +  <reg name=3D"hi" bitsize=3D"64"/>
> > +  <reg name=3D"bad" bitsize=3D"64"/>
> > +  <reg name=3D"cause" bitsize=3D"64"/>
> > +  <reg name=3D"pc" bitsize=3D"64"/>
> > +
> > +  <reg name=3D"f0" bitsize=3D"64" regnum=3D"38"/>
> > +  <reg name=3D"f1" bitsize=3D"64"/>
> > +  <reg name=3D"f2" bitsize=3D"64"/>
> > +  <reg name=3D"f3" bitsize=3D"64"/>
> > +  <reg name=3D"f4" bitsize=3D"64"/>
> > +  <reg name=3D"f5" bitsize=3D"64"/>
> > +  <reg name=3D"f6" bitsize=3D"64"/>
> > +  <reg name=3D"f7" bitsize=3D"64"/>
> > +  <reg name=3D"f8" bitsize=3D"64"/>
> > +  <reg name=3D"f9" bitsize=3D"64"/>
> > +  <reg name=3D"f10" bitsize=3D"64"/>
> > +  <reg name=3D"f11" bitsize=3D"64"/>
> > +  <reg name=3D"f12" bitsize=3D"64"/>
> > +  <reg name=3D"f13" bitsize=3D"64"/>
> > +  <reg name=3D"f14" bitsize=3D"64"/>
> > +  <reg name=3D"f15" bitsize=3D"64"/>
> > +  <reg name=3D"f16" bitsize=3D"64"/>
> > +  <reg name=3D"f17" bitsize=3D"64"/>
> > +  <reg name=3D"f18" bitsize=3D"64"/>
> > +  <reg name=3D"f19" bitsize=3D"64"/>
> > +  <reg name=3D"f20" bitsize=3D"64"/>
> > +  <reg name=3D"f21" bitsize=3D"64"/>
> > +  <reg name=3D"f22" bitsize=3D"64"/>
> > +  <reg name=3D"f23" bitsize=3D"64"/>
> > +  <reg name=3D"f24" bitsize=3D"64"/>
> > +  <reg name=3D"f25" bitsize=3D"64"/>
> > +  <reg name=3D"f26" bitsize=3D"64"/>
> > +  <reg name=3D"f27" bitsize=3D"64"/>
> > +  <reg name=3D"f28" bitsize=3D"64"/>
> > +  <reg name=3D"f29" bitsize=3D"64"/>
> > +  <reg name=3D"f30" bitsize=3D"64"/>
> > +  <reg name=3D"f31" bitsize=3D"64"/>
> > +  <reg name=3D"fsr" bitsize=3D"64" group=3D"float"/>
> > +  <reg name=3D"fir" bitsize=3D"64" group=3D"float"/>
> > +  <reg name=3D"fp" bitsize=3D"64" group=3D"float"/>
> > +</feature>
> > diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> > index bbcf7ca463..014f1db59e 100644
> > --- a/target/mips/cpu.c
> > +++ b/target/mips/cpu.c
> > @@ -181,6 +181,11 @@ static ObjectClass *mips_cpu_class_by_name(const
> > char *cpu_model)
> >      return oc;
> >  }
> >
> > +static gchar *mips_gdb_arch_name(CPUState *cs)
> > +{
> > +    return g_strdup("mips");
> > +}
> > +
> >  static void mips_cpu_class_init(ObjectClass *c, void *data)
> >  {
> >      MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(c);
> > @@ -213,6 +218,12 @@ static void mips_cpu_class_init(ObjectClass *c,
> > void *data)
> >      cc->tlb_fill =3D mips_cpu_tlb_fill;
> >  #endif
> >
> > +    cc->gdb_arch_name =3D mips_gdb_arch_name;
> > +#ifdef TARGET_MIPS64
> > +    cc->gdb_core_xml_file =3D "mips64-core.xml";
> > +#else
> > +    cc->gdb_core_xml_file =3D "mips-core.xml";
> > +#endif
> >      cc->gdb_num_core_regs =3D 73;
> >      cc->gdb_stop_before_watchpoint =3D true;
> >  }
>
>
> --
> Alex Benn=C3=A9e
>
>

--000000000000fc978c05946645c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 7, 2019, Alex Benn=C3=A9e &lt;<a href=3D"mailto:=
alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><br>
Mikhail Abakumov &lt;<a href=3D"mailto:mikhail.abakumov@ispras.ru">mikhail.=
abakumov@ispras.ru</a>&gt; writes:<br>
<br>
&gt; From: Mikhail Abakumov &lt;mikhail.abakumov@ispras&gt;<br>
<br>
Hmm the email got truncated here.<br>
<br>
&gt;<br>
&gt; This patch add xml files with gdb registers for mips.<br>
&gt;<br>
&gt; Signed-off-by: Mikhail Abakumov &lt;mikhail.abakumov@ispras&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 3 ++<br>
&gt;=C2=A0 gdb-xml/mips-core.xml=C2=A0 =C2=A0| 84 +++++++++++++++++++++++++=
+++++<wbr>+++++++++++<br>
&gt;=C2=A0 gdb-xml/mips64-core.xml | 84<br>
&gt; ++++++++++++++++++++++++++++++<wbr>+++++++++++<br>
<br>
Otherwise for the configure/xml:<br>
<br>
Acked-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">al=
ex.bennee@linaro.org</a>&gt;<br>
<br>
I assume the changes will go in via a MIPS tree.<br>
<br></blockquote><div><br></div><div>Yes, this should go via mips tree. Tha=
nks for taking a look.</div><div><br></div><div><br></div><div>Mikhail, tha=
nks for this effort.</div><div><br></div><div>Is there any way to include M=
SA registers, possibly in a separate file, and in a separate patch? What ab=
out a separate file for FPU registers? Can you take a look at corresponding=
 solutions for other architectures?</div><div><br></div><div>Yours,</div><d=
iv>Aleksandar</div><div><br></div><div><br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
&gt;=C2=A0 target/mips/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 ++++++<br>
&gt;=C2=A0 4 files changed, 182 insertions(+)<br>
&gt;=C2=A0 create mode 100644 gdb-xml/mips-core.xml<br>
&gt;=C2=A0 create mode 100644 gdb-xml/mips64-core.xml<br>
&gt;<br>
&gt; diff --git a/configure b/configure<br>
&gt; index 8f8446f52b..5bb2c62194 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -7466,12 +7466,14 @@ case &quot;$target_name&quot; in<br>
&gt;=C2=A0 =C2=A0 mips|mipsel)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mttcg=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TARGET_ARCH=3Dmips<br>
&gt; +=C2=A0 =C2=A0 gdb_xml_files=3D&quot;mips-core.xml&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;TARGET_ABI_MIPSO32=3Dy&quot; &gt;&gt; $=
config_target_mak<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 mipsn32|mipsn32el)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mttcg=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TARGET_ARCH=3Dmips64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TARGET_BASE_ARCH=3Dmips<br>
&gt; +=C2=A0 =C2=A0 gdb_xml_files=3D&quot;mips64-core.<wbr>xml&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;TARGET_ABI_MIPSN32=3Dy&quot; &gt;&gt; $=
config_target_mak<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;TARGET_ABI32=3Dy&quot; &gt;&gt; $config=
_target_mak<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt; @@ -7479,6 +7481,7 @@ case &quot;$target_name&quot; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mttcg=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TARGET_ARCH=3Dmips64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TARGET_BASE_ARCH=3Dmips<br>
&gt; +=C2=A0 =C2=A0 gdb_xml_files=3D&quot;mips64-core.<wbr>xml&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;TARGET_ABI_MIPSN64=3Dy&quot; &gt;&gt; $=
config_target_mak<br>
&gt;=C2=A0 =C2=A0 ;;<br>
&gt;=C2=A0 =C2=A0 moxie)<br>
&gt; diff --git a/gdb-xml/mips-core.xml b/gdb-xml/mips-core.xml<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..a46b2993eb<br>
&gt; --- /dev/null<br>
&gt; +++ b/gdb-xml/mips-core.xml<br>
&gt; @@ -0,0 +1,84 @@<br>
&gt; +&lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
&gt; +&lt;!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Copying and distribution of this file, with or wi=
thout<br>
&gt; modification,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0are permitted in any medium without royalty provi=
ded the copyright<br>
&gt; +=C2=A0 =C2=A0 =C2=A0notice and this notice are preserved.=C2=A0 --&gt=
;<br>
&gt; +<br>
&gt; +&lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
&gt; +&lt;feature name=3D&quot;org.gnu.gdb.mips&quot;&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;zero&quot; bitsize=3D&quot;32&quot;/&gt;<=
br>
&gt; +=C2=A0 &lt;reg name=3D&quot;at&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;v0&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;v1&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a0&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a1&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a2&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a3&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t0&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t1&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t2&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t3&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t4&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t5&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t6&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t7&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s0&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s1&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s2&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s3&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s4&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s5&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s6&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s7&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t8&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t9&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;k0&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;k1&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;gp&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;sp&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s8&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;ra&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;sr&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;lo&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;hi&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;bad&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;cause&quot; bitsize=3D&quot;32&quot;/&gt;=
<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;pc&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;f0&quot; bitsize=3D&quot;32&quot; regnum=
=3D&quot;38&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;f1&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f2&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f3&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f4&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f5&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f6&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f7&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f8&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f9&quot; bitsize=3D&quot;32&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f10&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f11&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f12&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f13&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f14&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f15&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f16&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f17&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f18&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f19&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f20&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f21&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f22&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f23&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f24&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f25&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f26&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f27&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f28&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f29&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f30&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f31&quot; bitsize=3D&quot;32&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;fsr&quot; bitsize=3D&quot;32&quot; group=
=3D&quot;float&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;fir&quot; bitsize=3D&quot;32&quot; group=
=3D&quot;float&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;fp&quot; bitsize=3D&quot;32&quot; group=
=3D&quot;float&quot;/&gt;<br>
&gt; +&lt;/feature&gt;<br>
&gt; diff --git a/gdb-xml/mips64-core.xml b/gdb-xml/mips64-core.xml<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..cc1a15ad56<br>
&gt; --- /dev/null<br>
&gt; +++ b/gdb-xml/mips64-core.xml<br>
&gt; @@ -0,0 +1,84 @@<br>
&gt; +&lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
&gt; +&lt;!-- Copyright (C) 2010-2019 Free Software Foundation, Inc.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0Copying and distribution of this file, with or wi=
thout<br>
&gt; modification,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0are permitted in any medium without royalty provi=
ded the copyright<br>
&gt; +=C2=A0 =C2=A0 =C2=A0notice and this notice are preserved.=C2=A0 --&gt=
;<br>
&gt; +<br>
&gt; +&lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
&gt; +&lt;feature name=3D&quot;org.gnu.gdb.mips64&quot;&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;zero&quot; bitsize=3D&quot;64&quot;/&gt;<=
br>
&gt; +=C2=A0 &lt;reg name=3D&quot;at&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;v0&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;v1&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a0&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a1&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a2&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;a3&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t0&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t1&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t2&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t3&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t4&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t5&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t6&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t7&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s0&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s1&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s2&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s3&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s4&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s5&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s6&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s7&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t8&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;t9&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;k0&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;k1&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;gp&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;sp&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;s8&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;ra&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;sr&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;lo&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;hi&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;bad&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;cause&quot; bitsize=3D&quot;64&quot;/&gt;=
<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;pc&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;f0&quot; bitsize=3D&quot;64&quot; regnum=
=3D&quot;38&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;f1&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f2&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f3&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f4&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f5&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f6&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f7&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f8&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f9&quot; bitsize=3D&quot;64&quot;/&gt;<br=
>
&gt; +=C2=A0 &lt;reg name=3D&quot;f10&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f11&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f12&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f13&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f14&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f15&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f16&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f17&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f18&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f19&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f20&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f21&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f22&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f23&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f24&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f25&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f26&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f27&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f28&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f29&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f30&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;f31&quot; bitsize=3D&quot;64&quot;/&gt;<b=
r>
&gt; +=C2=A0 &lt;reg name=3D&quot;fsr&quot; bitsize=3D&quot;64&quot; group=
=3D&quot;float&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;fir&quot; bitsize=3D&quot;64&quot; group=
=3D&quot;float&quot;/&gt;<br>
&gt; +=C2=A0 &lt;reg name=3D&quot;fp&quot; bitsize=3D&quot;64&quot; group=
=3D&quot;float&quot;/&gt;<br>
&gt; +&lt;/feature&gt;<br>
&gt; diff --git a/target/mips/cpu.c b/target/mips/cpu.c<br>
&gt; index bbcf7ca463..014f1db59e 100644<br>
&gt; --- a/target/mips/cpu.c<br>
&gt; +++ b/target/mips/cpu.c<br>
&gt; @@ -181,6 +181,11 @@ static ObjectClass *mips_cpu_class_by_name(const<=
br>
&gt; char *cpu_model)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return oc;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static gchar *mips_gdb_arch_name(CPUState *cs)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return g_strdup(&quot;mips&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void mips_cpu_class_init(<wbr>ObjectClass *c, void *data)=
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 MIPSCPUClass *mcc =3D MIPS_CPU_CLASS(c);<br>
&gt; @@ -213,6 +218,12 @@ static void mips_cpu_class_init(<wbr>ObjectClass =
*c,<br>
&gt; void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cc-&gt;tlb_fill =3D mips_cpu_tlb_fill;<br>
&gt;=C2=A0 #endif<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_arch_name =3D mips_gdb_arch_name;<br>
&gt; +#ifdef TARGET_MIPS64<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_core_xml_file =3D &quot;mips64-core.xml&quot=
;;<br>
&gt; +#else<br>
&gt; +=C2=A0 =C2=A0 cc-&gt;gdb_core_xml_file =3D &quot;mips-core.xml&quot;;=
<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cc-&gt;gdb_num_core_regs =3D 73;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 cc-&gt;gdb_stop_before_watchpoint =3D true;<br>
&gt;=C2=A0 }<br>
<br>
<br>
--<br>
Alex Benn=C3=A9e<br>
<br>
</blockquote>

--000000000000fc978c05946645c8--


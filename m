Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED95C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 16:24:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A5020725
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 16:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZz2iHIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A5020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib5XB-0007Nc-KK
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 11:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib5WI-0006xg-N9
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 11:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib5WF-0008CQ-38
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 11:22:54 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ib5WE-0008CG-Pb
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 11:22:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id o12so28575976oic.9
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=BWKIvU9xnTaCncoFrC4hQo6o3TaxLIhDWA7tBydqFEM=;
 b=EZz2iHIVvsBZ306W3gwbEvOYa2bSFLy1/XRUV/IYLolj9NbVMd0wqJxTjXp6wPVCDk
 8XTFgsyMIqvuZCgPesp8maLLDMxoNkDth7m3Bw+dO3Hm/OYIId8MF4mwxFznVYcjdCNT
 gMbAlYnpTi8pS9cKeqkHA7EAmV1aidRXYe9STZMauOj8gFcaJI2LZfFzqEn+KFGBqA4p
 xlyaD5sqBLUjDjbJk9zmgEnxeLpNW3oVnQhvyCqP+obzHAkMsclAvpuH+ZIyQl6hTw2R
 z/J8EBQoEZZImBXh5Du8EALP5RlUkdOp43P5Gdcdw7KShqBXQnYVxxBlBcrUa3+OvPqM
 sOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=BWKIvU9xnTaCncoFrC4hQo6o3TaxLIhDWA7tBydqFEM=;
 b=HOR06skJbQH07r9w496jTyUNdygoXyd+1F3E/0CkM3QeNAVphP3CvKl1W664KdHCWv
 eMhrqPCfDAg0XuYYtwbY/ca6JDvR5QQgskFq+51HRlc1d3r6Vc+W8yqfJFrL2utEp+Ip
 U7sXZJuI4BDj/2Cavup+hvkqnWUB+9xi8rT18q5iXCm+IHdzpOhN8by+ERnGjjjWf2F6
 m81EGD7e5sGxadBPZ1BW7aCl7xuj4uroymX6OSH9vbz/Tb4yLcu7DaNDVThnjE1uWkpA
 F2YrnHt62BxNQdmgeLm8CtnkxECw/5sxhiebQQO5cgPGD3j0xaj5PJG2GCLZ4oPbyked
 OXBw==
X-Gm-Message-State: APjAAAXqUH3lvgbJRviKcx5e4HLHekzk3WLOGM1lPF5wM4wG3DAh/VYF
 qcjPDyXM2qHbyZrv2i4MKyeazBjRYYAH3Gkxzfw=
X-Google-Smtp-Source: APXvYqwhv8ASuFoqR/jE/767VPcB8FbuBhIuUYrpNlrZ5CMwHBRpAxyaDFmYSnDZqSOwgzut3iaI0VJqACQ1Fwjm80Y=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr2886014oic.62.1575130969808; 
 Sat, 30 Nov 2019 08:22:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 08:22:49
 -0800 (PST)
In-Reply-To: <CAK4993hACMt78_bs7es=awz54LzGru_rxCSEWwWi6SHpgZy33g@mail.gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <CAL1e-=i8i6kLZX_-UNEeYTk6_uYfDM5rY_yMMnFVz1qtPU7Y8Q@mail.gmail.com>
 <CAK4993hACMt78_bs7es=awz54LzGru_rxCSEWwWi6SHpgZy33g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 30 Nov 2019 17:22:49 +0100
Message-ID: <CAL1e-=hb0Cbrq=cbsV2O3PtM+9RycmCOiXG_ayq2iyfMzfeoGg@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ee21e9059892c124"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ee21e9059892c124
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 23, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> On Fri, Nov 22, 2019 at 7:12 PM Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > > +
> > > +static void avr_avr1_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +}
> > > +
> > > +static void avr_avr2_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +}
> > > +
> > > +static void avr_avr25_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +}
> > > +
> > > +static void avr_avr3_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +}
> > > +
> > > +static void avr_avr31_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +}
> > > +
> > > +static void avr_avr35_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +}
> > > +
> > > +static void avr_avr4_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +}
> > > +
> > > +static void avr_avr5_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +}
> > > +
> > > +static void avr_avr51_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +}
> > > +
> > > +static void avr_avr6_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +}
> > > +
> > > +static void avr_xmega2_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > > +}
> > > +
> > > +static void avr_xmega4_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > > +}
> > > +
> > > +static void avr_xmega5_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > > +}
> > > +
> > > +static void avr_xmega6_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > > +}
> > > +
> > > +static void avr_xmega7_initfn(Object *obj)
> > > +{
> > > +    AVRCPU *cpu = AVR_CPU(obj);
> > > +    CPUAVRState *env = &cpu->env;
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > > +
> > > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > > +}
> > > +
> > > +typedef struct AVRCPUInfo {
> > > +    const char *name;
> > > +    void (*initfn)(Object *obj);
> > > +} AVRCPUInfo;
> > > +
> > > +
> > > +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
> > > +{
> > > +    const char *typename = object_class_get_name(OBJECT_CLASS(data));
> > > +
> > > +    qemu_printf("%s\n", typename);
> > > +}
> > > +
> > > +void avr_cpu_list(void)
> > > +{
> > > +    GSList *list;
> > > +    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
> > > +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> > > +    g_slist_free(list);
> > > +}
> > > +
> > > +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> > > +    { \
> > > +        .parent = TYPE_AVR_CPU, \
> > > +        .instance_init = initfn, \
> > > +        .name = model "-avr-cpu", \
> > > +    }
> > > +
> > > +static const TypeInfo avr_cpu_type_info[] = {
> > > +    {
> > > +        .name = TYPE_AVR_CPU,
> > > +        .parent = TYPE_CPU,
> > > +        .instance_size = sizeof(AVRCPU),
> > > +        .instance_init = avr_cpu_initfn,
> > > +        .class_size = sizeof(AVRCPUClass),
> > > +        .class_init = avr_cpu_class_init,
> > > +        .abstract = true,
> > > +    },
> > > +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> > > +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> > > +};
> > > +
> >
> > Hi, Michael,
> >
> > I have the hardest time finding in the documentation some kind of
> > table of AVR CPUs containing supported features. Related to that:
> >
> > - Is there a list in the docs equivalent to the definitions of
> > AVR_FEATURE_XXX constants in your code?
> > - How did you collect all info needed for definition of 15 CPUs above
> > (link to the source of info would be great)?
> > - Would all 15 CPUs be supported in QEMU once this series is
> > integrated, without caveats?
> >
> > Sincerely yours,
> > Aleksandar
>
> Hi Alexandar.
>
> you can find this info in different source
> 1. this wiki https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set


Hmm. Introducing a new target to QEMU based on Wikipedia article?


> 2. download all the speck and compare


It would be helpful if you provided links to the specs you meant here.


> 3. GCC
>     1. https://gcc.gnu.org/onlinedocs/gcc/AVR-Options.html
>     2. https://github.com/gcc-mirror/gcc/blob/master/gcc/config/
> avr/avr-mcus.def
>     3. https://github.com/gcc-mirror/gcc/blob/master/gcc/config/
> avr/avr-arch.h
>     4. https://github.com/gcc-mirror/gcc/blob/master/gcc/config/
> avr/avr-devices.c
>
>
QEMU should not be dependent on gcc code, as it is, by its definition, a
compiler-agnostic tool. Dependence on gcc opens the possibility of
importing bugs from gcc, among other problems.

It appears to me that all AVR_FEATURE_XXX constants are pure gcc
constructs, never mentioned (unfortunately) in official AVR documentation,
or some comparison table by the vendor. I understand that it is nice to
have the same organuzation of such flags both in QEMU and gcc, but gcc is
not QEMU's reference, and your checking each single item related to
AVR_FEATURE_XXX in the AVR documentation would be much appreciated. I know
it is a lot of work - but is there any other better solution than just
copying the code from gcc?

Thanks, Aleksandar


> as for the flags
> 1. AVR_FEATURE_SRAM defined but never used
> 2. AVR_FEATURE_LPM assigned for all cores, however there are more
> cores that do not support this instruction, so if added to QEMU will
> not have it defined for them.
>
>
>
> --
> Best Regards,
> Michael Rolnik
>

--000000000000ee21e9059892c124
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 23, 2019, Michael Rolnik &lt;<a href=3D"mailt=
o:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Fri, Nov 22, 2019 at 7:12 PM Aleksandar Markovic<br>
&lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr1_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr2_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr25_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr3_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr31_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr35_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr4_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr5_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr51_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_avr6_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_xmega2_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_xmega4_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_xmega5_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_xmega6_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_xmega7_initfn(Object *obj)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; &gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br=
>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
&gt; &gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +typedef struct AVRCPUInfo {<br>
&gt; &gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt; &gt; +=C2=A0 =C2=A0 void (*initfn)(Object *obj);<br>
&gt; &gt; +} AVRCPUInfo;<br>
&gt; &gt; +<br>
&gt; &gt; +<br>
&gt; &gt; +static void avr_cpu_list_entry(gpointer data, gpointer user_data=
)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 const char *typename =3D object_class_get_name(OBJ=
ECT_<wbr>CLASS(data));<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 qemu_printf(&quot;%s\n&quot;, typename);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +void avr_cpu_list(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 GSList *list;<br>
&gt; &gt; +=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(<wbr>TYPE_AV=
R_CPU, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 g_slist_foreach(list, avr_cpu_list_entry, NULL);<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 g_slist_free(list);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +#define DEFINE_AVR_CPU_TYPE(model, initfn) \<br>
&gt; &gt; +=C2=A0 =C2=A0 { \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_AVR_CPU, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D initfn, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D model &quot;-avr-cpu&quot;=
, \<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +static const TypeInfo avr_cpu_type_info[] =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_AVR_CPU,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AVRCPU),<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D avr_cpu_initfn,<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(AVRCPUClass),=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D avr_cpu_class_init,<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,<br>
&gt; &gt; +=C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr1&quot;, avr_avr1_ini=
tfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr2&quot;, avr_avr2_ini=
tfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr25&quot;, avr_avr25_i=
nitfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr3&quot;, avr_avr3_ini=
tfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr31&quot;, avr_avr31_i=
nitfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr35&quot;, avr_avr35_i=
nitfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr4&quot;, avr_avr4_ini=
tfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr5&quot;, avr_avr5_ini=
tfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr51&quot;, avr_avr51_i=
nitfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr6&quot;, avr_avr6_ini=
tfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega2&quot;, avr_xmega2=
_initfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega4&quot;, avr_xmega4=
_initfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega5&quot;, avr_xmega5=
_initfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega6&quot;, avr_xmega6=
_initfn),<br>
&gt; &gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega7&quot;, avr_xmega7=
_initfn),<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt;<br>
&gt; Hi, Michael,<br>
&gt;<br>
&gt; I have the hardest time finding in the documentation some kind of<br>
&gt; table of AVR CPUs containing supported features. Related to that:<br>
&gt;<br>
&gt; - Is there a list in the docs equivalent to the definitions of<br>
&gt; AVR_FEATURE_XXX constants in your code?<br>
&gt; - How did you collect all info needed for definition of 15 CPUs above<=
br>
&gt; (link to the source of info would be great)?<br>
&gt; - Would all 15 CPUs be supported in QEMU once this series is<br>
&gt; integrated, without caveats?<br>
&gt;<br>
&gt; Sincerely yours,<br>
&gt; Aleksandar<br>
<br>
Hi Alexandar.<br>
<br>
you can find this info in different source<br>
1. this wiki <a href=3D"https://en.wikipedia.org/wiki/Atmel_AVR_instruction=
_set" target=3D"_blank">https://en.wikipedia.org/wiki/<wbr>Atmel_AVR_instru=
ction_set</a></blockquote><div><br></div><div>Hmm. Introducing a new target=
 to QEMU based on Wikipedia article?</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
2. download all the speck and compare</blockquote><div><br></div><div>It wo=
uld be helpful if you provided links to the specs you meant here.</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
3. GCC<br>
=C2=A0 =C2=A0 1. <a href=3D"https://gcc.gnu.org/onlinedocs/gcc/AVR-Options.=
html" target=3D"_blank">https://gcc.gnu.org/<wbr>onlinedocs/gcc/AVR-Options=
.<wbr>html</a><br>
=C2=A0 =C2=A0 2. <a href=3D"https://github.com/gcc-mirror/gcc/blob/master/g=
cc/config/avr/avr-mcus.def" target=3D"_blank">https://github.com/gcc-mirror=
/<wbr>gcc/blob/master/gcc/config/<wbr>avr/avr-mcus.def</a><br>
=C2=A0 =C2=A0 3. <a href=3D"https://github.com/gcc-mirror/gcc/blob/master/g=
cc/config/avr/avr-arch.h" target=3D"_blank">https://github.com/gcc-mirror/<=
wbr>gcc/blob/master/gcc/config/<wbr>avr/avr-arch.h</a><br>
=C2=A0 =C2=A0 4. <a href=3D"https://github.com/gcc-mirror/gcc/blob/master/g=
cc/config/avr/avr-devices.c" target=3D"_blank">https://github.com/gcc-mirro=
r/<wbr>gcc/blob/master/gcc/config/<wbr>avr/avr-devices.c</a><br>
<br></blockquote><div><br></div><div>QEMU should not be dependent on gcc co=
de, as it is, by its definition, a compiler-agnostic tool. Dependence on gc=
c opens the possibility of importing bugs from gcc, among other problems.</=
div><div><br></div><div>It appears to me that all AVR_FEATURE_XXX constants=
 are pure gcc constructs, never mentioned (unfortunately) in official AVR d=
ocumentation, or some comparison table by the vendor. I understand that it =
is nice to have the same organuzation of such flags both in QEMU and gcc, b=
ut gcc is not QEMU&#39;s reference, and your checking each single item rela=
ted to AVR_FEATURE_XXX=C2=A0in the AVR documentation would be much apprecia=
ted. I know it is a lot of work - but is there any other better solution th=
an just copying the code from gcc?</div><div><br></div><div>Thanks, Aleksan=
dar</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
as for the flags<br>
1. AVR_FEATURE_SRAM defined but never used<br>
2. AVR_FEATURE_LPM assigned for all cores, however there are more<br>
cores that do not support this instruction, so if added to QEMU will<br>
not have it defined for them.<br>
<br>
<br>
<br>
-- <br>
Best Regards,<br>
Michael Rolnik<br>
</blockquote>

--000000000000ee21e9059892c124--


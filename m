Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FDC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 22:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E49E2053B
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 22:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXvnMigb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E49E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYe8Q-0004VB-JA
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 17:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iYe7l-00041u-HL
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 17:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iYe7j-0004pn-EM
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 17:43:29 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:46937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iYe7j-0004pS-9J
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 17:43:27 -0500
Received: by mail-qt1-x841.google.com with SMTP id r20so12436055qtp.13
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 14:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CjHPuXOAwkSfFOqwjJG8zohR2kemzBmJOPf4DW0m5xE=;
 b=rXvnMigby2Qv8AE2Cr3zrdS1OtkJ1BH2OkATV5+KwXfjtnZtfd0vBFhBT1WDwFmy6t
 EZXvfmQxIWoHOpMjNmttfkqjKDqk8X47xrOTQFeZ9HgW1sTS8MNfumT5VymTO4Y3Wj8o
 zXmbU1lwtlYDMWhi2GvLe4Rd4xFE6DBGb3d15gbqUooTMtCo5dlIrSb3WvuzxckORcd/
 XzqRG5Jxd18yTAraWJ3plmSasolbH7hbrshpBMNN5VbCka+/URC+YawNlRdex7UC9fiw
 uQA7ai0LiBa/280vUOpPkkSJIYNw2leBwEON5nrl5+nbPSLAa/DZBHbL7LvRzrOq8fjC
 HuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CjHPuXOAwkSfFOqwjJG8zohR2kemzBmJOPf4DW0m5xE=;
 b=XZwqgwVfyyyDRiOuyQhK4nSvnMbcRI0EBmzUVNJmLs1WucfT/EALgO+yyeWwJpzUPC
 G0IKA7U8jsSpn0XmeUW0qnIfJPRxChNn++0A24+QKVAsaR8EYi1GDjjQFEeJKu2cNy9m
 mmoOTA8B78aN5jNTQmkwxk2bjfBfdZBPo7M4d1Xq41Fo/yOuak9Djtl4/dYSFaMLUWAC
 BgiMfjBA81H81gkkNcNiswbABL3hEF4/1AFEVN0g3JE49dJFWFp5TggTBH3MgKRb5fGI
 DZuHlYAax4M/9TBjLldtJ8tLxJybky0N4sAAkV7GdpQ8wwY08UHs+YxNECWY3syb2fej
 QesA==
X-Gm-Message-State: APjAAAWJAbp7ybLMTF4mZ4c9SfolMcVo8jhJSOItaFWYqEXFb8kG+gGp
 1pd7pY86BE0bSP1t3ezz4oeDOwesIf1aqRFP9Ns=
X-Google-Smtp-Source: APXvYqzDLEKuJ5c9ZNtekQxkMgvVs0NgsbMuYgJ+D42FdpXkvBdzrByJyW4q7w11lseDg40QBBBYxwc9uZNE+YeAKlY=
X-Received: by 2002:ac8:4a02:: with SMTP id x2mr10616283qtq.371.1574549005796; 
 Sat, 23 Nov 2019 14:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <CAL1e-=i8i6kLZX_-UNEeYTk6_uYfDM5rY_yMMnFVz1qtPU7Y8Q@mail.gmail.com>
In-Reply-To: <CAL1e-=i8i6kLZX_-UNEeYTk6_uYfDM5rY_yMMnFVz1qtPU7Y8Q@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 24 Nov 2019 00:42:28 +0200
Message-ID: <CAK4993hACMt78_bs7es=awz54LzGru_rxCSEWwWi6SHpgZy33g@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

On Fri, Nov 22, 2019 at 7:12 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> > +
> > +static void avr_avr1_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +}
> > +
> > +static void avr_avr2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +}
> > +
> > +static void avr_avr25_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +}
> > +
> > +static void avr_avr3_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
> > +
> > +static void avr_avr31_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
> > +
> > +static void avr_avr35_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +}
> > +
> > +static void avr_avr4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_avr5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_avr51_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_avr6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +}
> > +
> > +static void avr_xmega2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +static void avr_xmega7_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu = AVR_CPU(obj);
> > +    CPUAVRState *env = &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
> > +}
> > +
> > +typedef struct AVRCPUInfo {
> > +    const char *name;
> > +    void (*initfn)(Object *obj);
> > +} AVRCPUInfo;
> > +
> > +
> > +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
> > +{
> > +    const char *typename = object_class_get_name(OBJECT_CLASS(data));
> > +
> > +    qemu_printf("%s\n", typename);
> > +}
> > +
> > +void avr_cpu_list(void)
> > +{
> > +    GSList *list;
> > +    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
> > +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
> > +    g_slist_free(list);
> > +}
> > +
> > +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
> > +    { \
> > +        .parent = TYPE_AVR_CPU, \
> > +        .instance_init = initfn, \
> > +        .name = model "-avr-cpu", \
> > +    }
> > +
> > +static const TypeInfo avr_cpu_type_info[] = {
> > +    {
> > +        .name = TYPE_AVR_CPU,
> > +        .parent = TYPE_CPU,
> > +        .instance_size = sizeof(AVRCPU),
> > +        .instance_init = avr_cpu_initfn,
> > +        .class_size = sizeof(AVRCPUClass),
> > +        .class_init = avr_cpu_class_init,
> > +        .abstract = true,
> > +    },
> > +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
> > +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
> > +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
> > +};
> > +
>
> Hi, Michael,
>
> I have the hardest time finding in the documentation some kind of
> table of AVR CPUs containing supported features. Related to that:
>
> - Is there a list in the docs equivalent to the definitions of
> AVR_FEATURE_XXX constants in your code?
> - How did you collect all info needed for definition of 15 CPUs above
> (link to the source of info would be great)?
> - Would all 15 CPUs be supported in QEMU once this series is
> integrated, without caveats?
>
> Sincerely yours,
> Aleksandar

Hi Alexandar.

you can find this info in different source
1. this wiki https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set
2. download all the speck and compare
3. GCC
    1. https://gcc.gnu.org/onlinedocs/gcc/AVR-Options.html
    2. https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-mcus.def
    3. https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-arch.h
    4. https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.c

as for the flags
1. AVR_FEATURE_SRAM defined but never used
2. AVR_FEATURE_LPM assigned for all cores, however there are more
cores that do not support this instruction, so if added to QEMU will
not have it defined for them.



-- 
Best Regards,
Michael Rolnik


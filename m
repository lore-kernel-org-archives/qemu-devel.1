Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23134C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2E620829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkbJACjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2E620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B4y-0005gE-6R
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1AmY-0004rW-8Y
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:47:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1AmU-0003qz-To
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:47:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so9898143ota.10
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7BTKY0AOu7kkJmSYmdz0BsUTmdAuROH9BExYArF4J/4=;
 b=nkbJACjEV6jl3bVdssD5VqWitK4ZYtnf2OAcvzrKwiVQz8y9z/cBnawdco0LEtWeAp
 fuOggHzAs8QbNdBNoK5ddpG5OQ9BVa633EllrCNxwaMiJjQAiO8lS06c+bKQu6zaFY3a
 nwk/5Ez/0/wLo52EQCvaD3BrFxXMdBYawa8Buw5PTbbIXX/IkzfUDgbFZlyPD7G6QX+N
 UCc7/B4/N2E+vs1k4zhOTJzwQ+GmysFPdPKkYtXKVRF7InP6EMx64xrtvOHhKQJ7cbad
 CcZqbjeaJxjkusAekKyxumYzTXHuxtbp9u7NYShP94pus/XFhjtEd/jDDoH+8XloPBMY
 1pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7BTKY0AOu7kkJmSYmdz0BsUTmdAuROH9BExYArF4J/4=;
 b=rKATOnLn86NJ9CB6mJpHvZmFhYH9Ju+Dy7qlposK1n/etzDsMQxDfE4zrXk39MahKS
 R4P3KfJDzQQNoMPrh/9lKW5nvtMz77AFnYVFIp4vRis/dfej3OfnuSPvX+NwNt5Rg51O
 VxAkEWMOBNoQkdmWwdPTi7e1AQAIQjcht34kAu/XFwDf9JGso/2BOA5mBycE8LDG1QVR
 0LPtaWHSB+cEPm+LGnPI9jjmVvvUD6S74uHBe+FjaEZ7iMbcOZBNkBPLali2aEZslLdo
 7ksLNW0zQtYMqSNRaNspPjHLfgsq5VMVz2pQaPuAP7sOZhFX4y3zzLP8Xvq5gb6WQZ0v
 WqVw==
X-Gm-Message-State: AOAM532YxcRd8iEgB7YIVWZN0BOcD5TTf+jRlWwBLBU+07tRdDRe9umy
 NqXyhG7xQEBoY623d1qYdQjCCwWqVWGP2Yxl+8g4NA==
X-Google-Smtp-Source: ABdhPJwgxlRXzswcF+FyuB1j4i1ZEdn7pxhjeADXDwCMay1PnLFrOeD8pcQnvru/3a5WYZHlmI1GINWEYQsOngGxSls=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr2799632otb.91.1596124061434; 
 Thu, 30 Jul 2020 08:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
In-Reply-To: <20200723025657.644724-1-bauerman@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 16:47:30 +0100
Message-ID: <CAFEAcA-VFaZiR58F-zDo6h_Q-U5gU1O3RDnOcuCnwnuqD_JFSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 at 03:57, Thiago Jung Bauermann
<bauerman@linux.ibm.com> wrote:
>
> The ARM code has a start-powered-off property in ARMCPU, which is a
> subclass of CPUState. This property causes arm_cpu_reset() to set
> CPUState::halted to 1, signalling that the CPU should start in a halted
> state. Other architectures also have code which aim to achieve the same
> effect, but without using a property.
>
> The ppc/spapr version has a bug where QEMU does a KVM_RUN on the vcpu
> before cs->halted is set to 1, causing the vcpu to run while it's still in
> an unitialized state (more details in patch 3).
>
> Peter Maydell mentioned the ARM start-powered-off property and
> Eduardo Habkost suggested making it generic, so this patch series does
> that, for all cases which I was able to find via grep in the code.

Acked-by: Peter Maydell <peter.maydell@linaro.org>
for the Arm bits if you want to take the bug-fixing parts of
this series in via some other tree. (I think they've all been
reviewed.)

thanks
-- PMM


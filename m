Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C615C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AC22073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 15:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BafEGaTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AC22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9sGo-0003LP-0C
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 10:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9sGA-0002uC-4j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9sG9-0007Rx-4y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:18:01 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9sG8-0007RR-Vi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 10:18:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id 66so6000283otd.9
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 07:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k1xwR2KPPUogPphk5Q0+rS6jTuTHREOmc67Cr4a5Y04=;
 b=BafEGaTAw4klHGT3mXgsGL0UlVfU0YfhqBWZ8XskcG5uAlv99rJ1GAr67jkPPhKq/X
 bIdwkpnHx/j/ikEkQ/gLlI8BCQ7du3/UjhHyFD6BIVxUJ38A2REIpgIvlrfv81NZUxlF
 6gMGOUM4zi6eTRT5+BHAlav7x4wJ0wrxdzJxtBJFQB/BzpwzNk12Ja7Ov7LYGKVsFItD
 8LrgLNAB/VmJL+7VMWKSFNptvQR4byf2gYE/YLev74VHW4saAHvYPrlOBSzxylNCioot
 6xo/tK1ZxT3ewPn60ucQaDMKpeD1kSsETPJ957uF4/oZSG4sr/6N0E8jvCG4wQT7lvv2
 ZINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k1xwR2KPPUogPphk5Q0+rS6jTuTHREOmc67Cr4a5Y04=;
 b=PavmWj0yKwMYij2vr276nk1GPvNkMqIzrWcWvRmEqEvb7pUYPjf14+Ye+KZ7X+l1sw
 QnO5/fM9ZKRmy7xh2vigIbdmpzlVwHw7Gs8+fNBR/pQB8EPTDlTrzPSSGCieHRuSiUfl
 SVopMfOrISB5V2kljA+aLYBfL5Tu815RPrrj5IASDOT3kDszWwC1VzOo1UOcl0X8M8bT
 OkbjaYUhJv/48Hj69HHUS2nRNJta29QsOcfyrAEycv+3R3WUK+cCGk9Uk+sewGlOggY7
 1GnaIjd5w7s+D3KENirwDfuSiUHHpNSqZtGPAnVF8VRypk+EuiKIg1z/ACDDCMP7F0t4
 Htjw==
X-Gm-Message-State: ANhLgQ06xYR8lsgDrroKnp8UHeRCYQJvNrAzB+nzTwBC00iJ5dXy2ury
 saefHXfy+EaHqomvRS4R0bf5YXGupkVV3C9JQ5ASiA==
X-Google-Smtp-Source: ADFU+vt5460GTevFdiL99vC59vMlo5KkwFEhOULo7vuagmuE+VRswmbnj6oBnx6tZl36B/w2Gi+B+EhZ/m26d1EVfA4=
X-Received: by 2002:a05:6830:30ac:: with SMTP id
 g12mr5753521ots.221.1583421479874; 
 Thu, 05 Mar 2020 07:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20200304131214.179000-1-stefanb@linux.vnet.ibm.com>
 <CAFEAcA9dW7MqCXYN6TvWiW_95BcC9K839Z=-an7hRYHvUvUJAg@mail.gmail.com>
 <32857917-279b-3f63-6c14-cb6908b93da8@redhat.com>
In-Reply-To: <32857917-279b-3f63-6c14-cb6908b93da8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2020 15:17:48 +0000
Message-ID: <CAFEAcA-WCx1a+Ynd7BoVoSR-GuSnvmCp4DLX=pU97+-LwivS6w@mail.gmail.com>
Subject: Re: [PULL v1 00/10] Merge TPM 2020/03/04
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Mar 2020 at 15:11, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter, Stefan
>
> On 3/5/20 3:50 PM, Peter Maydell wrote:
> I think it is an issue in
> [PATCH v4 06/10] hw/arm/virt: vTPM support
>
>     TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
> is within the CONFIG_LINUX and should be outside.
>
> I am going to send a fix right now but I don't have any environment
> ready to test it against make check.

It fails also on the BSD VM setups in tests/vm, which
you can probably use to test locally.

thanks
-- PMM


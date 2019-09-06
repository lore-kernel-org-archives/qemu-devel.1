Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC83BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3292082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C78RHKDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3292082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BHF-0000Fh-Qi
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i6BGV-0008BU-JL
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i6BGU-0006Ix-6Z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:14:51 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i6BGT-0006Hr-Ui
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:14:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id e12so4221591oie.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 03:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WEnueH3OYCFrf9LIgd88/cny1qkF/Qf5i/wDCMtXRrA=;
 b=C78RHKDMOO02oduj9+AJA6gcuLSYiBoCqpSn0conxZxkJNN3Btnu6gWphmTheqK2TF
 qcRBNK1ckpq3TkcLFzvstW4r5Ex0RXEmKBKTWclc6QzqOEAvy5tYbyJLiIu9gf0ptl6N
 VxGctMMyb8WutdfDJAfidsjDH/1rWtbmMTqSh/nHfZUuKnnQwge3SLyZoN1dLEKgMDSB
 /CzSU3CsG4rcul2TnEfvTVOhNbLFK+ymKNDzdFqEa8mUR+F19wb/u5jBN44BeY/0QCQz
 TFW4AEyN0aGRqXW0D/tsIsBi8kTpPaPMKKnPQ3lKd3t3x4eJnfMIuKBVwS7HRy6takCH
 XcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WEnueH3OYCFrf9LIgd88/cny1qkF/Qf5i/wDCMtXRrA=;
 b=caWKbAgT1WfVJ1ixZ7j5gpAVUDSpn/hyber3yGqghhbGOpikYwS4PzQRLKWXGGbgGI
 8vhND6ycBF5ZwsTuM3KCK8fa5W+w37tMvdYTTrYA55V5AdIQPnNgisx2pRD+3wrfOwWR
 6anEpwT8AUyDFbqthRac3IyYDAs2djzyp8q/1gU02UN+Aa5nJFRfi4TLy8xXUec65BKF
 HxtWc4Q/eP0pX8sCDx7T33brF73zXB1XjwXG6MkNgyo+fD6TI749XBKES63VuAxKBoOw
 y6lAt7VSRlCtDC2Beq+J1VI1x42Z8EA7U/q38PUQebakJkzFF0rV8k9QHCumeiIZ82S9
 L61Q==
X-Gm-Message-State: APjAAAXo2WpGBVPG147HjWHeOlZEm1GBfYIaMJ10zkk1rPYPywMehdmR
 5KF+Kr9iiFZvaMh4DQf+9LB8gXzwQqpxKzre8pK84g==
X-Google-Smtp-Source: APXvYqxLTlUV6PbkDKTnX+4tGCIHaN10lt3aI7KSXfgaXHzhaRRicQDBteKTu85QWxk2J11F81JI0GHRvjODL/xyk+0=
X-Received: by 2002:aca:281a:: with SMTP id 26mr6315714oix.163.1567764888790; 
 Fri, 06 Sep 2019 03:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190827160554.30995-1-eric.auger@redhat.com>
 <20190827160554.30995-3-eric.auger@redhat.com>
 <29520007-f3fd-ed8d-f52b-2839f991556a@huawei.com>
 <0dd3bc89-8f91-0f8e-8908-18712240a115@redhat.com>
 <CAFEAcA8u3Qe9zx=4QxW_Bb8a=JQ7kUmiAO5H-cwAU4i3R+Nf8w@mail.gmail.com>
 <9bd0a5b8-ad15-d19f-2bcc-8b605afb5b78@redhat.com>
In-Reply-To: <9bd0a5b8-ad15-d19f-2bcc-8b605afb5b78@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Sep 2019 11:14:38 +0100
Message-ID: <CAFEAcA9LzvGzpsKMZjG7f1GaHLLyMto2enGrQ_dUPTwiPNA-Gg@mail.gmail.com>
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [RFC 2/3] intc/arm_gic: Support PPI injection for
 more than 256 vpus
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 09:40, Auger Eric <eric.auger@redhat.com> wrote:
> I guess arm_cpu_kvm_set_irq attempting to inject IRQ/FIQ into KVM is
> used with userspace GIC emulation, which is not supported along with
> GICv3. But anyway, I guess it does not hurt to set vcpu_index2 in
> arm_cpu_kvm_set_irq?

Having now got up to speed with the kernel patchset that goes
with this one: yes, we should set the vcpu_index2 in the
arm_cpu_kvm_set_irq function as well.

Given that we have two callsites that now need to assemble
the value for kvm_set_irq() and the cpu_index field is in
two pieces, maybe we should define a utility function that
takes cpu-index, irq-type and irq-id as separate arguments
and assembles the fields into the right places and calls
kvm_set_irq() ?

thanks
-- PMM


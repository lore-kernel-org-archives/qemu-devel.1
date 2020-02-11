Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F1C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CCA20656
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgbxyWkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CCA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XiY-0000Ch-H5
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1Xga-0005JO-8N
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1XgY-0007wC-M1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:42:51 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1XgY-0007vx-87
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:42:50 -0500
Received: by mail-oi1-x242.google.com with SMTP id l9so13175358oii.5
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pd5As4/L2oTjSBZjWpPOMKqBaFJ2ADt2yHhVgPMSRMg=;
 b=NgbxyWkY7QLXWCbElISLSiWcF/s7LTdVaFB+VXa8xsn1F/e7JfYIPCMIKBEQCXs5nW
 iXI+lGmftjS4OwXM1uikkl0qHoPcgl0A7DSAXpDV/lrluZA6CiSTEoUq92TyQaNVgo0s
 /OufFYqsDyXdkgxkQqXIZhR/gn2hKjRt+DQG8idlZbE7kgI2SFYEcROBNbcJLk6j3cEh
 /CqMY4GMl6dhkdmQzr7kTNo1+lrBjIxHTQtCRI7+McqZKg42LNfa1nLKL34X3jNcL9La
 xvhIiQEk9HnxRhb7Fy0CjnmAop0gorfnt2hoFTSxgquVxnuLd8s9nlZHgy7p6DjSKqr4
 E0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pd5As4/L2oTjSBZjWpPOMKqBaFJ2ADt2yHhVgPMSRMg=;
 b=qGwWiHd4u1g+Ux1onqrVAvtimbCSP+s4U3mJvdCbOzwopfVi6qp8Wi2lilhkvH7TX7
 gSgI+zWeISqBcC+atcz1xF9KidYOj27tKitfJIyWH50T37r9Ue9mVGPq4y0IH6Gd3rnO
 ZCTyxrC+8UNX87IWJjf/5UjnYHu1TGKFALnLA6NY0dVOVFkO/aREjnQD0Szq4RN4qpo6
 /jJKxrTr51AKD+wO5lblmstwHxgPeiTb7e9qaYyyNaK/bWyzsgqpZS4nz/z8qRWoixpS
 QUjj0RTTqKYYwvUca1fVbLOePuxRPt6huwyDkETdfsUh+Bu9h1BOkFkuAUNBTno0eU9M
 EdjA==
X-Gm-Message-State: APjAAAWme2+ErctTBN72BfkAhBSPsMFQVuFPjE7Gd5mkNSBgdTgTlbIo
 MjlnWjTz0mPxV+WZZoivjVPzf1Eb5NUlNaUmUDSx+w==
X-Google-Smtp-Source: APXvYqzbKMnFsR97qzwElnPnwovDkYV7Zzu3AUttOV+j0mhUDouh3J3SUypPbNHSVUfPQ6WO115YGcX7PLsQ24pG4y8=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr3174520oic.48.1581435769182; 
 Tue, 11 Feb 2020 07:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20200130112510.15154-1-eric.auger@redhat.com>
In-Reply-To: <20200130112510.15154-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 15:42:38 +0000
Message-ID: <CAFEAcA8iBvM2xguW2_6OFWDjPPEzEorief4F2aoh0Vitp466rQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v2 0/9] KVM: arm64: PMUv3 Event Counter
 Tests
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrew Jones <drjones@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Murray <andrew.murray@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, kvmarm@lists.cs.columbia.edu,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 at 11:25, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series implements tests exercising the PMUv3 event counters.
> It tests both the 32-bit and 64-bit versions. Overflow interrupts
> also are checked. Those tests only are written for arm64.
>
> It allowed to reveal some issues related to SW_INCR implementation
> (esp. related to 64-bit implementation), some problems related to
> 32-bit <-> 64-bit transitions and consistency of enabled states
> of odd and event counters (See [1]).
>
> Overflow interrupt testing relies of one patch from Andre
> ("arm: gic: Provide per-IRQ helper functions") to enable the
> PPI 23, coming from "arm: gic: Test SPIs and interrupt groups"
> (https://patchwork.kernel.org/cover/11234975/). Drew kindly
> provided "arm64: Provide read/write_sysreg_s".
>
> All PMU tests can be launched with:
> ./run_tests.sh -g pmu
> Tests also can be launched individually. For example:
> ./arm-run arm/pmu.flat -append 'chained-sw-incr'
>
> With KVM:
> - chain-promotion and chained-sw-incr are known to be failing.
>   [1] proposed a fix.
> - On TX2, I have some random failures due to MEM_ACCESS event
>   measured with a great disparity. This is not observed on
>   other machines I have access to.
> With TCG:
> - all new tests are skipped

I'm having a go at using this patchset to test the support
I'm adding for TCG for the v8.1 and v8.4 PMU extensions...

Q1: how can I get run_tests.sh to pass extra arguments to
QEMU ? The PMU events check will fail unless QEMU gets
the '-icount 8' to enable cycle-counting, but although
the underlying ./arm/run lets you add arbitrary extra
arguments to QEMU, run_tests.sh doesn't seem to. Trying to
pass them in via "QEMU=/path/to/qemu -icount 8" doesn't
work either.

Q2: do you know why arm/pmu.c:check_pmcr() insists that
PMCR.IMP is non-zero? The comment says "simple sanity check",
but architecturally a zero IMP field is permitted (meaning
"go look at MIDR_EL1 instead"). This causes TCG to fail this
test on '-cpu max', because in that case we set PMCR.IMP
to the same thing as MIDR_EL1.Implementer which is 0
("software use", since QEMU is software...)

thanks
-- PMM


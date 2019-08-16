Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9592AC3A59E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFF02133F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpSPBOla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFF02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hybpY-0007Tm-8b
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hybo0-0005yI-MA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hybnz-0000LQ-Ez
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hybnz-0000K5-6C
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:58:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so3976493wml.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0TNU1qcTPKOb8ebj7Oqy+tAPM4gs6EGYteC/gAYplT4=;
 b=RpSPBOlaO06ZNuwYCGTQ8rB2RaIOBhTaTNxoY1UY3UWOx1D9PGVCjjTY36mA2pfwid
 duINFA7JTRVIAr1Qhi8/dJgnQBnhcg/SlGXPn2q+2mPILoentEFRshlvoed2V4MtHSTp
 i8y7z0MNhUcPvkzAH3Lza+MN1tM0X2mmmaYPGwptLP8lEzz6SswQa4dmGxsnOLckV6pN
 O4/1qkcPDrLoeeUlgHk1ND7jprs53Wbq3Mu69O+KmxtnChr9ICChwHRHtvSHQtMBaArC
 EphmvNHmjffbye269A0a0jQxVTO9kQLQU88YJPWrAZZji1dkGORAUz9/xBFKCEftruGz
 tB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0TNU1qcTPKOb8ebj7Oqy+tAPM4gs6EGYteC/gAYplT4=;
 b=uFOKFoMg1pLgxUZEozVDaPALN89eA2rPzfhWXtmjUr1rZ64G7LdyF0kz1mkQKvPEIU
 Df5Iws7PRNoC0E1jdP681nGpVq0Pbgv3W1kxEb3Knwxv6Kzaz6DN5pixbjPCg0/kLqFp
 NrQxhAbvE3wEj0zI5NqCqqaTy89t35SNtKykGp+RBLIJnKL0CfKQ1+pkP37h8BVPImaZ
 2hV2dMr4PdQPOk8trc2Q9Ob0MO1YK3EzzOk1ELoCa9FDXcMZM+opZNxo/eprDd1atLaD
 ZrU0D649jAyvEt4iw+5DNuOxFG90w7gJGAZpu50BmzprD4Mj1PT0jcazSWkahF4TlEaQ
 rvGA==
X-Gm-Message-State: APjAAAWIBNM9PqnKdohUSkkO06zBt5s2gaRNGSCALGU6U15h1endV1jN
 CStyypYjg67POvTGiYPCk9T6cQ==
X-Google-Smtp-Source: APXvYqyLv6ebGydAN6U1vMK6N91/lHxq1RWw9zoHLEci2ot8tlohDW5oZvNVZZJbJnflPBbFselAQg==
X-Received: by 2002:a05:600c:204:: with SMTP id
 4mr7733968wmi.167.1565960285180; 
 Fri, 16 Aug 2019 05:58:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a19sm17594348wra.2.2019.08.16.05.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 05:58:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 13:58:00 +0100
Message-Id: <20190816125802.25877-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Take exceptions on ATS
 instructions
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The translation table walk for an ATS instruction can result in
various faults.  In general these are just reported back via the
PAR_EL1 fault status fields, but in some cases the architecture
requires that the fault is turned into an exception:
 * synchronous stage 2 faults of any kind during AT S1E0* and
   AT S1E1* instructions executed from NS EL1 fault to EL2 or EL3
 * synchronous external aborts are taken as Data Abort exceptions
    
(This is documented in the v8A Arm ARM DDI0487A.e D5.2.11 and G5.13.4.)

I noticed this by code inspection back last year sometime when
I was investigating a guest boot failure that turned out to be
due to an entirely different cause. I got about halfway through
trying to code up a fix before I realised it was irrelevant to
that bug. This patchset is just tidying up and completing that
work so it doesn't get lost.

Use of ATS insns in the cases where they might actually fault
is quite rare (obviously nobody sets up page tables where there's
no memory and they'll take external aborts, and even for the
"take a hyp trap for a stage 2 fault" case you need a setup
with a hypervisor and a guest that uses ATS insns, and Linux as
a guest doesn't use ATS at all. So my testing of this patchset
has been more "check it doesn't break things" rather than
actively finding and testing a use of the throw-an-exception path...

thanks
-- PMM

Peter Maydell (2):
  target/arm: Allow ARMCPRegInfo read/write functions to throw
    exceptions
  target/arm: Take exceptions on ATS instructions when needed

 target/arm/cpu.h           |   6 ++-
 target/arm/helper.c        | 107 +++++++++++++++++++++++++++++++------
 target/arm/translate-a64.c |   6 +++
 target/arm/translate.c     |   7 +++
 4 files changed, 110 insertions(+), 16 deletions(-)

-- 
2.20.1


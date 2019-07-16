Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25BC76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FA520880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrZv1WOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FA520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDVp-0003RL-I0
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44247)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hnDVP-000241-8V
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hnDVO-0004Sr-6e
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:47:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hnDVI-0004KS-Al; Mon, 15 Jul 2019 22:47:46 -0400
Received: by mail-pl1-x643.google.com with SMTP id m9so9250595pls.8;
 Mon, 15 Jul 2019 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R9fI9TcTPlG4PRFkh9dQV+Ey7ZpO4L4ZSYxLH3ruWZo=;
 b=hrZv1WOo1obkum2aDHaEjoUwfNr6y7owfx9licFZyKJyRntFI81m3yLEGyFWlbv2o+
 RxafNXiXMBWDW0DG+0Zy5DyV5Gm7keiZ3M3WxywRpK4mRZMfHhsO4P1+YxTJfDHkIpNg
 qNr/+Hyuc9RCXshQC5v3o6uKffFYl7RzaYmSeWTxPv5Y+PwGcOn4GUesPpHuDHLbUd7l
 Xt0+rOPENYGmwZ3Kf99Klg6dMWXRerXG4auJ2wgZwhQ09UEMONiS4zKvNmhEzG4KZEvI
 yUhNccCVC7l1cg7dccib9iO1VkzoIUAU5UyhNYA/SNTarbD2vxOfIxuCbthH0xTSm9BE
 9CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R9fI9TcTPlG4PRFkh9dQV+Ey7ZpO4L4ZSYxLH3ruWZo=;
 b=LA2CAsK/4092UtcUbCzo/An7GfH4v3+EfBnxOKRI7Kh0zQ3Q09Cdzp0J/ZR/uk+IUc
 R0+UBmFqwXGWeeGnel/0HjLu+2rsEtqCaMYp/za53La5JBTgLsj6PdoDpOs0N/cA8v5Z
 nikkIHOgpToxmsEpHvZv5hFSEtCoYjECbsMDUeVyML0DyPktclSo4xaPikJDNPakf+ek
 GslPEVcx0vWNYXqWf7V7ytd6F2oqCuUSKJWMT3tObRRxHvbkoKDreMjBkauJKIa8MvGn
 MwZegm6dehGqvF5uYuQyqumac+t95PMWeUD9YX1Kv69IJRX9YMMETEWrFwv+2vRtrW6e
 FzAw==
X-Gm-Message-State: APjAAAUnWuUioypiZsM+kIP85aNRUfwFpFCqczWHMrO0MJQbGapRTfK2
 bWpWChmPC02yscrHgnyY8BU=
X-Google-Smtp-Source: APXvYqxLVLsQE+EFToGXj2gKxWJjCEZpO7L1+0fbQT7Rwo3j3MmqoQOAwNbnw6PBYxiSQnPPjClccQ==
X-Received: by 2002:a17:902:2865:: with SMTP id
 e92mr31672745plb.264.1563245259512; 
 Mon, 15 Jul 2019 19:47:39 -0700 (PDT)
Received: from bobo.local0.net ([203.220.8.141])
 by smtp.gmail.com with ESMTPSA id x8sm16557837pfa.46.2019.07.15.19.47.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 19:47:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 16 Jul 2019 12:47:21 +1000
Message-Id: <20190716024726.17864-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v4 0/5] spapr: implement dispatch and suspend
 calls
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series follows on from the previous that added H_PROD and
H_CONFER, but I've now aimed to make it conform better to PAPR.

It's still not completely there (as explained in comments), but
it's better than before and actually better matches KVM that
does implement the prod bit and dispatch counter.

The first 3 patches implement these splpar hcalls for tcg, as
KVM implements its own H_PROD, H_CONFER, H_CEDE, and dispatch
management. These would be nice to merge as they make qemu
behave more like KVM and PowerVM with these calls.

The last 2 patches implement some parts of the guest suspend
APIs I've been using to test Linux modifications to the pseries
(and generic kernel) suspend/hibernate code, but they are not
really useful to a Linux guest (yet) due to other missing bits.

I have some Linux code I'll try to gradually upstream to work
around the missing bits and make this suspend on QEMU "work",
which is at least useful for testing without having PowerVM.

Thanks,
Nick

Nicholas Piggin (5):
  spapr: Implement dispatch counter and prod bit on tcg
  spapr: Implement H_PROD
  spapr: Implement H_CONFER
  spapr: Implement H_JOIN
  spapr: Implement ibm,suspend-me

 hw/ppc/spapr.c                  |  52 +++++++++++++
 hw/ppc/spapr_cpu_core.c         |   5 +-
 hw/ppc/spapr_hcall.c            | 126 ++++++++++++++++++++++++++++++--
 hw/ppc/spapr_rtas.c             |  32 ++++++++
 include/hw/ppc/spapr.h          |  14 +++-
 include/hw/ppc/spapr_cpu_core.h |   2 +
 target/ppc/cpu.h                |   2 +
 target/ppc/translate_init.inc.c |  25 +++++++
 8 files changed, 251 insertions(+), 7 deletions(-)

-- 
2.20.1



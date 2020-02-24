Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A197C11D31
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BDE20828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BDE20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6CIR-0005zp-8V
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j6CHh-00050V-9o
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j6CHg-0004bH-4A
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:52:24 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:56471 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j6CHf-0004Ep-Tz
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:52:24 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C0CA01A20BF;
 Mon, 24 Feb 2020 12:51:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7EC401A208A;
 Mon, 24 Feb 2020 12:51:18 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: KVM/MIPS
Date: Mon, 24 Feb 2020 12:50:57 +0100
Message-Id: <1582545058-31609-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: James Hogan <jhogan@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This patch is just a follow up to James' wish to be releived
of QEMU KVM/MIPS mainatainer duties. Many thanks to James for
his substantial contributions to QEMU for MIPS made over many
years, and not only in KVM area.

CC: James Hogan <jhogan@kernel.org>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Paolo Bonzini <pbonzini@redhat.com>

Aleksandar Markovic (1):
  MAINTAINERS: Reactivate MIPS KVM CPUs

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4



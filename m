Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BFAC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FE332083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE332083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDRP-0005kp-OQ
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:54:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1heDKl-00084e-PD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1heDJv-0005Qt-Tg
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:48 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1heDJv-0005PD-Px
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:47 -0400
Received: by mail-qt1-f172.google.com with SMTP id w17so5839922qto.10
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 23:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=Gply2wdUcSWE8WAK1WV00kWqs8yaDSEL8abnlXTmTTw=;
 b=moqdksNwk0I6gkv7/xoV9eObGqtgmWp3to21rN4MiJDJBEoozc2oSZFWy+a0zyS6t9
 TfgE99Py2qXwbQ+2iaZz8fi5yAbXse+lA6J6Ff/qTif5Jsq9Ft16d6PHHgy2VS+FKcxE
 iG+euDwAbeVedvpQMerDA9V9yJISlVtafdCGDk/VchwEO7VevJUeDFFk+GtY7oLfgz76
 in9056JRluccQC8PfhrxmYHveutu2lqeFW8Ex3c0B+7ifwxFXZkhbMfzDhG/GeTH2bDf
 976VEXLHC+Xs9o/U/yD88Q7F5mPdz4xdIEpzUcRuLdCT1p0Gk7UIgvXChMGK9YR2TSD9
 kNcA==
X-Gm-Message-State: APjAAAU9A1HeFyXTmGWOERmc4ZVmjwbJATCDylVOIZrVkkA34dlyV4Wo
 ecyOdgsigrMr9YFyf+dt5GQEGPlUxhg=
X-Google-Smtp-Source: APXvYqy25da1HdVe6Oy1VVayrkjX1PxyHjEoh5sjZFhFhwyZ6Wwt+TLX1gUG8ya/sxr7zoJedN9mFw==
X-Received: by 2002:ac8:3908:: with SMTP id s8mr114533081qtb.224.1561099606299; 
 Thu, 20 Jun 2019 23:46:46 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id 16sm827263qkl.100.2019.06.20.23.46.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 23:46:45 -0700 (PDT)
Date: Fri, 21 Jun 2019 02:46:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190621064615.20099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.172
Subject: [Qemu-devel] [PATCH 0/3] pcie: hotplug fixes
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

Red Hat QE reported several bugs around PCI Express hotplug.
Fixes/workarounds follow.

Michael S. Tsirkin (3):
  pcie: don't skip multi-mask events
  pcie: check that slt ctrl changed before deleting
  pcie: work around for racy guest init

 include/hw/pci/pcie.h              |  3 ++-
 hw/pci-bridge/pcie_root_port.c     |  5 ++++-
 hw/pci-bridge/xio3130_downstream.c |  5 ++++-
 hw/pci/pcie.c                      | 35 +++++++++++++++++++++++++++---
 4 files changed, 42 insertions(+), 6 deletions(-)

-- 
MST



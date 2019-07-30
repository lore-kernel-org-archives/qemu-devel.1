Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCFDC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5B220659
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 19:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5B220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsY4u-0006Mh-Vr
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 15:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59464)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hsY4O-0005iG-Bs
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hsY4N-0004Yx-Di
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:46:00 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hsY4N-0004Xx-9w
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 15:45:59 -0400
Received: by mail-ua1-f68.google.com with SMTP id a97so25939204uaa.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 12:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=w9It1JhT0Iw37Po+VznIjsIMxnGExXAdVZdaibPOhGg=;
 b=Ud+6WfmAV2O4tcJWtS+bVLSg/6zn17LTzDNwN628ymcbCMnMYZeboKFNmhqDJQkCvR
 gKju4Wn3DHL0a+kiWUJ8wE1nIl36Sq6aNdcckakNskZPApBB920NM4VPduPKyNXf/uPQ
 AiyNhjoM+wCGwoGGWkK8x8roy8JSdDWzzpc8k+pB2QuI+Lcu4GDea5FW69NRPSgiVLWt
 8knCFjNi4IgOjh+gu8tB24vKRKqOn+oUwY4J5KLMbK2b1f7Ahb8wr6M+uLrNiA1h8tnI
 v5MVuan+uxNCTIiBvrEPrK8/z+RDWZAZuziSRW+yf+She96KOxw4Osw+/oyRM7vJ7OL4
 MpcQ==
X-Gm-Message-State: APjAAAUNS5JFikN4XKjehVzKo6vJj6D0PxHLvDPdiZBdJO1+voprxfAW
 HIuGYw0xOzxBNov8LVkfz/cVvYuXDE8GiQ==
X-Google-Smtp-Source: APXvYqzhJ41YzYbtmLXdPlmlm+k1f7/Vc4Z+qV4Z1sreQz6CkMIPDcWr/gaiJ6rqskrSVwyUuAAkOA==
X-Received: by 2002:ab0:2756:: with SMTP id c22mr20069462uap.22.1564515958115; 
 Tue, 30 Jul 2019 12:45:58 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 u19sm25389926uau.7.2019.07.30.12.45.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 12:45:57 -0700 (PDT)
Date: Tue, 30 Jul 2019 15:45:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190730194519.3689-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.68
Subject: [Qemu-devel] [PULL 0/2] pci: bugfix
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 22235bb609c18547cf6b215bad1f9d2ec56ad371:

  pc-dimm: fix crash when invalid slot number is used (2019-07-29 16:57:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to c8557f1b4873549fc231496f00003a9e5389c8dd:

  pcie_root_port: Disable ACS on older machines (2019-07-30 12:07:07 -0400)

----------------------------------------------------------------
pci: bugfix

A last minute fix to cross-version migration.
Better late than never.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dr. David Alan Gilbert (2):
      pcie_root_port: Allow ACS to be disabled
      pcie_root_port: Disable ACS on older machines

 include/hw/pci/pcie_port.h     | 2 ++
 hw/core/machine.c              | 1 +
 hw/pci-bridge/pcie_root_port.c | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)



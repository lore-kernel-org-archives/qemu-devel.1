Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E90C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0767424670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc2dQZfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0767424670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHid-0007mU-6z
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idHMH-0008Ef-Ja
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idHM9-0006ly-Ua
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idHM9-0006j0-Ic
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ymEd2uuOE/GZesgvaj23CCxd+WVmt6BCe9PlJBBjEIw=;
 b=Sc2dQZfaNQwo6sMEp8dHY0x2cIqfzTBP14NEmXMA83u9DivQ6f4z4LjtAKqFBJ88gSqLth
 neYQXVTJPM8PCzpeL0SGCt/yd5gzq50YUldK9YDxDOpjSOPc/DqoQhDbvJUjqnDq6qtzrG
 zj8wGMoQNt5DfLHTHTL27y2a0vHmup4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Z7PEmUhZPFGSp55N2Mg66g-1; Fri, 06 Dec 2019 12:25:26 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA26F1005502;
 Fri,  6 Dec 2019 17:25:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-212.brq.redhat.com [10.40.204.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2018C5C1C3;
 Fri,  6 Dec 2019 17:25:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 0/6] hw/pci-host: Add Kconfig selector for IGD PCIe
 pass-through
Date: Fri,  6 Dec 2019 18:25:08 +0100
Message-Id: <20191206172514.21268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Z7PEmUhZPFGSp55N2Mg66g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a kconfig selector to allow builds without Intel
Integrated Graphics Device GPU PCIe passthrough.

We keep the default as enabled.

v2:
- do not mix with vfio code (Alex)
- extract to different file to avoid #ifdef (Thomas)

Philippe Mathieu-Daud=C3=A9 (6):
  hw/pci-host/i440fx: Correct the header description
  hw/pci-host/i440fx: Extract PCII440FXState to "hw/pci-host/i440fx.h"
  hw/pci-host/i440fx: Use size_t to iterate over ARRAY_SIZE()
  hw/pci-host/i440fx: Use definitions instead of magic values
  hw/pci-host/i440fx: Extract the IGD Passthrough Host Bridge device
  hw/pci-host: Add Kconfig entry to select the IGD Passthrough Host Bridge

 include/hw/pci-host/i440fx.h |  19 +++++-
 hw/pci-host/i440fx.c         | 105 +-----------------------------
 hw/pci-host/igd_pt.c         | 120 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |   1 +
 hw/pci-host/Kconfig          |   4 ++
 hw/pci-host/Makefile.objs    |   1 +
 6 files changed, 144 insertions(+), 106 deletions(-)
 create mode 100644 hw/pci-host/igd_pt.c

--=20
2.21.0



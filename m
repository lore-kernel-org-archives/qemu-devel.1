Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EC2C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EB524680
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKMTpbUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EB524680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFhH-0000O9-5l
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieFgM-0007tH-Al
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieFgK-0000TI-Oc
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25401
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieFgK-0000T8-L8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575885019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0kZGDM6Dv+xPJxfZvPzJi9z3blegCflTkzGW0b89qeI=;
 b=DKMTpbUrH8JpqNxXgYOqsq6e3v1yANmxi7twq9dMS1IQQx0xx3dcT1pKM0RUJOcvJvjd3e
 9+OartcjalS+aOUgtYNDCmTkQYxEz04r4Zd9M9ixc92bxUPItknujkZkYGi77kbx3Db8iB
 v5oosN6xzsLD8xGehS5JkRWDXM9BraY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-P2eqbdoEPUqFaRectyj5cw-1; Mon, 09 Dec 2019 04:50:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 522401005512;
 Mon,  9 Dec 2019 09:50:17 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-142.brq.redhat.com [10.40.205.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBF9B52FD;
 Mon,  9 Dec 2019 09:50:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 0/6] hw/pci-host: Add Kconfig selector for IGD PCIe
 pass-through
Date: Mon,  9 Dec 2019 10:49:56 +0100
Message-Id: <20191209095002.32194-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: P2eqbdoEPUqFaRectyj5cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a kconfig selector to allow builds without Intel
Integrated Graphics Device GPU PCIe passthrough.

This device is enabled by default on the Xen build.

v3:
- Make it Xen specific

v2:
- do not mix with vfio code (Alex)
- extract to different file to avoid #ifdef (Thomas)

Philippe Mathieu-Daud=C3=A9 (6):
  hw/pci-host/i440fx: Correct the header description
  hw/pci-host/i440fx: Extract PCII440FXState to "hw/pci-host/i440fx.h"
  hw/pci-host/i440fx: Use size_t to iterate over ARRAY_SIZE()
  hw/pci-host/i440fx: Use definitions instead of magic values
  hw/pci-host/i440fx: Extract the IGD passthrough host bridge device
  hw/pci-host: Add Kconfig entry to select the IGD Passthrough Host
    Bridge

 include/hw/pci-host/i440fx.h |  19 +++++-
 hw/pci-host/i440fx.c         | 105 +-----------------------------
 hw/pci-host/xen_igd_pt.c     | 120 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |   1 +
 hw/pci-host/Kconfig          |   5 ++
 hw/pci-host/Makefile.objs    |   1 +
 6 files changed, 145 insertions(+), 106 deletions(-)
 create mode 100644 hw/pci-host/xen_igd_pt.c

--=20
2.21.0



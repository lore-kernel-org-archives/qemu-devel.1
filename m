Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48755C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A44F2467B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 00:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWciwdVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A44F2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igeA7-0007cX-V9
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 19:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ige90-0006Ie-E2
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ige8z-000665-GK
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ige8z-00061k-DC
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 19:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576455708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7IR6ewlBcwV4md0cSOov7RyetLSLGaIi1xQGhpC/i/s=;
 b=CWciwdVL8RnzoxfUcSowt7XQ9j6/bg2auueZTnDYMdm8dWp3tzFes+A+BB+f658LFulEsj
 NZ4gdYsyI34Ge3plI4IBMeOv7UC9ITVkgwlBFWq4xq9wQCCvw8oYzkDHDXSgibrKswBubX
 TE6aSoDZHzk4V8/lSfucZ1K1gF+xv2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ROBRgtlGOMazK0_j3QOjYQ-1; Sun, 15 Dec 2019 19:21:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88BD01005502;
 Mon, 16 Dec 2019 00:21:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCC861001901;
 Mon, 16 Dec 2019 00:21:37 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/pci/pci_host: Small cleanups
Date: Mon, 16 Dec 2019 01:21:32 +0100
Message-Id: <20191216002134.18279-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ROBRgtlGOMazK0_j3QOjYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Use unsigned 'size' argument
- Remove unuseful DPRINTF()

Philippe Mathieu-Daud=C3=A9 (2):
  hw/pci/pci_host: Remove redundant PCI_DPRINTF()
  hw/pci/pci_host: Let pci_data_[read/write] use unsigned 'size'
    argument

 include/hw/pci/pci_host.h |  4 ++--
 hw/pci/pci_host.c         | 25 +++++++------------------
 2 files changed, 9 insertions(+), 20 deletions(-)

--=20
2.21.0



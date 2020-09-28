Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E23C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6E820774
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpclP505"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6E820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt7a-0003vu-Ea
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMt1S-0004w1-25
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41651)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMt1Q-0002W5-5k
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:16:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nPBvf8cnPQnyLQ5LMRfJYGRdGAZqON273lEcntug720=;
 b=UpclP505oXqWCEkuZdEQY+nTQ67v6UFEuK+gYaNxRahqK/3AO2/EuQ6gzdQjT8tddMMPiY
 yoNyXxh5CYT3zNUs3CvpBnEYCt+JTMjw2ARRpXJ5+U283N8OKPFVR3xaVDHpmMpj/OOXA3
 CT+nOZNMkzCRiI3qenAa+uPo1gW3jTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-MtMPWPBPMISrchc5_uqe3w-1; Mon, 28 Sep 2020 09:16:49 -0400
X-MC-Unique: MtMPWPBPMISrchc5_uqe3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B53FB10219ED
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 13:16:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68EE260CD0;
 Mon, 28 Sep 2020 13:16:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4F55140827; Mon, 28 Sep 2020 15:16:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Usb 20200928 patches
Date: Mon, 28 Sep 2020 15:16:33 +0200
Message-Id: <20200928131638.9486-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 8d16e72f2d4df2c9e631393adf1669a1da7efe8a=
:=0D
=0D
  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-202009=
25a' into staging (2020-09-25 14:46:18 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/usb-20200928-pull-request=0D
=0D
for you to fetch changes up to 5c43b603a2e3f77f41e0cf339e72bee2077bfe61:=0D
=0D
  hw/usb: Use lock guard macros (2020-09-28 13:13:58 +0200)=0D
=0D
----------------------------------------------------------------=0D
usb: xhci sysbus support.=0D
usb: use lock guards.=0D
=0D
----------------------------------------------------------------=0D
=0D
Amey Narkhede (1):=0D
  hw/usb: Use lock guard macros=0D
=0D
Sai Pavan Boddu (4):=0D
  usb/hcd-xhci: Make dma read/writes hooks pci free=0D
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c=0D
  usb/hcd-xhci: Split pci wrapper for xhci base model=0D
  usb: hcd-xhci-sysbus: Attach xhci to sysbus device=0D
=0D
 hw/usb/hcd-xhci-pci.h       |  44 ++++++=0D
 hw/usb/hcd-xhci-sysbus.h    |  32 +++++=0D
 hw/usb/hcd-xhci.h           |  21 ++-=0D
 hw/usb/ccid-card-emulated.c |  54 +++----=0D
 hw/usb/hcd-xhci-nec.c       |  18 +--=0D
 hw/usb/hcd-xhci-pci.c       | 261 ++++++++++++++++++++++++++++++++++=0D
 hw/usb/hcd-xhci-sysbus.c    | 109 +++++++++++++++=0D
 hw/usb/hcd-xhci.c           | 271 ++++++++----------------------------=0D
 hw/usb/Kconfig              |  11 ++=0D
 hw/usb/meson.build          |   2 +=0D
 10 files changed, 564 insertions(+), 259 deletions(-)=0D
 create mode 100644 hw/usb/hcd-xhci-pci.h=0D
 create mode 100644 hw/usb/hcd-xhci-sysbus.h=0D
 create mode 100644 hw/usb/hcd-xhci-pci.c=0D
 create mode 100644 hw/usb/hcd-xhci-sysbus.c=0D
=0D
--=20=0D
2.27.0=0D
=0D



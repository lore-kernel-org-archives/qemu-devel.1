Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47719C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6711A20575
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb/zWyDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6711A20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUNn-0006jz-3n
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUUM7-00058D-8b
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUUM5-0006if-IV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603110814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zXJhGJPiiazxPcnCf2J4mvJpwMuZqWCK4NitiT/p51A=;
 b=Yb/zWyDThTAgshJ6dt1YnKVYyUAMa9hERS2C008huSnd0U+HL8P6yUvMUWKIjlH5K4kYOl
 xdbvP0LSJrJx92hEYtmY59S3v8HIuhb7nNeOc1UKfh6w+vODV/Zg/E7Ami9maeB6OkqIE4
 baICiST3cfcSBwUZT6W3/yTD0+4mQhk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-cxaH3_wYPQS1U7OD4qHOLA-1; Mon, 19 Oct 2020 08:33:32 -0400
X-MC-Unique: cxaH3_wYPQS1U7OD4qHOLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938BE64087
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:33:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D42BC6EF59;
 Mon, 19 Oct 2020 12:33:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D0BD416E18; Mon, 19 Oct 2020 14:33:26 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Usb 20201019 patches
Date: Mon, 19 Oct 2020 14:33:23 +0200
Message-Id: <20201019123326.9973-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit e12ce85b2c79d83a340953291912875c30b3af06=
:=0D
=0D
  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request=
' into staging (2020-10-16 22:46:28 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/usb-20201019-pull-request=0D
=0D
for you to fetch changes up to bea2a9e3e00b275dc40cfa09c760c715b8753e03:=0D
=0D
  hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet() (2020-10-19 0=
9:17:21 +0200)=0D
=0D
----------------------------------------------------------------=0D
usb: fixes for dwc2 + ehci.=0D
=0D
----------------------------------------------------------------=0D
=0D
Anthony PERARD (1):=0D
  usb/hcd-ehci: Fix error handling on missing device for iTD=0D
=0D
Mauro Matteo Cascella (1):=0D
  hw/usb/hcd-dwc2: fix divide-by-zero in dwc2_handle_packet()=0D
=0D
Paul Zimmerman (1):=0D
  usb: hcd-dwc2: change assert()s to qemu_log_mask(LOG_GUEST_ERROR...)=0D
=0D
 hw/usb/hcd-dwc2.c | 106 +++++++++++++++++++++++++++++++++++++---------=0D
 hw/usb/hcd-ehci.c |  35 +++++++--------=0D
 2 files changed, 105 insertions(+), 36 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D



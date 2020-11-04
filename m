Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C908620867
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkfIp0nB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C908620867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaHiL-00021l-JS
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 07:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfR-0007X7-4a
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaHfO-0007og-Jd
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 07:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604492009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=It4k9Fd4kCLqV7E+ebxXN+L3ctWv9zQxh/2anbBgipU=;
 b=ZkfIp0nBTuouYhbQx4mv5XUgpl7Wj6c+drPe7hTRyysM9fmHUJv+M3nzm8Kbc+x8A5gwa7
 TETCYI3FvPmq7naQQu4EXr5lxsDEyhU0+QftpY/OTZynuQmCpBsFIq9MGnImLUVBRg7I+N
 dgpn+nSygWUN47d+sLzDtiR1jsbtAUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-HCkcbnu1MM2ZAVO2AAx1Tw-1; Wed, 04 Nov 2020 07:13:27 -0500
X-MC-Unique: HCkcbnu1MM2ZAVO2AAx1Tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F8E2804751;
 Wed,  4 Nov 2020 12:13:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4078976640;
 Wed,  4 Nov 2020 12:13:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4202E16E31; Wed,  4 Nov 2020 13:13:21 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Usb 20201104 patches
Date: Wed,  4 Nov 2020 13:13:13 +0100
Message-Id: <20201104121321.7772-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a=
:=0D
=0D
  Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/usb-20201104-pull-request=0D
=0D
for you to fetch changes up to 963a7bed570ce12604a48755c78244a2b6e179b3:=0D
=0D
  dev-serial: store flow control and xon/xoff characters (2020-11-04 07:22:=
37 +0100)=0D
=0D
----------------------------------------------------------------=0D
usb: bugfixes for usb-serial=0D
=0D
----------------------------------------------------------------=0D
=0D
Mark Cave-Ayland (8):=0D
  dev-serial: style changes to improve readability and checkpatch fixes=0D
  dev-serial: use USB_SERIAL QOM macro for USBSerialState assignments=0D
  dev-serial: convert from DPRINTF to trace-events=0D
  dev-serial: add trace-events for baud rate and data parameters=0D
  dev-serial: replace DeviceOutVendor/DeviceInVendor with equivalent=0D
    macros from usb.h=0D
  dev-serial: add always-plugged property to ensure USB device is always=0D
    attached=0D
  dev-serial: add support for setting data_bits in QEMUSerialSetParams=0D
  dev-serial: store flow control and xon/xoff characters=0D
=0D
 hw/usb/dev-serial.c | 334 +++++++++++++++++++++++++++-----------------=0D
 hw/usb/trace-events |  13 ++=0D
 2 files changed, 216 insertions(+), 131 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D



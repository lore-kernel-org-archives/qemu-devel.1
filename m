Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38509C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A6421850
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEEV0y92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A6421850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXM2F-0001mI-9j
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXM0U-0000CM-5o
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXM0T-0003ZU-64
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXM0T-0003Yq-26
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574241036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vBIdHboBy7XLGKhKEx3+s1cWdLSAHcdjyZy2BY7Fk34=;
 b=VEEV0y92mjKJEgWwHldUeBraA9+qBHN311oAGESqHxtXHM+8/c+EghOQ9qLo/sNtfVFxLn
 Xb5LTBwj5/fFjOpb3FRlWSBSZ9tZmVs3+yp1BlxbM3Q7z6BtbT1bvjmDr342tPkXM8c//3
 9tuZSElVYY8Zg+fvSIWo/eQAQzQYT7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-E4UftHt-OXCycQAORiqjUg-1; Wed, 20 Nov 2019 04:10:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3501A107ACC4;
 Wed, 20 Nov 2019 09:10:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A37BE60BAB;
 Wed, 20 Nov 2019 09:10:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH for-5.0 0/4] Remove the deprecated bluetooth subsystem
Date: Wed, 20 Nov 2019 10:10:10 +0100
Message-Id: <20191120091014.16883-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: E4UftHt-OXCycQAORiqjUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: libvir-list@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series removes the bitrotten bluetooth subsystem. See
the patch description of the third patch for the rationale.

Thomas Huth (4):
  hw/arm/nseries: Replace the bluetooth chardev with a "null" chardev
  hw/usb: Remove the USB bluetooth dongle device
  Remove the core bluetooth code
  Remove libbluetooth / bluez from the CI tests

 .gitlab-ci.yml                             |    2 +-
 Makefile.objs                              |    2 -
 bt-host.c                                  |  198 --
 bt-vhci.c                                  |  167 --
 configure                                  |   31 -
 hw/Kconfig                                 |    1 -
 hw/Makefile.objs                           |    1 -
 hw/arm/nseries.c                           |   16 +-
 hw/bt/Kconfig                              |    2 -
 hw/bt/Makefile.objs                        |    3 -
 hw/bt/core.c                               |  143 --
 hw/bt/hci-csr.c                            |  512 -----
 hw/bt/hci.c                                | 2263 --------------------
 hw/bt/hid.c                                |  553 -----
 hw/bt/l2cap.c                              | 1367 ------------
 hw/bt/sdp.c                                |  989 ---------
 hw/usb/Kconfig                             |    5 -
 hw/usb/Makefile.objs                       |    1 -
 hw/usb/dev-bluetooth.c                     |  581 -----
 include/hw/bt.h                            | 2177 -------------------
 include/sysemu/bt.h                        |   20 -
 qemu-deprecated.texi                       |    7 -
 qemu-doc.texi                              |   17 -
 qemu-options.hx                            |   79 -
 tests/docker/dockerfiles/fedora.docker     |    1 -
 tests/docker/dockerfiles/ubuntu.docker     |    1 -
 tests/docker/dockerfiles/ubuntu1804.docker |    1 -
 vl.c                                       |  136 --
 28 files changed, 8 insertions(+), 9268 deletions(-)
 delete mode 100644 bt-host.c
 delete mode 100644 bt-vhci.c
 delete mode 100644 hw/bt/Kconfig
 delete mode 100644 hw/bt/Makefile.objs
 delete mode 100644 hw/bt/core.c
 delete mode 100644 hw/bt/hci-csr.c
 delete mode 100644 hw/bt/hci.c
 delete mode 100644 hw/bt/hid.c
 delete mode 100644 hw/bt/l2cap.c
 delete mode 100644 hw/bt/sdp.c
 delete mode 100644 hw/usb/dev-bluetooth.c
 delete mode 100644 include/hw/bt.h
 delete mode 100644 include/sysemu/bt.h

--=20
2.23.0



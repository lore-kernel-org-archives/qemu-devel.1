Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42FAC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A8620679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A8620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxT9z-0007pc-P4
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hxT8z-0006FB-6X
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hxT8y-00054c-6b
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48924)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hxT8w-000539-04; Tue, 13 Aug 2019 05:31:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFF0B81F10;
 Tue, 13 Aug 2019 09:31:00 +0000 (UTC)
Received: from thuth.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B78F82AF4D;
 Tue, 13 Aug 2019 09:30:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 11:30:41 +0200
Message-Id: <20190813093047.27948-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 13 Aug 2019 09:31:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] First batch of global_qtest-removement
 patches for QEMU 4.2
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Amit Shah <amit@kernel.org>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While global_qtest and its wrapper functions work fine for tests that only
run one instance of QEMU, using the global_qtest variable in our qtests is
very problematic for tests that use multiple test states (e.g. migration
tests). Thus the core libqtest and libqos library functions should not
depend on global_qtest or functions that rely on this variable.

This patch series gets rid of these dependencies in most of the libqtest
and libqos code.

Thomas Huth (6):
  tests/libqos: Make generic virtio code independent from global_qtest
  tests/libqos: Make virtio-pci code independent from global_qtest
  tests/libqtest: Remove unused function hmp()
  tests/libqtest: Clean up qtest_cb_for_every_machine() wrt global_qtest
  tests/libqtest: Make qtest_qmp_device_add/del independent from
    global_qtest
  tests/libqtest: Make qmp_assert_success() independent from
    global_qtest

 tests/cpu-plug-test.c      |  15 ++--
 tests/e1000e-test.c        |   2 +-
 tests/ivshmem-test.c       |   2 +-
 tests/libqos/usb.c         |   6 +-
 tests/libqos/usb.h         |   2 +-
 tests/libqos/virtio-pci.c  |   8 +-
 tests/libqos/virtio.c      |  74 +++++++++---------
 tests/libqos/virtio.h      |  27 ++++---
 tests/libqtest.c           |  37 ++++-----
 tests/libqtest.h           |  24 +++---
 tests/usb-hcd-ohci-test.c  |   2 +-
 tests/usb-hcd-uhci-test.c  |   8 +-
 tests/usb-hcd-xhci-test.c  |  22 +++---
 tests/virtio-9p-test.c     |  16 ++--
 tests/virtio-blk-test.c    | 153 +++++++++++++++++++------------------
 tests/virtio-ccw-test.c    |  18 +++--
 tests/virtio-net-test.c    |  35 +++++----
 tests/virtio-rng-test.c    |   2 +-
 tests/virtio-scsi-test.c   |  22 +++---
 tests/virtio-serial-test.c |   4 +-
 20 files changed, 251 insertions(+), 228 deletions(-)

-- 
2.18.1



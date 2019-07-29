Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38CCC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA08216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 16:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA08216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs8Wv-0003Oj-O7
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 12:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hs8WN-0002bF-7G
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hs8WM-0005N4-AG
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:29:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hs8WM-0005Mp-4q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 12:29:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53D50308338F
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 16:29:09 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-222.ams2.redhat.com
 [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFE3A60856;
 Mon, 29 Jul 2019 16:29:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, berrange@redhat.com, cohuck@redhat.com,
 mst@redhat.com
Date: Mon, 29 Jul 2019 17:29:01 +0100
Message-Id: <20190729162903.4489-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 29 Jul 2019 16:29:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [For 4.1 PATCH v2 0/2] Reversions to fix PCIe in virtio
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Revert a couple of patches that break PCIe capabilities in virtio
devices. The 'optional' revert is just reverted to make the main
reversion trivial.

Symptom:
  Loss of PCIe capabilities in virtio devices hung off PCIe bridges

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


Dr. David Alan Gilbert (2):
  Revert "Revert "globals: Allow global properties to be optional""
  Revert "hw: report invalid disable-legacy|modern usage for
    virtio-1-only devs"

 hw/core/machine.c             | 23 +++--------------------
 hw/display/virtio-gpu-pci.c   |  4 +---
 hw/display/virtio-vga.c       |  4 +---
 hw/virtio/virtio-crypto-pci.c |  4 +---
 hw/virtio/virtio-input-pci.c  |  4 +---
 hw/virtio/virtio-pci.c        | 26 ++++++++++----------------
 hw/virtio/virtio-pci.h        | 31 ++++++-------------------------
 include/hw/qdev-core.h        |  3 +++
 qom/object.c                  |  3 +++
 9 files changed, 29 insertions(+), 73 deletions(-)

--=20
2.21.0



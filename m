Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D5CC742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D093B2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D093B2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47447 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqrs-0000PB-P5
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 04:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan@weilnetz.de>) id 1hlqrh-0008QM-Jc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan@weilnetz.de>) id 1hlqrg-0007sn-Gv
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:25:13 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:36874
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1hlqrg-0007pr-8d
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 04:25:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id B6522DB8615;
 Fri, 12 Jul 2019 10:25:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id xNhOEextHkoJ; Fri, 12 Jul 2019 10:25:08 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id E330DDB8602;
 Fri, 12 Jul 2019 10:25:08 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id AEC574606D3; Fri, 12 Jul 2019 10:25:08 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 10:19:10 +0200
Message-Id: <20190712081910.29085-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] libvhost-user: Add missing GCC_FMT_ATTR and
 fix three format errors
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 contrib/libvhost-user/libvhost-user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 4b36e35a82..59b3202979 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -142,7 +142,7 @@ vu_request_to_string(unsigned int req)
     }
 }
=20
-static void
+static void GCC_FMT_ATTR(2, 3)
 vu_panic(VuDev *dev, const char *msg, ...)
 {
     char *buf =3D NULL;
@@ -661,7 +661,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
=20
         if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
             vu_panic(dev, "%s: Failed to userfault region %d "
-                          "@%p + size:%zx offset: %zx: (ufd=3D%d)%s\n",
+                          "@%" PRIx64 " + size:%zx offset: %zx: (ufd=3D%=
d)%s\n",
                      __func__, i,
                      dev_region->mmap_addr,
                      dev_region->size, dev_region->mmap_offset,
@@ -1753,7 +1753,7 @@ virtqueue_get_head(VuDev *dev, VuVirtq *vq,
=20
     /* If their number is silly, that's a fatal mistake. */
     if (*head >=3D vq->vring.num) {
-        vu_panic(dev, "Guest says index %u is available", head);
+        vu_panic(dev, "Guest says index %u is available", idx);
         return false;
     }
=20
@@ -1812,7 +1812,7 @@ virtqueue_read_next_desc(VuDev *dev, struct vring_d=
esc *desc,
     smp_wmb();
=20
     if (*next >=3D max) {
-        vu_panic(dev, "Desc next is %u", next);
+        vu_panic(dev, "Desc next is %u", *next);
         return VIRTQUEUE_READ_DESC_ERROR;
     }
=20
--=20
2.20.1



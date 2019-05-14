Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE3C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF350208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF350208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQV0S-0003FI-4g
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:50:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hQUsZ-0005ni-MK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hQUsY-0001AE-Mf
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:41:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hQUsW-00015e-Kj
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:41:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C42C0307D942
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 10:41:46 +0000 (UTC)
Received: from localhost (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE1B41001DC2;
	Tue, 14 May 2019 10:41:38 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:41:24 +0200
Message-Id: <20190514104126.6294-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190514104126.6294-1-marcandre.lureau@redhat.com>
References: <20190514104126.6294-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 14 May 2019 10:41:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 1/3] libvhost-user: fix cast warnings on 32
 bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes warnings:
 warning: cast to pointer from integer of different size
 [-Wint-to-pointer-cast]

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 74d42177c5..40443a3daa 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -621,7 +621,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
          * data that's already arrived in the shared process.
          * TODO: How to do hugepage
          */
-        ret =3D madvise((void *)dev_region->mmap_addr,
+        ret =3D madvise((void *)(uintptr_t)dev_region->mmap_addr,
                       dev_region->size + dev_region->mmap_offset,
                       MADV_DONTNEED);
         if (ret) {
@@ -633,7 +633,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
          * in neighbouring pages.
          * TODO: Turn this backon later.
          */
-        ret =3D madvise((void *)dev_region->mmap_addr,
+        ret =3D madvise((void *)(uintptr_t)dev_region->mmap_addr,
                       dev_region->size + dev_region->mmap_offset,
                       MADV_NOHUGEPAGE);
         if (ret) {
@@ -666,7 +666,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserM=
sg *vmsg)
         DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
                 __func__, i, reg_struct.range.start, reg_struct.range.le=
n);
         /* Now it's registered we can let the client at it */
-        if (mprotect((void *)dev_region->mmap_addr,
+        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
                      dev_region->size + dev_region->mmap_offset,
                      PROT_READ | PROT_WRITE)) {
             vu_panic(dev, "failed to mprotect region %d for postcopy (%s=
)",
--=20
2.21.0.777.g83232e3864



Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D3C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8882204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8882204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38353 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTMct-0001Vq-1t
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:29:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTMbP-0000fg-Db
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hTMat-00058n-AF
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:27:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hTMat-000582-3N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:27:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 449913086228
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 08:27:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6F69517574;
	Wed, 22 May 2019 08:27:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 3241CA205; Wed, 22 May 2019 10:27:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 10:27:16 +0200
Message-Id: <20190522082717.9354-3-kraxel@redhat.com>
In-Reply-To: <20190522082717.9354-1-kraxel@redhat.com>
References: <20190522082717.9354-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 22 May 2019 08:27:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/3] libvhost-user: fix -Werror=format= on ppc64
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

That should fix the following warning:

/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c: In function
=E2=80=98vu_set_mem_table_exec_postcopy=E2=80=99:
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long=
 unsigned int=E2=80=99, but
argument 5 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
         DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
         ^
/home/pm215/qemu/contrib/libvhost-user/libvhost-user.c:666:9: error:
format =E2=80=98%llx=E2=80=99 expects argument of type =E2=80=98long long=
 unsigned int=E2=80=99, but
argument 6 has type =E2=80=98__u64=E2=80=99 [-Werror=3Dformat=3D]
cc1: all warnings being treated as errors

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190514104126.6294-3-marcandre.lureau@redhat.com

{ kraxel: s/PRIu64/PRIx64/ ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index 0ffa0f45c890..c56f2dfe44a4 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -663,8 +663,10 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUser=
Msg *vmsg)
                      __func__, i);
             return false;
         }
-        DPRINT("%s: region %d: Registered userfault for %llx + %llx\n",
-                __func__, i, reg_struct.range.start, reg_struct.range.le=
n);
+        DPRINT("%s: region %d: Registered userfault for %"
+               PRIx64 " + %" PRIx64 "\n", __func__, i,
+               (uint64_t)reg_struct.range.start,
+               (uint64_t)reg_struct.range.len);
         /* Now it's registered we can let the client at it */
         if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
                      dev_region->size + dev_region->mmap_offset,
--=20
2.18.1



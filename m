Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B5C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCAF206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCAF206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpfi-0000Gn-8I
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:30:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hTpYg-0002XC-T7
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hTpYg-0006Ni-20
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:23:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hTpYb-0006KI-TG; Thu, 23 May 2019 11:23:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38C3C981D3;
	Thu, 23 May 2019 15:23:01 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-222.ams2.redhat.com
	[10.36.117.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BE8417CDD;
	Thu, 23 May 2019 15:22:58 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 17:22:50 +0200
Message-Id: <20190523152250.106717-4-sgarzare@redhat.com>
In-Reply-To: <20190523152250.106717-1-sgarzare@redhat.com>
References: <20190523152250.106717-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 23 May 2019 15:23:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] block/gluster: update .help of
 BLOCK_OPT_PREALLOC option
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Show 'falloc' and 'full' among the allowed values of
'preallocation' option, only when they are supported
('falloc' is support if defined CONFIG_GLUSTERFS_FALLOCATE,
'full' is support if defined CONFIG_GLUSTERFS_ZEROFILL)

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/gluster.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/gluster.c b/block/gluster.c
index e664ca4462..682fe49912 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -97,7 +97,14 @@ static QemuOptsList qemu_gluster_create_opts =3D {
         {
             .name =3D BLOCK_OPT_PREALLOC,
             .type =3D QEMU_OPT_STRING,
-            .help =3D "Preallocation mode (allowed values: off, full)"
+            .help =3D "Preallocation mode (allowed values: off"
+#ifdef CONFIG_GLUSTERFS_FALLOCATE
+                    ", falloc"
+#endif
+#ifdef CONFIG_GLUSTERFS_ZEROFILL
+                    ", full"
+#endif
+                    ")"
         },
         {
             .name =3D GLUSTER_OPT_DEBUG,
--=20
2.20.1



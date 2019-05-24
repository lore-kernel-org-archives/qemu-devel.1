Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F9CC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 08:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6BC2133D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 08:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6BC2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU5Av-0007LZ-5R
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 04:03:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU56n-00046u-Q4
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hU56m-000472-Mg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:59:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>)
	id 1hU56j-0003u8-Tf; Fri, 24 May 2019 03:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F8563086275;
	Fri, 24 May 2019 07:58:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B85191001E79;
	Fri, 24 May 2019 07:58:56 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 09:58:46 +0200
Message-Id: <20190524075848.23781-2-sgarzare@redhat.com>
In-Reply-To: <20190524075848.23781-1-sgarzare@redhat.com>
References: <20190524075848.23781-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 24 May 2019 07:59:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/3] qapi/block-core: update documentation
 of preallocation parameter
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

Add default and available values in the documentation block of
each block device or protocol that supports the 'preallocation'
parameter during the image creation.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..e2f7e2b89f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4103,7 +4103,10 @@
 #
 # @filename         Filename for the new image file
 # @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image (default: off)
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off,
+#                   falloc (if defined CONFIG_POSIX_FALLOCATE),
+#                   full (if defined CONFIG_POSIX))
 # @nocow            Turn off copy-on-write (valid only on btrfs; default=
: off)
 #
 # Since: 2.12
@@ -4121,7 +4124,10 @@
 #
 # @location         Where to store the new image file
 # @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image (default: off)
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off,
+#                   falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
+#                   full (if defined CONFIG_GLUSTERFS_ZEROFILL))
 #
 # Since: 2.12
 ##
@@ -4225,7 +4231,8 @@
 # @backing-fmt      Name of the block driver to use for the backing file
 # @encrypt          Encryption options if the image should be encrypted
 # @cluster-size     qcow2 cluster size in bytes (default: 65536)
-# @preallocation    Preallocation mode for the new image (default: off)
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off, falloc, full, metadata)
 # @lazy-refcounts   True if refcounts may be updated lazily (default: of=
f)
 # @refcount-bits    Width of reference counts in bits (default: 16)
 #
@@ -4408,7 +4415,8 @@
 # @location         Where to store the new image file
 # @size             Size of the virtual disk in bytes
 # @backing-file     File name of a base image
-# @preallocation    Preallocation mode (allowed values: off, full)
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off, full)
 # @redundancy       Redundancy of the image
 # @object-size      Object size of the image
 #
@@ -4443,8 +4451,8 @@
 #
 # @file             Node to create the image format on
 # @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image (allowed values=
: off,
-#                   metadata; default: off)
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off, metadata)
 #
 # Since: 2.12
 ##
--=20
2.20.1



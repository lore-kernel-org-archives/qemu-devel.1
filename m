Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A60FC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE5B20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE5B20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6h3-0008Qa-IH
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57846)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6UK-0007Qr-9k
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6UG-0006Cu-KU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hb6UC-00069X-U2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 402E030832E3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1051B51C6A;
 Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9591E1138661; Wed, 12 Jun 2019 18:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 18:52:20 +0200
Message-Id: <20190612165229.26976-3-armbru@redhat.com>
In-Reply-To: <20190612165229.26976-1-armbru@redhat.com>
References: <20190612165229.26976-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/11] qapi/block-core: update documentation of
 preallocation parameter
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
Cc: Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Add default and available values in the documentation block of
each block device or protocol that supports the 'preallocation'
parameter during the image creation.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190524075848.23781-2-sgarzare@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1defcde048..175ccfe896 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4121,7 +4121,10 @@
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
@@ -4139,7 +4142,10 @@
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
@@ -4243,7 +4249,8 @@
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
@@ -4426,7 +4433,8 @@
 # @location         Where to store the new image file
 # @size             Size of the virtual disk in bytes
 # @backing-file     File name of a base image
-# @preallocation    Preallocation mode (allowed values: off, full)
+# @preallocation    Preallocation mode for the new image (default: off;
+#                   allowed values: off, full)
 # @redundancy       Redundancy of the image
 # @object-size      Object size of the image
 #
@@ -4461,8 +4469,8 @@
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
2.21.0



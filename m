Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB8C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145C021775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAyfY9wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145C021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl4H-0004r7-2C
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzd-0006bi-QY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkza-00052Y-Q8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:09 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkza-0004xL-G9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:06 -0500
Received: by mail-wr1-x42f.google.com with SMTP id t2so8226526wrr.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nii6KloRzb9ik6RzFqLYY2ekJtWFz5U3rmF8nlmzCmo=;
 b=jAyfY9wY/xHuw40YiHJFg6rjKaLGq845BPPmpl+V4DZDiF2viIOZBC7SoK/4MOhvej
 uWlHQiLGyox+Hu1ztOIwI4AF6gVKRkZu4h6m4GQuCHPDAWqWIwciixolDf3vLEpc8Uup
 wudF6tR9h4pzTF78XBIr19x77GhDBjun/uB7s/RKsN5KaMKGirvQPMkZzp1Ea3g8jBgI
 HN3MwR2HonXYP1rj4XjxWffa1znWIVLKPq/x5UDbmLtDUIWV/9aj0cMjqal5uLq+T0Y8
 itNXMjAANWLy5pclm5bh8Do9D454kNSIEw6NutMR/rkAHQNiPMB0Q3Eh/kcpUHuoSc6a
 c0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nii6KloRzb9ik6RzFqLYY2ekJtWFz5U3rmF8nlmzCmo=;
 b=Bn23vUnjAE687XGNy3MtK8kE5LVvFK0fxzVkWo2QXrIpNiSBJYX67fEXB6Bdj2F7Pq
 Pu0X6xi9zV9q4zsN/q3vP1e7yg+Evb/IhxL4+GPFzWxWOBKAt1e9lKx/hK9lU7I1wFhr
 fhnhIVuha1bGcAEOiQn/YeY+Ocm+iZ1bkskExL6eXgrrl3sPX7aBC9Hm631RblqZxiGk
 bA5ljPn7enrV66csCSxvzqfsvQBLUe+P2t7vtJNGLci5SjV/xk3XlktvoOUk4sGA/LU5
 grcKs67Pu2KYkYSvKh3BO+WIskH0a61cBLU8X4AqnQxIV2JvxwbtrsKss+UO3NSqAYXm
 SBQA==
X-Gm-Message-State: APjAAAXtp/By5N1IkEtTR7dGgmbuBiZiY0LKx70YAjrm1fACMCL03eVR
 IXwf3flw3D/JDntUP4eGzvuK8iNCI3c=
X-Google-Smtp-Source: APXvYqydrRNydzY1lDHwwnYoIu156HWoa2ImK+/dGl5tUHWrf+POqbt2kqH0yq7vA6XwP/I7BZIfaw==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr5224226wrr.204.1581010263936; 
 Thu, 06 Feb 2020 09:31:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
Date: Thu,  6 Feb 2020 17:30:19 +0000
Message-Id: <20200206173040.17337-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some qapi doc comments have forgotten the ':' after the
@argument, like this:

# @filename         Filename for the new image file
# @size             Size of the virtual disk in bytes

The result is that these are parsed as part of the body
text and appear as a run-on line:
  filename Filename for the new image file size Size of the virtual disk in bytes"
followed by
  filename: string
    Not documented
  size: int
    Not documented

in the 'Members' section.

Correct the formatting.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json | 236 +++++++++++++++++++++----------------------
 1 file changed, 118 insertions(+), 118 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 372f35ee5f0..076a4a4808e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3235,9 +3235,9 @@
 ##
 # @SshHostKeyCheckMode:
 #
-# @none             Don't check the host key at all
-# @hash             Compare the host key with a given hash
-# @known_hosts      Check the host key against the known_hosts file
+# @none: Don't check the host key at all
+# @hash: Compare the host key with a given hash
+# @known_hosts: Check the host key against the known_hosts file
 #
 # Since: 2.12
 ##
@@ -3247,8 +3247,8 @@
 ##
 # @SshHostKeyCheckHashType:
 #
-# @md5              The given hash is an md5 hash
-# @sha1             The given hash is an sha1 hash
+# @md5: The given hash is an md5 hash
+# @sha1: The given hash is an sha1 hash
 #
 # Since: 2.12
 ##
@@ -3258,8 +3258,8 @@
 ##
 # @SshHostKeyHash:
 #
-# @type             The hash algorithm used for the hash
-# @hash             The expected hash value
+# @type: The hash algorithm used for the hash
+# @hash: The expected hash value
 #
 # Since: 2.12
 ##
@@ -4265,13 +4265,13 @@
 #
 # Driver specific image creation options for file.
 #
-# @filename         Filename for the new image file
-# @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image (default: off;
-#                   allowed values: off,
-#                   falloc (if defined CONFIG_POSIX_FALLOCATE),
-#                   full (if defined CONFIG_POSIX))
-# @nocow            Turn off copy-on-write (valid only on btrfs; default: off)
+# @filename: Filename for the new image file
+# @size: Size of the virtual disk in bytes
+# @preallocation: Preallocation mode for the new image (default: off;
+#                 allowed values: off,
+#                 falloc (if defined CONFIG_POSIX_FALLOCATE),
+#                 full (if defined CONFIG_POSIX))
+# @nocow: Turn off copy-on-write (valid only on btrfs; default: off)
 #
 # Since: 2.12
 ##
@@ -4286,12 +4286,12 @@
 #
 # Driver specific image creation options for gluster.
 #
-# @location         Where to store the new image file
-# @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image (default: off;
-#                   allowed values: off,
-#                   falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
-#                   full (if defined CONFIG_GLUSTERFS_ZEROFILL))
+# @location: Where to store the new image file
+# @size: Size of the virtual disk in bytes
+# @preallocation: Preallocation mode for the new image (default: off;
+#                 allowed values: off,
+#                 falloc (if defined CONFIG_GLUSTERFS_FALLOCATE),
+#                 full (if defined CONFIG_GLUSTERFS_ZEROFILL))
 #
 # Since: 2.12
 ##
@@ -4305,11 +4305,11 @@
 #
 # Driver specific image creation options for LUKS.
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image
-#                   (since: 4.2)
-#                   (default: off; allowed values: off, metadata, falloc, full)
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @preallocation: Preallocation mode for the new image
+#                 (since: 4.2)
+#                 (default: off; allowed values: off, metadata, falloc, full)
 #
 # Since: 2.12
 ##
@@ -4324,8 +4324,8 @@
 #
 # Driver specific image creation options for NFS.
 #
-# @location         Where to store the new image file
-# @size             Size of the virtual disk in bytes
+# @location: Where to store the new image file
+# @size: Size of the virtual disk in bytes
 #
 # Since: 2.12
 ##
@@ -4338,9 +4338,9 @@
 #
 # Driver specific image creation options for parallels.
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @cluster-size     Cluster size in bytes (default: 1 MB)
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @cluster-size: Cluster size in bytes (default: 1 MB)
 #
 # Since: 2.12
 ##
@@ -4354,11 +4354,11 @@
 #
 # Driver specific image creation options for qcow.
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @backing-file     File name of the backing file if a backing file
-#                   should be used
-# @encrypt          Encryption options if the image should be encrypted
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @backing-file: File name of the backing file if a backing file
+#                should be used
+# @encrypt: Encryption options if the image should be encrypted
 #
 # Since: 2.12
 ##
@@ -4385,24 +4385,24 @@
 #
 # Driver specific image creation options for qcow2.
 #
-# @file             Node to create the image format on
-# @data-file        Node to use as an external data file in which all guest
-#                   data is stored so that only metadata remains in the qcow2
-#                   file (since: 4.0)
-# @data-file-raw    True if the external data file must stay valid as a
-#                   standalone (read-only) raw image without looking at qcow2
-#                   metadata (default: false; since: 4.0)
-# @size             Size of the virtual disk in bytes
-# @version          Compatibility level (default: v3)
-# @backing-file     File name of the backing file if a backing file
-#                   should be used
-# @backing-fmt      Name of the block driver to use for the backing file
-# @encrypt          Encryption options if the image should be encrypted
-# @cluster-size     qcow2 cluster size in bytes (default: 65536)
-# @preallocation    Preallocation mode for the new image (default: off;
-#                   allowed values: off, falloc, full, metadata)
-# @lazy-refcounts   True if refcounts may be updated lazily (default: off)
-# @refcount-bits    Width of reference counts in bits (default: 16)
+# @file: Node to create the image format on
+# @data-file: Node to use as an external data file in which all guest
+#             data is stored so that only metadata remains in the qcow2
+#             file (since: 4.0)
+# @data-file-raw: True if the external data file must stay valid as a
+#                 standalone (read-only) raw image without looking at qcow2
+#                 metadata (default: false; since: 4.0)
+# @size: Size of the virtual disk in bytes
+# @version: Compatibility level (default: v3)
+# @backing-file: File name of the backing file if a backing file
+#                should be used
+# @backing-fmt: Name of the block driver to use for the backing file
+# @encrypt: Encryption options if the image should be encrypted
+# @cluster-size: qcow2 cluster size in bytes (default: 65536)
+# @preallocation: Preallocation mode for the new image (default: off;
+#                 allowed values: off, falloc, full, metadata)
+# @lazy-refcounts: True if refcounts may be updated lazily (default: off)
+# @refcount-bits: Width of reference counts in bits (default: 16)
 #
 # Since: 2.12
 ##
@@ -4425,13 +4425,13 @@
 #
 # Driver specific image creation options for qed.
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @backing-file     File name of the backing file if a backing file
-#                   should be used
-# @backing-fmt      Name of the block driver to use for the backing file
-# @cluster-size     Cluster size in bytes (default: 65536)
-# @table-size       L1/L2 table size (in clusters)
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @backing-file: File name of the backing file if a backing file
+#                should be used
+# @backing-fmt: Name of the block driver to use for the backing file
+# @cluster-size: Cluster size in bytes (default: 65536)
+# @table-size: L1/L2 table size (in clusters)
 #
 # Since: 2.12
 ##
@@ -4448,10 +4448,10 @@
 #
 # Driver specific image creation options for rbd/Ceph.
 #
-# @location         Where to store the new image file. This location cannot
-#                   point to a snapshot.
-# @size             Size of the virtual disk in bytes
-# @cluster-size     RBD object size
+# @location: Where to store the new image file. This location cannot
+#            point to a snapshot.
+# @size: Size of the virtual disk in bytes
+# @cluster-size: RBD object size
 #
 # Since: 2.12
 ##
@@ -4499,23 +4499,23 @@
 #
 # Driver specific image creation options for VMDK.
 #
-# @file         Where to store the new image file. This refers to the image
-#               file for monolithcSparse and streamOptimized format, or the
-#               descriptor file for other formats.
-# @size         Size of the virtual disk in bytes
-# @extents      Where to store the data extents. Required for monolithcFlat,
-#               twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
-#               monolithicFlat, only one entry is required; for
-#               twoGbMaxExtent* formats, the number of entries required is
-#               calculated as extent_number = virtual_size / 2GB. Providing
-#               more extents than will be used is an error.
-# @subformat    The subformat of the VMDK image. Default: "monolithicSparse".
-# @backing-file The path of backing file. Default: no backing file is used.
-# @adapter-type The adapter type used to fill in the descriptor. Default: ide.
-# @hwversion    Hardware version. The meaningful options are "4" or "6".
-#               Default: "4".
-# @zeroed-grain Whether to enable zeroed-grain feature for sparse subformats.
-#               Default: false.
+# @file: Where to store the new image file. This refers to the image
+#        file for monolithcSparse and streamOptimized format, or the
+#        descriptor file for other formats.
+# @size: Size of the virtual disk in bytes
+# @extents: Where to store the data extents. Required for monolithcFlat,
+#           twoGbMaxExtentSparse and twoGbMaxExtentFlat formats. For
+#           monolithicFlat, only one entry is required; for
+#           twoGbMaxExtent* formats, the number of entries required is
+#           calculated as extent_number = virtual_size / 2GB. Providing
+#           more extents than will be used is an error.
+# @subformat: The subformat of the VMDK image. Default: "monolithicSparse".
+# @backing-file: The path of backing file. Default: no backing file is used.
+# @adapter-type: The adapter type used to fill in the descriptor. Default: ide.
+# @hwversion: Hardware version. The meaningful options are "4" or "6".
+#             Default: "4".
+# @zeroed-grain: Whether to enable zeroed-grain feature for sparse subformats.
+#                Default: false.
 #
 # Since: 4.0
 ##
@@ -4533,9 +4533,9 @@
 ##
 # @SheepdogRedundancyType:
 #
-# @full             Create a fully replicated vdi with x copies
-# @erasure-coded    Create an erasure coded vdi with x data strips and
-#                   y parity strips
+# @full: Create a fully replicated vdi with x copies
+# @erasure-coded: Create an erasure coded vdi with x data strips and
+#                 y parity strips
 #
 # Since: 2.12
 ##
@@ -4545,7 +4545,7 @@
 ##
 # @SheepdogRedundancyFull:
 #
-# @copies           Number of copies to use (between 1 and 31)
+# @copies: Number of copies to use (between 1 and 31)
 #
 # Since: 2.12
 ##
@@ -4555,8 +4555,8 @@
 ##
 # @SheepdogRedundancyErasureCoded:
 #
-# @data-strips      Number of data strips to use (one of {2,4,8,16})
-# @parity-strips    Number of parity strips to use (between 1 and 15)
+# @data-strips: Number of data strips to use (one of {2,4,8,16})
+# @parity-strips: Number of parity strips to use (between 1 and 15)
 #
 # Since: 2.12
 ##
@@ -4580,13 +4580,13 @@
 #
 # Driver specific image creation options for Sheepdog.
 #
-# @location         Where to store the new image file
-# @size             Size of the virtual disk in bytes
-# @backing-file     File name of a base image
-# @preallocation    Preallocation mode for the new image (default: off;
-#                   allowed values: off, full)
-# @redundancy       Redundancy of the image
-# @object-size      Object size of the image
+# @location: Where to store the new image file
+# @size: Size of the virtual disk in bytes
+# @backing-file: File name of a base image
+# @preallocation: Preallocation mode for the new image (default: off;
+#                 allowed values: off, full)
+# @redundancy: Redundancy of the image
+# @object-size: Object size of the image
 #
 # Since: 2.12
 ##
@@ -4603,8 +4603,8 @@
 #
 # Driver specific image creation options for SSH.
 #
-# @location         Where to store the new image file
-# @size             Size of the virtual disk in bytes
+# @location: Where to store the new image file
+# @size: Size of the virtual disk in bytes
 #
 # Since: 2.12
 ##
@@ -4617,10 +4617,10 @@
 #
 # Driver specific image creation options for VDI.
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @preallocation    Preallocation mode for the new image (default: off;
-#                   allowed values: off, metadata)
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @preallocation: Preallocation mode for the new image (default: off;
+#                 allowed values: off, metadata)
 #
 # Since: 2.12
 ##
@@ -4645,17 +4645,17 @@
 #
 # Driver specific image creation options for vhdx.
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @log-size         Log size in bytes, must be a multiple of 1 MB
-#                   (default: 1 MB)
-# @block-size       Block size in bytes, must be a multiple of 1 MB and not
-#                   larger than 256 MB (default: automatically choose a block
-#                   size depending on the image size)
-# @subformat        vhdx subformat (default: dynamic)
-# @block-state-zero Force use of payload blocks of type 'ZERO'. Non-standard,
-#                   but default.  Do not set to 'off' when using 'qemu-img
-#                   convert' with subformat=dynamic.
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @log-size: Log size in bytes, must be a multiple of 1 MB
+#            (default: 1 MB)
+# @block-size: Block size in bytes, must be a multiple of 1 MB and not
+#              larger than 256 MB (default: automatically choose a block
+#              size depending on the image size)
+# @subformat: vhdx subformat (default: dynamic)
+# @block-state-zero: Force use of payload blocks of type 'ZERO'. Non-standard,
+#                    but default.  Do not set to 'off' when using 'qemu-img
+#                    convert' with subformat=dynamic.
 #
 # Since: 2.12
 ##
@@ -4683,12 +4683,12 @@
 #
 # Driver specific image creation options for vpc (VHD).
 #
-# @file             Node to create the image format on
-# @size             Size of the virtual disk in bytes
-# @subformat        vhdx subformat (default: dynamic)
-# @force-size       Force use of the exact byte size instead of rounding to the
-#                   next size that can be represented in CHS geometry
-#                   (default: false)
+# @file: Node to create the image format on
+# @size: Size of the virtual disk in bytes
+# @subformat: vhdx subformat (default: dynamic)
+# @force-size: Force use of the exact byte size instead of rounding to the
+#              next size that can be represented in CHS geometry
+#              (default: false)
 #
 # Since: 2.12
 ##
@@ -4703,7 +4703,7 @@
 #
 # Options for creating an image format on a given node.
 #
-# @driver           block driver to create the image format
+# @driver: block driver to create the image format
 #
 # Since: 2.12
 ##
-- 
2.20.1



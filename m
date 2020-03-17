Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9020BC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCFF20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hFxQxeE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCFF20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGuw-0007kI-GK
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jEGmz-0003ZQ-Oz
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jEGmv-00009k-AN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:18:05 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jEGmu-0005xu-6X; Tue, 17 Mar 2020 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=TKff4cYs4DZY3KrO7NuCZI8bc9isDfcNxdbF0M4xumo=; 
 b=hFxQxeE7crizD8RQ5ShSeWdI2ZP9q5Qck2ULbDgDhHtwr65Zs4YnlCXK4UDgWq/m8ZbQvt6Kg784/jYd7bZ96qDoDVIhXA7SF4BbdappVulRCwdaks1I17rpVZsKIIUEcwVOGa27rWWf+sz1N0LmoY7ivb279SlEDuLexyukLMZ5HXYCQCKexQ5p1vyxXB/l3iesuN4HGbiwobjcGrVNC9+Gz0/gCix9111Lguy8w5cG4GbUgt233DAKyXhxt8b7cMD13F1FXk1MOM3kw8ipegx4EvPhYt/E+XPQIfacju94uwHUx4mUGbCKxSC0Ufyn3VVQZiuHWJmZ7OSZBXRYiw==;
Received: from [81.0.35.138] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jEGmD-00014w-3c; Tue, 17 Mar 2020 19:17:17 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jEGlw-0006OH-96; Tue, 17 Mar 2020 19:17:00 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/30] qcow2: Document the Extended L2 Entries feature
Date: Tue, 17 Mar 2020 19:16:04 +0100
Message-Id: <aa1ac3fbb1d42db67d930b76255c9b7b19c07b42.1584468723.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1584468723.git.berto@igalia.com>
References: <cover.1584468723.git.berto@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Subcluster allocation in qcow2 is implemented by extending the
existing L2 table entries and adding additional information to
indicate the allocation status of each subcluster.

This patch documents the changes to the qcow2 format and how they
affect the calculation of the L2 cache size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 docs/interop/qcow2.txt | 68 ++++++++++++++++++++++++++++++++++++++++--
 docs/qcow2-cache.txt   | 19 +++++++++++-
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 5597e24474..2e8cad38c4 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -39,6 +39,9 @@ The first cluster of a qcow2 image contains the file header:
                     as the maximum cluster size and won't be able to open images
                     with larger cluster sizes.
 
+                    Note: if the image has Extended L2 Entries then cluster_bits
+                    must be at least 14 (i.e. 16384 byte clusters).
+
          24 - 31:   size
                     Virtual disk size in bytes.
 
@@ -114,7 +117,12 @@ the next fields through header_length.
                                 clusters. The compression_type field must be
                                 present and not zero.
 
-                    Bits 4-63:  Reserved (set to 0)
+                    Bit 4:      Extended L2 Entries.  If this bit is set then
+                                L2 table entries use an extended format that
+                                allows subcluster-based allocation. See the
+                                Extended L2 Entries section for more details.
+
+                    Bits 5-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -493,7 +501,7 @@ cannot be relaxed without an incompatible layout change).
 Given an offset into the virtual disk, the offset into the image file can be
 obtained as follows:
 
-    l2_entries = (cluster_size / sizeof(uint64_t))
+    l2_entries = (cluster_size / sizeof(uint64_t))        [*]
 
     l2_index = (offset / cluster_size) % l2_entries
     l1_index = (offset / cluster_size) / l2_entries
@@ -503,6 +511,8 @@ obtained as follows:
 
     return cluster_offset + (offset % cluster_size)
 
+    [*] this changes if Extended L2 Entries are enabled, see next section
+
 L1 table entry:
 
     Bit  0 -  8:    Reserved (set to 0)
@@ -543,7 +553,8 @@ Standard Cluster Descriptor:
                     nor is data read from the backing file if the cluster is
                     unallocated.
 
-                    With version 2, this is always 0.
+                    With version 2 or with extended L2 entries (see the next
+                    section), this is always 0.
 
          1 -  8:    Reserved (set to 0)
 
@@ -580,6 +591,57 @@ file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
 no backing file or the backing file is smaller than the image, they shall read
 zeros for all parts that are not covered by the backing file.
 
+== Extended L2 Entries ==
+
+An image uses Extended L2 Entries if bit 4 is set on the incompatible_features
+field of the header.
+
+In these images standard data clusters are divided into 32 subclusters of the
+same size. They are contiguous and start from the beginning of the cluster.
+Subclusters can be allocated independently and the L2 entry contains information
+indicating the status of each one of them. Compressed data clusters don't have
+subclusters so they are treated the same as in images without this feature.
+
+The size of an extended L2 entry is 128 bits so the number of entries per table
+is calculated using this formula:
+
+    l2_entries = (cluster_size / (2 * sizeof(uint64_t)))
+
+The first 64 bits have the same format as the standard L2 table entry described
+in the previous section, with the exception of bit 0 of the standard cluster
+descriptor.
+
+The last 64 bits contain a subcluster allocation bitmap with this format:
+
+Subcluster Allocation Bitmap (for standard clusters):
+
+    Bit  0 -  31:   Allocation status (one bit per subcluster)
+
+                    1: the subcluster is allocated. In this case the
+                       host cluster offset field must contain a valid
+                       offset.
+                    0: the subcluster is not allocated. In this case
+                       read requests shall go to the backing file or
+                       return zeros if there is no backing file data.
+
+                    Bits are assigned starting from the least significant
+                    one (i.e. bit x is used for subcluster x).
+
+        32 -  63    Subcluster reads as zeros (one bit per subcluster)
+
+                    1: the subcluster reads as zeros. In this case the
+                       allocation status bit must be unset. The host
+                       cluster offset field may or may not be set.
+                    0: no effect.
+
+                    Bits are assigned starting from the least significant
+                    one (i.e. bit x is used for subcluster x - 32).
+
+Subcluster Allocation Bitmap (for compressed clusters):
+
+    Bit  0 -  63:   Reserved (set to 0)
+                    Compressed clusters don't have subclusters,
+                    so this field is not used.
 
 == Snapshots ==
 
diff --git a/docs/qcow2-cache.txt b/docs/qcow2-cache.txt
index d57f409861..5f763aa6bb 100644
--- a/docs/qcow2-cache.txt
+++ b/docs/qcow2-cache.txt
@@ -1,6 +1,6 @@
 qcow2 L2/refcount cache configuration
 =====================================
-Copyright (C) 2015, 2018 Igalia, S.L.
+Copyright (C) 2015, 2018-2020 Igalia, S.L.
 Author: Alberto Garcia <berto@igalia.com>
 
 This work is licensed under the terms of the GNU GPL, version 2 or
@@ -222,3 +222,20 @@ support this functionality, and is 0 (disabled) on other platforms.
 This functionality currently relies on the MADV_DONTNEED argument for
 madvise() to actually free the memory. This is a Linux-specific feature,
 so cache-clean-interval is not supported on other systems.
+
+
+Extended L2 Entries
+-------------------
+All numbers shown in this document are valid for qcow2 images with normal
+64-bit L2 entries.
+
+Images with extended L2 entries need twice as much L2 metadata, so the L2
+cache size must be twice as large for the same disk space.
+
+   disk_size = l2_cache_size * cluster_size / 16
+
+i.e.
+
+   l2_cache_size = disk_size * 16 / cluster_size
+
+Refcount blocks are not affected by this.
-- 
2.20.1



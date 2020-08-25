Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18311C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92D720706
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFfamjjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92D720706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUPz-0005oa-2x
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUOh-0003QY-Ne
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAUOd-0000Zy-0P
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598344413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxRz0eoM0sa0fxUQkUm/mc7nZEnnCbUd0tyQHs7Rfa8=;
 b=ZFfamjjsw6K8M/0vPyxyKJ+YMZYKPwbVTNygLfbk+rqjMEFnQfYMC/EFO7pBZyBzfeqHOy
 docCyq/8+Tlfb+TLzpwYWetctkmJ1l+q1vFTNd5dlsRFDJRekdC2hJwIYhV9BRvDehtjvI
 3s7NDsdJlebFbnU93f8ClVmFnd408Qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540--wn92MBcNTubzD8uowifCA-1; Tue, 25 Aug 2020 04:33:31 -0400
X-MC-Unique: -wn92MBcNTubzD8uowifCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3579418A2251;
 Tue, 25 Aug 2020 08:33:30 +0000 (UTC)
Received: from localhost (ovpn-113-72.ams2.redhat.com [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9654B60C15;
 Tue, 25 Aug 2020 08:33:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/34] qcow2: Document the Extended L2 Entries feature
Date: Tue, 25 Aug 2020 10:32:44 +0200
Message-Id: <20200825083311.1098442-8-mreitz@redhat.com>
In-Reply-To: <20200825083311.1098442-1-mreitz@redhat.com>
References: <20200825083311.1098442-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

Subcluster allocation in qcow2 is implemented by extending the
existing L2 table entries and adding additional information to
indicate the allocation status of each subcluster.

This patch documents the changes to the qcow2 format and how they
affect the calculation of the L2 cache size.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <5199f2e1c717bcaa58b48142c9062b803145ff7f.1594396418.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 docs/interop/qcow2.txt | 68 ++++++++++++++++++++++++++++++++++++++++--
 docs/qcow2-cache.txt   | 19 +++++++++++-
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index f072e27900..7da0d81df8 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -42,6 +42,9 @@ The first cluster of a qcow2 image contains the file header:
                     as the maximum cluster size and won't be able to open images
                     with larger cluster sizes.
 
+                    Note: if the image has Extended L2 Entries then cluster_bits
+                    must be at least 14 (i.e. 16384 byte clusters).
+
          24 - 31:   size
                     Virtual disk size in bytes.
 
@@ -117,7 +120,12 @@ the next fields through header_length.
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
@@ -498,7 +506,7 @@ cannot be relaxed without an incompatible layout change).
 Given an offset into the virtual disk, the offset into the image file can be
 obtained as follows:
 
-    l2_entries = (cluster_size / sizeof(uint64_t))
+    l2_entries = (cluster_size / sizeof(uint64_t))        [*]
 
     l2_index = (offset / cluster_size) % l2_entries
     l1_index = (offset / cluster_size) / l2_entries
@@ -508,6 +516,8 @@ obtained as follows:
 
     return cluster_offset + (offset % cluster_size)
 
+    [*] this changes if Extended L2 Entries are enabled, see next section
+
 L1 table entry:
 
     Bit  0 -  8:    Reserved (set to 0)
@@ -548,7 +558,8 @@ Standard Cluster Descriptor:
                     nor is data read from the backing file if the cluster is
                     unallocated.
 
-                    With version 2, this is always 0.
+                    With version 2 or with extended L2 entries (see the next
+                    section), this is always 0.
 
          1 -  8:    Reserved (set to 0)
 
@@ -585,6 +596,57 @@ file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
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
+    Bit  0 - 31:    Allocation status (one bit per subcluster)
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
+        32 - 63     Subcluster reads as zeros (one bit per subcluster)
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
+    Bit  0 - 63:    Reserved (set to 0)
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
2.26.2



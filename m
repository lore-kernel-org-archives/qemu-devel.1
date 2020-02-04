Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D341C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA6E20674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K5D8veBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA6E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywRT-0001Fl-Af
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQD-0008Jy-Bh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQB-00008E-CK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQA-0008Md-Of
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113104euoutp025f13835f2d8b8d71d4c51c934d222f5a~wL6dS2FVJ3023230232euoutp020
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204113104euoutp025f13835f2d8b8d71d4c51c934d222f5a~wL6dS2FVJ3023230232euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815864;
 bh=IJ1emGgN6d30HijKvqti3w0yHl5azRM1D5/4t/jSL+I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K5D8veBTMDTaK61I+eY5LGmEHV3A4stKtN36RJSU3dlDJzUUgS051BFmTfsNsFaIC
 VrZwxd8LPjEw3aEA3iXNarS74phg94KM158MhowkEFRftDCKt+RrE60yk1JrawQZ+1
 jKvoex3A08M7g2ZiYu4Dy7N6Icjqeh/Ke80qdGaQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204113104eucas1p2e83ce943e6f3e457f4fb0ee7a66762e0~wL6dEbzpa0683206832eucas1p29;
 Tue,  4 Feb 2020 11:31:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id E3.3C.60679.8F5593E5; Tue,  4
 Feb 2020 11:31:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113104eucas1p2587768b7daa479ef5c01b45e1da99e45~wL6cruR6b0683106831eucas1p2y;
 Tue,  4 Feb 2020 11:31:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113104eusmtrp1c96f6997c3b56ea854e36622acafff48~wL6crMZJv2134721347eusmtrp1G;
 Tue,  4 Feb 2020 11:31:04 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ce-5e3955f8494a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.0A.07950.8F5593E5; Tue,  4
 Feb 2020 11:31:04 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113103eusmtip28249f773b8678ea801ba48f029313b35~wL6cYB82n1358713587eusmtip2S;
 Tue,  4 Feb 2020 11:31:03 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 1/9] memory: Add function for finding flat memory ranges
Date: Tue,  4 Feb 2020 12:30:43 +0100
Message-Id: <1580815851-28887-2-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djP87o/Qi3jDBY1qVvsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYorhsUlJzMstSi/TtErgy5v5r
 ZS14o1mxeNcK1gbGiXJdjJwcEgImEuu/zWbrYuTiEBJYwSix9/xydgjnC6PEonmPoZzPjBL9
 t1tYYVre3JrMBJFYzijxc8k2sARYS9sbdRCbTUBNYueRz4wgtoiApMTvrtPMIDazQIbE81nd
 YLawgJvEveWtYDUsAqoSu5evBIvzCgRINK5+xQixTE7i5rlOsDinQKDE+z2TwBZLCJxhk1jU
 cByqyEViw9EdULawxKvjW9ghbBmJ05N7WCDseomWOzugmjsYJfpWTmeDSFhLfNmwFKiIA+g6
 TYn1u/Qhwo4Sr0/NZwUJSwjwSdx4KwhxP5/EpG3TmSHCvBIdbUIQ1XoS3U9uMsFsXdb4CGqr
 h8StGdegwbOEUWLVA+0JjPKzEHYtYGRcxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJERj9
 p/8d/7KDcdefpEOMAhyMSjy8J89axAmxJpYVV+YeYpTgYFYS4T2vbxknxJuSWFmVWpQfX1Sa
 k1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA2PKB4Fbqb/n7/pz12j37UZJ1Qna
 10/6ZWZ/Z72iVPX4hs3Dlz+bZiadynEKnHtTcELZMU2T2Dttaez/N35wKn/7e0u0quNUxiXb
 HZ6VbFM8aD138aGK9gNbjCympjHcaz+Vs3Mpe4pejobqeSYV9jNcd8Q1XT505cROm3h/hfnT
 77v2P41/d5FPiaU4I9FQi7moOBEA/sKXAPoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7o/Qi3jDK695rHYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlzP3XylrwRrNi8a4VrA2ME+W6GDk5
 JARMJN7cmswEYgsJLGWU2D01DiIuI/Hj9Bo2CFtY4s+1LiCbC6jmE6PEqRWbwRrYBNQkdh75
 zAhiiwhISvzuOs0MYjMLZEnsnH0frEZYwE3i3vJWsBoWAVWJ3ctXgtXwCgRINK5+xQixQE7i
 5rlOsDinQKDE+z2ToA4KkLiwaxb7BEa+BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKD
 cduxn1t2MHa9Cz7EKMDBqMTDq+FoESfEmlhWXJl7iFGCg1lJhPe8vmWcEG9KYmVValF+fFFp
 TmrxIUZToKMmMkuJJucDIyWvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwf
 EwenVAOjb+s+w4IpG/89+ZGstupLaR9jr/mRH0kzd8V++t5Qd3+zhW0Pk2G44d+1lVOvnz04
 uTo4KWGdJ8MWAb7k8so7Th8O7trXFHvzjVdukQ6/7Usbz3V3JRQ6eav52OoZvmj+fVt7ZE5z
 ++P5jvc9Nmlv6TomwTOr+0/ikx9f/J7dZDC+b3zQ/OIqJZbijERDLeai4kQAaF15KVwCAAA=
X-CMS-MailID: 20200204113104eucas1p2587768b7daa479ef5c01b45e1da99e45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113104eucas1p2587768b7daa479ef5c01b45e1da99e45
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113104eucas1p2587768b7daa479ef5c01b45e1da99e45
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113104eucas1p2587768b7daa479ef5c01b45e1da99e45@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Given an address this lets us find the largest contiguous memory range
at that address.

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 include/exec/memory.h | 19 +++++++++++++
 memory.c              | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de..6092528 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1915,6 +1915,25 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
                                        hwaddr addr, uint64_t size);
 
 /**
+ * memory_region_find_flat_range: translate an address/size relative to
+ * a MemoryRegion into a FlatRange containing it.
+ *
+ * Returns a #MemoryRegionSection that describes this FlatRange.
+ * It will have the following characteristics:
+ *    .@size = 0 iff no containing FlatRange was found
+ *    .@mr is non-%NULL iff a containing FlatRange was found
+ *
+ * Remember that in the return value the @offset_within_region is
+ * relative to the returned region (in the .@mr field), not to the
+ * @mr argument.
+ *
+ * @mr: a MemoryRegion within which @addr is a relative address
+ * @addr: start of the area within @as to be searched
+ * @size: size of the area to be searched
+ */
+MemoryRegionSection memory_region_find_flat_range(MemoryRegion *mr,
+                                                  hwaddr addr, uint64_t size);
+/**
  * memory_global_dirty_log_sync: synchronize the dirty log for all memory
  *
  * Synchronizes the dirty page log for all address spaces.
diff --git a/memory.c b/memory.c
index aeaa8dc..e9f37e7 100644
--- a/memory.c
+++ b/memory.c
@@ -2523,6 +2523,25 @@ static FlatRange *flatview_lookup(FlatView *view, AddrRange addr)
                    sizeof(FlatRange), cmp_flatrange_addr);
 }
 
+static int cmp_flatrange_addr_containing(const void *addr_, const void *fr_)
+{
+    const AddrRange *addr = addr_;
+    const FlatRange *fr = fr_;
+
+    if (int128_le(addr->start, fr->addr.start)) {
+        return -1;
+    } else if (int128_ge(addrrange_end(*addr), addrrange_end(fr->addr))) {
+        return 1;
+    }
+    return 0;
+}
+
+static FlatRange *flatview_lookup_containing(FlatView *view, AddrRange addr)
+{
+    return bsearch(&addr, view->ranges, view->nr,
+                   sizeof(FlatRange), cmp_flatrange_addr_containing);
+}
+
 bool memory_region_is_mapped(MemoryRegion *mr)
 {
     return mr->container ? true : false;
@@ -2532,7 +2551,8 @@ bool memory_region_is_mapped(MemoryRegion *mr)
  * returned region.  It must be called from an RCU critical section.
  */
 static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
-                                                  hwaddr addr, uint64_t size)
+                                                  hwaddr addr,
+                                                  uint64_t size)
 {
     MemoryRegionSection ret = { .mr = NULL };
     MemoryRegion *root;
@@ -2576,6 +2596,50 @@ static MemoryRegionSection memory_region_find_rcu(MemoryRegion *mr,
     return ret;
 }
 
+/*
+ * Same as memory_region_find_flat_range, but it does not add a reference to
+ * the returned region.  It must be called from an RCU critical section.
+ */
+static MemoryRegionSection memory_region_find_flat_range_rcu(MemoryRegion *mr,
+                                                             hwaddr addr,
+                                                             uint64_t size)
+{
+    MemoryRegionSection ret = { .mr = NULL, .size = 0 };
+    MemoryRegion *root;
+    AddressSpace *as;
+    AddrRange range;
+    FlatView *view;
+    FlatRange *fr;
+
+    addr += mr->addr;
+    for (root = mr; root->container; ) {
+        root = root->container;
+        addr += root->addr;
+    }
+
+    as = memory_region_to_address_space(root);
+    if (!as) {
+        return ret;
+    }
+    range = addrrange_make(int128_make64(addr), int128_make64(size));
+
+    view = address_space_to_flatview(as);
+    fr = flatview_lookup_containing(view, range);
+    if (!fr) {
+        return ret;
+    }
+
+    ret.mr = fr->mr;
+    ret.fv = view;
+    range = fr->addr;
+    ret.offset_within_region = fr->offset_in_region;
+    ret.size = range.size;
+    ret.offset_within_address_space = int128_get64(range.start);
+    ret.readonly = fr->readonly;
+    ret.nonvolatile = fr->nonvolatile;
+    return ret;
+}
+
 MemoryRegionSection memory_region_find(MemoryRegion *mr,
                                        hwaddr addr, uint64_t size)
 {
@@ -2588,6 +2652,19 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
     return ret;
 }
 
+MemoryRegionSection memory_region_find_flat_range(MemoryRegion *mr,
+                                                  hwaddr addr, uint64_t size)
+{
+    MemoryRegionSection ret;
+    rcu_read_lock();
+    ret = memory_region_find_flat_range_rcu(mr, addr, size);
+    if (ret.mr) {
+        memory_region_ref(ret.mr);
+    }
+    rcu_read_unlock();
+    return ret;
+}
+
 bool memory_region_present(MemoryRegion *container, hwaddr addr)
 {
     MemoryRegion *mr;
-- 
2.7.4



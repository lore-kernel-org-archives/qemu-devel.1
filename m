Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5D2C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87CD208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="RoX8YD5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87CD208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgEqU-0001h6-35
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d@lizzy.crudebyte.com>)
 id 1hgEo1-0000cN-V3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d@lizzy.crudebyte.com>)
 id 1hgEnz-0002kL-AO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:46:13 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:51719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d@lizzy.crudebyte.com>)
 id 1hgEny-0001eG-VW
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ucS3awRLJbdDNg7oh4Sb4/HXxT7TV0Z8+e3NMBLi6DY=; b=RoX8YD5N65K1V0ARhz0S9fBFS
 KwLTGa2vMkg2XNR/dbQ0Y+BJMVRfkWTyrfycto+8mu7cbTSwJvb1Xek34XsSPXJYUODdbBpOIqwt+
 kIi7YkZUG97nDaXTGorb6ftzL9RsWlyAdUCfmIT+eF/eS+fIAWFrGpvPxtJ7BJtEwkZHrIuDtadvI
 E9xqgRdJMDoFT/SrJYXS4n8wcW2OLo0E2tjJan3UCK/RM6SbyW7ASzv7HV4Eu0gez1XDFo8jSkgaR
 7rOMaEtGjq45qXzHd3mCPuhGbdWB2hYSSfuh5b2ELbBDY8g+IxW5eeDvcss0lzxGx/9NVsbLtneWS
 tAueedp9g==;
Message-Id: <fea3c051eb7ac3e2c5cbccb89d279a84d9b2c91d.1561575449.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1561575449.git.qemu_oss@crudebyte.com>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 20:52:09 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v4 5/5] 9p: Use variable length suffixes for
 inode remapping
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use variable length suffixes for inode remapping instead of the fixed 16
bit size prefixes before. With this change the inode numbers on guest will
typically be much smaller (e.g. around >2^1 .. >2^7 instead of >2^48 with
the previous fixed size inode remapping.

Additionally this solution should be more efficient, since inode numbers in
practice can take almost their entire 64 bit range on guest as well. Which
might also be beneficial for nested virtualization.

The "Exponential Golomb" algorithm is used as basis for generating the
variable length suffixes. The algorithm has a paramter k which controls the
distribution of bits on increasing indeces (minimum bits at low index vs.
maximum bits at high index). With k=0 the generated suffixes look like:

Index Dec/Bin -> Generated Suffix Bin
1 [1] -> [1] (1 bits)
2 [10] -> [010] (3 bits)
3 [11] -> [110] (3 bits)
4 [100] -> [00100] (5 bits)
5 [101] -> [10100] (5 bits)
6 [110] -> [01100] (5 bits)
7 [111] -> [11100] (5 bits)
8 [1000] -> [0001000] (7 bits)
9 [1001] -> [1001000] (7 bits)
10 [1010] -> [0101000] (7 bits)
11 [1011] -> [1101000] (7 bits)
12 [1100] -> [0011000] (7 bits)
...
65533 [1111111111111101] ->  [1011111111111111000000000000000] (31 bits)
65534 [1111111111111110] ->  [0111111111111111000000000000000] (31 bits)
65535 [1111111111111111] ->  [1111111111111111000000000000000] (31 bits)
Hence minBits=1 maxBits=31

And with k=5 they would look like:

Index Dec/Bin -> Generated Suffix Bin
1 [1] -> [000001] (6 bits)
2 [10] -> [100001] (6 bits)
3 [11] -> [010001] (6 bits)
4 [100] -> [110001] (6 bits)
5 [101] -> [001001] (6 bits)
6 [110] -> [101001] (6 bits)
7 [111] -> [011001] (6 bits)
8 [1000] -> [111001] (6 bits)
9 [1001] -> [000101] (6 bits)
10 [1010] -> [100101] (6 bits)
11 [1011] -> [010101] (6 bits)
12 [1100] -> [110101] (6 bits)
...
65533 [1111111111111101] -> [0011100000000000100000000000] (28 bits)
65534 [1111111111111110] -> [1011100000000000100000000000] (28 bits)
65535 [1111111111111111] -> [0111100000000000100000000000] (28 bits)
Hence minBits=6 maxBits=28

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/9pfs/9p.h |  67 ++++++++++++++-
 2 files changed, 312 insertions(+), 22 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e6e410972f..46c9f11384 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -26,6 +26,7 @@
 #include "migration/blocker.h"
 #include "sysemu/qtest.h"
 #include "qemu/xxhash.h"
+#include <math.h>
 
 int open_fd_hw;
 int total_open_fd;
@@ -572,6 +573,123 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_NAMED_PIPE |   \
                                 P9_STAT_MODE_SOCKET)
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/* Mirrors all bits of a byte. So e.g. binary 10100000 would become 00000101. */
+static inline uint8_t mirror8bit(uint8_t byte) {
+    return (byte * 0x0202020202ULL & 0x010884422010ULL) % 1023;
+}
+
+/* Same as mirror8bit() just for a 64 bit data type instead for a byte. */
+static inline uint64_t mirror64bit(uint64_t value) {
+    return ((uint64_t)mirror8bit( value        & 0xff) << 56) |
+           ((uint64_t)mirror8bit((value >> 8)  & 0xff) << 48) |
+           ((uint64_t)mirror8bit((value >> 16) & 0xff) << 40) |
+           ((uint64_t)mirror8bit((value >> 24) & 0xff) << 32) |
+           ((uint64_t)mirror8bit((value >> 32) & 0xff) << 24) |
+           ((uint64_t)mirror8bit((value >> 40) & 0xff) << 16) |
+           ((uint64_t)mirror8bit((value >> 48) & 0xff) << 8 ) |
+           ((uint64_t)mirror8bit((value >> 56) & 0xff)      ) ;
+}
+
+/* Parameter k for the Exponential Golomb algorihm to be used.
+ *
+ * The smaller this value, the smaller the minimum bit count for the Exp.
+ * Golomb generated affixes will be (at lowest index) however for the
+ * price of having higher maximum bit count of generated affixes (at highest
+ * index). Likewise increasing this parameter yields in smaller maximum bit
+ * count for the price of having higher minimum bit count.
+ */
+#define EXP_GOLOMB_K    0
+
+# if !EXP_GOLOMB_K
+
+/** @brief Exponential Golomb algorithm limited to the case k=0.
+ *
+ * See expGolombEncode() below for details.
+ *
+ * @param n - natural number (or index) of the prefix to be generated
+ *            (1, 2, 3, ...)
+ */
+static VariLenAffix expGolombEncodeK0(uint64_t n) {
+    const int bits = (int) log2(n) + 1;
+    return (VariLenAffix) {
+        .type = AffixType_Prefix,
+        .value = n,
+        .bits = bits + bits - 1
+    };
+}
+
+# else
+
+/** @brief Exponential Golomb algorithm for arbitrary k (including k=0).
+ *
+ * The Exponential Golomb algorithm generates @b prefixes (@b not suffixes!)
+ * with growing length and with the mathematical property of being
+ * "prefix-free". The latter means the generated prefixes can be prepended
+ * in front of arbitrary numbers and the resulting concatenated numbers are
+ * guaranteed to be always unique.
+ *
+ * This is a minor adjustment to the original Exp. Golomb algorithm in the
+ * sense that lowest allowed index (@param n) starts with 1, not with zero.
+ *
+ * @param n - natural number (or index) of the prefix to be generated
+ *            (1, 2, 3, ...)
+ * @param k - parameter k of Exp. Golomb algorithm to be used
+ *            (see comment on EXP_GOLOMB_K macro for details about k)
+ */
+static VariLenAffix expGolombEncode(uint64_t n, int k) {
+    const uint64_t value = n + (1 << k) - 1;
+    const int bits = (int) log2(value) + 1;
+    return (VariLenAffix) {
+        .type = AffixType_Prefix,
+        .value = value,
+        .bits = bits + MAX((bits - 1 - k), 0)
+    };
+}
+
+# endif /* !EXP_GOLOMB_K */
+
+/** @brief Converts a suffix into a prefix, or a prefix into a suffix.
+ *
+ * What this function does is actually mirroring all bits of the affix value,
+ * with the purpose to preserve respectively the mathematical "prefix-free"
+ * or "suffix-free" property after the conversion.
+ *
+ * In other words: if a passed prefix is suitable to create unique numbers,
+ * then the returned suffix is suitable to create unique numbers as well
+ * (and vice versa).
+ */
+static VariLenAffix invertAffix(const VariLenAffix* affix) {
+    return (VariLenAffix) {
+        .type = (affix->type == AffixType_Suffix) ? AffixType_Prefix : AffixType_Suffix,
+        .value =  mirror64bit(affix->value) >> ((sizeof(affix->value) * 8) - affix->bits),
+        .bits = affix->bits
+    };
+}
+
+/** @brief Generates suffix numbers with "suffix-free" property.
+ *
+ * This is just a wrapper function on top of the Exp. Golomb algorithm.
+ *
+ * Since the Exp. Golomb algorithm generates prefixes, but we need suffixes,
+ * this function converts the Exp. Golomb prefixes into appropriate suffixes
+ * which are still suitable for generating unique numbers.
+ *
+ * @param n - natural number (or index) of the suffix to be generated
+ *            (1, 2, 3, ...)
+ */
+static VariLenAffix affixForIndex(uint64_t index) {
+    VariLenAffix prefix;
+    #if EXP_GOLOMB_K
+    prefix = expGolombEncode(index, EXP_GOLOMB_K);
+    #else
+    prefix = expGolombEncodeK0(index);
+    #endif
+    return invertAffix(&prefix); /* convert prefix to suffix */
+}
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
 
 /* creative abuse of tb_hash_func7, which is based on xxhash */
 static uint32_t qpp_hash(QppEntry e)
@@ -584,13 +702,23 @@ static uint32_t qpf_hash(QpfEntry e)
     return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
 }
 
-static bool qpp_lookup_func(const void *obj, const void *userp)
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+static bool qpd_cmp_func(const void *obj, const void *userp)
+{
+    const QpdEntry *e1 = obj, *e2 = userp;
+    return e1->dev == e2->dev;
+}
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
+static bool qpp_cmp_func(const void *obj, const void *userp)
 {
     const QppEntry *e1 = obj, *e2 = userp;
     return e1->dev == e2->dev && e1->ino_prefix == e2->ino_prefix;
 }
 
-static bool qpf_lookup_func(const void *obj, const void *userp)
+static bool qpf_cmp_func(const void *obj, const void *userp)
 {
     const QpfEntry *e1 = obj, *e2 = userp;
     return e1->dev == e2->dev && e1->ino == e2->ino;
@@ -607,6 +735,58 @@ static void qp_table_destroy(struct qht *ht)
     qht_destroy(ht);
 }
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/*
+ * Returns how many (high end) bits of inode numbers of the passed fs
+ * device shall be used (in combination with the device number) to
+ * generate hash values for qpp_table entries.
+ *
+ * This function is required if variable length suffixes are used for inode
+ * number mapping on guest level. Since a device may end up having multiple
+ * entries in qpp_table, each entry most probably with a different suffix
+ * length, we thus need this function in conjunction with qpd_table to
+ * "agree" about a fix amount of bits (per device) to be always used for
+ * generating hash values for the purpose of accessing qpp_table in order
+ * get consistent behaviour when accessing qpp_table.
+ */
+static int qid_inode_prefix_hash_bits(V9fsPDU *pdu, dev_t dev)
+{
+    QpdEntry lookup = {
+        .dev = dev
+    }, *val;
+    uint32_t hash = dev;
+    VariLenAffix affix;
+
+    val = qht_lookup(&pdu->s->qpd_table, &lookup, hash);
+    if (!val) {
+        val = g_malloc0(sizeof(QpdEntry));
+        *val = lookup;
+        affix = affixForIndex(pdu->s->qp_affix_next);
+        val->prefix_bits = affix.bits;
+        qht_insert(&pdu->s->qpd_table, val, hash, NULL);
+        pdu->s->qp_ndevices++;
+    }
+    return val->prefix_bits;
+}
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
+/** @brief Slow / full mapping host inode nr -> guest inode nr.
+ *
+ * This function performs a slower and much more costly remapping of an
+ * original file inode number on host to an appropriate different inode
+ * number on guest. For every (dev, inode) combination on host a new
+ * sequential number is generated, cached and exposed as inode number on
+ * guest.
+ *
+ * This is just a "last resort" fallback solution if the much faster/cheaper
+ * qid_path_prefixmap() failed. In practice this slow / full mapping is not
+ * expected ever to be used at all though.
+ *
+ * @see qid_path_prefixmap() for details
+ *
+ */
 static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
                             uint64_t *path)
 {
@@ -615,11 +795,9 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
         .ino = stbuf->st_ino
     }, *val;
     uint32_t hash = qpf_hash(lookup);
-
-    /* most users won't need the fullmap, so init the table lazily */
-    if (!pdu->s->qpf_table.map) {
-        qht_init(&pdu->s->qpf_table, qpf_lookup_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
-    }
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    VariLenAffix affix;
+#endif
 
     val = qht_lookup(&pdu->s->qpf_table, &lookup, hash);
 
@@ -633,8 +811,16 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
         *val = lookup;
 
         /* new unique inode and device combo */
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        affix = affixForIndex(
+            1ULL << (sizeof(pdu->s->qp_affix_next) * 8)
+        );
+        val->path = (pdu->s->qp_fullpath_next++ << affix.bits) | affix.value;
+        pdu->s->qp_fullpath_next &= ((1ULL << (64 - affix.bits)) - 1);
+#else
         val->path = pdu->s->qp_fullpath_next++;
         pdu->s->qp_fullpath_next &= QPATH_INO_MASK;
+#endif
         qht_insert(&pdu->s->qpf_table, val, hash, NULL);
     }
 
@@ -642,42 +828,71 @@ static int qid_path_fullmap(V9fsPDU *pdu, const struct stat *stbuf,
     return 0;
 }
 
-/* stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
+/** @brief Quick mapping host inode nr -> guest inode nr.
+ *
+ * This function performs quick remapping of an original file inode number
+ * on host to an appropriate different inode number on guest. This remapping
+ * of inodes is required to avoid inode nr collisions on guest which would
+ * happen if the 9p export contains more than 1 exported file system (or
+ * more than 1 file system data set), because unlike on host level where the
+ * files would have different device nrs, all files exported by 9p would
+ * share the same device nr on guest (the device nr of the virtual 9p device
+ * that is).
+ *
+ * if P9_VARI_LENGTH_INODE_SUFFIXES == 0 :
+ * stat_to_qid needs to map inode number (64 bits) and device id (32 bits)
  * to a unique QID path (64 bits). To avoid having to map and keep track
  * of up to 2^64 objects, we map only the 16 highest bits of the inode plus
  * the device id to the 16 highest bits of the QID path. The 48 lowest bits
  * of the QID path equal to the lowest bits of the inode number.
  *
- * This takes advantage of the fact that inode number are usually not
- * random but allocated sequentially, so we have fewer items to keep
- * track of.
+ * if P9_VARI_LENGTH_INODE_SUFFIXES == 1 :
+ * Instead of fixed size (16 bit) generated prefix, we use variable size
+ * suffixes instead. See comment on P9_VARI_LENGTH_INODE_SUFFIXES for
+ * details.
  */
 static int qid_path_prefixmap(V9fsPDU *pdu, const struct stat *stbuf,
                                 uint64_t *path)
 {
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    const int ino_hash_bits = qid_inode_prefix_hash_bits(pdu, stbuf->st_dev);
+#endif
     QppEntry lookup = {
         .dev = stbuf->st_dev,
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        .ino_prefix = (uint16_t) (stbuf->st_ino >> (64-ino_hash_bits))
+#else
         .ino_prefix = (uint16_t) (stbuf->st_ino >> 48)
+#endif
     }, *val;
     uint32_t hash = qpp_hash(lookup);
 
     val = qht_lookup(&pdu->s->qpp_table, &lookup, hash);
 
     if (!val) {
-        if (pdu->s->qp_prefix_next == 0) {
-            /* we ran out of prefixes */
+        if (pdu->s->qp_affix_next == 0) {
+            /* we ran out of affixes */
             return -ENFILE;
         }
 
         val = g_malloc0(sizeof(QppEntry));
         *val = lookup;
 
-        /* new unique inode prefix and device combo */
-        val->qp_prefix = pdu->s->qp_prefix_next++;
+        /* new unique inode affix and device combo */
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        val->qp_affix_index = pdu->s->qp_affix_next++;
+        val->qp_affix = affixForIndex(val->qp_affix_index);
+#else
+        val->qp_affix = pdu->s->qp_affix_next++;
+#endif
         qht_insert(&pdu->s->qpp_table, val, hash, NULL);
     }
-
-    *path = ((uint64_t)val->qp_prefix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    /* assuming generated affix to be suffix type, not prefix */
+    *path = (stbuf->st_ino << val->qp_affix.bits) | val->qp_affix.value;
+#else
+    *path = ((uint64_t)val->qp_affix << 48) | (stbuf->st_ino & QPATH_INO_MASK);
+#endif
     return 0;
 }
 
@@ -3799,9 +4014,17 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
 
     s->dev_id = 0;
 
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    qht_init(&s->qpd_table, qpd_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
+#endif
+    /* most users won't need the fullmap, so init the table lazily */
+    qht_init(&s->qpf_table, qpf_cmp_func, 1 << 16, QHT_MODE_AUTO_RESIZE);
     /* QID path hash table. 1 entry ought to be enough for anybody ;) */
-    qht_init(&s->qpp_table, qpp_lookup_func, 1, QHT_MODE_AUTO_RESIZE);
-    s->qp_prefix_next = 1; /* reserve 0 to detect overflow */
+    qht_init(&s->qpp_table, qpp_cmp_func, 1, QHT_MODE_AUTO_RESIZE);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    s->qp_ndevices = 0;
+#endif
+    s->qp_affix_next = 1; /* reserve 0 to detect overflow */
     s->qp_fullpath_next = 1;
 
     s->ctx.fst = &fse->fst;
@@ -3817,6 +4040,9 @@ out:
         }
         g_free(s->tag);
         g_free(s->ctx.fs_root);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+        qp_table_destroy(&s->qpd_table);
+#endif
         qp_table_destroy(&s->qpp_table);
         qp_table_destroy(&s->qpf_table);
         v9fs_path_free(&path);
@@ -3831,6 +4057,9 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
     }
     fsdev_throttle_cleanup(s->ctx.fst);
     g_free(s->tag);
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    qp_table_destroy(&s->qpd_table);
+#endif
     qp_table_destroy(&s->qpp_table);
     qp_table_destroy(&s->qpf_table);
     g_free(s->ctx.fs_root);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 2b74561030..a94272a504 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -236,13 +236,68 @@ struct V9fsFidState
     V9fsFidState *rclm_lst;
 };
 
-#define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
+/*
+ * Defines how inode numbers from host shall be remapped on guest.
+ *
+ * When this compile time option is disabled then fixed length (16 bit)
+ * prefix values are used for all inode numbers on guest level. Accordingly
+ * guest's inode numbers will be quite large (>2^48).
+ *
+ * If this option is enabled then variable length suffixes will be used for
+ * guest's inode numbers instead which usually yields in much smaller inode
+ * numbers on guest level (typically around >2^1 .. >2^7).
+ */
+#define P9_VARI_LENGTH_INODE_SUFFIXES 1
+
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+typedef enum AffixType_t {
+    AffixType_Prefix,
+    AffixType_Suffix, /* A.k.a. postfix. */
+} AffixType_t;
+
+/** @brief Unique affix of variable length.
+ *
+ * An affix is (currently) either a suffix or a prefix, which is either
+ * going to be prepended (prefix) or appended (suffix) with some other
+ * number for the goal to generate unique numbers. Accordingly the
+ * suffixes (or prefixes) we generate @b must all have the mathematical
+ * property of being suffix-free (or prefix-free in case of prefixes)
+ * so that no matter what number we concatenate the affix with, that we
+ * always reliably get unique numbers as result after concatenation.
+ */
+typedef struct VariLenAffix {
+    AffixType_t type; /* Whether this affix is a suffix or a prefix. */
+    uint64_t value; /* Actual numerical value of this affix. */
+    int bits; /* Lenght of the affix, that is how many (of the lowest) bits of @c value must be used for appending/prepending this affix to its final resulting, unique number. */
+} VariLenAffix;
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
+
+#if !P9_VARI_LENGTH_INODE_SUFFIXES
+# define QPATH_INO_MASK        (((unsigned long)1 << 48) - 1)
+#endif
+
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+
+/* See qid_inode_prefix_hash_bits(). */
+typedef struct {
+    dev_t dev; /* FS device on host. */
+    int prefix_bits; /* How many (high) bits of the original inode number shall be used for hashing. */
+} QpdEntry;
+
+#endif /* P9_VARI_LENGTH_INODE_SUFFIXES */
 
 /* QID path prefix entry, see stat_to_qid */
 typedef struct {
     dev_t dev;
     uint16_t ino_prefix;
-    uint16_t qp_prefix;
+    #if P9_VARI_LENGTH_INODE_SUFFIXES
+    uint32_t qp_affix_index;
+    VariLenAffix qp_affix;
+    #else
+    uint16_t qp_affix;
+    #endif
 } QppEntry;
 
 /* QID path full entry, as above */
@@ -274,9 +329,15 @@ struct V9fsState
     V9fsConf fsconf;
     V9fsQID root_qid;
     dev_t dev_id;
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    struct qht qpd_table;
+#endif
     struct qht qpp_table;
     struct qht qpf_table;
-    uint16_t qp_prefix_next;
+#if P9_VARI_LENGTH_INODE_SUFFIXES
+    uint64_t qp_ndevices; /* Amount of entries in qpd_table. */
+#endif
+    uint16_t qp_affix_next;
     uint64_t qp_fullpath_next;
 };
 
-- 
2.11.0



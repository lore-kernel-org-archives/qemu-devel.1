Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85D4C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606CC2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606CC2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJ1e-0005p9-Bi
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpx-0007jy-JW; Tue, 13 Oct 2020 07:51:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpv-000506-Hs; Tue, 13 Oct 2020 07:51:25 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFslN-1kgtx30155-00HKY4; Tue, 13 Oct 2020 13:51:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/14] vmdk: fix maybe uninitialized warnings
Date: Tue, 13 Oct 2020 13:50:43 +0200
Message-Id: <20201013115052.133355-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XB7loyoGcXKIcOfHMjQoDjVgKRfm0t1xGrFtoqpspoGMvsOcC1T
 jQ6z5HFbfuZrpWTPDoFlGS57/JCQAxSTV/7ATvUpe5TmTdaRFi4ni50+yk6VrgCopGTWidY
 H25kL+/T7yiUypYZVGIk2lvU7mXC24IROVa3kQrmBHMhqDOoPoc1c1ip4c0KnfqzbQRhbwk
 TnKysulw0Ozq6x6ZYhYHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZeNJ7wiqgXw=:Hw2tyxTQmuifLlKl7Js/QC
 UMz2Yz4KxPJSYvwPyoBiwyBJjArlQPbO5pnf5eMdDQxyuSlccEFSwGXke52O4apat4hFWopA+
 Ru3lFLtWoqn039IryxV9L7tHirxQBZLmosJ9Ljh434jMyqvPOtrlNHKOATOrer7ACXxC9lIym
 Gd9cJbubNgr/hjPhYLfUvUy5nWJ7QEfwX7QsBawt5JPk5utKXeU02UC8//39AezmF1yzgiiqj
 HOWiRWutR30pR6JNs21l0z1UFv1pCPcpvudOS1kPkQyDJ2sYR2okyHWU0OnzltXiYc1B4jppN
 SnSVo49Kkpct9or7PyFmwxmda+DW9jE6ZcW/v4gchoVQUOGmv1X4KyY8xLux0RYkZseOFrXF5
 pSid1GbUswMBHNb9PLTOWzGBQmbpOunLIxzfjOIigV5RF06Ks33sffJUMQr59NglLIgD97K0g
 ok/JKivi4NWNG4jkYBoDT1f4FnPXdRmZuYsR2nQ+VuDEeeieWZ9ANQyMiLBgukg5NO2kjZcdl
 JxcuDvxRAoLTTRj5HDvPHwalBY+RU2xfbdm3BV0G8YxjeI94Dd+qIarIJq8WYZIcgG3RanTop
 5jAPohwgktqkNkSsJ710AW5uc8+Q+8xI+JR6k9KVYVBvcrMNkpVMLg3gBLlCkPu0ChzreFJxu
 08WKNJ3Axj0YVNSOfMS5AXKcWQkBZeiPUU2qiiyLPOJsaxqP0W6JS9dS8tE9XhBuLyunF6acy
 fnM5xOxSoAssvTmptmbvhjiRgaXZVTyRT5gvQzqNg6uglqPfp5GPIIagz4FajlcBk5epIfXsf
 N3w/LDp4QLQltINtBrtFHmaKmnVtq4fCDMnrdMmQTEG6VdEjFHMAPm7MpkI060wxW3vb9ku
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:51:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 Fam Zheng <fam@euphon.net>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Fedora 32 gcc 10 seems to give false positives:

Compiling C object libblock.fa.p/block_vmdk.c.o
../block/vmdk.c: In function ‘vmdk_parse_extents’:
../block/vmdk.c:587:5: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  587 |     g_free(extent->l1_table);
      |     ^~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:754:17: note: ‘extent’ was declared here
  754 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  620 |     ret = vmdk_init_tables(bs, extent, errp);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:598:17: note: ‘extent’ was declared here
  598 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c:1178:39: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
 1178 |             extent->flat_start_offset = flat_offset << 9;
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../block/vmdk.c: In function ‘vmdk_open_vmdk4’:
../block/vmdk.c:581:22: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  581 |     extent->l2_cache =
      |     ~~~~~~~~~~~~~~~~~^
  582 |         g_malloc(extent->entry_size * extent->l2_size * L2_CACHE_SIZE);
      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:872:17: note: ‘extent’ was declared here
  872 |     VmdkExtent *extent;
      |                 ^~~~~~
../block/vmdk.c: In function ‘vmdk_open’:
../block/vmdk.c:620:11: error: ‘extent’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  620 |     ret = vmdk_init_tables(bs, extent, errp);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../block/vmdk.c:598:17: note: ‘extent’ was declared here
  598 |     VmdkExtent *extent;
      |                 ^~~~~~
cc1: all warnings being treated as errors
make: *** [Makefile.ninja:884: libblock.fa.p/block_vmdk.c.o] Error 1

fix them by assigning a default value.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Fam Zheng <fam@euphon.net>
Message-Id: <20200930155859.303148-2-borntraeger@de.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/vmdk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 8ec62c7ab798..a00dc00eb47a 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -595,7 +595,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState *bs,
     int ret;
     uint32_t magic;
     VMDK3Header header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
 
     ret = bdrv_pread(file, sizeof(magic), &header, sizeof(header));
     if (ret < 0) {
@@ -751,7 +751,7 @@ static int vmdk_open_se_sparse(BlockDriverState *bs,
     int ret;
     VMDKSESparseConstHeader const_header;
     VMDKSESparseVolatileHeader volatile_header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
 
     ret = bdrv_apply_auto_read_only(bs,
             "No write support for seSparse images available", errp);
@@ -869,7 +869,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
     uint32_t magic;
     uint32_t l1_size, l1_entry_sectors;
     VMDK4Header header;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
     BDRVVmdkState *s = bs->opaque;
     int64_t l1_backup_offset = 0;
     bool compressed;
@@ -1088,7 +1088,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
     BdrvChild *extent_file;
     BdrvChildRole extent_role;
     BDRVVmdkState *s = bs->opaque;
-    VmdkExtent *extent;
+    VmdkExtent *extent = NULL;
     char extent_opt_prefix[32];
     Error *local_err = NULL;
 
-- 
2.26.2



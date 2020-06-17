Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85639C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50608208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mysuse.onmicrosoft.com header.i=@mysuse.onmicrosoft.com header.b="LJYGddGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50608208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVMt-00030K-Gb
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVLt-0002Ao-SU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:31:29 -0400
Received: from mail-vi1eur05on2061.outbound.protection.outlook.com
 ([40.107.21.61]:46817 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVLl-0008PW-M8
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:31:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKYaRjtDXbGNBCNKb8o0zTrv1IFm7nxhxT8tv5h1MzwjGZEB7hfcfSmPAJyqznUaLeVxTMb9ZqVs86ed4C9uDHi9AL1NYd/seNwwzT8b1RFxh9mE2UT3U5wAb/ietyjDUixMyioedCAWxjwI6DSnqIe0EuZIfa+kVR8sNa309fSlr0/xtWbvvAD/d2DhSyvUOhaCVfX0BRLXw16ofE7u/8kfPnd18mge7Ru3qm8Gd9/ZVO/oTQXkBsnaatSRd1PqZYUVfNQ2N7KOnw6vSlH5LjSEwWxQAe0elu8cNf0JSaTkvfOlAWiZDYZgmlOPyRJsJtsH0l3r4ppaPB+Ef9Cf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjgdY45G2B/P1e9HyyJEIYGlVAq8rMncFu9MNoqpXrg=;
 b=KYETjBk7MfSXJnO6iyg/0bJD0OeMUxp9YFa2BsmRBV4zSIvGQp12ceTMu8fUhwuKDvaYmgmvHSdd7gDrRG2NdDTCs4+wbgD8Vjv4BNnOcTn5hpBNP+eaIQwyHvFLG9jT6kDqriPRaodYjQB08jeMLA2HoIsLCLbM8kXkembwYp87OhZ3bl0kAou2jQTzMIkjZeNWsG0WeHzNZ2cu6kT0KYfQcBnc7Apn0TMaUsOKIn5Xsk3yvYu8hP37mLfOwgb431PyaW0OKBzkAflu0nVCt8LB54n97bQDIBUXmMrSD/uRUqHdpkkvjjmUozzVEgOZcGDqY+vY28kmLOicokKZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjgdY45G2B/P1e9HyyJEIYGlVAq8rMncFu9MNoqpXrg=;
 b=LJYGddGaa1zTqo4GhU8JfcrAzWDMOC5u6stRAY5VlYrBT9mKW/3hIThSgVtagNC7M+S6dk09phsUFTG7TZpV8yJ65y8PXabeajmL13lRhX9Rriod6ku3ESTw6X/vAsPpG57L0K2IOSYt3p/bNcsAuxaaDmtrkPKTqwmnkqdsSSn72wbIuKt4Q5YMnnm7LGAUFooqOJboVqLWWgqy+KxEocgSEuIfzA9uP+6IOLQC+2QufZtjXDGZrIs3D+Rp+MZLOofY0gQtvE5BogbyKwmw7iRI6BEiqiRpzJR8IspBo3g/JxBDbJk0+NEwuF54yHG9GoUNZGE+V5odd4sDF4za+Q==
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17)
 by AM6PR04MB5815.eurprd04.prod.outlook.com (2603:10a6:20b:b0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 10:30:46 +0000
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55]) by AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55%4]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 10:30:46 +0000
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] block: Add bdrv_co_get_lba_status
Date: Wed, 17 Jun 2020 18:30:16 +0800
Message-Id: <20200617103018.18026-2-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617103018.18026-1-lma@suse.com>
References: <20200617103018.18026-1-lma@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM6PR04MB5782.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (114.255.249.163) by
 HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 10:30:44 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [114.255.249.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef252621-e298-4ea9-1d8d-08d812a97f2a
X-MS-TrafficTypeDiagnostic: AM6PR04MB5815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB58152D8710B589CE4ACFBDF6C59A0@AM6PR04MB5815.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kxa3IPvo3B6BWiu1RlsveUJN5Kz6zBPcSy+TiRb8Zo5RFu/54SFjVfcZIVGwu1b4m5fTZGxoOu79dv2NuzTx+tfvqmKwOhv7ZJY2fyZTJIDZrJwXTbE0IIPOTIpbA9/RSMkpHIx2f5rIo4UBmCghbGQNAVYXnosuz50Tslo8rjuoLvI+8wtPwnlH3aRmFq7uD5hAc7PP7Zwk55uwcHagyqbdOVYxM+dsVfhesrWg4lnkeAtWSQ8EKQt1y2sFnyg4n/o2oJjxGzX2/Ez7+zDiGT5TWTy0wdlVTKsyCkchEFzMs+flCCyao83nXEuANRF1/UOU84h/sRreXq79Q042f8+w9VGPQhO7IZGBt22OeiU+VHpq1RxxybQ5Sp2n3Pv4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5782.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(5660300002)(52116002)(6916009)(66556008)(478600001)(6486002)(8936002)(26005)(8676002)(2906002)(66476007)(66946007)(6506007)(4326008)(316002)(36756003)(6666004)(6512007)(86362001)(107886003)(2616005)(956004)(186003)(1076003)(16526019)(83380400001)(69590400007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: G5/d8bOJElZyxMaTdnF3Nc/rRHuH1mXC+BcR9aKSaQbF6Y/YWe+7NoZFbTLIMgM4Alvq2qcsV5ojAQhAMssCWXDmbjKlxCqA3hz6SrqNM5PCtQ6sS0bgVNRAJ6t4nD+PAd6wZQBw+AnEFnV6KgPeMeHuATLykKC8KSbr91VItNp1NM8BQ4roD0MinR3uFv3WvLkPjVGjMtWcVYh3tA0JqaHK7n0z7Nen7hJJseOJgFqhbYbHkMEy7AypFOYvDj5APsX8e3/I2dGr+NPtSm/wPe7Aw39Z5TnchYO9G1gLfn2wHuCMHgBfeFpUl3euXlU8CdkGiWnD02Wv5DUfXILTdiniP5tMQCltctQaxNyjVk7dwEUbhbF6C2F0/XKSAVxZoDsWLD+OYZnk6mWVcSaLW1Pe5YT7KZMQsaPAaFCzemW8G7b9ZMkbKOdj7flAVZviW8kohb3+usPm7g+qF6ugnfeIuuzyqj8PMkLcgqquHYs=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef252621-e298-4ea9-1d8d-08d812a97f2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 10:30:46.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNdW1kO7VpzpX+IDcP1PpGeTA1Eq89RLaosK+hV6UXvMsU8OsqtDl5xpGVmffTXt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5815
Received-SPF: pass client-ip=40.107.21.61; envelope-from=LMa@suse.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:31:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Lin Ma <lma@suse.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The get lba status wrapper based on the bdrv_block_status. The following
patches will add GET LBA STATUS 16 support for scsi emulation layer.

Signed-off-by: Lin Ma <lma@suse.com>
---
 block/io.c                | 43 +++++++++++++++++++++++++++++++++++++++
 include/block/block_int.h |  5 +++++
 2 files changed, 48 insertions(+)

diff --git a/block/io.c b/block/io.c
index df8f2a98d4..2064016b19 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2208,6 +2208,49 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
 
+int coroutine_fn
+bdrv_co_get_lba_status(BdrvChild *child, int64_t offset, int64_t bytes,
+                       uint32_t *num_blocks, uint32_t *is_deallocated)
+{
+    BlockDriverState *bs = child->bs;
+    int ret = 0;
+    int64_t target_size, count = 0;
+    bool first = true;
+    uint8_t wanted_bit1 = 0;
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return -EIO;
+    }
+
+    if (offset < 0 || bytes < 0) {
+        return -EIO;
+    }
+
+    for ( ; offset <= target_size - bytes; offset += count) {
+        ret = bdrv_block_status(bs, offset, bytes, &count, NULL, NULL);
+        if (ret < 0) {
+            goto out;
+        }
+        if (first) {
+            if (ret & BDRV_BLOCK_ZERO) {
+                wanted_bit1 = BDRV_BLOCK_ZERO >> 1;
+                *is_deallocated = 1;
+            } else {
+                wanted_bit1 = 0;
+            }
+            first = false;
+        }
+        if ((ret & BDRV_BLOCK_ZERO) >> 1 == wanted_bit1) {
+            (*num_blocks)++;
+        } else {
+            break;
+        }
+    }
+out:
+    return ret;
+}
+
 /*
  * Flush ALL BDSes regardless of if they are reachable via a BlkBackend or not.
  */
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..43f90591b9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1296,6 +1296,11 @@ int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *bs,
                                                    int64_t *pnum,
                                                    int64_t *map,
                                                    BlockDriverState **file);
+int coroutine_fn bdrv_co_get_lba_status(BdrvChild *child,
+                                        int64_t offset,
+                                        int64_t bytes,
+                                        uint32_t *num_blocks,
+                                        uint32_t *is_deallocated);
 const char *bdrv_get_parent_name(const BlockDriverState *bs);
 void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp);
 bool blk_dev_has_removable_media(BlockBackend *blk);
-- 
2.26.0



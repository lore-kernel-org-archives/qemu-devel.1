Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E24C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15F8204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KOcdXE1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15F8204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgty6-00041l-0Q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsO-0003AI-5H; Thu, 04 Jun 2020 13:42:00 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com
 ([40.107.0.103]:11696 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsN-0005oK-Gu; Thu, 04 Jun 2020 13:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REQyw6cf4RelmptDU5ugZqfeOYOQq5G1pV0rB81BDtnp4yuUGggrgotSNaOnLKrNOgXDnvdB2R8XQVQTUUgIm96yZEHN2Xi3fuDsc//NMmrrhAoILqL+6XHRA2LrfHjI2x2Q6zvV117bQouM919pM/6+3TKO7yQTDsX89KUJdMiK11GWIT1H9teIthFtYUV098DbPIUBCVm3eIl8vBRyZb+QrDkWeVmWNTDvHwXxnA5PLX/VoBH3jRZZmAG9CmDDNlGtReMtCa1YwGGbOLvHYMbhsHdda6BtC2xviW8MuLtlRbZebPvLVz1hD6pjxekYblVFyhVVnTNFCvq8SR9TWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRY4YW8JNkMvjfJ2rapnWPP4AdsS3y9ldVH+VQ8hmEs=;
 b=YdZeR2KSbcFtKNy9el7GDLH6e9Lh676v0SsG4LhHcIdNhcd/L5KSH4pZs7xspp1obCWlKoSK14ZZFKuoRblQRMZ34YGq4lsm+pcp97ixPpcuUWckUBMU32058y5b+AP3i22FdM2OSPc3Xis2iCLizHj1I3BhzwxeIvA0N2igcLORQtetWnwPLigtJCRkeAN313bfY+eepzFy1Q6ziiqDrSPxu5Q6L3iaxVNZ23jMlJEPYInDWxwx9zX65IJWKdAlcFRB+68cHPtTZZnhz+kgfXhHE3gEaU5DG1xAvbIg/05chCgYzE24Ajz5f79k3nqUcPZrG1WFSF8PZV8uHoTddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRY4YW8JNkMvjfJ2rapnWPP4AdsS3y9ldVH+VQ8hmEs=;
 b=KOcdXE1XJP2Z2NOsz8WQ3k3pWqo5hbKa+U0AmhTGP5sJNkz6mweR11WYpDRD5EuJ0SQyV9+h0oX9LcJklqjIhtmRbAMvD3EpjfhrjdhQoho9uFm+TKVEuKZm3Y7civu/BU0MDurfKwyg04Appw/HFqlZFwowXXa8MCOtcMvpXiM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 04/12] qcow2_format.py: use tuples instead of lists for
 fields
Date: Thu,  4 Jun 2020 20:41:27 +0300
Message-Id: <20200604174135.11042-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200604174135.11042-1-vsementsov@virtuozzo.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.190) by
 AM4PR0101CA0049.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Thu, 4 Jun 2020 17:41:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bad0ecb3-6fa1-42b5-aa3e-08d808ae90e6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381C8EC132115AF7B15F0E7C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCjfnvQOsdrki/ug7C3U8aemU96jxWIjXA0cYJybO/B7AbRJsFg54vqYCQvhfz0sRHTtq1d/aCZ/d0plsWtBJi1MwmEfnap8/G0Ae9GvoTuwqhYB09SXgXp6i67tWg39L86VtYjIwei0/pcHqzqCGL3foYobTWBS31HgWHJTMrxIFa4lMxbroSVuvFQaKqob5fRqtNjFd+d1vMMKpIjmnRDedwNihzVfYBOBBdt4BQBxVs9WjyrHDCKronhhBPlZWfuJ8Vl/B2GOuQdlL/vUJQ+1ICy32VRcdKiHpUEXcy1Xr6Mxu3cjn5+4fhmPWnlaNjws58Yycm9T8FLjRbdCBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8JwYUe2TfG5AO5+W94RC0SQTEbcO1Mu6iNdvFk6rWVhwfDJD/RxJFQSoT8ZobWj9z24NZuD8e8Z8QVIh8lWJr46Mp3J4HiSwYaUEaODjGFnri2mi9VwgFTFsLragANwY9YGdfUPKmQp3PAEJC3wLeDgMjLp5k58StzvZaGkHQb88VyGVInrjz2nydJSOVY0aGD646jrjnkJrMVkZSwSUigZOwmzEzCwA+TikX9Q1ddjVGZup1o0fW3K/Ai40iGAeucZ4mgX1kzygPVLims9EQxHtV8/H28i3dJlyfuSwAbYbl+ZWLxmLBXWQpyJl+yNaFe17/uwpI/77/044NNeIc9afvS9/ua06XbkNKXbrgCn69KHM/UM9Wh5w3WbzDkiU6hUTVvD+JDidWGAEVv6JcBxfpLPeWKoIBN7uAnt7fCJLWztzrk1Epx+tX+lNCMVg+lN6B3FLxowTQBwSqZQ1CKe3dtXsr9vkHiTgnApA8DkuouiZIw++Al8lUPBxwg4R
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad0ecb3-6fa1-42b5-aa3e-08d808ae90e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:52.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn4wwH9pOs3fapQClZWrYx9oHzwmqa82XfV0l+INYGou0d46GQQoImU5Le1sOnPQECULp9niwI59opD3nP68tBZX+3prN7LPU52mGyUy61g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.0.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:41:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No need in lists: it's a constant variable.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 99e5248e73..5d242c4aa4 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -23,29 +23,29 @@ class QcowHeader:
     uint32_t = 'I'
     uint64_t = 'Q'
 
-    fields = [
+    fields = (
         # Version 2 header fields
-        [uint32_t, '%#x',  'magic'],
-        [uint32_t, '%d',   'version'],
-        [uint64_t, '%#x',  'backing_file_offset'],
-        [uint32_t, '%#x',  'backing_file_size'],
-        [uint32_t, '%d',   'cluster_bits'],
-        [uint64_t, '%d',   'size'],
-        [uint32_t, '%d',   'crypt_method'],
-        [uint32_t, '%d',   'l1_size'],
-        [uint64_t, '%#x',  'l1_table_offset'],
-        [uint64_t, '%#x',  'refcount_table_offset'],
-        [uint32_t, '%d',   'refcount_table_clusters'],
-        [uint32_t, '%d',   'nb_snapshots'],
-        [uint64_t, '%#x',  'snapshot_offset'],
+        (uint32_t, '%#x',  'magic'),
+        (uint32_t, '%d',   'version'),
+        (uint64_t, '%#x',  'backing_file_offset'),
+        (uint32_t, '%#x',  'backing_file_size'),
+        (uint32_t, '%d',   'cluster_bits'),
+        (uint64_t, '%d',   'size'),
+        (uint32_t, '%d',   'crypt_method'),
+        (uint32_t, '%d',   'l1_size'),
+        (uint64_t, '%#x',  'l1_table_offset'),
+        (uint64_t, '%#x',  'refcount_table_offset'),
+        (uint32_t, '%d',   'refcount_table_clusters'),
+        (uint32_t, '%d',   'nb_snapshots'),
+        (uint64_t, '%#x',  'snapshot_offset'),
 
         # Version 3 header fields
-        [uint64_t, 'mask', 'incompatible_features'],
-        [uint64_t, 'mask', 'compatible_features'],
-        [uint64_t, 'mask', 'autoclear_features'],
-        [uint32_t, '%d',   'refcount_order'],
-        [uint32_t, '%d',   'header_length'],
-    ]
+        (uint64_t, 'mask', 'incompatible_features'),
+        (uint64_t, 'mask', 'compatible_features'),
+        (uint64_t, 'mask', 'autoclear_features'),
+        (uint32_t, '%d',   'refcount_order'),
+        (uint32_t, '%d',   'header_length'),
+    )
 
     fmt = '>' + ''.join(field[0] for field in fields)
 
-- 
2.21.0



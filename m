Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C6CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C11F206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="u77ITSb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQAI-0004lh-Hg
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ31-0002Qx-Lp; Thu, 11 Jun 2020 12:27:23 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com
 ([40.107.20.110]:32417 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ30-0006oc-0z; Thu, 11 Jun 2020 12:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHQGx+AsOM8Rgf3OVX927d/yROPImF+qtoae2oUhjllqy8Hs5Syb8tOCmcWiMCT/+om3CxbKLZ298GI2bPn6rp3ohNK0q6/jFlYHAOVdLHAOVe+v6IMhxCKc7dG8893mOPNe3uHgFoSA/bxVzss3bFPzYSlkgY50YqDSBzemKBSTmrNRLMOaa+QS8KTt2etPijRqxE+ANgQrRIYyPPbXdmhrcJrWyRXAk3o4tRR7xjIPTz9OTjbiBqOTTl1C8gVFh8vL9NflXGYeIEd3Bfhpvk4ROGyJX1kNa13Qo2DPjMjVD57hqpet1SSEUmEmPZ55xNuHPe2V2IKakb1Q+KHdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xrQeysTFjb+GCyru1t/kK/l7QxTARdCZVDvohnjes=;
 b=ERs1Fz7UN0bKw66eJxy5SOK8GurZ7ZxpNpsY5lCX5HQ4IRQjJ43Ia2RF3+rxt7q5du1fKISrRZ93wGnklKkS6SYAiDcUXJCE6zwA7ftIHkPDmAHnrtLhfw6gKkpPCrNY5wMkscjw+YbvQKtiZDLbC2wY/d6refdiCz6HDPF/6TWJ61qIxdk8WgAf0bn/MU8T9udW+74iT7CWFe2pXaOXKVmk1p6ObF9/zIRKB50f+y3oqdeXTgdG8HWJjEqmHu4lKdK6xGOE5R9sLAfl7KtpS7gJfpsyTaH/vPybBi7gxN4ARZ3MpNdWKcnVzinFJa/30tI3U8L1d251Lj/J5VNLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0xrQeysTFjb+GCyru1t/kK/l7QxTARdCZVDvohnjes=;
 b=u77ITSb28ZeBvhGFFbgujFUUDwCF8y1RvLIJe5EHnVH74DzLinfRhqNRExVNTk5NhmTTpb1+7vvgokQvT1HfjgkhN7A7gRg/bB8Ly4jvqzwdKPquvsdH70oGSXTc8GaTSwARrk1axVm7HF46NOp2TejAoLtCm3el9BMQCZOoUfI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 16:27:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 16:27:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 2/4] block/nbd: define new max_write_zero_fast limit
Date: Thu, 11 Jun 2020 19:26:53 +0300
Message-Id: <20200611162655.4538-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611162655.4538-1-vsementsov@virtuozzo.com>
References: <20200611162655.4538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:207:3::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.159) by
 AM3PR05CA0148.eurprd05.prod.outlook.com (2603:10a6:207:3::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 16:27:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12c565b-de40-4f3d-c7a9-08d80e244bef
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549374FA86568C16FDCD196BC1800@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtUPPue8DLLVLDu7ejjWdnmB+Ud+FaiSbGkTei00nBUrweUwAVGKQoZEl6L4LI4ShJ+/zfKWwby4VI1BRCMcm74kBhjwe+g4Ted8CG2I2nnXtLWjzHinjmRL33nbxH9Y9Eb/BhORRkSQt0VHGmERxMkGaurnz4u8YrBH/k2kjD9+LX1Fe2qz2ZOduDH188fZhSQCt1IsXumoVcFIw+QLb7VlVLvc8PvD+Kpqf7V90Yb5mrEhOaozIzWfKTFeu22PG2+SwVhziLJIN9MPd3hhWQf0ZHHAHQLoypaKhOyvVoWnRLyJKGnWI5apPC6LGz+A4PZyV0o/nmzg6Mign/Uq6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(6512007)(316002)(478600001)(16526019)(186003)(8676002)(36756003)(6486002)(8936002)(52116002)(83380400001)(2616005)(107886003)(6506007)(26005)(956004)(4326008)(6916009)(66556008)(6666004)(66476007)(4744005)(5660300002)(1076003)(86362001)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: syY9TFXlGFoeE2oiqgKY8uK8Ba5G/s0woulIk3gb4vGKKUFv+/BFgz7e89pH8IRbZ2HYzVjspkhVddPTnIRkV5HmAc9gyNdr6bgxO81O9+thaUg0TplaHqqrhghEaXiGGPsgj7vrXHoqFi/ZTKMkCbW+4D3wGci+iyTxzQnIQaiRA5IvWZL6rYUOctlhQ7paqP7+DxaW2CDpBFXR2aq3329IlFN3pZlGeqZAY3T3+t3JUCPifFwWEHNyl4Ny6Q0RLLTEGUKBxAdbgv0fFTz1wM0vRPJAdSG+xxZMzxPWzx/Sf1oVz8z+ml0EbtKFBiS7gml1/is+C92iNpsfOw4St7fr47xs+mmr20Sz8dkqwGj3QWsl+VfpdBRXX052VoTPwkkMkAjPeFsN0L/PH2O3gPyHUA/gcpJw4LXDk0fGXmbDUG7+YimyXxnP5UFrNMvyT6fQFBH/y6vd9il7FXMFS63JUtV/bW2XxG4EqmlgI4TWrxnex5Y68NHJpXwgDx6i
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c565b-de40-4f3d-c7a9-08d80e244bef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 16:27:12.9746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfc9RpgOlHflZ+sLybNM/Hki5qn3TYO1HdslmOXsvUzO/6UkpBJAl+U3t0ZFh04U03K+g0UF/xNdbNBUXG0xfT1PlGcsyv5X7sTH8feVOrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.20.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:27:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD spec was recently updated to clarify that max_block doesn't
relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
mirrors Qemu flag BDRV_REQ_NO_FALLBACK).

bs->bl.max_write_zero_fast is zero by default which means using
max_pwrite_zeroes. Update nbd driver to allow larger requests with
BDRV_REQ_NO_FALLBACK.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 4ac23c8f62..b0584cf68d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1956,6 +1956,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 
     bs->bl.request_alignment = min;
     bs->bl.max_pdiscard = QEMU_ALIGN_DOWN(INT_MAX, min);
+    bs->bl.max_pwrite_zeroes_fast = bs->bl.max_pdiscard;
     bs->bl.max_pwrite_zeroes = max;
     bs->bl.max_transfer = max;
 
-- 
2.21.0



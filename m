Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97601C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3FD2073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xjaml2c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3FD2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcEN-0003gb-97
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDA-0001vf-2f; Thu, 07 May 2020 04:48:57 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:13902 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcCz-0006Er-5e; Thu, 07 May 2020 04:48:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0r+wwyT4DLPB99vAIOqs0goaIXrXr0lvyB8z34WFySiXa+5rBxaWCrYakvMdRe+HMIEZpRlbbygRDwitFUUOD5XRK3fvivrjIA9SnbsknazYBZRgbQQOe3UbJmhyq1RirrhzwZqF5xcQ24nLU97aA8DCjEWJUIV5wsSCbF6KiS2PB92Kz+9tGEhC73D62X4FPhg+8MsR4jaVNLSvM9eCDwHSjEzcwTJQIT2Zn1x2/uNbC2O0FNRXk/YkLJOUtgC/OJJG+aDS+ib/7Gdc+vQ5cGIVekKt7RVySInZXunfLjSxGpHCEEytH36cWqMXf6PbMd/hkI/pLqrnzyexR4Cww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4pWlrhdL9T8Rq4NVPiPL4D8ieKlvCJLtG+/pIFicvE=;
 b=AAd8O4VgwVJFxstNHCeutX07iu2w8K1/bxvVYVxHVHD19YN76AEjeD+CX7HOpG46upj3IiAy/w21qMGQp9XZkPPEEMIZNIxq0am8Sazzo91Q8hfvkkmVXY6MOTM38HQlbX/DNGgiXPLIAr/fPvWY82mcOto/gEgkWu5oOroLY8J5NwtT+BFFrQNwXFC5F5U9SjRaBDFlDtEb20aWYXYiUYJA07StkIx29aquWJ+CsXwur3JcBCbVyIaSI2pUSQdQZi5R6dPF6x+DBciN7YDOzFzR/qRdppwNIzyx4MlMI3OgDkVHTD/P5wrhYOg2zZG0EizcZgknf45CcIHr74Bo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4pWlrhdL9T8Rq4NVPiPL4D8ieKlvCJLtG+/pIFicvE=;
 b=Xjaml2c7iEjcll+rLARMcLOHnKUcYl/pKvfz+rp64PHfXeO0vpVt4lWlfRfvy9rPV94WNVhD8HyRLWAGsiMaZfPodGClCTKf7JQlbZt/oIzDHZyrF7W9q7s8IyWSuFqOt5+XCN1o1TOM8QjOH5Y83EQxutowsLNBW8/I4kPCuoA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/9] qemu-img: convert: don't use
 unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:47:52 +0300
Message-Id: <20200507084800.20596-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7acfce8-318a-4ccc-1c67-08d7f2636ded
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495A621F4004C709C53F520C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2I94GhPKAElWc32aPhUWS2UVmrPlMfJWsTeBMf+3JHNt9A1sGlhF0xUvL9UqxSwksPjOOmBXpYtzrJ3VUfDlWsk5vezjA1HNdEfSFhVI2CO4fiQM/tQt3EBHBqLnmqSdcvWeVEeIXUNa6QkHIqN5bGky6n4uOaBMz+evUE49CaoEUwawVCrlm4mc0VxUzxEar6wGR6oZwNBGX/gBQaChdtm2sJxgovmYFGvo5d0jLgRZ6btTwZR5325UGbmCsg48lXr9gH4BU4nJiFf+7K+OX00/2sCWYAyAB5IA9HCqnv3BAUVW6lyw5y49YYhOGof3j/O6VhbI4b8tkCPQ/+3noU36J66a7aSuzs0b0fpqgIB1a8rq1rY7K03om4wqYio/zth6aCwXHnikDT2FOVO87Td8ZofutRR433ASrZQyWMVx5y4ubQkgzGHUBFfJglcLOvQv6BSi31nSstM1yKh5GNZ4GFCzx+ZCn4bsZk35WoPw1z1pi4WGGrv7JsGVm3ga6n8waQcz1USUxFdQHoxsxyOhyQEfMcEtgU9DBMZe+slKYHUC4JHv4wbb4NqVZMXh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(66476007)(66946007)(66556008)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dThsPGRrlaslBYljFbH2PeOHMUydWdxl4SF8GDC+vmtnUyAqnO66G14Sf3pP8rU92ofNhDBGZQy+3jmLQUf9SfCIouLvHu85UC/qhVqsqGt36Ueiii/SAwDynbGtdi90zy5iUQbA/Hi6vGH04zIPtjidNF8VA3f8O8Cq2BpfKzADz3w3nPbv73xwe4EXM/+16oR1+uZnPLjrV80+vSqe7SEELZzV1SD1qSlp3ob4U9oHuxvCPKL5fLGP8dXgm4V15MIZrGipzHkvPYTRa51XSjcDFXwTWBxqpfFuhXqjmszIsnUf8OpkobezDAT+M5leU1/ZFrSBBnVw5yz2KOciYTG3wHgRrCNdRHoVLs76OXtUwNlOabw1hJvBHFbop6nTmhBtX97gngBlWrEvx1ChO5kEUKYRN7CB37t/cj++fmx5KOhJSySYvy2UmizkrNyVS9RLouxvBrrKkbDBa+Vs7MNx20j9784vkpR1c3MII4uhDDW9XgnP1sJkFoCpQwN+pWrfjKWeBMsoPTSCpjs59mEMcsaE3O395UYxuLM8uqGYI9pO+nS5kCpAFhO1y7nGu+ZE6nDLS+fj6w/7lx5J/SfPFIhIDlq4oqKqdmS5e/KhqTxEWgv3b9qQ/NVN1ASxQwV93+vmB8HX1RsO/aiz3XGVom46/JbTeTnKvLV9Ufd7u0Tkx0nEQM6hRQ1dDiwmvo6gru5mN/Q2/rqkC1WWb7oJkNpeT+w+Vna3fMh0eqik4+mZbgbDLNjhCXE+pjoqntxIH94NjbHMMkfBfzOBmydkWxjORTFGqVhhx/bc6DM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7acfce8-318a-4ccc-1c67-08d7f2636ded
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:35.8225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mawCAlJgB5sz98iePCwJubWpGELx/YRUKNaXRWjr5nfJ1FyxF5Mhbvt46TExydM9JX/o4CcJuqAxAn1pfc932dW0EYgonzDTae1XRBR4eZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu-img convert wants to distinguish ZERO which comes from short
backing files. unallocated_blocks_are_zero field of bdi is unrelated:
space after EOF is always considered to be zero anyway. So, just make
post_backing_zero true in case of short backing file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6a4327aaba..4fe751878b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1632,7 +1632,6 @@ typedef struct ImgConvertState {
     BlockBackend *target;
     bool has_zero_init;
     bool compressed;
-    bool unallocated_blocks_are_zero;
     bool target_is_new;
     bool target_has_backing;
     int64_t target_backing_sectors; /* negative if unknown */
@@ -1677,7 +1676,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 
     if (s->target_backing_sectors >= 0) {
         if (sector_num >= s->target_backing_sectors) {
-            post_backing_zero = s->unallocated_blocks_are_zero;
+            post_backing_zero = true;
         } else if (sector_num + n > s->target_backing_sectors) {
             /* Split requests around target_backing_sectors (because
              * starting from there, zeros are handled differently) */
@@ -2580,7 +2579,6 @@ static int img_convert(int argc, char **argv)
     } else {
         s.compressed = s.compressed || bdi.needs_compressed_writes;
         s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
-        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
     }
 
     ret = convert_do_copy(&s);
-- 
2.21.0



Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2951C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB4A21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A5sc6T/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB4A21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL75-0005rL-B9
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzU-0007FH-Tb; Fri, 18 Sep 2020 14:20:14 -0400
Received: from mail-eopbgr40122.outbound.protection.outlook.com
 ([40.107.4.122]:8096 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzS-0004bq-TY; Fri, 18 Sep 2020 14:20:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzp1oRWpvKqhWhJxvIBHE0LFGhQyjDdiOMVKhxreBOjwSe/0mBpZPSGIveM6dqUT2iyWBoIlQ7Hbq5mkooWy1MIiRrihPZGmxCFZ7Gxpn2fxzANmkv1T0hP2ntG+1BJ0o5XOwjD8427XQVamOez3AFdWMLu6VkuseOv49KjWZCQSciZcjCD76AbOKeJv26SfKPJtWzzWy06o/03LB5kC7nOQxRObkxpuTFsy8ALJEZA9OkE23FI5WFoYBf/IIjtBy1YGEcA/I64WTDVbb68BiVF1RrwkgSxy/UfxZXotG8tifOkPsjSJztEgilWoL2M8lseuaoPL6e0q9nyXB+bF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9ffJp3GBUYCdrFi6KtXODZCppuTk4IW7QXFxAvnO5Y=;
 b=dQpY6r4nx716yEo3v0IRu2U61/49lynvLmXhZboGX1r09LFrTqQBXKcg7XZwN5YOD/exagWsocWibtz7v0+MdoPmvnW04OYXpFlA9e1FF1gYfBFACkDUfhLa1bbrXTyA/tUrqRJsvtVWu/Wt27QKEsKoffKE6VjkOp7MnL68W5BFOUioUHACXPy6JJgSaUaNMj3Toth08wctokEV9VDCFP/tToMFRD3CaQNG2ZpMROaeNGtBgyN+e9yUsctc5OL79eFCZxsKuxqBP5XAvhR95yj9tXV0E03lEOM7/h0kGaRfcTiQrtyQ1NwQHKNfKYN1hWsSh4rNuQLiuI/oQ2C0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9ffJp3GBUYCdrFi6KtXODZCppuTk4IW7QXFxAvnO5Y=;
 b=A5sc6T/lFlVo3NwptabZx9uMrOi0ndbVrjJzWIDpZ5WaHmtShDVeWxm3uIxRHzRAm/yF3lJopjZXjnMwk+KTsFsTYv9REgn5RZFbZf+MKniTCLYYx9PCn2cIJKaA0O8TKlQ2n7k9TGBS14myF+eQ5veVL9lx216MuDSifMGkRyM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 01/15] block: simplify comment to BDRV_REQ_SERIALISING
Date: Fri, 18 Sep 2020 21:19:37 +0300
Message-Id: <20200918181951.21752-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:04 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2926856-ff6b-4bfa-5c87-08d85bff773f
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB19051C95CC25B6B95BF5C766C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1yGL27zMoJynJp0FNDIiu5Xsq8ixEDa2ezrgcufUDAalX1j8xEAwmSJ28E+DgM2VDjNjIp1rx4ohe/Sgq0F+LKaPDVD/HCOCrMkNoY7vo1zY2E8JM0oe7L8Pju8pC5mY9cSCrvpNRlhKO9AiIAqKL93f7ubJq9mZevFm8EI6DZM2QosMC5asLaQXIFwXNgmW8ICSFhAaNxOdKse4y4z8Ws+d94KyEujeDFm0QVgV+7Fq5k3NP3GGA4Sg8WeBXoDviXX33JO37d0RGCueZ4nRLVfH7AvKoI7dd1Pdj0IR9MRN0DXM7gl/yakaUqMfgAfh1kWKMya/6gphJg+fCe1zIz/LP1jsWQZWY/t108sJw307KK8oJ28foClO3RCflOP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4Hb9c4Gj0jjsJ6NKYsluePgNufi4XFT6KL8D9xUe3C/0ddoGSSeXUe+EKDj4QewiVtt9TL/plRT96wYrYi2kc4sdFx7vygauYqhKuVjVmpVagLe8JBj4Kl/JbQ1DvfKpGv3QY0zxKT+TWlQO1RtGf8rFDFOHYtQXuf8IhjGSCludVj85jwLiUP32zaq7GgpAzkWwrEgKNowyuo2f41nrPYpXLwM1kKSzHsrwCdFE3ZJd/w4IYFkToKPZ4jN2XAVceozVHOOcll4xwGuDbMMt7HtV6N6poDTnj3S8qGLshxooLtnAre4fewPP2rZDQVMeJtcQj/R18gN7dLy/TZ+gGmPtGXW6/XZIOsW1L9xViKecemNZGQzC+OyjiHMzvYqzXKFwS7ke3wLNxN8IAzBSzS/I1/4AT7Sh5642yGSxkVqzElUsjUwVwop4jBC+dSAuNC7JcwB1+2y/45es24Ns4REtXw+8IECkCqt35UXoywPgXIrn9mno0qiOt+c78QpH6jtNscg3Dn9FYsLxUpvUP+eQVEZaGfUmiyQyZVdgKW2mQKkGglgN//QegDyoyNa10WJ6AsW/NE+G76pJcFy+Sq+d2ufQWIqn62UavSdAups8ENZUT6qU/0fHBakgb43HxB9uh3bbJUQmU2YJZqHIVQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2926856-ff6b-4bfa-5c87-08d85bff773f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:05.0863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THaL75kgILaEbmFW6lKGljOxf6r7nCj8SNeLe/5piNAKl1qFJ975n34ZJywUO+pMibKRSK1M3kssSDqOvZix0fO2kn0dfGmZ6mJN72W1LWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. BDRV_REQ_NO_SERIALISING doesn't exist already, don't mention it.

2. We are going to add one more user of BDRV_REQ_SERIALISING, so
   comment about backup becomes a bit confusing here. The use case in
   backup is documented in block/backup.c, so let's just drop
   duplication here.

3. The fact that BDRV_REQ_SERIALISING is only for write requests is
   omitted. Add a note.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 981ab5b314..ef948e3f34 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -53,16 +53,7 @@ typedef enum {
      * content. */
     BDRV_REQ_WRITE_UNCHANGED    = 0x40,
 
-    /*
-     * BDRV_REQ_SERIALISING forces request serialisation for writes.
-     * It is used to ensure that writes to the backing file of a backup process
-     * target cannot race with a read of the backup target that defers to the
-     * backing file.
-     *
-     * Note, that BDRV_REQ_SERIALISING is _not_ opposite in meaning to
-     * BDRV_REQ_NO_SERIALISING. A more descriptive name for the latter might be
-     * _DO_NOT_WAIT_FOR_SERIALISING, except that is too long.
-     */
+    /* Forces request serialisation. Use only with write requests. */
     BDRV_REQ_SERIALISING        = 0x80,
 
     /* Execute the request only if the operation can be offloaded or otherwise
-- 
2.21.3



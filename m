Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C47C20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 19:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vwMTbpcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C47C20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5N4-0003tD-6v
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 15:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5KA-00073D-JV; Wed, 09 Sep 2020 15:00:06 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:14387 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kG5K8-0001M1-P5; Wed, 09 Sep 2020 15:00:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5JoslBpF5lV7ughfKmaRQZxIQbQ+6Rf9NT1kqEuA8mSe7x1Z/Mf1LF9PzkOSWcO3lBstylT09VHTaaCYwr39rfhNa5CSk/AncnElvPWtlAX1SFSMgkY/bnhmoaSR81NME2g3Mq1yXCJutbUBcVbafwm6ke6UKuiuwcT3HRQk42uFojjyPKBXmE/MlH/dVJ/t12UZwLhYJakZKFZrg5SVgLPGYDAFm/dWQ08SyOJpln2HniQQVdInduThpirsuTVX1UbaHNX57xtt+EgNKgqP9AZlOXSzeQS6TY00CvMvqVdeExTiA1ICfUJNYny3LCloldgUZr6GN3TTkodpmLB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsj2/PUC4zOBRvjUfSKF/KPkbBu1UYS9keicgd44Ulw=;
 b=goL6HcFE3A/0StkYckqhfFQskrRUYE8hL3EQJ00661stsUsWObnbjmYXTQvo3egxBth90Rt+gw0LCROGm774IWhBAktvrKYaS3J4ZAoxFkOyepLVZaZtOcdhvtZyw9xPN0wClIGqZnL68Lg7+UcdkLW91qUS37dnUxkNWJg7ckC3waPNwSO0o48U36SGTh4+nU032SoycsQILuIowp/DCC588f/BEILkdbsZGZUak+nXhitaZ4IYrRHm9dbaheZc1+PWoO2oYIOPIvacUiknwJi2Pa76MHp56e/94QwirJg32k1hqTZXMYkoFsXIOxE44qEBcj/7OrBVvPJtJQZEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsj2/PUC4zOBRvjUfSKF/KPkbBu1UYS9keicgd44Ulw=;
 b=vwMTbpcs42Ck1u7JF6mkVkbOJFkza1xANo1gbZgLc9KwJ6rvATyt3+6tMl38nQOcpKfIBYpEtUyCmk0Hchs5ai9fxXUUAeZRX7FXrG1FI3G3Q7cU9tOgGWx+oSY69WzbbqHyvdoMChEM85B67d2CESIlAkYPr42O1O5O/IIskjk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3445.eurprd08.prod.outlook.com (2603:10a6:20b:43::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:59:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 18:59:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH 05/14] block: drop extra error propagation for
 bdrv_set_backing_hd
Date: Wed,  9 Sep 2020 21:59:21 +0300
Message-Id: <20200909185930.26524-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909185930.26524-1-vsementsov@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.136) by
 AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 18:59:55 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.136]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953baf30-4bb4-41ed-26f1-08d854f28ace
X-MS-TrafficTypeDiagnostic: AM6PR08MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34454F0BD59758779989886DC1260@AM6PR08MB3445.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9h0wPfNgvDRp77FlY2j8lMacEkDxFoo0Sfdf2DMNFSd//7o349X4iQk3OqW80TU9FSJK1owkWWZapQCJmTkPuGfnqcv28QUp7DOxROTG81KyXtURjXQstGvSTlO7BWFi7QSMM7yliqh57fiexy/hSShqLRiw5aX8uJl9fwdi68+2/mPaarTrn4IFt9ALeNFusAN60JbiUQnSGRfmfdzLFRGco/Vbe3JDH5J0F/aAK4QVEKpaAwyFn6BLB76J5C6GO+aqzkWfusLo3TZwwynT4LNEi78rdHpBGowBqKhAt4IvUvHEO8TMDG6GV3SrLmdX/rHOqz9O3PqfNoULi/xoRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(376002)(346002)(66946007)(52116002)(83380400001)(4744005)(2616005)(956004)(2906002)(6666004)(8676002)(6512007)(1076003)(86362001)(5660300002)(26005)(36756003)(6916009)(478600001)(6506007)(8936002)(316002)(16526019)(66556008)(186003)(66476007)(7416002)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QErY5tYwC1eE3iAG2SzvJ6xymdi9gdk2OTNs7ZqrJtr8F2ahUsTvxGnvKz0MTFZhuRD5sa6dNtxltJw9Tox02cKdrz4kZVPsx1iruAC+Tf8Y5aYZI49cTzMhVIyr7t70ehTh7U9HcwOZSrsCOW2aouq+NB57ZzWoga2ZJLh5FlIhmrHrbxa1nrshH+UPmhmfh7QdEHjntQ2TnBA3L2U2D95+8DdsRyqH7EA7RWPsrTxJ3eikOpfdYqldAhIe3095jtbLroN5lK3TGfQoAGG+Jji6HCeeNxtZruhR7BN408WOFTayOKDApuHK0nnx8ExtGREiWTK+/qaLAk9k4raLNG6vk+Hp0L4tFNCQSGhIddZhrlHu4fdluwRNh28RBRsS6woaTUC8/Jr2jzGjzkinhuExBkDprrlziZx3Y7CYhKHqYnOWLCH33M7LwBdTOutfUhZSrGBfTin8/Q5KgYj2zXmeus9zo43wGL+8xMwNDt6NwS6ltoRE5bejT8Qprl2pUXwMDDb0j1SGblo7DjfYKKktAK4FH+wlBkvBSLI+gsE989giSiR1iW+RJFmAry4gefhYzKr+28eEGlB7r0qalya/4HrTNo03IPELCH40nEGdUfBEgX3vZrwOuOFLT878M/4SsAW3uZnCLrh5DeoW1w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953baf30-4bb4-41ed-26f1-08d854f28ace
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:59:56.2113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvKdF6ikbzr9e+JLtPuBQex8boJaGNNrlgrMHT2iyXkqt48rdSPbVAS1TFcBPbj0f3Gstpo7a2ngzU5SuoLdlGqMKQ2pLcn4C1ndmmQxdLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Received-SPF: pass client-ip=40.107.7.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:59:51
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

bdrv_set_backing_hd now returns status, let's use it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 9b624b2535..c5e3a1927e 100644
--- a/block.c
+++ b/block.c
@@ -3011,11 +3011,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
-    bdrv_set_backing_hd(bs, backing_hd, &local_err);
+    ret = bdrv_set_backing_hd(bs, backing_hd, errp);
     bdrv_unref(backing_hd);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
+    if (ret < 0) {
         goto free_exit;
     }
 
-- 
2.21.3



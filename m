Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B48C43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D228C20717
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="enGIeS4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D228C20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ09E-0003GM-Uy
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00Y-0002nz-Na; Thu, 17 Sep 2020 15:55:55 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:28615 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00W-0005s0-OW; Thu, 17 Sep 2020 15:55:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNsi6PhEvm8m8IWKXp6Z7ou2+77wMNWNXeN4hirdYA9RmTsczl6ep4LM+PN4R0a+AB1sXFciMZ/H1zIBJqTsb0hNbcgDSJ+1bDVSxCPZ9NN3qcjonbGcoEIvtgfMNq7kldujT3gMZ4rEuya2e0/0kSb7q3IckrfVB2eWKOx4cVCgssffr72DEYBuhO7vFwErGx5qCxvipm9cV6gmcZuxl5FO2obZXdnn3FM090TtpVr5nm5ZiMz5SlFGj7w3uO12B6vVq+yV/CrSy1Kj4U2YHovAoejEf2c7xcoM+ZVqNt14Re/YZkpRF2gxzcTtxegzuV/4cYEmiGzW5N/St5Dkfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWSYx6Xd8mj1/oM2U2pKNJj9WO4pCFgdhZPLY9G1NBY=;
 b=VqMZV9ooBo2pwfjB5CajaxULL9ZQaQPx2qPYIfy/MfirK1qgbUNn/7zgaFJ1gXO3+gi6aDlhbx5FUB6NGfjKhQOCrYG1n6OrGh7hNkmgPDItcfJ/ZUD0DJTEXn85L4dyMve9FWGqsJUTXxiYdU5lE36TcRUkFvcf+XbDLG2wtzg3Qt6cNpffoUX0gibYy+Z4zVqFYI0mSRU6j2zSbGwiarioX1E9W4sRwBqzp7ZMV5mY0+/xIlygIPS/W2I75E+gLsZ0oIeJwxI+0iK1DypUjLdsHxq/xSX2KaltwzlimbFHWOFILRR5hYmaM0T+5qCkKN6A2rn31loeNqCILMCB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWSYx6Xd8mj1/oM2U2pKNJj9WO4pCFgdhZPLY9G1NBY=;
 b=enGIeS4yT0t2saBoHZVasCLK83j2hq4Bb38cd/aPhsETsAZ1VM6EzbwCF7y+vLcm8O4aCH1prVhYGL0ePdEWIILLhH/zzSg0nQMDXA5WyV/IhaGlN51tQjqzPR+QacGnRjMAuOYSXLu6tvSkYZuiF3dLjGYBL4HDnQdaOkuvoLk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 05/13] block: drop extra error propagation for
 bdrv_set_backing_hd
Date: Thu, 17 Sep 2020 22:55:11 +0300
Message-Id: <20200917195519.19589-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:39 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b36c4be-0c41-40cf-d56a-08d85b43a71e
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30323E95CFAC54DF0B638773C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fa9c084fIHZBlsYYsT+kFl/OUMtnKM+PrhNH6M8T1Ugaz9CYn3eHzVluDZPxX3Of9Mmt3HOJ5tDR43GIUg4w2fk24YIC42U/tWoECOW+cH0s09UjWuQuK/u33MXnHTdkXTFgruAGA/In9u0FiM3jCBBLe0CSZj7qEXi1AE3MxXo5fWy6oDWIOJmfaLAmLf4JOY1EQGHhVIZWkMYqIK+HeyvViD+xk5KR+PZkcPoHKz3IoA/qvK7g5lksk8a4yB1uwGNfwwB+ex2FOv1brc3tItfWgnNbF8Eo3Xiyi9fBlzm5L3yckMRpNBiRaqERyJXkVsXZ3SiL5IMTfn3+1DFQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(4744005)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CuZjpNpMmwDSZANL7IvVqh144PFqb/TcBLZ3WSJGk6xDIy4EaISG8abxc/2sYYNZ5XMShDrts7Q1M2GmbmCVh3Mod1DcP2fCqfS6FgFwEXJ5WOBaobVCZZYdeJPCpY9Harel47IbHg5kEfGcD1kOVwx9qKVG+NwS+BZQoNFyp04s0i2G7E9KPJHUQNbK1xuHukMP4brjGQPDIBpdl5VRzXoZfYwpKbQ7XcJl5yYdhf5DPe2A4jUF60XWvchc4g83MdfjFqrKzDiXZm2Y4MoIZMup1X0lmwZkcHMczsCsud8waqdwvrAbq8qxVT1S0YgJGrhyBugzPIMFIZb2ZuEVFcXagEBAHI3vFsXxkofvHbCpaRJZLc29ikgTHCyVDzewiJfbqcPw8U2b5tpTQOZL4L76jG3Ko4FVcXQEsRB5kwUEwroLpXz++DUeiUaVe4R9eA9Wir+pQdY7GZ6172fsvpCEenndzF4ZRR0g4IkugJ0YPS3sn3xJ54zlAA5U3hTjG/XCkgbliaHWB36ChN0M/MD3fiCtZ4YBkJAe9TZkz8RpWU1pGYiT+de0nQ8o5UrmYqO//6ZDPR+qX24Upv0765yEOSDuYcwkx9Ftr8i4Wk9k6ApQn1U08pwj1ellwIVSrmSil7XlOKn3tUlZJw95iw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b36c4be-0c41-40cf-d56a-08d85b43a71e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:39.9101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ym3dJU8XbkbVzRq7kM6lqFWnbxYHi2gIzZArDzXl8UNrnHZwmbgxIXIFHPw5o/quf3YJCKxJy8kaimgogCy03rRJVIPLjZ5urCh8QhXp8mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:36
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
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index b4e36d6dd7..1cf825c349 100644
--- a/block.c
+++ b/block.c
@@ -3015,11 +3015,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
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



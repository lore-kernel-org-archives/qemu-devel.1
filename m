Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB188C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180D824656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SiQmQNRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180D824656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfyn-0003qe-Pk
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflg-0000lg-7Z; Thu, 22 Oct 2020 14:56:56 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:5089 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfle-0007Y8-IQ; Thu, 22 Oct 2020 14:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7l+h34VMtRMP1z6Uc+P7uSN9GureTfFOaWWDN2Few4ZfC1kB87+s1RiTjrxeugFraqQnXFq2PUSkYycSMq3qBKjJM2uXWw6xOryvveoZDmxgJzvGS9Hr7/Q8PLEe2VNmQ4u34DnbBMtPHoM1jaMwgJIOCEWTfCVXZYresx88jV9XSBfyNfHyCLXrRNBqwYTjg/tPRxGJWeDarknC/zQyVIMVUSRFHaZ6s42dE9NifmuJqslIawpCPsTW0HGRYB6s+MGGx6dUCdLLIXFmkJtm6ZTt47REH2MCaJGDetERWPJMzmjcILUQ9Kmbt9eGsHh1VQMN1XWQ1cHclEF3wN16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs4/2pIvQhViG9WDePfVuU+qr/T+eODAHDLNGjq1eJU=;
 b=B+d23Yxma4+7yTtR/LpckJfssBiYAtktbY2OSpNiS21s6ge4BMZLmPvZ75h5kH55tLBuqsq1Dgj6fRiuzcIS5EFuY8Nb8uXaWtdOj9J5GvwUpxR9YqOhtgDW5ZF5/kT6bNdNPDvNw1K1oL0WwIw6t9C7viLlJsljWmqEfwGFcJi4DWHr6rAhbYeuWRyqqzGv07EjSs3tlK10xdPgYl29pVXi3b3eaG/Uwyo06WF3/bmSeUsQnMmaDZ+PRswxXb7eyRMfcNK8teeHHGMwzozXDgtuDwtl2gimhA3OJYs0Z0lv5SWjTsyjcrghg57Qw5QDqncsxOe+rrQJOb7F0iGAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs4/2pIvQhViG9WDePfVuU+qr/T+eODAHDLNGjq1eJU=;
 b=SiQmQNRB9Zq5bTXkeBIxXKrcV1hFdU8wQ17WfW4EmHt8esK9TCM/z/zJlVYDFk54OvXi348WNsNsQ2x+c91p1bk5bIiVVpX+oQgo79xfIAad/RfgwjE3NQgnJ1YvBKvpxO9+7mecTEtEFyEh2OxZw7AOSaDdsLWSe88InK3Yzqg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 06/12] iotests/294: add shebang line
Date: Thu, 22 Oct 2020 21:56:21 +0300
Message-Id: <20201022185627.16987-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b81e8a4-976e-4467-6d1c-08d876bc3891
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB63099F18530E3D6D67D21935C11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pesoj4e1zRwomMeyuM7Qfjx+lBZsBk5khGeLfguhC2EcSpQRKYZxsQiQocse7yryfbNlfUNt0xDS/wy7VOVu0mQEwGMCmZbah4Qk8B3Aot/QyRUKgMA73jYXEVEoOcR/nlFavOmY4Dsk2eksLcVxPlaHAXmwm3JedkQS2TxDL5cBnnR8F9qfYu0gQcRwAoBJDCAK1oCtpaUBagYScbTzVWwZ2QX6t6RCnkhew++/D7b78X9iH6UZC5x6UmDQJeoL5DEK9oXsRftlb0fNmiR/BjRVptUckpA8sSLX8xABT30FXUNEG09mVt8xCPRXu56ngdZNbERzuMyZDIFkiRjSCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(4744005)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: z+ifg2Ctor+8V4bUc+nklAgurMQ4q+DWmtb+hqskpkLfDUUKUtXOrpR8drhtcMf1V1nMZLJVlwAeT1Eh6mDHdOWYzaO3SL/oTgeHVjvfGTtBg7gJYBu2JBU3szt8hQp6lPIDPrMOIe3DAf+wV8QOziFox+TG5HVP5JuTnycxzttT4qbzzfMySryCcf3oV54YUsJBRb+GA7KftIlpXxKs9bl8RUF7ffbxkuK2B7FDi26acpd92a0flQmtlqavMi2ELB2GyWHr414+6rMQ6iSJBBoWYQv+XdgYFCm82zcWArrO4Gmopng0dHgAlQcoAQpvGlJfJ899rnVwU4gGyxg7FNA1OuUjFX0wf1mJwNGrJetQEyFeXgIFxaZnSonPVrFWOnKUS+WlDu30cHMZ4x41vf6HNEk+6A5FNhCzqlZlMqMCOm084fdRCK1ybsfAGiVEXw9WsmA1Uosqjr58i5DIvLx39vGdbp+JNpSrsLnVpYxH+3c/W4fGKymJ2wvQmpR7eaW2qDccU/AQMjS1LnlP6K6sAhPFI+SlN9ItvbH66o2pI7d6bCtw65g52UKH8XZxcHEb01Bwhkk7NZ1Ktts/+oxIM8fAQQtvPiqFL+p4rP2LIy5ROl0qYMdAIL/E35kntXbQRgUwMf92BzzDY6sDnw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b81e8a4-976e-4467-6d1c-08d876bc3891
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:44.9721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfH42hTbpcSnf/Y1RcLSsabpX7Q/7AuJteSQGCH5nNuT6Q41a7ZRcrfOqpC/pXZbinDJsxIMuX2mhtUNMh2LIBllJ2i8D5bCeJg92+4uj4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/294 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/294 b/tests/qemu-iotests/294
index 9c95ed8c9a..4bdb7364af 100755
--- a/tests/qemu-iotests/294
+++ b/tests/qemu-iotests/294
@@ -1,3 +1,4 @@
+#!/usr/bin/env bash
 #
 # Copyright (C) 2019 Red Hat, Inc.
 #
-- 
2.21.3



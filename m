Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E331205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AciY73iB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E331205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhhs-0003a8-8h
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg0-0001jd-6d; Fri, 15 May 2020 17:15:28 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhfz-0005Vf-3n; Fri, 15 May 2020 17:15:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNpwz4EV+Hf9KeMQRg4JkjnOzvujCYmggEI4A8wpB1B1g8x9f/qTWlez660IiXzOZvvq1g9e3E95B5T1rCuTLYk9bLj1L7dX8g0xeiaVxf1B+FIrfmbfA4PeGYS4oCzf2vKR86E0plq81771zdyIIFLrM7UY4UMZhRQ1FBHdUqG6mThqY5l2j7CmwJ8QFkup7w+iaZml9d8sSflwlzxjtGMBdlWf8jITCEsR3AXHcxzB6jw4aVtrAEFghy0LNTylUiCN8fnDH+mxJ2fTzj6Zg8eqZAAsnx3oT78T595BrxJ4WAFXeQPYlRx2B7YOwbSlYkbTcYQaGHueANKypKMRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R90jSf4+HHlPMKjmyND1dsHYZQdLmxJHYDEeJha7Zq4=;
 b=FdW0/mf56tZawdrHXp5c5g9I3G/RpJyy8mFkY2iwoDqMerC29FyqNnH3taaQlbhHNqlM4jQo2g79e2oa1hPMpshMAAubjLsjj0eiLMzkXZEtHp8ZUK5JTd5rkY0uvNo7ec7AJHLKjfuxLscq1b0AvVdT/++/9Wi/udt3llXYqRsjmDvr8MtzoXT41GoG9FzPTESjhFRGh+F58oNCqjeZTzYb8kHQBKQEoGzsiKxDZmEFO97fiZ3KXUfBgpuQUX7n7UUNB4Loj5S+xAj+YXnAzFkBYcXtDmbcSMXeVF2CFahWVq3n6h4WhEEAqc6t+60JQPkKbliWyIg8LrWh5gBtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R90jSf4+HHlPMKjmyND1dsHYZQdLmxJHYDEeJha7Zq4=;
 b=AciY73iBk8r3LU98bqejOUOmA9XEgfCmrutjBl00CG4Ek6Hk69zMZO3dujZS4ZOrWjBv0FJzTDBAVer+UshZAvcYAgfvZrBXd4fAQwZzGNb0ccaoltCp9AG/PcoYGsLaymPBlmODd7gybMcTDXtWGTc/KFgHp/9N2yGItRnHxYA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/9] iotests/277: use dot slash for nbd-fault-injector.py
 running
Date: Sat, 16 May 2020 00:14:57 +0300
Message-Id: <20200515211505.3042-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:18 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4f7d3b-fbd6-4fb6-c101-08d7f915125b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478E5A40EEE584D28EC70DCC1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOfF9AX/UIDQGbERxHtxopcVA8BSAe8ywhKkXXYTQ8GGSouHQqdgzdkzzsOMWFGWxYmkLrmyBpj45I4utfHKSSs5RAVye7g6jciKlS1XWomHlqlLspz+rdEp33nX7oZiiWe5VIHx6BLS4Mn0r7iMZMg9jXiOut+F9Itbk2VefYogjvykUwFhSmDLnmwnbQPkEeYOfI1pQAFoNG+T/EWKs/fQI9HHJ+W7DCJiXp2oXvli2JtbHhM1V0eXv83crvmnekQ0cox+mpnp51j8T4sLFGh1PlzIlvCLyHaalW50v3fiCBuW9xIfUM2ZUJJn5RnAEkj0W/MjkPmrT+CW8v8suGzF9P82qqtu6o0u/8k2950fSUFk/JtyKq4rAjZQHONK1GSjTbpMYIa1P+l48y7LJesm25Ufgi5NBL81xOIWSbc/wpMFQVC89A053PPa2oEn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LX+Jf0trhWl9DDk6DBJDt+cRh0uHtK6zsbi1n8lB1N5xnELH7tjFKxeJj9QGk92YsguGv5K5yBHdWiBUctZCMqpdMrUttnYnpGCAmT9mAwXuOKhsgaCbnJkxgePJRJ9YFIFcAmaLp34fIgxSllbsCBgA8D4Durkr/trmZrbiDeW5EgYN28KeWOPQmtvIh4D6Y/yTtjX2KW7I8P+0bD37VEu6qun8Jkb/eqw62pP48WQsimqXW5gqb8ZHxMS0U/F5mapydNq9KJtc7KIgyfH0oo8PjylR01ablp/M1MTj22ko4auDURtYytKNxhujGuuZ9+ev8/3ydiF8GAMQGd/sjXa1KLPP/73UPeWxK8nidtihbN/yAjPZWY/D6f8lwDfT3J6yXMH/OMSXOXk//x6rHVE97wP/76w23j8yJPcmDM9ATv0MA6SLPP18FKbXhVS4NFD0/XP3oxbuB4Z3zT2M7XG3SWTzpz24LnNdJmn9//7Niq2cq/lFjGf0IGSTTDMI
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4f7d3b-fbd6-4fb6-c101-08d7f915125b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:19.6276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl1FGcPX29bHphE51O68PMqBfAUc8LdVZajciAMSXEI6JGrI2nLm49KcUVoI1qUHtZS2FkoRT66205aWsXDQkxqyqSRcGmuP2SYXSJ5DOSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.100;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:19
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you run './check 277', check includes common.config which adjusts
$PATH to include '.' first, and therefore finds nbd-fault-injector.py
on PATH.  But if you run './277' directly, there is nothing to adjust
PATH, and if '.' is not already on your PATH by other means, the test
fails because the executable is not found.  Adjust how we invoke the
helper executable to avoid needing a PATH search in the first place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/277 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
index d34f87021f..a39ce2d873 100755
--- a/tests/qemu-iotests/277
+++ b/tests/qemu-iotests/277
@@ -42,7 +42,7 @@ def make_conf_file(event):
 def start_server_NBD(event):
     make_conf_file(event)
 
-    srv = subprocess.Popen(['nbd-fault-injector.py', '--classic-negotiation',
+    srv = subprocess.Popen(['./nbd-fault-injector.py', '--classic-negotiation',
                            nbd_sock, conf_file], stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, universal_newlines=True)
     line = srv.stdout.readline()
-- 
2.21.0



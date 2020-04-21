Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C39C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B67E2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uDGidpkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B67E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnTQ-0007ax-Fs
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSM-00063E-KF
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSM-0006jh-Ag
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:34 -0400
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:47520 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSI-0006Xr-NR; Tue, 21 Apr 2020 03:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE221m0FML6WyD/jkZRdQATEOC3087mvEuWMHD8G4b3HJ3UNgpeJy0HPLmM8p0Ywo5IwS0kCeTnw1f7ZPGbMR+J8PiGCJwH7EuqgeYTF4nzCt2udRI1gaqfw9By/fFMPHjfooPir+JR2xLtFzQADoRruDXolMdeGhKes3NCf+brT2vjRQK+XxkxzthmNf/TDCV7Rf9YsX0NXAX7R0cAfSLcc51cAHmJAtBBQskzCmp1ilQ1wO1d3yJ1V1JeQY5L17R6XrlLHsGqclhg2zfvXnVN0ET0KpZtuDIKLimZqQ7UINr9ZsA/FfCTOzXf7OovfcC+KvIP2YHlhJBzdGwzfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3kpuNXgJNYvzwNfZ+HpmEadCpsjCdeTpOSyvOFsTAA=;
 b=YH9rwaMO3vss4sVbyFtOMUo8G6ULzUJg5GGP7p9pWShhWb21BAiVXItw4dEg4vBNj/+4bAFDvIYifWwA6239uvnX88P0ypTQIN5RlV/UCjqouRO/B1d6iyhEGoG8tvw8DeME9gHc62F/P5zA8UA1Ov6gq+MpFwTi2T0l2uY12XOeoafIUciKXKVovGQoC+JxndXutzn6nqiDT1+BpIkff+TSr/YohDEdlxOMINReAhcGL6lYgfnO+rF+f4hWvVQBxP+DurqC2He/jgddv0roKqm3dRMWvsDWHXWzR4tcSr7ipB/3a6rr+cuwOT5JbLTqype7ZguqUta3yQ4mLLPFTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3kpuNXgJNYvzwNfZ+HpmEadCpsjCdeTpOSyvOFsTAA=;
 b=uDGidpkOOnfl/Doe5r0JZcUqTrdXtAWADAxmLaAMx6oXLIPlQU+QvNUpoSSKUlKCOT2+RPzt+hchSFeAtuXrnQWWZQBwF8n/b8k6uV9ZlETB4289H+WSZoKFVAXBS/4xSOR0tb5VEPTBLz9YldBq6P8fm2v2fVr+UYn1lL1rFWE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/10] iotests/277: use dot slash for nbd-fault-injector.py
 running
Date: Tue, 21 Apr 2020 10:35:52 +0300
Message-Id: <20200421073601.28710-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200421073601.28710-1-vsementsov@virtuozzo.com>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0137.eurprd07.prod.outlook.com
 (2603:10a6:207:8::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.142) by
 AM3PR07CA0137.eurprd07.prod.outlook.com (2603:10a6:207:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:26 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1881dcb9-fa2f-49a8-5423-08d7e5c6b3c8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397F50113727791BC2BF487C1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(4744005)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibt/dk3aFv5RWNcktTlwNklWBdjMbFAWF9xtULh37vfCi0oWYSRpBG9pe7fQkJyrW4YlQS+RPqcGwn+7brSag1bYQg5UDDFVWwEoaac26/jILRTuxiB4vY1mtYBZRxNtqTCdJdq4Ot97ED+g1lNbFXCP2GKQfxeRe41G8ZG8aAOzT7ar1DD6SjWi4rLvc0sTbUS5jFdcSpSGvdVJ33IeQpiBrfHmRm+aCSiuk/FhU+BDZx6ouP3BpydXr/dgky9IbGQb9WoWcwvax5rik4iZOYeMG9Mwao/dDL/xBELljijOOHEyW4vlkevzB0SiDmrYiBnrszS2J2A0CzWnP5zh+vIN+S0kY1KfjxKnGlIfgQyin71J6BgOl+rAD5zYuaMtdvecYxicCShrOwddE5OyhaES+oEhO/Xd99pnjveBxP07iH3LMVcXlD8fyBZAcEFWMj/S0YMgXjc4xV7xyOwtUWU1XABodeNTOdTLd8jUpzk0TO5MXVKoejM4XUYbYwBZ
X-MS-Exchange-AntiSpam-MessageData: 9TkQcCKo22+qZHvoR8w4ahyRqJHxSQu/eP+v3DMt4oaqG2h6gYNRTG0v84CjcRF64OnY3aYYFaLmfyej3tWP4tWipSWt9OEIilxj43qEE7MyZNEHV4LTj94g+FWP+xe52oG2divpizPGQlO5c6iOdw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1881dcb9-fa2f-49a8-5423-08d7e5c6b3c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:28.1776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPMaht6n4EvDQwxG9rfm0NkJwSPVLzzlD7vPy81UQs/CR+hhhXqIGZeFEYw5TEauDOvL6Td1zrSEP1v/U9e6fd8W+AV7ZYvcsUxImeRsumw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
Received-SPF: pass client-ip=40.107.20.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:36:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.107
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

Somehow, this doesn't work if you just call ./277. But check 277 works.
We are going to new iotests running framework, which will consider test
files as self-executable, so let's just change it now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/277 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
index 04aa15a3d5..a4ef1a38c6 100755
--- a/tests/qemu-iotests/277
+++ b/tests/qemu-iotests/277
@@ -40,7 +40,7 @@ def make_conf_file(event):
 def start_server_NBD(event):
     make_conf_file(event)
 
-    srv = subprocess.Popen(['nbd-fault-injector.py', '--classic-negotiation',
+    srv = subprocess.Popen(['./nbd-fault-injector.py', '--classic-negotiation',
                            nbd_sock, conf_file], stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, universal_newlines=True)
     line = srv.stdout.readline()
-- 
2.21.0



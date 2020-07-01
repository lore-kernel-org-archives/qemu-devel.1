Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC5CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0439206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rnNsYvWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0439206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaQF-0007Lm-5L
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaNB-000274-Bn; Wed, 01 Jul 2020 06:53:49 -0400
Received: from mail-eopbgr10106.outbound.protection.outlook.com
 ([40.107.1.106]:9187 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN9-0002Jl-Jo; Wed, 01 Jul 2020 06:53:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mipsvGHa1yWLC6VMYF3CMlzaof+BS8u39fn0fJsCAL9YjMtjhS2GvD5lHrGPM5991NaBZnfo8Mq+33dDJYdfZbbrfGHkPI82128UaS7HyFve6lKMF3GD7OcUi3a9a81ajnqeCL8iXiJQ0YuJuHftea9o+CJi3S/RqAc3EJbEwMgA9mNnWOD/1KuabNY8ogyBYHC5WS/9JN7bUXckwZliTbNL/rlnhqbaBYcVfy6snGuTchCS55u5r2+1wmKF5xH9/2o4lunaUL5cN8oDBtgpjsH/87NMtgH9y18hiPUKB4N2SD6MUoLRO6Q0xoqIQOZP2wesGOIVvutYOx3ygR1uVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMZayBVdy65Ef8lV9b/bq1XSjq3qIc6iKRIc1Fnp604=;
 b=AXrIqL6fHMcSOags8NxAaFdHa0qJmN7iknzOzYdHIpPkxumh0h1LCzLPIkaJ/hNAlyL2lXiGo/vGOirqWS3QNgMsAuC2hXV32QKgMx/hZjIiEnO9ta9AaxBqCrZuaAzHE/PdSyJv2ap2IpvmddKoUc6iGK8KW0GZonLBK1f0xYfPYcrRCqnhz/7w5bXXPPzrW/1+BsP3aqkPVY9yhCLKHpn5+iSxQhivB2e1V0chXkpT8ff44/SZkAcx9FHOypwunJhh/XUhpVtxRxgH+mFBfMVUTIs1uGb313HgkPOlX7RSMif6DpJIe0XaLvQjTy53aEE3cazuAl8Znc5QPYMDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMZayBVdy65Ef8lV9b/bq1XSjq3qIc6iKRIc1Fnp604=;
 b=rnNsYvWriA+BakRJdGOqe5cRAK86fiW1SJqJtFoGYpS5R9bgTTDg9O51cyIxFCadG9CGcoATlrPTfVbV24vSYS/N9PUD47jhPmYD1qeSrUxe/8VAfXamAUMOfRCRpGyxKzTgg406U31k7kcAb81FyA+GEPil1lrKP78GaxXlq+I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 10:53:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 10:53:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/5] iotests.py: filter_testfiles(): filter SOCK_DIR too
Date: Wed,  1 Jul 2020 13:53:30 +0300
Message-Id: <20200701105331.121670-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701105331.121670-1-vsementsov@virtuozzo.com>
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.28) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 10:53:40 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33bf41a3-e514-4f35-ab7f-08d81dad0462
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850ED12BF8927BA799A7A50C16C0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv1UgIr1UVa6KRN8x1ULon3JIJH42jC17eMhrG0OI/+S//crFfok4f/q9BdUOA7mzBa2vNqq/YCEA3oez90rrn2wxwYEKbIniVLNQDIbxpHNks0PILHlI6unTjdUcDFxacYNMLWISg/bqzXBn6ovOhrVFuBVf1GK6Kw7wAXsDqqzImV/LjgPRaDqlvgsRsVrgDoCPyTQnO8b8tcZWYK26nCnkNUT4aYiSBfzcNzrLRKF59sOL8SYCE/c8/wbTQszcX3vxPDwiJ5jpxr89zeGSS+9cvm99c3nI5sG14V2makNKstcjAviwrSlVEs9Gn7DwTC1jdIolPCuX+KHgS/nvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(2906002)(83380400001)(956004)(316002)(2616005)(6512007)(6916009)(107886003)(6666004)(66946007)(66556008)(4326008)(5660300002)(66476007)(86362001)(4744005)(1076003)(478600001)(186003)(6506007)(36756003)(52116002)(8936002)(26005)(16526019)(6486002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O3GVwxxGCv5NtesyHy+pjl8RPO72n+0REbcCVhnSv4Iyh3OB4VVzzbg0vWF9RcK8iusdPQXvYNfWPmAc07gXrXHHS2nb2hLH9o8fPeUdfb84NpM1qac7kVIB3uhs1fsrmd7+sNq3ki/igK/o7b45Al2wZs4vsVD33Q8XH3aixzZ+arOUNlh2oDujZpVSOwadKj1NvjbOMK1ltTk9m6h2lriOV6HcSHsB9G107Dd52OZoooXuAzmYad+3FLTR+/UZu5zdy4x2f96O6JrZ6cWiJnQQW1VgCwcF2Q5TGV4Sob0oRTLwKkpuVGX01Pl/5dnvcF+2N0bZTA4Wf//oEpoLPrQsVzvpTQLNIzqn5cXHqh3rDRc+Jk58apw4OEJSCxim7qzS3JJJ1Y6zC+OBhnmjJrrGVXAIhPmUQB6bUthlz6vOAkjxE0c5xOqsc517a4JLhvRoEld1zvQYSG/34NdWMm0IpR5olCZVSxXhlGFkLlM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bf41a3-e514-4f35-ab7f-08d81dad0462
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:53:41.4671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2o4Uz5ibHDk6A5wr4iv6LgcbUqJyP7mgZjNZeJBXmlpc6J3QvYeoTtL+ujzvS+Lh+1S5mAA8EEBoG4LCg3qtr17sQUzpvd4Ha1jq4vTcJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.1.106;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:53:43
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ac9d199a1e..31d4b105ca 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -345,8 +345,9 @@ def filter_qmp(qmsg, filter_fn):
     return qmsg
 
 def filter_testfiles(msg):
-    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
-    return msg.replace(prefix, 'TEST_DIR/PID-')
+    pref1 = os.path.join(test_dir, "%s-" % (os.getpid()))
+    pref2 = os.path.join(sock_dir, "%s-" % (os.getpid()))
+    return msg.replace(pref1, 'TEST_DIR/PID-').replace(pref2, 'SOCK_DIR/PID-')
 
 def filter_qmp_testfiles(qmsg):
     def _filter(_key, value):
-- 
2.18.0



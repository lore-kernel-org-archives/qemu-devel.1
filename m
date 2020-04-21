Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C44C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E802073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 07:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U6X3EzDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E802073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQnTc-0007rH-0E
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 03:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnST-0006A3-Lq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQnSS-00073Z-8b
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 03:36:41 -0400
Received: from mail-db8eur05on2107.outbound.protection.outlook.com
 ([40.107.20.107]:47520 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQnSJ-0006Xr-TS; Tue, 21 Apr 2020 03:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd+mTf9/xulteuY2vx8P/Da/I/A9eD/JJ/FtyXDO949rFz8j69XU5PU0uz30GcXHUFwPKNHHLrKUhoeomWlw3tZSZdluzTmJkrJ4rGe/sqy0viMXt1SI1lyFOUxcSJq0Htemh9vEU7DlK5m7rozXsITjdfteBa46LmOuodsVOMN7a0npGFNbo60SWoo98BZ8brBjR8yImAdzoE/s1UkzpfG41Lch51OFSNMI21E3pL9HjfpxXLt0Q5repMiaT60jHpiy1yDF5BnNchoscFVi5OzPCxdDmKQGLdYCgFSufJ2Oh/Hquwuc60F56Qho5Csu1cLA0HNZ1PWO2hXTwmcpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFSqr+V9MrdMh1Vq5MG6wYSjq8v3HnNE48NRAN/UPv8=;
 b=BZbDdBnNdz9FL4kfS/3/NeaCoGq7OvRSBoilZbOuKc4NhbH2jwzXA1vGz2yTSSNwAih6PYZF/ls0xYujfaFuUS3ItwUXhX0JQoHbah4QgDZQ1UtxEBW2ZMw7zIJ76YhRJY5HJSbtx4Qwv4Bgu/pcb7ckqOa3tuVh9R1l8oMoHU6aS22e+fmpFelw6GyLdhrrONObWHyLKis3V4aP4q8hGNrhmVqEX2tV9qGRG+z4QYpfiiFCC5Eys224hRYXaPVY1qCGEdmWeU59mqnArHTFaR0BGXiTy4znSBXXgNO1Ko47WgHLfJBo50+1msKx4xU3q/vsac/nLFC2WDuPF5oVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFSqr+V9MrdMh1Vq5MG6wYSjq8v3HnNE48NRAN/UPv8=;
 b=U6X3EzDBh+7ko/IyTZnPIQJcfC6H5OLHD5NFI16GkdS8nmzdT/ukyNGou3/lQIe3BPD9Bn0QLiNIqw9biR2aGQYd72CVnSj4W4C/cMreIkEipOiDibaZvWIKW2NI/YHjGF44G61r4StHNNkijkQ/RV7QSimr/hX3750sqOFecoE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:36:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:36:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 02/10] iotests: fix some whitespaces in test output files
Date: Tue, 21 Apr 2020 10:35:53 +0300
Message-Id: <20200421073601.28710-3-vsementsov@virtuozzo.com>
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
 15.20.2937.9 via Frontend Transport; Tue, 21 Apr 2020 07:36:28 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff174b21-6ab5-410b-4e05-08d7e5c6b52f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397F44DE7128E62CA255437C1D50@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(39840400004)(136003)(366004)(36756003)(1076003)(6916009)(5660300002)(6666004)(6512007)(186003)(4326008)(316002)(2616005)(956004)(16526019)(69590400007)(66556008)(66476007)(66946007)(26005)(2906002)(8936002)(8676002)(81156014)(6506007)(6486002)(478600001)(86362001)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fjIohvOHJ7edcd43+0F8uFsgskcFp9iFYaXbQcdXxfkauX9SAhxPO1OcSeCFLV9dsia1jfKAk41FrTQ/UPJXDNyPfM+ZALQCciX/IsNxl5xwKsBNh8U1fP23ChylHRGvANzcKR9b3pQNub2H491T3QNIq31uIVEBWisuPbQUCoNs0cR/NCVw5onPSv13BuUvrnfCjC5VDBl0esghbEi4wtv2p/oWL1CNs2YvKFkbFdswOF3G2gKBFN3kxjvGesHH6Dmq1WHQdIieUIKWLxziH6EazhpQwMS+/9iVbOnucrhDmRS33Xs6rfJdt4iK0LfeCoDHeYRJO/lsgqJq4WnhYiDDRn1y7DfHnSV7eX1p095CDxalb0n7d8BbFT+PpJWtIV9CvN6Wx8cmGvOOYwwlclrISzawn5DAfv4PfYXJSGxKiWtv8mLzip5vHMUs3bkICoB7l8Ip+MmtfSJUrazmxCe34BuCPjgz0P56bJcMZaza51j6aL2SzJMmOMDnWZP
X-MS-Exchange-AntiSpam-MessageData: zh1gDGqZhea2rtKbrp3CfsCz87GE/N/13s6u1gliNzTXoGml12zySPO5WCLNdq1OobTjyjAKZl3tKyYac3Q2hfgfnu2+vJrkZ9WXL7HkvGsQzpZhRjugQhvneBYq18DUi4SOxYoqHOJGbWl7B3N8Xg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff174b21-6ab5-410b-4e05-08d7e5c6b52f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:36:30.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xxnYh96o2u/XKMpwH2Q9k04vG2znzxHLFS4ikJkZLTGLSvPKbIY4hV72dtOEIbeIkjjqoHkgKjjfO49XLyl6gBQYt7hZES7xybMB8N2ABI=
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

We are going to be stricter about comparing test result with .out
files. So, fix some whitespaces now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/175.out |  2 +-
 tests/qemu-iotests/267.out | 48 +++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
index 39c2ee0f62..40a5bd1ce6 100644
--- a/tests/qemu-iotests/175.out
+++ b/tests/qemu-iotests/175.out
@@ -23,4 +23,4 @@ size=4096, min allocation
 == resize empty image with block_resize ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=0
 size=1048576, min allocation
- *** done
+*** done
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 8dddb4baa4..26ef5f64b9 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+1         snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
---        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+--        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+1         snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 Internal snapshots on backing file:
 Snapshot list:
-ID        TAG                 VM SIZE                DATE       VM CLOCK
-1         snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+ID        TAG                     VM SIZE                DATE       VM CLOCK
+1         snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 *** done
-- 
2.21.0



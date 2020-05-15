Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228AAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A27205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="O0QhiplO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A27205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhhs-0003cy-Uy
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg2-0001jr-2G; Fri, 15 May 2020 17:15:30 -0400
Received: from mail-db8eur05on2100.outbound.protection.outlook.com
 ([40.107.20.100]:45280 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg0-0005Vf-OZ; Fri, 15 May 2020 17:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGMAfd+xTFSNgyfciJ2YVQePLdaZu4uyew/VkzXiXPp29LwQgp3nH3pZQaryr05pnnXmKMswaJRDuBs4HPZqWSz5TykrInfNzstQEACdIyk44vudnaoYFExLxyVd7kXUFXnjXn+5Syun4fiJU+gm8zvYwk2EQQnq98z+1i2nnuwx2LPDv+DpmPBFeq29E12JZ5Bi0qC2VDwV6nKrmK3wUco+bIHRwdUdQpp1sMfILUr+6SrCnUt5EH1cE6wCB+2EMMqngUwMLuEtTp3bqdyD5prCHJpcogwS0FvaNFRTMlIgYMkuXzCG9OX9K1m4hUsXwFA8DsnmeFcXZbPG7GbvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrQa3fT0KmnMn03JMAkBHYTWhq7ShgM6KfKqqq4lQl8=;
 b=Zi3RQLWGQWL8kUNIpyOjFfzQtasvzFvmXlzU3GHwm8BY8kxWIz7L+i7k3YAcmjRkgwOAS/cXcv/A8HTEA9XZkL+xvcOnj4HvnB7kyOaEEo6ysq+KeOp8MkFik4y/v0MA30Dni+VM7tIz0WSjEP2o5ljux6kOKgmc5B7RHdyR0JBKtR6r434jyxrNtJb1wwPmsK4AT+TO+qtyVUx+8/Qs9feWduHZGax8rC9OyNkVExBBSw+apTodOhKn8+PpeKYMGiNChVdCDoVh8yanYGeTD4qYOkV/IZmDrlm9a8EwJkc0G39dZDUXDfnrt9LT6hSEW7AL94XQzjiShBmmSZe5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrQa3fT0KmnMn03JMAkBHYTWhq7ShgM6KfKqqq4lQl8=;
 b=O0QhiplOIjiQWizL7tyZepHyiBFXZ252yGu3sXUkaN09gpIg9994Uiz0nGbvhA7M6amRXgVabCpZg9BqpHV/ebSU1UH1ijjiWgYolzInvQs/KVGS0bAOxBcWfVNwMhKlJH7MnckBC4uxUZnNtdqeQMxyUGxeZCKXlrkGNfsxEWA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 2/9] iotests: fix some whitespaces in test output files
Date: Sat, 16 May 2020 00:14:58 +0300
Message-Id: <20200515211505.3042-3-vsementsov@virtuozzo.com>
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
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:19 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3398aef-3dd8-41a8-34cf-08d7f91512ee
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478710CB5BA19ABCF4E9FA5C1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dezwl2ufbjMNd8i7q2YL+kAQC6DCXUCGalehN2nE7t1HOSv1wVfgplrR/HQxWq9sfOFKx47RO7b/oEMA6ouu42O9RVfmxaMiO16uztbuw1R/rU9RRwSv9U2deW7CrL7PHn6mjqgUS1Cm7BDLEwDEts2oAQqlVdbLksDJZr7p7YM+X1ml8LJkdg0iHI6kpFqiBciGWvhRofhyFOruzI6IKtEP5ej/I+kFIDHvpp+K55J+Rlv8eaH+L/HDBEjPhbeflrTpVLJrzpEulzgM9QhFjq7DRXSDB1YhieVrRc8EwEKjOoilNgMhJcF7OXJIHemrQR4qMlckbNGVjhDwojTCR1L8lfRc6ao5236WbKQ1B0pGo/kRohlBknE2Gjz2IrQoebI4kosthxsLPyFajaZKwT45U26Xyf10q1fJSNe/pbM56r5MHu0lpBeR7Df1qi+s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(2906002)(6916009)(36756003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WjaRg9iJym7b1QuWP9cGAjy8eYfzvd2oR5e2Zai8wrWfqlPQBY5q/wr02Q/0kAs4LruX2luIRGnFt9/wCEk1GAzy0wUWyfLu/ukgwjQawwyMSkb/faX4i4g+77iD9MzAqM6tL4rWsxJqCo/u6cMJJ1x62nhtJoHZEuWgp7G/93AMgE4OwAWX2yZjEeNtt10rt6gOpvsdcTHgI3NeqB2yJaDzVTmX4cVzCVMxvJeeLuS8OUmJbpLINcgEInh6CRo8YjjXxswlKpLzRhTEyUKb91PA4nsbqxkuY9tYL3pcXdlu+Klgo+Fri4VnfgOXaPrc4pzvWvF1GAc0MvVbpKoW2n9wKn51vjmM4El3Q2dKXZMdBitmH2UiFqPU0Pb7bPqS6FL+7RiBeBjjZijWiEC8jlub5PYSRPHGqHVCYWmjvJ8UkODy6Jn6eLHxPSeruzj0AifuOXkNDTdPTqm+w3zWi2UNJfZz5BWWRtK9ZtMx9hZepR4IvoyV7uUH88XbSRTn
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3398aef-3dd8-41a8-34cf-08d7f91512ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:20.5137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0maooija3lcb3zm5iBEll6T9ep0f6e3dmkYXsGAr+9xDT/EBvyENy8ne8NCg0nj2n+vY1gJOJ2OjRgUfH6tWt21TUYtwbNvUDHvzhHXY+1E=
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

We are going to be stricter about comparing test result with .out
files. So, fix some whitespaces now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/175.out |  2 +-
 tests/qemu-iotests/267.out | 48 +++++++++++++++++++-------------------
 tests/qemu-iotests/287.out | 10 ++++----
 3 files changed, 30 insertions(+), 30 deletions(-)

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
diff --git a/tests/qemu-iotests/287.out b/tests/qemu-iotests/287.out
index 6b9dfb4af0..49ab6a27d5 100644
--- a/tests/qemu-iotests/287.out
+++ b/tests/qemu-iotests/287.out
@@ -10,22 +10,22 @@ incompatible_features     []
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     [3]
 
-=== Testing zlib with incompatible bit set  ===
+=== Testing zlib with incompatible bit set ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     [3]
 
-=== Testing zstd with incompatible bit unset  ===
+=== Testing zstd with incompatible bit unset ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 incompatible_features     []
 
-=== Testing compression type values  ===
+=== Testing compression type values ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-   0
+0
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-   1
+1
 
 === Testing simple reading and writing with zstd ===
 
-- 
2.21.0



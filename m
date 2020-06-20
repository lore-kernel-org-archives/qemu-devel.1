Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438BEC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFA523BDC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ouh7xgO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFA523BDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmeeK-0007oq-8x
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 10:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecO-0002k5-AR; Sat, 20 Jun 2020 10:37:16 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com
 ([40.107.5.102]:35810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecM-0004UK-GC; Sat, 20 Jun 2020 10:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJCwagPcqxchiaRSwyQwZy618IVFBF1B/u/o/3qdPHWqOHmpH1Faza6DExddBscSahXQ24wpi+MV29JJZNIGDBQruB58paTdeSrt7AgnXIAp/j7wfHdqNJ7PfCG96lwJPaNAMyYdF2oTa9YD58/8YxXau+Mm4wnQ+tNXJCvJDQt4UurwiOOQMUiU0nj3yHCGH7mAxnS38FNwRoOwKVZC4WgxdEQYc92XPQpI8kPpcQh2qKwFCGR8T8f1Zxy6flrT7lW2BNnK88U1Ofg+5loRq5huy6VfTqaO63MKaxKqLgld9fB4tuG9u+rtPdaqRNrILCih4ByNk7LvXzMmr4qWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16gT/kaWnO+B9k41bACSIvfnDldsTZvYxZ0E8WNy47c=;
 b=mJiZwsMUxspfD/TlxHbL6Ey31akCTIuiLeT68ta5c5i12wAGvAmCWRLjb/qPE71xzemPoGREd6uae68V50i0MPW5PXW78SHOySJAs34JJ0PmCVQKZ4P6JPasU76KO2BvvShhXiVsPm4W8uKkruAHKrlWVevCddKEJNR3fi0Gyz5w2/4KtzdGoU8Sf9h1La1Dz25mYWdQdDg5A170Cm30BVH/7FymWFdTO6DL7UGyYISFiCd5q+pM8Q2TrIDDieCrU7RT8Gnyc22dNmpkENz4ni8kmbqhgVtIPw67VbxjyCfEkrTn4bL2KzoZ39l2DajY6j0ApASRiTx0WAeynI34IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16gT/kaWnO+B9k41bACSIvfnDldsTZvYxZ0E8WNy47c=;
 b=ouh7xgO0/8w3hlYAC6eIwEGH64MQ3VHV/I/wM+SuWEJ+861wYrZHNfRBwn1vdpUK0NhMVwiGoVDz9EYzamfoPXG5z3MImgRsSLhUzVJ2eYXEPEUcNh0/gX79o4iHmVH7/HY9ZJ6gcJTaFbC5ZuwzL5mF5s7d3s7AD6jrKKGANlo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 14:37:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 14:37:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/5] iotests: QemuIoInteractive: use qemu_io_args_no_fmt
Date: Sat, 20 Jun 2020 17:36:48 +0300
Message-Id: <20200620143649.225852-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200620143649.225852-1-vsementsov@virtuozzo.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:207:5::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.122) by
 AM3PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:207:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 14:37:00 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c15f3b53-697e-4f48-19b6-08d8152764ac
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430812986E4FD4CA4F81EE6C1990@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixFpgO1SVCvzt0qImOhnGXLDhYBme6LDEomD7fXwE0Xe6jzMtcOxUTDtUAnp/aG5ZgWW1/S/UjSzrBW/W+c1UTckh1jtg2PryQ/GD7qPVtbgLjJOt1Y4ZI43S7WTYl22Qz8RgHRZ7YIS+gJ7d/Gmu3Yn2OJcnvp8vXEIz1cIl78flLnm6EUagJFpofGTqAa4jP/XSHRf4G0B0Zj71RxiH3cjrWRiwegEYExPIVzR+/jjViS+dceP18ePSon2JpuNB0ETyqIUgjfNF/vich5I/5haZB8SPuW01gLC3UaSVFpks+HToeHn5k/pDYJSsFz6qTwcu2e6F0DMj2zxZI4Mdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6666004)(26005)(186003)(16526019)(86362001)(2906002)(6916009)(6512007)(4326008)(83380400001)(52116002)(2616005)(6506007)(478600001)(956004)(4744005)(36756003)(5660300002)(6486002)(8676002)(316002)(66946007)(8936002)(66476007)(1076003)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4tv24ca1pB4NfOOcQJVd+hgjWPW9kl3NLY7w5qJN/YIATnrYkl2fmy3Y2Ih8KlqHFL8YWcvUPf9B65RUBk90XthHdojMYmcTzOVB5JeLdnc4HotBUy/I4SKtGn4TL3/E9TpiYfU06iLLXL1q6irKL4+dyntPyqVsTEIf3tupdNJ8Ks9jm78hNoQVF31f+kmjFU7+lNW5Md0BM0mZMil3vhc+J4PlEnw9knVY5BtjxgZTsQJIRYa6MEMBdZRHoz87R2WS9YhNLORaLiVi0ITqQGB6NI0F7HNG+Xw1PGdbzUkZzsv9Z/c5/av6QTpzDqtvkhMOAg/u773mc8gkLy3KbNGmqU3B7Tz7WfiPWhtfbtWW55kFvp/TfgA5/aZfrmtX3QOrLb2qPvX8Y/JdcnybSqTdFFEkks0iL8Q+LCZ+3QrcPm2I+837KRM7JzU5mewzDzPIG0J+ITpC8YALyDDNxsN+sSWsz8dmUhmN9vw2lGk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15f3b53-697e-4f48-19b6-08d8152764ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 14:37:01.1107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW/2xHb6kpzAvCqJb8+yGXtyyfJetwpt1pt4OKlNpkgpFuxfAoOghbs2/PQuAAoEjgixmXr87zH/5PnbLlSNccvvbCsI4kpcVGrFr5vsSwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.5.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 10:36:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All users of QemuIoInteractive provides -f argument, so it's incorrect
to use qemu_io_args, which contains -f too. Let's use
qemu_io_args_no_fmt, which also makes possible to use --image-opts with
QemuIoInteractive in the following patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f20d90f969..a8f71df4eb 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -211,7 +211,7 @@ def get_virtio_scsi_device():
 
 class QemuIoInteractive:
     def __init__(self, *args):
-        self.args = qemu_io_args + list(args)
+        self.args = qemu_io_args_no_fmt + list(args)
         self._p = subprocess.Popen(self.args, stdin=subprocess.PIPE,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT,
-- 
2.18.0



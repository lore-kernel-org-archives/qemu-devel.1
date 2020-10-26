Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A5C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41FB22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uwer6+Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41FB22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6SG-0008Ab-4D
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX691-0007lS-DG; Mon, 26 Oct 2020 13:18:55 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:17409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68z-0008Ou-LU; Mon, 26 Oct 2020 13:18:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxWSzvp/GiKmOgUf3yD1wrIhhGriZYBOVCtL00sVKYwtITVKVve+a9S06nxSFUlcA1SmzcdahxgeBhsersrndycOEMloNfiuJABJ2fNv9m9O5nFLYf3jlG4aJkqWJcmoeVQt3xLGsJ4uWpu3UJxliHGhb5gp9xKFNmqCEOxWVjMlX6fhQEMwm/EXkJrwutCgkHlFTAjd1EQX4jxWWJ3gVIocxIneTtFuz16a+yn5VYBwiycZwQKiksiTOsBSGhRq5z4xAdJ/M0swqh7KTy4kQ6GLJpz7FEqfxoeCPhLE73DtVqQDkPOeTvJ2/F3SJYa/I6tyDmW1ZJrU8EnjHp8MgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZwoNWNyx4nEg3ZYnTOvQwp3HpRk9+C2ZYXmFxOgbg=;
 b=G7FMcFIDoYcwlUh1D7j85WBl7z9P6BNYp2WbWv7HImKZNpcVPnnp0gSmsLtIFVwq4atACngfzEWythf0f6dz29rHbXHIDmyZ5Wt/6b+BrgxQoJA5bpKa3Faw+7/Uym/ZTSbNGVJCB1YK75c7/cUQ9e2sJhbvy63rwObCL2BbkXp/i7C/Ocs7EewPfJRq8+MTxx2z4NcBJd7JQuTmHbdfjKSIoHPg+YSDKRqTXI34cQS9sdEa3lq3lQH3ZSzg1EK4ErFcxx8SNWepaWMfci6LwCTLL3XDmnZXnL0hS2se3yhg35m6o/pEBALwKYRLomFmWGLYjbWm3DITUj+lL+DO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZwoNWNyx4nEg3ZYnTOvQwp3HpRk9+C2ZYXmFxOgbg=;
 b=uwer6+Mctj95WWjFfJ/hrVe60f4D190zaSoRxOpWp9IFP0nZCq0zPE6NTXZBZAsHmobia650GwZKy+fsr01Ci6ebRDtRli6jNPJHd/UqPFqqaLuioy3XnqeOjLt1emq65PoAOduXfuGBEBBU39LbWmCJz8bQBVIedxm0OzSwV+8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 12/25] iotests: 56: prepare for backup over block-copy
Date: Mon, 26 Oct 2020 20:18:02 +0300
Message-Id: <20201026171815.13233-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 983bfe6c-4455-4338-292c-08d879d32ecc
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303269877E015BD4CC64C1DEC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qGkHLDIDHgefUO3CHImalouuE6Ok4Zvd62K055tOaUGYL2LLtF+BbeuYrMTJxvT4pk8pZJEKqaxHmvKtCOgV/5xHrExpnU8QTaNE58qe9BtECgw+Hbx84WNA7DmTHooWwmnspW3+yzRtxQrOArEHymbgfEsvHNAqHNhBqVS0emr/vodO2bDwI18qJBOHR2hbIHQ5pugPMP476BGAhVdtiqsYXWh/XYUTKJj5fOfkAv2KQVWZzgYkrh7Z9An/OEbkZE1i7M2NCGwanF6RwNCpAtbqiH2DDmnha0rOKYCYBrdCJHmMObXM0kHYMC4p1nB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tG9MyDzKK83RnK784rQ/b9sAXIZhzbd/UlxGqauaT/IBcJzb+SAEopey6/QYpveL7IXzwv8jY2rjc98zfredH1gfOGOE7Jiel3QPEDeiLAVkcHUQFJnox0gtVs8RbgX3Izp5uJrEI+IXldFuoPpmGBu0tdGHdHIE9bADbyq4/W/RFyN4fctvINPPL9IjygcXixBXh++OhUZHkFTkbdUpBtiRMsrvdpLRo83BTSSa7PlPmymIX/aKxAzaLH/CLBeckhLXVFxm3LSRKC2SkJsobVLKSpt7V5gqb9I07dOPW0FtOJ4gy/zJO2QVABvRKm1zQFgcNFmIHvaiDAWGeRkxPX4fhqIPv9JpQR1yblb62g5fxZoaKphAyPq8lTH/Z27xL4sVtsNX+qFQWhAteWD2TjV5ZrABx+1Mhmb7iPzXhi85XKLWTvjJRHPmrQTUyudBJ2VLbuFDXC5fM+rAijKb1DKOmPlbtx9ddQy3b4PTkdbDYuCzA+CrMU+r4atKP0rdykOXn3cMaxrMiXvF/i0FohELBFvLye35osEeEUvUL6Yvg4V0ym1JBGp6+M4i2N/midy992YkoSZGxTPexxULrEy4BklNGZYov/LBFpVQfPoelOuMmF33J8Ae5rq7MKOcl7H+GE8vNJeXGj76UwbCmQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983bfe6c-4455-4338-292c-08d879d32ecc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:40.4690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njovuEjzrSl2UJ4SUFKYeyphS8EazqD/VYcbSRWeI0yvJz2lqWWFpZY2LxNLS9RY3SwS4Uk9vh6cMG5daqOQ8PkLn597ZnTOlSAFoznbYE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:43
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

After introducing parallel async copy requests instead of plain
cluster-by-cluster copying loop, we'll have to wait for paused status,
as we need to wait for several parallel request. So, let's gently wait
instead of just asserting that job already paused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/056 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 052456aa00..e2978ba019 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -307,8 +307,13 @@ class BackupTest(iotests.QMPTestCase):
         event = self.vm.event_wait(name="BLOCK_JOB_ERROR",
                                    match={'data': {'device': 'drive0'}})
         self.assertNotEqual(event, None)
-        # OK, job should be wedged
-        res = self.vm.qmp('query-block-jobs')
+        # OK, job should pause, but it can't do it immediately, as it can't
+        # cancel other parallel requests (which didn't fail)
+        with iotests.Timeout(60, "Timeout waiting for backup actually paused"):
+            while True:
+                res = self.vm.qmp('query-block-jobs')
+                if res['return'][0]['status'] == 'paused':
+                    break
         self.assert_qmp(res, 'return[0]/status', 'paused')
         res = self.vm.qmp('block-job-dismiss', id='drive0')
         self.assert_qmp(res, 'error/desc',
-- 
2.21.3



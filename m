Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED8C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC69A207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SaFEz5xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC69A207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pdX-0005XH-Ua
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUH-0000zo-Uk; Thu, 20 Aug 2020 14:40:33 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:40648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUD-0003Bm-67; Thu, 20 Aug 2020 14:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDVldhG9a/wR85WfIRf8IYRn8aUaJwHFLahtCSFPfhpvHbgGquJ+yftNGlAw5OHiDZNSwPDSaZH2sHe1F+30uSo6sRTYfnCBBBBf6OrDQcLNSKRLXUqtcTrRUvAN/XbmIbm6TnXNK/OUee3q23JPe2ADrvUzSTA+4ZUM4enBOmP2dj0VFLz2cXio5nTNA8wQAT7bqRIlxQlVZqi2InqhtpEjqHygl/VakG/Q57t9Ctpi/z96iC9aNjivok/41J61gSFK7wkuPNi8cbODBnRGK3wzU0HaLnGKpUM5NCWkB0Gk6WEPXvYnbOkOkVEHMNEtoyViukpyuAbWgbgm6wd1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0KimpCIv/9rLHs7Qo/Hz8Izh/rstRbY80vnHIXsYa0=;
 b=gVDpIVuSX/SBeephs3S019UduVrp8I5wPI11oPGy3fUUhx9GLSNMcF6LYxosJ7AubqwykE7aVWDtAMUG1TnQ1sfmZqi/lPUBF6b9kyMsCqhEKPSWj7fRktn5bPYK2prnyJmjY4/NKD7TO7EOLSjsXcNBUbv5Ri1S28B0Lze3gqTGODQwYm6fT3HDBTtdYm7g3rI0BfjVgbgTTooMGCLFJKZqO4r4ifA3jsaqYHuQ4diBkXrb8txzqwKiyq2zxj6819igQOXLbU2hmjr5q3ekrJE3WHPOYxfJn+BX/9t1IBALaVM33Lb1ynOD/R3NVnrnF5NqZiP+2/auInoK7vuTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0KimpCIv/9rLHs7Qo/Hz8Izh/rstRbY80vnHIXsYa0=;
 b=SaFEz5xnLApJdJczqWd+k1HCJZu7DcYy76G4ep+LWfaCV3FHoT58WkYk+DaUGURw71sZTucpmDuDnvFYlS8XaOkEbwPEdTRCtN0sHLgV6d4dZqPfPALlwnF46dKzpQB79cz3JfpLD0WxgZDJg/YOnoFGNn65wRXYE978E41r0MI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 08/10] iotests.py: add verify_o_direct helper
Date: Thu, 20 Aug 2020 21:39:48 +0300
Message-Id: <20200820183950.13109-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:10 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90df6ed8-59b8-4644-1c58-08d845387829
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30327986D5FA3BB464BE7A2CC15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awraZRy1c67R5BxkaMQ1IMCfcrb2qeYsuhDTljwm63Q+SnYpEffjY4XrjVgn6DNF/ghHxPAGW1F40XDLz5wLVb8YgQeCPK6MuYUEHVStUxGJ9fzTfSg++LcNxNlp1Cqk8fpBEe9rZ/K5zKt5o3u9it9WihMsgRLIcykDiN5Dem88Eyecvfy9zFwrQhEdEB7yZIpJtDkV+60IPJQVesl4H7tYJwxzuTXD9Vj0ZUSQoAvRFWq6hTlAWl0HxM/Dh6BWOuxeFcPvl3LBt6lUQLSA8BQLCncQcn5QDjXqTEPMn9Z0Khi5JmQd3QJTR+MFUA222IQuGMVEc/ucppQdL3vCHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(15650500001)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DbC/IL9zJB2MPQ30KUB/KXOIzaftTP9eair5tdLHudmdDpwr/rt8pJeEGYE8VGxFVsRhzO1vsKiEcE7NIq0Gjvtv+isf5mcAvSjdMw9S/a1lcbN881ybl/oJTj0t2JYQqv2aJIqDzpT09GK+PYg74FrD+ZyQ7hZeZCjRlnqK4aKOQGpYrBm5M5zoEx2SbhdQAgzz3lp1meXBVuQq4pp6re8tWR3tvJeQTUYc9DyrIFKKaNKPyHC4l9N5RB+ITvf8R01N9fiI1JfPhPToE4HgA4C22hsBOLk+XcJy3gSPJP0Ma3KSuUj3rcUtSBP9iyzOjJ8zCkpgLABpOYHj9F6l4ZmF1+VlWW7il09XXhzyhrVTMnsOLxPSAJCGaU7+Fhfm1rLWoqVP4phx1Yi0++HWFeXTGUoabgPbMxdmNXVwhrf5lf0Ly2m1ctewd74k4D4xFK+8M4sTM8znemxBajRrjoT0CPKKAtg2T7X+0Lx9UM+WeqxWSz57E3UMOH6PgZwd2VRMS1HKCZQdxBMSzHBBNLxi4QoHBPqQu75jT3MfTiifLb5hzVaENVCbRUo+XQPG9aH4lTIz/PUMoGeWh4q5vDlXV63Wdm+gzkfjZjhk6z8TyHWzv72OC8KhpS/pmPHaAUXrvitjub3JVH4FfuFwfw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90df6ed8-59b8-4644-1c58-08d845387829
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:11.1172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpXkWQif/u26LvoiQup6f9CxphmVCv5ne59Z4gFYtbZVtw9e2xK/Z0poqVh06nJsiR+iFcRzSPEcAhX3OZttRWjmj/yLMD7+lODFOmgmhrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add python notrun-helper similar to _check_o_direct for bash tests.
To be used in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 717b5b652c..369e9918b4 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1083,6 +1083,12 @@ def _verify_aio_mode(supported_aio_modes: Sequence[str] = ()) -> None:
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
 
+def verify_o_direct() -> None:
+    with FilePath('test_o_direct') as f:
+        qemu_img_create('-f', 'raw', f, '1M')
+        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit', f):
+            notrun(f'file system at {test_dir} does not support O_DIRECT')
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
 
-- 
2.21.3



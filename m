Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF3BC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4846624656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Y+N43wuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4846624656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfsE-0006Jo-7n
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflZ-0000eX-NJ; Thu, 22 Oct 2020 14:56:49 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:46561 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflX-0007YP-O6; Thu, 22 Oct 2020 14:56:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYaaUw+u9D+VQpzGWZiiES0r76MMjKpSPey63+Q8w9H85npOg7Lh+90X0UA2X7Axo4nDxfm10v1DttT8HNYdesnXBHadp/zgcuWjHlsGowp5GKSFxmFK8KAodb8M8Lw0dS3V+HVBFLVDahZ+6gwg4uFf7dwqbPS4Sgi1tnPhvxcUZWtfGkkPMSdkRN1xcWoyi1SBi/XbNSaZiTS/6LqQ5lSzHbnunVqXx4lqbYppFZzBGkusorIEWKPdXaRv/RBlhzbOG2NcyrZyNzadGA0rhEhc1yVLIt2JBHCraSptSAio0ZQEXemLOqI2VkjJDY3iR/x23dSh0qLyciBT8RSLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcoN453VkaQJ1KCHTQqgGsQxWcYpPBayE0E9M+tUvTU=;
 b=WreZaZXk6BI8CaWOybfkXYE8HGWFxWTLSSZkLCMavSl7yfVXV7FaaLcW8UYokP79U63EFq6HJKEoZe7H3f3+hZG3Ue5UhNAqQv+RUzJh+8tXTkeNAcw4wodi/5AYlwHeqiqH0bJ7w5yXBn3o9lV98Oc4RpkOBFN6LF9jCA+ikap6PgD2C3ThrZiGTOj/W5uUaeM9CnTldhWXFnIsjExUveB4fkpEAzZiFryNyymCBmPrJL+QtIOtj4Pt+R7wlTV9+ZGbf9oA535n4sh1oJxju1HQsn1dtxgNI8AB4Zd2FS68qW2mXoAokVs6O2MTeny4hguXEo9EU56sjTkAz/5Vgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcoN453VkaQJ1KCHTQqgGsQxWcYpPBayE0E9M+tUvTU=;
 b=Y+N43wuA2GANYvEIANZi6v/tXMRN6slTgsEgciDQP66wjT0bzB4ePbCF7idh490JIGA6Ed/LNim1sxt00Z0yQccvq0ZDm6dt6l4mpRkAEZcGhzs0wPVaTJ7F6y1UFW9yTIjYmgY+0ae3IWR8SDhWdnjJK/xo0AbyI/4PBkOsd4c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH v5 01/12] iotests/277: use dot slash for nbd-fault-injector.py
 running
Date: Thu, 22 Oct 2020 21:56:16 +0300
Message-Id: <20201022185627.16987-2-vsementsov@virtuozzo.com>
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
 Transport; Thu, 22 Oct 2020 18:56:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88f7d61-66f1-4dd7-ec5f-08d876bc3647
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB630903ECB57463B2F212FACDC11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoAufJdZ+VLyekp2yeHoSNMQv6tgU4Hj1KzzjDsLykxFUpKW208RugAtv7YXc4RGjNTMAyhK+6A87sC8TbfzRhQNj9pyPodILxB3VB7zAr2rC4smWEYPuGsW/5mc8nFYuV4B4b/DNKmMnXiNL1BMrZ9ZmU4DPyGQmmWJO8tE/x4eyYcqHU+D4lVU/40GD3pahpiLb6zc0myNFIr3Ju8pAXk7lIyYgfS//0MRYOtk4ozdARRIAyuvJi1vP48UJJ2LBlabeYEB6Opyl0N2llYw+S/EFt6a198L0FyLkAaMJBw4BIuQs3bM5R6Ys4pRalO8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sRYRr5KSuzLaz8AORNHNoM92yO9GHkHqRRTmxw73tbWvL3dgWPWLW3ExxUKXMp7lgiJjko/yLS/WkbD/MlO1kmKJMIRyyDBgo2S3gCojicPTsHGsBzQdMMa5lqXCCE8KrcA/fpWACfcCWQfV5ML1+/2zzNZhPGwPcITW3G1p4TnAswGxSaKg5sCmdRhOMp7e1mv7yGbPEaf66S3zmWaMRxzCwNRGhKs25CQ15Gkg3DJm1y6agijIXmnyYcxHmp28NaoWPUI6QXMro+/0q+Clj9Uwc6lDL065jOHiCljGAN+q2rx4c5vxapAD7EYLIq4QBx/AYZHaJWSQrhsABMiypXJ6G2fUQ00pPBMjFOrfyUwzxd8Rexy0mjER086lOlbmYVqd4MkXrUiVMeDFojSah4BTrznrNxmsdlC87sIL44Lsa2PMqhjm0gg28ufP7HqcauI4swvsvI1dxCF/9sNSgl7672J9509JSHmBGteUoPoXrEE2Iq+GG1G4ComWT8NgXKI2SlPwj1SnG4PzxJ4OUbhDT0VcrYOQpIUBgFFRrNWO1KFRfDw+KV9AZeFDRDvnLe7xu31Lhc01DyBYoXAgghR1Ky979rAAsyvHBuqJMLabQBABDQ7wWT/6bNLYwBUe55FLnpfRr7IEqJoECYv/UA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88f7d61-66f1-4dd7-ec5f-08d876bc3647
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:41.0941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNCRGPoXSJk20eJ9utsVvQENxxnHTBB9KH69KrJK1ZWxxy3SoTi497wURK15gaK8Qi1+O3n019KKkuoI5Al2p0XTX+vM7MkR85vvn6SCa2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:45
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
2.21.3



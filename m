Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC43AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754C8206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t+VbRGm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754C8206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytVd-0006J5-Px
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJL-00027C-9n; Fri, 24 Jul 2020 04:44:11 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:11111 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJJ-0008Q9-GG; Fri, 24 Jul 2020 04:44:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVxvIwfF9HRiHVOZ3F5fl6J0W6G84qh0LOTE0C2EDm4cnMpPIPKMdpWXioCuaM+BbNfMdYK2vYtklQ/GLOESopSeXlTl4YXJSaWl4wMFtiBFmEYKIcZzD689tHE27QgxqaJfDGBKZ/6FUiPYhRCL88RepshYihfzYII4t+OvB+cQt9wps842GMZ+aJGQkKNc5wQzB2goccvCRkJbOUfFzXqSHOP63bRbVozG4UZ9yyg99wvzF6st4AGOAhj0/KlHkan2znzAU+uy2/zRJ2fp9GFUJ3b+wuFGHIUIqXkzGryixaCAk536hcfOy3YySzJMV9zmYv6hsJzO7ohRa3DXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrpnzzDYZYo9NxzTsFhEVcJO/YqGrSRuWdmYkrcoj8Q=;
 b=EPIeYBikY9PzedMp92OxzQB+V2XngfGtMOygdGCPGWi/DFJXommTUNWeOIIahpsKmpChV3jQiRUJeXu37WBdQTlNhFHvFS8UEMwGrh5OzkDkY4G97QMo3dp1rTd5YUzj/yn7ASc7Dc28/lE3DkfugXoU6O79seQaoe6q5aKASt4iBYu6eDstNLMf4om9L/O7i7CuebDeJz5X4v4yzXbM0iO/fGkafPbCgpAF26X1fumncJbKk9C/FFLdrKYwE7fC+cvtNTua8dlo+fuzLNIvs+tM2y2j3drCmxml9SISOn+zFm8ivWv+dcZ/3qgZVeUyeo0UP2hTJWDmGe/iazK8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrpnzzDYZYo9NxzTsFhEVcJO/YqGrSRuWdmYkrcoj8Q=;
 b=t+VbRGm4CahnviHc8/4leicMco8cjSt2AHap/E6aF4WI8hcO3qPj0qqetlTg9qGy9vw/cCokjGUTCHUWS1OK3h4XGfQfEyDje/SJ3fAz/YfLua+ahhIKV6tntuZXcUKtcgMBVvjw1GSLvWGlCFo9OjCSzb0cSyzMoSlgBfpswAg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:44:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:44:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 21/21] qemu-iotests/199: add source-killed case to bitmaps
 postcopy
Date: Fri, 24 Jul 2020 11:43:27 +0300
Message-Id: <20200724084327.15665-22-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:44:01 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cfd8122-755a-4779-c32a-08d82fadb766
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48496C344C2C7DBEBB47EC25C1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuMUj1UmLtTrDUnYUqyfKublNXupp24aG+fwMVCgq5bcpkrc6u9+NYonAWJQbK5OEEy64tx2mmBsw4ao/4oEloyphPN747+cnFJyUYIqXlR7oZkcV9j91QJbDX8eYkrvRNDGRi/TGE+jeGWkRiVHmGsmRsYA4g8613EUwJgnEwHJQvDRAHAOfVKvP6fDPz6ZC7UT7AkURe+h5CIwK4jU25O3/CJPliIv/VYuWXZgy/z2IH2vSHp5/50BpbuwLaNHvWtsn8+tRY4py39Q2EJULe1oCDStBG89fkrAvF/mFyvwtdtftZgHip7obw1BLTgE08cfE931sNO8yVI/cg+0cV7jramHiHr9HnYMOGgJ9UiZpPG6kQ+HKwvRv/Y1w5qg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rVdDu5736oEC2Y+nbF6hPPLwupKcJOEraYRFLcVhhegWI/ViTe4TRnnEAf5/AvnNpR3Hrxs8x4OSll+X/i0ks/LGaILleJNfq9EvQ7sPtWp8ZuRqeWWiMUDofIY8AgPCcoNA64Xhl6gnovclgjZwveb9tdnXvsCA/so/Neiu/eHMhwK58VGF+lAhLLpNtDU+Wv0bj0R6uDQHEzPJQg/dKThlRRrusOYHdmOSQiF0/WtiZM3RHEYi4+axc2E+TF3RrZdA+GC4ON5n4emVQY6ZIfxVMzct5tfNR/zM3ukN4ro8iO4Pl8sZJjriyH9xvM4zwg70n4cm8ydqnEb/oQuFKewDfge/fNGZZVoB6hffuBbU9LvzmjqYnA4Gln1Dj3F3AV+tXTI84whhQ6U8P1Al+zRiyjrU/Eptnzr99tNG6gIhasYmEHNv+JB83vBqQhSrzw+JC84bLPV44AKOWcuFrWqCLBuJAyb8d2LFX3UjqfY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfd8122-755a-4779-c32a-08d82fadb766
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:44:02.7002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfzjr1QNMt71CIqwjOvvU7z5PggH65XxgczWEa6Ufbr5pG54psqZL7PuspHmpSFU/0au8us+uRUpl6bKg3Ak7ZoTEe24td+Eu82LCwDmQx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.6.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:44:00
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous patches fixes behavior of bitmaps migration, so that errors
are handled by just removing unfinished bitmaps, and not fail or try to
recover postcopy migration. Add corresponding test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/199     | 15 +++++++++++++++
 tests/qemu-iotests/199.out |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 140930b2b1..58fad872a1 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -241,6 +241,21 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a.launch()
         check_bitmaps(self.vm_a, 0)
 
+    def test_early_kill_source(self):
+        self.start_postcopy()
+
+        self.vm_a_events = self.vm_a.get_qmp_events()
+        self.vm_a.kill()
+
+        self.vm_a.launch()
+
+        match = {'data': {'status': 'completed'}}
+        e_complete = self.vm_b.event_wait('MIGRATION', match=match)
+        self.vm_b_events.append(e_complete)
+
+        check_bitmaps(self.vm_a, 0)
+        check_bitmaps(self.vm_b, 0)
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/199.out
+++ b/tests/qemu-iotests/199.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
 
 OK
-- 
2.21.0



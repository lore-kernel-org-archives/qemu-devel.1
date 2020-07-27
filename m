Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BAC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D498206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BYQaaxFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D498206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k097o-0004Ap-CQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091w-0002WT-CZ; Mon, 27 Jul 2020 15:43:24 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:11911 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091u-0003hz-G6; Mon, 27 Jul 2020 15:43:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jF6BzuUrdimr0HCB9y3aIKQNZHOyhck4DHxu1Pff+vPuBT/xefXAIY5TxcbNaFIujjObg36jXwXOtV1W3LC+T0e5TJ78YdqiSYJgnSXlY/djWfMH1Zc7pdFtYUeSkbsmf3j3kFWmi+JKU52lPI/QjInJHPNRnR2QtIwDiJrFkZk7nJA6oyEGADc0yCsb2fuertQXw/Dff++O7kVI51MBWyIi50bSYh6hUonSSMtyLlWuKEPZfPy6h2ikBY+DkGw7LGDZZmx/SrX7lEFbpOP/8d8H6+5xpzYTWkrDCD3b11X7rhg+DXYdhLKemn2rN85CU2b88EhJ0aj5+bqmajonBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm04YX0M+X7fJbdDSJnqO8rss1GGK+oP8h9NdTbgmNY=;
 b=H+GvM31cGzMSf5m/uxmMa2LxZxcfI0+zU+PH1RrVBpwmzeQRn7XwNTqoHwTJyLQsqFEfeFdaF9vxbDH7V9/Ng303NuC0TxsgdmpdHKDVVTyeUOgD559cXMTnsfIiN8wUJCZxAIU72VCDUj/ul38VJF4mnLHTVbrGaLxGgNsWGk4dFz42NMvdjgrw8VLeNLAqzRGvawMlvLO/aNhsr6PZZjwY24NXYMpnDY6kFTBj7wb4Dtm3zwoW0EvVZPppplW9YE1b6xdPOI+uEChkeYHEZyCVRxLYLdkqecDDWZiDVpLnjfNEcwHJ1w8jCgZvc02MytGoQL1mYsOZJG5rU0/yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm04YX0M+X7fJbdDSJnqO8rss1GGK+oP8h9NdTbgmNY=;
 b=BYQaaxFGxBiPPw+cS+zFpOkOvG3Ke4nA96tRf3w/G81vZl9638pPW66kfjfWp2kIilZPPCoCyA0R2sYHCSrOecTBl1g/TpllSzlojNPPQax+3AqgaT9bMJecqT9+nLIgS5OaqnxvkybkLRKSQogmFK1hau/BLkB+udbotXj9XIA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 21/21] qemu-iotests/199: add source-killed case to bitmaps
 postcopy
Date: Mon, 27 Jul 2020 22:42:36 +0300
Message-Id: <20200727194236.19551-22-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:43:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0d8c1a-3f03-443f-6e56-08d832654b17
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610E29390B83EC5A7D7C1BAC1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:134;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2I+FYMH5VTSM7MbaAx62mvsZcuk5ktBoCFCyZpchJOEt+tWkpNIIW58v+jNmoST8UaUDlqmBTE4ydmbIhfhZQq8PXdv2hEvGHj/VMfG5YbonWoiFRq9G20ykUZEiXXgeWPgwyb+UOJ5EW5aP7XAofIHf5xvij8asVwXtSFWA6m/g0anyoj5XH35eRMWuhy0wQxajy/uBtrNqVRVBEKIbSmldUW2MeUNnaw5vV4AkYjM9AIaX443Z8sBfZQ5Z4oxsrXoK3QoLaK2X/qG5lzXNFVGPz5VLEFZCE4A6BnfZnw39iYBGf/xvCH9uOjG1BdP+la8IvrwZf8o7EP6jH9LIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ce635EVMrv9NLOjYJlDA6Zfl54yhaj3MbozzQq5XahcX/SmE2xQ/uIP1ZZlRvcPHt4swJI2P1PjFbc25UwI6tSQMA9pU4Xi+eczxieFyi5Oj1LuEfoGwtY8YFJcda3Z0YeJC2+z0TN3atCmyPv0ktyW8xfxZb95Pq+kFtr6haYXX34TYKKzPobfgXXo96qj6KylPVaovYZH8fL5NZzIh3b3OObax1YsrO3QFWxNluxY34G9otneQyDQSQEHrPXSrwTgf9qGvdXKpS7wtMvwUQ/DFJmqu7IJ1vTMy0fvfj+WSsa5Stku/rZfx11jqT/msg/0S29Wri7RPh2c7dBTSyEmkrhmJm5zKCXCd6YrRM+tGOFWTWHeXFyb8layQ0VttqO8vTcOi+MCU3f9o5UpUt0n0V0wQouLxxf/rTge9TAR9ncP8YTI4YFs8MMVJ9F4I+jIJFNwjb8CqCEOJH/QPFLQ0EViDIhOefu3dfvOpnCg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0d8c1a-3f03-443f-6e56-08d832654b17
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:10.7580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QS24SEFDpihE3CcGk79guceWbdrA2AI3fDC38zs9SXrVddhneM/5jb3GDzEiLf7pAluBQrv22Gvdyvnog7+PS/gC/Mu6O4aoiQQYfbYESm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:43:12
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
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Previous patches fixes behavior of bitmaps migration, so that errors
are handled by just removing unfinished bitmaps, and not fail or try to
recover postcopy migration. Add corresponding test.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
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



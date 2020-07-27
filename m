Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EEEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A7F2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zd6lXmhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Ak-0001Ee-EY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091v-0002ST-0n; Mon, 27 Jul 2020 15:43:23 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091t-0003fa-BO; Mon, 27 Jul 2020 15:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEuQEoEgt/Jb3UuWTae3e1q6npPsdDS2qmIVDGuW+jYbS4hNl4EsQacfLmnDqPT1SDQ0XYiC7c4zYZ7kNEprUofmFsnB1hpfl81qKyaHRBDOcRY+U249DJ5uUHvGP6ci3NKDIEOiklP4eWViljnDBizfmOz8egvg/YhVWu0i6SJfZulwZJtMh/LJnZgJXklpwQuYFJRdLAW4pMEfnTKcwhuA+J1hVPF5WwalN2ey41JRMO4QSK0E98cJp3y6PwKpsticyvsJj9mD8cJndr2QM01AdfSXxE/R4d8+prwX+jZWu3RLYRo0A5+eJEVlCSMH49v6e3lOxF5/d8P/Y8Eh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrO+kljmbYPumJMcuV1GQw0egxqY+Nf8l5hm/txiJRA=;
 b=iSbVJCN2s7YAt087ZDCPYVRj7j3UPk29JVX/9jTRl3HVBJ7WgrY7vZbhlscPiF52qbf8WTfrnU4a1fikywDrcIqDE67oBkadoowTlDSoWY8iRyWEE2NBxKsiHPrGPE2PXzCSuhK8vJ3qzCs5ViEKPjlzJDSWls5c4zMpq54rpjsNTJjy6AUkBv96Jr34uQdBUJOjSUhsoDrxVu+GJUReqOIfm/ol7y2TgQVJN9ovKmQgbUj2BNmdIQqU9HOGJLnteYAS2JVppgzS5EIAkWI6ZGx87bNpTFhFQ8baHGkXzWer1iEXBixTGTJoVCLM38ilMlNkSBxaU4u1joi9Cf0TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrO+kljmbYPumJMcuV1GQw0egxqY+Nf8l5hm/txiJRA=;
 b=Zd6lXmhpS47CVOgHIRZa/JLlj34P186J7FNiJHbFEkNXL3eiS7J1If30qBmv1AvSIZIKW1VZ6rJnOIX/TQwNytHOqEPvaPzPWY09Nwph/aERw9Sw53RWA/rClD4249I21qzG3ZDZyoqgNGLvt2WobsKXJF5XezSEe08nnUwHLjQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 20/21] qemu-iotests/199: add early shutdown case to bitmaps
 postcopy
Date: Mon, 27 Jul 2020 22:42:35 +0300
Message-Id: <20200727194236.19551-21-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:08 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78453662-e130-4a6a-d040-08d832654a7f
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610F9AC6F1BDAA288CD70D3C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdxPy/GyO1v3aE0gDNAgoCQBEh4dYSwFe1aieiCjj9Thz3D6RS3ImM7mCZoHgvyyAhpkc9q287v2VEX1M82rd9sFETNFEUe4VvsrmbbSiOjx1YnR+DiKH/hGLhFV7NPIAoSFwVBMNxVOVJqdzTC1f3O2CM+qsI0g0E8wfKMUoJa9pJWKimVIVoukYR6dVYZaTzcpN9tXTSfTZcix/dMRz+ZOKPs+lvBbVjmZ50UsxtPIveFUVYZHYU5sxF0O+072sbaUq2la2sb+xpkYOtsl8JOEzmbrqlA+pvtJGt1cwbgN8tvkTMqHyd+l/1Roj8QvMYs0kKRJHeKpHm3WGgA16A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O12SDqlgPGvkOy/14kCT25hsG1NDRU/SJ4IxzVYhTvibpD3Q8eP7c7mkl03Tbeen8avmHhrayACV3QcNCEi41b3c6CEe7CuvOSmhulWQd6cKY4xND7Jdq3e9sZM4uIxUBm52F5P4aPplUDLMEk5bISah/w9TWlMtD61Y4GdtPEBdVHMGBSwwKuDmcJ8BbPdSjT6N/T77yBSA8oyPp/fjkl6NmGHsOgwURLL5A7QUxCvUG98si9vBg5waFvs6M/F7k7CSm6Jh6FeMxRCj+77KtWOT4mDN0rKi1TkxPwl4OUmlSCVNQgJEfG9LAxk2N+dpV7e0m9UlzqC/GgBc8b6cPaKQWXU7kYkmxBzGwHaP1VZTfNc9VF/Cu0jy25NBchFhAfVxish+BOdfHV7LoMnLPr24gF6LOy77OnnVN+19jwMQz+xdnPcU3TEAnAU5muVuLpeJbh/q/bjmMK/WLUYFMahTrBW9eulpSCmCF+kj35k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78453662-e130-4a6a-d040-08d832654a7f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:09.7892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFgljUH3qpUTYwsbn4j320e+CkEwAwDMIcw6EroP3c9xxDGVPazPSlggeqqm5tB6vd2AvYBXd/mVUdF6mPP1HGWOJj/0kcupjVGML2eNfDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:50
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

Previous patches fixed two crashes which may occur on shutdown prior to
bitmaps postcopy finished. Check that it works now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199     | 24 ++++++++++++++++++++++++
 tests/qemu-iotests/199.out |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 5fd34f0fcd..140930b2b1 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -217,6 +217,30 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             sha = self.discards1_sha256 if i % 2 else self.all_discards_sha256
             self.assert_qmp(result, 'return/sha256', sha)
 
+    def test_early_shutdown_destination(self):
+        self.start_postcopy()
+
+        self.vm_b_events += self.vm_b.get_qmp_events()
+        self.vm_b.shutdown()
+        # recreate vm_b, so there is no incoming option, which prevents
+        # loading bitmaps from disk
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_b.launch()
+        check_bitmaps(self.vm_b, 0)
+
+        # Bitmaps will be lost if we just shutdown the vm, as they are marked
+        # to skip storing to disk when prepared for migration. And that's
+        # correct, as actual data may be modified in target vm, so we play
+        # safe.
+        # Still, this mark would be taken away if we do 'cont', and bitmaps
+        # become persistent again. (see iotest 169 for such behavior case)
+        result = self.vm_a.qmp('query-status')
+        assert not result['return']['running']
+        self.vm_a_events += self.vm_a.get_qmp_events()
+        self.vm_a.shutdown()
+        self.vm_a.launch()
+        check_bitmaps(self.vm_a, 0)
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
index ae1213e6f8..fbc63e62f8 100644
--- a/tests/qemu-iotests/199.out
+++ b/tests/qemu-iotests/199.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
 
 OK
-- 
2.21.0



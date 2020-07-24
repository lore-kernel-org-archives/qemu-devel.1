Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C0AC433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB3C206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uC/qqEBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB3C206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytTV-0003nt-Vu
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJI-000221-Uk; Fri, 24 Jul 2020 04:44:08 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:11111 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJH-0008Q9-0x; Fri, 24 Jul 2020 04:44:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Za8i8gjz34G5ytIH//Rth6WwNi1ATShBerbrBsN/KYk9TDC8wPtX7TkEy64OPhzMU0MRRPQ8fyErfyctYxeZUz+JAPAnwayD7LZE9n1gpelZQhJxdldEsD5n7gA9yOdCJZ0pqmYBZWrYxh4Q9Cgr5xERr8SXILVBO1gpNRTi24iSKkRuxyjAtyYaNRIaDyFBDtzrAsc/BLaJ2owsVRg4I+hJ+209ZSEHAlgzL3YWX2LjzOZacl+C/DpCIdzrVxXtHa+zQ/mXiAxwLV492JiKsp4IkK6LZJw6Wfy5/RyZuSoVIJ8lRD9CP2+x3jMS2fAMYWmm3WfI7oGlIPIzNfTB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0l1ys7V+++oo7VoKW7UFu9i3c+fk3aaaz0LaHhrKRQ=;
 b=Hj/9BULz1nSqbZOt2dqXUDD7BTtnopYA3/tvkkZmTiG8pZD/G4VCsvUUtBN/XW1ziMz/n3mKhihgXRO0g0C4gVP67mi6+/AmrYc/3vm5nZPGxE7i8S2QySyRG967k1fVjy0Vx8hnN3F1FhHAJZKrxtH6mPIUhmwNt4SKqEvcgVIyUmyQP7Wvr3Q7Yde3veUR4lJYWT9KqR2Ilot5Ro557Imoidh8xPGRDtP7Gv5nA5Iue1MZ6vfTSXfBO5nE+qtWG7HOduulrW2RbEgKd1dYWbUWEytvd5i+Y986to325q3xkNkHz5rcW4i/o8DGJV/4LhMaMl9FDsoMTgrM7UcmOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0l1ys7V+++oo7VoKW7UFu9i3c+fk3aaaz0LaHhrKRQ=;
 b=uC/qqEBU8xVN2oCXQcZdknQzUAT8suPDTUZdqrl1f2R5zm1BBCfE0OFrGzKyBqbx4F17lrv4coElCKM7I1T8ovHF5tfiP9FYZZWB69cfrhiuDDQDO+5f856KylKbhCiq5IvCDmpeiRGd4Yje6YvWSCdKSFC4LO1N7JHtEsucfIw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:44:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:44:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 20/21] qemu-iotests/199: add early shutdown case to bitmaps
 postcopy
Date: Fri, 24 Jul 2020 11:43:26 +0300
Message-Id: <20200724084327.15665-21-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:44:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d106514a-8a82-431d-b77e-08d82fadb6d8
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849F3E71840A47B7F2E35DEC1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeWzlvsZA51O5ZPnWivCsKBocbKKCZbs4vO8Ewiu/4Eqiuq5HkUq0PvXuoOLub/3RIrdnwIzE7cuUApMlhGysmNPUxn/x97B+FetGNvg6COgft6oQYgPxyALzsWsiU1M5eGYtGG0jYy9CUbozVJoRVnwIsBuyfHTB2Mek8dITCT5zdM+598r7NBJBpk2QzMwjO73mqysMGiTwei8T+mqiwMmWTzKyj++zh0FJWo1k9cto9WBDy08EQ5bqQazBdsWxJC9AJPWiykezNBI3bq7jOpNupSPyelCYgz4fZ5k8RrhvOqwKhzVyiy7m0N0a8Q0kiAFLtGyP35ONoTQ20lbfTUuHCzTD9z5MTSu9swXiyoH7hGkKRTsTHUzBgaQLWXI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7tqoMhfmaVvNUu/PELWq8pfkTAhMD+QuvyK/Bhme7JhKExa+GBsqDawFLtLnVE8LuriGI5HPEEuFMQ7pw8fTsH9nZIC9iuTXNqe714+shC9ss1BFXJqL4loT+Wvx+t6oczfAX3Jq2W98XW4PzzjFupxJK/jbAyqPNOdYd3bT2xATuzyB1mMk026DtsUqiLDj27gueT3ZYKYYmNbNmgE0RwHP0jTqwa2jaxiI4trSA+vvtm6BbvE1ahvIzBHgpi95Z9w9ILttf1daPGlFNMKeelH5V4KmE5f7aeVAj2OIfS16V6MJLE1t5uC0Uy9UPWNojTIpuVHSYSfiweE3h8lkF5Yqy5961WNBHTxZu/dzsOqhNnZLLGlOBiKDzOq6b4mGpGd+YLpFDx75cdughKgazLQ6ln6GG1jgJCtATUGniG1DVMWDJ63lDhG6B539bwif3NSOcSV5EezQocRF420li9+D2GVuzEQ2poGITP4WrP4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d106514a-8a82-431d-b77e-08d82fadb6d8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:44:01.7683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6KRlU01fLidi2pxnU+rx3ITsMxDWICkiAvAY0OC/47qor9SP7Cc4S2r5Oe5LuDfbKIpk7CB0VRCMYSz5gGKZDDOFmPEVK0Hgoou0Rxags0=
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

Previous patches fixed two crashes which may occur on shutdown prior to
bitmaps postcopy finished. Check that it works now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
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



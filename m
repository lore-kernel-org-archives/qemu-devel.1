Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195ADC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A63F2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q+vmqlEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A63F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6M8-0008SJ-Gh
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX693-0007qJ-Jg; Mon, 26 Oct 2020 13:18:57 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com
 ([40.107.21.92]:44161 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX691-0008QM-SV; Mon, 26 Oct 2020 13:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNsCApa3vhe0rGtjBsXuhe3tBytyYcB7Ke8DAkvY2jSoBPmLFBJlj2eoq4UIW7FUrAhDDRxF+PcAwfpxw2tL2BO/CXs20xy+FKaUUeJJfE/y1ZZwCuvKAmPMKyoy2MTvmoPgbn8mkwBliPfoIu9iwOS9qIYA24bzj5wRQnExkuh5OiM3iPrM1KHY4MDhgwiiLpSqrmmEeGetTQ+12FIAzpdiZd9t5Vh33cjnAn+Y9RpICWUTI+AdIrWZeOXfnVXKyME4v/yMGr1ybNqWXU1h4ci6J/QJueNUWAXVN5VFg4ql5HBsCwOQ2vb3PDC+ClAiCPfhxokEZwBwXi6PS9G48A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USpBnH0YGGjaFPx580wvgDTym9L2LgIDWFDQzHKJyzQ=;
 b=Wwg+1ewHrBiAcVfMLElxWV6pl5njWO8U5uu8RPkSgGH96Yw9DaBx9Kg0zmkmBFt9pfxPVz9S4YrCEA50322KRsoAhK0kn+UgXYEw1+lgKnwFxKiaK4JIgnkTz6rehgP3F92nunexS0yxSeLYk9ei/hpIG7CHz+l8fPj2RY+aXSQ1NHQ/Cvn53JYUQvCqJpA+9I4k3PQfht7P+L3VTpJh4Tlu+XK7RjbzVnDxznsQzQKI3J74DPXu07QIaUXfCRCZFFny5i3FID3XOpJ6xbVQTP24XrkhkOL08/4Khxwa+IFFAjt+3mgHWLE5Sqe4r4oYSmnqwADtsoLW86j8pYsGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USpBnH0YGGjaFPx580wvgDTym9L2LgIDWFDQzHKJyzQ=;
 b=q+vmqlEUOaPpmNGpmgodzcYXjxPkqmgIFTaGh9+vU1j+SxUN04JQxIy7m3qiHdKlm0E0+s2w1wNhHMTKHiB4qfBwK+Q2NII22Plm/m34ZwIrJEUzNtnetgINuC3KoFw8yBTV4k8jQzis4bmHKaVZAd2ws9V8aH/MRKLUMJJS5dM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 13/25] iotests: 129: prepare for backup over block-copy
Date: Mon, 26 Oct 2020 20:18:03 +0300
Message-Id: <20201026171815.13233-14-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd16f407-f256-41d4-6269-08d879d32f58
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB303289D8FC236079B0908263C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ygo+S5468hW/V3KHeSDQtaeS3Xedppex+WpmmObYJ7sXOWgAprJN/CwL621v5QHq3gEGIgZji7+WJA+3tkP83iYDQykeEjk24ryrOkGr0hjzUxjzksEqTUw90c5cCn7MGwFPQloxQRRT711OOXJw0kj8erTDeXwydpKjI0sauVzdMm8lLrWsagAASBe4U7vqnY/pVK3YY1fc3rZMmoWVJtNJPv93h3L/sIM8uGH6QDNCPIFOk/EWjVILGW2VVOZJqnTujm9NMkSS0ZeCJThyJX0ey7GTGiRDu5z+C+Yup++Qxf+ijkiJf8LPt/65yx/mmXBUKx0XUeyyirGZYZ7FPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ko8DY2oDSB43GDKnEdmB7ZpilMwm6DMFN0Cmfr1y4F80oNDCYga3Qe9lfVbQT+DWbKbHcDyGc84M3g8LAufx42UHUcEYEjHZah++NJa4PIOXla59nHlbB8tJrSu0aGAabnuoxjMRoSJcE4Sm821KQCGPAHz11KQGM0SKCyeguvw1mizH40+oLteXWSROS9AnhA+viVf0rJrRm1kplWds0aMGTNN4TTkmlTzr3JXDrQc+ucoEYuxMeo7WyFsc++DSjSVgPh+mg6r5KYv3NWvgeafDsoJxGE5dFTiZqsSTfYG7k+v9FXFpE3xvE9eXYu9T3cUxjzioAMZ9kIfEBw5DiN4vpSQEzCA6RisWofLhrnZHBPV2/c2lJJV9ueFvOi5wSCsea1jBImJCOsO3pggiCvvOAGU9vPAy7i/fe4dCzytIHSlqIEatofDQG9Tzj/ybctaiXnW1H4oHjJ5PNSpr/1JyRyIg7tf0/zNvC0tAsRD4pYNoij+yBIqPU+94CyFUTAYFnhrJHHCEDP7XgrIJJvqEgOJ7X2sbRLckXE1jRufxa56DSLxNSEV5b45dP6eUsjzm3j/dsWDUgZXlNksSDoEke9K7bwYY7Zqp26qLqJKsEUlwAMJaBhXflcozNjQsVeNAU0MnBzjuylKQI6JLOQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd16f407-f256-41d4-6269-08d879d32f58
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:41.3939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/8tY/0chAYrkQVtWKNbrZYFbGX6FAFXuz8NgloNGpXVaJVukC01UkcQaGP727UfoKCXEEYCiJMbZjzem2yejnogxT6QQ+YmI3EWqWvMC/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:53
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

After introducing parallel async copy requests instead of plain
cluster-by-cluster copying loop, backup job may finish earlier than
final assertion in do_test_stop. Let's require slow backup explicitly
by specifying speed parameter.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/129 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index 3c22f6448c..e9da0208c4 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -77,7 +77,7 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
     def test_drive_backup(self):
         self.do_test_stop("drive-backup", device="drive0",
                           target=self.target_img,
-                          sync="full")
+                          sync="full", speed=1024)
 
     def test_block_commit(self):
         self.do_test_stop("block-commit", device="drive0")
-- 
2.21.3



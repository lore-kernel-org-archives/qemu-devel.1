Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF9C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5E124656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Zs8oi0iZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5E124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVg1g-0006pd-Bk
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflo-0000vH-8f; Thu, 22 Oct 2020 14:57:05 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:46561 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflm-0007YP-Ea; Thu, 22 Oct 2020 14:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyjqjcAS0jSJqLtpxS9i9W+wZRVgV16wWGJ9k3eYfSQo29wLQNqotaG1/Q8AaIucizq10F+zJnUQ/4MuGUlwoLfodHzTjrVXPQv44jyafLv8pg6IvOUG9F0sD2gfwTZWaaE0IxLoDrpbFeoQ3hIKpy5F2U9muCTJAEHO9XYjum84UOL0sl6tur5uIGepmYb/s/uDQV7vqg7TgTr8m1DFUO2QWA3GAZZ8YnqyWe3QLPPgP/zsbNSHaDyrz7gS6MYK5F7YFms4hPGlXe1nWSHJUWuQC6VlLcV+Bkh801unBpQ6Vgvtk1Qq2DNqk4hLKnPsE4Zyg+vo72cTBu5fIhyMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVb2/G5cA3NX4Zl6Gn5EEMYIcvjcsEKJPQ9DggVODqU=;
 b=JVtQcjBXP4wkgXxzU+DWJ52tUVeOhnNnA+L2VzXcQwPRmV/lMWUWEFicskCj807USQL9xVbEzXHwzsGxJMwCwI9Y7/zP+M1Xakd5tCjfwnUqjCqJeRnTHqJOA+whBUSHLcpabtMQ/lhLosmHVjcBomxougfe9CrbTlP37Vbvz834vyalo4CZLtBOZxK1pxz4nMQ3xggkbIP7gRUWRsWK10BNgYNOonO8Y9kaFVfCeWAdGw/918Eb5M79fSPkGKgmyrKDvDHADRvBadh5lM5O5RH5H+ZZHNb9R5AWryspDnVS1sCgxlw4yfUXqW/Do/9tG7AFl5/LTpf9TUj8hUG1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVb2/G5cA3NX4Zl6Gn5EEMYIcvjcsEKJPQ9DggVODqU=;
 b=Zs8oi0iZ1uf15/C/NtWKNtcKfpUcuK7uMZTwlavgP2nGcx929ohhtRnFPFhVA9vPKCXLcYWj38+AEHqiyy9b5sTLqxpeUSqJcJsm7lqyPwl4erSdnjZPLakvYlRjb3Cjpk8TTPBG9EB3tnBlCvicSD0gdYolgtjLBfT5K9HspQ0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com
Subject: [PATCH RFC v5 12/12] iotests: rename and move 169 and 199 tests
Date: Thu, 22 Oct 2020 21:56:27 +0300
Message-Id: <20201022185627.16987-13-vsementsov@virtuozzo.com>
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
 Transport; Thu, 22 Oct 2020 18:56:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03fec3be-3364-4551-9f89-08d876bc3b78
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB630980CF94740B8A213532C7C11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLtlPb2xhNfWIfH8nPb3iNEQmx0RFfR11H9+ODhZRNIK8wBwEc+TcRhtZSs3gKl6CNVxtZwIE31G4KoCaw5ddMU7P+ABbWV0CiJNQZvDZDwY0W7Fh18TJfYyZJCrIz+MnK0Lu0TD68aIzxromuUAx+VGZSaqAJpjG1dPv2bffbNtkdJGaCqBdTGDgodxvtFeXjf2KhgxuPTzIWoMl+ofkzhTF8fbDufL+4Qc8nidDu+00CKi4tIf9uPeRU42Mv4DE0HGN4/tc0fr+nbyWs29GHeJ7an9mkZO56g6W66KUwKf7C9kcQFjuSSrRtiAbMI9q1wUJ8I3rV7mQbSCXpnzdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jwioV09Juxi0FOAXssYix87BmS+K8NiJQVIjGeYmGT1uMObXrxl3wq+oIAYR+Jyx5MJlauA+fFUxPuTm6wX9NMBVF3PTIzSYS/uFs3Ld0hb917tsigAuS2SKYNdaGSdGrD77TjUg7XejVRlUlnshUMYAvNQa1eUfNjN13GAPh8lMM3eVc6mqcgm70XGFMRpoZ5DT/FWHHMWItcTpsYc4U9u9rGWrrMuflqRKlxOuRB0BeQshzI2/Z2Yk+lwLjgTPrKLzIG4ESHnPu3n29/udZXa5Bwscj6J8rLZ81SSj4Tvusq2LYc2IsxOAi0xeg+X7RoSUCi2UZYBHvSmMgh6zXY/6B1W3mT/4gE7U9DPdSYo/dNL9LOel6aqwWPGBYLk2VY9y2Mo5zj+ipBYOCJiB2Ipn5LE37YFIchC6G/yUwMIKL8aOc90ic2eqhu/Ekx628WcNQo/bmLTaNsFHx1ILYtXKt0SKMsWrPpfS4FlTa43WqoVEcG3ui9iplr/UHyNu0wOxb5pGzHa6+QyDGL5Kv5hMh/p82CBkPHHze3+w6Rf0bZ+sJMlXwNRZeaNZtTe4fnRZ0Oj6ty8Z5iOHFSzRzm6A8IKT5p86ySIq7lIUMs1QiLc8r6FNwpBpggR5e352FtFJ1NiDj9V3ZWkCyVjjTw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fec3be-3364-4551-9f89-08d876bc3b78
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:49.8088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9M5almqQ7+j80Lk8bSVL4gvABpkxRfbxtEmNNecCpdi5k9DDf0ozqiT2e6uAfe1wU96WpJ95BK/qP8ve7lXKl8t37Wqs4gSmCSQRd/wyhtk=
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

Rename bitmaps migration tests and move them to tests subdirectory to
demonstrate new human-friendly test naming.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
 .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
 tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
 tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
 rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
 rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
 rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
similarity index 100%
rename from tests/qemu-iotests/199
rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
similarity index 100%
rename from tests/qemu-iotests/199.out
rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
similarity index 100%
rename from tests/qemu-iotests/169
rename to tests/qemu-iotests/tests/migrate-bitmaps-test
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
similarity index 100%
rename from tests/qemu-iotests/169.out
rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out
-- 
2.21.3



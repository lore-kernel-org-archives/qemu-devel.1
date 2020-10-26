Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF16922265
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WL4/npjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF16922265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6X2-0003iH-VG
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX692-0007oN-Ra; Mon, 26 Oct 2020 13:18:56 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX690-0008NC-Mq; Mon, 26 Oct 2020 13:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FanJNA5KpY2TTffPQz/0fyfrf4JjeN7qHvrBwsHHwM3InKlItcPn3f+Gtp8zIgPmlZzjwunWO1GbZ6lGd8rNJqhZGj066SPLCxxBnUP4Yh36q8eEPyUjNSQHqh4Ohr6taLwqAZFnBJ8vhwpMqCqprUNSHcoKZSe1mQJYm60ZtyDjiYTP41qnKkyeJn0RAw87KZtl6Cl/njQ8c+ZKFsqGrhiLdCa269b5oQLIzUwK163JEzXh28uzt2OPE4wAfvUnHF7LloUxh21RsSZNk93Ip+6QpWyP3oMIWL1Mdd1zxZTLSg4hXxkeF2jwilgqA3X1rP4lhoZkIx36GY+hcFitsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF2VTnE/lfj8+MzIcBBEP3DczQsTl5DvM4MCEpKPhFU=;
 b=XVWK56wmu/MGCDwgl10Nx0gmOHNt3EMVuftM8iAFfiR1cuUznF1e9SR854gHcZUHJnejho4V2vbMqY584IieG9OIvCsM++zrfof6+4UWUgxbngcnnkELM9xZEmin63jsZ7KJbCIdy0fUg98nL1Cps+DAd6WGHJNLVCfxQoEzc5U/E1OXfsS9AJkQ8engqXV/+34qGja/zfzyavh4A7OAw594xBLmPDZ7no1Ho9hOa6f0AnmBv18BAgU57ubQMnBGJXRLFu8LrcQkLnITc4sPKSl6lcz6TNjsglHUReCSwSn+XkgEyxn/Y+AYQfanCmsXsWkB7KZwG9KChzIb+jmCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF2VTnE/lfj8+MzIcBBEP3DczQsTl5DvM4MCEpKPhFU=;
 b=WL4/npjAY6Zff126617xj6gz4NzgXCS+H7WnA/VwhMhz0uMS9Nu6iaLzRv6MctHfQRAX1lPpzWD5P0BhL+sQpPENwlaJfU7MhfQZcgvh0bXfF1dq6pAkzeVIKtFrzODwuXwa7FGA+nQRgb1v3J/Ebl2IyqyIe+iui7BnZUFVNsA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 14/25] iotests: 185: prepare for backup over block-copy
Date: Mon, 26 Oct 2020 20:18:04 +0300
Message-Id: <20201026171815.13233-15-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d4fb9b3-e0dd-4d0b-30d0-08d879d32fe7
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30329C6158CAE43C71A4912EC1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QvBZNZBN5Pw0GgbKwIgt2c64CS2+4RUMYj2B6qnr+VYQCM55xDL4+IUMtwRxsLSO1i2JYbwkP4ULWBlLxwnLy5o3qeKDodMmeu1Co90NNRsNy1G3dJfju6rjM1bvUPuWVrSqvqVqw00HNXpwfw4jU6E4VSdTu0oWfx7D6IfZcBlTHp11JPh+V0t0tRIMLB4Ibzm2je1upzR46CoTUUeInfoWAj4f0hc8FMHN+kCUFFokNCBut7WBE8qtSOU02tamaGS+EG4B8gFG2YdAZRd8pcxuH5FM4+va0i6VxCjJpoqDXI2iq+MRGEx7zyrLhmul0bzmw+jKG2cQJIJOHRI2fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tlWi6+GrvdTXrDf1f/XJY7xe1WX0PvJY+7Dcg/1oQ1mNR8Dn2Ih0KEXdCubN0qvqPt5bcOTTO2xBFNg2tlgNalRehkiEBgFBSD5UNNyXZ/5EvRfmh5320FHExWUrzILZK+MJ7ABhxP0NjzU+fSIB66uSH+JTFuVG+/fbY5GKKDvb9CI+dZYJovD7L3r58HeYd5rAX/Zmp7TLO5qiU0pj4PPLpwem1AiPLQkV12Shn1gR0efd8LKG0iFgGUreJSQdg0/dTD3MK3EXrJ80cHndqlMg4zgKqRBhoeiO/a3xzkG5vxqnWsErPgbBuSmB7VcZjv98r+Qb/GfKRCZNDXqUK4cBGQdffxKJ2z6wAVzhGgzY5y0kdqYHqCTshkDk9u2cMTn1Cep0gQu+J7WrHoEvtmWZWOFm824jIdCWhKBgzY/DzxkXK0h5f1wTp+w3Rkng6j77PJSip0469k0SyE6/lYszExm5APt+KEnr/okp22/g5JURkJ8h1QIhCm7LewZFPBZOSfTRP+yb0RQO9jG6FOPkWjBSyH1TlszFqE1iiHQBoAMEz8WeFn197cU9aFPXXSUri88mhGZSQy+0OrS7QvRAyk97zcr8Gh6zEE4O40VvWVOkehlsNxnvXrev9YZPF3UoB0zYZWnrzYBv2b1zTw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4fb9b3-e0dd-4d0b-30d0-08d879d32fe7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:42.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3RAwhDcBSkbiMF4dsX5evXFkFmjYi9/2gDiwHJB2eOWrRtVcorFtdkkhSqRaAAenVf4M4VGPii73qEFl4aJHm36owv2oeJX1qWCivAOztg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
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

The further change of moving backup to be a one block-copy call will
make copying chunk-size and cluster-size two separate things. So, even
with 64k cluster sized qcow2 image, default chunk would be 1M.
185 test however assumes, that with speed limited to 64K, one iteration
would result in offset=64K. It will change, as first iteration would
result in offset=1M independently of speed.

So, let's explicitly specify, what test wants: set max-chunk to 64K, so
that one iteration is 64K. Note, that we don't need to limit
max-workers, as block-copy rate limiter will handle the situation and
wouldn't start new workers when speed limit is obviously reached.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/185     | 3 ++-
 tests/qemu-iotests/185.out | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index fd5e6ebe11..0efadcbf62 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -182,7 +182,8 @@ _send_qemu_cmd $h \
                       'target': '$TEST_IMG.copy',
                       'format': '$IMGFMT',
                       'sync': 'full',
-                      'speed': 65536 } }" \
+                      'speed': 65536,
+                      'x-perf': {'max-chunk': 65536} } }" \
     "return"
 
 # If we don't sleep here 'quit' command races with disk I/O
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 339438ac68..dd31d69cea 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -61,7 +61,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off
 
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
-{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 } }
+{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'TEST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536, 'x-perf': {'max-chunk': 65536} } }
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=67108864 lazy_refcounts=off refcount_bits=16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
-- 
2.21.3



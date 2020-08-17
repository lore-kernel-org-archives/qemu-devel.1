Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9053FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1622072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eEnbuC/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1622072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bTg-0003lk-Lb
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFq-0007r3-R3; Mon, 17 Aug 2020 05:16:34 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com
 ([40.107.14.107]:49892 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFo-00087Y-8x; Mon, 17 Aug 2020 05:16:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsBr+O19PKOVLdTPc+9HhCyvlR69HsOjj+ZKz3fgGriPyT387VQVZdREQajVKGqZRI68j6dqEWFV52FjyfllPRvM6T9acjBptuMRVvXazqVsUiYU5tAMU8WvcTr7jWy19nRLP4ReLcXgNAsNd2CDij1EoKxtD1TO1c9PIjLhvxnXTpWIBEW2orcwHMCKvvHH5ZhKrvrgRy1QrM7s43ysW9IIymCtcM2Of6oSKs0Bi+AP3d4FBMRQD8EIWkMk7rbJ00AScVSrK4nUYPLuSmfzKm7i0bfmIKJpHl/9LNB7ax7OG7jec6jxg8Xxq078sdSwE0DwwrfctNISwAq7co267Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMfHzmMeHtZT622efOgGcxNrYL11mltfChN96w+RTM0=;
 b=FEfZGtDa9vMjYgcy+VZ5wHDet8lFE0Iaq46TbmmRqIKO0raGsBNnihSl+wWi7xSMHl6nIhvgNvPaIKptX3/p7AYP3PdsOLqBKIYuaTHz92W35dL2b1l6N4jWqTJYIxbdO+hHY1nRp+aGqwfsmNcjSbZFkmATgw2xT/D89dWNiAK23NcKsbZgcUorUE5/24UqBgwqKO69RfexqXZRPCJMdzamerbKW1hUC6FFYUPtsZOvEbUsvMoUjdqhhsnwu9VI3BaN0VfGFWXJ+8NU3vFsN0bDbL2pq0K0F5bMQ2Ajpce0x95jcSBJsYHtyMDUk9ehXYtZ5u6WU5f8FKsCQ4Dz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMfHzmMeHtZT622efOgGcxNrYL11mltfChN96w+RTM0=;
 b=eEnbuC/I20/QWdz9Dw6Gmp6AdjzAL8FYKeZhvA2rLhPTQrr5W+Qja3+C0F0aT0Xa+T5OXtud8WhcIQm4yDc5sJzB7XfuYaCcjhbct2tXcLzfxqnAX7CKsIFOGk5kBBN0xDEfDFowJFfAg3SB6kms2DymCnW2VvxMuCJkEjRUuPo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/12] iotests.py: add verify_o_direct helper
Date: Mon, 17 Aug 2020 12:15:49 +0300
Message-Id: <20200817091553.283155-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:09 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b95748e-bf31-4893-019d-08d8428e2e2b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB485293C012B90A40557D1F30C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfuVI4HrXuAFPqYU47dktusZHvaB5obWM0grT9wkJ+1OrntdPqYnUoYO/sgLoRkkWsRI3OtcedSFS0ta+m4627SR+GbIZ55b0wfILWgxs9m37Y8b73j0cwfjpVq+ClZlZg5x98jdEnPk9sBUFJ7sQjaj6VCZtrhrcNT3Z2clyb7eUlWB1l2GF4iO1i4MkgTVskLRsir+iNyQdXySn0Oz336L0ZyK4e4pJX2Mj09aLqKCbEj/8EgU7T30no1NcAn4tC1i3hJXHZGPq1OwPJDyAEZLvxZybSIyrPl8biIjHgC0V5cnuLptjYF7XWDy2CbWY0xM1L1iPvByilaLXm+yJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(15650500001)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(4744005)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OqsvssIayP9heS2vzWuxzA/yyKGgNhenWFoabYoxR0psYxAP/vPbAARyvOiJrhRIBD3QkoWikS1qmxsuw4xTKFJNCf+z4tz4RK+oTNfSykz+pX0wp7fmJVeW9L506XPI/UyKg6gOlT59+m7ZKyBy/YFRsi2qelyU0bxluiRer1E24JQEN4PzIYi4E1AJENs36PtIrY40NNy4erwRfRV8uKkw4nMJoHgNFz3Xwn4waVUfIDCL9x2dYVG4hkIwFJZ5CinDSKRHLewOOJvP56YXD8/1TlgZL2fKQTrhlIumeRB1rHaJbyTQyEvmKzgScxbCD7Nk0666GN3Xad9OXRNGjeiOMB5BV+sDQtUAH63YOQahLoVPxwy41A8KPtQA+9wEJiLsaaGYF+1CsVEBirYb560D18YLPVs7JH1VGjkvEnfox19uiAx53VPZsropq4RLLVW96m8yYB7sqmrKSe/sNsskoPpTqJbmXA3h12D58lxyKQGn09kmi7CfoCanVnqB81vGlbzA0vO0mrTDxOM2HmMZtrrFVnXDhSZus7HcM2tENQ8K/j74w3Otn6F+AsDuoTd9OfHYG9KTBqEYbXKU+vBjdjf2JuEiCZsz3QFZmdZw88OAU7p9kKn6f6rEkfMqag5VdL355Jn6xxVnMQCf7g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b95748e-bf31-4893-019d-08d8428e2e2b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:10.1708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufZbiPAmZWtn4ST8rbpbzgzsDLVLWLx/+Rw1/TIuGW+F9Zlk2hX3OgmDox6KFLaGl5G8jrE8VHIM6U1FKxNZgcDIudU957RVf7nHg+LyK9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.14.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:12
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add python notrun-helper similar to _check_o_direct for bash tests.
To be used in the following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.18.0



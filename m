Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3578C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B491C206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UKgi+0SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B491C206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pVX-0002X2-KO
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU1-0000Xr-E3; Thu, 20 Aug 2020 14:40:17 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:40648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pTw-0003Bm-6C; Thu, 20 Aug 2020 14:40:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2kr0JTqCW6+I1+pbJD2UyqXcpOzDRQFM9qmWuNs2DJ9YmPoMn0FJa9Wzg1JcRG5Aonl1Sc8jr2DRmhsE7tc+XTs761e6OdwosXRZuD/mp6Xhv1tBquZgZxd2q1w6G75Ad9dPpy4s1aGCxxEgi7d5SnpKQV795EJe7IjhFsDN3tnq3F06I8mbWJo4zJ8cbSrdIWaOo3Xi6DjgrY53oHoA/SuPQKbAiAlsnZvJS942HsmkCY5Q/8SGYoqYR4jOyx9fmuM9o0BmnXyhu5SHX3y32Pp3IGzRuYaiEz4qjwhNpRl5IG9onduPD/reqZYUiJSMSTQPWyH6m4zuS35+tYyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGgeaiWA2ByN7Mp9oYARFXCropN+PmDEtHudx0jsIWY=;
 b=XmIjeZf+rg20uzLbWW0HiuuyLlv+fRZCLtPVcazRVEYTSXEUOTwQqzMzXvD3c70MRtSQXS+LmTjXoiVQuetVElMSaNFmtou2/nadVoC7DfrXW4RpR9efrM+ujOsKKltGfwSfVmLIDCUXSA/sy9oIxGN/8HlyBDRExIprA7lcczTqLCQQeRHqrbzfiOSSA9+yEMFBXOOyP949pnFzLSKTeEhvrHQdQRevmxYdXblhXj/rzurwPyqPotMaygLZ3gAiXlxhOg9ad2DCHUqyKm7F9LFVn9Tq1rFnYVMdQz8QsVECD7qZYXvbvI7rsD6AyHxpZ77oQ+UBLx1+wCxiCfQwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGgeaiWA2ByN7Mp9oYARFXCropN+PmDEtHudx0jsIWY=;
 b=UKgi+0SUn6sC3G4yVfbnzipIq/vTs/v8KSzxw5fKp5gVnFK8i2q7ROy9m3OEOpFXMEN4nBd9QUizH17OKrfH2SK7USfPEpd0ncS40CLG0+0MSELvmLsyRPufD6YE63wpkn1VBzu8K5/GgdpqmhTy4A/nCLffqgfA63C0e5Dt/+k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:03 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 00/10] preallocate filter
Date: Thu, 20 Aug 2020 21:39:40 +0300
Message-Id: <20200820183950.13109-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
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
 Transport; Thu, 20 Aug 2020 18:40:03 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc584fa7-6db0-4683-0666-08d8453873c9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032ABA6BE306D45F882D2F7C15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yB1cPBtWebX4mpvPtgx7GDsWHypoJDYK1xVpY482Zzhzaw7gGcskSqLBAmW96zQyjeILOb8H0+/oFczc2vz8lU/zZi7qLIntgRdJZNmynpAPjCWWyFxmZPpvIzHbAcpskevjQXQM9A+wsqpsKq+fc51StERMH4DNZ6Zp6LTutODi1rYB8+IuRB23qrey27f611WlNKzvKBO5E+GkOOMeL9YAv5dKLqdpfPQee3+XVpTwuBqkJrWGn3b9ON1VdSVxRqzCIi+5dYrV2uE+tRbBTNt1xGifborSMk4hpPN5FjE1jSwJuivLLQkis2UUgQx6Pbce/DNcEPrePtp70oGxWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SxyhQvLU8HYyOSB4t2+Y5ecL2Dd/79rdj/45oQpMdD8t6Z+K0X7NHj4GwtdAbnHDuNEX7Yi2X8e9zJfEupqgQlUZbmrcyLBULCOErorU3qSr+8pmQJBEbe6nFVcHotMEX47M0NNlQm/zD0sLwli9NwWeeN9Vr2PGwPS0Fhx+m8H/18KrRBk9tFly4D8YUUjPNVgxqTSgA9w7+U6IKa4IeFcvJOcn2dTuBZfnXrRTI6fdgwbMaPdSqT6uNXQrNNACiiexkoXUw2VMYTDYBy8sRVxTY1K6BSFYp+WhKUzntcnQyViH7kFoqbqyqepVv/sQNwpX2alT6whPoe+HKXpkBtvuqkBw3Qgc1MFdorBAV3Jwu4amT3O+sPeH7xibAFESUMFdDCK1pHm4NpJAIorSlN1WgT23+TWBFQwD1Kfaw7nYkovqEuiN2MoSiEew8C9BAyuvAWKsYMa4v+cGg71UhajFbGyb7HFmHMd39OeB+MgJ1ZK+eESfJMc7SOv5qyXuCwo9O9V/ulsYPjBqkLoH4hQ1Q/gUZwwJX8BHvnzq8GPKT4sxClVHcztKZ7PWA7dg4ipNu9x0Pw+9+v82TrqF8FhYRwnwNyt7USgaldMCusWgJRFMBjtxHWTmEP6x3bwCEVWH6q9Y0nf5gxml1RwQcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc584fa7-6db0-4683-0666-08d8453873c9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:03.8124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gV/qvUE1PiTRDHgfSvzbQlllMrBkCcKX2fz5LNBLHr7xMJo/VLpKWzN2gY0XC0mSn13uL7YO9Mx5c5tWDt2n6ZQm4rkrz2AKkQC6ozoOuYs=
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

Hi all!

Here is a filter, which does preallocation on write.

In Virtuozzo we have to deal with some custom distributed storage
solution, where allocation is relatively expensive operation. We have to
workaround it in Qemu, so here is a new filter.

v4:
01-04: add r-bs
05: add coroutine_fn tag
06: use QEMU_LOCK_GUARD and fix reqs_lock leak
07: grammar
08-10: add r-b

I decided to not resend patches 11-12, for which I don't know
how they can be applied universally. I think I'll keep them
downstream only for now, and probably drop in future if we
can insert filter in libvirt.

Vladimir Sementsov-Ogievskiy (10):
  block: simplify comment to BDRV_REQ_SERIALISING
  block/io.c: drop assertion on double waiting for request serialisation
  block/io: split out bdrv_find_conflicting_request
  block/io: bdrv_wait_serialising_requests_locked: drop extra bs arg
  block: bdrv_mark_request_serialising: split non-waiting function
  block: introduce BDRV_REQ_NO_WAIT flag
  block: introduce preallocate filter
  iotests.py: add verify_o_direct helper
  iotests.py: add filter_img_check
  iotests: add 298 to test new preallocate filter driver

 docs/system/qemu-block-drivers.rst.inc |  26 +++
 qapi/block-core.json                   |  20 +-
 include/block/block.h                  |  20 +-
 include/block/block_int.h              |   3 +-
 block/file-posix.c                     |   2 +-
 block/io.c                             | 130 ++++++-----
 block/preallocate.c                    | 291 +++++++++++++++++++++++++
 block/Makefile.objs                    |   1 +
 tests/qemu-iotests/298                 |  50 +++++
 tests/qemu-iotests/298.out             |   6 +
 tests/qemu-iotests/group               |   1 +
 tests/qemu-iotests/iotests.py          |  10 +
 12 files changed, 492 insertions(+), 68 deletions(-)
 create mode 100644 block/preallocate.c
 create mode 100644 tests/qemu-iotests/298
 create mode 100644 tests/qemu-iotests/298.out

-- 
2.21.3



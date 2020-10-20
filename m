Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B20622475
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OA4iiKP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B20622475
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrKe-00039P-4V
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrId-0001CW-0k; Tue, 20 Oct 2020 09:03:35 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:62453 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIX-0005ZO-E1; Tue, 20 Oct 2020 09:03:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKvrtQaRrLNs1QjCyulaU+VpCYX05BbUPIrzOttR3IICsOVHv3oiW9k4/Ik3yXASzcU9Z1ArlTcNJx8+qk8E0/NDmD4k96iwkXonFdlKmQD319fOe9oafWraZ8bHzdwwuIdLqxiSJSsXYRWEUvSEVKvSdIaPRxbDSsCujJLh3tfYjhvu5XyGYtUijOjQ4UQ7crdqZp6XkaJ7S4wB6qo/rI43swk1ULZNB/5iBCCrZWuAor+gdiBkTCrR8GwSfrNknKjjUQ9oxmzp+T5mVo17OeS8bh32NUXFHd10kcf77c41iyDCw6eqKJyDjjMNGrNdAfOPK47vhW4QvxHpkl7sLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGilj1WejSVT2RmXUF1dBwxnd5a3RymL59AMrkMfUOc=;
 b=L+XzDmxst3ls+UxNdHZlezzsJ+4Am7eq77ssUy+vV7jQy2aDOUnh7WpczkbbW5FiHCR1JVhMvffMfbiY0nl03MI1zvhjjonrHxHZRuEKcW/j8G/uwVyVca6Ze+WI/y8xm7b81ctUOamiEjVomIM7pJra7oLAFejVI2QhisVozMEqAPhgZ1vLXLx2bimpnxeFwcYDZzZrspsmnqyUxoZRT3YzfAzocHIPTmgzG3UtA+mZCMrUaO5/2DCNhlnoG0N12P3qbLoBJ5ULYlcgrUDLf1HJ8FRXRGRTSsJiaHIe1qTGVw+OVrJ1r1oLDUpIArdpFL0EPuM5IrAZvld1O6//BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGilj1WejSVT2RmXUF1dBwxnd5a3RymL59AMrkMfUOc=;
 b=OA4iiKP/DxF0maCrycCPbRAHbLr7pfhPPiAzhoQikpxOELru07dXum5JpxvVpxvjtM9Khdvylh35p7/HiuLU23x7c3as28kwg8FIWzuBrYhQ0x1yef7+DfEMAXeygP2kmULzTvXFWUfwmUnIUHO7fOErfUa1Iax/mtNlkF3Hob8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v4 00/14] block: deal with errp: part I
Date: Tue, 20 Oct 2020 16:02:57 +0300
Message-Id: <20201020130311.14311-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a121c3b-959a-4edd-f0cc-08d874f887f6
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61684374D58A391F2BEBF126C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMm/9fsMUrtHfIwlSyMQRCjweax97EtGqNHnLfhmfP2qjg1TKe7oPocpBX+QTwin62uMMpoAz8avHmxj2ENvsv0gsyUY/Nk7+bf0FEAmJuurkE814HQBg9kMDeYIFdogYjGqT4VsuBujyW/PEc9/+dt+boEYP7wnQiMpcRigtGAHAEQDa2qx1rPQjc05O9AJZE/ilZZShY+wfS2WsVmGt5uPenj1PqRwP7QhvkKC1w2hj9WQN0PmJ/tsUKJZxHmI9qphFXg80vFtC+S1CD1xxsk72BP9Ui2fN6ULSab9krTaOIyXdI815c8ythnwzueV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VVct5t3qIXz030NCrQtvGYrHqP8EuUWMIEZzqnRxd77tjk4aX1duXmVapF9iBy9AbvkZsEgiXuEEJaRxD/Wnc3QOzXO4+dVikg5Ifla+xIN0pzb/6t7ghYkP6Ycam/B7WlZ+zOHnwXgkzsX/gPIYztWOVGlMueOafxwK6DHTLP/1HsTJf4wFkHIRHTnNsHH2dai7NFwmSy57WPq7RMfeGaMExa+NLWeTFnofTUD0QrwtMZOXtdQaYA1pogkO27T1RGDriPl4cDIvhnsbmze7R93/H/66BDqVkFFg1A9/G5yK3j76DpWQxH3r8dvVwS262oQ/FDZGGEyRjb+e+GjaNJtwHOM1erdbROF5J191SK/HsgyOA+AiDRU+PzRKkMZFiJliC60+x3cSAV6BhmwjwBae4mPn3iI/9C+7/Tdj/18dvprDuVXJiziKOnojAjpLEPEJL/4HH1MMzNe9YYNQj2cGYaGmxI89xJjbxEOiVqiSVFXhNX9eldq/zJDBwYas7NvJz2P+UcRLfrhzTO5xoamlh49cY9sqbzbH/4/iDcC0d3iEaTB6ZFQSCfQQeaP7zULSnWAQbjJaW8ynUwn0m3fRiGOAAogRP9l0ZfvcoLM6O+g1bO859No8l4wf6QpespKWGuTrcG2Y0vTu6K9+Hw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a121c3b-959a-4edd-f0cc-08d874f887f6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:25.6357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: booEX1WlqW2k2nWX7j3XpJK7F8JMvc3qtnblyIRsfUlB5LuP6w8JURWF3M3DMpnYjcbrmumD1xMM7eXaPfluwljd/fA6fQwOIw5QdO7y0xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:26
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

v4:
01: - use -EPERM on bdrv_attach_child failure
    - "ret = 0" above "out:"
    - drop r-bs
02: - use "ret = ...; if (ret < 0) { ... }" pattern
    - use g_assert_cmpint
    - drop r-bs
14: new

Vladimir Sementsov-Ogievskiy (14):
  block: return status from bdrv_append and friends
  block: use return status of bdrv_append()
  block: check return value of bdrv_open_child and drop error
    propagation
  blockdev: fix drive_backup_prepare() missed error
  block: drop extra error propagation for bdrv_set_backing_hd
  block/mirror: drop extra error propagation in commit_active_start()
  blockjob: return status from block_job_set_speed()
  block/qcow2: qcow2_get_specific_info(): drop error propagation
  block/qcow2-bitmap: improve qcow2_load_dirty_bitmaps() interface
  block/qcow2-bitmap: return status from
    qcow2_store_persistent_dirty_bitmaps
  block/qcow2: read_cache_sizes: return status value
  block/qcow2: simplify qcow2_co_invalidate_cache()
  block/qed: bdrv_qed_do_open: deal with errp
  block/qcow2: refactor qcow2_update_options_prepare error paths

 block/qcow2.h               |  9 ++---
 include/block/block.h       | 12 +++----
 include/block/blockjob.h    |  2 +-
 block.c                     | 63 ++++++++++++++++++++--------------
 block/backup-top.c          | 23 ++++++-------
 block/blkdebug.c            |  6 ++--
 block/blklogwrites.c        | 10 +++---
 block/blkreplay.c           |  6 ++--
 block/blkverify.c           | 11 +++---
 block/commit.c              |  6 ++--
 block/mirror.c              | 18 ++++------
 block/qcow2-bitmap.c        | 67 +++++++++++++++++++------------------
 block/qcow2.c               | 64 ++++++++++++++++-------------------
 block/qed.c                 | 24 ++++++++-----
 block/quorum.c              |  6 ++--
 blockdev.c                  |  9 +++--
 blockjob.c                  | 18 +++++-----
 tests/test-bdrv-graph-mod.c |  6 ++--
 18 files changed, 177 insertions(+), 183 deletions(-)

-- 
2.21.3



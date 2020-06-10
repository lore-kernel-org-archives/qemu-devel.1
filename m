Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F49C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8658620656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="L8/Mgcp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8658620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5Op-00040T-Nq
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nj-00020E-4T; Wed, 10 Jun 2020 14:23:23 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:7846 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Ni-0006OY-9i; Wed, 10 Jun 2020 14:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2PNtEB9Kc4eSM/8WnpTUbTO+1YzyosHU+pKNdhI6UO3wLBta//+MEJX1FygdUHHBYnFkTetE0lKliDic6ksVAziCAY9NleCVxixCG6rs1Unf/HCUmoPPJg9WopCAS2U4ctbFnCgihZ/TIB5tjOK0xUOL+XwlUhPOxndSp7T+bMXj4LuFSWWbUp5iil0+xbFQeK0HOTAHYly7nfolm7CkHLoHNsxkyLdtmNZiiAvHbroGCIRDN8AOU4YOIb83VrOZG0IAGu3RBQdhMAyPE3+1pOnEf1uTUg1Hw9tH9WFe8dGK55BOmIcxrfaiX6BRNu5g2ZLlP/cEtIOA3xvdl8/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxaGcxW4ryNNNOz7FOkIaSN/JKpeA8RB4P3ljNviRvA=;
 b=Xs5cSmGjIGCp5Fi0Y/ITFBc9CNJfOcd/YgPTJFS5Sro964VB9FAWX/cy97pDKjZ12ihOKoPW1ma11cL3zxmOYktsAbHAB2rnhQArAXYKNDQ5dzY9yksiwSyoiLNFrgxUrPQvqXvxZcZOELBAYvqYmuE6mxgG9E3GRZEv0wOvR1XYrWlpSZrQlaToyWtveV9Q+qA3W1KeUbmbgx9+M1R/MI1Ynuq+4Tj+sGvOFTyKjmvI4Q5Z9tyi2Q8ynOLP3D+zu1S4gVJWqBiSAyvdOpEBfgiNJaPoyLCLj5alTI/xeNg1Xhm4ajP31XJBHG4jHJ/RfA9N32ry2SnfftN/ASKt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxaGcxW4ryNNNOz7FOkIaSN/JKpeA8RB4P3ljNviRvA=;
 b=L8/Mgcp15itbQJNxZmhKWX7Bb3fdpQqkkB2Tkg+/PKPX2q0dLq5xM8jfQK1xoRXHtC6zRkubsHd6DwlTy4oD7DcwgqAjbKUABFjBPoySFB38Jw4MrtAD+lXqqwNnMuBkiSGyAG56/kCdNscufooRInfd4bg4UnhEwxVLWTENK4U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 18:23:18 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:23:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/4] nbd: reduce max_block restrictions
Date: Wed, 10 Jun 2020 21:23:01 +0300
Message-Id: <20200610182305.3462-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM0PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:208:ab::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 18:23:17 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bad97b4-867f-4f1f-ec80-08d80d6b5930
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53508B90B171D7422FC01CF3C1830@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZ3LnY/7wlZ4UYQbsb6YT+FEEaTN4Pjk0qGxJwNdtudWWyKn3b3yCgechmLh19ylT0MMLgnhvyrZqoVWyprjN7a5VwTcum4liS+zNeMaz68PHUm57u7HC6IwwxOUccfeJI3KBdL9AhcRQh8l6NW0VzUTN7x6OM6fNpndPXVYk2MPv+0gNrE83X5mJGwBKu3UllNpxSb2/wkxzjNS8Bph72FSZm9HEEQ57iq4ZGZYGINSWDVgCcsr9yXHngp6EB+3XTLU1wGTzlQRvchGC9JLHDoqPS+4a9rvfsKMBeYXsOxd4zyvuThBjOgIBqKgADMOxxRQwU6AkUNb36K8VfR6Osm+B7CLjpgwOoh0Ytr7ESOIMFy5W/yPufmMZM+JtyOHzbZnXeXpsUE9f457ZFeRvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(1076003)(4744005)(956004)(8676002)(52116002)(966005)(8936002)(83380400001)(86362001)(4326008)(2616005)(478600001)(107886003)(6512007)(316002)(186003)(5660300002)(26005)(66946007)(2906002)(66556008)(16526019)(66476007)(6666004)(36756003)(6916009)(6506007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6A1nBnnEBVxdpRl+so6hDvGu6kQwDHCCf7RanWtQm4Ke7x3m8OI1cNjh6y9sYi76WiljdAXs8NdNCRhKE/9bd1ZOgB3Ir6pDYgG9Woe564V19zWz2iakkHhyUNPI1EKY6oNB8bjpzM1Uw/lemKxt+VvdqzzknMwt1TLkMUB1WXg4HXJDhmPEwRvuB7ILxkbY34wckx1ByjdxwXxoC/Q3JxSiaT8LA1svF03+1VULjiF5GS5ubiKX//JTErpgM9Xz5zSnQoyz5tEpYIueosBXTIQD0OGvkqGlhysalmo7G56bstT8aoclUXtboQSru3jP+aoL19GHMbG6d1RB+AuEBxDyhJvyaLpOsYKN6pg2lwLCLoTfi6oOvKtMEb0BW1t0mtL/G8gDZj8vknCsgDDSfOoCj8Ap6HK/pii73TckJn2Sr08/EDwQRkKMqpj4Nw9Zcj3VMkBHwCPAe1jH5Wdy6dlzNY6jHqINHEUEUuVgnYzVBxILARtqRgyaHsmRY/DN
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bad97b4-867f-4f1f-ec80-08d80d6b5930
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:23:18.3190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtIhWE7VNSHZMs5l8gf++EceDyU8k8SlDyQW5ZDh3YHNrJL0opX/cqFsQMeh6XIxjU9U6Rlt1oQPkY9a6FXuBcejh2MjjPSIDL6ptrDAQLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.3.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:23:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent changes in NBD protocol allowed to use some commands without
max_block restriction. Let's drop the restrictions.

NBD change is here:
https://github.com/NetworkBlockDevice/nbd/commit/9f30fedb8699f151e7ef4ccc07e624330be3316b#diff-762fb7c670348da69cc9050ef58fe3ae

v3: first two patches from v2 was merged. Let's continue with the rest.

Vladimir Sementsov-Ogievskiy (4):
  block: add max_pwrite_zeroes_fast to BlockLimits
  block/nbd: define new max_write_zero_fast limit
  block/io: refactor bdrv_co_do_pwrite_zeroes head calculation
  block/io: auto-no-fallback for write-zeroes

 include/block/block_int.h |  8 ++++++++
 block/io.c                | 39 +++++++++++++++++++++++++++++++++------
 block/nbd.c               |  1 +
 3 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.21.0



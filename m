Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF78C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755C820747
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ESqwlr0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755C820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcHh-0001o5-Ku
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDI-000218-4v; Thu, 07 May 2020 04:49:04 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:13902 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDG-0006Er-3B; Thu, 07 May 2020 04:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwHId9oXgjIFqdinBOwW64a3/9ePKh0xw9TEo1uoADKaoQ96mBi3AzXgOE1F2N9Ojh7C4NMEKKfwYDfIHYsZQIklE8uxVT4BwYVOYTvF+Bw5c4hqbJVKs7ziDjGW90vcW6j8HSrgjmRzG8Sp9kublSmtglU7UOEdfdwxb6g5o7MPvnH8t35EECNX0hT+zQ+V6jJ3FTIjDNhNivk7pLMXISbQzd9NcKcFLlEyJbzVYrK6JRQflSb9s2PWMq1JMSSuDbBvVNIW3+vkA1Q7he6jcZcUO6cBsrFW1LdNSpuNyHeg2Bg1pvZIkG8akCMBdLRhRCfnsu7z5SAc/rzCB9L9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEw8sfNryfOBsTwhETT0Gfn5CiFm4JvafjhcfrJ03ao=;
 b=Lbr7SSH49sL5UUS9J9UQ/qu10eiogU06PfHyoemssb0Wb+vWRQUMtweqY29ds/p9C3zx8jGw3TK7BHyCpMUzHvROnE1xdMhLw+rVbwEWnxh+UXNwWowEmBV7zVFBZwoYQZckwBNCKwnraSz3MkXLhgAwjrOwysQV2jq1wRpmFhK/zE8QK27smgVszrYWFMhL53TAbLjtC+4SzX4r3AXB/SbijKbFAJOpvvdICjHIZK6wxyvKbbFflsmf1qRxIY7nyxNdqz12OLFVOaUav+vZalqSqv073El1pJ+RjrzD6WTgb+7AiVlvGr+IRFMigM/v+pFEFmHWE7yod5Hcvgs7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEw8sfNryfOBsTwhETT0Gfn5CiFm4JvafjhcfrJ03ao=;
 b=ESqwlr0arMmk3hezbxRS3/tTpkUgwrSu1u7raIGeiTUgAgyLb3C50CqAschmIJgDbiBtnllomEEi0BPCVAHVhZxfjWb4RG82zo5mWmdOheBgP6pQh1wwl0T1vnBuxWEtBp3SBC/xO1U2E4NiwJtlyyHT+SKYcaR1FSDDItB879g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/9] block/iscsi: drop unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:47:57 +0300
Message-Id: <20200507084800.20596-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:40 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402c554f-c1ee-400d-7518-08d7f263712f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549525FE0A413FB174AA4A1FC1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0OUJg4JatHM5vLnKMemDx9MPxZgPWujpN/VoVEmG0luJldA+nfwRG4DzMUJF2XMTc/fRA5MAmt4Tfsau+m/4xJ/puTfOXUht58k4ZmYfqWN3OxDYRruAwBWGqQ11n6Ab1OlnYGDmXPMwSvjvoWYDZty3SxYEElp++2WeYj4PtJ0ickkSpBhdKUFGez4LgpcqiQgz+WmQqql8CBH+f8UauXSuAhbWCg/UO4JAOxJMnOhdlVpIjiUWpjPpuubdMPW057EsFWjXgFfl4t2Wg4UyvSTqfqYLrM9HzsOtWw08rjQWdYS1fz2TvSrfzEqI5KLBoP1Kp2iSSWcc/mESJDRLhAZaQx308XjEvnviKY1c9upqq7bxlgzPJEmngEWlBKgAjEf0mcJL/od02PG8dutq23x/WsNbNJT+PDdPUSjhVy6X3CSV1gcNJm/2YhTnjLHbBlF/r5xa0Kckg+48RxwspCktcE4Vyb51Rw7mB/R8aPljlIYH28JwKhfRbAnfJ5hn49hSB7a5b/X18xVWCeW+3RAmZWwNqQTrCwd6IjwBuKoWoMsM4pn6tcCOfDRDzPf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(66476007)(66946007)(66556008)(4744005)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O2We9lYFH6kqA2EgSOXAKCme4f/AbyssJMWZZTU2wfUSJsWa2j9egYm7Krf5h6WF82q0311Ssda7dkjq6s1KCfMbUR+smMmuYpddhEAhH+kHnFh3r9uJpNUPUkmk/irpSQ7Tf1ngf8hUOWpyIWfESoAmHf8NP5zyueEQNf/PFMXigKkw8UIMWI+dt294G9EvAhvsp+IjIP8m1WRT2jpXLLCISkVs/BdDlt04fxXtoegpZ9FvmEujSPFFBaDmeEwDenV6+LPdKDPj4laEoeJxC9P0ULG1puqsT8IcmqmJeIf2bHCOcuo00G2G3YZ6ceLIyPOcHSfr64YqtDDd1D4EHwqgQkagV+ZGxCfMvLs8SUc1xUehRAfcew1Rqb2z9fXTMylnVWwrSHKBROXgdpp/9Qix8LDsHJKckAFXY/beWVVFVRrkut4locmLan/YKwp9cy6/cDCHj7nKxPJ3Xll7kDi8e/QXAJIFad/JiNVAq1SSI3zLIh3gjTh1G7tGbH58eT9Giu01qv9rQOgBt977FdoG07Sr5sHE7OYnpVVjLcUrduvuxQ7Eo/pZF/v0TUqKqTKw7e+aZB0dNBxJ+yMqyvW7ZYkejPP0hXxrRJyOXkDluwlN/6wQ2NDbhKUlJTtMGwqmsSdFmBsE0i+WEiGgiTTofsMnVnkzjpdwaKbtxuxyK7ALyTkoFmPDnZs6+YcnBl0mBrbNQS2o3zPPXLwVkn48Y5yaKAkULa13KXfcMXZ/91z8dBi+nJwo1mmrJ/r/IG1m6ltZFEXlbclZx4uXA9cUKLgyRAeontyn57lxcok=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402c554f-c1ee-400d-7518-08d7f263712f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:41.3034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js4A1ssOGq7Y39cPylSurrY13ZkAAV3yLVY6dziNUu4BmIhsyxr1yfvyVa7/xAf+0oXyQLV3X3+UFgW+1GlUyK/KqygHVS3ahC3SJpViXHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We set bdi->unallocated_blocks_are_zero = iscsilun->lbprz, but
iscsi_co_block_status doesn't return 0 in case of iscsilun->lbprz, it
returns ZERO when appropriate. So actually unallocated_blocks_are_zero
is useless (it doesn't affect the only user of the field:
bdrv_co_block_status()). Drop it now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/iscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index a8b76979d8..767e3e75fd 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2163,7 +2163,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
 static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun = bs->opaque;
-    bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
     bdi->cluster_size = iscsilun->cluster_size;
     return 0;
 }
-- 
2.21.0



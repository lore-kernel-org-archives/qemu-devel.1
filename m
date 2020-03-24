Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC615C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7911E20788
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IebAWj/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7911E20788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlcr-0002ZK-I9
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbm-0000ZS-LC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbl-0005dA-4x
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:50 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com
 ([40.107.7.133]:6087 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbk-0005br-IK; Tue, 24 Mar 2020 11:36:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4oWJk6vNo9vWoGvhCNThETs+4cmveU2rljepXNQW3yVin+KCMNQDSg5pn2/mCpDL7EISXqlP0R6WtySkEMYT6BFWnlIN/xbDz5A41fW1Ifp0BcJCNnl3TybRk9bXpuZYHq47oHdIAXzTIh5eF46OddWbW0dk7aj+mRMHgkNQb0reBCTS8ZqDmQc863jFv4Gyi1xCNjJLlXgfFQ1jbr+EQbIgXILFRu4vJAC0nib4wk73y3HdZHmX97nC9JNziZs7w9oWCUsGaUK9JlCbPGmAEOgv065hpYvbuLIowDJmEmDb9XaXB2hFso6JGf86ikCS3kPV4G6HQ27tnygIqtpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sguF906Jz5VJ6LuuJnaxHzZxZb4k9S1FFrhs0WGARug=;
 b=dJis02e1HH3TxdA4ukAr5JCewcG87seavxyoQdKpMNbFZ3AFX1lzMUmsSZGmu9aJvHrAMC7rFCL7iufIbePqO2icSGb8IQHgvjrgrsbrE6pBxKBOTuKRZTBLLhYBNsh+VP6XHd9+eVjcQ5h5u5afrTsSCL2eBFOkeW0LJlXPAX3mc6P5yy38qxLJBUKii7pW/GK/VEnYtaVIUnd6KEfX1LeoR/0qlWVFV6mEDwGXCnATsrOZ+JGTDXTEEwQ+V0jDdtmbgR2XwzCWdzTkHf/j0m6ei/xQn2IrdkZFiW+G4PIQzyDMCoxitWn+e901w3WAcIouPXagv+3002oNDX3NEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sguF906Jz5VJ6LuuJnaxHzZxZb4k9S1FFrhs0WGARug=;
 b=IebAWj/JfeFtrSq0FIdaJRoh8DVh+KsC9h30RmWbkgytVXogcFptblBzL3o4Ie1v4MkV3wyuACH7sOEnLh539nHFiZjwMgZZJsuSgrm7MxfmhIkL1WALcQhoHEI/Mpx0+GG8gUmDyWaHba6WNTe5uojD1W67YUTS+JXsCNW/FPk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 0/6] Several error use-after-free
Date: Tue, 24 Mar 2020 18:36:24 +0300
Message-ID: <20200324153630.11882-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0401CA0062.eurprd04.prod.outlook.com
 (2603:10a6:3:19::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.15) by
 HE1PR0401CA0062.eurprd04.prod.outlook.com (2603:10a6:3:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:44 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a19175b1-a4aa-4c92-3888-08d7d0092929
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336B4C6EED2424A25252F90C1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(66946007)(81166006)(66556008)(5660300002)(4326008)(66476007)(2906002)(81156014)(8676002)(16526019)(6666004)(107886003)(26005)(8936002)(186003)(316002)(6512007)(6486002)(52116002)(36756003)(6506007)(1076003)(478600001)(956004)(86362001)(6916009)(2616005)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5336;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M76OeVI/hpafdx5zue50NPQR3u8eJv2EI1mUPOuPgr1BRt7V/of6CLbmLikjh+gAZCcasK76btSAyo7AeMq4QG5C6fA7EXTNjJvZErTAiUUEsm4F1JRgPcrZcs8xc0uOnLJwEKA9KLr0YgsuW/8HZKAYp4p1fPUF34i/Y88HC6w7cYRm+6C4Xn+gyD1w9A09EjvJeJhJjw2mUMbiYffwIV6m5gp0q0/ghz2eqD5oMm3I38hHgNd2KzJoB7CFmH2ECp0tVdHN91H34ByUhZ5XVE9HE82Yw9vXJwdJjC6aFGSJluNotle724BUNF0uCegk1o9ZUJeG1CcNeZysAcrNOqC85wMNouKzLMpN2uxu/Wl8Kg3s2KJF7Ic5kb2+fWmojzOZjrwRmmtMr7nyaaHXbAqlvoAYy/vOnwPcF9zarvJy1HsnxRB8w9DGK9pKlLTs
X-MS-Exchange-AntiSpam-MessageData: gNywEc6k3/tQGbd0l61OxHcD6eeUsAjV4X3YP4y5Cf7sVX+CHxkt7sXdYRvUWdS70DK81LbEGzeMpk0DrDVKlf1NHAmXRd7U5NsuoSFonRR86HvoHVotg0ntcGZ7eZBHu7Oom6eZ5dYViSrhZD9lDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19175b1-a4aa-4c92-3888-08d7d0092929
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:46.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFVKrgmoUVIs0emWtDFXhxWrPwuHCUHPkKfrAlOEPq67zvZPJlLBmpI0yzJWs1qgJGOlVvfHKnGmN8+80x8q/y0y5M0cBnxrN5uDsWUX2mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.133
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, den@openvz.org,
 marcandre.lureau@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

I accidentally found use-after-free of local_err in mirror, and decided
to search for similar cases with help of small coccinelle script
(patch 01). Happily, there no many cases.

Better to fix zero Error* pointer after each freeing everywhere, but
this is too much for 5.0 and most of these cases will be covered by
error-auto-propagation series.

Note also, that there are still a lot of use-after-free cases possible
when error is not local variable but field of some structure, shared by
several functions.

Vladimir Sementsov-Ogievskiy (6):
  scripts/coccinelle: add error-use-after-free.cocci
  block/mirror: fix use after free of local_err
  dump/win_dump: fix use after free of err
  migration/colo: fix use after free of local_err
  migration/ram: fix use after free of local_err
  qga/commands-posix: fix use after free of local_err

 scripts/coccinelle/error-use-after-free.cocci | 52 +++++++++++++++++++
 block/mirror.c                                |  1 +
 dump/win_dump.c                               |  4 +-
 migration/colo.c                              |  1 +
 migration/ram.c                               |  1 +
 qga/commands-posix.c                          |  3 ++
 MAINTAINERS                                   |  1 +
 7 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 scripts/coccinelle/error-use-after-free.cocci

--=20
2.21.0



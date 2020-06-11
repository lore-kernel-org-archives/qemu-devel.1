Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D9DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F053C20838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FZTEGa4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F053C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQBs-0007jE-6C
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ2w-0002D2-KB; Thu, 11 Jun 2020 12:27:18 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com
 ([40.107.20.110]:32417 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ2t-0006oc-EE; Thu, 11 Jun 2020 12:27:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOUm7GdR6OXSgLpGErlnfmViAN2qZMJc9SEPyZkKmlv6TauYUEGPtyNlsAvPwpv2M/tOPXvOQPi5QvU1ItK3c3jc2zcwI8b70bhx2+h1gKDo/5ad1QBXXbvt4rMCWoMNHlImFkHY0/OAkjO4xE1fld22yn+33n8Cck6V/eU4eMc58S8LpRm7R9df3f2hABHNndBONnwamFRVbadpW+z9py90hlPDdxtAo0nJZoTPyz9P3ABumoWp7Tt6rVCZ7yZlrOqPmUO8xs49rrAUF2QN/PmP7egdkW8V9GYwUcUsysF+eFDNiywjftfhuZkwsTyl3eT8fZz0bC3SdNMIyf78qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JONnDmBFMaMEvtQozdUHZRt3OYc3MnSsTsVjqRBN2UU=;
 b=XMGqnD3wTBfqBSwNJ4HGHnVp71/wt/LCyuo8hel8iwnO0huEAiTKW8AhHx+DuVzkoBU7O9+10+vG/7pvsAT4uFB6dTMVKJK9GRd+Vlg7WZahyhfqdCq9z4+jE95+aXyzeqFv8I87Omzacuy5eg5MN/YowoTEbaLYoQBwgL1FdZDw+0TFPCFT/FbavWuJrglfYRw/gXNV8qivAoAQ5tNzgkiZWt6lqB156HUfr/4QcLF/a42wOsUQUhECtwzVdGiBpmD7T3l+9ZmHK42cYtduSC2A00OlA5gWFeImNPlbEMTym4Q2mfIQmMbbFGJsUQCO/IFcDIns+tuiVEtnifQY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JONnDmBFMaMEvtQozdUHZRt3OYc3MnSsTsVjqRBN2UU=;
 b=FZTEGa4MR03oRHWNO8XTD6Xltz3mZ0FSME0R7o70iN2NqZ2jGLgLbYGK6Mb3wAPoz4nGAd7dFqXIpHSky2yzKIKkoBNyw12hcYUjA5ESPX0jfkBlNiwMvSu1taxhQs5Aj4584tEXgNYrLOQHARr4bisJb4iAnhC5Di1GGRjkq04=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 16:27:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 16:27:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/4] nbd: reduce max_block restrictions
Date: Thu, 11 Jun 2020 19:26:51 +0300
Message-Id: <20200611162655.4538-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:207:3::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.159) by
 AM3PR05CA0148.eurprd05.prod.outlook.com (2603:10a6:207:3::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 16:27:10 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf78df3-f4b4-4210-ac79-08d80e244ace
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5493BA040B7E83A8A5FB696BC1800@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5EJZl72nq85+xg5dNw3o/MK//+lj0Rl8nZZdJNdsHQBWmn5kGqHyZTbh4AeYDVY8i9hH316tFEk5UC3CFHExHHfmyoS+Z0v6URmML86/1CVDTfD19Hwz6/XvlFl6C2DKY5tMhb8A+CCMexmHq2/okPdb30tUFODf31vnEJPcoH2kNW3Zn+Vvjz2Xk9YOcxFI7l5UVJLiOwfbUCMjkkcF77Ow2N+UKfcdQX6nZD7HtMbP7FKarBai5O+Yb1IR7/1gSvzafaorDRpBACEynrh9syuGdd4ouGdvczPlmBlu93L1LyK5yNlG+dB4eCESkO/CuTgc5j7gncqzCbaCFFWETQ9ZWcbpdLzVsFvQqYwPr8zgWCX4JMQW44dyUj256+9KXhd0t+fQ7b/V2az4IR6oyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(6512007)(316002)(478600001)(16526019)(186003)(8676002)(36756003)(6486002)(8936002)(52116002)(83380400001)(2616005)(107886003)(6506007)(966005)(26005)(956004)(4326008)(6916009)(66556008)(6666004)(66476007)(4744005)(5660300002)(1076003)(86362001)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QsTuz0SekmkRbuROu+Y/6CW5kGUgbpYnyG8PpIcqk05AktAhx9DYTQdnxp7MFI/MkzeWPhx0GnsJogiSJlGX4moRDL6bUIBtZVZ7Qx9IQICfRx0TnfZWwEZcnM05L0eXcq1cjCmnON2+G/pqD3lYF5edmDAxGNC8WiM3Oj8KeWb1/e80OHUeYVmoBhVqXxwHZHj9Hu/7+KD2sPNZYuAwr7gk8DYHXCCims0am/guzi/TJs5Dm0YVQdO9xko/8eL/BMnCaqk6IxtJhEVCRlEWRcdKLLasfPul49+V5qABQ2NWQ7cxJJk+hsUEGSVfPkXIjN47VSJpd+645mDPTteRFcJpTo9MjrkIevmJ2K8BKtq9DL3q9zEh/m6ndnPF6C+ZO7opfDlKMxv9E/V2hsi2QT/I8JJxOmGCbYyg667r1rUkBAQbUOgtq/jslbj6kN8Yj5a9XEuPiVqvUKDqj7ZsZ3AhhcURwzR9dyLzRX1DdzBgvljsi4IA6UORBWY9CIHd
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf78df3-f4b4-4210-ac79-08d80e244ace
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 16:27:11.1531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdMzz6OxdrN3kz7sj09jXkjM3Yk6XxuyiA4WsnZqbLj9RmEKO/x9+tU5aNX+cqJpovJsLdDUmhqrOuLlBGF1BTii9VBEVnKzpsbfZcBWGVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.20.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:27:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent changes in NBD protocol allowed to use some commands without
max_block restriction. Let's drop the restrictions.

NBD change is here:
https://github.com/NetworkBlockDevice/nbd/commit/9f30fedb8699f151e7ef4ccc07e624330be3316b#diff-762fb7c670348da69cc9050ef58fe3ae

v4: fix auto_no_fallback variable usage in 04:
    - initialize it
    - unset it on error
    Hope, it will fix bug reported by patchew

Vladimir Sementsov-Ogievskiy (4):
  block: add max_pwrite_zeroes_fast to BlockLimits
  block/nbd: define new max_write_zero_fast limit
  block/io: refactor bdrv_co_do_pwrite_zeroes head calculation
  block/io: auto-no-fallback for write-zeroes

 include/block/block_int.h |  8 ++++++++
 block/io.c                | 40 +++++++++++++++++++++++++++++++++------
 block/nbd.c               |  1 +
 3 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.21.0



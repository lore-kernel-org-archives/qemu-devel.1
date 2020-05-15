Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441E42074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="npKH6t1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441E42074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZfR-00044H-AQ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe4-00028Z-Hx; Fri, 15 May 2020 08:40:56 -0400
Received: from mail-eopbgr150102.outbound.protection.outlook.com
 ([40.107.15.102]:11310 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZZe2-0008VJ-8h; Fri, 15 May 2020 08:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjeByZFf7VKPe9IKiTIJrtnolm4EeMpQeFIPGE+GJAITGzPMj7l90j48V/nJga6vIQW++PLrRjcLtszkur+YWjnKWKncoaurkIBHQOpCGyCbz5AqSQ8gbZPrcpzh/Q1Gb52DpzGk2TlaA2g+lLq0zxXCNODDE18RFGzSYJFW+jjSpmeVzbeHh0NkwEOjpzXV+813WseGAAdL+xS+q+ZJnXcYtnacABKP5Rz6tSdlX3QBWCSK6qGSfWBZVHdtY8ec3+zMhdf9JMwr+mAMPmErRm6vADQ2yRV94Fu3YV8R1o6VzX0w6AOHASZhFgFRws2BSN126zX8uLWI6h7LnSQJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUaN9DoZA2ANuBSVz7UkfInKucGNe8SSEpGGDhFeThU=;
 b=lc5nu+8cpl6T3NLKs6jGzWbkASB8Swzr6qZGOwbCFJb3y1i+0cGi9ei0uCiZWQHIHaI6uLsQXHHZKJkPY3ppcBk5qdh5e2j4nhy21X6Q0rX3XBymjIr/7Rqmz7z4I8ASKtLjJ3AD1pvJDlB+a30std/BWsL9nNbQZBRBijDPcHkKSC+VEQjCC5NGgI3FE0EbNZz/KneVkqrRGIT+9jSdx+0OJhwA5D6VmF1qvAJ0jVTFyfIkQUJ7eOaZB4QznhHqoizNc/chQAUtRSLyThaJLlnAoGvHWvSJHtxmcpt0uAm2uiR+2FDHV8uJHoPdUDjyaXgTcOhramOWPdF4tvu5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUaN9DoZA2ANuBSVz7UkfInKucGNe8SSEpGGDhFeThU=;
 b=npKH6t1wfvMKqwFydub70h+5TxMQK+UDyH4hT1uY2W4K0ZUtI6cqXhqsBN1UFjJ8u3pVGR1AYw8dOcy+LJ8rW6nUz1OjbuJHppu/UqDclEDl0Vq5tBY9Y9CI+pOAH+KmEf9zIBIYF1IJn/deyOK+53342/W3WMowkpJHBYmMmcg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 12:40:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 12:40:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/7] fix migration with bitmaps and mirror
Date: Fri, 15 May 2020 15:40:17 +0300
Message-Id: <20200515124024.3491-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0039.eurprd03.prod.outlook.com (2603:10a6:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:40:49 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a75674fa-6a12-48f3-ecad-08d7f8cd32bb
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381F971E36070EA643D63A0C1BD0@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu5+A97wXshr/crYkkvIngzNyRnIhEyO+2Gib0YTczzV0Kh/uq45mlcyj5rJYHLjRfgIhJrixHN5uZpCRqE88TLe1180r+G3KNbmyG10W7Hb1S6j8PIMBn+8M5G9aGCTsedyzFurLiBGeS0ZbdRXBYqxY/C1JtJjRwoltlI2MjOIX/+2hkU5AcqbmhFzYPVyZXGUM3ehhVYxJd2QBGQ1ShnTZfoBP+IkdMmX/61SRkXW/WAV7OnaRQspwxsmrED5RL6ihkBb4DLSe8sM4+MgHb9UcAvYBnI1o8Ty4G7EaK5v34Q8fnx1gvApyxnOFcm1UGpM9IjhVSR3kHXWTBIyCyf9/5mUAxzWkVBjbz39mpScxk+e9/wmusG1puyJmzys7rAwOxWxDCWuK3qdxvafzSGfwc+NmZjw20I6aZ6abSjrmn+J2BFZWfzphNDNqjfP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39840400004)(52116002)(6486002)(36756003)(8676002)(7416002)(8936002)(6916009)(478600001)(6666004)(86362001)(6512007)(4326008)(316002)(26005)(5660300002)(16526019)(186003)(6506007)(2616005)(2906002)(1076003)(956004)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 164VGg8Uz2pq/U9lVxJ9JmFjdy+ZQJuF3FbUEjFuqdmMUnq3Rml05TpQLPVb+U25Ihm+sYs0D6diQHXm8C4uIRW07LzNt74pM+FMKp2MrlUm4dXO+Kcg/U5So2pvfV0s/oabAKMc0m9YMtyxe+kad60w+GRwjbuyuXOWmsW0nSKOuS8nmIg+wvQFx5eEkGLfnyotLw7mF+k7l1jT+B7tFdDlSiy1ekIMPwe2uc4e5UEVVBULgki2jTt/q8p8Gx3CmQM/tdE6qxN2kwmBQ3jtPdDZLPKbNF2iv5zam1avHYcL0eOqf+bgVLaAEffhgRCXuswaFiW+9zQ+MX8bwcog9sEd7+bg/+MFmlBScjTtZzr8BZHDamUHXbfbSUcoix0LBYgjWeqfrAHKQpMxt3APklcdDQqAmY9xNwIsLS23Td/F3FdbiwMsd4frOjJTMs7lfHCbgBJVrxJFY0reelZN/TLZoetOyL0m34JjjItogucw6ZdemhJMMpziA+TL8ASC
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75674fa-6a12-48f3-ecad-08d7f8cd32bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:40:50.0838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ab2TcjurwXQ+wMsvOFCkIL4vB36M5oBBbkbWPWBAx2fP+gM4m9wOJ+5EOhgEltdDWSjul/haQlDswKPAAx7BxOXPQvH+gSmm8/hYHTsXbCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.15.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 08:40:51
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 stefanha@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, pavel.dovgaluk@ispras.ru,
 den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
01: updated, just taken from Kevin's block-tree
02: fix grammar, add Eric's r-b
03: add Eric's and Andrey's r-bs (Andrey's one comes from downstrem)
04: update commit message a bit
06-07: new

Max Reitz (1):
  block: Mark commit, mirror, blkreplay as filters

Vladimir Sementsov-Ogievskiy (6):
  migration/block-dirty-bitmap: refactor init_dirty_bitmap_migration
  block/dirty-bitmap: add bdrv_has_named_bitmaps helper
  migration/block-dirty-bitmap: fix bitmaps pre-blockdev migration
    during mirror job
  iotests: 194: test also migration of dirty bitmap
  migration/block-dirty-bitmap: add_bitmaps_to_list: check disk name
    once
  migration/block-dirty-bitmap: forbid migration by generated node-name

 include/block/dirty-bitmap.h   |   1 +
 block/blkreplay.c              |   1 +
 block/commit.c                 |   2 +
 block/dirty-bitmap.c           |  13 ++++
 block/mirror.c                 |   2 +
 migration/block-dirty-bitmap.c | 126 ++++++++++++++++++++++++---------
 tests/qemu-iotests/194         |  14 ++--
 tests/qemu-iotests/194.out     |   6 ++
 8 files changed, 127 insertions(+), 38 deletions(-)

-- 
2.21.0



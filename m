Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48049C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D292075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pgyEbljp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D292075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8Ly-0001vs-VE
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Ke-00007c-AB; Tue, 19 May 2020 15:55:20 -0400
Received: from mail-eopbgr70137.outbound.protection.outlook.com
 ([40.107.7.137]:40771 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kc-0003bR-7s; Tue, 19 May 2020 15:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRdJXgRdbu0NmbUdFIljDAaLpHKTgjPeMGSkkf3yoBSRxMAZi4q1t/3nlScQLXcZcyNFxCdjJEc/6BPWPYz4XAAlGIjJ31mnKYJD+Gg52wm1P1Lm5+YH0UNhOAg+wVIRGymhgmBZRfRAzuoadMVsFuQfLWyGUhkYtYhJf42O4ydSeRIQKx/oy0BW2qhrW9TkHNcBZjp2GTAIm5NJWgii31ju7gWnRkEQHR+mNnIXH3N4IwcRXm1iTW/iXXSo/5CKXvRn5kdQ9yf6JGP1Veq1CCqcR5I8QfGTVgKqU9ZU1V075FK+rzxBrd/wrjY10Yet1KxHwZ738+GWyUZ+eLm2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1FIB1/EHjyRownip60a8sOBWwvgtbMKjxpRSuZg830=;
 b=ALCXyludQqSMlm+A6ytudSZ5RGw/oV8tAq8gmDYO3PbEKpEc21KU5h4vsp9OY0+fAoVN0M9y2hAjs7/sYPszWeUvpWThkpWzWXFZbvwn+28F7Wk/ZnATSK6a836UTEUi7fMmViuGsLR2NK2DF8IporLHRVbLYL5LbzDeR0Y8dOKCyfkHtWSxl6qRhWwADmprwmobxfzllkRyR3De8knTVK3JcTt5MJ/TyjTsTYQY2IqI5g2ZdV58HrN1PnzmJG2nDQaQXJIBK3WsRs/IXN/AwV57ZZuiINOko1+5dKKeiuy0T8h95SwOPqrRp5BtP+2LnRIBGVXYtDmeqNR0JEsobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1FIB1/EHjyRownip60a8sOBWwvgtbMKjxpRSuZg830=;
 b=pgyEbljpqnKOKdFeKGtrZFR+fABW/6hNlgFciBMfMud0+TOR93TsgEwB21LKL9LfV0NE0l3XJJMICSxv+/EKnrvnKYQUu1OKNXU/Gu2lkvHM9VeOqwcmWIZBb3uyzb4GMdMN4FBl2e8327OYSnT4zSbB25fPHxH9bfOPAWNfQwU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB5342.eurprd08.prod.outlook.com (2603:10a6:803:132::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 19:55:13 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:55:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/5] fix & merge block_status_above and is_allocated_above
Date: Tue, 19 May 2020 22:54:56 +0300
Message-Id: <20200519195501.29071-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 19:55:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 816f42a2-99e4-43c9-d480-08d7fc2e8b61
X-MS-TrafficTypeDiagnostic: VI1PR08MB5342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5342201885B75F0760903D12C1B90@VI1PR08MB5342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubACnwPwxIR7a8d022bhPc4fWHXwCwOErZlOR8gcPAoCTt2jgeG4qyyB5T3sqImsegK9WlfBuupyzcMKYy1yG7HDEr2T2kI5rn1cGHHkGT1qkqKubkVhaof6rChxikZuVJsGbk4qsgKTeqNDuQm/9dcoYdJO/d8YgvZom+lg6LP6o5qa1CGaJnJtI2Yp5OZt20VOmVNnF1cWzFF5Wps4FC7i2CfOiy+/WN2az7CfPHvrGwC9UPF4KTLH3pn6tNWMR+zAaAyPaCxsEOr3udYpgGygKFiBa9zxiFaR8nKZswH9cwFAfRmzjiXqnb2LxBixkHRPK7lDa0/RYsmXl0DXfmlst6qu1NPrGDI5rGGRrA097RJP8FN1UuLMKXOo3IZM7OTIXbsAVQ5D4n27yZ1fNfzmtaLTNgGlKgaiP2oq9g5E5Hl5CiW4lxhoSXcVS5RC2VDJk6QDP5YG0ZkIyMDAVRr/qQB7XuGY+nfJnaLy8pb71kmEIL7frOPMwqtUTTfu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(346002)(376002)(366004)(136003)(6506007)(107886003)(478600001)(66556008)(6916009)(36756003)(316002)(6666004)(6512007)(8936002)(956004)(4326008)(66946007)(66476007)(2616005)(69590400007)(2906002)(6486002)(16526019)(186003)(26005)(52116002)(86362001)(5660300002)(1076003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Vx/XWDcOR2NdCNkNp2hxS4YqLf5va0hnBI4T9jAImlWuhRyE7iS/Z+V0ep90jSgdYxN0pfhU7E2oBVC9BOT/H8n25KENbFZOKGd4R2XEROmRmeGjohaBnpSgburx1Kf1iraohScVc4PQBmxF0ENkUkFjnnYjQGTpuaRZoEvi4p7paVxciixBnnTGlK0WShTDiKK0YnsvdPE25KdWaFoTve66h8S5BfX244ilS0uKPz2dZpb3NbCSFEkm/Flc4wOC+Vke0qBWMkFhy/PaMPfnJxQB/4mKtSx6xi9fVjZ9oYES6xV62f7xnqFonDWHEv/YXVmF0KzxwZxNtBz/VJECyUA0KWA9mxu+FF9qO0U5MALUJ8HeSQygDN7806HOEmk4JMc5GakxiKbXpU4izHqfD5SO0yiCZAr8rVdl20hLPUIJ0KEWlv/PCJvd/gWWpDcwEfRZA5SqNY8/ujLD7iD/qn9meee0qwv+fVoaFnH+Df0TJCThIdYh6kW8/1pIWiIr
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816f42a2-99e4-43c9-d480-08d7fc2e8b61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:55:13.5604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4aDjQKhRc/C4EEJMldOjx7S/SiCnOnvl9uzh/ouMPqa0x6jj32s67Ts9c4h0+t0LEkboXf7902FmeO0bJXby6ZfUewcvW340/9Vt1nksJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5342
Received-SPF: pass client-ip=40.107.7.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 15:55:15
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

v2:
01: wording, grammar, keep comment
02-03: add Kevin's r-bs
05: test-output rebased on compression type qcow2 extension

=====

I wanted to understand, what is the real difference between bdrv_block_status_above
and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work through
bdrv_block_status_above..

And I found the problem: bdrv_is_allocated_above considers space after EOF as
UNALLOCATED for intermediate nodes..

UNALLOCATED is not about allocation at fs level, but about should we go to backing or
not.. And it seems incorrect for me, as in case of short backing file, we'll read
zeroes after EOF, instead of going further by backing chain.

This leads to the following effect:

./qemu-img create -f qcow2 base.qcow2 2M
./qemu-io -c "write -P 0x1 0 2M" base.qcow2

./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M

Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
./qemu-io -c "read -P 0 1M 1M" top.qcow2
read 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)

But after commit guest visible state is changed, which seems wrong for me:
./qemu-img commit top.qcow2 -b mid.qcow2

./qemu-io -c "read -P 0 1M 1M" mid.qcow2
Pattern verification failed at offset 1048576, 1048576 bytes
read 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)

./qemu-io -c "read -P 1 1M 1M" mid.qcow2
read 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)

=====

bdrv_block_allocated_above behaves strange too:

with want_zero=true, it may report unallocated zeroes because of short backing files, which
are actually "allocated" in POV of backing chains. But I see this may influence only
qemu-img compare, and I don't see can it trigger some bug..

with want_zero=false, it may do no progress because of short backing file. Moreover it may
report EOF in the middle!! But want_zero=false used only in bdrv_is_allocated, which considers
onlyt top layer, so it seems OK. 

Vladimir Sementsov-Ogievskiy (5):
  block/io: fix bdrv_co_block_status_above
  block/io: bdrv_common_block_status_above: support include_base
  block/io: bdrv_common_block_status_above: support bs == base
  block/io: fix bdrv_is_allocated_above
  iotests: add commit top->base cases to 274

 block/io.c                 | 104 ++++++++++++++++++-------------------
 tests/qemu-iotests/154.out |   4 +-
 tests/qemu-iotests/274     |  20 +++++++
 tests/qemu-iotests/274.out |  65 +++++++++++++++++++++++
 4 files changed, 139 insertions(+), 54 deletions(-)

-- 
2.21.0



Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE642C47257
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7C820747
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XXaq4wah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7C820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGKK-0000p1-Ok
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJO-0007fh-8e; Wed, 06 May 2020 05:25:54 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJM-0006M8-5Q; Wed, 06 May 2020 05:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddjvw40gDIXqqkRbVncF6Zf/5XtgwVx30UQXaSsKG/IYHtFRMGfE6jQruLt5dRoLksXS2bB6S1f2cgPBOc/d5zjZUhCPRRzFxDQbEbH4FzVy8V5jh6YCGqCj2g3HpYdr+8QLL0dOL+T7L7P01H1HelZpBgoJmC9U+U6yAbROMKiSbN149WXg3UaFsvXf3ZRLYuSsLyKeP/+MzA3ILGF2YlTJ6Z0jviEFCLoThwZPGDHHumLCAj8cdV9fLEDtdzUkRlQDyAS8Li0QxaIQwcQMZtUpLdY/vmhgHDo8XQlXgvUJLhxFS0rVfZRBq/0OrJjAPXmvQHHtvcgV6JBSjV0bYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOkXQZSc70ixgCyWYGlnqBM9DW/R8Y+PEt/9ZOrcQBk=;
 b=BIUsCrYHLVHwFRgjit7DnKoOPgADtsyYvQoThAvNirBVVzdJxTuPBEX87tXzP5jHR3fdMb+yo0ug56Jq72EW/2yNiMAlggxjMuXOibKwGW0g48xPkQFTKfJaTKhg5ke+MwD7YXgSLiguHzTwpbSb5VbLb9JSLxerd78KS8L33v3kWaQaTMRlGOq8j2txRZw82ESOcBH8F9vg7UBmdBKMl4QGKyeIOWFJtRHPKduowxZ52l+8MX1mNbWITXU73vMAVGUq3aHqCd6p9tUi8+MJyYnNRZgmCSp4j715R8isWfbD82YF2PCYzC9oFV3I57bg/mVij1m7bVAyp7QOweVD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOkXQZSc70ixgCyWYGlnqBM9DW/R8Y+PEt/9ZOrcQBk=;
 b=XXaq4wahVCBhuY438FPfMBC2NHjK1NLKRkhFsRwEtAg2lcUnPj7BsQpyBzf0rTVSGQSnU0O00//TrKxCKwDkCiw6s2n7hVAZHRtAtT+sM3SmTd1Ywh/uuXbw1vVTlVTZcaDPuhaByszJYcl4O6LzixPjNuKgQQmwuPvUpNDuVBs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/8] drop unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:05 +0300
Message-Id: <20200506092513.20904-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a594cd7-af22-4aa1-8b1c-08d7f19f753b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53823B3A9710306E05C048E5C1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E//+/7ac7ySiFnzeNvn2PAkc40ghTZo+kVlgw8XCXgd6Y2woYGya6YPrklJeZN8XYCn4Bj9gYzZDTOmheN2X7/3XTn/eDgjSz4gX79OuC2/sPqwgP1tQOMB9ypXsGtIonO2uCVVEpbQ19xC8qCGBcws2yYWOKcEUrVLYofoZtvZqkolhar+5Iw1NrVFhyhnCAhWQ06okOsMwBS5LPhES9DAF7TJrQYG7Yc4vyB2dlkCwuwdZq5qQHiQOnO+ebk0fF4anfz7n2KmNZHVIIz6IEHyU7sKU5qKGtlHXf/asp2zaB2xQk8ncLo28gdkhkkj2hMPGsxDsmJCgEEqvxNdJrlhlkJduvbTQOZn4Nikxpikl4+b58AotFyD46a95xmcMXZDo1zwdTbL8R+WmS68cZQh9YBzdSMNF7NRDZ4F7inT80rltCepF/baBOY7rqZLhvLwnu8YCe/WYPZyuy5ipU5GGUUEsU1SUJwXS4SmSBN+90mewmMEsMTmx4Cd4gnOHlWYu01QFkhcphuTOK5Q43HnCWQvZx0vh7c9DsTCTWe9atcFmL3xzonrultjaQdK3TwcDyySPOIy1WGLQOBIOVP3QQmJBo5KktawVsmjI2UBtwWP1lyqTReFuBkoHtTs7U/55y4wc4N/J9zcvF2QttQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(966005)(66946007)(66476007)(33440700001)(66556008)(4326008)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: HKvR18m0HDWJl/mm0Z7bSe3oB6MLwna+5PDOu0t7f2za/aFog2mtvkovGnQPvwDEPyD3U5xBhJ941N0idxVVC9E4qv/GdESCqg1QyGFtOPQdZGZIaQ8Ea/a2QZhJriaoRli9fHe/WCF54E/5JDQhOnt890gbWJap7oa6iAjL5GJ83vqQpLhjRpo+U24Ra/+BItDxys39Wj+KyE/t2gXLVpWG/ybEswO4pG94UB9YmQV/zZIQWdT3+BZcgtqkL+hjn0Zy1UOpE18p6ADUtarfO3xnSZF3GQqfcjZbq4XsVnDHvtzSxb8bttnqtaDvlIROwyiI58wrpO/OwJqwbuU+TzmUSJYTKoegs2ZCtna/atT1W6e5V70XjbpIB4uXD8NK875XNrVoxiuIIOTnkjDCGjfeB8m3tKjbTITfsA/KhjKKLQbMbGyMWXugZa3DtW7OVk0Xo/2HuDnKeQC8laE1O6A/mFPwzYezOe5FMoBGH7pyo1ZWquAnTkkmDcSlYiFBN+7KWVMAPUSi4C54SZhzlojeeSBRSrO9s0Nw2a0dJT1JJw6QqcdPOjmN2mL2r9RYKFkB/DIZbTA7jQUz4peuSatEpe17HOTv1STtAsxbooltccnm4KkyDqFJwo5+wKk/oet35Wi8T0VU2HEHHuuubNFyZnvOWxKYitSa1laP8hiNDtbRXX8Qt6C9CxTKJFvJWzxT4gJgkKxqBK0thFilPlfiZBMBlmERjoiZSRmnLbNK7a+NQr1HGRPT1bGn+R8ratVwu8lvz5I+z1W9fDngV9JkQrfQZli8IITQGy3JFJg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a594cd7-af22-4aa1-8b1c-08d7f19f753b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:46.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/ooas3OKZ5dS/7ADEd3zFU3wW7nJxmttBenOd0NqM2qqQxhQrk95u8Bu8Bd9mRRrlAr78CHYEBRWm7V4lIbpoIC+uGIvy1hGWnU/clWoHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:25:49
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

Hi all!

This is first step to block-status refactoring, and solves most simple
problem mentioned in my investigation of block-status described in
the thread "backing chain & block status & filters":
  https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html


unallocated_blocks_are_zero doesn't simplify all the logic about
block-status, and happily it's not needed, as shown by the following
patches. So, let's get rid of it.

Vladimir Sementsov-Ogievskiy (8):
  block/vdi: return ZERO block-status when appropriate
  block/vpc: return ZERO block-status when appropriate
  block/crypto: drop unallocated_blocks_are_zero
  block/iscsi: drop unallocated_blocks_are_zero
  block/file-posix: drop unallocated_blocks_are_zero
  block/vhdx: drop unallocated_blocks_are_zero
  qemu-img: convert: don't use unallocated_blocks_are_zero
  block: drop unallocated_blocks_are_zero

 include/block/block.h     |  6 ------
 include/block/block_int.h | 13 ++++++++++++-
 block.c                   | 15 ---------------
 block/crypto.c            |  1 -
 block/file-posix.c        |  3 ---
 block/io.c                |  8 ++++----
 block/iscsi.c             |  1 -
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 block/vdi.c               |  3 +--
 block/vhdx.c              |  3 ---
 block/vpc.c               |  3 +--
 qemu-img.c                |  4 +---
 13 files changed, 19 insertions(+), 43 deletions(-)

-- 
2.21.0



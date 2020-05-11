Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF08C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE67C206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hycloud.partner.onmschina.cn header.i=@hycloud.partner.onmschina.cn header.b="sI4Y/Abd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE67C206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huayun.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9AZ-0002dL-T2
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quweijie@huayun.com>)
 id 1jY5Tt-0005pM-Uq; Mon, 11 May 2020 06:16:17 -0400
Received: from mail-bjbon0147.outbound.protection.partner.outlook.cn
 ([42.159.36.147]:43781
 helo=CN01-BJB-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quweijie@huayun.com>)
 id 1jY5To-0001sJ-LD; Mon, 11 May 2020 06:16:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IknSg6WML8ej74r4pmX7VThEeqstGZTcdZlpJqOC33o8AWPEs9zdFUtAzDNgk1hO6e9CIQ7MDthyn1ZG1UBv0HDSSzPVuvGGGinq20MgCXHAi8H3+4DtXelNqaMTKxhj0b6p5fnSeljtt2J6a9k5Db8ap6KdXfJCAXltApo01R5sj2/w+Bli9sgTY4t0DdUQJ/2r8S3MMLphvbpir7C+w9sBYpWOikcV3DKRtA9DKxP0gCvOvNh26Ihhup9oi3wwTrW25ROJIoRWAWFIwWy72LjlUswigXeIPR5fyy7/p9+e1Sc+Q4P0gUwhTHs28scQiu/c6kNoM92PwRQVvEDUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDPaY3m6HIuVs3W8O7d4E/rrbhCV1P/Azm0QFTsrqzw=;
 b=WHSfqpx0hoGExfA1rSLzLU6rp0IJJ8cqcS4mFYJChWAIO5wja2/DB42TR4bH86MF0W7BVgW3Vy5gjav6fx3irg7QJevE5pCxWrnkt2yOydDTsD4Lt/nmNQtVa8y9CgS/P7UET6U68DC22f68Xy5KxSBrZA6M9gUfer7WfGkcQg74ohRPZExEfsYJ7UAea8vv8htdWp9iwHCPMf0l/uBW3pMCzQ3z6ETbjqrL+DQKru+1P/GBJqrPi/C6pOyDVvLex9TBg/QIruYdaIU5Eu9WrZw249p3Jlk3Yp5PXccxuqnnLGVumuFxddhr8DQBe+eqS+cJenH9HD5HQ1667jxPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=huayun.com; dmarc=pass action=none header.from=huayun.com;
 dkim=pass header.d=huayun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hycloud.partner.onmschina.cn; s=selector1-hycloud-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDPaY3m6HIuVs3W8O7d4E/rrbhCV1P/Azm0QFTsrqzw=;
 b=sI4Y/AbdvWeQtHXxxPvTQwWuAnDMHs5qkXBKH80vInm/Di58HJgnZiE3OG5MdbGylh3RHbufPlvsB/FvDpK22YA01WhjYrB/OKmK2Y4VNMe7YZT2M0jtG026NU6NxW5BkUmpiSfPndPtNwIDLR5uavEezAZvGMJJtmS/bSdlQNk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=huayun.com;
Received: from SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn (10.43.110.78) by
 SHXPR01MB0637.CHNPR01.prod.partner.outlook.cn (10.43.110.15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Mon, 11 May 2020 10:00:53 +0000
Received: from SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn ([10.43.110.78])
 by SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn ([10.43.110.78])
 with mapi id 15.20.2979.033; Mon, 11 May 2020 10:00:53 +0000
From: quweijie@huayun.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] When del child,
 next_child_index need to subtract 1. Otherwise,
 the index will get bigger and bigger.
Date: Mon, 11 May 2020 18:00:30 +0800
Message-Id: <1589191231-18876-1-git-send-email-quweijie@huayun.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SHAPR01CA029.CHNPR01.prod.partner.outlook.cn (10.41.244.36)
 To SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn
 (10.43.110.78)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.localdomain (116.228.45.98) by
 SHAPR01CA029.CHNPR01.prod.partner.outlook.cn (10.41.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 10:00:53 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [116.228.45.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e3b243-7cd3-4d84-57be-08d7f5923105
X-MS-TrafficTypeDiagnostic: SHXPR01MB0637:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SHXPR01MB06379BF3F22EFC19A97883CFB2A10@SHXPR01MB0637.CHNPR01.prod.partner.outlook.cn>
X-MS-Oob-TLC-OOBClassifiers: OLM:21;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaFzOjp0oPBqN8yqJJJFurtIKS0xvrGPpTF596pBNqE2M4aB3wJhSjjv5VqVW8rfajiTRqUsObskbuCgFYEYu7dL0b2CmWujyDeuAjq1NlAeKRkG2h+F6UmyWlZpjDLBywhcP8RMtOAluhlZb+FR7+IzCyebMPQGpR8Q+iiv2hQiZK9EUWKKHVQsaZxjAfA/hWqeJroz8TI8mGXj5p+KLSON6pVfEJHgHi0Xo1N2T+O5Ez7pOqy6G/rMXdzAzZ/jyqOgeOxYEdw41SKbEIxNiFlE/bTR703Vkm42eOB4Hu1C1L3kwBLLhYdeU02M/Gj+NtAl516iOrAHdpgFCT9QgnZ3pfIXlzTQSX4foDoxu9vz01U+jdDH/hyp3GwuGFvd63WENFbnP2YwliJe+QwnHmQr/YwLSCDach5cISyhyt+GyI4LDZlWqxugsKDll6zJ2WxQq4znb3ifRzUjBIE7r7W/hplI9CciLCd6uunVTyMztbg82/TyHFfibhSQmE9VmtWHpYn2l/sYE6GRh0MN7M+cSh3gp2A2PlvPFkhwPvsPu1Zh8JM4J5UOhoIGLgXGhFt8IL0fjSqzFLKIWcJZUIgUG4WjdljDBQGkkUe7oLT3li2OAjPdfNUQvw7MttPKC5mVyB+/BS7gAEWUc49w9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0574.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFTY:;
 SFS:(376002)(346002)(366004)(329002)(328002)(33430700001)(508600001)(8676002)(86362001)(2906002)(8936002)(4326008)(63696004)(52116002)(36756003)(33440700001)(2616005)(956004)(66946007)(95416001)(6916009)(6666004)(54906003)(66476007)(66556008)(4744005)(5660300002)(26005)(186003)(9686003)(16526019)(94163001)(223183001)(135533001)(142933001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /0MRnDB+jXTw0gO1PB6KAZEqLDUp4u6lemY/yQxJIlbGYOxCyFla9Xl5uCOzii+SNtT7zYaC2+C5EXAMKvCP5DM8Qeu8k9F7lg71Czu/uy0V7wvg6X1lg85EW+G0WFgkIdK9DQq3ch2jJg5tlT7oZfyZeXqJskJRT5CwzQ2TsdtOjeQ7oprc1C6PqFW38Z5v6yXiREsBuGCQb4mcogJUB/bwZSNsrsNcQ6mTlJXgx36sBeIgSFLkTcrdgwPJyPwgtPi5/2tH5BJN0QGLd7xuZ/zt7Ei5ql7yLJk1/+Flh0UMyhQMkS2Qj39JXz+VVjNc7aTlTTk7mnRXl28Sgdi1kXc4xdBI5wvSpsAwDTo5nmF9pbdSis0zP+OIf4TLOMGCEQHbOjRz3UaEghg3+donsiJlCp///M+k/TUTCuQYTIQ=
X-OriginatorOrg: huayun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e3b243-7cd3-4d84-57be-08d7f5923105
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 10:00:53.3678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a674a363-98d5-4f2d-95da-d54302c8edaa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89IS4Uc8hyTcq4nA38pYW5O2dw93brpnX+XaJ8NeqBT7to4qXEoCY0QwvnRSsDwAOAV0wJV1LlJsDJpQ0CbsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0637
Received-SPF: pass client-ip=42.159.36.147; envelope-from=quweijie@huayun.com;
 helo=CN01-BJB-obe.outbound.protection.partner.outlook.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 06:16:02
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2020 10:09:20 -0400
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alberto Garcia <berto@igalia.com>, "open list:Quorum" <qemu-block@nongnu.org>,
 quweijie <quweijie@huayun.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: quweijie <quweijie@huayun.com>

Signed-off-by: quweijie <quweijie@huayun.com>
---
 block/quorum.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56b..a8272fe 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1096,6 +1096,7 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
     memmove(&s->children[i], &s->children[i + 1],
             (s->num_children - i - 1) * sizeof(BdrvChild *));
     s->children = g_renew(BdrvChild *, s->children, --s->num_children);
+    s->next_child_index--;
     bdrv_unref_child(bs, child);
 
     bdrv_drained_end(bs);
-- 
1.8.3.1



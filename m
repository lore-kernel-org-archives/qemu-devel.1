Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E56CC55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D97A20780
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n2Lf7VWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D97A20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jREB4-0000Dc-3N
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 08:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREAI-0008By-7B
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jREAH-00076R-Sq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 08:07:42 -0400
Received: from mail-eopbgr60117.outbound.protection.outlook.com
 ([40.107.6.117]:14667 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jREAD-0006bu-Uh; Wed, 22 Apr 2020 08:07:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsEnwXsZrjpU6BH5U73nB9a9hgdgFKqcoF7MZL2/hvjoGzq0B7wcSIGBOjUEW1QNUBawQwUlLXF6pcSHJ3qDtKUrNMRYwJqfu0kBauSespW8DyvDY69ZiLvrLLhKeO+Jq1thXyH81gtX9xECM/VmlT+nWw/KbMQewG1Ft2BNr+NUiDUzEdOv2eFRXTShv08c/V/IV+7utghTqsqF9YxLJN3xjmKeoLvqRrNAHHJJqtAAnsA1vmywrxto2kuYeQhueTiBx15rfL1m4bXBxrWJwI5noSmphuNAmnHRsIHXxBJeJZPZJnHCxd1ltfZD1UfRBs+XwiGkKTxMxrcqUJtO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7WEHUztFvvuDPC6Q9jvbavqcuJGiadc8gPidSel9X4=;
 b=jHT25LnHbj7ZIYBldDn8KSRL+/jEWUD8K9ETE7QIWKaw3rFCwnkxPFmZrLt8g5I9HDWaHYv5ZpVxaoMhW8KSNDHJyiT7Ijt4O1lHwZNWSl7ol4yx/rik4ByI76sne7KxRo+tA9OnEb6w2q6KCUWb9qhVFUu7UK1TmRn1eiP5uXFI5P/qSMkW/YveZsLjTlbSncBzRJ/8wpoRxoKtbxpNTypCFkWnRIkNAUwViSd9h/wuiEAjxdRvMys3m6jFqdQrFrheda4DbmeSXIWIwfRgPDMcJN+NX0+XlrDOPCoov/RO4D1mnfAtmUw1SCnKy1kMxSViiqtrF6YYTekJ+QZweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7WEHUztFvvuDPC6Q9jvbavqcuJGiadc8gPidSel9X4=;
 b=n2Lf7VWuC4ZuBWs6dXZC1OX6xMvhDfqWmLPfshCbtgvtbAaxOSu37qKj04XIRU5ctiw3YN7uWOdmhnT/KOtXDy3b+tk9ISYfYByGZY3zbXxrHJOPWZUjsibWNp04ZYnU9tiDeWY/YrsJ8r/Tc5E2fKx49gNzDzw12veo44zvhHo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 12:07:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 12:07:34 +0000
Subject: Re: [PATCH v4 21/30] qcow2: Add subcluster support to
 check_refcounts_l2()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <ef2a1699095c04e954665aba591dd055c3bddb63.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422150656745
Message-ID: <9972aadc-dcc8-9fce-019b-e23d2b7dcad8@virtuozzo.com>
Date: Wed, 22 Apr 2020 15:06:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <ef2a1699095c04e954665aba591dd055c3bddb63.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::16) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 FR2P281CA0029.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 12:07:34 +0000
X-Tagtoolbar-Keys: D20200422150656745
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3224c29b-f438-4154-d0b2-08d7e6b5be0e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5301EE0C9946185689613F6EC1D20@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(2616005)(16526019)(8936002)(86362001)(8676002)(81156014)(54906003)(4326008)(52116002)(66476007)(31686004)(5660300002)(66556008)(31696002)(66946007)(6486002)(26005)(107886003)(956004)(478600001)(316002)(186003)(6666004)(16576012)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywKIMzLwygwi8B9PONLkKkYKM2p9spz3zHqRHUSLFBWizSVaoE1n3DN//OMD4eJ9qJ0nVSRwDMHdqgM1F9gJnmB73w5wdPjjGl8Ss1taQde0DR4AxBD96GFsIKFZ8gAZGGwKzshj+/zhUGxu0XpKjghBpx07AeUnLyVXeDNmwK0ooFsG6y7pL7O4zjEFSc5CYZRgyUq4VbLCycl3L9cgfIvdHEe4BIXPSUekmRvEyrNToTPo1qQIthLbkeHORqu8Cl6PuZE1ci2CDThR9ivNce9yw5k+pMnZI7DQJya3ATLb4ep0bRVRq+ABDvkgqFNjNDh89rDd8DyRir/Wp5M/LqKVOLQqBwciskHYokjOjeXamydtIUt4Kqa/8q7O1wObstjNnMFCQOS1d+aKWzD7VxSRLXWv5Ehp7BdAYIrG4HN65HGXq+6pV2snq+cFBhZz
X-MS-Exchange-AntiSpam-MessageData: 9QbMQ2nINr3G+wUwviju9ALEAUMv/VEW8WvNjGIBhLhe1i7Q/XbBOK6bKikRL4DCjaEF6cR3glhD4MIzL/VzR9m/nsyC7mkmGI6Pg4/yp19szebMTEmulCxlvqSym6/TmuNHmXwtMotj1vdxaGY5RA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3224c29b-f438-4154-d0b2-08d7e6b5be0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 12:07:34.9410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8mOYbK4ILvxFEWB3DNKG8XXDiNreS/f+ZYBqsZNLj6ZL3OmwuqZiPn/wvH8ED25huouhUyBzegThH6U3yaFbqeKhERKdsaugE2zb1Gq0Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.6.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 08:07:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.117
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
> image has subclusters. Instead, the individual 'all zeroes' bits must
> be used.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Patch itself seems correct.. Still, would be good also to check, is QCOW_OFLAG_ZERO set in subclustres case and add corresponding corruptions++, and may be even fix (by using  QCOW_L2_BITMAP_ALL_ZEROES instead)

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   block/qcow2-refcount.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3b89a97fd0..9337496c84 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1686,8 +1686,13 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
>                           int ign = active ? QCOW2_OL_ACTIVE_L2 :
>                                              QCOW2_OL_INACTIVE_L2;
>   
> -                        l2_entry = QCOW_OFLAG_ZERO;
> -                        set_l2_entry(s, l2_table, i, l2_entry);
> +                        if (has_subclusters(s)) {
> +                            set_l2_entry(s, l2_table, i, 0);
> +                            set_l2_bitmap(s, l2_table, i,
> +                                          QCOW_L2_BITMAP_ALL_ZEROES);
> +                        } else {
> +                            set_l2_entry(s, l2_table, i, QCOW_OFLAG_ZERO);
> +                        }
>                           ret = qcow2_pre_write_overlap_check(bs, ign,
>                                   l2e_offset, l2_entry_size(s), false);
>                           if (ret < 0) {
> 


-- 
Best regards,
Vladimir


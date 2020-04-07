Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6E7C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B92072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ayY0qRbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B92072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLh44-0003fD-Ad
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLh3H-00035P-Q0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLh3B-0005zO-LP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:45:34 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:59333 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLh3B-0005xZ-1l; Tue, 07 Apr 2020 01:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW7ik8sCwSBX/F+DFEC02NvEGSoYSfRffD+baVwvMW+dvs9gAAGf8DWnlnzUilhmgh6HxLIv6kTuHKScPKf3N6jaUKx/UwqNgpnXST2A/delr1ZfssXZN2pLGKvvQOgA3fDgj3cAq9+nfOlhb6BoGI2HsS480k28HJOUxHxFHaqvRtioTCjDTEV434RJdbgYLr1hg1tDSOZbLB+uhLJq4vToKf9W8j0SP9jiMxsKq4M/XNZJgpogz5tLiWn+BP060gPjH9dAy+H1FeStbzlDyN8/l8s/EeN1hJGa593bbHrw4Po1pN0Tp29kQoUosLeJT0S2hPJUbj30ASPorPaX0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWgrF57R2t9k3qOlOjyohCLQs/UWIvLj7x+5UUbwYNA=;
 b=cbC+U5Q2iRMHiQFrADNVVxJdCMz53mjLaZT/4D32uHKmWdpS1+8tXBmh+I2PnJDazz8PqNJKww4C4g5bswuPlgo6m+XkfXz9Gx8haRrg6TUxJrcQENz7FAib4DkRdTCYBT//t8bgljfcnhDJWfI6diorZltJ2wJogprCnP/cZziTlKf7UgOcTJvq5ORhDAhqVVqxZgSqauhyr7/a+khMMNTZTphH7D4c886svVKC4eY5qUx3KRAbF/eIoX+JheGfa9cWsAV8uvU72Yra4Irmo+0xczhLs6EnYFLRcgLrEiftiiTbma4OhGjcbs+NZwcJ1kA6ACiXMbsJO0nX3Z/8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWgrF57R2t9k3qOlOjyohCLQs/UWIvLj7x+5UUbwYNA=;
 b=ayY0qRbPcFlWW+M7alewuxNFhOrTBGrxoVzohMR9y9ZT0rAUHqZsT1LmrlQi0FJTSd250qiMssUewalkTrJzWDWgDCptN+GmgT8mMWw3ENdlCajMCwVva1G88xpj/3aFiRh/TpsCdjzj4AzaibbtIqMF2qtXhLLLXvuVm+dkVlE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5478.eurprd08.prod.outlook.com (10.141.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16; Tue, 7 Apr 2020 05:45:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 05:45:25 +0000
Subject: Re: [PATCH for-5.0 v2 1/3] block-backend: Reorder flush/pdiscard
 function definitions
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-2-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407084523485
Message-ID: <042e919a-ea77-a72b-b220-689a529ffcfe@virtuozzo.com>
Date: Tue, 7 Apr 2020 08:45:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200406171403.6761-2-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM0PR10CA0034.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Tue, 7 Apr 2020 05:45:24 +0000
X-Tagtoolbar-Keys: D20200407084523485
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e06424b-9f8b-4d45-f528-08d7dab6debe
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-Microsoft-Antispam-PRVS: <AM7PR08MB547841B5E7BC399DE432DE80C1C30@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(346002)(136003)(396003)(39830400003)(376002)(16526019)(66556008)(6486002)(316002)(66946007)(8676002)(52116002)(66476007)(16576012)(4744005)(2906002)(31686004)(81166006)(81156014)(8936002)(36756003)(478600001)(956004)(2616005)(186003)(86362001)(31696002)(4326008)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tLcqrJQZCo24boIfA06k8HvzdX5BEAHSa9eW79kGQbUhWY19tRTaiUL5Em5ggWejASkT5L5viCJUH4kfvjNdzYSP9jqdlKNDYesDLQfSUYOsMuHLGluNgwbgbE7gZ01hZJHxC0zb+mvTELfINlqF8se/OAGrZvD8w0RMKE36Y+ZikewzxfqYA6/XNUxB1ACgr7AoaKoaAmC26rSgWVZgw68VlT7WuKDJhEsMWNTz5L+pRDbUPZfU3bgOSOCIRKb8nGDWBNGp7D3jWqhYl+okiWRJvzdHli4utRyneuKfz2VtvzFtZzkvR7cm7Myw5oQ4FstanCGhYgwLFz4goYLHUCCs11qviJqXK7YJ5w+sIbiM7xo5P6SIhvoumgYFDojQVH/xPzpgk0PS8pLcrcBLtp55rvOid4nK2ElhGgOoUK2OG93a9yxMm5T9n49S3Yi
X-MS-Exchange-AntiSpam-MessageData: SFOYUIuZaLQfoLNqIF5pQK7xY9qL6bVgRkg2YKMNDr63+TUX/KVnOsc/P3yQfPbwvIttWFfQrvVk1r3NAUmAVzMYDfG0de39DMpbWCrSHQ4HgsR0NdB8Wp/D2kp0zjzfNOL2T4NQeAG4HnuSC5begQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e06424b-9f8b-4d45-f528-08d7dab6debe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 05:45:25.3816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CkVBXUaTYFBEoZGC7ceGKvmH2SWDz8UCQTB0QWIbtu8ksvqd3XBdFEg0+lzlTu4I24n2uTmGxC8xU0HImYk4m6HGD6IBFHRqsIk9SkqUP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.127
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
Cc: s.reiter@proxmox.com, qemu-devel@nongnu.org, dietmar@proxmox.com,
 stefanha@redhat.com, mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.04.2020 20:14, Kevin Wolf wrote:
> Move all variants of the flush/pdiscard functions to a single place and
> put the blk_co_*() version first because it is called by all other
> variants (and will become static in the next patch).
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir


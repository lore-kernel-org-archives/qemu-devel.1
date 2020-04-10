Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77354C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAA82078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bav76TrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAA82078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMqGH-0000YO-C8
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMqEp-0008R3-2D
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMqEo-0007VK-2y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:46:14 -0400
Received: from mail-am6eur05on2125.outbound.protection.outlook.com
 ([40.107.22.125]:5088 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMqEj-0007Ss-If; Fri, 10 Apr 2020 05:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlemrbIY8ZV3YQCu1E9ICKl8nXvbFUmdY1iptJTVaS1muzVvepBdhU8mvBmnT2GZpWxM8g5x+nZ2dunJdUscvJwIWUr3OzN35zgXaKgV5W/2587BQDI7ZE4H+GgLBCNIDbXVU/zBZAZ7JQeNMdAosTlLY3YL43f0mLYsxYsp7eEjz5N81tH/kxn8rIRCAJO29EsU0QP2zhQKC6b9kie269xnIIvMTxhOpjQD8ihTtTrwcMuMf8StyxHEeBLP3S9z7ctHGOOE8f8xM5E4xdfn2p8A/h0h67YeeO5Hh8J+AHz7xW7laWkvFc5oalWt2iIfU7/3BF63OwWbSGPhDSC3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7kEuhz6sN0A4DXEYB85Ie89bwLyFxq5epCuX6h95AI=;
 b=YeL1CMixEULWTVi02iCXRiZrnHf+Ht/el0Cvm4/QCO3jo5GIDg1avTrW4r1d5nPoKVx3GSBFsDJsWLAW2IWYt2CO4b/OasaN4oQYnm4t2amkCzC4PWp8hAxhkSCzJbl2TRx46kMrQ9kvaLw7io7SD//11urFFUFn//PNKxu1IYU94jBUJKY538Ck7zOhSTKdhnZAqVD1Y0uWDPd2kzyrydHW0XaezWK80ktDDShRcZRq8mVffHiNFxDvOFwj5n37ZhrgFRDL7qhmj7q9SYrqaZ9/q9+qe04Iy8S0yW4XY8bCq2wfTr4wy81tezG5ptOyEMPN5+PU8GrTl2QzFY/bQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7kEuhz6sN0A4DXEYB85Ie89bwLyFxq5epCuX6h95AI=;
 b=Bav76TrNzcvfpGYlkDGm15mcKt9UBPAJ9oVuYO9g7UynHN484F9LK7QvDyyUhYBCXIekXwXpitLPWEwy1nw6tYGhLcqdEzkAwfqMbY11c94tw9WzZRxrJ+GNiOgOdYt+R8suNQzxVQ35QOu44JOa7R28B80NoqIlQ7fxJT6Xx3k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Fri, 10 Apr
 2020 09:46:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 09:46:06 +0000
Subject: Re: [PATCH v4 09/30] qcow2: Add subcluster-related fields to
 BDRVQcow2State
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <eea31d0b30552e61f5921c6e693034cc75c724c6.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200410124555446
Message-ID: <3706eb27-e17b-923e-6d00-1170c2208584@virtuozzo.com>
Date: Fri, 10 Apr 2020 12:45:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <eea31d0b30552e61f5921c6e693034cc75c724c6.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.134) by
 FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.20 via Frontend Transport; Fri, 10 Apr 2020 09:46:06 +0000
X-Tagtoolbar-Keys: D20200410124555446
X-Originating-IP: [185.215.60.134]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c696d51-1101-4120-eabc-08d7dd33fda8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5493CDB9B55562FAA2689FC6C1DE0@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(366004)(396003)(136003)(376002)(346002)(39840400004)(6666004)(186003)(66556008)(8676002)(2906002)(16526019)(31686004)(956004)(26005)(52116002)(5660300002)(31696002)(66946007)(66476007)(81156014)(8936002)(478600001)(16576012)(316002)(54906003)(6486002)(4744005)(36756003)(86362001)(4326008)(107886003)(2616005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noi3coIR2RTpH5wB3Bc8Zs07aa5gWi7GXgmHUMZlvokdUt26udr1YqdZLF+GCyfb0E6wWCiOsi68JKJhgq5h6XHF4QDV7mBqmZZmJmK8cyRbh1xSmUs0gJc6ZO0TgNAjItmBvEKJdgrHzhC5YyzSG8x/Cqh+hsj5zB3AD9IRsfwZ07HyvG2zSdoW5XIaPZ5mfoZA+SIMwIPT5b/LHS5wmD5m5OXZt8ptJFIEFTrcL8FzB/5et+o1TRBMqQSrW8QpaVe1DWgYL/5+0gAOwOMkvGySbNV1Pa68k02A+2bq+5ys3ObOfSbq5SGDZD9jz2/sZcDQxe7NtXigZuT/PPURR1v7v7MD/ZTYpmjLoymBlZ4ASWHJfub0gJbbwnjQkqIOkvkoKXdrMj6u0cqNxuw6aVkGZaBIvy/JvPIA/7YaIWbQNK+ae4unj1OTkcS+dnP1
X-MS-Exchange-AntiSpam-MessageData: S0Hu1ZBT1Ty+JsYJEFb7Z8/RUE4UbwcaH3P13eZfozZvffSDOKlJ/j7m3c0Px85YQjrrogrcTHlNuWDTmtCl20tnw/29zUwd3pZJ7e4QbHgUSY28yVPyfDIlkMkEJyrC9AoHiQQU2oTV0mZCzGf2kg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c696d51-1101-4120-eabc-08d7dd33fda8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 09:46:06.8435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yf1ZOwLE54MlOhCcCXmQe7DbKi+aFysT/XaKVima8PsQmGXExwvvTEYeM+AmDsV8uFdEal9qACGAv1aKhD9mwOHNZ2eF+OEVEn7xvyQagrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.125
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
> This patch adds the following new fields to BDRVQcow2State:
> 
> - subclusters_per_cluster: Number of subclusters in a cluster
> - subcluster_size: The size of each subcluster, in bytes
> - subcluster_bits: No. of bits so 1 << subcluster_bits = subcluster_size
> 
> Images without subclusters are treated as if they had exactly one,

exactly one subcluster per cluster...

> with subcluster_size = cluster_size.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir


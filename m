Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04552206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e/LjSGGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04552206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDo9-0006UP-93
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDme-0004dM-BA; Wed, 08 Jul 2020 13:23:00 -0400
Received: from mail-db8eur05on2103.outbound.protection.outlook.com
 ([40.107.20.103]:57117 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDmc-0004nT-KZ; Wed, 08 Jul 2020 13:23:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mI/4cK2HcC6q6kyrpjk3DQiRZZT7D+UZ0AE1KEquU3FnstldWpB9MWQtOoJrRt2XptVI3I7c1x6et1steHUiBe8CfkU1F/P5kquhyq6CETMB+cpu2roek71+MLBqyRpkekqSD3tHCG3Z/fXNMqxHdj3c+6Jajv7bYKs7AacKLx/9KjZdsNl503Po1fChfYJnhnNyNfNkWp/R4yXWGwJW37cYCSefSaCmFEgWEuXBh7J1raGSTJb+8f5UEWl+V5aUx/RszsJjWNUV3YB1+3P4+FuJQMaxrI4Zoi9U8ER4YMU40zfpJYlOgdz0cTjH0zyc1KoExAVpSZigw3DQQPVhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEU29OK5kWpejl0sv4tAguvNQqeJLIBZ7GHROwsXNlE=;
 b=VO1Njf4TB5O147JCfiM/xeo5xS7YwIW+Coc/gags7HMc5We++tYJ9XzSoucCCJXJIg9/q7tLC9RwK7OeBad124Th2+3zaTXTnlk3i4NsCczcXPaHvSIA/kO/SjknGjLVVV8VLQn7uxQccO7o9UyPfvn5lxgCpIP/870cKDgY9sxuoywR3Y0sulwFX3V+p53bAGadN19sWvsA9mjs3xQDz68PwmE3O6IPVV+rmpTUXgRp0WohULfGKKGizA1cji30lBgB9HdMqnZpZxO61PnrgWdDL+Ufot4j6UQ28t2R2W18mXKfvFV9Kp2Fj+LGZwB/xvZzcJFZgw4esMGcWtDnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEU29OK5kWpejl0sv4tAguvNQqeJLIBZ7GHROwsXNlE=;
 b=e/LjSGGN4UhCB4g/KYb827E8ePC5JtQd0gApqGJ06GeQ85h+cOegGeovIJRnOT+rThMuaPJ2S/KVYmXo2Ytuq/dz9oV1ca+e+MhkVukdMxgZVw5brWRPqf3KBVEWIZMIzxcwoCDYYejNU9A3KhyiWHswgq47JUOLtS6FMUqhVbU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 17:22:56 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:22:56 +0000
Subject: Re: [PATCH v7 01/47] block: Add child access functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-2-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <7f6e56bb-9af6-3ef4-c881-1ef1017ab011@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:22:52 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0124.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::41) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR10CA0124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Wed, 8 Jul 2020 17:22:55 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffd54d07-c918-4d92-0d29-08d823638db6
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2984DE63743FCB224D82B805F4670@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZoUhS2tiQxA9VRRZHcAZN1wmyFWQV8/G0peyW3Et4GwI04BFXa81QR6f/TqorDVsovwZnhJVJS1ywknJ4rlDXhUY60J4yIEVPuoB5XCO3FCilN13L9hm5pe7PF2iZomyKVwGmc7q8vb6z8JE7QJWHSMtIIpWDw8CIk+38L1yhNyEmSjGPNEEGn/m63MRnAwYiATqRVqPW5pJ3aBBX8YWge/Of3z0CpY80qRg+mm4BrOqvhopN80Eurjt/v8vIN/qYovBgnI4+xWHCcWzokQfWieo0FPahN/6IHtIheC30TzEbZ+VPf2C9om3whH/zzUz5X14dFH/dj6L5Ia36kmgWvJSGJqcqZJ98u+l7Qelrs3/cdhBSwa/WUhucmEHCr+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39840400004)(8676002)(16526019)(956004)(316002)(6512007)(2616005)(8936002)(54906003)(26005)(186003)(44832011)(31686004)(2906002)(53546011)(478600001)(4326008)(5660300002)(66556008)(52116002)(6486002)(83380400001)(86362001)(66476007)(66946007)(6506007)(31696002)(6666004)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1GLUd/jeNFO7mSD1Zkd1cfQzl1HmqJlCAcCfLjcxB7ufWhA5VciIj4ZW6SomHo5r8giqRbMLz8CqNap5XHFjIaoj3/aZASR/E6jaBTV2vax0WNgdmBcBzz74/hSpiESTzFR6eKzw3p2ZajTeXtn2qFm8Q4Vxbjk0FznJ+/ghBRBbs7G8NYB1D7f9hMyiWpvxq0Rki3qSkJyDxbsrU/C1gofKRT4rQv9j0EUpvQC1TW56BO60SHf/V5vvY0tnukazzde1duQD/ZBKDG3h7uM6cX+I5syQlcr35i9DiWAYbJJRpGciILVblTFQFq/D0c986NVyV916acGqfKwDEA3AZ/rbXwfiVHstD4A8OAtlbzYStWkYswzEuB6oOwUyCwnWAV7iw60/cXN/1T948oW8gKzsnnriDGGxz14APOjBQfBmRFH+AlgcdJU0oq9WtOREkBFqsKaGdtDqyO34wpy7K1R10gHoakEfN7Tq1Gs/3zVPqvUMYh1SC1XvD8BnZ7r4
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd54d07-c918-4d92-0d29-08d823638db6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:22:56.3485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDrDbA8bv+8mz8awJxvph4dVseNqcAP5J/lv8JmkS++quYN2yYbyUuk5yeQRZAtH82RNjtb5XU5pSyKi/ee0qXwO4dkak0wdbMA44S5rF0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.20.103;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:22:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 25.06.2020 18:21, Max Reitz wrote:
> There are BDS children that the general block layer code can access,
> namely bs->file and bs->backing.  Since the introduction of filters and
> external data files, their meaning is not quite clear.  bs->backing can
> be a COW source, or it can be a filtered child; bs->file can be a
> filtered child, it can be data and metadata storage, or it can be just
> metadata storage.
>
> This overloading really is not helpful.  This patch adds functions that
> retrieve the correct child for each exact purpose.  Later patches in
> this series will make use of them.  Doing so will allow us to handle
> filter nodes in a meaningful way.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block_int.h | 44 +++++++++++++++++--
>   block.c                   | 90 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 131 insertions(+), 3 deletions(-)
>
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 1b86b59af1..bb3457c5e8 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -90,9 +90,17 @@ struct BlockDriver {
>       int instance_size;
>   
> ...


Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>



Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCFC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2691F21D92
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nj6NkKr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2691F21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgty-0005Ft-Uy
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGgsn-0004QO-Qa; Fri, 11 Sep 2020 07:06:22 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com
 ([40.107.5.133]:17705 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kGgsk-00067y-HP; Fri, 11 Sep 2020 07:06:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8DS67b6/VEqn/m6M1GEtyDJNs6W2SKfBSCSTzhBRGowQUOJpc7Al3k+OeuQ5IzX6uICHkKEcQzB25iFUeFF+J9429lToA5IIBdR95oqeSuw9HKey9k3yVqovEjfFdK5TTlQ0u2hGq1wq1ec6QiEJ6QJOXzAoszMiBc7h8qx0zcm9jp4sQdYFFkPfBQ452QVMtKky+tIn1eGU4Ph2/mPNoU6dMKHgq0kFTcsGyKdJq/8d98HAVW7ecEjZEw7wuVbvdbvo1X1zrXdv/fuCt7HVrhiR2dBHGtObDYqJXyDKOZ95HGtLiP3RsYiHZIL733uefI7ZChdV1rjjuGiaLu3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brrAeRiV4OB3M9tj+EY179g9ofXb8bKF7v1WDzA1Kbs=;
 b=e3oVCNf4ZAae6CaH0vm2uTb6gG7ZNoBqFsWyNysPyZlZNXx7T5uo33NQnD6jf/DOWK6hD4pXIUYXHHl7xKctc1dFS5rWKmpev84OwfIJpiYiWRwMkGcYhk+xS+ZIVZfVz5Wr69LAZVJN5fwsVmoJzifEP+jBnPXRDrNxgiMrBXMgO4K/GdJWo8bf3x8JI9dys6vNjta8ksimYpN5iSF/MmMI28y5EIWyVZlb5GSPub3HOR7+FocyBadNN7WXv245vYgVxh0fdVvmukXBWLwjhid2QowpQ8sukoT/wEns2KHXECWShmYF/hYuOjOdB0LpmAPUq2NybAYDh01xSaJ5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brrAeRiV4OB3M9tj+EY179g9ofXb8bKF7v1WDzA1Kbs=;
 b=nj6NkKr9moAP0+su3/rqs2Pu2uKm07Hme0rkukxsAhhSCf6XEOPoSuHTWRns25PoPtsFGKjmUB+/OZxpy1QVXkcykp0HTNirWjPv1RythCqUXLP1sbZuyGienfIc6/8azf7Mrj4D4C8z/0nsbTKDCgc+olyINBi/XS77mrQ4q/s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3223.eurprd08.prod.outlook.com (2603:10a6:209:4d::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 11:06:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 11:06:12 +0000
Subject: Re: [PATCH v3 2/2] qcow2: Skip copy-on-write when allocating a zero
 cluster
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <cover.1599759873.git.berto@igalia.com>
 <0350dd55702eacd701e0aea924b101db7448a517.1599759873.git.berto@igalia.com>
 <7f0ae868-07ca-2267-eb27-2787ff86e801@virtuozzo.com>
 <w51blichbne.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5642b34f-cc33-f7c5-2070-a7285b9e0acf@virtuozzo.com>
Date: Fri, 11 Sep 2020 14:06:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <w51blichbne.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.150) by
 AM0PR10CA0057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 11:06:11 +0000
X-Originating-IP: [185.215.60.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a80950bf-746e-4516-a821-08d85642b196
X-MS-TrafficTypeDiagnostic: AM6PR08MB3223:
X-Microsoft-Antispam-PRVS: <AM6PR08MB32237EB2A356A4C14E4F7C8DC1240@AM6PR08MB3223.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31kWNgFyEyDKczjxG0cl2yY9O+cfPG8VaL8uH3u+KlX2K085+QQIAXwUY+X2P5Fd2FxY0FCUdrSg3wBOJCa9k+IYYpyxyVE2lVnv5Uo7SbiFU52Awje2WSb829r1fq0XxP77cHSszY4oXobsrmrGXnIl1S4wBgZtcHHysnm7eJFsfiwkbPf8Bxms5zV/3w57h1G9weQ2vYOEsF/YiCrQa8Z8f9Zq7glTaJeQ8QZA+3R3gC2j396Uig8ugdGFtuGzKxp5BwjeSn85C6c9DMwi9LrcGe2SSkx5iaSXtB4CQtJpT6sjmp/Mafsbm+KSH4Okh8j0OTO5pzZ8zk3AerHK0Sjar8pORYIMuPjdQyij4r3OlpLu3vuKlnRLmXwt3pdy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39840400004)(346002)(136003)(396003)(366004)(478600001)(31686004)(66946007)(8936002)(16526019)(316002)(66556008)(66476007)(16576012)(6486002)(186003)(4326008)(36756003)(26005)(83380400001)(52116002)(86362001)(54906003)(2906002)(8676002)(31696002)(6666004)(5660300002)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TJD18AY+vsve5g0fcTlbJuFYgTNq90ef90Ww6e4ww1c0AENH3WHmlBX1k6QzG75Axka1ishQ89upT9oNdgzYFjPAwY7Y9hn9jl3E91fjRtvl/o/r/kKsRSm+fB+ryK2lc8WjMYKHJv8UA1FFZwrljaki3vDo2Qr0G86UjW8zGBaY/vBY1BFyjxzYog5mgplpPQNHL3bAAzhBJThR37RRBxrTud0iep3qUix+SjTDISIr3+j8Dvk82wTuH0V6U1xHVw5qw/pu05y2NSlgONEE723K32xhzcr8BJg8xBB4jgOJztqg7D8La4hOSVvJVxI8fDzdZxbAT0egxIclf6BlabpwbK9fffwLb6uXaW7ZXByaTAz7CIXBmFCJWvnP13IdCK146V1/TG3jduSy3Kymnk7Ea5mrw37jnvbwLCmgnsdtqkjootl/9f/UEYEnJ0i5jZiW10d5w7pzRJU2WvTHrdF4dgsICgUi1IbfJGSRc248LBaVzYuClzRhzmTDphIvv/MfqgpsgPVagLNrlBxBoB8yTrLholVuGPXEorFJLIJZx/LM7tXKUW6MVpywlGV7JLuqSTavtBm5ynCBpoflHHxPZd0apKD+hMBK5VFu+3iG9+ex2N7AXya7ueceMdUC8IlXC84Ns7vo9usXSzWo/g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80950bf-746e-4516-a821-08d85642b196
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 11:06:12.1689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PQePRl1x9AxWmeotVi0GcTHI+biSUVyw2ArmOYYuzc6heLK4MeHvEDKghSYU/1+uloGJYPD2rTFgEslLAWmRi7YQJpHit6AL8jBqWCXYpHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3223
Received-SPF: pass client-ip=40.107.5.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 07:06:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.09.2020 13:04, Alberto Garcia wrote:
> On Fri 11 Sep 2020 11:34:37 AM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>> -        if (!is_zero_cow(bs, m)) {
>>> +        ret = is_zero_cow(bs, m);
>>> +        if (ret < 0) {
>>> +            return ret;
>>
>> It's a common practice to treat block-status errors as "unknown"
>> status and not error-out immediately:
>>
>>    - really, it's not critical, we can continue assuming non-zero
>>    - if there are real problems with IO, we'll most probably fail on
>>    real read or write operation, and report its status, which seems
>>    better for user than block-status error
> 
> But what's the problem exactly, does this complicate the code too much?
> :-?

Of course not :) Hmm. OK, I don't know, I'm just used to this practice in block jobs. Patch is correct as is:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> 
>> So, I'd keep existing logic in handle_alloc_space(). And, if you agree
>> and resend, probably good to split this patch into two, one for
>> block.h/io.c and one for qcow2.c (still, I'm OK with it as one patch).
> 
> Sure, I can split the patch if I have to resend it.
> 
> Berto
> 


-- 
Best regards,
Vladimir


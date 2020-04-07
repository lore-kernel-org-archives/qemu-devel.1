Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF4CC2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA6720731
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yix9GWqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA6720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLl3h-0005Rw-2X
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLl2C-0004Z1-WF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jLl2A-0003Wn-5V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:00:43 -0400
Received: from mail-vi1eur05on2128.outbound.protection.outlook.com
 ([40.107.21.128]:1915 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jLl29-0003SI-H4; Tue, 07 Apr 2020 06:00:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UM6UUKC0oi/FgnsACIuJfkkb0Tnzn0sWuRqBuqU/AhH27yP17jvHSE4yS9Smk9gZxjEaCVgFO5EAIKbjHRGPbmuZ4Rlj9sYBBRtqNJZqwv/fxLdAlQt7aBLFZ0EHX+hvDMgpNuzy5VwiCxCAV8N3tIp1NFPF4iccthcuGTGzoLCPLHmSBuCTim9lcLhzHGc1RixVgcmooJvsdcae7F0CScoER1Tw3hvFousEAein/0edwPmPefHYfCcqLdvW1EPRBWknvMYJxc6tXAOVxMV2zo/wmpOdXxVNHWfWf8S7zkH2eA0ph2WtG3As4mEZcRwNYYMx751vb9Xe8THIJjkUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEdmTurBAtc5KsCbNX8sYK7BcMqWpd+GJ/8HwJlvtDM=;
 b=nd5lsLKLHxSjmVuj8t1GUA0EWWiABO14dQHqD357cmy4KFgBWY6IvByqN0EiE562ypq4QWviUM+VInNpIjhYNMJx/5lkr1IygMY0NJwIFJufIgdiSUVvnrXoN4+/m61XxZ/sX2oF1GYxK2nxD4SCGgr5jgUkZRx1sT/JXFgjxui5M5iZm74AjMZnBQ68tBEtS8lhyfdVBJ9dGTcebZA2pUUJOcDp6VqtstzW2ZZDMJrXM7W4GWvdNAbanqi4flHqC5DymcIBqbThKCog4ErH2rvRSY1+hcY2SQppt8HiB/jrREtIiOyZlw+jc2zpuROliF2RVSU2ahy976ensTuzoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEdmTurBAtc5KsCbNX8sYK7BcMqWpd+GJ/8HwJlvtDM=;
 b=Yix9GWqWryYX1jDfpxaj71ZJuDVaAX7WEgEblOIslSrwnlKH8w8Pm3WiQQT19XB7Hmy5is/OiWga1oseqlfkt0sjIIpYd53XIYM2nEFRo2qnIjfx5BSXq+V5NPZCrQTJSPQe9yDndnLK4EF5xbA2CgzJOXIHh7d5XyYK15bW5JU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5399.eurprd08.prod.outlook.com (10.141.172.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 10:00:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 10:00:38 +0000
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for coroutine
 interfaces
To: Kevin Wolf <kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
 <9d0aa9cc-61a1-fd14-357e-6fb0ba2742dd@virtuozzo.com>
 <20200407085216.GA7695@linux.fritz.box>
 <b1a2cb59-7969-5bb7-f5ce-ec4ab51199cb@virtuozzo.com>
 <20200407094814.GC7695@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200407130036397
Message-ID: <18511cc4-158a-a998-c30a-fbb402af48a5@virtuozzo.com>
Date: Tue, 7 Apr 2020 13:00:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200407094814.GC7695@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.160) by
 AM6PR04CA0056.eurprd04.prod.outlook.com (2603:10a6:20b:f0::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.16 via Frontend Transport; Tue, 7 Apr 2020 10:00:37 +0000
X-Tagtoolbar-Keys: D20200407130036397
X-Originating-IP: [185.215.60.160]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ccceb15-2732-4aca-2a0c-08d7dada85f0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399BE6A6373772C11D545BBC1C30@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(396003)(136003)(366004)(346002)(376002)(81156014)(31696002)(2616005)(16526019)(186003)(16576012)(66946007)(66556008)(4326008)(6916009)(5660300002)(66476007)(86362001)(956004)(6486002)(81166006)(31686004)(8936002)(2906002)(316002)(8676002)(26005)(478600001)(36756003)(52116002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51YL+Mjnd5kuqieVwA9xznlqQW5MUdq9Y5SR4Q0H5lyC2bpqqPDgtR5/zrRr8cO7bYbEUK/5VRDFLsT1iiH/2hXeov37NyrXnw/nylTtrNQfqP5CsqH1CvWA1I7wVyeUWAdoA4ofJQKfJGQhLgmtr3HHqXQcnfam7QTS0e8KXSkjtWUzwo8qvcx90XI7q3QDqfWDYUeMnLwQMF2WHi+8OPy51sdJ1raoaO/2fYzQmbJKt9pAHBCSz9Bn51hb/Cz+FZ5gk+yF84S9i9aI6vG6TM1XxoKNXBvOpDCKCT2OwA1jgOYKp5nYnA8VQemXYecx130YUu47B0ZbnUjKCwgfk+/2zRXh/qcehf/Lb7Wzh0rk1dnmFcqt1rYLujqSBu8hZqSDaH/WBOKsKVD87BoawwLRzu5BlCRbXC4z9yM2yw85AdA8rzjvj2rL3nV7eSkF
X-MS-Exchange-AntiSpam-MessageData: zy/C02r2jqtXb147thS54dPe+IK6h3N3CXegKhCdCEkOkUhYQMdLfbvj2cYx9EPHUKHtizsYSyDtHT0MCHodbtEbmtzMRQdxcyV96ovAaJrkXQ8M+vUvNyi29PNJ+kbepaUbgZFkg6HsJEAtLwrcDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccceb15-2732-4aca-2a0c-08d7dada85f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 10:00:38.2343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOQw4WMHettGepqMxPq/4N6DPsiXaQJPX7tsZFyZT7oI7vqNJRZKWb/AjWVdOcvhbKhRVdlTw9GLu2mqc7cqagqcpnn5ruOlnnszfa9MuIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.128
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

07.04.2020 12:48, Kevin Wolf wrote:
> Am 07.04.2020 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 07.04.2020 11:52, Kevin Wolf wrote:
>>> Am 07.04.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 06.04.2020 20:14, Kevin Wolf wrote:
>>>>> External callers of blk_co_*() don't currently increase the
>>>>> BlockBackend.in_flight counter, but calls from blk_aio_*() do, so there
>>>>> is an inconsistency whether the counter has been increased or not.
>>>>>
>>>>> This patch moves the actual operations to static functions that can
>>>>> later know they will always be called with in_flight increased exactly
>>>>> once, even for external callers using the blk_co_*() coroutine
>>>>> interfaces.
>>>>>
>>>>> If the public blk_co_*() interface is unused, remove it.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>
>>>>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> Still, did you consider instead just move inc/dec to _co_ functions, like
>>>> [...]
>>>> (and same for write, ioctl, flush, discard). It seems more
>>>> consistent.. Should it work?
>>>
>>> No, it would be wrong because it would be too late. The main purpose of
>>> blk_inc_in_flight() is to keep the request covered during the first and
>>> the last phase outside of blk_co_*(), which can potentially involve BHs
>>> like blk_aio_complete_bh().
>>
>> OK, thanks, I see now, we want to caver possible completion BH.
>> Hmm, not too late but too early (for decrement).. As nothing interesting
>> happening between increment in blk_aio_prwv and entering the coroutine with
>> _do_ function.
> 
> Basically it covers everything that isn't yet covered by
> bdrv_inc/dec_in_flight() on the node level, but completion is probably
> the most important part.
> 
> Start, too, because actually something very interesting is happening
> between blk_aio_prwv() and blk_do_*(): It uses bdrv_coroutine_enter(),
> which in some circumstances may end up only scheduling the coroutine
> instead of immediately entering it.
> 

I missed this fact, I thought bdrv_coroutine_enter is simpler. OK, thanks. You answered my question in next too.


-- 
Best regards,
Vladimir


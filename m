Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282D0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D0E2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SO5PxF4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D0E2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyF6P-0000qC-4J
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyF5i-00007j-NK; Wed, 22 Jul 2020 09:47:26 -0400
Received: from mail-eopbgr10094.outbound.protection.outlook.com
 ([40.107.1.94]:5079 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyF5f-00045h-Ur; Wed, 22 Jul 2020 09:47:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fld9eMKcIxZj9O4B3X9H1yR1zL1qSgfvPRM1sVT8aoWPQNqKx9FsfESoFdqNm6L6I7+KT9H1KeAD9v0LaC36Q6Ndrj1HlnccauuEE8U7plFn257EbubRxICimskSuGS9KnHuFtpMhgEUijlZm5CIi79vOUIkGf1qSyxcIbhRqlwVqlkOihjPYBT8ryWX8fTaRWPNpYbz/jKUHn38tcBuXDAaMd1q+D3y0Di+0plUeGxmc9cNncTEeViEs0d1ZGFvcn77VhdI5C2K/cqmoXizsNLbs5MZ5R+Ij1OhFT6pc8L1osO8/3JcdCagxuvu3U/R0JyxwuWdSlZ16c1ok4o+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mNs4bq+CrMybbYkRD2Tn+lYt+e45bTqGJ+uIfI3aCM=;
 b=I55qyvX3aQK56eAndHr6JONfDm+S3FBWVcQ5xAGjOr3DnwWvQU8fVRG3zIMqUSMMd5q4MujbKlAXsFmGN4ez9Fm4C6Ueb9cLsSTZ7XFiONKvMkRn6cpISlzXEeOlQMOYQyAaoPMtKw182sD17VxtJXpwvsVp0VeAPDlNbI6svMTzbcYNyDqDN2oZfDivL4nV/h2AtXDa5cAsmvpFqSU6zOBPtAmchjWLWf6kHxDiTI8tgwBBdaQiZNW769pnkOxdaggj3Jxw6dP/5FbU5q8G6V8OfJpnVJzmUDNMciTBf2BtAXkNflk56OP4AZU/HrAHfYKyYLCfTDlgRfOtiKpnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mNs4bq+CrMybbYkRD2Tn+lYt+e45bTqGJ+uIfI3aCM=;
 b=SO5PxF4r/prcAXKXriDywtdVOW5+PUPeYmiWy3HtBGAQuUrxaZ67aHVUeLeh7Rqu/8BOhzJARUZ9A+JPQV7RShrm4t3hIK835oztO0J34Yn96xGNMgO59VIMFkIQ+Sg5avEW7SliJaDxQT4bTptjRDCuWAOHDSNHuSGADJJ+tac=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5333.eurprd08.prod.outlook.com (2603:10a6:20b:104::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Wed, 22 Jul
 2020 13:47:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 13:47:20 +0000
Subject: Re: [PATCH 3/4] io/channel-socket: implement non-blocking connect
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
 <20200720180715.10521-4-vsementsov@virtuozzo.com>
 <20200720182923.GP643836@redhat.com>
 <840b762e-1ce1-af25-2ea0-b8cfdedba0d4@virtuozzo.com>
 <20200722112104.GC2324845@redhat.com>
 <cd5058fe-20d4-615e-8489-a30ac54d57de@virtuozzo.com>
 <20200722125303.GI2324845@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <71bd9b95-6db6-bfaa-729e-df9d1493e5b7@virtuozzo.com>
Date: Wed, 22 Jul 2020 16:47:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722125303.GI2324845@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.154) by
 AM0PR04CA0093.eurprd04.prod.outlook.com (2603:10a6:208:be::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Wed, 22 Jul 2020 13:47:20 +0000
X-Originating-IP: [185.215.60.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9384d958-a5e6-4a0e-94fd-08d82e45c15c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB533387EE48D9020F7719C694C1790@AM7PR08MB5333.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3y8Y+zKmP7E4yHDbs1We6gi94CFEpE0/GbSBWL612J1kS8XzVKndinZLQ41Y0SrqXc14ouoN3b2XqYMY4t+ElcUMVBAvKauUYcxQOebRHAj//2QMBCBXWL6MQJ5ibziO8osb+YIgxvjCV12xiiTLpEF+v4EZs0+NG4P2vpR18AXeDJnkMiqBkPdR782QHzYvDl342vdAXbHMuE0vBBLJnpLPCIj9PZnDbccCZh2+4cy4AuN40LgQfOGTWdzv+f6ZXDsBC2NPrfugNLiDR2jXgJnX+WgRBuQopNDGyTqovHoCXZERtYBcQHeOAPGdHJDUhfTW/3uBfCe0/je82RnR28l/amyxpUH7OB6KYc+tjwdFurJ79m4aJ8j0w1eXmEx0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39840400004)(6486002)(478600001)(52116002)(956004)(2616005)(36756003)(4326008)(83380400001)(6916009)(31686004)(26005)(66946007)(66556008)(66476007)(107886003)(8936002)(186003)(16526019)(5660300002)(8676002)(31696002)(316002)(16576012)(86362001)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZnHpRah7N+poy8jNXey4tvwztJ89rUwIpd3ZKbwXzHHgCcFkLvV59Bop2A8/x6oQbtDjcaxNRWHLaXh4NvG5jpI8VsrV6mDZxUO9520gkvWypnSLAMNzmtZ8daWV6OLPdBNFxt8l6WhdvfPW5xqtq8wu6s2INsxkcQyLQ2EBKWpp19JfhDpIhgXb6Bw/f8Jll+in+ipqY6YR0/qKtFGGX6vA0rdVkgl/lCofeILjLZsLIBlBzcbCEuIP+QTM67QwR/DesoaiPlFZ5Q3YFNbP5hJOkWqWiXw+G0ge84atDOsA9+ncXivcB/pNzh/kFHt7FwsuvKS5Td7s7ErQFTm6mOvz9Y8NZCvj7cAONMaX4r0uijO1ufhWhVAmWi3EWBxjdw9ua6e20bq8wg9Ur8Fg/jt6apwGqc04r7r2p5KiAk25UXtFgscX8NCwpmceEn7EfiMevwERAgTBktsJWtlWbP3uprtHaY17iHLgsufJlpwc3wNAp6vPg2Sf8FAPBwfy
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9384d958-a5e6-4a0e-94fd-08d82e45c15c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 13:47:20.6687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxLvE8Sd7XQpn3MXMl4678lB15D1U5Qktxp8JaOXwj09Gs7TkGwzIWe9I+zmXeGLM+9y3tRuSu0NpJ8XKVEf/Ega8rl+et7Bg0FzBS1sWxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5333
Received-SPF: pass client-ip=40.107.1.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 09:47:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.07.2020 15:53, Daniel P. Berrangé wrote:
> On Wed, Jul 22, 2020 at 03:43:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 22.07.2020 14:21, Daniel P. Berrangé wrote:
>>> On Wed, Jul 22, 2020 at 02:00:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> 20.07.2020 21:29, Daniel P. Berrangé wrote:
>>>>> On Mon, Jul 20, 2020 at 09:07:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Utilize new socket API to make a non-blocking connect for inet sockets.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>> ---
>>>>>>     include/io/channel-socket.h | 14 +++++++
>>>>>>     io/channel-socket.c         | 74 +++++++++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 88 insertions(+)
>>>>>>
>>>>>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>>>>>> index 777ff5954e..82e868bc02 100644
>>>>>> --- a/include/io/channel-socket.h
>>>>>> +++ b/include/io/channel-socket.h
>>>>>> @@ -94,6 +94,20 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>>>>>                                         SocketAddress *addr,
>>>>>>                                         Error **errp);
>>>>>> +/**
>>>>>> + * qio_channel_socket_connect_non_blocking_sync:
>>>>>> + * @ioc: the socket channel object
>>>>>> + * @addr: the address to connect to
>>>>>> + * @errp: pointer to a NULL-initialized error object
>>>>>> + *
>>>>>> + * Attempt to connect to the address @addr using non-blocking mode of
>>>>>> + * the socket. Function is synchronous, but being called from
>>>>>> + * coroutine context will yield during connect operation.
>>>>>> + */
>>>>>> +int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
>>>>>> +                                                 SocketAddress *addr,
>>>>>> +                                                 Error **errp);
>>>>>> +
>>>>>>     /**
>>>>>>      * qio_channel_socket_connect_async:
>>>>>>      * @ioc: the socket channel object
>>>>>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>>>>>> index e1b4667087..076de7578a 100644
>>>>>> --- a/io/channel-socket.c
>>>>>> +++ b/io/channel-socket.c
>>>>>> @@ -22,6 +22,7 @@
>>>>>>     #include "qapi/error.h"
>>>>>>     #include "qapi/qapi-visit-sockets.h"
>>>>>>     #include "qemu/module.h"
>>>>>> +#include "qemu/sockets.h"
>>>>>>     #include "io/channel-socket.h"
>>>>>>     #include "io/channel-watch.h"
>>>>>>     #include "trace.h"
>>>>>> @@ -29,6 +30,8 @@
>>>>>>     #define SOCKET_MAX_FDS 16
>>>>>> +static int qio_channel_socket_close(QIOChannel *ioc, Error **errp);
>>>>>> +
>>>>>>     SocketAddress *
>>>>>>     qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>>>>>                                          Error **errp)
>>>>>> @@ -157,6 +160,77 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>>>>>         return 0;
>>>>>>     }
>>>>>> +static int qio_channel_inet_connect_non_blocking_sync(QIOChannelSocket *ioc,
>>>>>> +        InetSocketAddress *addr, Error **errp)
>>>>>> +{
>>>>>> +    Error *local_err = NULL;
>>>>>> +    struct addrinfo *infos, *info;
>>>>>> +    int sock = -1;
>>>>>> +
>>>>>> +    infos = inet_parse_connect_saddr(addr, errp);
>>>>>> +    if (!infos) {
>>>>>> +        return -1;
>>>>>> +    }
>>>>>
>>>>> This call is blocking since it calls getaddrinfo whose design
>>>>> offers no ability todo non-blocking DNS lookups. Given this
>>>>> call, ...
>>>>
>>>> Oh, that's bad, thanks for taking a look on that early stage!
>>>>
>>>>>
>>>>>> +
>>>>>> +    for (info = infos; info != NULL; info = info->ai_next) {
>>>>>> +        bool in_progress;
>>>>>> +
>>>>>> +        error_free(local_err);
>>>>>> +        local_err = NULL;
>>>>>> +
>>>>>> +        sock = inet_connect_addr(addr, info, false, &in_progress, &local_err);
>>>>>> +        if (sock < 0) {
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        if (qio_channel_socket_set_fd(ioc, sock, &local_err) < 0) {
>>>>>> +            close(sock);
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        if (in_progress) {
>>>>>> +            if (qemu_in_coroutine()) {
>>>>>> +                qio_channel_yield(QIO_CHANNEL(ioc), G_IO_OUT);
>>>>>> +            } else {
>>>>>> +                qio_channel_wait(QIO_CHANNEL(ioc), G_IO_OUT);
>>>>>> +            }
>>>>>
>>>>> ...this is offering false assurances of being non-blocking.
>>>>>
>>>>> If we don't want the current thread to be blocked then we
>>>>> need to be using the existing qio_channel_socket_connect_async
>>>>> method or similar. It uses a throw away background thread to
>>>>> run the connection attempt, and then reports completion back
>>>>> later, thus avoiding the getaddrinfo design flaw for the callers.
>>>>>
>>>>> I explicitly didn't want to add an method like the impl in this
>>>>> patch, because getaddrinfo dooms it and we already had bugs in
>>>>> the pre-QIOChannel code where QEMU thought it was non-blocking
>>>>> but wasn't due to getaddrinfo lookups.
>>>>>
>>>>>
>>>>> IIUC, the main appeal of this method is that the non-blocking
>>>>> nature is hidden from the caller who can continue to treat it
>>>>> as a synchronous call and have the coroutine magic happen in
>>>>> behind the scenes.
>>>>>
>>>>> IOW, What's needed is a simple way to run the operation in a
>>>>> thread, and sleep for completion while having the coroutine
>>>>> yield.
>>>>>
>>>>> I think this could likely be achieved with QIOTask with an
>>>>> alternate impl of the qio_task_wait_thread() method that is
>>>>> friendly to coroutines instead of being based on pthread
>>>>> condition variable waits.
>>>>
>>>> The most simple thing is just run qio_channel_socket_connect_sync in
>>>> a thread with help of thread_pool_submit_co() which is coroutine-friendly.
>>>> And this don't need any changes in io/channel.
>>>>
>>>> Actually, I've started with such design, but decided that better use
>>>> non-blocking connect to not deal with cancelling the connecting thread
>>>> on shutdown.
>>>>
>>>> I think, I'll resend based on thread_pool_submit_co().
>>>>
>>>> ===
>>>>
>>>> Hmm, there is async getaddrinfo_a function.. What do you think of it?
>>>
>>> It isn't portable, glibc only.
>>>
>>>> But seems simpler to use a thread than move to async interfaces everywhere.
>>>
>>>
>>
>> Hmm.. Still, on shutdown, how to cancel this connect and getaddrinfo ? I'm not sure
>> how much time may getaddrinfo take, but connect can take about a minute. It's not really
>> good to wait for it on shutdown.
> 
> The intention was that if you don't want to carry on waiting for the
> async operation to complete you just give and pretend it no longer
> exists. Eventually it will fail or complete and the thread will exit.
> The only important thing there is making sure that the callback you
> are passing to the _async() method can cope with the cleanup when the
> work eventually completes, even if you've given up.
> 

At least it's not possible with thread_pool_submit_co as I wanted, because underlying
thread pool waits for all its threads to complete on exit.


-- 
Best regards,
Vladimir


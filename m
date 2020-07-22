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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D90C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE7F20657
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EYIKVRBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE7F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyELV-0006Xa-8w
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyEKu-0005yX-7n; Wed, 22 Jul 2020 08:59:04 -0400
Received: from mail-am6eur05on2101.outbound.protection.outlook.com
 ([40.107.22.101]:1935 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyEKr-0005Gz-Dc; Wed, 22 Jul 2020 08:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1tK4IuHkD5pql+r0ClxQF+KY042dyAdmzoLdQPAiW1b6b9qI2rIpzEy/LqHDE56BOOC0OkStuxduyODlbMXEpBOmo01fofyaHD9bnrDrVsI4ug1/YKs8aSss6TLfSpwM+pa+3/yTqmGPS+EE1mLzU1rhR5cBM/iA9LhfjCCkUzxovKkyBDw+Jb4Aq5C2wi0Iw7vUNDWmGYUjkzo+ZXeH0++QLEwVHifMCBjijNoNcjnoBrXolAstgp+INLPFN2Hmb1NCHf+UTmLgKAFCZtQnkC2jKb00cTTv9ojVVvTMq1uPp/ip+NERv71fs2cw90/d2n7cnS02MzE3rS/jkjRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7KqEtm8HSsvWYyfdu4EQRp1e7c8TzPTZeAWJW2uEfo=;
 b=JuAU4qYbdRQB0eHbB52xwSxBTG1PS0hM3j6tPeN0UCa5ItRvyW1L4AhhaiEI97OE62npra5SoOK/pJFqGebcdm+IcDR7d/DFHZJZQB87im52vE0v2cT6Tg14+5aUWFheXvWwSAdiQdsB7PfnKcaXQd/4s0EXqT1YMRr5JBeM5hHN0v3D/7Hl8oKRbqJVsr0UL3g4HckDyFguneV/0xeJku+y1t1th6PBhHjHdVnJe939BkqqQ/cCPGMz3DBavBJPMogaMesV56oIyh9qAH64P9htnQf21ggpPXikopcKfkt5mOIUePyTQJ1hP/0PJ6i9S3Pk6nFr3kbTmR5BLYQrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7KqEtm8HSsvWYyfdu4EQRp1e7c8TzPTZeAWJW2uEfo=;
 b=EYIKVRBhgawWBhX9sY9jxgl9DYdgmkWRJvzXGtz7T7TI2geJGJoCxzg7tLwNloWkM+/zNPAecveFUIon5RfsLbtOKQw3XrIP5e9QiM9zZ1wZrr+m5Ft2Jt6CjE1azwjaXcOu0ZIPdRuCQybPaDVFwsHm10p5hw077qOP9A22okw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3030.eurprd08.prod.outlook.com (2603:10a6:209:46::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 12:43:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 12:43:56 +0000
Subject: Re: [PATCH 3/4] io/channel-socket: implement non-blocking connect
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
 <20200720180715.10521-4-vsementsov@virtuozzo.com>
 <20200720182923.GP643836@redhat.com>
 <840b762e-1ce1-af25-2ea0-b8cfdedba0d4@virtuozzo.com>
 <20200722112104.GC2324845@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cd5058fe-20d4-615e-8489-a30ac54d57de@virtuozzo.com>
Date: Wed, 22 Jul 2020 15:43:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722112104.GC2324845@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.154) by
 AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Wed, 22 Jul 2020 12:43:55 +0000
X-Originating-IP: [185.215.60.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4bef065-8d25-4d07-c2ee-08d82e3ce5de
X-MS-TrafficTypeDiagnostic: AM6PR08MB3030:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3030E6D511EFD0960E960B6AC1790@AM6PR08MB3030.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xERIiecIOy4h3lX2Xgrmxd7+GZWvwXhTDjawwFN+TR8qHjJ3OeQQJSbCde4lXoaMlVGdABaOaD0AXhiYq74euAd9+wL5ZypJM9pbifv55KG4PttPbeOANJ/+qsVMMPolR6LZEM7VeUMXnBKFm9eSJPBZIdOrhIdgMlnn5RkMYmDV6pP1tQkJXaksz7HIpKGbt44EwohuLfv0sangyZGE2/EEiXjSt4n6BYk++AXrQSwBn9BFE8/bFxJhpI4gyytILtbNO2tsG8UGlRGugoT/kTxS4vDqeNYrBdN6dxaU3cDTSEihXuK/sELvzx9viOxcJ/MU7K9MB0SlIDLqIrtwUHZa+y0ov0Cn9q27yuNS9GtQWL6LD9GylftgL1vQ4uB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(376002)(136003)(39840400004)(346002)(107886003)(956004)(26005)(31696002)(316002)(16576012)(2616005)(8936002)(86362001)(2906002)(5660300002)(4326008)(66556008)(6486002)(478600001)(6916009)(36756003)(8676002)(31686004)(186003)(16526019)(66946007)(66476007)(83380400001)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: O5G1tk+N5BhR55IqS/sJIU/hBSnawxo6tMD5AmtUIZ+MuEQ27B8NSenLeWE/wnMyA9PQbhcvCg3xhCJ7J3dYT3T6zx6pOkCFosaFsrhKX+P1g5DfjcqjXrZS67dqSj0+wrIRPoFO9OyH5tcjXS9LEBO6d6MpYx1ftQcFcnaTVdvJLFJJzdvrcRvvGAZtoz4fn78cVTf830k8VML9FQ4Pq7lNdfXUNiEf+xDLKmrZejn6cdioYb/axGkikbf+nwAXUoOOAiaTBJF67e/TlBY0LGRISP64hA0dr0pxyZRNzdgAarz90tcuxlko02G7QGi3GIIw42yGJptLWQxiTcf16KSWMT575uPIvaSzsIAtq8bEcMpgFE375QJl5iaSZpZ27ovu8CSVFWb1d6RjdO4VWM9SCa3O8BPGlBTzJ65tbnXuYda29bNUmsaHQLxq9AyX8nkd2t3xoF6zhFOTXzn1JoHafhPVrftWu98peo1ISkQ76bMU5D3V8Xqgm1D0jg65
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bef065-8d25-4d07-c2ee-08d82e3ce5de
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 12:43:56.4413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM0FOe7WAB5wW8fbE+tLQXN34Ogm2S1GD0TVNGQt9v2E1oG/QNm+ZrVErlCrQM8ofFrFgEB4JLJcHOgDI7ITpKes57xK5g7QtrlHCHVO4q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3030
Received-SPF: pass client-ip=40.107.22.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 08:58:59
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

22.07.2020 14:21, Daniel P. Berrangé wrote:
> On Wed, Jul 22, 2020 at 02:00:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 20.07.2020 21:29, Daniel P. Berrangé wrote:
>>> On Mon, Jul 20, 2020 at 09:07:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Utilize new socket API to make a non-blocking connect for inet sockets.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    include/io/channel-socket.h | 14 +++++++
>>>>    io/channel-socket.c         | 74 +++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 88 insertions(+)
>>>>
>>>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>>>> index 777ff5954e..82e868bc02 100644
>>>> --- a/include/io/channel-socket.h
>>>> +++ b/include/io/channel-socket.h
>>>> @@ -94,6 +94,20 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>>>                                        SocketAddress *addr,
>>>>                                        Error **errp);
>>>> +/**
>>>> + * qio_channel_socket_connect_non_blocking_sync:
>>>> + * @ioc: the socket channel object
>>>> + * @addr: the address to connect to
>>>> + * @errp: pointer to a NULL-initialized error object
>>>> + *
>>>> + * Attempt to connect to the address @addr using non-blocking mode of
>>>> + * the socket. Function is synchronous, but being called from
>>>> + * coroutine context will yield during connect operation.
>>>> + */
>>>> +int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
>>>> +                                                 SocketAddress *addr,
>>>> +                                                 Error **errp);
>>>> +
>>>>    /**
>>>>     * qio_channel_socket_connect_async:
>>>>     * @ioc: the socket channel object
>>>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>>>> index e1b4667087..076de7578a 100644
>>>> --- a/io/channel-socket.c
>>>> +++ b/io/channel-socket.c
>>>> @@ -22,6 +22,7 @@
>>>>    #include "qapi/error.h"
>>>>    #include "qapi/qapi-visit-sockets.h"
>>>>    #include "qemu/module.h"
>>>> +#include "qemu/sockets.h"
>>>>    #include "io/channel-socket.h"
>>>>    #include "io/channel-watch.h"
>>>>    #include "trace.h"
>>>> @@ -29,6 +30,8 @@
>>>>    #define SOCKET_MAX_FDS 16
>>>> +static int qio_channel_socket_close(QIOChannel *ioc, Error **errp);
>>>> +
>>>>    SocketAddress *
>>>>    qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>>>                                         Error **errp)
>>>> @@ -157,6 +160,77 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>>>        return 0;
>>>>    }
>>>> +static int qio_channel_inet_connect_non_blocking_sync(QIOChannelSocket *ioc,
>>>> +        InetSocketAddress *addr, Error **errp)
>>>> +{
>>>> +    Error *local_err = NULL;
>>>> +    struct addrinfo *infos, *info;
>>>> +    int sock = -1;
>>>> +
>>>> +    infos = inet_parse_connect_saddr(addr, errp);
>>>> +    if (!infos) {
>>>> +        return -1;
>>>> +    }
>>>
>>> This call is blocking since it calls getaddrinfo whose design
>>> offers no ability todo non-blocking DNS lookups. Given this
>>> call, ...
>>
>> Oh, that's bad, thanks for taking a look on that early stage!
>>
>>>
>>>> +
>>>> +    for (info = infos; info != NULL; info = info->ai_next) {
>>>> +        bool in_progress;
>>>> +
>>>> +        error_free(local_err);
>>>> +        local_err = NULL;
>>>> +
>>>> +        sock = inet_connect_addr(addr, info, false, &in_progress, &local_err);
>>>> +        if (sock < 0) {
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        if (qio_channel_socket_set_fd(ioc, sock, &local_err) < 0) {
>>>> +            close(sock);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        if (in_progress) {
>>>> +            if (qemu_in_coroutine()) {
>>>> +                qio_channel_yield(QIO_CHANNEL(ioc), G_IO_OUT);
>>>> +            } else {
>>>> +                qio_channel_wait(QIO_CHANNEL(ioc), G_IO_OUT);
>>>> +            }
>>>
>>> ...this is offering false assurances of being non-blocking.
>>>
>>> If we don't want the current thread to be blocked then we
>>> need to be using the existing qio_channel_socket_connect_async
>>> method or similar. It uses a throw away background thread to
>>> run the connection attempt, and then reports completion back
>>> later, thus avoiding the getaddrinfo design flaw for the callers.
>>>
>>> I explicitly didn't want to add an method like the impl in this
>>> patch, because getaddrinfo dooms it and we already had bugs in
>>> the pre-QIOChannel code where QEMU thought it was non-blocking
>>> but wasn't due to getaddrinfo lookups.
>>>
>>>
>>> IIUC, the main appeal of this method is that the non-blocking
>>> nature is hidden from the caller who can continue to treat it
>>> as a synchronous call and have the coroutine magic happen in
>>> behind the scenes.
>>>
>>> IOW, What's needed is a simple way to run the operation in a
>>> thread, and sleep for completion while having the coroutine
>>> yield.
>>>
>>> I think this could likely be achieved with QIOTask with an
>>> alternate impl of the qio_task_wait_thread() method that is
>>> friendly to coroutines instead of being based on pthread
>>> condition variable waits.
>>
>> The most simple thing is just run qio_channel_socket_connect_sync in
>> a thread with help of thread_pool_submit_co() which is coroutine-friendly.
>> And this don't need any changes in io/channel.
>>
>> Actually, I've started with such design, but decided that better use
>> non-blocking connect to not deal with cancelling the connecting thread
>> on shutdown.
>>
>> I think, I'll resend based on thread_pool_submit_co().
>>
>> ===
>>
>> Hmm, there is async getaddrinfo_a function.. What do you think of it?
> 
> It isn't portable, glibc only.
> 
>> But seems simpler to use a thread than move to async interfaces everywhere.
> 
> 

Hmm.. Still, on shutdown, how to cancel this connect and getaddrinfo ? I'm not sure
how much time may getaddrinfo take, but connect can take about a minute. It's not really
good to wait for it on shutdown.

So, it may make sense to split connect, and keep it true-async. And call getaddrinfo in a thread
(or just keep it synchronous).



-- 
Best regards,
Vladimir


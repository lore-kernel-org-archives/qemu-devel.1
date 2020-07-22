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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FBEC433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F482065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hJBfoXFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F482065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGsP-0007g3-6V
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyGqy-00072p-3R; Wed, 22 Jul 2020 11:40:20 -0400
Received: from mail-vi1eur05on2103.outbound.protection.outlook.com
 ([40.107.21.103]:23648 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyGqu-0005Tq-J2; Wed, 22 Jul 2020 11:40:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO4S+6xzKvo6bPDCQOv/ni4/Cti8UcieFS4zFwxqZ4sF7uyCXq6g4Rs4RtTxq/xvCvv4U+d0MvmyyZRWHYw6VwQFMFQKv8qV+yV7D2tWSSHi4kwwRnBga67lTk5M87U6gexofZhAWZkHkIIwQFbSXRSiefdJNnXQUK1UwmPb5vDJB/nOIoMmuXtJkzoSa5UwK0zBiUQO6+4yA2irg72TYjL/zEoyccFdYP8FbgJom4CzUYtr/UmZCSGN//EEalf0dHZ1XcLYxPaVGjowb1nn0F6Ice1P+KozNjvd3Xb/TtiA6j3Iz2Y2sKexmRIgG3G2zxlU7iwganL0fbn0tpwKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOOgq7TFnUy8k4P2WvLjWWPvSKmCPnj9ige8B1clcJk=;
 b=HnEZR4Wxe+bLN1IUyO6aLnE5cMOFY0nEDxs0PNCwr3FaGEXzKSlQtzH0hyaidbLhvBhpvg0ejPGZpuLl3/x/V4YQdp8g4nOdpwAUvOXHyuK9j15DIjAb8OpNbdnjcnuRPTWFHuKXd85SmarWHS/K5J2+qCDBImby/qY0dW+OW9Kr+P0EC3dESoD5zL1mrj6YH1azJusuP3Dch9ZiCisjJbsxZOArw8EEmGOR8gulMFlAPXVYNERF8rmRTHLaOdSZRv5xj1WBm/Sabf6cpNNThMuzs+/tNG3YnVqst98yRKrRNtX2uEHkpb3TQbc5LIa8mgbWepAWtJ49Mrq0BGl7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOOgq7TFnUy8k4P2WvLjWWPvSKmCPnj9ige8B1clcJk=;
 b=hJBfoXFSGbFdTWMUPreZZzIwfPvceKwWCyu+OKK02KZElgIjSUm+xZbnT6cwvYqLlr0CZz5k8kjt3ySlHC8+kt0+zncAG2tDf9/bcaTfb/i4tQmDAC78uR6YftFWGF5rWaf3brht8sktM+1yC7qoTYS1yax+MpB9SFVcoRAXccE=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 15:40:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 15:40:12 +0000
Subject: Re: [PATCH 3/4] io/channel-socket: implement non-blocking connect
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200720180715.10521-1-vsementsov@virtuozzo.com>
 <20200720180715.10521-4-vsementsov@virtuozzo.com>
 <20200720182923.GP643836@redhat.com>
 <840b762e-1ce1-af25-2ea0-b8cfdedba0d4@virtuozzo.com>
 <20200722112104.GC2324845@redhat.com>
 <cd5058fe-20d4-615e-8489-a30ac54d57de@virtuozzo.com>
 <20200722125303.GI2324845@redhat.com>
 <71bd9b95-6db6-bfaa-729e-df9d1493e5b7@virtuozzo.com>
 <46847ccc-22d0-59b9-6c43-16cb6af4b078@virtuozzo.com>
 <20200722152140.GO2324845@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ebc8409a-7387-8cb4-cc37-8b2df580863b@virtuozzo.com>
Date: Wed, 22 Jul 2020 18:40:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200722152140.GO2324845@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.154) by
 FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.15 via Frontend Transport; Wed, 22 Jul 2020 15:40:11 +0000
X-Originating-IP: [185.215.60.154]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a05d84-b00e-44ab-fb68-08d82e5585a7
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB453499949B4E5C0794727F37C1790@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrAvPnptM9yXytJMsMf2PXXDTeVEb4ESKtyPVn1+ISHp7B7T7cJoBSTXndrEzHY1dlg/8ufeoZ9ibO4dESK5CbnYYoXGlYqg64p/Lu0kwaCKKtTwNH4muIN7rfPX2MMjrCMAGx3raZu/BmCgN7FtE8eWDCFhLmMwKmd6D3DDeA1LqVZLSdOAdFUUyAyAtmqPD5u7owxmXPRBLxmyYw+NsABRy6/8VB8VBCZra3y77e8YLujqpoVCFTCc8+EvL9+BMRvm7vtQ/wx6MCeu0XxEW9p7+ppFn6rH3kWjSSBN1FRWovioFsHf48/Yy8dNSZDGe+WzyK4bGBvODBldv7XEkU0rcW5bAslUGcvQNusqrO8WFNW08C33QmuAprDv9nSV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39840400004)(366004)(86362001)(2616005)(956004)(16576012)(316002)(16526019)(83380400001)(107886003)(4326008)(31686004)(31696002)(478600001)(186003)(8676002)(8936002)(6486002)(36756003)(52116002)(66946007)(5660300002)(66556008)(66476007)(26005)(2906002)(6916009)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zYOGFYaTA7J+2fbMSxaFgcMuCJ7VNB83k8Sev8jcw6iredygIqzex8Iq6Ej/IpWDqa1qJU8qv42D8hrxYFW9r1T6oFKZqvwRuHJq0TYBDf7ltZIfR2fEX9Falei3k2ggbg8AMKu6re/GTRL9a4+7gfHaD3MHN+XwuDHomuXTeR1UAPTefJ+YIda7VXVt28fd/ScA241qbxWnR3lQFshpkWwAIHCdCG1Ug/T1rfiKCK8DGQFiSrUCvUW36lppK6LSRUdrwGR+bb6C9NFe9geV/JFSIUC9IZk49vEqYVdqs/sqe7yDgn7F6GRGuvkJOoWA4CIJjMrO0y7p8AVBQDQ+Q1M4/X6GjtWD93a+0VGBCCNU84avuNDbqwrUA/DSzCg5O/7mzCA3KsU3cgJzan2TQn6Wyr1YrXKdp5uH3KmHPJzzN8eZfBcCyNT3LZZwub1OtOnU1TrMmTDv/we41VvQZNSLejZQiDvz19ooa66eDykPPShxJBT7oeWoSYT9wzbh
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a05d84-b00e-44ab-fb68-08d82e5585a7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 15:40:12.3616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTF+UblGcXOCfqwlR9DMSjYCo+cFZFIYlqRI4T16efXkLmA66ohtaMwalFJ4RSS9MdkA2LlHgh/sNFB3+35hV+/wLo6KYk5zxFEkigxYips=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.21.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 11:40:13
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

22.07.2020 18:21, Daniel P. Berrangé wrote:
> On Wed, Jul 22, 2020 at 06:04:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 22.07.2020 16:47, Vladimir Sementsov-Ogievskiy wrote:
>>> 22.07.2020 15:53, Daniel P. Berrangé wrote:
>>>> On Wed, Jul 22, 2020 at 03:43:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 22.07.2020 14:21, Daniel P. Berrangé wrote:
>>>>>> On Wed, Jul 22, 2020 at 02:00:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 20.07.2020 21:29, Daniel P. Berrangé wrote:
>>>>>>>> On Mon, Jul 20, 2020 at 09:07:14PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>> Utilize new socket API to make a non-blocking connect for inet sockets.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>>>>>> ---
>>>>>>>>>      include/io/channel-socket.h | 14 +++++++
>>>>>>>>>      io/channel-socket.c         | 74 +++++++++++++++++++++++++++++++++++++
>>>>>>>>>      2 files changed, 88 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>>>>>>>>> index 777ff5954e..82e868bc02 100644
>>>>>>>>> --- a/include/io/channel-socket.h
>>>>>>>>> +++ b/include/io/channel-socket.h
>>>>>>>>> @@ -94,6 +94,20 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>>>>>>>>                                          SocketAddress *addr,
>>>>>>>>>                                          Error **errp);
>>>>>>>>> +/**
>>>>>>>>> + * qio_channel_socket_connect_non_blocking_sync:
>>>>>>>>> + * @ioc: the socket channel object
>>>>>>>>> + * @addr: the address to connect to
>>>>>>>>> + * @errp: pointer to a NULL-initialized error object
>>>>>>>>> + *
>>>>>>>>> + * Attempt to connect to the address @addr using non-blocking mode of
>>>>>>>>> + * the socket. Function is synchronous, but being called from
>>>>>>>>> + * coroutine context will yield during connect operation.
>>>>>>>>> + */
>>>>>>>>> +int qio_channel_socket_connect_non_blocking_sync(QIOChannelSocket *ioc,
>>>>>>>>> +                                                 SocketAddress *addr,
>>>>>>>>> +                                                 Error **errp);
>>>>>>>>> +
>>>>>>>>>      /**
>>>>>>>>>       * qio_channel_socket_connect_async:
>>>>>>>>>       * @ioc: the socket channel object
>>>>>>>>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>>>>>>>>> index e1b4667087..076de7578a 100644
>>>>>>>>> --- a/io/channel-socket.c
>>>>>>>>> +++ b/io/channel-socket.c
>>>>>>>>> @@ -22,6 +22,7 @@
>>>>>>>>>      #include "qapi/error.h"
>>>>>>>>>      #include "qapi/qapi-visit-sockets.h"
>>>>>>>>>      #include "qemu/module.h"
>>>>>>>>> +#include "qemu/sockets.h"
>>>>>>>>>      #include "io/channel-socket.h"
>>>>>>>>>      #include "io/channel-watch.h"
>>>>>>>>>      #include "trace.h"
>>>>>>>>> @@ -29,6 +30,8 @@
>>>>>>>>>      #define SOCKET_MAX_FDS 16
>>>>>>>>> +static int qio_channel_socket_close(QIOChannel *ioc, Error **errp);
>>>>>>>>> +
>>>>>>>>>      SocketAddress *
>>>>>>>>>      qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>>>>>>>>                                           Error **errp)
>>>>>>>>> @@ -157,6 +160,77 @@ int qio_channel_socket_connect_sync(QIOChannelSocket *ioc,
>>>>>>>>>          return 0;
>>>>>>>>>      }
>>>>>>>>> +static int qio_channel_inet_connect_non_blocking_sync(QIOChannelSocket *ioc,
>>>>>>>>> +        InetSocketAddress *addr, Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    Error *local_err = NULL;
>>>>>>>>> +    struct addrinfo *infos, *info;
>>>>>>>>> +    int sock = -1;
>>>>>>>>> +
>>>>>>>>> +    infos = inet_parse_connect_saddr(addr, errp);
>>>>>>>>> +    if (!infos) {
>>>>>>>>> +        return -1;
>>>>>>>>> +    }
>>>>>>>>
>>>>>>>> This call is blocking since it calls getaddrinfo whose design
>>>>>>>> offers no ability todo non-blocking DNS lookups. Given this
>>>>>>>> call, ...
>>>>>>>
>>>>>>> Oh, that's bad, thanks for taking a look on that early stage!
>>>>>>>
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +    for (info = infos; info != NULL; info = info->ai_next) {
>>>>>>>>> +        bool in_progress;
>>>>>>>>> +
>>>>>>>>> +        error_free(local_err);
>>>>>>>>> +        local_err = NULL;
>>>>>>>>> +
>>>>>>>>> +        sock = inet_connect_addr(addr, info, false, &in_progress, &local_err);
>>>>>>>>> +        if (sock < 0) {
>>>>>>>>> +            continue;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        if (qio_channel_socket_set_fd(ioc, sock, &local_err) < 0) {
>>>>>>>>> +            close(sock);
>>>>>>>>> +            continue;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        if (in_progress) {
>>>>>>>>> +            if (qemu_in_coroutine()) {
>>>>>>>>> +                qio_channel_yield(QIO_CHANNEL(ioc), G_IO_OUT);
>>>>>>>>> +            } else {
>>>>>>>>> +                qio_channel_wait(QIO_CHANNEL(ioc), G_IO_OUT);
>>>>>>>>> +            }
>>>>>>>>
>>>>>>>> ...this is offering false assurances of being non-blocking.
>>>>>>>>
>>>>>>>> If we don't want the current thread to be blocked then we
>>>>>>>> need to be using the existing qio_channel_socket_connect_async
>>>>>>>> method or similar. It uses a throw away background thread to
>>>>>>>> run the connection attempt, and then reports completion back
>>>>>>>> later, thus avoiding the getaddrinfo design flaw for the callers.
>>>>>>>>
>>>>>>>> I explicitly didn't want to add an method like the impl in this
>>>>>>>> patch, because getaddrinfo dooms it and we already had bugs in
>>>>>>>> the pre-QIOChannel code where QEMU thought it was non-blocking
>>>>>>>> but wasn't due to getaddrinfo lookups.
>>>>>>>>
>>>>>>>>
>>>>>>>> IIUC, the main appeal of this method is that the non-blocking
>>>>>>>> nature is hidden from the caller who can continue to treat it
>>>>>>>> as a synchronous call and have the coroutine magic happen in
>>>>>>>> behind the scenes.
>>>>>>>>
>>>>>>>> IOW, What's needed is a simple way to run the operation in a
>>>>>>>> thread, and sleep for completion while having the coroutine
>>>>>>>> yield.
>>>>>>>>
>>>>>>>> I think this could likely be achieved with QIOTask with an
>>>>>>>> alternate impl of the qio_task_wait_thread() method that is
>>>>>>>> friendly to coroutines instead of being based on pthread
>>>>>>>> condition variable waits.
>>>>>>>
>>>>>>> The most simple thing is just run qio_channel_socket_connect_sync in
>>>>>>> a thread with help of thread_pool_submit_co() which is coroutine-friendly.
>>>>>>> And this don't need any changes in io/channel.
>>>>>>>
>>>>>>> Actually, I've started with such design, but decided that better use
>>>>>>> non-blocking connect to not deal with cancelling the connecting thread
>>>>>>> on shutdown.
>>>>>>>
>>>>>>> I think, I'll resend based on thread_pool_submit_co().
>>>>>>>
>>>>>>> ===
>>>>>>>
>>>>>>> Hmm, there is async getaddrinfo_a function.. What do you think of it?
>>>>>>
>>>>>> It isn't portable, glibc only.
>>>>>>
>>>>>>> But seems simpler to use a thread than move to async interfaces everywhere.
>>>>>>
>>>>>>
>>>>>
>>>>> Hmm.. Still, on shutdown, how to cancel this connect and getaddrinfo ? I'm not sure
>>>>> how much time may getaddrinfo take, but connect can take about a minute. It's not really
>>>>> good to wait for it on shutdown.
>>>>
>>>> The intention was that if you don't want to carry on waiting for the
>>>> async operation to complete you just give and pretend it no longer
>>>> exists. Eventually it will fail or complete and the thread will exit.
>>>> The only important thing there is making sure that the callback you
>>>> are passing to the _async() method can cope with the cleanup when the
>>>> work eventually completes, even if you've given up.
>>>>
>>>
>>> At least it's not possible with thread_pool_submit_co as I wanted, because underlying
>>> thread pool waits for all its threads to complete on exit.
>>>
>>>
>>
>>
>> I'm trying to use qio_channel_socket_connect_async().. But callback
>> is not called.
>>
>> How to make it be executed? In tests/test-io-channel-socket.c it's
>> done by g_main_loop_new .. g_main_loop_run. But I need to yield.
>> socket_start_outgoing_migration uses qio_channel_socket_connect_async
>> as well, but is not doing any magic with g_main_loop. But it works. How?
> 
> The _async() impls uses  qio_task_run_in_thread to spawn the background
> thread. When the thread finishes, it uses g_idle_add to invoke the
> callback so that it runs in the context of the main thread, not the
> background thread. So something needs to be running the main loop
> in QEMU.

I came to same idea. But still, I don't see where g_main_loop is run inside qemu_main_loop(). Only iothread_run() does it. But what if we don't have iothreads?

OK, it's obvious that when qemu parses -drive options it doesn't run any main-loop. But on reconnect attempts it should
run qemu_main_loop, but callback still is not called for me..

I understand, that I can create custom wrapper on sync connect, to run it in a thread. But I just try to understand:

  - how qemu_main_loop and all these g_main_loop* things are connected?
  - if they are not, how qio_channel_socket_connect_async() works in socket_start_outgoing_migration(), where nobody run the g_main_loop_run() ?

> 
> If that isn't viable for the scenario you're in, then you can create
> your own async version by spawning the thread yourself and running
> the _sync() function - the _async() function is ajust a convenient
> wrapper combining QIOTask + _sync(), but doesn't always do what
> everyone might need.   In the char-socket.c for example, I do the
> async bit manually instead of using teh _async() wrapper.
> 
> Regards,
> Daniel
> 


-- 
Best regards,
Vladimir


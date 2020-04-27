Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D7C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BFE82063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="diUJhqRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFE82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1bX-00049V-86
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 07:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT1Yr-0000TY-67
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT1Yo-0003VX-Ch
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:04:28 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:26934 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT1Yn-0003NY-3w
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 07:04:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK5iN14yGsNKH73yd4//QfEU2SmBuYxX5FbJS2EuJH+KvhNKAKvG4O2hw4DvY8WcUbgNsqvWQ61doQSyYt7yt9/x/y8Nk5wIc6WTXMQhqfA7geTpkJ5H8laj+q0eL0z0Bqt5RqGo86I0gi/DJAVHNeMSLOkyZNnjTPCCiQD9V8OJoo1UE52H4oErx9nN38tkwRwioy3laga+Y/M2Fg6yuza6/Omaxy6YcOOdtu3LiixsWNPG2JifBQ8LD4X3nwipShOY+3HF8DKP898NYOrktIOIrk9FUW/lPxVFU1jVLXfW1qUDLAanuBfVSN1oDR50n+g8zrpNr6GYVBPYD3h+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oIkivmkaj9kK4NBGG4SxVbk45Kaca5zsB4+eOxNv5w=;
 b=jMpntb5j8dUeRVMiOu5bRF/R9KxeQZ0rytOPzawtsvMTg+eHsNcCe3ZqNtFjKgUyeulBQtns1Y33X867sMvgIlSuZ2MppaTfLs8RqZP8R3N/XD6IxlQpOh9SExYgvAqrEpIvQnzRn+qMR7YO2ZMoieacYV0gE0wo0L5OJEIInuXWm+iNkBLqrFe8sLjbWDwLx3KxlFYbymyRPnNfD/u6S1yovm1aU7b28hlI8HErTHKYdDCFt4ezH7GKiU1ObkIJsd4PnE/Xz9CAT4FpkEeTddDqUwP6EonZ9VVhxrlXVrW7/bxbng4WfAEmFd113Ir4Sf2XGAmcfL39nyWpP9kslw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oIkivmkaj9kK4NBGG4SxVbk45Kaca5zsB4+eOxNv5w=;
 b=diUJhqRh+CZerLUlUfpAYjRN/laEogAV5P0LgdtqzZ9vIa0aiZOUHYzPqHTkbDn9EFIQo6PFT8SkRSXJ7rqFqFq/90FxUy9j9hyek+ZfUx/IH6tilzCfXXmM7t6TSF3qmYtzOMnUU0ihDrXLutTN4Fds628PQ6KrOnX3wyZWSsc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 11:04:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 11:04:21 +0000
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
 <90aab270-618b-629b-07cf-45989e11559e@virtuozzo.com>
 <a21d35b8-90d6-17c7-0ba1-b249182f7537@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200427140419578
Message-ID: <14f67454-e809-065f-10e1-07dd24f8a2c9@virtuozzo.com>
Date: Mon, 27 Apr 2020 14:04:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <a21d35b8-90d6-17c7-0ba1-b249182f7537@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.182) by
 FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 11:04:20 +0000
X-Tagtoolbar-Keys: D20200427140419578
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e039ecef-ca42-47e9-0131-08d7ea9abcd4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53830E62E9D009B72FD1134AC1AF0@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(31686004)(186003)(16576012)(6486002)(31696002)(26005)(2906002)(4326008)(8676002)(53546011)(16526019)(86362001)(66946007)(316002)(66556008)(66476007)(36756003)(8936002)(5660300002)(81156014)(52116002)(30864003)(478600001)(956004)(2616005);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0RNld3jGa5tO1s7aZ45sRNFhPO8c9wIRptkSS9Tj0FhtLaVuBX+UTZc2kaIUAG7iXWuUEjWWukuuLd8eZ4dhSzc6P56DCuU3dFQ9syyjVgBrtV1FsH464Begr0gHi5xQa8nnNV1tljLu088NBhmkIP+Wscdb3acnnE04Pg7AlVKQApWUyD6C/PFXuU9lx+X8NRWtCJSXjifBUPexdVUdzEcsP6dio1PLZkz5vikZZ04iDejj1GMYCUZA1eGDOQvY0pJnR4ExHy58VGLxQTfVLuRA9ekRSCavFPfN1A099nTDYTIs3h0IS8p3V0yBnZ3ddBSuZ9W+Qikf9ceODDusOIsiqk8PBdpylBgSe+8rV70kF6glE+oz+TWSJG1K+4NPx00JkbCz4evWcuqrkdvUKU2gW82sC8Xh5wdtohFLCb0PyM0GkwB8yKrx/SqXmna
X-MS-Exchange-AntiSpam-MessageData: drQtryBdZX+mihR3mmNRXCHioOubRIqDRzijO489hcCR3ovo4q+J7cl0Xjzdme8NDe85Rz/2qt/IHb2WnzQeurCZi22Bq5k/H9rUY3uyd8rAPVXF2khKQvozr4zMxkSgbZqOz1Ic16zGmbzZ/l7kserrRmlDqVLQ6KdWX0pMTJwXEAiXZeJQzN+r4eU9IrNhp4sh+zUuiiw59T0R/hYGHlRc2g87WB5VMK2tQN6rZTV+RSNqWYo4RanxT3h7AointHbpIuGZxsiNGS4GawEvuMRkc/28nYwzhrM9Xyifea/8Js+KC4oQytpUTXqRkVFTu+G+sw/3CmU2q4EUVuCGfKBweU+R5ylmVol2iiytqLEGx0X8TBAiNqJk2WETWtNEH6LQKJOcmabH3uC3LnbmVW4gSpR3WLAYM0h+JR1QjCvRcoAauoHf4eEVI1kAANsxA3kyjFygItIb1Z3Eq2Y+DWLW+cWQuk2PvSXWwUt8b0BPO0pK5JW81qISC7hbOYZmPhV7TsLQBDfd3U3hQ5X/lSEsvckIYJkRE7xm8G5bHQEgB3CQsWhvcyRGt4sKDTXFmizqMTeihOnynViTkJ43yzvv1JJdZJm+C+SnsUIVicpDWY1TNM1+QDRxkbRNfQEijJ+WiYWYhGdhTvSWo5WXckdNBZ4Fgmjr7KBztQJgbOZSsWmNJbHEMEOtvtqof/Jaat1H7BTmSbw7EPFOLWo7OLUu/zpW6Z7uv1gbumhRKjhU9Na+rlBMpwZiLsbnkk9mBavU95ZIEtvp3q4aVZEaX5eHNHxaseCcFJ/jetr7XrM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e039ecef-ca42-47e9-0131-08d7ea9abcd4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 11:04:21.3234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wMhBFioPa3Ad+nx2tJJgaFYVw48GPagQRnvY8bpXOE21W0BljOBIb3kSpDYgQ3DZE0toscu371t96+Tgl1eJfalx9OBu23TwK9BEDfi5n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.8.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 07:04:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.137
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
Cc: den@openvz.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.04.2020 11:19, Denis Plotnikov wrote:
> 
> 
> On 25.04.2020 12:10, Vladimir Sementsov-Ogievskiy wrote:
>> 13.04.2020 14:12, Denis Plotnikov wrote:
>>> The patch adds ability to qemu-file to write the data
>>> asynchronously to improve the performance on writing.
>>> Before, only synchronous writing was supported.
>>>
>>> Enabling of the asyncronous mode is managed by new
>>> "enabled_buffered" callback.
>>
>> Hmm.
>>
>> I don't like resulting architecture very much:
>>
>> 1. Function naming is not clean: how can I understand that copy_buf is for buffered mode when add_to_iovec is +- same thing for non-buffered mode?
> Yes, this is to be changed in the next patches
>>
>> Hmm actually, you just alter several significant functions of QEMUFile - open, close, put, flush. In old mode we do one thing, in a new mode - absolutely another. This looks like a driver. So may be we want to add QEMUFileDriver struct, to define these functions as callbacks, move old realizations to default driver, and add new functionality as a new driver, what do you think?
> Yes it looks like that, but on the other hand I can't imagine another driver to be added and changing the code to "the driver notation" would involve more code adding. So, should we really do that. Anyway, your suggestion looks cleaner.
>>
>> 2. Terminology: you say you add buffered mode, but actually qemu file is already work in buffered mode, so it should be clarified somehow..
> The initial implementation uses mixed implementation, it has a buffer and an iovec array. The buffer is used to store *some* parts (ecluding RAM) of a vm state + service information. Each written to the buffer is added to the iovec array as a separate entry. RAM pages aren't added to the buffer, instead they are added to the iovec array directly without coping to the buffer. This is why we almost always get the iovec array consisting of size- and pointer- unaligned iovec-s and why we have the performance issues (more detailed in 0000 of this series).
> So, I can't say that the qemu-file has "real" buffered-mode.

But if someone will come and try to understand the code, it would be difficult because of such naming. If we keep it, we should add your description as comment to that name.

>> You also add asynchronisity, but old implementation has already qemu_put_buffer_async..
> In my opinion, this function name is kind of confusing. What the function does is adding the buffer pointer to the internal iovec array without coping the buffer. It's not related to some asynchronous operation.
>> You use aio task pool, but don't say that it may be used only from coroutine.
>> May be, we'd better call it "coroutine-mode" ?
> I don't think that mentioning any implementation-specific name is a good idea. aio_task_pool is a good option to implement async operation, but it can be any other interface.
> I'd rather implicitly assert qemu_in_coroutine() when in "buffered-mode".
>>
>>
>> Also, am I correct that new mode can't be used for read? Should we document/assert it somehow? 
> It can't just for now since read-buffered mode isn't implemented. Enabling buffered-mode for reading affects nothing - qemu-file works as before.
> The same qemu-file instance can't  be opened for reading and writing at the same time. I'd add that assert on qemu-file open.

Ah, OK. I saw it, but thought somehow that enabled writing doesn't protect from reading.

>> Or may be support reading? Will switch to snapshot benefit if we implement reading in a new mode?
> I thought about that. I think it could benefit making some kind of read-ahead to a number of buffers, while the "current" buffer is used to fill a vm state.
> I didn't want to focus on the reading improvements because it's not that big problem in comparison to the writing. The qemu-file reading uses a buffer and fills  that buffer with a single io operation.

OK

> 
>>
>>>
>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>> ---
>>>   include/qemu/typedefs.h |   1 +
>>>   migration/qemu-file.c   | 351 +++++++++++++++++++++++++++++++++++++++++++++---
>>>   migration/qemu-file.h   |   9 ++
>>>   3 files changed, 339 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>> index 88dce54..9b388c8 100644
>>> --- a/include/qemu/typedefs.h
>>> +++ b/include/qemu/typedefs.h
>>> @@ -98,6 +98,7 @@ typedef struct QEMUBH QEMUBH;
>>>   typedef struct QemuConsole QemuConsole;
>>>   typedef struct QEMUFile QEMUFile;
>>>   typedef struct QEMUFileBuffer QEMUFileBuffer;
>>> +typedef struct QEMUFileAioTask QEMUFileAioTask;
>>>   typedef struct QemuLockable QemuLockable;
>>>   typedef struct QemuMutex QemuMutex;
>>>   typedef struct QemuOpt QemuOpt;
>>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>>> index 285c6ef..f42f949 100644
>>> --- a/migration/qemu-file.c
>>> +++ b/migration/qemu-file.c
>>> @@ -29,19 +29,25 @@
>>>   #include "qemu-file.h"
>>>   #include "trace.h"
>>>   #include "qapi/error.h"
>>> +#include "block/aio_task.h"
>>>   -#define IO_BUF_SIZE 32768
>>> +#define IO_BUF_SIZE (1024 * 1024)
>>>   #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
>>> +#define IO_BUF_NUM 2
>>
>> Interesting, how much is it better than if we set to 1, limiting the influence of the series to alignment of written chunks?
>>> +#define IO_BUF_ALIGNMENT 512
>>>   -QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
>>> +QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, IO_BUF_ALIGNMENT));
>>> +QEMU_BUILD_BUG_ON(IO_BUF_SIZE > INT_MAX);
>>> +QEMU_BUILD_BUG_ON(IO_BUF_NUM <= 0);
>>>     struct QEMUFileBuffer {
>>>       int buf_index;
>>> -    int buf_size; /* 0 when writing */
>>> +    int buf_size; /* 0 when non-buffered writing */
>>>       uint8_t *buf;
>>>       unsigned long *may_free;
>>>       struct iovec *iov;
>>>       unsigned int iovcnt;
>>> +    QLIST_ENTRY(QEMUFileBuffer) link;
>>>   };
>>>     struct QEMUFile {
>>> @@ -60,6 +66,22 @@ struct QEMUFile {
>>>       bool shutdown;
>>>       /* currently used buffer */
>>>       QEMUFileBuffer *current_buf;
>>> +    /*
>>> +     * with buffered_mode enabled all the data copied to 512 byte
>>> +     * aligned buffer, including iov data. Then the buffer is passed
>>> +     * to writev_buffer callback.
>>> +     */
>>> +    bool buffered_mode;
>>> +    /* for async buffer writing */
>>> +    AioTaskPool *pool;
>>> +    /* the list of free buffers, currently used on is NOT there */
>>> +    QLIST_HEAD(, QEMUFileBuffer) free_buffers;
>>> +};
>>> +
>>> +struct QEMUFileAioTask {
>>> +    AioTask task;
>>> +    QEMUFile *f;
>>> +    QEMUFileBuffer *fb;
>>>   };
>>>     /*
>>> @@ -115,10 +137,42 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
>>>       f->opaque = opaque;
>>>       f->ops = ops;
>>>   -    f->current_buf = g_new0(QEMUFileBuffer, 1);
>>> -    f->current_buf->buf = g_malloc(IO_BUF_SIZE);
>>> -    f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
>>> -    f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
>>> +    if (f->ops->enable_buffered) {
>>> +        f->buffered_mode = f->ops->enable_buffered(f->opaque);
>>> +    }
>>> +
>>> +    if (f->buffered_mode && qemu_file_is_writable(f)) {
>>
>> So we actually go to buffered_mode if file is writable. Then, shouldn't we otherwise set buffered_mode to false otherwise?
> buffered_mode is initialized with false

I mean, if enable_buffered() returned true but qemu_file_is_writable() returned false.. I now think it should an error.

>>
>>> +        int i;
>>> +        /*
>>> +         * in buffered_mode we don't use internal io vectors
>>> +         * and may_free bitmap, because we copy the data to be
>>> +         * written right away to the buffer
>>> +         */
>>> +        f->pool = aio_task_pool_new(IO_BUF_NUM);
>>> +
>>> +        /* allocate io buffers */
>>> +        for (i = 0; i < IO_BUF_NUM; i++) {
>>> +            QEMUFileBuffer *fb = g_new0(QEMUFileBuffer, 1);
>>> +
>>> +            fb->buf = qemu_memalign(IO_BUF_ALIGNMENT, IO_BUF_SIZE);
>>> +            fb->buf_size = IO_BUF_SIZE;
>>> +
>>> +            /*
>>> +             * put the first buffer to the current buf and the rest
>>> +             * to the list of free buffers
>>> +             */
>>> +            if (i == 0) {
>>> +                f->current_buf = fb;
>>> +            } else {
>>> +                QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
>>> +            }
>>> +        }
>>> +    } else {
>>> +        f->current_buf = g_new0(QEMUFileBuffer, 1);
>>> +        f->current_buf->buf = g_malloc(IO_BUF_SIZE);
>>> +        f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
>>> +        f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
>>> +    }
>>>         return f;
>>>   }
>>> @@ -190,6 +244,8 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>>       unsigned long idx;
>>>       QEMUFileBuffer *fb = f->current_buf;
>>>   +    assert(!f->buffered_mode);
>>> +
>>>       /* Find and release all the contiguous memory ranges marked as may_free. */
>>>       idx = find_next_bit(fb->may_free, fb->iovcnt, 0);
>>>       if (idx >= fb->iovcnt) {
>>> @@ -221,6 +277,147 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>>       bitmap_zero(fb->may_free, MAX_IOV_SIZE);
>>>   }
>>>   +static void advance_buf_ptr(QEMUFile *f, size_t size)
>>> +{
>>> +    QEMUFileBuffer *fb = f->current_buf;
>>> +    /* must not advance to 0 */
>>> +    assert(size);
>>> +    /* must not overflow buf_index (int) */
>>> +    assert(fb->buf_index + size <= INT_MAX);
>>
>> to not overflow in check: assert(fb->buf_index <= INT_MAX - size)
> good catch
>>
>>> +    /* must not exceed buf_size */
>>> +    assert(fb->buf_index + size <= fb->buf_size);
>>> +
>>> +    fb->buf_index += size;
>>> +}
>>> +
>>> +static size_t get_buf_free_size(QEMUFile *f)
>>> +{
>>> +    QEMUFileBuffer *fb = f->current_buf;
>>> +    /* buf_index can't be greated than buf_size */
>>> +    assert(fb->buf_size >= fb->buf_index);
>>> +    return fb->buf_size - fb->buf_index;
>>> +}
>>> +
>>> +static size_t get_buf_used_size(QEMUFile *f)
>>> +{
>>> +    QEMUFileBuffer *fb = f->current_buf;
>>> +    return fb->buf_index;
>>> +}
>>> +
>>> +static uint8_t *get_buf_ptr(QEMUFile *f)
>>> +{
>>> +    QEMUFileBuffer *fb = f->current_buf;
>>> +    /* protects from out of bound reading */
>>> +    assert(fb->buf_index <= IO_BUF_SIZE);
>>> +    return fb->buf + fb->buf_index;
>>> +}
>>> +
>>> +static bool buf_is_full(QEMUFile *f)
>>> +{
>>> +    return get_buf_free_size(f) == 0;
>>> +}
>>> +
>>> +static void reset_buf(QEMUFile *f)
>>> +{
>>> +    QEMUFileBuffer *fb = f->current_buf;
>>> +    fb->buf_index = 0;
>>> +}
>>> +
>>> +static int write_task_fn(AioTask *task)
>>> +{
>>> +    int ret;
>>> +    Error *local_error = NULL;
>>> +    QEMUFileAioTask *t = (QEMUFileAioTask *) task;
>>> +    QEMUFile *f = t->f;
>>> +    QEMUFileBuffer *fb = t->fb;
>>> +    uint64_t pos = f->pos;
>>> +    struct iovec v = (struct iovec) {
>>> +        .iov_base = fb->buf,
>>> +        .iov_len = fb->buf_index,
>>> +    };
>>> +
>>> +    assert(f->buffered_mode);
>>> +
>>> +    /*
>>> +     * Increment file position.
>>> +     * This needs to be here before calling writev_buffer, because
>>> +     * writev_buffer is asynchronous and there could be more than one
>>> +     * writev_buffer started simultaniously. Each writev_buffer should
>>> +     * use its own file pos to write to. writev_buffer may write less
>>> +     * than buf_index bytes but we treat this situation as an error.
>>> +     * If error appeared, further file using is meaningless.
>>> +     * We expect that, the most of the time the full buffer is written,
>>> +     * (when buf_size == buf_index). The only case when the non-full
>>> +     * buffer is written (buf_size != buf_index) is file close,
>>> +     * when we need to flush the rest of the buffer content.
>>> +     */
>>> +    f->pos += fb->buf_index;
>>
>> Seems safer to add pos to QEMUFileAioTask instead, and manage global f->pos
>> in main coroutine, not in tasks.
> I also though about that but I didn't find any benefit because with couroutines we shouldn't get race problems

Still, it would be more obvious code pattern IMHO, so that task is offset and bytes, instead of just bytes and global offset variable which we should update with care.

>>
>>> +
>>> +    ret = f->ops->writev_buffer(f->opaque, &v, 1, pos, &local_error);
>>> +
>>> +    /* return the just written buffer to the free list */
>>> +    QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
>>> +
>>> +    /* check that we have written everything */
>>> +    if (ret != fb->buf_index) {
>>> +        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
>>> +    }
>>> +
>>> +    /*
>>> +     * always return 0 - don't use task error handling, relay on
>>> +     * qemu file error handling
>>> +     */
>>> +    return 0;
>>> +}
>>> +
>>> +static void qemu_file_switch_current_buf(QEMUFile *f)
>>> +{
>>> +    /*
>>> +     * if the list is empty, wait until some task returns a buffer
>>> +     * to the list of free buffers.
>>> +     */
>>> +    if (QLIST_EMPTY(&f->free_buffers)) {
>>> +        aio_task_pool_wait_slot(f->pool);
>>> +    }
>>> +
>>> +    /*
>>> +     * sanity check that the list isn't empty
>>> +     * if the free list was empty, we waited for a task complition,
>>> +     * and the pompleted task must return a buffer to a list of free buffers
>>> +     */
>>> +    assert(!QLIST_EMPTY(&f->free_buffers));
>>> +
>>> +    /* set the current buffer for using from the free list */
>>> +    f->current_buf = QLIST_FIRST(&f->free_buffers);
>>> +    reset_buf(f);
>>> +
>>> +    QLIST_REMOVE(f->current_buf, link);
>>> +}
>>> +
>>> +/**
>>> + *  Asynchronously flushes QEMUFile buffer
>>> + *
>>> + * This will flush all pending data. If data was only partially flushed, it
>>> + * will set an error state. The function may return before the data actually
>>> + * written.
>>> + */
>>> +static void flush_buffer(QEMUFile *f)
>>> +{
>>> +    QEMUFileAioTask *t = g_new(QEMUFileAioTask, 1);
>>> +
>>> +    *t = (QEMUFileAioTask) {
>>> +        .task.func = &write_task_fn,
>>> +        .f = f,
>>> +        .fb = f->current_buf,
>>> +    };
>>> +
>>> +    /* aio_task_pool should free t for us */
>>> +    aio_task_pool_start_task(f->pool, (AioTask *) t);
>>> +
>>> +    /* if no errors this will switch the buffer */
>>> +    qemu_file_switch_current_buf(f);
>>> +}
>>> +
>>>   /**
>>>    * Flushes QEMUFile buffer
>>>    *
>>> @@ -241,7 +438,13 @@ void qemu_fflush(QEMUFile *f)
>>>       if (f->shutdown) {
>>>           return;
>>>       }
>>> +
>>> +    if (f->buffered_mode) {
>>> +        return;
>>
>> I don't think it's correct. qemu_fflush is public interface of QEMUFile and it's assumed to write all in-flight data.
> Yes it should, when you use sockets and you want to make sure that you've sent what your peer is waiting for.
> But this isn't the case when you write an internal snapshot, especially when you explicitly ask to open qemu-file in "buffered_mode".

Hmm, would be good to add a comment in the code..

>>
>>> +    }
>>> +
>>>       if (fb->iovcnt > 0) {
>>> +        /* this is non-buffered mode */
>>>           expect = iov_size(fb->iov, fb->iovcnt);
>>>           ret = f->ops->writev_buffer(f->opaque, fb->iov, fb->iovcnt, f->pos,
>>>                                       &local_error);
>>> @@ -378,6 +581,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>>>     void qemu_update_position(QEMUFile *f, size_t size)
>>>   {

[..]


-- 
Best regards,
Vladimir


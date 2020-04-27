Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77094C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EB020656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YZk3I6cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EB020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzIU-00065Q-A6
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jSzE7-0008Lj-EC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jSzDo-0007nw-DL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:34:53 -0400
Received: from mail-eopbgr140128.outbound.protection.outlook.com
 ([40.107.14.128]:23710 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jSzDn-0007ni-Qo
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:34:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA4R03OSxC7AI5h+Oa5GI+GqWTN28+PK7Tuq4L6W5j4cNX5IStYPc9tNP1nUkjlWR24X6thQX93KWwg4iS1knr38dBPOi8cUW7BTkG8o2ni2+W/ttn3cOYZ+2Iq6vqzdDKyzPDboOucF5meOIRJNLyhXgdxJcaJWuPNQu2mq08EtwBBmhHirViuvxuiLqLkx2wS5YK1JnLGJHAZT2UxmJWzRYdPdOSXO7+Iv+IwuRrY44s4glsutbV/fSrphODGYzbGWXs2ffjvP5kiqvJZ/ptxutYvuU7cMJPV1Q6hkR2cUX1MD+drfzaZPgOxazaRmiYVBMXm1nE25pH4rsxfBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQkMikkAmDUry8KuUb/TNaWO2/SIHwooaXFAy+UNovY=;
 b=h2+RSdNFzRmfp4ffASZZnT3VWSMJw928ag/ewZmc4ADtOIDK4MstDzGJ9oQRdXDourioVjJY4S1IX/U4yufaKv1fvNOnLTLoHfh/GfOVEQFVBr4Y5pmkbg7rLK80WbeU4SdGLmu3Si5VgbU5pw0rVXEEMF4LdVg/RWdH0fNlm2ydddojP4rpr/ku5FN8NIeAQdOJFs/T5ypDKis7zJpILRnQaZAOAdA9F0RzqK6ytP2nBYIRbBPvAfJrTohO3K/61/ql40KfIQfUtI+dpmIY++io88Jwiz99yo/j1syy/95o/k4I9upK8BclwhdNy0d9pfiSrrmPLwNEapMs7u8DSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQkMikkAmDUry8KuUb/TNaWO2/SIHwooaXFAy+UNovY=;
 b=YZk3I6cA5nUClqdkaoT7N/I8qTVHXdKuguSiBJN2f3D5ShQp1SK0HTbbPmY6u03WnUfQgDfScDPursANu6H/asF4Nj7n2GP7gIoKOjyqmoFGxgP+F90s41Cu7rEF0jiVKXAG1OQhuUiV3c7Cpt874OVdDIhmeY+T6riwYFpLFDQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4594.eurprd08.prod.outlook.com (2603:10a6:208:104::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:19:29 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:19:29 +0000
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
 <90aab270-618b-629b-07cf-45989e11559e@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <a21d35b8-90d6-17c7-0ba1-b249182f7537@virtuozzo.com>
Date: Mon, 27 Apr 2020 11:19:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <90aab270-618b-629b-07cf-45989e11559e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0017.eurprd04.prod.outlook.com
 (2603:10a6:208:122::30) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.240.57) by
 AM0PR04CA0017.eurprd04.prod.outlook.com (2603:10a6:208:122::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Mon, 27 Apr 2020 08:19:28 +0000
X-Originating-IP: [94.233.240.57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2b27953-431b-46c4-3905-08d7ea83b4de
X-MS-TrafficTypeDiagnostic: AM0PR08MB4594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45945FFA16E3AC432E9031E5CFAF0@AM0PR08MB4594.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(39840400004)(346002)(396003)(86362001)(16526019)(31696002)(2906002)(8676002)(81156014)(31686004)(6486002)(186003)(956004)(316002)(16576012)(26005)(36756003)(2616005)(8936002)(52116002)(478600001)(30864003)(66556008)(4326008)(66476007)(53546011)(5660300002)(66946007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DM0a4oAdIxSY0xMlYLs7flgCDfJ5iuJw5lvC6igYOzkvLnNfOJeyA0CWpkyYnjvQGqOw0BPDkxU5DURqH1ZgmQrIX0mX/HB/zb1WYcDr/1GLJ4FPG2uslYsZ3eYMZfVEAgZdRZYZMgFFdee4BbqW18QnTjhrStSKDTMAVHSS4osbXb96fNPhNYEyL9UsFEhd1Il8aZ3LBDWnPZcI8Hj3Kpwm/RIlW+7ImmgcLKMPXJdXOrgeXEwmk/S98BaXE3bAzMtu4nWHssiPVSe/YpAKsxm1XJRTCXc/ZLBSgFPmR+eZZB+MxISHnGEYkB+tOntBLYZlCvDQbFsOa+4MvjvVqVifDDaaz/n3YaN5Fa/MC5EvqkS8MkEamMrXxZuUpPEPbxBAC3W+lU2g3Gzl6JUA0GT642G3jTvzl1OnMAFmyKBc3lN3uWDwm3irW1Ahtmf
X-MS-Exchange-AntiSpam-MessageData: k9Fgn6yO5YUQqzfBHxZeKdLTdV98hYVYsvS9IhdshM6798XLASRyPko8kTfk+Z3QqF9cVn3foQa2RWHU5BogkcRRSYU78BLImdyuuBJ0B5LfPMvfFp3bHgcHC7RdEV2NLfshVQj8c2HCgn+VPVryeyHgHZykmCLBxeoyY444Ngp3k/NmIRAzDKMgg0sfymRYqGTwUrcRLuqK/4/CsLyyydAd7gYI4nTdrVRbzrFgstc8tq2zaXSEm+ZBRMvI+CqQCWD6ldojsYd/jWh42vbpNpgac8PJ8BFAoj7BO1/beKVUqR5uh2UzzoAOYfxE/P7cZ7oBG74/4HWfilxaF/dgB41wK96gg848JpxKSJ3s8k4cm9DDDu5MfVPmewI/H85fuVsR2YSAt9U8+Cw3ultH9flFwUv1bFGaHsCK1Q7DXZboAkHDlrTpU7PT91WY40wUsRwLARtWpiLd8Yxj5rMceAJQogvG2vMMK3abhST7bxVNqBBz+vXxDHBLObImAxN2MTK4sbd/mrXSZk0RCGDUniOK4han1K+LKyzStgQ/tV26fur+TQ85VWjAiI8sTi6L5gUMyb3Vmd99Q+xMSforY5Zqu7PsFSiCAf4YuUrAMqAey95B6Q/ePMDsJO2VNq69k0Haxrh7jxF73880sSWy99vezhraUvgjqo3oYpxxQYx125Ekp2gqKOVf4pK06RPYlVm7LPwSEp0+DJj8uKTVyE2HA9jPsonF0ZPB92+8wPq4M0wQV7nxS76vxmsgt/uetoJzgliEUnNK/pBkwPAYBdPdcUcVqqzopxgT42Dtt8U=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b27953-431b-46c4-3905-08d7ea83b4de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:19:29.4720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5iJfRrNEx5YskMJZ12EGS49h0U3ekqe+yrsKnAaTgXaDgYUY26b8IIPjy9rlIktP/7EC6p1fdS+T32T2kZrU3g6quDAXfU8sf9PA+utVKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4594
Received-SPF: pass client-ip=40.107.14.128;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:34:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.128
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



On 25.04.2020 12:10, Vladimir Sementsov-Ogievskiy wrote:
> 13.04.2020 14:12, Denis Plotnikov wrote:
>> The patch adds ability to qemu-file to write the data
>> asynchronously to improve the performance on writing.
>> Before, only synchronous writing was supported.
>>
>> Enabling of the asyncronous mode is managed by new
>> "enabled_buffered" callback.
>
> Hmm.
>
> I don't like resulting architecture very much:
>
> 1. Function naming is not clean: how can I understand that copy_buf is 
> for buffered mode when add_to_iovec is +- same thing for non-buffered 
> mode?
Yes, this is to be changed in the next patches
>
> Hmm actually, you just alter several significant functions of QEMUFile 
> - open, close, put, flush. In old mode we do one thing, in a new mode 
> - absolutely another. This looks like a driver. So may be we want to 
> add QEMUFileDriver struct, to define these functions as callbacks, 
> move old realizations to default driver, and add new functionality as 
> a new driver, what do you think?
Yes it looks like that, but on the other hand I can't imagine another 
driver to be added and changing the code to "the driver notation" would 
involve more code adding. So, should we really do that. Anyway, your 
suggestion looks cleaner.
>
> 2. Terminology: you say you add buffered mode, but actually qemu file 
> is already work in buffered mode, so it should be clarified somehow..
The initial implementation uses mixed implementation, it has a buffer 
and an iovec array. The buffer is used to store *some* parts (ecluding 
RAM) of a vm state + service information. Each written to the buffer is 
added to the iovec array as a separate entry. RAM pages aren't added to 
the buffer, instead they are added to the iovec array directly without 
coping to the buffer. This is why we almost always get the iovec array 
consisting of size- and pointer- unaligned iovec-s and why we have the 
performance issues (more detailed in 0000 of this series).
So, I can't say that the qemu-file has "real" buffered-mode.
> You also add asynchronisity, but old implementation has already 
> qemu_put_buffer_async..
In my opinion, this function name is kind of confusing. What the 
function does is adding the buffer pointer to the internal iovec array 
without coping the buffer. It's not related to some asynchronous operation.
> You use aio task pool, but don't say that it may be used only from 
> coroutine.
> May be, we'd better call it "coroutine-mode" ?
I don't think that mentioning any implementation-specific name is a good 
idea. aio_task_pool is a good option to implement async operation, but 
it can be any other interface.
I'd rather implicitly assert qemu_in_coroutine() when in "buffered-mode".
>
>
> Also, am I correct that new mode can't be used for read? Should we 
> document/assert it somehow? 
It can't just for now since read-buffered mode isn't implemented. 
Enabling buffered-mode for reading affects nothing - qemu-file works as 
before.
The same qemu-file instance can't  be opened for reading and writing at 
the same time. I'd add that assert on qemu-file open.
> Or may be support reading? Will switch to snapshot benefit if we 
> implement reading in a new mode?
I thought about that. I think it could benefit making some kind of 
read-ahead to a number of buffers, while the "current" buffer is used to 
fill a vm state.
I didn't want to focus on the reading improvements because it's not that 
big problem in comparison to the writing. The qemu-file reading uses a 
buffer and fills  that buffer with a single io operation.

>
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> ---
>>   include/qemu/typedefs.h |   1 +
>>   migration/qemu-file.c   | 351 
>> +++++++++++++++++++++++++++++++++++++++++++++---
>>   migration/qemu-file.h   |   9 ++
>>   3 files changed, 339 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>> index 88dce54..9b388c8 100644
>> --- a/include/qemu/typedefs.h
>> +++ b/include/qemu/typedefs.h
>> @@ -98,6 +98,7 @@ typedef struct QEMUBH QEMUBH;
>>   typedef struct QemuConsole QemuConsole;
>>   typedef struct QEMUFile QEMUFile;
>>   typedef struct QEMUFileBuffer QEMUFileBuffer;
>> +typedef struct QEMUFileAioTask QEMUFileAioTask;
>>   typedef struct QemuLockable QemuLockable;
>>   typedef struct QemuMutex QemuMutex;
>>   typedef struct QemuOpt QemuOpt;
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 285c6ef..f42f949 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -29,19 +29,25 @@
>>   #include "qemu-file.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "block/aio_task.h"
>>   -#define IO_BUF_SIZE 32768
>> +#define IO_BUF_SIZE (1024 * 1024)
>>   #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
>> +#define IO_BUF_NUM 2
>
> Interesting, how much is it better than if we set to 1, limiting the 
> influence of the series to alignment of written chunks?
>> +#define IO_BUF_ALIGNMENT 512
>>   -QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
>> +QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, IO_BUF_ALIGNMENT));
>> +QEMU_BUILD_BUG_ON(IO_BUF_SIZE > INT_MAX);
>> +QEMU_BUILD_BUG_ON(IO_BUF_NUM <= 0);
>>     struct QEMUFileBuffer {
>>       int buf_index;
>> -    int buf_size; /* 0 when writing */
>> +    int buf_size; /* 0 when non-buffered writing */
>>       uint8_t *buf;
>>       unsigned long *may_free;
>>       struct iovec *iov;
>>       unsigned int iovcnt;
>> +    QLIST_ENTRY(QEMUFileBuffer) link;
>>   };
>>     struct QEMUFile {
>> @@ -60,6 +66,22 @@ struct QEMUFile {
>>       bool shutdown;
>>       /* currently used buffer */
>>       QEMUFileBuffer *current_buf;
>> +    /*
>> +     * with buffered_mode enabled all the data copied to 512 byte
>> +     * aligned buffer, including iov data. Then the buffer is passed
>> +     * to writev_buffer callback.
>> +     */
>> +    bool buffered_mode;
>> +    /* for async buffer writing */
>> +    AioTaskPool *pool;
>> +    /* the list of free buffers, currently used on is NOT there */
>> +    QLIST_HEAD(, QEMUFileBuffer) free_buffers;
>> +};
>> +
>> +struct QEMUFileAioTask {
>> +    AioTask task;
>> +    QEMUFile *f;
>> +    QEMUFileBuffer *fb;
>>   };
>>     /*
>> @@ -115,10 +137,42 @@ QEMUFile *qemu_fopen_ops(void *opaque, const 
>> QEMUFileOps *ops)
>>       f->opaque = opaque;
>>       f->ops = ops;
>>   -    f->current_buf = g_new0(QEMUFileBuffer, 1);
>> -    f->current_buf->buf = g_malloc(IO_BUF_SIZE);
>> -    f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
>> -    f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
>> +    if (f->ops->enable_buffered) {
>> +        f->buffered_mode = f->ops->enable_buffered(f->opaque);
>> +    }
>> +
>> +    if (f->buffered_mode && qemu_file_is_writable(f)) {
>
> So we actually go to buffered_mode if file is writable. Then, 
> shouldn't we otherwise set buffered_mode to false otherwise?
buffered_mode is initialized with false
>
>> +        int i;
>> +        /*
>> +         * in buffered_mode we don't use internal io vectors
>> +         * and may_free bitmap, because we copy the data to be
>> +         * written right away to the buffer
>> +         */
>> +        f->pool = aio_task_pool_new(IO_BUF_NUM);
>> +
>> +        /* allocate io buffers */
>> +        for (i = 0; i < IO_BUF_NUM; i++) {
>> +            QEMUFileBuffer *fb = g_new0(QEMUFileBuffer, 1);
>> +
>> +            fb->buf = qemu_memalign(IO_BUF_ALIGNMENT, IO_BUF_SIZE);
>> +            fb->buf_size = IO_BUF_SIZE;
>> +
>> +            /*
>> +             * put the first buffer to the current buf and the rest
>> +             * to the list of free buffers
>> +             */
>> +            if (i == 0) {
>> +                f->current_buf = fb;
>> +            } else {
>> +                QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
>> +            }
>> +        }
>> +    } else {
>> +        f->current_buf = g_new0(QEMUFileBuffer, 1);
>> +        f->current_buf->buf = g_malloc(IO_BUF_SIZE);
>> +        f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
>> +        f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
>> +    }
>>         return f;
>>   }
>> @@ -190,6 +244,8 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>       unsigned long idx;
>>       QEMUFileBuffer *fb = f->current_buf;
>>   +    assert(!f->buffered_mode);
>> +
>>       /* Find and release all the contiguous memory ranges marked as 
>> may_free. */
>>       idx = find_next_bit(fb->may_free, fb->iovcnt, 0);
>>       if (idx >= fb->iovcnt) {
>> @@ -221,6 +277,147 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>       bitmap_zero(fb->may_free, MAX_IOV_SIZE);
>>   }
>>   +static void advance_buf_ptr(QEMUFile *f, size_t size)
>> +{
>> +    QEMUFileBuffer *fb = f->current_buf;
>> +    /* must not advance to 0 */
>> +    assert(size);
>> +    /* must not overflow buf_index (int) */
>> +    assert(fb->buf_index + size <= INT_MAX);
>
> to not overflow in check: assert(fb->buf_index <= INT_MAX - size)
good catch
>
>> +    /* must not exceed buf_size */
>> +    assert(fb->buf_index + size <= fb->buf_size);
>> +
>> +    fb->buf_index += size;
>> +}
>> +
>> +static size_t get_buf_free_size(QEMUFile *f)
>> +{
>> +    QEMUFileBuffer *fb = f->current_buf;
>> +    /* buf_index can't be greated than buf_size */
>> +    assert(fb->buf_size >= fb->buf_index);
>> +    return fb->buf_size - fb->buf_index;
>> +}
>> +
>> +static size_t get_buf_used_size(QEMUFile *f)
>> +{
>> +    QEMUFileBuffer *fb = f->current_buf;
>> +    return fb->buf_index;
>> +}
>> +
>> +static uint8_t *get_buf_ptr(QEMUFile *f)
>> +{
>> +    QEMUFileBuffer *fb = f->current_buf;
>> +    /* protects from out of bound reading */
>> +    assert(fb->buf_index <= IO_BUF_SIZE);
>> +    return fb->buf + fb->buf_index;
>> +}
>> +
>> +static bool buf_is_full(QEMUFile *f)
>> +{
>> +    return get_buf_free_size(f) == 0;
>> +}
>> +
>> +static void reset_buf(QEMUFile *f)
>> +{
>> +    QEMUFileBuffer *fb = f->current_buf;
>> +    fb->buf_index = 0;
>> +}
>> +
>> +static int write_task_fn(AioTask *task)
>> +{
>> +    int ret;
>> +    Error *local_error = NULL;
>> +    QEMUFileAioTask *t = (QEMUFileAioTask *) task;
>> +    QEMUFile *f = t->f;
>> +    QEMUFileBuffer *fb = t->fb;
>> +    uint64_t pos = f->pos;
>> +    struct iovec v = (struct iovec) {
>> +        .iov_base = fb->buf,
>> +        .iov_len = fb->buf_index,
>> +    };
>> +
>> +    assert(f->buffered_mode);
>> +
>> +    /*
>> +     * Increment file position.
>> +     * This needs to be here before calling writev_buffer, because
>> +     * writev_buffer is asynchronous and there could be more than one
>> +     * writev_buffer started simultaniously. Each writev_buffer should
>> +     * use its own file pos to write to. writev_buffer may write less
>> +     * than buf_index bytes but we treat this situation as an error.
>> +     * If error appeared, further file using is meaningless.
>> +     * We expect that, the most of the time the full buffer is written,
>> +     * (when buf_size == buf_index). The only case when the non-full
>> +     * buffer is written (buf_size != buf_index) is file close,
>> +     * when we need to flush the rest of the buffer content.
>> +     */
>> +    f->pos += fb->buf_index;
>
> Seems safer to add pos to QEMUFileAioTask instead, and manage global 
> f->pos
> in main coroutine, not in tasks.
I also though about that but I didn't find any benefit because with 
couroutines we shouldn't get race problems
>
>> +
>> +    ret = f->ops->writev_buffer(f->opaque, &v, 1, pos, &local_error);
>> +
>> +    /* return the just written buffer to the free list */
>> +    QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
>> +
>> +    /* check that we have written everything */
>> +    if (ret != fb->buf_index) {
>> +        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
>> +    }
>> +
>> +    /*
>> +     * always return 0 - don't use task error handling, relay on
>> +     * qemu file error handling
>> +     */
>> +    return 0;
>> +}
>> +
>> +static void qemu_file_switch_current_buf(QEMUFile *f)
>> +{
>> +    /*
>> +     * if the list is empty, wait until some task returns a buffer
>> +     * to the list of free buffers.
>> +     */
>> +    if (QLIST_EMPTY(&f->free_buffers)) {
>> +        aio_task_pool_wait_slot(f->pool);
>> +    }
>> +
>> +    /*
>> +     * sanity check that the list isn't empty
>> +     * if the free list was empty, we waited for a task complition,
>> +     * and the pompleted task must return a buffer to a list of free 
>> buffers
>> +     */
>> +    assert(!QLIST_EMPTY(&f->free_buffers));
>> +
>> +    /* set the current buffer for using from the free list */
>> +    f->current_buf = QLIST_FIRST(&f->free_buffers);
>> +    reset_buf(f);
>> +
>> +    QLIST_REMOVE(f->current_buf, link);
>> +}
>> +
>> +/**
>> + *  Asynchronously flushes QEMUFile buffer
>> + *
>> + * This will flush all pending data. If data was only partially 
>> flushed, it
>> + * will set an error state. The function may return before the data 
>> actually
>> + * written.
>> + */
>> +static void flush_buffer(QEMUFile *f)
>> +{
>> +    QEMUFileAioTask *t = g_new(QEMUFileAioTask, 1);
>> +
>> +    *t = (QEMUFileAioTask) {
>> +        .task.func = &write_task_fn,
>> +        .f = f,
>> +        .fb = f->current_buf,
>> +    };
>> +
>> +    /* aio_task_pool should free t for us */
>> +    aio_task_pool_start_task(f->pool, (AioTask *) t);
>> +
>> +    /* if no errors this will switch the buffer */
>> +    qemu_file_switch_current_buf(f);
>> +}
>> +
>>   /**
>>    * Flushes QEMUFile buffer
>>    *
>> @@ -241,7 +438,13 @@ void qemu_fflush(QEMUFile *f)
>>       if (f->shutdown) {
>>           return;
>>       }
>> +
>> +    if (f->buffered_mode) {
>> +        return;
>
> I don't think it's correct. qemu_fflush is public interface of 
> QEMUFile and it's assumed to write all in-flight data.
Yes it should, when you use sockets and you want to make sure that 
you've sent what your peer is waiting for.
But this isn't the case when you write an internal snapshot, especially 
when you explicitly ask to open qemu-file in "buffered_mode".
>
>> +    }
>> +
>>       if (fb->iovcnt > 0) {
>> +        /* this is non-buffered mode */
>>           expect = iov_size(fb->iov, fb->iovcnt);
>>           ret = f->ops->writev_buffer(f->opaque, fb->iov, fb->iovcnt, 
>> f->pos,
>>                                       &local_error);
>> @@ -378,6 +581,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>>     void qemu_update_position(QEMUFile *f, size_t size)
>>   {
>> +    assert(!f->buffered_mode);
>
> Public interface. Why are you sure that it's not used in snapshot? It 
> is used in migration/ram.c ...
Looks like on reading... I didn't encounter that assert on writing when 
testing. Add this protection just in case, because ...
>
>>       f->pos += size;
>
> And it shouldn't be the problem for the new mode, just ass pos 
> parameter to QEMUFileAioTask,
...It could be a problem. In the new mode we want our buffers 
size-aligned, if we update pos, we need to fill the rest of the buffer 
with zeros, put the buffer for writing, get another free buffer for using.
But I didn't see qemu_update_position() using in writing path.
>
>>   }
>>   @@ -392,7 +596,18 @@ void qemu_update_position(QEMUFile *f, size_t 
>> size)
>>   int qemu_fclose(QEMUFile *f)
>>   {
>>       int ret;
>> -    qemu_fflush(f);
>> +
>> +    if (qemu_file_is_writable(f) && f->buffered_mode) {
>> +        ret = qemu_file_get_error(f);
>> +        if (!ret) {
>> +            flush_buffer(f);
>> +        }
>> +        /* wait until all tasks are done */
>> +        aio_task_pool_wait_all(f->pool);
>> +    } else {
>> +        qemu_fflush(f);
>> +    }
>
> Again, not clean thing: for buffered mode we use flush_buffer, for 
> non-buffered we use qemu_fflush.. It's not clean from function naming.
Will improve the naming
>
>> +
>>       ret = qemu_file_get_error(f);
>>         if (f->ops->close) {
>> @@ -408,16 +623,77 @@ int qemu_fclose(QEMUFile *f)
>>           ret = f->last_error;
>>       }
>>       error_free(f->last_error_obj);
>> -    g_free(f->current_buf->buf);
>> -    g_free(f->current_buf->iov);
>> -    g_free(f->current_buf->may_free);
>> -    g_free(f->current_buf);
>> +
>> +    if (f->buffered_mode) {
>> +        QEMUFileBuffer *fb, *next;
>> +        /*
>> +         * put the current back to the free buffers list
>> +         * to destroy all the buffers in one loop
>> +         */
>> +        QLIST_INSERT_HEAD(&f->free_buffers, f->current_buf, link);
>> +
>> +        /* destroy all the buffers */
>> +        QLIST_FOREACH_SAFE(fb, &f->free_buffers, link, next) {
>> +            QLIST_REMOVE(fb, link);
>> +            /* looks like qemu_vfree pairs with qemu_memalign */
>> +            qemu_vfree(fb->buf);
>> +            g_free(fb);
>> +        }
>> +        g_free(f->pool);
>> +    } else {
>> +        g_free(f->current_buf->buf);
>> +        g_free(f->current_buf->iov);
>> +        g_free(f->current_buf->may_free);
>> +        g_free(f->current_buf);
>> +    }
>> +
>>       g_free(f);
>>       trace_qemu_file_fclose();
>>       return ret;
>>   }
>>     /*
>> + * Copy an external buffer to the intenal current buffer.
>> + */
>> +static void copy_buf(QEMUFile *f, const uint8_t *buf, size_t size,
>> +                     bool may_free)
>> +{
>> +    size_t data_size = size;
>> +    const uint8_t *src_ptr = buf;
>> +
>> +    assert(f->buffered_mode);
>> +    assert(size <= INT_MAX);
>> +
>> +    while (data_size > 0) {
>> +        size_t chunk_size;
>> +
>> +        if (buf_is_full(f)) {
>> +            flush_buffer(f);
>> +            if (qemu_file_get_error(f)) {
>> +                return;
>> +            }
>> +        }
>> +
>> +        chunk_size = MIN(get_buf_free_size(f), data_size);
>> +
>> +        memcpy(get_buf_ptr(f), src_ptr, chunk_size);
>> +
>> +        advance_buf_ptr(f, chunk_size);
>> +
>> +        src_ptr += chunk_size;
>> +        data_size -= chunk_size;
>> +        f->bytes_xfer += chunk_size;
>> +    }
>> +
>> +    if (may_free) {
>> +        if (qemu_madvise((void *) buf, size, QEMU_MADV_DONTNEED) < 0) {
>> +            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
>> +                         buf, size, strerror(errno));
>> +        }
>> +    }
>> +}
>> +
>> +/*
>>    * Add buf to iovec. Do flush if iovec is full.
>>    *
>>    * Return values:
>> @@ -454,6 +730,9 @@ static int add_to_iovec(QEMUFile *f, const 
>> uint8_t *buf, size_t size,
>>   static void add_buf_to_iovec(QEMUFile *f, size_t len)
>>   {
>>       QEMUFileBuffer *fb = f->current_buf;
>> +
>> +    assert(!f->buffered_mode);
>> +
>>       if (!add_to_iovec(f, fb->buf + fb->buf_index, len, false)) {
>>           fb->buf_index += len;
>>           if (fb->buf_index == IO_BUF_SIZE) {
>> @@ -469,8 +748,12 @@ void qemu_put_buffer_async(QEMUFile *f, const 
>> uint8_t *buf, size_t size,
>>           return;
>>       }
>>   -    f->bytes_xfer += size;
>> -    add_to_iovec(f, buf, size, may_free);
>> +    if (f->buffered_mode) {
>> +        copy_buf(f, buf, size, may_free);
>> +    } else {
>> +        f->bytes_xfer += size;
>> +        add_to_iovec(f, buf, size, may_free);
>> +    }
>>   }
>>     void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>> @@ -482,6 +765,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t 
>> *buf, size_t size)
>>           return;
>>       }
>>   +    if (f->buffered_mode) {
>> +        copy_buf(f, buf, size, false);
>> +        return;
>> +    }
>> +
>>       while (size > 0) {
>>           l = IO_BUF_SIZE - fb->buf_index;
>>           if (l > size) {
>> @@ -506,15 +794,21 @@ void qemu_put_byte(QEMUFile *f, int v)
>>           return;
>>       }
>>   -    fb->buf[fb->buf_index] = v;
>> -    f->bytes_xfer++;
>> -    add_buf_to_iovec(f, 1);
>> +    if (f->buffered_mode) {
>> +        copy_buf(f, (const uint8_t *) &v, 1, false);
>> +    } else {
>> +        fb->buf[fb->buf_index] = v;
>> +        add_buf_to_iovec(f, 1);
>> +        f->bytes_xfer++;
>> +    }
>>   }
>>     void qemu_file_skip(QEMUFile *f, int size)
>>   {
>>       QEMUFileBuffer *fb = f->current_buf;
>>   +    assert(!f->buffered_mode);
>> +
>>       if (fb->buf_index + size <= fb->buf_size) {
>>           fb->buf_index += size;
>>       }
>> @@ -672,10 +966,14 @@ int64_t qemu_ftell_fast(QEMUFile *f)
>>   {
>>       int64_t ret = f->pos;
>>       int i;
>> -    QEMUFileBuffer *fb = f->current_buf;
>>   -    for (i = 0; i < fb->iovcnt; i++) {
>> -        ret += fb->iov[i].iov_len;
>> +    if (f->buffered_mode) {
>> +        ret += get_buf_used_size(f);
>> +    } else {
>> +        QEMUFileBuffer *fb = f->current_buf;
>> +        for (i = 0; i < fb->iovcnt; i++) {
>> +            ret += fb->iov[i].iov_len;
>> +        }
>>       }
>>         return ret;
>> @@ -683,8 +981,12 @@ int64_t qemu_ftell_fast(QEMUFile *f)
>>     int64_t qemu_ftell(QEMUFile *f)
>>   {
>> -    qemu_fflush(f);
>> -    return f->pos;
>> +    if (f->buffered_mode) {
>> +        return qemu_ftell_fast(f);
>> +    } else {
>> +        qemu_fflush(f);
>> +        return f->pos;
>> +    }
>>   }
>>     int qemu_file_rate_limit(QEMUFile *f)
>> @@ -803,6 +1105,8 @@ ssize_t qemu_put_compression_data(QEMUFile *f, 
>> z_stream *stream,
>>       QEMUFileBuffer *fb = f->current_buf;
>>       ssize_t blen = IO_BUF_SIZE - fb->buf_index - sizeof(int32_t);
>>   +    assert(!f->buffered_mode);
>> +
>>       if (blen < compressBound(size)) {
>>           return -1;
>>       }
>> @@ -827,6 +1131,9 @@ int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile 
>> *f_src)
>>       int len = 0;
>>       QEMUFileBuffer *fb_src = f_src->current_buf;
>>   +    assert(!f_des->buffered_mode);
>> +    assert(!f_src->buffered_mode);
>> +
>>       if (fb_src->buf_index > 0) {
>>           len = fb_src->buf_index;
>>           qemu_put_buffer(f_des, fb_src->buf, fb_src->buf_index);
>> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>> index a9b6d6c..08655d2 100644
>> --- a/migration/qemu-file.h
>> +++ b/migration/qemu-file.h
>> @@ -103,6 +103,14 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
>>   typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
>>                                      Error **errp);
>>   +/*
>> + * Enables or disables the buffered mode
>> + * Existing blocking reads/writes must be woken
>> + * Returns true if the buffered mode has to be enabled,
>> + * false if it has to be disabled.
>> + */
>> +typedef bool (QEMUFileEnableBufferedFunc)(void *opaque);
>> +
>>   typedef struct QEMUFileOps {
>>       QEMUFileGetBufferFunc *get_buffer;
>>       QEMUFileCloseFunc *close;
>> @@ -110,6 +118,7 @@ typedef struct QEMUFileOps {
>>       QEMUFileWritevBufferFunc *writev_buffer;
>>       QEMURetPathFunc *get_return_path;
>>       QEMUFileShutdownFunc *shut_down;
>> +    QEMUFileEnableBufferedFunc *enable_buffered;
>>   } QEMUFileOps;
>>     typedef struct QEMUFileHooks {
>>
>
>



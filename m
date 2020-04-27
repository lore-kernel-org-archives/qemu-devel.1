Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C7DC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4BB20661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rmxux5BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4BB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz3a-0001y5-Uv
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jSz1f-0008EU-Ho
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jSz1d-0003zM-CS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:22:02 -0400
Received: from mail-eopbgr40125.outbound.protection.outlook.com
 ([40.107.4.125]:56959 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jSz1c-0003yl-E5
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:22:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHspCFaIib2zZBnn+TX2w+9RmRgsW2UP5atPxtiee4mBOKyf9pBQuvE27/vJs+emvj+BQiL0cDuoaD6Co4FUQUksDyz1TZQ5Aslnwo8BvJm1/JaBlKe0ZEoo93PP1J3PXZB+tUtUzhf9uyjBpsmTqUVlNdfbQbypphMevYaSd8VGw56cKhgqPN1D1UlF9tgcafDlobiTcCnltTYA+re6mQrwU7bZfNOHqm5zmp1ip8WYkR/A0Em9GtigQNtSX0NhzZbco9cgfF6DmDLRJPhy/UvQzhypB+jrfVKNqoaXU7TzUtDb3MkrJsszprTWCQQ/sWNqH4U1dttKjzgeayGdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWkvXudNUpRRNfMH1RynLxHX8P9GraOP6zi7VaNj6PY=;
 b=ArwsXe9DpjHRDIGg98t7RfPcHHhtMvDbF5oeUQrblwrVaXnB/ofAY/1RJMe1B4mSt32XIyHq8EfmOlkUzwjGA5TM1c65dA5httBrDOYMpzGoPSS9sw/tKdpEspD9mDWejwZ1ExG3ny8Yd/wJH2CQs25TVlkkIR5PCy6y8WdIdYamBiaXYQwvB5wzirp+dPnq/2Br0+nrHzdYK3E03ucosGx69Jhd4ZS3/IUC/ayXqmYduQvuAT+d5ehnh7fDkzJ9G9sfJrjdRuRclde6dPBQ+aMgwJ67OpPsRSrOYekcQvaiXybiwxwh28IeYWZR2xuy7NTJ8sW38XkINV8LFFOrDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWkvXudNUpRRNfMH1RynLxHX8P9GraOP6zi7VaNj6PY=;
 b=rmxux5BTpg+c62Bn7dlyWGLPJdR3EY7JMLutl7yKGjxvspXUUptcE2lEhza7mbtVB0FIfwn1J3LE2hWr+68zNdGcHkiKU6sg7zxRJQX2cPpQWc4cp8tHy9fQ16DocPyN2u+GtMoxeKbi5LQs/0WBwosJy8BWrJAIcuoGwNPulWs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB5090.eurprd08.prod.outlook.com (2603:10a6:208:15c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:21:57 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:21:57 +0000
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
 <9bb27377-49e5-75de-fc7e-4846f05478e2@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <f7a43ea1-1db8-a047-8b35-863dc1b903c4@virtuozzo.com>
Date: Mon, 27 Apr 2020 11:21:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <9bb27377-49e5-75de-fc7e-4846f05478e2@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::27) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (94.233.240.57) by
 FR2P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:21:56 +0000
X-Originating-IP: [94.233.240.57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab8a9b37-feb3-4728-03b1-08d7ea840d14
X-MS-TrafficTypeDiagnostic: AM0PR08MB5090:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5090185A8B6623883A0AB8D1CFAF0@AM0PR08MB5090.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(4326008)(31696002)(186003)(8676002)(86362001)(5660300002)(53546011)(52116002)(31686004)(6486002)(16526019)(956004)(2616005)(66476007)(66946007)(316002)(478600001)(36756003)(16576012)(66556008)(8936002)(26005)(2906002)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udGJEozZFEYDbjcRMDAtJwU0EAUGRXriVTtodimDlIL/3MhpBfdZT0JPZakpcKDxEkQJKgTpxgQtoWLerra1dFJtThEGXzvJ1Uq4b5MyYd5Ff65leH6ByT6K9BijjQ3RRGvf5prCBm30kGpP/llKojLvsYB9S7kJLIsfUCxFbwE7NWafOWPHlDm0b1RcJTsE3fFnSl8Qk5Wn3o9EF1EO6fnc752VjRjObbbDg4+Imj+Bn+Vh1i7VoXuoUnmKqIlpBtQpXKVxaPQLlSqewUHiWp+CT1lYsJVIzfnB8ee+9cj6Cl9rISTD92ctG1uIsml0AgibwF28B/L/TGd3CULz2X8yjhAX4ShpJ7qxsT5MPMF793VxUU8YzDPCBtmAH9/iR8TPGItQH0UW7kwSkXIsruWiCIYgFzRj9xKFTo+nO4Y+sSxtuR1HUJa1zevtsFiQ
X-MS-Exchange-AntiSpam-MessageData: +K0XcQdECDw9OIhj6nbQGzCzRMGDd19Q6G6Y+3glAM5zLStfrmyoxSjVUlvBfnUZWvB7gYbK4KpMHSPbPhw8paHx+NOTAQTSXwugGSK7F9NzJatEu7aVyZ0YudA7HT8w/jDkAYZaIVyzrCY6usPsYv+i1pRy13pg6bQIQn0YBNSFUYHXmEO1dWmMMT0cDs8MX2XvwUeDitVRfoCzq9WHIdonaHaM0+Eg0g7AYfu5f21qt4KLMigtJdCus3rWEF+go4gtiIVopHXyYJ3JNpbnkX3aI0MzLJEGvN0o4meExqe6zeRCoNzorDUmv05ktlLAejNlERRA8iHzTvQoANOg7x8XIrGnaMIiRSTL+uuHDLyIp+y07OMc4fMVJNRWP0mn1GtP4eRLN4/06HzjStQTPB+19YbxZojDA/HlxiWXSXlmYLYga0H/ETGs+nFjKYXcIZ5708c4/9mpEJt4+8EW6G06NztawocLvCIHYM2A8Jf+6dPDpFbg+fbztUn5MS7XY+EFL2VlGi1MH0Pz7WQMAnmVwmM4Ftl6ZjZT3dd4vrbCInj4qLln8/drrRZ8LpP6u+xhEdinX4me6l+LI1PcKhE+bTjXL+Wd2+VOV7lrKvXZScKaNZRMO+AJ77htKCOK8Ktj6EGQtSETQaUGthxC0hO+SlcTjzNTtBx8XfeZ80fk57gs6uMVNGt79B7T0kgoqhlKdWDlxntRFl/BA0x1EoHd3IZQLLGBIcS9S12oZAkDBRupyfOKwCfJJ7YvYbuOnZAQRdVZSM5qLw6u31w3mLDNm0gD/dJh4SK7hvJmJIE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8a9b37-feb3-4728-03b1-08d7ea840d14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:21:57.4141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETY1g6M5tkQ9ul/nfy71zsReMqMpqhJdqAoB9BWpubiMhk2Fa5k29SBg0ub9R7yrjeCqrEzAoJJlhy1Ffdb558RUwfms3OBBO5JkW5A/FxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5090
Received-SPF: pass client-ip=40.107.4.125;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:21:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.125
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



On 25.04.2020 00:25, Eric Blake wrote:
> On 4/13/20 6:12 AM, Denis Plotnikov wrote:
>> The patch adds ability to qemu-file to write the data
>> asynchronously to improve the performance on writing.
>> Before, only synchronous writing was supported.
>>
>> Enabling of the asyncronous mode is managed by new
>
> asynchronous
>
>> "enabled_buffered" callback.
>
> The term "enabled_buffered" does not appear in the patch.  Did you 
> mean...
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
>
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
>
> ..."Asynchronous mode is managed by setting the new buffered_mode 
> flag"?  ...
>
>
>> +    /* for async buffer writing */
>> +    AioTaskPool *pool;
>> +    /* the list of free buffers, currently used on is NOT there */
>
> s/on/one/
>
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
>
> ...ah, you meant 'enable_buffered'.  But still, why do we need a 
> callback function?  Is it not sufficient to just have a bool flag?
>
>
>> +static size_t get_buf_free_size(QEMUFile *f)
>> +{
>> +    QEMUFileBuffer *fb = f->current_buf;
>> +    /* buf_index can't be greated than buf_size */
>
> greater
>
>> +    assert(fb->buf_size >= fb->buf_index);
>> +    return fb->buf_size - fb->buf_index;
>> +}
>> +
>
>> +static int write_task_fn(AioTask *task)
>> +{
>
>> +    /*
>> +     * Increment file position.
>> +     * This needs to be here before calling writev_buffer, because
>> +     * writev_buffer is asynchronous and there could be more than one
>> +     * writev_buffer started simultaniously. Each writev_buffer should
>
> simultaneously
>
>> +     * use its own file pos to write to. writev_buffer may write less
>> +     * than buf_index bytes but we treat this situation as an error.
>> +     * If error appeared, further file using is meaningless.
>
> s/using/use/
>
>> +     * We expect that, the most of the time the full buffer is written,
>> +     * (when buf_size == buf_index). The only case when the non-full
>> +     * buffer is written (buf_size != buf_index) is file close,
>> +     * when we need to flush the rest of the buffer content.
>
> We expect that most of the time, the full buffer will be written 
> (buf_size == buf_index), with the exception at file close where we 
> need to flush the final partial buffer.
>
>> +     */
>> +    f->pos += fb->buf_index;
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
>
> rely
>
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
>
> completion
>
>> +     * and the pompleted task must return a buffer to a list of free 
>> buffers
>
> completed
>
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
>
>>     /*
>> + * Copy an external buffer to the intenal current buffer.
>
> internal
>
>> + */
>> +static void copy_buf(QEMUFile *f, const uint8_t *buf, size_t size,
>> +                     bool may_free)
>> +{
>
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
>
> If this never gets called outside of initial creation of the QemuFile 
> (that is, it is not dynamic), then making it a straight flag instead 
> of a callback function is simpler.
Yes, I agree.

Thanks for reviewing and lots of grammar fixing!
>
>
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



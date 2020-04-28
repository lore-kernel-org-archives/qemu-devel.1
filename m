Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BC6C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6B620731
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gFVM0OYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6B620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWrA-000088-9P
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTWnL-0004FF-Ok
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1jTWnI-00023F-KS
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:25:30 -0400
Received: from mail-eopbgr140119.outbound.protection.outlook.com
 ([40.107.14.119]:36502 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jTWnH-0001xG-FL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bv2dCVU8d1LjzVY2bTSAZoPGShvT+EYMY9iBrysd+RGYLViuMZSmCijP0sq2u7YbXxHdMr8diyvZQifX4IX+pKHrnCANrOcWW/WwTd2s+VGSdVyammpS6AxvB2BoKXRywNldpkwOzmV1DrZZ+BcuE0GdARoy953Q0Mhdh+U9TrvnMGmyBoRCGZ1KjIKcT9iREhIujKYtdpD1gZ4YvOJDC+k+kk0GWELeiijUbQa/pfjKlQi+MpSDNZHOoBkGeEmBg6lk5PSj3y1zohtrdxH5miNC1k0kMtKGSYtOo8x0+Z+G2RP7N3BgjIHQ6NemQm+q6VZm7T8IrArwvEN1RTHwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h29+x2OyAeygUlQS+BYFGD5TnFr7UxLOGFkMeFUMS4=;
 b=XyOhLrjbkkhy1TEazXzemFkB3QKdF4osUEefBCTJcshN9nzkCML1DzFk9TczLMGSoCNNRwfyGEPRxjn2dxOxmMIYixdrLpne8QCLvou4f54pUaiAXPwGUhmmoJLmz3XgUglSZGxtugivxiz84gI9F2c4+bDiDIgDsWVj1yeCEttYFDp9Cvmqhv4+vUAUBVbS1INXBpwAYhYp6hd5AWsi/IGlQGK/fX45OzAy1Jd7LGzTpIz3qhjKiDjR5KvFFTXv0pvUmBmdyCDUpdniJUnl+5sxpRFf2TDMEjvWsETYCdhZipwTGMr/phVjrVTPHgY95j1Q5XcqdPQxSlUqWMMCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3h29+x2OyAeygUlQS+BYFGD5TnFr7UxLOGFkMeFUMS4=;
 b=gFVM0OYVPdeKOqXtjR22PG+jygoTfnvaPcOTJPORawL81uGgHvtKVHf47l505V3WqIjpLKGj/ym9oq8hoPLKNAhrXgxL0LCD/jXbDZbv4w7ENRQA/EPjXk1TKEFW3TW5LTWyck91ZcApNYPg5IprZKWhc+QKI3/jvDout665RL0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB5524.eurprd08.prod.outlook.com (2603:10a6:208:181::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 20:25:24 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 20:25:24 +0000
Subject: Re: [RFC patch v1 2/3] qemu-file: add buffered mode
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
 <1586776334-641239-3-git-send-email-dplotnikov@virtuozzo.com>
 <20200427121433.GI2923@work-vm>
 <1e12e7f5-5c64-8c22-16a4-08822a6b9ec8@virtuozzo.com>
 <20200428175403.GQ2794@work-vm>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <97cb8e0b-1908-590b-fef7-cf22b519d1c1@virtuozzo.com>
Date: Tue, 28 Apr 2020 23:25:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200428175403.GQ2794@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.151.204) by
 AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 20:25:23 +0000
X-Originating-IP: [178.34.151.204]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9785412-6633-4d37-348f-08d7ebb247c4
X-MS-TrafficTypeDiagnostic: AM0PR08MB5524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5524842B6362F2C9A83018E3CFAC0@AM0PR08MB5524.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39840400004)(366004)(6916009)(86362001)(5660300002)(30864003)(2906002)(316002)(6486002)(16576012)(31696002)(8936002)(107886003)(52116002)(31686004)(26005)(956004)(2616005)(36756003)(4326008)(53546011)(8676002)(478600001)(16526019)(66946007)(186003)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZT4/TdySBiert6HoizlMeIYJHOluUP3OmI2AQr0M0Qat4q8YDkqv9j3XJzUxg3jRdFS7/D6QfywJZzr2zGZDHyHxGazaN0TAe9NQ/tPyFRq92eHFkSuHh+y47liEbd2lpk9Uprmte5G3Qpx1DRNq0Gd+BUsOWifkYMuv3NgLJ//h2L0fBlN3mM+5GtW5c8n2XPG/zuNtb6TeDkBdBWvYSR5xoSLCqBto3oH1SEYq2D9pEWZtiIg+mOndXRTuFkK5m+5OtOknR9w2PjDvDA2pLg3daEoHfYGdJ8bR2J/ToKl+9/TBDY/6seY/0geRL3Lv/Shp/kR2/qEsiKik3uTipkW3Bnxm30lvmrAb4DHSJ41csB+AhCKzXm4IjddPBNqyt+w/lQqLjnA4r262b/ucldBWnEauP5VuRIwbMUcKCgoCgz64e0X1DZhs9loVrWSQ
X-MS-Exchange-AntiSpam-MessageData: PwcMSN2vATuL9X0fqAk1AAHEFTxvergKmrQUJIa8QJzHip+hWtSXeq45NNaDbPzROk4Ivg7Ys+0mhz86lq3TRWrYbM3LBt4/WgvLtVugPbZhcozsHInSl9AxkADKhKP4G6LW/pFTI6+RrT+Fsl4y+EnFZR/zr2mRB7t+Iqla88ORQTwx07CoT/KcDZAjLWdwrEi1x3Wqvoc/neLSplUAEc5UPUANcUNFuvb4F5+7D6oKrufUgIRdVad75zq9Phu4vDVaTwgMwPPOmwZtUml4tDFJZu0FjNCSFHxedeln1htoh6jo6gNoPyHTxb8awVu4ej3x9WSv026U7XH7ROnEgQS/xtTYVsl7w42oSKjUCP0q6gFZac+li5N+wSJ/h7xrVkkLxS9RZsxkOZkdfFfe/SVJGCmCiDoMzlLAcWdtsmbse3oZ7gMku5FCt9r1HXf67nWPsMxgtas2gzcpn9G0sAR9R5epzDv7FF9Fkv5cvK8xqjXFi4UDkUe0SQj5bcHg7JZT0Orch0Yy38AwGt8lv0V/lok33zNYVqWkrPlnQMsnV2+1IBK9olwYBjIE0519lMUmXutNMeXk86APJvVS+x7b6Exwe99OBg3be0NVnTPf5/VAQ+Ddc+OjFKvspgTrTaAMlkrv9VIRb2xlbcKUsZ0kH4ZmDdMDYHdBRspr61BtVaFJKSiRWFUSWpdeExWx7lA6zslD3aaSRxm9fJ1N0CEazPPw2IO3tZErcjvOIO0x2AgpTfNRNuclgEhD1zORYFxrl9mbwctNytfK1VLEumWTumFdTOhcc/5x6PjRjB4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9785412-6633-4d37-348f-08d7ebb247c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 20:25:24.0439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb6WHOQOwWhfD7qBnXP1qu3bFBJgLP5Qp8qM3jsSJPhnkMG12Xn/8zHPyn8kCXLJAK2gYv1P3Q+lNUjtKwB/TWCeNYfQUW/cNtrODxIirmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5524
Received-SPF: pass client-ip=40.107.14.119;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 16:25:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.119
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
Cc: den@openvz.org, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 28.04.2020 20:54, Dr. David Alan Gilbert wrote:
> * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
>>
>> On 27.04.2020 15:14, Dr. David Alan Gilbert wrote:
>>> * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
>>>> The patch adds ability to qemu-file to write the data
>>>> asynchronously to improve the performance on writing.
>>>> Before, only synchronous writing was supported.
>>>>
>>>> Enabling of the asyncronous mode is managed by new
>>>> "enabled_buffered" callback.
>>> It's a bit invasive isn't it - changes a lot of functions in a lot of
>>> places!
>> If you mean changing the qemu-file code - yes, it is.
> Yeh that's what I worry about; qemu-file is pretty complex as it is.
> Especially when it then passes it to the channel code etc
>
>> If you mean changing the qemu-file usage in the code - no.
>> The only place to change is the snapshot code when the buffered mode is
>> enabled with a callback.
>> The change is in 03 patch of the series.
> That's fine - that's easy.
>
>>> The multifd code separated the control headers from the data on separate
>>> fd's - but that doesn't help your case.
>> yes, that doesn't help
>>> Is there any chance you could do this by using the existing 'save_page'
>>> hook (that RDMA uses).
>> I don't think so. My goal is to improve writing performance of
>> the internal snapshot to qcow2 image. The snapshot is saved in qcow2 as
>> continuous stream placed in the end of address space.
>> To achieve the best writing speed I need a size and base-aligned buffer
>> containing the vm state (with ram) which looks like that (related to ram):
>>
>> ... | ram page header | ram page | ram page header | ram page | ... and so
>> on
>>
>> to store the buffer in qcow2 with a single operation.
>>
>> 'save_page' would allow me not to store 'ram page' in the qemu-file internal
>> structures,
>> and write my own ram page storing logic. I think that wouldn't help me a lot
>> because:
>> 1. I need a page with the ram page header
>> 2. I want to reduce the number of io operations
>> 3. I want to save other parts of vm state as fast as possible
>>
>> May be I can't see the better way of using 'save page' callback.
>> Could you suggest anything?
> I guess it depends if we care about keeping the format of the snapshot
> the same here;  if we were open to changing it, then we could use
> the save_page hook to delay the writes, so we'd have a pile of headers
> followed by a pile of pages.

I think we have to care about keeping the format. Because many users 
already have internal snapshots
saved in the qcow2 images, if we change the format we can't load 
snapshots from those images
as well as make snapshots non-readable for older qemu-s or we need to 
support two versions of format
which I think is too complicated.

>
>> Denis
>>> In the cover letter you mention direct qemu_fflush calls - have we got a
>>> few too many in some palces that you think we can clean out?
>> I'm not sure that some of them are excessive. To the best of my knowlege,
>> qemu-file is used for the source-destination communication on migration
>> and removing some qemu_fflush-es may break communication logic.
> I can't see any obvious places where it's called during the ram
> migration; can you try and give me a hint to where you're seeing it ?

I think those qemu_fflush-es aren't in the ram migration rather than in 
other vm state parts.
Although, those parts are quite small in comparison to ram, I saw quite 
a lot of qemu_fflush-es while debugging.
Still, we could benefit saving them with fewer number of io operation if 
we going to use buffered mode.

Denis

>
>> Snapshot is just a special case (if not the only) when we know that we can
>> do buffered (cached)
>> writings. Do you know any other cases when the buffered (cached) mode could
>> be useful?
> The RDMA code does it because it's really not good at small transfers,
> but maybe generally it would be a good idea to do larger writes if
> possible - something that multifd manages.
>
> Dave
>
>>> Dave
>>>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> ---
>>>>    include/qemu/typedefs.h |   1 +
>>>>    migration/qemu-file.c   | 351 +++++++++++++++++++++++++++++++++++++++++++++---
>>>>    migration/qemu-file.h   |   9 ++
>>>>    3 files changed, 339 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>>> index 88dce54..9b388c8 100644
>>>> --- a/include/qemu/typedefs.h
>>>> +++ b/include/qemu/typedefs.h
>>>> @@ -98,6 +98,7 @@ typedef struct QEMUBH QEMUBH;
>>>>    typedef struct QemuConsole QemuConsole;
>>>>    typedef struct QEMUFile QEMUFile;
>>>>    typedef struct QEMUFileBuffer QEMUFileBuffer;
>>>> +typedef struct QEMUFileAioTask QEMUFileAioTask;
>>>>    typedef struct QemuLockable QemuLockable;
>>>>    typedef struct QemuMutex QemuMutex;
>>>>    typedef struct QemuOpt QemuOpt;
>>>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>>>> index 285c6ef..f42f949 100644
>>>> --- a/migration/qemu-file.c
>>>> +++ b/migration/qemu-file.c
>>>> @@ -29,19 +29,25 @@
>>>>    #include "qemu-file.h"
>>>>    #include "trace.h"
>>>>    #include "qapi/error.h"
>>>> +#include "block/aio_task.h"
>>>> -#define IO_BUF_SIZE 32768
>>>> +#define IO_BUF_SIZE (1024 * 1024)
>>>>    #define MAX_IOV_SIZE MIN(IOV_MAX, 64)
>>>> +#define IO_BUF_NUM 2
>>>> +#define IO_BUF_ALIGNMENT 512
>>>> -QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, 512));
>>>> +QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(IO_BUF_SIZE, IO_BUF_ALIGNMENT));
>>>> +QEMU_BUILD_BUG_ON(IO_BUF_SIZE > INT_MAX);
>>>> +QEMU_BUILD_BUG_ON(IO_BUF_NUM <= 0);
>>>>    struct QEMUFileBuffer {
>>>>        int buf_index;
>>>> -    int buf_size; /* 0 when writing */
>>>> +    int buf_size; /* 0 when non-buffered writing */
>>>>        uint8_t *buf;
>>>>        unsigned long *may_free;
>>>>        struct iovec *iov;
>>>>        unsigned int iovcnt;
>>>> +    QLIST_ENTRY(QEMUFileBuffer) link;
>>>>    };
>>>>    struct QEMUFile {
>>>> @@ -60,6 +66,22 @@ struct QEMUFile {
>>>>        bool shutdown;
>>>>        /* currently used buffer */
>>>>        QEMUFileBuffer *current_buf;
>>>> +    /*
>>>> +     * with buffered_mode enabled all the data copied to 512 byte
>>>> +     * aligned buffer, including iov data. Then the buffer is passed
>>>> +     * to writev_buffer callback.
>>>> +     */
>>>> +    bool buffered_mode;
>>>> +    /* for async buffer writing */
>>>> +    AioTaskPool *pool;
>>>> +    /* the list of free buffers, currently used on is NOT there */
>>>> +    QLIST_HEAD(, QEMUFileBuffer) free_buffers;
>>>> +};
>>>> +
>>>> +struct QEMUFileAioTask {
>>>> +    AioTask task;
>>>> +    QEMUFile *f;
>>>> +    QEMUFileBuffer *fb;
>>>>    };
>>>>    /*
>>>> @@ -115,10 +137,42 @@ QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops)
>>>>        f->opaque = opaque;
>>>>        f->ops = ops;
>>>> -    f->current_buf = g_new0(QEMUFileBuffer, 1);
>>>> -    f->current_buf->buf = g_malloc(IO_BUF_SIZE);
>>>> -    f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
>>>> -    f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
>>>> +    if (f->ops->enable_buffered) {
>>>> +        f->buffered_mode = f->ops->enable_buffered(f->opaque);
>>>> +    }
>>>> +
>>>> +    if (f->buffered_mode && qemu_file_is_writable(f)) {
>>>> +        int i;
>>>> +        /*
>>>> +         * in buffered_mode we don't use internal io vectors
>>>> +         * and may_free bitmap, because we copy the data to be
>>>> +         * written right away to the buffer
>>>> +         */
>>>> +        f->pool = aio_task_pool_new(IO_BUF_NUM);
>>>> +
>>>> +        /* allocate io buffers */
>>>> +        for (i = 0; i < IO_BUF_NUM; i++) {
>>>> +            QEMUFileBuffer *fb = g_new0(QEMUFileBuffer, 1);
>>>> +
>>>> +            fb->buf = qemu_memalign(IO_BUF_ALIGNMENT, IO_BUF_SIZE);
>>>> +            fb->buf_size = IO_BUF_SIZE;
>>>> +
>>>> +            /*
>>>> +             * put the first buffer to the current buf and the rest
>>>> +             * to the list of free buffers
>>>> +             */
>>>> +            if (i == 0) {
>>>> +                f->current_buf = fb;
>>>> +            } else {
>>>> +                QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
>>>> +            }
>>>> +        }
>>>> +    } else {
>>>> +        f->current_buf = g_new0(QEMUFileBuffer, 1);
>>>> +        f->current_buf->buf = g_malloc(IO_BUF_SIZE);
>>>> +        f->current_buf->iov = g_new0(struct iovec, MAX_IOV_SIZE);
>>>> +        f->current_buf->may_free = bitmap_new(MAX_IOV_SIZE);
>>>> +    }
>>>>        return f;
>>>>    }
>>>> @@ -190,6 +244,8 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>>>        unsigned long idx;
>>>>        QEMUFileBuffer *fb = f->current_buf;
>>>> +    assert(!f->buffered_mode);
>>>> +
>>>>        /* Find and release all the contiguous memory ranges marked as may_free. */
>>>>        idx = find_next_bit(fb->may_free, fb->iovcnt, 0);
>>>>        if (idx >= fb->iovcnt) {
>>>> @@ -221,6 +277,147 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>>>>        bitmap_zero(fb->may_free, MAX_IOV_SIZE);
>>>>    }
>>>> +static void advance_buf_ptr(QEMUFile *f, size_t size)
>>>> +{
>>>> +    QEMUFileBuffer *fb = f->current_buf;
>>>> +    /* must not advance to 0 */
>>>> +    assert(size);
>>>> +    /* must not overflow buf_index (int) */
>>>> +    assert(fb->buf_index + size <= INT_MAX);
>>>> +    /* must not exceed buf_size */
>>>> +    assert(fb->buf_index + size <= fb->buf_size);
>>>> +
>>>> +    fb->buf_index += size;
>>>> +}
>>>> +
>>>> +static size_t get_buf_free_size(QEMUFile *f)
>>>> +{
>>>> +    QEMUFileBuffer *fb = f->current_buf;
>>>> +    /* buf_index can't be greated than buf_size */
>>>> +    assert(fb->buf_size >= fb->buf_index);
>>>> +    return fb->buf_size - fb->buf_index;
>>>> +}
>>>> +
>>>> +static size_t get_buf_used_size(QEMUFile *f)
>>>> +{
>>>> +    QEMUFileBuffer *fb = f->current_buf;
>>>> +    return fb->buf_index;
>>>> +}
>>>> +
>>>> +static uint8_t *get_buf_ptr(QEMUFile *f)
>>>> +{
>>>> +    QEMUFileBuffer *fb = f->current_buf;
>>>> +    /* protects from out of bound reading */
>>>> +    assert(fb->buf_index <= IO_BUF_SIZE);
>>>> +    return fb->buf + fb->buf_index;
>>>> +}
>>>> +
>>>> +static bool buf_is_full(QEMUFile *f)
>>>> +{
>>>> +    return get_buf_free_size(f) == 0;
>>>> +}
>>>> +
>>>> +static void reset_buf(QEMUFile *f)
>>>> +{
>>>> +    QEMUFileBuffer *fb = f->current_buf;
>>>> +    fb->buf_index = 0;
>>>> +}
>>>> +
>>>> +static int write_task_fn(AioTask *task)
>>>> +{
>>>> +    int ret;
>>>> +    Error *local_error = NULL;
>>>> +    QEMUFileAioTask *t = (QEMUFileAioTask *) task;
>>>> +    QEMUFile *f = t->f;
>>>> +    QEMUFileBuffer *fb = t->fb;
>>>> +    uint64_t pos = f->pos;
>>>> +    struct iovec v = (struct iovec) {
>>>> +        .iov_base = fb->buf,
>>>> +        .iov_len = fb->buf_index,
>>>> +    };
>>>> +
>>>> +    assert(f->buffered_mode);
>>>> +
>>>> +    /*
>>>> +     * Increment file position.
>>>> +     * This needs to be here before calling writev_buffer, because
>>>> +     * writev_buffer is asynchronous and there could be more than one
>>>> +     * writev_buffer started simultaniously. Each writev_buffer should
>>>> +     * use its own file pos to write to. writev_buffer may write less
>>>> +     * than buf_index bytes but we treat this situation as an error.
>>>> +     * If error appeared, further file using is meaningless.
>>>> +     * We expect that, the most of the time the full buffer is written,
>>>> +     * (when buf_size == buf_index). The only case when the non-full
>>>> +     * buffer is written (buf_size != buf_index) is file close,
>>>> +     * when we need to flush the rest of the buffer content.
>>>> +     */
>>>> +    f->pos += fb->buf_index;
>>>> +
>>>> +    ret = f->ops->writev_buffer(f->opaque, &v, 1, pos, &local_error);
>>>> +
>>>> +    /* return the just written buffer to the free list */
>>>> +    QLIST_INSERT_HEAD(&f->free_buffers, fb, link);
>>>> +
>>>> +    /* check that we have written everything */
>>>> +    if (ret != fb->buf_index) {
>>>> +        qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * always return 0 - don't use task error handling, relay on
>>>> +     * qemu file error handling
>>>> +     */
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void qemu_file_switch_current_buf(QEMUFile *f)
>>>> +{
>>>> +    /*
>>>> +     * if the list is empty, wait until some task returns a buffer
>>>> +     * to the list of free buffers.
>>>> +     */
>>>> +    if (QLIST_EMPTY(&f->free_buffers)) {
>>>> +        aio_task_pool_wait_slot(f->pool);
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * sanity check that the list isn't empty
>>>> +     * if the free list was empty, we waited for a task complition,
>>>> +     * and the pompleted task must return a buffer to a list of free buffers
>>>> +     */
>>>> +    assert(!QLIST_EMPTY(&f->free_buffers));
>>>> +
>>>> +    /* set the current buffer for using from the free list */
>>>> +    f->current_buf = QLIST_FIRST(&f->free_buffers);
>>>> +    reset_buf(f);
>>>> +
>>>> +    QLIST_REMOVE(f->current_buf, link);
>>>> +}
>>>> +
>>>> +/**
>>>> + *  Asynchronously flushes QEMUFile buffer
>>>> + *
>>>> + * This will flush all pending data. If data was only partially flushed, it
>>>> + * will set an error state. The function may return before the data actually
>>>> + * written.
>>>> + */
>>>> +static void flush_buffer(QEMUFile *f)
>>>> +{
>>>> +    QEMUFileAioTask *t = g_new(QEMUFileAioTask, 1);
>>>> +
>>>> +    *t = (QEMUFileAioTask) {
>>>> +        .task.func = &write_task_fn,
>>>> +        .f = f,
>>>> +        .fb = f->current_buf,
>>>> +    };
>>>> +
>>>> +    /* aio_task_pool should free t for us */
>>>> +    aio_task_pool_start_task(f->pool, (AioTask *) t);
>>>> +
>>>> +    /* if no errors this will switch the buffer */
>>>> +    qemu_file_switch_current_buf(f);
>>>> +}
>>>> +
>>>>    /**
>>>>     * Flushes QEMUFile buffer
>>>>     *
>>>> @@ -241,7 +438,13 @@ void qemu_fflush(QEMUFile *f)
>>>>        if (f->shutdown) {
>>>>            return;
>>>>        }
>>>> +
>>>> +    if (f->buffered_mode) {
>>>> +        return;
>>>> +    }
>>>> +
>>>>        if (fb->iovcnt > 0) {
>>>> +        /* this is non-buffered mode */
>>>>            expect = iov_size(fb->iov, fb->iovcnt);
>>>>            ret = f->ops->writev_buffer(f->opaque, fb->iov, fb->iovcnt, f->pos,
>>>>                                        &local_error);
>>>> @@ -378,6 +581,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
>>>>    void qemu_update_position(QEMUFile *f, size_t size)
>>>>    {
>>>> +    assert(!f->buffered_mode);
>>>>        f->pos += size;
>>>>    }
>>>> @@ -392,7 +596,18 @@ void qemu_update_position(QEMUFile *f, size_t size)
>>>>    int qemu_fclose(QEMUFile *f)
>>>>    {
>>>>        int ret;
>>>> -    qemu_fflush(f);
>>>> +
>>>> +    if (qemu_file_is_writable(f) && f->buffered_mode) {
>>>> +        ret = qemu_file_get_error(f);
>>>> +        if (!ret) {
>>>> +            flush_buffer(f);
>>>> +        }
>>>> +        /* wait until all tasks are done */
>>>> +        aio_task_pool_wait_all(f->pool);
>>>> +    } else {
>>>> +        qemu_fflush(f);
>>>> +    }
>>>> +
>>>>        ret = qemu_file_get_error(f);
>>>>        if (f->ops->close) {
>>>> @@ -408,16 +623,77 @@ int qemu_fclose(QEMUFile *f)
>>>>            ret = f->last_error;
>>>>        }
>>>>        error_free(f->last_error_obj);
>>>> -    g_free(f->current_buf->buf);
>>>> -    g_free(f->current_buf->iov);
>>>> -    g_free(f->current_buf->may_free);
>>>> -    g_free(f->current_buf);
>>>> +
>>>> +    if (f->buffered_mode) {
>>>> +        QEMUFileBuffer *fb, *next;
>>>> +        /*
>>>> +         * put the current back to the free buffers list
>>>> +         * to destroy all the buffers in one loop
>>>> +         */
>>>> +        QLIST_INSERT_HEAD(&f->free_buffers, f->current_buf, link);
>>>> +
>>>> +        /* destroy all the buffers */
>>>> +        QLIST_FOREACH_SAFE(fb, &f->free_buffers, link, next) {
>>>> +            QLIST_REMOVE(fb, link);
>>>> +            /* looks like qemu_vfree pairs with qemu_memalign */
>>>> +            qemu_vfree(fb->buf);
>>>> +            g_free(fb);
>>>> +        }
>>>> +        g_free(f->pool);
>>>> +    } else {
>>>> +        g_free(f->current_buf->buf);
>>>> +        g_free(f->current_buf->iov);
>>>> +        g_free(f->current_buf->may_free);
>>>> +        g_free(f->current_buf);
>>>> +    }
>>>> +
>>>>        g_free(f);
>>>>        trace_qemu_file_fclose();
>>>>        return ret;
>>>>    }
>>>>    /*
>>>> + * Copy an external buffer to the intenal current buffer.
>>>> + */
>>>> +static void copy_buf(QEMUFile *f, const uint8_t *buf, size_t size,
>>>> +                     bool may_free)
>>>> +{
>>>> +    size_t data_size = size;
>>>> +    const uint8_t *src_ptr = buf;
>>>> +
>>>> +    assert(f->buffered_mode);
>>>> +    assert(size <= INT_MAX);
>>>> +
>>>> +    while (data_size > 0) {
>>>> +        size_t chunk_size;
>>>> +
>>>> +        if (buf_is_full(f)) {
>>>> +            flush_buffer(f);
>>>> +            if (qemu_file_get_error(f)) {
>>>> +                return;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        chunk_size = MIN(get_buf_free_size(f), data_size);
>>>> +
>>>> +        memcpy(get_buf_ptr(f), src_ptr, chunk_size);
>>>> +
>>>> +        advance_buf_ptr(f, chunk_size);
>>>> +
>>>> +        src_ptr += chunk_size;
>>>> +        data_size -= chunk_size;
>>>> +        f->bytes_xfer += chunk_size;
>>>> +    }
>>>> +
>>>> +    if (may_free) {
>>>> +        if (qemu_madvise((void *) buf, size, QEMU_MADV_DONTNEED) < 0) {
>>>> +            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
>>>> +                         buf, size, strerror(errno));
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>>     * Add buf to iovec. Do flush if iovec is full.
>>>>     *
>>>>     * Return values:
>>>> @@ -454,6 +730,9 @@ static int add_to_iovec(QEMUFile *f, const uint8_t *buf, size_t size,
>>>>    static void add_buf_to_iovec(QEMUFile *f, size_t len)
>>>>    {
>>>>        QEMUFileBuffer *fb = f->current_buf;
>>>> +
>>>> +    assert(!f->buffered_mode);
>>>> +
>>>>        if (!add_to_iovec(f, fb->buf + fb->buf_index, len, false)) {
>>>>            fb->buf_index += len;
>>>>            if (fb->buf_index == IO_BUF_SIZE) {
>>>> @@ -469,8 +748,12 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
>>>>            return;
>>>>        }
>>>> -    f->bytes_xfer += size;
>>>> -    add_to_iovec(f, buf, size, may_free);
>>>> +    if (f->buffered_mode) {
>>>> +        copy_buf(f, buf, size, may_free);
>>>> +    } else {
>>>> +        f->bytes_xfer += size;
>>>> +        add_to_iovec(f, buf, size, may_free);
>>>> +    }
>>>>    }
>>>>    void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>>>> @@ -482,6 +765,11 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
>>>>            return;
>>>>        }
>>>> +    if (f->buffered_mode) {
>>>> +        copy_buf(f, buf, size, false);
>>>> +        return;
>>>> +    }
>>>> +
>>>>        while (size > 0) {
>>>>            l = IO_BUF_SIZE - fb->buf_index;
>>>>            if (l > size) {
>>>> @@ -506,15 +794,21 @@ void qemu_put_byte(QEMUFile *f, int v)
>>>>            return;
>>>>        }
>>>> -    fb->buf[fb->buf_index] = v;
>>>> -    f->bytes_xfer++;
>>>> -    add_buf_to_iovec(f, 1);
>>>> +    if (f->buffered_mode) {
>>>> +        copy_buf(f, (const uint8_t *) &v, 1, false);
>>>> +    } else {
>>>> +        fb->buf[fb->buf_index] = v;
>>>> +        add_buf_to_iovec(f, 1);
>>>> +        f->bytes_xfer++;
>>>> +    }
>>>>    }
>>>>    void qemu_file_skip(QEMUFile *f, int size)
>>>>    {
>>>>        QEMUFileBuffer *fb = f->current_buf;
>>>> +    assert(!f->buffered_mode);
>>>> +
>>>>        if (fb->buf_index + size <= fb->buf_size) {
>>>>            fb->buf_index += size;
>>>>        }
>>>> @@ -672,10 +966,14 @@ int64_t qemu_ftell_fast(QEMUFile *f)
>>>>    {
>>>>        int64_t ret = f->pos;
>>>>        int i;
>>>> -    QEMUFileBuffer *fb = f->current_buf;
>>>> -    for (i = 0; i < fb->iovcnt; i++) {
>>>> -        ret += fb->iov[i].iov_len;
>>>> +    if (f->buffered_mode) {
>>>> +        ret += get_buf_used_size(f);
>>>> +    } else {
>>>> +        QEMUFileBuffer *fb = f->current_buf;
>>>> +        for (i = 0; i < fb->iovcnt; i++) {
>>>> +            ret += fb->iov[i].iov_len;
>>>> +        }
>>>>        }
>>>>        return ret;
>>>> @@ -683,8 +981,12 @@ int64_t qemu_ftell_fast(QEMUFile *f)
>>>>    int64_t qemu_ftell(QEMUFile *f)
>>>>    {
>>>> -    qemu_fflush(f);
>>>> -    return f->pos;
>>>> +    if (f->buffered_mode) {
>>>> +        return qemu_ftell_fast(f);
>>>> +    } else {
>>>> +        qemu_fflush(f);
>>>> +        return f->pos;
>>>> +    }
>>>>    }
>>>>    int qemu_file_rate_limit(QEMUFile *f)
>>>> @@ -803,6 +1105,8 @@ ssize_t qemu_put_compression_data(QEMUFile *f, z_stream *stream,
>>>>        QEMUFileBuffer *fb = f->current_buf;
>>>>        ssize_t blen = IO_BUF_SIZE - fb->buf_index - sizeof(int32_t);
>>>> +    assert(!f->buffered_mode);
>>>> +
>>>>        if (blen < compressBound(size)) {
>>>>            return -1;
>>>>        }
>>>> @@ -827,6 +1131,9 @@ int qemu_put_qemu_file(QEMUFile *f_des, QEMUFile *f_src)
>>>>        int len = 0;
>>>>        QEMUFileBuffer *fb_src = f_src->current_buf;
>>>> +    assert(!f_des->buffered_mode);
>>>> +    assert(!f_src->buffered_mode);
>>>> +
>>>>        if (fb_src->buf_index > 0) {
>>>>            len = fb_src->buf_index;
>>>>            qemu_put_buffer(f_des, fb_src->buf, fb_src->buf_index);
>>>> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>>>> index a9b6d6c..08655d2 100644
>>>> --- a/migration/qemu-file.h
>>>> +++ b/migration/qemu-file.h
>>>> @@ -103,6 +103,14 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaque);
>>>>    typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool wr,
>>>>                                       Error **errp);
>>>> +/*
>>>> + * Enables or disables the buffered mode
>>>> + * Existing blocking reads/writes must be woken
>>>> + * Returns true if the buffered mode has to be enabled,
>>>> + * false if it has to be disabled.
>>>> + */
>>>> +typedef bool (QEMUFileEnableBufferedFunc)(void *opaque);
>>>> +
>>>>    typedef struct QEMUFileOps {
>>>>        QEMUFileGetBufferFunc *get_buffer;
>>>>        QEMUFileCloseFunc *close;
>>>> @@ -110,6 +118,7 @@ typedef struct QEMUFileOps {
>>>>        QEMUFileWritevBufferFunc *writev_buffer;
>>>>        QEMURetPathFunc *get_return_path;
>>>>        QEMUFileShutdownFunc *shut_down;
>>>> +    QEMUFileEnableBufferedFunc *enable_buffered;
>>>>    } QEMUFileOps;
>>>>    typedef struct QEMUFileHooks {
>>>> -- 
>>>> 1.8.3.1
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>



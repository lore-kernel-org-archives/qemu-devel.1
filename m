Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B508C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3700220757
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vDrVEIQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3700220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9cB-0004Am-CQ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg9aC-0001bf-Ny; Tue, 02 Jun 2020 12:16:08 -0400
Received: from mail-eopbgr00130.outbound.protection.outlook.com
 ([40.107.0.130]:16565 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jg9a9-0006Tu-CR; Tue, 02 Jun 2020 12:16:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWiIBtNoVwElhj0EDVDKr4pKGsaQig4EitwzA3p0cA6kklp+HIN0xKUGIH0FSQpSuLUWXRrT9sYtwVr2TdyaguY2mqdsQfPGODiTaScr3JlkokXINvv57py3XH+V7StzEXJKUmVcJA/BJJqRMyu656E5k3CNzi6Cgg8UtCY1G1qDxT4TN9Z5o0HU9sUigvR8zccuRMVGp0VKuka7/H+xVlsiXEB8wVHTFoG7Xv48yqrjJl5IJed9LUAldFMcdVW+4JXanJEcRS1qi8qQ+pogHv7sRszuQ5UnsKrUXLGT2zT4RC7px09tIUlHxziTFpAhMk3KwInyEGbSOSpNDxH92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ViXP14rcFDvOeV6Y7i8HG/v3qtsL1A/Ah16ur2zXs=;
 b=V+KtX/yPq3P4bA3bdgw3+/VpE/7nux+zuWbQHznCSEjqIrDbgoMxZAIrHYzYD+TpmpqaKgK8WH60WGhkMuRdLgdug7Q6yba1aMew3CkofcURLT/GDp9R7ZsdMB56oXTF1ClUCukRDOHPBjKy1hsrceemJNuHwhRTdMbukGnc1yjd6/6AhjOTnGBqfnglVNrSnt0L+Mdn4ZEpGajCDpkKJ/WiRvD9phreGOaqrfxa9og/Nopf4qDYtng8iOZ0bbZP5LIjiqPdN1psQH9Zdsjg/Z2e4egRsqzIT93nII7p+BiwTX0r+Z9vsAnnFEIjsEzz5KuhMqYXSZuBv4Z9jLuAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/ViXP14rcFDvOeV6Y7i8HG/v3qtsL1A/Ah16ur2zXs=;
 b=vDrVEIQ0V4CXvCb0nnE8sWltnEhNhJHtUaahIzJRxW8uwX/qLg27Afw72ZxvmhhB+pXNgdqfu9fzMBbrLjfJp6RH9Ms0NaHgM/TQvdDysrYaM0vga/6i8ATqnuZSmFVYvhMlzbJ8Lq6QO5qNNG6shBkiIr/xWphr5ablE6G0ExA=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Tue, 2 Jun
 2020 16:16:02 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 16:16:01 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <dfe5fbff-ce04-504e-542b-11095a57fd78@virtuozzo.com>
 <50115120-9d1a-79f7-64f4-cd45508c0e7c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <19babc97-3cc9-e924-ef0b-cca3c8cefcae@virtuozzo.com>
Date: Tue, 2 Jun 2020 19:16:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <50115120-9d1a-79f7-64f4-cd45508c0e7c@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0134.eurprd05.prod.outlook.com
 (2603:10a6:207:3::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM3PR05CA0134.eurprd05.prod.outlook.com (2603:10a6:207:3::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 16:16:01 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f0f1e78-ae30-4d4b-eb7d-08d807103e29
X-MS-TrafficTypeDiagnostic: AM7PR08MB5367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53677B5CCEB30A20EF7482E8C18B0@AM7PR08MB5367.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVqwt0ZUJG6JHrO/bJ0ljMUgjSfWzc6tmg/qYMlS+9GsQNXeQh9ECsCJcCl09WKZ40BcfW7a2Sde0DQUkz/vOfF374lnrOIVQxK1g3clpuRMmuDC9QR33tjI1TlRt9Tn8XXzVNyPZBfDWOSFXZEVQNU2Wj0GukXcb5/V2G4RY7v2Q185RwITczSShP79Y9FytnOVo/SopfTFZaYrPMrT065e+ZkUBXouoy+fnFuGxhJTd7ygGEtqt5mbo295Z2NBFmlOAb2bId40soKonD9aUx2iRF95MBhJ96un7BsC2CYw22aGhjNtYoPWcCy6DDchamJmlQ7jm6RL1N177fLNZXHVxMBQgIBnORQC0kv32STkn0nX6kjTKUfAAtb7LWkD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(39850400004)(136003)(366004)(396003)(83380400001)(5660300002)(316002)(36756003)(4326008)(86362001)(26005)(66556008)(16576012)(186003)(31696002)(66476007)(54906003)(53546011)(16526019)(66946007)(6486002)(478600001)(52116002)(8936002)(2616005)(956004)(31686004)(107886003)(2906002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: motSr0NFqfaQ2acfAIHCQys86WYrdJsNMXtJRGU+heaPK53kZPeQIdxA2NV7lN/xTcnOJv2VJxKtA/Cy0ocCq/WxCE6tn/oOJRDyYpgaIhNA+QzpyG6La3jnpgX+m2UjdZEl1rs4ED4dxWN4/N2k+/pi01L6FLxA1m0HXs29Oz+RrOKC/cqPy6RRufS0dgyGIefTUQncm2zRt2z8ro/NYdK5T8eimlXTTSy/xkuxFb4OtbOpklFQVnri8dSGLljTWTZ+8fOWyZjvbpOSIrKG/6fb6t+cGZj9xGyo4ZX1R44366sF8DFWoHAHqFItT8m9ZZhan+dj4HG1pmIdKCEEs/1zsNuQI3N2nHEvEpeXRR8bmm3Ar/eoQISuS5cZhbuWnmcXDtW42TSmps6zE+aJPsti4BHRGbSURmq8fxmM0CoI9+G6u1lkQG9m3VdTs8IMbuaKx/eDb/jPISNpbpRSDpmbJu+eQXu+VwsV5Sp9gjniB3eLDP+cuKxj/OlbS4yO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0f1e78-ae30-4d4b-eb7d-08d807103e29
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 16:16:01.8408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F6un22nYgwtjxeAmCrJmhllRH2XTTZ53zuS9JdDhLaJkbwmO5+P1cY9PvbUkC/F6823TuMmJRo6fWg/xlHoEURvlit+Nraxdm7+zymV620=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
Received-SPF: pass client-ip=40.107.0.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 12:16:03
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.06.2020 18:46, Max Reitz wrote:
> On 02.06.20 16:43, Vladimir Sementsov-Ogievskiy wrote:
>> 01.11.2019 18:25, Max Reitz wrote:
>>
>> Sorry for being late, I have some comments
> 
> Uh, well.  Reasonable, but I hope you don’t mind me having no longer
> having this patch fresh on my mind.
> 
>>> The XFS kernel driver has a bug that may cause data corruption for qcow2
>>> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
>>> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
>>> in practice).
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    block/file-posix.c | 36 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 36 insertions(+)
>>>
>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>> index 0b7e904d48..1f0f61a02b 100644
>>> --- a/block/file-posix.c
>>> +++ b/block/file-posix.c
>>> @@ -2721,6 +2721,42 @@ raw_do_pwrite_zeroes(BlockDriverState *bs,
>>> int64_t offset, int bytes,
>>>        RawPosixAIOData acb;
>>>        ThreadPoolFunc *handler;
>>>    +#ifdef CONFIG_FALLOCATE
>>> +    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
>>> +        BdrvTrackedRequest *req;
>>> +        uint64_t end;
>>> +
>>> +        /*
>>> +         * This is a workaround for a bug in the Linux XFS driver,
>>> +         * where writes submitted through the AIO interface will be
>>> +         * discarded if they happen beyond a concurrently running
>>> +         * fallocate() that increases the file length (i.e., both the
>>> +         * write and the fallocate() happen beyond the EOF).
>>> +         *
>>> +         * To work around it, we extend the tracked request for this
>>> +         * zero write until INT64_MAX (effectively infinity), and mark
>>> +         * it as serializing.
>>> +         *
>>> +         * We have to enable this workaround for all filesystems and
>>> +         * AIO modes (not just XFS with aio=native), because for
>>> +         * remote filesystems we do not know the host configuration.
>>> +         */
>>> +
>>> +        req = bdrv_co_get_self_request(bs);
>>> +        assert(req);
>>> +        assert(req->type == BDRV_TRACKED_WRITE);
>>> +        assert(req->offset <= offset);
>>> +        assert(req->offset + req->bytes >= offset + bytes);
>>
>> Why these assertions?
> 
> Mostly to see that bdrv_co_get_self_request() (introduced by the same
> series) actually got the right request.  (I suppose.)
> 
>> TrackedRequest offset and bytes fields correspond
>> to the original request. When request is being expanded to satisfy
>> request_alignment, these fields are not updated.
> 
> Well, shrunk in this case, but OK.
> 
>> So, maybe, we should assert overlap_offset and overlap_bytes?
> 
> Maybe, but would that have any benefit?  Especially after this patch
> having been in qemu for over half a year?
> 
> (Also, intuitively off the top of my head I don’t see how it would make
> more sense to check overlap_offset and overlap_bytes, if all the
> assertions are for is to see that we got the right request.
> overlap_offset and overlap_bytes may still not exactly match @offset or
> @bytes, respectively.)
> 
> Your suggestion makes it sound a bit like you have a different purpose
> in mind what these assertions might be useful for...?

No I just think it may have false-positives, when actual request is larger
than original. So offset may be < req->offset and req->offset + req->bytes may be
less than offset + bytes. And we will crash. I should make a reproducer to
prove it, but it seems possible.

> 
>>> +
>>> +        end = INT64_MAX & -(uint64_t)bs->bl.request_alignment;
>>> +        req->bytes = end - req->offset;
>>
>> And I doubt that we should update req->bytes. We never updated it in
>> other places, it corresponds to original request. It's enough to update
>> overlap_bytes to achieve corresponding serialising.
> 
> Does it hurt?  If so, would you send a patch?
> 
> I assume you reply to this patch instead of writing a patch because you
> have the same feeling of “It probably doesn’t really matter, so let’s
> have a discussion first”.

1. yes, and
2. I probably don't see the full picture around tracked requests

> 
> My stance is: I don’t think it matters and this whole piece of code is a
> hack that shouldn’t exist, obviously.  So I don’t really care how it
> fits into all of our other code.
> 
> I would like to say I wouldn’t mind a patch to drop the req->bytes
> assignment, but OTOH it would mean I’d have to review it and verify that
> it’s indeed sufficient to set overlap_bytes.
> 
> If it’s in any way inconvenient for you that req->bytes is adjusted,
> then of course please send one.
> 
>>> +        req->overlap_bytes = req->bytes;
>>> +
>>> +        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
>>
>> Not sure, how much should we care about request_alignment here, I think,
>> it's enough to just set req->overlap_bytes = INT64_MAX -
>> req->overlap_offest, but it doesn't really matter.
> 
> As long as req->bytes is adjusted, we have to care, or the overlap_bytes
> calculation in bdrv_mark_request_serialising will overflow.
> 
> Well, one could argue that it doesn’t matter because the MAX() will
> still do the right thing, but overflowing is never nice.

Hmm I think, if reduce it to just INT64_MAX, we should pass 1 as align to bdrv_mark_request_serialising.

> 
> (Of course, it probably doesn’t matter at all if we just wouldn’t touch
> req->bytes.)
> 

OK, thanks for the answer, I'll prepare a patch.


-- 
Best regards,
Vladimir


Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E552068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="trPuDPAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E552068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAJ7-0006Dc-5z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgAI3-00050L-GR; Tue, 02 Jun 2020 13:01:27 -0400
Received: from mail-eopbgr10123.outbound.protection.outlook.com
 ([40.107.1.123]:43560 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgAI0-0007GV-AL; Tue, 02 Jun 2020 13:01:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhg7Q7oXyeakrWq0TB/TPmHV3RM8A3l9Uun8KpXwIKMDKHrQ6fb2dibLlMhsqMgD7TYH7KL/5rAXMRkuOjo643FrWTaxzueJ6OEySJeXukrwuQ8n+FAHpBuToMz6dYQmqJG5EDYVPOMB0Z5sXSa0SN77z3pi2cDRgqh7cCHvmow3bV094KXHsoxXGpEZOqpqkDU+T2N06UB5nBpVaK+TbKw3mTwcEPxDerXRFYSWP0eqrpubHfZwo6RRLL0tXL521P2f/tT7vXzmBRy2HrYiTuQzEfzfw7z6viOoZsQdYXdiwUoiaE/7PoqWH6Ock7gypd6gUTrINILuVeDAtN1T9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7gdlBkL0VmuTMlqThGSRtywv0lB61//Lu4TC0WG9IA=;
 b=F4o8esCaFEeVryIT5YARKaHHaYD5H1htC6EfhzdpfSsRnF38Zfy0EhFsAM+70gmBG1wYrLvRqefhHozHaRZV3eV6cSD5biFui6QXAVYmcdAmOvqPF0kl9jZBFfD0aCxESnyN4F9rr0dbXt3NOSFE4G54qvfiyDS1+4JbDYqs6Du7k2AvA9t0YqcZgMdrIxzEIMoUYjl8P9chDFr+JBYn1QvP9ygUoTMfF4d/vuOxuWi+kyDxoZ8BimgxBSQJRPZ0AQzZn9W4POtsaqUZZLBWbSpElbUkZkwEtn4hotlyJrnnhdox3+ScEwkkejujlAHpW83yRx1X/KKOwbCPFj2X5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7gdlBkL0VmuTMlqThGSRtywv0lB61//Lu4TC0WG9IA=;
 b=trPuDPAAvLqEPVVh39dCKqoMvHSOmJxxy3b0nluyyBRAGPSRkKaayaXBkBC3AE1tqkwMoJ8NjloobTZW7owVhPFvoAgLFS6QlIPi4L1G7cld+gmgiU4LHdbQhn15McxzozKcCG3zG0vBhcxa30GF6eYofCxHghDpAYAuOtEGCzw=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5477.eurprd08.prod.outlook.com (2603:10a6:20b:10f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Tue, 2 Jun
 2020 17:01:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 17:01:16 +0000
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <dfe5fbff-ce04-504e-542b-11095a57fd78@virtuozzo.com>
 <50115120-9d1a-79f7-64f4-cd45508c0e7c@redhat.com>
 <19babc97-3cc9-e924-ef0b-cca3c8cefcae@virtuozzo.com>
 <562a7703-184c-36b6-3b9e-da5fcb3b9174@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <975faf57-b4d9-870c-a47f-ca40e8902043@virtuozzo.com>
Date: Tue, 2 Jun 2020 20:01:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <562a7703-184c-36b6-3b9e-da5fcb3b9174@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.153) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Tue, 2 Jun 2020 17:01:16 +0000
X-Originating-IP: [185.215.60.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669d78fb-d011-41cf-a701-08d807169071
X-MS-TrafficTypeDiagnostic: AM7PR08MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5477E9B5AAC3E581291FE956C18B0@AM7PR08MB5477.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCrGhz6rgPFuXvP32UGy5Ta5ZQtQQeNPie3vUFuDinreAzJR8AaA8pGmzlAVVhd+1YDHAwA7S4CyjOgx+MiactJRrfuFeyidjjRAvlBSFk72ZYzzF21ELufVCqR+youUsgADH+ILr3PipzBb+lf6fIAVoL/9tEb9VdLQuOQaPeKeKAvTOlpGTjXUfocz9FUdifKUmn0YRss66oQWYh2UfCMJiSweWMkgCTnjUYEwGTGlOD+xrQxJ4oG5iUPqIMFYmG5jrjvz77wQ1YRqDaDNK/vWdnFiyi1LC6Y3xK0CjIpB2iuculNejcsKXQ+0E8v5L/o38EUP3xREKlz6jcpPOrT0hpUZXNW46uuDdC4DCQhSXd0VRATHroP5iHRaecba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(31686004)(52116002)(107886003)(478600001)(8676002)(53546011)(4326008)(36756003)(26005)(6486002)(8936002)(5660300002)(86362001)(186003)(16526019)(66556008)(66946007)(66476007)(2906002)(31696002)(54906003)(83380400001)(16576012)(956004)(2616005)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nCYW4+mGXfA53osKAFTI2tV3iOa6BG/UAh2qQl50/9PQLqYzhEH4ImPIE29ZsI1I1fKtjiliFt32qqWSf58pHHw8JAbMp3stsZqk/eSFdb6XT00EEwygM+fDy6A+4RIT0R86x59Q6ilI74FmecwBcU93KGKZW9K7faQtheZ79+uekRSFBedMx1sEXiFHhemSSHF8tTESV/AP+2MhSEnWn6B4faMvsNX+Dbwy6uEVck6/X1Q9LBkCc/S7pvwpmIQDYECWal4aQSBhS/mIoJCzOvdcst5FPSW4HfudUCsfRY7FZ9uPdIKPz5hr7fOGac42Rp9khSHBwiuRe3OC4RRhO46hvAYZ+Pvdh8kbR0hBj0zl0PkH7oHFhdQa4VTG6YRs9EuPYzP+llDharULq0geHab5xmY/sX6PNve4RTVw9SyNyK4AEWRE2HRNb29T1VW1taD3SXnDnEp9ZlEWiAda+n8uabBV4ACsLAKzgEOZMRmn6e0bZdEZ8IKx1a1pbCrs
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669d78fb-d011-41cf-a701-08d807169071
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 17:01:16.7769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfQQvp1927iXo7EJ56sNzetBIoHDtT48Qm9FDo+DdObuxbPlujFOdHNwqFMjj8vzS3rdi0hj8Xb0IwG0jCepgaTgJZOGMM4HnlTyjhE7LDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5477
Received-SPF: pass client-ip=40.107.1.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 13:01:18
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

02.06.2020 19:38, Max Reitz wrote:
> On 02.06.20 18:16, Vladimir Sementsov-Ogievskiy wrote:
>> 02.06.2020 18:46, Max Reitz wrote:
>>> On 02.06.20 16:43, Vladimir Sementsov-Ogievskiy wrote:
>>>> 01.11.2019 18:25, Max Reitz wrote:
>>>>
>>>> Sorry for being late, I have some comments
>>>
>>> Uh, well.  Reasonable, but I hope you don’t mind me having no longer
>>> having this patch fresh on my mind.
>>>
>>>>> The XFS kernel driver has a bug that may cause data corruption for
>>>>> qcow2
>>>>> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
>>>>> treating post-EOF fallocates as serializing up until infinity
>>>>> (INT64_MAX
>>>>> in practice).
>>>>>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>     block/file-posix.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>>> index 0b7e904d48..1f0f61a02b 100644
>>>>> --- a/block/file-posix.c
>>>>> +++ b/block/file-posix.c
>>>>> @@ -2721,6 +2721,42 @@ raw_do_pwrite_zeroes(BlockDriverState *bs,
>>>>> int64_t offset, int bytes,
>>>>>         RawPosixAIOData acb;
>>>>>         ThreadPoolFunc *handler;
>>>>>     +#ifdef CONFIG_FALLOCATE
>>>>> +    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
>>>>> +        BdrvTrackedRequest *req;
>>>>> +        uint64_t end;
>>>>> +
>>>>> +        /*
>>>>> +         * This is a workaround for a bug in the Linux XFS driver,
>>>>> +         * where writes submitted through the AIO interface will be
>>>>> +         * discarded if they happen beyond a concurrently running
>>>>> +         * fallocate() that increases the file length (i.e., both the
>>>>> +         * write and the fallocate() happen beyond the EOF).
>>>>> +         *
>>>>> +         * To work around it, we extend the tracked request for this
>>>>> +         * zero write until INT64_MAX (effectively infinity), and mark
>>>>> +         * it as serializing.
>>>>> +         *
>>>>> +         * We have to enable this workaround for all filesystems and
>>>>> +         * AIO modes (not just XFS with aio=native), because for
>>>>> +         * remote filesystems we do not know the host configuration.
>>>>> +         */
>>>>> +
>>>>> +        req = bdrv_co_get_self_request(bs);
>>>>> +        assert(req);
>>>>> +        assert(req->type == BDRV_TRACKED_WRITE);
>>>>> +        assert(req->offset <= offset);
>>>>> +        assert(req->offset + req->bytes >= offset + bytes);
>>>>
>>>> Why these assertions?
>>>
>>> Mostly to see that bdrv_co_get_self_request() (introduced by the same
>>> series) actually got the right request.  (I suppose.)
>>>
>>>> TrackedRequest offset and bytes fields correspond
>>>> to the original request. When request is being expanded to satisfy
>>>> request_alignment, these fields are not updated.
>>>
>>> Well, shrunk in this case, but OK.
>>>
>>>> So, maybe, we should assert overlap_offset and overlap_bytes?
>>>
>>> Maybe, but would that have any benefit?  Especially after this patch
>>> having been in qemu for over half a year?
>>>
>>> (Also, intuitively off the top of my head I don’t see how it would make
>>> more sense to check overlap_offset and overlap_bytes, if all the
>>> assertions are for is to see that we got the right request.
>>> overlap_offset and overlap_bytes may still not exactly match @offset or
>>> @bytes, respectively.)
>>>
>>> Your suggestion makes it sound a bit like you have a different purpose
>>> in mind what these assertions might be useful for...?
>>
>> No I just think it may have false-positives, when actual request is larger
>> than original.
> 
> Seems like a bug.  Why would we zero more than originally requested?

Hmm, you are right, seems it's not possible. We may expand the request to do COW,
but it will never produce write-zero request larger than original one.

(I really tried to reproduce to understand it :)

> 
>> So offset may be < req->offset and req->offset +
>> req->bytes may be
>> less than offset + bytes. And we will crash. I should make a reproducer to
>> prove it, but it seems possible.
> 
> I’m definitely curious.
> 
>>>>> +
>>>>> +        end = INT64_MAX & -(uint64_t)bs->bl.request_alignment;
>>>>> +        req->bytes = end - req->offset;
>>>>
>>>> And I doubt that we should update req->bytes. We never updated it in
>>>> other places, it corresponds to original request. It's enough to update
>>>> overlap_bytes to achieve corresponding serialising.
>>>
>>> Does it hurt?  If so, would you send a patch?
>>>
>>> I assume you reply to this patch instead of writing a patch because you
>>> have the same feeling of “It probably doesn’t really matter, so let’s
>>> have a discussion first”.
>>
>> 1. yes, and
>> 2. I probably don't see the full picture around tracked requests
> 
> Neither do I, that’s for sure.
> 
>>> My stance is: I don’t think it matters and this whole piece of code is a
>>> hack that shouldn’t exist, obviously.  So I don’t really care how it
>>> fits into all of our other code.
>>>
>>> I would like to say I wouldn’t mind a patch to drop the req->bytes
>>> assignment, but OTOH it would mean I’d have to review it and verify that
>>> it’s indeed sufficient to set overlap_bytes.
>>>
>>> If it’s in any way inconvenient for you that req->bytes is adjusted,
>>> then of course please send one.
>>>
>>>>> +        req->overlap_bytes = req->bytes;
>>>>> +
>>>>> +        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
>>>>
>>>> Not sure, how much should we care about request_alignment here, I think,
>>>> it's enough to just set req->overlap_bytes = INT64_MAX -
>>>> req->overlap_offest, but it doesn't really matter.
>>>
>>> As long as req->bytes is adjusted, we have to care, or the overlap_bytes
>>> calculation in bdrv_mark_request_serialising will overflow.
>>>
>>> Well, one could argue that it doesn’t matter because the MAX() will
>>> still do the right thing, but overflowing is never nice.
>>
>> Hmm I think, if reduce it to just INT64_MAX, we should pass 1 as align
>> to bdrv_mark_request_serialising.
> 
> True.
> 
>>> (Of course, it probably doesn’t matter at all if we just wouldn’t touch
>>> req->bytes.)
>>>
>>
>> OK, thanks for the answer, I'll prepare a patch.
> 
> OK?  I’m not sure where the benefit is (apart from the perhaps failing
> assertions).  So it still looks to me like putting too much energy into
> a hack.
> 
> (I think the original reason I set both req->bytes and
> req->overlap_bytes was actually because I just wanted to be sure, and
> didn’t want to have to look too hard whether either would be sufficient.)
> 
> ((Please also note that I can’t guarantee I will review your patch in a
> timely manner, for one thing because I can already rarely give that
> promise (as you are probably painfully aware...); and now there’s also
> two weeks of mail on top for me to wade through after PTO.  So if
> there’s no reason to change anything apart from saving two LoC, well.
> Failing assertions are a different matter altogether, though, of course.))
> 
> Max
> 


-- 
Best regards,
Vladimir


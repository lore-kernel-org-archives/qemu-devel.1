Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29114C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A967620731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZMLl1IFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A967620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiqR-00064s-PP
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTipf-0005Ms-3v
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTipV-0002dH-4M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:16:42 -0400
Received: from mail-am6eur05on2094.outbound.protection.outlook.com
 ([40.107.22.94]:38051 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTiog-0008KM-CJ; Wed, 29 Apr 2020 05:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8PNB4ViHEETbEsXO8KZ1ECHytv0wr5e4sPL7soAK2q51jH5/xBbb1LHuRC9XgMteiDFMRwmauJ+/sijt9VWQLL5DfvWqb6o17+wx2WAG/s0weknzjqhHEPdMcWBCZHJ6fZ9yQJcH2Hni0SWhMGD6YjngEuVB8fSQNUMFgLhWIbE50E3GcBs6AiNivfS+s9dMaBEV9H1u9HsBjiDBTFSc2FjgL+2KiZzb5gBu/2GuA3XmB2S9dd2YPYs2xIkGw0OZrs/WnV7cv1pO7vJMM+pJOLCGmKUfXdVSaK3Rj6xRNNwzHnrK1xQ8jjVKPZZ/JZhsYV+jImCfoZnQdtjcZUm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yDp9M6lnHVyajxYH0Bm2cPqXwtvmZlYkpPh1UUj/ZU=;
 b=kpmBB618KyMQ1PSFLSpd7esY7i82pRG9qm8H73BRcaYBxMyXeQOvO5uWchkk3uZeY9PcGCHyCWpyzEiQAUGcK83az6nmsxWCjffbnQGQLanp+Cx57F2CwW31ABFWJf5Td20+IYqKp5buG8zqb+aG79ky4wQ76YY8u7Ky4q4gyPPK8zzOBk2alvceQeSYCQlSdEDno3MB5+aYOOLT6w2ucfnSNVOXZbSXBIu0DKdtCOryACqlMJzSaSWrg4cJQY7bqBoq4Bij4cr2T4Y0rCHjWIXLHTkkYVl0LD6ZQOna7xgBOtA08N6JpkjrVKCxjKGK1BenIT8nRZ8Z34Zb1ZtI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yDp9M6lnHVyajxYH0Bm2cPqXwtvmZlYkpPh1UUj/ZU=;
 b=ZMLl1IFDmQ32n/QFOjn83bxZf2kYQpyQrexDsNX/okjnCQEij0iuTBUaSt0wIYcOZDxev50S8HBXS9ywiTU0ssVml+9ysUxgEXX1qXJs7TjySxpFClAlrLYT3LRbe09zqUcTLVgUTPUZ8uot+C8KS+L6jcgVsjYj/IRNjqFr/Iw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5302.eurprd08.prod.outlook.com (2603:10a6:20b:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 09:15:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 09:15:37 +0000
Subject: Re: backing chain & block status & filters
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <20200428112853.GC5789@linux.fritz.box>
 <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
 <25f6278c-466d-c663-73e0-ef2d256b326d@redhat.com>
 <04dd8365-7077-766a-6d42-1aac26abbdeb@virtuozzo.com>
 <91b741ac-248c-2065-17b9-7fe31eafee40@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429121535352
Message-ID: <7b1d4246-e59b-0fdb-3c44-6810eea6e5b8@virtuozzo.com>
Date: Wed, 29 Apr 2020 12:15:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <91b741ac-248c-2065-17b9-7fe31eafee40@virtuozzo.com>
Content-Type: multipart/mixed; boundary="------------DBA025E4B6D5E27CB3B4512D"
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 09:15:36 +0000
X-Tagtoolbar-Keys: D20200429121535352
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e18e04f-d6f8-434a-7231-08d7ec1de10f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5302:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530234D734384B78ADB3B8CFC1AD0@AM7PR08MB5302.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eaqVYEY7SfttPYc2IPsJ+XbUfpocPg9AkkVupEOhfe2Y6e48W4XAU/xMGmaVLZFngSkOttVM29LhGrPBK2lc0eGbCEtBihjPLOmWjDElGkriIOetyMmy88VZx327pawrnm4/V66LMCoddEsBTIqF65yWyV5rCav74pT+2CHlnUMydRfggEfs9e5dLEDzPc2/ouxDhz9oUIRCbMe8+TA5UIpim/TD5N886QXykQ+vxQzQWczWUe2kzhDgqyc60ygGNKyUiM47UsbNjXKIHDTek86qLLF/Fwzx/AMhYMezDmfViGQyNc6Ium5dQ9tASR1p3U0cTdxjlEJ4XTkibNqJJyd27NTh4TZxR5DFZOInjOPWnRLijbrTS8+HXE95HuJkrpV8dFqmvmrMhRfRK+zssxJwSYTAdPQYlBdQXGQmedKvtyhx5R6CG/Fvusanj5vBLQ8djRyNyipwqvfYC2MMwZwcqpBoTRMbUxanHcwqH8Fpntij3QU+rGFXzKRAa4x/Oj3m6Hg65+GmnXJ/uWzuUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39830400003)(376002)(966005)(66476007)(66616009)(4326008)(2616005)(66556008)(31686004)(110136005)(33964004)(66946007)(956004)(5660300002)(235185007)(54906003)(16576012)(52116002)(478600001)(53546011)(26005)(16526019)(186003)(8936002)(36756003)(86362001)(31696002)(8676002)(2906002)(6486002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8yzrme0zcW6mGkh9viQ9qrCdGo5U5SK9vbDBAFs9B0x6Zp7lV1osEMgZiKOHcTAqAl7Kxxl1ut9sKG88hZ/t+4tkvySQOiFKnxyJ9/m8jUedx4tG30nhq6n6Q2JfnLYPFlY3s+78Q9wiKh1Rd0lajhVhMfCg56SeyYGrqPOTymBC2XCFTt9NNCyRy4Ms5YR/7Yludhy5TXLDQ6Jws28RxXoa5JXjW1QOK+LT5d2suiQroq7qAeGGPaE4l98qcKSbTfhuUBTfIEL2uo1lmHAU/a5GbiQsQLOWAz4m/PHtfNXh1BudAhhJLgn9OPIKIl4N4DIjT714+pC9f35FyJJDKKUjeo0s4US9B7KRgeHOTxcW+QtGECsAjUz/RwpJEa2FyKonlJmckqX5R9Gs0XbqUsgNRpRw938vqlZmRGA8sIxBLl8/G8ae/ggaCZGHTMhnT1068bKJkciP3l0ZoKBwMlkA5Gze+2UsiZDH0daa0RsPZk5DbgwmXjlJXUS069qi+YkmVE/4b1nVuBdkGam4lFg/LWJSZowXuO3VnteNQnkQ+485cCWdWkaP9HY7lhyQw1o6gGLhZ0B4GyTSiRBnLRXrrN0UYSMKZNKPUF1MSlIjzSheZofFAJxJdtcLSEviQ/lWIbtf/ewkSOKV4pGYpsBHHK3dQxpahKk+Kx67TTVY7yLT6zKF+Yfr0xNP4TQtBQhMTbMEP0aqIKUgzzJaweycw37xEoIhtRVDSkP5mJW4Lk8PYdSZPmTc9n2JbR3zAg9x1gHaSQuwGdsQLRUZ5Xw34ngdEWFVgvR6OKQ0eX8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e18e04f-d6f8-434a-7231-08d7ec1de10f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 09:15:37.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q8ujOmXmm/vJAQ6hBYGLIOSvLpICxj8P1YLeeMwEoWbxkZ7R8mDC/dDqFUg5X76F8L0GpJnSRgLflLVKQ8HYb5f1+GO16JCk3YZtnWl49c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5302
Received-SPF: pass client-ip=40.107.22.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 05:15:38
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.94
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------DBA025E4B6D5E27CB3B4512D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

28.04.2020 22:44, Vladimir Sementsov-Ogievskiy wrote:
> 28.04.2020 19:46, Vladimir Sementsov-Ogievskiy wrote:
>> 28.04.2020 19:18, Eric Blake wrote:
>>> On 4/28/20 10:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>>>>> Hm.  I could imagine that there are formats that have non-zero holes
>>>>>> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
>>>>>> ZERO or DATA then.
>>>>>>
>>>>>> But OTOH we don’t care about such cases, do we?  We need to know whether
>>>>>> ranges are zero, data, or unallocated.  If they aren’t zero, we only
>>>>>> care about whether reading from it will return data from this layer or not.
>>>>>>
>>>>>> So I suppose that anything that doesn’t support backing files (or
>>>>>> filtered children) should always return ZERO and/or DATA.
>>>>>
>>>>> I'm not sure I agree with the notion that everything should be
>>>>> BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means today
>>>>> at least. If we want to change this, we will have to check all callers
>>>>> of bdrv_is_allocated() and friends who might use this to find holes in
>>>>> the file.
>>>>
>>>> Yes. Because they are doing incorrect (or at least undocumented and unreliable) thing.
>>>
>>> Here's some previous mails discussing the same question about what block_status should actually mean.  At the time, I was so scared of the prospect of something breaking if I changed things that I ended up keeping status quo, so here we are revisiting the topic several years later, still asking the same questions.
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00069.html
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03757.html
>>>
>>>>
>>>>>
>>>>> Basically, the way bdrv_is_allocated() works today is that we assume an
>>>>> implicit zeroed backing layer even for block drivers that don't support
>>>>> backing files.
>>>>
>>>> But read doesn't work so: it will read data from the bottom layer, not from
>>>> this implicit zeroed backing layer. And it is inconsistent. On read data
>>>> comes exactly from this layer, not from its implicit backing. So it should
>>>> return BDRV_BLOCK_ALLOCATED, accordingly to its definition..
>>>>
>>>> Or, we should at least document current behavior:
>>>>
>>>>    BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>>>>    layer rather than any backing, set by block. Attention: it may not be set
>>>>    for drivers without backing support, still data is of course read from
>>>>    this layer. Note, that for such drivers BDRV_BLOCK_ALLOCATED may mean
>>>>    allocation on fs level, which occupies real space on disk.. So, for such drivers
>>>>
>>>>    ZERO | ALLOCATED means that, read as zero, data may be allocated on fs, or
>>>>    (most probably) not,
>>>>    don't look at ALLOCATED flag, as it is added by generic layer for another logic,
>>>>    not related to fs-allocation.
>>>>
>>>>    0 means that, most probably, data doesn't occupy space on fs, zero-status is
>>>>    unknown (most probably non-zero)
>>>>
>>>
>>> That may be right in describing the current situation, but again, needs a GOOD audit of what we are actually using it for, and whether it is what we really WANT to be using it for.  If we're going to audit/refactor the code, we might as well get semantics that are actually useful, rather than painfully contorted to documentation that happens to match our current contorted code.
>>>
>>
>> Honest enough:) I'll try to make a table.
>>
>> I don't think that reporting fs-allocation status is a bad thing. But I'm sure that it should be separated from backing-chain-allocated concept.
>>
> 
> As a first step, I've don brief analysis of .bdrv_co_block_status of drivers (attached)
> 

As a second step, here is brief analysis of all block_status usage

-- 
Best regards,
Vladimir

--------------DBA025E4B6D5E27CB3B4512D
Content-Type: text/plain; charset=UTF-8;
 name="block-status-usage-report"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="block-status-usage-report"

UHVibGljIGludGVyZmFjZSBvZiBibG9jay1zdGF0dXMgaXM6CgogICAgYmRydl9ibG9ja19zdGF0
dXMKICAgIGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlCiAgICBiZHJ2X2lzX2FsbG9jYXRlZAogICAg
YmRydl9pc19hbGxvY2F0ZWRfYWJvdmUKCgo9IGJkcnZfYmxvY2tfc3RhdHVzID0KCmJkcnZfbWFr
ZV96ZXJvOiB3b3JrcyBvbiBjdXJyZW50IGxldmVsIG9mIGJhY2tpbmctY2hhaW4sIHdhbnQncyB0
byBza2lwIHplcm9lcywgbm90IGludGVyZXN0ZWQgaW4gQG1hcCBhbmQgQGZpbGUKCmltZyBjb252
ZXJ0OiBjb252ZXJ0X2l0ZXJhdGlvbl9zZWN0b3JzOiB3YW50cyB0byBkaXN0aW5ndWlzaCBaRVJP
LCBEQVRBIGFuZCBnby10by1iYWNraW5nLiBJdCBhbHNvIHRyaWVzIHRvIG5vdCB3cml0ZSB6ZXJv
ZXMsIGlmIGhhdmUgc2hvcnQgYmFja2luZyBmaWxlLCBidXQgZG9lcyBpdCBhIGJpdCB3cm9uZy4g
VHJlYXRzIHVuYWxsb2NhdGVkIGFzIERBVEEgaWYgbm8gYmFja2luZy4KCmltZy1tYXA6IGdldF9i
bG9ja19zdGF0dXM6IGRpc3Rpbmd1aXNoIFpFUk8sIERBVEEgYW5kIGdvLXRvLWJhY2tpbmcuIENv
dW50IGRlcHRoIG9mIHRoZSBiYWNraW5nLiBKdXN0IHJlcG9ydHMgZmluYWwgWkVSTyBhbmQgREFU
QS4gU28sIGZzLXVuYWxsb2NhdGVkIHRoaW5nIGlzIHJlcG9ydGVkIHRvIHVzZXIKCj0gYmRydl9i
bG9ja19zdGF0dXNfYWJvdmUgPQoKYmxvY2stY29weTogYmxvY2tfY29weV9ibG9ja19zdGF0dXM6
IHdhbnRzIHR3byB0aGluZ3M6CiAgCiAgMS4gc2tpcCBnby10by1iYWNraW5nIGhvbGVzIGluIHRv
cCBsYXllciBmb3IgdG9wIG1vZGUKICAyLiBkbyB3cml0ZV96ZXJvIGZvciBaRVJPIGFyZWFzCgpt
aXJyb3I6IGNhbGwgb24gdGhlIHdob2xlIGJhY2tpbmcgY2hhaW4KICAgLSBmb3IgREFUQSAoYW5k
IGZvciBEQVRBfFpFUk8gd2hpY2ggaXMgYmFkKSBkbyBqdXN0IGNvcHkKICAgLSBmb3IgWkVSTyBk
byBqdXN0IFpFUk8KICAgLSBmb3IgMCAod2hpY2ggbWVhbnMgdGhhdCBib3R0b20gbGF5ZXIgZG9l
c24ndCByZXBvcnQgdGhhdCB1bmFsbG9jYXRlZCBhcmUgemVybykgZG9lcyBESVNDQVJEICh3aGlj
aCBpcyBtb3N0LXByb2JhYmx5IHplcm9pbmcpIC0gYWJzb2x1dGVseSB3cm9uZyB0aGluZwoKcWNv
dzI6IGlzX3plcm86IGNhbGwgb24gdGhlIHdob2xlIGJhY2tpbmcgY2hhaW4sIHdhbnQncyBqdXN0
IHRvIGNoZWNrIGlzIHJlYWRzLWFzLXplcm8gb3Igbm90LgoKcWNvdzI6IHFjb3cyX21lYXN1cmU6
IGNhbGwgb24gdGhlIHdob2xlIGJhY2tpbmcgY2hhaW46CiAgIC0gc2tpcCBaRVJPCiAgIC0gY291
bnQgY2x1c3RlcnMgd2l0aCBib3RoIERBVEEgYW5kIEFMTE9DQVRFRCBzZXQuIEhtbS4gQUxMT0NB
VEVEIGlzIGFsd2F5cyBzZXQgZm9yIERBVEEuIFNlZW1zIHRoZSBmdW5jdGlvbiBhY3R1YWxseSB0
cmllcyB0byBjYWxjdWxhdGUgZGlzayBvY2N1cGF0aW9uLCBhc3N1bWluZyB0aGF0IEJEUlZfQkxP
Q0tfQUxMT0NBVEVEIGhlbHBzIGluIGl0LCBidXQgaXQgYWN0dWFsbHkgZG9lc24ndC4uCgogICBJ
IHRoaW5rLCBjb3JyZWN0IHNvbHV0aW9uIGlzIHRvIHN1cHBvcnQgb2Zmc2V0IGFuZCBieXRlcyBp
biBiZHJ2X21lYXN1cmUsIGFuZCBzcGxpdCBpdCBmcm9tIGJsb2NrX3N0YXR1cy4gVGhlbiBxY293
Ml9tZWFzdXJlIHdpbGwganVzdCByZWN1cnNpdmVseSBjYWxsIGJkcnZfbWVhc3VyZSBvbiBpdHMg
Y2hpbGRyZW4uIFRoaXMgd291bGQgYmUgY2xlYW4uCgpuYmQ6IG5iZF9jb19zZW5kX3NwYXJzZV9y
ZWFkOiBjYWxsIG9uIHRoZSB3aG9sZSBiYWNraW5nIGNoYWluOgogICAtIHdhbnRzIHRvIGRpc3Rp
bmd1aXNoIHplcm9lcwoKbmJkOiBibG9ja3N0YXR1c190b19leHRlbnRzOiBjYWxsIG9uIHRoZSB3
aG9sZSBiYWNraW5nIGNoYWluOgogICAhQUxMT0NBVEVEIC0+IE5CRF9IT0xFCiAgIFpFUk8gLT4g
TkJEX1pFUk8KCiAgIFNvLCB3ZSByZXBvcnQgSE9MRSBvbmx5IGlmIGl0J3Mgbm90IEJEUlZfQkxP
Q0tfQUxMT0NBVEVEIG9uIGFueSBsYXllci4uIFRoYXQncyB3cm9uZy4gSSB0aGluaywgd2Ugc2hv
dWxkIHJlcG9ydCBIT0xFIGluIGEgbG90IG1vcmUgY2FzZXMuIEFjdHVhbGx5LCB3aGVuIG5vdCBv
Y2N1cHkgcmVhbCBzcGFjZSBvbiBkaXNrLgoKaW1nLWNvbXBhcmU6IGNhbGwgb24gdGhlIHdob2xl
IGJhY2tpbmcgY2hhaW46CiAgLSBkbyBub3QgY29tcGFyZSB6ZXJvZXMKICAtIGRvIG5vdCBjb21w
YXJlIGlmIGJvdGggcmVwb3J0IHVuYWxsb2NhdGVkLi4gaXQncyBhY3R1YWxseSBub3QgY29ycmVj
dCBmb3IgcHJvdG9jb2xzIHdoaWNoIHJlcG9ydHMgZnMtdW5hbGxvY2F0ZWQtbm9uLXplcm9lcy4g
QXMgcmVhZHMgbWF5IGRpZmZlciBhY3R1YWxseS4gU3RpbGwsIHJlYWQgZnJvbSBmcy11bmFsbG9j
YXRlZCBhcmVhIGlzIG5vdCBndWFyYW50ZWVkIHRvIHJldHVybiBzYW1lIHRoaW5nIGVhY2ggdGlt
ZSwgeWVzPyBBdCBsZWFzdCwgbnVsbC1jbyBkb2Vzbid0IGd1YXJhbnRlZSBpdCA6KS4uIFNvLCBp
dCBtYXkgYmUgY29ycmVjdCB0byBza2lwIHRoZXNlIGFyZWFzLiBPciBtYXkgYmUgYmV0dGVyIHRv
IGFsd2F5cyByZXBvcnQgdGhlbSBkaWZmZXJlbnQ/PwogIC0gY29uc2lkZXIgZGF0YS16ZXJvZXMg
ZXF1YWwgdG8gdW5hbGxvY2F0ZWQuLiBpdCdzIGRlZmluaXRlbHkgbm90IGNvcnJlY3QgZm9yIHBy
b3RvY29scyB3aGljaCByZXBvcnRzIGZzLXVuYWxsb2NhdGVkLW5vbi16ZXJvZXMKCiAgSSB0aGlu
aywgaW1nLWNvbXBhcmUgbXVzdCBvbmx5IGNvbnNpZGVyIHplcm8vbm9uLXplcm8sIGFuZCBkb24n
dCB0b3VjaCBvdGhlciBibG9jay1zdGF0dXMgZmVhdHVyZXMuIE90aGVyd2lzZSBpdCdzIGEgbWVz
cwoKaW1nLWNvbnZlcnQ6IGNvbnZlcnRfaXRlcmF0aW9uX3NlY3RvcnM6IGNhbGwgb24gdGhlIHdo
b2xlIGJhY2tpbmcgY2hhaW46IGFscmVhZHkgZGVzY3JpYmVkIGluIGJkcnZfYmxvY2tfc3RhdHVz
IHNlY3Rpb24KCj0gYmRydl9pc19hbGxvY2F0ZWQgPQoKT2J2aW91cyB0aGluZyBmb3IgYmFja2lu
Zy1jaGFpbiByZWxhdGVkIG9wZXJhdGlvbiAoc3RpbGwgd3JvbmcgdGhhdCBzb21lIHByb3RvY29s
IGRyaXZlcnMgbWF5IHJldHVybiBmcy11bmFsbG9jYXRlZCBhbmQgaXQgaXMgdHJlYXRlZCBhcyBn
by10by1iYWNraW5nIGFyZWFzKToKICAgIGJsb2NrLWNvcHksIGNvbW1pdCwgY29weS1vbi1yZWFk
LCBzdHJlYW0sIGltZy1yZWJhc2UKCk90aGVyczoKdnZmYXQ6IG9fTyBpdCBoYXMgcWNvdyBjaGls
ZC4uIGFuZCBvcGVyYXRlcyBsaWtlIHNlbGYgaXMgYSBiYWNraW5nIG9mIHRoaXMgY2hpbGQuIEJ1
dCB5ZXMsIGl0IGp1c3QgdXNlcyBiZHJ2X2lzX2FsbG9jYXRlZCB0byB1bmRlcnN0YW5kIGlzIGNo
dW5rIGlzIHJld3JpdHRlbiBpbiBxY293LgoKbWlncmF0aW9uL2Jsb2NrOiBza2lwIHVuYWxsb2Nh
dGVkIGZvciB0b3AgbW9kZSAoc2hhcmVkX2Jhc2UsIGFzIGl0IGNhbGxlZCBoZXJlKQoKaW8tYWxs
b2M6IGp1c3QgcmVwb3J0IG51bWJlciBvZiBhbGxvY2F0ZWQgaW4gdG9wIGxheWVyCgppby1tYXA6
IG1hcF9pc19hbGxvY2F0ZWQ6IHNhbWUgdGhpbmcgYXMgaW8tYWxsb2MsIGJ1dCByZXBvcnQgY2h1
bmtzCgp0ZXN0X3N5bmNfb3BfYmxvY2tfc3RhdHVzOiBqdXN0IGNoZWNrIHdoYXQgaXQgcmV0dXJu
cwoKPSBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSA9CgpPYnZpb3VzIHVzYWdlIGZvciBiYWNraW5n
LWNoYWluIHJlbGF0ZWQ6IGNvbW1pdCwgbWlycm9yLCBzdHJlYW0sIGltZy1yZWJhc2UuIFdyb25n
IGZvciBmcy11bmFsbG9jYXRlZC1ub24temVybyByZXBvcnRpbmcgZHJpdmVycwoKT3RoZXJzOgpx
Y293MjogaXNfdW5hbGxvY2F0ZWQ6IGNhbGwgZm9yIHRoZSB3aG9sZSBiYWNraW5nIGNoYWluLiBV
c2VkIHRvIGNoZWNrIGlzLXplcm8uLiBXcm9uZyBmb3IgZnMtdW5hbGxvY2F0ZWQtbm9uLXplcm8g
cmVwb3J0aW5nIGRyaXZlcnMsIGFuZCBtYXkgYmUgbW9yZSBlZmZpY2llbnQgaWYgY29uc2lkZXIg
YWxzbyBaRVJPIHN0YXR1cy4uIGJ1dCBpbiBzb21lIHNtYXJ0LWZhc3Qgd2F5LgoKcmVwbGljYXRp
b246IGFsbG9jYXRlZCBvciBub3QgaW4gYmFja2luZy1jaGFpbjogY29tbW9uIGNhc2UK

--------------DBA025E4B6D5E27CB3B4512D--


Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1596DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A2221835
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TWjnTa0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A2221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWBF-0003AH-RE
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTWA9-0001HW-Mb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTWA8-0000cj-Mh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:45:01 -0400
Received: from mail-db8eur05on2136.outbound.protection.outlook.com
 ([40.107.20.136]:64353 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTWA4-0000c9-Rc; Tue, 28 Apr 2020 15:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVaL1sJm5vpfqm5HG9tQNsymGsbLRNiRuPae9zV8M+wQuQoA1kLjR+VIbCW9wxwE2cjFPD712fklEh1st1egObQQdeqapthjK6E5qgvH+oPQ4cuxUawl3KOHM+h7/MmHJmcmbtfKrQ9N5aXOUfmOE+BSVcW37WPCO6jlHRQkj8ziJ58oQSIvMptj3PZWK07CVkqXJx028IA4DJvCBSZhQ2uXSVFUI0FkudA4LNnZ7IojOtAVwHd6Nx/7VYG7ZYHSuHgYFRhi2CoVKy0/jjdWpmj1x+a4lTuwtNAh46omTINJN0I85GnWia2s9ZjoWMSFANyHKkqDStd4JDyNCpu24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EGhuPIRZM+foDUN1xlld/2LsYjF7Qoq8oFsdvEkV+k=;
 b=RnEzAIgx12zHvA/eyZaF61mcrQ8BSSrHvSw5sSmxrKbkzT7V0d3wnnV2Lfqw7swY4243ACC4Yb384w9mDuRJYQgJkfTBfzvhis4V2YbC3lcOHSBF0nT2gKlzbn7/H+GR1oqOshCn7wHMkS/4ViFkPCw9Nx3AnklnBJDMQSpiwaEWCupoo53UIIX7N9H2D+E/aPcXwi1SRiGGcx4bnFHqdKSE0EA75S46LNDCvUk1uzXtAjqijX6AT1qi8ebkcmQfN/5asOLDG1XSKOjqqSsBlMD3FLPaV5ea2PljWuOFChDLo6Iw4+CYrc601/ORK7muj0GThpuj813p1rDZ6sNOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EGhuPIRZM+foDUN1xlld/2LsYjF7Qoq8oFsdvEkV+k=;
 b=TWjnTa0IuUj+/7ndyMsJe2rWcFZ+PDf8YqvKYDkBJrfQsRXy3PCvhpvySqDp967Q1mjlwV/u+mXfmRop6bZsTnYPEAL4sHnVnBQK4XJxjuHglZzFk3/F9W4GykRpCJWRNLZE2tkMF0RW32QOI/p+5GvP9QKr0i7MmjD2dOh+1PE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5416.eurprd08.prod.outlook.com (2603:10a6:20b:10e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 19:44:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 19:44:52 +0000
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
X-Tagtoolbar-Keys: D20200428224450168
Message-ID: <91b741ac-248c-2065-17b9-7fe31eafee40@virtuozzo.com>
Date: Tue, 28 Apr 2020 22:44:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <04dd8365-7077-766a-6d42-1aac26abbdeb@virtuozzo.com>
Content-Type: multipart/mixed; boundary="------------7F3F05D5D92819F5ECEB196F"
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 19:44:51 +0000
X-Tagtoolbar-Keys: D20200428224450168
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25e5a629-fa93-43ff-19bc-08d7ebac9e5c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5416FF4AAD65164D079540B5C1AC0@AM7PR08MB5416.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(366004)(39840400004)(346002)(396003)(16526019)(66556008)(316002)(86362001)(26005)(6486002)(2906002)(186003)(66476007)(5660300002)(235185007)(8936002)(66946007)(4326008)(33964004)(8676002)(478600001)(53546011)(956004)(2616005)(52116002)(31686004)(16576012)(54906003)(31696002)(36756003)(966005)(66616009)(110136005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8QJwluZzTlRzqkgNplbPJEm9kDvqo5v2n9Ok5Gows+QafA9WKu5mpFCXj5ekzZlz30cR+Sq7VcXls0zXaOPju7hvCkbqT0SxxN1ydSxXOn/06lwGoi/Imo4vxjR1SD8LBJ+D0H26lFf9dcne6G40CTB//Rk3r38/sUS9LD06alHnqSFKSp2gXacrBcx0C6iCEKv4p0t6/0TLymoWvnuammXyscmibMcyZOnXOq/1CmvpgdNkC0Q+UpO4Y6tA5XDfMvrv6LpSx9Tfn3vBxf7sPhzH2WM35Wbey7qEAxBA7RxnTRczrlJwnoSRH1S9vJGvY7D+XYf8lI3hc+sQBBCNiXFbzxa/lXF1E59Zj8A+F2mZB1DZuHAT+/FrXikkweqdWm24ytuDL+ixuS3jVVpUHaj2yjv2A0alQEgqYV7R5wduJrg2rTzghZ9uDaSf0REpBBO+BzYoWHxO5KTlqfDydnsgnOfrBbRUOSM5bJGJuAQuKT9tJOjbOFszJVnGVPNHmwu/QDKewUkHib3CuyrYQ==
X-MS-Exchange-AntiSpam-MessageData: qYzCknh96mBAPFEwIbQlH4Xs1+cLJMlkkHLC50kPV0VbZEggLZQ1u5et7cdppfqhX5MXTwGHJJ344YWJpJ9RcY/58gGC65jGIvp0epmlV5w2/tYuXT/crvyoyqN0T/DmyXabf8ymIbFkewIelJFx31lpigK/8vclQL2sOy3+ZY7yIXlc70zVeISz+jiwektz2g4pVzwWPzs+iRCO24zvKA0x60ZAdvbBPIHo5VCM1HIODw0WCnW4rVcnJQyLl3CqBnKWDBNIqYN5B3q6byJjyhvwnUvQ6zOvR+YsrkuDlvc67WhHhDo+bvauVibse3b2Q80m45as+yzuMe9Ham303RnarbPcW7TPuU8rm4Wr0wVOZBoeFMb9fXu2/qT1VZfiwsuUyigkwdU3R8v4/1JeMbg+sgXmWti5WWG/jHFrnnkY8DaABIGLYOopwI1gZoEMo9yGvupJZUwKSuO3a8ZJ5jqWpBqEn3eiwVAEjEgqz67rPpPjutFhlL72kW+7/93N7Y8my2Tfuo/SB6rBYzZRsTxA38PZ0gpoZzd2uhZx53wb8e7LwbmV718gTD8GBZUZLksdb8qp0OjpKNhgyWF28vta9yPR1lQ/1umTlbPpUtBrHxrBS7/vMSCdB4OAcc+C+WsiyWABz0ApdIAlAaZ2vB/u9GoZXnUfWPIpU6LBN1kPwgK1gBcmsH99aEjJ3CoAktsk5pqK41tYIggfPyz8EZdOoXwA//UMwVMUl7DW7Zx/CKwy8cUuHFotJZMLRtjZuL/YKVCQG3BOg31NEaQSXT0IkglRZ6/I6EjSf4C6q1s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e5a629-fa93-43ff-19bc-08d7ebac9e5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 19:44:52.2969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coqqo4QJ7EeuJOfe4bN+EYcoHKQXm71iLKMNdp+fkMsyz/L95JnaBlu6BP85BfehKGFSxUzlvIgrZSncbWgg+hiNcinLwdgdJl6qIeKRVZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5416
Received-SPF: pass client-ip=40.107.20.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 15:44:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.136
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

--------------7F3F05D5D92819F5ECEB196F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

28.04.2020 19:46, Vladimir Sementsov-Ogievskiy wrote:
> 28.04.2020 19:18, Eric Blake wrote:
>> On 4/28/20 10:13 AM, Vladimir Sementsov-Ogievskiy wrote:
>>
>>>>> Hm.  I could imagine that there are formats that have non-zero holes
>>>>> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
>>>>> ZERO or DATA then.
>>>>>
>>>>> But OTOH we don’t care about such cases, do we?  We need to know whether
>>>>> ranges are zero, data, or unallocated.  If they aren’t zero, we only
>>>>> care about whether reading from it will return data from this layer or not.
>>>>>
>>>>> So I suppose that anything that doesn’t support backing files (or
>>>>> filtered children) should always return ZERO and/or DATA.
>>>>
>>>> I'm not sure I agree with the notion that everything should be
>>>> BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means today
>>>> at least. If we want to change this, we will have to check all callers
>>>> of bdrv_is_allocated() and friends who might use this to find holes in
>>>> the file.
>>>
>>> Yes. Because they are doing incorrect (or at least undocumented and unreliable) thing.
>>
>> Here's some previous mails discussing the same question about what block_status should actually mean.  At the time, I was so scared of the prospect of something breaking if I changed things that I ended up keeping status quo, so here we are revisiting the topic several years later, still asking the same questions.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00069.html
>> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03757.html
>>
>>>
>>>>
>>>> Basically, the way bdrv_is_allocated() works today is that we assume an
>>>> implicit zeroed backing layer even for block drivers that don't support
>>>> backing files.
>>>
>>> But read doesn't work so: it will read data from the bottom layer, not from
>>> this implicit zeroed backing layer. And it is inconsistent. On read data
>>> comes exactly from this layer, not from its implicit backing. So it should
>>> return BDRV_BLOCK_ALLOCATED, accordingly to its definition..
>>>
>>> Or, we should at least document current behavior:
>>>
>>>    BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>>>    layer rather than any backing, set by block. Attention: it may not be set
>>>    for drivers without backing support, still data is of course read from
>>>    this layer. Note, that for such drivers BDRV_BLOCK_ALLOCATED may mean
>>>    allocation on fs level, which occupies real space on disk.. So, for such drivers
>>>
>>>    ZERO | ALLOCATED means that, read as zero, data may be allocated on fs, or
>>>    (most probably) not,
>>>    don't look at ALLOCATED flag, as it is added by generic layer for another logic,
>>>    not related to fs-allocation.
>>>
>>>    0 means that, most probably, data doesn't occupy space on fs, zero-status is
>>>    unknown (most probably non-zero)
>>>
>>
>> That may be right in describing the current situation, but again, needs a GOOD audit of what we are actually using it for, and whether it is what we really WANT to be using it for.  If we're going to audit/refactor the code, we might as well get semantics that are actually useful, rather than painfully contorted to documentation that happens to match our current contorted code.
>>
> 
> Honest enough:) I'll try to make a table.
> 
> I don't think that reporting fs-allocation status is a bad thing. But I'm sure that it should be separated from backing-chain-allocated concept.
> 

As a first step, I've don brief analysis of .bdrv_co_block_status of drivers (attached)

-- 
Best regards,
Vladimir

--------------7F3F05D5D92819F5ECEB196F
Content-Type: text/plain; charset=UTF-8;
 name="block-status-report"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="block-status-report"

PSBGaWx0ZXIgZnVuY3Rpb25zID0KbWlycm9yLGNvbW1pdCxiYWNrdXAgZmlsdGVyczogYmRydl9j
b19ibG9ja19zdGF0dXNfZnJvbV9iYWNraW5nCmJsa2xvZ3dyaXRlcyxjb21wcmVzcyxDT1IsdGhy
b3R0bGU6IGJkcnZfY29fYmxvY2tfc3RhdHVzX2Zyb21fZmlsZQoKICAgIHJldHVybiBCRFJWX0JM
T0NLX1JBVyB8IEJEUlZfQkxPQ0tfT0ZGU0VUX1ZBTElECiAgICAtIHNlbWFudGljcyBvZiBCRFJW
X0JMT0NLX1JBVyBpcyB1bmNsZWFuLCBiZWhhdmlvciBpcyBicm9rZW4KCmJsa2RlYnVnOiBibGtk
ZWJ1Z19jb19ibG9ja19zdGF0dXMKICAgIC0gYWN0dWFsbHksIHVzZXMgYmRydl9jb19ibG9ja19z
dGF0dXNfZnJvbV9maWxlLAogICAgYWZ0ZXIgYWRkaXRpb25hbCBibGtkZWJ1Zy1yZWxhdGVkIHRo
aW5ncyBub3QgaW5mbHVpbmNpbmcgdGhlIHJlc3VsdAoKPSByYXcgPQpyYXc6IHJhd19jb19ibG9j
a19zdGF0dXMKICAgIHJldHVybiBCRFJWX0JMT0NLX1JBVyB8IEJEUlZfQkxPQ0tfT0ZGU0VUX1ZB
TElECiAgICAtIHNlbWFudGljcyBvZiBCRFJWX0JMT0NLX1JBVyBpcyB1bmNsZWFuLCBiZWhhdmlv
ciBpcyBicm9rZW4KClN1bW1hcnk6IHdlIG5lZWQgdG8gZml4IEJEUlZfQkxPQ0tfUkFXLXJlY3Vy
c2lvbiBzZW1hbnRpY3MgdG8gbm90IGludGVyZmVyZSB3aXRoIGJsb2NrX3N0YXR1c19hYm92ZS9p
c19hbGxvY2F0ZWRfYWJvdmUgbG9vcHMuCgo9IEZvcm1hdCBkcml2ZXJzIHdpdGggc3VwcG9ydHNf
YmFja2luZyA9IHRydWUgPQoKcWVkOiBiZHJ2X3FlZF9jb19ibG9ja19zdGF0dXMKICAgIGJkaS0+
dW5hbGxvY2F0ZWRfYmxvY2tzX2FyZV96ZXJvID0gdHJ1ZTsKICAgIAogICAgMCAtIGdvIHRvIGJh
Y2tpbmcKICAgIFpFUk8gLSBtZXRhZGF0YS16ZXJvCiAgICBEQVRBIHwgT0ZGU0VUX1ZBTElEIHdp
dGggQG1hcCBzZXQgYW5kIEBmaWxlID0gZmlsZS1jaGlsZCA6IG1ldGFkYXRhLWFsbG9jYXRlZC1k
YXRhCiAgICAgCnBhcmFsbGVsczogcGFyYWxsZWxzX2NvX2Jsb2NrX3N0YXR1cwogICAgdW5hbGxv
Y2F0ZWRfYmxvY2tzX2FyZV96ZXJvIGlzIHVuc2V0LCBidXQgdGhleSBhcmUgYWN0dWFsbHkgcmVh
ZCBhcyB6ZXJvIGlmIG5vIGJhY2tpbmcKCiAgICAwIC0gZ28gdG8gYmFja2luZwogICAgREFUQSB8
IE9GRlNFVF9WQUxJRCB3aXRoIEBtYXAgc2V0IGFuZCBAZmlsZSA9IGZpbGUtY2hpbGQgOiBtZXRh
ZGF0LWFsbG9jYXRlZC1kYXRhCgpxY293MjogcWNvdzJfY29fYmxvY2tfc3RhdHVzCiAgICBiZGkt
PnVuYWxsb2NhdGVkX2Jsb2Nrc19hcmVfemVybyA9IHRydWU7CgogICAgWkVSTyB8IE9GRlNFVF9W
QUxJRCB3aXRoIEBtYXAgc2V0IGFuZCBAZmlsZSA9IHNvbWV0aGluZyA6IG1ldGFkYXRhLWFsbG9j
YXRlZC16ZXJvCiAgICBEQVRBIHwgT0ZGU0VUX1ZBTElEIHdpdGggQG1hcCBzZXQgYW5kIEBmaWxl
ID0gc29tZXRoaW5nIDogbWV0YWRhdGEtYWxsb2NhdGVkLWRhdGEKICAgIFJFQ1VSU0UgfCBEQVRB
IHwgT0ZGU0VUX1ZBTElEIHdpdGggQG1hcCBzZXQgYW5kIEBmaWxlID0gZmlsZS1jaGlsZCA6IG1l
dGFkYXRhLWFsbG9jYXRlZC1kYXRhIChoaW50LCB0aGF0IHlvdSdkIGJldHRlciBkaWcgemVyb2Vz
IGluICpmaWxlKQoKICAgIFpFUk8gOiBtZXRhZGF0YS16ZXJvCgogICAgREFUQSA6IGNvbXByZXNz
ZWQgY2x1c3RlcnMuIFNvLCBpdCdzIG1ldGFkYXRhLWFsbG9jYXRlZC1kYXRhLCBidXQgbm8gb2Zm
c2V0IHdlIGNhbiBwcm92aWRlCgogICAgMDogZ28gdG8gYmFja2luZwoKcWNvdzogcWNvd19jb19i
bG9ja19zdGF0dXMKICAgIHVuYWxsb2NhdGVkX2Jsb2Nrc19hcmVfemVybyBpcyB1bnNldCwgYnV0
IHRoZXkgYXJlIGFjdHVhbGx5IHJlYWQgYXMgemVybyBpZiBubyBiYWNraW5nCgogICAgMDogZ28g
dG8gYmFja2luZwogICAgREFUQTogY29tcHJlc3NlZAogICAgREFUQSB8IE9GRlNFVF9WQUxJRCB3
aXRoIEBtYXAgc2V0IGFuZCBAZmlsZSA9IGZpbGUtY2hpbGQgOiBtZXRhZGF0YS1hbGxvY2F0ZWQt
ZGF0YQoKdm1kazogdm1ka19jb19ibG9ja19zdGF0dXMKICAgIHVuYWxsb2NhdGVkX2Jsb2Nrc19h
cmVfemVybyBpcyB1bnNldCwgYnV0IHRoZXkgYXJlIGFjdHVhbGx5IHJlYWQgYXMgemVybyBpZiBu
byBiYWNraW5nCgogICAgMDogZ28gdG8gYmFja2luZwogICAgWkVSTzogbWV0YWRhdGEtemVybwog
ICAgREFUQSB3aXRoIEBmaWxlIHNldCB0byBzb21ldGhpbmc6IGNvbXByZXNzZWQKICAgIERBVEEg
fCBPRkZTRVRfVkFMSUQgIHdpdGggQG1hcCBhbmQgQGZpbGUgc2V0IDogbWV0YWRhdGEtYWxsb2Nh
dGVkLWRhdGEKICAgIFJFQ1VSU0UgfCBEQVRBIHwgT0ZGU0VUX1ZBTElEICB3aXRoIEBtYXAgYW5k
IEBmaWxlIHNldCA6IG1ldGFkYXRhLWFsbG9jYXRlZC1kYXRhICh3aXRoIGhpbnQpCgpTdW1tYXJ5
OgogIFNvLCBvYnZpb3VzbHkgdW5hbGxvY2F0ZWRfYmxvY2tzX2FyZV96ZXJvIGlzIG5vdCBuZWVk
ZWQsIGFzIGFsbCB0aGV5IGJlaGF2ZSBzbwoKICBjb21tb24gc2VtYW50aWNzOgogIGp1c3QgY29y
cmVzcG9uZHMgdG8gc3BlY2lmaWNhdGlvbjoKICBEQVRBIHwgWkVSTyBtZWFucyBiYWNraW5nLWNo
YWluLWFsbG9jYXRlZC1hdC10aGlzLWxldmVsCiAgWkVSTyBtZWFucyByZWFkcyBhcyB6ZXJvCiAg
T0ZGU0VUX1ZBTElEIG1lYW5zIHRoYXQgaXQgbWF5IGJlIHJlYWQgZnJvbSBAZmlsZSAod2hpY2gg
c2hvdWxkIGJlIGNoaWxkIG9mIHRoaXMpIGF0IEBtYXAgb2Zmc2V0CiAgYWRkaXRpb25hbCBSRUNV
UlNFIGlzIGhpbnQgdG8gZGlnIHplcm9lcyBpbiBAZmlsZSBvZiBAbWFwIG9mZnNldCAoaWYgaXQg
aXMgbm90IHNldCwgZGlnZ2luZyBpcyBtb3N0IHByb2JhYmx5IHVzZWxlc3MpCgogIG9mIGNvdXJz
ZSwgbm90aGluZyBoZXJlIGFib3V0IGZzLWFsbG9jYXRpb24gc3RhdHVzIG9yIG9jY3VweWluZyBz
cGFjZSBvbiBkaXNrCgo9IEZvcm1hdCBkcml2ZXJzIHdpdGggc3VwcG9ydHNfYmFja2luZyA9IGZh
bHNlID0KCnZkaTogdmRpX2NvX2Jsb2NrX3N0YXR1cwogICAgYmRpLT51bmFsbG9jYXRlZF9ibG9j
a3NfYXJlX3plcm8gPSB0cnVlOwoKICAgIDA6IG1ldGFkYXRhLXVuYWxsb2NhdGVkLi4gCiAgICAg
ICBpbiB0aGlzIGNhc2UgdmlkX2NvX3ByZWFkdiB6ZXJvaXplIHFpb3YuIFNvLCBpdCBhY3R1YWxs
eSBzaG91bGQgYmUgWkVSTwogICAgREFUQSB8IE9GRlNFVF9WQUxJRCB3aXRoIEBtYXAgc2V0IGFu
ZCBAZmlsZSA9IGZpbGUtY2hpbGQgOiBtZXRhZGF0YS1hbGxvY2F0ZWQtZGF0YQogICAgUkVDVVJT
RSB8IERBVEEgfCBPRkZTRVRfVkFMSUQgd2l0aCBAbWFwIHNldCBhbmQgQGZpbGUgPSBmaWxlLWNo
aWxkIDogbWV0YWRhdGEtYWxsb2NhdGVkLWRhdGEgKGhpbnQsIHRoYXQgeW91J2QgYmV0dGVyIGRp
ZyB6ZXJvZXMgaW4gKmZpbGUpCgp2cGM6IHZwY19jb19ibG9ja19zdGF0dXMKICAgIGJkaS0+dW5h
bGxvY2F0ZWRfYmxvY2tzX2FyZV96ZXJvID0gdHJ1ZTsKICAgIAogICAgMDogdW5hbGxvY2F0ZWQ/
CiAgICAgICBpbiB0aGlzIGNhc2UgdnBjX2NvX3ByZWFkdiB6ZXJvaXplIHFpb3YuIFNvLCBpdCBh
Y3R1YWxseSBzaG91bGQgYmUgWkVSTwogICAgREFUQSB8IE9GRlNFVF9WQUxJRCB3aXRoIEBtYXAg
c2V0IGFuZCBAZmlsZSA9IGZpbGUtY2hpbGQgOiBtZXRhZGF0YS1hbGxvY2F0ZWQtZGF0YQogICAg
UkVDVVJTRSB8IERBVEEgfCBPRkZTRVRfVkFMSUQgd2l0aCBAbWFwIHNldCBhbmQgQGZpbGUgPSBm
aWxlLWNoaWxkIDogbWV0YWRhdGEtYWxsb2NhdGVkLWRhdGEgKGhpbnQsIHRoYXQgeW91J2QgYmV0
dGVyIGRpZyB6ZXJvZXMgaW4gKmZpbGUpCgpTdW1tYXJ5OgogIEFnYWluLCB1bmFsbG9jYXRlZF9i
bG9ja3NfYXJlX3plcm8gaXMgYWx3YXlzIHRydWUsIHNvIGl0J3Mgbm90IGFjdHVhbGx5IG5lZWRl
ZAogIE1vcmVvdmVyLCBJIHRoaW5rIGRyaXZlcnMgc2hvdWxkIHJldHVybiBaRVJPIGJ5IHRoZW1z
ZWx2ZXMKICBTbyBjb21tb24gc2VtYW50aWNzIHNob3VsZCBiZSB0aGUgc2FtZSBhcyBmb3IgYmFj
a2luZy1zdXBwb3J0aW5nIGZvcm1hdHMsIGV4Y2VwdCBmb3IgdGhleSBtdXN0IGFsd2F5cyBzZXQg
YXQgbGVhc3Qgb25lIG9mIERBVEEgYW5kIFpFUk8gZmxhZ3MKCiAgb2YgY291cnNlLCBub3RoaW5n
IGhlcmUgYWJvdXQgZnMtYWxsb2NhdGlvbiBzdGF0dXMgb3Igb2NjdXB5aW5nIHNwYWNlIG9uIGRp
c2sKCj09IFByb3RvY29sIGRyaXZlcnMsIHdpdGggbm8gY2hpbGRyZW4gPT0KCmlzY3NpLCBpc2Vy
OiBpc2NzaV9jb19ibG9ja19zdGF0dXMKICAgIGJkaS0+dW5hbGxvY2F0ZWRfYmxvY2tzX2FyZV96
ZXJvID0gaXNjc2lsdW4tPmxicHJ6OwogICAgYnV0IGJsb2NrLXN0YXR1cyBuZXZlciByZXR1cm4g
MCwgaWYgaXNjc2lsdW4tPmxicHJ6CgogICAgYWx3YXlzOiBPRkZTRVRfVkFMSUQgd2l0aCBAbWFw
IHNldCBhbmQgQGZpbGUgPSB0aGlzCgogICAgYWxzbzoKICAgIERBVEEgOiBub3JtYWwtZGF0YQog
ICAgMCAtIGZzLXVuYWxsb2NhdGVkLCBub3QgemVybwogICAgWkVSTyAtIGZzLXVuYWxsb2NhdGVk
LCB6ZXJvCgpuYmQ6IG5iZF9jbGllbnRfY29fYmxvY2tfc3RhdHVzCgogICAgc3BlY2lhbCBjYXNl
OgoKICAgICAgICBaRVJPOiBmb3Igb2Zmc2V0ID4gbmJkIEVPRiAod2hpY2ggbWF5IGJlIG5vdCBz
ZWN0b3ItYWxpZ25lZCkKCiAgICAgICAgSSB0aGluaywgbm8gcmVhc29uIHRvIG5vdCByZXBvcnQg
T0ZGU0VUX1ZBTElEIGNvbWJpbmF0aW9uLAogICAgICAgIGFzIGJ5dGUtYWNjdXJhdGUgRU9GIGlz
IGFjdHVhbGx5IGludGVybmFsIG5iZCBkcml2ZXIgaW5mb3JtYXRpb24KCiAgICBvdGhlcndpc2U6
CgogICAgICAgIGFsd2F5czogT0ZGU0VUX1ZBTElEIHdpdGggQG1hcD1Ab2Zmc2V0IGFuZCBAZmls
ZSA9IHRoaXMKCiAgICAgICAgYWxzbzoKICAgICAgICBEQVRBOiBpZiBmZWF0dXJlIHVuc3VwcG9y
dGVkLCBzbyB1bmtub3duCiAgICAgICAgYW55IGNvbWJpbmF0aW9uIG9mIERBVEEgYW5kIFpFUk8s
IG1hcHBpbmcgTkJEIHByb3RvY29sLAogICAgICAgICFEQVRBIG1lYW5zOiBtb3N0IHByb2JhYmx5
IGRvZXNuJ3Qgb2NjdXB5IHNwYWNlIG9uIGZzCiAgICAgICAgWkVSTyBtZWFuczogcmVhZHMgYXMg
emVybwoKbnVsbC1jbywgbnVsbC1haW86IG51bGxfY29fYmxvY2tfc3RhdHVzCgogICAgSG1tLCBp
cyBpdCBhIHByb3RvY29sIGRyaXZlcj8gOikKCiAgICBhbHdheXM6IE9GRlNFVF9WQUxJRCB3aXRo
IEBtYXAgc2V0IGFuZCBAZmlsZSA9IHRoaXMKCiAgICBhbHNvOgogICAgWkVSTyAtIGlmIHMtPnJl
YWRfemVyb2VzIChyZWFkIHdpbGwgemVyb2l6ZSBxaW92KQogICAgMCAtIG90aGVyd2lzZSAocmVh
ZCBkb2VzIG5vdGhpbmcpCgpnbHVzdGVyOiBxZW11X2dsdXN0ZXJfY29fYmxvY2tfc3RhdHVzCgog
ICAgYWx3YXlzOiBPRkZTRVRfVkFMSUQgd2l0aCBAbWFwPUBvZmZzZXQgYW5kIEBmaWxlPXRoaXMK
CiAgICBhbHNvOgogICAgREFUQTogaWYgbm90IHdhbnRfemVybywgb3IgdW5rbm93biwgb3Iga25v
d24tZGF0YSAtIG5vcm1hbC1kYXRhCiAgICBaRVJPOiBmcy11bmFsbG9jYXRlZC16ZXJvCgpmaWxl
LXBvc2l4OiByYXdfY29fYmxvY2tfc3RhdHVzCmJkaS0+dW5hbGxvY2F0ZWRfYmxvY2tzX2FyZV96
ZXJvID0gcy0+ZGlzY2FyZF96ZXJvZXM7CmJ1dCBpdCBuZXZlciByZXBvcnQgdW5hbGxvY2F0ZWQg
OikKCiAgICBhbHdheXM6IE9GRlNFVF9WQUxJRCB3aXRoIEBtYXA9QG9mZnNldCBhbmQgQGZpbGU9
dGhpcwoKICAgIGFsc286CiAgICBEQVRBOiBpZiBub3Qgd2FudF96ZXJvLCBvciB1bmtub3duLCBv
ciBrbm93bi1kYXRhIC0gbm9ybWFsLWRhdGEKICAgIFpFUk86IGZzLXVuYWxsb2NhdGVkLXplcm8K
CnNoZWVwZG9nOiBzZF9jb19ibG9ja19zdGF0dXMKCiAgICBIbW0uIHNoZWVwZG9nIGlzIGEgZGVh
ZCBwcm9qZWN0LCB5ZXM/IFNob3VsZCB3ZSBkZXByZWNhdGUgaXQ/CgogICAgMDogZnMtdW5hbGxv
Y2F0ZWQKICAgIERBVEEgfCBPRkZTRVRfVkFMSUQgd2l0aCBAbWFwPUBvZmZzZXQgYW5kIEBmaWxl
PXRoaXMKCnZ2ZmF0OiB2dmZhdF9jb19ibG9ja19zdGF0dXMKCiAgICBhbHdheXM6IERBVEEKClN1
bW1hcnk6CiAgIEZpcnN0LCB1bmFsbG9jYXRlZF9ibG9ja3NfYXJlX3plcm8gaXMgb2J2aW91c2x5
IHVudXNlZC4KICAKICAgU2Vjb25kLCBJIHRoaW5rIGFsbCBzaG91bGQgYWx3YXlzIHJldHVybiBh
dCBsZWFzdAogICBPRkZTRVRfVkFMSUQgd2l0aCBAbWFwPUBvZmZzZXQgYW5kIEBmaWxlPXRoaXMs
IGFzCiAgIGl0J3MgZXhhY3RseSB3aGVyZSBmcm9tIHdlIHJlYWQgaW4gdGVybXMgb2YgYmxvY2st
bGF5ZXIuCiAgIEFuZCBnb29kIHRvIGJlIGNvbnNpc3RlbnQgYWJvdXQgaXQuCgogICBOZXh0LCBP
Sywgc2VlbXMsIG1vc3Qgb2YgZHJpdmVycyB3YW50cyB0byByZXBvcnQgZnMtYWxsb2NhdGlvbi9k
aXNrLW9jY3VweWluZyBzdGF0dXMsCgogICAwIC0gbW9zdCBwcm9iYWJseSBkb2Vzbid0IG9jY3Vw
eSBzcGFjZSwgbm90LXplcm8KICAgWkVSTyAtIG1vc3QgcHJvYmFibHkgZG9lc24ndCBvY2N1cHkg
c3BhY2UsIHplcm8KICAgREFUQSAtIG1vc3QgcHJvYmFibHkgb2NjdXB5IHNwYWNlLCBidXQgYWxz
byBpcyBhIHNhZmUgZGVmYXVsdAogICBEQVRBIHwgWkVSTyAtIG1vc3QgcHJvYmFibHkgb2NjdXB5
IHNwYWNlLCBidXQgZm9yIHNvbWUgcmVhc29uIGtub3duIHplcm9lcy4gT25seSBuYmQgY2FuIHRo
ZW9yZXRpY2FsbHkgZG8gaXQuCgoKPSBUZXN0aW5nID0KCnRlc3Q6IGJkcnZfdGVzdF9jb19ibG9j
a19zdGF0dXMKCiAgICBhbHdheXMgMC4gIHRlc3Rfc3luY19vcF9ibG9ja19zdGF0dXMoKSB0ZXN0
cyBkaWZmZXJlbnQgc2NlbmFyaW9zCiAgICBvZiBiZHJ2X2lzX2FsbG9jYXRlZC4gSWYgd2UgZGVj
aWRlIHRvIGNoYW5nZSB0aGUgYmVoYXZpb3IsIG5vdCBhCiAgICBwcm9ibGVtIHRvIGNoYW5nZSB0
ZXN0IHJlc3VsdHMgYW5kIGJkcnZfdGVzdF9jb19ibG9ja19zdGF0dXMoKQoKPSBEcml2ZXJzIHdp
dGhvdXQgYmxvY2tfc3RhdHVzID0KQSBsb3Qgb2YgdGhlbS4gTm90IGEgcHJvYmxlbS4gV29ydGgg
bWVudGlvbmluZyB2aGR4Ogp2aGR4CiAgICBiZGktPnVuYWxsb2NhdGVkX2Jsb2Nrc19hcmVfemVy
byA9CiAgICAgICAgKHMtPnBhcmFtcy5kYXRhX2JpdHMgJiBWSERYX1BBUkFNU19IQVNfUEFSRU5U
KSA9PSAwOwogICAgLSBpdCBpcyBub3QgdXNlZCwgYXMgREFUQXxBTExPQ0FURUQgaXMgc2V0IGZv
ciBkcml2ZXJzIHdpdGhvdXQgYmxvY2tfc3RhdHVzCg==

--------------7F3F05D5D92819F5ECEB196F--


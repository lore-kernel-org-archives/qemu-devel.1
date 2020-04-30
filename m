Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73284C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F2CE2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R6VwgeVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2CE2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEdh-00012r-BB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUEc9-000068-Kh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jUEc7-0004Qy-FG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:12:52 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:24673 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jUEc6-0004Qe-LF; Thu, 30 Apr 2020 15:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7EmHOWiqCDyX+Fzt6bBCuW9xQPZL8XLsHqQKqEjYxlVUkMB1yh/3UN8vHHSfcLf9ITfiLdX1vEIL2FZCb3QMHj6oJLMUHaYURSjceH/f6H8WgaC4k2MmUWRYqyfs5VB0WUhLDn6SgAnU7lJLGOU/PMMPDCpjUfvKp2I8L50Ql7uZlcQ9p/IMBcDByfiHGbQ6bI6Ydm7N18HsSh09TuX53yB+nICLWMR4psdRt8sAR0NfumbqvLeR7ziRfb3jpBKIOrywPy2wkxtg1+EvfMKOCCnerAEhCnAr/EuHhhJtz03s1yM2E1tzkNsgSWI1up8I365mXWdz2pKYIZ0wtgpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ShPctZPHA84YFCqMjZqXemrrJFwyl+dLzH6iaMzCVU=;
 b=NKe4JxKTfYa7SdhWZv1NL7Sxhgyg+iYm17F0q8Ck256xybddp2M82tpXM/hd4jMyC18PoFh0f/9cijXvxMXN0rwWcrVllZkzY1Dnciz1/mi7az241GfyWx1kfWtcpiRxT+0AiWUWr1WUvepV+gmOovtwFrN3OuaSpYipFcjZZl/N05uGC0eVj0W7v0Iq8eomYrWxcHu20efzodHNEe5/m46PyyEhj0v7ifbIPCdII+jeXpR5JaJY1enN1NrR506cX/cx+ZoRSTA4VAUWaeVV0G7ofXIxY6reSdIag4zjthOfa6lnwbG+2NB22wLbG3ZSuswRQaklPG04xorcluuaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ShPctZPHA84YFCqMjZqXemrrJFwyl+dLzH6iaMzCVU=;
 b=R6VwgeVy+8wYWU58FWN/3srlPJ9k6Uh1dH/KyqYmByksehE184esX1H27bFZKBA+R/CHGhzxlXbI41u9JKJQWRG/SVd1CMHIa/EFbJ39OhvIoq9KcdoEruYSE1Pbd1A1Po0yWi1+QhjKI1aRhf7ES00cIi13x+TbDfquQpeF34s=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 19:12:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 19:12:48 +0000
Subject: Re: backing chain & block status & filters
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430221246406
Message-ID: <f1220430-1d37-3cc4-0484-3e26fb7e4b84@virtuozzo.com>
Date: Thu, 30 Apr 2020 22:12:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0053.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM0PR10CA0053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Thu, 30 Apr 2020 19:12:47 +0000
X-Tagtoolbar-Keys: D20200430221246406
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5d01c6-d95c-4b49-eef5-08d7ed3a7858
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544758C2E0771A8D5684B77EC1AA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(366004)(6486002)(26005)(54906003)(316002)(107886003)(16576012)(52116002)(110136005)(186003)(478600001)(31686004)(53546011)(956004)(2616005)(16526019)(66476007)(2906002)(31696002)(66946007)(66556008)(5660300002)(86362001)(36756003)(8936002)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5ZQru+ZsX2lVRAkQYaLzqguOjDdpR1tRjCymFt8XfOK3bBCbmlx3MOn3oU3OXHgzBTG9RPWV0r2JzoP4RrBK+CVP6ZSjsu0NgoZoJgBV+ool394YJmRnIrsy1ZWT8ciG8WmzTuwZKs8vnCWU2TNxezfo2OSqnF2oARLHZCTVU4y+sktC6+PPfzMImFJjKktnKj+pQeBkUmR6juyQ1dTmsDjNjhK6nX9GKU8D3JjHS64CwdJwaqhiurqQuqPVo8q8QvuFNdzItryv+SUvVPNT4y0OXE1BELA3i/k+700HvoHQneTHXFKUIDFVCk+s0fGxSa0xoFJ49IOfulOjFslKu2x80MHi1sxogy2IKn8/NNDJ9jCrnBIbjNUnixINy54UmM9pG8rl5f4fXsSGDYkPMqZ/q+Xdvg+0Y9CCyl+whUjWh+NwZ07+2tACLpjtmEn
X-MS-Exchange-AntiSpam-MessageData: JlfW+GFN5Yxr8bb6lCaUgXS6cCPgFAjpYPm+8JCmoWbDRV0hKbPpESIYCstnw+GMficBBtzHwouuMfYQ4NR7Onjzms879rH/C6aU5U3ApQk0U/nP3ry5Bxuhx//eqxOhPcZCxiwPfos3fbHJJGl93ewIFvVz4tpfHOAmynaRrFPw5aDWNQqY9BWx5zjbHDyTkhPF3Elu9o5AvGf+JNcUudhuhH9UcpqyPDOgrtUk0Hs6DizoqCFpYUdytoeHTQABejqD5nXzj9euqU+pvghCvTpUbklInsphvJhX+351LhrXqOqg43Vj+ZT4ls9urLrFZsvWaKlcjxEGtzlhu0tRP+UNhdTXskTFYZZ4QHTrlgaTfmfFV6kW/Kk05pDsCyGazQ0btDnLs4jpdpsAmOSrHih9NgvLB7HqqFVsXUvxOabzxZF5NSPkz3vScKx1so3aiYH36w/ha1E7BToTQfNJ804rH0Ig90gadU7k1CnoZVmXe/NyjYehDj0KWa+mgh5amHqL0m/OubLkFPsL7GAfGqeEdKEJW7EzpHNdM4NyDpK4RERtiyye9w7RjVsCgdWDOumK/pSdK7zPZ9fYhcGVXfVZFaH0SPwsdpRc8iBf5CgsFNPYVU8wnYTDtvIBW7OHLzbvwtTbTAaiu9KkwNj+g+HXQjeyYVHG0PGdAuMycjmdf0vrDqsLsVbMKRWjuULbLkQQ90Xn5FdrluuowZnxD3cnmaQYX8pdUrl6QvX7+dG1hUkbHGhFw+SqGSmBgA4Y4twakZZYySCV/EwfKW6vCxonYee4MhBaQIWGFJ/UUQA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5d01c6-d95c-4b49-eef5-08d7ed3a7858
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 19:12:48.1056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zut6yMALKgjl1VOGZjJ+Z6b2JFZnxHpHLdZgaqQpbmFqWWHCf5jAi+oSQPrQwD7Ug/az6zjPSVgZHRRybTS+KUTLHXWsfOoF6y06zF2eXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 15:12:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.132
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.04.2020 17:51, Vladimir Sementsov-Ogievskiy wrote:
> 28.04.2020 14:08, Max Reitz wrote:
>> On 28.04.20 10:55, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi!
>>>
>>> I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and
>>> is_allocated_above", and returned to all the inconsistencies about
>>> block-status. I keep in mind Max's series about child-access functions,
>>> and Andrey's work about using COR filter in block-stream, which depends
>>> on Max's series (because, without them COR fitler with file child breaks
>>> backing chains).. And, it seems that it's better to discuss some
>>> questions before resending.
>>>
>>> First, problems about block-status:
>>>
>>> 1. We consider ALLOCATED = ZERO | DATA, and documented as follows:
>>>
>>>     * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>>>     * BDRV_BLOCK_ZERO: offset reads as zero
>>>     * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing
>>> raw data
>>>     * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>>>     *                       layer rather than any backing, set by block
>>> layer
>>>
>>> This actually means, that we should always have BDRV_BLOCK_ALLOCATED for
>>> formats which doesn't support backing. So, all such format drivers must
>>> return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, for
>>> example, iscsi - doesn't.
>>
>> Hm.  I could imagine that there are formats that have non-zero holes
>> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
>> ZERO or DATA then.
>>
>> But OTOH we don’t care about such cases, do we?  We need to know whether
>> ranges are zero, data, or unallocated.  If they aren’t zero, we only
>> care about whether reading from it will return data from this layer or not.
>>
>> So I suppose that anything that doesn’t support backing files (or
>> filtered children) should always return ZERO and/or DATA.
>>
>>> 2. ZERO. The meaning differs a bit for generic block_status and for
>>> drivers.. I think, we at least should document it like this:
>>>
>>> BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>>> BDRV_BLOCK_ZERO: if driver return ZERO, than the region is allocated at
>>> this layer and read as ZERO. If generic block_status returns ZERO, it
>>> only mean that it reads as zero, but the region may be allocated on
>>> underlying level.
>>
>> Hm.  What does that mean?
>>
>> One of the problems is that “allocated” has two meanings:
>> (1) reading data returns data defined at this backing layer,
>> (2) actually allocated, i.e. takes up space on the file represented by
>> this BDS.
>>
>> As far as I understand, we actually don’t care about (2) in the context
>> of block_status, but just about (1).
>>
>> So if a layer returns ZERO, it is by definition (1)-allocated.  (It
>> isn’t necessarily (2)-allocated.)
>>
>>> 3. bdi.unallocated_blocks_are_zero
>>>
>>> I think it's very bad, that we have formats, that supports backing, but
>>> doesn't report bdi.unallocated_blocks_are_zero as true. It means that
>>> UNALLOCATED region reads as zero if we have short backing file, and not
>>> as zero if we remove this short backing file.
>>
>> What do you mean by “remove this short backing file”?  Because generally
>> one can’t just drop a backing file.
>>
>> So maybe a case like block-stream?  Wouldn’t that be a bug in
>> block-stream them, i.e. shouldn’t it stream zeros after the end of the
>> backing file?
>>
>>> I can live with it but
>>> this is weird logic. These bad drivers are qcow (not qcow2), parallels
>>> and vmdk. I hope, they actually just forget to set
>>> unallocated_blocks_are_zero to true.
>>
>> qcow definitely sounds like it.
>>
>>> Next. But what about drivers which doesn't support backing? As we
>>> considered above, they should always return ZERO or DATA, as everything
>>> is allocated in this backing-chain level (last level, of course).. So
>>> again unallocated_blocks_are_zero is meaningless. So, I think, that
>>> driver which doesn't support backings, should be fixed to return always
>>> ZERO or DATA, than we don't need this unallocated_blocks_are_zero at all.
>>
>> Agreed.
>>
>>> 3.
>>
>> The second 3.? :)
>>
>>> Short backing files in allocated_above: we must consider space after
>>> EOF as ALLOCATED, if short backing file is inside requested
>>> backing-chain part, as it produced exactly because of this short file
>>> (and we never go to backing).
>>
>> Sounds correct.
>>
>>> (current realization of allocated_above is
>>> buggy, see my outdated series "[PATCH 0/4] fix & merge
>>> block_status_above and is_allocated_above")
>>>
>>> 4. Long ago we've discussed problems about BDRV_BLOCK_RAW, when we have
>>> a backing chain of non-backing child.. I just remember that we didn't
>>> reach the consensus.
>>
>> Possible? :)
>>
>>> 5. Filters.. OK we have two functions for them:
>>> bdrv_co_block_status_from_file and bdrv_co_block_status_from_backing. I
>>> think both are wrong:
>>>
>>> bdrv_co_block_status_from_file leads to problem [4], when we can report
>>> UNALLOCATED, which refers not to the current backing chain, but to sub
>>> backing chain of file child, which is inconsistent with
>>> block_status_above and is_allocated_above iteration.
>>>
>>> bdrv_co_block_status_from_backing is also is not consistent with
>>> block_status_above iteration.. At least at leads to querying the same
>>> node twice.
>>
>> Well, yes.
>>
>>> So, about filters and backing chains. Keeping (OK, just, trying to keep)
>>> all these things in mind, I think that it's better to keep backing
>>> chains exactly *backing* chains, so that "backing" child is the only
>>> "not own" child of the node. So, its close to current behavior and we
>>> don't need child-access functions. Then how filters should work:
>>>
>>> Filter with backing child, should always return UNALLOCATED (i.e. no
>>> DATA, no ZERO), it is honest: everything is on the other level of
>>> backing chain.
>>
>> I disagree, because filters with or without backing children should work
>> exactly the same way and just not appear in the backing chain.
> 
> They work the same way in my variant too. The only difference is that if you use file-child-based filters, you can't do stream/commit around them. I just think, that binding the concept to the "backing" link of the node is simpler and more generic. In blockdev era, when all nodes will be named and libvirt will take care of all nodes including filters, we will not need any filter-skipping magic, libvirt will directly point to exact nodes it means. And we can deprecate "file" children of existing filters, to finally reach simple architecture with simple backing chain of nodes (any nodes). And after deprecating old filename-based interfaces, we'll drop all filter-skipping magic..

What do you think?

-- 
Best regards,
Vladimir


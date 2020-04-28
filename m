Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8ACC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D69D5206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iLMcSJ2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69D5206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRbt-000241-PV
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTRa4-0007En-8b
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTRa2-00017f-1X
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:51:27 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com
 ([40.107.3.96]:26631 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTRa1-00016C-77; Tue, 28 Apr 2020 10:51:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWxgeXsL6VIMQs/fEsXNCQn4d+2DkKQCEvPpeh1ywsWyk/WhRdCXCv7UIkrr+pqEhVV3PF9yZxcYyphBaSi8yCHMejeE3gYuwevp6cmNS7UP/eoB/j5uh6MvD97vd0O4x60Zt86r9y7/0rmsd50yoEgKaFOqcB5t3u7Q0mw9jgePPisqWyP1ubLVQiy5BqlP6E4LTDkM0Kszmwn1Xa0WZH7xEr31PUf2KsJXZrvt3FMHkiKKlwCK3JSqpJyQo4pc58QQx88fLT6g/Aj1Nbsyu61J60nvkXX84ztuZzrj3+3z0PzGGNSqa0g38hI1L9sHLvsBROGgrKcJKspGUPWUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAEaREOld14dmATmwJkGGQmtZ5w6zTdxJ4SLVrTOnj0=;
 b=Iv/9XRW1JjJSf1nvB2fX0PGDrt2yAObZLXj0thbTBSMtpWN8iwVwkOLdwrmtjxqIvu7skMI2dUhv8F37p3vFPp3kP4sdYSIOjHg7V34DgAHSZONtT6WYH7e2/xT1focQskiPKr0TARAmchrJ6Hh61ENemqS9vHgqZ06FKLqzXrA7Gqq89/yb9mKPAA2OGgQvSzl/kRdWA1YTtm485Su9hdWv2et0XJm4oU8THEWyHyNTSPGqAaz1xRx+REHcwYcUjYOuHUTdYly+gaarwxJ0NFV3HDpX9WBvgHpZHvlB/lLACpeG/5Gqvrk9JPIfLc1j64n7f9oZIXnVsV3ftQeHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAEaREOld14dmATmwJkGGQmtZ5w6zTdxJ4SLVrTOnj0=;
 b=iLMcSJ2RSOBD/84MIeTnmMOQQOLsTq/WIu0Q9PCc4icXgss6xNdvNyGLVVYs3sRVxVjwAsS9n79YbbHbJFHoHGnafexMQNLts8Ri6DhKjS9dgNHWyS3aRcV0jVA4dJ8e4yv86urhFYft9uSbeidq/a5k0/GBGQRHhnxoNYy+wLw=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 14:51:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:51:21 +0000
Subject: Re: backing chain & block status & filters
To: Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428175119362
Message-ID: <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
Date: Tue, 28 Apr 2020 17:51:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 AM0P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 14:51:20 +0000
X-Tagtoolbar-Keys: D20200428175119362
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67cf331c-1d5e-4f5d-d6eb-08d7eb839d31
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54945413651CF109344136F1C1AC0@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39840400004)(136003)(366004)(376002)(2906002)(5660300002)(4326008)(31696002)(6486002)(478600001)(107886003)(86362001)(8936002)(8676002)(2616005)(81156014)(186003)(16526019)(66946007)(956004)(66476007)(66556008)(36756003)(54906003)(52116002)(316002)(110136005)(53546011)(26005)(31686004)(16576012);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30wIQe5F1z92Y1DgyAvEeGO5MPJ+H4IzIFEUkMfo9fKvINON6y37agEUDnLh5/dT5A2VqKIiBBXRVEjCdBk1jZE7pRz9nDNWRsWyYPu5TfgNHisUNAq4L+m0viZt6Wpl7PYYIptWE2dajO5hb01BYiBzyjdbcoGpCSRj3Rf8Bl4NmL7BEpzeNc3SVderDEOXpsIiW5/kM+lxJE+x4aSPjhuBgyKflPTMHgfSttXzpZdurxupG0y7Y3gm6TerGvD+7Md3EGynsT99n8t2Q7eZM0E4b4hn/smmrZlkDnL3zWwwDNQIHN1/UXMSauhvcLyLIps2qLLl90CkFVq50CS8XeqXlOWZQT92ID7l2k2ml914YXKAwEKf4FyhXwuIX/8ZsOHG5Cqpat2kJodqqMfVOg08JwTa7hbtMddbfs/Ypm5iAhdrSXnAVRMF/TPAstzp
X-MS-Exchange-AntiSpam-MessageData: 4SV/TY9KNKdbbz06Y1cqOm8N17h4K3Ya/pFJr5OJ8dMlPYQ5JYCnfsusmq/9PxJ0EQk5GGBE9rD6n1pBHccAsz9JMpkB48BvC0i+0UGLX/irriG1JBwWto3c7aPphhCBU6cvipUE8FClE3KJ93aM0saxCVXrMBJAHqYm1U+jyqLFCD1+wGfvvOPyeY+aagNfAcPHdQCRPuzBUDBMZ4mEuiHysSbKx+FwZW2jTAI3Sh8pBmQqfRvRL9aohaeV+umyu9Je5tyUPqz6nWvBNnhfB04W/ysPWBOLPRPOHHUY16YDhgIP5nFtgNfGebHp4txYnk7TvFp4tLYCEsM1za1d7SpOo9aehDUYFQw084QrZQ5IKJLd9D5XEMgMhTbeC+vy5ipSBJrCwITPofcbW1/+r8g+DqnnXYCSyyktIV1/RlagOOCwmpYgaGyJ2i1tzOCMisE9n9ogteCTgbRjU49YK1w7iEGDl6/ZIqSYbF1hwiFQ9eZPWkUlKY4obg48OtEJZubkjUnhpRy+g2qgPsZ29b+/L+P1qpdjTUa/WMksxJlJeNZvaFz8MfBbu7xHX7ghP1nlLw/WjTuzs3urFvH2DKVffY/Sq/Uy3pmvNyO8gakpvEEvZQt8Wzu0AYmaGBayFx7CIfOXKKrSbI+vnH/0HPhjK12e4zuzcI95e57QNVsmsMI+/rMWAwvL0Q4OKN2LZUkYZlxgytMpBrPQuOKN2PyVpIlZ/FL/MX4H3z5VlrwjY+nY6y5dFlGFguYOaKuVJ9ZG8DwDlW35nUd8/9K4cfBX25I7PCVQMQ3N2/CGgKs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cf331c-1d5e-4f5d-d6eb-08d7eb839d31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 14:51:20.8996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vb0WmCyJawC56JU5XRpf0po0nod/72pzK97SBCDDlMoaeQZ2/4iLyZiaGKHuVGkogqK8TNDdN8jvohAPz7eP8feOIygmX+htdbimb2tAt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
Received-SPF: pass client-ip=40.107.3.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 10:51:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.3.96
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

28.04.2020 14:08, Max Reitz wrote:
> On 28.04.20 10:55, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and
>> is_allocated_above", and returned to all the inconsistencies about
>> block-status. I keep in mind Max's series about child-access functions,
>> and Andrey's work about using COR filter in block-stream, which depends
>> on Max's series (because, without them COR fitler with file child breaks
>> backing chains).. And, it seems that it's better to discuss some
>> questions before resending.
>>
>> First, problems about block-status:
>>
>> 1. We consider ALLOCATED = ZERO | DATA, and documented as follows:
>>
>>     * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>>     * BDRV_BLOCK_ZERO: offset reads as zero
>>     * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing
>> raw data
>>     * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>>     *                       layer rather than any backing, set by block
>> layer
>>
>> This actually means, that we should always have BDRV_BLOCK_ALLOCATED for
>> formats which doesn't support backing. So, all such format drivers must
>> return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, for
>> example, iscsi - doesn't.
> 
> Hm.  I could imagine that there are formats that have non-zero holes
> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
> ZERO or DATA then.
> 
> But OTOH we don’t care about such cases, do we?  We need to know whether
> ranges are zero, data, or unallocated.  If they aren’t zero, we only
> care about whether reading from it will return data from this layer or not.
> 
> So I suppose that anything that doesn’t support backing files (or
> filtered children) should always return ZERO and/or DATA.
> 
>> 2. ZERO. The meaning differs a bit for generic block_status and for
>> drivers.. I think, we at least should document it like this:
>>
>> BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>> BDRV_BLOCK_ZERO: if driver return ZERO, than the region is allocated at
>> this layer and read as ZERO. If generic block_status returns ZERO, it
>> only mean that it reads as zero, but the region may be allocated on
>> underlying level.
> 
> Hm.  What does that mean?
> 
> One of the problems is that “allocated” has two meanings:
> (1) reading data returns data defined at this backing layer,
> (2) actually allocated, i.e. takes up space on the file represented by
> this BDS.
> 
> As far as I understand, we actually don’t care about (2) in the context
> of block_status, but just about (1).
> 
> So if a layer returns ZERO, it is by definition (1)-allocated.  (It
> isn’t necessarily (2)-allocated.)
> 
>> 3. bdi.unallocated_blocks_are_zero
>>
>> I think it's very bad, that we have formats, that supports backing, but
>> doesn't report bdi.unallocated_blocks_are_zero as true. It means that
>> UNALLOCATED region reads as zero if we have short backing file, and not
>> as zero if we remove this short backing file.
> 
> What do you mean by “remove this short backing file”?  Because generally
> one can’t just drop a backing file.
> 
> So maybe a case like block-stream?  Wouldn’t that be a bug in
> block-stream them, i.e. shouldn’t it stream zeros after the end of the
> backing file?
> 
>> I can live with it but
>> this is weird logic. These bad drivers are qcow (not qcow2), parallels
>> and vmdk. I hope, they actually just forget to set
>> unallocated_blocks_are_zero to true.
> 
> qcow definitely sounds like it.
> 
>> Next. But what about drivers which doesn't support backing? As we
>> considered above, they should always return ZERO or DATA, as everything
>> is allocated in this backing-chain level (last level, of course).. So
>> again unallocated_blocks_are_zero is meaningless. So, I think, that
>> driver which doesn't support backings, should be fixed to return always
>> ZERO or DATA, than we don't need this unallocated_blocks_are_zero at all.
> 
> Agreed.
> 
>> 3.
> 
> The second 3.? :)
> 
>> Short backing files in allocated_above: we must consider space after
>> EOF as ALLOCATED, if short backing file is inside requested
>> backing-chain part, as it produced exactly because of this short file
>> (and we never go to backing).
> 
> Sounds correct.
> 
>> (current realization of allocated_above is
>> buggy, see my outdated series "[PATCH 0/4] fix & merge
>> block_status_above and is_allocated_above")
>>
>> 4. Long ago we've discussed problems about BDRV_BLOCK_RAW, when we have
>> a backing chain of non-backing child.. I just remember that we didn't
>> reach the consensus.
> 
> Possible? :)
> 
>> 5. Filters.. OK we have two functions for them:
>> bdrv_co_block_status_from_file and bdrv_co_block_status_from_backing. I
>> think both are wrong:
>>
>> bdrv_co_block_status_from_file leads to problem [4], when we can report
>> UNALLOCATED, which refers not to the current backing chain, but to sub
>> backing chain of file child, which is inconsistent with
>> block_status_above and is_allocated_above iteration.
>>
>> bdrv_co_block_status_from_backing is also is not consistent with
>> block_status_above iteration.. At least at leads to querying the same
>> node twice.
> 
> Well, yes.
> 
>> So, about filters and backing chains. Keeping (OK, just, trying to keep)
>> all these things in mind, I think that it's better to keep backing
>> chains exactly *backing* chains, so that "backing" child is the only
>> "not own" child of the node. So, its close to current behavior and we
>> don't need child-access functions. Then how filters should work:
>>
>> Filter with backing child, should always return UNALLOCATED (i.e. no
>> DATA, no ZERO), it is honest: everything is on the other level of
>> backing chain.
> 
> I disagree, because filters with or without backing children should work
> exactly the same way and just not appear in the backing chain.

They work the same way in my variant too. The only difference is that if you use file-child-based filters, you can't do stream/commit around them. I just think, that binding the concept to the "backing" link of the node is simpler and more generic. In blockdev era, when all nodes will be named and libvirt will take care of all nodes including filters, we will not need any filter-skipping magic, libvirt will directly point to exact nodes it means. And we can deprecate "file" children of existing filters, to finally reach simple architecture with simple backing chain of nodes (any nodes). And after deprecating old filename-based interfaces, we'll drop all filter-skipping magic..

> 
>> Filter with file child should always return BDRV_BLOCK_DATA |
>> BDRV_BLOCK_RECURSE, to show that:
>> 1. everything is allocated in *this* level of backing chain
>> 2. filter is too lazy to dig in it's file child (and, maybe the whole
>> sub-tree of it) and asks generic layer to do it by itself, if it wants
>> zeroes.
>>
>> Then, of course, if we want some filter to be inside backing chain, it
>> should have not "file" child but "backing". For this, we may support in
>> current public filter both variants: backing or file, as user prefer.
>> I.e., filter is opened either with file option or with backing and
>> operate correspondingly. And newer filters (like backup-top) may support
>> only backing variants.
> 
> I disagree again for the same reason.
> 
> Max
> 


-- 
Best regards,
Vladimir


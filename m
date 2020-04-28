Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DCFC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2FF20575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fHHnAi8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2FF20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTSf0-00088v-Sf
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTSZU-00022a-5Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTSZQ-0002SL-GO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:54:54 -0400
Received: from mail-eopbgr130109.outbound.protection.outlook.com
 ([40.107.13.109]:47411 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTRv9-0007S3-Ek; Tue, 28 Apr 2020 11:13:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsQAsdCqbLd6PwpQB4MKzz7vc6hOS5LWT/NR+AXedHMg4jsoimYL4XA45Vu79ELBskdSixXs2EwHqWA3vKX2orI32yOh2hwoG8fp5Gl+CLJaYZxskDtOuRBz6cUM3H7gXyZ61m6gt6mQkwPlTum+hCpzRmj4hP++iQ7Op1P4lVszRa/vv5Ks+QkXHs/BztW7/GwmGXZGljJD6i4zjY/5V71IwzUDSJTkE7279z0m1gam+BFK+NA+e8Vm+gLZpyV5iskzIqldIyyH8VoELMKKN1pgRAoXUZSNVwsKXkzwkRMJjoxYO+4tWRRTY8HMWHr/WBzR0VxpWfrEx3dyvPj0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVkfRY2sGucF/WuJ6fXXXFPxh7S/kQsIXOAeQzNRio8=;
 b=ksF3PA401C39glED0AFTDifoxX0bzfnfP7m+UHy51lziOUbeg9XyiXqb9Zn0xoC8CqXxWV9XGTH9jZVUR+LoPFc+M4T5511fCscWegKCoDwH7NuwzXrBOhan5oah67PZ8XjdYMtbWZo0/ZEdnOYTtDTlSkWNvGne86fdycfi7YzWIk3raXrMsyg1+wkxQkOvQJxf/LmtgS5jdOM15WXf4au9r3qWp9qRQTtwSk0LignKU3CyTaO3JbUCq5/pJDB2WBKx4u4FgKVaYn4lEdbUWLR44/GxcNbcb7rjmq+Xr5zK7tJ+hgLAsUKJmkoq2UGVd7d82JGHN56v8DZ3WKPCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVkfRY2sGucF/WuJ6fXXXFPxh7S/kQsIXOAeQzNRio8=;
 b=fHHnAi8cxrtLRGryHJ85kRMYSIXrkB/bgEBbN8eyxebI2iFqKrLxBZWELE2eziq4U6JQPYec20mP98qQueSdIgmcD/5sQXTDMCJ9VkVy6XmDGtlEpF9f9sZFIMxftfSiuErfuwiXhIIoa0n6EjSXuhrdTtf14mbv9M8e+nYezR4=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5415.eurprd08.prod.outlook.com (2603:10a6:20b:10d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 15:13:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 15:13:11 +0000
Subject: Re: backing chain & block status & filters
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <20200428112853.GC5789@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428181310324
Message-ID: <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
Date: Tue, 28 Apr 2020 18:13:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200428112853.GC5789@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0501CA0052.eurprd05.prod.outlook.com
 (2603:10a6:200:68::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 AM4PR0501CA0052.eurprd05.prod.outlook.com (2603:10a6:200:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 15:13:11 +0000
X-Tagtoolbar-Keys: D20200428181310324
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6688ae-75dd-4d82-d17a-08d7eb86aa8e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB541501AE9CAC110503F3CDBCC1AC0@AM7PR08MB5415.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(186003)(16526019)(2906002)(107886003)(31686004)(36756003)(478600001)(66556008)(8936002)(5660300002)(66476007)(66946007)(81156014)(8676002)(52116002)(2616005)(956004)(53546011)(6486002)(31696002)(86362001)(4326008)(54906003)(16576012)(110136005)(26005)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOQHZpIIXzHo2CjH2Sifz6QJgoKjB9VkN0Sw7ZXpndhEKdwPQz6BVQ3masuA4NX0G3f297Oj9Su3d7DMGZ4dqO4Ux/hX9hFjWW5DqNSDfvlP1hr2cwYDDIw9ESpEoRudO439+eER7vbo75W/SE7PyJ9UqnXpotwsu7x0vw5qOYdpFyoAWHvgPzL+1n57/YhLEHmIwuKwWVqZnxYLdujt9KRuOBWodjAyYg05CovALody0mu7ixdik8uhttgZXKMjjEMW35QC3SVjv07sKaeULuDh67r3OJVpdxQ7f89yK4aBNeYhuwGq0YPl/yH2h7ngONOn6hBDHt6D5OUZCfjGdVzFPQDlyCP8zTMF68PywhcrY+YFYz/hqJVL21RECcXMbGsz4GhN98uzllHVA5/6wpEL7xX/snQLXZAP4P9laBT9AP6k2XdZQus4FK3I9pDi
X-MS-Exchange-AntiSpam-MessageData: znJBd6bfL4ggSzMKX9yU43pdsv2PiaKdr3HyYAlGmo7XvbITw97aKZyLatQ6y9WvP8xRM10+XsWxDnrOmDliCpIkGQDGmfiADhlsIn2u/c3NQB1zYo2yXp5oopVqdAQ7I4FkE+7YghMNwlMG9IL2dW32srGuggMu+2cVLXtI2UvC70a63AhpBOKL+NO0rNQQ1UVkUY7w55iKjhyiOyLMBXg2MZEtuTrunfjeeckd55JTQuPYrvm9x/dPrwk226889VwZR72BXCA0wwq1ZUbbIUDazFOxCQQetNXHoElKgsFu31y+ftmqD6RXrQQOKCKuQ7vAys2eoOQlZuS15nqeX1EP3gXhoYg4T9R+jUGmO7bfP63D0cHCtIVIGAS/PMrfOtmCaKYhY9PrX7JbR8Az6LygjlKKLhrjX+a3dTldF1Owf3g3wm2pqWgX+Av81PMoCLb6GnYHmyEMqQsy8w4kR2bLpgXih63Fby/72IKTtTiRDG2oFO0IIStmChJ0DNKAO7n8F5uWhW0Nb5+e3u0sKMU1f8sWO93TlFpETSZI31nh0OdsNS6LqmtgkvGuDnJIPIhT1RpLtP66E/DPAR7vwfQmM9R9eT1ak+Cin2lijfdv7FcYyPnq6ri7XjkLfroTySSdOQBDJ/YUMYUhrbLzUFOwShtnvDoL5BAF0vXjAsPlun5i+WyiaHjcS3SwbBf+S2lRlsKc4e4/LQ6+zXR6vZJ7DJxofurjluwwI/CIerFJ43oE0acBF20CnAGeVjlPOE80NbtrRUCuTgOtxHUBJaPSuZ6TBti+wZU2OTCZ02k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6688ae-75dd-4d82-d17a-08d7eb86aa8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 15:13:11.7130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /v8KnTwibwfCXHXMbPtw44VgPg6xVB89jFXNRP3XPEnkwv70kSCWfWoMX02z774PR9ZIpcqQWzaW3de1dfbIDlIDqGGashr7h+SAOQ1tJME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5415
Received-SPF: pass client-ip=40.107.13.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 11:13:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.13.109
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

28.04.2020 14:28, Kevin Wolf wrote:
> Am 28.04.2020 um 13:08 hat Max Reitz geschrieben:
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
>>>     * BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>>>     * BDRV_BLOCK_ZERO: offset reads as zero
>>>     * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for accessing
>>> raw data
>>>     * BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>>>     *                       layer rather than any backing, set by block
>>> layer
>>>
>>> This actually means, that we should always have BDRV_BLOCK_ALLOCATED for
>>> formats which doesn't support backing. So, all such format drivers must
>>> return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, for
>>> example, iscsi - doesn't.
>>
>> Hm.  I could imagine that there are formats that have non-zero holes
>> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
>> ZERO or DATA then.
>>
>> But OTOH we don’t care about such cases, do we?  We need to know whether
>> ranges are zero, data, or unallocated.  If they aren’t zero, we only
>> care about whether reading from it will return data from this layer or not.
>>
>> So I suppose that anything that doesn’t support backing files (or
>> filtered children) should always return ZERO and/or DATA.
> 
> I'm not sure I agree with the notion that everything should be
> BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means today
> at least. If we want to change this, we will have to check all callers
> of bdrv_is_allocated() and friends who might use this to find holes in
> the file.

Yes. Because they are doing incorrect (or at least undocumented and unreliable) thing.

> 
> Basically, the way bdrv_is_allocated() works today is that we assume an
> implicit zeroed backing layer even for block drivers that don't support
> backing files.

But read doesn't work so: it will read data from the bottom layer, not from
this implicit zeroed backing layer. And it is inconsistent. On read data
comes exactly from this layer, not from its implicit backing. So it should
return BDRV_BLOCK_ALLOCATED, accordingly to its definition..

Or, we should at least document current behavior:

   BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
   layer rather than any backing, set by block. Attention: it may not be set
   for drivers without backing support, still data is of course read from
   this layer. Note, that for such drivers BDRV_BLOCK_ALLOCATED may mean
   allocation on fs level, which occupies real space on disk.. So, for such drivers

   ZERO | ALLOCATED means that, read as zero, data may be allocated on fs, or
   (most probably) not,
   don't look at ALLOCATED flag, as it is added by generic layer for another logic,
   not related to fs-allocation.

   0 means that, most probably, data doesn't occupy space on fs, zero-status is
   unknown (most probably non-zero)

  

-- 
Best regards,
Vladimir


Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB29AC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E5F2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kv+FvW93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTsr-0003Mz-Kk
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTTrq-0002Me-AU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTTrn-0003Mi-Jf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:17:56 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:13807 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTTN4-00031U-Jh; Tue, 28 Apr 2020 12:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9D184HSghhT/UjAhQOxN7miNY6gcTK87d7RZcQuly1BJVvsyxrN6DS8pBfXspqzGABtYR6gnEcFeBXrkzPZtscBmFlAANhS8oY1NVUmtKdujTn3z2h7MsqtHCjaJVE9bykBUxNjdA79OYiWEc0Ht/yg9xdRw3hCXRLpIdii5+vlvwWZaMSNyNodY/LMBvZ5DOcmF2JXsbXpIZ7TlCJ98/PsQ745S2TCHBGrCiB4O26Crer231wxK40mAVS1rD83dxq0E39fCoX3misHTBCcqUaOjM/zhAJEmV+pV7krubRMeijk5Z9M2Sv+jWWTU8COk+8uHVLmQBrxy7Y+kRWgng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0437gjj3ZmbaZKKyc4oEvhLvIkPKZKiJp50E4EFuiw=;
 b=PBxupc/wrPZGzV7wNnyDVvYoUTolCwO2jcg/8Vnk6+/hgtlem3anYosr62d7i+ot8Ec57l+VnO56EW4uJJu07z2XaRJdOQFnlDHsbHwi2o5z/3FJKcVJK+fGO8Ckp0T8GfsA2m+QqE1C3q3o2Il3oXwKaup5wlNzjF1E9tsMWWs2R38ltB4lN8KK1127hM3D9r1uG6YV+bqkNYWBS2izrY0YvyOENCfzHJo6W/q0cIpZ89+06WdS9R/r0M3vgBF/msWkYJGDJ8ES0IhNXEpPsdjMNxKP0DbSVwN3qzzWlicRw38/DhDWTYbRQgr5aS+wVFW/IN/2zvXCcnVQGylOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0437gjj3ZmbaZKKyc4oEvhLvIkPKZKiJp50E4EFuiw=;
 b=Kv+FvW93oYE/7TdI+/3xRyx2CL/7+chzz74F+HXKo8pYXSd5Ga/I3otnRgxyYtZnWr+AsQiQdy03CITwQUYQIar0s1m+FAKn4CfNYfP63wAcUdV26M/IC0TTeNjMO9kvk3DC1KK9jw9nLwSyoVFzBs4ylZGDw0F3hU5+6zAjpZI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 16:46:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 16:46:06 +0000
Subject: Re: backing chain & block status & filters
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <20200428112853.GC5789@linux.fritz.box>
 <2e3eab55-4a1d-f1a9-ab28-3f9399c57bfe@virtuozzo.com>
 <25f6278c-466d-c663-73e0-ef2d256b326d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200428194603777
Message-ID: <04dd8365-7077-766a-6d42-1aac26abbdeb@virtuozzo.com>
Date: Tue, 28 Apr 2020 19:46:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <25f6278c-466d-c663-73e0-ef2d256b326d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.155) by
 AM0P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 16:46:06 +0000
X-Tagtoolbar-Keys: D20200428194603777
X-Originating-IP: [185.215.60.155]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3030ce00-4cae-4e77-0efb-08d7eb93a594
X-MS-TrafficTypeDiagnostic: AM7PR08MB5462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462031B5BF16F920CB2A077C1AC0@AM7PR08MB5462.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39840400004)(346002)(376002)(66946007)(66556008)(36756003)(66476007)(5660300002)(31686004)(6666004)(31696002)(966005)(86362001)(4326008)(16576012)(8676002)(2906002)(8936002)(478600001)(16526019)(2616005)(53546011)(186003)(26005)(6486002)(956004)(54906003)(316002)(110136005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ilu8bYkeFeYmvoHYXrSMSlEonUpKV8TWGapcjNxyeWF1WC/AZ1c/S6hNY+3HtsUuXSPAyLenh6aCo0WsHsO1JCNN4ZguR2fAHNSEyobSQLU5NEb8sYXF8q9/sXnSpkrPIUhmuILHXdGuMQXFW4RD1waGeuUMjlTOVuLCXyfzqA18xw1yXSV0iQH4LExCeq61V02O8PXlhWqLcWRlCu7E0Yt0N8H3S9eepY6zusV6b+lOLygAPf6oJdqOCrz8ys5HUAsl0OeYvqLisNx3oXMe1tfhaGWvZAXLg4767gyDxu/shvSmOxQVy+YIirMtOpnyopqIcWiwr21IV6sEwXjDeQUHkreKNBlHdbMJ85XZMcBZAnIvRt8E4kDWvxx3boY4mi7e1LlX0LMZAPbHatn++UH3GB8GPCBn8yD11gnfaikXgW8QUm4aDMCTK/cNt1c3mExQYfRObJ3fLZFrwtEcbvxMIQu+3Xjg3dg/5+NJT/BsLejuIIXoq9Ag7bxUvUheCplRp6+eWKyPc8AY4GMdYg==
X-MS-Exchange-AntiSpam-MessageData: zNKxs7rEfJ5rigWZl3XHq+n3J3SoYlIq7qtZx7XaICMi5arATYmM3WREXuFQmK3GUJDebJk4V7Yf6sf/SeQNuz9PWwh/nnREqI27RJGTCCg9XOzquvSQJWSpbEatElqNIW7ndRmKqLh6JK/iMAiOik5qHNS9ZEJIDE9CNhBj2Lj7IkySMmicy/0GJ/S9w3xo4QJC3clU44O/khALA90oa/bPOD/luMH+XgzCkpXMOhKPhMikcz1ybJnTLEKBf4LQPtUbEL0MyISSTVm0bhZN1wxpmr3qd7AJ0CHO/yeOhYi9u6gQHebKluRKHO6/OmqnMg8yuSzzR8qRPjjMxVOskKBpW+ZA45M2EaaMQGVG+HWm7MPNDJBfsHhpDNQJ/mHwIq9mi145AVILWU9dPzi3UxK/oYFAZnAC1WaOFbsi3k67shgnzdjlHbXCy3ktBhUwF5h5AcOFIsS3RLsQZTrhX6pPGP72o6UlSPQyTMOpZqFAopYR8aXRCw2avCq6MghgD7UdCM7Y7WjL2L/9pIpINxM8g0yd9fcnmjcYaM/N5Xs1brI11hhoJ25LVnIZukXxf+kq99MMCwJcZPEYSZdaNzSPa9W672MOG6cnYLZUnAHdCmTssElvFkJk48vKCLMVWEPXFII9n9MMuqtotWnqT1DwfR7EEc1Zij0MsJsFemMw+Gg4BBHyv5CQ09jhAxfbPtKr4VkN08oIgeYhL+jl8yU7F7wAEpN6UhNAm5jGcRY1WcnOoaEgTKpnXEMgOCnrFHWhPI3LMU/CjaNoY3t1DzwtlRuIQfYTezLQxkcRY9M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3030ce00-4cae-4e77-0efb-08d7eb93a594
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 16:46:06.7933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3//8EC8BUCPkmjAf1MWvjTPkHOWGiDniGa5ibLNzbImdFdA5po4kMuwJkjfR0eyH03mppZ/N7gcU5x8Nrkj93VLS7mc3xQTfhQjyi+pAUFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 12:46:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.109
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

28.04.2020 19:18, Eric Blake wrote:
> On 4/28/20 10:13 AM, Vladimir Sementsov-Ogievskiy wrote:
> 
>>>> Hm.  I could imagine that there are formats that have non-zero holes
>>>> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
>>>> ZERO or DATA then.
>>>>
>>>> But OTOH we don’t care about such cases, do we?  We need to know whether
>>>> ranges are zero, data, or unallocated.  If they aren’t zero, we only
>>>> care about whether reading from it will return data from this layer or not.
>>>>
>>>> So I suppose that anything that doesn’t support backing files (or
>>>> filtered children) should always return ZERO and/or DATA.
>>>
>>> I'm not sure I agree with the notion that everything should be
>>> BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means today
>>> at least. If we want to change this, we will have to check all callers
>>> of bdrv_is_allocated() and friends who might use this to find holes in
>>> the file.
>>
>> Yes. Because they are doing incorrect (or at least undocumented and unreliable) thing.
> 
> Here's some previous mails discussing the same question about what block_status should actually mean.  At the time, I was so scared of the prospect of something breaking if I changed things that I ended up keeping status quo, so here we are revisiting the topic several years later, still asking the same questions.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00069.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03757.html
> 
>>
>>>
>>> Basically, the way bdrv_is_allocated() works today is that we assume an
>>> implicit zeroed backing layer even for block drivers that don't support
>>> backing files.
>>
>> But read doesn't work so: it will read data from the bottom layer, not from
>> this implicit zeroed backing layer. And it is inconsistent. On read data
>> comes exactly from this layer, not from its implicit backing. So it should
>> return BDRV_BLOCK_ALLOCATED, accordingly to its definition..
>>
>> Or, we should at least document current behavior:
>>
>>    BDRV_BLOCK_ALLOCATED: the content of the block is determined by this
>>    layer rather than any backing, set by block. Attention: it may not be set
>>    for drivers without backing support, still data is of course read from
>>    this layer. Note, that for such drivers BDRV_BLOCK_ALLOCATED may mean
>>    allocation on fs level, which occupies real space on disk.. So, for such drivers
>>
>>    ZERO | ALLOCATED means that, read as zero, data may be allocated on fs, or
>>    (most probably) not,
>>    don't look at ALLOCATED flag, as it is added by generic layer for another logic,
>>    not related to fs-allocation.
>>
>>    0 means that, most probably, data doesn't occupy space on fs, zero-status is
>>    unknown (most probably non-zero)
>>
> 
> That may be right in describing the current situation, but again, needs a GOOD audit of what we are actually using it for, and whether it is what we really WANT to be using it for.  If we're going to audit/refactor the code, we might as well get semantics that are actually useful, rather than painfully contorted to documentation that happens to match our current contorted code.
> 

Honest enough:) I'll try to make a table.

I don't think that reporting fs-allocation status is a bad thing. But I'm sure that it should be separated from backing-chain-allocated concept.

-- 
Best regards,
Vladimir


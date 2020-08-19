Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34740C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EA5206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M2k4jnA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EA5206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8O05-0000m2-2A
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Nz2-0008C9-Ls; Wed, 19 Aug 2020 09:18:29 -0400
Received: from mail-he1eur04on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::707]:51805
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8Nyz-0007fs-C3; Wed, 19 Aug 2020 09:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOoUKZnNJxRJVOtsI/A5ApoovkAPHgTNmDCUhILvJCPp6qraFNtlK1o1GliCZ3+p+vg8XJctFftf0TM8r23J66O6LaPDpls9/IJKskG8cdvIBDWeqeQUPvZkLy16VIrqgPwJmk3/xn0xcfZAo1TpiM5HEAlLNRWlp/waRdUbs3lFBatd4QnszFB8RNXxcJ0LXoGutad1UaIb16Dn91NWx839pRWDd9WjXblSv8y7C8g9qlJwGPMIo9yY5KOFalz7KZsgalqFEUzacC+GGm4DU3f5jBhwK/nPtZ4pKhZL925jyi8VPJd8QFMdMjmKOgDUdnGykbCulHlCyXhxACaFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jB+CiWKTSzbDemtDRvFumNQNk9zWglQTNAnWu0oi4I=;
 b=bgFqIFa4YJjjScZrglreSXPNDSd4mb880VLXUf82ZC4Lxpk4HMHXxNY4m5hbLlPFPd4f5V8zR3DANlgDBi+8kf3mbqh7jz9LjUX15P1flWe3OgakrWxN8WimFB8pSMWtVT/MaOIgbrDWq4oEMDBWoggoCxw2moDCoFb/qF3fgxE7JhYjLE4Afvmhj8iuIEwE3gj1k3a2NIwwxT5Cl/mPLM8YlfvnwLUQ0UQ+VbZiLsMD8RqwgYjmxSbXJzcYYi7kIPD7tnAepI8wDkzhUQpYnm3EUPA6rDjl4zk0q9SHh36Fwtf3OwZ8097I7d56iHz25NTXfzanBwa5dAlHGwgrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jB+CiWKTSzbDemtDRvFumNQNk9zWglQTNAnWu0oi4I=;
 b=M2k4jnA8mcKjqPEgRfGiPuGO6f9p4ay8gdk8X8SCJp/bPKscF4n9PAxl8EHob7DSsD4ugpJjooPnSSnhHirQ4q4DH5DW7oFbl2XIhRauxRxP2L15MFhItAd+1RSRDGtkU5ifu19Tkof3XN4aN4Pf1Zm2nE7cokM4J+5BpXdOCXE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3541.eurprd08.prod.outlook.com (2603:10a6:20b:51::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 13:18:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 13:18:20 +0000
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <ed502f80-f4a2-bfb8-7395-5842f8103991@virtuozzo.com>
 <63ad2152-3861-1f9f-1bb9-1c14fd68cfbd@redhat.com>
 <002af188-5576-1685-9c23-735d9a2cf50c@virtuozzo.com>
 <05650336-fd53-db84-4c57-d3a37c747163@redhat.com>
 <f61033e0-92be-0b9a-7a14-e1c56372b671@virtuozzo.com>
 <9f8b1eb5-2039-b2c5-6330-7f39f2c21464@redhat.com>
 <0d9ded79-69f3-4875-a19f-b97893268cfb@virtuozzo.com>
 <5a6ec8b3-f3a5-7763-ba2f-215df6d0e570@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ca6b9736-dea9-072a-0e21-56d772579f42@virtuozzo.com>
Date: Wed, 19 Aug 2020 16:18:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <5a6ec8b3-f3a5-7763-ba2f-215df6d0e570@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:208:14::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 13:18:20 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27f01cc1-431c-4761-fca4-08d8444257e3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3541C466FAD81B171383263CC15D0@AM6PR08MB3541.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh4tBukzhVBs1jtozG/gPwN6VvbU7OSDvtp/V5JUIXuR/O+9WANmBwVPpU/5oOc47RKU2hu/lZivQUldvH6rUgZzbZbdlEt1N+/rrv7FSvmGpKTBCf2BKcR3ZvPMdj3ILw3bh1/E164NOm86OP1n74F3cWYqWssL7V4H+bFIie/+R/x2BKPS4TV9T4XzcSFGDUn7a0fckDbNskc03g2om/tyGQRS73zrk+fd8SxVdgSBJCVuDbLvECBrWzWppCmrytuIPdFa1YJYJkuWRLoAGqCrfOv0bzAf8B+osimmRY0foEggX97bH2BEdVxqgMT9EF2OSRAudAu7X6dQfJIY/Mtw3hXNx2659RU4IpKRGVHK5RX4ml1SsOv5ofJgjJ5+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(376002)(136003)(346002)(366004)(52116002)(16526019)(16576012)(478600001)(2616005)(5660300002)(316002)(956004)(110136005)(8936002)(186003)(26005)(2906002)(83380400001)(4326008)(31686004)(6486002)(86362001)(66946007)(31696002)(66556008)(8676002)(66476007)(36756003)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /gwFvkpfW7p+/B7itPXtugl9L6sbbDzYtpoNzgMHjYzt9CCxXVbzo5jWZ/vnKmMWMGaYBGWitXqUEPC+UzAlrhoCxic1GhaG0BILi1VG9b5cnGxbG/M3j+iGEeMZNYPwIOfe1m9jJjt6gz7hAxOQ+9niuv+fHIYYPYXxfe2TUnylLqZcKk5Z8K4Uo1+fqRuqp6y1NHFaUIo56DX1DC+EwLPH+y0PTC3Rm8nn3oThU+mNteVCjY3SKU/JXXpKAkCV5jY5UrmAnEc1fg8TvJ+pdG9P/wangKtHtIxUrw7St5O0WA16DNUZJlNt/8GDMTz7Sr4WMcNIT+2RDEMKyVlolbDZZNRrHQd8jfQr+Isgt/gjJXGODKVBkXk9ovcMREyTkX50MNGiKVX5ssCDIHM2zqpf+gYzwjpdgFnj2VgO3QZSIwuZPVOmXJRcMovafzopfWBbc+3bJuxvM0B+WIVVv6QJETHN5Xf67Ir+SuenqFuOj3NR6mGk4rD+QAwotjkgTTMbsgTmz5R/YgbxrK3+lewIxiquLriVQHi2rh2UXXPEbWm9XG6pkp0YuzyJMP+rQ8Ze4QCvdrSgaCfc3yyADsMLEuchaeuaB9JxKnIvE3yd5wTlzFeSsIatfl/u/IA22QKSL0L/ddv1kzDq5KCiPg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f01cc1-431c-4761-fca4-08d8444257e3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 13:18:20.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fs0y9LsHNJ2bVJ3/eRImbX1HyowdPuDpJCqhVAZeabBbt0lDhkOQR1ZMlyDnT50ta/Gm/qAT8+JXjsR6mcN93GfdZi+4ahCx5Ls6QmtnOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3541
Received-SPF: pass client-ip=2a01:111:f400:fe0d::707;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

19.08.2020 15:39, Max Reitz wrote:
> On 10.08.20 13:04, Vladimir Sementsov-Ogievskiy wrote:
>> 10.08.2020 11:12, Max Reitz wrote:
>>> On 07.08.20 12:29, Vladimir Sementsov-Ogievskiy wrote:
> 
> [...]
> 
>>>> But, with our proposed way (freeze only chain up to base_overlay
>>>> inclusively, and use backing(base_overlay) as final backing), all will
>>>> work as expected, and two parallel jobs will work..
>>>
>>> I don’t think it will work as expected because users can no longer
>>> specify which node should be the base node after streaming.  And the
>>> QAPI schema says that base-node is to become the backing file of the top
>>> node after streaming.
>>
>> But this will never work with either way: base node may disappear during
>> stream. Even with you way, they only stable thing is "above-base", which
>> backing child may be completely another node at stream finish.
> 
> Yeah, but after c624b015bf, that’s just how it is.  I thought the best
> would be an approach where if there are no graph changes during the job,
> you would indeed end up with @base as the backing file afterwards.
> 
> [...]
> 
>>> Well, that still leaves the problem that users should be able to specify
>>> which node is to become the base after streaming, and that that node
>>> maybe shouldn’t be restricted to immediate children of COW images.
>>
>> And again, this is impossible even with your way. I have an idea:
>>
>> What about making the whole thing explicit?
>>
>> We add an optional parameter to stream-job: bottom-node, which is
>> mutally exclusive with specifying base.
>>
>> Then, if user specified base node, we freeze base as well, so it can't
>> disappear. User will not be able to start parallel stream with this base
>> node as top (because new stream can not insert a filter into frozen
>> chain), but for sure it's rare case, used only in iotest 30 :)).
>> Benefit: user have guarantee of what would be final backing node.
> 
> Sounds very nice to me, but...
> 
>> Otherwise, if user specified bottom-node, we use the way of this patch.
>> So user can run parallel streams (iotest 30 will have to use bottom-node
>> argument). No guarantee of final base-node, it would be backing of
>> bottom-node at job finish.
>>
>> But, this is incompatible change, and we probably should wait for 3
>> releases for deprecation of old behavior..
> 
> ...yeah.  Hm.  What a pain, but right, we can just deprecate it.
> 
> Unfortunately, I don’t think there’s any way we could issue a warning
> (we’d want to deprecate using the @base node in something outside of the
> stream job, and we can’t really detect this case to issue a warning).
> So it would be a deprecation found only in the deprecation notes and the
> QAPI spec...

Hmm.. add "bool frozen_only_warn" field to BdrvChild and print warning
instead of fail where c->frozen cause failure?

I can make a patch, if you don't think that its too much.

> 
>> Anyway, I feel now, that you convinced me. I'm not sure that we will not
>> have to change it make filter work, but not reason to change something
>> now. Andrey, could you try to rebase your series on top of this and fix
>> iotest 30 by just specifying  exact node-names in it?..
>>
>>
>> Hmmm. My thought goes further. Seems, that in this way, introducing
>> explicit filter would be incompatible change anyway: it will break
>> scenario with parallel stream jobs, when user specifies filenames, not
>> node names (user will have to specify filter-node name as base for
>> another stream job, as you said). So, it's incompatible anyway.
>>
>> What do you think of it? Could we break this scenario in one release
>> without deprecation and don't care?
> 
> I don’t know, but I’m afraid I don’t think we can.

Actually, we already done so once:

Freezing of base was introduced in 4.0, when c624b015bf comes in 4.1
(there were no real user bugs or feature requests, it was just my [bad]
idea, related to the problem around our stream-filter and parallel
jobs in iotest 30).
So, at least for 4.0 we had frozen base.. Were there any bugs?
But now we live with not-frozen base for several releases..

> 
>> Than I think my idea about base vs
>> bottom-node arguments for stream job may be applied. Or what to do?
>>
>> If we can't break this scenario without a deprecation, we'll have to
>> implement "implicit" filter, like for mirror, when filter-node-name is
>> not specified. And for this implicit filter we'll need additional logic
>> (closer to what I've proposed in a previous mail). Or, try to keep
>> stream without a filter (not insert it at all and behave the old way),
>> when filter-node-name is not specified. Than new features based on
>> filter will be available only when filter-node-name is specified, but
>> this is OK. The latter seems better for me.
> 
> If that works...
> 
> 
> OK.  So what I think we can do is first just take this patch as part of
> this series.

Yes, let's start with it.

>  Then, we add @bottom-node separately and deprecate @base
> not being frozen.

I think we can just deprecate, and not add the bottom-node. If someone
will come during deprecation period and say that he have such use-case,
we'll add @bottom-node. Otherwise we'll just start to freeze base node
again.

> 
> If it’s feasible to not add a stream filter node until the deprecation
> period is over, then that should work.
> 
> Max
> 


-- 
Best regards,
Vladimir


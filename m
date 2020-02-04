Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C389C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA90620661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tl8AgRlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA90620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyyIg-0001zD-47
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyHK-0001Ii-QV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iyyHJ-00031z-5v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:30:10 -0500
Received: from mail-eopbgr70131.outbound.protection.outlook.com
 ([40.107.7.131]:48192 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iyyHC-0002al-OB; Tue, 04 Feb 2020 08:30:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocU1lSWfoo6GwCZjH9FwH4BFGLxNLwbN0W5DRFdxfvKq3Whz1rKeHajFBmgBhbZpmr37TNQ/n9hRtLEzhYEQKCpJiVsM4E8I4NAArdj+PzuNkxXyztS0xZ+KFTZma2+mklghS5bz4RkFy3XdEYuzxV3e8i3CmFKtcAbYIaMauTaa9xPoshj7ViqyDgxnkfCPjEJn/rvAQn+RCdbGhKSjAji0P+vFPmIjGuBKuwPeWkTd61bSJWx7aMdnm2TzulcjeV/Nb5gCzQebNqBts1Zei3DBn95q3Pwk+ONFxhKPMjQECIxRd1cwskGp09yt6T5SLhm7xNNDMvYdyG7ivwueXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfF+v2v2WKqRvvm522qREUR4Hu7swlwLVtCIdi/7EZQ=;
 b=Xz0sXABGQJVAYvmqGyJx60ujt5rcSOllHusovELlcyVCwZOK3X1yFOmvMbRjKtz//fBKl7A244vc7oFaEqfAdJYICiuhS76ai++A+Wcr6tB0+oR9uplrCfyeteaDF0VhvI8Se4fv6xoWAKdgji5gRKe2B3mZvzORZCXd0LFFTf0MCCp7OwVOVIm9vLpt9UROtlEAvuztc7XZ46Avpr4GGh3qCWZS20cVZAkXbLz0LOyClxkbEanqBhHhjkOj2n2AFaVmSACUy1LB2P/ZXoVDdFyQ/qhECqxRMR13fwJUdYyI/L0o+D7oGMGJEAhmydViHyrNLZKax0e8NyW1Wk6pzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfF+v2v2WKqRvvm522qREUR4Hu7swlwLVtCIdi/7EZQ=;
 b=tl8AgRlmZQE8kU04THwe5VyT6nm6OwV2VP4/OpFaDnZonrdAnfH2QLI6ncz8sxesnP3RilOuujllX1jT9TznUUj819iqKVmk2bxdI9JUSgpoq50jBppj8JtA83rsGvIRFWBbblbnCePYRb0aqtUyQnRFofQzeUbPlLFcLJ7X5Ks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3384.eurprd08.prod.outlook.com (20.177.114.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Tue, 4 Feb 2020 13:30:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.034; Tue, 4 Feb 2020
 13:30:00 +0000
Subject: Re: [PATCH 13/17] qcow2: Add new autoclear feature for all zero image
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-14-eblake@redhat.com>
 <da530661-a976-35ca-d999-646074b72490@virtuozzo.com>
 <10684ac8-2d01-86f1-d383-3ea83e6450eb@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200204162957903
Message-ID: <9adc0ad8-8bb8-37f7-e35b-8f69bfafbfd8@virtuozzo.com>
Date: Tue, 4 Feb 2020 16:29:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <10684ac8-2d01-86f1-d383-3ea83e6450eb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0402CA0004.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0402CA0004.eurprd04.prod.outlook.com (2603:10a6:3:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 4 Feb 2020 13:29:59 +0000
X-Tagtoolbar-Keys: D20200204162957903
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3852a29-49d1-497a-d5da-08d7a976556b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3384:
X-Microsoft-Antispam-PRVS: <AM6PR08MB33840C1A7968EF60BD756EEEC1030@AM6PR08MB3384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(31686004)(4326008)(31696002)(6486002)(86362001)(53546011)(956004)(2616005)(316002)(52116002)(16526019)(186003)(5660300002)(26005)(8936002)(54906003)(16576012)(81166006)(81156014)(478600001)(2906002)(8676002)(66946007)(66476007)(66556008)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3384;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkF+RN8tnGdJqHDxaz+uyasgIR//STs1GPJOdQdzHULOyWpzuGf/mczr+FWt87CmAvQrYRZXCqpyGYw8m6iKQzxchd52hG+5zZaeNU+xrCDldAvsOM5rku9kqtRnL6x8rYdeK1YtKAuS5wI8xlLKVsl7uLMzqbURj+8jWT2cj6G4mQpQqB6nYt5Y5MUaEtup3vDd8jRldXfEfV1ZIDu5hXeVuN4K+hEG6wMUiBmm0l13ezLPPm3BrAUAMwSuK/Au1w4Y5UungaW2FMVcJSJUcsmLNjuIqNfg0j7Ta/Xp71vGE+WPtwLSOilkXkLhzLliAQIN61GC6cFOOFRBHCr8j7H13dZbPLQFkxAmOapMmUx5CqL6i9PBf5AK8T2Huv2QllQIho0vN35R3ylRmbAYicmDoj1spfcKNJeV88vOvfZz9MSbm46PBcddnO5Wopyu
X-MS-Exchange-AntiSpam-MessageData: KHqd0F36+hP2uHaH+TrJlaK+71yjfLXUTmpCiByozk5p4zQw774DsP+JI4ykXVjLbrbftc2AaEEPHdvRZTyWy6t8nGmEkR7iDD048YxOefjC0l/EugCV7AxAEr4sCNOEDjF5eDSEkvOxHHMvbPrP/g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3852a29-49d1-497a-d5da-08d7a976556b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 13:30:00.1419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNp5+i0bwiLukXdFUWQckGTWR6HwWd6HYxbsIcheTX5PKj6kmn+ys5MwTh3JyvK8gd18vdIPPGIV9M0RTmJ9yNsmYF4K8nY4aSRJ0PhqB/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3384
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.131
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

04.02.2020 16:12, Eric Blake wrote:
> On 2/3/20 11:45 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 31.01.2020 20:44, Eric Blake wrote:
>>> With the recent introduction of BDRV_ZERO_OPEN, we can optimize
>>> various qemu-img operations if we know the destination starts life
>>> with all zero content.=C2=A0 For an image with no cluster allocations a=
nd
>>> no backing file, this was already trivial with BDRV_ZERO_CREATE; but
>>> for a fully preallocated image, it does not scale to crawl through the
>>> entire L1/L2 tree to see if every cluster is currently marked as a
>>> zero cluster.=C2=A0 But it is quite easy to add an autoclear bit to the
>>> qcow2 file itself: the bit will be set after newly creating an image
>>> or after qcow2_make_empty, and cleared on any other modification
>>> (including by an older qemu that doesn't recognize the bit).
>>>
>>> This patch documents the new bit, independently of implementing the
>>> places in code that should set it (which means that for bisection
>>> purposes, it is safer to still mask the bit out when opening an image
>>> with the bit set).
>>>
>>> A few iotests have updated output due to the larger number of named
>>> header features.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>>> ---
>>> RFC: As defined in this patch, I defined the bit to be clear if any
>>> cluster defers to a backing file. But the block layer would handle
>>> things just fine if we instead allowed the bit to be set if all
>>> clusters allocated in this image are zero, even if there are other
>>> clusters not allocated.=C2=A0 Or maybe we want TWO bits: one if all
>>> clusters allocated here are known zero, and a second if we know that
>>> there are any clusters that defer to a backing image.
>=20
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bits 2-63:=C2=A0 Reserved (se=
t to 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bit 2:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 All zero image bit
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If this bit is set, the entire i=
mage reads
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 as all zeroes. This can be usefu=
l for
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 detecting just-created images ev=
en when
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clusters are preallocated, which=
 in turn
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be used to optimize image co=
pying.
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit should not be set if an=
y cluster
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in the image defers to a backing=
 file.
>>
>> Hmm. The term "defers to a backing file" not defined in the spec. And, a=
s I
>> understand, can't be defined by design. Backing file may be added/remove=
d/changed
>> dynamically, and qcow2 driver will not know about it. So, the only way t=
o
>> be sure that clusters are not defer to backing file is to make them
>> ZERO clusters (not UNALLOCATED). But this is inefficient, as we'll have =
to
>> allocated all L2 tables.
>>
>> So, I think better to define this flag as "all allocated clusters are ze=
ro".
>=20
> That was precisely the topic of my RFC question.

Yes, and this is what I'm thinking about it :)  Looks like I worded it in
manner that I didn't see the RFC and just consider it as final patch,
sorry for that.

>=20
> I _do_ think it is simpler to report that 'all clusters where content com=
es from _this_ image read as zero', leaving unallocated clusters as zero on=
ly if 1. there is no backing image, or 2. the backing image also reads as a=
ll zero (recursing as needed).=C2=A0 I'll spin v2 of these patches along th=
ose lines, although I'm hoping for more review on the rest of the series, f=
irst.

Still, I'm not sure that it make sense to consider backing at all. In my PO=
V,
backing is up to the user. User may load backing file which is specified in
qcow2 header, but on the same time, user may chose some other backing file.
Backing file is "external" thing, so, may be better not rely on it.

>=20
>>
>> Hmm interesting, in qcow2 spec "allocated" means allocated on disk and h=
as
>> offset. So, ZERO cluster is actually unallocated cluster, with bit 0 of
>> L2 entry set to 1. On the other hand, qemu block layer considers ZERO
>> clusters as "allocated" (in POV of backing-chain).
>=20
> I really want the definition to be 'any cluster whose contents come from =
this layer' (the qemu-io definition of allocated, not necessarily the qcow2=
 definition of allocated), which picks up BOTH types of qcow2 zero clusters=
 (those preallocated but marked 0, where the contents of the allocated area=
 are indeterminate but never read, and those unallocated but marked 0 which=
 do not defer to the backing layer).=C2=A0 Whether or not the cluster is al=
located is less important than whether the image reads as 0 at that cluster=
.
>=20
> But I think that you are right that an alternative definition of 'all all=
ocated clusters are zero' will give the same results when crawling through =
the backing chain to learn if the overall image reads as zero, and that's a=
ll the more that we can expect out of this bit.

Yes, it's equal, because unallocated clusters marked as ZERO are zero anywa=
y.

>=20
>>
>> So, if we define it as "all allocated clusters are zero", we are done:
>> other clusters are either unallocated and MAY refer to backing, so we
>> can say nothing about their read-as-zero status at the level of qcow2
>> spec, or unallocated with zero-bit set, which are normal ZERO clusters.
>>
>> So, on the level of qcow2 driver I think it's better consider only this
>> image. Still, we can implement generic bdrv_is_all_zeros, which will
>> check or layers (or at least, check that bs->backing is NULL).
>=20
> The earlier parts of this series which renamed bdrv_has_zero_init() into =
bdrv_known_zeroes() does just that - it already handles recursion through t=
he backing chain, and insists that an image is all zeroes with respect to B=
DRV_ZERO_OPEN only if all layers of the backing chain agree.
>=20

Great. I'll look at other patches soon.


--=20
Best regards,
Vladimir


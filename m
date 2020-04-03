Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33ADC2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mXb1AU9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ADC2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKWw-0000SO-Dg
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKKWG-0008IR-05
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jKKWE-0002LS-9S
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:29:51 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com
 ([40.107.13.98]:52430 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jKKWD-0002Ki-MH; Fri, 03 Apr 2020 07:29:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBAULB6NMyEdHLSnJs8SQTYNUlIdJAFAqbtwUCH59faW+ScmLhK/HjGYSZgq17KQiU5il9dLvDNYOGLMM4t905ARojFw7Q1H81nSWU9s2Me6GjoZJnN4TQpUbrpDZKt+zjQ9V3+bXZch1l10cfCwSlLA1HqmvtF30TLTf/irXC9YnlHVwqItLMKLl6xnZSDEC6zEgPSobaP19ijtfT4bpP3Is6+W4DdaeBSWEVKtm33hhQFpNRfMjG1EX76g7QF5m8phx1vmgqzJTqBeOyFUkKz2WKl6zAdaSxiy2gBjqkzKlXr+KDK9ae1bbTp3yjeD7kX916OfKiGw/bdRNoOYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z/TKV0r5hP3dq7rhCmWx4J9TYEPY59IS1emOa3Bs7Q=;
 b=gCs6qthhSaKisF+XIO+KppWQ8ASysIAL4SFxIeGzWS0DQgc29sRG9IL5J73/JqGKNzhi1NSCMqzRvBLqYTazEbyejfVTxdEXTFXpbLofEy43aG1o/xSDYJ3Ad9IEF6XDkR3oVy4Qj9lT6PeW7Wg9PLBZNdY/vqKQ3D7YRbsRIL2/PQyPAqpF6s8x7aLx3XqT2cEhKF5bVABqLtfxAS3a6EJhdz9V2gSqgNdCQ2hIUdlMDnnnSd3VCwIQ+OY8UWWW84z47HGDb9wWdtQ33/pcmAT/QAVBKr7Kzc6g4dORg61EaOXXTGRANljzo5iDzm2ZmLxSanNdnflMwBqxBm0xeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z/TKV0r5hP3dq7rhCmWx4J9TYEPY59IS1emOa3Bs7Q=;
 b=mXb1AU9/wlnd+Hd4d1z7g6GfLc4OozJM327rvGASnTD4UmDLzE2xhqMmI8W6AqqmlNhK76TWf3vz1sIvK/HAyiD5GeC1oYyFwv0wLCzhASptuchtdUB8xlscgFVcdimS4SkfahfPXfJUw9+SMEtQrp5bRNpQ5p43v5VSkAQedDs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5527.eurprd08.prod.outlook.com (10.141.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 11:29:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.016; Fri, 3 Apr 2020
 11:29:47 +0000
Subject: Re: [PATCH v2 0/5] fix migration with bitmaps and mirror
To: Peter Krempa <pkrempa@redhat.com>
References: <20191219085106.22309-1-vsementsov@virtuozzo.com>
 <20191219103638.GJ4914@andariel.pipo.sk>
 <a5015250-46f4-c6ed-92b9-779f885e8a4a@virtuozzo.com>
 <20200403112358.GV578401@andariel.pipo.sk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200403142945475
Message-ID: <bfd71b93-41a4-33fb-b6ff-5f7602af14fa@virtuozzo.com>
Date: Fri, 3 Apr 2020 14:29:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200403112358.GV578401@andariel.pipo.sk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.62) by
 AM0PR06CA0001.eurprd06.prod.outlook.com (2603:10a6:208:ab::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 11:29:46 +0000
X-Tagtoolbar-Keys: D20200403142945475
X-Originating-IP: [185.215.60.62]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6987dbd7-9f1f-4ca6-058f-08d7d7c25071
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527AFE14E45325D4853E074C1C70@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39840400004)(53546011)(316002)(8936002)(186003)(66946007)(31696002)(26005)(478600001)(86362001)(66556008)(31686004)(966005)(16526019)(2616005)(956004)(66476007)(8676002)(4326008)(5660300002)(6486002)(36756003)(6916009)(16576012)(81156014)(2906002)(52116002)(81166006);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGcP1o61XAjxn0cuAGwxH6o+gu6DXQ2AsrrfWKUOuiCdMkcnbWgzuBTvSnuU/xWf2sXjuFo7anNb0wkJA1fanPkeSLe/PuqT4PtAULYt21XCoI64ojXMFOmdDQnfNMba8/ibSboj9SlUyFJIqlBKx8MscunAaUYTTLGUmXucalw7XYB/91v6yemb1IVbR71kDwFZOtb7dfYc1FMZrwAViBwRr+3hAJkzYiCTxckiZKBWngOYrqPf7oh9hqnUKgX8cSUAgSgNb3f3+Lkj0vDKn8zOzC7EFPcXBa0lc7OOlZkiJ+a1SNkAYClS5u7A++z3V/d+PHZ0waktjKJ9VQrwmiktbEOXDtCRerwlyHJuCnGzp0LXqgouDZhqtv+f1VLRcJHmJG+7gRDN8v3m5FubLAawjtYvl9f1FbNqbRjBu/V2at3V37gAJhXfVvkArgOZ/90szNU8Q2+HGtgSz5Wq4jYQjtS9yhRyS/u44aij/kv05zBSQtV7JLU8tHgerkGottGhRuAYf1eaeJLAljqS9w==
X-MS-Exchange-AntiSpam-MessageData: p+em+J0jFdvCn1DQ+BBckrie+0l+B/TRsjSmeE5lyu6mAix9UZ6xk+hCcnxOZdIvofFu8s/djpSTcl7/jQn5dq/EwfQZz8PEP8NM4sXu5bF2ws1WlL3VpmJxTHXvuZzb89tNJpFMY9zquZWh/CGd3g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6987dbd7-9f1f-4ca6-058f-08d7d7c25071
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 11:29:47.0969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gj4hM7y4FIOSf0F2/HtLZNIArDBMRhVvP5ARGESwbaq+m+hwfsjRlyPNpSCOl++oWWKlRnafd19luKpsh9WOv1RabyWelTTCyIyrjkow7xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.98
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

03.04.2020 14:23, Peter Krempa wrote:
> On Fri, Apr 03, 2020 at 14:02:47 +0300, Vladimir Sementsov-Ogievskiy wrote:
>> 19.12.2019 13:36, Peter Krempa wrote:
>>> On Thu, Dec 19, 2019 at 11:51:01 +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all!
>>>>
>>>> It's a continuation for
>>>> "bitmap migration bug with -drive while block mirror runs"
>>>> <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg07241.html
>>>>
>>>> The problem is that bitmaps migrated to node with same node-name or
>>>> blk-parent name. And currently only the latter actually work in libvirt.
>>>> And with mirror-top filter it doesn't work, because
>>>> bdrv_get_device_or_node_name don't go through filters.
>>>
>>> I want to point out that since libvirt-5.10 we use -blockdev to
>>> configure the backend of storage devices with qemu-4.2 and later. This
>>> means unfortunately that the BlockBackend of the drive does not have a
>>> name any more and thus the above will not work even if you make the
>>> lookup code to see through filters.
>>
>> Not that this series doesn't make things worse, as it loops through named
>> block backends when trying to use their name for migration. So with these
>> patches applied, qemu will just work in more possible scenarios.
> 
> Okay, if that's so it's fair enough in this case.
> 
> I'm just very firmly against baking in the assumption that
> node names mean the same thing accross migration, because that will
> create a precedent situation and more stuff may be baked in on top of
> this in the future. It seems that it has already happened though and
> it's wrong. And the worst part is that it's never mentioned that this
> might occur. But again, don't do that and preferrably remove the
> matching of node names for bitmaps altogether until we can control it
> arbitrarily.
> 
> We've also seen this already before with the backend name of memory
> devices being baked in to the migration stream which creates an unwanted
> dependancy.
> 

Hmm. Actually, matching by node-name never worked. May be just drop it now, and allow only matching by blk-name?

And then (in 5.1) implement special qmp commands for precise mapping.

-- 
Best regards,
Vladimir


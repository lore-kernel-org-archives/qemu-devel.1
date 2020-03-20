Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BD4C43332
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A25B20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vPOKd3x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A25B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIly-0004sr-No
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jFIl1-0003TT-J7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jFIl0-0000cz-C2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:36:19 -0400
Received: from mail-am6eur05on20710.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::710]:3885
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jFIkv-0000F4-Rl; Fri, 20 Mar 2020 10:36:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTlX7fSIlMPQcyJvYh1huyeXcvuYTt2c5t/un/Ezwdsf9DNhGHQje+dkKlJDgiNSovq2CPNaIA5qr+/3e52C31MP5hMmDc3XGrQnSfateTpriRW6rwi/K0nsFRR2/SppHDRzPNqtAeTUsDQ2n0hviVS+yKawTrdjJa1JwmlttMDAJwDScr2HLdMuP3c9XFZPIZPlD4DD2YFvXZEZ/HX7s8mDK0+xfxAgINAvYvfZSgsOWXhI/6rM9qYld2vKkH72UhsaVqWh3PtYhoh5G+hvf0OPXY4blLxZdlQEe0cMf2LQS9lREuX7gzv6oUgFnyHGfR2jONmNshkpDpPtoXU+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34AhENEb0d098ZBr/mcpGzFLrlTMIPtl1CvxOlcCMFQ=;
 b=oGV0jkrCINTddwVqKmROYcB5RO4Qj1EUg/z7whgkEmfTzTBgvby3ENfn5ldofaK/EMPWY2Q/3kH1sAIoij7+T0EvsrNkIeMKdaVQ7tK+Y2Ndy//qbemUujhNjyyMh80aTdBxft/3r0neKCueR6e7LcOx/RZOPMAJr/uIj3of5KHl8cXpD0QesoiO507RJ3ktoDSljaYo5K30THgm9XJcjBQGAUXWDNYvvFrihxJwx3SEXgrj0CnZWICw6MG1MWL0d9FokxlG6oJJ8vvAdn62S+ZhzvoFuR2dAe5lKgAEWwGpozy3oMnS6hUBIbKkfDHgudEP1EjSArGa8j1n+HFGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34AhENEb0d098ZBr/mcpGzFLrlTMIPtl1CvxOlcCMFQ=;
 b=vPOKd3x5QPNiCM66dx/51+hLgDM8dKlqi9S5vQYQRfpcRlIGzG0AEjkWsB9PKD6D371PdwW5TeyykJxn8zRiU4wWS8CVItSh2HJ4GRXA86okA+rARs0WxZV7LA/kBCfvn6G/ncJafK3fkLfPq8evVbOk/psLiCh6OCyceF0h3jw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2153.eurprd08.prod.outlook.com (10.172.126.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Fri, 20 Mar 2020 14:36:10 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2835.017; Fri, 20 Mar
 2020 14:36:10 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
 <f9c8de73-38d8-a14c-632a-8e57d18e00c8@virtuozzo.com>
 <87o8swk8wc.fsf@dusky.pond.sub.org>
 <db2fa8a3-48cc-51aa-a3d5-eba88fb29f66@virtuozzo.com>
 <87wo7jqn8m.fsf@dusky.pond.sub.org>
 <c944511d-0a10-0840-258f-8e0bac19eb47@virtuozzo.com>
 <87wo7gd3nb.fsf@dusky.pond.sub.org>
 <d7bc3318-2d39-ce6f-1bd0-4165084458a2@virtuozzo.com>
 <87r1xn2kmf.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200320173606653
Message-ID: <28ac8e37-6b43-3755-61d7-41dc2d45ed94@virtuozzo.com>
Date: Fri, 20 Mar 2020 17:36:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87r1xn2kmf.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.10) by
 HE1PR0502CA0010.eurprd05.prod.outlook.com (2603:10a6:3:e3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18 via Frontend Transport; Fri, 20 Mar 2020 14:36:07 +0000
X-Tagtoolbar-Keys: D20200320173606653
X-Originating-IP: [185.215.60.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c830a1-ca81-49f0-9937-08d7ccdc07a1
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2153:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB215306A69EA82E699A0897DEC1F50@HE1PR0802MB2153.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(199004)(4326008)(54906003)(36756003)(316002)(16526019)(186003)(2906002)(478600001)(6916009)(6486002)(16576012)(86362001)(66946007)(66476007)(81156014)(66556008)(52116002)(31696002)(8676002)(31686004)(8936002)(2616005)(7416002)(26005)(956004)(5660300002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2153;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZfQQmLCOAMy+rpGZ/WgtuRzEGOzAyfy49c47NZH/hQkE5FYjH1WoSc/GD5NaFhAsp/DtqzoCWFujTnSNsJJTt/hHWz/zA97i2XaFfpQcLI2rfqKvKqaeryxKTyQ80ZskHFsySIWweGW1bTMfg5ZJe8rJHW+f/f33oGPosNO7oAito/hVTi9cEgT3uwYQVqC8+LeRJKMiQiVPxgsMXwF9JcUEQ8MJdKJBMbbfsoT2GC0Mjx6Ga3KSUeepEK2a6IoOXARdJX3w0/vqObbXx9hk8WWvh4eC/5+hdIVp/z6ZjHY0xCaTq/PWNSYpHFIsXKIFs9xbxqfE+1y9mET3ZWHILutx+mrjiaoUPV3sAi5EJRfKR2l21Pqxr2kMJ9/tvKmVf0YA03XxpQ//McxCIQ8ogxVHybFfDEZPdz2CPdXjAlp2V6RQkAcnyHXuhklrfSq
X-MS-Exchange-AntiSpam-MessageData: BDHh+g1zr1JC7sgRMOTgprSSaqhP/+3drIS0yaFYkeWWd1phKWoLEK2bmfB4asLYydWcQIeO5ezTuepxZEJWoaJw/yq4zEItJ4wlEQX+3IJqGDSmEByPXqWaYdlbC7dnsGs+lDQiF8RI+7YEltIMaQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c830a1-ca81-49f0-9937-08d7ccdc07a1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 14:36:09.9092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaYMKZvZvmskDmApuBp+3RRRg+LKyY9dgG7uF9cFj9GbM4ErSzLIaUlZw7bXjTkAr1Lxydxbd7eP59zpAQEhRoe/m9Ab9gQYHPgXMMhiowQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2153
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:7e1b::710
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.03.2020 16:58, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 19.03.2020 13:45, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> [...]
>>>> So, understanding that there no such cases in the whole tree, and even
>>>> if your patch works faster on the whole tree, I still don't want to
>>>> drop inheritance, because it's just a correct thing to do. Yes, we've
>>>> added ____ helper. It helps to avoid some problems. Pair-inheritance
>>>> helps to avoid another problems. I understand, that there still may
>>>> other, not-covered problems, but better to be as safe as possible. And
>>>> inheritance here is native and correct thing to do, even with our ____
>>>> additional helper. What do you think?
>>>
>>> I wouldn't call it correct.  It's still unreliable, but less so than
>>> without the function name constraint.  That makes it less wrong.
>>
>> Agree.
>>
>>>
>>> 100% reliable would be nice, but not at any cost.  Something we're
>>> reasonably confident to get right should be good enough.
>>>
>>> To be confident, we need to understand the script's limitations, and how
>>> to compensate for them.  I figure we do now.  You too?
>>>
>>
>> I will not be surprised, if we missed some more interesting cases :)
>> But we should proceed. What is our plan? Will you queue v10 for 5.1?
> 
> v10's PATCH 1+2 look ready.  The error.h comment update could perhaps
> use some polish; I've focused my attention elsewhere.
> 
> PATCH 8-9 are generated.  They should never be rebased, always be
> regenerated.  We compare regenerated patches to posted ones to make sure
> they are still sane, and the R-bys are still valid.  I can take care of
> the comparing.
> 
> I'd like to have a pull request ready when the tree reopens for general
> development.  Let's use the time until then to get more generated
> patches out for review.
> 
> If I queue up patches in my tree, we shift the responsibility for
> regenerating patches from you to me, and create a coordination issue:
> you'll want to base patch submissions on the branch I use to queue this
> work, and that's going to be awkward when I rebase / regenerate that
> branch.  I think it's simpler to queue up in your tree until we're ready
> for a pull request.
> 
> When you post more patches, use
> 
>      Based-on: <20200317151625.20797-1-vsementsov@virtuozzo.com>
> 
> so that Patchew applies them on top of this series.  Hmm, probably won't
> do, as PATCH 9 already conflicts.
> 
> You could instead repost PATCH 1+2 with each batch.  I hope that's not
> too confusing.
> 
> I trust you'll keep providing a tag reviewers can pull.
> 
> I suggest to ask maintainers to leave merging these patches to me, in
> cover letters.
> 
> Makes sense?
> 

Hmm.

I remember what Kevin said about freeze period: maintainers will queue
a lot of patches in their "next" branches, and send pull requests at start
of next developing period. This highly possible will drop r-bs I can get now.
And reviewers will have to review twice.

And for the same reason, it's bad idea to queue in your branch a lot of patches
from different subsystems during freeze.

So, just postpone this all up to next development phase?


-- 
Best regards,
Vladimir


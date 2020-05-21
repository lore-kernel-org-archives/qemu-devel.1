Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21469C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AA72072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XlpUGo/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AA72072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmqG-0004l8-2P
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbmpU-0003hY-BK; Thu, 21 May 2020 11:09:52 -0400
Received: from mail-am6eur05on2117.outbound.protection.outlook.com
 ([40.107.22.117]:47131 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbmpR-0007nI-Th; Thu, 21 May 2020 11:09:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhfffSDfsebGMAQYPet5IObgs/IsnWBiFn4GtTkHkohFrtncoZPaq3mLOt9R4aXlHliZ77r0AXrVMVWvrd6GOHCWb/JiZaUM2OOysfdhR7XdSKqFvkApB88NVXAhH6G1yP7CxEbmWK/1sF5UZRd01+Xy9jGiU7YvXVBL1iA/p5mPpJfNd+LbQRhiK3rafGX+NFg+ob6mcbpOjhFcEbMqwSnpEj1bvLPH7APgKTAT4/ybV+/zJ6oFAQdAKtQwtxXXaX+WJ8tlaD7DS8kkppRh5xnDHiMe542kVrbf8pl/+jOnbD/1FyLsRRj85wvfSjDyiJMC+ySXAR3Rp5tdVJcSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBDdkHXvP7g9hWs1FCjA0O1NTGkCmgb+JInXvUfUzg4=;
 b=P5edrzh5/GVu/dxW4hzRAb63QRDnbN92gvMwPOkrbEAB7fCpDChLAtTRIHdIzNSzSJT1ohuyKb91NP2U1+fYoDqsvfKKETpHSdE2wwytX2k75zVQQENanP3u+A9piaMwGBz+Jt6rC7bKJdMDuIhgvjXHdfCe7DBHIZkLBpcLC4x95uOckJ1OcfLqSziyywJBKLaYIwY71MT4gt35yz+KTJVr+tLx5/JsY8CUtz4uuI97JBEW8dlbqBIfHZAuq8OXZfXzRVHdnB+OIURoebqwn+SU2URaYl9YjexXiJ9kWhFPlR3sePR83V/ZtVJrxhikHdgaz541PcDNXL2/2SYk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBDdkHXvP7g9hWs1FCjA0O1NTGkCmgb+JInXvUfUzg4=;
 b=XlpUGo/hLQEvZthRo23OtRPA4Y0HN3HrM0/CpClWVq6/iNqzTVeYB4YQ/np22Jl82Ai0jMwcFYqb7gs9UIlitcKYd6MrJ31HBYqupB688Bpf0JS5esJ7Eleg15dn8MtPl7bCS4bnFAkLBndiBtVv7Nts6pk+cN9XJLHhnP7DMrU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5351.eurprd08.prod.outlook.com (2603:10a6:20b:dc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 21 May
 2020 15:09:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 15:09:46 +0000
Subject: Re: [PATCH v5 2/5] qcow2: Expose bitmaps' size during measure
To: Nir Soffer <nsoffer@redhat.com>
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-3-eblake@redhat.com>
 <CAMRbyytCZ5KuqPLXkv_kw1Fbgw-w05s0iApmhP69ev_q3VjOnA@mail.gmail.com>
 <295f514d-f4c8-551a-d828-77a70b4d6fa3@virtuozzo.com>
 <CAMRbyyvrYmhh9OK+6-nBVs1wqbHruYTq7Stn8iBZ17a_V_4wkQ@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e2fe2f35-9df3-163b-c29a-470505c00590@virtuozzo.com>
Date: Thu, 21 May 2020 18:09:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAMRbyyvrYmhh9OK+6-nBVs1wqbHruYTq7Stn8iBZ17a_V_4wkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:207:3::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.167) by
 AM3PR05CA0149.eurprd05.prod.outlook.com (2603:10a6:207:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Thu, 21 May 2020 15:09:45 +0000
X-Originating-IP: [185.215.60.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95fae9b5-aa6c-49a6-d587-08d7fd98ff65
X-MS-TrafficTypeDiagnostic: AM7PR08MB5351:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53514597664BB0AF035026E0C1B70@AM7PR08MB5351.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Otpw4vMCesyczUQXN4VtijgZaLvL4L/1vTCGGJ9UQusyYN4R3uONadyWqNakYlII8dSdr5iGpr6hPbzJsyw36Ic06PiVBIgESK205p4mRTr3Ag539x58RU6MuyDNRczfyVKnjSQwdRYeMk23GpcSa3OmzqLyzDmUqZvb0sH1isHdlTDO0zjrQKJ683ysMHbIrFF1+1PwBoKue7MnJsR2s0BLg0izoknakHINfLj5KK1ete2wPLuXXC4k/WfldDF6DXBIuAVSQ9lU7XXTzliilE03hi+3/RY6bb3WVNM41CIPfqlQKND1WqoPsnwgomRYDtdBn77XDMdi8Qr0oQr0fL6BqwwtV/WsxyMznnGHAYuQ1nDqjp4+kiPt2X248e7RahFL2ZaY/0g9I1Ooh6tBxROCEaU3/aXwWHIrkrIu6X7ujBiqwD6lkY2hOVzHjlI1qOIJ3WZqzR4OxP3bVmvTs57ekAYORaodgzjzMIfGt4lO3zyLP1CON84rEmgh8y1U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39840400004)(16576012)(52116002)(478600001)(54906003)(316002)(4326008)(53546011)(36756003)(26005)(16526019)(2906002)(8936002)(186003)(5660300002)(8676002)(2616005)(6916009)(31686004)(956004)(31696002)(86362001)(6486002)(66556008)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: s+j5XvZf1HaBfigNWGZrFNF4V/XKvCbhNGeb/wZzeGsfsM/kEujzNqaGNZP4MDe9V0pySAuL5mlU9QyJWxA+NgC+sBcjbMCD76fyzSoh1Sb6Kxlg3kP8izgGK90MHyt+/sdjyI+WlHJFKWkBCUoWC+WtgrjhN0QKa4ajCR7jNUoXBuL2j3DlHJhJ/vwGHRuKEROv7j4o+tYlMMFSc9s+1E+uz3FFh+5qzqno1xwF8tXPhm9UjZTQ7nUHU4FAHAQZrlMpkHYEohsh0EEcZ1Mu5h+tQ3NlwpRjYJxK6dWujvg8WxUNQo2aWO3eNHjtTOTbIKrdI3NsppzzX79NmUii2Eybhq0fHKKaw2Pe+2VG0mR9dlEZr7uY1Iq6y0xf0EIz5IXln77CKBtcMjrvZqaKODZhsRRtPAk5JZ7vcP9qzA/8RWsLYS3K2p/BZRIREHacrNs3EtGA2kFua7nxL2+HwwgNvBc6ue1c7rI5Xt86Z8gf6IQntL7Xq2c5PER66Ff6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fae9b5-aa6c-49a6-d587-08d7fd98ff65
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 15:09:45.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoALZOSlt+yrSHI1+Rjjm3/4QvK56g4lkOv1/j3J9pzkBxlvrfBYP8DeUmk7/c1X6g+CA8uUs765fwMZIbuTNXZx2sFRbp+bY6Fq4Fm+jZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5351
Received-SPF: pass client-ip=40.107.22.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 11:09:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.05.2020 16:29, Nir Soffer wrote:
> On Thu, May 21, 2020 at 2:40 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>>
>> 21.05.2020 02:00, Nir Soffer wrote:
>>> On Thu, May 21, 2020 at 1:01 AM Eric Blake <eblake@redhat.com> wrote:
>>>>
>>>> It's useful to know how much space can be occupied by qcow2 persistent
>>>> bitmaps, even though such metadata is unrelated to the guest-visible
>>>> data.  Report this value as an additional QMP field, present when
>>>> measuring an existing image and output format that both support
>>>> bitmaps.  Update iotest 178 and 190 to updated output, as well as new
>>>> coverage in 190 demonstrating non-zero values made possible with the
>>>> recently-added qemu-img bitmap command.
>>>>
>>>> On the command-line side, 'qemu-img measure' gains a new --bitmaps
>>>> flag.  When present, the bitmap size is rolled into the two existing
>>>> measures (or errors if either the source image or destination format
>>>> lacks bitmaps); when absent, there is never an error (for
>>>> back-compat), but the output will instead include a new line item for
>>>> bitmaps (which you would have to manually add), with that line being
>>>> omitted in the same cases where passing --bitmaps would error.
>>>
>>> Supporting 2 ways to measure, one by specifying --bitmaps, and another
>>> by adding bitmaps key is not a good idea. We really need one way.
>>>
>>> Each one has advantages. adding --bitmaps flag is consistent with
>>> "qemu-img convert"
>>> and future extensions that may require  new flag, and adding "bitmaps"
>>> key is consistent
>>> with "qmeu-img info", showing bitmaps when they exist.
>>>
>>> Adding a "bitmaps" key has an advantage that we can use it to test if qemu-img
>>> supports measuring and copying bitmaps (since both features are expected to
>>> be delivered at the same time). So we can avoid checking --help learn about
>>> the capabilities.
>>>
>>> I'm ok with both options, can we have only one?
>>
>> Hi! What are your scenarios? Are you using qemu-img by hand, or it is used from some management tool? For management tool, I'd recommend to use qmp interface, which is a lot more strict, reliable and stable, and documented. You just need to run qemu binary in stopped mode for it.
> 
> The use case is oVirt - it is a management system but it uses qemu-img
> to perform various
> operations, like copying disks around. The specific use case is
> cloning qcow2 image chain
> from one server to another, or cloning on the same server.
> 
> In the case of qcow2 images on logical volumes, we need to create a
> large enough  logical
> volume to copy an image, and for this we use "qemu-img measure". With
> the current patches
> we will be able to create large enough logical volume and copy the
> image data and the bitmps
> to the destination.
> 
> qmp interface is nice but to use it we have to rewrite all the code
> using qemu-img to start qemu
> with the relevant disks and perform operation via qmp or via libvirt.
> This a huge rewrite and I'm
> not sure it's worth the effort.

OK, I'm not familiar with oVirt.. But maybe, you don't need to rewrite everything, but just add a possibility to use qmp interface, so, keep old features working on qemu-img, while adding new features using qmp?

> 
> This approach also has limitations, for example using qemu-img we can
> copy disks in parallel on
> multiple hosts, while using libvirt and qemu will limit us to using
> one host since qemu takes locks
> that we control.

hmm.. do you open same image RW in several qemu-img processes? Or I don't follow, what behavior is blocked by Qemu locks... qemu-img takes locks as well..

> 
> Also using libvirt means that all new features take more time to
> complete since now we have
> a new layer between oVirt and qemu.

May be, using qmp directly is still a good option.


-- 
Best regards,
Vladimir


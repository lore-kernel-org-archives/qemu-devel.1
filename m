Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127EEC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C05214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="axgt+SbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C05214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izzK4-0005pN-U4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1izzJA-0004f4-01
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1izzJ7-0004p6-UJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:48:15 -0500
Received: from mail-vi1eur05on2132.outbound.protection.outlook.com
 ([40.107.21.132]:43905 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1izzJ7-0004jh-5d; Fri, 07 Feb 2020 03:48:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn4Df+kyKWBk4dlUXO9oUAWfpUI0lCpvOVBLVtdC8pqQ27mdkhEdQrQLmHRCKCoAtPs/hWpuT3Q0lVUdbf/J20ju1wVWBP84VolvOqkzmo5aZ9qYS+1+Bad38XEc8kAsY75AJoTNqAfXIVaG0KPMPm/7cT3tvsDa5IT9Py8loW7PtAlx4C2lQQXpDLCWxH3nddzF2sqAxzPsHnmp7fyHbEYSYUzwzDEYv6W5WFAKBIGmVfue7L8a0eXz5K+BVUYPsORCrZWcfLOjY53nCUGuPFKmc1PjdS406xET3lN1O6xEJX8UwnjxMSFVRfYp+N8t9uG+IulSEVraijaa++45Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJyJH/tTk/t/kS8hDvXCgHQhq1u9Vopm9NV0hvaOT2A=;
 b=gPkRSTSSBklADY1kva37pSUnaLnThZidXPvLqOYe03fPxzpPbCtU4c21Gb3LVPxJY3WEyBKc5l+6tmg8HsYeFj3NoJYBsbxcN5f6v2gVs+6ONkOXi5Z3pck0rL16UW4AcaZZiswI2XI1NRaJ7o/IDFOV+cVKWubtS9PWFbhqMxlJMw+YaMzkBB6eQndJIrMzc2SeS8A5z1oapdB+Hi5MP7RzzK/3cFIxJYe23RAZ9dmcnc0uU1BLzpbZCPE3adIz6bGzJqBBCWst3dRutDQ9BmcUviW8ouK2v9w9HGGWqTeZk/yDJZwyC64cPRzeYQOXIxw0m1NRDY3cXqD+nMlSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJyJH/tTk/t/kS8hDvXCgHQhq1u9Vopm9NV0hvaOT2A=;
 b=axgt+SbV016iyhhk3ZLucdKBylisHRfffMCmGMRA7wrHByhWFZQz77cHJyWinyllpdcXyWJN5zd9GmmbY1M9Y8urW9S3XwUKamYZy7onFDJNyG5yqMK8ox0t3Mgl30RGHK3ULJu2GUa8EO6f1Pp5EEFQUzX4+HdvDGHfq2rY8Zk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB4994.eurprd08.prod.outlook.com (10.255.29.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 08:48:09 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::5558:d9d2:7f7d:e4%2]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 08:48:09 +0000
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
 <20200205111905.GE58062@stefanha-x1.localdomain>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
Date: Fri, 7 Feb 2020 11:48:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200205111905.GE58062@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR06CA0149.eurprd06.prod.outlook.com
 (2603:10a6:7:16::36) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
Received: from [192.168.1.63] (46.45.235.22) by
 HE1PR06CA0149.eurprd06.prod.outlook.com (2603:10a6:7:16::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 08:48:07 +0000
X-Originating-IP: [46.45.235.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b60fac8a-507d-4dc2-f9fe-08d7abaa74e6
X-MS-TrafficTypeDiagnostic: AM0PR08MB4994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB49945789817B00B21AD7794CCF1C0@AM0PR08MB4994.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39850400004)(199004)(189003)(2616005)(31686004)(956004)(4326008)(478600001)(81156014)(8676002)(8936002)(81166006)(26005)(16526019)(966005)(186003)(107886003)(6916009)(52116002)(6486002)(53546011)(36756003)(16576012)(66476007)(66556008)(66946007)(316002)(31696002)(7416002)(5660300002)(2906002)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4994;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMmoRFuf9CX3GIDSHwk3SRAwNElaLic0eubrebM7+7uuZXPIrEiFkBJRrjinGF+1oqFYMhwPtub1kJMh/XljWMAG/cYkUlyRkW6YL7Aosmt6K8notQ+81Utpya+r7ClLx0QI7Wp/yIG6AaRSdhsMic0k7iGfzop4G7os+unkdLLc0s4pFWYm508ukSeYT5xGgPAx4Usw88yJbrfYt1pds7EDM4hLb+e7kPCU2ZEK0GokKachI670MtyrD/eD+HggS8Vi/I99rSGeIYVXJLdu2mQa9qJU277jBOT3UtUfm/3qfZRfoV/yjs2VFW8Fua5XLJCkgNLjNwsSc+axE1+8POW+Dcw4FRcp3J6c1OZO11NC7FIoU53yxkMeJ59VIMBoHB2YbHgwcmkZNgrQUCrlEafAexSP504lGz6gimcjDxllFIZOBQB3sBBuI5Yc/Q7XsTmQEs4E9l8OGPp6vaJqdhxVK2C/g0cQmZb+5a9FKqaY309Tk/Iq+F4KzkpFOyduYFtFUPRz0vYil1t/QSJ2zg==
X-MS-Exchange-AntiSpam-MessageData: gFmtk73uCBPrG/7v+zRDfKKkWwInUTOZy86vYprqfpsuVHoF5hWQQMeEQ/Sqtahp91QbTgNBmroV5jN5RTxwgQGdlL41s8RLN2PkFpnYvRran5gvgHTSSmTMNu4YOcfKnh3jOtToAwj0EhWgN3dRoA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60fac8a-507d-4dc2-f9fe-08d7abaa74e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 08:48:09.1558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mih5PMt/YHC9wqBgYWw57TYYGABOfHHr0TorOSQ23mBUmJe3dIpS5wdEv67QryruPYpXhzLiechAqdol9xP8OKpczbnA9bC//45gFywZnGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4994
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.132
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 05.02.2020 14:19, Stefan Hajnoczi wrote:
> On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
>>
>> On 30.01.2020 17:58, Stefan Hajnoczi wrote:
>>> On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
>>>> The goal is to reduce the amount of requests issued by a guest on
>>>> 1M reads/writes. This rises the performance up to 4% on that kind of
>>>> disk access pattern.
>>>>
>>>> The maximum chunk size to be used for the guest disk accessing is
>>>> limited with seg_max parameter, which represents the max amount of
>>>> pices in the scatter-geather list in one guest disk request.
>>>>
>>>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>>>> size increases seg_max, which, in turn, increases the maximum size
>>>> of data to be read/write from guest disk.
>>>>
>>>> More details in the original problem statment:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>>>
>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> ---
>>>>    hw/core/machine.c          | 3 +++
>>>>    include/hw/virtio/virtio.h | 2 +-
>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 3e288bfceb..8bc401d8b7 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -28,6 +28,9 @@
>>>>    #include "hw/mem/nvdimm.h"
>>>>    GlobalProperty hw_compat_4_2[] =3D {
>>>> +    { "virtio-blk-device", "queue-size", "128"},
>>>> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>>>> +    { "vhost-blk-device", "virtqueue_size", "128"},
>>> vhost-blk-device?!  Who has this?  It's not in qemu.git so please omit
>>> this line. ;-)
>> So in this case the line:
>>
>> { "vhost-blk-device", "seg_max_adjust", "off"},
>>
>> introduced by my patch:
>>
>> commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
>> Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Date:=A0=A0 Fri Dec 20 17:09:04 2019 +0300
>>
>>  =A0=A0=A0 virtio: make seg_max virtqueue size dependent
>>
>> is also wrong. It should be:
>>
>> { "vhost-scsi-device", "seg_max_adjust", "off"},
>>
>> Am I right?
> It's just called "vhost-scsi":
>
> include/hw/virtio/vhost-scsi.h:#define TYPE_VHOST_SCSI "vhost-scsi"
>
>>> On the other hand, do you want to do this for the vhost-user-blk,
>>> vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Those
>>> devices would benefit from better performance too.
After thinking about that for a while, I think we shouldn't extend queue=20
sizes for vhost-user-blk, vhost-user-scsi and vhost-scsi.
This is because increasing the queue sizes seems to be just useless for=20
them: the all thing is about increasing the queue sizes for increasing=20
seg_max (it limits the max block query size from the guest). For=20
virtio-blk-device and virtio-scsi-device it makes sense, since they have=20
seg-max-adjust property which, if true, sets seg_max to=20
virtqueue_size-2. vhost-scsi also have this property but it seems the=20
property just doesn't affect anything (remove it?).
Also vhost-user-blk, vhost-user-scsi and vhost-scsi don't do any seg_max=20
settings. If I understand correctly, their backends are ment to be=20
responsible for doing that.
So, what about changing the queue sizes just for virtio-blk-device and=20
virtio-scsi-device?

Denis

>> It seems to be so. We also have the test checking those settings:
>> tests/acceptance/virtio_seg_max_adjust.py
>> For now it checks virtio-scsi-pci and virtio-blk-pci.
>> I'm going to extend it for the virtqueue size checking.
>> If I change vhost-user-blk, vhost-user-scsi and vhost-scsi it's worth
>> to check those devices too. But I don't know how to form a command line
>> for that 3 devices since they should involve some third party components=
 as
>> backends (kernel modules, DPDK, etc.) and they seems to be not available=
 in
>> the
>> qemu git.
>> Is there any way to do it with some qit.qemu available stubs or somethin=
g
>> else?
>> If so, could you please point out the proper way to do it?
> qemu.git has contrib/vhost-user-blk/ and contrib/vhost-user-scsi/ if
> you need to test those vhost-user devices without external dependencies.
>
> Stefan



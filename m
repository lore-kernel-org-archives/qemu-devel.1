Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75264C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4161C20715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XZxkz35I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4161C20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1B8v-00005N-GL
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 10:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j1B4t-0002Vi-0d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j1B4q-00048T-0y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 10:34:26 -0500
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:21251 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j1B4p-00045w-0d; Mon, 10 Feb 2020 10:34:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms6VkR5E+kbQK4G8OedYV7u8g3ZlvvI6wYyCfdwfyAxbGrfzFE0SNhjGi5WCph6iNvvL80EtTOKBO4QR7IRHUCAUmuM+SBbMzak+VbVHyxkuEgU6XLlsqFq1TqJtflsZeY4qEZUlj5OmnEj62hoLJk+A2UAUVJgEsAYNg6JlcDmOIf9qGOrGjRDYfm6bvw+rvZxDI5KkSf67KgM2rHdooi2RbuqJwukTuXsjLcASfXUjM6EXFCqSUw3JYapS10g/565BROLO0cv2UN9gQfXfSedWAVa//VcGCMXtb4wJ+4Jlyx5QawgwneJGnK/f8HvW0FRBf96dxpn6szkPcPyxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCqO24mOKMZR6UV5Uy+TxEqSGmT65jPYnDKfNWDn0Zo=;
 b=W/GKS0pJKiXLGeT2hl59coPhensIUTgNu+nZnbaE0oRMO5o0gezqYC5ewq3XjKMP3WZEWPTL2ENGbxCX0UPwB1X2zHMU5YB9FI4u9Tfe9tAAZcKMMSekcoKI5kMqgBeXbPnssMnlBB8fM53R21Qhh/ZiNi7ghXFih+1VVWXON5geQ0XWv9a5oKw7qukD7RdgXgqOhpZ1fM4sMHzp6XXzS957kLCc6MO5l1mpz0c8mMVTDZ5PI4QQw6/S9TwjkYXkkpHZ9CvlQs0CLAjFuIz0UNnRVKWrC4xk0n65yqY/2UbQdum40q5Iykw5ziWEQMFdeGgrjjWd6lpbJY+TiSwa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCqO24mOKMZR6UV5Uy+TxEqSGmT65jPYnDKfNWDn0Zo=;
 b=XZxkz35I3lexRMlw620QkidDJbpLDfeoxCcSHjVXyWkdmaN334GNL114KszThV9xoec/PYsoahF4wR8H+mwN51BF4oO3P5w6JfAq8KsQpiI4foxoWmhv3leNF6HFYiwnj2TNWCdjMfJUs7aLnm5340Ymy1cbDn7PhuwSNnBfeEs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
Received: from DB7PR08MB3755.eurprd08.prod.outlook.com (20.178.45.224) by
 DB7PR08MB3481.eurprd08.prod.outlook.com (20.177.120.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Mon, 10 Feb 2020 15:34:19 +0000
Received: from DB7PR08MB3755.eurprd08.prod.outlook.com
 ([fe80::da2:be76:2740:258a]) by DB7PR08MB3755.eurprd08.prod.outlook.com
 ([fe80::da2:be76:2740:258a%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 15:34:19 +0000
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
 <20200130145840.GH180311@stefanha-x1.localdomain>
 <92f392e9-eb05-5c85-4d50-208110720a22@virtuozzo.com>
 <20200205111905.GE58062@stefanha-x1.localdomain>
 <683b80a8-0d40-7f14-e3f4-628d2b38037f@virtuozzo.com>
 <20200209024650-mutt-send-email-mst@kernel.org>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <0e9663a0-85fe-2d8f-abc7-e30f686ae0be@virtuozzo.com>
Date: Mon, 10 Feb 2020 18:34:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200209024650-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:7:28::36) To DB7PR08MB3755.eurprd08.prod.outlook.com
 (2603:10a6:10:77::32)
MIME-Version: 1.0
Received: from [192.168.1.63] (178.34.162.57) by
 HE1PR05CA0149.eurprd05.prod.outlook.com (2603:10a6:7:28::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Mon, 10 Feb 2020 15:34:17 +0000
X-Originating-IP: [178.34.162.57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52bbb3fa-e0c0-4b6b-33e8-08d7ae3eb1b5
X-MS-TrafficTypeDiagnostic: DB7PR08MB3481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3481779597B5F2F4C34D97C5CF190@DB7PR08MB3481.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(39850400004)(396003)(136003)(376002)(189003)(199004)(31696002)(478600001)(2906002)(54906003)(36756003)(52116002)(316002)(16576012)(86362001)(966005)(6486002)(107886003)(4326008)(5660300002)(31686004)(66476007)(7416002)(66946007)(66556008)(26005)(8676002)(6916009)(8936002)(81156014)(81166006)(186003)(16526019)(2616005)(956004)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3481;
 H:DB7PR08MB3755.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DEOV0a9mENxFlKZ8w4am9l8GFfZuZuiW+8XBHGroNQ6xMpJ+mQhar8A5DENyOdgKTaNaR64ndZok/dZeFCS+RyZ33NJ30BqH2trlNz6ysjcsFrIo5nS68VOoRtl7WavVS33ZBi2MOsSfKUmWqd3S7hNw17Cl80EdPFu63yf2IL4ZXbs8vPk/1ZNpHit+20EyujGlcgDK8AXpNCVjo3Nn9N8ffX8si82QIP3XfuJQk2VjN9OmbuXxGlsVvsJxVLfrLzrPbTAr3nwJIiIABY+CWnPexM/Wc4qrabQwINSw1rtMEoSvLKL1b8AuWoEQd02l/vQ5dvLTlCbkhZ74UCfxFV331Tug3r799B67XFDVBRN6yVUY+4Y35juEuuQWAOg7wgGn/dDZ6gXbgLvxDhSShr5g7NfkT1zTIoeiCLtgfClF9EwjvDPAPZxmxAPO/AgjFeerIwJMux6+zanAUp3pB2sns6mWEjhUrLhbgN9aeuRvjqLePuQFdnImvmxfLwMjUZP3M6pjwl3qjSE+HPxWQ==
X-MS-Exchange-AntiSpam-MessageData: SdD09EbN7cLXHGNmgq/AzvqmOdeHU1uUk6Bsq4DKjUw2TLIrl+xqT9bHNU/FxQf1gmDS34Y4t81nM1hKRvJU32kyW5ScH9u4P9fpJ4tmYa+J9W9a8DHJkfjZWvVyp9tRYS34MKvrzc/Fb6XWHbilKQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bbb3fa-e0c0-4b6b-33e8-08d7ae3eb1b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 15:34:19.0331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFgufgESUWqsJxtKtsON+4OnlM4Qh9LHJoX4n0aBOEuGV+15Vr6r1lymZ7fOsq+jYxp33xcrgLLcxgBqo+FrcFRKnKgIHJYLndeq1RIJl7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3481
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.13.114
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
 ehabkost@redhat.com, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 09.02.2020 10:49, Michael S. Tsirkin wrote:
> On Fri, Feb 07, 2020 at 11:48:05AM +0300, Denis Plotnikov wrote:
>>
>> On 05.02.2020 14:19, Stefan Hajnoczi wrote:
>>> On Tue, Feb 04, 2020 at 12:59:04PM +0300, Denis Plotnikov wrote:
>>>> On 30.01.2020 17:58, Stefan Hajnoczi wrote:
>>>>> On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
>>>>>> The goal is to reduce the amount of requests issued by a guest on
>>>>>> 1M reads/writes. This rises the performance up to 4% on that kind of
>>>>>> disk access pattern.
>>>>>>
>>>>>> The maximum chunk size to be used for the guest disk accessing is
>>>>>> limited with seg_max parameter, which represents the max amount of
>>>>>> pices in the scatter-geather list in one guest disk request.
>>>>>>
>>>>>> Since seg_max is virqueue_size dependent, increasing the virtqueue
>>>>>> size increases seg_max, which, in turn, increases the maximum size
>>>>>> of data to be read/write from guest disk.
>>>>>>
>>>>>> More details in the original problem statment:
>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>>>>>>
>>>>>> Suggested-by: Denis V. Lunev <den@openvz.org>
>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>> ---
>>>>>>     hw/core/machine.c          | 3 +++
>>>>>>     include/hw/virtio/virtio.h | 2 +-
>>>>>>     2 files changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>> index 3e288bfceb..8bc401d8b7 100644
>>>>>> --- a/hw/core/machine.c
>>>>>> +++ b/hw/core/machine.c
>>>>>> @@ -28,6 +28,9 @@
>>>>>>     #include "hw/mem/nvdimm.h"
>>>>>>     GlobalProperty hw_compat_4_2[] =3D {
>>>>>> +    { "virtio-blk-device", "queue-size", "128"},
>>>>>> +    { "virtio-scsi-device", "virtqueue_size", "128"},
>>>>>> +    { "vhost-blk-device", "virtqueue_size", "128"},
>>>>> vhost-blk-device?!  Who has this?  It's not in qemu.git so please omi=
t
>>>>> this line. ;-)
>>>> So in this case the line:
>>>>
>>>> { "vhost-blk-device", "seg_max_adjust", "off"},
>>>>
>>>> introduced by my patch:
>>>>
>>>> commit 1bf8a989a566b2ba41c197004ec2a02562a766a4
>>>> Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>> Date:=C2=A0=C2=A0 Fri Dec 20 17:09:04 2019 +0300
>>>>
>>>>   =C2=A0=C2=A0=C2=A0 virtio: make seg_max virtqueue size dependent
>>>>
>>>> is also wrong. It should be:
>>>>
>>>> { "vhost-scsi-device", "seg_max_adjust", "off"},
>>>>
>>>> Am I right?
>>> It's just called "vhost-scsi":
>>>
>>> include/hw/virtio/vhost-scsi.h:#define TYPE_VHOST_SCSI "vhost-scsi"
>>>
>>>>> On the other hand, do you want to do this for the vhost-user-blk,
>>>>> vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Thos=
e
>>>>> devices would benefit from better performance too.
>> After thinking about that for a while, I think we shouldn't extend queue
>> sizes for vhost-user-blk, vhost-user-scsi and vhost-scsi.
>> This is because increasing the queue sizes seems to be just useless for
>> them: the all thing is about increasing the queue sizes for increasing
>> seg_max (it limits the max block query size from the guest). For
>> virtio-blk-device and virtio-scsi-device it makes sense, since they have
>> seg-max-adjust property which, if true, sets seg_max to virtqueue_size-2=
.
>> vhost-scsi also have this property but it seems the property just doesn'=
t
>> affect anything (remove it?).
>> Also vhost-user-blk, vhost-user-scsi and vhost-scsi don't do any seg_max
>> settings. If I understand correctly, their backends are ment to be
>> responsible for doing that.
> The queue size is set by qemu IIRC.
>
>> So, what about changing the queue sizes just for virtio-blk-device and
>> virtio-scsi-device?
>
> Hmm that would break ability to migrate between userspace and vhost
> backends, would it not?
I'm not sure I've understood what you meant.
Just for the record, I was going to change virtqueue-size for=20
virtio-blk-device and virtio-scsi-device since they can adjust seg_max=20
to the specified queue size and I don't want to touch vhost-s and=20
vhost-user-s since they don't have adjustable seg_max for now.

Denis
>
>
>> Denis
>>
>>>> It seems to be so. We also have the test checking those settings:
>>>> tests/acceptance/virtio_seg_max_adjust.py
>>>> For now it checks virtio-scsi-pci and virtio-blk-pci.
>>>> I'm going to extend it for the virtqueue size checking.
>>>> If I change vhost-user-blk, vhost-user-scsi and vhost-scsi it's worth
>>>> to check those devices too. But I don't know how to form a command lin=
e
>>>> for that 3 devices since they should involve some third party componen=
ts as
>>>> backends (kernel modules, DPDK, etc.) and they seems to be not availab=
le in
>>>> the
>>>> qemu git.
>>>> Is there any way to do it with some qit.qemu available stubs or someth=
ing
>>>> else?
>>>> If so, could you please point out the proper way to do it?
>>> qemu.git has contrib/vhost-user-blk/ and contrib/vhost-user-scsi/ if
>>> you need to test those vhost-user devices without external dependencies=
.
>>>
>>> Stefan



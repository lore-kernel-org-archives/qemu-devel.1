Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BD9C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F7320706
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 15:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Mr65/Ifx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F7320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVHFw-0007IS-P6
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 10:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iVH8E-00016e-Sp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iVH8C-0002LH-Ty
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:34:02 -0500
Received: from mail-eopbgr20108.outbound.protection.outlook.com
 ([40.107.2.108]:27206 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iVH8B-0002Ji-Ut
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 10:34:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCmzsE6J2xYp2Adef7IrpRuGQESf/qL3hlnmaFThGrO7qiTEDgtldtGkureqUFFbKfNXQ156Y3DZVEHPpHbKced9IvIGLVtPdAvr87Vfs0+Us5mvOH8UzX5gIcz25Rc5urMgu21bhWaW4WReSzV7jOYL/uwzSQWiTbrW48PvU+ztShGc27uvgEqQai+2UrPc1Ud+xNnp45dj1qqdHKikbRR+KaHZChw1ZZgG3sPhYQdGgqWzpblV1Fc41PuH/XksOMJfs870dYzeuEsxlcsigSCL0unWMsq8fPTvYMVEtVcsGD35Hj82pDfgqqFVWsSvLKHZIo6DOU+asHEL9Ti98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3hQqS+6LOwV5M4vlW7lIFyLGfUInHQyXwmEyHZgOfs=;
 b=DZr/Il4Z5q6SdcZmVGjRksFih8gweeIq1o2R6n8msIYA6djVIJYnVXTN8t21XKbcT/6dyqy4YtbPFcdgBnDXml/v4I0F+7XGSxRreUAf/ssSsDO3rZ0TCVCPsNmgMSB24WDOUH8B9EBQXJvD/+OSgCvVCKx4yphE4MLpUBom5onyfFM9Au/90DOS7YRfd43iId26HaTlnTYMqwWvwKAjkrCm9yIuOv56f9TsVD6s9V4BwaApBiM0dHN8cfD7sq7IfpccvPMwPl/BZPh2XHsZfvgqhTDUTsUVuxaFB6WjLGUHjoddDkGYI42oyT+YuSnK9P2A1hjnBcom6KRMFeul2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3hQqS+6LOwV5M4vlW7lIFyLGfUInHQyXwmEyHZgOfs=;
 b=Mr65/Ifx9FJyy8zecwzaeMp3PZBTN//ttEQ8y229SRZDE+NeMsp85L/XSDh+Inz1MYsKhZAb2f8+sn5vSyJGF8H3wScKYrBXAe9jvDjTs4/odyoE56h6GVzIhzpCTw1Pm2x/WwjBE56iRi9ybvfTGr3cm+PNJGsYwmGKMSoOwRU=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB5315.eurprd08.prod.outlook.com (10.255.225.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 14 Nov 2019 15:33:56 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::e8bf:705f:f64d:4aa%4]) with mapi id 15.20.2451.027; Thu, 14 Nov 2019
 15:33:56 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Index: AQHVhasj1hrogEqe4kWfxpGYRrvmHqdoxjuAgADscwCAFHZTAIALPIAA///Y7ACAAbgTgA==
Date: Thu, 14 Nov 2019 15:33:56 +0000
Message-ID: <6b3a8e46-f0df-4303-08b2-209ff5353834@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191023172005-mutt-send-email-mst@kernel.org>
 <42b80a75-6ab4-5123-bbf5-eee21c2841ac@virtuozzo.com>
 <20191106065816-mutt-send-email-mst@kernel.org>
 <650b229d-34d6-f9a5-6a52-d7b5892a2c0c@virtuozzo.com>
 <20191113081108-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191113081108-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0021.eurprd03.prod.outlook.com
 (2603:10a6:3:76::31) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.161.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75d2da0e-f67d-4057-117d-08d769180fea
x-ms-traffictypediagnostic: AM0PR08MB5315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB5315BB78EA8E4E0AAC68A8DECF710@AM0PR08MB5315.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(39840400004)(346002)(189003)(199004)(25786009)(3846002)(71200400001)(71190400001)(66446008)(31686004)(64756008)(256004)(7736002)(66476007)(36756003)(305945005)(66556008)(2906002)(6436002)(8676002)(6486002)(81166006)(66946007)(14444005)(8936002)(81156014)(229853002)(6246003)(6512007)(478600001)(86362001)(52116002)(11346002)(446003)(2616005)(476003)(6506007)(31696002)(4326008)(6916009)(6116002)(5660300002)(386003)(316002)(54906003)(66066001)(102836004)(53546011)(14454004)(26005)(186003)(486006)(76176011)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5315;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gU24aDP7EZ21uQ7LiLUqLw8IuB4/7ssubWj3cQAcdoBOsphVybkyMOLgODWexU9JrQzIIUIjOJLvYWXhOkmHqkP6kIC7jMRwmQ2uXtlyQvhnC1/Jwbwps4RLhFDIecTPBWhPCm7hPifPg1BdIAopRDPMo/OnGWgauwFKm52e3ie2a1mD1YHne7HG4YbsHYxRDYNHYyzdJF1zfX3uW0FnWgFLq8CV2bWYdeNnWLABjhaSUVyFjLp/D2UEXQdCAOFLzxHnwATftspL/BiTTW8SN+nMMDM25KKPQqOhTazg0/mljq/GP5W+YwL3KtlDXC9HVUOXyhfYqXW/CvpjprriGLNPzNkGa7F85yp5unLRt87PZ9skoZuoeSXdtbGZnwipDPVfGI//SL50OK7rEtWKgyzyLE3H9SrELnindOvcbNZGZClP0VwE5GKkJ0PQOYQ8
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <88BCD3EDEA37E3408DBFC1B7C39DD57A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2da0e-f67d-4057-117d-08d769180fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 15:33:56.4663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQqA2HC3uVS1MJddG0pbObOsuqinJPRuX2F9RFXRqq291jPMWg1PO/jiNpMGljYmXw94z0FOg0e/bMrLsdP9GzMlSmBW7Gh6ZkdCLUknGdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5315
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.108
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 13.11.2019 16:18, Michael S. Tsirkin wrote:
> On Wed, Nov 13, 2019 at 12:38:48PM +0000, Denis Plotnikov wrote:
>>
>> On 06.11.2019 15:03, Michael S. Tsirkin wrote:
>>> On Thu, Oct 24, 2019 at 11:34:34AM +0000, Denis Lunev wrote:
>>>> On 10/24/19 12:28 AM, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
>>>>>> From: "Denis V. Lunev" <den@openvz.org>
>>>>>>
>>>>>> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
>>>>>> field reported by SCSI controler. Thus typical sequential read with
>>>>>> 1 MB size results in the following pattern of the IO from the guest:
>>>>>>     8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [d=
d]
>>>>>>     8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [d=
d]
>>>>>>     8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
>>>>>>     8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0=
]
>>>>>>     8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0=
]
>>>>>>     8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
>>>>>> The IO was generated by
>>>>>>     dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
>>>>>>
>>>>>> This effectively means that on rotational disks we will observe 3 IO=
PS
>>>>>> for each 2 MBs processed. This definitely negatively affects both
>>>>>> guest and host IO performance.
>>>>>>
>>>>>> The cure is relatively simple - we should report lengthy scatter-gat=
her
>>>>>> ability of the SCSI controller. Fortunately the situation here is ve=
ry
>>>>>> good. VirtIO transport layer can accomodate 1024 items in one reques=
t
>>>>>> while we are using only 128. This situation is present since almost
>>>>>> very beginning. 2 items are dedicated for request metadata thus we
>>>>>> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
>>>>>>
>>>>>> The following pattern is observed after the patch:
>>>>>>     8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [d=
d]
>>>>>>     8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [d=
d]
>>>>>>     8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0=
]
>>>>>>     8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0=
]
>>>>>> which is much better.
>>>>>>
>>>>>> The dark side of this patch is that we are tweaking guest visible
>>>>>> parameter, though this should be relatively safe as above transport
>>>>>> layer support is present in QEMU/host Linux for a very long time.
>>>>>> The patch adds configurable property for VirtIO SCSI with a new defa=
ult
>>>>>> and hardcode option for VirtBlock which does not provide good
>>>>>> configurable framework.
>>>>>>
>>>>>> Unfortunately the commit can not be applied as is. For the real cure=
 we
>>>>>> need guest to be fixed to accomodate that queue length, which is don=
e
>>>>>> only in the latest 4.14 kernel. Thus we are going to expose the prop=
erty
>>>>>> and tweak it on machine type level.
>>>>>>
>>>>>> The problem with the old kernels is that they have
>>>>>> max_segments <=3D virtqueue_size restriction which cause the guest
>>>>>> crashing in the case of violation.
>>>>> This isn't just in the guests: virtio spec also seems to imply this,
>>>>> or at least be vague on this point.
>>>>>
>>>>> So I think it'll need a feature bit.
>>>>> Doing that in a safe way will also allow being compatible with old gu=
ests.
>>>>>
>>>>> The only downside is it's a bit more work as we need to
>>>>> spec this out and add guest support.
>>>>>
>>>>>> To fix the case described above in the old kernels we can increase
>>>>>> virtqueue_size to 256 and max_segments to 254. The pitfall here is
>>>>>> that seabios allows the virtqueue_size-s < 128, however, the seabios
>>>>>> patch extending that value to 256 is pending.
>>>>> And the fix here is just to limit large vq size to virtio 1.0.
>>>>> In that mode it's fine I think:
>>>>>
>>>>>
>>>>>      /* check if the queue is available */
>>>>>      if (vp->use_modern) {
>>>>>          num =3D vp_read(&vp->common, virtio_pci_common_cfg, queue_si=
ze);
>>>>>          if (num > MAX_QUEUE_NUM) {
>>>>>              vp_write(&vp->common, virtio_pci_common_cfg, queue_size,
>>>>>                       MAX_QUEUE_NUM);
>>>>>              num =3D vp_read(&vp->common, virtio_pci_common_cfg, queu=
e_size);
>>>>>          }
>>>>>      } else {
>>>>>          num =3D vp_read(&vp->legacy, virtio_pci_legacy, queue_num);
>>>>>      }
>>>> you mean to put the code like this into virtio_pci_realize() inside QE=
MU?
>>>>
>>>> If no, can you pls clarify which component should be touched.
>>>>
>>>> Den
>>> I mean:
>>>    - add an API to change the default queue size
>>>    - add a validate features callback, in there check and for modern
>>>      flag set in features increase the queue size
>>>
>>> maybe all this is too much work, we could block this
>>> for transitional devices, but your patch does not do it,
>>> you need to check that legacy is enabled not that modern
>>> is not disabled.
>> To develop the idea of how to adjust queue size further I'd like to
>> summarize what we have:
>>
>> 1. Variatly of gusts without(?) queue size limitations which can support
>> queue sizes up to MAX(1024)
>>
>> 2. seabios setups with two possible max queue size limitations: 128 and
>> 256 (recently commited)
>>
>> 3. non-sebios setups with unknown max queue-size limitations
>>
>> Taking into account that queue size may be limited in bios(efi), to
>> safely support gueue sizes > 128 we need to distinguish those how can
>> support greater_than_128 from those who can't.
>> seabios potentially can't do it, so, as far as I understood, the idea is
>> to start with queue size=3D128 and then increase the queue size when the
>> guest driver is engaged.
>>
>> To achieve that, we need to
>>
>> 1.=A0 understand, which driver is currently working with a virtio device=
:
>> seabios, guest, other. Things
>>   =A0=A0=A0 here are quite complex, since we can't modify any guest, sea=
bios or
>> other drivers to explicitly tell
>>   =A0=A0=A0 that=A0 to device
> Anyone negotiating VIRTIO_1
>
>> 2. be able to increase queue size dynamically (re-create queues?). At
>> the time, this functionality
>>   =A0=A0 is absent, at least in qemu virtio-scsi.
>>   =A0=A0 Is it possible by design?
> Why not, it's just an array.
> This is what I meant when I said we need an API to resize a queue.
>
>> 3. choose a place for queue size extending (re-creation).
>> VirtioDeviceClass->reset?
> Definitely not reset, that gets you back to original state.
>
>> I actually don't know how to do it reliably, so would really appreciate
>> sone help or advice.
> validate features sounds like a good place.
> this is why I wrote "add a validate features callback".
>
>> You've mentioned that old seabios won't use the modern interface, so
>> would it be ok, if we
>>
>>   =A0=A0=A0 * define DEFAULT_QUEUE_SIZE =3D 128
>>   =A0=A0=A0 * leave queues creation as is at VirtioDeviceClass->realize(=
)
>>   =A0=A0=A0=A0=A0 with queue_size =3D conf.queue_size
>>   =A0=A0=A0 * on VirtioDeviceClass->reset() we check if the device acces=
sed
>> through "legacy" interface
>>   =A0=A0=A0=A0=A0 if so, then (in pseudocode)
>>   =A0=A0=A0=A0=A0=A0=A0=A0 if (current_queue_size > DEFAULT_QUEUE_SIZE) =
{
>>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (queue in all_queues) {
>>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reduce_queue_size(que=
ue, DEFAULT_QUEUE_SIZE) //
>> recreate_queue() ?
>>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>   =A0=A0=A0=A0=A0=A0=A0=A0 }
>>   =A0=A0=A0=A0=A0 else
>>   =A0=A0=A0=A0=A0=A0=A0=A0 if (conf.queue_size > current_queue_size) {
>>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (queue in all_queues) {
>>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 increase_queue_size(q=
ueue, conf.queue_size)
>>   =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>   =A0=A0=A0=A0=A0=A0=A0=A0 }
>>
>> Might this approach work? Does it what you meant?
>>
>> Denis
>
> I don't think you can do anything useful in reset.  We need to check
> features after they have been negotiated.  So we'd start with a small
> queue min(DEFAULT_QUEUE_SIZE, current_queue_size)?
> and if VIRTIO_1 is set increase the size.
>
> This is very compatible but it is certainly ugly as we are
> second-guessing the user.
>
>
> Simpler idea: add a new property that is simply
> unsupported with legacy.  E.g.  "modern-queue-size" ?
> If someone sets it, legacy must be disabled otherwise we fail.
>
> Way less compatible but hey.
If I got the idea correctly, in that case the old seabios won't start.
Hence we won't achieve what we want: increase the queue size in the=20
guests which
use the old seabios.
May be the ugly way is worth to be implemented since it would allow to=20
add some
performance to the existing guests?

Denis

>
>
>>>
>>>



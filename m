Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E0ACA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B232084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 09:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PHRdHBr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B232084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNCmT-0006n6-LV
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 05:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iNCho-0004in-Cx
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iNChm-0006Nj-6a
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:13:24 -0400
Received: from mail-eopbgr80099.outbound.protection.outlook.com
 ([40.107.8.99]:58673 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iNChi-0006Lq-LH
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:13:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQiXVOr5CO4FuxgO8iOKOMT4dflRNUNVUpWzfTkGzt/ZSvcOA60IInJy19A3gt5NBzQ6s4ZupmzVNPP+0dnf0VU5m+vzlsGWG/dNjd1cITXIoHsGMJxO5ich+XTTKkrxWZbtZSbRUtNuY9NP+2F3Bqik4wwBd7wMq9Ex7ovw1uQoHdQFWB/N6xqv8ymMoFuQ4eYJtmsGuQn8MoQLH/jzefaX/e3CihBt3vc8ZXyLnmrXbqCdWHR9bIM8vHmY+6uKj9sbJ+ev1I67lmIG530QFVyNUEkd2A7kVPbmXfdo+s2teZBA0Ob1zfO2fPbHbCpIaDhmbbR6/7y88PcG1h5/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EZmqkkGkm6DNArY0hUeOUxgighM8CouSHPw4mpj5Ew=;
 b=AP1naSi+sBjEaxYAgQknLIT9c3cnJsGsKs70XRoI34yG4bCkANnV8QR+/bKW5S/OiuXOjReKLcwxn4ZeQDMtH9NJPS3bkcHEu9x/KEpyP6N2ueQDaTWTc7wNxtmJbcOOUokNyOozpd9jzTxFV1vYFXVMroQB1Ka8b67eZHKG9knMprrt4+tRseDGB4vMVU9D8M9FMzDwFJ5HwGfRdtjtWpUSSjk+I+enaRKtW1MxO4epTCDl1EIpzC9PyQl5IrJCGdT7+ljBOPFguB/+QoE2j85XaWzze7jBeD3Ogvo/YlJEEoq3GhNtKg4mOWjiIpBi7EuX+Yp4Db5IVLGiu/RHzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EZmqkkGkm6DNArY0hUeOUxgighM8CouSHPw4mpj5Ew=;
 b=PHRdHBr7o7rdvm3orazZQcP2920U9Dk+l9HzncWKDfwbK33AoVaT9i7sjwXyIgkiQY46ek1us8lYNVGX4jWH/CNhLZI0x26QK7NnN16BfW9l+WZcqQhyBSUnPfSDgw1Lk9fzYkhPNayZ3JPObB2Dwxlyxul2D+0RXQo/mOVqWLw=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3377.eurprd08.prod.outlook.com (20.177.43.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 09:13:13 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::cb5:43e:b23f:9618%7]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 09:13:13 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Index: AQHVhasj1hrogEqe4kWfxpGYRrvmHqdlGoSAgALeUwA=
Date: Wed, 23 Oct 2019 09:13:12 +0000
Message-ID: <8eabd34d-d94f-cdfd-3cc8-529cee9f6145@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191021132455.GH22659@stefanha-x1.localdomain>
In-Reply-To: <20191021132455.GH22659@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0014.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::24)
 To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.233.241.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1d0c38e-1894-4398-4556-08d757993b04
x-ms-traffictypediagnostic: AM0PR08MB3377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3377AB52CBCBD1F7950F8384CF6B0@AM0PR08MB3377.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(396003)(39840400004)(136003)(52314003)(199004)(189003)(6486002)(52116002)(76176011)(53546011)(6506007)(8676002)(81156014)(81166006)(8936002)(71190400001)(478600001)(4326008)(31686004)(14454004)(99286004)(6512007)(6246003)(26005)(54906003)(64756008)(107886003)(316002)(102836004)(386003)(66946007)(66556008)(186003)(66476007)(66446008)(71200400001)(31696002)(86362001)(6916009)(7736002)(446003)(305945005)(66066001)(11346002)(14444005)(256004)(2616005)(486006)(3846002)(36756003)(6116002)(2906002)(5660300002)(229853002)(25786009)(6436002)(476003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3377;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R+65I2tzpvwYgSqIjA4t8csHUrdplgPJM+RRclCV2clwl1aZ/alxYoLtaoz1dUJtYbg4E43bG/EkDGtG0yKwWotyREAIYCfmvC76ntpvx/Yi1Crfte9Zj7SzjahVRkSvdL19A1X0SLAcyvaV4zI17lFv7kawnxRGpub21UG7fIQ3kL+hnPIlUU4TQtyi2qivpohD1bVa2zJX/YZZdhlFRWjk0DF6KPTXoPq/fZELU9MOplG5hf1UYEpEN9WY6sMHTiNNunIh7+94ofogvbaOvb3WiFJCYk0ABmVXOnbAenCh+ARYyBXZRtFwiuhF59kaBbOTyDvhhiztWtc5dL2YH/ST8tceVWzNzhT+j52hklvaJi8XEGzEZqj38epuRapgWtI0byLODS38PlUVrBd1kss3oG5znMaXe0WumTchYhA68lsB+wuoU6caJP1HR80g
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <81C0A11E2753244C98FC0DA48ED615B1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d0c38e-1894-4398-4556-08d757993b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:13:13.0011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DStnELvKpq9NBFFsZmpVErIMxvyg0Gd1brk+dFcH82ivWPqAfH0eYQ4rRWglS+klaWk5EMhR//EbaIBBL8Y1ovIq+0EE41b1Ht/C4d/dEm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3377
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.99
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
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 21.10.2019 16:24, Stefan Hajnoczi wrote:
> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
>> field reported by SCSI controler. Thus typical sequential read with
>> 1 MB size results in the following pattern of the IO from the guest:
>>    8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
>>    8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
>>    8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
>>    8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
>>    8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
>>    8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
>> The IO was generated by
>>    dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
>>
>> This effectively means that on rotational disks we will observe 3 IOPS
>> for each 2 MBs processed. This definitely negatively affects both
>> guest and host IO performance.
>>
>> The cure is relatively simple - we should report lengthy scatter-gather
>> ability of the SCSI controller. Fortunately the situation here is very
>> good. VirtIO transport layer can accomodate 1024 items in one request
>> while we are using only 128. This situation is present since almost
>> very beginning. 2 items are dedicated for request metadata thus we
>> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
>>
>> The following pattern is observed after the patch:
>>    8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
>>    8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
>>    8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
>>    8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
>> which is much better.
>>
>> The dark side of this patch is that we are tweaking guest visible
>> parameter, though this should be relatively safe as above transport
>> layer support is present in QEMU/host Linux for a very long time.
>> The patch adds configurable property for VirtIO SCSI with a new default
>> and hardcode option for VirtBlock which does not provide good
>> configurable framework.
>>
>> Unfortunately the commit can not be applied as is. For the real cure we
>> need guest to be fixed to accomodate that queue length, which is done
>> only in the latest 4.14 kernel. Thus we are going to expose the property
>> and tweak it on machine type level.
>>
>> The problem with the old kernels is that they have
>> max_segments <=3D virtqueue_size restriction which cause the guest
>> crashing in the case of violation.
>> To fix the case described above in the old kernels we can increase
>> virtqueue_size to 256 and max_segments to 254. The pitfall here is
>> that seabios allows the virtqueue_size-s < 128, however, the seabios
>> patch extending that value to 256 is pending.
> If I understand correctly you are relying on Indirect Descriptor support
> in the guest driver in order to exceed the Virtqueue Descriptor Table
> size.
>
> Unfortunately the "max_segments <=3D virtqueue_size restriction" is
> required by the VIRTIO 1.1 specification:
>
>    2.6.5.3.1 Driver Requirements: Indirect Descriptors
>
>    A driver MUST NOT create a descriptor chain longer than the Queue
>    Size of the device.
>
> So this idea seems to be in violation of the specification?
>
> There is a bug in hw/block/virtio-blk.c:virtio_blk_update_config() and
> hw/scsi/virtio-scsi.c:virtio_scsi_get_config():
>
>    virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
>
> This number should be the minimum of blk_get_max_iov() and
> virtio_queue_get_num(), minus 2 for the header and footer.

Stefan,

It seems VitrioSCSI don't have a direct link to blk, apart of=20
VirtIOBlock->blk, and the link to a blk comes with each scsi request. I=20
suspect that idea here is that a single virtioscsi can serve several=20
blk-s. If my assumption is corect, then we can't get blk_get_max_iov()=20
on virtioscsi configuration stage and we shouldn't take into account=20
max_iov and limit max_segments with virtio_queue_get_num()-2 only.

Is it so, or is there any other details to take into account?

Thanks!

Denis

>
> I looked at the Linux SCSI driver code and it seems each HBA has a
> single max_segments number - it does not vary on a per-device basis.
> This could be a problem if two host block device with different
> max_segments are exposed to the guest through the same virtio-scsi
> controller.  Another bug? :(
>
> Anyway, if you want ~1024 descriptors you should set Queue Size to 1024.
> I don't see a spec-compliant way of doing it otherwise.  Hopefully I
> have overlooked something and there is a nice way to solve this.
>
> Stefan


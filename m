Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCE0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA652173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SPZwH3A4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA652173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHnN-0002If-J1
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNHm2-0001mg-0c
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNHlx-00046m-SP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:38:04 -0400
Received: from mail-eopbgr40138.outbound.protection.outlook.com
 ([40.107.4.138]:7992 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1iNHlv-00045V-O9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkW1mVQu82axTx7MGJhZ3bUki1ULwfalg0N2ETcQoQ1J8usMOSmknUeI5v+YPLLXLLtA5/K06qK1A45yOldFymUZYR4lI6xRjUHKl/WbO6VkuvizGaF8uRPUavHAom0PLcen4E0lFMa0f/APegXgrW/9iug61su+F0eaGHnwmweq+JItkK4r2XzU0xw05+Fofd4wDVGdwCxURBALCAug2HnCi38WYKuJ1gY88dSycYQoxFMqcshMbgTSmCL1TutK/1zhBLKua0/SI39BJ0lSBPSVdqhSmVHAKeOPenaTMXrRcIq3H/4lG3ITJsZv53ti7FtCfmdHyDsTrx/+Q10Oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmAoutuzBFnZ9oxgqKLc2wCy+f0KdFqJ9E5JxrNiuj8=;
 b=Jt4IAhQqpkhTI2H916BEOfWvP+5xK4VMvZw4cMjWPuI1BodfYiMbph1aIIdb5v0iMs+UewMKGczVxdXejKvdyjPGAmkmWlInCAbQfb65MI4HeyPv81Z004Ujwrj3aLrtigkwcSZRv2c2RdlLuRScmJ7b22S/4Oz9j8ib0mK/+/8r22NitNBwTzAbi4+sHyyFutoRw3kWlxSej1YknvEZSyQUwoZpDSFd9cwrH1o0ZrBg39J20pyZqQURtSJBYHe9dCvpYQMUZub/v5BzJfeKFpt1AHQbLNxhSPF9ibTRtC6abwV051G4lokcWPcw16/CHylFX1yPWWwf0ouQc1focw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmAoutuzBFnZ9oxgqKLc2wCy+f0KdFqJ9E5JxrNiuj8=;
 b=SPZwH3A4vLX6zELqlZfKTk98zhYlaCi50N4t7pYhtBczWf7oOZkCn2/9gEmX83srMjKb8a53u8h3SxrvVnJVVGc75GyNnEhRU0LMGmIoJs6DRNfeV4WxIgwCWdtMtLw9tN+8J4Dght0xlhGPAQypgIJ/t/aRYveeZHp4nbET8/A=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB2119.eurprd08.prod.outlook.com (10.169.223.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 14:37:56 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 14:37:56 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Index: AQHVhasC5IeHsTPw3kK+gvsF622z76dlGoSAgAD1CICAAj4wgIAABdYA
Date: Wed, 23 Oct 2019 14:37:56 +0000
Message-ID: <6e1e0b88-25b3-3db1-5fdc-255190720646@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191021132455.GH22659@stefanha-x1.localdomain>
 <c5b0761d-496d-eabc-bb87-2fd70e89577c@virtuozzo.com>
 <20191023141701.GD9574@stefanha-x1.localdomain>
In-Reply-To: <20191023141701.GD9574@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0178.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::26) To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a201902-d3b7-4820-ff1e-08d757c697f2
x-ms-traffictypediagnostic: DB6PR0801MB2119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB211972F807316C2296DF4725B66B0@DB6PR0801MB2119.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(346002)(39840400004)(189003)(51444003)(52314003)(199004)(6512007)(6506007)(316002)(6116002)(76176011)(66476007)(86362001)(305945005)(3846002)(64756008)(386003)(52116002)(66946007)(7736002)(99286004)(66556008)(31686004)(2906002)(186003)(26005)(31696002)(102836004)(53546011)(6916009)(486006)(14444005)(478600001)(256004)(6246003)(6486002)(5660300002)(14454004)(66446008)(8676002)(81156014)(229853002)(476003)(81166006)(8936002)(25786009)(71190400001)(6436002)(71200400001)(54906003)(11346002)(36756003)(446003)(4326008)(66066001)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB2119;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQH1ehpBpnaJSDwKyp+67DkXwTf45+6RBloser0MLHiWJwSOKx5u23lnvWwIarspMsaPo+N3XAfn1zlVFdug+ptXaOJMOhJtMd0Jx5/B3KSeJOjmdS0TbrZzo4q5sj/+FiwYP2MGOtUBiTICYeNw4MocsbOEp8BH7P9Ha+V9Nq81VzHRcetUixB5/gQ66N5GBdZBprEqbZ0GcQ3L1ws7DNqY2KrIFMPuPFogFmGmAwXla3dSzcq6JiLVShJEgJflzZD63qCCnoNCgr0N9lTnzmcMnKtN6anV9IaEArA81YkY9XnWnBATfg7fn+CuQUBNxslVVuh2AfDbJcso1ipa2paZP0na21Pk6wHw3KarhL7qHrj/dB1303IQS5Kah8h5Adm+3JJeVLsx99HxmAUFyyO+ZiF+ox9ozbdHlXxew3ewW52m50xdMKoXqCecNWBw
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <00FB6E757FBD76488012F19C266C7EDC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a201902-d3b7-4820-ff1e-08d757c697f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 14:37:56.1759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMy+25D8gnBgPrGp2BaVlMYyrKZoU5bXvFmyODyeKvj4iN1+al64HovSVd6LcotKp4pxvVGWkM5KgzxCH9AXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2119
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.138
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 5:17 PM, Stefan Hajnoczi wrote:
> On Tue, Oct 22, 2019 at 04:01:57AM +0000, Denis Lunev wrote:
>> On 10/21/19 4:24 PM, Stefan Hajnoczi wrote:
>>> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
>>>> From: "Denis V. Lunev" <den@openvz.org>
>>>>
>>>> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
>>>> field reported by SCSI controler. Thus typical sequential read with
>>>> 1 MB size results in the following pattern of the IO from the guest:
>>>>   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
>>>>   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
>>>>   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
>>>>   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
>>>>   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
>>>>   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
>>>> The IO was generated by
>>>>   dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
>>>>
>>>> This effectively means that on rotational disks we will observe 3 IOPS
>>>> for each 2 MBs processed. This definitely negatively affects both
>>>> guest and host IO performance.
>>>>
>>>> The cure is relatively simple - we should report lengthy scatter-gathe=
r
>>>> ability of the SCSI controller. Fortunately the situation here is very
>>>> good. VirtIO transport layer can accomodate 1024 items in one request
>>>> while we are using only 128. This situation is present since almost
>>>> very beginning. 2 items are dedicated for request metadata thus we
>>>> should publish VIRTQUEUE_MAX_SIZE - 2 as max_seg.
>>>>
>>>> The following pattern is observed after the patch:
>>>>   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
>>>>   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
>>>>   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
>>>>   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
>>>> which is much better.
>>>>
>>>> The dark side of this patch is that we are tweaking guest visible
>>>> parameter, though this should be relatively safe as above transport
>>>> layer support is present in QEMU/host Linux for a very long time.
>>>> The patch adds configurable property for VirtIO SCSI with a new defaul=
t
>>>> and hardcode option for VirtBlock which does not provide good
>>>> configurable framework.
>>>>
>>>> Unfortunately the commit can not be applied as is. For the real cure w=
e
>>>> need guest to be fixed to accomodate that queue length, which is done
>>>> only in the latest 4.14 kernel. Thus we are going to expose the proper=
ty
>>>> and tweak it on machine type level.
>>>>
>>>> The problem with the old kernels is that they have
>>>> max_segments <=3D virtqueue_size restriction which cause the guest
>>>> crashing in the case of violation.
>>>> To fix the case described above in the old kernels we can increase
>>>> virtqueue_size to 256 and max_segments to 254. The pitfall here is
>>>> that seabios allows the virtqueue_size-s < 128, however, the seabios
>>>> patch extending that value to 256 is pending.
>>> If I understand correctly you are relying on Indirect Descriptor suppor=
t
>>> in the guest driver in order to exceed the Virtqueue Descriptor Table
>>> size.
>>>
>>> Unfortunately the "max_segments <=3D virtqueue_size restriction" is
>>> required by the VIRTIO 1.1 specification:
>>>
>>>   2.6.5.3.1 Driver Requirements: Indirect Descriptors
>>>
>>>   A driver MUST NOT create a descriptor chain longer than the Queue
>>>   Size of the device.
>>>
>>> So this idea seems to be in violation of the specification?
>>>
>>> There is a bug in hw/block/virtio-blk.c:virtio_blk_update_config() and
>>> hw/scsi/virtio-scsi.c:virtio_scsi_get_config():
>>>
>>>   virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
>>>
>>> This number should be the minimum of blk_get_max_iov() and
>>> virtio_queue_get_num(), minus 2 for the header and footer.
>>>
>>> I looked at the Linux SCSI driver code and it seems each HBA has a
>>> single max_segments number - it does not vary on a per-device basis.
>>> This could be a problem if two host block device with different
>>> max_segments are exposed to the guest through the same virtio-scsi
>>> controller.  Another bug? :(
>>>
>>> Anyway, if you want ~1024 descriptors you should set Queue Size to 1024=
.
>>> I don't see a spec-compliant way of doing it otherwise.  Hopefully I
>>> have overlooked something and there is a nice way to solve this.
>>>
>>> Stefan
>> you are perfectly correct. We need actually 3 changes to improve
>> guest behavior:
>> 1) This patch, which adds property but does not change anything
>> =A0=A0=A0 useful
> This patch is problematic because it causes existing guest drivers to
> violate the VIRTIO specification (or fail) if the value is set too high.
> In addition, it does not take into account the virtqueue size so the
> default value is too low when the user sets -device ...,queue-size=3D1024=
.
>
> Let's calculate blkcfg.seg_max based on the virtqueue size as mentioned
> in my previous email instead.
As far as I understand maximum amount of segments could be more than
virtqueue size for indirect requests (allowed in VirtIO 1.0).

> There is one caveat with my suggestion: drivers are allowed to access
> VIRTIO Configuration Space before virtqueue setup has determined the
> final size.  Therefore the value of this field can change after
> virtqueue setup.  Drivers that set a custom virtqueue size would need to
> read the value after virtqueue setup.  (Linux drivers do not modify the
> virtqueue size so it won't affect them.)
>
> Stefan
I think that we should do that a little bit different :) We can not
change max_segs
just if queue size is changed, this should be somehow bound to machine type=
.
Thus I propose to add "automatic" value, i.e.

if max_segs is set to 0 the code should set it to queue size -2.
This should be default. Alternatively the value from max_segs should be
taken. Will this work for you?

Please note, currently the specification could also be violated if we will
reduce queue size to 64 :)

Den


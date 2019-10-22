Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31357CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83BF2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 04:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jceU7QhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83BF2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMlNs-00048g-1d
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 00:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iMlMy-0003gS-Gk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 00:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iMlMw-0001Ku-Sz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 00:02:04 -0400
Received: from mail-eopbgr20121.outbound.protection.outlook.com
 ([40.107.2.121]:2919 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1iMlMw-0001KV-5f
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 00:02:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSGJ+j/n7dICAhFHo8wz2QqlRclgP6eRdwL0WI43IkacDsW1JI1L8VyGlgJySJdArMgLStf78q5tNX2TBcxjI+h1SDi3RAX4lOv4ic3j0cfn4PSzcY9rlNksJ8hAegk7HgE0farUoqDrr4lw2Tx7ZtrtqwiWpesH4KChRTXe06hoEGma/dlGbFvgzWLU4a113Ed11lQvcVJUa2c639dPxXZsaizufgawFN0cW57sj1JfPekWH0f5+6B7hiSOiIGkTwXN13lR7I2RQfmERunGU6CbScre+LavYRbwqLR8UGYZmsquFKbCrWG9Xm4ruGLT2eA7AEuHtU5m8QJYVl8L6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkGJx9eTBPZ9Dn81Cj94ZgvWZJzuYZZHonx5eKBeSyg=;
 b=EJfNkqV297FRTLwtz6+s2p65dmocsewCZCKlc5zFm2tO55Daw1eaaY/HODdEJqmwKCUDQtdxW36lGlh8nERIbVP2M2vSj82phgeFs47bWzx2wFZeGut1srpKqYhTN++mOnxsmf8f6LOPev4R9fu4Evur3qaFo187xTCraKxYuYLh66M9ytxcYVRs9oSTGeScVdXQep3MyKecRt02wg7ZKhF2iy7TNXGsI4XlbkPe6lPAuKqQp2YABwBjnfNrKXCfr1z26t01fQuDgeKkwLWlpQW0vZxCnvIM5YRR/0ab8GFDQTcaJEgFdqQDzID+uAauBOvDO/67PSxC/m/DGL3xTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkGJx9eTBPZ9Dn81Cj94ZgvWZJzuYZZHonx5eKBeSyg=;
 b=jceU7QhPX8wHEmqWNoYXIdh/llclJSHPE6oNbBgVwrvlHC9yk0dZRmJp7E1eHALdKPgcUyC6sGbMb/IclkAIynPEBEgzfxhw+PcKJkDGcwOBgZ2JXHzFXCZH7dqs3EPyTf5DVUIDFNN7+5dzMDyVheV+bDArjO4JwA0UaE2ddq0=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB1909.eurprd08.prod.outlook.com (10.168.84.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 04:01:57 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 04:01:57 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Denis Plotnikov
 <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Topic: [PATCH] virtio: fix IO request length in virtio SCSI/block
 #PSBM-78839
Thread-Index: AQHVhasC5IeHsTPw3kK+gvsF622z76dlGoSAgAD1CIA=
Date: Tue, 22 Oct 2019 04:01:57 +0000
Message-ID: <c5b0761d-496d-eabc-bb87-2fd70e89577c@virtuozzo.com>
References: <20191018115547.19299-1-dplotnikov@virtuozzo.com>
 <20191021132455.GH22659@stefanha-x1.localdomain>
In-Reply-To: <20191021132455.GH22659@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::23) To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [31.148.204.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8df4693-3640-43f3-3fc5-08d756a49564
x-ms-traffictypediagnostic: DB6PR0801MB1909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB19095FF99EA440EE135F04F4B6680@DB6PR0801MB1909.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(366004)(39840400004)(376002)(52314003)(189003)(51444003)(199004)(476003)(11346002)(2906002)(31696002)(3846002)(6116002)(86362001)(305945005)(71200400001)(14444005)(66946007)(256004)(66476007)(66556008)(64756008)(66446008)(446003)(31686004)(7736002)(2616005)(71190400001)(36756003)(486006)(478600001)(14454004)(6246003)(386003)(6506007)(53546011)(110136005)(6486002)(25786009)(229853002)(6512007)(54906003)(6436002)(99286004)(52116002)(81156014)(81166006)(76176011)(5660300002)(316002)(8676002)(186003)(66066001)(26005)(102836004)(6636002)(4326008)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB1909;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jehaUcEfkWCZxqeu+ab8NdMVw7XVyEO1M7VUyYq/8IBKStM+h++sBvSDugvudCfQRpkn6GNTjwh8esYBWx5WjV1h/h1qNKJ7B+YtAkYH9tL1aMk1bxooix9rkeEoK1T4fjVOPF9JL4vkW9RiS/A/PWN+pPJrZi8SYPBlwrcCdJAqlVVR4kp7TuQHZcfV39rA8DTOROLDwvl6Gf4nlRsBNnMrsSIcqkSIyQTx+iqiKvG6ATDNbhG4eCZstk9UEd1mBcSqvSJoxfH0cqND16GVfj8bmVIuIGhbwCM73z9X/tuUIocDmtmBXyPgVw1NS0s2YEod904S24UFQT1lz7YMPqIr0TJSkQgfi399nl9uURAwY4GF6oNIYk3rjvUSYgZmQVsQ4xW6XBX4ZNqbAJ4jRPzjSdNN0XsNZ/jDFCB54nDu+ykmGwnt84O28wbwil6h
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FBF768C2198DED4C97AA40D13F35BC87@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8df4693-3640-43f3-3fc5-08d756a49564
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 04:01:57.9054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOmALFD6d1aH4tgbKAEF8MRyhjdx8faAWy2pjjd5wXbNOvP7j3IznTsnRQvLOOtkNgnfwaJU26DKZ4/uY0SvDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1909
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.121
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 4:24 PM, Stefan Hajnoczi wrote:
> On Fri, Oct 18, 2019 at 02:55:47PM +0300, Denis Plotnikov wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> Linux guests submit IO requests no longer than PAGE_SIZE * max_seg
>> field reported by SCSI controler. Thus typical sequential read with
>> 1 MB size results in the following pattern of the IO from the guest:
>>   8,16   1    15754     2.766095122  2071  D   R 2095104 + 1008 [dd]
>>   8,16   1    15755     2.766108785  2071  D   R 2096112 + 1008 [dd]
>>   8,16   1    15756     2.766113486  2071  D   R 2097120 + 32 [dd]
>>   8,16   1    15757     2.767668961     0  C   R 2095104 + 1008 [0]
>>   8,16   1    15758     2.768534315     0  C   R 2096112 + 1008 [0]
>>   8,16   1    15759     2.768539782     0  C   R 2097120 + 32 [0]
>> The IO was generated by
>>   dd if=3D/dev/sda of=3D/dev/null bs=3D1024 iflag=3Ddirect
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
>>   8,16   1     9921     2.662721340  2063  D   R 2095104 + 1024 [dd]
>>   8,16   1     9922     2.662737585  2063  D   R 2096128 + 1024 [dd]
>>   8,16   1     9923     2.665188167     0  C   R 2095104 + 1024 [0]
>>   8,16   1     9924     2.665198777     0  C   R 2096128 + 1024 [0]
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
>   2.6.5.3.1 Driver Requirements: Indirect Descriptors
>
>   A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device.
>
> So this idea seems to be in violation of the specification?
>
> There is a bug in hw/block/virtio-blk.c:virtio_blk_update_config() and
> hw/scsi/virtio-scsi.c:virtio_scsi_get_config():
>
>   virtio_stl_p(vdev, &blkcfg.seg_max, 128 - 2);
>
> This number should be the minimum of blk_get_max_iov() and
> virtio_queue_get_num(), minus 2 for the header and footer.
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
you are perfectly correct. We need actually 3 changes to improve
guest behavior:
1) This patch, which adds property but does not change anything
=A0=A0=A0 useful
2) The patch to SeaBIOS, which extends maximum allowed
=A0=A0=A0 queue size. Right now virtque > 128 results in assert (pending
=A0=A0=A0 in SeaBIOS list).
3) Increase queue size and max_segments inside machine type.
=A0=A0=A0 We have done that to 256 and 256 -2 respectively.

I think that this exact patch with property does not harm and
upon the acceptance could start a discussion about default
queue length extension.

Den


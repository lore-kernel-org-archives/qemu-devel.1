Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF70C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F1A20872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="naLrr6YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F1A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSsf-0006EW-Dr
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSrM-00053G-5r
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXSrI-0005Dm-OU
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:29:39 -0500
Received: from mail-he1eur01on0725.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::725]:5603
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXSrH-0005DD-QT; Wed, 20 Nov 2019 11:29:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJcVUZNoKIeOYcNijxOzEo20Mnl8EPziITqydYUPTcGb2S3/86v7ofMGsSimY566TcNjdEx7yvDRKyS0fRYKbal4wJaUEs4eHcvqJkH9pwBWNfoGbt82slZgzc1w2MoNE/9Rkr2uB8qGZX4N3TgI8OwVo+qA+dpzmLZlp+f0YnL/SKGZ8LQAZi4YSoPEHw2J/NQMrBFPvqm46OnVd7xaDy7FAjmqxbagyOL01LP+Xs05gahzXjBP0VFxVbL4Cqi1r2ackBgn1tbe2LwTOp25TD2Cfs9UYzdwQfzezm0uO6WbqjgbcdvjSy3qqVYfP28fopPyO5UDtH3iHzx83d3jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xtmo9gjeLiu5cPmnj8+iznFNnbAhNOgDOppsPoG6g8=;
 b=awHpnNECCKcaLNe/KQchBfPSdOSh3lCoWs0jIKmMuvcyxonVtmd9Rlsv60RyOwd8Aah/vJKVFSHdqzJwGkkt5oK73S1nz9UMrtjlfufl3gQBjw8Z/UrB+reIs+WSnXK5j4cMewNfjqD/cNnFy+4efLaCPCkZdfXkuBEatFZPpW5r0ey1QKQtz0xES4kZUC0N02kqzu86cHyMEvP5XUhPAmfR2Fo8A5NfmCYS4U/6+p6LUDf5J+UUqX27QpuKEC6cBpiaH/ntNIxGOW2tue0WZTQYtNPZjZlo0Sx/c3cyk3d8CtHu65rsp79U1v6tDh7qDXBki8Y0AAvjh5jknAjGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xtmo9gjeLiu5cPmnj8+iznFNnbAhNOgDOppsPoG6g8=;
 b=naLrr6YLh2cSSYM2mUIxbzS4i7ZZsOK73uORDx2U2HGkpz7YI314qHKjlJIVFHhjOVnLLbaD26m+QTdoAuBGRUysDJUFA8YE5dvmccLKy9m2RNGNxmcIyzdU1uUBWqikp/zad7rMF7/vjWuEBqiU8efSSjGm9hxk/3hGGcg0e/c=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3510.eurprd08.prod.outlook.com (20.177.114.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 16:29:31 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 16:29:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn6tcQgTd8h0BOUCr2B20a33R1qeUZOgA///V+wCAAAUhAA==
Date: Wed, 20 Nov 2019 16:29:31 +0000
Message-ID: <48896017-4e6e-6eb7-0c96-d53d2a02a993@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-7-kwolf@redhat.com>
 <b5f3fb13-7467-d87e-07db-45bd014c6464@virtuozzo.com>
 <20191120161106.GE5779@linux.fritz.box>
In-Reply-To: <20191120161106.GE5779@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0054.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120192928839
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3be2e83-7834-415d-9cca-08d76dd6d212
x-ms-traffictypediagnostic: AM6PR08MB3510:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB35102F5E9435B53E709A00D4C14F0@AM6PR08MB3510.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(189003)(199004)(6116002)(102836004)(256004)(66946007)(14444005)(305945005)(446003)(3846002)(54906003)(6506007)(386003)(81166006)(6512007)(36756003)(2906002)(14454004)(11346002)(6246003)(71200400001)(71190400001)(7736002)(64756008)(66476007)(66446008)(66556008)(486006)(31686004)(476003)(2616005)(31696002)(52116002)(81156014)(99286004)(5660300002)(186003)(8936002)(6306002)(76176011)(6916009)(25786009)(6436002)(229853002)(86362001)(4326008)(66066001)(8676002)(26005)(498600001)(6486002)(21314003)(2004002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3510;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gFtKciVrftnph7ENTtGoUMTleOlBOJ7TC9tppb82msGsZ/RinbFqhMx+bWcY6a6WnrcnQYqAYF+eLN9e/NimURhOs9/eYBiCOQF/+KvgafihfCyjpYnmaqPYJn3WFfVCaGlef2nnMefaOg7zgtrREU9wwei5ws6fVwWg+0WfSJyEOT9HcvlIq8PrxSeLfLN2y96cWtHfKrvij1QbRNhQ0M9OfDY7tlMyT4FXboIPpksIEOv78/m4pBUUqxX6ngs21YXw5Mb7HIPEi6Vids4rn3CMY2+cnsJEFJov6za4LE3QShhKKjKwUyQgQn7R5covQMk97j600ptMTBFbyCydILzYlyKnCpxuY35PEmzQot8OzxWmdmgY/UmmcymXR5hkZKAH9PAzHmQQId9yqCyq0Kcy45vwrXIyzuTqBzhBvxm5XyABKwFjFpzAegVUV5R24l4WkGEbscb2mir+vQnVuAiYd2EgYk+PwfBVmb8vFU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <06DB9FF568A70E4F9CE52CB73F88838E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3be2e83-7834-415d-9cca-08d76dd6d212
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 16:29:31.2427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pk9MLBbP7DTNcXcqGShyvv5mHuEyk1P80YZXRfRDZTFvB8dIw9dI1X9qN4KYCbLvcIfkDrdpDOFlcI4PGEDQregc6NyCI/VOVP0RH+ec8pI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3510
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1e::725
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 19:11, Kevin Wolf wrote:
> Am 20.11.2019 um 16:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 20.11.2019 17:03, Kevin Wolf wrote:
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
>>>    tests/qemu-iotests/274.out    | 150 ++++++++++++++++++++++++++++++++=
++
>>>    tests/qemu-iotests/group      |   1 +
>>>    tests/qemu-iotests/iotests.py |   2 +-
>>>    4 files changed, 283 insertions(+), 1 deletion(-)
>>>    create mode 100755 tests/qemu-iotests/274
>>>    create mode 100644 tests/qemu-iotests/274.out
>>>
>>> diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
>>> new file mode 100755
>>> index 0000000000..f3b71e2859
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/274
>>> @@ -0,0 +1,131 @@
>>> +#!/usr/bin/env python
>>> +#
>>> +# Copyright (C) 2019 Red Hat, Inc.
>>> +#
>>> +# This program is free software; you can redistribute it and/or modify
>>> +# it under the terms of the GNU General Public License as published by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
>>> +#
>>> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
>>> +#
>>> +# Some tests for short backing files and short overlays
>>> +
>>> +import iotests
>>> +import os
>>> +
>>> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
>>> +iotests.verify_platform(['linux'])
>>> +
>>> +size_short =3D 1 * 1024 * 1024
>>> +size_long =3D 2 * 1024 * 1024
>>> +size_diff =3D size_long - size_short
>>> +
>>> +def create_chain():
>>> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
>>> +                         str(size_long))
>>> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, m=
id,
>>> +                         str(size_short))
>>> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, to=
p,
>>> +                         str(size_long))
>>> +
>>> +    iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)
>>> +
>>> +def create_vm():
>>> +    vm =3D iotests.VM()
>>> +    vm.add_blockdev('file,filename=3D%s,node-name=3Dbase-file' % (base=
))
>>> +    vm.add_blockdev('%s,file=3Dbase-file,node-name=3Dbase' % (iotests.=
imgfmt))
>>> +    vm.add_blockdev('file,filename=3D%s,node-name=3Dmid-file' % (mid))
>>> +    vm.add_blockdev('%s,file=3Dmid-file,node-name=3Dmid,backing=3Dbase=
' % (iotests.imgfmt))
>>> +    vm.add_drive(top, 'backing=3Dmid,node-name=3Dtop')
>>> +    return vm
>>> +
>>> +with iotests.FilePath('base') as base, \
>>> +     iotests.FilePath('mid') as mid, \
>>> +     iotests.FilePath('top') as top:
>>> +
>>> +    iotests.log('=3D=3D Commit tests =3D=3D')
>>> +
>>> +    create_chain()
>>> +
>>> +    iotests.log('=3D=3D=3D Check visible data =3D=3D=3D')
>>> +
>>> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, top)
>>> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), top)
>>> +
>>> +    iotests.log('=3D=3D=3D Checking allocation status =3D=3D=3D')
>>> +
>>> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
>>> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
>>> +                        base)
>>> +
>>> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
>>> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
>>> +                        mid)
>>> +
>>> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
>>> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
>>> +                        top)
>>> +
>>> +    iotests.log('=3D=3D=3D Checking map =3D=3D=3D')
>>> +
>>> +    iotests.qemu_img_log('map', '--output=3Djson', base)
>>> +    iotests.qemu_img_log('map', '--output=3Dhuman', base)
>>> +    iotests.qemu_img_log('map', '--output=3Djson', mid)
>>> +    iotests.qemu_img_log('map', '--output=3Dhuman', mid)
>>> +    iotests.qemu_img_log('map', '--output=3Djson', top)
>>> +    iotests.qemu_img_log('map', '--output=3Dhuman', top)
>>> +
>>> +    iotests.log('=3D=3D=3D Testing qemu-img commit (top -> mid) =3D=3D=
=3D')
>>> +
>>> +    iotests.qemu_img_log('commit', top)
>>> +    iotests.img_info_log(mid)
>>> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
>>> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), mid)
>>> +
>>> +    iotests.log('=3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D')
>>> +
>>> +    create_chain()
>>> +    with create_vm() as vm:
>>> +        vm.launch()
>>> +        vm.qmp_log('human-monitor-command', command_line=3D'commit dri=
ve0')
>>> +
>>> +    iotests.img_info_log(mid)
>>> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
>>> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), mid)
>>> +
>>> +    iotests.log('=3D=3D=3D Testing QMP active commit (top -> mid) =3D=
=3D=3D')
>>> +
>>> +    create_chain()
>>> +    with create_vm() as vm:
>>> +        vm.launch()
>>> +        vm.qmp_log('block-commit', device=3D'top', base_node=3D'mid',
>>> +                   job_id=3D'job0', auto_dismiss=3DFalse)
>>> +        vm.run_job('job0', wait=3D5)
>>> +
>>> +    iotests.img_info_log(mid)
>>> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
>>> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_di=
ff), mid)
>>> +
>>> +
>>> +    iotests.log('=3D=3D Resize tests =3D=3D')
>>> +
>>> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, '6G')
>>> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, t=
op, '1G')
>>> +    iotests.qemu_io_log('-c', 'write -P 1 3G 64k', base)
>>> +    iotests.qemu_io_log('-c', 'write -P 2 5G 64k', base)
>>> +
>>> +    # After this, 0 to 6 GB should be allocated/zeroed
>>> +    # 6 GB to 8 BG should be unallocated
>>
>> Hmm, the problem is that the following qemu-img map can't show it, as it=
 merges
>> 1G..6G and 6G..8G into one chunk..
>=20
> Hm, true, because it's more about the content of the blocks than about
> the allocation status. I'll add a qemu-io 'map' call, which display the
> actual allocation status:
>=20
> 1 GiB (0x40000000) bytes not allocated at offset 0 bytes (0x0)
> 5 GiB (0x140000000) bytes     allocated at offset 1 GiB (0x40000000)
> 2 GiB (0x80000000) bytes not allocated at offset 6 GiB (0x180000000)
>=20
>>> +    iotests.qemu_img_log('resize', '-f', iotests.imgfmt, top, '8G')
>>> +    iotests.qemu_io_log('-c', 'read -P 0 3G 64k', top)
>>> +    iotests.qemu_io_log('-c', 'read -P 0 5G 64k', top)
>>> +    iotests.qemu_img_log('map', '--output=3Djson', top)
>>> diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
>>> new file mode 100644
>>> index 0000000000..def0ac7d27
>>> --- /dev/null
>>> +++ b/tests/qemu-iotests/274.out
>>> @@ -0,0 +1,150 @@
>>> +=3D=3D Commit tests =3D=3D
>>> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_siz=
e=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> +
>>> +Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
>>> +
>>> +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=
=3DTEST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
>>> +
>>> +wrote 2097152/2097152 bytes at offset 0
>>> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +
>>> +=3D=3D=3D Check visible data =3D=3D=3D
>>> +read 1048576/1048576 bytes at offset 0
>>> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +
>>> +read 1048576/1048576 bytes at offset 1048576
>>> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>> +
>>> +=3D=3D=3D Checking allocation status =3D=3D=3D
>>> +1048576/1048576 bytes allocated at offset 0 bytes
>>> +1048576/1048576 bytes allocated at offset 1 MiB
>>> +
>>> +0/1048576 bytes allocated at offset 0 bytes
>>> +0/0 bytes allocated at offset 1 MiB
>>> +
>>> +0/1048576 bytes allocated at offset 0 bytes
>>> +0/1048576 bytes allocated at offset 1 MiB
>>> +
>>> +=3D=3D=3D Checking map =3D=3D=3D
>>> +[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": t=
rue, "offset": 327680}]
>>> +
>>> +Offset          Length          Mapped to       File
>>> +0               0x200000        0x50000         TEST_DIR/PID-base
>>> +
>>> +[{ "start": 0, "length": 1048576, "depth": 1, "zero": false, "data": t=
rue, "offset": 327680}]
>>> +
>>> +Offset          Length          Mapped to       File
>>> +0               0x100000        0x50000         TEST_DIR/PID-base
>>> +
>>> +[{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": t=
rue, "offset": 327680},
>>> +{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data=
": false}]
>>
>> I think depth of second chunk should be 1, not 0.. But this is for
>> another fixing series.
>=20
> The part from 1 GB to 6 GB should be 0 without any question, this is
> where we wrote zeros into the overlay.
>=20
> The part from 7 GB to 8 GB is a bit more open to interpretation because
> this is unallocated in the overlay and reads zeros because the backing
> file is shorter. I think 0 makes sense, but it's debatable.
>=20
> Kevin
>=20

Here I'm not about last test-case but about "depth" in second element of ma=
p, which covers [1M,2M) region.
Zeroes comes from second layer (after EOF), not from first. On first this a=
re is unallocated in all possible meanings.
Still, I doubt that "depth" in qemu-img map output is something well-docume=
nted, so it's not significant.

--=20
Best regards,
Vladimir


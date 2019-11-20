Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E25C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05F920692
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W7VKh9De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05F920692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSGO-0005FB-Gy
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXS6v-0002jO-JR
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXS6r-0006tw-B7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:41:41 -0500
Received: from mail-eopbgr140097.outbound.protection.outlook.com
 ([40.107.14.97]:43238 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXS6q-0006t9-Dg; Wed, 20 Nov 2019 10:41:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPMjakXzgKanfa62u8YnXZpTOSPeMaU8RioK1PKzXylqiyw5XgDKLlIIahMH4NaFoamQmfor2UB5gOAgDfFxuO75v+GwXeXC+h730cL4w3TZP/Lqg2zRyiMszZY+coQIvIVNnnf51nZqgnez/+vgmgREjl0GcKY/j+AHA3cBX+fVuSQhk9JerohKIIfDeM2TB1gLBqduVT9xxzIkkHYaK9cT13xyEtJoXEBUHXZTGdJQHm8lYXt26Odl/CSXifVfWUKkVJc/w8/YgxvtdZEjoDCUxk2Nu5vsdYjAJibzD2XAmL68JBCPHiqXz64hDaoENVJpQR3dcepREpW+ROrzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC2yi4l0RIp82sQKxyDujgz/01t3w6OBBSLSU/xBHzg=;
 b=TjvcmMoP6cLowPH74LlGS7iDv8p0w2iBm1RAWiXVTFlF6blSQmymd1CrbQAfnmI73MGcPGTSBKkTkn2zDbi2/q7JoPVsqVStbJ7hAUxF7me7NFGQ2DxVWVRJYoiGsrf1Z733eqOlyf0ZR1U2tkO0ko+QkBJ36JEf6FfWapKkUMUnAufonT/f4R20MQRHGE9lOdBMwmUNt0y1AuDmrF2Kd0nK2GbX5jLqHyOIo+D3mLACvtHLIUikm6QkHY6i3rlRAfa8INlQ4dUURtMF8HkZASQUvIqKvbsNKY5sHK62bB5nVXcVjEX+1OyZAyEjlPYh/4LKBI1/MGWLbfuC5yD1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC2yi4l0RIp82sQKxyDujgz/01t3w6OBBSLSU/xBHzg=;
 b=W7VKh9DerS4w+8gqmWieADpVxBVXUhgCz80i77m8fjEc/QmlWX+8PlCgkg/Ee9R0eKQWUPxoso1Hal1RDM2Fppa8cSkzaZPkopVa+JCDA4xNUEzAZd8PiqSh6y5/DI/cS/yYCHd7sAJj+8w+EtYRcOiHSvCvkOPGSuuC8qWTtho=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5238.eurprd08.prod.outlook.com (10.255.121.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Wed, 20 Nov 2019 15:41:33 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 15:41:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn6tcQgTd8h0BOUCr2B20a33R1qeUMp0A
Date: Wed, 20 Nov 2019 15:41:33 +0000
Message-ID: <b5f3fb13-7467-d87e-07db-45bd014c6464@virtuozzo.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
 <20191120140319.1505-7-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-7-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120184130470
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b18490-e860-498a-cc13-08d76dd01e80
x-ms-traffictypediagnostic: AM6PR08MB5238:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB52384B68809CB7838CF9A0EEC14F0@AM6PR08MB5238.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:359;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(396003)(366004)(136003)(376002)(52314003)(189003)(199004)(54906003)(30864003)(316002)(110136005)(99286004)(6506007)(386003)(31686004)(486006)(36756003)(102836004)(52116002)(76176011)(6306002)(6436002)(2501003)(14444005)(256004)(4326008)(71190400001)(6486002)(6246003)(25786009)(6512007)(478600001)(8676002)(81166006)(81156014)(8936002)(2906002)(71200400001)(14454004)(229853002)(305945005)(7736002)(66476007)(66446008)(66946007)(64756008)(66556008)(476003)(2616005)(11346002)(446003)(31696002)(26005)(186003)(86362001)(66066001)(5660300002)(3846002)(6116002)(21314003)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5238;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzekUew3CHNnGyqYqc4zuuh08X7CsRBnxDH8L8+SYyQf/9jFauveoaP3rWTv2NTdz0DV25Wq61PngDaunz9HDYlIn9yg/3xIMIjWXhNFyTEbd3C6nNvxCoGRyPFyzRK3z5qbNBQmwcieaFQ41ww/AiZVJuJgaK1/j4JVVSaZoUc7FVmd9LnNdw38PEA0Zb1DyivOmXkxw3XRu3UYdvqaewiKVml5ksOQSDD4oL7NqN7U9DMXZGiF+2e8nRI/HKb83fPLnFmnHZq4IwLvNgJXjqDEcLvKziehggJGTl/P2BcbhSu+lOuSHqsptWCxrBPHe4jRYEekz8/LQZvw40XO4SMd9OnhbhdPU3kPW4eo4ZypyxuXUldN2KNw1j3dwC/U4MRZrpnTMkUjYl2aTHSEkfcTi1GfV+7u6zxp4E4bTWSwWuso4EfLbJIGj6v6ty+mLiZPeBsUQqhPdo1qWADPNHJpsU7UqnmXlIzMDPb9Ulw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9F2BD7E7DCB58741B891CF1B1A2E8DB7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b18490-e860-498a-cc13-08d76dd01e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 15:41:33.0196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/WE7tolFmw7ZvdzNFrcV8+CETAKb0RF6IHEYujVldeX7GDPsL9gChRxf9G64mbZFI2X8U8BCcJTbAp0FjLAYslGIx1mfiQzu/bkvFnOCe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5238
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.97
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 17:03, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
>   tests/qemu-iotests/274.out    | 150 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/group      |   1 +
>   tests/qemu-iotests/iotests.py |   2 +-
>   4 files changed, 283 insertions(+), 1 deletion(-)
>   create mode 100755 tests/qemu-iotests/274
>   create mode 100644 tests/qemu-iotests/274.out
>=20
> diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
> new file mode 100755
> index 0000000000..f3b71e2859
> --- /dev/null
> +++ b/tests/qemu-iotests/274
> @@ -0,0 +1,131 @@
> +#!/usr/bin/env python
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
> +#
> +# Some tests for short backing files and short overlays
> +
> +import iotests
> +import os
> +
> +iotests.verify_image_format(supported_fmts=3D['qcow2'])
> +iotests.verify_platform(['linux'])
> +
> +size_short =3D 1 * 1024 * 1024
> +size_long =3D 2 * 1024 * 1024
> +size_diff =3D size_long - size_short
> +
> +def create_chain():
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
> +                         str(size_long))
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, mid=
,
> +                         str(size_short))
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, top,
> +                         str(size_long))
> +
> +    iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)
> +
> +def create_vm():
> +    vm =3D iotests.VM()
> +    vm.add_blockdev('file,filename=3D%s,node-name=3Dbase-file' % (base))
> +    vm.add_blockdev('%s,file=3Dbase-file,node-name=3Dbase' % (iotests.im=
gfmt))
> +    vm.add_blockdev('file,filename=3D%s,node-name=3Dmid-file' % (mid))
> +    vm.add_blockdev('%s,file=3Dmid-file,node-name=3Dmid,backing=3Dbase' =
% (iotests.imgfmt))
> +    vm.add_drive(top, 'backing=3Dmid,node-name=3Dtop')
> +    return vm
> +
> +with iotests.FilePath('base') as base, \
> +     iotests.FilePath('mid') as mid, \
> +     iotests.FilePath('top') as top:
> +
> +    iotests.log('=3D=3D Commit tests =3D=3D')
> +
> +    create_chain()
> +
> +    iotests.log('=3D=3D=3D Check visible data =3D=3D=3D')
> +
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, top)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff=
), top)
> +
> +    iotests.log('=3D=3D=3D Checking allocation status =3D=3D=3D')
> +
> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> +                        base)
> +
> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> +                        mid)
> +
> +    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
> +                        '-c', 'alloc %d %d' % (size_short, size_diff),
> +                        top)
> +
> +    iotests.log('=3D=3D=3D Checking map =3D=3D=3D')
> +
> +    iotests.qemu_img_log('map', '--output=3Djson', base)
> +    iotests.qemu_img_log('map', '--output=3Dhuman', base)
> +    iotests.qemu_img_log('map', '--output=3Djson', mid)
> +    iotests.qemu_img_log('map', '--output=3Dhuman', mid)
> +    iotests.qemu_img_log('map', '--output=3Djson', top)
> +    iotests.qemu_img_log('map', '--output=3Dhuman', top)
> +
> +    iotests.log('=3D=3D=3D Testing qemu-img commit (top -> mid) =3D=3D=
=3D')
> +
> +    iotests.qemu_img_log('commit', top)
> +    iotests.img_info_log(mid)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff=
), mid)
> +
> +    iotests.log('=3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D')
> +
> +    create_chain()
> +    with create_vm() as vm:
> +        vm.launch()
> +        vm.qmp_log('human-monitor-command', command_line=3D'commit drive=
0')
> +
> +    iotests.img_info_log(mid)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff=
), mid)
> +
> +    iotests.log('=3D=3D=3D Testing QMP active commit (top -> mid) =3D=3D=
=3D')
> +
> +    create_chain()
> +    with create_vm() as vm:
> +        vm.launch()
> +        vm.qmp_log('block-commit', device=3D'top', base_node=3D'mid',
> +                   job_id=3D'job0', auto_dismiss=3DFalse)
> +        vm.run_job('job0', wait=3D5)
> +
> +    iotests.img_info_log(mid)
> +    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
> +    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff=
), mid)
> +
> +
> +    iotests.log('=3D=3D Resize tests =3D=3D')
> +
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, '6G')
> +    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, top=
, '1G')
> +    iotests.qemu_io_log('-c', 'write -P 1 3G 64k', base)
> +    iotests.qemu_io_log('-c', 'write -P 2 5G 64k', base)
> +
> +    # After this, 0 to 6 GB should be allocated/zeroed
> +    # 6 GB to 8 BG should be unallocated

Hmm, the problem is that the following qemu-img map can't show it, as it me=
rges
1G..6G and 6G..8G into one chunk..

> +    iotests.qemu_img_log('resize', '-f', iotests.imgfmt, top, '8G')
> +    iotests.qemu_io_log('-c', 'read -P 0 3G 64k', top)
> +    iotests.qemu_io_log('-c', 'read -P 0 5G 64k', top)
> +    iotests.qemu_img_log('map', '--output=3Djson', top)
> diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
> new file mode 100644
> index 0000000000..def0ac7d27
> --- /dev/null
> +++ b/tests/qemu-iotests/274.out
> @@ -0,0 +1,150 @@
> +=3D=3D Commit tests =3D=3D
> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> +
> +Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
> +
> +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=
=3DTEST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
> +
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D=3D Check visible data =3D=3D=3D
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D=3D Checking allocation status =3D=3D=3D
> +1048576/1048576 bytes allocated at offset 0 bytes
> +1048576/1048576 bytes allocated at offset 1 MiB
> +
> +0/1048576 bytes allocated at offset 0 bytes
> +0/0 bytes allocated at offset 1 MiB
> +
> +0/1048576 bytes allocated at offset 0 bytes
> +0/1048576 bytes allocated at offset 1 MiB
> +
> +=3D=3D=3D Checking map =3D=3D=3D
> +[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": tru=
e, "offset": 327680}]
> +
> +Offset          Length          Mapped to       File
> +0               0x200000        0x50000         TEST_DIR/PID-base
> +
> +[{ "start": 0, "length": 1048576, "depth": 1, "zero": false, "data": tru=
e, "offset": 327680}]
> +
> +Offset          Length          Mapped to       File
> +0               0x100000        0x50000         TEST_DIR/PID-base
> +
> +[{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": tru=
e, "offset": 327680},
> +{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data":=
 false}]

I think depth of second chunk should be 1, not 0.. But this is for another =
fixing series.

> +
> +Offset          Length          Mapped to       File
> +0               0x100000        0x50000         TEST_DIR/PID-base
> +
> +=3D=3D=3D Testing qemu-img commit (top -> mid) =3D=3D=3D
> +Image committed.
> +
> +image: TEST_IMG
> +file format: IMGFMT
> +virtual size: 2 MiB (2097152 bytes)
> +cluster_size: 65536
> +backing file: TEST_DIR/PID-base
> +Format specific information:
> +    compat: 1.1
> +    lazy refcounts: false
> +    refcount bits: 16
> +    corrupt: false
> +
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D
> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> +
> +Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
> +
> +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=
=3DTEST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
> +
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +{"execute": "human-monitor-command", "arguments": {"command-line": "comm=
it drive0"}}
> +{"return": ""}
> +image: TEST_IMG
> +file format: IMGFMT
> +virtual size: 2 MiB (2097152 bytes)
> +cluster_size: 65536
> +backing file: TEST_DIR/PID-base
> +Format specific information:
> +    compat: 1.1
> +    lazy refcounts: false
> +    refcount bits: 16
> +    corrupt: false
> +
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D=3D Testing QMP active commit (top -> mid) =3D=3D=3D
> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> +
> +Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
> +
> +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=
=3DTEST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=
=3D16
> +
> +wrote 2097152/2097152 bytes at offset 0
> +2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +{"execute": "block-commit", "arguments": {"auto-dismiss": false, "base-n=
ode": "mid", "device": "top", "job-id": "job0"}}
> +{"return": {}}
> +{"execute": "job-complete", "arguments": {"id": "job0"}}
> +{"return": {}}
> +{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "=
commit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS"=
, "seconds": "SECS"}}
> +{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "=
commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "US=
ECS", "seconds": "SECS"}}
> +{"execute": "job-dismiss", "arguments": {"id": "job0"}}
> +{"return": {}}
> +image: TEST_IMG
> +file format: IMGFMT
> +virtual size: 2 MiB (2097152 bytes)
> +cluster_size: 65536
> +backing file: TEST_DIR/PID-base
> +Format specific information:
> +    compat: 1.1
> +    lazy refcounts: false
> +    refcount bits: 16
> +    corrupt: false
> +
> +read 1048576/1048576 bytes at offset 0
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +read 1048576/1048576 bytes at offset 1048576
> +1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D Resize tests =3D=3D
> +Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D6442450944 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> +
> +Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D1073741824 backing_fil=
e=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bi=
ts=3D16
> +
> +wrote 65536/65536 bytes at offset 3221225472
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +wrote 65536/65536 bytes at offset 5368709120
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +Image resized.
> +
> +read 65536/65536 bytes at offset 3221225472
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +read 65536/65536 bytes at offset 5368709120
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +[{ "start": 0, "length": 1073741824, "depth": 1, "zero": true, "data": f=
alse},
> +{ "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "=
data": false}]
> +
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index c56bb69031..329c9e4d37 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -285,3 +285,4 @@
>   270 rw backing quick
>   272 rw
>   273 backing quick
> +274 rw backing quick
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index c4063ef6bb..5fd6d820b1 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -144,7 +144,7 @@ def img_info_log(filename, filter_path=3DNone, imgopt=
s=3DFalse, extra_args=3D[]):
>       output =3D qemu_img_pipe(*args)
>       if not filter_path:
>           filter_path =3D filename
> -    log(filter_img_info(output, filter_path))
> +    log(filter_img_info(output, filter_path), filters=3D[filter_testfile=
s])
>  =20
>   def qemu_io(*args):
>       '''Run qemu-io and return the stdout data'''
>=20

anyway,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir


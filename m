Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ADC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E334D2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gnmt01tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E334D2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7g2-00069a-6f
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48314)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hs7fP-0005HR-3z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hs7fN-0004Ug-Nc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:34:27 -0400
Received: from mail-he1eur04on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::70b]:27822
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hs7fK-0004PC-N7; Mon, 29 Jul 2019 11:34:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHywSsme3fvZ3x0qlBb8l1DSX+TRdDfYI/suqz66nJANZ7LzZoznD7ykO7TVtsV0AqkCVhp2T3W6f/Pklg7Ohzob4agypEO1L/Yy8NYNZoSTNxiXiXXmjueHxMZiCuf1tF+7qQChA6zy6BoJf6s9wgAmws9mofXx03qhU+ezzKWGA2kpXhOunh7KlkB5dWQ8RDqo7OBDLxVVoXJwqt/IG8i+NVCCXJNH041rqAcTv/3XRtYVzzclBogPKTbPiz+jpIZzD6pdn9bHvFZhUO3pDrGqFweqtu6Y/94e3nPWfbgarEUYyA1wMAgCw2vwkH/DNhW7z9IMIs2+DyW0cpgIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ0Awt1/RGJiNacL1qNProap4eoRA2u56U8fvniKscI=;
 b=Y57J72Dg1O79B56Xqj82+rD8oGea+ZqxYks/pLR5tvN+S55tsd/TEWjIEtpi/37GLB6WvMCTHjTZz+nKYJtS57q5Ovxe6SGNxoayaA4Rb5L/TMQetlarJz+ZLcRn0R0CyVjImIEuluqCGaKcojR2dPH31+DwALqTYCDEJAweh2E6yr96H1mtr+rsMX0Decn0kB+wUtbSMAoeQgb/57Yh5znamWyNwO5dNn1GwIQTVsgkgtaItt/FuPtHs/ESXBTW0GnK4NLt5tJ6ZdWavD8zZ4dHC/HjHphBEYx5Ex0Q5DyeZNYCG8ppZLCBfhjysmHYGevky2JdFAy/yRFvM1C+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQ0Awt1/RGJiNacL1qNProap4eoRA2u56U8fvniKscI=;
 b=gnmt01tJeCVhO0Wqk/luw5zKuOJLaYH5cVjPTjyMDJBC3o+ZnFE/NSNCEcmVspQtZOqcEpkVDCQveA/Qziv7mnrK1Y+M3yzg02jSvgqDCNzNXadF4BvbnOOpPkmsPUQEItFlIfXx+GOjXPt6bNcdFzXvrw4oej+cLFyuO/BTQq4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4186.eurprd08.prod.outlook.com (20.179.12.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Mon, 29 Jul 2019 15:34:18 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Mon, 29 Jul 2019
 15:34:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Thread-Topic: [PATCH v2 00/12] block: qiov_offset parameter for io
Thread-Index: AQHVGvDDN3N+yvQgRE6fCgP4uttDuabiDWkAgAAC3YA=
Date: Mon, 29 Jul 2019 15:34:17 +0000
Message-ID: <c2c182d8-eddb-91d5-48a4-73631e7868ab@virtuozzo.com>
References: <20190604161514.262241-1-vsementsov@virtuozzo.com>
 <20190729152400.GB21033@stefanha-x1.localdomain>
In-Reply-To: <20190729152400.GB21033@stefanha-x1.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190729183415472
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57e22947-911a-4526-f4dc-08d7143a3811
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4186; 
x-ms-traffictypediagnostic: DB8PR08MB4186:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB41863E3E72340A17CD4B5A38C1DD0@DB8PR08MB4186.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(346002)(376002)(366004)(136003)(53754006)(199004)(189003)(6916009)(36756003)(229853002)(5660300002)(102836004)(86362001)(99286004)(316002)(476003)(11346002)(6436002)(71200400001)(71190400001)(446003)(486006)(76176011)(66446008)(2616005)(25786009)(54906003)(68736007)(52116002)(186003)(26005)(14454004)(31696002)(6486002)(66946007)(966005)(66476007)(66556008)(64756008)(305945005)(7736002)(478600001)(8676002)(66066001)(3846002)(6116002)(8936002)(81166006)(6512007)(81156014)(53936002)(6306002)(256004)(4326008)(386003)(6506007)(107886003)(6246003)(31686004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4186;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dt9PcpDTp5pW/KcoWYWC6LYTNOtZiZaR6l/7adNTC4LhU7ejRQ/MOjZA8nSYLOUM8BXP96G/+XNDIWLbjwMLvF1R2c5sYEiDpaHfVOFEEysaD688G2Gkn4/nwwserZvR/dLj8yXpkIWIPBuu6Qgd8IbYti+B1IiWG13DgaonBpkItWvmc504bS5y61HWQDnayTfoedoBzcKrPc3997qhLpzBBIw/bBbzVx8FwhCA+AF0QswnNZ6jjUrJ6+lVtiz+PFdnUHcA790F+ww0bkDEFG/j2zItoIvv7yUiJ2HRbWLEpk9JEooEJvutZUw2u/OlAy7mFxhtqq8CpaFQvoCbGMkKw5S8MlxRc/nnsL42xKFzNKLK9RSvJ9zSVJArn3GIpK9ML7mYPYWSJV6JkQnFufh5WC7YKrbidOX0WbmUPTk=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <A8BE105F3676AB41AFA1F8ACE49627E8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e22947-911a-4526-f4dc-08d7143a3811
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 15:34:17.8925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4186
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::70b
Subject: Re: [Qemu-devel] [PATCH v2 00/12] block: qiov_offset parameter for
 io
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.07.2019 18:24, Stefan Hajnoczi wrote:
> On Tue, Jun 04, 2019 at 07:15:02PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>
>> Here is new parameter qiov_offset for io path, to avoid
>> a lot of places with same pattern of creating local_qiov or hd_qiov
>> variables.
>>
>> These series also includes my
>> "[Qemu-devel] [PATCH 0/2] block/io: refactor padding"
>> with some changes [described in 01 and 03 emails]
>>
>> Vladimir Sementsov-Ogievskiy (12):
>>    util/iov: introduce qemu_iovec_init_extended
>>    util/iov: improve qemu_iovec_is_zero
>>    block/io: refactor padding
>>    block: define .*_part io handlers in BlockDriver
>>    block/io: bdrv_co_do_copy_on_readv: use and support qiov_offset
>>    block/io: bdrv_co_do_copy_on_readv: lazy allocation
>>    block/io: bdrv_aligned_preadv: use and support qiov_offset
>>    block/io: bdrv_aligned_pwritev: use and support qiov_offset
>>    block/io: introduce bdrv_co_p{read,write}v_part
>>    block/qcow2: refactor qcow2_co_preadv to use buffer-based io
>>    block/qcow2: implement .bdrv_co_preadv_part
>>    block/qcow2: implement .bdrv_co_pwritev(_compressed)_part
>>
>>   block/qcow2.h             |   1 +
>>   include/block/block_int.h |  21 ++
>>   include/qemu/iov.h        |  10 +-
>>   block/backup.c            |   2 +-
>>   block/io.c                | 532 ++++++++++++++++++++++----------------
>>   block/qcow2-cluster.c     |  14 +-
>>   block/qcow2.c             | 131 +++++-----
>>   qemu-img.c                |   4 +-
>>   util/iov.c                | 153 +++++++++--
>>   9 files changed, 559 insertions(+), 309 deletions(-)
>>
>> --=20
>> 2.18.0
>=20
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
>=20
> Stefan
>=20

Thanks! Than I can base my further work on parallelizing qcow2
read/write loops  on it, great! (long ago v1 was
[PATCH 0/7] qcow2: async handling of fragmented io)

--=20
Best regards,
Vladimir


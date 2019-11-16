Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1960C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 09:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C31F20723
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 09:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dtt29ZM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C31F20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVuOK-0006WC-Ja
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 04:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVuNK-0005rY-5O
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 04:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVuNI-0007Lf-QD
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 04:28:13 -0500
Received: from mail-eopbgr30119.outbound.protection.outlook.com
 ([40.107.3.119]:15586 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVuNI-0007IR-65; Sat, 16 Nov 2019 04:28:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRRMt9FWTiJh6Gfz9/6Y1fqS6jOclNDakba0KwwZJ3FXWfwzm7mMUedRJeMR5V4olCAQzTXf12650wRYGAD2ITlwGh7TOoxpvStY9FkXouuRfADLdqa7gsrLwUYTmydAuN1pppsNmbkxYH5vxaJkQqFFYBABV69/NNcE6+894aUZvLbD518EgGeM8ZzZhnOpge401LKwlC5UQtM0YDbIpFTNdGyP3JFZoHx6udJemvSayodAABC32SchUa9Yd44vySL2LSz2Yqtm+XPiJkKptrdrUheoRkkA53u232RM9j6g/TdJmRF4mUzgVPYQuiTYec65XVHYK4J84sKuaF3gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhSfy4p+zk5jgZK5AdRY+QWvKmJ1nTrQ+xcO8oGGpqU=;
 b=Kei7w2r0U12JDbNGPGerP4cHqrJakaswRWcLYJDieNNgDes8zMY3T7CVhY/zd8nzz4+HDYgymwnK67bhJCFfzGQGV5sUTAQr2y64qKbQL2shAX/KQaGJZrBcMe72taG8fC9B+6u1OyxKM+BLVFniOzQLziADHou8DEBaW8BdJ6vMuPU6z70VEJCvo2qF7D1Q92LDR7o9RZ3ytDDSUqmqvcfq9tpzoXUSfHzv95tnNDTfauYkY0igwmozH00InXqe69dAa/hfnjwyuARw7G9p1OSBLWQgv+EEdVoClK08G2wq7SzDa0Qi3B6gvDqPkBX8lxd/TNKGLy2fcqw5/iLZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhSfy4p+zk5jgZK5AdRY+QWvKmJ1nTrQ+xcO8oGGpqU=;
 b=dtt29ZM7t7xFJhg447m//u8KyUzJikq1TwlkPqmoqz+334G7MOX9/sXjfqS0mI9Jf5OIu0TqgE0PBFaVUvWe8FHjYpkpe2g512lLcwPnVfCUoneZP9q6yzQR9CNctpyFjYGbsy0eHo9AHv8FQ7GaoONTbvcfdrlF5c7+BZTHl5M=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4707.eurprd08.prod.outlook.com (10.255.96.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sat, 16 Nov 2019 09:28:09 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Sat, 16 Nov 2019
 09:28:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [RFC 21/24] backup: move to block-copy
Thread-Topic: [RFC 21/24] backup: move to block-copy
Thread-Index: AQHVm78jNFFXRSugOk65/ATbvklAA6eMhR2AgAEDsgA=
Date: Sat, 16 Nov 2019 09:28:08 +0000
Message-ID: <1c315773-a775-4adf-d70b-81908f78b772@virtuozzo.com>
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
 <20191115141444.24155-22-vsementsov@virtuozzo.com>
 <66b4478f-3d51-9888-3a88-78d4ae7dcd48@redhat.com>
In-Reply-To: <66b4478f-3d51-9888-3a88-78d4ae7dcd48@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0053.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::42) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191116122806493
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 383b94f2-2710-485f-3989-08d76a774ae6
x-ms-traffictypediagnostic: AM6PR08MB4707:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4707B4377C5A70BFD63F540BC1730@AM6PR08MB4707.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(346002)(39840400004)(376002)(189003)(199004)(53546011)(386003)(6506007)(52116002)(102836004)(76176011)(6436002)(2906002)(6116002)(3846002)(64756008)(66476007)(66556008)(66946007)(7416002)(446003)(99286004)(476003)(486006)(2616005)(316002)(11346002)(110136005)(2501003)(31696002)(36756003)(26005)(31686004)(81166006)(8676002)(66446008)(81156014)(8936002)(86362001)(66066001)(5660300002)(71200400001)(71190400001)(229853002)(256004)(6512007)(14454004)(107886003)(6246003)(14444005)(478600001)(25786009)(7736002)(4326008)(186003)(305945005)(6486002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4707;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tpi6R+L6P6pscs88v3/pB0eLDREwgHS2H9Ud/rNeNfkrmLhz7qg+J+9w1S9miCsrCd2X3NSn8SbldVL+IQiKn1klAUt/hZCCqpqSWwPDpIVr/8JLk7EhPMgPvHu8/WNF66+W59cBZxC2Hb7zlHSE+2rAl4syQhRcGUWYXfhJsgbjISSF5hjFAlrn0rPlOcBpALgLtjiGKduuM5+Jmxw0En/vGn8kczJrLeiC3npDw5krY+ubxkx6D2+5Fhpku2/zEj18sss3zsIUwl17ohe/TkBqOumdEUPZJ/QPCpfqzceMWE4UI8BBWCsSz5r46xtsrn0AcAnLCjJKgjX+oXfr9k4uTzlu66+cGiVmltCiIyDrW79wpPyqHjWgdcyQzPPLb/KyVF1s8Cbu2hRBOpK7+Hro9Wo81NK6QkP3yuhevIuDSDhfTiiKBQk7qRTwjTIP
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <666C43B5729DAE448DD30FD4C0BBCC6A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383b94f2-2710-485f-3989-08d76a774ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 09:28:08.8307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVtxDXFO9esy25eqavaA3I+ttdJWz8j5OObNpa2x0JSaoqq1YmPDrfEtHDkU3HRJx2g/QYWBWPF6y2Rp8yJPd3gtpZhdPHp1R+YhV7DOnMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4707
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.119
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
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "crosa@redhat.com" <crosa@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.11.2019 20:58, Eric Blake wrote:
> On 11/15/19 8:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> This brings async request handling and block-status driven chunk sizes
>> to backup out of the box, which improves backup performance.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>=20
>> +++ b/qapi/block-core.json
>> @@ -1455,6 +1455,12 @@
>> =A0 #=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 above nod=
e specified by @drive. If this option is not given,
>> =A0 #=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 a node na=
me is autogenerated. (Since: 4.2)
>> =A0 #
>> +# @x-max-workers: maximum of parallel requests for static data backup. =
This
>> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 doesn't influence cop=
y-before-write operations. (Since: 4.3)
>> +#
>> +# @x-max-chunk: maximum chunk length for static data backup. This doesn=
't
>> +#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 influence copy-before-write=
 operations. (Since: 4.3)
>=20
> The next release is 5.0, not 4.3.
>=20
> Is there a reason to keep these experimental for a while?=A0 For example,=
 are there potential changes to the interface that might affect how it gets=
 used?=A0 Or should we drop the x- prefix and add this outright in 5.0?
>=20

Hmm, I added these options to satisfy some very conservative iotests. Still=
, they may be meaningful for user too.

The only real doubt is that actually they are options of block-copy, not ba=
ckup job. And to not finish up with adding such
parameters to each block-job, it may be better to combine them into a struc=
ture.. Or may be not.

--=20
Best regards,
Vladimir


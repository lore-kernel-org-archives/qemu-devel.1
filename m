Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1CC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7735220637
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SUVB5BE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7735220637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2Ee-0001Tq-HW
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iX2DW-0000JG-5H
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iX2DQ-0000M4-Kl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:02:45 -0500
Received: from mail-eopbgr130092.outbound.protection.outlook.com
 ([40.107.13.92]:41351 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iX2DP-0000Ed-Q7; Tue, 19 Nov 2019 07:02:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si1jhpwK0QrUaWEAdR/v86VURRrMn3p+gDOlTBqS1+t21HWo9w2ODcZfWtQHQdXemXY/AYUbhMyh6BEj0bzC0JdhxUYnA+RfL24rGJVyiv9eDxCBVWoF0CmCD3I/gROrdVIzLfWPKkJMbrUMY1HT78itnfeJ1RicUALmjusAwexd9tTHwvCgScqoROHTH4Az/VwvbJiHZh47JKS/xf5tUOjIk16RvUc/17aEmHeWKzPodos7llUYuVuRXEtmwJwsz8A26k+5HiDfH2VSzvKjvgW36zWljnbGwrK0w9Wg79MJHw1Q5xCWxBUVS4BCJawxiXVO53FXNIXO75XRh+SdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0g+iDf1ovlXoMsXGvbNLo9jD/H5v1L9qEMDPprjTgk=;
 b=i8GhrmGKapZYWz/mQ9Oki10MiOEV6RsBaSFueHTQo9BZU3WS7hZbVWKjcpRN/g8ARsW7DMsQSwUgyqtCxUWwjhS9mNqNbqHevAZd2l3+3Kt+jzGewkDtrUT8Bw6+/zcHylZmgHKDifA/5xKp9DKO3vmFcB1ND8t6kd/3TvLMs8RXKPd7RJ1ci9UaJ7bWvSH23C27mcfNPR/iXyg1R3A48lD91r65xk43VUZvYt7di/2YQzIS9PWU8dKyaA5dhn8F5fFX0tnetHS9oJQZb9lbzycYfo9UKa4ua5mGMAcjIHfOjpMKJ88PjuvHBj+xt4k7QFKe0bm7/zEfdMbDTtwAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0g+iDf1ovlXoMsXGvbNLo9jD/H5v1L9qEMDPprjTgk=;
 b=SUVB5BE/ZUgl0fsneph1NBHXXax57jkc/rsl3m4/ogK5NVpmbvCTs1WItyYhCqjY+tfxLRe+b0hlEmBPJlRXIcbmMIO/A9Rg3t+Dorx+n0no+WW35D914EZdpBUZ6OfvL565X95PH0/29qKBXwS3BrFbCfXTjXkRkyTzqLEBqt8=
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com (52.135.131.139) by
 DB7PR08MB3226.eurprd08.prod.outlook.com (52.135.128.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 12:02:33 +0000
Received: from DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e]) by DB7PR08MB3052.eurprd08.prod.outlook.com
 ([fe80::b0a9:80ac:af62:a71e%6]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 12:02:33 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0GAG/b2t//Euzgq5az2jncKeSTT2AgAAb/IA=
Date: Tue, 19 Nov 2019 12:02:33 +0000
Message-ID: <6b0811ec-822e-1c4a-1512-d6f3945645d2@openvz.org>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
In-Reply-To: <09d0bab1-ed7d-4fd7-555d-93075f10d497@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::19) To DB7PR08MB3052.eurprd08.prod.outlook.com
 (2603:10a6:5:28::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07a950a0-d01d-414e-84bb-08d76ce85c0c
x-ms-traffictypediagnostic: DB7PR08MB3226:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR08MB32263D57CC6350A942ED4374B64C0@DB7PR08MB3226.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39840400004)(366004)(396003)(346002)(189003)(199004)(53754006)(52116002)(4326008)(31686004)(486006)(76176011)(36756003)(11346002)(66476007)(66556008)(64756008)(66446008)(2616005)(305945005)(476003)(446003)(478600001)(66946007)(186003)(6116002)(256004)(14444005)(25786009)(3846002)(42882007)(102836004)(2501003)(386003)(6506007)(53546011)(81156014)(81166006)(8676002)(8936002)(26005)(66066001)(71190400001)(71200400001)(2906002)(316002)(31696002)(6436002)(110136005)(6512007)(6246003)(14454004)(99286004)(229853002)(54906003)(7736002)(6486002)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3226;
 H:DB7PR08MB3052.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2m5fJVlb4DKyA2BZ2xYlWmRHDSOqe0SFkRd/ZTyynZxBJBfPG4XjuntZQjN2EFANwyPNo5ld6JhbVjY2XZmUxEF+LNZzN7TVTZBMiT450oKT3bFOV182k0ma9PSI9eGTMaQRWsIxruzJy+P22YfZV8z+r21ZoHUwGgPQjUSlcHorbZWXv5rff2ajyQ5hC8qEaYMOtlLwMQJsG0iTHzFIYfKYVv0rDnqW48M4ds0WH0DVzUjQQyuarzCSCHOLTaI11NFzmIiVNCLgG2sx+ngcoUVWGp/iDIbsDYigOi3Us5erbHr8L8sax2Iz+hr8nAiVLrfLFiuS7sSmP+Pp3dC5zJ7t6mlZVy5kECuHQHbZF4UGhh+pjtQM/AllW5+YncZja+FjKHPaPox8+Y85/dneID+kAXQu2TmzhuVbhGi7xW3aKXpXFhghivfI20/+cIqA
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0C0D7113AD0F4445894D326E369B23AA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a950a0-d01d-414e-84bb-08d76ce85c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 12:02:33.1329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6f+Nv/K0TRwNqz6QwGTNlGSUqVQya0xa+2e71G6ulQ3kg9OA1hwLf+woGDv1qTYj5isQ8bh7YkXPAXDIXt+aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3226
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.92
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 1:22 PM, Max Reitz wrote:
> On 16.11.19 17:34, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> I wanted to understand, what is the real difference between bdrv_block_s=
tatus_above
>> and bdrv_is_allocated_above, IMHO bdrv_is_allocated_above should work th=
rough
>> bdrv_block_status_above..
>>
>> And I found the problem: bdrv_is_allocated_above considers space after E=
OF as
>> UNALLOCATED for intermediate nodes..
>>
>> UNALLOCATED is not about allocation at fs level, but about should we go =
to backing or
>> not.. And it seems incorrect for me, as in case of short backing file, w=
e'll read
>> zeroes after EOF, instead of going further by backing chain.
> Should we, though?  It absolutely makes sense to me to consider post-EOF
> space as unallocated because, well, it is as unallocated as it gets.
>
> So from my POV it would make more sense to fall back to the backing file
> for post-EOF reads.
>
> OTOH, I don=92t know whether changing that behavior would qualify as a
> possible security issue now, because maybe someone has sensitive
> information in the tail of some disk and then truncated the overlay so
> as to hide it?  But honestly, that seems ridiculous and I can=92t imagine
> people to do that.  (It would work only for the tail, and why not just
> write zeroes there, which works everywhere?)  So in practice I don=92t
> believe that to be a problem.
>
> Max

That seems to be wrong from my POW. Once we get block device truncated,
it exposed that tail to the guest with all zeroes.

Let us assume that we have virtual disk of length L. We create new top
delta of
length X (less then L) and new top delta after with length Y (more than L),
like the following:

[.........................] Y
[........] X
[...................] L

Once the guest creates FS=A0 on state Y it relies on the fact that data fro=
m X
to Y is all zeroes.

Any operations with backing chain must keep guest content to be tha same,
i.e. if we commit from Y to L, virtual disk content should be preserved,
i.e.
read as all zero even if there is some data in L from X to L.

If we commit from X to Y, the range from X to L should remain all zeroes.

This is especially valid for backups, which can not be changed and are
validated by the software from time to time.

Does this makes sense?

Den


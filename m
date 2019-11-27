Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86515C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50364207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 20:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JfE2O0DI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50364207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia3cW-0008Fc-EP
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 15:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia3bJ-0007g1-7f
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia3bH-0003WI-OR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 15:07:48 -0500
Received: from mail-eopbgr00128.outbound.protection.outlook.com
 ([40.107.0.128]:52665 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia3bG-0003RW-VM; Wed, 27 Nov 2019 15:07:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2EKnUN8Oo3Ssafx5zCmSfl3DJ7Xc6VshT2JYXsDRwBFf3yG/klfaUbcNQburZlQ/6GOdS622Fj2atL9DCHXXH06Gy1Aq5l232WyxAvQZgxjf6eEk9CecOKIHGzV1kydlG75i8L0LrBvWBm1sltEtkneRy0k98u+2Wpj+Y6nqrpl+LhQPWp4gyeaE6wdgdhISpNWyG26IY776PVqMfh6V1mfNhurd8CP3A3/dhLz6Iw8QqoVtFZnheKHpa5JgbfkmblanBnl9cJPDUHbs+KsbOWxBwrNg67ZqGRtDFVoTueZ1QI3v32+gpHNGOncjwoWorTWmBvcv76nfHg7vp2grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIrmgShhCBvghWeSXU0m5oZqpGLjtXW5qIhm9QxcXYI=;
 b=R/mVMhNg1pPnJe3wnN1Z9WTKQjzVLEhitjZuOBAU9xai/CxlJuCAOlwhNLMxKZxjBy41NvTqjVvnOK1BPQ5BQiG/UjcI659wpZVHWpmK+N6QvLqgn3f+YuWKXSYFj7zCAAdylZEfPi4nEQRzc5k/DFdgw0moCssOUPnqSOQHIo2qLH5beNTxJ2zC46ke/Mvr+S798v5SwLM8tZDnMg0gasWHQSUMctdHX4Fl3pHHxRJaAlH5HD+bpfdvsyrsj6qh9EC3RnASvbuyEvyjpiGVzdV8awDPYS2M74pMKv8Xsdp/us3j1qd3KkUX+/dBv8Zm1c1cqCa3UStOQ2q5+xVqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIrmgShhCBvghWeSXU0m5oZqpGLjtXW5qIhm9QxcXYI=;
 b=JfE2O0DIkj8aqdcd3i6cb7PiDYxoRtSCxzAdTk0M7QesNeQfOFdgb/+K4IvWsURa20HBGegT+fvNcpt+WpGfgQYa5Ft3LlEAoYZh+fynVVtmGX07Qy8f48pkkcmq+gq/gC2B5NKup4MH2o6CPtfKNzNoS7lpPNf55/vEn9iDkZA=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3735.eurprd08.prod.outlook.com (20.178.88.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 20:07:44 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 20:07:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
Thread-Topic: [PATCH v6] nbd: well form nbd_iter_channel_error errp handler
Thread-Index: AQHVpVYYOOqrL+0ML0i4F9pC4GQXY6efbQUAgAAE9QA=
Date: Wed, 27 Nov 2019 20:07:43 +0000
Message-ID: <1f314c9d-ce78-a3eb-13a5-dc07ebf3d63b@virtuozzo.com>
References: <20191127190840.15773-1-vsementsov@virtuozzo.com>
 <949f6fe4-5dde-0cef-84e3-e029787c7b12@redhat.com>
In-Reply-To: <949f6fe4-5dde-0cef-84e3-e029787c7b12@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0263.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191127230742006
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 518474ab-edd5-4edd-311a-08d7737576da
x-ms-traffictypediagnostic: AM6PR08MB3735:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM6PR08MB37353742B2A4A0F88D835C90C1440@AM6PR08MB3735.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(124014002)(52116002)(4326008)(36756003)(186003)(256004)(14454004)(64756008)(31696002)(76176011)(66946007)(99286004)(66556008)(66476007)(71200400001)(6436002)(110136005)(66446008)(66066001)(6512007)(6486002)(2616005)(2501003)(14444005)(316002)(71190400001)(54906003)(6306002)(446003)(11346002)(305945005)(25786009)(966005)(81156014)(81166006)(478600001)(8936002)(31686004)(7736002)(561944003)(3846002)(6116002)(229853002)(102836004)(386003)(53546011)(6246003)(86362001)(2906002)(5660300002)(26005)(8676002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3735;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Up/7LmjdNYUJ4/3S/n2w2eZrf7wD6Bt0E3Vl4pLeKSl/qNiLjEEeSJZyLuHP4v+CAN59KGAne7GOnOn3Aktufm273MKzs/W3d/hht9Q2frHN3GLae44t7G8L4ynlwLwjTcZwhRXiqKtEb+53KOHEQlUNCaUuU+PJCFco8lKiLn7ZcaCZSp/6uWNDZmfkfAIcHeFXQH6AtPLwTNqUhyVyiDPInk7tKtritURQmBR9UjzY0iLAKwJJqdFRW2uiV3+h7Xosj8FxIIX/GpfXqsDkCL6pw0FWuKastwaFKACfFUmreplkTwbrG3n/V185cYJ/XpHQaNXx1coAJvDiArVPo+c2FJpQ62YCnwvQZMopaIKFlwKaNTW526ms5kw4heywY+i4RBoUXCyayYZHDTIhWQQzAEV4ToDop4hKLk0KKVqYPkus/rG18ubf4hCcokTnCfNtO/mTuE46pHG1Qog2JPg1WV3oZ8iKwYaQR/y3doM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <61E978B417E2104E9CB97C75F1CD9C91@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518474ab-edd5-4edd-311a-08d7737576da
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 20:07:44.0222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWT3lMcCmWhVIYE3HiHDJI1vM9U99oWlXRZIH5EcnVil/PGDjVpBWVGnGj0N/hq/jTux8ckBfEZGpSqb3lDiYctk4hePGSts/ePQ+x1TFjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3735
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.128
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
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

27.11.2019 22:49, Eric Blake wrote:
> [adding Markus]
>=20
> On 11/27/19 1:08 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Make nbd_iter_channel_error errp handler well formed:
>> rename local_err to errp_in, as it is IN-parameter here (which is
>> unusual for Error**).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> v6: fix commit message
>> =A0=A0=A0=A0 add Eric's r-b
>=20
> I'm surprised that you aren't including Markus on a lot of these patches =
- even though you've posted a lot of them as separate threads to make them =
easier for individual maintainers to pick up, it would also be possible for=
 Markus to pick up a bunch of them at once through his error tree.

Oops, you are right, I'm sorry :(

If it helps, all patches Eric saying about are 21 patches from myself,
with v6 tag, sent during last two hours.

Sorry that I didn't answer to
   https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03105.html
before sending them, and I don't want do it now, to not move v5 above v6.

Week passed since my proposal at that link, so having one against (Eric)
and two for (Kevin and Greg), I decided to follow my plan now.

>=20
> At any rate, I'll queue this one through my NBD tree for 5.0 if it does n=
ot make it through Markus' error tree or the trivial tree sooner.
>=20
>=20

Thanks!

--=20
Best regards,
Vladimir


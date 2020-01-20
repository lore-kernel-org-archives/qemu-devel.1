Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787742087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wEwCVe+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787742087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ita0T-0007ia-8Y
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZz8-0006hP-4u
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itZz4-0007ZN-Jm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:33:06 -0500
Received: from mail-am6eur05on2122.outbound.protection.outlook.com
 ([40.107.22.122]:5921 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itZz4-0007Z4-Dx; Mon, 20 Jan 2020 11:33:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyBXbCyomi1/OR2oTZwUiqoeVbrDzXobv4mTiD5BfwafsSGup9v6v4SUecjSwqqW/lOlSgx46cHGWOxt/bW5vhAuODU9isP8Og3gwVQLsZTMrxkY/HSE9PVZRE7H057NGrmLC78QR478C6dZkJa21jkEin57FrOtT6ZJ+rYBzbrnliKCxdkq2KABleR3kQWPosWDhMHt4TpdfiGTZYs4w2W5QDe+NR+IpzdgFUHDlji0Jclkt628ASv2or0pVyH82CUJ90hTHsgWAFjZvkPQkCqkKvu5mDFBiP0AIbKu1/x3tAaawGKDqguOFakZXb7BCwwKDouyZuqYGy+TQXgyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpmMg5ZEqFC/ghw28S2IZN7jgDsS2OOyH06yxsA2NYo=;
 b=bIh9uDhaXWo0Yv3oqTDgtnfeOci1Q2QIJh/UWYHdqhjBV5SYWVkMuNglWG1TI2UhbSoYTzt9938mNuFvX3e7PbQfm7zoiduz9YSkL75m184ECVJ4RZofy9JBRKj9z9T+6SjIo9eRoFzJk5vtVk+vuOjCnAghz3LNUNnwgqKeiK5GLcuCtnYWCDRD0rPOUnKIDIn5pZYNHs0yy+7D9U6rKV3H3ka0/k1VSlQw+nVMeNUyh+zTb91DUDK9GJ5bcfIDdEyZCr/UlMl+lvMdNhJ/0rKMYciLMSiksi9Tgljg2vBe872i6glafE7UcMR+lcS0B9pAc2Ih5nsoe5IPwcpohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpmMg5ZEqFC/ghw28S2IZN7jgDsS2OOyH06yxsA2NYo=;
 b=wEwCVe+MX169vQ8lsVN+InoztBhgQuGog20aIRefwz6Wh0viN4CD8Y7s47FkoQthcPjHY/vZIrARk1FbiFtYsrEQ/ujCVpkvbhtvieSXGeEmQPy3rDtG/in3w1WwUMdcevGH/C6Z5qCD9ZbSX2v1UYnjqT6qteOImdFtsQKoM2s=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4023.eurprd08.prod.outlook.com (20.179.1.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Mon, 20 Jan 2020 16:33:00 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 16:33:00 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Mon, 20 Jan 2020 16:33:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 00/10] Further bitmaps improvements
Thread-Topic: [PATCH v3 00/10] Further bitmaps improvements
Thread-Index: AQHVtlOfCvnuiV0eH0K+yf5b1BrasqfzzNgAgAAlDoA=
Date: Mon, 20 Jan 2020 16:33:00 +0000
Message-ID: <1d0721d7-95e8-7817-86ab-0deb018d5152@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <063f89d7-2517-f2e2-d8a8-8ff1b417b679@redhat.com>
In-Reply-To: <063f89d7-2517-f2e2-d8a8-8ff1b417b679@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::21) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120193259087
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 832952a5-04ec-47b2-9011-08d79dc66a2e
x-ms-traffictypediagnostic: AM6PR08MB4023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB40234F39E7733FF60D2B20F5C1320@AM6PR08MB4023.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(376002)(39840400004)(366004)(189003)(199004)(107886003)(8936002)(8676002)(2906002)(53546011)(52116002)(81166006)(26005)(36756003)(186003)(16526019)(86362001)(66446008)(478600001)(31696002)(64756008)(66556008)(66476007)(6486002)(4744005)(31686004)(66946007)(4326008)(5660300002)(71200400001)(16576012)(316002)(54906003)(110136005)(81156014)(2616005)(956004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4023;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6i+WkbZVM+IkPW9KLiFmLAz0KqLQs9poP2hzIZxElJDRvQgrVugIPBlhp9T8xg5L2ktA5B2BfDR5J3hx93Q7AYjXlk1Anr7n52kG0xnZ5zD92tpQMTLbfXWQD7SPYN2G7pjUdfZ63E9WfXWvkTGY/2fdNg80iLYnCajE14cUWBemeyCnm6t4VpuR/PbKtdTs/aZrMNuxEYpF/R4IiOGzWjka1NTBHloVu622/rUl3fw4cANXipjj4AAVI8FDeXIOfl22KBpzEQr+YVYSoOhxORoH3xcbjwFKtNqNQw6Sc7q2trnUvsTxnQK9U4kEJqir8nO3qLNRPKV2An9k/7W2qpnD/t1dva7DvxlPlPpWx7i5TyhlElanuXoOwmMLIIYvITABYhV5WCIdnDEGVnJNDe/L+3cI9oMGWObRQuTjopjbbT9tAAykaRFHrjpuwdZb
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <89FC8CF461EE464F8D2652155D23867A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832952a5-04ec-47b2-9011-08d79dc66a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 16:33:00.7595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L5+Dfq3Fx7WeoraJc7nalt58Rx6CSl737M9x7Vyhmz3ALBa2OddD3XRm4HAa4eAAap1qmejdCvAh/BLl1wNji83LJJs4oL7ev+Z56iMWwOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4023
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.22.122
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
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.01.2020 17:20, Max Reitz wrote:
> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>> Hi!
>>
>> The main feature here is improvement of _next_dirty_area API, which I'm
>> going to use then for backup / block-copy.
>=20
> Looks good to me overall, with a few minor changes.  I=92d rather leave
> patches 8 and 9 to Eric, though.  (Even though I=92m not exactly the
> maintainer for the rest of the patches either...)
>=20
> Max
>=20

Thanks for reviewing! Let's wait for Eric.

--=20
Best regards,
Vladimir


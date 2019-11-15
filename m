Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7B2C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D5C2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Yu2L5NBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D5C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdqW-0006Jp-F7
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVdoa-0004g0-QN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVdoY-00089m-PO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:47:16 -0500
Received: from mail-eopbgr40104.outbound.protection.outlook.com
 ([40.107.4.104]:33430 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVdoR-0007i5-Q5; Fri, 15 Nov 2019 10:47:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STkQHZYqznbb3zyxYrcquWenjSRJcNJ/xH4sLuVpb3iDwXae/Pk0xxvRH5tfh+XdhaKacVDdtW6onSeUGLA6ndo0T9jm3Ny+WjPvAYJ2zIBWk6nvNAiFKltDlkghp5fBpm1ABhNSkaDakYfNuJGwasZjP0V0fwAUehOFFtB3/Q8OXi2FpkGB9wc+fWm1ApxQ2jIh/DGtSfJgTExtcMl3nyvhTo5UVwsituk3h/TeHNZs+sTThKBcRwIJGUoW9O6FUmopBvbAcgt2c9dgWakrysLFexkV8t6Q10sGLp0ZYnEGECqwv1YXLpKCjeUG18zs3UTHuqIxJec491Wrsx28Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmDLKzIuMfauf9MI24tpBX44woIFzBA6PO8nPpObP4E=;
 b=NbpwVb/dZAcSss1hO5DxgZf9ZSAaR3X2zIKSd3pD+FmTR6S3+7xKTGzoSQOgZjg81HuAEHNuyPTY/XZsQfdsxOn+gymhsjGoSkga5lSV7ZRv6YX8q0bzYfePMBMA78GrZzuksMyWxJVv3m+GZkBYJdLSXJGhg+I6gm3G3J/YU+KyNyxqvYSuiwp5WTO8C81A9QnMBg1CosThO6XeyZFyEu15aHXbDcShsPdZDFXwUImcTWtWEx5DEUrz55JkYsOtczNyTjOPTDw200GUlM3Hlz0VEpgcYyRxKL87J9l9P0EkGp7Ojb+RZ3r1R7dMr+j1NIffaHWdVZGv9twKwPvnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmDLKzIuMfauf9MI24tpBX44woIFzBA6PO8nPpObP4E=;
 b=Yu2L5NBdzilwUXSj/+TkzqXAhZGpU59/mrutJR2f9Gx/T4PaXilNpK0eKMjgxO4y+lYLXgAxHwlFW5xbE0+aQKZlXCGeWAFmAFwo4Ygxt9BH5SuF35ZR0E8xzOVCzC/DXlMGaZrPbWXhR+R0mJvwHtZ2Yy2mCaILUq57gBRtg3Q=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4184.eurprd08.prod.outlook.com (20.178.87.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Fri, 15 Nov 2019 15:47:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Fri, 15 Nov 2019
 15:47:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Thread-Topic: [PATCH v3 2/4] bitmap: Enforce maximum bitmap name length
Thread-Index: AQHVmpXQlrP7gvUJk0eiM4XXWoXbLqeMiPCA///Zu4A=
Date: Fri, 15 Nov 2019 15:47:03 +0000
Message-ID: <6d54c6eb-4f28-6a5d-81e1-a175e34f3cf8@virtuozzo.com>
References: <20191114024635.11363-1-eblake@redhat.com>
 <20191114024635.11363-3-eblake@redhat.com>
 <0a25974f-f9cd-07a1-4cb7-2bbd4dfe4375@virtuozzo.com>
In-Reply-To: <0a25974f-f9cd-07a1-4cb7-2bbd4dfe4375@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0080.eurprd07.prod.outlook.com
 (2603:10a6:3:64::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191115184701553
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e03295-901d-4468-d3de-08d769e30f99
x-ms-traffictypediagnostic: AM6PR08MB4184:
x-microsoft-antispam-prvs: <AM6PR08MB41840B2C298E23F2CBA4C70EC1700@AM6PR08MB4184.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39840400004)(396003)(51444003)(189003)(199004)(4744005)(81156014)(81166006)(31686004)(2616005)(229853002)(476003)(4326008)(446003)(54906003)(36756003)(486006)(11346002)(110136005)(14444005)(66476007)(66556008)(64756008)(66446008)(256004)(66946007)(305945005)(25786009)(2906002)(478600001)(3846002)(14454004)(6116002)(71200400001)(71190400001)(7736002)(2501003)(52116002)(102836004)(186003)(5660300002)(6436002)(6486002)(26005)(86362001)(316002)(31696002)(6512007)(386003)(8936002)(99286004)(6506007)(8676002)(76176011)(66066001)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4184;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dSosw82IFxodwNmAgX03iKZRLBn26KpdqGENmi2mbjTMcCXKPpyaQv+VXA480X7Vz+DzN8Z4OR30JcYKLKNvHpGjafLRBJFW6R4M3raTO8mcM156sS5Hn773lJah/MsY4oij1GcN3xxjTlv+paMcu4myD6aDiabfsDu0PXATWg2LIkGJTaUSZrh/ccmv6cMhFd1kRh1oupf5LG3/XXvVP/z4YHLb6fyup8V/Hco238WzLOC0vSXxOy4L1WaF4nUnIr0GZOHOq5c92HRpYKbtf6cHo6eqTqQJxiUbnOKWhenR3EHTZiiYzgyva4gvMlkyiNY/Vxtxw8COseXt60YiGrKrIJkNBpBMSKKaXAOLZuH0/gwl5/2fES0c6JSVYu8jJQqGRgNm9H65NDkYmQlw9sYvHAd7Z2ZTLq+OoxhlLZCMcftqpQhz9niDU0ND8dES
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F4370A619001AD41A0B5833E1DE26450@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e03295-901d-4468-d3de-08d769e30f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 15:47:03.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jxJqFy1oVEQKSxLRVpmTslTfiflCRH8rlw7Da8sjqJXJpaAXyuPePsSG1s4InVXghuVzSeLyfL54PWfKmyOM3Kfn1vidNHtuHXv9j3GQ1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4184
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.104
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

15.11.2019 18:03, Vladimir Sementsov-Ogievskiy wrote:
> 14.11.2019 5:46, Eric Blake wrote:
>> We document that for qcow2 persistent bitmaps, the name cannot exceed
>> 1023 bytes.=A0 It is inconsistent if transient bitmaps do not have to
>> abide by the same limit, and it is unlikely that any existing client
>> even cares about using bitmap names this long.=A0 It's time to codify
>> that ALL bitmaps managed by qemu (whether persistent in qcow2 or not)
>> have a documented maximum length.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20

One doubt:

Is it good idea to include string larger than 4K into error message
(in next patch too)? I doubt that such message would be
readable, and I think that most possible source of such message is
some kind of memory corruption, so the whole message would be garbage,
which may contain special symbols which may look bad or even break
output.

--=20
Best regards,
Vladimir


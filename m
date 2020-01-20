Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D016BC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA0020684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GfSLpSrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA0020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60467 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT3L-00005Y-Ob
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT2h-00084G-Ll
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itT2g-0001en-Lw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:08:19 -0500
Received: from mail-ve1eur01on070b.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::70b]:57923
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itT2g-0001cr-FE; Mon, 20 Jan 2020 04:08:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrgrZwKXlx6dki3PVWW1KMVl97qph7mrDQ9srtht76MABqzlGFJwty1Y6Y+RZcqYvzJRMiks9JkFMr/gbqGW+t68fWE6/G7uPLk22b23Ir8ABKCcu5Wlcy1jv2kMnIE79KdUlsV+8DZ54uBxqWd6piYc7WNtSV5IEYl7qRHbpty6UPx1o+sNrffK9RtjpPptMht7RoLY7C5PeWSlktPSsfoGOoq+sliiew2L03epv2wr9MxXYMuSWuC0+5zv0q0jsTJGmN+HiojI3orqKnKMA0yhOKmXyeWZ5B3BXe8U74QGiTt2eyBKK5VcShYet6X8lK8jmH247Phz8Pvc7tMI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZDJjEPKKgWcqpbPdTFXnX8CglqGl2wx3QYQlu/yP7w=;
 b=GmLAcb5lBZf/t9kxmHfM8kUheGjH5kkK1OtmzOkXZ+XIJXRb/CZ/UAiB2cGaUZzo8RpvTcmQsjwjCRgoeWzucRcpMG/+R/OUjVq3ZLYhaym38DGt4OoXVmaUSHim+/MrRVq4iIZTaJeSJY8UxUTnbeM49mshCFMR33jLW/xziJXEGDi4WClvvlPudxfnpORmyVjUZYmJWA70nl4TtD4cIZspUSQzNbzTEz+i8TooSyjWMmBKtf9tysQqYpyAgl/1tN+vy3ypz+ac1Joc5ZWzc5l9TBWxdLN3Li3Or1Cud1ACFsjstDIJvUbqPsTRZk7NyHQZHukelbmVnL+kcKqUVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZDJjEPKKgWcqpbPdTFXnX8CglqGl2wx3QYQlu/yP7w=;
 b=GfSLpSrMmBEeEqHG1yDOgxShz8Q81J2OByiJEWVZLE1Eg+TsSVPMq1mNBxLIVWl7R/r1rOMLuC7Xs1LtG/tmKwdOAgP16BvcxozvsZQz8Pvg6BuNDp8Ev+PkP8xjDymZ9GSG1pX9RHmvfipZ3Fk3mZrGEVRmQlUFriMQMXzXt/8=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5016.eurprd08.prod.outlook.com (10.255.122.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Mon, 20 Jan 2020 09:08:15 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 09:08:15 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0902CA0036.eurprd09.prod.outlook.com (2603:10a6:7:15::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 09:08:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 00/10] Further bitmaps improvements
Thread-Topic: [PATCH v3 00/10] Further bitmaps improvements
Thread-Index: AQHVtlOfCvnuiV0eH0K+yf5b1BrasqfzdaAA
Date: Mon, 20 Jan 2020 09:08:14 +0000
Message-ID: <55e61448-1f22-864c-fad1-a9fc651e02bf@virtuozzo.com>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191219100348.24827-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0036.eurprd09.prod.outlook.com
 (2603:10a6:7:15::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120120812228
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 123190ab-d68a-471b-c5e7-08d79d884824
x-ms-traffictypediagnostic: AM6PR08MB5016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB5016420CDBDBDAA317313AD5C1320@AM6PR08MB5016.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(136003)(346002)(376002)(199004)(189003)(8676002)(66946007)(6916009)(71200400001)(316002)(66446008)(81156014)(186003)(66556008)(16576012)(66476007)(64756008)(36756003)(5660300002)(6486002)(26005)(8936002)(31696002)(31686004)(52116002)(4326008)(956004)(478600001)(2616005)(16526019)(54906003)(2906002)(107886003)(86362001)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5016;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0CP0UFXMefKdFBE7d2UkfKFsr8VMUjYzbpMABk3/6pYGLblEdo1oS8Q4rC4r4HRnv/N4hnte+6dwdFKYhdy6N3UFW4b1i5dtd/AvWZ9WPZSPU8VI/h0q/Mb7gcRxuTe9hkDGm/ukmsS12IxDzy5cJLpepGPTCPyitIO8tnEHmtabOBFkTyKo9eMpkDtWc1Kh5tBJuRAUdvU2lcDqAc+PL9tPepv8bTcfX/9mgDIgj4x97ovRao0aVNjtmq/leUy5kWzFn/hhKiCY2xcAMq78MIUGaJa/kLd2KC81qQEJ7lTb7Hj7XgsrTvH8KI1h6T6K3PNLs8GDpiaNJYQitQ+4Rn5p+FblZxH09W/EFa6TaxdbpmqGxxWPXLMklx4GyPuAf5HlPIraTuLWRATe6YnR38GHQMWasoCmeRMrPXnMYpmgjSypDjvThftqsvxNbz7
Content-Type: text/plain; charset="utf-8"
Content-ID: <60D864B1FAB81341B74BF9065F232666@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123190ab-d68a-471b-c5e7-08d79d884824
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 09:08:14.9376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQT/JE/5ERtfPKn7OkHH2zNy2dEbbr7QBKfzIJXHCN0yZW2nhRP3mWTRiRIh0SvxYsg+6C2Iu2esXKvxagaEVTnM3xYF+cIwFCdfldiR6V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::70b
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cGluZw0KDQoxOS4xMi4yMDE5IDEzOjAzLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSENCj4gDQo+IFRoZSBtYWluIGZlYXR1cmUgaGVyZSBpcyBpbXByb3ZlbWVudCBv
ZiBfbmV4dF9kaXJ0eV9hcmVhIEFQSSwgd2hpY2ggSSdtDQo+IGdvaW5nIHRvIHVzZSB0aGVuIGZv
ciBiYWNrdXAgLyBibG9jay1jb3B5Lg0KPiANCj4gdjM6IHJlYmFzZSBvbiBjdXJyZW50IG1hc3Rl
ci4gTWlycm9yIGRvbid0IHVzZSBfbmV4dF9kaXJ0eV9hcmVhIGFueQ0KPiBtb3JlLCBzbyBtaXJy
b3IgY2h1bmtzIGRyb3BwZWQgKHBhdGNoZXMgMDUgYW5kIDA3KSBhbmQgMDcgY29tbWl0IG1lc3Nh
Z2UNCj4gY2hhbmdlZC4NCj4gDQo+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDEwKToN
Cj4gICAgaGJpdG1hcDogYXNzZXJ0IHRoYXQgd2UgZG9uJ3QgY3JlYXRlIGJpdG1hcCBsYXJnZXIg
dGhhbiBJTlQ2NF9NQVgNCj4gICAgaGJpdG1hcDogbW92ZSBoYml0bWFwX2l0ZXJfbmV4dF93b3Jk
IHRvIGhiaXRtYXAuYw0KPiAgICBoYml0bWFwOiB1bnB1Ymxpc2ggaGJpdG1hcF9pdGVyX3NraXBf
d29yZHMNCj4gICAgaGJpdG1hcDogZHJvcCBtZXRhIGJpdG1hcHMgYXMgdGhleSBhcmUgdW51c2Vk
DQo+ICAgIGJsb2NrL2RpcnR5LWJpdG1hcDogc3dpdGNoIF9uZXh0X2RpcnR5X2FyZWEgYW5kIF9u
ZXh0X3plcm8gdG8gaW50NjRfdA0KPiAgICBibG9jay9kaXJ0eS1iaXRtYXA6IGFkZCBfbmV4dF9k
aXJ0eSBBUEkNCj4gICAgYmxvY2svZGlydHktYml0bWFwOiBpbXByb3ZlIF9uZXh0X2RpcnR5X2Fy
ZWEgQVBJDQo+ICAgIG5iZC9zZXJ2ZXI6IGludHJvZHVjZSBOQkRFeHRlbnRBcnJheQ0KPiAgICBu
YmQvc2VydmVyOiB1c2UgYmRydl9kaXJ0eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhDQo+ICAgIGJs
b2NrL3Fjb3cyLWJpdG1hcDogdXNlIGJkcnZfZGlydHlfYml0bWFwX25leHRfZGlydHkNCj4gDQo+
ICAgaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCB8ICAgOSArLQ0KPiAgIGluY2x1ZGUvcWVt
dS9oYml0bWFwLmggICAgICAgfCAgOTcgKysrLS0tLS0tLS0NCj4gICBibG9jay9kaXJ0eS1iaXRt
YXAuYyAgICAgICAgIHwgIDE2ICstDQo+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgICAgICAgICB8
ICAxMSArLQ0KPiAgIG5iZC9zZXJ2ZXIuYyAgICAgICAgICAgICAgICAgfCAyNDIgKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgdGVzdHMvdGVzdC1oYml0bWFwLmMgICAgICAgICB8IDMx
NCArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIHV0aWwvaGJpdG1hcC5j
ICAgICAgICAgICAgICAgfCAxMzMgKysrKysrKysrLS0tLS0tDQo+ICAgNyBmaWxlcyBjaGFuZ2Vk
LCAzNjYgaW5zZXJ0aW9ucygrKSwgNDU2IGRlbGV0aW9ucygtKQ0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=


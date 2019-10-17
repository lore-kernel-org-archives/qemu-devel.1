Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65365FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB491205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oF8ZVeFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB491205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7AL-0000fC-2c
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL61B-0004Mg-Rn
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iL61A-0005wh-7w
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:40:41 -0400
Received: from mail-eopbgr70122.outbound.protection.outlook.com
 ([40.107.7.122]:4743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iL619-0005vt-HA; Thu, 17 Oct 2019 09:40:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWpXLp+WJzSQcQfucOJtnkJRkIB4pvXtpmddBNMBp6i4b2HOEYpe2rMMTCl3kiHdOu1shC+y7yD9YP7cnsrDfMUf8z4B2bF6ErR7w+YJxcrEovhnvxPXkOMErUVF9sqpWAEl0bKRssIuYNx9Zhpr6PvZyQDwYNroWmt6Crog7SMRldsjX/vsxlt/x92MEFqXfHBXr5VggL2kJlnxTing+mMQGsaubRNbrOOKnGScdB5oDjd1HnPFARrgB+EoqImMazVlnMvblXkmaxxGfSCTxyHWCHz2EXYZ3XJuwoHnh/NAtStc1m0rMfymMNk4TS13MYy7BjVRJLn50gFj5wY/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If9ClqoUWwD2/y9nevbql8JTPYITMkKUZStujBztMdk=;
 b=LyOfTBkVUIOODa6PDjcPxfVqT4L9Om6O109h+bpd5/k7vCKnEyLA892lG2NVAoifuZPA7dbaHOFOwb8vKllBikZYQuNqxwJ8TgXxwCmHhyIilVec3TmRmG123bGFXm2ganSb4WxA3k0TFM0xIrG1yW7+fo1/moZli7SbOX+yDCaNtwErq1F9EcVVm/dHI7oia2aL2G5lA5wGaWpLG15rVQtp6QpIZT/kjZXHQB8USbusx/37VF1SVUDT0CmmO3ZPBrMpH4gGB/cYXa9sLfdkU+e+VxuCZwmmcmPB37j6MOrXeNN6K+e6hoULLYeabNfjkynmJ9hiC9bjFFyuB0qooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=If9ClqoUWwD2/y9nevbql8JTPYITMkKUZStujBztMdk=;
 b=oF8ZVeFgkjaZwbS9ztLoy3LwKsfCAWtohJ7P/bwDagPJfJ7bmknmvPYn23LG6L9h5miaRrm8i3tL/QTuBgp+CDIBnxZhXopOGKKzBRISbGjC6+rNYILjw6WMUdsde0I6FJJPBr90NLu+NHfZxq2munDcJ5J/E1HbAxibhMhm6dw=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB4930.eurprd08.prod.outlook.com (10.255.28.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Thu, 17 Oct 2019 13:40:37 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 13:40:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [PULL 33/36] block/backup: use backup-top instead of write
 notifiers
Thread-Topic: [PULL 33/36] block/backup: use backup-top instead of write
 notifiers
Thread-Index: AQHVf2aBj5A/xh+g/0qqxN5vmOWZFadex1AAgAAayQA=
Date: Thu, 17 Oct 2019 13:40:36 +0000
Message-ID: <75fde289-9411-1910-9a4e-f12f5ab1bd3d@virtuozzo.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
 <20191010114300.7746-34-mreitz@redhat.com>
 <CAFEAcA_jV_C1W_EsffV2vv9FjupV2ONTZ1wOxTLBmy76Gh5FgQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_jV_C1W_EsffV2vv9FjupV2ONTZ1wOxTLBmy76Gh5FgQ@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::17) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191017164034850
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132fc94f-d0ac-4be8-4175-08d75307975c
x-ms-traffictypediagnostic: AM0PR08MB4930:
x-microsoft-antispam-prvs: <AM0PR08MB4930167EFF4C9EE97B1C81AEC16D0@AM0PR08MB4930.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(376002)(346002)(396003)(136003)(366004)(199004)(189003)(36756003)(7736002)(6246003)(66066001)(71200400001)(25786009)(31696002)(229853002)(6512007)(86362001)(71190400001)(3846002)(4326008)(2906002)(14444005)(6116002)(6436002)(256004)(305945005)(6486002)(478600001)(31686004)(14454004)(99286004)(52116002)(66476007)(486006)(66446008)(64756008)(66946007)(26005)(5660300002)(8676002)(8936002)(76176011)(186003)(102836004)(11346002)(446003)(6506007)(54906003)(386003)(316002)(66556008)(476003)(81166006)(2616005)(81156014)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4930;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3030zzIxp17QuXbmwVcE86MEiHyPCQLG6wEBnv8CfzrtTwWTQwH/5rOCiPs8d+5AEVl0kPYAb5Ur9Zhj3pfzrENKfxl+qUbym9DYQIpASm/Idwp2ExOY71Upddjw47BV7lgkJK3jps6JLp1UlmRfBs9jIt4ey22OImNPYY/TT6HsthKVBvXM8fRIZUIMCrxHfQTS8idUbs1ngIm5wRNMIKIK0jz6sYzh9TOhcQWDjbDrvK17Z7s8Q74Ud61cXrEaQor7enCIEwgiO2/Lab8kDAtSoyQJsUnDdWDw12eAj4oY0rNB8yTraoGCgF5J5Rh7AfCtbjFZdu5+W7Y+7ghVXdqoH0WepG0rz6B3txZTh7qairuMxOZsrCYFHyQm/w6MslkjOlkx/y8see4wOhZdQNK4xKEFi8xZ9TTjGIEQls=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5498DF97154684F977BDFDD757B18D7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132fc94f-d0ac-4be8-4175-08d75307975c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 13:40:36.9114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+Si9h9bfjhBJlXrwaFdd5L2TJul5FIw0oXF97cZg9M0vADWvXDWpgQFwtbw5hGDt/rOd5Ps/rJmqktslXgffYJBBvnlVvbHma1sMgT7JxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4930
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.122
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMTAuMjAxOSAxNTowNCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVGh1LCAxMCBPY3Qg
MjAxOSBhdCAxMjo0NCwgTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pg0K
Pj4gRnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KPj4NCj4+IERyb3Agd3JpdGUgbm90aWZpZXJzIGFuZCB1c2UgZmlsdGVyIG5vZGUg
aW5zdGVhZC4NCj4gDQo+IEhpOyBhZnRlciB0aGlzIGNoYW5nZSBDb3Zlcml0eSBjb21wbGFpbnMg
YWJvdXQgZGVhZCBjb2RlIGluDQo+IGJhY2t1cF9qb2JfY3JlYXRlKCkgKENJRCAxNDA2NDAyKToN
Cg0KT29wcywgSSdtIHNvcnJ5LiBXaWxsIHNlbmQgYSBwYXRjaCBzb29uLg0KDQo+IA0KPj4gQEAg
LTM4Miw2ICszNTMsOCBAQCBCbG9ja0pvYiAqYmFja3VwX2pvYl9jcmVhdGUoY29uc3QgY2hhciAq
am9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4+ICAgICAgIEJhY2t1cEJsb2NrSm9iICpq
b2IgPSBOVUxMOw0KPj4gICAgICAgaW50NjRfdCBjbHVzdGVyX3NpemU7DQo+PiAgICAgICBCZHJ2
UmVxdWVzdEZsYWdzIHdyaXRlX2ZsYWdzOw0KPj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpiYWNr
dXBfdG9wID0gTlVMTDsNCj4+ICsgICAgQmxvY2tDb3B5U3RhdGUgKmJjcyA9IE5VTEw7DQo+Pg0K
Pj4gICAgICAgYXNzZXJ0KGJzKTsNCj4+ICAgICAgIGFzc2VydCh0YXJnZXQpOw0KPj4gQEAgLTQ2
MywzMyArNDM2LDM1IEBAIEJsb2NrSm9iICpiYWNrdXBfam9iX2NyZWF0ZShjb25zdCBjaGFyICpq
b2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgd3JpdGVfZmxhZ3MgPSAoYmRy
dl9jaGFpbl9jb250YWlucyh0YXJnZXQsIGJzKSA/IEJEUlZfUkVRX1NFUklBTElTSU5HIDogMCkg
fA0KPj4gICAgICAgICAgICAgICAgICAgICAoY29tcHJlc3MgPyBCRFJWX1JFUV9XUklURV9DT01Q
UkVTU0VEIDogMCksDQo+Pg0KPj4gKyAgICBiYWNrdXBfdG9wID0gYmRydl9iYWNrdXBfdG9wX2Fw
cGVuZChicywgdGFyZ2V0LCBmaWx0ZXJfbm9kZV9uYW1lLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjbHVzdGVyX3NpemUsIHdyaXRlX2ZsYWdzLCAmYmNzLCBl
cnJwKTsNCj4+ICsgICAgaWYgKCFiYWNrdXBfdG9wKSB7DQo+PiArICAgICAgICBnb3RvIGVycm9y
Ow0KPj4gKyAgICB9DQo+PiArDQo+PiAgICAgICAvKiBqb2ItPmxlbiBpcyBmaXhlZCwgc28gd2Ug
Y2FuJ3QgYWxsb3cgcmVzaXplICovDQo+PiAtICAgIGpvYiA9IGJsb2NrX2pvYl9jcmVhdGUoam9i
X2lkLCAmYmFja3VwX2pvYl9kcml2ZXIsIHR4biwgYnMsIDAsIEJMS19QRVJNX0FMTCwNCj4+ICsg
ICAgam9iID0gYmxvY2tfam9iX2NyZWF0ZShqb2JfaWQsICZiYWNrdXBfam9iX2RyaXZlciwgdHhu
LCBiYWNrdXBfdG9wLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIEJMS19QRVJN
X0FMTCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3BlZWQsIGNyZWF0aW9uX2Zs
YWdzLCBjYiwgb3BhcXVlLCBlcnJwKTsNCj4+ICAgICAgIGlmICgham9iKSB7DQo+PiAgICAgICAg
ICAgZ290byBlcnJvcjsNCj4+ICAgICAgIH0NCj4+DQo+PiArICAgIGpvYi0+YmFja3VwX3RvcCA9
IGJhY2t1cF90b3A7DQo+PiAgICAgICBqb2ItPnNvdXJjZV9icyA9IGJzOw0KPj4gICAgICAgam9i
LT5vbl9zb3VyY2VfZXJyb3IgPSBvbl9zb3VyY2VfZXJyb3I7DQo+PiAgICAgICBqb2ItPm9uX3Rh
cmdldF9lcnJvciA9IG9uX3RhcmdldF9lcnJvcjsNCj4+ICAgICAgIGpvYi0+c3luY19tb2RlID0g
c3luY19tb2RlOw0KPj4gICAgICAgam9iLT5zeW5jX2JpdG1hcCA9IHN5bmNfYml0bWFwOw0KPj4g
ICAgICAgam9iLT5iaXRtYXBfbW9kZSA9IGJpdG1hcF9tb2RlOw0KPj4gLQ0KPj4gLSAgICBqb2It
PmJjcyA9IGJsb2NrX2NvcHlfc3RhdGVfbmV3KGJzLCB0YXJnZXQsIGNsdXN0ZXJfc2l6ZSwgd3Jp
dGVfZmxhZ3MsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCk7
DQo+PiAtICAgIGlmICgham9iLT5iY3MpIHsNCj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+PiAt
ICAgIH0NCj4+IC0NCj4gDQo+IFRoaXMgY29kZSBkZWxldGlvbiBoYXMgcmVtb3ZlZCB0aGUgb25s
eSBjb2RlIHBhdGggdGhhdCBjYW4NCj4gcmVhY2ggdGhlICdlcnJvcicgbGFiZWwgYWZ0ZXIgdGhl
IHN1Y2Nlc3NmdWwgY3JlYXRpb24gb2YgdGhlIGpvYi4uLg0KPiANCj4+ICsgICAgam9iLT5iY3Mg
PSBiY3M7DQo+PiAgICAgICBqb2ItPmNsdXN0ZXJfc2l6ZSA9IGNsdXN0ZXJfc2l6ZTsNCj4+ICAg
ICAgIGpvYi0+bGVuID0gbGVuOw0KPj4NCj4+IC0gICAgYmxvY2tfY29weV9zZXRfY2FsbGJhY2tz
KGpvYi0+YmNzLCBiYWNrdXBfcHJvZ3Jlc3NfYnl0ZXNfY2FsbGJhY2ssDQo+PiArICAgIGJsb2Nr
X2NvcHlfc2V0X2NhbGxiYWNrcyhiY3MsIGJhY2t1cF9wcm9ncmVzc19ieXRlc19jYWxsYmFjaywN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBiYWNrdXBfcHJvZ3Jlc3NfcmVzZXRf
Y2FsbGJhY2ssIGpvYik7DQo+Pg0KPj4gLSAgICAvKiBSZXF1aXJlZCBwZXJtaXNzaW9ucyBhcmUg
YWxyZWFkeSB0YWtlbiBieSBibG9jay1jb3B5LXN0YXRlIHRhcmdldCAqLw0KPj4gKyAgICAvKiBS
ZXF1aXJlZCBwZXJtaXNzaW9ucyBhcmUgYWxyZWFkeSB0YWtlbiBieSBiYWNrdXAtdG9wIHRhcmdl
dCAqLw0KPj4gICAgICAgYmxvY2tfam9iX2FkZF9iZHJ2KCZqb2ItPmNvbW1vbiwgInRhcmdldCIs
IHRhcmdldCwgMCwgQkxLX1BFUk1fQUxMLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQo+Pg0KPj4gQEAgLTUwMiw2ICs0NzcsOCBAQCBCbG9ja0pvYiAqYmFja3Vw
X2pvYl9jcmVhdGUoY29uc3QgY2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4+
ICAgICAgIGlmIChqb2IpIHsNCj4+ICAgICAgICAgICBiYWNrdXBfY2xlYW4oJmpvYi0+Y29tbW9u
LmpvYik7DQo+PiAgICAgICAgICAgam9iX2Vhcmx5X2ZhaWwoJmpvYi0+Y29tbW9uLmpvYik7DQo+
IA0KPiAuLi5zbyBkb3duIGhlcmUgaW4gdGhlICdlcnJvcjonIGNvZGUgdGhlICJpZiAoam9iKSIg
Y29uZGl0aW9uDQo+IGNhbiBuZXZlciBwYXNzLCBhbmQgdGhlIGNvZGUgaW4gdGhpcyBwYXJ0IG9m
IHRoZSBpZiBzdGF0ZW1lbnQNCj4gaXMgZGVhZC4NCj4gDQo+PiArICAgIH0gZWxzZSBpZiAoYmFj
a3VwX3RvcCkgew0KPj4gKyAgICAgICAgYmRydl9iYWNrdXBfdG9wX2Ryb3AoYmFja3VwX3RvcCk7
DQo+PiAgICAgICB9DQo+Pg0KPj4gICAgICAgcmV0dXJuIE5VTEw7DQo+PiAgIHsicmV0dXJuIjog
e319DQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==


Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DD1C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56A02075D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 16:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QrZSiLHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56A02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEyXD-0003rI-3J
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 12:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iEyVZ-0002TE-IP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iEyVY-00009y-Ih
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 12:26:45 -0400
Received: from mail-eopbgr150133.outbound.protection.outlook.com
 ([40.107.15.133]:55950 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iEyVM-0008SU-QQ; Mon, 30 Sep 2019 12:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XooqlKGfXTzdFBHchxFea52xZ3/s02ZYyoXXC1dvEX2lrOBi6Ne7zi4o4QQnY3Rjno3ocbVmgetyV9fu7SlcpNJOpsUbDbBnN+Se7xdL7+jLjuPoYheoYQxid2CmhmommMLyT+SqztVwDqbeBjQSL2lBVIdhYYbsTi1FGvonmvwS18nA4kpYJCGbuo7sR3CxYZDjz5t7BSXrPfnashxLVfh8O/Iio0glMHyu18D+Qz2xAZq8f53ubn4t30YsXRQCJRU1RcyOihioRA18OzAvt4HtPw0aefuWMr5SOsvzkhmK4Ny3XsGJV2Aijm7wZwbpFQwwd3fuGNx0d2mwEBBX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5L/eKWUPsjMH+s84jaQ9uOjWlsFjgaQd/QnB1uG9CM=;
 b=X4qV6EH4WsfIvkkq6EkS4LB79Qa/h+9xpai4ql/HALfrv5jrSIyXVdTRNqX+0m7bbBwgs1+zkWVTF7Qcx80s9VFx9bNbkD0TP6h+kkYApDrcSqMl75BcUd16Inxqc5fxRy0v1POciqvJj9vW9B6RKR1z9b+V/fnObVQHIuwNX0tfu2Ykxq/fg6qzzjQP8Zj3fJUIWFQ8nDXfeg5yi+o4+BtY/Sqc3awvvwJoWQXheqdrL5Y1nITYoakVBJZ/FX54heVIuq/DU85SRTuXA7qOZNH/GrpNTw3UIOzBOLOSAo+sqKn6mYZNK3u9ZEso4I77vWZ44jquqotovr3OYP+Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5L/eKWUPsjMH+s84jaQ9uOjWlsFjgaQd/QnB1uG9CM=;
 b=QrZSiLHKh4jHf4WAUOvrqeIav9UB9zlruf5ppNa+s7EGA4vqabClUpOidjFvYy9EFrKYUjTh1i3pGJUTd8FCgmqbS3sWd+nDwBQ5lMzXaxdSIuU7fgwWiH/1b4gCWmhZB0fxknRzKFfL5MoDzPfYu/kqzP4pSb5XTfqdp0uBdl8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Mon, 30 Sep 2019 16:26:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 16:26:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 04/25] error: auto propagated local_err
Thread-Topic: [PATCH v3 04/25] error: auto propagated local_err
Thread-Index: AQHVcxQEcKETnqqn7ky5xEykJfDDyadEXLqAgAA0NoD//9lQgIAABzEA
Date: Mon, 30 Sep 2019 16:26:28 +0000
Message-ID: <495102b2-5d1a-f659-4387-5733ae34b3e2@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
 <20190924200902.4703-5-vsementsov@virtuozzo.com>
 <20190930151215.GB12777@linux.fritz.box>
 <ca629ae8-15c5-1685-1cbb-99283d37b0a1@virtuozzo.com>
 <20190930160039.GC12777@linux.fritz.box>
In-Reply-To: <20190930160039.GC12777@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190930192624256
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d062fd76-df61-4da9-baa3-08d745c2f20b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4010; 
x-ms-traffictypediagnostic: DB8PR08MB4010:
x-microsoft-antispam-prvs: <DB8PR08MB40108958E0142B0659425A21C1820@DB8PR08MB4010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(136003)(396003)(39840400004)(199004)(189003)(486006)(316002)(7736002)(2906002)(54906003)(6246003)(66476007)(7406005)(64756008)(66946007)(36756003)(305945005)(81156014)(6116002)(6916009)(7416002)(66446008)(3846002)(386003)(31686004)(6506007)(66066001)(76176011)(81166006)(66556008)(102836004)(71200400001)(186003)(8676002)(71190400001)(8936002)(476003)(86362001)(446003)(26005)(4326008)(6486002)(14454004)(5660300002)(31696002)(99286004)(2616005)(14444005)(256004)(229853002)(478600001)(25786009)(52116002)(6436002)(6512007)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4010;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TXMrBKqUhbwTXvVvTQYegyDgq5XRZ3wwVZVMP9mdL2AdTSyETyNODdBOtsb8l497f/FSoRyVbPr5AMQz+vd1A1C83F7gAO3mKpJwyPdNmriUSRyYsmv6xzcitIEwi0zc77IvijLwksKuDeGGeMNzTdJTv/sY3rNcPIl+JBy7q3M6rNNSLJ8a43xQnPuetKEezTTOnp7KYIdQGxen37sX6re/hvzzktjfcLyU+ZlcL4VIhifr2RJMqduecYtKWaVwzT2CGFCZ3bWUcZNTxSuJxoIN/xTNvFh3LFo2mHO/tJH3U7xDHC4+CWA3dKm8aqE0AuCf7hCXvGo0AEUkzEptgULm6oTHyT5akSM1ciAvfHRCGZyWJWWIfueTYziR72ZCkJTAyoQHnMD39WVSCi1w7JoVJVdL/8RJdx3IG67CFE4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2552325C35593C42A8432D187B4C75C8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d062fd76-df61-4da9-baa3-08d745c2f20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 16:26:28.4072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpvNwp3TIb+nLMgmsjEvLID57CKak6C2DZ+XrE971C+V6+nS6oU5F46EPiMVCASIdTuIeZ25DppDIARdwvxj5o0wfs6EBT8fzTIrb0RuwL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.133
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paul Burton <pburton@wavecomp.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Greg Kurz <groug@kaod.org>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 David Hildenbrand <david@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 "integration@gluster.org" <integration@gluster.org>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDkuMjAxOSAxOTowMCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMzAuMDkuMjAxOSB1bSAx
NzoxOSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDMw
LjA5LjIwMTkgMTg6MTIsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMjQuMDkuMjAxOSB1bSAy
MjowOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4g
SGVyZSBpcyBpbnRyb2R1Y2VkIEVSUlBfRlVOQ1RJT05fQkVHSU4gbWFjcm8sIHRvIGJlIHVzZWQg
YXQgc3RhcnQgb2YNCj4+Pj4gZnVuY3Rpb25zIHdpdGggZXJycCBwYXJhbWV0ZXIuDQo+Pj4NCj4+
PiBBIGJpdCBvZiBiaWtlIHNoZWRkaW5nLCBidXQgRk9PX0JFR0lOIHN1Z2dlc3RzIHRvIG1lIHRo
YXQgYSBGT09fRU5EIHdpbGwNCj4+PiBmb2xsb3cuIENhbiB3ZSBmaW5kIGEgZGlmZmVyZW50IG5h
bWUsIGVzcGVjaWFsbHkgbm93IHRoYXQgd2Ugd29uJ3QgdXNlDQo+Pj4gdGhpcyBtYWNybyBpbiBl
dmVyeSBmdW5jdGlvbiB0aGF0IHVzZXMgYW4gZXJycCwgc28gZXZlbiB0aGUgImVycnANCj4+PiBm
dW5jdGlvbiIgcGFydCBpc24ndCByZWFsbHkgY29ycmVjdCBhbnkgbW9yZT8NCj4+Pg0KPj4+IEhv
dyBhYm91dCBFUlJQX0FVVE9fUFJPUEFHQVRFPw0KPj4NCj4+IEkgaGF2ZSBhbiBpZGVhIHRoYXQg
d2l0aCB0aGlzIG1hY3JvIHdlIGNhbiAob3B0aW9uYWxseSkgZ2V0IHRoZSB3aG9sZSBjYWxsIHN0
YWNrDQo+PiBvZiB0aGUgZXJyb3IgYW5kIHByaW50IGl0IHRvIGxvZywgc28gaXQncyBnb29kIHRv
IGdpdmUgaXQgbW9yZSBnZW5lcmljIG5hbWUsIG5vdA0KPj4gbGltaXRlZCB0byBwcm9wYWdhdGlv
bi4uDQo+IA0KPiBIbSwgd2hhdCdzIHRoZSBjb250ZXh0IGZvciB0aGlzIGZlYXR1cmU/DQo+IA0K
PiBUaGUgb2J2aW91cyBvbmUgd2hlcmUgeW91IHdhbnQgdG8gaGF2ZSBhIHN0YWNrIHRyYWNlIGlz
ICZlcnJvcl9hYm9ydCwNCj4gYnV0IHRoYXQgb25lIGNyYXNoZXMsIHNvIHlvdSBnZXQgaXQgYXV0
b21hdGljYWxseS4gSWYgaXQncyBqdXN0IGEgbm9ybWFsDQo+IGVycm9yIChsaWtlIGEgUUFQSSBv
cHRpb24gY29udGFpbnMgYW4gaW52YWxpZCB2YWx1ZSBhbmQgc29tZSBmdW5jdGlvbg0KPiBkb3du
IHRoZSBjYWxsIGNoYWluIGNoZWNrcyBpdCksIHdoeSB3b3VsZCBhbnlvbmUgd2FudCB0byBrbm93
IHdoYXQgdGhlDQo+IGNhbGwgY2hhaW4gaW4gdGhlIFFFTVUgY29kZSB3YXM/DQo+IA0KDQpXaGVu
IEkgaGF2ZSBidWcgZnJvbSB0ZXN0ZXJzLCBjYWxsIHN0YWNrIHdvdWxkIGJlIGEgbG90IG1vcmUg
ZGVzY3JpcHRpdmUsIHRoYW4ganVzdA0KYW4gZXJyb3IgbWVzc2FnZS4NCg0KV2UgbWF5IGFkZCB0
cmFjZSBwb2ludCB3aGljaCB3aWxsIHByaW50IHRoaXMgaW5mb3JtYXRpb24sIHNvIHdpdGggZGlz
YWJsZWQgdHJhY2UgcG9pbnQNCi0gbm8gZXh0cmEgb3V0cHV0Lg0KDQoNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpWbGFkaW1pcg0K


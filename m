Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA086C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EF0222C5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SPW0/s/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EF0222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUS0-0003Hv-Ji
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUQP-0002G3-CW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUQN-0007U9-6p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:07:17 -0400
Received: from mail-eopbgr140134.outbound.protection.outlook.com
 ([40.107.14.134]:56805 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDUQJ-0007QC-Hq; Thu, 26 Sep 2019 10:07:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoFW2ha0Z+NSczBIjjrqpH6SWWqLsNV/Q2d9hXL8UYJVBi1txDirtSANkRvOCFpnOlcdreaNfa2pUDX1WneNdORm+BHtWcTn84vdPpDKVSh4gbCCXLFEOmPhWlHhYwLXGJ6WglICDI1rVmJGPmT5skYLXrHdfUbyVrb2fSjVs5mB0c/VEe11ve/gi5NEmXjn+spyZjAozX5bxEMz3VvnaPLDqfnpRNU9X33Dp9c1qbBmqtrzFg3YvJwCeEoJ1AkiwbSZ4YosRbDOYSj4/RqsrMgofQpXBxMTgNwP+PwzlYOqSr4d3x+OZhiwhpLjV8pJLUAwmvTvezjK+4wbfV0c4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jEePjv1C3omQLM5Kxa0OvXBbtyiJiCQIUS8eFKfIhg=;
 b=ZPOErlgXwtIZJ/pQM2Xy+h/kkt10gIUA/E8OWLjbC/27HXD1LZoPwUIO5k1U+LkTHBAeQivDWP7g7pEzA1AA1RAeb/pbbNYaJ++LEJAs9zed4XfGKXo1Aig2DxNcydOX8vZsi7+AzsuhkDnk+4wtPcSeK3B6ieG5ZrR6oeFvIu3yWE5kHI+SusZc2bwd/0lyD+06Vc47WN06L9V5zJiwXZcs/AaeTolBTGZl3ck14fo5c/ymTmJCU9IXAFDqtrmdS4JU9AcLPcfDjPh8u6uIOSxELhlmoB7w0b66nzPtmbyM4fm71kFhSobgkAEA0VPcQTl1OStFdE04NtEVSGtV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jEePjv1C3omQLM5Kxa0OvXBbtyiJiCQIUS8eFKfIhg=;
 b=SPW0/s/0hIu/YmQSN4IAFxPrrJ2lYuXpDbDIvt0GJtJpOXkrV39AaWUlVkwMFeTC5POjOB0Y580ajVhbq14S7MFUELY3kyaudZ2FrKod5Yn3sjZiOPUxbZYKkjnh/5md98qGJsF1zCHdaRDmUGm1wvq3fhvnJRcvNPiAAhG1Pvc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4971.eurprd08.prod.outlook.com (10.255.19.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Thu, 26 Sep 2019 14:07:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 14:07:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 17/22] iotests: Add VM.assert_block_path()
Thread-Topic: [PATCH 17/22] iotests: Add VM.assert_block_path()
Thread-Index: AQHVb8qng16jD1DLk0mMEq10srCWrqc+B8EA
Date: Thu, 26 Sep 2019 14:07:04 +0000
Message-ID: <de0a9fe2-ea84-7be9-6911-b806f032cfff@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-18-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-18-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::43) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926170702128
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f47ed69b-fa81-41c3-32a0-08d7428acf2a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4971; 
x-ms-traffictypediagnostic: DB8PR08MB4971:
x-microsoft-antispam-prvs: <DB8PR08MB4971B055DCB9C661D0DC56A0C1860@DB8PR08MB4971.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(136003)(39850400004)(366004)(189003)(199004)(81156014)(6436002)(11346002)(8676002)(476003)(52116002)(6506007)(2616005)(76176011)(71190400001)(102836004)(71200400001)(31696002)(5660300002)(386003)(4326008)(99286004)(2501003)(31686004)(26005)(86362001)(3846002)(256004)(6116002)(66446008)(64756008)(66556008)(6486002)(229853002)(66946007)(6246003)(66476007)(14454004)(36756003)(66066001)(6512007)(25786009)(478600001)(186003)(81166006)(446003)(305945005)(7736002)(2906002)(316002)(486006)(110136005)(54906003)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4971;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hBkmsBF1vae5vxm1vQabYDohiecXEDw+otwlNOfFODE9eAHD3nHyC3wIi3oICNubfGD0gnRzPDBBwKhmZhg/HMJD6i70GYg9DwM1AVyLIFeBR8MbizRc3THHG/LvOzncADWtf8xfMQ1emGZzERdJb9Ze0cc75YLA8eXl+24RItBMD6g0rWKg8oGzv054qDHV2RlH8yPo1LWL3H/S3Gf2qef+finlxHxmxnNVcOBtv+lM8F+aup7Jb018JgfbseZFTedRuziFa5UjSmHehlYLfNqLdrL6s/58drgqpEQJ2JJDjVe11+MICz4JZETR2n3lCVLZuldkne+n1vSI12+Y8FM2fn2g90TZcPOdP9TdbwTvUcqnTyP9tMkQ3UTzNWMYTcq0I37s/CiBhQdjSg932MWDBceNjVnswBmfpYDeZ3Q=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F64D62545CF7D54EADEA89E976B61EF2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ed69b-fa81-41c3-32a0-08d7428acf2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:07:04.6715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEQWn7SpKWTMK9bgbDvE/JEu+Wg4Q7GftBweOXVWE0sgEbLBJoP0hME7aNJwV2OL6W62ZULsFytEWZR0H08yCVcMYvPr/AVOFLl3inwuq2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4971
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.134
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weSB8IDQ4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0
cy9xZW11LWlvdGVzdHMvaW90ZXN0cy5weSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5
DQo+IGluZGV4IGRhZWQ0ZWUwMTMuLmU2ZmI0NjI4N2QgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3Rz
LnB5DQo+IEBAIC02NzAsNiArNjcwLDU0IEBAIGNsYXNzIFZNKHF0ZXN0LlFFTVVRdGVzdE1hY2hp
bmUpOg0KPiAgIA0KPiAgICAgICAgICAgcmV0dXJuIGZpZWxkcy5pdGVtcygpIDw9IHJldC5pdGVt
cygpDQo+ICAgDQo+ICsgICAgJycnDQo+ICsgICAgQHBhdGggaXMgYSBzdHJpbmcgd2hvc2UgY29t
cG9uZW50cyBhcmUgc2VwYXJhdGVkIGJ5IHNsYXNoZXMuDQo+ICsgICAgVGhlIGZpcnN0IGNvbXBv
bmVudCBpcyBhIG5vZGUgbmFtZSwgdGhlIHJlc3QgYXJlIGNoaWxkIG5hbWVzLg0KPiArICAgIEV4
YW1wbGVzOg0KPiArICAgICAgLSAicWNvdzItbm9kZS9iYWNraW5nL2ZpbGUiDQo+ICsgICAgICAt
ICJxdW9ydW0tbm9kZS9jaGlsZHJlbi4yL2ZpbGUiDQoNClBvc3NpYmx5LCBzZXBhcnRpbmcgbm9k
ZS1uYW1lIHRvIGZpcnN0IHBhcmFtZXRlciBhbmQga2VlcGluZyBjaGlsZC1wYXRoIGFzDQphIHNl
Y29uZCB3aWxsIHNpbXBsaWZ5IGNvZGUgYSBiaXQsIGFuZCBiZSBtb3JlIHVzZWZ1bCBmb3IgY2Fz
ZXMgd2hlbiBvbiBjYWxsZXINCnBhcnQgbm9kZS1uYW1lIGlzIGluIHZhcmlhYmxlLg0KDQo+ICsN
Cj4gKyAgICBAZXhwZWN0ZWRfbm9kZSBtYXkgYmUgTm9uZS4NCj4gKw0KPiArICAgIEBncmFwaCBt
YXkgYmUgTm9uZSBvciB0aGUgcmVzdWx0IG9mIGFuIHgtZGVidWctcXVlcnktYmxvY2stZ3JhcGgN
Cj4gKyAgICBjYWxsIHRoYXQgaGFzIGFscmVhZHkgYmVlbiBwZXJmb3JtZWQuDQo+ICsgICAgJycn
DQo+ICsgICAgZGVmIGFzc2VydF9ibG9ja19wYXRoKHNlbGYsIHBhdGgsIGV4cGVjdGVkX25vZGUs
IGdyYXBoPU5vbmUpOg0KPiArICAgICAgICBpZiBncmFwaCBpcyBOb25lOg0KPiArICAgICAgICAg
ICAgZ3JhcGggPSBzZWxmLnFtcCgneC1kZWJ1Zy1xdWVyeS1ibG9jay1ncmFwaCcpWydyZXR1cm4n
XQ0KDQpZYXkhIEknbSBoYXBweSB0byBzZWUgdGhhdCBpdCdzIHVzZWZ1bC4NCg0KPiArDQo+ICsg
ICAgICAgIGl0ZXJfcGF0aCA9IGl0ZXIocGF0aC5zcGxpdCgnLycpKQ0KPiArICAgICAgICByb290
ID0gbmV4dChpdGVyX3BhdGgpDQo+ICsgICAgICAgIHRyeToNCj4gKyAgICAgICAgICAgIG5vZGUg
PSBuZXh0KG5vZGUgZm9yIG5vZGUgaW4gZ3JhcGhbJ25vZGVzJ10gaWYgbm9kZVsnbmFtZSddID09
IHJvb3QpDQo+ICsgICAgICAgIGV4Y2VwdCBTdG9wSXRlcmF0aW9uOg0KPiArICAgICAgICAgICAg
bm9kZSA9IE5vbmUNCg0KZm9yIHN1Y2ggdXNhZ2UgbmV4dCBoYXMgc2Vjb25kIG9wdGlvbmFsIGFy
Z3VtZW50OiBuZXh0KGl0ZXJhdG9yWywgZGVmYXVsdF0pDQoNCihkb24ndCB0aGluayBJIHRlYWNo
IHlvdSBQeXRob24sIGFjdHVhbGx5IHlvdSB0ZWFjaCBtZSwgYXMgYmVmb3JlIEkgZGlkbid0IGtu
b3cNCmNvcnJlY3Qgd2F5IHRvIHNlYXJjaCBmaXJzdCBlbGVtZW50IHdpdGggY29uZGl0aW9uKQ0K
DQoNCj4gKw0KPiArICAgICAgICBmb3IgcGF0aF9ub2RlIGluIGl0ZXJfcGF0aDoNCj4gKyAgICAg
ICAgICAgIGFzc2VydCBub2RlIGlzIG5vdCBOb25lLCAnQ2Fubm90IGZvbGxvdyBwYXRoICVzJyAl
IHBhdGgNCj4gKw0KPiArICAgICAgICAgICAgdHJ5Og0KPiArICAgICAgICAgICAgICAgIG5vZGVf
aWQgPSBuZXh0KGVkZ2VbJ2NoaWxkJ10gZm9yIGVkZ2UgaW4gZ3JhcGhbJ2VkZ2VzJ10gXA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgZWRnZVsncGFy
ZW50J10gPT0gbm9kZVsnaWQnXSBhbmQNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGVkZ2VbJ25hbWUnXSA9PSBwYXRoX25vZGUpDQoNCkhtbSBoZXJl
IHlvdSBhbGxvdyBkZWZhdWx0IFN0b3BJdGVyYXRpb24gZXhjZXB0aW9uIFsxXQ0KDQoNCj4gKw0K
PiArICAgICAgICAgICAgICAgIG5vZGUgPSBuZXh0KG5vZGUgZm9yIG5vZGUgaW4gZ3JhcGhbJ25v
ZGVzJ10gXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgbm9kZVsnaWQn
XSA9PSBub2RlX2lkKQ0KPiArICAgICAgICAgICAgZXhjZXB0IFN0b3BJdGVyYXRpb246DQo+ICsg
ICAgICAgICAgICAgICAgbm9kZSA9IE5vbmUNCg0KYWN0dWFsbHksIEkgdGhpbmsgdGhpcyB3aWxs
IG5ldmVyIGhhcHBlbiwgc28gd2UgbWF5IHNpbXBsaWZ5IGNvZGUgYW5kIGFsbG93IGl0IHRvDQp0
aHJvdyBTdG9wSXRlcmF0aW9uIGV4Y2VwdGlvbiBpbiB0aGlzIGltcG9zc2libGUgY2FzZS4uDQoN
Cj4gKw0KPiArICAgICAgICBhc3NlcnQgbm9kZSBpcyBub3QgTm9uZSBvciBleHBlY3RlZF9ub2Rl
IGlzIE5vbmUsIFwNCj4gKyAgICAgICAgICAgICAgICdObyBub2RlIGZvdW5kIHVuZGVyICVzIChi
dXQgZXhwZWN0ZWQgJXMpJyAlIFwNCj4gKyAgICAgICAgICAgICAgIChwYXRoLCBleHBlY3RlZF9u
b2RlKQ0KDQpub2RlIG1heSBiZSBOb25lIGhlcmUgb25seSBmcm9tIGxhc3QgaXRlcmF0aW9uLCBi
dXQgaXQgY2FuJ3QgaGFwcGVuOiBpZiB3ZSBoYXZlIGVkZ2UNCndpdGggY2hpbGQsIHdlJ2xsIGZv
ciBzdXJlIGhhdmUgbm9kZSB3aXRoIHN1Y2ggbm9kZS1uYW1lIGluIGdyYXBoDQoNCj4gKw0KPiAr
ICAgICAgICBhc3NlcnQgZXhwZWN0ZWRfbm9kZSBpcyBub3QgTm9uZSBvciBub2RlIGlzIE5vbmUs
IFwNCj4gKyAgICAgICAgICAgICAgICdGb3VuZCBub2RlICVzIHVuZGVyICVzIChidXQgZXhwZWN0
ZWQgbm9uZSknICUgXA0KPiArICAgICAgICAgICAgICAgKG5vZGVbJ25hbWUnXSwgcGF0aCkNCg0K
aG1tLCBzbyBleHBlY3RlZF9ub2RlPU5vbmUgbWVhbnMgd2Ugd2FudCB0byBwcm92ZSB0aGF0IHRo
ZXJlIGlzIG5vIHN1Y2ggbm9kZT8gSXQgc2hvdWxkDQpiZSBtZW50aW9uZWQgaW4gY29tbWVudCBh
Ym92ZSB0aGUgZnVuY3Rpb24uIEJ1dCB0aGlzIGRvbid0IHdvcmsgZHVlIHRvIFsxXQ0KDQo+ICsN
Cj4gKyAgICAgICAgaWYgbm9kZSBpcyBub3QgTm9uZSBhbmQgZXhwZWN0ZWRfbm9kZSBpcyBub3Qg
Tm9uZToNCj4gKyAgICAgICAgICAgIGFzc2VydCBub2RlWyduYW1lJ10gPT0gZXhwZWN0ZWRfbm9k
ZSwgXA0KPiArICAgICAgICAgICAgICAgICAgICdGb3VuZCBub2RlICVzIHVuZGVyICVzIChidXQg
ZXhwZWN0ZWQgJXMpJyAlIFwNCj4gKyAgICAgICAgICAgICAgICAgICAobm9kZVsnbmFtZSddLCBw
YXRoLCBleHBlY3RlZF9ub2RlKQ0KPiAgIA0KPiAgIGluZGV4X3JlID0gcmUuY29tcGlsZShyJyhb
XlxbXSspXFsoW15cXV0rKVxdJykNCj4gICANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K


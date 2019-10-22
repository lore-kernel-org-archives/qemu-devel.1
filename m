Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA56E205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YadH1Mgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA56E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMruc-0002Bo-Pr
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMrsh-0001L1-2R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iMrsf-0000MN-3T
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:59:14 -0400
Received: from mail-eopbgr150095.outbound.protection.outlook.com
 ([40.107.15.95]:24591 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iMrse-0000LL-Cd; Tue, 22 Oct 2019 06:59:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBzx1cYyhbaiTzSlPuYqeld0wKEQwKwD0g/PlKaCEGrWKe3SymYe3Gshwt0cKhz6o7L/0hLk7UYHyturCgrwr4BfqKRgdjzss5hLZTzDy0Evyl63SyEglbxRwhKoFdn6KdeCp3F9Yn6/vvfYfwCSfsJrx0DxBE1IFd8g5n+g1ItgUh7Uzo8YjqSlXM8V45dHoXsZZ/rmzsZPrUcO55dXldwp/xyFukkXtFta1m2B9uQBKkwJGkyY0QYJo9otJg3nKnpTQqWlqokGhqcQyiGlsbVkERDc5FxRa7N0u3M1NO1lwgfS2zZ+BF7NJVe+5Xp6DGHYkh9iB5IiNEZy7T/2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQGwSdrkP/VBI658xFsszQbtXGiTLnZqLr/Lprg0c4w=;
 b=Ut9xW34lP/Q55M0HSsqT1d9de717l8vw3QUUYL0VHfSIaMxoby+mAWyoNOY3roOn1TCAHX0Z2arfEiN8tGlF3UE7z5rT0UrJ6ki8wl7MlbIjkEEkMduiAMb0LHagLRiXi9mHSZjdV7Ldx0qoGi1Td3f+pmKBxwqEVB9z7yQsFuIyL9xmhqUNn4/H/uU0/jlpGJvAgqAM+QE5S85TI2WOhKAEgkgrzwPkGQcKIUUybDbC5gO9NtNIt49G4YEtYuUhTsgLZN2mUcsuJJrfEeeQEwYAkAHVZTMtdIPr+WmPpdibw224SCQYCeEYD4eXa5Wds01+mRpAOsdVCIEfVuehrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQGwSdrkP/VBI658xFsszQbtXGiTLnZqLr/Lprg0c4w=;
 b=YadH1MgrhL+5JhRV7YXCitJaatA4Q9TzQZx/+vaZel2OpM5IMfHK8Gnk60ZaIJ0urjrg21Tk/OYOYHxvOq0z6hlS75eiLjqS3pCd3U1YBGRh/cvUlc960EdepRFBDXRc94Cfo1ag5i2hvenqzht7oelzp0oXllShx8pI21D7xHk=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3890.eurprd08.prod.outlook.com (20.178.82.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 22 Oct 2019 10:59:10 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 10:59:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 4/6] util: introduce SharedResource
Thread-Topic: [PATCH v2 4/6] util: introduce SharedResource
Thread-Index: AQHVhERwAV9Z2/5fC0SUTVrAXsbBe6dmfPOAgAAJ+AA=
Date: Tue, 22 Oct 2019 10:59:10 +0000
Message-ID: <4a5ca249-4479-3487-5281-dcc398510453@virtuozzo.com>
References: <20191016170905.8325-1-vsementsov@virtuozzo.com>
 <20191016170905.8325-5-vsementsov@virtuozzo.com>
 <111b7d67-ab40-1015-a45a-8440b6361633@redhat.com>
In-Reply-To: <111b7d67-ab40-1015-a45a-8440b6361633@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::26) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191022135908051
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af4f5ab-aaf3-47be-b629-08d756deddcb
x-ms-traffictypediagnostic: AM0PR08MB3890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3890371B87370F72112FA9E2C1680@AM0PR08MB3890.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39840400004)(199004)(189003)(446003)(2616005)(186003)(6246003)(107886003)(6512007)(54906003)(52116002)(14444005)(2501003)(76176011)(86362001)(256004)(110136005)(4326008)(36756003)(6436002)(229853002)(14454004)(11346002)(476003)(486006)(478600001)(26005)(6116002)(99286004)(3846002)(102836004)(316002)(6486002)(31686004)(386003)(6506007)(53546011)(7736002)(305945005)(66476007)(66556008)(64756008)(66066001)(31696002)(8936002)(2906002)(66946007)(71190400001)(8676002)(81156014)(81166006)(71200400001)(25786009)(5660300002)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3890;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4GFfHY7HDpN4d9EJ7FPqrPt3kXrbfPyYVjkHbxyQFjRCmllUlPZPSJe8atIJW0so1uzVI/YzSDIF/IBNE9h1IO07cjzutUWQkadYBDIlfMSi8MpKwg1PCP+1HRqDdxfLSBNhgxKH/1ivtm2umVMneCdyO3JKYXWKBxBfFk0LCejCs0U/UCvZctUUcXypU4Xl+HWjVVq0dsGwkPnflptfySPI1EcjuAq+9W1TxfoiK7PRyIZL6lZRyPUAGYNJugf+w/Fa6BepWtkG4rv/aAKsQk7k3PnX6RKLozmE+w/ffgF7flPsnEsQYvd1boTlEOBnqTboJUmQptvcYe737hctQxdHNrt81gFDxIJUSf5BK8bDzj7PsIwq/d72Zt/Gj/8/91/XvQfFs+FYj1ROsD/X32EainSgWs66qph4AqAGtZAVot4BCNE8PxAGib3+7doq
Content-Type: text/plain; charset="utf-8"
Content-ID: <D47B74B9BFBDBB4C8B0DCC9CC6AFE587@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af4f5ab-aaf3-47be-b629-08d756deddcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 10:59:10.1247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJfh50DUQsFVPUEKUSj9CFJlSqySsw1kuozpp8oGbIqe9jICO5ePxxbJOAPUiTq2siCsXMcKWt+ZIzLO0M3M+/VHohGLsFRQTEIIucKPN9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3890
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.95
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

MjIuMTAuMjAxOSAxMzoyMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNi4xMC4xOSAxOTowOSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEludHJvZHVjZSBhbiBBUEkg
Zm9yIHNvbWUgc2hhcmVkIHNwbGl0dGFibGUgcmVzb3VyY2UsIGxpa2UgbWVtb3J5Lg0KPj4gSXQn
cyBnb2luZyB0byBiZSB1c2VkIGJ5IGJhY2t1cC4gQmFja3VwIHVzZXMgYm90aCByZWFkL3dyaXRl
IGlvIGFuZA0KPj4gY29weV9yYW5nZS4gY29weV9yYW5nZSBtYXkgY29uc3VtZSBtZW1vcnkgaW1w
bGljdGx5LCBzbyB0aGUgbmV3IEFQSSBpcw0KPj4gYWJzdHJhY3Q6IGl0IGRvZXNuJ3QgYWxsb2Nh
dGUgYW55IHJlYWwgbWVtb3J5IGJ5IGJ1dCBvbmx5IGhhbmRzIG91dA0KPiANCj4gLWJ5DQo+IA0K
Pj4gdGlja2V0cy4NCj4+DQo+PiBUaGUgaWRlYSBpcyB0aGF0IHdlIGhhdmUgc29tZSB0b3RhbCBh
bW91bnQgb2Ygc29tZXRoaW5nIGFuZCBjYWxsZXJzDQo+PiBzaG91bGQgd2FpdCBpbiBjb3JvdXRp
bmUgcXVldWUgaWYgdGhlcmUgaXMgbm90IGVub3VnaCBvZiB0aGUgcmVzb3VyY2UNCj4+IGF0IHRo
ZSBtb21lbnQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvcWVt
dS9jby1zaGFyZWQtcmVzb3VyY2UuaCB8IDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+PiAgIHV0aWwvcWVtdS1jby1zaGFyZWQtcmVzb3VyY2UuYyAgICB8IDc2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAgdXRpbC9NYWtlZmlsZS5vYmpzICAgICAgICAgICAg
ICAgIHwgIDEgKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDE0OCBpbnNlcnRpb25zKCspDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3FlbXUvY28tc2hhcmVkLXJlc291cmNlLmgNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvcWVtdS1jby1zaGFyZWQtcmVzb3VyY2UuYw0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvY28tc2hhcmVkLXJlc291cmNlLmggYi9pbmNs
dWRlL3FlbXUvY28tc2hhcmVkLXJlc291cmNlLmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
PiBpbmRleCAwMDAwMDAwMDAwLi4wNGM5YzNkNWJlDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysg
Yi9pbmNsdWRlL3FlbXUvY28tc2hhcmVkLXJlc291cmNlLmgNCj4+IEBAIC0wLDAgKzEsNzEgQEAN
Cj4+ICsvKg0KPj4gKyAqIEhlbHBlciBmdW5jdGlvbmFsaXR5IGZvciBkaXN0cmlidXRpbmcgYSBm
aXhlZCB0b3RhbCBhbW91bnQgb2YNCj4+ICsgKiBhbiBhYnN0cmFjdCByZXNvdXJjZSBhbW9uZyBt
dWx0aXBsZSBjb3JvdXRpbmVzLg0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChjKSAyMDE5IFZp
cnR1b3p6byBJbnRlcm5hdGlvbmFsIEdtYkgNCj4+ICsgKg0KPj4gKyAqIFBlcm1pc3Npb24gaXMg
aGVyZWJ5IGdyYW50ZWQsIGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBh
IGNvcHkNCj4+ICsgKiBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRp
b24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8gZGVhbA0KPj4gKyAqIGluIHRoZSBTb2Z0d2Fy
ZSB3aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uIHRoZSBy
aWdodHMNCj4+ICsgKiB0byB1c2UsIGNvcHksIG1vZGlmeSwgbWVyZ2UsIHB1Ymxpc2gsIGRpc3Ry
aWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vciBzZWxsDQo+PiArICogY29waWVzIG9mIHRoZSBTb2Z0
d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlIFNvZnR3YXJlIGlzDQo+PiAr
ICogZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9u
czoNCj4+ICsgKg0KPj4gKyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBl
cm1pc3Npb24gbm90aWNlIHNoYWxsIGJlIGluY2x1ZGVkIGluDQo+PiArICogYWxsIGNvcGllcyBv
ciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuDQo+PiArICoNCj4+ICsgKiBU
SEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkg
S0lORCwgRVhQUkVTUyBPUg0KPj4gKyAqIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlU
RUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLA0KPj4gKyAqIEZJVE5FU1Mg
Rk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORCBOT05JTkZSSU5HRU1FTlQuIElOIE5PIEVWRU5U
IFNIQUxMDQo+PiArICogVEhFIEFVVEhPUlMgT1IgQ09QWVJJR0hUIEhPTERFUlMgQkUgTElBQkxF
IEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1IgT1RIRVINCj4+ICsgKiBMSUFCSUxJVFksIFdIRVRI
RVIgSU4gQU4gQUNUSU9OIE9GIENPTlRSQUNULCBUT1JUIE9SIE9USEVSV0lTRSwgQVJJU0lORyBG
Uk9NLA0KPj4gKyAqIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9S
IFRIRSBVU0UgT1IgT1RIRVIgREVBTElOR1MgSU4NCj4+ICsgKiBUSEUgU09GVFdBUkUuDQo+PiAr
ICovDQo+PiArDQo+PiArI2lmbmRlZiBRRU1VX0NPX1NIQVJFRF9BTU9VTlRfSA0KPj4gKyNkZWZp
bmUgUUVNVV9DT19TSEFSRURfQU1PVU5UX0gNCj4gDQo+IFlvdSBzaG91bGQgcHJvYmFibHkgYWRq
dXN0IHRoZXNlIGluY2x1ZGUgZ3VhcmRzIHRvIG1hdGNoIHRoZSBuZXcgZmlsZW5hbWUuDQo+IA0K
PiBXaXRoIHRob3NlIGJpdHMgZml4ZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogTWF4IFJlaXR6IDxt
cmVpdHpAcmVkaGF0LmNvbT4NCj4gDQoNClRoYW5rIGZvciByZXZpZXdpbmchIEknbGwgZml4IGl0
IGFuZCByZXNlbmQuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


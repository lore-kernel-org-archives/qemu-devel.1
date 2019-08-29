Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11907C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C920F20828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FqkCUqoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C920F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3I9a-0000j3-Ul
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i3I0d-0006J9-Hb
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i3I0a-0005Rj-DB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:50:31 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com
 ([40.107.8.105]:63214 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i3I0U-0005Kq-R2; Thu, 29 Aug 2019 06:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5nDiOpLi5NMc688wkWiFc1iYy0zJ4WitBm5TbmNBo3eal58Fwpxf4dDdKUh59C2AdyYhysmWVUoXb4WuijPMQFKKL2eswpJWGeaywOfDwV+b0jIqa5tHmCnPozaI02SJTozTjO2cviLEAuWOab9xKXGFBdLfiMEag1PIwkpboHloR0ISB/bdc8aMS2ZhP12J5MXQnv3bX/VssQI3Ddk6Io/npSYPe/Dlu2fpM4SCfMQJoL5XyVQuvG2CI6phzfSGbY1ZRfmpvUy+ukQFTL0ZwqZS9IGEoI4NINpAEtWLKoUNpwrYFW7TIwqrWVQhM1PoAfbasW8ogoaXOckrdWDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pmj+41Rr0F+X3kJObEqK1cAbUxub0wcMR1c8bYeUu0=;
 b=Hqy8bqlPUtJg+R6LePLn0ynZMfh9Otn5KZwPf6SXbAn3jyMWR49SpHIeIhNI3fwKBQj3eUn+Vk9kRt8ysGwqUUOoKQ4nJH1QkkXmmSK6gCQjG44DkcKieqSAuvf+7aeRlMaIG/URXZExM/LkUAyMEUs0Bcgtwg5NR/GPFOx43JHrSx7oH1QEl3WvGhbtpGSPN8eDvJzMiU928e4aCTnlUuaLBmNNniHMzNSWK6Z1GhB8Jq8SH7FXYyhk5wvQFXAtYsuUu9tcSQXCQFQ97Bn4rC4XZ10dzDYQvOWft7yebd8cIzv97dQvkb0jQz939y2q3hqFQyffVeJvL5HHoaF8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pmj+41Rr0F+X3kJObEqK1cAbUxub0wcMR1c8bYeUu0=;
 b=FqkCUqoP6rSkUMzBKRBOXQwNaiVi4tXqOiWeoRsIeDWgcBFup/T43vBUUagJZK73dNbDjK10JK8VpJyhGPlVf/9N06QOnjjlifM4nJV1SCWbfYlaA7ETHk0AXMtWb24SjW0R5S+yW30jSpc2MLhRMfSLBb8iQIS1+LZNbthTJko=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3901.eurprd08.prod.outlook.com (20.178.80.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 10:50:19 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.021; Thu, 29 Aug 2019
 10:50:18 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v6 1/6] iotests: allow Valgrind checking all
 QEMU processes
Thread-Index: AQHVXCYCgs5X/6Tyuk+5nqQQCNfhG6cRMAmAgAAZrACAAK0SAA==
Date: Thu, 29 Aug 2019 10:50:18 +0000
Message-ID: <be87cbd6-4b12-0222-3825-90ef8538d7ac@virtuozzo.com>
References: <1566834628-485525-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1566834628-485525-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d04202ac-87ab-f226-0fc9-490d20f571fd@redhat.com>
 <dd9f0ef8-d24c-29c3-6c48-809c9a4ac5d8@redhat.com>
In-Reply-To: <dd9f0ef8-d24c-29c3-6c48-809c9a4ac5d8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::16)
 To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46669084-1e99-4ff9-9a15-08d72c6eae83
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3901; 
x-ms-traffictypediagnostic: VI1PR08MB3901:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB390162D3597166E554631A2FF4A20@VI1PR08MB3901.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(376002)(39850400004)(136003)(346002)(199004)(189003)(66066001)(71200400001)(478600001)(31686004)(86362001)(81156014)(81166006)(6436002)(5660300002)(6512007)(64756008)(8676002)(66556008)(53936002)(6506007)(186003)(66446008)(6306002)(66946007)(8936002)(36756003)(71190400001)(6486002)(2501003)(31696002)(52116002)(6116002)(2906002)(44832011)(3846002)(6246003)(2201001)(446003)(2616005)(26005)(476003)(25786009)(486006)(110136005)(966005)(66476007)(11346002)(14454004)(229853002)(7736002)(99286004)(54906003)(305945005)(4326008)(76176011)(256004)(53546011)(386003)(102836004)(316002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3901;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JbThrCBDDiYjOWJHKaRCNo06yUG+eNiw4zTMFIYGy3ejHwLmkV1yKtT8G/kVs1Olc+hsTar3GCFyMs0+5RopN5aZ7hejdC7QxCyCKWC5SzfgcfZYp6FtbYbz+TLvcbi8uf0ZnUjpX8F0xGO0CBzsr8GPpMInyWI7Z6D7N3U8FxmVQP8n0huQ+NAB9I1OLm8D2jfYuh1bmNAbZudvoZjR/xvoh15sMR4Wyu918LPkiH9jkqOvzDC2T9cyVhRP2qiXImuZaIly4RbQc0rCTtNJEMl4tY0Us8UJUck/WliBFfyUxXJacSD6MjJUVuEkBLmP8IANrLdDfcCZk9jLGGrDPvSAqYLrrcy+b42PZjtOnJidCS5HjJ6w22KT9p99U0iYB+IeVXbs1B7UW/lcDNN5jYO1GawhWGYYMnT5d8ED3P8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31BC620C9A2E4040ACF9CEF76ACAA001@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46669084-1e99-4ff9-9a15-08d72c6eae83
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 10:50:18.5057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: re4GMI7eEnXJJVagCjovTWHlYQ3zL10qIpE6rdt3yuCb8bm/jMFDO0rRGmEdWcY3Zvcmtxkrzp0MdqdQuJvZsad+1W+qjC2SQewtBxz1zqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3901
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.105
Subject: Re: [Qemu-devel] [PATCH v6 1/6] iotests: allow Valgrind checking
 all QEMU processes
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI5LzA4LzIwMTkgMDM6MzAsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDgvMjgvMTkg
NTo1OCBQTSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4+PiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvY29tbW9uLnJjDQo+Pj4gQEAgLTYwLDYxICs2MCwxMzIgQEAgaWYgISAuIC4vY29tbW9uLmNv
bmZpZw0KPj4+ICAgICAgIGV4aXQgMQ0KPj4+ICAgZmkNCj4+PiAgIA0KPj4+ICsjIFVuc2V0IHRo
ZSB2YXJpYWJsZXMgdG8gdHVybiBWYWxncmluZCBvZmYgZm9yIHNwZWNpZmljIHByb2Nlc3Nlcywg
ZS5nLg0KPiANCj4gVGhhdCdzIG5vdCB1bnNldHRpbmcsIHRoYXQncyBzZXR0aW5nIHRvIHRoZSBl
bXB0eSBzdHJpbmcuDQo+IA0KDQpUaGFua3MgRXJpYywgSSB3aWxsIG1ha2UgdGhlIGNvcnJlY3Rp
b24gb2YgdGhlIGNvbW1lbnQuIEFueSBzdHJpbmcgb3RoZXIgDQp0aGFuICJ5IiwgaW5jbHVkaW5n
IHRoZSBlbXB0eSBvbmUsIGZpdHMuDQoNCj4+PiArIyAkIFZBTEdSSU5EX1FFTVVfSU89IC4vY2hl
Y2sgLXFjb3cyIC12YWxncmluZCAwMTUNCj4+PiArDQo+Pj4gKzogJHtWQUxHUklORF9RRU1VX1ZN
PSd5J30NCj4+PiArOiAke1ZBTEdSSU5EX1FFTVVfSU1HPSd5J30NCj4+PiArOiAke1ZBTEdSSU5E
X1FFTVVfSU89J3knfQ0KPj4+ICs6ICR7VkFMR1JJTkRfUUVNVV9OQkQ9J3knfQ0KPj4+ICs6ICR7
VkFMR1JJTkRfUUVNVV9WWEhTPSd5J30NCj4+PiArDQo+Pg0KDQpJIGFtIGdvaW5nIHRvIG1ha2Ug
dGhlIGNoYW5nZToNCg0KOiAke1ZBTEdSSU5EX1FFTVVfVk09JFZBTEdSSU5EX1FFTVV9DQo6ICR7
VkFMR1JJTkRfUUVNVV9JTUc9JFZBTEdSSU5EX1FFTVV9DQo6ICR7VkFMR1JJTkRfUUVNVV9JTz0k
VkFMR1JJTkRfUUVNVX0NCjogJHtWQUxHUklORF9RRU1VX05CRD0kVkFMR1JJTkRfUUVNVX0NCjog
JHtWQUxHUklORF9RRU1VX1ZYSFM9JFZBTEdSSU5EX1FFTVV9DQoNCmFuZCBnZXQgcmlkIG9mIHRo
ZSBsb2NhbCBWQUxHUklORF9PTj0iJHtWQUxHUklORF9RRU1VfSINCg0Kc28gdGhhdCB0aGUgY29k
ZSB3aWxsIGJlIG9wdGltaXplZC4NCg0KPj4gSSBoYXZlIHRvIGFkbWl0IHRvIHlvdSB0aGF0IEkn
bSBub3QgZmFtaWxpYXIgd2l0aCB0aGlzIHRyaWNrLiBJJ20NCj4+IGxvb2tpbmcgaXQgdXAgYW5k
IEkgc2VlIDo9IGRvY3VtZW50ZWQsIGJ1dCBub3QgPSBhbG9uZS4NCj4gDQo+IEl0J3MgYmVlbiBh
IHJlcGVhdGVkIGNvbXBsYWludCB0byB0aGUgYmFzaCBkZXZlbG9wZXIgdGhhdCB0aGUgbWFudWFs
IGlzDQo+IGRvaW5nIGEgZGlzc2VydmljZSB0byBpdHMgdXNlcnMgYnkgbm90IGRvY3VtZW50aW5n
ICR7dmFyPXZhbH0gaW4gYW4NCj4gZWFzaWx5IHNlYXJjaGFibGUgZm9ybS4gIEl0IElTIGRvY3Vt
ZW50ZWQsIGJ1dCBvbmx5IGJ5IHZpcnR1ZSBvZg0KPiAke3Zhcjo9dmFsfSBvY2N1cnJpbmcgdW5k
ZXIgYSBzZWN0aW9uIGhlYWRlciB0aGF0IHN0YXRlczoNCj4gDQo+ICAgICAgICAgV2hlbiBub3Qg
cGVyZm9ybWluZyBzdWJzdHJpbmcgZXhwYW5zaW9uLCAgdXNpbmcgIHRoZSAgZm9ybXMNCj4gZG9j
dW1lbnRlZA0KPiAgICAgICAgIGJlbG93ICAoZS5nLiwgIDotKSwgIGJhc2ggIHRlc3RzIGZvciBh
IHBhcmFtZXRlciB0aGF0IGlzIHVuc2V0IG9yDQo+IG51bGwuDQo+ICAgICAgICAgT21pdHRpbmcg
dGhlIGNvbG9uIHJlc3VsdHMgaW4gYSB0ZXN0ICBvbmx5ICBmb3IgIGEgIHBhcmFtZXRlcg0KPiB0
aGF0ICBpcw0KPiAgICAgICAgIHVuc2V0Lg0KPiANCj4gU28gdGhlIGNob2ljZSBpcyB3aGV0aGVy
IHlvdSB3YW50IHRvIHNwZWNpYWwgY2FzZSBhIHZhcmlhYmxlIHNldCB0byBhbg0KPiBlbXB0eSBz
dHJpbmcgdGhlIHNhbWUgYXMgYW4gdW5zZXQgdmFyaWFibGUsIG9yIHRoZSBzYW1lIGFzIGEgdmFy
aWFibGUNCj4gd2l0aCBhIG5vbi1lbXB0eSB2YWx1ZS4NCj4gDQoNClRoYW5rIHlvdSBhbGwgZm9y
IHlvdXIgcmV2aWV3cyBhbmQgY29tbWVudHMuIFRoZSBwdXJwb3NlIHdoeSBJIG9taXR0ZWQgDQp0
aGUgY29sb24gaXMgdG8gYWxsb3cgYSB1c2VyIHdyaXRpbmcgdGhlIHNob3J0ZXIgY29tbWFuZCBz
eW50YXggbGlrZQ0KJCBWQUxHUklORF9RRU1VX0lPPSAuL2NoZWNrIC12YWxncmluZCA8dGVzdCM+
DQpyYXRoZXIgdGhhbg0KJCBWQUxHUklORF9RRU1VX0lPPSIgJ25vJyBvciAnb2ZmJyBvciBlbHNl
IGFueXRoaW5nIG90aGVyIHRoYW4gJ3knICIgDQouL2NoZWNrIC12YWxncmluZCA8dGVzdCM+DQpz
bywgbm8gbmVlZCB0byBzdHJpa2UgdGhlIFNoaWZ0IGtleSB0d2ljZSBhbmQgZ3Vlc3MgYXQgd2hh
dCBlbHNlIGlzIA0KYWNjZXB0YWJsZSB0byB0eXBlICkpKQ0KDQpUaGUgdmFyaWFibGUgZGVmYXVs
dCB2YWx1ZSAneScgbG9va3MgZ29vZCB0byBtZSB0byBpbXBsZW1lbnQgdGhlIG5ldyANCmZ1bmN0
aW9uYWxpdHkgdGhhdCBpcyBjb21wYXRpYmxlIHdpdGggdGhlIGV4aXN0aW5nIG9uZSB3aGVuIHdl
IGp1c3Qgc2V0IA0KdGhlICctdmFsZ3JpbmQnIHN3aXRjaC4gVGhlIGdlbmVyYWwgaWRlYSBiZWhp
bmQgdXNpbmcgdGhlIFZhbGdyaW5kIGlzIHRvIA0KbWFrZSBhIGNhcmVmdWwgc2VhcmNoIGZvciBt
ZW1vcnkgaXNzdWVzLiBPbmNlIGZvdW5kLCBhIHVzZXIgY2FuIHR1bmUgdGhlIA0KcGFydGljdWxh
ciB0ZXN0IHdpdGggZXh0cmEgdmFyaWFibGVzIHRvIHNhdmUgdGhlaXIgZGV2ZWxvcG1lbnQvdGVz
dGluZyANCnRpbWUgYXMgSm9obiBzdWdnZXN0ZWQuIEFsc28sIG5vIG5lZWQgdG8gc3BlY2lmeSBh
bGwgdGhlIGZpdmUgbG9uZyBuYW1lIA0KdmFyaWFibGVzIGVhY2ggdGltZSBhIHVzZXIgd3JpdGVz
IHRoZSBjb21tYW5kIGlmIGRlZmF1bHQgdmFsdWVzIGFyZW4ndCBzZXQuDQoNCkkgYW0gZmxleGli
bGUgdG8gbWFrZSBhIGNoYW5nZSB0aGF0IGlzIGdvb2QgZm9yIGFsbC4gU28sIHdoYXQgc29sdXRp
b24gDQp3aWxsIHdlIGNvbWUgdG8/DQoNCkFuZHJleQ0KDQo+Pg0KPj4gSXQgZG9lc24ndCBzZWVt
IGRvY3VtZW50ZWQgaGVyZSBhdCBhbGw6DQo+PiBodHRwczovL3d3dy5nbnUub3JnL3NvZnR3YXJl
L2Jhc2gvbWFudWFsL2h0bWxfbm9kZS9TaGVsbC1QYXJhbWV0ZXItRXhwYW5zaW9uLmh0bWwNCj4+
DQo+PiBJIHNlZSBpdCBoZXJlLCB0aG91Z2g6DQo+PiBodHRwczovL3d3dy50bGRwLm9yZy9MRFAv
YWJzL2h0bWwvcGFyYW1ldGVyLXN1YnN0aXR1dGlvbi5odG1sDQo+Pg0KPj4gQW5kIGl0IHNlZW1z
IHRvIHdvcmssIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhpcyB3b3JrcyB3aXRoIEJTRCBvciBPU1gn
cw0KPj4gc2guIEkgc2VlIEVyaWMgY29tbWVudCBvbiB0aGF0IGNvbXBhdGliaWxpdHkgYSBsb3Qs
IHNvIG1heWJlIEknbGwgbGV0DQo+PiBoaW0gY2hpbWUgaW4uDQo+IA0KPiBJdCdzIHF1aXRlIHBv
cnRhYmxlOyBQT1NJWCByZXF1aXJlcyBpdCwgYW5kIGF1dG9jb25mIHJlbGllcyBvbiBpdC4NCj4g
DQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==


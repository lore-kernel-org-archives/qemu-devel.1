Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA4C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F83207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kXZhpAxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F83207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNYa-0007xW-6v
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGNXJ-0007Rg-DW
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iGNXH-0004Id-NQ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:22:20 -0400
Received: from mail-eopbgr50115.outbound.protection.outlook.com
 ([40.107.5.115]:65358 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iGNXD-0004HE-Vp; Fri, 04 Oct 2019 09:22:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMp6xcgv9ZiEWi/AvOEFZYzj3js5LURWIPH/GH8i4/yOpdSnBhY8q+WjRGmQQdm8wP0D+/hfhkaCrax9jnbM2w2SKsGvb/mDIODnZBNK5xX3XVLWKfQdbVTTLUQf2il9IYuY+DNlApmhru5xHuA9pEXwPNE25mQTziEalIjhtHUdGzBqzRXXDlD/TFT5Taq8edn6Ug0igG2llD60ZZNNbJpRRk4z4MNvqFD7/u8bKHh5vMx46/D4xaBfbXiYtA+jFcRMX6sQTQqlFSdLnGXyzisua5I54nvFJ07dGZbMXZjff7MfklMWbr1oxYft+z8bRY5PsxEVCQ5ctiFAluE+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqtZ7XZrimfsWX2OdAIXpIak+ju2xpralUZ4ysfF70Y=;
 b=EqOhhnZIai9kqiekPvSy4NJ2blLZqXc5n5b6v2bJZa/FhWuphe7dJAFuI5a+0OGP9bQnEB8NFFTe6iQ/ALt1LHX3yhphwh3Sb21OOMopw2ahYDSmBX6VwxTa8TjaUVlV7277H4fEhK5uRX8I6ZqsV/RXtRczjJxGAZVewEszPbogh6+gQwVBouuHo6MQCxbUY7ymR4PP7wO0GJBk9GGDhMjWW+jVUbIAyevfYFjxJN9j6+1n+t41x466ynwL9JEFU/GDmTBcTF3CQJyfporYdqrMlkUy2le7LD8k5H8HibDnpHPNn/0OBrbpEZgbX+Htk7Cb2L+7Ac9nlsEY/vhiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqtZ7XZrimfsWX2OdAIXpIak+ju2xpralUZ4ysfF70Y=;
 b=kXZhpAxpMEHH1rBtLoemUk3i2bhwyIVfK81uJ7jsSMhO9rKDJlEZqc85Jj9qrCK96d7y0q7fWRkhem421cI4oumIx2MO73Su2L3p57PuJhwiaq+GcxFBkwwXymB1A6Z109iGc9nTAD58GnXuBonBBBfy918gPPao/Scv6CZORnE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5500.eurprd08.prod.outlook.com (52.133.243.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 13:22:12 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 13:22:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
Thread-Topic: [PATCH 3/4] block/mirror: support unaligned write in active
 mirror
Thread-Index: AQHVaXyqGWMlukZLJkOXoRVirVbRLqdHkGAAgAA0KAD//857AIAADO6AgAFa8ICAAZlDgIAABlQA
Date: Fri, 4 Oct 2019 13:22:12 +0000
Message-ID: <3193c71d-cd5e-fa94-4dc1-dc8ebbe9ce22@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
 <7dec596f-0175-951e-ba3f-2eb8b2a3d8ed@redhat.com>
 <9a857f23-73b0-44c1-dde2-ac68d45dcf93@virtuozzo.com>
 <62e03b60-b9cb-9e59-f876-df40bba96ca0@virtuozzo.com>
 <3dc81329-443a-288c-0ea1-4190dfc33f5e@redhat.com>
 <5b267415-519f-f4ca-29d0-1bc9753b29f3@virtuozzo.com>
 <292e7686-5440-fdf3-cda3-a0e1f1968089@redhat.com>
In-Reply-To: <292e7686-5440-fdf3-cda3-a0e1f1968089@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191004162208742
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d51db516-3107-4c8f-0b80-08d748cddd94
x-ms-traffictypediagnostic: DB8PR08MB5500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5500BF43420F4D18795AD698C19E0@DB8PR08MB5500.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(396003)(346002)(376002)(136003)(199004)(189003)(2616005)(6436002)(36756003)(6486002)(53546011)(6512007)(11346002)(229853002)(25786009)(86362001)(31686004)(4326008)(256004)(7736002)(107886003)(6246003)(446003)(99286004)(2501003)(66066001)(71200400001)(5660300002)(186003)(71190400001)(66556008)(64756008)(2906002)(3846002)(66946007)(66446008)(6116002)(66476007)(52116002)(478600001)(81166006)(81156014)(6506007)(386003)(26005)(316002)(76176011)(54906003)(8676002)(14444005)(486006)(476003)(102836004)(14454004)(110136005)(8936002)(305945005)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5500;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTPOkNQ0xwAB6OjsHZyHMWc90m9ARDmnKtFTqQbRfesWXBcdolcVtpjzPoObRfAw2wTaU5bo+IAKj+mqoq8i+0c12Xvz/jLQL8EKTPrXrusHB+o6ktVTzN6HQ0C43QQ/B1yCjz4dr1S2pL53IGfc4JN3pd2/DEEugua+pu/55f7S3yuLNkUey84q1KAFG01h8vflG+L81hXOgqqSqkS1+fOU6aNjLX3l20iXl90Z2Tsgn/Uzx3Fv9AYF+c+dw+1Yp8/oF1l54/ln/dOsbM01Joq6XQoVBMCWezR5iUEfJ6tGs7ggzf6JCZYjx+50vDTDqr1kZQzVmYC73j0eycQk07BLSEtttxQvP+AAlyyXUXSlreSe6QouekVOrB10NEXIV7iusthdGUJAxajkFQlf6mVkrHaKE2hkw2ZqmbzM5tw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3C8A37AF434CD46AF6641491C6543B2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51db516-3107-4c8f-0b80-08d748cddd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 13:22:12.1759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kh+1Q7xhcSwlpLEQ1JXEOdJ76+VMM0XgEapopOTF/ior0QD9TB0gskISMOQ5wG2dS7xQ/2Uqn1PE6I2gEtFsEEbzYXCYXPpqhvEzMDNdJzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5500
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.115
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

MDQuMTAuMjAxOSAxNTo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMy4xMC4xOSAxMTozNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAyLjEwLjIwMTkgMTg6NTIs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMi4xMC4xOSAxNzowNiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMDIuMTAuMjAxOSAxODowMywgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IDAyLjEwLjIwMTkgMTc6NTcsIE1heCBSZWl0
eiB3cm90ZToNCj4+Pj4+PiBPbiAxMi4wOS4xOSAxNzoxMywgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4gUHJpb3IgOWFkYzFjYjQ5YWY4ZCBkb19zeW5jX3Rhcmdl
dF93cml0ZSBoYWQgYSBidWc6IGl0IHJlc2V0IGFsaWduZWQtdXANCj4+Pj4+Pj4gcmVnaW9uIGlu
IHRoZSBkaXJ0eSBiaXRtYXAsIHdoaWNoIG1lYW5zIHRoYXQgd2UgbWF5IG5vdCBjb3B5IHNvbWUg
Ynl0ZXMNCj4+Pj4+Pj4gYW5kIGFzc3VtZSB0aGVtIGNvcGllZCwgd2hpY2ggYWN0dWFsbHkgbGVh
ZHMgdG8gcHJvZHVjaW5nIGNvcnJ1cHRlZA0KPj4+Pj4+PiB0YXJnZXQuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IFNvIDlhZGMxY2I0OWFmOGQgZm9yY2VkIGRpcnR5IGJpdG1hcCBncmFudWxhcml0eSB0byBi
ZQ0KPj4+Pj4+PiByZXF1ZXN0X2FsaWdubWVudCBmb3IgbWlycm9yLXRvcCBmaWx0ZXIsIHNvIHdl
IGFyZSBub3Qgd29ya2luZyB3aXRoDQo+Pj4+Pj4+IHVuYWxpZ25lZCByZXF1ZXN0cy4gSG93ZXZl
ciBmb3JjaW5nIGxhcmdlIGFsaWdubWVudCBvYnZpb3VzbHkgZGVjcmVhc2VzDQo+Pj4+Pj4+IHBl
cmZvcm1hbmNlIG9mIHVuYWxpZ25lZCByZXF1ZXN0cy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhpcyBj
b21taXQgcHJvdmlkZXMgYW5vdGhlciBzb2x1dGlvbiBmb3IgdGhlIHByb2JsZW06IGlmIHVuYWxp
Z25lZA0KPj4+Pj4+PiBwYWRkaW5nIGlzIGFscmVhZHkgZGlydHksIHdlIGNhbiBzYWZlbHkgaWdu
b3JlIGl0LCBhcw0KPj4+Pj4+PiAxLiBJdCdzIGRpcnR5LCBpdCB3aWxsIGJlIGNvcGllZCBieSBt
aXJyb3JfaXRlcmF0aW9uIGFueXdheQ0KPj4+Pj4+PiAyLiBJdCdzIGRpcnR5LCBzbyBza2lwcGlu
ZyBpdCBub3cgd2UgZG9uJ3QgaW5jcmVhc2UgZGlydGluZXNzIG9mIHRoZQ0KPj4+Pj4+PiAgIMKg
wqDCoCBiaXRtYXAgYW5kIHRoZXJlZm9yZSBkb24ndCBkYW1hZ2UgInN5bmNocm9uaWNpdHkiIG9m
IHRoZQ0KPj4+Pj4+PiAgIMKgwqDCoCB3cml0ZS1ibG9ja2luZyBtaXJyb3IuDQo+Pj4+Pj4NCj4+
Pj4+PiBCdXQgdGhhdOKAmXMgbm90IHdoYXQgYWN0aXZlIG1pcnJvciBpcyBmb3IuwqAgVGhlIHBv
aW50IG9mIGFjdGl2ZSBtaXJyb3IgaXMNCj4+Pj4+PiB0aGF0IGl0IG11c3QgY29udmVyZ2UgYmVj
YXVzZSBldmVyeSBndWVzdCB3cml0ZSB3aWxsIGNvbnRyaWJ1dGUgdG93YXJkcw0KPj4+Pj4+IHRo
YXQgZ29hbC4NCj4+Pj4+Pg0KPj4+Pj4+IElmIHlvdSBza2lwIGFjdGl2ZSBtaXJyb3JpbmcgZm9y
IHVuYWxpZ25lZCBndWVzdCB3cml0ZXMsIHRoZXkgd2lsbCBub3QNCj4+Pj4+PiBjb250cmlidXRl
IHRvd2FyZHMgY29udmVyZ2luZywgYnV0IGluIGZhY3QgbGVhZCB0byB0aGUgb3Bwb3NpdGUuDQo+
Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBUaGUgd2lsbCBub3QgY29udHJpYnV0ZSBvbmx5IGlmIHJlZ2lv
biBpcyBhbHJlYWR5IGRpcnR5LiBBY3R1YWxseSwgYWZ0ZXINCj4+Pj4+IGZpcnN0IGl0ZXJhdGlv
biBvZiBtaXJyb3JpbmcgKGNvcHlpbmcgdGhlIHdob2xlIGRpc2spLCBhbGwgZm9sbG93aW5nIHdy
aXRlcw0KPj4+Pj4gd2lsbCBjb250cmlidXRlLCBzbyB0aGUgd2hvbGUgcHJvY2VzcyBtdXN0IGNv
bnZlcmdlLiBJdCBpcyBhIGJpdCBzaW1pbGFyIHdpdGgNCj4+Pj4+IHJ1bm5pbmcgb25lIG1pcnJv
ciBsb29wIGluIG5vcm1hbCBtb2RlLCBhbmQgdGhlbiBlbmFibGUgd3JpdGUtYmxvY2tpbmcuDQo+
Pj4+Pg0KPj4+Pg0KPj4+Pg0KPj4+PiBJbiBvdGhlciB3b3Jkcywgd2UgZG9uJ3QgbmVlZCAiYWxs
IGd1ZXN0IHdyaXRlcyBjb250cmlidXRlIiB0byBjb252ZXJnZSwNCj4+Pj4gImFsbCBndWVzdCB3
cml0ZXMgZG9uJ3QgY3JlYXRlIG5ldyBkaXJ0eSBiaXRzIiBpcyBlbm91Z2gsIGFzIHdlIGhhdmUg
cGFyYWxsZWwNCj4+Pj4gbWlycm9yIGl0ZXJhdGlvbiB3aGljaCBjb250aWd1b3VzbHkgaGFuZGxl
cyBkaXJ0eSBiaXRzLg0KPj4+DQo+Pj4gSG0sIGluIGEgc2Vuc2UuICBCdXQgaXQgZG9lcyBtZWFu
IHRoYXQgZ3Vlc3Qgd3JpdGVzIHdpbGwgbm90IGNvbnRyaWJ1dGUNCj4+PiB0byBjb252ZXJnZW5j
ZS4NCj4+Pg0KPj4+IEFuZCB0aGF04oCZcyBhZ2FpbnN0IHRoZSBjdXJyZW50IGRlZmluaXRpb24g
b2Ygd3JpdGUtYmxvY2tpbmcsIHdoaWNoIGRvZXMNCj4+PiBzdGF0ZSB0aGF0IOKAnHdoZW4gZGF0
YSBpcyB3cml0dGVuIHRvIHRoZSBzb3VyY2UsIHdyaXRlIGl0IChzeW5jaHJvbm91c2x5KQ0KPj4+
IHRvIHRoZSB0YXJnZXQgYXMgd2VsbOKAnS4NCj4+Pg0KPj4NCj4+IEhtbSwgdW5kZXJzdGFuZC4g
QnV0IElNSE8gb3VyIHByb3Bvc2VkIGJlaGF2aW9yIGlzIGJldHRlciBpbiBnZW5lcmFsLg0KPj4g
RG8geW91IHRoaW5rIGl0J3MgYSBwcm9ibGVtIHRvIGNoYW5nZSBzcGVjIG5vdz8NCj4+IElmIHll
cywgSSdsbCByZXNlbmQgd2l0aCBhbiBvcHRpb24NCj4gDQo+IFdlbGwsIHRoZSB0aGluZyBpcyB0
aGF0IEnigJlkIGZpbmQgaXQgd2VpcmQgaWYgd3JpdGUtYmxvY2tpbmcgd2FzbuKAmXQNCj4gYmxv
Y2tpbmcgaW4gYWxsIGNhc2VzLiAgQW5kIGluIG15IG9waW5pb24sIGl0IG1ha2VzIG1vcmUgc2Vu
c2UgZm9yDQo+IGFjdGl2ZSBtaXJyb3IgaWYgYWxsIHdyaXRlcyBhY3RpdmVseSBjb250cmlidXRl
ZCB0byBjb252ZXJnZW5jZS4NCj4gDQoNCldoeT8gV2hhdCBpcyB0aGUgYmVuZWZpdCBpbiBpdD8N
CldoYXQgaXMgImFsbCB3cml0ZXMgYWN0aXZlbHkgY29udHJpYnV0ZWQgdG8gY29udmVyZ2VuY2Ui
IGZvciB1c2VyPw0KDQpJIHRoaW5rIGZvciB1c2VyIHRoZXJlIG1heSBiZSB0aGUgZm9sbG93aW5n
IGNyaXRlcmlhOg0KDQoxLiBndWFyYW50ZWVkIGNvbnZlcmdlLCB3aXRoIGFueSBndWVzdCB3cml0
ZSBsb2FkLg0KQm90aCBjdXJyZW50IGFuZCBteSBwcm9wb3NlZCB2YXJpYW50cyBhcmUgT0suDQoN
CjIuIExlc3MgaW1wYWN0IG9uIGd1ZXN0Lg0KT2J2aW91c2x5IG15IHByb3Bvc2VkIHZhcmlhbnQg
aXMgYmV0dGVyDQoNCjMuIFRvdGFsIHRpbWUgb2YgbWlycm9yaW5nDQpTZWVtcywgY3VycmVudCBt
YXkgYmUgYSBiaXQgYmV0dGVyLCBidXQgSSBkb24ndCB0aGluayB0aGF0IHVuYWxpZ25lZA0KdGFp
bHMgZ2l2ZXMgc2lnbmlmaWNhbnQgaW1wYWN0Lg0KDQo9PT0NCg0KU28sIGFzc3VtZSBJIHdhbnQg
WzFdK1syXS4gQW5kIHBvc3NpYmx5DQoyLjI6IEV2ZW4gbGVzcyBpbXBhY3Qgb24gZ3Vlc3Q6IGln
bm9yZSBub3Qgb25seSB1bmFsaWduZWQgdGFpbHMgaWYgdGhleSBhcmUNCmFscmVhZHkgZGlydHks
IGJ1dCBmdWxsIHN5bmNocm9ub3VzIG1pcnJvciBvcGVyYXRpb24gaWYgYXJlYSBpcyBhbHJlYWR5
IGRpcnR5Lg0KDQpIb3cgc2hvdWxkIEkgY2FsbCB0aGlzPyBTaG91bGQgaXQgYmUgc2VwYXJhdGUg
bW9kZSwgb3Igb3B0aW9uIGZvciB3cml0ZS1ibG9ja2luZz8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K


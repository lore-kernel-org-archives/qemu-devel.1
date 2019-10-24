Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F961CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667C921872
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TaqmjA8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667C921872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNen4-00082T-Cs
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iNdmF-0004ub-OH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iNdmE-0000yd-G5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:07:47 -0400
Received: from mail-eopbgr70138.outbound.protection.outlook.com
 ([40.107.7.138]:52454 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iNdmA-0000qQ-4S; Thu, 24 Oct 2019 10:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoqWY4d2WXlRI/IxiszEiv/2aVeoYeoV0GmF2XsiFmMvKopSHq0AXYSgYKt9V7vtqbsyUw6s2G38dt410vfa6LhnwfHYBIvuUGCdWEpYyaeJLVBZjiUNLRzSmYNKSjTpx4ZpL/mLlKOjDBnbizhLjRZH68AaxeN0LaZLFFHLZq9bp+3ods7E2NZich+3LoVCVj4WcsV2hQ/wdKieflneCq6RUbzPxYlPTQjaaEev1TtV7+cuci/t+IUwBqxvagk0v8R4UiagleRsC7nkIZzLDGU3rdxGgZp5gJSTgDhvdiTu1cc2al6oEPr0BABp9bPRvoyruYokIVhJ+N07+BepJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fesfcg6Yo9aZX2Ypm3G1bol+PLmLXoxhyULa8eUj0zo=;
 b=Hcm4RT1VcYZuuM5cRSI1Sly1j5Dnu0eUj29QxPAHxqqZzW5fLW3rXvyApQUNQdywPaeeO0xOq9J1WLf28FQ1C7F8fUnh94aYL19Uj+3YK2TLBFszYMW7lFNkv+BPxa3XGGraGYG70ncJRNQzru0iBMFFeFaUA8otk4hF0+m5Mx0wAs5B9RBk4D4fJYu+05hvtqXHrZy5EwaZUGv5RxxopnTDH7RIBvQe7aemk/EvboHQ900upjSdta5Ym9CQnDdZ4YK12casFSZ4cZ3aA10sRVbFtgE6OcD1CkM/70ZkP9e3TFngAh73ft+sU7NwjC/Ni+fq7IQ/8P5Vm1oM3P9vig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fesfcg6Yo9aZX2Ypm3G1bol+PLmLXoxhyULa8eUj0zo=;
 b=TaqmjA8d6Pv9RD+kHULUR09Vjp8yyKxaECMyI5m42sATvEGUGXAMgYOobF0O68GPUOc+RWnE8u/5IeVlTva0Zp6CY/Xr9Nb+7YP9ANSW1wpJXzgkKUKwyejrhA7z5PgASE0IvQszay7SgRI3xagveFZTvnZUkO+F3W1zsSBQAnY=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2693.eurprd08.prod.outlook.com (10.170.222.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Thu, 24 Oct 2019 14:07:39 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 14:07:38 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Topic: [PATCH v5 1/4] block: support compressed write at generic layer
Thread-Index: AQHVh4YxkyM0Azl4xEijX5NTK9vhK6dmZxIAgABBJ4D//9ScgIAADIKAgAAOngCAAAlKgIAAQkoAgAKp9ICAAGq2gP//3BKAgAAFdAA=
Date: Thu, 24 Oct 2019 14:07:38 +0000
Message-ID: <26cfb4ed-941a-11b0-c1cf-bf3c7e354487@virtuozzo.com>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
 <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
 <cc3f87c2-3ad5-da4e-4750-27a48bce1ee6@virtuozzo.com>
 <787da788-9aca-2110-a092-b63ef498a9fa@redhat.com>
 <ae5bc00f-e65e-8c33-2620-a9147e48ea78@virtuozzo.com>
 <1088f0ff-d882-083f-705c-95c08bdc486f@redhat.com>
 <cb6db9c4-0dbc-9d9a-4ec5-b436c48178a8@virtuozzo.com>
 <4fd89d2a-94aa-6f2d-ed7d-7633356e5163@redhat.com>
 <539e7d9e-0cb7-fdb7-f376-1648361ec2f3@virtuozzo.com>
 <8828d08f-79aa-f3a6-4387-f1423a8b7d70@redhat.com>
In-Reply-To: <8828d08f-79aa-f3a6-4387-f1423a8b7d70@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::21) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0be78f65-b5ef-492a-5152-08d7588b8721
x-ms-traffictypediagnostic: DB6PR08MB2693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB2693D2FAA682977196D5C89AF46A0@DB6PR08MB2693.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:669;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(6486002)(2501003)(107886003)(44832011)(478600001)(14454004)(6436002)(486006)(186003)(31696002)(71200400001)(11346002)(6506007)(53546011)(2201001)(386003)(26005)(99286004)(6512007)(52116002)(102836004)(76176011)(476003)(2906002)(3846002)(6116002)(86362001)(31686004)(66066001)(2616005)(229853002)(316002)(66946007)(64756008)(66446008)(4326008)(66556008)(66476007)(446003)(71190400001)(110136005)(54906003)(5660300002)(25786009)(6246003)(8676002)(256004)(14444005)(36756003)(305945005)(7736002)(8936002)(81156014)(81166006)(41533002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2693;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNx6tjxfqrOTIitaJLKM2mfwdI++97ZZxB7+WxA/Ny9swpxK8msRlxIDUEkJaCVDHpwgKAwhpjynFSb8HdPIruHTbZRF9IuC3a7mXUD7k3Km7XGOW55iEuRnhJddtU7ee8+VVuzzhMjcYus+h1cqXq5bfnAyW28GAExV/4IVYjU4oHMpwYwFLTo2cd//m9tH5aZsDgYJmxQIbp2FdnANDm4Qo68MFfQg741Kv/DGufHwAMeBEn84XdhP34hiPyb5gXRkNsHIwkCqDh60oXp++eN1onO8AnAEudsWAHol/MpDim0wfUnWfC8LPPu0aBMrv7pxSsrRy6vMEc4VAQntRY093CGdcfu/SPkvYHUywFWiMvu1GDPj+pS4KWrbgI4mVOIPSQK1s3Gf5IKWkj41VQL8xIibU5lK6EAduK381ce9tIMFT8ay0KEMXF+Se06U
Content-Type: text/plain; charset="utf-8"
Content-ID: <71ED71E897CE0F4283FAD20CCC6FBC2B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be78f65-b5ef-492a-5152-08d7588b8721
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 14:07:38.9089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVnrA2lQ/whyoN+c209GA+iRxfm6pdAk60goD2iESlRJ0egWNgOQm02jPzKKPHep1rOkMaybgjzJrRjH9sd863IhYM11603utARyhw/I79g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2693
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.138
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI0LzEwLzIwMTkgMTY6NDgsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjQuMTAuMTkg
MTQ6NTYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAyNC8xMC8yMDE5
IDEyOjM0LCBNYXggUmVpdHogd3JvdGU6DQo+Pj4gT24gMjIuMTAuMTkgMTU6NTMsIEFuZHJleSBT
aGlua2V2aWNoIHdyb3RlOg0KPj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+PiBJZiB0aGUgc3VwcG9y
dCBvZiBDT1cgZm9yIGNvbXByZXNzZWQgd3JpdGVzIGlzIGZvdW5kIGZlYXNpYmxlLCB3aWxsIGl0
DQo+Pj4+IG1ha2UgYSBzZW5zZSB0byBpbXBsZW1lbnQ/IFRoZW4gdGhpcyBzZXJpZXMgd2lsbCBm
b2xsb3cuDQo+Pj4NCj4+PiBIbSwgd2hhdCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5IHN1cHBvcnQg
b2YgQ09XIGZvciBjb21wcmVzc2VkIHdyaXRlcz8NCj4+Pg0KPj4NCj4+IEkgc3Bva2UgaW4gdGVy
bXMgb2YgdGhlIGNvbW1pdCBtZXNzYWdlIHdpdGggdGhlIGZvbGxvd2luZyBJRDoNCj4+DQo+PiBi
MGI2ODYyZTVlMWExMzk0ZTBhYjNkNWRhOTRiYThiMGRhODY2NGUyDQo+Pg0KPj4gInFjb3cyOiBG
YWlsIHdyaXRlX2NvbXByZXNzZWQgd2hlbiBvdmVyd3JpdGluZyBkYXRhIg0KPj4NCj4+ICIuLi5x
Y293Ml93cml0ZV9jb21wcmVzc2VkKCkgZG9lc24ndCBwZXJmb3JtIENPVyBhcyBpdCB3b3VsZCBo
YXZlIHRvIGRvLi4uIg0KPj4NCj4+IFNvLCBJIHN1Z2dlc3QgdGhhdCB3ZSBpbXBsZW1lbnQgd3Jp
dGluZyBjb21wcmVzc2VkIGRhdGEgdG8gdGhlIGFsbG9jYXRlZA0KPj4gY2x1c3RlcnMgcmF0aGVy
IHRoYW4gcWNvdzJfYWxsb2NfY29tcHJlc3NlZF9jbHVzdGVyX29mZnNldCgpIHJldHVybnMgdGhl
DQo+PiBlcnJvci4gUGFydGljdWxhcmx5LCB3aGVuIGl0IGNvbWVzIHRvIE5CRCBzZXJ2ZXIgY29u
bmVjdGlvbiBmYWlsdXJlIGZvcg0KPj4gd3JpdGhpbmcgYSBjb21wcmVzc2VkIGNsdXN0ZXIsIGl0
IG1heSBub3QgYmUgcmV3cml0dGVuIGFmdGVyIHRoZQ0KPj4gY29ubmVjdGlvbiBpcyByZXN0b3Jl
ZC4NCj4+IEFyZSB0aGVyZSBhbnkgaXNzdWVzIHdpdGggdGhhdCBpbXBsZW1lbnRhdGlvbiBpZGVh
Pw0KPiANCj4gV2VsbCwgdGhlIENPVyBpbiB0aGF0IGNvbW1pdCBpcyBtZWFudCBkaWZmZXJlbnRs
eSwgYmVjYXVzZSBpdCByZWZlcnMgdG8NCj4gdGhlIENPVyB0aGF04oCZcyByZXF1aXJlZCB3aGVu
IHdyaXRpbmcgdG8gYSBjbHVzdGVyIHNoYXJlZCBieSBhbiBpbnRlcm5hbA0KPiBzbmFwc2hvdC4N
Cj4gDQo+IE9UT0gsIHlvdSBjb3VsZCBzYXkgdGhhdCBhbGwgY29tcHJlc3NlZCB3cml0ZXMgdG8g
YSBjbHVzdGVyIHRoYXQgaXMNCj4gYWxyZWFkeSBhbGxvY2F0ZWQgd291bGQgbmVlZCB0byBkbyBD
T1cgYmVjYXVzZSB3ZeKAmWQgYWx3YXlzIGhhdmUgdG8gZnVsbHkNCj4gcmV3cml0ZSB0aGF0IGNs
dXN0ZXIgaW4gYW4gUk1XIGN5Y2xlLg0KPiANCj4gSSBkb27igJl0IHNlZSBob3cgbGV0dGluZyBx
Y293Ml9hbGxvY19jb21wcmVzc2VkX2NsdXN0ZXJfb2Zmc2V0KCkgdXNlIHRoZQ0KPiBleGlzdGlu
ZyBjbHVzdGVyIHdvdWxkIHNvbHZlIHRoZSBwcm9ibGVtLCB0aG91Z2guICBZb3XigJlkIGdlbmVy
YWxseSBuZWVkDQo+IHRvIGFsbG9jYXRlIGEgbmV3IGNsdXN0ZXI7IG9yIGF0dGVtcHQgdG8gcmV1
c2UgdGhlIGV4aXN0aW5nIHNwYWNlIGluIGENCj4gY29tcHJlc3NlZCBjbHVzdGVyLg0KPiANCj4g
TWF4DQo+IA0KDQpZZXMsIG5ldyBjbHVzdGVycyB3b3VsZCBiZSBhbGxvY2F0ZWQgZm9yIHRoZSBj
b21wcmVzc2VkIFJNVyBhbmQgdGhlIA0KZXhpc3Rpbmcgb25lcyB3b3VsZCBiZSByZXVzZWQgaWYg
cG9zc2libGUuIEl0IHNlYW1zIHRvIGJlIGluZWZmZWN0aXZlIA0KYnV0IHVzZXJzIGFyZSBzdXBw
b3NlZCB0byBrbm93IHdoYXQgdGhleSBkby4NClNvLCBkb2VzIGl0IHdvcnRoIHRvIGNoZWNrIGEg
ZmVhc2liaWxpdHkgb2YgdGhlIGltcGxlbWVudGF0aW9uPw0KDQpBbmRyZXkNCg0K


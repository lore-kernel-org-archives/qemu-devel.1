Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA7EC2D0CF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0BA206CB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 07:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TbSLK2eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0BA206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijf1y-0003hE-1q
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 02:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijf1L-0003Ii-Cu
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1ijf1J-0008UQ-Gi
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:54:22 -0500
Received: from mail-eopbgr30101.outbound.protection.outlook.com
 ([40.107.3.101]:38286 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1ijf1I-0008T2-TT
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 02:54:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCOjGbo+fOSB92trDkNCJKdkkaA6rsJSOny4wm/sJmL7gt1Sz28CvOukDQS8i+tjI7ZwRF8N2Lbqy4vEgUD96e0sBzP+l+1Hu37r5w0qpB2oOT4BwVQDT4X57KzElJ0/dut7hn/oaftuwYZWMz8Aj5CmuocKMP1a21kJvQcZM/Mr7RbFZ+FCDqPhMcFPjkry6/TF57GbI6dvCHI3f3vCMhFX+YrQBkVuPMBDVO4zkbkX6IX3/D0U4WifsG4UETRArcvziaoGBbMbEUdjlBAgk8PEOr0jAuNG6GYVqGD7YA6fLhlaT8OSbafPDFiT2jfZrcA92t0K8o4OOUeeYcsnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adz3ztKT5G512aGUBEqm9nbsJrJNXTQ6EXdnm7VI6hY=;
 b=adstAEeMFwc0Csb2+wIMzvEBNu4bb+Yu5LMLuaaTuQ9bLTla0zClmcuPJo0EVY5gNvkjdLrioWMDO2kDpL233Lo/oOyL89yYylezrAaUYR44/BmAfdw62NqQTjPUKsmVN2DQWCUbaQgqOG2doNU8dPRXTtzsqJXG2FGIlV14JSSoUyqR2zvRtApN64vRvxX7p+0TPJL4+E0Q39IPf4YGkBlNVoYz9J+iOg6/L/w+3wVt3KPk4v+9DMspANYbfgBzVgHl4rUGBpbvsoUI0uQh03gLgEeAw708Fx8Wn3XrR/F1uKMWpkBRle0dCsS4FqS+r/tIe7URTBmgAdYzsrj6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adz3ztKT5G512aGUBEqm9nbsJrJNXTQ6EXdnm7VI6hY=;
 b=TbSLK2eTAIeLAsXPmDr0IgwcraqE5uMHQ47sI9p4H7O9kJMq2utCFw9EW0fWMrt94ndyNdBSZjdpHKwlSzr9kB6TAJD58w2LOoao77esP6JhPdGijZiBVpVn79RrT+TrXs2aSrhf68e1/FO0NaIYJgv/Q/ry66Ag59pJJ0Iokxk=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3956.eurprd08.prod.outlook.com (20.178.202.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Tue, 24 Dec 2019 07:54:16 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::893d:bf37:4b98:12%4]) with mapi id 15.20.2559.017; Tue, 24 Dec 2019
 07:54:16 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1] virtio-pci: store virtqueue size directly to a device
Thread-Topic: [PATCH v1] virtio-pci: store virtqueue size directly to a device
Thread-Index: AQHVuYV+qyjqIGgOCEa6U67hDNiWUKfHyFyAgAEjRAA=
Date: Tue, 24 Dec 2019 07:54:16 +0000
Message-ID: <be70a775-ade1-abfa-1fc9-2f9912966f13@virtuozzo.com>
References: <20191223113758.11951-1-dplotnikov@virtuozzo.com>
 <20191223093029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191223093029-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0045.eurprd09.prod.outlook.com
 (2603:10a6:3:45::13) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [109.168.156.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13285a11-af49-41de-196c-08d788467981
x-ms-traffictypediagnostic: AM0PR08MB3956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3956D280362760EF22D91A75CF290@AM0PR08MB3956.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(376002)(346002)(136003)(199004)(189003)(8936002)(6506007)(53546011)(6916009)(66946007)(186003)(81166006)(81156014)(2906002)(5660300002)(316002)(8676002)(6486002)(6512007)(2616005)(4326008)(86362001)(66476007)(36756003)(107886003)(54906003)(31696002)(52116002)(71200400001)(66556008)(64756008)(66446008)(478600001)(26005)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3956;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bLD/0B1g1K/X+Kixp+uosUFBs1ETS+nmvvNBFvxlUpOFW4TzMWDo/eSN45o4XA3QbXthIQdgtZc6WwPIhcNatRtp4LvlsUb5gzg5y5sv2jJVnijYEtuhd6saXfStC/6GaegrZZvl4w9aRGJPb0vVrONwnqzrwkUFjy33Gx3BnOvaqfxFpJ03eNDC6I9oLR/rnxBWYt+HQwM5bBuOkYwp314HCJbCkBq8ANfpxIsk72ktTtAmfUYH/KXHLOrmK9pky/iJp2R0kM5Kff/nRlfyePlCB92F3wDAV5keC/tNJx3elbZ1YfYsG6byb3gYmkLbdWD9LjuYaQPAvRUevIyhknYiZweIZzDvajY9K3FBxilASXBGame93tr3OkSZm0EqEPjsZj1zaJ+a+RumwA+vvFcDt1F9hkr/GbLAuOAKWSimUFe3smPv+klPtha7CBs+
Content-Type: text/plain; charset="utf-8"
Content-ID: <02A20C7139AA6743928BD8E0FA85ABF3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13285a11-af49-41de-196c-08d788467981
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 07:54:16.7024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4mQtRZFoJdns6n0ZDmaJIYL3T2JuLEEc7IK0OjX1g8VXq9ZG6pqscalhs667uzcfNURpSn11DAj2wmOWySNNgfQS2gJkyy3fWGhRkGoo4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3956
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.101
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDIzLjEyLjIwMTkgMTc6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24g
TW9uLCBEZWMgMjMsIDIwMTkgYXQgMDI6Mzc6NThQTSArMDMwMCwgRGVuaXMgUGxvdG5pa292IHdy
b3RlOg0KPj4gQ3VycmVubHksIHRoZSB2aXJ0cXVldWUgc2l6ZSBpcyBzYXZlZCB0byB0aGUgcHJv
eHkgb24gcGNpIHdyaXRpbmcgYW5kDQo+PiBpcyByZWFkIGZyb20gdGhlIGRldmljZSBwY2kgcmVh
ZGluZy4NCj4+IFRoZSB2aXJ0cXVldWUgc2l6ZSBpcyBwcm9wYWdhdGVkIGxhdGVyIG9uIGZvcm0g
dGhlIHByb3h5IHRvIHRoZSBkZXZpY2UNCj4+IG9uIHZpcnF1ZXVlIGVuYWJsaW5nIHN0YWdlLg0K
Pj4NCj4+IFRoaXMgY291bGQgYmUgYSBwcm9ibGVtLCBpZiBhIGd1ZXN0LCBvbiB0aGUgdmlydHF1
ZXVlIGNvbmZpZ3VyYXRpb24sIHNldHMNCj4+IHRoZSBzaXplIGFuZCB0aGVuIHJlLXJlYWQgaXQg
aW1tZWRpYXRseSBiZWZvcmUgdGhlIHF1ZXVlIGVuYWJsaW5nDQo+PiBpbiBvcmRlciB0byBjaGVj
ayBpZiB0aGUgZGVzaWdlZCBzaXplIGhhcyBiZWVuIHNldC4NCj4+DQo+PiBUaGlzIGhhcHBlbnMg
aW4gc2VhYmlvczogKHNlYmlvcyBzbmlwcGV0KQ0KPj4NCj4+IHZwX2ZpbmRfdnEoKQ0KPj4gew0K
Pj4gICAgICAuLi4NCj4+ICAgICAgLyogY2hlY2sgaWYgdGhlIHF1ZXVlIGlzIGF2YWlsYWJsZSAq
Lw0KPj4gICAgICBpZiAodnAtPnVzZV9tb2Rlcm4pIHsNCj4+ICAgICAgICAgIG51bSA9IHZwX3Jl
YWQoJnZwLT5jb21tb24sIHZpcnRpb19wY2lfY29tbW9uX2NmZywgcXVldWVfc2l6ZSk7DQo+PiAg
ICAgICAgICBpZiAobnVtID4gTUFYX1FVRVVFX05VTSkgew0KPj4gICAgICAgICAgICAgIHZwX3dy
aXRlKCZ2cC0+Y29tbW9uLCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcsIHF1ZXVlX3NpemUsDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgTUFYX1FVRVVFX05VTSk7DQo+PiAgICAgICAgICAgICAgbnVt
ID0gdnBfcmVhZCgmdnAtPmNvbW1vbiwgdmlydGlvX3BjaV9jb21tb25fY2ZnLCBxdWV1ZV9zaXpl
KTsNCj4+ICAgICAgICAgIH0NCj4+ICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgIG51bSA9IHZw
X3JlYWQoJnZwLT5sZWdhY3ksIHZpcnRpb19wY2lfbGVnYWN5LCBxdWV1ZV9udW0pOw0KPj4gICAg
ICB9DQo+PiAgICAgIGlmICghbnVtKSB7DQo+PiAgICAgICAgICBkcHJpbnRmKDEsICJFUlJPUjog
cXVldWUgc2l6ZSBpcyAwXG4iKTsNCj4+ICAgICAgICAgIGdvdG8gZmFpbDsNCj4+ICAgICAgfQ0K
Pj4gICAgICBpZiAobnVtID4gTUFYX1FVRVVFX05VTSkgew0KPj4gICAgICAgICAgZHByaW50Zigx
LCAiRVJST1I6IHF1ZXVlIHNpemUgJWQgPiAlZFxuIiwgbnVtLCBNQVhfUVVFVUVfTlVNKTsNCj4+
ICAgICAgICAgIGdvdG8gZmFpbDsNCj4+ICAgICAgfQ0KPj4gICAgICAuLi4NCj4+IH0NCj4+DQo+
PiBJZiB0aGUgZGV2aWNlIHF1ZXVlIG51bSBpcyBncmVhdGVyIHRoZW4gdGhlIG1heCBxdWV1ZSBz
aXplIHN1cHBvcnRlZCBieSBzZWFiaW9zLA0KPj4gc2VhYmlvcyB0cmllcyB0byByZWR1Y2UgdGhl
IHF1ZXVlIHNpemUsIHRoZW4gcmUtcmVhZCBpdCBhZ2FpbiwgSSBzdXBwb3NlIHRvDQo+PiBjaGVj
ayBpZiB0aGUgc2V0dGluZyBhY3R1YWxseSBoYXBwZW5zLCBhbmQgdGhlbiBjaGVja3MgdGhlIHZp
cnRxdWV1ZSBzaXplIGFnYWluLA0KPj4gdG8gZGVzaWRlIHdoZXRoZXIgaXQgaXMgc2F0aXNmaWVk
IHdpdGggdGhlIHZhdWxlLg0KPj4gSW4gdGhpcyBjYXNlLCBpZiBkZXZpY2UncyB2aXJ0cXVldWUg
c2l6ZSBpcyA1MTIgYW5kIHNlYWJpb3MgbWF4IHN1cHBvcnRlZCBxdWV1ZQ0KPj4gc2l6ZSBpcyAy
NTYsIHNlYWJpb3MgdHJpZXMgdG8gc2V0IDI1NiBidXQgdGhhbiByZWFkIDUxMiBhZ2FpbiBhbmQg
Y2FuJ3QgcHJvY2VlZA0KPj4gd2l0aCB0aGF0IHZhdWxlLCBwcmV2ZW50aW5nIHRoZSBndWVzdCBm
cm9tIHN1Y2Nlc3NmdWwgYm9vdGluZy4NCj4+IFRoZSByb290IGNhc2Ugd2FzIGludmVzdGlnYXRl
ZCBieSBSb21hbiBLYWdhbiA8cmthZ2FuQHZpcnR1b3p6by5jb20+DQo+Pg0KPj4gVGhlIHBhdGNo
IGZpeGVzIHRoZSBwcm9ibGVtLCBieSBwcm9wYWdhdGluZyB0aGUgcXVldWUgc2l6ZSB0byB0aGUg
ZGV2aWNlIHJpZ2h0DQo+PiBhd2F5LCBzbyB0aGUgd3JpdHRlbiB2YWx1ZSBjb3VsZCBiZSByZWFk
IG9uIHRoZSBuZXh0IHN0ZXAsIGlmIHRoZSB2YWx1ZSB3YXMNCj4+IG9rIGZvciB0aGUgZGV2aWNl
Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogUm9tYW4gS2FnYW4gPHJrYWdhbkB2aXJ0dW96em8uY29t
Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5j
b20+DQo+IFRoYW5rcywgSSBhbHJlYWR5IGhhdmUgdGhpcyBxdWV1ZWQgYXM6DQo+DQo+IGNvbW1p
dCA4YWFiYmJkOWQwNGY5NWQ1NTgxZDIyNzUzNjI5OTZlY2I1NTE2ZGQ5DQo+IEF1dGhvcjogTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gRGF0ZTogICBGcmkgRGVjIDEzIDA5
OjIyOjQ4IDIwMTkgLTA1MDANCj4NCj4gICAgICB2aXJ0aW86IHVwZGF0ZSBxdWV1ZSBzaXplIG9u
IGd1ZXN0IHdyaXRlDQo+ICAgICAgDQo+ICAgICAgU29tZSBndWVzdHMgcmVhZCBiYWNrIHF1ZXVl
IHNpemUgYWZ0ZXIgd3JpdGluZyBpdC4NCj4gICAgICBVcGRhdGUgdGhlIHNpemUgaW1tZWRpYXRs
eSB1cG9uIHdyaXRlIG90aGVyd2lzZQ0KPiAgICAgIHRoZXkgZ2V0IGNvbmZ1c2VkLg0KPiAgICAg
IA0KPiAgICAgIFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+DQo+DQo+IEkgd291bGQgYXBwcmVjaWF0ZSBjaGVja2luZyBvdGhlciB0cmFuc3BvcnRzLCB0
aGV5IGxpa2VseQ0KPiBuZWVkIHRoZSBzYW1lIGZpeC4NCm9rLCBJJ2xsIHNlbmQgdGhlIHBhdGNo
IHNob3J0bHkNCj4NCj4NCj4+IC0tLQ0KPj4gICBody92aXJ0aW8vdmlydGlvLXBjaS5jIHwgMiAr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2h3L3ZpcnRpby92aXJ0aW8tcGNpLmMgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jDQo+PiBp
bmRleCBjNmI0N2E5YzczLi5lNWM3NTllMTllIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmlydGlvL3Zp
cnRpby1wY2kuYw0KPj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4gQEAgLTEyNTYs
NiArMTI1Niw4IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfY29tbW9uX3dyaXRlKHZvaWQgKm9w
YXF1ZSwgaHdhZGRyIGFkZHIsDQo+PiAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICBjYXNlIFZJ
UlRJT19QQ0lfQ09NTU9OX1FfU0laRToNCj4+ICAgICAgICAgICBwcm94eS0+dnFzW3ZkZXYtPnF1
ZXVlX3NlbF0ubnVtID0gdmFsOw0KPj4gKyAgICAgICAgdmlydGlvX3F1ZXVlX3NldF9udW0odmRl
diwgdmRldi0+cXVldWVfc2VsLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJv
eHktPnZxc1t2ZGV2LT5xdWV1ZV9zZWxdLm51bSk7DQo+PiAgICAgICAgICAgYnJlYWs7DQo+PiAg
ICAgICBjYXNlIFZJUlRJT19QQ0lfQ09NTU9OX1FfTVNJWDoNCj4+ICAgICAgICAgICBtc2l4X3Zl
Y3Rvcl91bnVzZSgmcHJveHktPnBjaV9kZXYsDQo+PiAtLSANCj4+IDIuMTcuMA0KDQo=


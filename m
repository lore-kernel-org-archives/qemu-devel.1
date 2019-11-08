Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E453FC6194
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B867218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="l/jEKfEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B867218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0i4-00049s-6J
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT0gf-0002mO-0u
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT0gd-00025M-Rr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:36:12 -0500
Received: from mail-eopbgr10132.outbound.protection.outlook.com
 ([40.107.1.132]:13184 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT0ga-000223-0X; Fri, 08 Nov 2019 04:36:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7UmRaFbw8LlGA24Dhx3SRORqOeNICXMMX/QqTDdxE58+kuGisRr9YcpPXGqs6vChSxpItSdn9c5OjSDmf7Mp53Uy1jMsAlroLn9JhXURXWwcMmLgGykxJ2j4jTtULYANsehANaOrDsA6woRYDeabem6OzupL5yJG02Mfp8Cn9CZg2TzDue/AOlQ13MwlQ+usMhvfqeJDXZk7xpZ/JFttuEq45on9iEO9qNnSxZH3+B6dKxFE4rDf52NzBZQK09VqzG1zJmZOw8QOibTNmDegzQ8a08jQyzo3RWVpNMmX4vTWHsyHjytBUYGpOcTs20qRn1fBD9R/7dpXtLuJYPHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6XGH127g4WdoT8eFmoN/HOmbwWCPMcAHlMRFKARTOc=;
 b=nWpuiUZlAk+lcsXKowzEmlX6CK5e0+puYkHjSrOZoAxHCjFZ1/A0mzarFriQFs+syukceH+j6XqFyxzYz6CZF+xhRhHvREjZrsByDLVOYnteNgSO+ARL1Pi4J6DxAPG5c7L5u9wq9lZElhABiyXVDwJSsGjQnGl9NlKPkJIo1pkd1w7Yk/BoGT1fQe+7lQphN5K78OrN7O3KoNuieddrdCEXTWtAIF42QbQTJwMdJd+hZ8y9uJiTjoh9HpK7jK8bp/eZfhw9iP3TUkvQzcv2mBmtaMSGmoJ7+XcbTFTfghrROywouFQjcE9NiGZF1edio0QkVmW2ag7XIyvRQJNVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6XGH127g4WdoT8eFmoN/HOmbwWCPMcAHlMRFKARTOc=;
 b=l/jEKfEeJzeAQU6XWA8ktldogU7Groto36Z+a4+JFWcA95aE67Ph7t/C0B1gefXh6FwldgUI5Liah+Vhjr4DbQI6YQwmB7BcL8sHSGIjJqFmWTUjpUbaHGCwpQd40OOgqHBw5glZn6Kb2Cv3nPeZ3xYq7Q+2V1zddivN0e011ZE=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3938.eurprd08.prod.outlook.com (20.178.117.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 09:36:05 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 09:36:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Deprecating stuff for 4.2
Thread-Topic: Deprecating stuff for 4.2
Thread-Index: AQHVlhfwxOi67UczFkKHW09T0UvzTg==
Date: Fri, 8 Nov 2019 09:36:04 +0000
Message-ID: <26371ed9-79ce-4d2a-e052-dca1310062b2@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <8736i2zf8e.fsf_-_@dusky.pond.sub.org>
 <423f2f82-9111-9c19-85b6-2645f66ab641@redhat.com>
 <ee0c3bf0-cb5b-835c-3981-d6f2b8af86e1@redhat.com>
 <e0448126-3371-fcf7-20ed-0d682dd8ca97@virtuozzo.com>
 <87eeyirht2.fsf_-_@dusky.pond.sub.org>
In-Reply-To: <87eeyirht2.fsf_-_@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0281.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::33) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191108123602481
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f26e005f-c13c-45d4-8655-08d7642f133d
x-ms-traffictypediagnostic: AM0PR08MB3938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB393816A5D080873F02966512C17B0@AM0PR08MB3938.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(136003)(39840400004)(376002)(199004)(189003)(6506007)(66446008)(5660300002)(66556008)(102836004)(66476007)(386003)(446003)(81156014)(86362001)(76176011)(2616005)(486006)(6486002)(81166006)(66946007)(6246003)(6436002)(476003)(8676002)(71200400001)(71190400001)(6512007)(305945005)(7416002)(6916009)(8936002)(186003)(52116002)(4326008)(6116002)(3846002)(64756008)(36756003)(31686004)(478600001)(11346002)(14454004)(7736002)(99286004)(26005)(256004)(54906003)(14444005)(25786009)(2906002)(316002)(31696002)(66066001)(7116003)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3938;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2v6HbNkUunvl3uDBQVxSOeHbKfK9WF0O7PaKXLOocIiL1+X9n9Xv/5WdtofdzdADchLwKDbAVhumLZqZuISo78p+bHLOfcoY2nyfhzrCGWYfIhAYakQwlpV8q/U4nn72WEE0HG6Ic29HhTgR+07KS4Kh+uBc+YGkOo7dUQlsXbkccZx/ZHYXPTpjcqp1vxaK4OEztvrLHs7F3aAI4Ad6m2hr+NN48TmsL7RayqWqbe2tq5BLfM6YlYBL3kedkfsS/ufsDvr3rFksWLuQMCzR/4iE5PQdLSQ/s+HuSjPK9rkhNMqRShWlv3PydGo6DIDzAavKLFsCPMtGb1+QV6jYNFGkMxn8xxjdl6TwBswPs0iXEJHq+sx2c1DCNztyBmXFJXOzwIA2TmM1qp9RsQSTUmArxY1jfhC7SxedfZ78GAXtyD1gfy4pl0I5zvyWn/x
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C8FCE8D78F54E49AA49A3E0DEF29DFB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26e005f-c13c-45d4-8655-08d7642f133d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 09:36:04.8122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgDxkjA41ezG1Or4FhETj5kjnLcdeSp057vP3C2ozD5YP5OjmUPJlP1X3W3U45rmtLnx7YArmW/EvHI5ztOmwAen56mOvyt3k6nvoEHpIro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3938
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.132
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTEuMjAxOSA5OjQxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPiB3cml0ZXM6DQo+IA0K
Pj4gMDcuMTEuMjAxOSAyMTo1MiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFsu
Li5dDQo+Pj4gUHJlLXJlbGVhc2UgcGVyaW9kLCB0aW1lIHRvIGRlcHJlY2F0ZSBzb21lIHN0dWZm
cyA6KQ0KPj4+DQo+Pj4gSG93IHNob3VsZCB3ZSBwcm9jZWVkPyBEbyB5b3UgaGF2ZSBzb21ldGhp
bmcgaW4gbWluZD8NCj4+Pg0KPj4+IFRoZXJlIGFyZSBvbGRlciB0aHJlYWRzIGFib3V0IHRoaXMu
IFNob3VsZCB3ZSBzdGFydCBhIG5ldyB0aHJlYWQ/IEdhdGhlciB0aGUgZGlmZmVyZW50IGlkZWFz
IG9uIHRoZSBXaWtpPw0KPj4+DQo+Pj4gKE9idmlvdXNseSB5b3UgYXJlIG5vdCB0aGUgb25lIHJl
c3BvbnNpYmxlIG9mIHRoaXMgdG9waWMsIHlvdSBqdXN0IGhhcHBlbiB0byBiZSB0aGUgbGFzdCBv
bmUgd29ycmllZCBhYm91dCBpdCBvbiB0aGUgbGlzdCkuDQo+Pj4NCj4+PiBSZWdhcmRzLA0KPj4+
DQo+Pj4gUGhpbC4NCj4gDQo+IDQuMi4wLXJjMCBoYXMgYmVlbiB0YWdnZWQsIGkuZS4gd2UncmUg
aW4gaGFyZCBmcmVlemUgYWxyZWFkeS4gIE9ubHkgYnVnDQo+IGZpeGVzIGFyZSBhY2NlcHRlZCBk
dXJpbmcgaGFyZCBmcmVlemUuICBXZSd2ZSBvY2Nhc2lvbmFsbHkgYmVudCB0aGlzDQo+IHJ1bGUg
YWZ0ZXIgLXJjMCBmb3IgYm9yZGVybGluZSBjYXNlcywgZS5nLiB0byB0d2VhayBhIG5ldyBleHRl
cm5hbA0KPiBpbnRlcmZhY2UgYmVmb3JlIHRoZSByZWxlYXNlIGNhbGNpZmllcyBpdC4gIE1ha2lu
ZyBhIGNhc2UgZm9yIGJlbmRpbmcNCj4gdGhlIHJ1bGVzIGJlY29tZXMgaGFyZGVyIHdpdGggZWFj
aCAtcmMuDQo+IA0KPiBJZGVhbGx5LCB3ZSdkIGRvdWJsZS1jaGVjayBuZXcgaW50ZXJmYWNlcyBm
b3IgZ2FmZmVzIGJlZm9yZSBhIHJlbGVhc2UsDQo+IGFuZCB3aGV0aGVyIG9sZCBpbnRlcmZhY2Vz
IHRoYXQgaGF2ZSBiZWVuIHJlcGxhY2VkIG5vdyBzaG91bGQgYmUNCj4gZGVwcmVjYXRlZC4gIFRo
ZXJlJ3MgcmFyZWx5IHRpbWUgZm9yIHRoYXQsIGFuZCBwcmV0dHkgbXVjaCBuZXZlciBmb3INCj4g
cmVsZWFzZXMgcmlnaHQgYWZ0ZXIgS1ZNIEZvcnVtLg0KPiANCj4gU28gbm8sIEkgZG9uJ3QgaGF2
ZSBhbnl0aGluZyBpbiBtaW5kIGZvciA0LjIuDQo+IA0KPiBXZSBpbnRlbmQgdG8gdGFnIC1yYzEg
bmV4dCBUdWVzZGF5LiAgVG8gbWFrZSB0aGF0IGRlYWRsaW5lLCB3ZSdkIG5lZWQNCj4gcGF0Y2hl
cywgbm90IGp1c3QgaWRlYXMuDQo+IA0KPj4gSGkhDQo+Pg0KPj4gSSB3YW50ZWQgdG8gcmVzZW5k
LCBidXQgZmFjZWQgc29tZSBwcm9ibGVtcywgYW5kIHVuZGVyc3RhbmQgdGhhdCBJIGNhbid0IGRv
IGl0IGluIHRpbWUgYmVmb3JlIHNvZnQtZnJlZXplLi4NCj4+IEJ1dCB5b3Ugc2F5LCB0aGF0IHdl
IGNhbiBkZXByZWNhdGUgc29tZXRoaW5nIGV2ZW4gYWZ0ZXIgaGFyZC1mcmVlemU/DQo+IA0KPiBT
ZWUgYWJvdmUuDQo+IA0KPj4gT2ssIHRoZSBwcm9ibGVtIHRoYXQgSSBmYWNlZCwgaXMgdGhhdCBk
ZXByZWNhdGlvbiB3YXJuaW5ncyBicmVha3Mgc29tZSBpb3Rlc3RzLi4gV2hhdCBjYW4gd2UgZG8/
DQo+Pg0KPj4gMS4gVXBkYXRlIGlvdGVzdHMuLi4NCj4+ICAgICAxLjEgSnVzdCB1cGRhdGUgaW90
ZXN0cyBvdXRwdXRzIHRvIHNob3cgd2FybmluZ3MuIFRoZW4sIGluIG5leHQgcmVsZWFzZSBjeWNs
ZSwgdXBkYXRlIGlvdGVzdHMsIHRvIG5vdCB1c2UgZGVwcmVjYXRlZCB0aGluZ3MNCj4gDQo+IFNv
dW5kcyB3b3JrYWJsZSB0byBtZSwgYnV0IEknbSBub3QgdGhlIG1haW50YWluZXIuDQo+IA0KPj4g
ICAgIG9yDQo+PiAgICAgMS4yIFVwZGF0ZSBpb3Rlc3RzIHRvIG5vdCB1c2UgZGVwcmVjYXRlZCB0
aGluZ3MuLiBOb3QgYXBwcm9wcmlhdGUgZm9yIGhhcmQgZnJlZXplLg0KPiANCj4gVW5uZWNlc3Nh
cmlseSByaXNreSBjb21wYXJlZCB0byAxLjEuDQo+IA0KPj4gb3INCj4+IDIuIENvbW1pdCBkZXBy
ZWNhdGlvbnMgd2l0aG91dCB3YXJuaW5ncy4uIEJ1dCBob3cgZG8gcGVvcGxlIGZpbmQgb3V0IGFi
b3V0IHRoaXM/DQo+IA0KPiBOb3QgbmljZS4NCj4gDQo+IFdlIGRvIGl0IGZvciBRTVAsIGJ1dCBv
bmx5IGJlY2F1c2Ugd2Ugc3RpbGwgbGFjayB0aGUgbWVhbnMgdG8gd2Fybg0KPiB0aGVyZS4NCj4g
DQo+PiBOZXh0LCB3aGF0IGV4YWN0bHkgdG8gZGVwcmVjYXRlPyBBcyBJIHVuZGVyc3RhbmQsIHdl
IGNhbid0IGRlcHJlY2F0ZSBkcml2ZS1taXJyb3Igbm93Pw0KPj4gU28gSSBwcm9wb3NlIHRvOg0K
Pj4NCj4+IDEuIGRlcHJlY2F0ZSBkcml2ZS1iYWNrdXANCj4+IDIuIGFkZCBvcHRpb25hbCBmaWx0
ZXItbm9kZS1uYW1lIHBhcmFtZXRlciB0byBkcml2ZS1taXJyb3IsIHRvIGNvcnJlc3BvbmQgdG8g
Y29tbWl0IGFuZCBtaXJyb3INCj4+IDMuIGRlcHJlY2F0ZSB0aGF0IGZpbHRlci1ub2RlLW5hbWUg
aXMgb3B0aW9uYWwgZm9yIGNvbW1pdCBhbmQgbWlycm9yLg0KPiANCj4gVG8gaGF2ZSBhIGNoYW5j
ZSB0aGVyZSwgd2UgbmVlZCBwYXRjaGVzIGEucy5hLnAuDQo+IA0KDQpPSywgSSdsbCBzZW5kIHRv
ZGF5IGFuZCB3ZSdsbCBzZWUsIHdoYXQgdG8gZG8gd2l0aCBpdC4NCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K


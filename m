Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36621C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025B824672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="puNiVLtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025B824672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwk8-0003qY-P3
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihwic-00025h-LS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihwib-0008Gj-Bq
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:23:58 -0500
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:29636 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihwiW-0007jG-WE; Thu, 19 Dec 2019 09:23:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQke/UrL/pJy3YxxqmlC5nacAlbjjTv1e4ZNI5b/EeJRE55215Rs6HfgtOAOZHPuGntV8t4eC2ERGorpnPgl05b8ZMcAMBDbHglNC7rNB5objN2kfuPG0aWZsKx5vgahtDeVpJ5N5GZlI205WgwIXvufaFQXQ9V4HDRzQ0iTnrNinZ03LjkZIGVbVJHLlVgKt0Svlx2NXCNeKnSwD58/203FfkXTm/5KYASAM1Oua3v4qn9MOuamvUQDYEFEilujny6Z5LTR0mnHDz9l70oEhRwn9jy+zWuEWERE86Ki8MthlaDGUTDrQtjCJpFYheY9ZrC79N3kEkXUCQehg4mLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIEDZ7bGhWZDP7W59uMBvzgUUMPxkofkLqpWX4MJHi8=;
 b=YM6ioml0G/tl8/GTRdk1bnViFt+PlLp+d0cxVZUl4F0efGLI/wTl+LFX3cygfdUu3Mg9Sv9xoDF2Ghccdgf7nkp8bciJ5TZhtelhRbXmTbNdKK7KHkclyVgOrtTpJep6NdDZmoGuZgNdSqhFs9bINBIzqX2LHHEmzo+3ryYrxMYxCm7h1N7Y0NhWTNId5ydfd3Krx4JZ4DPRudNyT1vfdJk8U3cgv5PpeCTSjBCwZY1bgyskiZ/TGxJplcuZLvWGkNjrMUwAmnHRhZaZveLKhOvsjGyvNJ+ew5Sa8yb0a2gYKqGUDUKN2SElFdtyKeK6ZCRBTuyulDvhS9UxZDZgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIEDZ7bGhWZDP7W59uMBvzgUUMPxkofkLqpWX4MJHi8=;
 b=puNiVLtmVMR7amO+SpyaK9bumtpx3w3HK5IPLjFuf7Q/1mSThs9wSwmwdh/ZkyDHayt7tFW5z6yuKtoWoZ4EeWhfUANQ3exJM2b1ujLXruwm1Nq33oJNogGwEEnEo55JV0DeQ45Cc/gkzHMcfiGV6vGO65gj1tF8NwlUMlw9nC0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3655.eurprd08.prod.outlook.com (20.177.113.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 14:23:50 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 14:23:50 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Topic: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Index: AQHVtmzMtpyWQS3Bp0OaQNZadGqOP6fBd04AgAAGUoCAAAVhAA==
Date: Thu, 19 Dec 2019 14:23:49 +0000
Message-ID: <96b56762-21ad-13ea-9474-ecaca9276fe1@virtuozzo.com>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
In-Reply-To: <20191219140433.GK5230@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219172348099
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3204399d-67ab-4d4b-bc5c-08d7848f1115
x-ms-traffictypediagnostic: AM6PR08MB3655:
x-microsoft-antispam-prvs: <AM6PR08MB3655DA89E49CAD493411D74EC1520@AM6PR08MB3655.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(396003)(346002)(39840400004)(376002)(199004)(189003)(31696002)(26005)(81156014)(2616005)(2906002)(8936002)(81166006)(186003)(52116002)(8676002)(6506007)(6486002)(36756003)(478600001)(6916009)(31686004)(86362001)(316002)(64756008)(66556008)(5660300002)(6512007)(4326008)(66476007)(71200400001)(66446008)(54906003)(66946007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3655;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNzNy13oOOs1kIFPNi9YbnR98Jn1Lu1ZXYviCaWlKzaMG9hCdgEuNg9d27q/50wGGYLfnCx7mTHxAmRmd55cQec/os+Fihpz7wnPEvsklg2K7/Y7Hke0rM7frm4RAddibIAZHzAeUPz2EceEDEgTMxnlh6X7EtDLeVZN7nR7lZWEO1VGfUs7d5Jxif/JXuV9uMiFDCZ738136E+Zw901E9XS/2WscfjDqyCF9VF2sTNweE5W7vhpd0FMOCR7bhOSh+kh7C+NW78tuaqKmQSxFaG977q//sX/lpj6t9ggRCyX4lfAYdGWG6SjKThMygbpg3pTt2Y8AcfVXxadXfekTswHamdBFsEqMmce1Yz4JvAmjUgbuPEsJIFRlo4cYp7rl5HDNOOzWscbZES+9bWXz4BO5BIY3SrRXmmj4phMnaON5O5nJxC6PL9/nUZO9QB0MjG7ij7SV89zQmFjmHUmR4j84a8rcIdCvXs3SfZ6Lxw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <44C062E7A6000940941E8058348ADEC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3204399d-67ab-4d4b-bc5c-08d7848f1115
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 14:23:50.0639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv/egSruXypv6EUQNCmzp7Vt5dkRRenh0KENXWc/0MNOCHtPWG4ipDapb6crR03tzuelRr48FcXK0O9szuWcufRnIYK+SY1Vx0vTSZaXbMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3655
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.134
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
Cc: Nir Soffer <nsoffer@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxNzowNCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTkuMTIuMjAxOSB1bSAx
NDo0MSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IEFo
aCwgSSBzZWUsIGl0J3MgZG9jdW1lbnRlZCBhcw0KPj4NCj4+ICsjIEBiaXRtYXA6IEFsc28gZXhw
b3J0IHRoZSBkaXJ0eSBiaXRtYXAgcmVhY2hhYmxlIGZyb20gQGRldmljZSwgc28gdGhlDQo+PiAr
IyAgICAgICAgICBOQkQgY2xpZW50IGNhbiB1c2UgTkJEX09QVF9TRVRfTUVUQV9DT05URVhUIHdp
dGgNCj4+ICsjICAgICAgICAgICJxZW11OmRpcnR5LWJpdG1hcDpOQU1FIiB0byBpbnNwZWN0IHRo
ZSBiaXRtYXAuIChzaW5jZSA0LjApDQo+Pg0KPj4gYW5kIGl0IGlzIGxvZ2ljYWwgdG8gYXNzdW1l
IHRoYXQgZXhwb3J0IG5hbWUgKHdoaWNoIGlzIEBuYW1lIGFyZ3VtZW50KSBpcw0KPj4gbWVudGlv
bmVkLiBCdXQgd2UgbmV2ZXIgbWVudGlvbmVkIGl0LiBUaGlzIGlzIGp1c3QgZG9jdW1lbnRlZCBh
ZnRlcg0KPj4gcmVtb3ZlZCBleHBlcmltZW5hdGwgY29tbWFuZCB4LW5iZC1zZXJ2ZXItYWRkLWJp
dG1hcCwNCj4+DQo+PiBsb29rIGF0DQo+Pg0KPj4gY29tbWl0IDdkYzU3MGIzODA2ZTViMGE0Yzky
MTkwNjE1NTZlZDVhNGEwZGU4MGMNCj4+IEF1dGhvcjogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhh
dC5jb20+DQo+PiBEYXRlOiAgIEZyaSBKYW4gMTEgMTM6NDc6MTggMjAxOSAtMDYwMA0KPj4NCj4+
ICAgICAgIG5iZDogUmVtb3ZlIHgtbmJkLXNlcnZlci1hZGQtYml0bWFwDQo+Pg0KPj4gLi4uDQo+
Pg0KPj4gLSMgQGJpdG1hcC1leHBvcnQtbmFtZTogSG93IHRoZSBiaXRtYXAgd2lsbCBiZSBzZWVu
IGJ5IG5iZCBjbGllbnRzDQo+PiAtIyAgICAgICAgICAgICAgICAgICAgICAoZGVmYXVsdCBAYml0
bWFwKQ0KPj4gLSMNCj4+IC0jIE5vdGU6IHRoZSBjbGllbnQgbXVzdCB1c2UgTkJEX09QVF9TRVRf
TUVUQV9DT05URVhUIHdpdGggYSBxdWVyeSBvZg0KPj4gLSMgInFlbXU6ZGlydHktYml0bWFwOk5B
TUUiICh3aGVyZSBOQU1FIG1hdGNoZXMgQGJpdG1hcC1leHBvcnQtbmFtZSkgdG8gYWNjZXNzDQo+
PiAtIyB0aGUgZXhwb3NlZCBiaXRtYXAuDQo+Pg0KPj4NCj4+IFNvLCB0aGlzICJOQU1FIiBpcyBz
YXZlZCBhbmQgbm93IGxvb2tzIGluY29ycmVjdC4gV2hhdCBzaG91bGQgYmUgZml4ZWQsIGlzIFFh
cGkNCj4+IGRvY3VtZW50YXRpb24uDQo+IA0KPiBIbSwgSSBkb24ndCBrbm93IHRoZXNlIGludGVy
ZmFjZXMgdmVyeSB3ZWxsLCBidXQgZnJvbSB5b3UgZXhwbGFuYXRpb24gaXQNCj4gbG9va3MgdG8g
bWUgYXMgaWYgaGF2aW5nIGEgYml0bWFwIG5hbWUgbWFkZSBzZW5zZSB3aXRoDQo+IHgtbmJkLXNl
cnZlci1hZGQtYml0bWFwIGJlY2F1c2UgaXQgY291bGQgYmUgY2FsbGVkIG1vcmUgdGhhbiBvbmNl
IGZvcg0KPiBleHBvcnRpbmcgbXVsdGlwbGUgYml0bWFwcy4NCj4gDQo+IEJ1dCBub3csIHdlIGhh
dmUgb25seSBuYmQtc2VydmVyLWFkZCwgd2hpY2ggdGFrZXMgYSBzaW5nbGUgYml0bWFwIG5hbWUu
DQo+IEFzIHdlIGRvbid0IGhhdmUgdG8gZGlzdGluZ3Vpc2ggbXVsdGlwbGUgYml0bWFwcyBhbnkg
bW9yZSwgd291bGRuJ3QgaXQNCj4gbWFrZSBtb3JlIHNlbnNlIHRvIHVzZSAicWVtdTpkaXJ0eS1i
aXRtYXAiIHdpdGhvdXQgYW55IG90aGVyDQo+IGluZm9ybWF0aW9uPyBCb3RoIGV4cG9ydCBuYW1l
IGFuZCBiaXRtYXAgbmFtZSBhcmUgYWxyZWFkeSBpZGVudGlmaWVkIGJ5DQo+IHRoZSBjb25uZWN0
aW9uLg0KDQpJIHRoaW5rLCBpdCB3aWxsIGEgYml0IGluIGNvbmZsaWN0IHdpdGggYWxyZWFkeSBk
b2N1bWVudGVkDQoNCiogInFlbXU6ZGlydHktYml0bWFwOiIgLSByZXR1cm5zIGxpc3Qgb2YgYWxs
IGF2YWlsYWJsZSBkaXJ0eS1iaXRtYXANCiAgICAgICAgICAgICAgICAgICAgICAgICAgbWV0YWRh
dGEgY29udGV4dHMuDQoNClNvLCBpZiB3ZSB3YW50IHNvbWUgImRlZmF1bHQgZGlydHkgYml0bWFw
Iiwgd2UnZCBiZXR0ZXIgdXNlIHNvbWV0aGluZyBkaWZmZXJlbnQNCmZyb20ganVzdCBkaXJ0eS1i
aXRtYXAuIEZvciBleGFtcGxlLA0KDQogICAgInFlbXU6ZGVmYXVsdC1kaXJ0eS1iaXRtYXAiDQoN
Cj4gQnV0IGlmIHdlIGhhdmUgdG8gaGF2ZSBzb21ldGhpbmcgdGhlcmUsIHVzaW5nIHRoZSBiaXRt
YXAgbmFtZSAod2hpY2ggbWF5DQo+IG9yIG1heSBub3QgYmUgdGhlIHNhbWUgYXMgdXNlZCBpbiB0
aGUgaW1hZ2UgZmlsZSkgbWFrZXMgYSBsaXR0bGUgbW9yZQ0KPiBzZW5zZSBiZWNhdXNlIGl0IG1h
a2VzIHRoZSBpbnRlcmZhY2UgZXh0ZW5zaWJsZSBmb3IgdGhlIGNhc2UgdGhhdCB3ZQ0KPiBldmVy
IHdhbnQgdG8gcmUtaW50cm9kdWNlIGFuIG5iZC1zZXJ2ZXItYWRkLWJpdG1hcC4NCg0KQWdyZWUN
Cg0KDQo+IA0KPiAoQnkgdGhlIHdheSwgZXZlbiBpZiB0aGUgcGF0Y2ggd2VyZSBjb3JyZWN0LCBp
dCBsYWNrcyBhIFNpZ25lZC1vZmYtYnkuKQ0KPiANCj4gS2V2aW4NCj4gDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


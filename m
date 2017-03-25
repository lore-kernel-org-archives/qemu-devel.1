Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashedel@microsoft.com>) id 1crs8d-0004Dg-Un
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 16:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashedel@microsoft.com>) id 1crs8a-0001pm-QT
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 16:18:15 -0400
Received: from mail-dm3nam03on0126.outbound.protection.outlook.com
	([104.47.41.126]:23488
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ashedel@microsoft.com>)
	id 1crs8a-0001p6-9I
	for qemu-devel@nongnu.org; Sat, 25 Mar 2017 16:18:12 -0400
From: Andrey Shedel <ashedel@microsoft.com>
Date: Sat, 25 Mar 2017 17:43:07 +0000
Message-ID: <CY1PR0301MB161274AF5C14F09FCE50D36AB3310@CY1PR0301MB1612.namprd03.prod.outlook.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
	<1173789300.7253222.1490394527808.JavaMail.zimbra@redhat.com>
	<DM2PR21MB006087829595A4E336AFC9BB9E3E0@DM2PR21MB0060.namprd21.prod.outlook.com>
	<291670989.7316919.1490436858720.JavaMail.zimbra@redhat.com>
In-Reply-To: <291670989.7316919.1490436858720.JavaMail.zimbra@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] win32: replace custom mutex and condition
 variable with native primitives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Stefan Weil <sw@weilnetz.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21haWx0bzpwYm9uemluaUByZWRoYXQuY29tXSANCj4g
U2VudDogU2F0dXJkYXksIE1hcmNoIDI1LCAyMDE3IDM6MTQNCj4NCj4gLS0tLS0gT3JpZ2luYWwg
TWVzc2FnZSAtLS0tLQ0KPiA+IEZyb206ICJBbmRyZXcgQmF1bWFubiIgPEFuZHJldy5CYXVtYW5u
QG1pY3Jvc29mdC5jb20+DQo+ID4gVG86ICJQYW9sbyBCb256aW5pIiA8cGJvbnppbmlAcmVkaGF0
LmNvbT4NCj4gPiBDYzogIkFuZHJleSBTaGVkZWwiIDxhc2hlZGVsQG1pY3Jvc29mdC5jb20+LCAi
U3RlZmFuIFdlaWwiIA0KPiA+IDxzd0B3ZWlsbmV0ei5kZT4sIHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0KPiA+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAyNSwgMjAxNyAxMjoxNDoyMCBBTQ0KPiA+IFN1
YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1BBVENIXSB3aW4zMjogcmVwbGFjZSBjdXN0b20gbXV0
ZXggYW5kIA0KPiA+IGNvbmRpdGlvbiB2YXJpYWJsZSB3aXRoIG5hdGl2ZSBwcmltaXRpdmVzDQo+
ID4gDQo+ID4gPiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNv
bV0NCj4gPiA+IFNlbnQ6IEZyaWRheSwgMjQgTWFyY2ggMjAxNyAxNToyOQ0KPiA+IA0KPiA+ID4g
PiBGcm9tOiBBbmRyZXkgU2hlZGVsIDxhc2hlZGVsQG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+DQo+
ID4gPiA+IFRoZSBtdWx0aXRocmVhZGVkIFRDRyBpbXBsZW1lbnRhdGlvbiBleHBvc2VkIGRlYWRs
b2NrcyBpbiB0aGUgDQo+ID4gPiA+IHdpbjMyIGNvbmRpdGlvbiB2YXJpYWJsZXM6IGFzIGltcGxl
bWVudGVkLCBxZW11X2NvbmRfYnJvYWRjYXN0IA0KPiA+ID4gPiB3YWl0ZWQgb24gcmVjZWl2ZXJz
LCB3aGVyZWFzIHRoZSBwdGhyZWFkcyBBUEkgaXQgd2FzIGludGVuZGVkIHRvIA0KPiA+ID4gPiBl
bXVsYXRlIGRvZXMgbm90LiBUaGlzIHdhcyBjYXVzaW5nIGEgZGVhZGxvY2sgYmVjYXVzZSBicm9h
ZGNhc3QgDQo+ID4gPiA+IHdhcyBjYWxsZWQgd2hpbGUgaG9sZGluZyB0aGUgSU8gbG9jaywgYXMg
d2VsbCBhcyBhbGwgcG9zc2libGUgDQo+ID4gPiA+IHdhaXRlcnMgYmxvY2tlZCBvbiB0aGUgc2Ft
ZSBsb2NrLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIHJlcGxhY2VzIGFsbCB0aGUgY3Vz
dG9tIHN5bmNocm9uaXNhdGlvbiBjb2RlIGZvciANCj4gPiA+ID4gbXV0ZXhlcyBhbmQgY29uZGl0
aW9uIHZhcmlhYmxlcyB3aXRoIG5hdGl2ZSBXaW5kb3dzIHByaW1pdGl2ZXMgDQo+ID4gPiA+IChT
Uldsb2NrcyBhbmQgY29uZGl0aW9uIHZhcmlhYmxlcykgd2l0aCB0aGUgc2FtZSBzZW1hbnRpY3Mg
YXMgDQo+ID4gPiA+IHRoZWlyIFBPU0lYIGVxdWl2YWxlbnRzLiBUbyBlbmFibGUgdGhhdCwgaXQg
cmVxdWlyZXMgYSBXaW5kb3dzIA0KPiA+ID4gPiBWaXN0YSBvciBuZXdlciBob3N0IE9TLg0KPiA+
ID4gPg0KPiA+ID4gPiBbQUI6IGVkaXRlZCBjb21taXQgbWVzc2FnZV0NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogQW5kcmV3IEJhdW1hbm4gPEFuZHJldy5CYXVtYW5uQG1pY3Jvc29mdC5jb20+DQo+
ID4gPiANCj4gPiA+IE9vcHMsIGp1c3QgYSBuaXQgYnV0IGFuIGltcG9ydGFudCBvbmU6IHRoZXJl
IHNob3VsZCBiZSBhIA0KPiA+ID4gU2lnbmVkLW9mZi1ieSBmb3IgQW5kcmV5IGFzIHdlbGwuDQo+
ID4gDQo+ID4gT29wcywgbXkgZmF1bHQsIHNpbmNlIEkgdG9vayBoaXMgY29kZSBhbmQgcHJlcGFy
ZWQgdGhlIHBhdGNoIA0KPiA+IHN1Ym1pc3Npb24uIFdlIGNhbiByZXNlbmQgd2l0aCB0aGUgc2ln
bm9mZiwgYnV0IHBlcmhhcHMgSSBzaG91bGQgd2FpdCBmb3IgYSByZXZpZXc/DQo+DQo+IEl0J3Mg
ZW5vdWdoIGlmIGhlIHJlcGxpZXMgd2l0aCB0aGUgU2lnbmVkLW9mZi1ieSBsaW5lLg0KPg0KPiBQ
YW9sbw0KPg0KDQpTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hlZGVsIDxhc2hlZGVsQG1pY3Jvc29m
dC5jb20+DQoNCg==

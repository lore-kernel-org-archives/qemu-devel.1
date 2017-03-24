Received: from eggs.gnu.org ([2001:4830:134:3::10]:51843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crYPc-000274-8M
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crYPZ-0005uk-3r
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:14:28 -0400
Received: from mail-cys01nam02on0128.outbound.protection.outlook.com
	([104.47.37.128]:49184
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1crYPY-0005tZ-IF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 19:14:25 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 24 Mar 2017 23:14:20 +0000
Message-ID: <DM2PR21MB006087829595A4E336AFC9BB9E3E0@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170324220141.10104-1-Andrew.Baumann@microsoft.com>
	<1173789300.7253222.1490394527808.JavaMail.zimbra@redhat.com>
In-Reply-To: <1173789300.7253222.1490394527808.JavaMail.zimbra@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Andrey Shedel <ashedel@microsoft.com>, Stefan Weil <sw@weilnetz.de>

PiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gU2Vu
dDogRnJpZGF5LCAyNCBNYXJjaCAyMDE3IDE1OjI5DQoNCj4gPiBGcm9tOiBBbmRyZXkgU2hlZGVs
IDxhc2hlZGVsQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBUaGUgbXVsdGl0aHJlYWRlZCBUQ0cg
aW1wbGVtZW50YXRpb24gZXhwb3NlZCBkZWFkbG9ja3MgaW4gdGhlIHdpbjMyDQo+ID4gY29uZGl0
aW9uIHZhcmlhYmxlczogYXMgaW1wbGVtZW50ZWQsIHFlbXVfY29uZF9icm9hZGNhc3Qgd2FpdGVk
IG9uDQo+ID4gcmVjZWl2ZXJzLCB3aGVyZWFzIHRoZSBwdGhyZWFkcyBBUEkgaXQgd2FzIGludGVu
ZGVkIHRvIGVtdWxhdGUgZG9lcw0KPiA+IG5vdC4gVGhpcyB3YXMgY2F1c2luZyBhIGRlYWRsb2Nr
IGJlY2F1c2UgYnJvYWRjYXN0IHdhcyBjYWxsZWQgd2hpbGUNCj4gPiBob2xkaW5nIHRoZSBJTyBs
b2NrLCBhcyB3ZWxsIGFzIGFsbCBwb3NzaWJsZSB3YWl0ZXJzIGJsb2NrZWQgb24gdGhlDQo+ID4g
c2FtZSBsb2NrLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCByZXBsYWNlcyBhbGwgdGhlIGN1c3RvbSBz
eW5jaHJvbmlzYXRpb24gY29kZSBmb3IgbXV0ZXhlcw0KPiA+IGFuZCBjb25kaXRpb24gdmFyaWFi
bGVzIHdpdGggbmF0aXZlIFdpbmRvd3MgcHJpbWl0aXZlcyAoU1JXbG9ja3MgYW5kDQo+ID4gY29u
ZGl0aW9uIHZhcmlhYmxlcykgd2l0aCB0aGUgc2FtZSBzZW1hbnRpY3MgYXMgdGhlaXIgUE9TSVgN
Cj4gPiBlcXVpdmFsZW50cy4gVG8gZW5hYmxlIHRoYXQsIGl0IHJlcXVpcmVzIGEgV2luZG93cyBW
aXN0YSBvciBuZXdlciBob3N0DQo+ID4gT1MuDQo+ID4NCj4gPiBbQUI6IGVkaXRlZCBjb21taXQg
bWVzc2FnZV0NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgQmF1bWFubiA8QW5kcmV3LkJhdW1h
bm5AbWljcm9zb2Z0LmNvbT4NCj4gDQo+IE9vcHMsIGp1c3QgYSBuaXQgYnV0IGFuIGltcG9ydGFu
dCBvbmU6IHRoZXJlIHNob3VsZCBiZSBhDQo+IFNpZ25lZC1vZmYtYnkgZm9yIEFuZHJleSBhcyB3
ZWxsLg0KDQpPb3BzLCBteSBmYXVsdCwgc2luY2UgSSB0b29rIGhpcyBjb2RlIGFuZCBwcmVwYXJl
ZCB0aGUgcGF0Y2ggc3VibWlzc2lvbi4gV2UgY2FuIHJlc2VuZCB3aXRoIHRoZSBzaWdub2ZmLCBi
dXQgcGVyaGFwcyBJIHNob3VsZCB3YWl0IGZvciBhIHJldmlldz8NCg0KQW5kcmV3DQo=

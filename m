Received: from eggs.gnu.org ([209.51.188.92]:51200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1gyzVM-0005Ft-Eu
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1gyzEl-0001eX-8h
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:27:05 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Wed, 27 Feb 2019 12:32:00 +0000
Message-ID: <d200c71d-c739-fd52-dcff-00d442b289ae@openvz.org>
References: <20190226145930.5000-1-den@openvz.org>
	<20190226155131.GC4598@linux.fritz.box>
In-Reply-To: <20190226155131.GC4598@linux.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <36044FD761A0D2409DE96B211B1C6861@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/1] block: propagate discard aligment from
 format drivers to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>

T24gMi8yNi8xOSA2OjUxIFBNLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiBBbSAyNi4wMi4yMDE5IHVt
IDE1OjU5IGhhdCBEZW5pcyBWLiBMdW5ldiBnZXNjaHJpZWJlbjoNCj4+IE5vd2FkYXkgU0NTSSBk
cml2ZXJzIGluIGd1ZXN0cyBhcmUgYWJsZSB0byBhbGlnaHQgVU5NQVAgcmVxdWVzdHMgYmVmb3Jl
DQo+IElzIHMvYWxpZ2h0L2FsaWduLyB3aGF0IHlvdSBtZWFuPw0KPg0KPiBUaGUgc3ViamVjdCBs
aW5lIGhhcyBhbiAiYWxpZ25tZW50IiB0eXBvLCB0b28uDQo+DQo+PiBzZW5kaW5nIHRvIHRoZSBk
ZXZpY2UuIFJpZ2h0IG5vdyBRRU1VIHByb3ZpZGVzIGFuIGFiaWxpdHkgdG8gc2V0DQo+PiB0aGlz
IHZpYSAiZGlzY2FyZF9ncmFudWxhcml0eSIgcHJvcGVydHkgb2YgdGhlIGJsb2NrIGRldmljZSB3
aGljaCBjb3VsZA0KPj4gYmUgdXNlZCBieSBtYW5hZ2VtZW50IGxheWVyLg0KPj4NCj4+IFRob3Vn
aCwgaW4gcGFydGljdWxhciwgZnJvbSB0aGUgcG9pbnQgb2YgUUVNVSwgdGhlcmUgaXMNCj4+IHBk
aXNjYXJkX2dyYW51bGFyaXR5IG9uIHRoZSBmb3JtYXQgZHJpdmVyIGxldmVsLCBmLmUuIG9uIFFD
T1cyIG9yIGlTQ1NJLg0KPj4gSXQgd291bGQgYmUgYmVuZWZpY2lhbCB0byBwYXNzIHRoaXMgdmFs
dWUgYXMgYSBkZWZhdWx0IGZvciB0aGlzDQo+PiBwcm9wZXJ0eS4NCj4+DQo+PiBUZWNobmljYWxs
eSB0aGlzIHNob3VsZCByZWR1Y2UgdGhlIGFtb3VudCBvZiB1c2VsZXNzIFVOTUFQIHJlcXVlc3Rz
DQo+PiBmcm9tIHRoZSBndWVzdCB0byB0aGUgaG9zdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBE
ZW5pcyBWLiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+DQo+PiBDQzogS2V2aW4gV29sZiA8a3dvbGZA
cmVkaGF0LmNvbT4NCj4+IENDOiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPj4gQ0M6
IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+PiBDQzogRmFtIFpoZW5nIDxm
YW1AZXVwaG9uLm5ldD4NCj4gSSdtIG5vdCBkb2luZyB0aGluZ3MgbGlrZSB0aGlzIHZlcnkgb2Z0
ZW4sIGJ1dCB5b3UncmUgdG91Y2hpbmcgdGhlIGd1ZXN0DQo+IEFCSSBoZXJlLCB3aGljaCBpcyBh
IGJpdCB0cmlja3kuIFRoZSBtYWluIHBvaW50IGlzIHRoYXQgdGhlIHNhbWUgY29tbWFuZA0KPiBs
aW5lIG11c3QgcmVzdWx0IGluIHRoZSBzYW1lIGd1ZXN0IHZpZXcuDQo+DQo+IFlvdSdsbCBuZWVk
IGF0IGxlYXN0IHNvbWUgbWFjaGluZSB0eXBlIG1hZ2ljIHRvIG1ha2Ugb2xkIG1hY2hpbmUgdHlw
ZXMNCj4gdXNlIHRoZSBvbGQgZGVmYXVsdHMuIEknbSBub3Qgc3VyZSBpZiB0aGVyZSdzIHNvbWV0
aGluZyBlbHNlIHRvIGNvbnNpZGVyDQo+IGZvciBtaWdyYXRpb24gY29tcGF0aWJpbGl0eS4NCj4N
Cj4gS2V2aW4NCnNvdW5kcyByZWFzb25hYmxlLCB0aGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9u
Lg0KDQpJIHdhcyBmYXNjaW5hdGVkIHdpdGggdGhlIGZhY3QgdGhhdA0KYSkgY2hhbmdlIGlzIG5v
dMKgIGRpc3J1cHRpdmUNCmIpIHRoZSBndWVzdCBhY3R1YWxseSBkbyBub3QgcmVhZCB0aGlzIHZh
bHVlIGV4Y2VwdCBvbiBjb250cm9sbGVyIHJlc2V0IGFuZA0KwqDCoMKgIGl0IGlzIHNhZmUgdG8g
cmV0dXJuIGRpZmZlcmVudCB2YWx1ZSBvbiBhIG5ldyByZXF1ZXN0LiBUaGlzIGlzIG5vdCBhDQp2
ZXJ5DQrCoMKgwqAgYmlnIGRlYWwuDQoNCkRlbg0K

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZHCx-0004Lp-O2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZH1v-00066a-UJ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:11:37 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 18 Dec 2018 15:11:18 +0000
Message-ID: <b91e2cff-2d5c-f5dd-e8cc-7a8944c93de4@virtuozzo.com>
References: <20181215135324.152629-1-eblake@redhat.com>
	<20181215135324.152629-8-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-8-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CB7EB09CC043D409E593144DC42674E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 07/22] qemu-nbd: Avoid strtol open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MTUuMTIuMjAxOCAxNjo1MywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT3VyIGNvcHktYW5kLXBhc3Rl
ZCBvcGVuLWNvZGluZyBvZiBzdHJ0b2wgaGFuZGxpbmcgZm9yZ290IHRvDQo+IGhhbmRsZSBvdmVy
ZmxvdyBjb25kaXRpb25zLiAgVXNlIHFlbXVfc3RydG8qKCkgaW5zdGVhZC4NCj4gDQo+IEluIHRo
ZSBjYXNlIG9mIC0tcGFydGl0aW9uLCBzaW5jZSB3ZSBpbnNpc3Qgb24gYSB1c2VyLXN1cHBsaWVk
DQo+IHBhcnRpdGlvbiB0byBiZSBub24temVybywgd2UgY2FuIHVzZSAwIHJhdGhlciB0aGFuIC0x
IGZvciBvdXINCj4gaW5pdGlhbCB2YWx1ZSB0byBkaXN0aW5ndWlzaCB3aGVuIGEgcGFydGl0aW9u
IGlzIG5vdCBiZWluZw0KPiBzZXJ2ZWQsIGZvciBzbGlnaHRseSBtb3JlIG9wdGltYWwgY29kZS4N
Cj4gDQo+IFRoZSBlcnJvciBtZXNzYWdlcyBmb3Igb3V0LW9mLWJvdW5kcyB2YWx1ZXMgYXJlIGxl
c3Mgc3BlY2lmaWMsDQo+IGJ1dCBzaG91bGQgbm90IGJlIGEgdGVycmlibGUgbG9zcyBpbiBxdWFs
aXR5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+
DQo+IA0KPiAtLS0NCj4gdjI6IFJldGl0bGUsIGNhdGNoIG1vcmUgdXNlcyBvZiBzdHJ0b2wNCj4g
W0htbSAtIHRoaXMgZGVwZW5kcyBvbiBpbnQ2NF90IGFuZCBvZmZfdCBiZWluZyBjb21wYXRpYmxl
OyBpZiB0aGV5DQo+IGFyZW4ndCB0aGF0IHdheSBvbiBhbGwgcGxhdGZvcm1zLCBJJ2xsIG5lZWQg
YSB0ZW1wb3JhcnkgdmFyaWFibGVdDQoNCmhtbSwgYXMgSSB1bmRlcnN0YW5kLCBldmVuIGlmIHRo
aXMgY29tcGF0aWJpbGl0eSBleGlzdHMsIGl0J3Mgbm90IGEgcGFydA0Kb2Ygc3RhbmRhcmQgYW5k
IG5vdGhpbmcgYWJvdXQgb2ZmX3Qgc2l6ZSBpbiBQT1NJWC4uDQoNCk1vcmVvdmVyOiB3aGF0IGlz
IHRoZSByZWFzb24gZm9yIHVzaW5nIG9mZl90IGluIE5CRCBjb2RlPyBXZSBkb24ndCBoYXZlIGl0
DQppbiBOQkQgcHJvdG9jb2wsIHdlIGRvbid0IGhhdmUgaXQgaW4gZ2VuZXJpYyBibG9jayBsYXll
ciBpbnRlcmZhY2UuIElzbid0IGl0DQphbHdheXMgY2FzdGVkIHRvIGludDY0X3Qgb3IgbGlrZSB0
aGlzPw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

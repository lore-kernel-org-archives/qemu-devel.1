Received: from eggs.gnu.org ([209.51.188.92]:35647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gjR7w-00074O-Cw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:59:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gjR7v-0008Ta-MM
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:59:44 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 15 Jan 2019 15:59:35 +0000
Message-ID: <7f84b5ef-445c-9c7b-894c-f6d81bf944a3@virtuozzo.com>
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-11-eblake@redhat.com>
	<e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
	<c0ab928c-3efc-41fd-f16f-6a6b4e465e9a@redhat.com>
	<52cbe9ac-0b58-e545-4b50-ab03fee642d4@virtuozzo.com>
	<12a8e60d-8357-06d0-d689-ecc7a5f63435@redhat.com>
In-Reply-To: <12a8e60d-8357-06d0-d689-ecc7a5f63435@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1B8B2030738C4DBC1F05654B7A8B58@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 10/19] nbd/client: Split out
 nbd_send_one_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MTUuMDEuMjAxOSAxODo1NSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMS8xNS8xOSA5OjUyIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pj4+IC1uYmRfb3B0
X21ldGFfcmVxdWVzdChjb25zdCBjaGFyICpjb250ZXh0LCBjb25zdCBjaGFyICpleHBvcnQpICJS
ZXF1ZXN0aW5nIHRvIHNldCBtZXRhIGNvbnRleHQgJXMgZm9yIGV4cG9ydCAlcyINCj4+Pj4+ICtu
YmRfb3B0X21ldGFfcmVxdWVzdChjb25zdCBjaGFyICpvcHRuYW1lLCBjb25zdCBjaGFyICpjb250
ZXh0LCBjb25zdCBjaGFyICpleHBvcnQpICJSZXF1ZXN0aW5nICVzICVzIGZvciBleHBvcnQgJXMi
DQo+Pj4+DQo+Pj4+IEhtbSwgeW91IGZvcmdldCBuYmRfb3B0X2xvb2t1cCgpDQo+Pj4NCj4+PiBX
aGVyZT8gVGhlIHVwZGF0ZWQgdHJhY2UgcG9pbnQgYXQgWzJdIGhhcyBuYmRfb3B0X2xvb2t1cCgp
IGZvcg0KPj4+IGRldGVybWluaW5nIG9wdG5hbWUuDQo+Pg0KPj4gWW91ciBtb3JuaW5nIGlzIG15
IGV2ZW5pbmcpDQo+Pg0KPj4gWWVzLCBpdCdzIG9rLCBhbmQgaW4gdGhlIG5leHQgcGF0Y2ggdG9v
LiBCdXQgeW91IHVzdWFsbHkgdHJhY2UgYm90aCBudW1iZXIgKyBsb29rdXAtc3RyaW5nLA0KPj4g
YW5kIGhlcmUgb25seSBzdHJpbmcuIElzIHRoZXJlIGEgcmVhc29uIHRvPw0KPiANCj4gSSBkaWRu
J3Qgc2VlIGFueSBhZGRlZCB2YWx1ZSBpbiB0cmFjaW5nIHRoZSBudW1iZXIsIHNpbmNlIHRoZSB0
cmFjZQ0KPiBwb2ludCBjYW4gb25seSBoYXBwZW4gb24gb25lIG9mIHR3byBvcHQgdmFsdWVzICh0
aGUgbnVtYmVyIGlzIG1vcmUNCj4gaW1wb3J0YW50IHdoZW4gdGhlIG9wdCB2YWx1ZSBjYW4gYmUg
YW55dGhpbmcsIGluY2x1ZGluZyBvbmUgdGhhdCBkb2VzDQo+IG5vdCBoYXZlIGEgY29ycmVzcG9u
ZGluZyBzdHJpbmcgbmFtZSBjb21waWxlZCBpbikuDQo+IA0KDQpPSywgYWdyZWVkLg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

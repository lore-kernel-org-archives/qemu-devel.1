Received: from eggs.gnu.org ([209.51.188.92]:57682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPJa-00081c-VS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPJa-00064T-0C
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 Apr 2019 09:44:35 +0000
Message-ID: <35da9a3a-32e2-5db2-1342-ce8d48531709@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
	<66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
In-Reply-To: <66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <524FAF3FEF99434C9825C20C825D4170@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>

MzAuMDQuMjAxOSAxMTozOCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MjkuMDQuMjAxOSAxOTozNywgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMDIuMDQuMTkgMTc6Mzcs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gQmFja2dyb3VuZDogZGVj
cnlwdGlvbiB3aWxsIGJlIGRvbmUgaW4gdGhyZWFkcywgdG8gdGFrZSBiZW5lZml0IG9mIGl0LA0K
Pj4+IHdlIHNob3VsZCBtb3ZlIGl0IG91dCBvZiB0aGUgbG9jayBmaXJzdC4NCj4+DQo+PiAuLi53
aGljaCBpcyBzYWZlIGFmdGVyIHlvdXIgY29tbWl0IGM5NzJmYTEyM2M3MzUwMWI0LCBJIHByZXN1
bWUuDQo+Pg0KPj4gKEF0IGZpcnN0IGdsYW5jZSwgdGhlIHBhdGNoZWQgbG9va2VkIGEgYml0IHdl
aXJkIHRvIG1lIGJlY2F1c2UgaXQNCj4+IGRvZXNuJ3QgZ2l2ZSBhIHJlYXNvbiB3aHkgZHJvcHBp
bmcgdGhlIGxvY2sgYXJvdW5kDQo+PiBxY3J5cHRvX2Jsb2NrX2RlY3J5cHQoKSB3b3VsZCBiZSBP
Sy4pDQo+Pg0KPj4+IEJ1dCBsZXQncyBnbyBmdXJ0aGVyOiBpdCB0dXJucyBvdXQsIHRoYXQgZm9y
IGxvY2tpbmcgYXJvdW5kIHN3aXRjaA0KPj4+IGNhc2VzIHdlIGhhdmUgb25seSB0d28gdmFyaWFu
dHM6IHdoZW4gd2UganVzdCBkbyBtZW1zZXQoMCkgbm90DQo+Pj4gcmVsZWFzaW5nIHRoZSBsb2Nr
IChpdCBpcyB1c2VsZXNzKSBhbmQgd2hlbiB3ZSBhY3R1YWxseSBjYW4gaGFuZGxlIHRoZQ0KPj4+
IHdob2xlIGNhc2Ugb3V0IG9mIHRoZSBsb2NrLiBTbywgcmVmYWN0b3IgdGhlIHdob2xlIHRoaW5n
IHRvIHJlZHVjZQ0KPj4+IGxvY2tlZCBjb2RlIHJlZ2lvbiBhbmQgbWFrZSBpdCBjbGVhbi4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+PiBSZXZpZXdlZC1ieTogQWxiZXJ0byBHYXJjaWEgPGJl
cnRvQGlnYWxpYS5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgYmxvY2svcWNvdzIuYyB8IDQ2ICsrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4+PiBpbmRleCA0NmU4ZTM5
ZGE1Li5mY2Y5MmE3ZWI2IDEwMDY0NA0KPj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4+PiArKysg
Yi9ibG9jay9xY293Mi5jDQo+Pj4gQEAgLTE5ODMsNiArMTk4Myw3IEBAIHN0YXRpYyBjb3JvdXRp
bmVfZm4gaW50IHFjb3cyX2NvX3ByZWFkdihCbG9ja0RyaXZlclN0YXRlICpicywgdWludDY0X3Qg
b2Zmc2V0LA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBxY293Ml9nZXRfY2x1c3Rlcl9v
ZmZzZXQoYnMsIG9mZnNldCwgJmN1cl9ieXRlcywgJmNsdXN0ZXJfb2Zmc2V0KTsNCj4+DQo+PiBJ
c24ndCB0aGlzIHRoZSBvbmx5IGZ1bmN0aW9uIGluIHRoZSBsb29wIHRoYXQgYWN0dWFsbHkgbmVl
ZHMgdGhlIGxvY2s/DQo+PiBXb3VsZG4ndCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8ganVzdCB0YWtl
IGl0IGFyb3VuZCB0aGlzIGNhbGw/DQo+Pg0KPiANCj4gSG1tLCBsb29rcyBjb3JyZWN0LCBJJ2xs
IHJlc2VuZC4NCj4gDQo+IA0KDQpPciBub3QsIGFjdHVhbGx5LCB3ZSBtYXkgaGF2ZSBzZXZlcmFs
IHFjb3cyX2dldF9kYXRhX29mZnNldCBjYWxscyB1bmRlciBvbmUgbG9jaywNCmlmIGNsdXN0ZXJz
IGFyZSBkaWZmZXJlbnQga2luZHMgb2YgWkVSTy4gU28sIEkgdGhpbmsgYmV0dGVyIHRvIGtlZXAg
aXQgYXMgaXMgZm9yIG5vdy4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

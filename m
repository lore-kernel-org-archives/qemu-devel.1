Received: from eggs.gnu.org ([209.51.188.92]:53673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyfNM-00061i-9f
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyfNK-0001Uo-1E
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:14:36 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 26 Feb 2019 16:14:13 +0000
Message-ID: <1f085844-30f3-5ff1-8bac-2fec70a93eee@virtuozzo.com>
References: <1551196405-23815-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551196405-23815-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <043E7B0ED8334047915552914CF250BC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] iotests: handle TypeError for Python 3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

U29ycnkgYWJvdXQgdGhlIG1pc3NlZCAnU2lnbmVkLW9mZi1ieTogTmlyIFNvZmZlciA8bnNvZmZl
ckByZWRoYXQuY29tPicNClRoZSBwYXRjaCBoYXMgYmVlbiByZXNlbnQuDQoNCk9uIDI2LzAyLzIw
MTkgMTg6NTMsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPiBUaGUgZGF0YSB0eXBlIGZvciBi
eXRlcyBpbiBQeXRob24gMyBkaWZmZXJzIGZyb20gdGhlIG9uZSBpbiBQeXRob24gMi4NCj4gVGhl
IHR5cGUgY2FzdCB0aGF0IGlzIGNvbXBhdGlibGUgd2l0aCBib3RoIHZlcnNpb25zIHdhcyBhcHBs
aWVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlu
a2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IFJlcG9ydGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkBy
ZWRoYXQuY29tPg0KPiAtLS0NCj4gdjI6DQo+IFRoZSBUeXBlRXJyb3IgaW4gUHl0aG9uMyB3YXMg
aGFuZGxlZCBiYXNlZCBvbiB0aGUgdmVyc2lvbiBjaGVjay4NCj4gRGlzY3Vzc2VkIGluIHRoZSBl
LW1haWwgdGhyZWFkIHdpdGggdGhlIE1lc3NhZ2UgSUQ6DQo+IDwxNTUwODM0NzczLTg3MzUxMi0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+IA0KPiB2
MToNCj4gVGhlIFR5cGVFcnJvciBpbiBQeXRob24zIHdhcyBoYW5kbGVkIGFzIHRoZSBleGNlcHRp
b24uDQo+IERpc2N1c3NlZCBpbiB0aGUgZS1tYWlsIHRocmVhZCB3aXRoIHRoZSBNZXNzYWdlIElE
Og0KPiA8MTU1MDUxOTk5Ny0yNTM1MzQtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hpbmtldmlj
aEB2aXJ0dW96em8uY29tPg0KPiANCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMjQyIHwgOCArKysr
Ky0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MiBiL3Rlc3RzL3FlbXUt
aW90ZXN0cy8yNDINCj4gaW5kZXggMTZjNjVlZC4uYzE3NmU5MiAxMDA3NTUNCj4gLS0tIGEvdGVz
dHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQyDQo+IEBA
IC0yMCw2ICsyMCw3IEBADQo+ICAgDQo+ICAgaW1wb3J0IGlvdGVzdHMNCj4gICBpbXBvcnQganNv
bg0KPiAraW1wb3J0IHN0cnVjdA0KPiAgIGZyb20gaW90ZXN0cyBpbXBvcnQgcWVtdV9pbWdfY3Jl
YXRlLCBxZW11X2lvLCBxZW11X2ltZ19waXBlLCBcDQo+ICAgICAgIGZpbGVfcGF0aCwgaW1nX2lu
Zm9fbG9nLCBsb2csIGZpbHRlcl9xZW11X2lvDQo+ICAgDQo+IEBAIC02NCwxMCArNjUsMTEgQEAg
ZGVmIHdyaXRlX3RvX2Rpc2sob2Zmc2V0LCBzaXplKToNCj4gICBkZWYgdG9nZ2xlX2ZsYWcob2Zm
c2V0KToNCj4gICAgICAgd2l0aCBvcGVuKGRpc2ssICJyK2IiKSBhcyBmOg0KPiAgICAgICAgICAg
Zi5zZWVrKG9mZnNldCwgMCkNCj4gLSAgICAgICAgYyA9IGYucmVhZCgxKQ0KPiAtICAgICAgICB0
b2dnbGVkID0gY2hyKG9yZChjKSBeIGJpdG1hcF9mbGFnX3Vua25vd24pDQo+ICsgICAgICAgICMg
UmVhZCBvbmUgYnl0ZSBpbiBhIHdheSBjb21wYXRpYmxlIHdpdGggUHl0aG9uIDINCj4gKyAgICAg
ICAgZmxhZ3MgPSBzdHJ1Y3QudW5wYWNrKCJCIiwgZi5yZWFkKDEpKQ0KPiArICAgICAgICB0b2dn
bGVkID0gZmxhZ3NbMF0gXiBiaXRtYXBfZmxhZ191bmtub3duDQo+ICAgICAgICAgICBmLnNlZWso
LTEsIDEpDQo+IC0gICAgICAgIGYud3JpdGUodG9nZ2xlZCkNCj4gKyAgICAgICAgZi53cml0ZShz
dHJ1Y3QucGFjaygiQiIsIHRvZ2dsZWQpKQ0KPiAgIA0KPiAgIA0KPiAgIHFlbXVfaW1nX2NyZWF0
ZSgnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgZGlzaywgJzFNJykNCj4gDQoNCi0tIA0KV2l0aCB0aGUg
YmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

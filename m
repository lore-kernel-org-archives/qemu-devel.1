Received: from eggs.gnu.org ([209.51.188.92]:57413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gxTTN-0002b1-Ej
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 04:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gxTTM-0004vc-J8
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 04:19:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 23 Feb 2019 09:19:21 +0000
Message-ID: <95b96a00-d8b2-45d4-75b5-ff513e5eaeb1@virtuozzo.com>
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC3EE34EEA3FDF42B987F90F18D487AB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] iotests: handle TypeError for Python3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, "crosa@redhat.com" <crosa@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjIuMDIuMjAxOSAxNDoyNiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBkYXRhIHR5
cGUgZm9yIGJ5dGVzIGluIFB5dGhvbjMgZGlmZmVycyBmcm9tIHRoZSBvbmUgaW4gUHl0aG9uMi4N
Cj4gVGhvc2UgY2FzZXMgc2hvdWxkIGJlIG1hbmFnZWQgc2VwYXJhdGVseS4NCj4gDQo+IHYxOg0K
PiBJbiB0aGUgZmlyc3QgdmVyc2lvbiwgdGhlIFR5cGVFcnJvciBpbiBQeXRob24zIHdhcyBoYW5k
bGVkIGFzIHRoZQ0KPiBleGNlcHRpb24uDQo+IERpc2N1c3NlZCBpbiB0aGUgZS1tYWlsIHRocmVh
ZCB3aXRoIHRoZSBNZXNzYWdlIElEOg0KPiA8MTU1MDUxOTk5Ny0yNTM1MzQtMS1naXQtc2VuZC1l
bWFpbC1hbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+
IFJlcG9ydGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0
ZXN0cy9xZW11LWlvdGVzdHMvMjQyIHwgOCArKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMv
cWVtdS1pb3Rlc3RzLzI0MiBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDINCj4gaW5kZXggMTZjNjVl
ZC4uNDQ2ZmJmOCAxMDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPiArKysg
Yi90ZXN0cy9xZW11LWlvdGVzdHMvMjQyDQo+IEBAIC0yMCw2ICsyMCw3IEBADQo+ICAgDQo+ICAg
aW1wb3J0IGlvdGVzdHMNCj4gICBpbXBvcnQganNvbg0KPiAraW1wb3J0IHN5cw0KPiAgIGZyb20g
aW90ZXN0cyBpbXBvcnQgcWVtdV9pbWdfY3JlYXRlLCBxZW11X2lvLCBxZW11X2ltZ19waXBlLCBc
DQo+ICAgICAgIGZpbGVfcGF0aCwgaW1nX2luZm9fbG9nLCBsb2csIGZpbHRlcl9xZW11X2lvDQo+
ICAgDQo+IEBAIC02NSw5ICs2NiwxMiBAQCBkZWYgdG9nZ2xlX2ZsYWcob2Zmc2V0KToNCj4gICAg
ICAgd2l0aCBvcGVuKGRpc2ssICJyK2IiKSBhcyBmOg0KPiAgICAgICAgICAgZi5zZWVrKG9mZnNl
dCwgMCkNCj4gICAgICAgICAgIGMgPSBmLnJlYWQoMSkNCj4gLSAgICAgICAgdG9nZ2xlZCA9IGNo
cihvcmQoYykgXiBiaXRtYXBfZmxhZ191bmtub3duKQ0KPiArICAgICAgICB0b2dnbGVkID0gb3Jk
KGMpIF4gYml0bWFwX2ZsYWdfdW5rbm93bg0KPiAgICAgICAgICAgZi5zZWVrKC0xLCAxKQ0KPiAt
ICAgICAgICBmLndyaXRlKHRvZ2dsZWQpDQo+ICsgICAgICAgIGlmIHN5cy52ZXJzaW9uX2luZm8u
bWFqb3IgPj0gMzoNCj4gKyAgICAgICAgICAgIGYud3JpdGUoYnl0ZXMoW3RvZ2dsZWRdKSkNCj4g
KyAgICAgICAgZWxzZToNCj4gKyAgICAgICAgICAgIGYud3JpdGUoY2hyKHRvZ2dsZWQpKQ0KPiAg
IA0KPiAgIA0KPiAgIHFlbXVfaW1nX2NyZWF0ZSgnLWYnLCBpb3Rlc3RzLmltZ2ZtdCwgZGlzaywg
JzFNJykNCj4gDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

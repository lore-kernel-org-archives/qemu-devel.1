Received: from eggs.gnu.org ([209.51.188.92]:52229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grHrG-0005u1-Pq
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grHrG-0002II-39
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:42:58 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Feb 2019 07:42:52 +0000
Message-ID: <9dc9efac-ef70-062f-4668-7ee57bab8026@virtuozzo.com>
References: <1549397675-189741-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549397675-189741-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4644405AB33EFE429810A3D467AE8424@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDUuMDIuMjAxOSAyMzoxNCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IEEgbmV3IHRlc3Qg
ZmlsZSAyNDIgYWRkZWQgdG8gdGhlIHFlbXUtaW90ZXN0cyBzZXQuIEl0IGNoZWNrcw0KPiB0aGUg
Zm9ybWF0IG9mIHFjb3cyIHNwZWNpZmljIGluZm9ybWF0aW9uIGZvciB0aGUgbmV3IGFkZGVkDQo+
IHNlY3Rpb24gdGhhdCBsaXN0cyBkZXRhaWxzIG9mIGJpdG1hcHMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4N
Cj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0MiAgICAgfCAxMDAgKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mi5vdXQgfCAxNjcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVt
dS1pb3Rlc3RzL2dyb3VwICAgfCAgIDEgKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjY4IGluc2Vy
dGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mg0K
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjQyLm91dA0KPiANCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDIgYi90ZXN0cy9xZW11LWlvdGVzdHMv
MjQyDQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAuLjk1YzFmMTgNCj4g
LS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQyDQoNClsuLl0NCg0K
PiArDQo+ICtkZWYgdG9nZ2xlX2ZsYWcob2Zmc2V0KToNCj4gKyAgICBmID0gb3BlbihkaXNrLCAi
citiIikNCj4gKyAgICBmLnNlZWsob2Zmc2V0LCAwKQ0KPiArICAgIGMgPSBmLnJlYWQoMSkNCj4g
KyAgICB0b2dnbGVkID0gY2hyKG9yZChjKSBeIGJpdG1hcF9mbGFnX3Vua25vd24pDQo+ICsgICAg
Zi5zZWVrKC0xLCAxKQ0KPiArICAgIGYud3JpdGUodG9nZ2xlZCkNCj4gKyAgICBmLmNsb3NlKCkN
Cg0Kb2ssIGJ1dCBiZXR0ZXIgdXNlICJ3aXRoIiwgbGlrZQ0Kd2l0aCBvcGVuKGRpc2ssICJyK2Ii
KSBhcyBmOg0KICAgIC4uLg0KDQphcyBmaWxlIHdpbGwgYmUgY2xvc2VkIG9uIGFueSBleGNlcHRp
b24NCg0KDQpXaXRoIG9yIHdpdGhvdXQgdGhhdCBmaXhlZDoNClJldmlld2VkLWJ5OiBWbGFkaW1p
ciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

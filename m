Received: from eggs.gnu.org ([209.51.188.92]:35154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gvp58-0006Gp-Cs
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gvp57-0007ax-GN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 15:00:02 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 18 Feb 2019 19:59:47 +0000
Message-ID: <f3695df7-7543-5eda-49e8-b45f34f8042d@virtuozzo.com>
References: <1549638368-530182-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549638368-530182-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190218161207.GD5303@dhcp-200-176.str.redhat.com>
In-Reply-To: <20190218161207.GD5303@dhcp-200-176.str.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD46EC18E17ADF448FF50676F944E3B6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v14 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "fam@euphon.net" <fam@euphon.net>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDE4LzAyLzIwMTkgMTk6MTIsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDA4LjAyLjIw
MTkgdW0gMTY6MDYgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2NocmllYmVuOg0KPj4gQSBuZXcg
dGVzdCBmaWxlIDI0MiBhZGRlZCB0byB0aGUgcWVtdS1pb3Rlc3RzIHNldC4gSXQgY2hlY2tzDQo+
PiB0aGUgZm9ybWF0IG9mIHFjb3cyIHNwZWNpZmljIGluZm9ybWF0aW9uIGZvciB0aGUgbmV3IGFk
ZGVkDQo+PiBzZWN0aW9uIHRoYXQgbGlzdHMgZGV0YWlscyBvZiBiaXRtYXBzLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tPg0KPiANCj4gVGhpcyBkb2Vzbid0IHNlZW0gdG8gYmUgUHl0aG9uIDMgY29tcGF0aWJs
ZS4NCj4gDQo+IEtldmluDQo+IA0KDQpUaGFuayB5b3UsIEtldmluLg0KRml4ZWQuIFBsZWFzZSBy
ZXZpZXcgdGhlIHBhdGNoDQowMDAxLWlvdGVzdHMtaGFuZGxlLVR5cGVFcnJvci1mb3ItUHl0aG9u
My1pbi10ZXN0LTI0Mi5wYXRjaA0KDQo+IA0KPiAyNDIgICAgICAgICAgICAgICAgWzE3OjA5OjI3
XSBbMTc6MDk6MjldIFtmYWlsZWQsIGV4aXQgc3RhdHVzIDFdIC0gb3V0cHV0IG1pc21hdGNoIChz
ZWUgMjQyLm91dC5iYWQpDQo+IC0tLSAvaG9tZS9rd29sZi9zb3VyY2UvcWVtdS90ZXN0cy9xZW11
LWlvdGVzdHMvMjQyLm91dCAgMjAxOS0wMi0xMyAxMjo1OTozOC43NDgyNjIzNjQgKzAxMDANCj4g
KysrIC9ob21lL2t3b2xmL3NvdXJjZS9xZW11L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDIub3V0LmJh
ZCAgICAgIDIwMTktMDItMTggMTc6MDk6MjkuMzE0NjM3NTk3ICswMTAwDQo+IEBAIC0xNDMsMjQg
KzE0Myw5IEBADQo+ICAgeyJleGVjdXRlIjogImJsb2NrLWRpcnR5LWJpdG1hcC1hZGQiLCAiYXJn
dW1lbnRzIjogeyJkaXNhYmxlZCI6IGZhbHNlLCAiZ3JhbnVsYXJpdHkiOiAxNjM4NCwgIm5hbWUi
OiAiYml0bWFwLTAiLCAibm9kZSI6ICJkcml2ZTAiLCAicGVyc2lzdGVudCI6IHRydWV9fQ0KPiAg
IHsicmV0dXJuIjoge319DQo+ICAgV3JpdGUgYW4gdW5rbm93biBiaXRtYXAgZmxhZyAnMHg0JyBp
bnRvIGEgbmV3IFFDT1cyIGltYWdlIGF0IG9mZnNldCAzMjc2OTUNCj4gLXFlbXUtaW1nOiBDb3Vs
ZCBub3Qgb3BlbiAnVEVTVF9JTUcnOiBCaXRtYXAgJ2JpdG1hcC0wJyBkb2Vzbid0IHNhdGlzZnkg
dGhlIGNvbnN0cmFpbnRzDQo+IC0NCj4gLVVuc2V0IHRoZSB1bmtub3duIGJpdG1hcCBmbGFnICcw
eDQnIGluIHRoZSBiaXRtYXAgZGlyZWN0b3J5IGVudHJ5Og0KPiAtDQo+IC1pbWFnZTogVEVTVF9J
TUcNCj4gLWZpbGUgZm9ybWF0OiBJTUdGTVQNCj4gLXZpcnR1YWwgc2l6ZTogMS4wTSAoMTA0ODU3
NiBieXRlcykNCj4gLWNsdXN0ZXJfc2l6ZTogNjU1MzYNCj4gLUZvcm1hdCBzcGVjaWZpYyBpbmZv
cm1hdGlvbjoNCj4gLSAgICBjb21wYXQ6IDEuMQ0KPiAtICAgIGxhenkgcmVmY291bnRzOiBmYWxz
ZQ0KPiAtICAgIGJpdG1hcHM6DQo+IC0gICAgICAgIFswXToNCj4gLSAgICAgICAgICAgIGZsYWdz
Og0KPiAtICAgICAgICAgICAgICAgIFswXTogYXV0bw0KPiAtICAgICAgICAgICAgbmFtZTogYml0
bWFwLTANCj4gLSAgICAgICAgICAgIGdyYW51bGFyaXR5OiAxNjM4NA0KPiAtICAgIHJlZmNvdW50
IGJpdHM6IDE2DQo+IC0gICAgY29ycnVwdDogZmFsc2UNCj4gLQ0KPiAtVGVzdCBjb21wbGV0ZQ0K
PiArVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPiArICBGaWxlICIyNDIiLCBs
aW5lIDk4LCBpbiA8bW9kdWxlPg0KPiArICAgIHRvZ2dsZV9mbGFnKGZsYWdfb2Zmc2V0KQ0KPiAr
ICBGaWxlICIyNDIiLCBsaW5lIDcwLCBpbiB0b2dnbGVfZmxhZw0KPiArICAgIGYud3JpdGUodG9n
Z2xlZCkNCj4gK1R5cGVFcnJvcjogYSBieXRlcy1saWtlIG9iamVjdCBpcyByZXF1aXJlZCwgbm90
ICdzdHInDQo+IEZhaWx1cmVzOiAyNDINCj4gRmFpbGVkIDEgb2YgMSB0ZXN0cw0KPiANCg0KLS0g
DQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K

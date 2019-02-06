Received: from eggs.gnu.org ([209.51.188.92]:44042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grRdx-0008MF-Jz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:09:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grRdw-0005Yw-PC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:09:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Feb 2019 18:09:21 +0000
Message-ID: <aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
	<20190206165342.219192-3-vsementsov@virtuozzo.com>
	<abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
In-Reply-To: <abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB5E6FAB1C88924FA7ECB704437E7E2B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>

MDYuMDIuMjAxOSAyMDozMiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi82LzE5IDEwOjUzIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gVXNlIG5ldyBxZW11X2lv
dmVjX2luaXRfYnVmKCkgaW5zdGVhZCBvZg0KPj4gcWVtdV9pb3ZlY19pbml0X2V4dGVybmFsKCAu
Li4gLCAxKSwgd2hpY2ggc2ltcGxpZmllcyB0aGUgY29kZS4NCj4gDQo+IERpZCB5b3UganVzdCBk
byBhIG1hbnVhbCBzZWFyY2ggZm9yIGNhbmRpZGF0ZSBjYWxsZXJzPw0KPiANCj4gQXMgeW91IHNh
aWQgaW4gdGhlIGNvdmVyIGxldHRlciwgdGhlcmUgYXJlIG90aGVyIGZpbGVzIHRoYXQgY2FuIGJl
bmVmaXQNCj4gYXMgd2VsbDsgYXJlIHlvdSBwbGFubmluZyBvbiBtYWtpbmcgdjMgb2YgdGhlIHNl
cmllcyBsb25nZXI/DQoNCmdpdCBncmVwIHFlbXVfaW92ZWNfaW5pdF9leHRlcm5hbCB8IGdyZXAg
MQ0KDQpzaG93cyBhIGxvdCBvZiwgZXhhY3RseSAzNCBhZnRlciBpby5jIGFscmVhZHkgdXBkYXRl
ZC4NClRoZXkgYXJlIGluIGRpZmZlcmVudCBzdWJzeXN0ZW1zLCBzbyBJIHRoaW5rIGl0IHNob3Vs
ZCBiZSBzaW1wbGVyIHRvIHB1c2ggdGhpcw0Kb25lIGFzIGEgcHJlY2VkZW50IGFuZCBleGFtcGxl
LCBhbmQgdGhlbiBzZW5kIHNlcGFyYXRlIHBhdGNoZXMgKG9yIHNlcmllcykNCnBlci1tYWludGFp
bmVyLg0KDQpobSwgaW4gb3RoZXIgd29yZHM6DQojIGdpdCBncmVwIC1sICdxZW11X2lvdmVjX2lu
aXRfZXh0ZXJuYWwuKjEnDQpibG9jay9iYWNrdXAuYw0KYmxvY2svYmxvY2stYmFja2VuZC5jDQpi
bG9jay9jb21taXQuYw0KYmxvY2svcGFyYWxsZWxzLmMNCmJsb2NrL3Fjb3cuYw0KYmxvY2svcWNv
dzIuYw0KYmxvY2svcWVkLXRhYmxlLmMNCmJsb2NrL3FlZC5jDQpibG9jay9zdHJlYW0uYw0KYmxv
Y2svdm1kay5jDQpody9pZGUvYXRhcGkuYw0KaHcvaWRlL2NvcmUuYw0KaHcvc2NzaS9zY3NpLWRp
c2suYw0KbWlncmF0aW9uL2Jsb2NrLmMNCnFlbXUtaW1nLmMNCnRlc3RzL3Rlc3QtYmRydi1kcmFp
bi5jDQoNCg0KDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1P
Z2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9p
by5jIHwgOTAgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA2OSBkZWxldGlv
bnMoLSkNCj4gDQo+IEJ1dCBJJ20gbG92aW5nIHRoZSBkaWZmc3RhdCAtIGl0IGlzIGRlZmluaXRl
bHkgYSBuaWNlIGNoYW5nZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VA
cmVkaGF0LmNvbT4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

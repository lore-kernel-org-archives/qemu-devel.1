Received: from eggs.gnu.org ([209.51.188.92]:56853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gzItp-0004Uf-GV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gzIto-0000CL-Jg
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:26:45 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 28 Feb 2019 10:26:28 +0000
Message-ID: <bd945ddd-a8be-6bcb-1853-c604adc161dd@virtuozzo.com>
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F1CF14C5C436345B8C56EC21DF8C03E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: discard bitmap when removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MjguMDIuMjAxOSAxMjoyNiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFdoZW4gYSBiaXRt
YXAgaXMgcmVtb3ZlZCwgd2UgY2FuIGNsZWFuIHNvbWUgc3BhY2Ugb24gdGhlIGRpc2suIFRoZSBz
aXplDQo+IG9mIGEgY2x1c3RlciBtYXkgYmUgbGFyZ2VyLCBzbyBpcyB0aGUgc2l6ZSBvZiB0aGUg
Yml0bWFwIHRoYXQgaW5jbHVkZXMNCj4gbWFueSBjbHVzdGVycy4gU29tZSBiaXRtYXBzIGNhbiBi
ZSBhcyBsYXJnZSBhcyB0ZW5zIG9mIG1lZ2FieXRlcy4NCj4gVGhlIGZsYWcgUUNPVzJfRElTQ0FS
RF9BTFdBWVMgYWxsb3dzIGEgY2FsbCB0byB0aGUgcmF3X2NvX3BkaXNjYXJkKCkNCj4gdGhhdCBk
b2VzIHRoZSBhY3R1YWwgY2xlYW5pbmcgb2YgdGhlIGltYWdlIG9uIGRpc2ssIHdoaWxlIHdpdGgg
dGhlIGZsYWcNCj4gUUNPVzJfRElTQ0FSRF9PVEhFUiwgYSByZWZlcmVuY2UgY291bnQgb2YgdGhl
IGNsdXN0ZXIgaXMgdXBkYXRlZCBvbmx5Lg0KDQpub3QgcXVpdGUgcmlnaHQsIGFzIGl0IGRlcGVu
ZHMgb24gY29uZmlndXJhdGlvbi4NCg0KU28gSSdkIHJld29yZCB0aGUgd2hvbGUgbWVzc2FnZSB0
byBiZSBzaW1wbGVyLCBsaWtlOg0KDQpCaXRtYXAgZGF0YSBtYXkgdGFrZSBhIGxvdCBvZiBkaXNr
IHNwYWNlLCBzbyBpdCdzIGJldHRlciB0byBkaXNjYXJkIGl0IGFsd2F5cy4NCg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6
by5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KPiAtLS0NCj4gdjE6IERpc2NhcmQgb2xkIGJpdG1h
cCBkaXJlY3RvcmllcyBpbiBRQ09XMiBpbWFnZQ0KPiANCj4gSW4gdGhlIGZpcnN0IHZlcnNpb24g
b2YgdGhlIHBhdGNoLCBhbnkgY2FsbCB0byBxY293Ml9mcmVlX2NsdXN0ZXJzKCkgaW4NCj4gYmxv
Y2svcWNvdzItYml0bWFwLmMgd2FzIHdpdGggdGhlIGZsYWcgUUNPVzJfRElTQ0FSRF9BTFdBWVMs
IGV2ZW4gaW4gdGhlDQo+IGNhc2VzIHdoZW4gdGhlIGNsZWFuZWQgc3BhY2UgaXMgaW5zaWduaWZp
Y2FudCwgcGFydGljdWxhcmx5LCBpbiBjYXNlIG9mDQo+IGJpdG1hcCBkaXJlY3Rvcmllcy4NCj4g
RGlzY3Vzc2VkIGluIHRoZSBlbWFpbCB0aHJlYWQgd2l0aCB0aGUgbWVzc2FnZSBJRA0KPiA8MTU0
OTk3NDk1MS03MzEyODUtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tPg0KPiANCj4gICBibG9jay9xY293Mi1iaXRtYXAuYyB8IDIgKy0NCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9ibG9jay9xY293Mi1iaXRtYXAuYyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+IGluZGV4IDNl
ZTUyNGQuLjE2Mjc0NGUgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ICsr
KyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+IEBAIC0yMDIsNyArMjAyLDcgQEAgc3RhdGljIHZv
aWQgY2xlYXJfYml0bWFwX3RhYmxlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB1aW50NjRfdCAqYml0
bWFwX3RhYmxlLA0KPiAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiAgICAgICAgICAgfQ0KPiAg
IA0KPiAtICAgICAgICBxY293Ml9mcmVlX2NsdXN0ZXJzKGJzLCBhZGRyLCBzLT5jbHVzdGVyX3Np
emUsIFFDT1cyX0RJU0NBUkRfT1RIRVIpOw0KPiArICAgICAgICBxY293Ml9mcmVlX2NsdXN0ZXJz
KGJzLCBhZGRyLCBzLT5jbHVzdGVyX3NpemUsIFFDT1cyX0RJU0NBUkRfQUxXQVlTKTsNCj4gICAg
ICAgICAgIGJpdG1hcF90YWJsZVtpXSA9IDA7DQo+ICAgICAgIH0NCj4gICB9DQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

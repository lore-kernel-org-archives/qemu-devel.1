Received: from eggs.gnu.org ([209.51.188.92]:54553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hAwDf-000617-Qa
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hAwDe-0007xx-QQ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:39:19 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 1 Apr 2019 12:39:12 +0000
Message-ID: <e09c424e-769e-bd01-de3a-4924da88f246@virtuozzo.com>
References: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554120365-39119-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554120365-39119-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <156CC471F96FB1418FDB362814B8F094@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "jsnow@redhat.com" <jsnow@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDEuMDQuMjAxOSAxNTowNiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBib3R0b20g
bm9kZSBpcyB0aGUgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IGhhcyB0aGUgYmFzZSBh
cyBpdHMNCj4gYmFja2luZyBpbWFnZS4gSXQgaXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSBiYXNlIG5v
ZGUgd2hpbGUgYSBibG9jayBzdHJlYW0NCj4gam9iIGlzIHJ1bm5pbmcgdG8gYXZvaWQgZGVwZW5k
ZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVlIHRvIHRoZQ0KPiBwYXJhbGxlbCBq
b2JzLiBUaGUgY2hhbmdlIG1heSB0YWtlIHBsYWNlIGR1ZSB0byBhIGZpbHRlciBub2RlIGFzIHdl
bGwgdGhhdA0KPiBpcyBpbnNlcnRlZCBiZXR3ZWVuIHRoZSBiYXNlIGFuZCB0aGUgaW50ZXJtZWRp
YXRlIGJvdHRvbSBub2RlLiBJdCBvY2N1cnMNCj4gd2hlbiB0aGUgYmFzZSBub2RlIGlzIHRoZSB0
b3Agb25lIGZvciBhbm90aGVyIGNvbW1pdCBvciBzdHJlYW0gam9iLg0KPiBBZnRlciB0aGUgaW50
cm9kdWN0aW9uIG9mIHRoZSBib3R0b20gbm9kZSwgZG9uJ3QgZnJlZXplIGl0cyBiYWNraW5nIGNo
aWxkLA0KPiB0aGF0J3MgdGhlIGJhc2UsIGFueW1vcmUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1
b3p6by5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3N0cmVhbS5jICAgICAgICAgICAgfCA1NCArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGJsb2NrL3Ry
YWNlLWV2ZW50cyAgICAgICAgfCAgMiArLQ0KPiAgIGJsb2NrZGV2LmMgICAgICAgICAgICAgICAg
fCAgNyArKysrKy0NCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oIHwgIDYgKysrLS0tDQo+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0NSAgICB8ICA0ICsrLS0NCj4gICA1IGZpbGVzIGNoYW5n
ZWQsIDM5IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiANCg0KWy4uXQ0KDQo+IGRp
ZmYgLS1naXQgYS9ibG9ja2Rldi5jIGIvYmxvY2tkZXYuYw0KPiBpbmRleCA0Nzc1YTA3Li5jZTBj
YWQ0IDEwMDY0NA0KPiAtLS0gYS9ibG9ja2Rldi5jDQo+ICsrKyBiL2Jsb2NrZGV2LmMNCj4gQEAg
LTMxNjQsNiArMzE2NCw3IEBAIHZvaWQgcW1wX2Jsb2NrX3N0cmVhbShib29sIGhhc19qb2JfaWQs
IGNvbnN0IGNoYXIgKmpvYl9pZCwgY29uc3QgY2hhciAqZGV2aWNlLA0KPiAgIHsNCj4gICAgICAg
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsICppdGVyOw0KPiAgICAgICBCbG9ja0RyaXZlclN0YXRlICpi
YXNlX2JzID0gTlVMTDsNCj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpib3R0b21fbm9kZSA9IE5V
TEw7DQo+ICAgICAgIEFpb0NvbnRleHQgKmFpb19jb250ZXh0Ow0KPiAgICAgICBFcnJvciAqbG9j
YWxfZXJyID0gTlVMTDsNCj4gICAgICAgY29uc3QgY2hhciAqYmFzZV9uYW1lID0gTlVMTDsNCj4g
QEAgLTMyMzcsNyArMzIzOCwxMSBAQCB2b2lkIHFtcF9ibG9ja19zdHJlYW0oYm9vbCBoYXNfam9i
X2lkLCBjb25zdCBjaGFyICpqb2JfaWQsIGNvbnN0IGNoYXIgKmRldmljZSwNCj4gICAgICAgICAg
IGpvYl9mbGFncyB8PSBKT0JfTUFOVUFMX0RJU01JU1M7DQo+ICAgICAgIH0NCj4gICANCj4gLSAg
ICBzdHJlYW1fc3RhcnQoaGFzX2pvYl9pZCA/IGpvYl9pZCA6IE5VTEwsIGJzLCBiYXNlX2JzLCBi
YXNlX25hbWUsDQo+ICsgICAgLyogRmluZCB0aGUgYm90dG9tIG5vZGUgdGhhdCBoYXMgdGhlIGJh
c2UgYXMgaXRzIGJhY2tpbmcgaW1hZ2UgKi8NCj4gKyAgICBib3R0b21fbm9kZSA9IGJkcnZfZmlu
ZF9vdmVybGF5KGJzLCBiYXNlX2JzKTsNCj4gKyAgICBhc3NlcnQoYm90dG9tX25vZGUpOw0KDQph
c3NlcnQgc2VlbXMgdW5uZWNlc3Nhcnkgbm93IGFuZCBldmVuIGJvdHRvbV9ub2RlIHZhcmlhYmxl
LiBJIHRoaW5rIHlvdSBjYW4ganVzdCBjYWxsDQpiZHJ2X2ZpbmRfb3Zlcmx5IGluc2lkZSBzdHJl
YW1fc3RhcnQoKSBwYXJhbWV0ZXIgbGlzdC4NCg0Kd2l0aCBvciB3aXRob3V0IHRoaXMgY2hhbmdl
Og0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

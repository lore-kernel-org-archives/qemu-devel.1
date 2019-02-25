Received: from eggs.gnu.org ([209.51.188.92]:49833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyAON-0008RE-W9
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:09:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyAOM-000714-Bt
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:09:35 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 07:09:21 +0000
Message-ID: <5d773448-60cf-9c7b-9e8b-05cd6fd1998f@virtuozzo.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-4-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-4-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D186A73D69D82A41ABD58FC51381ECA9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 03/10] block/dirty-bitmap: remove
 set/reset assertions against enabled bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

YWJvdXQgc3ViamVjdDogc2hvdWxkbid0IGl0IGJlICJhZ2FpbnN0IGRpc2FibGVkIGJpdCIgaW5z
dGVhZD8NCg0KMjMuMDIuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IGJkcnZfc2V0X2Rp
cnR5X2JpdG1hcCBhbmQgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAgYXJlIG9ubHkgdXNlZCBhcyBh
bg0KPiBpbnRlcm5hbCBBUEkgYnkgdGhlIG1pcnJvciBhbmQgbWlncmF0aW9uIGFyZWFzIG9mIG91
ciBjb2RlLiBUaGVzZQ0KPiBjYWxscyBtb2RpZnkgdGhlIGJpdG1hcCwgYnV0IGRvIHNvIGF0IHRo
ZSBiZWhlc3Qgb2YgUUVNVSBhbmQgbm90IHRoZQ0KPiBndWVzdC4NCj4gDQo+IFByZXNlbnRseSwg
dGhlc2UgYml0bWFwcyBhcmUgYWx3YXlzICJlbmFibGVkIiBhbnl3YXksIGJ1dCB0aGVyZSdzIG5v
DQo+IHJlYXNvbiB0aGV5IGhhdmUgdG8gYmUuDQo+IA0KPiBNb2RpZnkgdGhlc2UgaW50ZXJuYWwg
QVBJcyB0byBkcm9wIHRoaXMgYXNzZXJ0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9obiBT
bm93IDxqc25vd0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0tLQ0KPiAgIGJsb2Nr
L2RpcnR5LWJpdG1hcC5jIHwgMiAtLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2RpcnR5LWJpdG1hcC5jIGIvYmxvY2svZGlydHkt
Yml0bWFwLmMNCj4gaW5kZXggYWEzZjg2YmI3My4uOWVhNTczODQyMCAxMDA2NDQNCj4gLS0tIGEv
YmxvY2svZGlydHktYml0bWFwLmMNCj4gKysrIGIvYmxvY2svZGlydHktYml0bWFwLmMNCj4gQEAg
LTU0Miw3ICs1NDIsNiBAQCBpbnQ2NF90IGJkcnZfZGlydHlfaXRlcl9uZXh0KEJkcnZEaXJ0eUJp
dG1hcEl0ZXIgKml0ZXIpDQo+ICAgdm9pZCBiZHJ2X3NldF9kaXJ0eV9iaXRtYXBfbG9ja2VkKEJk
cnZEaXJ0eUJpdG1hcCAqYml0bWFwLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQ2NF90IG9mZnNldCwgaW50NjRfdCBieXRlcykNCj4gICB7DQo+IC0gICAgYXNzZXJ0
KGJkcnZfZGlydHlfYml0bWFwX2VuYWJsZWQoYml0bWFwKSk7DQo+ICAgICAgIGFzc2VydCghYmRy
dl9kaXJ0eV9iaXRtYXBfcmVhZG9ubHkoYml0bWFwKSk7DQo+ICAgICAgIGhiaXRtYXBfc2V0KGJp
dG1hcC0+Yml0bWFwLCBvZmZzZXQsIGJ5dGVzKTsNCj4gICB9DQo+IEBAIC01NTksNyArNTU4LDYg
QEAgdm9pZCBiZHJ2X3NldF9kaXJ0eV9iaXRtYXAoQmRydkRpcnR5Qml0bWFwICpiaXRtYXAsDQo+
ICAgdm9pZCBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcF9sb2NrZWQoQmRydkRpcnR5Qml0bWFwICpi
aXRtYXAsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBv
ZmZzZXQsIGludDY0X3QgYnl0ZXMpDQo+ICAgew0KPiAtICAgIGFzc2VydChiZHJ2X2RpcnR5X2Jp
dG1hcF9lbmFibGVkKGJpdG1hcCkpOw0KPiAgICAgICBhc3NlcnQoIWJkcnZfZGlydHlfYml0bWFw
X3JlYWRvbmx5KGJpdG1hcCkpOw0KPiAgICAgICBoYml0bWFwX3Jlc2V0KGJpdG1hcC0+Yml0bWFw
LCBvZmZzZXQsIGJ5dGVzKTsNCj4gICB9DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZtm0-0004W0-8V
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZtlz-0001oS-E4
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:33:40 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 20 Dec 2018 08:33:30 +0000
Message-ID: <9ac2eaa1-2556-7547-e09c-b3dafb5efb85@virtuozzo.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-3-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-3-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F334AF7CBC68F84390F17F509E93701A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 02/11] block/dirty-bitmap: remove
 assertion from restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

MjAuMTIuMjAxOCA1OjI5LCBKb2huIFNub3cgd3JvdGU6DQo+IFdoZW4gbWFraW5nIGEgYmFja3Vw
IG9mIGEgZGlydHkgYml0bWFwIChmb3IgdHJhbnNhY3Rpb25zKSwgd2Ugd2FudCB0bw0KPiByZXN0
b3JlIHRoYXQgYmFja3VwIHdoZXRoZXIgb3Igbm90IHRoZSBiaXRtYXAgaXMgZW5hYmxlZCBvciBu
b3QuDQo+IA0KPiBJdCBpcyBwZXJmZWN0bHkgdmFsaWQgdG8gd3JpdGUgaW50byBiaXRtYXBzIHRo
YXQgYXJlIGRpc2FibGVkLiBJdCBpcw0KPiBvbmx5IGlsbGVnaXRpbWF0ZSBmb3IgdGhlIGd1ZXN0
IHRvIGhhdmUgZG9uZSBzby4NCj4gDQo+IFJlbW92ZSB0aGlzIGFzc2VydGlvbi4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cg0KPiAtLS0NCj4gICBibG9jay9kaXJ0eS1iaXRtYXAuYyB8IDEgLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svZGlydHktYml0bWFw
LmMgYi9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPiBpbmRleCA4OWZkMWQ3ZjhiLi42YjY4ODM5NGU0
IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPiArKysgYi9ibG9jay9kaXJ0
eS1iaXRtYXAuYw0KPiBAQCAtNjI1LDcgKzYyNSw2IEBAIHZvaWQgYmRydl9jbGVhcl9kaXJ0eV9i
aXRtYXAoQmRydkRpcnR5Qml0bWFwICpiaXRtYXAsIEhCaXRtYXAgKipvdXQpDQo+ICAgdm9pZCBi
ZHJ2X3Jlc3RvcmVfZGlydHlfYml0bWFwKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwLCBIQml0bWFw
ICpiYWNrdXApDQo+ICAgew0KPiAgICAgICBIQml0bWFwICp0bXAgPSBiaXRtYXAtPmJpdG1hcDsN
Cj4gLSAgICBhc3NlcnQoYmRydl9kaXJ0eV9iaXRtYXBfZW5hYmxlZChiaXRtYXApKTsNCj4gICAg
ICAgYXNzZXJ0KCFiZHJ2X2RpcnR5X2JpdG1hcF9yZWFkb25seShiaXRtYXApKTsNCj4gICAgICAg
Yml0bWFwLT5iaXRtYXAgPSBiYWNrdXA7DQo+ICAgICAgIGhiaXRtYXBfZnJlZSh0bXApOw0KPiAN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

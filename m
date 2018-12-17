Received: from eggs.gnu.org ([2001:4830:134:3::10]:47682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gYu1D-0004tS-Ux
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gYu17-0004ZG-EK
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 09:37:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 17 Dec 2018 14:37:03 +0000
Message-ID: <eb4097f4-0182-e2f9-a75c-67d7b42b96be@virtuozzo.com>
References: <20181214231512.5295-1-jsnow@redhat.com>
	<20181214231512.5295-6-jsnow@redhat.com>
In-Reply-To: <20181214231512.5295-6-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5ACD8188D0FC654CB0650B75A8249D07@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 5/7] iotests: add
 filter_generated_node_ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

MTUuMTIuMjAxOCAyOjE1LCBKb2huIFNub3cgd3JvdGU6DQo+IFRvIG1pbWljIHRoZSBjb21tb24g
ZmlsdGVyIG9mIHRoZSBzYW1lIG5hbWUsIGJ1dCBmb3IgdGhlIHB5dGhvbiB0ZXN0cy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbS4NCg0Kb29wcywgJy4n
IC0+ICc+Jw0KDQphbmQgYWxzbywgc3RyYW5nZSBDQyBsaW5lIGluIGhlYWRlciwgaW5jbHVkaW5n
ICJKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+LCBKb2huIg0KDQo+IFJldmlld2VkLWJ5OiBF
cmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzL2lvdGVzdHMucHkgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMv
aW90ZXN0cy5weSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IGluZGV4IGEzNGU2
NjgxM2EuLjk1OTU0MjlmZWEgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rl
c3RzLnB5DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9pb3Rlc3RzLnB5DQo+IEBAIC0yMzks
NiArMjM5LDkgQEAgZGVmIGZpbHRlcl90ZXN0ZmlsZXMobXNnKToNCj4gICAgICAgcHJlZml4ID0g
b3MucGF0aC5qb2luKHRlc3RfZGlyLCAiJXMtIiAlIChvcy5nZXRwaWQoKSkpDQo+ICAgICAgIHJl
dHVybiBtc2cucmVwbGFjZShwcmVmaXgsICdURVNUX0RJUi9QSUQtJykNCj4gICANCj4gK2RlZiBm
aWx0ZXJfZ2VuZXJhdGVkX25vZGVfaWRzKG1zZyk6DQo+ICsgICAgcmV0dXJuIHJlLnN1YigiI2Js
b2NrWzAtOV0rIiwgIk5PREVfTkFNRSIsIG1zZykNCj4gKw0KPiAgIGRlZiBmaWx0ZXJfaW1nX2lu
Zm8ob3V0cHV0LCBmaWxlbmFtZSk6DQo+ICAgICAgIGxpbmVzID0gW10NCj4gICAgICAgZm9yIGxp
bmUgaW4gb3V0cHV0LnNwbGl0KCdcbicpOg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

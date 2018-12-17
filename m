Received: from eggs.gnu.org ([2001:4830:134:3::10]:34394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gYtLI-00017X-U2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gYtLI-0004pl-3O
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:53:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 17 Dec 2018 13:53:30 +0000
Message-ID: <3f1a2cb4-b4c1-175a-4879-2e032b1372c9@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
In-Reply-To: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4503547DF4DC464FB6E7B86D2D0FB9ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/8] qcow2: encryption threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>

MTEuMTIuMjAxOCAxOTo0MywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gVGhlIHNlcmllcyBicmluZ3MgdGhyZWFkcyB0byBxY293MiBlbmNyeXB0
aW9uL2RlY3J5cHRpb24gcGF0aCwNCj4gbGlrZSBpdCBpcyBhbHJlYWR5IGRvbmUgZm9yIGNvbXBy
ZXNzaW9uLg0KPiANCj4gdjI6IC0gbXVsdGlwbGUgY2lwaGVyIGluc2lkZSBRQ3J5cHRvQmxvY2sg
aW5zdGVhZCBvZiBtdWx0aXBsZQ0KPiAgICAgICAgYmxvY2tzIGluc2lkZSBxY293MiwgYXMgc3Vn
Z2VzdGVkIGJ5IERhbmllbCwgYW5kIGl0IGlzDQo+ICAgICAgICBkb25lIGluIHNlcGFyYXRlIHNl
cmllcw0KPiAgICAgIC0gdXNlIHRocmVhZGVkIGVuY3J5cHRpb24gaW4gZG9fcGVyZm9ybV9jb3df
ZW5jcnlwdCgpIHRvbw0KPiAgICAgIC0gc29tZSByZW5hbWluZyBhbmQgcmVmYWN0b3JpbmcgYW5k
IHNpbXBsaWZpY2F0aW9ucw0KPiAoU29ycnkgZm9yIG5vdCBiZWluZyB2ZXJ5IGNhcmVmdWwgYWJv
dXQgY2hhbmdlIGxpc3QsIGJ1dCB2MSBpc24ndA0KPiAgIGFjdHVhbGx5IHJldmlld2VkLCBhcyBh
cHByb2FjaCB3aXRoIG11bHRpcGxlIGJsb2NrcyB3YXMgZWFybHkNCj4gICByZWplY3RlZCBieSBE
ZW5pYWwpDQo+IA0KPiBUaGUgc2VyaWVzIG5vdyBiYXNlZCBvbiB0d28gcXVldWVkIGZvciA0LjAg
c2VyaWVzLCB3aGljaCwgaW4NCj4gdHVybiwgbWF5IGJlIGFwcGxpZWQgaW4gYW55IG9yZGVyOiAi
Y3J5cHRvIHRocmVhZHMiIChEYW5pZWwncw0KPiB0cmVlKSwgYW5kICAicWNvdzIgZGVjb21wcmVz
cyBpbiB0aHJlYWRzIiwgd2hpY2ggaXMgbm93IGluDQo+IEtldmluJ3MgYmxvY2stbmV4dC4NCj4g
DQo+IEJhc2VkLW9uOiA8MjAxODEyMDcxNjEzNTEuNDM4MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCj4gKFtQQVRDSCB2MyAwLzVdIGNyeXB0byB0aHJlYWRzKQ0KPiBCYXNlZC1vbjogZ2l0
Oi8vcmVwby5vci5jei9xZW11L2tldmluLmdpdCBibG9jay1uZXh0DQo+IChkZWNvbXByZXNzIGlu
IHRocmVhZHMgaW5zaWRlKQ0KDQpCb3RoIG1lcmdlZCwgc28sIG5vdyBiYXNlZCBvbiBtYXN0ZXIu
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

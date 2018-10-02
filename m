Received: from eggs.gnu.org ([2001:4830:134:3::10]:54186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7M8Q-0006B7-I5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7M8M-0002EO-N5
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:58:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 2 Oct 2018 14:58:42 +0000
Message-ID: <3c64931c-014a-3911-2ff8-4ac3cfef84b3@virtuozzo.com>
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-2-vsementsov@virtuozzo.com>
	<5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
	<ef7c913f-21a6-a85a-55e2-22761dd03084@virtuozzo.com>
	<e1e14dad-78bc-f504-9f7f-738ca53af3f6@redhat.com>
In-Reply-To: <e1e14dad-78bc-f504-9f7f-738ca53af3f6@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F288E70B9AECF41892AC6CF88149E41@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support device id for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MDIuMTAuMjAxOCAxNzozNSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMi8xOCA5OjMwIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPg0KPj4+PiAtIyBAZGV2aWNl
OiBkZXZpY2UgbmFtZSB0byBzZXQgbGF0ZW5jeSBoaXN0b2dyYW0gZm9yLg0KPj4+PiArIyBAZGV2
aWNlOiBkZXZpY2UgbmFtZSB0byBzZXQgbGF0ZW5jeSBoaXN0b2dyYW0gZm9yIChiZXR0ZXIgdXNl
IEBpZCkuDQo+Pj4+ICsjDQo+Pj4+ICsjIEBpZDogVGhlIG5hbWUgb3IgUU9NIHBhdGggb2YgdGhl
IGd1ZXN0IGRldmljZS4NCj4+Pg0KPj4+IEFzIGxvbmcgYXMgd2UgYXJlIHJlbmFtaW5nIHRoZSBj
b21tYW5kLCB0aGVyZSdzIG5vIG5lZWQgdG8ga2VlcCBhIA0KPj4+IGxlZ2FjeSBwYXJhbWV0ZXIg
YXJvdW5kLiBKdXN0IGdldCByaWQgb2YgZGV2aWNlIGFuZCByZXBsYWNlIGl0IGJ5IA0KPj4+IGlk
LCByYXRoZXIgdGhhbiB3b3JyeWluZyBhYm91dCBib3RoLsKgIFRoZSBpbnRyb2R1Y3Rpb24gb2Yg
dGhlIHN0YWJsZSANCj4+PiBjb21tYW5kIGRvZXMgbm90IGhhdmUgdG8gY2FycnkgYW55IGJhZ2dh
Z2UgbGVmdCBvdmVyIGZyb20gdGhlIHgtIA0KPj4+IHByZWxpbWluYXJ5IHZlcnNpb24uDQo+Pj4N
Cj4+DQo+PiBMaWJ2aXJ0IGRvbid0IG5lZWQgYm90aCBmb3Igbm93LCBmb3IgZGlmZmVyZW50IHNj
ZW5hcmlvcz8NCj4NCj4gSWYgeW91IHdhbnQgYm90aCB0byB3b3JrIGJlY2F1c2UgbGlidmlydCBo
YXMgcmVhc29ucyB0byB1c2UgYm90aCwgdGhlbiANCj4gdGhlIGRvY3VtZW50YXRpb24gbmVlZHMg
dG8gYmUgbW9yZSBwcmVjaXNlLiAiKGJldHRlciB1c2UgQGlkKSIgZG9lcyANCj4gbm90IHRlbGwg
bWUgd2h5IEkgc2hvdWxkbid0IHVzZSBAZGV2aWNlLCBvciB3aGF0IGRpZmZlcmVuY2UgaW4gDQo+
IGJlaGF2aW9yIEkgZ2V0IGJ5IHVzaW5nIG9uZSBpbnN0ZWFkIG9mIHRoZSBvdGhlci4gRnVydGhl
cm1vcmUsIGlmIEBpZCANCj4gaXMgYWJsZSB0byB1c2UgdGhlIG5hbWUgb2YgdGhlIGd1ZXN0IGRl
dmljZSBhcyBhbiBhbHRlcm5hdGl2ZSB0byB0aGUgDQo+IFFPTSBwYXRoLCB0aGVuIGhvdyBpcyB0
aGF0IGRpZmZlcmVudCBmcm9tIEBkZXZpY2UgYmVpbmcgdGhlIG5hbWUgb2YgDQo+IHRoZSBndWVz
dCBkZXZpY2U/DQo+DQoNCkhtLiBJdCBhbGwgbG9va3MgYSBiaXQgd2VpcmQuIEkndmUganVzdCBk
dXBsaWNhdGVkIGJsb2NrX3NldF9pb190aHJvdHRsZSANCmludGVyZmFjZToNCg0KIyBAZGV2aWNl
OiBCbG9jayBkZXZpY2UgbmFtZSAoZGVwcmVjYXRlZCwgdXNlIEBpZCBpbnN0ZWFkKQ0KIw0KIyBA
aWQ6IFRoZSBuYW1lIG9yIFFPTSBwYXRoIG9mIHRoZSBndWVzdCBkZXZpY2UgKHNpbmNlOiAyLjgp
DQoNCiDCoMKgwqAgYmxrID0gcW1wX2dldF9ibGsoYXJnLT5oYXNfZGV2aWNlID8gYXJnLT5kZXZp
Y2UgOiBOVUxMLA0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
cmctPmhhc19pZCA/IGFyZy0+aWQgOiBOVUxMLA0KZXJycCk7DQogwqDCoMKgIGlmICghYmxrKSB7
DQpyZXR1cm47DQogwqDCoMKgIH0NCg0KDQpTbywgbG9va3MgbGlrZSAiVGhlIG5hbWUgb3IiIGlz
IHdyb25nIHBhcnQuIEBpZCBjYW4gYmUgb25seSBwYXRoLg0KDQpIb3dldmVyLCBJIGNhbiBjYWxs
IGJsa19ieV9uYW1lIG9uIEBpZCwgaWYgYmxrX2J5X3FkZXZfaWQgZmFpbGVkLi4NCg0KU28sIHZh
cmlhbnRzOg0KDQoxLiBib3RoIHBhcmFtZXRlcnMsIGN1cnJlbnQgY29kZSwgYnV0IGZpeCBkb2N1
bWVudGF0aW9uICh3aWxsIGJlIEBpZDogDQpRT00gcGF0aCBvZiB0aGUgZ3Vlc3QgZGV2aWNlLikN
CjIuIG9ubHkgQGlkIGFuZCBvbmx5IFFPTSBwYXRoDQozLiBvbmx5IEBpZCwgYnV0IGZ1bGxiYWNr
IHRvIGJsa19ieV9uYW1lKEBpZCkgaWYgZmFpbGVkIHRvIGZpbmQgcWRldi4NCg0KQW55IG9wdGlv
biBpcyBvayBmb3IgbWUsIEkgZG9uJ3QgY2FyZS4gV2hhdCBkbyB5b3UgdGhpbms/DQoNCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0KDQo=

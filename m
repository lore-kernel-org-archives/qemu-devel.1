Received: from eggs.gnu.org ([209.51.188.92]:55758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyAry-0003cA-UP
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:40:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyArw-0001y7-WC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:40:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 07:39:55 +0000
Message-ID: <ba720682-22ec-4670-d9f8-aaaf58ee3047@virtuozzo.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-5-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-5-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F1C1EDF47A88479EAFD3C3496AA281@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 04/10] block/dirty-bitmap: change
 semantics of enabled predicate
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

MjMuMDIuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IEN1cnJlbnRseSwgdGhlIGVuYWJs
ZWQgcHJlZGljYXRlIG1lYW5zIHNvbWV0aGluZyBsaWtlOg0KPiAidGhlIFFBUEkgc3RhdHVzIG9m
IHRoZSBiaXRtYXAgaXMgQUNUSVZFLiINCj4gQWZ0ZXIgdGhpcyBwYXRjaCwgaXQgc2hvdWxkIG1l
YW4gZXhjbHVzaXZlbHk6DQo+ICJUaGlzIGJpdG1hcCBpcyByZWNvcmRpbmcgZ3Vlc3Qgd3JpdGVz
LCBhbmQgaXMgYWxsb3dlZCB0byBkbyBzby4iDQo+IA0KPiBJbiBtYW55IHBsYWNlcywgdGhpcyBp
cyBob3cgdGhpcyBwcmVkaWNhdGUgd2FzIGFscmVhZHkgdXNlZC4NCj4gSW50ZXJuYWwgdXNhZ2Vz
IG9mIHRoZSBiaXRtYXAgUVBJIGNhbiBjYWxsIHVzZXJfbG9ja2VkIHRvIGZpbmQgb3V0IGlmDQo+
IHRoZSBiaXRtYXAgaXMgaW4gdXNlIGJ5IGFuIG9wZXJhdGlvbi4NCj4gDQo+IFRvIGFjY29tbW9k
YXRlIHRoaXMsIG1vZGlmeSB0aGUgY3JlYXRlX3N1Y2Nlc3NvciByb3V0aW5lIHRvIG5vdw0KPiBl
eHBsaWNpdGx5IGRpc2FibGUgdGhlIHBhcmVudCBiaXRtYXAgYXQgY3JlYXRpb24gdGltZS4NCj4g
DQo+IA0KPiBKdXN0aWZpY2F0aW9uczoNCj4gDQo+IDEuIGJkcnZfZGlydHlfYml0bWFwX3N0YXR1
cyBzdWZmZXJzIG5vIGNoYW5nZSBmcm9tIHRoZSBsYWNrIG9mDQo+ICAgICAxOjEgcGFyaXR5IHdp
dGggdGhlIG5ldyBwcmVkaWNhdGVzIGJlY2F1c2Ugb2YgdGhlIG9yZGVyIGluIHdoaWNoDQo+ICAg
ICB0aGUgcHJlZGljYXRlcyBhcmUgY2hlY2tlZC4gVGhpcyBpcyBub3cgb25seSBmb3IgY29tcGF0
aWJpbGl0eS4NCj4gDQo+IDIuIGJkcnZfc2V0X2RpcnR5KCkgaXMgdW5jaGFuZ2VkOiBwcmUtcGF0
Y2gsIGl0IHdhcyBza2lwcGluZyBiaXRtYXBzIHRoYXQgd2VyZQ0KPiAgICAgZGlzYWJsZWQgb3Ig
aGFkIGEgc3VjY2Vzc29yLCB3aGlsZSBwb3N0LXBhdGNoIGl0IGlzIG9ubHkgc2tpcHBpbmcgYml0
bWFwcw0KPiAgICAgdGhhdCBhcmUgZGlzYWJsZWQuIFRvIGFjY29tbW9kYXRlIHRoaXMsIGNyZWF0
ZV9zdWNjZXNzb3Igbm93IGVuc3VyZXMgdGhhdA0KPiAgICAgYW55IGJpdG1hcCB3aXRoIGEgc3Vj
Y2Vzc29yIGlzIGV4cGxpY2l0bHkgZGlzYWJsZWQuDQo+IA0KPiAzLiBxY293Ml9zdG9yZV9wZXJz
aXN0ZW50X2RpcnR5X2JpdG1hcHM6IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBUaGlzIGZ1bmN0aW9u
DQo+ICAgICBjYXJlcyBvbmx5IGFib3V0IHRoZSBsaXRlcmFsIGVuYWJsZWQgYml0LCBhbmQgbWFr
ZXMgbm8gZWZmb3J0IHRvIGNoZWNrIGlmDQo+ICAgICB0aGUgYml0bWFwIGlzIGluLXVzZSBvciBu
b3QuIEFmdGVyIHRoaXMgcGF0Y2ggdGhlcmUgYXJlIHN0aWxsIG5vIHdheXMgdG8NCj4gICAgIHBy
b2R1Y2UgYW4gZW5hYmxlZCBiaXRtYXAgd2l0aCBhIHN1Y2Nlc3Nvci4NCj4gDQo+IDQuIGJsb2Nr
X2RpcnR5X2JpdG1hcF9lbmFibGVfcHJlcGFyZQ0KPiAgICAgYmxvY2tfZGlydHlfYml0bWFwX2Rp
c2FibGVfcHJlcGFyZQ0KPiAgICAgaW5pdF9kaXJ0eV9iaXRtYXBfbWlncmF0aW9uDQo+ICAgICBu
YmRfZXhwb3J0X25ldw0KPiANCj4gICAgIFRoZXNlIGZ1bmN0aW9ucyBjYXJlIGFib3V0IHRoZSBs
aXRlcmFsIGVuYWJsZWQgYml0LA0KPiAgICAgYW5kIGFscmVhZHkgY2hlY2sgdXNlcl9sb2NrZWQg
c2VwYXJhdGVseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdzxqc25vd0ByZWRoYXQu
Y29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

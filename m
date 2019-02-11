Received: from eggs.gnu.org ([209.51.188.92]:38574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtFYf-0001En-4p
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtFYe-0006I6-7F
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:39:53 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 17:39:38 +0000
Message-ID: <0b69aa1d-1a17-0ac6-52d4-a7ee7bd8eb75@virtuozzo.com>
References: <20181221165341.23736-1-vsementsov@virtuozzo.com>
	<20181221165341.23736-2-vsementsov@virtuozzo.com>
	<875zuznv5k.fsf@dusky.pond.sub.org>
In-Reply-To: <875zuznv5k.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <70165AA01D32CF43BC71D8AF15C8D8B2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/2] qapi: move to QOM path for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>

MDguMDEuMjAxOSAxNjoyMCwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JpdGVzOg0KPiAN
Cj4+IE1vdmUgdG8gd2F5IG9mIGRldmljZSBzZWxlY3RpbmcsIGhvd2V2ZXIgZmFsbCBiYWNrIHRv
IGRldmljZSBuYW1lIGlmDQo+PiBwYXRoIGlzIG5vdCBmb3VuZC4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQo+PiAtLS0NCj4+ICAgcWFwaS9ibG9jay1jb3JlLmpzb24gfCAgNCArKy0tDQo+PiAgIGJs
b2NrZGV2LmMgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrLS0tLS0tLQ0KPj4gICAyIGZp
bGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+
IGluZGV4IDc2MjAwMGYzMWYuLmJiNzBjNTFhNTcgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2Nr
LWNvcmUuanNvbg0KPj4gKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC00ODksNyAr
NDg5LDcgQEANCj4+ICAgIyBJZiBvbmx5IEBkZXZpY2UgcGFyYW1ldGVyIGlzIHNwZWNpZmllZCwg
cmVtb3ZlIGFsbCBwcmVzZW50IGxhdGVuY3kgaGlzdG9ncmFtcw0KPj4gICAjIGZvciB0aGUgZGV2
aWNlLiBPdGhlcndpc2UsIGFkZC9yZXNldCBzb21lIG9mIChvciBhbGwpIGxhdGVuY3kgaGlzdG9n
cmFtcy4NCj4+ICAgIw0KPj4gLSMgQGRldmljZTogZGV2aWNlIG5hbWUgdG8gc2V0IGxhdGVuY3kg
aGlzdG9ncmFtIGZvci4NCj4+ICsjIEBpZDogVGhlIFFPTSBwYXRoIG9yIG5hbWUgb2YgdGhlIGd1
ZXN0IGRldmljZS4NCj4+ICAgIw0KPj4gICAjIEBib3VuZGFyaWVzOiBsaXN0IG9mIGludGVydmFs
IGJvdW5kYXJ5IHZhbHVlcyAoc2VlIGRlc2NyaXB0aW9uIGluDQo+PiAgICMgICAgICAgICAgICAg
IEJsb2NrTGF0ZW5jeUhpc3RvZ3JhbUluZm8gZGVmaW5pdGlvbikuIElmIHNwZWNpZmllZCwgYWxs
DQo+IA0KPiBJcyBzdWNoIG92ZXJsb2FkZWQgc2VtYW50aWNzIHdoYXQgd2Ugd2FudCBpbiBuZXcg
aW50ZXJmYWNlcz8NCj4gDQo+IEhtbSwgbG9va3MgbGlrZSB0aGVyZSdzIGFtcGxlIHByZWNlZGVu
Y2UgZm9yIGl0LiAgRXNjYXBlZCBteSBncmVwIGF0DQo+IGZpcnN0IGJlY2F1c2UgaXRzIGNvbW1v
bmx5IGRvY3VtZW50ZWQgYXMgIlRoZSBuYW1lIG9yIFFPTSBwYXRoIG9mIHRoZQ0KPiBndWVzdCBk
ZXZpY2UiLiAgU3VnZ2VzdCB0byBzdGljayB0byB0aGF0IGZvciBjb25zaXN0ZW5jeS4NCg0KDQpJ
bnRlcmVzdGluZywgdGhhdCBpbiBjYXNlcyB5b3UgbWVhbiwgZG9jdW1lbnRhdGlvbiBzZWVtcyB3
cm9uZzoNCml0IGdvZXMgdGhyb3VnaCBxbXBfZ2V0X2Jsaywgd2hpY2ggd29ya3MgbGlrZSBAaWQg
bWF5IGJlIG9ubHkgUU9NIHBhdGgsIG5vdCBuYW1lLA0Kc28gZm9yIHRoZSBpdCBzaG91bGQgYmUg
QGlkOiBUaGUgUU9NIHBhdGguDQoNCkFuZCBJJ20gYWZyYWlkIHRoYXQgb25seSBteSBjYXNlIG1l
cmdlcyBib3RoIGludG8gb25lIGZpZWxkLiBBbmQgaXQgaXMgbW9yZSBjb3JyZWN0DQp0byBwdXQg
UU9NIHBhdGggaW4gZmlyc3QgcGxhY2UsIGFzIGl0IGlzIGNoZWNrZWQgZmlyc3QsIGFuZCBpZiBp
dCBmYWlscywgc2VhcmNoZXMgYnkNCm5hbWUuIFNvLCBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIGl0
IGFzIGlzLCBhbmQgZml4IG90aGVyIGNvbW1hbmQgZG9jdW1lbnRhdGlvbiAoYnV0DQpub3QgaW4g
dGhlc2Ugc2VyaWVzLCBvZiBjb3Vyc2UpDQoNCj4gDQo+PiBAQCAtNTQ3LDcgKzU0Nyw3IEBADQo+
PiAgICMgPC0geyAicmV0dXJuIjoge30gfQ0KPj4gICAjIw0KPj4gICB7ICdjb21tYW5kJzogJ3gt
YmxvY2stbGF0ZW5jeS1oaXN0b2dyYW0tc2V0JywNCj4+IC0gICdkYXRhJzogeydkZXZpY2UnOiAn
c3RyJywNCj4+ICsgICdkYXRhJzogeydpZCc6ICdzdHInLA0KPj4gICAgICAgICAgICAgICcqYm91
bmRhcmllcyc6IFsndWludDY0J10sDQo+PiAgICAgICAgICAgICAgJypib3VuZGFyaWVzLXJlYWQn
OiBbJ3VpbnQ2NCddLA0KPj4gICAgICAgICAgICAgICcqYm91bmRhcmllcy13cml0ZSc6IFsndWlu
dDY0J10sDQo+IFsuLi5dDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

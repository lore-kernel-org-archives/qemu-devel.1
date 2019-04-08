Received: from eggs.gnu.org ([209.51.188.92]:55966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYq7-00023y-M5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDYq5-0001Bn-NX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:17:51 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 8 Apr 2019 18:17:37 +0000
Message-ID: <15f8499f-812d-1bf9-ad22-21971687826a@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w511s2cy08l.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s2cy08l.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DA0E3F6940E7243B924E47B18E502FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MzksIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTkgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiBAQCAtMjMyLDggKzIzMiwxMyBAQCB2b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFyICpqb2Jf
aWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4gICAgICAgU3RyZWFtQmxvY2tKb2IgKnM7DQo+
PiAgICAgICBCbG9ja0RyaXZlclN0YXRlICppdGVyOw0KPj4gICAgICAgYm9vbCBic19yZWFkX29u
bHk7DQo+PiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJvdHRvbSA9IE5VTEw7DQo+PiArICAgIGlu
dCBiYXNpY19mbGFncyA9IEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8IEJMS19QRVJNX1dSSVRF
X1VOQ0hBTkdFRDsNCj4+ICsNCj4+ICsgICAgLyogRmluZCB0aGUgYm90dG9tIG5vZGUgdGhhdCBo
YXMgdGhlIGJhc2UgYXMgaXRzIGJhY2tpbmcgaW1hZ2UgKi8NCj4+ICsgICAgYm90dG9tID0gYmRy
dl9maW5kX292ZXJsYXkoYnMsIGJhc2UpOw0KPiANCj4gV2hhdCBoYXBwZW5zIGlmIGJzID09IGJh
c2UgaGVyZSA/Pw0KPiANCg0KQWN0dWFsbHksIHRoYXQgY29uZGl0aW9uIGlzIGNoZWNrZWQgaW4g
dGhlIHFtcF9ibG9ja19zdHJlYW0oKS4NCkkgdXNlZCB0byBoYXZlIHRoZSAnYXNzZXJ0KGJvdHRv
bSknIGFmdGVyIHRoZSBjYWxsIHRvIHRoZQ0KYmRydl9maW5kX292ZXJsYXkoYnMsIGJhc2UpIGlu
IHRoZSBxbXBfYmxvY2tfc3RyZWFtKCkgb2YgdGhlIHYyLg0KDQo+PiArICAgIC8qDQo+PiArICAg
ICAqIEJsb2NrIGFsbCBpbnRlcm1lZGlhdGUgbm9kZXMgYmV0d2VlbiBicyBhbmQgYm90dG9tIChp
bmNsdXNpdmUpLCBiZWNhdXNlDQo+PiArICAgICAqIHRoZXkgd2lsbCBkaXNhcHBlYXIgZnJvbSB0
aGUgY2hhaW4gYWZ0ZXIgdGhpcyBvcGVyYXRpb24uIFRoZSBzdHJlYW1pbmcNCj4+ICsgICAgICog
am9iIHJlYWRzIGV2ZXJ5IGJsb2NrIG9ubHkgb25jZSwgYXNzdW1pbmcgdGhhdCBpdCBkb2Vzbid0
IGNoYW5nZSwgc28NCj4+ICsgICAgICogZm9yYmlkIHdyaXRlcyBhbmQgcmVzaXplcy4NCj4+ICsg
ICAgICovDQo+PiArICAgIGZvciAoaXRlciA9IGJzOyBpdGVyICE9IGJvdHRvbTsgaXRlciA9IGJh
Y2tpbmdfYnMoaXRlcikpIHsNCj4+ICsgICAgICAgIGJsb2NrX2pvYl9hZGRfYmRydigmcy0+Y29t
bW9uLCAiaW50ZXJtZWRpYXRlIG5vZGUiLCBiYWNraW5nX2JzKGl0ZXIpLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDAsIGJhc2ljX2ZsYWdzLCAmZXJyb3JfYWJvcnQpOw0KPj4gICAg
ICAgfQ0KPiANCj4gVGhpcyBzdG9wcyB3aGVuIGl0ZXIgPT0gYm90dG9tLCBzbyBib3R0b20gaXMg
bm90IGFjdHVhbGx5IGJsb2NrZWQuDQoNClRoZSBib3R0b20gaXMgYWN0dWFsbHkgYmxvY2tlZCBi
ZWNhdXNlDQpiYWNraW5nX2JzKGl0ZXIpID09IGJvdHRvbSBpcyBwYXNzZWQgdG8gdGhlIGJsb2Nr
X2pvYl9hZGRfYmRydigpDQp3aXRoIHRoZSBsYXN0IGl0ZXJhdGlvbiBvZiB0aGUgbG9vcC4NCg0K
PiANCj4+IGRpZmYgLS1naXQgYS9ibG9jay90cmFjZS1ldmVudHMgYi9ibG9jay90cmFjZS1ldmVu
dHMNCj4+IGluZGV4IDczMzVhNDIuLjUzNjZkNDUgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay90cmFj
ZS1ldmVudHMNCj4+ICsrKyBiL2Jsb2NrL3RyYWNlLWV2ZW50cw0KPj4gQEAgLTIwLDcgKzIwLDcg
QEAgYmRydl9jb19jb3B5X3JhbmdlX3RvKHZvaWQgKnNyYywgdWludDY0X3Qgc3JjX29mZnNldCwg
dm9pZCAqZHN0LCB1aW50NjRfdCBkc3Rfb2YNCj4+ICAgDQo+PiAgICMgc3RyZWFtLmMNCj4+ICAg
c3RyZWFtX29uZV9pdGVyYXRpb24odm9pZCAqcywgaW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5
dGVzLCBpbnQgaXNfYWxsb2NhdGVkKSAicyAlcCBvZmZzZXQgJSIgUFJJZDY0ICIgYnl0ZXMgJSIg
UFJJdTY0ICIgaXNfYWxsb2NhdGVkICVkIg0KPj4gLXN0cmVhbV9zdGFydCh2b2lkICpicywgdm9p
ZCAqYmFzZSwgdm9pZCAqcykgImJzICVwIGJhc2UgJXAgcyAlcCINCj4+ICtzdHJlYW1fc3RhcnQo
dm9pZCAqYnMsIHZvaWQgKmJvdHRvbSwgdm9pZCAqcykgImJzICVwIGJvdHRvbSAlcCBzICVwIg0K
PiANCj4gSXMgdGhpcyBjaGFuZ2Ugc3RpbGwgY29ycmVjdD8gV2UgZG9uJ3QgcGFzcyBib3R0b20g
YW55bW9yZS4NCj4gDQo+IEJlcnRvDQo+IA0KDQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywN
CkFuZHJleSBTaGlua2V2aWNoDQo=

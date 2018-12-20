Received: from eggs.gnu.org ([2001:4830:134:3::10]:40276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZuwS-0000Dl-QP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gZuwS-0003hT-3c
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:48:32 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 20 Dec 2018 09:48:20 +0000
Message-ID: <6f41617a-ccf9-d769-874c-8d567cafdb7b@virtuozzo.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-9-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-9-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4EA7C41209DF448A02EB11D99DE8222@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 08/11] iotests: remove default filters
 from qmp_log
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

MjAuMTIuMjAxOCA1OjI5LCBKb2huIFNub3cgd3JvdGU6DQo+IFNldmVyYWwgcGxhY2VzIGluIGlv
dGVzdHMgZGVhbCB3aXRoIHNlcmlhbGl6aW5nIG9iamVjdHMgaW50byBKU09ODQo+IHN0cmluZ3Ms
IGJ1dCB0byBhZGQgcHJldHR5LXByaW50aW5nIGl0IHNlZW1zIGRlc2lyZWFibGUgdG8gbG9jYWxp
emUNCj4gYWxsIG9mIHRob3NlIGNhc2VzLg0KPiANCj4gbG9nKCkgc2VlbXMgbGlrZSBhIGdvb2Qg
Y2FuZGlkYXRlIGZvciB0aGF0IGNlbnRyYWxpemVkIGJlaGF2aW9yLg0KPiBsb2coKSBjYW4gYWxy
ZWFkeSBzZXJpYWxpemUganNvbiBvYmplY3RzLCBidXQgd2hlbiBpdCBkb2VzIHNvLA0KPiBpdCBh
c3N1bWVzIGZpbHRlcnM9W10gb3BlcmF0ZXMgb24gUU1QIG9iamVjdHMsIG5vdCBzdHJpbmdzLg0K
PiANCj4gcW1wX2xvZyBjdXJyZW50bHkgb3BlcmF0ZXMgYnkgZHVtcGluZyBvdXRnb2luZyBhbmQg
aW5jb21pbmcgUU1QDQo+IG9iamVjdHMgaW50byBzdHJpbmdzIGFuZCBmaWx0ZXJpbmcgdGhlbSBh
c3N1bWluZyB0aGF0IGZpbHRlcnM9W10NCj4gYXJlIHN0cmluZyBmaWx0ZXJzLg0KPiANCj4gVG8g
aGF2ZSBxbXBfbG9nIHVzZSBsb2cncyBzZXJpYWxpemF0aW9uLCBxbXBfbG9nIHdpbGwgbmVlZCB0
bw0KPiBhY2NlcHQgb25seSBxbXAgZmlsdGVycywgbm90IHRleHQgZmlsdGVycy4NCj4gDQo+IEhv
d2V2ZXIsIG9ubHkgYSBzaW5nbGUgY2FsbGVyIG9mIHFtcF9sb2cgYWN0dWFsbHkgcmVxdWlyZXMg
YW55DQo+IGZpbHRlcnMgYXQgYWxsLiBJIHJlbW92ZSB0aGUgZGVmYXVsdCBmaWx0ZXIgYW5kIGFk
ZCBpdCBleHBsaWNpdGx5DQo+IHRvIHRoZSBjYWxsZXIgaW4gcHJlcGFyYXRpb24gZm9yIHJlZmFj
dG9yaW5nIHFtcF9sb2cgdG8gdXNlIHJpY2gNCj4gZmlsdGVycyBpbnN0ZWFkLg0KPiANCj4gdGVz
dCAyMDYgaXMgYW1lbmRlZCB0byBuYW1lIHRoZSBmaWx0ZXIgZXhwbGljaXRseSBhbmQgdGhlIGRl
ZmF1bHQNCj4gaXMgcmVtb3ZlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdzxqc25v
d0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tp
eSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=

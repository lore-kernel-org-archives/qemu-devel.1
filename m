Received: from eggs.gnu.org ([209.51.188.92]:39981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkQlT-0007UU-JO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gkQlO-0004wD-IO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:48:37 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 18 Jan 2019 09:48:06 +0000
Message-ID: <af3e202b-25d1-0f37-727f-f5aa4f619415@virtuozzo.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-6-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-6-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6B62A19FFBED944B50745AF15A84B99@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 05/21] nbd/server: Hoist length check to
 qmp_nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MTcuMDEuMjAxOSAyMjozNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gV2Ugb25seSBoYWQgdHdvIGNh
bGxlcnMgdG8gbmJkX2V4cG9ydF9uZXc7IHFlbXUtbmJkLmMgYWx3YXlzDQo+IHBhc3NlZCBhIHZh
bGlkIG9mZnNldC9sZW5ndGggcGFpciAoYmVjYXVzZSBpdCBhbHJlYWR5IGNoZWNrZWQNCj4gdGhl
IGZpbGUgbGVuZ3RoLCB0byBlbnN1cmUgdGhhdCBvZmZzZXQgd2FzIGluIGJvdW5kcyksIHdoaWxl
DQo+IGJsb2NrZGV2LW5iZC5jIGFsd2F5cyBwYXNzZWQgMC8tMS4gIFRoZW4gbmJkX2V4cG9ydF9u
ZXcgcmVkdWNlcw0KPiB0aGUgc2l6ZSB0byBhIG11bHRpcGxlIG9mIEJEUlZfU0VDVE9SX1NJWkUg
KGNhbiBvbmx5IGhhcHBlbg0KPiB3aGVuIG9mZnNldCBpcyBub3Qgc2VjdG9yLWFsaWduZWQsIHNp
bmNlIGJkcnZfZ2V0bGVuZ3RoKCkNCj4gY3VycmVudGx5IHJvdW5kcyB1cCksIHdoaWNoIGNhbiBy
ZXN1bHQgaW4gb2Zmc2V0IGJlaW5nIGdyZWF0ZXINCj4gdGhhbiB0aGUgZW5mb3JjZWQgbGVuZ3Ro
LCBidXQgdGhhdCdzIG5vdCBmYXRhbCAodGhlIHNlcnZlcg0KPiByZWplY3RzIGNsaWVudCByZXF1
ZXN0cyB0aGF0IGV4Y2VlZCB0aGUgYWR2ZXJ0aXNlZCBsZW5ndGgpLg0KPiANCj4gSG93ZXZlciwg
SSdtIGZpbmRpbmcgaXQgZWFzaWVyIHRvIHdvcmsgd2l0aCB0aGUgY29kZSBpZiB3ZSBhcmUNCj4g
Y29uc2lzdGVudCBvbiBoYXZpbmcgYm90aCBjYWxsZXJzIHBhc3MgaW4gYSB2YWxpZCBsZW5ndGgs
IGFuZA0KPiBqdXN0IGFzc2VydCB0aGF0IHRoaW5ncyBhcmUgc2FuZSBpbiBuYmRfZXhwb3J0X25l
dywgbWVhbmluZw0KPiB0aGF0IG5vIG5lZ2F0aXZlIHZhbHVlcyB3ZXJlIHBhc3NlZCwgYW5kIHRo
YXQgb2Zmc2V0K3NpemUgZG9lcw0KPiBub3QgZXhjZWVkIDYzIGJpdHMgKGFzIHRoYXQgcmVhbGx5
IGlzIGEgZnVuZGFtZW50YWwgbGltaXQgdG8NCj4gbGF0ZXIgb3BlcmF0aW9ucywgd2hldGhlciB3
ZSB1c2Ugb2ZmX3Qgb3IgdWludDY0X3QpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFr
ZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==

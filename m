Received: from eggs.gnu.org ([209.51.188.92]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ghIPr-0007MU-Pr
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ghIIh-0004CE-Ga
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:10:00 -0500
From: Denis V.Lunev <den@openvz.org>
Date: Wed, 9 Jan 2019 18:09:49 +0000
Message-ID: <9b291140-98a1-8187-1dc8-4481aa3d07b0@openvz.org>
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
	<20190109112311.GB4867@localhost.localdomain>
	<5ddd78e0-90ed-a6e5-c454-f1a2e44c1a37@redhat.com>
	<20190109165111.GI4867@localhost.localdomain>
	<61f6ac4d-91ab-f9cb-67e5-e0f5ce17524d@redhat.com>
	<20190109170929.GJ4867@localhost.localdomain>
In-Reply-To: <20190109170929.GJ4867@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3AE57FFE11BC6448FA1FA2E50F6B854@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>

T24gMS85LzE5IDg6MDkgUE0sIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDA5LjAxLjIwMTkgdW0g
MTc6NTUgaGF0IFBhb2xvIEJvbnppbmkgZ2VzY2hyaWViZW46DQo+PiBPbiAwOS8wMS8xOSAxNzo1
MSwgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAwOS4wMS4yMDE5IHVtIDE3OjQyIGhhdCBQYW9s
byBCb256aW5pIGdlc2NocmllYmVuOg0KPj4+PiBPbiAwOS8wMS8xOSAxMjoyMywgS2V2aW4gV29s
ZiB3cm90ZToNCj4+Pj4+IEFsc28gbm90ZSB0aGF0IHRoaXMgaXMgb25seSBtZXRhZGF0YSBwcmVh
bGxvY2F0aW9uOyBmdWxsIHByZWFsbG9jYXRpb24NCj4+Pj4+IHdpbGwgc3RpbGwgcmV0dXJuIGFs
bG9jYXRlZCBmb3IgdGhlIHByb3RvY29sIGxheWVyIGFuZCBzbyBpdCB3aWxsIGFsd2F5cw0KPj4+
Pj4gYmUgc2xvdy4NCj4+Pj4gRnVsbCBwcmVhbGxvY2F0aW9uIHRoZXNlIGRheXMgY2FuIGNyZWF0
ZSBpbWFnZXMgd2l0aCBwcmVhbGxvY2F0ZWQgYnV0DQo+Pj4+IGtub3duLXplcm8gYmxvY2tzLCBJ
IHRoaW5rPw0KPj4+IFRoYXQgd291bGQgZGVmZWF0IG9uZSBvZiB0aGUgbWFpbiBwdXJwb3NlcyBv
ZiBwcmVhbGxvY2F0aW9uIGJlY2F1c2UgaXQNCj4+PiB3b3VsZCBzdGlsbCByZXF1aXJlIENPVyBh
bmQgbWV0YWRhdGEgdXBkYXRlcyBvbiB0aGUgZmlyc3Qgd3JpdGUuDQo+PiBTb3JyeSBJIG1lYW4g
YXQgdGhlIHByb3RvY29sIGxldmVsLCBsaWtlIEZBTExPQ19GTF9aRVJPX1JBTkdFLiAgSXQgd291
bGQNCj4+IHN0aWxsIHJlcXVpcmUgbWV0YWRhdGEgdXBkYXRlcyBvbiB0aGUgZmlsZXN5c3RlbSBs
ZXZlbCwgdW5saWtlICJyZWFsIg0KPj4gZnVsbCBwcmVhbGxvY2F0aW9uLCBidXQgbm8gcWNvdzIg
bWV0YWRhdGEgdXBkYXRlcy4NCj4gcHJlYWxsb2NhdGlvbj1mdWxsIGRvZXNuJ3QgZG8gdGhhdC4g
cHJlYWxsb2NhdGlvbj1mYWxsb2MgaXMgbW9yZSBsaWtlDQo+IGl0LCB0aG91Z2ggdGhhdCBpcyBq
dXN0IHBvc2l4X2ZhbGxvY2F0ZSgpLCBub3QgRkFMTE9DX0ZMX1pFUk9fUkFOR0UuIEJ1dA0KPiB3
aGVuIGNhbGxlZCBvbiBhIG5ldyBmaWxlLCBpdCBtaWdodCByZXN1bHQgaW4gdGhlIHNhbWUgdGhp
bmc/IE5vdCBzdXJlLg0KPg0KPiBLZXZpbg0KRnJvbSB0aGUgcG9pbnQgb2YgdGhlIGZpbGUgc3Ry
dWN0dXJlICJmYWxsb2NhdGVkIiBzcGFjZSBzaG91bGQgYmUgY29uc2lkZXJlZA0KYXMgZGF0YSBh
cyB0aGUgc3BhY2Ugb24gdGhlIGRpc2MgaXMgcmVhbGx5IGFsbG9jYXRlZCBhbmQgdGhlIHNhbWUg
Y29uc3RyYWludA0Kc2hvdWxkIGJlIGtlcHQgaW4gb24gdGFyZ2V0Lg0KDQpEZW4NCg==

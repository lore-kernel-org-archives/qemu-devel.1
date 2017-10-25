Received: from eggs.gnu.org ([2001:4830:134:3::10]:45216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7G5V-0004K0-Uc
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7G5S-0006D0-O1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:26:53 -0400
From: Changlimin <changlimin@h3c.com>
Date: Wed, 25 Oct 2017 07:26:22 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572CFCE550D@H3CMLB12-EX.srv.huawei-3com.com>
References: <BC29A004BA570342A4CC0044A3845572CFCE4DB9@H3CMLB12-EX.srv.huawei-3com.com>
	<93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
In-Reply-To: <93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] qemu-img crash when resize a qcow2 file created
 with preallocation=full/falloc .
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

VGhlIGxhdGVzdCB2ZXJzaW9uIGZyb20gZ2l0IGU4MjJlODFlMzUwODI1ZGQ5NGY0MWVlMjUzOGZm
MTQzMmI4MTJlYjkNCkFsc28gdWJ1bnR1IDE3LjEwDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBUaG9tYXMgSHV0aCBbbWFpbHRvOnRodXRoQHJlZGhhdC5jb21dIA0KU2VudDog
V2VkbmVzZGF5LCBPY3RvYmVyIDI1LCAyMDE3IDM6MjIgUE0NClRvOiBjaGFuZ2xpbWluIDAwMTQ4
IChDbG91ZCk7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6IFFlbXUtYmxvY2s7IE1heCBSZWl0
eg0KU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBxZW11LWltZyBjcmFzaCB3aGVuIHJlc2l6ZSBh
IHFjb3cyIGZpbGUgY3JlYXRlZCB3aXRoIHByZWFsbG9jYXRpb249ZnVsbC9mYWxsb2MgLg0KDQpP
biAyNC4xMC4yMDE3IDA1OjI4LCBDaGFuZ2xpbWluIHdyb3RlOg0KPiBIaSwNCj4gSSBhbSBnbGFk
IHRvIHNlZSB0aGF0IHFjb3cyIGZpbGUgY3JlYXRlZCB3aXRoIHByZWFsbG9jYXRpb249ZnVsbC9m
YWxsb2MgY2FuIGJlIHJlc2l6ZWQuIEJ1dCB3aGVuIEkgdGVzdCBpdCwgcWVtdS1pbWcgY3Jhc2hz
Lg0KPiBxZW11LWltZzogYmxvY2svcWNvdzItcmVmY291bnQuYzo1MzA6IHFjb3cyX3JlZmNvdW50
X2FyZWE6IEFzc2VydGlvbiBgIShzdGFydF9vZmZzZXQgJSBzLT5jbHVzdGVyX3NpemUpJyBmYWls
ZWQuDQo+IA0KPiBUaGVzZSBhcmUgY29tbWFuZHM6DQo+IHFlbXUtaW1nIGNyZWF0ZSAtZiBxY293
MiAtbyBwcmVhbGxvY2F0aW9uPWZ1bGwgZnVsbC5pbWcgMUcgcWVtdS1pbWcgDQo+IHJlc2l6ZSAt
LXByZWFsbG9jYXRpb249ZnVsbCBmdWxsLmltZyArMUcNCg0KV2hpY2ggdmVyc2lvbiBvZiBxZW11
LWltZyBhcmUgeW91IHVzaW5nPyB2Mi4xMCBvciB0aGUgbGF0ZXN0IGdpdCBtYXN0ZXIgYnJhbmNo
Pw0KDQogVGhvbWFzDQo=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eK5QC-0008W5-36
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eK5Q8-0004P1-RZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:41:16 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2236 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eK5Q8-0004NT-GD
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:41:12 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 29 Nov 2017 16:41:00 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A9A3B@DGGEMA505-MBS.china.huawei.com>
References: <20171128044656.10592-1-linzhecheng@huawei.com>
	<cd2bad80-1790-aa01-fde4-4979b4c53b97@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A9A07@DGGEMA505-MBS.china.huawei.com>
	<2d6d0a12-9eb8-0948-4dc5-f84ad9070cc0@redhat.com>
In-Reply-To: <2d6d0a12-9eb8-0948-4dc5-f84ad9070cc0@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] thread: move detach_thread from
 creating thread to created thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, linzhecheng <linzhecheng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMzAs
IDIwMTcgMTI6MzkgQU0NCj4gVG86IEdvbmdsZWkgKEFyZWkpOyBFcmljIEJsYWtlOyBsaW56aGVj
aGVuZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBmYW16QHJlZGhhdC5jb207IHdhbmd4
aW4gKFUpDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0XSB0aHJlYWQ6IG1v
dmUgZGV0YWNoX3RocmVhZCBmcm9tDQo+IGNyZWF0aW5nIHRocmVhZCB0byBjcmVhdGVkIHRocmVh
ZA0KPiANCj4gT24gMjkvMTEvMjAxNyAxNzoyOCwgR29uZ2xlaSAoQXJlaSkgd3JvdGU6DQo+ID4+
PiBUaGUgcm9vdCBjYXVzZSBvZiB0aGlzIHByb2JsZW0gaXMgYSBidWcgb2YgZ2xpYmModmVyc2lv
biAyLjE3LHRoZSBsYXRlc3QNCj4gdmVyc2lvbg0KPiA+PiBoYXMgdGhlIHNhbWUgYnVnKSwNCj4g
Pj4+IGxldCdzIHNlZSB3aGF0IGhhcHBlbmVkIGluIGdsaWJjJ3MgY29kZS4NCj4gPj4gSGF2ZSB5
b3UgcmVwb3J0ZWQgdGhpcyBidWcgdG8gdGhlIGdsaWJjIGZvbGtzLCBhbmQgaWYgc28sIGNhbiB3
ZSBpbmNsdWRlDQo+ID4+IGEgVVJMIHRvIHRoZSBnbGliYyBidWd6aWxsYT8NCj4gPj4NCj4gPiBO
bywgd2UgZGlkbid0IGRvIHRoYXQgeWV0LiA6KA0KPiANCj4gSXQncyBoZXJlOg0KPiANCj4gICAg
IGh0dHBzOi8vc291cmNld2FyZS5vcmcvYnVnemlsbGEvc2hvd19idWcuY2dpP2lkPTE5OTUxLg0K
PiANCj4gSSd2ZSBhZGRlZCBhIG5vdGUgdG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCk5pY2V+
IDopDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=

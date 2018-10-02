Received: from eggs.gnu.org ([2001:4830:134:3::10]:53310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1g7HKI-0001fT-Vy
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1g7HKE-0004uX-DC
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:50:46 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Tue, 2 Oct 2018 09:50:37 +0000
Message-ID: <f0e18134-202a-3945-866a-121f0759b552@janustech.com>
References: <20180929095454.32066-1-lbloch@janustech.com>
	<dd15dbb9-6aaa-ab5a-9105-8cf49e76cc27@redhat.com>
	<20181001165945.GD4445@localhost.localdomain>
In-Reply-To: <20181001165945.GD4445@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC3B7415F1D07A4DB00DAE73D5CC5722@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix cache-clean-interval
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>

T24gMTAvMS8xOCA3OjU5IFBNLCBLZXZpbiBXb2xmIHdyb3RlOg0KPiBBbSAwMS4xMC4yMDE4IHVt
IDE2OjM1IGhhdCBFcmljIEJsYWtlIGdlc2NocmllYmVuOg0KPj4gT24gOS8yOS8xOCA0OjU0IEFN
LCBMZW9uaWQgQmxvY2ggd3JvdGU6DQo+Pj4gRml4aW5nIGNhY2hlLWNsZWFuLWludGVydmFsIGRv
Y3VtZW50YXRpb24gZm9sbG93aW5nIHRoZSByZWNlbnQgY2hhbmdlIHRvDQo+Pj4gYSBkZWZhdWx0
IG9mIDYwMCBzZWNvbmRzIG9uIHN1cHBvcnRlZCBwbGFyZm9ybXMgKG9ubHkgTGludXggY3VycmVu
dGx5KS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IExlb25pZCBCbG9jaCA8bGJsb2NoQGphbnVz
dGVjaC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZG9jcy9xY293Mi1jYWNoZS50eHQgfCAxOSArKysr
KysrKystLS0tLS0tLS0tDQo+Pj4gICAgcWFwaS9ibG9jay1jb3JlLmpzb24gfCAgMyArKy0NCj4+
PiAgICBxZW11LW9wdGlvbnMuaHggICAgICB8ICAzICsrLQ0KPj4+ICAgIDMgZmlsZXMgY2hhbmdl
ZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0
IGEvZG9jcy9xY293Mi1jYWNoZS50eHQgYi9kb2NzL3Fjb3cyLWNhY2hlLnR4dA0KPj4+IGluZGV4
IDU5MzU4YjgxNmYuLjE3NzgzMTJlMDkgMTAwNjQ0DQo+Pj4gLS0tIGEvZG9jcy9xY293Mi1jYWNo
ZS50eHQNCj4+PiArKysgYi9kb2NzL3Fjb3cyLWNhY2hlLnR4dA0KPj4+IEBAIC0yMDIsMTggKzIw
MiwxNyBAQCBSZWR1Y2luZyB0aGUgbWVtb3J5IHVzYWdlDQo+Pj4gICAgSXQgaXMgcG9zc2libGUg
dG8gY2xlYW4gdW51c2VkIGNhY2hlIGVudHJpZXMgaW4gb3JkZXIgdG8gcmVkdWNlIHRoZQ0KPj4+
ICAgIG1lbW9yeSB1c2FnZSBkdXJpbmcgcGVyaW9kcyBvZiBsb3cgSS9PIGFjdGl2aXR5Lg0KPj4+
IC1UaGUgcGFyYW1ldGVyICJjYWNoZS1jbGVhbi1pbnRlcnZhbCIgZGVmaW5lcyBhbiBpbnRlcnZh
bCAoaW4gc2Vjb25kcykuDQo+Pj4gLUFsbCBjYWNoZSBlbnRyaWVzIHRoYXQgaGF2ZW4ndCBiZWVu
IGFjY2Vzc2VkIGR1cmluZyB0aGF0IGludGVydmFsIGFyZQ0KPj4+IC1yZW1vdmVkIGZyb20gbWVt
b3J5Lg0KPj4+ICtUaGUgcGFyYW1ldGVyICJjYWNoZS1jbGVhbi1pbnRlcnZhbCIgZGVmaW5lcyBh
biBpbnRlcnZhbCAoaW4gc2Vjb25kcyksDQo+Pj4gK2FmZmVyIHdoaWNoIGFsbCB0aGUgY2FjaGUg
ZW50cmllcyB0aGF0IGhhdmVuJ3QgYmVlbiBhY2Nlc3NlZCBkdXJpbmcgaXQNCj4+DQo+PiBzL2Fm
ZmVyL2FmdGVyLw0KPj4NCj4+IE1heWJlIHMvZHVyaW5nIGl0L2R1cmluZyB0aGUgaW50ZXJ2YWwv
DQo+IA0KPiBUaGFua3MsIG1hZGUgdGhlc2UgZml4ZXMgYW5kIGFwcGxpZWQgaXQgdG8gdGhlIGJs
b2NrIGJyYW5jaC4NCj4gDQo+IEtldmluDQo+IA0KDQpUaGFua3MgS2V2aW4sIEVyaWMhDQo=

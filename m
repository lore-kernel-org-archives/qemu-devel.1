Received: from eggs.gnu.org ([2001:4830:134:3::10]:59341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1co4AI-0001za-Nb
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1co4AE-0005uO-O1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:20:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:43494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1co4AE-0005sq-BT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 04:20:10 -0400
From: "Zhong, Yang" <yang.zhong@intel.com>
Date: Wed, 15 Mar 2017 08:20:05 +0000
Message-ID: <7A85DF989CAE8F42902CF7B31A7D94A139557AC1@shsmsx102.ccr.corp.intel.com>
References: <1489585188-14504-1-git-send-email-yang.zhong@intel.com>
	<f421ff1e-b6a3-e271-57c1-2b8b5fba6d4b@redhat.com>
In-Reply-To: <f421ff1e-b6a3-e271-57c1-2b8b5fba6d4b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] memory: reduce heap Rss size around 3M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Xu, Anthony" <anthony.xu@intel.com>, Peter Maydell <peter.maydell@linaro.org>

SGVsbG8gUGFvbG8mcGV0ZXIsDQoNCk1heWJlIGJlbG93IHBhdGNoIGlzIG11Y2ggbW9yZSBiZXR0
ZXIsIEkgYWxzbyBkaWQgdGhlIHZlcmlmaWNhdGlvbi4gUGxlYXNlIGFsbCBvZiB5b3UgZ2l2ZSBz
b21lIGNvbW1lbnRzLCBtYW55IHRoYW5rcyENCg0KZGlmZiAtLWdpdCBhL21lbW9yeS5jIGIvbWVt
b3J5LmMNCmluZGV4IDY0YjBhNjAuLjIzMGYyY2IgMTAwNjQ0DQotLS0gYS9tZW1vcnkuYw0KKysr
IGIvbWVtb3J5LmMNCkBAIC0yNDIyLDcgKzI0MjIsNyBAQCBBZGRyZXNzU3BhY2UgKmFkZHJlc3Nf
c3BhY2VfaW5pdF9zaGFyZWFibGUoTWVtb3J5UmVnaW9uICpyb290LCBjb25zdCBjaGFyICpuYW1l
KQ0KICAgICBBZGRyZXNzU3BhY2UgKmFzOw0KDQogICAgIFFUQUlMUV9GT1JFQUNIKGFzLCAmYWRk
cmVzc19zcGFjZXMsIGFkZHJlc3Nfc3BhY2VzX2xpbmspIHsNCi0gICAgICAgIGlmIChyb290ID09
IGFzLT5yb290ICYmIGFzLT5tYWxsb2NlZCkgew0KKyAgICAgICAgaWYgKHJvb3QgPT0gYXMtPnJv
b3QgJiYgKGFzLT5tYWxsb2NlZCB8fCBhcyA9PSAmYWRkcmVzc19zcGFjZV9tZW1vcnkpKSB7DQog
ICAgICAgICAgICAgYXMtPnJlZl9jb3VudCsrOw0KICAgICAgICAgICAgIHJldHVybiBhczsNCiAg
ICAgICAgIH0NCg0KUmVnYXJkcywNCg0KWmhvbmdZYW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0g
DQpTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE1LCAyMDE3IDQ6MTMgUE0NClRvOiBaaG9uZywgWWFu
ZyA8eWFuZy56aG9uZ0BpbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBYdSwg
QW50aG9ueSA8YW50aG9ueS54dUBpbnRlbC5jb20+OyBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBtZW1vcnk6IHJlZHVjZSBo
ZWFwIFJzcyBzaXplIGFyb3VuZCAzTQ0KDQoNCg0KT24gMTUvMDMvMjAxNyAxNDozOSwgWWFuZyBa
aG9uZyB3cm90ZToNCj4gU2luY2UgY3B1LW1lbW9yeSBhbmQgbWVtb3J5IGhhdmUgc2FtZSBhZGRy
ZXNzIHNwYWNlLG9uZSBtYWxsb2NlZCANCj4gbWVtb3J5IGlzIGVub3VnaC4gVGhpcyBwYXRjaCB3
aWxsIHNraXAgbWVtb3J5IG1hbGxvYyBmb3IgbWVtb3J5IA0KPiBhZGRyZXNzIHNwYWNlLHdoaWNo
IHdpbGwgcmVkdWNlIGFyb3VuZCAzTSBwaHlzaWNhbCBtZW1vcnkgaW4gaGVhcC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFlhbmcgWmhvbmcgPHlhbmcuemhvbmdAaW50ZWwuY29tPg0KPiAtLS0NCj4g
IG1lbW9yeS5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVtb3J5LmMgYi9tZW1vcnkuYw0KPiBpbmRl
eCA2NGIwYTYwLi4wMDAzYjFlIDEwMDY0NA0KPiAtLS0gYS9tZW1vcnkuYw0KPiArKysgYi9tZW1v
cnkuYw0KPiBAQCAtMjQyMiw3ICsyNDIyLDcgQEAgQWRkcmVzc1NwYWNlICphZGRyZXNzX3NwYWNl
X2luaXRfc2hhcmVhYmxlKE1lbW9yeVJlZ2lvbiAqcm9vdCwgY29uc3QgY2hhciAqbmFtZSkNCj4g
ICAgICBBZGRyZXNzU3BhY2UgKmFzOw0KPiAgDQo+ICAgICAgUVRBSUxRX0ZPUkVBQ0goYXMsICZh
ZGRyZXNzX3NwYWNlcywgYWRkcmVzc19zcGFjZXNfbGluaykgew0KPiAtICAgICAgICBpZiAocm9v
dCA9PSBhcy0+cm9vdCAmJiBhcy0+bWFsbG9jZWQpIHsNCj4gKyAgICAgICAgaWYgKHJvb3QgPT0g
YXMtPnJvb3QgJiYgYXMgPT0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KSB7DQoNCk9mIGNvdXJzZSB5
b3UgbmVlZCB0byBrZWVwIHRoZSBhcy0+bWFsbG9jZWQgY2hlY2ssIGRvbid0IHlvdT8NCg0KPiAg
ICAgICAgICAgICAgYXMtPnJlZl9jb3VudCsrOw0KPiAgICAgICAgICAgICAgcmV0dXJuIGFzOw0K
PiAgICAgICAgICB9DQo+IA0KDQpUaGlzIGlzIG5vdCByZWFsbHkgYmVhdXRpZnVsLCBidXQgY29t
cGFyZWQgdG8gdjEgYW5kIHYyIGl0IGhhcyB0aGUgYWR2YW50YWdlIHRoYXQgaXQgd29ya3MgKHdp
dGggdGhlIGFzLT5tYWxsb2NlZCBjaGVjayByZWludHJvZHVjZWQpLg0KUGV0ZXIsIHlvdSBpbnRy
b2R1Y2VkIGFkZHJlc3Nfc3BhY2VfaW5pdF9zaGFyZWFibGUsIHdoYXQgZG8geW91IHRoaW5rPw0K
DQpQYW9sbw0K

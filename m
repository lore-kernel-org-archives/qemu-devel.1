Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chenhl@arraynetworks.com.cn>) id 1eIB5Y-0001Ta-NY
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chenhl@arraynetworks.com.cn>) id 1eIB5S-0005KS-Ac
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:20:04 -0500
Received: from mail.arraynetworks.com.cn ([124.42.99.121]:30090
	helo=mail01.arraynetworks.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chenhl@arraynetworks.com.cn>)
	id 1eIB5R-0005C3-FH
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 05:19:58 -0500
Date: Fri, 24 Nov 2017 17:59:09 +0800
From: Chen Hailin <chenhl@arraynetworks.com.cn>
References: <20171117063635.9244-1-chenhl@arraynetworks.com.cn>,
	<f7tine8z6pj.fsf@dhcp-25-97.bos.redhat.com>
MIME-Version: 1.0
Message-ID: <2017112417590937512732@arraynetworks.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [ovs-dev] [PATCH RFC] netdev-dpdk: Fix device
 obtain mac address when received first packet in vhost type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Conole <aconole@redhat.com>, "jianfeng.tan" <jianfeng.tan@intel.com>
Cc: "ovs-dev@openvswitch.org" <ovs-dev@openvswitch.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, cloud <cloud@arraynetworks.com.cn>, qemu-devel <qemu-devel@nongnu.org>, dev <dev@dpdk.org>

SGkgQWFyb24gQ29ub2xlICYmIEppYW5mZW5nLA0KDQpUaGUgc3RwIGNvdWxkIG5vdCB3b3JrIGlu
IG92cy1kcGRrIHZob3N0dXNlci4NCkJlY2F1c2UgdGhlIGF0dGFjaGVkIHZob3N0IGRldmljZSBk
b2Vzbid0IGhhdmUgTUFDIGFkZHJlc3MuDQoNCk5vdyB3ZSBoYXZlIHR3byB3YXlzIHRvIHNvbHZl
IHRoaXMgcHJvYmxlbS4NCjEuIFRoZSB2aG9zdCBsZWFybnMgTUFDIGFkZHJlc3MgZnJvbSBwYWNr
ZXQgbGlrZSBhcyBteSBmaXJzdCBwYXRjaC4NCjIuIFRoZSB2aXJ0aW8gbm90aWZpZXMgTUFDIGFk
ZHJlc3MgYWN0aXZlbHkgdG8gdmhvc3QgdXNlciAuDQoNCkluIG15IG9waW5pb25zLCAgaWYgd2Ug
dHJlYXQgaXQgYXMgYSBkZXZpY2UsICB3ZSBzaG91bGQgYWxsb2NhdGUgDQpNQUMgYWRkcmVzcyBm
b3IgdGhlIGRldmljZSB3aGVuIHRoZSBWTSBzdGFydGVkLg0KDQpXaGljaCBvbmUgZG8geW91IHRo
aW5rIGJldHRlcj8NCg0KDQoNCkJlc3QgUmVnYXJkcywNCkNoZW4gSGFpbGluDQpjaGVuaGxAYXJy
YXluZXR3b3Jrcy5jb20uY24NCiANCkZyb206IEFhcm9uIENvbm9sZQ0KRGF0ZTogMjAxNy0xMS0x
OCAxMDowMA0KVG86IEhhaWxpbiBDaGVuDQpDQzogb3ZzLWRldkBvcGVudnN3aXRjaC5vcmc7IE1h
eGltZSBDb3F1ZWxpbjsgY2xvdWRAYXJyYXluZXR3b3Jrcy5jb20uY24NClN1YmplY3Q6IFJlOiBb
b3ZzLWRldl0gW1BBVENIIFJGQ10gbmV0ZGV2LWRwZGs6IEZpeCBkZXZpY2Ugb2J0YWluIG1hYyBh
ZGRyZXNzIHdoZW4gcmVjZWl2ZWQgZmlyc3QgcGFja2V0IGluIHZob3N0IHR5cGUNCkhpIEhhaWxp
biwNCiANCkhhaWxpbiBDaGVuIDxjaGVuaGxAYXJyYXluZXR3b3Jrcy5jb20uY24+IHdyaXRlczoN
CiANCj4gVGhlIHN0cCBjb3VsZCBub3Qgd29yayBvbiBuZXRkZXYtZHBkayBpZiBuZXR3b3JrIGlz
IGxvb3AuDQo+IEJlY2F1c2UgdGhlIHN0cCBwcm90b2NvbCBuZWdvdGlhdGVzIGRlc2lnbmF0ZSBw
b3J0IGJ5IHNlbmRpbmcNCj4gQlBEVSBwYWNrZXRzIHdoaWNoIGNvbnRhaW5zIE1BQyBhZGRyZXNz
Lg0KPiBIb3dldmVyIHRoZSBkZXZpY2UgZG9lc24ndCBoYXZlIE1BQyBhZGRyZXNzIGluIHZob3N0
dXNlciB0eXBlLg0KPiBUaHVzLCBmdW5jdGlvbiBzZW5kX2JwZHVfY2Igd291bGQgbm90IHNlbmQg
QlBEVSBwYWNrZXRzLg0KPg0KPiBUaGlzIHBhdGNoIHdpbGwgc2V0IHRoZSBNQUMgZm9yIGRldmlj
ZSB3aGVuIHJlY2VpdmVkIGZpcnN0IHBhY2tldC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFpbGlu
IENoZW4gPGNoZW5obEBhcnJheW5ldHdvcmtzLmNvbS5jbj4NCj4gLS0tDQogDQpUaGFua3MgZm9y
IHRoZSBwYXRjaC4NCiANCkluIGdlbmVyYWwsIEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgcmln
aHQgYXBwcm9hY2ggdG8gZGVhbCB3aXRoIHRoaXMNCnR5cGUgb2YgaXNzdWUuICBJIGJlbGlldmUg
dGhlIHByb2JsZW0gc3RhdGVtZW50IGlzIHRoYXQgT3ZTIGJyaWRnZSBpcw0KdW5hd2FyZSBvZiB0
aGUgZ3Vlc3QgTUFDIGFkZHJlc3MgLSBkaWQgSSBnZXQgaXQgcmlnaHQ/ICBJbiB0aGF0IGNhc2Us
IEkNCndvdWxkIHRoaW5rIHRoYXQgYSBiZXR0ZXIgd2F5IHRvIHNvbHZlIHRoaXMgd291bGQgYmUg
dG8gaGF2ZSB2aXJ0aW8gdGVsbA0KdGhlIG1hYyBhZGRyZXNzIG9mIHRoZSBndWVzdC4gIEkgZG9u
J3QgcmVjYWxsIHJpZ2h0IG5vdyBpZiB0aGF0J3MNCmFsbG93ZWQgaW4gdGhlIHZpcnRpbyBzcGVj
LCBidXQgSSBkbyByZW1lbWJlciBzb21lIGtpbmQgb2YgbmVnb3RpYXRpb24NCmZlYXR1cmVzLg0K
IA0KSSd2ZSBDQydkIE1heGltZSwgd2hvIGlzIG9uZSBvZiB0aGUgbWFpbnRhaW5lcnMgb2YgdGhl
IHZpcnRpbyBjb2RlIGZyb20NCkRQREsgc2lkZS4gIFBlcmhhcHMgdGhlcmUgaXMgYW4gYWx0ZXJu
YXRlIHdheSB0byBzb2x2ZSB0aGlzLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCmRldiBtYWlsaW5nIGxpc3QNCmRldkBvcGVudnN3aXRjaC5vcmcNCmh0
dHBzOi8vbWFpbC5vcGVudnN3aXRjaC5vcmcvbWFpbG1hbi9saXN0aW5mby9vdnMtZGV2DQo=

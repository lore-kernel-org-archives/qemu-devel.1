Received: from eggs.gnu.org ([2001:4830:134:3::10]:57660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csgIt-0003be-B9
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1csgIp-0003zM-J6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:52:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:6778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1csgIp-0003yr-B6
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 21:52:07 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 28 Mar 2017 01:52:02 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B56706B@SHSMSX103.ccr.corp.intel.com>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
	<00d28fcc-446b-eff6-a5a3-6675216802b9@redhat.com>
In-Reply-To: <00d28fcc-446b-eff6-a5a3-6675216802b9@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH] virtio-blk: add DISCARD
 support to virtio-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogdmlydGlvLWRldkBsaXN0
cy5vYXNpcy1vcGVuLm9yZyBbbWFpbHRvOnZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmdd
IE9uDQo+IEJlaGFsZiBPZiBQYW9sbyBCb256aW5pDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjcs
IDIwMTcgNzozNCBQTQ0KPiBUbzogTGl1LCBDaGFuZ3BlbmcgPGNoYW5ncGVuZy5saXVAaW50ZWwu
Y29tPjsgdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZzsNCj4gdmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGhjaEBsc3QuZGUNCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBSZTog
W3ZpcnRpby1kZXZdIFtQQVRDSF0gdmlydGlvLWJsazogYWRkIERJU0NBUkQgc3VwcG9ydCB0byB2
aXJ0aW8tYmxrIGRyaXZlcg0KPiANCj4gDQo+IA0KPiBPbiAyOC8wMy8yMDE3IDEwOjM5LCBDaGFu
Z3BlbmcgTGl1IHdyb3RlOg0KPiA+ICsJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJU
SU9fQkxLX0ZfRElTQ0FSRCkpIHsNCj4gPiArCQlxLT5saW1pdHMuZGlzY2FyZF96ZXJvZXNfZGF0
YSA9IDA7DQo+IA0KPiBNYXliZSB5b3UgY291bGQgdXNlIGFub3RoZXIgZmVhdHVyZSBiaXQgdG8g
cG9wdWxhdGUgZGlzY2FyZF96ZXJvZXNfZGF0YS4NCj4gDQo+IFBhb2xvDQo+IA0KU291bmRzIGdv
b2QgdG8gbWUsIENocmlzdG9waCBIZWxsd2lnIG1lbnRpb25lZCB0aGlzIGZpZWxkIHdpbGwgYmUg
cmVtb3ZlZCBpbiBuZXh0IHJlbGVhc2UsIGp1c3QgcmVtb3ZlZCB0aGlzIGxpbmUgbWFrZXMgY2xl
YXIuDQo+ID4gKwkJcS0+bGltaXRzLmRpc2NhcmRfYWxpZ25tZW50ID0gYmxrX3NpemU7DQo+ID4g
KwkJcS0+bGltaXRzLmRpc2NhcmRfZ3JhbnVsYXJpdHkgPSBibGtfc2l6ZTsNCj4gPiArCQlibGtf
cXVldWVfbWF4X2Rpc2NhcmRfc2VjdG9ycyhxLCBVSU5UX01BWCk7DQo+ID4gKwkJYmxrX3F1ZXVl
X21heF9kaXNjYXJkX3NlZ21lbnRzKHEsIDEpOw0KPiA+ICsJCXF1ZXVlX2ZsYWdfc2V0X3VubG9j
a2VkKFFVRVVFX0ZMQUdfRElTQ0FSRCwgcSk7DQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVA
bGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gRm9yIGFkZGl0aW9uYWwgY29tbWFuZHMsIGUtbWFpbDog
dmlydGlvLWRldi1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQoNCg==

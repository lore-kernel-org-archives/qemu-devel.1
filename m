Received: from eggs.gnu.org ([2001:4830:134:3::10]:38023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cunming.liang@intel.com>) id 1f9Cpo-0001dE-C4
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cunming.liang@intel.com>) id 1f9Cpl-00059F-9N
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:55:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:11055)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cunming.liang@intel.com>)
	id 1f9Cpk-00058X-Vt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:54:57 -0400
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Thu, 19 Apr 2018 16:52:20 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E950C67@SHSMSX104.ccr.corp.intel.com>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-7-tiwei.bie@intel.com>
	<20180418192154-mutt-send-email-mst@kernel.org>
	<20180419111439.i6gfhnept6wy7uzp@debian>
	<D0158A423229094DA7ABF71CF2FA0DA34E94E895@SHSMSX104.ccr.corp.intel.com>
	<20180419182035-mutt-send-email-mst@kernel.org>
	<f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
In-Reply-To: <f123c3a5-f7a3-a0e3-ffc7-b57e19610a9b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 6/6] vhost-user: support registering
 external host notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Bie, Tiwei" <tiwei.bie@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Daly,
	Dan" <dan.daly@intel.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "Wang,
	Xiao W" <xiao.w.wang@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxOSwg
MjAxOCAxMTo1MiBQTQ0KPiBUbzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47
IExpYW5nLCBDdW5taW5nDQo+IDxjdW5taW5nLmxpYW5nQGludGVsLmNvbT4NCj4gQ2M6IEJpZSwg
VGl3ZWkgPHRpd2VpLmJpZUBpbnRlbC5jb20+OyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPiBhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgc3RlZmFuaGFAcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBu
b25nbnUub3JnOw0KPiB2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnOyBEYWx5LCBEYW4g
PGRhbi5kYWx5QGludGVsLmNvbT47IFRhbiwgSmlhbmZlbmcNCj4gPGppYW5mZW5nLnRhbkBpbnRl
bC5jb20+OyBXYW5nLCBaaGlob25nIDx6aGlob25nLndhbmdAaW50ZWwuY29tPjsgV2FuZywNCj4g
WGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
Ni82XSB2aG9zdC11c2VyOiBzdXBwb3J0IHJlZ2lzdGVyaW5nIGV4dGVybmFsIGhvc3QNCj4gbm90
aWZpZXJzDQo+IA0KPiBPbiAxOS8wNC8yMDE4IDE3OjQyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+ID4+IEEgY29tcGlsZXIgYmFycmllciBpcyBlbm91Z2ggb24gc3Ryb25nbHktb3JkZXJl
ZCBtZW1vcnkgcGxhdGZvcm0uDQo+ID4+IEFzIGl0IGRvZXNuJ3QgcmUtb3JkZXIgc3RvcmUsIFBD
SSBkZXZpY2Ugd29uJ3Qgc2VlIGEgc3RhbGUgaW5kZXgNCj4gPj4gdmFsdWUuIEJ1dCBhIHdlYWts
eS1vcmRlcmVkIG1lbW9yeSBuZWVkcyBzZmVuY2UuDQo+ID4NCj4gPiBPaCB5b3UgYXJlIHJpZ2h0
Lg0KPiA+DQo+ID4gU28gaXQncyBvbmx5IG5lZWRlZCBmb3Igbm9uLWludGVsIHBsYXRmb3JtcyBv
ciB3aGVuIHBhY2tldHMgYXJlIGluIFdDDQo+ID4gbWVtb3J5IHRoZW4uIEFuZCBJIGRvbid0IGtu
b3cgd2hldGhlciBkcGRrIGV2ZXIgcHV0cyBwYWNrZXRzIGluIFdDDQo+ID4gbWVtb3J5Lg0KPiA+
DQo+ID4gSSBndWVzcyB3ZSdsbCBjcm9zcyB0aGlzIGJyaWRnZSB3aGVuIHdlIGdldCB0byBpdC4N
Cj4gDQo+IE5vbi1UU08gYXJjaGl0ZWN0dXJlcyBzZWVtIGltcG9ydGFudC4uLg0KDQpJJ20gbm90
IGZhbWlsaWFyIHdpdGggTm9uLVRTTywgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhlIGRpZmZlcmVu
Y2UgYWNjb3JkaW5nIHRvIHRoZSBmZWF0dXJlIHNldC4gTGV0J3Mgc2F5IG5vbi1UU08gYXJjaGl0
ZWN0dXJlcyBkbyBub3Qgc2V0ICd3ZWFrX2JhcnJpZXJzJy4gVGhlbiBtYW5kYXRvcnkgYmFycmll
ciBpcyB1c2VkIGZvciBzb2Z0d2FyZS4gSFcgb2ZmbG9hZCBvbiB0aGF0IHBsYXRmb3JtIHdvdWxk
IGNob29zZSBkaWZmZXJlbnQgZmVhdHVyZSBzZXQgYWdhaW5zdCBzb2Z0d2FyZT8gDQpJZiBpdCdz
IG5vdCwgZXNzZW50aWFsbHkgd2UncmUgd29ycmllZCBhYm91dCBsaXZlIG1pZ3JhdGlvbiBmcm9t
IGEgVFNPIHRvIGEgbm9uLVRTTyBhcmNoaXRlY3R1cmVzIHBsYXRmb3JtPw0KDQo+IA0KPiBQYW9s
bw0K

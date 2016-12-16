Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cHiGZ-0000VH-49
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 21:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cHiGV-0002e9-5W
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 21:28:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:32607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cHiGU-0002b0-TJ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 21:28:55 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 16 Dec 2016 02:28:47 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190BC0914@SHSMSX101.ccr.corp.intel.com>
References: <1481681345-32424-1-git-send-email-peterx@redhat.com>
	<1481681345-32424-2-git-send-email-peterx@redhat.com>
	<20161214044741-mutt-send-email-mst@kernel.org>
	<20161214025343.GG32222@pxdev.xzpeter.org>
In-Reply-To: <20161214025343.GG32222@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/2] intel_iommu: check validity for GAW
 bits in CE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDE0LCAyMDE2IDEwOjU0IEFNDQo+IA0KPiBPbiBXZWQsIERlYyAxNCwg
MjAxNiBhdCAwNDo0ODo0MkFNICswMjAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4g
T24gV2VkLCBEZWMgMTQsIDIwMTYgYXQgMTA6MDk6MDRBTSArMDgwMCwgUGV0ZXIgWHUgd3JvdGU6
DQo+ID4gPiBDdXJyZW50bHkgdnQtZCBDb250ZXh0IEVudHJ5IChDRSkgb25seSBhbGxvd3MgMzkv
NDggYml0cyBhZGRyZXNzIHdpZHRoLg0KPiA+ID4gSWYgZ3Vlc3Qgc29mdHdhcmUgY29uZmlndXJl
ZCBtb3JlIHRoYW4gdGhhdCwgd2UgY29tcGxhaW4gYW5kIHJlcG9ydC4NCj4gPiA+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAxNyArKysrKysrKysrKysrKysr
LQ0KPiA+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+ID4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPg0K
PiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPiA+ID4gaW5kZXggNWYzZTM1MS4uNTE3YTJhMyAxMDA2NDQNCj4gPiA+IC0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+ID4gPiBAQCAtNTk5LDkgKzU5OSwxOSBAQCBzdGF0aWMgaW5saW5lIHVpbnQzMl90DQo+IHZ0
ZF9nZXRfbGV2ZWxfZnJvbV9jb250ZXh0X2VudHJ5KFZURENvbnRleHRFbnRyeSAqY2UpDQo+ID4g
PiAgICAgIHJldHVybiAyICsgKGNlLT5oaSAmIFZURF9DT05URVhUX0VOVFJZX0FXKTsNCj4gPiA+
ICB9DQo+ID4gPg0KPiA+ID4gKy8qIFJldHVybiAwIGlmIGZhaWxlZCB0byBmZXRjaCB2YWxpZCBh
dyAqLw0KPiA+ID4gIHN0YXRpYyBpbmxpbmUgdWludDMyX3QgdnRkX2dldF9hZ2F3X2Zyb21fY29u
dGV4dF9lbnRyeShWVERDb250ZXh0RW50cnkgKmNlKQ0KPiA+ID4gIHsNCj4gPiA+IC0gICAgcmV0
dXJuIDMwICsgKGNlLT5oaSAmIFZURF9DT05URVhUX0VOVFJZX0FXKSAqIDk7DQo+ID4gPiArICAg
IHVpbnQ4X3QgYXcgPSAoY2UtPmhpICYgVlREX0NPTlRFWFRfRU5UUllfQVcpOw0KPiA+ID4gKyAg
ICAvKg0KPiA+ID4gKyAgICAgKiBBY2NvcmRpbmcgdG8gdnQtZCBzcGVjIDEwLjQuMiBiaXRzIDEy
OjgsIFNBR0FXIG9ubHkgYWxsb3dzDQo+ID4gPiArICAgICAqIDM5LzQ4IGJpdHMuDQo+ID4gPiAr
ICAgICAqLw0KPiA+ID4gKyAgICBpZiAoYXcgPiBWVERfQ0VfQVdfNDhCSVQpIHsNCj4gPg0KPiA+
IDUtbGV2ZWwgaXMgYWxtb3N0IHN1cmUgdG8gYWxsb3cgbW9yZS4gSSBkb24ndCBzZWUgdGhlIHBv
aW50IG9mIHRoaXMgdGVzdC4NCj4gDQo+IFBsZWFzZSBjaGVjayBhYm92ZSBjb21tZW50IC0gc3Bl
YyBvbmx5IGFsbG93IDMvNCBsZXZlbCBwYWdlIHRhYmxlLg0KPiANCj4gTXkgdmVyc2lvbiBvZiB2
dC1kIHNwZWMgaXMgMjAxNiBPY3QuIEkgc3VwcG9zZSB0aGF0J3MgbmV3IGVub3VnaC4uLg0KPiAN
Cg0KSXQgaXMgaW4gdGhlIHdvcmtzIGFuZCB3aWxsIGJlIHB1Ymxpc2hlZCBpbiBKYW51YXJ5Lg0K
DQpUaGFua3MNCktldmluDQo=

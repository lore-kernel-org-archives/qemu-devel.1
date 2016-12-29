Received: from eggs.gnu.org ([2001:4830:134:3::10]:56618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cMY57-0004nK-TK
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 05:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cMY54-0006HI-T1
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 05:37:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:22950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cMY54-0006HC-LA
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 05:37:06 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 29 Dec 2016 10:37:01 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257438FEF99D@shsmsx102.ccr.corp.intel.com>
References: <A2975661238FB949B60364EF0F2C257438FEF893@shsmsx102.ccr.corp.intel.com>
	<20161229095940.GB4195@pxdev.xzpeter.org>
In-Reply-To: <20161229095940.GB4195@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH 12/13] intel_iommu: do replay when
 context invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBl
dGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjksIDIwMTYgNjow
MCBQTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IENjOiBUaWFuLCBL
ZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBMYW4sIFRpYW55dSA8dGlhbnl1LmxhbkBpbnRl
bC5jb20+OyAncWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZycgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz47ICdiZC5hdml2QGdtYWlsLmNvbScNCj4gPGJkLmF2aXZAZ21haWwuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1FlbXUtZGV2ZWxdIFtSRkMgUEFUQ0ggMTIvMTNdIGludGVsX2lvbW11OiBkbyByZXBs
YXkgd2hlbiBjb250ZXh0DQo+IGludmFsaWRhdGUNCj4gDQo+IE9uIFRodSwgRGVjIDI5LCAyMDE2
IGF0IDA3OjM4OjM4QU0gKzAwMDAsIExpdSwgWWkgTCB3cm90ZToNCj4gPiA+IEJlZm9yZSB0aGlz
IG9uZSB3ZSBvbmx5IGludmFsaWRhdGUgY29udGV4dCBjYWNoZSB3aGVuIHdlIHJlY2VpdmUgY29u
dGV4dA0KPiA+ID4gZW50cnkgaW52YWxpZGF0aW9ucy4gSG93ZXZlciBpdCdzIHBvc3NpYmxlIHRo
YXQgdGhlIGludmFsaWRhdGlvbiBhbHNvDQo+ID4gPiBjb250YWlucyBhIGRvbWFpbiBzd2l0Y2gg
KG9ubHkgaWYgY2FjaGUtbW9kZSBpcyBlbmFibGVkIGZvciB2SU9NTVUpLiBJbg0KPiA+ID4gdGhh
dCBjYXNlIHdlIG5lZWQgdG8gbm90aWZ5IGFsbCB0aGUgcmVnaXN0ZXJlZCBjb21wb25lbnRzIGFi
b3V0IHRoZSBuZXcNCj4gPiA+IG1hcHBpbmcuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
UGV0ZXIgWHUgPGFkZHJlc3NAaGlkZGVuPg0KPiA+ID4gLS0tDQo+ID4gPiAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jIHwgMSArDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPiA+ID4gaW5kZXggMmZjZDdhZi4uMDIyMGU2MyAxMDA2NDQNCj4gPiA+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4gKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+ID4gPiBAQCAtMTE4OCw2ICsxMTg4LDcgQEAgc3RhdGljIHZvaWQNCj4gdnRkX2Nv
bnRleHRfZGV2aWNlX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlDQo+ID4gPiAqcywNCj4gPiA+
ICAgICAgICAgICAgICAgICAgdHJhY2VfdnRkX2ludl9kZXNjX2NjX2RldmljZShidXNfbiwgKGRl
dmZuX2l0ID4+IDMpICYgMHgxZiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXZmbl9pdCAmIDMpOw0KPiA+ID4gICAgICAgICAgICAgICAgICB2
dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50cnkuY29udGV4dF9jYWNoZV9nZW4gPSAwOw0KPiA+ID4g
KyAgICAgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX2lvbW11X3JlcGxheV9hbGwoJnZ0ZF9hcy0+
aW9tbXUpOw0KPiA+DQo+ID4gSGkgUGV0ZXIsDQo+ID4NCj4gPiBJdCBsb29rcyBsaWtlIGFsbCB0
aGUgZGV2aWNlIGNvbnRleHQgaW52YWxpZGF0aW9uIHdvdWxkIHJlc3VsdCBpbiByZXBsYXkgZXZl
biB0aGUNCj4gPiBkZXZpY2UgaXMgbm90IGFuIGFzc2lnbmVkIGRldmljZS4gSXMgaXQgbmVjZXNz
YXJ5IHRvIGRvIHJlcGxheSBmb3IgYSB2aXJ0dWFsIGRldmljZT8NCj4gDQo+IE5vcm1hbCBlbXVs
YXRlZCBkZXZpY2VzIHdvbid0IHJlZ2lzdGVyIGZvciBJT01NVSBub3RpZmllci4gRm9yIHRoZXNl
DQo+IGRldmljZXMsIE1lbW9yeVJlZ2lvbi5pb21tdV9ub3RpZnkgd2lsbCBiZSBlbXB0eS4gU28g
cmVwbGF5IG9uIHRob3NlDQo+IG1lbW9yeSByZWdpb25zIHNob3VsZCBub3QgYWZmZWN0IHRoZW0g
YXQgYWxsLg0KPiANCkNvb2wsIHNvdW5kcyBnb29kLiB0aHghDQoNClJlZ2FyZHMsDQpZaSBMDQo=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiewen.yao@intel.com>) id 1epNP2-0003aq-GX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiewen.yao@intel.com>) id 1epNOy-000453-53
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:09:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:64669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
	id 1epNOx-00042r-Rr
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:09:20 -0500
From: "Yao, Jiewen" <jiewen.yao@intel.com>
Date: Sat, 24 Feb 2018 00:09:15 +0000
Message-ID: <74D8A39837DF1E4DA445A8C0B3885C503AACEB43@shsmsx102.ccr.corp.intel.com>
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180223132311.26555-2-marcandre.lureau@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [edk2] [PATCH 1/7] SecurityPkg/Tcg2Pei: drop
 Tcg2PhysicalPresenceLib dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "lersek@redhat.com" <lersek@redhat.com>

UmV2aWV3ZWQtYnk6IEppZXdlbi55YW9AaW50ZWwuY29tDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogZWRrMi1kZXZlbCBbbWFpbHRvOmVkazItZGV2ZWwtYm91bmNlc0Bs
aXN0cy4wMS5vcmddIE9uIEJlaGFsZiBPZg0KPiBtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20N
Cj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAyMywgMjAxOCA5OjIzIFBNDQo+IFRvOiBlZGsyLWRl
dmVsQGxpc3RzLjAxLm9yZw0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBqYXZpZXJtQHJl
ZGhhdC5jb207IHBqb25lc0ByZWRoYXQuY29tOyBZYW8sDQo+IEppZXdlbiA8amlld2VuLnlhb0Bp
bnRlbC5jb20+OyBsZXJzZWtAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBbZWRrMl0gW1BBVENIIDEv
N10gU2VjdXJpdHlQa2cvVGNnMlBlaTogZHJvcCBUY2cyUGh5c2ljYWxQcmVzZW5jZUxpYg0KPiBk
ZXBlbmRlbmN5DQo+IA0KPiBGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJl
YXVAcmVkaGF0LmNvbT4NCj4gDQo+IEFwcGFyZW50bHksIHVubmVjZXNzYXJ5LiBBdm9pZHMgZXh0
cmEgYnVpbGQgZGVwZW5kZW5jeSBhbmQgY2h1cm4uDQo+IA0KPiBDQzogTGFzemxvIEVyc2VrIDxs
ZXJzZWtAcmVkaGF0LmNvbT4NCj4gQ0M6IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXgudm5l
dC5pYm0uY29tPg0KPiBDb250cmlidXRlZC11bmRlcjogVGlhbm9Db3JlIENvbnRyaWJ1dGlvbiBB
Z3JlZW1lbnQgMS4wDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2Fu
ZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiAtLS0NCj4gIFNlY3VyaXR5UGtnL1RjZy9UY2cyUGVp
L1RjZzJQZWkuYyAgIHwgMiAtLQ0KPiAgU2VjdXJpdHlQa2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5p
bmYgfCAxIC0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9TZWN1cml0eVBrZy9UY2cvVGNnMlBlaS9UY2cyUGVpLmMNCj4gYi9TZWN1cml0eVBr
Zy9UY2cvVGNnMlBlaS9UY2cyUGVpLmMNCj4gaW5kZXggYTdhZTMzNTRiNS4uMzc1OGZjNmE0MSAx
MDA2NDQNCj4gLS0tIGEvU2VjdXJpdHlQa2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5jDQo+ICsrKyBi
L1NlY3VyaXR5UGtnL1RjZy9UY2cyUGVpL1RjZzJQZWkuYw0KPiBAQCAtMTgsNyArMTgsNiBAQCBX
SVRIT1VUIFdBUlJBTlRJRVMgT1IgUkVQUkVTRU5UQVRJT05TIE9GIEFOWQ0KPiBLSU5ELCBFSVRI
RVIgRVhQUkVTUyBPUiBJTVBMSUVELg0KPiAgI2luY2x1ZGUgPEluZHVzdHJ5U3RhbmRhcmQvVWVm
aVRjZ1BsYXRmb3JtLmg+DQo+ICAjaW5jbHVkZSA8UHBpL0Zpcm13YXJlVm9sdW1lSW5mby5oPg0K
PiAgI2luY2x1ZGUgPFBwaS9GaXJtd2FyZVZvbHVtZUluZm8yLmg+DQo+IC0jaW5jbHVkZSA8UHBp
L0xvY2tQaHlzaWNhbFByZXNlbmNlLmg+DQo+ICAjaW5jbHVkZSA8UHBpL1RwbUluaXRpYWxpemVk
Lmg+DQo+ICAjaW5jbHVkZSA8UHBpL0Zpcm13YXJlVm9sdW1lLmg+DQo+ICAjaW5jbHVkZSA8UHBp
L0VuZE9mUGVpUGhhc2UuaD4NCj4gQEAgLTQ0LDcgKzQzLDYgQEAgV0lUSE9VVCBXQVJSQU5USUVT
IE9SIFJFUFJFU0VOVEFUSU9OUyBPRiBBTlkNCj4gS0lORCwgRUlUSEVSIEVYUFJFU1MgT1IgSU1Q
TElFRC4NCj4gICNpbmNsdWRlIDxMaWJyYXJ5L01lbW9yeUFsbG9jYXRpb25MaWIuaD4NCj4gICNp
bmNsdWRlIDxMaWJyYXJ5L1JlcG9ydFN0YXR1c0NvZGVMaWIuaD4NCj4gICNpbmNsdWRlIDxMaWJy
YXJ5L1Jlc2V0U3lzdGVtTGliLmg+DQo+IC0jaW5jbHVkZSA8TGlicmFyeS9UY2cyUGh5c2ljYWxQ
cmVzZW5jZUxpYi5oPg0KPiANCj4gICNkZWZpbmUgUEVSRl9JRF9UQ0cyX1BFSSAgMHgzMDgwDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvU2VjdXJpdHlQa2cvVGNnL1RjZzJQZWkvVGNnMlBlaS5pbmYNCj4g
Yi9TZWN1cml0eVBrZy9UY2cvVGNnMlBlaS9UY2cyUGVpLmluZg0KPiBpbmRleCBmN2I4NTQ0NGQ5
Li5iYzkxMGMzYmFmIDEwMDY0NA0KPiAtLS0gYS9TZWN1cml0eVBrZy9UY2cvVGNnMlBlaS9UY2cy
UGVpLmluZg0KPiArKysgYi9TZWN1cml0eVBrZy9UY2cvVGNnMlBlaS9UY2cyUGVpLmluZg0KPiBA
QCAtNTgsNyArNTgsNiBAQA0KPiAgICBQZXJmb3JtYW5jZUxpYg0KPiAgICBNZW1vcnlBbGxvY2F0
aW9uTGliDQo+ICAgIFJlcG9ydFN0YXR1c0NvZGVMaWINCj4gLSAgVGNnMlBoeXNpY2FsUHJlc2Vu
Y2VMaWINCj4gICAgUmVzZXRTeXN0ZW1MaWINCj4gDQo+ICBbR3VpZHNdDQo+IC0tDQo+IDIuMTYu
MS43My5nNTgzMmI3ZTlmMg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18NCj4gZWRrMi1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gZWRrMi1kZXZlbEBs
aXN0cy4wMS5vcmcNCj4gaHR0cHM6Ly9saXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9lZGsy
LWRldmVsDQo=

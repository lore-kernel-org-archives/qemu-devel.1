Received: from eggs.gnu.org ([2001:4830:134:3::10]:51020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1erntg-0002mv-N3
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1erntc-0006Ng-AW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:51:04 -0500
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com
	([104.47.36.51]:11072
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1erntc-0006IP-2X
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:51:00 -0500
From: "Moger, Babu" <Babu.Moger@amd.com>
Date: Fri, 2 Mar 2018 16:50:57 +0000
Message-ID: <CY4PR12MB17682DBE8100F5588C21C1FC95C50@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1519439425-27883-1-git-send-email-babu.moger@amd.com>
	<1519439425-27883-4-git-send-email-babu.moger@amd.com>
	<20180228182420.GC8418@flask>
	<CY4PR12MB1768464C5ABB828EEA45166B95C70@CY4PR12MB1768.namprd12.prod.outlook.com>
	<20180301195715.GA28948@flask>
In-Reply-To: <20180301195715.GA28948@flask>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/i386: Add support for
 CPUID_8000_001E for AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pixo@polepetko.eu" <pixo@polepetko.eu>, "Hook, Gary" <Gary.Hook@amd.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFkaW0gS3LEjW3DocWZ
IFttYWlsdG86cmtyY21hckByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMSwg
MjAxOCAxOjU3IFBNDQo+IFRvOiBNb2dlciwgQmFidSA8QmFidS5Nb2dlckBhbWQuY29tPg0KPiBD
YzogcGJvbnppbmlAcmVkaGF0LmNvbTsgcnRoQHR3aWRkbGUubmV0OyBlaGFia29zdEByZWRoYXQu
Y29tOw0KPiBtdG9zYXR0aUByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IGt2bUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IHBpeG9AcG9sZXBldGtvLmV1OyBIb29rLCBHYXJ5IDxHYXJ5Lkhv
b2tAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIHRhcmdldC9pMzg2OiBB
ZGQgc3VwcG9ydCBmb3IgQ1BVSURfODAwMF8wMDFFDQo+IGZvciBBTUQNCj4gDQo+IDIwMTgtMDIt
MjggMjI6MTgrMDAwMCwgTW9nZXIsIEJhYnU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogUmFkaW0gS3LEjW3DocWZIFttYWlsdG86cmtyY21hckByZWRoYXQu
Y29tXQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyOCwgMjAxOCAxMjoyNCBQTQ0K
PiA+ID4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+ID4gPiBDYzogcGJv
bnppbmlAcmVkaGF0LmNvbTsgcnRoQHR3aWRkbGUubmV0OyBlaGFia29zdEByZWRoYXQuY29tOw0K
PiA+ID4gbXRvc2F0dGlAcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBrdm1Admdl
ci5rZXJuZWwub3JnOw0KPiA+ID4gcGl4b0Bwb2xlcGV0a28uZXU7IEhvb2ssIEdhcnkgPEdhcnku
SG9va0BhbWQuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIHRhcmdldC9p
Mzg2OiBBZGQgc3VwcG9ydCBmb3INCj4gQ1BVSURfODAwMF8wMDFFDQo+ID4gPiBmb3IgQU1EDQo+
ID4gPg0KPiA+ID4gMjAxOC0wMi0yMyAyMTozMC0wNTAwLCBCYWJ1IE1vZ2VyOg0KPiA+ID4gPiBG
cm9tOiBTdGFuaXNsYXYgTGFuY2kgPHBpeG9AcG9sZXBldGtvLmV1Pg0KPiA+ID4gPg0KPiA+ID4g
PiBQb3B1bGF0ZSB0aHJlYWRzL2NvcmVfaWQvYXBpY19pZHMvc29ja2V0X2lkIHdoZW4NCj4gQ1BV
SURfRVhUM19UT1BPRVhUDQo+ID4gPiA+IGZlYXR1cmUgaXMgc3VwcG9ydGVkLiBUaGlzIGlzIHJl
cXVpcmVkIHRvIHN1cHBvcnQgaHlwZXJ0aHJlYWRpbmcNCj4gPiA+ID4gZmVhdHVyZSBvbiBBTUQg
Q1BVUy4gVGhlc2UgYXJlIHN1cHBvcnRlZCB2aWEgQ1BVSURfODAwMF8wMDFFDQo+ID4gPiBleHRl
bmRlZA0KPiA+ID4gPiBmdW5jdGlvbnMuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IFN0YW5pc2xhdiBMYW5jaSA8cGl4b0Bwb2xlcGV0a28uZXU+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICB0YXJnZXQvaTM4Ni9jcHUuYyB8IDggKysrKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9p
Mzg2L2NwdS5jIGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPiA+ID4gaW5kZXggYTVhNDgwZS4uMTkx
ZTg1MCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPiA+ID4gKysr
IGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPiA+ID4gQEAgLTM2NjYsNiArMzY2NiwxNCBAQCB2b2lk
IGNwdV94ODZfY3B1aWQoQ1BVWDg2U3RhdGUgKmVudiwNCj4gPiA+IHVpbnQzMl90IGluZGV4LCB1
aW50MzJfdCBjb3VudCwNCj4gPiA+ID4gICAgICAgICAgICAgICplZHggPSAwOw0KPiA+ID4gPiAg
ICAgICAgICB9DQo+ID4gPiA+ICAgICAgICAgIGJyZWFrOw0KPiA+ID4gPiArICAgIGNhc2UgMHg4
MDAwMDAxRToNCj4gPiA+ID4gKyAgICAgICAgaWYgKGVudi0+ZmVhdHVyZXNbRkVBVF84MDAwXzAw
MDFfRUNYXSAmDQo+IENQVUlEX0VYVDNfVE9QT0VYVCkgew0KPiA+ID4gPiArICAgICAgICAgICAg
KmVheCA9IGNwdS0+YXBpY19pZDsNCj4gPiA+ID4gKyAgICAgICAgICAgICplYnggPSAoY3MtPm5y
X3RocmVhZHMgLSAxKSA8PCA4IHwgY3B1LT5jb3JlX2lkOw0KPiA+ID4NCj4gPiA+IERvIHdlIHNv
bWV3aGVyZSBhc3NlcnQgdGhhdCBBTUQgY2Fubm90IGhhdmUgY3B1LT5jb3JlX2lkID4gMjU1Pw0K
PiA+ID4gKHFlbXUgZG9lcyBhbGxvdyB3ZWlyZCBjb25maWd1cmF0aW9ucy4pDQo+ID4NCj4gPiBJ
IGRvbid0IHNlZSBzcGVjaWZpYyBhc3NlcnQgb24gY29yZV9pZC4gICBCdXQsIEkgc2VlIHRoYXQg
cWVtdSBkb2VzIG5vdCBhbGxvdw0KPiBucl9jb3JlcyBtb3JlIHRoYW4gMjU1Lg0KPiA+IEFsc28g
SSBzZWUgdGhhdCBjb3JlX2lkIGlzIGl0ZXJhdGVkIGJhc2VkIG9uIG5yX2NvcmVzLiAgSWYgeW91
IHN0cm9uZ2x5DQo+IGJlbGlldmUgd2UgbmVlZCB0byBhZGQgYXNzZXJ0IGhlcmUsIEkgd2lsbCBh
ZGQgaXQuDQo+ID4gTGV0IG1lIGtub3cuDQo+IA0KPiBBIHVzZXIgY2FuIGVtdWxhdGUgQU1EIHdp
dGggeDJhcGljIGFuZCBpbnRlbC1pb21tdSB0byBhbGxvdyBtb3JlIHRoYW4NCj4gMjU1IHZjcHVz
IGFuZCBhbGwgb2YgdGhlbSBjYW4gYmUgYSBzZXBhcmF0ZSBjb3JlIChvciBpdHMgb3duIHNvY2tl
dCksDQo+IHdoaWNoIHdvdWxkIG92ZXJmbG93IHRoaXMgKG9yIHRoZSBuZXh0IGNvdW50ZXIpLg0K
PiANCj4gRm9yYmlkZGluZyB0aGF0IGNyYXp5IGNvbmZpZ3VyYXRpb24gbWF5IGJlIHByZWZlcmFi
bGUsIGJ1dCBhbiBhc3NlcnQNCj4gd29uJ3QgaHVydCBub3csDQoNCk9rLiBTdXJlLiBXaWxsIGFk
ZCBhc3NlcnQuDQoNCj4gDQo+IHRoYW5rcy4NCj4gDQo+ID4gPiBUaGFua3MuDQo+ID4gPg0KPiA+
ID4gPiArICAgICAgICAgICAgKmVjeCA9IGNwdS0+c29ja2V0X2lkOw0KPiA+ID4gPiArICAgICAg
ICAgICAgKmVkeCA9IDA7DQo+ID4gPiA+ICsgICAgICAgIH0NCj4gPiA+ID4gKyAgICAgICAgYnJl
YWs7DQo+ID4gPiA+ICAgICAgY2FzZSAweEMwMDAwMDAwOg0KPiA+ID4gPiAgICAgICAgICAqZWF4
ID0gZW52LT5jcHVpZF94bGV2ZWwyOw0KPiA+ID4gPiAgICAgICAgICAqZWJ4ID0gMDsNCj4gPiA+
ID4gLS0NCj4gPiA+ID4gMS44LjMuMQ0KPiA+ID4gPg0KPiANCg0K

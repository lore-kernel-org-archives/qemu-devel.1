Received: from eggs.gnu.org ([2001:4830:134:3::10]:44329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eqXIp-0005rC-5v
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 23:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eqXIm-0007RZ-3D
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 23:55:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:54674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eqXIl-0007PN-PJ
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 23:55:44 -0500
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Date: Tue, 27 Feb 2018 04:55:37 +0000
Message-ID: <ED26CBA2FAD1BF48A8719AEF02201E36514530D8@SHSMSX103.ccr.corp.intel.com>
References: <1517842735-9011-1-git-send-email-jianfeng.tan@intel.com>
	<1b6a1999-95bb-5eac-70e1-39e6ba5b22fc@redhat.com>
	<6716e932-9ce5-3d97-41cb-f33ea94ad4ce@intel.com>
	<502bbdba-0c35-e35a-6600-dfca739d0ea3@redhat.com>
	<20180205181521.47232aa4@redhat.com>
	<5155622d-cc49-d24c-7a7d-24ebb9ca2331@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E36514317E8@SHSMSX103.ccr.corp.intel.com>
	<20180207130635.4033f8b8@redhat.com>
	<8474af94-7bff-a7b5-e316-b8a0e332467e@intel.com>
	<20180208105111.7a776513@redhat.com>
	<53186984-2111-ed5e-0d47-65db12f22ea3@intel.com>
	<20180208123018.5b3c9da7@redhat.com>
	<ED26CBA2FAD1BF48A8719AEF02201E365144EAAB@SHSMSX103.ccr.corp.intel.com>
	<20180226135549.34af5dbf@redhat.com>
	<bfe718ca-3251-a87d-00e7-60a1dfa2da82@redhat.com>
In-Reply-To: <bfe718ca-3251-a87d-00e7-60a1dfa2da82@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC] exec: eliminate ram naming issue as migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjYs
IDIwMTggMTA6NDMgUE0NCj4gVG86IElnb3IgTWFtbWVkb3Y7IFRhbiwgSmlhbmZlbmcNCj4gQ2M6
IEphc29uIFdhbmc7IE1heGltZSBDb3F1ZWxpbjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBNaWNo
YWVsIFMgLg0KPiBUc2lya2luDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1kZXZlbF0gW1JGQ10gZXhl
YzogZWxpbWluYXRlIHJhbSBuYW1pbmcgaXNzdWUgYXMNCj4gbWlncmF0aW9uDQo+IA0KPiBPbiAy
Ni8wMi8yMDE4IDEzOjU1LCBJZ29yIE1hbW1lZG92IHdyb3RlOg0KPiA+Pj4gU28gaG93IGFib3V0
IGp1c3QgYWRkaW5nIGEgbmV3IG9wdGlvbiAtLW1lbS1zaGFyZSB0byBkZWNpZGUgaWYgdGhhdCdz
IGENCj4gPj4+IHByaXZhdGUgbWVtb3J5IG9yIHNoYXJlZCBtZW1vcnk/IFRoYXQgc2VlbXMgbXVj
aCBzdHJhaWdodGZvcndhcmQNCj4gd2F5DQo+ID4gQWJvdmUgb3B0aW9ucyBhcmUgbGVnYWN5ICh3
aGljaCB3ZSBjYW4ndCByZW1vdmUgZm9yIGNvbXBhdCByZWFzb25zKSwNCj4gPiB0aGVpciByZXBs
YWNlbWVudCBpcyAnbWVtb3J5LWJhY2tlbmQtZmlsZScgYmFja2VuZCB3aGljaCBoYXMgYWxsIG9m
DQo+ID4gdGhlIGFib3ZlIGluY2x1ZGluZyAnc2hhcmUnIHByb3BlcnR5Lg0KPiANCj4gTW9yZSBw
cmVjaXNlbHksIHdlIGhhdmUgYWRkZWQgIi1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSIgdG8g
YXZvaWQNCj4gcHJvbGlmZXJhdGlvbiBvZiBvcHRpb25zIHJlbGF0ZWQgdG8gbWVtb3J5LiAgQmVz
aWRlcyB1bmlmeWluZyB0aGUgY2FzZXMNCj4gb2YgMSBhbmQgPjEgTlVNQSBub2RlLCB1c2luZyAt
b2JqZWN0IGFsc28gaGFzIHRoZSBhZHZhbnRhZ2Ugb2YNCj4gc3VwcG9ydGluZyBtZW1vcnkgaG90
cGx1Zy4NCj4gDQo+IFlvdSB3cm90ZSAiSSBmaW5kIGFkZGluZyBhIGJhY2tlbmQgZm9yIG5vbm51
bWEgcGMgUkFNIGlzIHJvdW5kYWJvdXQgd2F5Ig0KPiBidXQgYmFzaWNhbGx5IHRoZSBjb21tYW5k
IGxpbmUgc2F5cyAidGhpcyBWTSBoYXMgb25seSBvbmUgTlVNQSBub2RlLA0KPiBiYWNrZWQgYnkg
dGhpcyBtZW1vcnkgb2JqZWN0IiB3aGljaCBpcyBhIHByZWNpc2UgZGVzY3JpcHRpb24gb2Ygd2hh
dCB0aGUNCj4gVk0gbWVtb3J5IGxvb2tzIGxpa2UuDQo+IA0KPiA+IFNvIGp1c3QgYWRkICdtZW1k
ZXYnIHByb3BlcnR5IHRvIG1hY2hpbmUgYW5kIHJldXNlIG1lbW9yeS1iYWNrZW5kLWZpbGUNCj4g
PiB3aXRoIGl0IGluc3RlYWQgb2YgZHVwbGljYXRpbmcgZnVuY3Rpb25hbGl0eSBpbiB0aGUgbGVn
YWN5IGNvZGUuDQo+IA0KPiBUaGF0IHdvdWxkIGhvd2V2ZXIgYWxzbyBoYXZlIGEgZGlmZmVyZW50
IFJBTUJsb2NrIGlkLCBlZmZlY3RpdmVseQ0KPiBwcm9kdWNpbmcgdGhlIHNhbWUgb3V0cHV0IGFz
ICItbnVtYSBub2RlLG1lbWRldj0uLi4iLg0KDQpJcyBpdCBwb3NzaWJsZSB0aGF0IHdlIGZvcmNl
IHRoYXQgUkFNQmxvY2sgaWQgdG8gYmUgInBjLnJhbSI/DQoNCj4gDQo+IEkgdGhpbmsgdGhpcyBz
aG91bGQgYmUgc29sdmVkIGF0IHRoZSBsaWJ2aXJ0IGxldmVsLiAgTGlidmlydCBzaG91bGQNCj4g
d3JpdGUgaW4gdGhlIG1pZ3JhdGlvbiBYTUwgY29va2llIHdoZXRoZXIgdGhlIFZNIGlzIHVzaW5n
IC1vYmplY3Qgb3INCj4gLW1lbS1wYXRoIHRvIGRlY2xhcmUgaXRzIG1lbW9yeSwgYW5kIG5ld2x5
LXN0YXJ0ZWQgVk1zIHNob3VsZCBhbHdheXMgdXNlDQo+IC1vYmplY3QuICBUaGlzIHdvbid0IGZp
eCB0aGUgcHJvYmxlbSBmb3IgVk1zIHRoYXQgYXJlIGFscmVhZHkgcnVubmluZywNCj4gYnV0IGl0
IHdpbGwgZml4IGl0IHRoZSBuZXh0IHRpbWUgdGhleSBhcmUgc3RhcnRlZC4NCg0KSW4gdGhpcyBj
YXNlLCB3ZSByZXR1cm4gdG8gdGhlIHN0YXJ0IHBvaW50IDotKQ0KDQpUaGFua3MsDQpKaWFuZmVu
Zw0K

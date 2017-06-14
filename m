Received: from eggs.gnu.org ([2001:4830:134:3::10]:44495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLBgb-0003q4-JA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dLBgW-0002sD-OO
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:02:29 -0400
Received: from us-smtp-delivery-101.mimecast.com ([63.128.21.101]:44468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dLBgW-0002rr-F7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 13:02:24 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Wed, 14 Jun 2017 17:02:17 +0000
Message-ID: <F0D8D81A-19F6-4311-95C6-B30B38FCB2BC@nutanix.com>
References: <149745954462.1611.12282014261512444009@4a9a010726c0>
In-Reply-To: <149745954462.1611.12282014261512444009@4a9a010726c0>
Content-Language: en-US
Content-ID: <DF8297DF6995124381EFE4D8DEBAFD20@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] vhost-user: support cross-endianess
 negatiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>
Cc: Mike Cui <cui@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
	Bonzini <pbonzini@redhat.com>

DQo+IE9uIDE0IEp1biAyMDE3LCBhdCAxNzo1OSwgbm8tcmVwbHlAcGF0Y2hldy5vcmcgd3JvdGU6
DQo+IA0KPiBIaSwNCj4gDQo+IFRoaXMgc2VyaWVzIGZhaWxlZCBhdXRvbWF0aWMgYnVpbGQgdGVz
dC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kDQo+IHRoZWlyIG91dHB1dCBi
ZWxvdy4gSWYgeW91IGhhdmUgZG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXBy
b2R1Y2UgaXQNCj4gbG9jYWxseS4NCj4gDQo+IE1lc3NhZ2UtaWQ6IDE0OTc0NTg0ODYtMTU2NzMt
MS1naXQtc2VuZC1lbWFpbC1mZWxpcGVAbnV0YW5peC5jb20NCj4gVHlwZTogc2VyaWVzDQo+IFN1
YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHZob3N0LXVzZXI6IHN1cHBvcnQgY3Jvc3MtZW5k
aWFuZXNzIG5lZ2F0aWF0aW9uDQo+IA0KLi4uDQo+IA0KPiAgQ0MgICAgICBody9wY2ktYnJpZGdl
L3BjaV9leHBhbmRlcl9icmlkZ2Uubw0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L25ldC92bXhuZXQzLmM6MzA6DQo+IC90bXAvcWVtdS10ZXN0L3NyYy9pbmNs
dWRlL21pZ3JhdGlvbi9yZWdpc3Rlci5oOjE4OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mIHR5cGVk
ZWYg4oCYTG9hZFN0YXRlSGFuZGxlcuKAmQ0KPiAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9t
aWdyYXRpb24vdm1zdGF0ZS5oOjMyOiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhM
b2FkU3RhdGVIYW5kbGVy4oCZIHdhcyBoZXJlDQo+IG1ha2U6ICoqKiBbaHcvbmV0L3ZteG5ldDMu
b10gRXJyb3IgMQ0KPiBtYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0K
PiB0ZXN0cy9kb2NrZXIvTWFrZWZpbGUuaW5jbHVkZToxMTg6IHJlY2lwZSBmb3IgdGFyZ2V0ICdk
b2NrZXItcnVuJyBmYWlsZWQNCj4gbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAyDQo+
IG1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
ZW5sM2l4eXIvc3JjJw0KPiB0ZXN0cy9kb2NrZXIvTWFrZWZpbGUuaW5jbHVkZToxNDk6IHJlY2lw
ZSBmb3IgdGFyZ2V0ICdkb2NrZXItcnVuLXRlc3QtYnVpbGRAbWluLWdsaWInIGZhaWxlZA0KPiBt
YWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1idWlsZEBtaW4tZ2xpYl0gRXJyb3IgMg0KPiA9PT0g
T1VUUFVUIEVORCA9PT0NCj4gDQo+IFRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAyDQoN
ClRoYXQgc2VlbXMgY29tcGxldGVseSB1bnJlbGF0ZWQgdG8gd2hhdCBvdXIgcGF0Y2ggdG91Y2hl
ZC4uLiBJJ20gZ29ubmEgZ3Vlc3MgdGhpcyBpcyBhIGtub3duIGlzc3VlIGFuZCBJIGNhbiBzYWZl
bHkgaWdub3JlIGl0Pw0KDQpUaGFua3MsDQpGLg==

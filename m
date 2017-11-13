Received: from eggs.gnu.org ([2001:4830:134:3::10]:45400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.hatayama@jp.fujitsu.com>) id 1eE9Vp-0003zM-Aa
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:50:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.hatayama@jp.fujitsu.com>) id 1eE9Vl-0008Lz-Cr
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:50:33 -0500
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:12435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.hatayama@jp.fujitsu.com>)
	id 1eE9Vk-0008Ki-LI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 02:50:29 -0500
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
	(g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 2321CAC00B0
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 16:50:19 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Date: Mon, 13 Nov 2017 07:50:16 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B1807CB@G01JPEXMBYT03>
References: <20171107162348.16843-1-marcandre.lureau@redhat.com>
In-Reply-To: <20171107162348.16843-1-marcandre.lureau@redhat.com>
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/5] fw_cfg: add DMA operations &
 etc/vmcoreinfo support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>
Cc: "somlo@cmu.edu" <somlo@cmu.edu>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

TWFyYy1BbmRyZSwNCg0KSXQgbG9va3MgdG8gbWUgdGhhdCB0aGUgNHRoIGFu
ZCA1dGggcGF0Y2hlcyBzb21laG93IGhhcyBub3QgYmVlbiBzZW50Lg0KQ291
bGQgeW91IHNlbmQgdGhlbSwgdG9vPw0KSSdkIGxpa2UgdGhlbSB0byBhY3R1
YWxseSBidWlsZCBhbmQgcnVuIHRoZSBrZXJuZWwgZm9yIHRlc3RpbmcuDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgt
a2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxpbnV4
LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBN
YXJjLUFuZHJlIEx1cmVhdQ0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVy
IDgsIDIwMTcgMToyNCBBTQ0KPiBUbzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogc29tbG9AY211LmVkdTsgcWVtdS1kZXZlbEBub25n
bnUub3JnOyBtc3RAcmVkaGF0LmNvbTsgTWFyYy1BbmRyw6kgTHVyZWF1DQo+
IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQ
QVRDSCB2NSAwLzVdIGZ3X2NmZzogYWRkIERNQSBvcGVyYXRpb25zICYgZXRj
L3ZtY29yZWluZm8gc3VwcG9ydA0KPiANCj4gSGksDQo+IA0KPiBUaGlzIHNl
cmllcyBhZGRzIERNQSBvcGVyYXRpb25zIHN1cHBvcnQgdG8gdGhlIHFlbXUg
ZndfY2ZnIGtlcm5lbA0KPiBtb2R1bGUgYW5kIHBvcHVsYXRlcyAiZXRjL3Zt
Y29yZWluZm8iIHdpdGggdm1jb3JlaW5mbyBsb2NhdGlvbg0KPiBkZXRhaWxz
Lg0KPiANCj4gTm90ZTogdGhlIHN1cHBvcnQgZm9yIHRoaXMgZW50cnkgaGFu
ZGxpbmcgaGFzIGJlZW4gbWVyZ2VkIGZvciBuZXh0DQo+IHFlbXUgcmVsZWFz
ZSAoMi4xMSkNCj4gDQo+IHY1Og0KPiAtIHJlc2VudCB0byBDQyBrZHVtcCBw
ZW9wbGUgb24gdGhlIHBhZGRyX3ZtY29yZWluZm9fbm90ZSgpIGV4cG9ydCBw
YXRjaA0KPiANCj4gdjQ6DQo+IC0gZXhwb3J0IHBhZGRyX3ZtY29yZWluZm9f
bm90ZSgpIHRvIGZpeCBmd19jZmcua28gYnVpbGQNCj4gLSBmaXggYnVpbGQg
d2l0aCAhQ09ORklHX0NSQVNIX0NPUkUNCj4gLSByZXBsYWNlIHRoZSB1bmJv
dW5kZWQgeWllbGQoKSBsb29wIHdpdGggYSB1c2xlZXBfcmFuZ2UoKSBsb29w
IGFuZCBhDQo+ICAgMjAwbXMgdGltZW91dA0KPiAtIGRvIG5vdCB3cml0ZSB2
bWNvcmVpbmZvIGVudHJ5IHdoZW4gcnVubmluZyB0aGUga2R1bXAga2VybmVs
IChELiBIYXRheWFtYSkNCj4gLSBkcm9wIHRoZSBleHBlcmltZW50YWwgc3lz
ZnMgd3JpdGUgc3VwcG9ydCBwYXRjaCBmcm9tIHRoaXMgc2VyaWVzDQo+IA0K
PiB2MzogKHRoYW5rcyBrYnVpbGQpDQo+IC0gYWRkICJmd19jZmc6IGZpeCB0
aGUgY29tbWFuZCBsaW5lIG1vZHVsZSBuYW1lIiBwYXRjaA0KPiAtIGZpeCBi
dWlsZCBvZiAiZndfY2ZnOiBhZGQgRE1BIHJlZ2lzdGVyIiB3aXRoIENPTkZJ
R19GV19DRkdfU1lTRlNfQ01ETElORT15DQo+IC0gZml4ICdXc2hpZnQtY291
bnQtb3ZlcmZsb3cnDQo+IA0KPiB2MjoNCj4gLSB1c2UgcGxhdGZvcm0gZGV2
aWNlIGZvciBkbWEgbWFwcGluZw0KPiAtIGFkZCBldGMvdm1jb3JlaW5mbyBw
YXRjaA0KPiAtIHNvbWUgY29kZSBjbGVhbnVwcw0KPiANCj4gTWFyYy1BbmRy
w6kgTHVyZWF1ICg1KToNCj4gICBmd19jZmc6IGZpeCB0aGUgY29tbWFuZCBs
aW5lIG1vZHVsZSBuYW1lDQo+ICAgZndfY2ZnOiBhZGQgRE1BIHJlZ2lzdGVy
DQo+ICAgZndfY2ZnOiBkbyBETUEgcmVhZCBvcGVyYXRpb24NCj4gICBjcmFz
aDogZXhwb3J0IHBhZGRyX3ZtY29yZWluZm9fbm90ZSgpDQo+ICAgZndfY2Zn
OiB3cml0ZSB2bWNvcmVpbmZvIGRldGFpbHMNCj4gDQo+ICBkcml2ZXJzL2Zp
cm13YXJlL3FlbXVfZndfY2ZnLmMgfCAyOTINCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIGtlcm5lbC9jcmFzaF9j
b3JlLmMgICAgICAgICAgICB8ICAgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDI2NCBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCj4gDQo+IC0t
DQo+IDIuMTUuMC4xMjUuZzhmNDk3NjZkNjQNCj4gDQo+IA0KDQo=

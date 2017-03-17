Received: from eggs.gnu.org ([2001:4830:134:3::10]:33042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liqiang6-s@360.cn>) id 1conIS-0003ft-8N
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 04:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liqiang6-s@360.cn>) id 1conIO-0005lD-AS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 04:31:40 -0400
Received: from mtabjsc2.360.cn ([123.125.82.7]:49954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liqiang6-s@360.cn>) id 1conIN-0005k9-Lz
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 04:31:36 -0400
From: =?utf-8?B?5p2O5by6?= <liqiang6-s@360.cn>
Date: Fri, 17 Mar 2017 08:31:28 +0000
Message-ID: <143C0AFC63FC204CB0C55BB88F3A8ABB3336D644@EX02.corp.qihoo.net>
References: <1489735296-19047-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1489735296-19047-1-git-send-email-kraxel@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix off-by-one in
 cirrus_bitblt_rop_bkwd_transp_*_16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1kZXZlbA0KPiBb
bWFpbHRvOnFlbXUtZGV2ZWwtYm91bmNlcytsaXFpYW5nNi1zPTM2MC5jbkBub25nbnUub3JnXSBP
biBCZWhhbGYgT2YNCj4gR2VyZCBIb2ZmbWFubg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE3LCAy
MDE3IDM6MjIgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogR2VyZCBIb2Zm
bWFubg0KPiBTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBjaXJydXM6IGZpeCBvZmYtYnkt
b25lIGluDQo+IGNpcnJ1c19iaXRibHRfcm9wX2Jrd2RfdHJhbnNwXypfMTYNCj4gDQo+IFRoZSBz
d2l0Y2ggZnJvbSBwb2ludGVycyB0byBhZGRyZXNzZXMgKGNvbW1pdA0KPiAwMjZhZWZmY2I0NzUy
MDU0ODMwYmEyMDMwMjBlZDZlYjA1YmNhYmE4IGFuZA0KPiBmZmFmODU3Nzc4Mjg2Y2E1NGUzODA0
NDMyYTIzNjlhMjc5ZTczYWE3KSBhZGRlZCBhIG9mZi1ieS1vbmUgYnVnIHRvDQo+IDE2Yml0IGJh
Y2t3YXJkIGJsaXRzLiAgRml4Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IOadjuW8uiA8bGlxaWFuZzYt
c0AzNjAuY24+DQo+IFNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQu
Y29tPg0KDQpSZXZpZXdlZC1ieTogTGkgUWlhbmcgPGxpcWlhbmc2LXNAMzYwLmNuPg0KDQo+IC0t
LQ0KPiAgaHcvZGlzcGxheS9jaXJydXNfdmdhX3JvcC5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcv
ZGlzcGxheS9jaXJydXNfdmdhX3JvcC5oIGIvaHcvZGlzcGxheS9jaXJydXNfdmdhX3JvcC5oIGlu
ZGV4DQo+IGM2MWE2NzcuLjA4NDFiOWUgMTAwNjQ0DQo+IC0tLSBhL2h3L2Rpc3BsYXkvY2lycnVz
X3ZnYV9yb3AuaA0KPiArKysgYi9ody9kaXNwbGF5L2NpcnJ1c192Z2Ffcm9wLmgNCj4gQEAgLTIx
OSw3ICsyMTksNyBAQCBnbHVlKGdsdWUoY2lycnVzX2JpdGJsdF9yb3BfYmt3ZF90cmFuc3BfLA0K
PiBST1BfTkFNRSksXzE2KShDaXJydXNWR0FTdGF0ZSAqcywNCj4gICAgICBzcmNwaXRjaCArPSBi
bHR3aWR0aDsNCj4gICAgICBmb3IgKHkgPSAwOyB5IDwgYmx0aGVpZ2h0OyB5KyspIHsNCj4gICAg
ICAgICAgZm9yICh4ID0gMDsgeCA8IGJsdHdpZHRoOyB4Kz0yKSB7DQo+IC0gICAgICAgICAgICBS
T1BfT1BfVFJfMTYocywgZHN0YWRkciwgY2lycnVzX3NyYzE2KHMsIHNyY2FkZHIpLCB0cmFuc3Ap
Ow0KPiArICAgICAgICAgICAgUk9QX09QX1RSXzE2KHMsIGRzdGFkZHIgLSAxLCBjaXJydXNfc3Jj
MTYocywgc3JjYWRkciAtIDEpLA0KPiArIHRyYW5zcCk7DQo+ICAgICAgICAgICAgICBkc3RhZGRy
IC09IDI7DQo+ICAgICAgICAgICAgICBzcmNhZGRyIC09IDI7DQo+ICAgICAgICAgIH0NCj4gLS0N
Cj4gMS44LjMuMQ0KPiANCg0K

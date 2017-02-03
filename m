Received: from eggs.gnu.org ([2001:4830:134:3::10]:60924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZlSw-0005dP-DM
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZlSs-0003kq-DH
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:32:22 -0500
Received: from mail1.bemta8.messagelabs.com ([216.82.243.198]:10329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ketan.Nilangekar@veritas.com>)
	id 1cZlSs-0003kB-8c
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:32:18 -0500
From: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Date: Fri, 3 Feb 2017 21:32:11 +0000
Message-ID: <75317A00-6AB8-4890-905B-D6A93BEFFD0F@veritas.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
	<20170202100728.GA20760@stefanha-x1.localdomain>
	<20170202101537.GE2915@redhat.com>
	<49FDD34F-2649-4437-AC4F-4C1C91FEA15C@veritas.com>
	<231FC4E3-0EEB-4BD5-A541-1ABFAB592EEC@veritas.com>
	<20170203094509.GB10350@redhat.com>
In-Reply-To: <20170203094509.GB10350@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E1584A0D6A7D244B730A234EC9BD049@veritas.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 RFC] block/vxhs: Initial commit to add
 Veritas HyperScale VxHS block device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, ashish mittal <ashmit602@gmail.com>, Paolo
	Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

DQoNCk9uIDIvMy8xNywgMTo0NSBBTSwgIkRhbmllbCBQLiBCZXJyYW5nZSIgPGJlcnJhbmdlQHJl
ZGhhdC5jb20+IHdyb3RlOg0KDQogICAgT24gVGh1LCBGZWIgMDIsIDIwMTcgYXQgMDk6MjI6NDZQ
TSArMDAwMCwgS2V0YW4gTmlsYW5nZWthciB3cm90ZToNCiAgICA+IA0KICAgID4gT24gMi8yLzE3
LCAxMjo1NyBQTSwgIktldGFuIE5pbGFuZ2VrYXIiIDxLZXRhbi5OaWxhbmdla2FyQHZlcml0YXMu
Y29tPiB3cm90ZToNCiAgICA+ICAgICAgICAgDQogICAgPiAgICAgW0tldGFuXQ0KICAgID4gICAg
IERvZXMgdGhlIFFJTyBpbnRlcmZhY2UgYWxsb3cgZm9yIHJlYWR2L3dyaXRldiBvdmVyIG5ldHdv
cmsgZm9yIHVuc2VjdXJlIHNvY2tldHM/DQogICAgPiAgICAgDQogICAgPiBbS2V0YW5dDQogICAg
PiBJIGNoZWNrZWQgdGhlIHFpbyBpbXBsZW1lbnRhdGlvbiBhbmQgaXQgc2VlbXMgdGhhdCB0aGVy
ZSBpcyBhIHBzZXVkbw0KICAgID4gaW1wbGVtZW50YXRpb24gb2YgcmVhZHYvd3JpdGV2IHdoaWNo
IGl0ZXJhdGVzIG92ZXIgdGhlIGluZGl2aWR1YWwNCiAgICA+IGlvdmVjcyB0byBtYWtlIHNlbmQv
cmVjdiBzeXNjYWxscy4gVGhpcyBjYW7igJl0IGJlIHRvbyBnb29kIGZvciBwZXJmb3JtYW5jZS4N
CiAgICANCiAgICBJIHRoaW5rIHlvdSBsb29rZWQgYXQgdGhlIFdpbjMyIGNvZGUgLSB0aGUgcWlv
X2NoYW5uZWxfc29ja2V0X3dyaXRldg0KICAgIGFuZCBxaW9fY2hhbm5lbF9zb2NrZXRfcmVhZHYg
bWV0aG9kcyB3aGljaCBhcmUgYnVpbHQgb24gbm9uLVdpbjMyDQogICAgcGxhdGZvcm1zIHVzZSBy
ZWN2bXNnL3NlbmRtc2cgdG8gaGFuZGxlIGlvdmVjcyBpbiBhIHNpbmdsZSBvcGVyYXRpb24uDQoN
CltLZXRhbl0NCk9rIEkgc2VlIHRoYXQuDQogICAgDQogICAgPiBBcmUgeW91IHN1Z2dlc3Rpbmcg
d2UgdXNlIHRoZSBxaW8gaW50ZXJmYWNlIGZvciBzZWN1cmUgY29tbXVuaWNhdGlvbiBvbmx5DQog
ICAgPiBhbmQgbGVhdmUgdGhlIHVuc2VjdXJlIGNvbW11bmljYXRpb24gdG8gbGlicW5pbz8NCiAg
ICANCiAgICBJZiB5b3UgZXhwZWN0IG5vbi1RRU1VIGFwcHMgdG8gdXNlIGxpYnFuaW8sIHRoZW4g
eW91IGNvdWxkIGtlZXAgc3VwcG9ydA0KICAgIGZvciBwbGFpbiAmIFRMUyBzb2NrZXRzIGluIGxp
YnFuaW8uIEp1c3QgcHJvdmlkZSB0aGUgSS9PIGNhbGxiYWNrcyBmYWNpbGl0eQ0KICAgIGFzIGFu
IGFsdGVybmF0aXZlIGFwcHJvYWNoIHdoaWNoIGNhbiBiZSB1c2VkIGJ5IFFFTVUgZm9yIHNlY3Vy
ZSAmIGluc2VjdXJlDQogICAgSS9PIGhhbmRsaW5nLg0KDQpbS2V0YW5dDQpXZSBkbyBleHBlY3Qg
bm9uLXFlbXUgYXBwbGljYXRpb25zIHRvIHVzZSBsaWJxbmlvLiANCkhvd2V2ZXIsIGlmIHRoaXMg
aXMgYSAibmljZSB0byBoYXZlIiBmcm9tIFFFTVUgcGVyc3BlY3RpdmUsIEknZCBsaWtlIHRvIHRh
a2UgdGhpcyB1cCBsYXRlci4NCg0KDQpSZWdhcmRzLA0KICAgIERhbmllbA0KICAgIC0tIA0KICAg
IHw6IGh0dHA6Ly9iZXJyYW5nZS5jb20gICAgICAtby0gICAgaHR0cDovL3d3dy5mbGlja3IuY29t
L3Bob3Rvcy9kYmVycmFuZ2UvIDp8DQogICAgfDogaHR0cDovL2xpYnZpcnQub3JnICAgICAgICAg
ICAgICAtby0gICAgICAgICAgICAgaHR0cDovL3ZpcnQtbWFuYWdlci5vcmcgOnwNCiAgICB8OiBo
dHRwOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgICAgIC1vLSAgICBodHRwOi8vc2VhcmNoLmNwYW4u
b3JnL35kYW5iZXJyLyA6fA0KICAgIA0KDQo=

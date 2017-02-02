Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZOqE-00026H-Gq
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 16:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZOqA-00078o-3t
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 16:22:54 -0500
Received: from mail1.bemta8.messagelabs.com ([216.82.243.194]:17783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ketan.Nilangekar@veritas.com>)
	id 1cZOq9-00078H-UB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 16:22:50 -0500
From: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Date: Thu, 2 Feb 2017 21:22:46 +0000
Message-ID: <231FC4E3-0EEB-4BD5-A541-1ABFAB592EEC@veritas.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
	<20170202100728.GA20760@stefanha-x1.localdomain>
	<20170202101537.GE2915@redhat.com>
	<49FDD34F-2649-4437-AC4F-4C1C91FEA15C@veritas.com>
In-Reply-To: <49FDD34F-2649-4437-AC4F-4C1C91FEA15C@veritas.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A02D1DE7738BEF40B8FF8FC88CE1D1FF@veritas.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Buddhi Madhav <Buddhi.Madhav@veritas.com>, ashish mittal <ashmit602@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

DQpPbiAyLzIvMTcsIDEyOjU3IFBNLCAiS2V0YW4gTmlsYW5nZWthciIgPEtldGFuLk5pbGFuZ2Vr
YXJAdmVyaXRhcy5jb20+IHdyb3RlOg0KDQogICAgDQogICAgDQogICAgT24gMi8yLzE3LCAyOjE1
IEFNLCAiRGFuaWVsIFAuIEJlcnJhbmdlIiA8YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQog
ICAgDQogICAgICAgIE9uIFRodSwgRmViIDAyLCAyMDE3IGF0IDEwOjA3OjI4QU0gKzAwMDAsIFN0
ZWZhbiBIYWpub2N6aSB3cm90ZToNCiAgICAgICAgPiBPbiBXZWQsIEZlYiAwMSwgMjAxNyBhdCAx
MTo1OTo1M1BNICswMDAwLCBLZXRhbiBOaWxhbmdla2FyIHdyb3RlOg0KICAgICAgICA+ID4gUGF0
Y2ggZm9yIHNlY3VyZSBpbXBsZW1lbnRhdGlvbiBpbiBsaWJxbmlvIGlzIGF2YWlsYWJsZSBmb3Ig
cmV2aWV3IGhlcmU6DQogICAgICAgID4gPiANCiAgICAgICAgPiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9WZXJpdGFzSHlwZXJTY2FsZS9saWJxbmlvL3B1bGwvMTINCiAgICAgICAgPiA+IA0KICAgICAg
ICA+ID4gbGlicW5pbyBjbGllbnQgaW5pdGlhbGl6YXRpb24gbm93IGhhcyBhbiBvcHRpb24gdG8g
dXNlIFguNTA5IGNlcnRpZmljYXRlcyB0byBhdXRoZW50aWNhdGUgaXRzZWxmIHRvIHRoZSB2eGhz
IHNlcnZlci4gIA0KICAgICAgICA+ID4gQWxzbyBlYWNoIGNsaWVudCBJTyByZXF1ZXN0IG5vdyBp
bmNsdWRlcyBhbiBpbnN0YW5jZSBpZCB0aGF0IGlzIHVzZWQgYnkgdGhlIHZ4aHMgc2VydmVyIHRv
IGF1dGhvcml6ZSB0aGUgcmVxdWVzdC4NCiAgICAgICAgPiA+IEEgdGVzdCBjbGllbnQgaGFzIGFs
c28gYmVlbiBhZGRlZC4NCiAgICAgICAgPiA+IExpYnFuaW8uc28gc28gaXMgcmVuYW1lZCB0byBs
aWJ2eGhzLnNvLiBXZSB3aWxsIHJlbmFtZSB0aGUgcmVwb3NpdG9yeSBvbmNlIHRoZSBsYXRlc3Qg
cGF0Y2hlcyBhcmUgbWVyZ2VkLg0KICAgICAgICA+ID4gUUVNVSBwYXRjaCB0byB1c2UgdGhlIG5l
dyBzZWN1cmUgaW50ZXJmYWNlIHdpbGwgZm9sbG93IHNob3J0bHkuDQogICAgICAgID4gDQogICAg
ICAgID4gSSBoYXZlIGxlZnQgY29tbWVudHMgb24gc3BlY2lmaWMgbGluZXMgb2YgY29kZSBvbiBH
aXRIdWIuDQogICAgICAgID4gDQogICAgICAgID4gVGhlIHNlcnZlciBzaG91bGQgZG8gc29tZXRo
aW5nIGJhc2VkIG9uIHRoZSBjbGllbnQgWC41MDkgY2VydGlmaWNhdGUuDQogICAgICAgID4gSXMg
dGhlIGNvZGUgYWN0dWFsbHkgdmVyaWZ5aW5nIGNlcnRpZmljYXRlcyBvbiB0aGUgY2xpZW50IHNp
ZGU/DQogICAgICAgID4gDQogICAgICAgID4gUmlnaHQgbm93IHRoZSBjb2RlIGlzIGp1c3QgZ29p
bmcgdGhyb3VnaCB0aGUgbW90aW9ucyBvZiBTU0wgYnV0IG5vdA0KICAgICAgICA+IHByb3RlY3Rp
bmcgYWdhaW5zdCBtYW4taW4tdGhlLW1pZGRsZSBhdHRhY2tzLg0KICAgICAgICA+IA0KICAgICAg
ICA+IEkgbm90aWNlZCB0aGF0IHRoZSBjb2RlIHVzZXMgT3BlblNTTC4gIFFFTVUgdXNlcyBHbnVU
TFMgaW5zdGVhZCBvZg0KICAgICAgICA+IE9wZW5TU0wuICBJbiBwcmFjdGljZSBpdCdzIGhhcmQg
dG8gYXZvaWQgZHVwbGljYXRpb24gb2YgU1NMIGxpYnJhcmllczoNCiAgICAgICAgPiBHbHVzdGVy
RlMgYW5kIENlcGggdXNlIE9wZW5TU0wgYW5kIE5TUy4gIFRoYXQgbWVhbnMgUUVNVSBLVk0gbWF5
IGRyYWcgaW4NCiAgICAgICAgPiBHbnVUTFMsIE9wZW5TU0wsIGFuZCBOU1MhICBCdXQgZnJvbSBh
IFFFTVUgcG9pbnQgb2YgdmlldyBpdCB3b3VsZCBiZQ0KICAgICAgICA+IG5pY2VzdCB0byB1c2Ug
R251VExTIHRvIGtlZXAgZXh0cmEgbGlicmFyeSBkZXBlbmRlbmNpZXMgbWluaW1hbC4NCiAgICAg
ICAgDQogICAgICAgIFRoZXNlIHBvaW50cyBhcmUgYWxsIHJlYXNvbnMgd2h5IGxpYnFuaW8gc2hv
dWxkIG5vdCBkbyBhbnl0aGluZyBUTFMNCiAgICAgICAgcmVsYXRlZCBhdCBhbGwuIEl0IHNob3Vs
ZCBkZWxlZ2F0ZSBhbGwgYWN0dWFsIEkvTyB0byBRRU1VLCBzbyB0aGF0IHdlDQogICAgICAgIGNh
biB1c2Ugb3VyIGV4aXN0aW5nIFFJTyBsb2dpYyBmb3IgVExTIHRoYXQgaXMgdHJpZWQgJiB0ZXN0
ZWQsIGFzIHdlbGwNCiAgICAgICAgYXMgaW50ZWdyYXRpbmcgd2l0aCBleGlzdGluZyBRRU1VIGlu
ZnJhc3RydWN0dXJlLiBpZSwgYWJpbGl0eSB0byB1c2UNCiAgICAgICAgb2JqZWN0X2FkZCBRTVAg
Y29tbWFuZCB0byByZWdpc3RlciBUTFMgY2VydGlmaWNhdGVzIHdpdGggUUVNVSwgaW5zdGVhZA0K
ICAgICAgICBvZiBoYXJkY29kaW5nIHRoZWlyIGxvY2F0aW9uIG9uIGRpc2sgaW4gbGlicW5pbw0K
ICAgICAgICANCiAgICBbS2V0YW5dDQogICAgRG9lcyB0aGUgUUlPIGludGVyZmFjZSBhbGxvdyBm
b3IgcmVhZHYvd3JpdGV2IG92ZXIgbmV0d29yayBmb3IgdW5zZWN1cmUgc29ja2V0cz8NCiAgICAN
CltLZXRhbl0NCkkgY2hlY2tlZCB0aGUgcWlvIGltcGxlbWVudGF0aW9uIGFuZCBpdCBzZWVtcyB0
aGF0IHRoZXJlIGlzIGEgcHNldWRvIGltcGxlbWVudGF0aW9uIG9mIHJlYWR2L3dyaXRldiB3aGlj
aCBpdGVyYXRlcyBvdmVyIHRoZSBpbmRpdmlkdWFsIGlvdmVjcyB0byBtYWtlIHNlbmQvcmVjdiBz
eXNjYWxscy4gVGhpcyBjYW7igJl0IGJlIHRvbyBnb29kIGZvciBwZXJmb3JtYW5jZS4NCkFyZSB5
b3Ugc3VnZ2VzdGluZyB3ZSB1c2UgdGhlIHFpbyBpbnRlcmZhY2UgZm9yIHNlY3VyZSBjb21tdW5p
Y2F0aW9uIG9ubHkgYW5kIGxlYXZlIHRoZSB1bnNlY3VyZSBjb21tdW5pY2F0aW9uIHRvIGxpYnFu
aW8/DQoNClJlZ2FyZHMsDQogICAgICAgIERhbmllbA0KICAgICAgICAtLSANCiAgICAgICAgfDog
aHR0cDovL2JlcnJhbmdlLmNvbSAgICAgIC1vLSAgICBodHRwOi8vd3d3LmZsaWNrci5jb20vcGhv
dG9zL2RiZXJyYW5nZS8gOnwNCiAgICAgICAgfDogaHR0cDovL2xpYnZpcnQub3JnICAgICAgICAg
ICAgICAtby0gICAgICAgICAgICAgaHR0cDovL3ZpcnQtbWFuYWdlci5vcmcgOnwNCiAgICAgICAg
fDogaHR0cDovL2VudGFuZ2xlLXBob3RvLm9yZyAgICAgICAtby0gICAgaHR0cDovL3NlYXJjaC5j
cGFuLm9yZy9+ZGFuYmVyci8gOnwNCiAgICAgICAgDQogICAgDQogICAgDQoNCg==

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZORR-0001zY-V3
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZORP-0005gL-A2
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:57:18 -0500
Received: from mail1.bemta12.messagelabs.com ([216.82.251.16]:19646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ketan.Nilangekar@veritas.com>)
	id 1cZORO-0005g5-VU
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:57:15 -0500
From: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Date: Thu, 2 Feb 2017 20:57:11 +0000
Message-ID: <49FDD34F-2649-4437-AC4F-4C1C91FEA15C@veritas.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
	<20170202100728.GA20760@stefanha-x1.localdomain>
	<20170202101537.GE2915@redhat.com>
In-Reply-To: <20170202101537.GE2915@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <632A1C3A11A10C4B9850ABAE63996266@veritas.com>
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

DQoNCk9uIDIvMi8xNywgMjoxNSBBTSwgIkRhbmllbCBQLiBCZXJyYW5nZSIgPGJlcnJhbmdlQHJl
ZGhhdC5jb20+IHdyb3RlOg0KDQogICAgT24gVGh1LCBGZWIgMDIsIDIwMTcgYXQgMTA6MDc6MjhB
TSArMDAwMCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KICAgID4gT24gV2VkLCBGZWIgMDEsIDIw
MTcgYXQgMTE6NTk6NTNQTSArMDAwMCwgS2V0YW4gTmlsYW5nZWthciB3cm90ZToNCiAgICA+ID4g
UGF0Y2ggZm9yIHNlY3VyZSBpbXBsZW1lbnRhdGlvbiBpbiBsaWJxbmlvIGlzIGF2YWlsYWJsZSBm
b3IgcmV2aWV3IGhlcmU6DQogICAgPiA+IA0KICAgID4gPiBodHRwczovL2dpdGh1Yi5jb20vVmVy
aXRhc0h5cGVyU2NhbGUvbGlicW5pby9wdWxsLzEyDQogICAgPiA+IA0KICAgID4gPiBsaWJxbmlv
IGNsaWVudCBpbml0aWFsaXphdGlvbiBub3cgaGFzIGFuIG9wdGlvbiB0byB1c2UgWC41MDkgY2Vy
dGlmaWNhdGVzIHRvIGF1dGhlbnRpY2F0ZSBpdHNlbGYgdG8gdGhlIHZ4aHMgc2VydmVyLiAgDQog
ICAgPiA+IEFsc28gZWFjaCBjbGllbnQgSU8gcmVxdWVzdCBub3cgaW5jbHVkZXMgYW4gaW5zdGFu
Y2UgaWQgdGhhdCBpcyB1c2VkIGJ5IHRoZSB2eGhzIHNlcnZlciB0byBhdXRob3JpemUgdGhlIHJl
cXVlc3QuDQogICAgPiA+IEEgdGVzdCBjbGllbnQgaGFzIGFsc28gYmVlbiBhZGRlZC4NCiAgICA+
ID4gTGlicW5pby5zbyBzbyBpcyByZW5hbWVkIHRvIGxpYnZ4aHMuc28uIFdlIHdpbGwgcmVuYW1l
IHRoZSByZXBvc2l0b3J5IG9uY2UgdGhlIGxhdGVzdCBwYXRjaGVzIGFyZSBtZXJnZWQuDQogICAg
PiA+IFFFTVUgcGF0Y2ggdG8gdXNlIHRoZSBuZXcgc2VjdXJlIGludGVyZmFjZSB3aWxsIGZvbGxv
dyBzaG9ydGx5Lg0KICAgID4gDQogICAgPiBJIGhhdmUgbGVmdCBjb21tZW50cyBvbiBzcGVjaWZp
YyBsaW5lcyBvZiBjb2RlIG9uIEdpdEh1Yi4NCiAgICA+IA0KICAgID4gVGhlIHNlcnZlciBzaG91
bGQgZG8gc29tZXRoaW5nIGJhc2VkIG9uIHRoZSBjbGllbnQgWC41MDkgY2VydGlmaWNhdGUuDQog
ICAgPiBJcyB0aGUgY29kZSBhY3R1YWxseSB2ZXJpZnlpbmcgY2VydGlmaWNhdGVzIG9uIHRoZSBj
bGllbnQgc2lkZT8NCiAgICA+IA0KICAgID4gUmlnaHQgbm93IHRoZSBjb2RlIGlzIGp1c3QgZ29p
bmcgdGhyb3VnaCB0aGUgbW90aW9ucyBvZiBTU0wgYnV0IG5vdA0KICAgID4gcHJvdGVjdGluZyBh
Z2FpbnN0IG1hbi1pbi10aGUtbWlkZGxlIGF0dGFja3MuDQogICAgPiANCiAgICA+IEkgbm90aWNl
ZCB0aGF0IHRoZSBjb2RlIHVzZXMgT3BlblNTTC4gIFFFTVUgdXNlcyBHbnVUTFMgaW5zdGVhZCBv
Zg0KICAgID4gT3BlblNTTC4gIEluIHByYWN0aWNlIGl0J3MgaGFyZCB0byBhdm9pZCBkdXBsaWNh
dGlvbiBvZiBTU0wgbGlicmFyaWVzOg0KICAgID4gR2x1c3RlckZTIGFuZCBDZXBoIHVzZSBPcGVu
U1NMIGFuZCBOU1MuICBUaGF0IG1lYW5zIFFFTVUgS1ZNIG1heSBkcmFnIGluDQogICAgPiBHbnVU
TFMsIE9wZW5TU0wsIGFuZCBOU1MhICBCdXQgZnJvbSBhIFFFTVUgcG9pbnQgb2YgdmlldyBpdCB3
b3VsZCBiZQ0KICAgID4gbmljZXN0IHRvIHVzZSBHbnVUTFMgdG8ga2VlcCBleHRyYSBsaWJyYXJ5
IGRlcGVuZGVuY2llcyBtaW5pbWFsLg0KICAgIA0KICAgIFRoZXNlIHBvaW50cyBhcmUgYWxsIHJl
YXNvbnMgd2h5IGxpYnFuaW8gc2hvdWxkIG5vdCBkbyBhbnl0aGluZyBUTFMNCiAgICByZWxhdGVk
IGF0IGFsbC4gSXQgc2hvdWxkIGRlbGVnYXRlIGFsbCBhY3R1YWwgSS9PIHRvIFFFTVUsIHNvIHRo
YXQgd2UNCiAgICBjYW4gdXNlIG91ciBleGlzdGluZyBRSU8gbG9naWMgZm9yIFRMUyB0aGF0IGlz
IHRyaWVkICYgdGVzdGVkLCBhcyB3ZWxsDQogICAgYXMgaW50ZWdyYXRpbmcgd2l0aCBleGlzdGlu
ZyBRRU1VIGluZnJhc3RydWN0dXJlLiBpZSwgYWJpbGl0eSB0byB1c2UNCiAgICBvYmplY3RfYWRk
IFFNUCBjb21tYW5kIHRvIHJlZ2lzdGVyIFRMUyBjZXJ0aWZpY2F0ZXMgd2l0aCBRRU1VLCBpbnN0
ZWFkDQogICAgb2YgaGFyZGNvZGluZyB0aGVpciBsb2NhdGlvbiBvbiBkaXNrIGluIGxpYnFuaW8N
CiAgICANCltLZXRhbl0NCkRvZXMgdGhlIFFJTyBpbnRlcmZhY2UgYWxsb3cgZm9yIHJlYWR2L3dy
aXRldiBvdmVyIG5ldHdvcmsgZm9yIHVuc2VjdXJlIHNvY2tldHM/DQoNCiAgICBSZWdhcmRzLA0K
ICAgIERhbmllbA0KICAgIC0tIA0KICAgIHw6IGh0dHA6Ly9iZXJyYW5nZS5jb20gICAgICAtby0g
ICAgaHR0cDovL3d3dy5mbGlja3IuY29tL3Bob3Rvcy9kYmVycmFuZ2UvIDp8DQogICAgfDogaHR0
cDovL2xpYnZpcnQub3JnICAgICAgICAgICAgICAtby0gICAgICAgICAgICAgaHR0cDovL3ZpcnQt
bWFuYWdlci5vcmcgOnwNCiAgICB8OiBodHRwOi8vZW50YW5nbGUtcGhvdG8ub3JnICAgICAgIC1v
LSAgICBodHRwOi8vc2VhcmNoLmNwYW4ub3JnL35kYW5iZXJyLyA6fA0KICAgIA0KDQo=

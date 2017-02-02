Received: from eggs.gnu.org ([2001:4830:134:3::10]:45566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZONS-0008Gi-5d
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cZONP-0004eM-Ge
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:53:10 -0500
Received: from mail1.bemta12.messagelabs.com ([216.82.251.1]:30462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ketan.Nilangekar@veritas.com>)
	id 1cZONP-0004dV-88
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:53:07 -0500
From: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Date: Thu, 2 Feb 2017 20:53:02 +0000
Message-ID: <0DBDB9EF-15E3-42F0-95EA-5890B5CA393B@veritas.com>
References: <CAAo6VWMJAYeLdtEmyQ43vYeYjvNzCP80Wufe4=eNRUZum0rYdQ@mail.gmail.com>
	<CAJSP0QV7QCLwih+F30hcohmwYQ1Ci+6bMPuCj_Kk9hwbmgWzUA@mail.gmail.com>
	<E05FEFD5-A72D-4FC5-B600-58AAD2900A02@veritas.com>
	<CAJSP0QUWmU_XbB9TGxvL0hH-SCzRSWDciNhpZrarDDcE22RF_w@mail.gmail.com>
	<D1304CAA-9C32-4E42-AA65-27B3277130E8@veritas.com>
	<20170202100728.GA20760@stefanha-x1.localdomain>
In-Reply-To: <20170202100728.GA20760@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4252B0809B0A44A81510847FE379D2B@veritas.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Buddhi Madhav <Buddhi.Madhav@veritas.com>, ashish mittal <ashmit602@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
	Berrange" <berrange@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Gaurav Bhandarkar <Gaurav.Bhandarkar@veritas.com>, Abhishek Kane <Abhishek.Kane@veritas.com>, Ketan Mahajan <Ketan.Mahajan@veritas.com>, Niranjan Pendharkar <Niranjan.Pendharkar@veritas.com>, Nirendra Awasthi <Nirendra.Awasthi@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

DQoNCk9uIDIvMi8xNywgMjowNyBBTSwgIlN0ZWZhbiBIYWpub2N6aSIgPHN0ZWZhbmhhQGdtYWls
LmNvbT4gd3JvdGU6DQoNCiAgICBPbiBXZWQsIEZlYiAwMSwgMjAxNyBhdCAxMTo1OTo1M1BNICsw
MDAwLCBLZXRhbiBOaWxhbmdla2FyIHdyb3RlOg0KICAgID4gUGF0Y2ggZm9yIHNlY3VyZSBpbXBs
ZW1lbnRhdGlvbiBpbiBsaWJxbmlvIGlzIGF2YWlsYWJsZSBmb3IgcmV2aWV3IGhlcmU6DQogICAg
PiANCiAgICA+IGh0dHBzOi8vZ2l0aHViLmNvbS9WZXJpdGFzSHlwZXJTY2FsZS9saWJxbmlvL3B1
bGwvMTINCiAgICA+IA0KICAgID4gbGlicW5pbyBjbGllbnQgaW5pdGlhbGl6YXRpb24gbm93IGhh
cyBhbiBvcHRpb24gdG8gdXNlIFguNTA5IGNlcnRpZmljYXRlcyB0byBhdXRoZW50aWNhdGUgaXRz
ZWxmIHRvIHRoZSB2eGhzIHNlcnZlci4gIA0KICAgID4gQWxzbyBlYWNoIGNsaWVudCBJTyByZXF1
ZXN0IG5vdyBpbmNsdWRlcyBhbiBpbnN0YW5jZSBpZCB0aGF0IGlzIHVzZWQgYnkgdGhlIHZ4aHMg
c2VydmVyIHRvIGF1dGhvcml6ZSB0aGUgcmVxdWVzdC4NCiAgICA+IEEgdGVzdCBjbGllbnQgaGFz
IGFsc28gYmVlbiBhZGRlZC4NCiAgICA+IExpYnFuaW8uc28gc28gaXMgcmVuYW1lZCB0byBsaWJ2
eGhzLnNvLiBXZSB3aWxsIHJlbmFtZSB0aGUgcmVwb3NpdG9yeSBvbmNlIHRoZSBsYXRlc3QgcGF0
Y2hlcyBhcmUgbWVyZ2VkLg0KICAgID4gUUVNVSBwYXRjaCB0byB1c2UgdGhlIG5ldyBzZWN1cmUg
aW50ZXJmYWNlIHdpbGwgZm9sbG93IHNob3J0bHkuDQogICAgDQogICAgSSBoYXZlIGxlZnQgY29t
bWVudHMgb24gc3BlY2lmaWMgbGluZXMgb2YgY29kZSBvbiBHaXRIdWIuDQogICAgDQpbS2V0YW5d
IA0KSSBoYXZlIHJlcGxpZWQgdG8geW91ciBjb21tZW50cyBhbmQgd2lsbCBiZSB1cGxvYWRpbmcg
YSBwYXRjaCBzaG9ydGx5IHRvIGNvdmVyIHNvbWUgZml4ZXMuDQoNCiAgICBUaGUgc2VydmVyIHNo
b3VsZCBkbyBzb21ldGhpbmcgYmFzZWQgb24gdGhlIGNsaWVudCBYLjUwOSBjZXJ0aWZpY2F0ZS4N
CiAgICBJcyB0aGUgY29kZSBhY3R1YWxseSB2ZXJpZnlpbmcgY2VydGlmaWNhdGVzIG9uIHRoZSBj
bGllbnQgc2lkZT8NCg0KICAgIFJpZ2h0IG5vdyB0aGUgY29kZSBpcyBqdXN0IGdvaW5nIHRocm91
Z2ggdGhlIG1vdGlvbnMgb2YgU1NMIGJ1dCBub3QNCiAgICBwcm90ZWN0aW5nIGFnYWluc3QgbWFu
LWluLXRoZS1taWRkbGUgYXR0YWNrcy4NCg0KW0tldGFuXQ0KVGhlIFZ4SFMgc2VydmVyIGltcGxl
bWVudGF0aW9uIHdpbGwgYmUgdmVyaWZ5aW5nIHRoZSBjbGllbnQgY2VydGlmaWNhdGVzLg0KVGhl
IGxpYnFuaW8gc2VydmVyIGltcGxlbWVudGF0aW9uIGlzIGp1c3QgYSBzYW1wbGUgdG8gdmVyaWZ5
IHRoZSBjbGllbnQgZnVuY3Rpb25hbGl0eS4NClZ4SFMgZG9lcyBub3QgdXNlIHRoZSBsaWJxbmlv
IHNlcnZlciBpbXBsZW1lbnRhdGlvbi4NCiAgICANCiAgICBJIG5vdGljZWQgdGhhdCB0aGUgY29k
ZSB1c2VzIE9wZW5TU0wuICBRRU1VIHVzZXMgR251VExTIGluc3RlYWQgb2YNCiAgICBPcGVuU1NM
LiAgSW4gcHJhY3RpY2UgaXQncyBoYXJkIHRvIGF2b2lkIGR1cGxpY2F0aW9uIG9mIFNTTCBsaWJy
YXJpZXM6DQogICAgR2x1c3RlckZTIGFuZCBDZXBoIHVzZSBPcGVuU1NMIGFuZCBOU1MuICBUaGF0
IG1lYW5zIFFFTVUgS1ZNIG1heSBkcmFnIGluDQogICAgR251VExTLCBPcGVuU1NMLCBhbmQgTlNT
ISAgQnV0IGZyb20gYSBRRU1VIHBvaW50IG9mIHZpZXcgaXQgd291bGQgYmUNCiAgICBuaWNlc3Qg
dG8gdXNlIEdudVRMUyB0byBrZWVwIGV4dHJhIGxpYnJhcnkgZGVwZW5kZW5jaWVzIG1pbmltYWwu
DQoNCltLZXRhbl0NCklmIEdsdXN0ZXJGUyBpcyBhbHJlYWR5IHVzaW5nIE9wZW5TU0wgdGhlbiBs
aWJxbmlvIGlzIG5vdCBpbnRyb2R1Y2luZyBhbnl0aGluZyBuZXcgaGVyZS4NCkZyb20gYSBsaWNl
bnNpbmcgcGVyc3BlY3RpdmUgdGhlcmUgc2VlbXMgdG8gYmUgYSB3YXkgb2YgYWRkaW5nIGEg4oCc
R1BMIGxpbmtpbmcgZXhjZXB0aW9u4oCdIGluIHRoaXMgY2FzZS4NCg0KDQoNCg==

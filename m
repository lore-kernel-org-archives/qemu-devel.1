Received: from eggs.gnu.org ([2001:4830:134:3::10]:34900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cgE8P-0001kr-QM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:21:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cgE8M-00045C-KY
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:21:53 -0500
Received: from mail1.bemta8.messagelabs.com ([216.82.243.200]:35387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ketan.Nilangekar@veritas.com>)
	id 1cgE8M-00044Y-Eq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:21:50 -0500
From: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Date: Tue, 21 Feb 2017 17:21:46 +0000
Message-ID: <A228B0EC-4D64-4174-A4FD-B3E00B836FD1@veritas.com>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
	<F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
	<20170220110235.GD21255@stefanha-x1.localdomain>
	<CAAo6VWNwHbsQRxU18dNCjWaNfNrZNAV9FfOKW8=JeZCND2vHnQ@mail.gmail.com>
	<20170221105918.GA22731@stefanha-x1.localdomain>
In-Reply-To: <20170221105918.GA22731@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA89379976035B44AC581088584E34DB@veritas.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, ashish mittal <ashmit602@gmail.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo
	Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus
	Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, John
	Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

DQoNCk9uIDIvMjEvMTcsIDU6NTkgQU0sICJTdGVmYW4gSGFqbm9jemkiIDxzdGVmYW5oYUBnbWFp
bC5jb20+IHdyb3RlOg0KDQogICAgT24gTW9uLCBGZWIgMjAsIDIwMTcgYXQgMDM6MzQ6NTdBTSAt
MDgwMCwgYXNoaXNoIG1pdHRhbCB3cm90ZToNCiAgICA+IE9uIE1vbiwgRmViIDIwLCAyMDE3IGF0
IDM6MDIgQU0sIFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAZ21haWwuY29tPiB3cm90ZToNCiAg
ICA+ID4gT24gU2F0LCBGZWIgMTgsIDIwMTcgYXQgMTI6MzA6MzFBTSArMDAwMCwgS2V0YW4gTmls
YW5nZWthciB3cm90ZToNCiAgICA+ID4+IE9uIDIvMTcvMTcsIDE6NDIgUE0sICJKZWZmIENvZHki
IDxqY29keUByZWRoYXQuY29tPiB3cm90ZToNCiAgICA+ID4+DQogICAgPiA+PiAgICAgT24gVGh1
LCBGZWIgMTYsIDIwMTcgYXQgMDI6MjQ6MTlQTSAtMDgwMCwgYXNoaXNoIG1pdHRhbCB3cm90ZToN
CiAgICA+ID4+ICAgICA+IEhpLA0KICAgID4gPj4gICAgID4NCiAgICA+ID4+ICAgICA+IEkgYW0g
Z2V0dGluZyB0aGUgZm9sbG93aW5nIGVycm9yIHdpdGggY2hlY2twYXRjaC5wbA0KICAgID4gPj4g
ICAgID4NCiAgICA+ID4+ICAgICA+IEVSUk9SOiBleHRlcm5zIHNob3VsZCBiZSBhdm9pZGVkIGlu
IC5jIGZpbGVzDQogICAgPiA+PiAgICAgPiAjNzg6IEZJTEU6IGJsb2NrL3Z4aHMuYzoyODoNCiAg
ICA+ID4+ICAgICA+ICtRZW11VVVJRCBxZW11X3V1aWQgX19hdHRyaWJ1dGVfXyAoKHdlYWspKTsN
CiAgICA+ID4+ICAgICA+DQogICAgPiA+PiAgICAgPiBJcyB0aGVyZSBhbnkgd2F5IHRvIGdldCBh
cm91bmQgdGhpcywgb3IgZG9lcyBpdCBtZWFuIHRoYXQgSSB3b3VsZCBoYXZlDQogICAgPiA+PiAg
ICAgPiB0byBhZGQgYSB2eGhzLmgganVzdCBmb3IgdGhpcyBvbmUgZW50cnk/DQogICAgPiA+PiAg
ICAgPg0KICAgID4gPj4NCiAgICA+ID4+ICAgICBJIHJlbWFpbiBza2VwdGljYWwgb24gdGhlIHVz
ZSBvZiB0aGUgcWVtdV91dWlkIGFzIGEgd2F5IHRvIHNlbGVjdCB0aGUgVExTDQogICAgPiA+PiAg
ICAgY2VydC4NCiAgICA+ID4+DQogICAgPiA+PiBba2V0YW5dDQogICAgPiA+PiBJcyB0aGVyZSBh
bm90aGVyIGlkZW50aXR5IHRoYXQgY2FuIGJlIHVzZWQgZm9yIHVuaXF1ZWx5IGlkZW50aWZ5aW5n
IGluc3RhbmNlcz8NCiAgICA+ID4+IFRoZSByZXF1aXJlbWVudCB3YXMgdG8gZW5mb3JjZSB2ZGlz
ayBhY2Nlc3MgdG8gb3duZXIgaW5zdGFuY2VzLg0KICAgID4gPg0KICAgID4gPiBUaGUgcWVtdV91
dWlkIHdlYWsgYXR0cmlidXRlIGxvb2tzIHN1c3BlY3QuICBXaGF0IGlzIGdvaW5nIHRvIHByb3Zp
ZGUgYQ0KICAgID4gPiBzdHJvbmcgcWVtdV91dWlkIHN5bWJvbD8NCiAgICA+ID4NCiAgICA+ID4g
V2h5IGFyZW4ndCBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMgbGlrZSB0aGUgVVVJRCBjb21pbmcg
ZnJvbSB0aGUgUUVNVQ0KICAgID4gPiBjb21tYW5kLWxpbmU/DQogICAgPiA+DQogICAgPiA+IFN0
ZWZhbg0KICAgID4gDQogICAgPiBVVUlEIHdpbGwgaW4gZmFjdCBjb21lIGZyb20gdGhlIFFFTVUg
Y29tbWFuZCBsaW5lLiBWeEhTIGlzIG5vdCBkb2luZw0KICAgID4gYW55dGhpbmcgc3BlY2lhbCBo
ZXJlLiBJdCB3aWxsIGp1c3QgdXNlIHRoZSB2YWx1ZSBhbHJlYWR5IGF2YWlsYWJsZSB0bw0KICAg
ID4gcWVtdS1rdm0gcHJvY2Vzcy4NCiAgICA+IA0KICAgID4gUWVtdVVVSUQgcWVtdV91dWlkOw0K
ICAgID4gYm9vbCBxZW11X3V1aWRfc2V0Ow0KICAgID4gDQogICAgPiBCb3RoIHRoZSBhYm92ZSBh
cmUgZGVmaW5lZCBpbiB2bC5jLiB2bC5jIHdpbGwgcHJvdmlkZSB0aGUgc3Ryb25nDQogICAgPiBz
eW1ib2wgd2hlbiBhdmFpbGFibGUuIFRoZXJlIGFyZSBjZXJ0YWluIGJpbmFyaWVzIHRoYXQgZG8g
bm90IGdldA0KICAgID4gbGlua2VkIHdpdGggdmwuYyAoZS5nLiBxZW11LWltZykuIFRoZSB3ZWFr
IHN5bWJvbCB3aWxsIGNvbWUgaW50bw0KICAgID4gYWZmZWN0IGZvciBzdWNoIGJpbmFyaWVzLCBh
bmQgaW4gdGhpcyBjYXNlLCB0aGUgZGVmYXVsdCBWWEhTIFVVSUQgd2lsbA0KICAgID4gZ2V0IHBp
Y2tlZCB1cC4gSSBoYWQsIGluIGEgcHJldmlvdXMgZW1haWwsIGV4cGxhaW5lZCBob3cgd2UgcGxh
biB0bw0KICAgID4gdXNlIHRoZSBkZWZhdWx0IFVVSUQuIEluIHRoZSByZWd1bGFyIGNhc2UsIHRo
ZSBWeEhTIGNvbnRyb2xsZXIgd2lsbA0KICAgID4gbm90IGFsbG93IGFjY2VzcyB0byB0aGUgZGVm
YXVsdCBVVUlEIChub24gcWVtdS1rdm0pIGJpbmFyaWVzLCBidXQgaXQNCiAgICA+IG1heSBjaG9v
c2UgdG8gZ3JhbnQgdGVtcG9yYXJ5IGFjY2VzcyB0byBzcGVjaWZpYyB2ZGlza3MgZm9yIHRoZXNl
DQogICAgPiBiaW5hcmllcyBkZXBlbmRpbmcgb24gdGhlIHdvcmtmbG93Lg0KICAgIA0KICAgIFRo
YXQgaWRlYSBzb3VuZHMgbGlrZSBhIHNlY3VyaXR5IHByb2JsZW0uICBEdXJpbmcgdGhpcyB0aW1l
IHdpbmRvdw0KICAgIGFueW9uZSBjb3VsZCB1c2UgdGhlIGRlZmF1bHQgVVVJRCB0byBhY2Nlc3Mg
dGhlIGRhdGE/DQogICAgDQogICAgSnVzdCBtYWtlIHRoZSBVVUlEIChvciBUTFMgY2xpZW50IGNl
cnRpZmljYXRlIGZpbGUpIGEgY29tbWFuZC1saW5lDQogICAgcGFyYW1ldGVyIHRoYXQgcWVtdS1z
eXN0ZW0sIHFlbXUtaW1nLCBhbmQgb3RoZXIgdG9vbHMgYWNjZXB0IChlLmcuDQogICAgcWVtdS1p
bWcgdmlhIHRoZSAtLWltYWdlLW9wdHMvLS1vYmplY3Qgc3ludGF4KS4NCiAgICANCltLZXRhbl0N
ClNvdW5kcyBmYWlyLiBXb3VsZCBpdCBiZSBvayB0byB0YWtlIHRoaXMgdXAgYWZ0ZXIgdGhlIGRy
aXZlciBpcyBtZXJnZWQgZm9yIHRoZSB1cGNvbWluZyBRRU1VIHJlbGVhc2U/DQoNCiAgICBTdGVm
YW4NCiAgICANCg0K

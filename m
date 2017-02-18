Received: from eggs.gnu.org ([2001:4830:134:3::10]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cesvC-0007d5-CD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 19:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Ketan.Nilangekar@veritas.com>) id 1cesv9-0006a1-6t
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 19:30:42 -0500
Received: from mail1.bemta12.messagelabs.com ([216.82.251.4]:14440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Ketan.Nilangekar@veritas.com>)
	id 1cesv8-0006Uk-Rw
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 19:30:39 -0500
From: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>
Date: Sat, 18 Feb 2017 00:30:31 +0000
Message-ID: <F23F188C-DAF9-49EA-9C0E-54F57945267A@veritas.com>
References: <CAAo6VWOAnGQeDwc_bJ4M=FQsu7rOhAv=1Qk6PdzG+0pcVnku=A@mail.gmail.com>
	<20170217214215.GK19045@localhost.localdomain>
In-Reply-To: <20170217214215.GK19045@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E11AC0998241384BAACBAA759E850622@veritas.com>
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
To: Jeff Cody <jcody@redhat.com>, ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel
	P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish
	Mittal <Ashish.Mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>

T24gMi8xNy8xNywgMTo0MiBQTSwgIkplZmYgQ29keSIgPGpjb2R5QHJlZGhhdC5jb20+IHdyb3Rl
Og0KDQogICAgT24gVGh1LCBGZWIgMTYsIDIwMTcgYXQgMDI6MjQ6MTlQTSAtMDgwMCwgYXNoaXNo
IG1pdHRhbCB3cm90ZToNCiAgICA+IEhpLA0KICAgID4gDQogICAgPiBJIGFtIGdldHRpbmcgdGhl
IGZvbGxvd2luZyBlcnJvciB3aXRoIGNoZWNrcGF0Y2gucGwNCiAgICA+IA0KICAgID4gRVJST1I6
IGV4dGVybnMgc2hvdWxkIGJlIGF2b2lkZWQgaW4gLmMgZmlsZXMNCiAgICA+ICM3ODogRklMRTog
YmxvY2svdnhocy5jOjI4Og0KICAgID4gK1FlbXVVVUlEIHFlbXVfdXVpZCBfX2F0dHJpYnV0ZV9f
ICgod2VhaykpOw0KICAgID4gDQogICAgPiBJcyB0aGVyZSBhbnkgd2F5IHRvIGdldCBhcm91bmQg
dGhpcywgb3IgZG9lcyBpdCBtZWFuIHRoYXQgSSB3b3VsZCBoYXZlDQogICAgPiB0byBhZGQgYSB2
eGhzLmgganVzdCBmb3IgdGhpcyBvbmUgZW50cnk/DQogICAgPg0KICAgIA0KICAgIEkgcmVtYWlu
IHNrZXB0aWNhbCBvbiB0aGUgdXNlIG9mIHRoZSBxZW11X3V1aWQgYXMgYSB3YXkgdG8gc2VsZWN0
IHRoZSBUTFMNCiAgICBjZXJ0Lg0KDQpba2V0YW5dDQpJcyB0aGVyZSBhbm90aGVyIGlkZW50aXR5
IHRoYXQgY2FuIGJlIHVzZWQgZm9yIHVuaXF1ZWx5IGlkZW50aWZ5aW5nIGluc3RhbmNlcz8NClRo
ZSByZXF1aXJlbWVudCB3YXMgdG8gZW5mb3JjZSB2ZGlzayBhY2Nlc3MgdG8gb3duZXIgaW5zdGFu
Y2VzLg0KDQogICAgDQogICAgQnV0IHRoYXQgYXNpZGUsIGFuZCBsb29raW5nIGF0IGl0IHN0cmlj
dGx5IGZyb20gYSBjaGVja3BhdGNoLnBsIHBvaW50IG9mDQogICAgdmlldywgSSB0aGluayBvbmUg
Y291bGQgbWFrZSBhIGNhc2UgdGhhdCBpZiB0aGVyZSBpcyBubyBoZWFkZXIgZmlsZSwgdGhlDQog
ICAgZXJyb3IgY291bGQgYmUgaWdub3JlZC4NCiAgICANCg0K

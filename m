Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbates@raithlin.com>) id 1gCTCP-0003uM-2q
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbates@raithlin.com>) id 1gCTCL-00041u-0p
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:32:04 -0400
Received: from mail-eopbgr660134.outbound.protection.outlook.com
	([40.107.66.134]:8935
	helo=CAN01-QB1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbates@raithlin.com>) id 1gCTCK-00040n-P7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:32:00 -0400
From: "Stephen  Bates" <sbates@raithlin.com>
Date: Tue, 16 Oct 2018 17:31:58 +0000
Message-ID: <2C5AFCF5-9F41-4F8F-A058-67743C5403F5@eideticom.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<CAKmqyKNTTu+5KyTMBHw5-+UMa7qnm9EaowxHj8NLxED98m1MKw@mail.gmail.com>
	<d9e6d7979143130092b5b96602885c1acaca9b52.camel@redhat.com>
	<CAKmqyKMTzYswJ74WEOQAQrisCdMDQ9Nf6NMEdUKLcUMCN7XLgg@mail.gmail.com>
	<23d9891ec01bec45b16f89ba1412238be39addf9.camel@redhat.com>
	<CAKmqyKMBxY6j3SwvyYsMVCCeAwKinuVE4+2kbAp6YapBWdKZig@mail.gmail.com>
	<967af677f4d0b60bfb201f639ade0b0712e09fc8.camel@redhat.com>
	<4089265c6ef44f79f0dd67d203f69e5bde9b8d85.camel@redhat.com>
	<138e8c0bd96f9fa58c1b79e89615ba9a6f4318fd.camel@redhat.com>
In-Reply-To: <138e8c0bd96f9fa58c1b79e89615ba9a6f4318fd.camel@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E50546B486ADF340B45D6442F4C70D7C@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, Alistair Francis <alistair23@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, "Richard W.M. Jones" <rjones@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

PiAgICBGb3Jnb3QgdG8gbWVudGlvbiB0aGF0LCBkZXNwaXRlIHNob3dpbmcgdXAsIHRoZSBkZXZp
Y2UgZG9lc24ndCBxdWl0ZQ0KPiAgICB3b3JrOiBmb3IgZXhhbXBsZSwgaXQgY2FuJ3Qgc2VlbSB0
byBiZSBhYmxlIHRvIGFjcXVpcmUgYW4gSVAgYWRkcmVzcy4NCiAgICANCkFuZHJlYSBhbmQgQWxp
c3RhaXINCg0KQSBsb3Qgb2YgeW91ciBpc3N1ZXMgbG9vayB2ZXJ5IHNpbWlsYXIgdG8gd2hhdCBJ
IHNhdy4gVGhlIFBDSWUgZGV2aWNlIGNhbiBiZSBhY2Nlc3NlZCB2aWEgTU1JTyBidXQgaW50ZXJy
dXB0cyBhcmUgYnJva2VuIHdoaWNoIGNhdXNlcyBpc3N1ZXMgd2l0aCB0aGUgZGV2aWNlcyAoZS5n
LiBOVk1lIG9yIDEwMDBlKS4gSSB0aGluayB3ZSBuZWVkIHRvIHJvb3QgY2F1c2UgYW5kIHJlc29s
dmUgdGhpcyBpc3N1ZSBiZWZvcmUgd2UgY2FuIG1lcmdlIHRoZSBzZXJpZXMuDQoNCkFsaXN0YWly
IEkgdGhpbmsgeW91IG5lZWQgdG8gcmV2aWV3IGhvdyBpbnRlcnJ1cHRzIGFyZSB3aXJlZCB1cCBp
biB0aGUgUENJZSByb290IGRldmljZS4gTWF5YmUgY29tcGFyZSB0byBob3cgaXQgd2FzIGRvbmUg
aW4gYXJtIGFzIGl0IGxvb2tzIGRpZmZlcmVudC4NCg0KRm9yIG5vdyBJIHdvdWxkIGNvbmNlbnRy
YXRlIG9uIHRoZSB2aXJ0IG1hY2hpbmUgKHNpbmNlIGl0IGhhcyBhIHdvcmtpbmcgZXF1aXZhbGVu
dCBpbiB0aGUgYXJtIHRyZWUpLiBXZSBjYW4gdGhlbiBsb29rIGF0IHRoZSBzaWZpdmVfdSBtYWNo
aW5lIGFmdGVyLg0KDQpDaGVlcnMNCg0KU3RlcGhlbg0KICAgIA0KICAgIA0KDQo=

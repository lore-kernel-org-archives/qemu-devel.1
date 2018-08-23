Received: from eggs.gnu.org ([2001:4830:134:3::10]:34918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1fsnpN-00029Z-Me
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1fsndR-0001Os-VN
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:18:44 -0400
Received: from mail-by2nam03on0066.outbound.protection.outlook.com
	([104.47.42.66]:45600
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Manish.Jaggi@cavium.com>)
	id 1fsndR-0001NN-ER
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:18:41 -0400
From: "Jaggi, Manish" <Manish.Jaggi@cavium.com>
Date: Thu, 23 Aug 2018 11:18:37 +0000
Message-ID: <CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
References: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
In-Reply-To: <CABgNM92-PHWg3X41tCVfErmV9-Hnu5GYpz_pa9-iXfbScFUCZg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0F753FD247AD348ADFCFC910AD01A44@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [Query] Live Migration between machines with different
 processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Liguori <aliguori@us.ibm.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Jaggi, Manish" <Manish.Jaggi@cavium.com>

SGksDQoNClBvc3RpbmcgYWdhaW4gd2l0aCBteSBjYXZpdW0gSUQgYW5kIENDaW5nIHJlbGV2YW50
IGZvbGtzDQoNCg0KTGl2ZSBNaWdyYXRpb24gYmV0d2VlbiBtYWNoaW5lcyB3aXRoIGRpZmZlcmVu
dCBwcm9jZXNzb3JJZHMNCg0KVk0gTWlncmF0aW9uIGJldHdlZW4gbWFjaGluZXMgd2l0aCBkaWZm
ZXJlbnQgcHJvY2Vzc29ySWQgdmFsdWVzIHRocm93cw0KZXJyb3IgaW4gcWVtdS9rdm0uIFRob3Vn
aCB0aGlzIGNoZWNrIGlzIGFwcHJvcHJpYXRlIGJ1dCBpcyBvdmVya2lsbCB3aGVyZQ0KdHdvIG1h
Y2hpbmVzIGFyZSBvZiBzYW1lIFNvQy9hcmNoIGZhbWlseSBhbmQgaGF2ZSBzYW1lIGNvcmUvZ2lj
IGJ1dA0KZGVsdGEgY291bGQgYmUgaW4gb3RoZXIgcGFydHMgb2YgU29jIHdoaWNoIGhhdmUgbm8g
ZWZmZWN0IG9uIFZNDQpvcGVyYXRpb24uDQoNClRoZXJlIGNvdWxkIGJlIHR3byB3YXlzIHRvIGFk
ZHJlc3MgdGhpcyBpc3N1ZSBieSBpZ25vcmluZyB0aGUNCmNvbXBhcmlzb24gb2YgcHJvY2Vzc29y
SURzIGFuZCBzbyBuZWVkIGZlZWRiYWNrIGZyb20gdGhlDQpjb21tdW5pdHkgb24gdGhpcy4NCg0K
YSkgTWFpbnRhaW4gYSB3aGl0ZWxpc3QgaW4gcWVtdToNCg0KVGhpcyB3aWxsIGJlIGEgc2V0IG9m
IGFsbCBwcm9jZXNzb3JJZHMgd2hpY2ggYXJlIGNvbXBhdGlibGUgYW5kIG1pZ3JhdGlvbiBjYW4N
CmhhcHBlbiBiZXR3ZWVuIGFueSBvZiB0aGUgbWFjaGluZXMgd2l0aCB0aGUgSWRzIGZyb20gdGhp
cyBzZXQuIFRoaXMgc2V0IGNhbg0KYmUgc3RhdGljYWxseSBidWlsdCB3aXRoaW4gcWVtdSBiaW5h
cnkuDQoNCmIpIFByb3ZpZGUgYW4gZXh0cmEgb3B0aW9uIHdpdGggbWlncmF0ZSBjb21tYW5kDQoN
CiAgIG1pZ3JhdGUgdGNwOjxpcD46PHBvcnQ+OjxkZXN0X3Byb2Nlc3Nvcl9pZD4NCg0KVGhpcyBp
cyB0byBmYWtlIHRoZSBzcmNfcHJvY2Vzc29yX2lkIGFzIGRlc3RfcHJvY2Vzc29yX2lkLCBzbyB0
aGUgcWVtdSBydW5uaW5nDQpvbiBkZXN0aW5hdGlvbiBtYWNoaW5lIHdpbGwgbm90IGNvbXBsYWlu
LiBUaGUgb3ZlcmhlYWQgd2l0aCB0aGlzIGFwcHJvYWNoIGlzDQp0aGF0IHRoZSBkZXN0aW5hdGlv
biBtYWNoaW5lcyBJZCBuZWVkIHRvIGJlIGtub3duIGJlZm9yZWhhbmQuDQoNCklmIHRoZXJlIGlz
IHNvbWUgYmV0dGVyIHdheeKApiBwbGVhc2Ugc3VnZ2VzdC4NCg0KVGhhbmtzLA0KTWFuaXNo

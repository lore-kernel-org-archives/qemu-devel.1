Received: from eggs.gnu.org ([2001:4830:134:3::10]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndragazis@outlook.com.gr>) id 1gFN7H-0001Po-Ec
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndragazis@outlook.com.gr>) id 1gFN7D-0006Xf-Dw
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:38:47 -0400
Received: from mail-oln040092069052.outbound.protection.outlook.com
	([40.92.69.52]:43088
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ndragazis@outlook.com.gr>)
	id 1gFN7D-0006WA-0r
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 13:38:43 -0400
From: Nikos Dragazis <ndragazis@outlook.com.gr>
Date: Wed, 24 Oct 2018 17:38:39 +0000
Message-ID: <AM6PR07MB38649DF03A31D47069F650B998F60@AM6PR07MB3864.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F824B8E9F056A4D8FE529200A426ABA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] Error with Virtio DMA Remapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Vangelis Koukis <vkoukis@arrikto.com>

SGkgYWxsLA0KDQpJIGFtIHRyeWluZyB0byB1c2UgUUVNVSB2SU9NTVUgZm9yIHZpcnRpbyBETUEg
cmVtYXBwaW5nLiBXaGVuIEkgcnVuIHRoZQ0KVk0sIEkgZ2V0IHRoZSBmb2xsb3dpbmcgbWVzc2Fn
ZXMgaW4gc3RkZXJyOg0KDQpxZW11LXN5c3RlbS14ODZfNjQ6IHZ0ZF9pb21tdV90cmFuc2xhdGU6
IGRldGVjdGVkIHRyYW5zbGF0aW9uIGZhaWx1cmUgKGRldj0wMTowMDowMCwgaW92YT0weDApDQpx
ZW11LXN5c3RlbS14ODZfNjQ6IE5ldyBmYXVsdCBpcyBub3QgcmVjb3JkZWQgZHVlIHRvIGNvbXBy
ZXNzaW9uIG9mIGZhdWx0cw0KcWVtdS1zeXN0ZW0teDg2XzY0OiB2aXJ0aW86IHplcm8gc2l6ZWQg
YnVmZmVycyBhcmUgbm90IGFsbG93ZWTCoMKgwqDCoMKgwqDCoMKgwqANCg0KTXkgUUVNVSBjb25m
aWd1cmF0aW9uIGlzOg0KDQoNCi4vcWVtdS1zeXN0ZW0teDg2XzY0IC1NIGFjY2VsPWt2bSAtY3B1
IGhvc3QgLXNtcCAyIC1tIDRHIFwNCsKgwqDCoMKgwqAgLWVuYWJsZS1rdm0gLW1hY2hpbmUgcTM1
LGFjY2VsPWt2bSxrZXJuZWwtaXJxY2hpcD1zcGxpdCBcDQrCoMKgwqDCoMKgIC1kZXZpY2UgaW50
ZWwtaW9tbXUseC1hdy1iaXRzPTQ4LGRldmljZS1pb3RsYj1vbixwdD1mYWxzZSBcDQrCoMKgwqDC
oMKgIC1kZXZpY2UgaW9oMzQyMCxpZD1wY2llLjEsY2hhc3Npcz0xIFwNCsKgwqDCoMKgwqAgLWRl
dmljZSB2aXJ0aW8tc2NzaS1wY2ksYnVzPXBjaWUuMSxpZD1zY3NpMCxpb21tdV9wbGF0Zm9ybT1v
bixhdHM9b24sDQpkaXNhYmxlLWxlZ2FjeT1vbixkaXNhYmxlLW1vZGVybj1vZmYgXA0KwqDCoMKg
wqDCoCBbLi4uXQ0KDQpJIHVzZSBRRU1VIDMuMC41MCBhbmQgaG9zdCBrZXJuZWwgNC40LjAuDQoN
CkkgZm9sbG93ZWQgdGhlIGluc3RydWN0aW9ucyBoZXJlOg0KaHR0cHM6Ly93aWtpLnFlbXUub3Jn
L0ZlYXR1cmVzL1ZULWQjV2l0aF9WaXJ0aW9fRGV2aWNlcw0KdG8gZW5hYmxlIERNQVIgZm9yIHRo
ZSB2aXJ0aW8tc2NzaSBkZXZpY2UuDQoNCkkgc2VlIHRoZXJlIGlzIGEgcmVsYXRlZCB0aHJlYWQg
YWJvdXQgdGhpcyBlcnJvciBoZXJlOg0KaHR0cDovL3FlbXUuMTEubjcubmFiYmxlLmNvbS9QQVRD
SC0wLTItdmlydGlvLXNjc2ktRml4LVFFTVUtaGFuZy13aXRoLXZJT01NVS1hbmQtQVRTLXRkNTk4
NzM2Lmh0bWwjYTU5OTA4Ng0KDQpJcyB0aGlzIHN0aWxsIGFuIG9wZW4gaXNzdWUgb3IgaXQgaGFz
IGJlZW4gc29sdmVkPw0KUGxlYXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpOaWtvcw0KDQo=

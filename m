Received: from eggs.gnu.org ([2001:4830:134:3::10]:32908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1cymdo-0003eY-Dz
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1cymdl-00011j-B6
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:51:00 -0400
Received: from mail-db5eur01on0106.outbound.protection.outlook.com
	([104.47.2.106]:10592
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1cymdk-00011L-Tj
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:50:57 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Thu, 13 Apr 2017 20:17:00 +0000
Message-ID: <VI1PR0601MB2479AC08F717F15FCE287FC99C020@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGVsbG8tDQoNCkkgcG9zdGVkIHRoaXMgcXVlc3Rpb24gb24gc3RhY2sgb3ZlcmZsb3cgYW5kIGdv
dCBubyByZXNwb25zZS4gU3RlZmFuIHJlY29tbWVuZGVkIGFza2luZyB0aGUgcXVlc3Rpb24gaGVy
ZS4NCg0KSeKAmXZlIGluY2x1ZGVkIGEgc3VtbWFyeSBvZiB0aGUgcHJvYmxlbSBoZXJlIGluIHRo
aXMgZW1haWwgYnV0IG1vcmUgZGV0YWlscyBjYW4gYmUgZm91bmQgaGVyZToNCg0KaHR0cDovL3N0
YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy80MzMwODMxMC9kbnMtc2VydmVyLW5vdC13b3JraW5n
LWluLXFlbXUtdXNlcm1vZGUtbmV0d29ya2luZz9ub3JlZGlyZWN0PTEjY29tbWVudDczNzA2NDEw
XzQzMzA4MzEwDQoNCkJhc2ljYWxseSwgSSBjYW4gYWNjZXNzIHRoZSBpbnRlcm5ldCB1c2luZyBz
dGF0aWMgSVAgYWRkcmVzc2VzIGJ1dCBuYW1lc2VydmVyIHJlc29sdXRpb24gaXMgbm90IHdvcmtp
bmcuIEkgY2FuIHBpbmcgdGhlIHJvdXRlciAxMC4wLjIuMiBhZGRyZXNzIGFuZCBteSAxMC4wLjIu
MTUgYWRkcmVzcyBidXQgbm90IHRoZSAxMC4wLjIuMyBhZGRyZXNzIG9mIHRoZSBETlMgc2VydmVy
IG9yIHRoZSAxMC4wLjIuNCBvZiB0aGUgU01CIHNlcnZlciBib3RoIG9mIHdoaWNoIEkgbmVlZCBm
b3IgbXkgcHJvamVjdC4NCg0KQW55IHN1Z2dlc3Rpb25zPw0KDQpwLnMuIEkgdHJpZWQgMi45cmMz
IGFuZCBpdCBmYWlsZWQgYXMgd2VsbC4NCg0KQmVzdCBSZWdhcmRzIC8gTWl0IGZyZXVuZGxpY2hl
biBHcsO8w59lbiAvIOaVrOWFtywNCk1hcmsuDQoNCk1hcmsgRm9ubmVtYW5uDQpTZW5pb3IgU29m
dHdhcmUgRW5naW5lZXIg4oCTIE1hY2hpbmUgVG9vbCBNZXRyb2xvZ3kgU29sdXRpb25zDQpUOiAr
MSA0MDEuODg2LjI1MjEgIE06ICsxIDI0OC44NjMuNzkzMQ0KRTogbWFyay5mb25uZW1hbm5AaGV4
YWdvbm1ldHJvbG9neS5jb208bWFpbHRvOm1hcmsuZm9ubmVtYW5uQGhleGFnb25tZXRyb2xvZ3ku
Y29tPg0KDQpIZXhhZ29uIE1hbnVmYWN0dXJpbmcgSW50ZWxsaWdlbmNlDQoyNTAgQ2lyY3VpdCBE
cml2ZQ0KTm9ydGggS2luZ3N0b3duLCBSSSAgMDI4MjINClVTQQ0KcGMtZG1pcy5jb208aHR0cDov
L3d3dy5wYy1kbWlzLmNvbS8+IHwgTGlua2VkSW48aHR0cDovL3d3dy5saW5rZWRpbi5jb20vZ3Jv
dXBzL0hleGFnb24tTWV0cm9sb2d5LUluYy00MDE0Mjk0L2Fib3V0PiB8IEZhY2Vib29rPGh0dHA6
Ly93d3cuZmFjZWJvb2suY29tL0hleGFnb24uTWV0cm9sb2d5LkluYz4gfCBUd2l0dGVyPGh0dHA6
Ly90d2l0dGVyLmNvbS9oZXhtZXQ+DQoNCg==

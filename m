Received: from eggs.gnu.org ([2001:4830:134:3::10]:55103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d77Hy-0002e2-5v
	for qemu-devel@nongnu.org; Sat, 06 May 2017 17:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.fonnemann@hexagon.com>) id 1d77Hv-0005pF-1U
	for qemu-devel@nongnu.org; Sat, 06 May 2017 17:30:54 -0400
Received: from mail-ve1eur01on0133.outbound.protection.outlook.com
	([104.47.1.133]:48832
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.fonnemann@hexagon.com>)
	id 1d77Hu-0005p5-DS
	for qemu-devel@nongnu.org; Sat, 06 May 2017 17:30:50 -0400
From: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Date: Sat, 6 May 2017 21:30:47 +0000
Message-ID: <VI1PR0601MB2479748C35B3C9F914896AEA9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] slirp: question about using SMB on windows host with
 linux guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGVsbG8tDQoNCkkgYW0gdHJ5aW5nIHRvIHNoYXJlcyBmaWxlcyBiZXR3ZWVuIFdpbmRvd3MgaG9z
dCBhbmQgTGludXggZ3Vlc3QgdXNpbmcgc2xpcnDigJlzIGJ1aWx0LWluIFNNQiBzZXJ2ZXIuDQpJ
IHN0YXJ0IFFFTVUgMi45LjAgdXNpbmcgdGhlIGZvbGxvd2luZzoNCg0KQzpcUHJvZ3JhbSBGaWxl
c1xxZW11PnFlbXUtc3lzdGVtLWkzODYuZXhlIC1yZWFkY29uZmlnIFxVc2Vyc1xtZm9ubmVtYW5u
XHFlbXUuY2ZnIC1uZXQgbmljIC1uZXQgdXNlcixzbWI9XFVzZXJzXG1mb25uZW1hbm5cc21iDQoN
CkkgdGhlbiB0cnkgdG8gbW91bnQgdGhlIFNNQiBzaGFyZSBmaXJzdCB3aXRoIDEwLjAuMi40Og0K
DQpyb290QHFlbXU6fiMgbW91bnQgLXQgY2lmcyAvLzEwLjAuMi40L1VzZXJzL21mb25uZW1hbm4v
c21iIHRtcCAtbyB1c2VyPW1mb25uZW1hbm4NCiAgICAgICAgICAgICAgICAgICAgUGFzc3dvcmQ6
DQogICAgICAgICAgICAgICAgICAgICBDSUZTIFZGUzogRXJyb3IgY29ubmVjdGluZyB0byBJUHY0
IHNvY2tldC4gQWJvcnRpbmcgb3BlcmF0aW9uDQogICAgICAgICAgICAgICAgICAgICBDSUZTIFZG
UzogY2lmc19tb3VudCBmYWlsZWQgdy9yZXR1cm4gY29kZSA9IC0xMTMNCiAgICAgICAgICAgICAg
ICAgICAgbW91bnQgZXJyb3IgMTEzID0gTm8gcm91dGUgdG8gaG9zdA0KICAgICAgICAgICAgICAg
ICAgICBtb3VudDogbW91bnQuY2lmcyBmYWlsZWQgd2l0aCBzdGF0dXMgLTENCg0KQW5kIHRoZW4g
d2l0aCAxMC4wLjIuMjoNCg0Kcm9vdEBxZW11On4jIG1vdW50IC10IGNpZnMgLy8xMC4wLjIuMi9V
c2Vycy9tZm9ubmVtYW5uL3NtYiB0bXAgLW8gdXNlcj1tZm9ubmVtYW5uDQogICAgICAgICAgICAg
ICAgICAgIFBhc3N3b3JkOg0KICAgICAgICAgICAgICAgICAgICAgQ0lGUyBWRlM6IFVua25vd24g
UkZDIDEwMDIgZnJhbWUNCg0KICAgICAgICAgICAgICAgICAgICAgQ0lGUyBWRlM6IFNlbmQgZXJy
b3IgaW4gU2Vzc1NldHVwID0gLTEzDQogICAgICAgICAgICAgICAgICAgICBDSUZTIFZGUzogY2lm
c19tb3VudCBmYWlsZWQgdy9yZXR1cm4gY29kZSA9IC0xMw0KICAgICAgICAgICAgICAgICAgICBt
b3VudCBlcnJvciAxMyA9IFBlcm1pc3Npb24gZGVuaWVkDQogICAgICAgICAgICAgICAgICAgIG1v
dW50OiBtb3VudC5jaWZzIGZhaWxlZCB3aXRoIHN0YXR1cyAtMQ0KDQpSZWdhcmRpbmcgUkZDIDEw
MDIgZnJhbWUsIEkgc2VlIHRoZSBmb2xsb3dpbmcgd2hlbiB1c2luZyDigJxkbWVzZ+KAnToNCg0K
Q0lGUyBWRlM6IFVua25vd24gUkZDIDEwMDIgZnJhbWUNCiAgICAgICAgICAgICAgICAgICAgIFJl
Y2VpdmVkIERhdGE6IDogZHVtcCBvZiAzNiBieXRlcyBvZiBkYXRhIGF0IDB4ZjcxNDAwYzANCg0K
ICAgICAgICAgICAgICAgICAgICAgMDAwMDAwOGQgNTc3NzAwNjQgNmUwMDY5MDAgNmYwMDY0MDAg
LiAuIC4gLiBkIC4gdyBXIC4gaSAuIG4gLiBkIC4gbw0KICAgICAgICAgICAgICAgICAgICAgNzMw
MDc3MDAgMzEwMDIwMDAgMjAwMDMwMDAgNzIwMDUwMDAgLiB3IC4gcyAuICAgLiAxIC4gMCAuICAg
LiBQIC4gcg0KICAgICAgICAgICAgICAgICAgICAgMjAwMDZmMDAgLiBvIC4NCg0KQW55IGhlbHAg
d291bGQgYmUgZ3JlYXRseSBhcHByZWNpYXRlZCEhDQpUaGFuayB5b3UgdmVyeSBtdWNoLg0KDQpC
ZXN0IFJlZ2FyZHMgLyBNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuIC8g5pWs5YW3LA0KTWFyay4N
Cg0K

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1cddQ7-0001Wa-1f
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1cddQ3-0007XJ-4I
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:45:27 -0500
Received: from smtpbg62.qq.com ([103.7.29.139]:3057 helo=smtpbg64.qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <4345099@qq.com>) id 1cddQ1-0007VU-VV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:45:23 -0500
From: "=?ISO-8859-1?B?aGVhdnliaXJk?=" <4345099@qq.com>
Mime-Version: 1.0
Date: Tue, 14 Feb 2017 21:45:15 +0800
Message-ID: <tencent_44FCF9336341E20C3F2A5EB7@qq.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] Fw: qemu integrator RAM size can't reach 128M when
 emulate the arm926
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>

aGkgcWVtdS1kZXZlbCwNCg0KDQppIHRyaWVkIHVzZSB0aGUgaW50ZWdyYXRvci5jIHRvIGVt
dWxhdGUgdGhlIGFybTkyNiB3aGljaCBoYXMgMTI4TSBtZXNzYWdlIGJ1dCBmb3VuZCB0aGUg
UkFNIHNpemUgY2FuIHVzZSBpcyBsZXNzIHRoYW4gMzJNLiBzdGVwcyBiZWxvdy4gdGhlIHFl
bXUgdXNkaW5nIGlzIDIuOC4NCg0KMSAgZGVmaW5lIHRoZSBSQU0gZnJvbSAwLTEyOE0gaW4g
bGQgZmlsZS4NCjIgd3JpdGUgdGhlIHRlc3QgcHJvZ3JhbSB0byB2ZXJpZnkgaSBjYW4gd3Jp
dGUvcmVhZCB0aGUgbWVtb3J5IGZyb20gMzJNIHRvIDY0TSBjb250aW51b3VzbHkgd2l0aCBh
ZGRyZXNzIGRpcmVjdGx5Lg0KMyBhbHdheXMgZmFpbGVkIHdoZW4gdGhlIHNpemUgaXMgY2xv
c2UgdG8gMzJNIGV2ZW4gdGhvdWdoIGkgY2hhbmdlZCBzdGFydCBhZGRyZXNzLg0KNCBlcnJv
ciBtZXNzYWdlOg0KDQpxZW11OiBoYXJkd2FyZSBlcnJvcjogaW50ZWdyYXRvcmNtX3dyaXRl
MzogVW5pbXBsZW1lbnRlZCBvZmZzZXQgMHgwDQoNCkNQVSAjMDoNClIwMD0wMDAwMDAyOCBS
MDE9MDAwMTkwMDAgUjAyPTAwMDAwMDU1IFIwMz0xMDAwMDAwMA0KUjA0PTAwMDBlYTljIFIw
NT0wMDAwMDUwNSBSMDY9MDAwMDA2MDYgUjA3PTAwMDAwNzA3DQpSMDg9MDAwMDA4MDggUjA5
PTAwMDAwOTA5IFIxMD0wMDAwMTAxMCBSMTE9MDAwMGZlYjQNClIxMj0wMDAwMDAwMCBSMTM9
MDAwMGZlYTggUjE0PTAwMDAwMzM4IFIxNT0wMDAwMDMwMA0KUFNSPTIwMDAwMTUzIC0tQy0g
QSBzdmMzMg0KczAwPTAwMDAwMDAwIHMwMT0wMDAwMDAwMCBkMDA9MDAwMDAwMDAwMDAwMDAw
MA0KczAyPTAwMDAwMDAwIHMwMz0wMDAwMDAwMCBkMDE9MDAwMDAwMDAwMDAwMDAwMA0KczA0
PTAwMDAwMDAwIHMwNT0wMDAwMDAwMCBkMDI9MDAwMDAwMDAwMDAwMDAwMA0KczA2PTAwMDAw
MDAwIHMwNz0wMDAwMDAwMCBkMDM9MDAwMDAwMDAwMDAwMDAwMA0KczA4PTAwMDAwMDAwIHMw
OT0wMDAwMDAwMCBkMDQ9MDAwMDAwMDAwMDAwMDAwMA0KczEwPTAwMDAwMDAwIHMxMT0wMDAw
MDAwMCBkMDU9MDAwMDAwMDAwMDAwMDAwMA0KczEyPTAwMDAwMDAwIHMxMz0wMDAwMDAwMCBk
MDY9MDAwMDAwMDAwMDAwMDAwMA0KczE0PTAwMDAwMDAwIHMxNT0wMDAwMDAwMCBkMDc9MDAw
MDAwMDAwMDAwMDAwMA0KczE2PTAwMDAwMDAwIHMxNz0wMDAwMDAwMCBkMDg9MDAwMDAwMDAw
MDAwMDAwMA0KczE4PTAwMDAwMDAwIHMxOT0wMDAwMDAwMCBkMDk9MDAwMDAwMDAwMDAwMDAw
MA0KczIwPTAwMDAwMDAwIHMyMT0wMDAwMDAwMCBkMTA9MDAwMDAwMDAwMDAwMDAwMA0KczIy
PTAwMDAwMDAwIHMyMz0wMDAwMDAwMCBkMTE9MDAwMDAwMDAwMDAwMDAwMA0KczI0PTAwMDAw
MDAwIHMyNT0wMDAwMDAwMCBkMTI9MDAwMDAwMDAwMDAwMDAwMA0KczI2PTAwMDAwMDAwIHMy
Nz0wMDAwMDAwMCBkMTM9MDAwMDAwMDAwMDAwMDAwMA0KczI4PTAwMDAwMDAwIHMyOT0wMDAw
MDAwMCBkMTQ9MDAwMDAwMDAwMDAwMDAwMA0KczMwPTAwMDAwMDAwIHMzMT0wMDAwMDAwMCBk
MTU9MDAwMDAwMDAwMDAwMDAwMA0KRlBTQ1I6IDAwMDAwMDAwDQoNCg0KdGhhbmtzDQpqYXNv
bi4=

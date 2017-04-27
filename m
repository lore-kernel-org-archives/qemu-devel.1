Received: from eggs.gnu.org ([2001:4830:134:3::10]:35199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1d3a2F-0006Di-NO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1d3a2A-0008Po-PH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:24:03 -0400
Received: from smtpbg202.qq.com ([184.105.206.29]:54077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <4345099@qq.com>) id 1d3a2A-0008OH-5P
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:23:58 -0400
From: "=?ISO-8859-1?B?aGVhdnliaXJk?=" <4345099@qq.com>
Mime-Version: 1.0
Date: Thu, 27 Apr 2017 11:23:46 +0800
Message-ID: <tencent_0B0C9551621D40450A004D34@qq.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel] qemu integrator hardware error: icp_control_write: Bad
 offset 789688
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?= <peter.maydell@linaro.org>, =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>

SGkgUGV0ZXIsIA0KDQpJIGFtIHVzaW5nIHlvdXIgcWVtdSBpbnRlZ3JhdG9yIHRvIGRlYnVn
IG15IGFwcGxpY2F0aW9uIGJ1dCBpdCBlbmNvdXRlcnMgdGhlIGV4Y2VwdGlvbiBiZWxvdywg
aSBoYXZlIG5vIGlkZWEgdG8gZmlndXJlIG91dCB0aGUgbWVzc2FnZSBiZWxvdy4gY291bGQg
eW91IGdpdmUgbWUgc29tZSBzdWdnZXN0aW9uIG9yIHNob3cgbWUgc29tZSBkb2N1bWVudCB0
byBnZXQgb3V0IHRoaXMgaXNzdWVzPz8gaSBub3RpY2VkIHRoZXJlIGlzIHRyYWNlIG9wdGlv
biBpbiB0aGUgcWV1bXUsIGJ1dCBkb24ndCBrbm93IGhvdyB0byB1c2UgaXQgbW9yZSBlZmZp
Y2VudGx5Lg0KDQp0aGFua3MuDQpqYXNvbg0KDQpxZW11OiBoYXJkd2FyZSBlcnJvcjogaWNw
X2NvbnRyb2xfd3JpdGU6IEJhZCBvZmZzZXQgNzg5Njg4DQoNCkNQVSAjMDoNClIwMD0wMDAw
MDAwMCBSMDE9Y2I3ODk2ODggUjAyPTAwMDAwMDAwIFIwMz0wMDAwMDAwMA0KUjA0PTAwMTA5
YTBjIFIwNT0wMDAwMDUwNSBSMDY9MDAwMDA2MDYgUjA3PTAwMDAwNzA3DQpSMDg9MDAwMDA4
MDggUjA5PTAwMDAwOTA5IFIxMD0wMDAwMTAxMCBSMTE9MDAxMGM0NmMNClIxMj0wMDAwMDAw
YSBSMTM9MDAwN2UwMDAgUjE0PTAwMDAwMDI4IFIxNT0wMDAwMDAwNA0KUFNSPTYwMDAwMWRi
IC1aQy0gQSB1bmQzMg0KczAwPTAwMDAwMDAwIHMwMT0wMDAwMDAwMCBkMDA9MDAwMDAwMDAw
MDAwMDAwMA0KczAyPTAwMDAwMDAwIHMwMz0wMDAwMDAwMCBkMDE9MDAwMDAwMDAwMDAwMDAw
MA0KczA0PTAwMDAwMDAwIHMwNT0wMDAwMDAwMCBkMDI9MDAwMDAwMDAwMDAwMDAwMA0KczA2
PTAwMDAwMDAwIHMwNz0wMDAwMDAwMCBkMDM9MDAwMDAwMDAwMDAwMDAwMA0KczA4PTAwMDAw
MDAwIHMwOT0wMDAwMDAwMCBkMDQ9MDAwMDAwMDAwMDAwMDAwMA0KczEwPTAwMDAwMDAwIHMx
MT0wMDAwMDAwMCBkMDU9MDAwMDAwMDAwMDAwMDAwMA0KczEyPTAwMDAwMDAwIHMxMz0wMDAw
MDAwMCBkMDY9MDAwMDAwMDAwMDAwMDAwMA0KczE0PTAwMDAwMDAwIHMxNT0wMDAwMDAwMCBk
MDc9MDAwMDAwMDAwMDAwMDAwMA0KczE2PTAwMDAwMDAwIHMxNz0wMDAwMDAwMCBkMDg9MDAw
MDAwMDAwMDAwMDAwMA0KczE4PTAwMDAwMDAwIHMxOT0wMDAwMDAwMCBkMDk9MDAwMDAwMDAw
MDAwMDAwMA0KczIwPTAwMDAwMDAwIHMyMT0wMDAwMDAwMCBkMTA9MDAwMDAwMDAwMDAwMDAw
MA0KczIyPTAwMDAwMDAwIHMyMz0wMDAwMDAwMCBkMTE9MDAwMDAwMDAwMDAwMDAwMA0KczI0
PTAwMDAwMDAwIHMyNT0wMDAwMDAwMCBkMTI9MDAwMDAwMDAwMDAwMDAwMA0KczI2PTAwMDAw
MDAwIHMyNz0wMDAwMDAwMCBkMTM9MDAwMDAwMDAwMDAwMDAwMA0KczI4PTAwMDAwMDAwIHMy
OT0wMDAwMDAwMCBkMTQ9MDAwMDAwMDAwMDAwMDAwMA0KczMwPTAwMDAwMDAwIHMzMT0wMDAw
MDAwMCBkMTU9MDAwMDAwMDAwMDAwMDAwMA0KRlBTQ1I6IDAwMDAwMDAwDQpBYm9ydGVkIChj
b3JlIGR1bXBlZCk=

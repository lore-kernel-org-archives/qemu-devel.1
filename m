Received: from eggs.gnu.org ([2001:4830:134:3::10]:35953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1d7wpe-0005zT-GX
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <4345099@qq.com>) id 1d7wpb-0004r8-E0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:33:06 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:43438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <4345099@qq.com>) id 1d7wpa-0004pR-QD
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:33:03 -0400
From: "=?ISO-8859-1?B?aGVhdnliaXJk?=" <4345099@qq.com>
Mime-Version: 1.0
Date: Tue, 9 May 2017 12:32:57 +0800
Message-ID: <tencent_025CFFC03619731459E0872A@qq.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Subject: [Qemu-devel]  timer configure for QEMU versatilepb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?= <peter.maydell@linaro.org>
Cc: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>

SGkgUGV0ZXIgYW5kIHFlbXUtZGV2ZWwsDQoNCkkgYW0gdHJ5aW5nIHRvIHBvcnQgb25lIHNp
bXBsZSBSVE9TIHRvIFFFTVUgdmVyc2F0aWxlcGIsICBob3dldmVyLCBpIGZvdW5kIHRoZSBT
SUMgYWRkcmVzcyhhY3R1YWxseSBQSUMpIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBQSUMgaW4g
dGhlIGludGVncmF0b3JjcC5jIGV2ZW4gdGhvdWdoIHRoZXkgYXJlIHNhbWUgYXJtOTI2LCBi
ZXNpZGVzLCB0aGUgUElDIHJlZ2lzdGVyIGJpdCBkZWZpbml0aW9uIGlzIHNvbWUgZGlmZmVy
ZW50IGJldHdlZW4gdmVyc2F0aWxlcGIgYW5kIGludGVncmF0b3JjcCBjb21wYXJlZCBieSB0
aGUgaWNwX3BpY19yZWFkL2ljcF9waWNfcmVhZCBpbnRlcmZhY2UuDQoNCjEgYWRkcmVzcyBk
ZWZmZXJlbnQgYmV0d2VlbiB2ZXJzYXRpbGVwYiBhbmQgaW50ZWdyYXRvcmNwDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZXJzYXRpbGVwYiAgICAgICAg
IGludGVncmF0b3JjcA0KVElNRVJfMCBhZHJlc3MgICAgICAgICAgICAgMHgxMDFlMjAwMCAg
ICAgICAweDEzMDAwMDAwDQpBRERSRVNTX1BJQyAgICAgICAgICAgICAgICAgMHgxMDAwMzAw
MCAgICAgMHgxNDAwMDAwMA0KDQppIGhhZCB0cmllZCB0aGUgMiBhZGRyZXNzIGFib3ZlIHRv
IHR1cm4gb24gdGhlIHRpbWVyMCBidXQgaXQgaXMgZmFpbGVkIHdpdGggdmVyc2F0aWxlcGIs
IGl0IGlzIG9rIHRvIHR1cm4gb24gdGhlIGludGVncmF0b3JjcCB0aW1lcjAgd2l0aCAweDEz
MDAwMDAwIHRpbWVyMCBhZGRyIGFuZCAweDE0MDAwMDAwIGZvciBQSUMuDQoNCjIgUElDIHJl
Z2lzdGVyIGJpdCBkaWZmZXJlbmNlIGFmdGVyIGJpdDgNCg0KDQoyLjEgaW50ZXJncmF0b3Jj
cCBkZWZpbml0aW9uDQogICAgY2FzZSA4OiAvKiBGUlFfU1RBVFVTICovDQogICAgICAgIHJl
dHVybiBzLT5sZXZlbCAmIHMtPmZpcV9lbmFibGVkOw0KICAgIGNhc2UgOTogLyogRlJRX1JB
V1NUQVQgKi8NCiAgICAgICAgcmV0dXJuIHMtPmxldmVsOw0KICAgIGNhc2UgMTA6IC8qIEZS
UV9FTkFCTEVTRVQgKi8NCiAgICAgICAgcmV0dXJuIHMtPmZpcV9lbmFibGVkOw0KICAgIGNh
c2UgMTE6IC8qIEZSUV9FTkFCTEVDTFIgKi8NCg0KICAgdmVyc2F0aWxlcGIgU0lDIGRlZmlu
aXRpb24gDQogICAgY2FzZSA4OiAvKiBQSUNFTkFCTEUgKi8NCiAgICAgICAgcmV0dXJuIHMt
PnBpY19lbmFibGU7DQogICAgY2FzZSA5OiAvKiBQSUNFTkNMUiAqLw0KICAgICAgICBzLT5w
aWNfZW5hYmxlICY9IH52YWx1ZTsNCiAgICAgICAgdnBiX3NpY191cGRhdGVfcGljKHMpOw0K
ICAgICAgICBicmVhazsNCg0KQ291bGQgeW91IGNvbmZpcm0gZm9yIG1lIFBJQyByZWdpc3Rl
ciBiaXQgZGVmaW5pdGlvbiBhbmQgdGhlIFBJQyBhZGRyZXNzL3RpbWVyMCBhZGRyZXNzIGlu
IHRoZSB2ZXJzYXRpbGVwYiBRRU1VIG9yIHdoZXJlIGkgY2FuIGZpbmQgc29tZSBpbmZvcm1h
dGlvbiBleGFjdGx5Lg0KDQp0aGFua3MNCmphc29u

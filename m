Received: from eggs.gnu.org ([209.51.188.92]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aQ-0007n4-Am
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aP-0002BR-3S
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aO-0001vk-Kx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:29 -0400
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Tue, 9 Apr 2019 23:55:17 +0000
Message-ID: <20190409235401.12671-2-alistair.francis@wdc.com>
References: <20190409235401.12671-1-alistair.francis@wdc.com>
In-Reply-To: <20190409235401.12671-1-alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68FC75E61BE6C4599B0C20AFFBA0273@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PULL 1/1] device_tree: Fix integer overflowing in
 load_device_tree()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, Markus Armbruster <armbru@redhat.com>, Kurtis Miller <kurtis.miller@nccgroup.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>

RnJvbTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQpJZiB0aGUgdmFs
dWUgb2YgZ2V0X2ltYWdlX3NpemUoKSBleGNlZWRzIElOVF9NQVggLyAyIC0gMTAwMDAsIHRoZQ0K
Y29tcHV0YXRpb24gb2YgQGR0X3NpemUgb3ZlcmZsb3dzIHRvIGEgbmVnYXRpdmUgbnVtYmVyLCB3
aGljaCB0aGVuDQpnZXRzIGNvbnZlcnRlZCB0byBhIHZlcnkgbGFyZ2Ugc2l6ZV90IGZvciBnX21h
bGxvYzAoKSBhbmQNCmxvYWRfaW1hZ2Vfc2l6ZSgpLiAgSW4gdGhlIChmb3J0dW5hdGVseSBpbXBy
b2JhYmxlKSBjYXNlIGdfbWFsbG9jMCgpDQpzdWNjZWVkcyBhbmQgbG9hZF9pbWFnZV9zaXplKCkg
c3Vydml2ZXMsIHdlJ2QgYXNzaWduIHRoZSBuZWdhdGl2ZQ0KbnVtYmVyIHRvICpzaXplcC4gIFdo
YXQgdGhhdCB3b3VsZCBkbyB0byB0aGUgY2FsbGVycyBJIGNhbid0IHNheSwgYnV0DQppdCdzIHVu
bGlrZWx5IHRvIGJlIGdvb2QuDQoNCkZpeCBieSByZWplY3RpbmcgaW1hZ2VzIHdob3NlIHNpemUg
d291bGQgb3ZlcmZsb3cuDQoNClJlcG9ydGVkLWJ5OiBLdXJ0aXMgTWlsbGVyIDxrdXJ0aXMubWls
bGVyQG5jY2dyb3VwLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1i
cnVAcmVkaGF0LmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQHJlZGhhdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQpNZXNzYWdlLUlkOiA8MjAxOTA0MDkxNzQwMTguMjU3OTgtMS1h
cm1icnVAcmVkaGF0LmNvbT4NCi0tLQ0KIGRldmljZV90cmVlLmMgfCA0ICsrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kZXZpY2VfdHJlZS5jIGIv
ZGV2aWNlX3RyZWUuYw0KaW5kZXggMjk2Mjc4ZTEyYS4uZjhiNDZiM2M3MyAxMDA2NDQNCi0tLSBh
L2RldmljZV90cmVlLmMNCisrKyBiL2RldmljZV90cmVlLmMNCkBAIC04NCw2ICs4NCwxMCBAQCB2
b2lkICpsb2FkX2RldmljZV90cmVlKGNvbnN0IGNoYXIgKmZpbGVuYW1lX3BhdGgsIGludCAqc2l6
ZXApDQogICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWVfcGF0aCk7DQogICAgICAgICBnb3Rv
IGZhaWw7DQogICAgIH0NCisgICAgaWYgKGR0X3NpemUgPiBJTlRfTUFYIC8gMiAtIDEwMDAwKSB7
DQorICAgICAgICBlcnJvcl9yZXBvcnQoIkRldmljZSB0cmVlIGZpbGUgJyVzJyBpcyB0b28gbGFy
Z2UiLCBmaWxlbmFtZV9wYXRoKTsNCisgICAgICAgIGdvdG8gZmFpbDsNCisgICAgfQ0KIA0KICAg
ICAvKiBFeHBhbmQgdG8gMnggc2l6ZSB0byBnaXZlIGVub3VnaCByb29tIGZvciBtYW5pcHVsYXRp
b24uICAqLw0KICAgICBkdF9zaXplICs9IDEwMDAwOw0KLS0gDQoyLjIxLjANCg0K

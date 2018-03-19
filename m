Received: from eggs.gnu.org ([2001:4830:134:3::10]:39753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1exmit-0005Za-FB
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1exmiq-0004IU-Da
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:48:39 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:37894 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1exmip-0004HU-Oj
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:48:36 -0400
Date: Mon, 19 Mar 2018 12:48:26 +0800 (CST)
Message-ID: <201803191248261240910@zte.com.cn>
In-Reply-To: <4c7e78e1-da12-5346-e7e7-13b52882e31c@gmail.com>
References: 201803190949243031468@zte.com.cn,
	4c7e78e1-da12-5346-e7e7-13b52882e31c@gmail.com
Mime-Version: 1.0
From: <jiang.biao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_2/8=5D_migration=3A_stop_allocat?=
 =?utf-8?q?ing_andfreeingmemory_frequently?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, pbonzini@redhat.com

Pj4+ICsgICAgZXJyID0gZGVmbGF0ZShzdHJlYW0sIFpfRklOSVNIKTsKPj4+ICsgICAgaWYgKGVy
ciAhPSBaX1NUUkVBTV9FTkQpIHsKPj4+ICsgICAgICAgIHJldHVybiAtMTsKPj4+ICsgICAgfQo+
Pj4gKwo+Pj4gKyAgICByZXR1cm4gc3RyZWFtLT5uZXh0X291dCAtIGRlc3Q7Cj4+PiArfQo+Pj4g
Kwo+Pj4KPj4+IEBAIC02ODMsOCArNzA3LDEwIEBAIHNzaXplX3QgcWVtdV9wdXRfY29tcHJlc3Np
b25fZGF0YShRRU1VRmlsZSAqZiwgY29uc3QgdWludDhfdCAqcCwgc2l6ZV90IHNpemUsCj4+PiBy
ZXR1cm4gLTE7Cj4+PiB9Cj4+PiB9Cj4+PiAtICAgIGlmIChjb21wcmVzczIoZi0+YnVmICsgZi0+
YnVmX2luZGV4ICsgc2l6ZW9mKGludDMyX3QpLCAodUxvbmdmICopJmJsZW4sCj4+PiAtICAgICAg
ICAgICAgICAgICAgKEJ5dGVmICopcCwgc2l6ZSwgbGV2ZWwpICE9IFpfT0spIHsKPj4+ICsKPj4+
ICsgICAgYmxlbiA9IHFlbXVfY29tcHJlc3NfZGF0YShzdHJlYW0sIGYtPmJ1ZiArIGYtPmJ1Zl9p
bmRleCArIHNpemVvZihpbnQzMl90KSwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBibGVuLCBwLCBzaXplKTsKPj4gVGhlICJsZXZlbCIgcGFyYW1ldGVyIGlzIG5ldmVyIHVzZWQg
YWZ0ZXIgdGhlIHBhdGNoLCBjb3VsZCB3ZSBqdXN0IHJlbW92ZWQgaXQ/Cj4+IE9uIHRoZSBvdGhl
ciBoYW5kLCBkZWZsYXRlKCkgb2YgemxpYiBzdXBwb3J0cyBjb21wcmVzc2lvbiBsZXZlbCB0b28o
YnkKPj4gZGVmbGF0ZUluaXQoc3RyZWFtLCBsZXZlbCkpLCBzaG91bGQgd2UganVzdCByZXVzZSB0
aGUgbGV2ZWwgcHJvcGVybHk/ICBJZiBub3QsIHRoZQo+PiAqbWlncmF0ZSBwYXJhbWV0ZXIgY29t
cHJlc3NfbGV2ZWwqIHdpbGwgYmUgdXNlbGVzcy4KPiAKPiBUaGUgJ2xldmVsJyBoYXMgYmVlbiBw
dXNoZWQgdG8gQHN0cmVhbToKPiArICAgICAgICBpZiAoZGVmbGF0ZUluaXQoJmNvbXBfcGFyYW1b
aV0uc3RyZWFtLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBtaWdyYXRlX2NvbXByZXNz
X2xldmVsKCkpICE9IFpfT0spIHsKPiArICAgICAgICAgICAgZ290byBleGl0Owo+ICsgICAgICAg
IH0KSW5kZWVkLCBJIG1pc3NlZCB0aGF0LiAKUmV2aWV3ZWQtYnk6IEppYW5nIEJpYW8gPGppYW5n
LmJpYW8yQHp0ZS5jb20uY24+

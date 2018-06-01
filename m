Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1fOfz0-0001zF-Hv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1fOfyv-00021x-KL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:04:26 -0400
Received: from [45.249.212.255] (port=35836 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
	id 1fOfyv-0001x3-7x
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 05:04:21 -0400
From: xuyandong <xuyandong2@huawei.com>
Date: Fri, 1 Jun 2018 08:17:12 +0000
Message-ID: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGkgdGhlcmUsDQoNCkkgYW0gZG9pbmcgc29tZSB0ZXN0IG9uIHFlbXUgdmNwdSBob3RwbHVnIGFu
ZCBJIHJ1biBpbnRvIHNvbWUgdHJvdWJsZS4NCkFuIGVtdWxhdGlvbiBmYWlsdXJlIG9jY3VycyBh
bmQgcWVtdSBwcmludHMgdGhlIGZvbGxvd2luZyBtc2c6DQoNCktWTSBpbnRlcm5hbCBlcnJvci4g
U3ViZXJyb3I6IDENCmVtdWxhdGlvbiBmYWlsdXJlDQpFQVg9MDAwMDAwMDAgRUJYPTAwMDAwMDAw
IEVDWD0wMDAwMDAwMCBFRFg9MDAwMDA2MDANCkVTST0wMDAwMDAwMCBFREk9MDAwMDAwMDAgRUJQ
PTAwMDAwMDAwIEVTUD0wMDAwZmZmOA0KRUlQPTAwMDBmZjUzIEVGTD0wMDAxMDA4MiBbLS1TLS0t
LV0gQ1BMPTAgSUk9MCBBMjA9MSBTTU09MCBITFQ9MA0KRVMgPTAwMDAgMDAwMDAwMDAgMDAwMGZm
ZmYgMDAwMDkzMDANCkNTID1mMDAwIDAwMGYwMDAwIDAwMDBmZmZmIDAwMDA5YjAwDQpTUyA9MDAw
MCAwMDAwMDAwMCAwMDAwZmZmZiAwMDAwOTMwMA0KRFMgPTAwMDAgMDAwMDAwMDAgMDAwMGZmZmYg
MDAwMDkzMDANCkZTID0wMDAwIDAwMDAwMDAwIDAwMDBmZmZmIDAwMDA5MzAwDQpHUyA9MDAwMCAw
MDAwMDAwMCAwMDAwZmZmZiAwMDAwOTMwMA0KTERUPTAwMDAgMDAwMDAwMDAgMDAwMGZmZmYgMDAw
MDgyMDANClRSID0wMDAwIDAwMDAwMDAwIDAwMDBmZmZmIDAwMDA4YjAwaWYNCkdEVD0gICAgIDAw
MDAwMDAwIDAwMDBmZmZmDQpJRFQ9ICAgICAwMDAwMDAwMCAwMDAwZmZmZg0KQ1IwPTYwMDAwMDEw
IENSMj0wMDAwMDAwMCBDUjM9MDAwMDAwMDAgQ1I0PTAwMDAwMDAwDQpEUjA9MDAwMDAwMDAwMDAw
MDAwMCBEUjE9MDAwMDAwMDAwMDAwMDAwMCBEUjI9MDAwMDAwMDAwMDAwMDAwMCBEUjM9MDAwMDAw
MDAwMDAwMDAwMA0KRFI2PTAwMDAwMDAwZmZmZjBmZjAgRFI3PTAwMDAwMDAwMDAwMDA0MDANCkVG
RVI9MDAwMDAwMDAwMDAwMDAwMA0KQ29kZT0zMSBkMiBlYiAwNCA2NiA4MyBjYSBmZiA2NiA4OSBk
MCA2NiA1YiA2NiBjMyA2NiA4OSBkMCA2NiBjMyA8Y2Y+IDY2IDY4IDIxIDhhIDAwIDAwIGU5IDA4
IGQ3IDY2IDU2IDY2IDUzIDY2IDgzIGVjIDBjIDY2IDg5IGMzIDY2IGU4IGNlIDdiIGZmIGZmIDY2
IDg5IGM2DQoNCkkgbm90aWNlIHRoYXQgZ3Vlc3QgaXMgc3RpbGwgcnVubmluZyBTZWFiQklPUyBp
biByZWFsIG1vZGUgd2hlbiB0aGUgdmNwdSBoYXMganVzdCBiZWVuIHBsdWdlZC4NClRoaXMgZW11
bGF0aW9uIGZhaWx1cmUgY2FuIGJlIHN0ZWFkbHkgcmVwcm9kdWNlZCBpZiBJIGFtIGRvaW5nIHZj
cHUgaG90cGx1ZyBkdXJpbmcgVk0gbGF1bmNoIHByb2Nlc3MuDQpBZnRlciBzb21lIGRpZ2dpbmcs
IEkgZmluZCB0aGlzIEtWTSBpbnRlcm5hbCBlcnJvciBzaG93cyB1cCBiZWNhdXNlIEtWTSBjYW5u
b3QgZW11bGF0ZSBzb21lIE1NSU8gKGdwYSAweGZmZjUzICkuDQoNClNvIEkgYW0gY29uZnVzZWQs
DQooMSkgZG9lcyBxZW11IHN1cHBvcnQgdmNwdSBob3RwbHVnIGV2ZW4gaWYgZ3Vlc3QgaXMgcnVu
bmluZyBzZWFiaW9zID8NCigyKSB0aGUgZ3BhICgweGZmZjUzKSBpcyBhbiBhZGRyZXNzIG9mIEJJ
T1MgUk9NIHNlY3Rpb24sIHdoeSBkb2VzIGt2bSBjb25maXJtIGl0IGFzIGEgbW1pbyBhZGRyZXNz
IGluY29ycmVjdGx5Pw0K

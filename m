Received: from eggs.gnu.org ([209.51.188.92]:58525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h0ivp-00025N-Or
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h0ivp-0001vE-3s
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:26:41 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:53592 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jerry.lilijun@huawei.com>)
	id 1h0ivo-0001qh-P1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 03:26:41 -0500
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.53])
	by Forcepoint Email with ESMTP id 80474B834345EE87BA6E
	for <qemu-devel@nongnu.org>; Mon,  4 Mar 2019 16:26:30 +0800 (CST)
From: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Date: Mon, 4 Mar 2019 08:26:23 +0000
Message-ID: <40280F65B1B0B44E8089ED31C01616EBA3947B1A@dggeml529-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] Question about VM inner route entry's lost when
 vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: wangyunjian <wangyunjian@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

DQpIaSBhbGwsDQoNCiAgICAgIEkgYW0gcnVubmluZyBteSBWTSB1c2luZyB2aG9zdC11c2VyIE5J
QyB3aXRoIE9WUy1EUERLLiAgVGhlIHN0ZXBzIG9mIG15IHF1ZXN0aW9uIGlzIHNob3duIGFzIGZv
bGxvd3M6DQogICAgIDEpIEluIHRoZSBWTSwgSSBhZGQgb25lIHJvdXRlIGVudHJ5IG1hbnVhbGx5
IG9uIHRoZSB2TklDIGV0aDAgdXNpbmcgdGhlIGxpbnV4IHRvb2wgcm91dGUuIA0KICAgICAyKSBX
aGVuIHJlc3RhcnRpbmcgb3BlbnZzd2l0Y2ggc2VydmljZSBmb3IgdGhlIGNyYXNoIG9mIHRoZSBv
dnMtdnN3aXRjaGQsIHFlbXUncyB2aG9zdC11c2VyIHJlY29ubmVjdGVkIHN1Y2Nlc3NmdWxseSBh
ZnRlciA0MHMuICANCiAgICAgMykgSGVyZSBWTSdzIHZOSUMgd2lsbCByZWNlaXZlIGxpbmsgZG93
biBhbmQgdXAgZXZlbnRzLCB0aGUgaW50ZXJ2YWwgYmV0d2VlbiB0aGUgdHdvIGV2ZW50cyBpcyBh
Ym91dCA0MHMuDQogICAgIDMpIEJ1dCB0aGF0IHJvdXRlIGVudHJ5IGRpc2FwcGVhcmVkIGFuZCB0
aGF0IHdpbGwgY2F1c2UgdXNlcidzIG5ldHdvcmsgdHJhZmZpYyBpbnRlcnJ1cHRpb24gYW5kIHRo
ZSBzZXJ2aWNlIGZhaWxlZC4NCg0KICAgICBJcyB0aGVyZSBzb21lIHdvcmsgb24gdGhpcyBwcm9i
bGVtPyAgQ2FuIHdlIGtlZXAgdGhlIHZOSUMncyBsaW5rIHVwIHN0YXR1cyB3aGVuIGRvIHZob3N0
LXVzZXIncyByZWNvbm5lY3Rpbmcgd29yaz8NCg0KICAgICBUaGFua3MuDQoNCkplcnJ5DQoNCg==

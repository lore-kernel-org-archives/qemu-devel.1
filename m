Received: from eggs.gnu.org ([2001:4830:134:3::10]:36899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liqsub1@163.com>) id 1gEZMe-0000Ub-Ix
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liqsub1@163.com>) id 1gEZMa-0007nz-1l
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:31:20 -0400
Received: from m12-244.163.com ([220.181.12.244]:41752)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liqsub1@163.com>) id 1gEZMY-0007j3-TF
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:31:15 -0400
Date: Mon, 22 Oct 2018 20:15:15 +0800
From: "liqsub1"<liqsub1@163.com>
Message-ID: <4d7675ee.374e.1669bb366e4.Coremail.liqsub1@163.com>
In-Reply-To: <20181022120908.13285-1-ppandit@redhat.com>
References: <20181022120908.13285-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 1/3] arm: check bit index before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

DQoNCjIwMTgtMTAtMjIgDQoNCmxpcXN1YjEgDQoNCg0KDQrlj5Hku7bkurrvvJpQIEogUCA8cHBh
bmRpdEByZWRoYXQuY29tPg0K5Y+R6YCB5pe26Ze077yaMjAxOC0xMC0yMyAwMTozOQ0K5Li76aKY
77yaW1FlbXUtZGV2ZWxdIFtQQVRDSCAxLzNdIGFybTogY2hlY2sgYml0IGluZGV4IGJlZm9yZSB1
c2UNCuaUtuS7tuS6uu+8miJRZW11IERldmVsb3BlcnMiPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4N
CuaKhOmAge+8miJQZXRlciBNYXlkZWxsIjxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+LCJNb2d1
b2ZhbmciPG1vZ3VvZmFuZ0BodWF3ZWkuY29tPiwiUHJhc2FkIEogUGFuZGl0IjxwanBAZmVkb3Jh
cHJvamVjdC5vcmc+DQoNCkZyb206IFByYXNhZCBKIFBhbmRpdCA8cGpwQGZlZG9yYXByb2plY3Qu
b3JnPiANCg0KV2hpbGUgcGVyZm9ybWluZyBncGlvIHdyaXRlIHZpYSBzdHJvbmdhcm1fZ3Bpb19o
YW5kbGVyX3VwZGF0ZSANCnJvdXRpbmUsIHRoZSAnYml0JyBpbmRleCBjb3VsZCBhY2Nlc3MgYmV5
b25kIHMtPmhhbmRsZXJbMjhdIGFycmF5LiANCkFkZCBjaGVjayB0byBhdm9pZCBPT0IgYWNjZXNz
LiANCg0KUmVwb3J0ZWQtYnk6IE1vZ3VvZmFuZyA8bW9ndW9mYW5nQGh1YXdlaS5jb20+IA0KU2ln
bmVkLW9mZi1ieTogUHJhc2FkIEogUGFuZGl0IDxwanBAZmVkb3JhcHJvamVjdC5vcmc+IA0KLS0t
IA0KIGh3L2FybS9zdHJvbmdhcm0uYyB8IDQgKysrLSANCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pIA0KDQpkaWZmIC0tZ2l0IGEvaHcvYXJtL3N0cm9uZ2Fy
bS5jIGIvaHcvYXJtL3N0cm9uZ2FybS5jIA0KaW5kZXggZWMyNjI3Mzc0ZC4uM2RkYTc1ZmVhZiAx
MDA2NDQgDQotLS0gYS9ody9hcm0vc3Ryb25nYXJtLmMgDQorKysgYi9ody9hcm0vc3Ryb25nYXJt
LmMgDQpAQCAtNTMyLDcgKzUzMiw5IEBAIHN0YXRpYyB2b2lkIHN0cm9uZ2FybV9ncGlvX2hhbmRs
ZXJfdXBkYXRlKFN0cm9uZ0FSTUdQSU9JbmZvICpzKSANCiAgDQogICAgIGZvciAoZGlmZiA9IHMt
PnByZXZfbGV2ZWwgXiBsZXZlbDsgZGlmZjsgZGlmZiBePSAxIDw8IGJpdCkgeyANCiAgICAgICAg
IGJpdCA9IGN0ejMyKGRpZmYpOyANCi0gICAgICAgIHFlbXVfc2V0X2lycShzLT5oYW5kbGVyW2Jp
dF0sIChsZXZlbCA+PiBiaXQpICYgMSk7IA0KKyAgICAgICAgaWYgKGJpdCA8IHNpemVvZihzLT5o
YW5kbGVyKSAvIHNpemVvZihzLT5oYW5kbGVyWzBdKSkgeyANCg0KSGVsbG8gUHJhc2FkLA0KTWF5
YmUgeW91IGNhbiB1c2UgQVJSQVlfU0laRSBoZXJlLg0KDQpUaGFua3MsDQpMaSBRaWFuZw0KDQor
ICAgICAgICAgICAgcWVtdV9zZXRfaXJxKHMtPmhhbmRsZXJbYml0XSwgKGxldmVsID4+IGJpdCkg
JiAxKTsgDQorICAgICAgICB9IA0KICAgICB9IA0KDQoNCg0KICANCiAgICAgcy0+cHJldl9sZXZl
bCA9IGxldmVsOyANCi0tICANCjIuMTcuMiA=

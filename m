Received: from eggs.gnu.org ([209.51.188.92]:57756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4Tr-000122-CE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4To-0003XT-OV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:42:03 -0400
Received: from mail-oln040092255038.outbound.protection.outlook.com
	([40.92.255.38]:37395
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hM4Tb-0003Cg-AN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:53 -0400
From: Alistair Francis <alistair@alistair23.me>
Date: Thu, 2 May 2019 05:41:16 +0000
Message-ID: <PSXP216MB0277D89E74F59BE18F609C9ADD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
References: <cover.1556774049.git.alistair@alistair23.me>
In-Reply-To: <cover.1556774049.git.alistair@alistair23.me>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 3/5] armv7m: Allow entry information to be
 returned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alistair23@gmail.com" <alistair23@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

QWxsb3cgdGhlIGtlcm5lbCdzIGVudHJ5IHBvaW50IGluZm9ybWF0aW9uIHRvIGJlIHJldHVybmVk
IHdoZW4gbG9hZGluZyBhDQprZXJuZWwuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+DQotLS0NCiBody9hcm0vYXJtdjdtLmMgICAgICB8
IDQgKysrLQ0KIGluY2x1ZGUvaHcvYXJtL2FybS5oIHwgNCArKystDQogMiBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9hcm0v
YXJtdjdtLmMgYi9ody9hcm0vYXJtdjdtLmMNCmluZGV4IGM0YjJhOWExZjUuLjJmMjc1NWIyMWUg
MTAwNjQ0DQotLS0gYS9ody9hcm0vYXJtdjdtLmMNCisrKyBiL2h3L2FybS9hcm12N20uYw0KQEAg
LTI4Niw3ICsyODYsNyBAQCBzdGF0aWMgdm9pZCBhcm12N21fcmVzZXQodm9pZCAqb3BhcXVlKQ0K
ICAgICBjcHVfcmVzZXQoQ1BVKGNwdSkpOw0KIH0NCiANCi12b2lkIGFybXY3bV9sb2FkX2tlcm5l
bChBUk1DUFUgKmNwdSwgY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLCBpbnQgbWVtX3NpemUp
DQordWludDY0X3QgYXJtdjdtX2xvYWRfa2VybmVsKEFSTUNQVSAqY3B1LCBjb25zdCBjaGFyICpr
ZXJuZWxfZmlsZW5hbWUsIGludCBtZW1fc2l6ZSkNCiB7DQogICAgIGludCBpbWFnZV9zaXplOw0K
ICAgICB1aW50NjRfdCBlbnRyeTsNCkBAIC0zMzMsNiArMzMzLDggQEAgdm9pZCBhcm12N21fbG9h
ZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50IG1l
bV9zaXplKQ0KICAgICAgKiBib2FyZCBtdXN0IGNhbGwgdGhpcyBmdW5jdGlvbiENCiAgICAgICov
DQogICAgIHFlbXVfcmVnaXN0ZXJfcmVzZXQoYXJtdjdtX3Jlc2V0LCBjcHUpOw0KKw0KKyAgICBy
ZXR1cm4gZW50cnk7DQogfQ0KIA0KIHN0YXRpYyBQcm9wZXJ0eSBiaXRiYW5kX3Byb3BlcnRpZXNb
XSA9IHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2FybS9hcm0uaCBiL2luY2x1ZGUvaHcvYXJt
L2FybS5oDQppbmRleCBmZmVkMzkyNTJkLi40OGQ5MTgxYjI4IDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9ody9hcm0vYXJtLmgNCisrKyBiL2luY2x1ZGUvaHcvYXJtL2FybS5oDQpAQCAtMjksMTEgKzI5
LDEzIEBAIHR5cGVkZWYgZW51bSB7DQogICogQGtlcm5lbF9maWxlbmFtZTogZmlsZSB0byBsb2Fk
DQogICogQG1lbV9zaXplOiBtZW1fc2l6ZTogbWF4aW11bSBpbWFnZSBzaXplIHRvIGxvYWQNCiAg
Kg0KKyAqIHJldHVybnM6IGxvY2F0aW9uIG9mIHRoZSBrZXJuZWwncyBlbnRyeSBwb2ludA0KKyAq
DQogICogTG9hZCB0aGUgZ3Vlc3QgaW1hZ2UgZm9yIGFuIEFSTXY3TSBzeXN0ZW0uIFRoaXMgbXVz
dCBiZSBjYWxsZWQgYnkNCiAgKiBhbnkgQVJNdjdNIGJvYXJkLiAoVGhpcyBpcyBuZWNlc3Nhcnkg
dG8gZW5zdXJlIHRoYXQgdGhlIENQVSByZXNldHMNCiAgKiBjb3JyZWN0bHkgb24gc3lzdGVtIHJl
c2V0LCBhcyB3ZWxsIGFzIGZvciBrZXJuZWwgbG9hZGluZy4pDQogICovDQotdm9pZCBhcm12N21f
bG9hZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNvbnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50
IG1lbV9zaXplKTsNCit1aW50NjRfdCBhcm12N21fbG9hZF9rZXJuZWwoQVJNQ1BVICpjcHUsIGNv
bnN0IGNoYXIgKmtlcm5lbF9maWxlbmFtZSwgaW50IG1lbV9zaXplKTsNCiANCiAvKiBhcm1fYm9v
dC5jICovDQogc3RydWN0IGFybV9ib290X2luZm8gew0KLS0gDQoyLjIxLjANCg0K

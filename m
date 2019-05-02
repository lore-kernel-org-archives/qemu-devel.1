Received: from eggs.gnu.org ([209.51.188.92]:57668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4TT-0000kw-VY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair@alistair23.me>) id 1hM4TR-0003Jd-5C
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:39 -0400
Received: from mail-hk2apc01olkn0805.outbound.protection.outlook.com
	([2a01:111:f400:febc::805]:22687
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistair@alistair23.me>)
	id 1hM4TD-0002vl-90
	for qemu-devel@nongnu.org; Thu, 02 May 2019 01:41:29 -0400
From: Alistair Francis <alistair@alistair23.me>
Date: Thu, 2 May 2019 05:40:34 +0000
Message-ID: <PSXP216MB02777FF1122DB78DEC580ACEDD340@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 0/5] Add the STM32F405 and Netduino Plus 2
 machine
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

DQpOb3cgdGhhdCB0aGUgQXJtLU00IENQVSBoYXMgYmVlbiBhZGRlZCB0byBRRU1VIHdlIGNhbiBh
ZGQgdGhlIE5ldGR1aW5vDQpQbHVzIDIgbWFjaGluZS4gVGhpcyBpcyB2ZXJ5IHNpbWlsYXIgdG8g
dGhlIFNUTTMyRjIwNSBhbmQgTmV0ZHVpbm8gMiBTb0MNCmFuZCBtYWNoaW5lLg0KDQp2MjoNCiAt
IFJlb3JkZXIgcGF0Y2hzZXQNCiAtIFJldHVybiB0aGUga2VybmVsIGVudHJ5IHBvaW50IGluc3Rl
YWQgb2YgdXNpbmcgYSBwb2ludGVyDQogLSBBZGRyZXNzIFBldGVyJ3MgY29tbWVudHMNCg0KDQpB
bGlzdGFpciBGcmFuY2lzICg1KToNCiAgaHcvbWlzYzogQWRkIHRoZSBTVE0zMkY0eHggU3lzY29u
ZmlnIGRldmljZQ0KICBody9taXNjOiBBZGQgdGhlIFNUTTMyRjR4eCBFWFRJIGRldmljZQ0KICBh
cm12N206IEFsbG93IGVudHJ5IGluZm9ybWF0aW9uIHRvIGJlIHJldHVybmVkDQogIGh3L2FybTog
QWRkIHRoZSBTVE0zMkY0eHggU29DDQogIGh3L2FybTogQWRkIHRoZSBOZXRkdWlubyBQbHVzIDIN
Cg0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKysNCiBkZWZhdWx0
LWNvbmZpZ3MvYXJtLXNvZnRtbXUubWFrICAgIHwgICA0ICsNCiBody9hcm0vS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgIHwgICA2ICsNCiBody9hcm0vTWFrZWZpbGUub2JqcyAgICAgICAgICAg
ICAgIHwgICAyICsNCiBody9hcm0vYXJtdjdtLmMgICAgICAgICAgICAgICAgICAgIHwgICA0ICst
DQogaHcvYXJtL25ldGR1aW5vcGx1czIuYyAgICAgICAgICAgICB8ICA3NyArKysrKysrKw0KIGh3
L2FybS9zdG0zMmY0MDVfc29jLmMgICAgICAgICAgICAgfCAzMDYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCiBody9taXNjL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwgICA2ICsN
CiBody9taXNjL01ha2VmaWxlLm9ianMgICAgICAgICAgICAgIHwgICAyICsNCiBody9taXNjL3N0
bTMyZjR4eF9leHRpLmMgICAgICAgICAgIHwgMTg3ICsrKysrKysrKysrKysrKysrKw0KIGh3L21p
c2Mvc3RtMzJmNHh4X3N5c2NmZy5jICAgICAgICAgfCAxNjggKysrKysrKysrKysrKysrKw0KIGh3
L21pc2MvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgfCAgMTEgKysNCiBpbmNsdWRlL2h3L2Fy
bS9hcm0uaCAgICAgICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS9ody9hcm0vc3RtMzJmNDA1
X3NvYy5oICAgICB8ICA3NCArKysrKysrDQogaW5jbHVkZS9ody9taXNjL3N0bTMyZjR4eF9leHRp
LmggICB8ICA2MCArKysrKysNCiBpbmNsdWRlL2h3L21pc2Mvc3RtMzJmNHh4X3N5c2NmZy5oIHwg
IDYxICsrKysrKw0KIDE2IGZpbGVzIGNoYW5nZWQsIDk4NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9hcm0vbmV0ZHVpbm9wbHVzMi5jDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGh3L2FybS9zdG0zMmY0MDVfc29jLmMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgaHcvbWlzYy9zdG0zMmY0eHhfZXh0aS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2Mv
c3RtMzJmNHh4X3N5c2NmZy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvYXJtL3N0
bTMyZjQwNV9zb2MuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2Mvc3RtMzJm
NHh4X2V4dGkuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2Mvc3RtMzJmNHh4
X3N5c2NmZy5oDQoNCi0tIA0KMi4yMS4wDQoNCg==

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g8Q58-00087G-1d
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g8Q57-0007hq-1x
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:23:49 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 5 Oct 2018 13:23:40 +0000
Message-ID: <8d29fbbe-6ff9-d569-3ef7-bf8899f3460c@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AD2129B018E8D449EAF5F8C1F37170B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] bdrv_replace_child crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Denis Lunev <den@virtuozzo.com>

SGkgS2V2aW4hDQoNCkluIGNvbW1pdCAzM2E2MTBjMzk4NiAiYmxvY2s6IEludm9sdmUgYmxvY2sg
ZHJpdmVycyBpbiBwZXJtaXNzaW9uIA0KZ3JhbnRpbmciIHlvdSB3cml0ZToNCiDCoMKgwqAgaWYg
KG9sZF9icykgew0KIMKgwqDCoMKgwqDCoMKgIC8qIFVwZGF0ZSBwZXJtaXNzaW9ucyBmb3Igb2xk
IG5vZGUuIFRoaXMgaXMgZ3VhcmFudGVlZCB0byBzdWNjZWVkDQogwqDCoMKgwqDCoMKgwqDCoCAq
IGJlY2F1c2Ugd2UncmUganVzdCB0YWtpbmcgYSBwYXJlbnQgYXdheSwgc28gd2UncmUgbG9vc2Vu
aW5nDQogwqDCoMKgwqDCoMKgwqDCoCAqIHJlc3RyaWN0aW9ucy4gKi8NCiDCoMKgwqDCoMKgwqDC
oCBiZHJ2X2dldF9jdW11bGF0aXZlX3Blcm0ob2xkX2JzLCAmcGVybSwgJnNoYXJlZF9wZXJtKTsN
CiDCoMKgwqDCoMKgwqDCoCBiZHJ2X2NoZWNrX3Blcm0ob2xkX2JzLCBOVUxMLCBwZXJtLCBzaGFy
ZWRfcGVybSwgTlVMTCwgDQomZXJyb3JfYWJvcnQpOw0KIMKgwqDCoMKgwqDCoMKgIGJkcnZfc2V0
X3Blcm0ob2xkX2JzLCBwZXJtLCBzaGFyZWRfcGVybSk7DQogwqDCoMKgIH0NCg0Kd2UgaGF2ZSBz
b21lIGNyYXNoZXMgb24gdGhpcyBlcnJvcl9hYm9ydCwgYmVjYXVzZSBGX1NFVExLIG9yIEZfT0ZE
X1NFVExLIA0KcmV0dXJuIGFuIGVycm9yIG9uIE5GUyAoZm9yIGV4YW1wbGUgd2hlbiByZW1vdGUg
c2VydmVyIG5vdCByZXNwb25kaW5nKS4NCg0KV2hhdCB0byBkbyB3aXRoIHRoaXM/IElzIGl0IHNh
ZmUganVzdCB0byBpZ25vcmUgdGhlIGVycm9yIGhlcmUsIGF0IGxlYXN0IA0KaW4gY2FzZSBvZiBi
ZHJ2X2RldGFjaF9jaGlsZD8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0KDQo=

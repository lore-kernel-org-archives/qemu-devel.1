Received: from eggs.gnu.org ([2001:4830:134:3::10]:44396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFy8Q-0003G9-3M
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFy8I-0007Vn-UK
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:10:24 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com
	([40.107.70.98]:20713
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gFy8I-0007NB-Ff
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:10:18 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 09:10:14 +0000
Message-ID: <51e7458e-935f-5775-af64-0908b2110ed7@wavecomp.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540383527-7923-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B3AEF6334792648BEF21A252F1C47F6@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 04/20] target/mips: Add and integrate
 MXU decoding engine placeholder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "jancraig@amazon.com" <jancraig@amazon.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

DQpPbiAyNC4xMC4xOC4gMTQ6MTgsIEFsZWtzYW5kYXIgTWFya292aWMgd3JvdGU6DQo+IEZyb206
IEFsZWtzYW5kYXIgTWFya292aWMgPGFtYXJrb3ZpY0B3YXZlY29tcC5jb20+DQo+DQo+IFByb3Zp
ZGUgdGhlIHBsYWNlaG9sZGVyIGFuZCBhZGQgdGhlIGludm9jYXRpb24gbG9naWMgZm9yIE1YVQ0K
PiBkZWNvZGluZyBlbmdpbmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kYXIgTWFya292
aWMgPGFtYXJrb3ZpY0B3YXZlY29tcC5jb20+DQo+IC0tLQ0KPiAgIHRhcmdldC9taXBzL3RyYW5z
bGF0ZS5jIHwgOCArKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9taXBzL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L21pcHMv
dHJhbnNsYXRlLmMNCj4gaW5kZXggZmVmZTlhYy4uMTI4Y2FiZSAxMDA2NDQNCj4gLS0tIGEvdGFy
Z2V0L21pcHMvdHJhbnNsYXRlLmMNCj4gKysrIGIvdGFyZ2V0L21pcHMvdHJhbnNsYXRlLmMNCj4g
QEAgLTIzODQ0LDYgKzIzODQ0LDEyIEBAIHN0YXRpYyB2b2lkIGRlY29kZV9vcGNfc3BlY2lhbChD
UFVNSVBTU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpDQo+ICAgICAgIH0NCj4gICB9DQo+
ICAgDQo+ICtzdGF0aWMgdm9pZCBkZWNvZGVfb3BjX214dShDUFVNSVBTU3RhdGUgKmVudiwgRGlz
YXNDb250ZXh0ICpjdHgpDQo+ICt7DQo+ICsgICAgTUlQU19JTlZBTCgiZGVjb2RlX29wY19teHUi
KTsNCj4gKyAgICBnZW5lcmF0ZV9leGNlcHRpb25fZW5kKGN0eCwgRVhDUF9SSSk7DQo+ICt9DQo+
ICsNCj4gICBzdGF0aWMgdm9pZCBkZWNvZGVfb3BjX3NwZWNpYWwyX2xlZ2FjeShDUFVNSVBTU3Rh
dGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpDQo+ICAgew0KPiAgICAgICBpbnQgcnMsIHJ0LCBy
ZDsNCj4gQEAgLTI2MDg3LDYgKzI2MDkzLDggQEAgc3RhdGljIHZvaWQgZGVjb2RlX29wYyhDUFVN
SVBTU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpDQo+ICAgICAgIGNhc2UgT1BDX1NQRUNJ
QUwyOg0KPiAgICAgICAgICAgaWYgKChjdHgtPmluc25fZmxhZ3MgJiBJTlNOX1I1OTAwKSAmJiAo
Y3R4LT5pbnNuX2ZsYWdzICYgQVNFX01NSSkpIHsNCj4gICAgICAgICAgICAgICBkZWNvZGVfdHg3
OV9tbWkoZW52LCBjdHgpOw0KPiArICAgICAgICB9IGVsc2UgaWYgKGN0eC0+aW5zbl9mbGFncyAm
IEFTRV9NWFUpIHsNCj4gKyAgICAgICAgICAgIGRlY29kZV9vcGNfbXh1KGVudiwgY3R4KTsNCg0K
DQpJcyB0aGUgYmVzdCB3YXkgdG8gaW1wbGVtZW50IHRoaXMgdG8gaW5jbHVkZSBwcm9jZXNzaW5n
IG9mIE1VTCwgQ0xaLCANCkNMTywgU0REUCBpbnN0cnVjdGlvbnMgaW50byBkZWNvZGVfb3BjX214
dSBhcyB0aGVpciBlbmNvZGluZ3MgYXJlbid0IA0Kb3ZlcmxhaWQgYnkgTVhVIGluc3RydWN0aW9u
cw0KDQpjb25zaWRlcmluZyBNSVBTIFNQRUNJQUwyIGluc3RydWN0aW9uIHBvb2wgYW5kIE1YVSBJ
bnN0cnVjdGlvbiBTZXQ/DQoNCg0KPiAgICAgICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgICAg
ICBkZWNvZGVfb3BjX3NwZWNpYWwyX2xlZ2FjeShlbnYsIGN0eCk7DQo+ICAgICAgICAgICB9DQo=

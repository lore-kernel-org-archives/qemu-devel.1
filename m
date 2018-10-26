Received: from eggs.gnu.org ([2001:4830:134:3::10]:45778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFyEg-00062Q-8j
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFyEc-0003JL-VL
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:16:54 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com
	([40.107.70.98]:63267
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gFyEc-0003Ir-PY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:16:50 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 09:16:47 +0000
Message-ID: <5237e179-f13a-3c0c-dfbf-1ea56dba1e9e@wavecomp.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540383527-7923-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDA3B9FF1C19A842A331D778CC93D8FF@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 06/20] target/mips: Add bit encoding for
 MXU accumulate add/sub 1-bit pattern 'aptn1'
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
IEFsZWtzYW5kYXIgTWFya292aWMgPGFtYXJrb3ZpY0B3YXZlY29tcC5jb20+DQo+DQo+IEFkZCBi
aXQgZW5jb2RpbmcgZm9yIE1YVSBhY2N1bXVsYXRlIGFkZC9zdWJ0cmFjdCAxLWJpdCBwYXR0ZXJu
DQo+ICdhcHRuMScuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kYXIgTWFya292aWMgPGFt
YXJrb3ZpY0B3YXZlY29tcC5jb20+DQo+IC0tLQ0KPiAgIHRhcmdldC9taXBzL3RyYW5zbGF0ZS5j
IHwgNiArKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCg0KUmV2
aWV3ZWQtYnk6IFN0ZWZhbiBNYXJrb3ZpYyA8c21hcmtvdmljQHdhdmVjb21wLmNvbT4NCg0KDQo+
IGRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy90cmFuc2xhdGUuYyBiL3RhcmdldC9taXBzL3RyYW5z
bGF0ZS5jDQo+IGluZGV4IGVkNzJiMzIuLmYyNzRhYzEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9t
aXBzL3RyYW5zbGF0ZS5jDQo+ICsrKyBiL3RhcmdldC9taXBzL3RyYW5zbGF0ZS5jDQo+IEBAIC0y
Mzg0NCw2ICsyMzg0NCwxMiBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfb3BjX3NwZWNpYWwoQ1BVTUlQ
U1N0YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4KQ0KPiAgICAgICB9DQo+ICAgfQ0KPiAgIA0K
PiArDQo+ICsvKiBNWFUgYWNjdW11bGF0ZSBhZGQvc3VidHJhY3QgMS1iaXQgcGF0dGVybiAnYXB0
bjEnICovDQo+ICsjZGVmaW5lIE1YVV9BUFROMV9BICAgIDANCj4gKyNkZWZpbmUgTVhVX0FQVE4x
X1MgICAgMQ0KPiArDQo+ICsNCj4gICAvKg0KPiAgICAqDQo+ICAgICogRGVjb2RlIE1YVSBwb29s
MDANCg==

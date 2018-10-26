Received: from eggs.gnu.org ([2001:4830:134:3::10]:45920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFyFY-0007Lx-V1
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFyFV-0003o5-PF
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:17:48 -0400
Received: from mail-eopbgr700123.outbound.protection.outlook.com
	([40.107.70.123]:21088
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gFyFV-0003nC-Iy
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:17:45 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Fri, 26 Oct 2018 09:17:42 +0000
Message-ID: <657cf136-8441-6212-13d0-8f216e9af82e@wavecomp.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540383527-7923-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0275980FA2DAB84C97797B64D1341AC1@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 08/20] target/mips: Add bit encoding for
 MXU execute add/sub pattern 'eptn2'
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
aXQgZW5jb2RpbmcgZm9yIE1YVSBleGVjdXRlIDItYml0IGFkZC9zdWJ0cmFjdCBwYXR0ZXJuICdl
cHRuMicuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZWtzYW5kYXIgTWFya292aWMgPGFtYXJrb3Zp
Y0B3YXZlY29tcC5jb20+DQo+IC0tLQ0KPiAgIHRhcmdldC9taXBzL3RyYW5zbGF0ZS5jIHwgNiAr
KysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCg0KUmV2aWV3ZWQt
Ynk6IFN0ZWZhbiBNYXJrb3ZpYyA8c21hcmtvdmljQHdhdmVjb21wLmNvbT4NCg0KDQo+IGRpZmYg
LS1naXQgYS90YXJnZXQvbWlwcy90cmFuc2xhdGUuYyBiL3RhcmdldC9taXBzL3RyYW5zbGF0ZS5j
DQo+IGluZGV4IDk3ZmIyZTAuLjY2NWE1ODQgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taXBzL3Ry
YW5zbGF0ZS5jDQo+ICsrKyBiL3RhcmdldC9taXBzL3RyYW5zbGF0ZS5jDQo+IEBAIC0yMzg1NSw2
ICsyMzg1NSwxMiBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfb3BjX3NwZWNpYWwoQ1BVTUlQU1N0YXRl
ICplbnYsIERpc2FzQ29udGV4dCAqY3R4KQ0KPiAgICNkZWZpbmUgTVhVX0FQVE4yX1NBICAgIDIN
Cj4gICAjZGVmaW5lIE1YVV9BUFROMl9TUyAgICAzDQo+ICAgDQo+ICsvKiBNWFUgZXhlY3V0ZSBh
ZGQvc3VidHJhY3QgMi1iaXQgcGF0dGVybiAnZXB0bjInICovDQo+ICsjZGVmaW5lIE1YVV9FUFRO
Ml9BQSAgICAwDQo+ICsjZGVmaW5lIE1YVV9FUFROMl9BUyAgICAxDQo+ICsjZGVmaW5lIE1YVV9F
UFROMl9TQSAgICAyDQo+ICsjZGVmaW5lIE1YVV9FUFROMl9TUyAgICAzDQo+ICsNCj4gICANCj4g
ICAvKg0KPiAgICAqDQo=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fyZPs-0000Rb-W9
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fyZPq-0002yC-Ay
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:20:32 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com
	([104.47.36.115]:34788
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fyZPq-0002uu-1Z
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 05:20:30 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sat, 8 Sep 2018 09:20:24 +0000
Message-ID: <DM6PR08MB4875E5EDA598B98379D09C57C6070@DM6PR08MB4875.namprd08.prod.outlook.com>
References: <20180707194137.GB14409@localhost.localdomain>
	<alpine.LFD.2.21.1808010159390.4967@eddie.linux-mips.org>
	<20180801133922.GC2371@localhost.localdomain>
	<c4b04967-c6fa-eea6-4c6e-7001c48344ba@linaro.org>,
	<20180907191619.GA11275@r52>
In-Reply-To: <20180907191619.GA11275@r52>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: Initial support for MIPS
 R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?gb2312?B?Sqi5cmdlbiBVcmJhbg==?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

obdGcm9tOiBGcmVkcmlrIE5vcmluZyA8bm9yaW5nQG5vY3Jldy5vcmc+DQqht1NlbnQ6IEZyaWRh
eSwgU2VwdGVtYmVyIDcsIDIwMTggOToxNiBQTQ0KobdUbzogUmljaGFyZCBIZW5kZXJzb247IEF1
cmVsaWVuIEphcm5vOyBBbGVrc2FuZGFyIE1hcmtvdmljOyBNYWNpZWogVy4gUm96eWNraQ0KobdD
YzogSqi5cmdlbiBVcmJhbjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQqht1N1YmplY3Q6IFJlOiBb
UEFUQ0ggdjJdIHRhcmdldC9taXBzOiBJbml0aWFsIHN1cHBvcnQgZm9yIE1JUFMgUjU5MDANCg0K
UGxlYXNlOg0KDQotIHJlYmFzZSB5b3VyIGNoYW5nZXMgdG8gdGhlIGxhdGVzdCBRRU1VIGNvZGUN
Ci0gb3JnYW5pemUgdGhlIGNoYW5nZXMgaW4gdGhlIGZvcm0gb2YgcGF0Y2ggc2VyaWVzDQotIHBy
b3ZpZGUgbGlua3MgdG8gb3IgYXR0YWNoIHJlbGV2YW50IGRvY3VtZW50YXRpb24NCi0gaW4gY292
ZXIgbGV0dGVyLCBvdXRsaW5lIHdoYXQgaXMgbmVlZGVkIGZvciBmdWxsIFFFTVUgc3VwcG9ydCBv
ZiB0aGUgY3B1IGluIHF1ZXN0aW9uDQotIGRlc2NyaWJlIHRlc3RpbmcgYW5kIHZlcmlmaWNhdGlv
bg0KLSByZW1vdmUgdGhlIHVuY2xlYXIgd29yZCAnaW5pdGlhbCcgZnJvbSB0aGUgdGl0bGUNCi0g
b3V0bGluZSB5b3VyIHBsYW4gZm9yIHByb3ZpZGluZyBmdWxsIHN1cHBvcnQgLSBjYW4geW91IGNv
bW1pdCBlbm91Z2ggcmVzb3VyY2VzIHRvIGRvIHRoZSBqb2IgaW4gYSByZWFzb25hYmxlIHRpbWVm
cmFtZT8NCg0KT3RoZXJ3aXNlLCBJIGFtIGdlbmVyYWxseSBoYXBweSB3aXRoIHlvdXIgcGF0Y2gu
DQoNClRoYW5rcywNCkFsZWtzYW5kYXINCg0K

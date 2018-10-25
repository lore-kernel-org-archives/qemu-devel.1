Received: from eggs.gnu.org ([2001:4830:134:3::10]:60318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFcZh-0006Ki-Sj
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gFcXh-00080h-QF
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:07:08 -0400
Received: from mail-eopbgr710133.outbound.protection.outlook.com
	([40.107.71.133]:22145
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gFcXh-0007y9-H7
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 06:07:05 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Thu, 25 Oct 2018 10:07:01 +0000
Message-ID: <986f4c5a-3a3f-9935-b3ff-c6ce35b56659@wavecomp.com>
References: <1540457346-30999-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540457346-30999-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540457346-30999-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BD0737B92302248B053638E7F000A2A@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/3] target/mips: Add nanoMIPS CRC32
 instruction pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

DQpPbiAyNS4xMC4xOC4gMTA6NDksIEFsZWtzYW5kYXIgTWFya292aWMgd3JvdGU6DQo+IEZyb206
IEFsZWtzYW5kYXIgTWFya292aWMgPGFtYXJrb3ZpY0B3YXZlY29tcC5jb20+DQo+DQo+IEFkZCBu
YW5vTUlQUyBDUkMzMiBpbnN0cnVjdGlvbiBwb29sLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGVr
c2FuZGFyIE1hcmtvdmljIDxhbWFya292aWNAd2F2ZWNvbXAuY29tPg0KPiAtLS0NCj4gICB0YXJn
ZXQvbWlwcy90cmFuc2xhdGUuYyB8IDEwICsrKysrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKQ0KDQoNClJldmlld2VkLWJ5OiBTdGVmYW4gTWFya292aWMgPHNtYXJr
b3ZpY0B3YXZlY29tcC5jb20+DQoNCg0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L21pcHMvdHJhbnNs
YXRlLmMgYi90YXJnZXQvbWlwcy90cmFuc2xhdGUuYw0KPiBpbmRleCBjNDRhNzUxLi40MzM4Yjlh
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvbWlwcy90cmFuc2xhdGUuYw0KPiArKysgYi90YXJnZXQv
bWlwcy90cmFuc2xhdGUuYw0KPiBAQCAtMTc0NzUsNiArMTc0NzUsMTYgQEAgZW51bSB7DQo+ICAg
ICAgIE5NX1NPViAgICAgID0gMHg3YSwNCj4gICB9Ow0KPiAgIA0KPiArLyogQ1JDMzIgaW5zdHJ1
Y3Rpb24gcG9vbCAqLw0KPiArZW51bSB7DQo+ICsgICAgTk1fQ1JDMzJCICAgPSAweDAwLA0KPiAr
ICAgIE5NX0NSQzMySCAgID0gMHgwMSwNCj4gKyAgICBOTV9DUkMzMlcgICA9IDB4MDIsDQo+ICsg
ICAgTk1fQ1JDMzJDQiAgPSAweDA0LA0KPiArICAgIE5NX0NSQzMyQ0ggID0gMHgwNSwNCj4gKyAg
ICBOTV9DUkMzMkNXICA9IDB4MDYsDQo+ICt9Ow0KPiArDQo+ICAgLyogUE9PTDMyQTUgaW5zdHJ1
Y3Rpb24gcG9vbCAqLw0KPiAgIGVudW0gew0KPiAgICAgICBOTV9DTVBfRVFfUEggICAgICAgID0g
MHgwMCwNCg==

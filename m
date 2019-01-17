Received: from eggs.gnu.org ([209.51.188.92]:59382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gk9De-0002kc-HV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gk9Dd-0006wV-Hc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:04:34 -0500
Received: from mail-eopbgr680096.outbound.protection.outlook.com
	([40.107.68.96]:60677
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gk9Db-0006ho-Sf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:04:33 -0500
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Thu, 17 Jan 2019 15:04:16 +0000
Message-ID: <82c6bc23-406a-acf3-d874-5069b0325259@wavecomp.com>
References: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1546533252-26601-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546533252-26601-9-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D7929B50D411644A641C55D23A5A13D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 8/8] target/mips: Update ITU to handle bus
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

DQpPbiAzLjEuMTkuIDE3OjM0LCBBbGVrc2FuZGFyIE1hcmtvdmljIHdyb3RlOg0KPiBGcm9tOiBZ
b25nYm9rIEtpbSA8eW9uZ2Jvay5raW1AbWlwcy5jb20+DQo+DQo+IFVwZGF0ZSBJVFUgdG8gaGFu
ZGxlIGJ1cyBlcnJvcnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdib2sgS2ltIDx5b25nYm9r
LmtpbUBtaXBzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxla3NhbmRhciBNYXJrb3ZpYyA8YW1h
cmtvdmljQHdhdmVjb21wLmNvbT4NCj4gLS0tDQo+ICAgaHcvbWlzYy9taXBzX2l0dS5jIHwgMjIg
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspDQoNCg0KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBNYXJrb3ZpYyA8c21hcmtvdmljQHdhdmVjb21w
LmNvbT4NCg0KDQo+IGRpZmYgLS1naXQgYS9ody9taXNjL21pcHNfaXR1LmMgYi9ody9taXNjL21p
cHNfaXR1LmMNCj4gaW5kZXggNWM0OWJkZC4uZTg4NjBkYyAxMDA2NDQNCj4gLS0tIGEvaHcvbWlz
Yy9taXBzX2l0dS5jDQo+ICsrKyBiL2h3L21pc2MvbWlwc19pdHUuYw0KPiBAQCAtMzc1LDYgKzM3
NSwxMiBAQCBzdGF0aWMgdm9pZCB2aWV3X3B2X3RyeV93cml0ZShJVENTdG9yYWdlQ2VsbCAqYykN
Cj4gICAgICAgdmlld19wdl9jb21tb25fd3JpdGUoYyk7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGlj
IHZvaWQgcmFpc2VfZXhjZXB0aW9uKGludCBleGNwKQ0KPiArew0KPiArICAgIGN1cnJlbnRfY3B1
LT5leGNlcHRpb25faW5kZXggPSBleGNwOw0KPiArICAgIGNwdV9sb29wX2V4aXQoY3VycmVudF9j
cHUpOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIHVpbnQ2NF90IGl0Y19zdG9yYWdlX3JlYWQodm9p
ZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5zaWduZWQgc2l6ZSkNCj4gICB7DQo+ICAgICAgIE1J
UFNJVFVTdGF0ZSAqcyA9IChNSVBTSVRVU3RhdGUgKilvcGFxdWU7DQo+IEBAIC0zODIsNiArMzg4
LDE0IEBAIHN0YXRpYyB1aW50NjRfdCBpdGNfc3RvcmFnZV9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdh
ZGRyIGFkZHIsIHVuc2lnbmVkIHNpemUpDQo+ICAgICAgIElUQ1ZpZXcgdmlldyA9IGdldF9pdGNf
dmlldyhhZGRyKTsNCj4gICAgICAgdWludDY0X3QgcmV0ID0gLTE7DQo+ICAgDQo+ICsgICAgc3dp
dGNoIChzaXplKSB7DQo+ICsgICAgY2FzZSAxOg0KPiArICAgIGNhc2UgMjoNCj4gKyAgICAgICAg
cy0+aWNyMCB8PSAxIDw8IElUQ19JQ1IwX0VSUl9BWEk7DQo+ICsgICAgICAgIHJhaXNlX2V4Y2Vw
dGlvbihFWENQX0RCRSk7DQo+ICsgICAgICAgIHJldHVybiAwOw0KPiArICAgIH0NCj4gKw0KPiAg
ICAgICBzd2l0Y2ggKHZpZXcpIHsNCj4gICAgICAgY2FzZSBJVENWSUVXX0JZUEFTUzoNCj4gICAg
ICAgICAgIHJldCA9IHZpZXdfYnlwYXNzX3JlYWQoY2VsbCk7DQo+IEBAIC00MjAsNiArNDM0LDE0
IEBAIHN0YXRpYyB2b2lkIGl0Y19zdG9yYWdlX3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFk
ZHIsIHVpbnQ2NF90IGRhdGEsDQo+ICAgICAgIElUQ1N0b3JhZ2VDZWxsICpjZWxsID0gZ2V0X2Nl
bGwocywgYWRkcik7DQo+ICAgICAgIElUQ1ZpZXcgdmlldyA9IGdldF9pdGNfdmlldyhhZGRyKTsN
Cj4gICANCj4gKyAgICBzd2l0Y2ggKHNpemUpIHsNCj4gKyAgICBjYXNlIDE6DQo+ICsgICAgY2Fz
ZSAyOg0KPiArICAgICAgICBzLT5pY3IwIHw9IDEgPDwgSVRDX0lDUjBfRVJSX0FYSTsNCj4gKyAg
ICAgICAgcmFpc2VfZXhjZXB0aW9uKEVYQ1BfREJFKTsNCj4gKyAgICAgICAgcmV0dXJuOw0KPiAr
ICAgIH0NCj4gKw0KPiAgICAgICBzd2l0Y2ggKHZpZXcpIHsNCj4gICAgICAgY2FzZSBJVENWSUVX
X0JZUEFTUzoNCj4gICAgICAgICAgIHZpZXdfYnlwYXNzX3dyaXRlKGNlbGwsIGRhdGEpOw0K

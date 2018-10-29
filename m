Received: from eggs.gnu.org ([2001:4830:134:3::10]:49096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gH75X-000725-NW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smarkovic@wavecomp.com>) id 1gH75T-0006mS-KV
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:56:11 -0400
Received: from mail-co1nam03on0107.outbound.protection.outlook.com
	([104.47.40.107]:25184
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <smarkovic@wavecomp.com>)
	id 1gH75T-0006lM-Bq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:56:07 -0400
From: Stefan Markovic <smarkovic@wavecomp.com>
Date: Mon, 29 Oct 2018 12:56:03 +0000
Message-ID: <14fa0b9e-d581-2c21-36d8-cb0d6e27660a@wavecomp.com>
References: <1540811730-15660-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540811730-15660-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F1ECD1960BAF541B0F68482FEFEA865@namprd22.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Add two missing breaks for
 NM_LLWPE and NM_SCWPE decoder cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>

DQpPbiAyOS4xMC4xOC4gMTI6MTUsIEFsZWtzYW5kYXIgTWFya292aWMgd3JvdGU6DQo+IEZyb206
IEFsZWtzYW5kYXIgTWFya292aWMgPGFtYXJrb3ZpY0B3YXZlY29tcC5jb20+DQo+DQo+IENvdmVy
aXR5IGZvdW5kIHR3byBmYWxsdGhyb3VnaHMgdGhhdCBsYWNrIGJyZWFrIHN0YXRlbWVudHMuIEZp
eCB0aGVtLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGVrc2FuZGFyIE1hcmtvdmljIDxhbWFya292
aWNAd2F2ZWNvbXAuY29tPg0KPiAtLS0NCj4gICB0YXJnZXQvbWlwcy90cmFuc2xhdGUuYyB8IDIg
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCg0KUmV2aWV3ZWQtYnk6
IFN0ZWZhbiBNYXJrb3ZpYyA8c21hcmtvdmljQHdhdmVjb21wLmNvbT4NCg0KDQo+IGRpZmYgLS1n
aXQgYS90YXJnZXQvbWlwcy90cmFuc2xhdGUuYyBiL3RhcmdldC9taXBzL3RyYW5zbGF0ZS5jDQo+
IGluZGV4IGI4YWNlMGIuLjgxM2FkMTkgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taXBzL3RyYW5z
bGF0ZS5jDQo+ICsrKyBiL3RhcmdldC9taXBzL3RyYW5zbGF0ZS5jDQo+IEBAIC0yMTQwMiw2ICsy
MTQwMiw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX25hbm9taXBzXzMyXzQ4X29wYyhDUFVNSVBTU3Rh
dGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2hlY2tfZXZhKGN0eCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tfY3AwX2Vu
YWJsZWQoY3R4KTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBnZW5fbGx3cChjdHgsIHJz
LCAwLCBydCwgZXh0cmFjdDMyKGN0eC0+b3Bjb2RlLCAzLCA1KSk7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQ6DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ2VuZXJhdGVfZXhjZXB0aW9uX2VuZChjdHgsIEVYQ1Bf
UkkpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiBAQCAtMjE0MjAsNiAr
MjE0MjEsNyBAQCBzdGF0aWMgaW50IGRlY29kZV9uYW5vbWlwc18zMl80OF9vcGMoQ1BVTUlQU1N0
YXRlICplbnYsIERpc2FzQ29udGV4dCAqY3R4KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNoZWNrX2V2YShjdHgpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoZWNrX2NwMF9l
bmFibGVkKGN0eCk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2VuX3Njd3AoY3R4LCBy
cywgMCwgcnQsIGV4dHJhY3QzMihjdHgtPm9wY29kZSwgMywgNSkpOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgICAgICAgICBkZWZhdWx0Og0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdlbmVyYXRlX2V4Y2VwdGlvbl9lbmQoY3R4LCBFWENQ
X1JJKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCg==

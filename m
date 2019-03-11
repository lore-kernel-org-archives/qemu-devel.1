Received: from eggs.gnu.org ([209.51.188.92]:47546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1h3NHK-0007Sh-If
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1h3NHJ-0008QR-1p
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:55:50 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Mon, 11 Mar 2019 15:55:33 +0000
Message-ID: C87848E9-4108-4586-B433-BF026017D406
References: <0184EA26B2509940AA629AE1405DD7F202153AC7@dggema523-mbx.china.huawei.com>,
	<CAFEAcA9yr3trFz7ZFsS-P-g=gxe=MX6Eet_dTdcOCSdhW7_J4w@mail.gmail.com>
In-Reply-To: <CAFEAcA9yr3trFz7ZFsS-P-g=gxe=MX6Eet_dTdcOCSdhW7_J4w@mail.gmail.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [RESEND PATCH] target/arm: change arch timer
 registers access permission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

dW5kZXJzdGFuZCBub3fvvIx0aGFua3MgZm9yIHRoZSBleHBsYWluYXRpb24sIEkgd2lsbCB1cGRh
dGUgaXQuDQrlj5Hku7bkurrvvJpQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+DQrmlLbku7bkurrvvJpnZW5nZG9uZ2ppdSA8Z2VuZ2RvbmdqaXVAaHVhd2VpLmNvbT4NCuaK
hOKAg+mAge+8mnFlbXUtYXJtIDxxZW11LWFybUBub25nbnUub3JnPjtRRU1VIERldmVsb3BlcnMg
PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCuaXtumXtO+8mjIwMTktMDMtMTEgMjM6Mzk6MzINCuS4
u+KAg+mimO+8mlJlOiBbUkVTRU5EIFBBVENIXSB0YXJnZXQvYXJtOiBjaGFuZ2UgYXJjaCB0aW1l
ciByZWdpc3RlcnMgYWNjZXNzIHBlcm1pc3Npb24NCg0KT24gTW9uLCAxMSBNYXIgMjAxOSBhdCAx
NToyNCwgZ2VuZ2RvbmdqaXUgPGdlbmdkb25naml1QGh1YXdlaS5jb20+IHdyb3RlOg0KPiBTbyBJ
ZiBRRU1VIGRlZmluZWQgdGhlIHRpbWVyIHJlZ2lzdGVycyByZWFkIG9ubHkgaW4gUEwwLCBldmVu
IHRob3VnaCBpdCBoYXMgYmVlbiBjb25maWd1cmVkIHRvIGhhdmUgd3JpdGUgcGVybWlzc2lvbiBp
biBQTDAgYnkgaGlnaCBQTHgsIHdlIHN0aWxsIGNhbm5vdCBoYXZlDQo+IFdyaXRlIHBlcm1pc3Np
b24sIGJlY2F1c2UgUUVNVSB3aWxsIGZpcnN0bHkgY2hlY2sgdGhlIGRlZmluZWQgcGVybWlzc2lv
biBhbmQgdGhlbiBjaGVjayB0aGUgY29uZmlndXJlZCBwZXJtaXNzaW9uIGJ5IGhpZ2ggUEx4Lg0K
DQpJJ20gYWZyYWlkIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSdyZSB0cnlpbmcgdG8gc2F5
IGhlcmUuDQoNClllcywgaXQgd2FzIGEgYnVnIHRoYXQgd2UgbWFya2VkIHRoZXNlIHJlZ2lzdGVy
cyBhcyByZWFkLW9ubHkgZm9yIFBMMCwNCmFuZCB3ZSBzaG91bGQgZml4IGl0Lg0KDQpXaGF0IEkg
YW0gdHJ5aW5nIHRvIHNheSBpcyB0aGF0DQogLmFjY2VzcyA9IFBMMV9SVyB8IFBMMF9SVw0KDQpp
cyBleGFjdGx5IGVxdWl2YWxlbnQgdG8NCiAuYWNjZXNzID0gUEwwX1JXDQoNCmFuZCB3ZSBzaG91
bGQgdXNlIHRoZSBzaW1wbGVyIHZlcnNpb24gb2YgdGhlIGV4cHJlc3Npb24uDQoNCihJZiB5b3Ug
bG9vayBhdCB0aGUgZGVmaW5pdGlvbnMgb2YgYWxsIHRoZSBQTCpfIGNvbnN0YW50cywNCnlvdSBj
YW4gc2VlIHRoYXQgUEwwX1cgaW1wbGllcyBQTDFfVzoNCiNkZWZpbmUgUEwwX1cgKDB4MDEgfCBQ
TDFfVykNCmFuZCBzaW1pbGFybHkgZm9yIFBMMF9SLiBTbyBhbGwgdGhlIGJpdHMgaW4gdGhlIGJp
dGZpZWxkIHRoYXQgd291bGQgYmUNCnNldCBieSBQTDFfUlcgYXJlIGFsc28gc2V0IGJ5IFBMMF9S
Vy4pDQoNCnRoYW5rcw0KLS0gUE1NDQo=

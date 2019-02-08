Received: from eggs.gnu.org ([209.51.188.92]:44812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gsCvH-00083N-H3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gsCvG-00039U-H0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:38:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gsCvF-0002y0-Ue
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:38:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18KYUkk030019
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 15:38:24 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qhfgmuptx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 15:38:24 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Fri, 8 Feb 2019 20:38:22 -0000
References: <1548859550-32019-1-git-send-email-liam.merwick@oracle.com>
	<3b98dc38-fe11-87fb-d846-4001f64c0b33@linux.ibm.com>
	<00ba3ef0-896a-81bd-6e89-1761e983881a@oracle.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Fri, 8 Feb 2019 15:38:20 -0500
MIME-Version: 1.0
In-Reply-To: <00ba3ef0-896a-81bd-6e89-1761e983881a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <cf016219-65e7-a768-91a8-9a674a1ddba4@linux.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] tpm_tis: validate locality values don't
 overrun array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

T24gMi84LzE5IDM6MTAgUE0sIExpYW0gTWVyd2ljayB3cm90ZToNCj4NCj4NCj4+DQo+Pg0K
Pj4NCj4+PiB0cmFjZV90cG1fdGlzX2Fib3J0KHMtPm5leHRfbG9jdHkpOw0KPj4+IMKgwqDC
oMKgwqAgLyoNCj4+PiBAQCAtNTMxLDYgKzUzNCw4IEBAIHN0YXRpYyB2b2lkIHRwbV90aXNf
bW1pb193cml0ZSh2b2lkICpvcGFxdWUsIA0KPj4+IGh3YWRkciBhZGRyLA0KPj4+IMKgwqDC
oMKgwqAgdWludDE2X3QgbGVuOw0KPj4+IMKgwqDCoMKgwqAgdWludDMyX3QgbWFzayA9IChz
aXplID09IDEpID8gMHhmZiA6ICgoc2l6ZSA9PSAyKSA/IDB4ZmZmZiA6IH4wKTsNCj4+PiAr
wqDCoMKgIGFzc2VydChUUE1fVElTX0lTX1ZBTElEX0xPQ1RZKGxvY3R5KSk7DQo+Pj4gKw0K
Pj4NCj4+IFdlIGFsc28gZG8gbm90IG5lZWQgdGhpcyBjaGVjayBoZXJlIHNpbmNlIHdlIGFy
ZSByZWdpc3RlcmluZyAweDUwMDAgDQo+PiBieXRlcyBvZiBNTUlPIHNwYWNlLCB3aGljaCBn
aXZlcyB1cyBhZGRyZXNzZXMgWzB4MC4uMHg0ZmZmXSwgZnJvbSANCj4+IHdoaWNoIHdlIGNh
bGN1bGF0ZSB0aGUgbG9jYWxpdHkgd2l0aCBhICc+PiAxMic6DQo+Pg0KPj4gc3RhdGljIHVp
bnQ4X3QgdHBtX3Rpc19sb2NhbGl0eV9mcm9tX2FkZHIoaHdhZGRyIGFkZHIpDQo+PiB7DQo+
DQo+IEluIHRoYXQgY2FzZSB3b3VsZCBpdCBiZSBnb29kIHRvIGFkZCB0aGlzIGNoZWNrIHRv
IGVuZm9yY2UgdGhlIGFkZHJlc3MgDQo+IHJhbmdlPw0KPg0KPiBhc3NlcnQoYWRkciA8IFRQ
TV9USVNfQUREUl9TSVpFKTsNCg0KDQpUaGVyZSB3b3VsZCBiZSBzb21ldGhpbmcgZnVuZGFt
ZW50YWxseSB3cm9uZyBpbiBob3cgdGhlIGRpc3BhdGNoaW5nIG9mIA0KTU1JTyBhZGRyZXNz
ZXMgd29ya3MgaW4gUUVNVS4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgbmVlZCBpdC4uLg0K
DQoNCj4NCj4NCj4+IMKgwqDCoMKgIHJldHVybiAodWludDhfdCkoKGFkZHIgPj4gVFBNX1RJ
U19MT0NBTElUWV9TSElGVCkgJiAweDcpOw0KPj4gfQ0KPj4NCj4+IHRoaXMgaXMgd2hlcmUg
d2UgcmVnaXN0ZXIgdGhlIE1NSU8gbWVtb3J5Og0KPj4NCj4+IMKgwqDCoMKgIG1lbW9yeV9y
ZWdpb25faW5pdF9pbygmcy0+bW1pbywgT0JKRUNUKHMpLCAmdHBtX3Rpc19tZW1vcnlfb3Bz
LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzLCAidHBtLXRpcy1tbWlvIiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVFBNX1RJU19OVU1fTE9DQUxJVElFUyA8PCAN
Cj4+IFRQTV9USVNfTE9DQUxJVFlfU0hJRlQpOw0KPj4NCj4+IFRoZSBsb2NhbGl0eSBjYW5u
b3QgYmUgb3V0LW9mLWJvdW5kcy4NCj4NCj4NCj4NCj4NCj4gRnJvbSBzdGFyaW5nIGF0IHRo
ZSBjb2RlLCBJIGRvIGhhdmUgb25lIG90aGVyIHF1ZXN0aW9uIC0gd2h5IGRvZXMgdGhlIA0K
PiBjaGVjayBvZiB0aGUgbG93ZXIgbG9jYWxpdGllcyBiZWxvdyBvbmx5IGNoZWNrICdsIDwg
bG9jdHkgLSAxJyBiZWZvcmUgDQo+IHNldHRpbmcgcy0+bG9jW2xvY3R5XSAtIGl0IHNlZW1z
IGxpa2Ugcy0+bG9jW2xvY3R5IC0gMV0gaXMgc2tpcHBlZC4NCj4NCj4NCj4gwqA2MjfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBjYW5jZWwgYW55IHNlaXplIGJ5IGEg
bG93ZXIgbG9jYWxpdHkgKi8NCj4gwqA2MjjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBmb3IgKGwgPSAwOyBsIDwgbG9jdHkgLSAxOyBsKyspIHsNCj4gwqA2MjnCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmxvY1tsXS5hY2Nlc3MgJj0g
flRQTV9USVNfQUNDRVNTX1NFSVpFOw0KPiDCoDYzMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0NCg0KDQpVdXVoLiBUaGUgbG9vcCBpcyBjbGVhcmluZyB0aGUgU0VJWkUg
ZmxhZyBvbiBsb2NhbGl0aWVzIGxvd2VyIHRoYW4gdGhlIA0KY3VycmVudCBvbmUuIFRoaXMg
d29ya3MgZmluZSBmb3IgbG9jdHkgPj0gMSwgYnV0IG5vdCBmb3IgbG9jdHkgPSAwLiBJIA0K
dGhpbmsgdGhlcmUncyBhIGJ1ZyBoZXJlLg0KDQoNCg0KPiDCoDYzMQ0KPiDCoDYzMsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmxvY1tsb2N0eV0uYWNjZXNzIHw9IFRQ
TV9USVNfQUNDRVNTX1NFSVpFOw0KPg0KPg0KPiBSZWdhcmRzLA0KPiBMaWFtDQo+DQoNCg==

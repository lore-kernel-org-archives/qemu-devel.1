Received: from eggs.gnu.org ([2001:4830:134:3::10]:37902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cqkxz-0004Zw-TI
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1cqkxv-0004gL-P5
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:26:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:10927)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1cqkxv-0004fP-Cc
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:26:35 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Wed, 22 Mar 2017 18:26:32 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1A2E524@ORSMSX112.amr.corp.intel.com>
References: <1489158897-9206-1-git-send-email-yang.zhong@intel.com>
	<4712D8F4B26E034E80552F30A67BE0B1A0F91A@ORSMSX112.amr.corp.intel.com>
	<920352018.1797331.1489251855464.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A13045@ORSMSX112.amr.corp.intel.com>
	<991a0f3d-5e1f-d17c-a8f3-a42c02ac2f17@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A1561C@ORSMSX112.amr.corp.intel.com>
	<f05fe113-c286-19b0-f5bc-ee2c1ea05568@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A16F14@ORSMSX112.amr.corp.intel.com>
	<1466597512.4602267.1489609298091.JavaMail.zimbra@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1A19A11@ORSMSX112.amr.corp.intel.com>
	<b23eb236-6f32-fb2b-1a61-a831053e277b@redhat.com>
In-Reply-To: <b23eb236-6f32-fb2b-1a61-a831053e277b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 2/2] reduce qemu's heap Rss size from
 12252kB to 2752KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Zhong, Yang" <yang.zhong@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiBTbyBwbGVhc2Ugc2VuZCBpdCB0byB0aGUgbGlzdCB3aXRoIFNpZ25lZC1vZmYtYnkgbGluZS4N
ClRoYW5rcywgDQoNCj4gDQo+ICAgICAgICAgICAgIERQUklOVEYoImhhbmRsZV9tbWlvXG4iKTsN
Cj4gICAgICAgICAgICAgLyogQ2FsbGVkIG91dHNpZGUgQlFMICovDQo+ICAgICAgICAgICAgIGFk
ZHJlc3Nfc3BhY2VfcncoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJ1bi0+bW1pby5waHlzX2FkZHIsIGF0dHJzLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJ1bi0+bW1pby5kYXRhLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJ1bi0+bW1pby5sZW4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnVu
LT5tbWlvLmlzX3dyaXRlKTsNCj4gDQo+IGFuZCBhZGRpbmcgYSBzaW1wbGUgYXNzZXJ0KCkgd291
bGQgaGF2ZSBxdWlja2x5IGRpc3Byb3ZlZCB5b3VyIHRoZW9yeS4NCllvdSBhcmUgcmlnaHQgaGVy
ZS4NCklmIGl0IGlzIGEgUENJIGJhciB3cml0ZSwgYSBtZW1vcnkgcmVnaW9uIG9wZXJhdGlvbihk
ZWwvYWRkKSBtYXkgDQpiZSBjYWxsZWQgaW5zaWRlIGFkZHJlc3Nfc3BhY2VfcncsIGFuZCANCm1l
bW9yeV9yZWdpb25fdHJhbnNhY3Rpb25fY29tbWl0IHdpbGwgYmUgY2FsbGVkLg0KSWYgYWRkcmVz
c19zcGFjZV9ydyBpcyBjYWxsZWQgIHdpdGhvdXQgdGhlIGdsb2JhbCBsb2NrLCANCm1lbW9yeV9y
ZWdpb25fdHJhbnNhY3Rpb25fY29tbWl0IGlzIGNhbGxlZCB3aXRoIHRoZSBnbG9iYWwgbG9jay4N
CiBJdCBjb25mbGljdHMgd2l0aCB3aGF0IHlvdSBzYWlkIGJlZm9yZS4NCg0KPk5vLCB5b3UgZG9u
J3QgbmVlZCB0byBjaGVjayBpdC4gIE1vc3QgZnVuY3Rpb25zIChpbiB0aGlzIGNhc2UsDQo+bWVt
b3J5X3JlZ2lvbl90cmFuc2FjdGlvbl9jb21taXQpIGNhbiBvbmx5IGJlIGNhbGxlZCB1bmRlciB0
aGUgZ2xvYmFsIGxvY2suDQoNCkFuZCBpZiB0d28gdmNwdXMgcHJvZ3JhbSB0aGUgZGlmZmVyZW50
IFBDSSBiYXJzIGF0IHRoZSBzYW1lIHRpbWUgDQooaXQgaXMgdW5saWtlbHksIGJ1dCBRRU1VIHNo
b3VsZCBub3QgYXNzdW1lIGl0KSwgd2l0aG91dCB0aGUgZ2xvYmFsIGxvY2ssIA0KcmVnaW9uIG9w
ZXJhdGlvbnMgbWF5IGJlIGNhbGxlZCBhdCB0aGUgc2FtZSB0aW1lLiANCkFyZSBtZW1vcnlfcmVn
aW9uX2RlbF9zdWJyZWdpb24gYW5kIA0KbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uX292ZXJs
YXAgdGhyZWFkLXNhZmU/DQoNCj4gSXQncyBub3QgYSBmaXggaWYgdGhlIGNvZGUgaXMgbm90IHRo
cmVhZC1zYWZlIGFueW1vcmUhICBCdXQgSSB0aGluayB5b3UNCj4gaGF2ZSB0aGUgYW5zd2VyIG5v
dyBhcyB0byB3aHkgeW91IGNhbm5vdCB1c2Ugc3luY2hyb25pemVfcmN1Lg0KDQpDYW4geW91IGVs
YWJvcmF0ZSB3aHkgdGhlIGNvZGUgaXMgbm90IHRocmVhZC1zYWZlPw0KDQpUaGFua3MNCkFudGhv
bnkNCg==

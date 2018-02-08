Received: from eggs.gnu.org ([2001:4830:134:3::10]:33390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ejmvF-0003lE-V5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ejmvB-0000rX-US
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:11:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ejmvB-0000qz-Ks
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:11:29 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18EBPqZ050988
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 09:11:28 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0qx5gj4q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:11:27 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 07:11:26 -0700
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
	<caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 12:11:20 -0200
MIME-Version: 1.0
In-Reply-To: <caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <36d28bb7-5e8d-f1f6-4ecd-bd5e986a5dfc@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/audio/sb16.c: missing break
 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

SGV5LA0KDQpPbiAwMi8wOC8yMDE4IDEwOjE1IEFNLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gSGkgRGFuaWVsLA0KPg0KPiBPbiAwMi8wOC8yMDE4IDA3OjU3IEFNLCBE
YW5pZWwgSGVucmlxdWUgQmFyYm96YSB3cm90ZToNCj4+IFRoaXMgcGF0Y2ggYWRkcyBhIGJy
ZWFrIGluIHRoZSBzd2l0Y2goKSBzdGF0ZW1lbnQgb2YgY29tcGxldGUoKSwNCj4+IHZhbHVl
IDB4NDI6DQo+Pg0KPj4gICAgICBjYXNlIDB4NDI6ICAgICAgICAgICAgICAvKiBGVDIgc2V0
cyBvdXRwdXQgZnJlcSB3aXRoIHRoaXMsIGdvIGZpZ3VyZSAqLw0KPj4gICAgICAgICAgcWVt
dV9sb2dfbWFzayhMT0dfVU5JTVAsICJjbWQgMHg0MiBtaWdodCBub3QgZG8gd2hhdCBpdCB0
aGluayBpdCINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIiBzaG91bGRcbiIpOw0KPj4g
ICAgICAgICAgYnJlYWs7IDwtLS0tLS0tDQo+PiAgICAgIGNhc2UgMHg0MToNCj4gSXQgc2Vl
bXMgdGhpcyBpcyBhbiBpbnRlbnRpb25hbCBmYWxsdGhyb3VnaCwgSSB1bmRlcnN0YW5kIGNt
ZCAweDQyIGlzDQo+IGV4cGVjdGVkIHRvIGRvIHRoZSBzYW1lIG9mIDB4NDEgYW5kIF9hIGJp
dCBtb3JlXyAoc2VlIGNvbW1pdCA4NTU3MWJjNzQxNSkuDQoNClBlcmhhcHMgaXQgc2hvdWxk
IGJlIG1vcmUgZXhwbGljaXQgdGhlbj8gU29tZXRoaW5nIGxpa2UNCg0KIMKgwqDCoMKgwqDC
oMKgIGNhc2UgMHg0MDoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPnRpbWVfY29uc3Qg
PSBkc3BfZ2V0X2RhdGEgKHMpOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGRlYnVnICgi
c2V0IHRpbWUgY29uc3QgJWRcbiIsIHMtPnRpbWVfY29uc3QpOw0KIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYnJlYWs7DQoNCiDCoMKgwqDCoMKgwqDCoCBjYXNlIDB4NDE6DQogwqDCoMKg
wqDCoMKgwqAgY2FzZSAweDQyOg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocy0+
Y21kID09IDB4NDIpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IEZUMiBzZXRzIG91dHB1dCBmcmVxIHdpdGggdGhpcywgZ28gZmlndXJlICovDQogwqAgwqDC
oCDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X2xvZ19tYXNrKExPR19VTklNUCwgImNtZCAw
eDQyIG1pZ2h0IG5vdCBkbyB3aGF0IGl0IA0KdGhpbmsgaXQiDQogwqDCoMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgIiBzaG91bGRcbiIpOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcy0+ZnJlcSA9IGRzcF9nZXRfaGlsbyAocyk7DQogwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBsZGVidWcgKCJzZXQgZnJlcSAlZFxuIiwgcy0+ZnJlcSk7DQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCg0KIMKgwqDCoMKgwqDCoMKgIGNhc2UgMHg0
ODoNCg0KDQoNCj4NCj4+IFRoZSBpc3N1ZSB3YXMgZm91bmQgYnkgQ292ZXJpdHkgKCMxMzg1
ODQxKToNCj4+DQo+PiAgICAgIENJRCAxMzg1ODQxOiAgQ29udHJvbCBmbG93IGlzc3VlcyAg
KE1JU1NJTkdfQlJFQUspDQo+PiAgICAgIFRoZSBjYXNlIGZvciB2YWx1ZSAiNjYiIGlzIG5v
dCB0ZXJtaW5hdGVkIGJ5IGEgJ2JyZWFrJyBzdGF0ZW1lbnQuDQo+Pg0KPj4gRml4ZXM6IDhl
YzY2MGI4MGUgKCJody9hdWRpby9zYjE2LmM6IGNoYW5nZSBkb2xvZygpIHRvIHFlbXVfbG9n
X21hc2soKSIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSA8
ZGFuaWVsaGJAbGludXgudm5ldC5pYm0uY29tPg0KPj4gQ0M6IEpvaG4gQXJidWNrbGUgPHBy
b2dyYW1taW5na2lkeEBnbWFpbC5jb20+DQo+PiBDQzogR2VyZCBIb2ZmbWFubiA8a3JheGVs
QHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvYXVkaW8vc2IxNi5jIHwgMSArDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9o
dy9hdWRpby9zYjE2LmMgYi9ody9hdWRpby9zYjE2LmMNCj4+IGluZGV4IDMxZGUyNjRhYjcu
LmIyZmRjZDg0MzcgMTAwNjQ0DQo+PiAtLS0gYS9ody9hdWRpby9zYjE2LmMNCj4+ICsrKyBi
L2h3L2F1ZGlvL3NiMTYuYw0KPj4gQEAgLTc0NCw2ICs3NDQsNyBAQCBzdGF0aWMgdm9pZCBj
b21wbGV0ZSAoU0IxNlN0YXRlICpzKQ0KPj4gICAgICAgICAgIGNhc2UgMHg0MjogICAgICAg
ICAgICAgIC8qIEZUMiBzZXRzIG91dHB1dCBmcmVxIHdpdGggdGhpcywgZ28gZmlndXJlICov
DQo+PiAgICAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLCAiY21kIDB4NDIg
bWlnaHQgbm90IGRvIHdoYXQgaXQgdGhpbmsgaXQiDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIiBzaG91bGRcbiIpOw0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4gICAg
ICAgICAgIGNhc2UgMHg0MToNCj4+ICAgICAgICAgICAgICAgcy0+ZnJlcSA9IGRzcF9nZXRf
aGlsbyAocyk7DQo+PiAgICAgICAgICAgICAgIGxkZWJ1ZyAoInNldCBmcmVxICVkXG4iLCBz
LT5mcmVxKTsNCj4+DQoNCg==

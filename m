Received: from eggs.gnu.org ([2001:4830:134:3::10]:43176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7iTy-0004uM-T4
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7iTm-0000Gi-MZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:50:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 14:50:19 +0000
Message-ID: <63da0f8f-be7f-73d7-526c-79ce4449e21a@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-2-vsementsov@virtuozzo.com>
	<b34bc12a-cae0-a7a0-36dd-2b6c75c16419@redhat.com>
In-Reply-To: <b34bc12a-cae0-a7a0-36dd-2b6c75c16419@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6271338A562524D8963C63BD474A319@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 01/18] block/dirty-bitmap: allow
 set/reset bits in disabled bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDMuMTAuMjAxOCAxNzoyMywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMS8xOCA1OjI5IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gSXQgaXMgbmVlZGVkIGZv
ciB1c2UgdGhlIGJpdG1hcHMgaW4gYmFja3VwLiAiZGlzYWJsZWQiIG1lYW5zIHRoYXQNCj4+IGJp
dG1hcCBpcyBub3QgYXV0byBzZXQgYnkgd3JpdGVzLiBMZXQncyBhbGxvdyBjaGFuZ2luZyBiaXRt
YXAgZm9yIG90aGVyDQo+PiB1c2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4g
wqAgYmxvY2svZGlydHktYml0bWFwLmMgfCAyIC0tDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBk
ZWxldGlvbnMoLSkNCj4NCj4gTG9va3MgbGlrZSB0aGlzIGR1cGxpY2F0ZXMgSm9obidzIHNlcmll
czoNCj4gaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgt
MTAvbXNnMDA0MDYuaHRtbA0KDQpOby4gQnV0IGl0IHJlbGF0ZXMuDQoNCj4NCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svZGlydHktYml0bWFwLmMgYi9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPj4g
aW5kZXggODljMTExMTFhZS4uNjVkMmU5MmVjMyAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2RpcnR5
LWJpdG1hcC5jDQo+PiArKysgYi9ibG9jay9kaXJ0eS1iaXRtYXAuYw0KPj4gQEAgLTUzMiw3ICs1
MzIsNiBAQCBpbnQ2NF90IGJkcnZfZGlydHlfaXRlcl9uZXh0KEJkcnZEaXJ0eUJpdG1hcEl0ZXIg
DQo+PiAqaXRlcikNCj4+IMKgIHZvaWQgYmRydl9zZXRfZGlydHlfYml0bWFwX2xvY2tlZChCZHJ2
RGlydHlCaXRtYXAgKmJpdG1hcCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50NjRfdCBvZmZzZXQsIGlu
dDY0X3QgYnl0ZXMpDQo+PiDCoCB7DQo+PiAtwqDCoMKgIGFzc2VydChiZHJ2X2RpcnR5X2JpdG1h
cF9lbmFibGVkKGJpdG1hcCkpOw0KPj4gwqDCoMKgwqDCoCBhc3NlcnQoIWJkcnZfZGlydHlfYml0
bWFwX3JlYWRvbmx5KGJpdG1hcCkpOw0KPj4gwqDCoMKgwqDCoCBoYml0bWFwX3NldChiaXRtYXAt
PmJpdG1hcCwgb2Zmc2V0LCBieXRlcyk7DQo+PiDCoCB9DQo+PiBAQCAtNTQ5LDcgKzU0OCw2IEBA
IHZvaWQgYmRydl9zZXRfZGlydHlfYml0bWFwKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwLA0KPj4g
wqAgdm9pZCBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcF9sb2NrZWQoQmRydkRpcnR5Qml0bWFwICpi
aXRtYXAsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IG9mZnNldCwgaW50NjRfdCBieXRl
cykNCj4+IMKgIHsNCj4+IC3CoMKgwqAgYXNzZXJ0KGJkcnZfZGlydHlfYml0bWFwX2VuYWJsZWQo
Yml0bWFwKSk7DQo+PiDCoMKgwqDCoMKgIGFzc2VydCghYmRydl9kaXJ0eV9iaXRtYXBfcmVhZG9u
bHkoYml0bWFwKSk7DQo+PiDCoMKgwqDCoMKgIGhiaXRtYXBfcmVzZXQoYml0bWFwLT5iaXRtYXAs
IG9mZnNldCwgYnl0ZXMpOw0KPj4gwqAgfQ0KPj4NCj4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQoNCg==

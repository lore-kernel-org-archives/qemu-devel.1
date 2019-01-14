Received: from eggs.gnu.org ([209.51.188.92]:60461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gj3XT-0004yP-6M
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gj3XR-0006Lm-9u
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:48:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 14 Jan 2019 14:48:13 +0000
Message-ID: <9767ccf8-6a00-88b0-e28a-3b8602580c2e@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
	<5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
	<29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
In-Reply-To: <29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <00BE60CADF5F5649B2A13803AF97AD43@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MTQuMDEuMjAxOSAxNzoxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wMS4xOSAxNTowMSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE0LjAxLjIwMTkgMTY6MTAs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyOS4xMi4xOCAxMzoyMCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gU2ltcGxpZnkgYmFja3VwX2luY3JlbWVudGFsX2lu
aXRfY29weV9iaXRtYXAgdXNpbmcgdGhlIGZ1bmN0aW9uDQo+Pj4+IGJkcnZfZGlydHlfYml0bWFw
X25leHRfZGlydHlfYXJlYS4NCj4+Pj4NCj4+Pj4gTm90ZTogbW92ZSB0byBqb2ItPmxlbiBpbnN0
ZWFkIG9mIGJpdG1hcCBzaXplOiBpdCBzaG91bGQgbm90IG1hdHRlciBidXQNCj4+Pj4gbGVzcyBj
b2RlLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBibG9jay9i
YWNrdXAuYyB8IDQwICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+
Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0K
Pj4+DQo+Pj4gT3ZlcmFsbDogV2hhdCBpcyB0aGlzIGZ1bmN0aW9uIGV2ZW4gc3VwcG9zZWQgdG8g
ZG8/ICBUbyBtZSwgaXQgbG9va3MNCj4+PiBsaWtlIGl0IG1hcmtzIGFsbCBhcmVhcyBpbiBqb2It
PmNvcHlfYml0bWFwIGRpcnR5IHRoYXQgYXJlIGRpcnR5IGluDQo+Pj4gam9iLT5zeW5jX2JpdG1h
cC4NCj4+Pg0KPj4+IElmIHNvLCB3b3VsZG4ndCBqdXN0IHJlcGxhY2luZyB0aGlzIGJ5IGhiaXRt
YXBfbWVyZ2UoKSBzaW1wbGlmeSB0aGluZ3MNCj4+PiBmdXJ0aGVyPw0KPj4+DQo+Pj4+IGRpZmYg
LS1naXQgYS9ibG9jay9iYWNrdXAuYyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+IGluZGV4IDQzNTQx
NGU5NjQuLmZiZTdjZTE5ZTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+
ICsrKyBiL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+IEBAIC00MDYsNDMgKzQwNiwyNyBAQCBzdGF0aWMg
aW50IGNvcm91dGluZV9mbiBiYWNrdXBfcnVuX2luY3JlbWVudGFsKEJhY2t1cEJsb2NrSm9iICpq
b2IpDQo+Pj4NCj4+PiBbLi4uXQ0KPj4+DQo+Pj4+ICsgICAgd2hpbGUgKGJkcnZfZGlydHlfYml0
bWFwX25leHRfZGlydHlfYXJlYShqb2ItPnN5bmNfYml0bWFwLA0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm9mZnNldCwgJmJ5dGVzKSkNCj4+Pj4g
KyAgICB7DQo+Pj4+ICsgICAgICAgIHVpbnQ2NF90IGNsdXN0ZXIgPSBvZmZzZXQgLyBqb2ItPmNs
dXN0ZXJfc2l6ZTsNCj4+Pj4gKyAgICAgICAgdWludDY0X3QgbGFzdF9jbHVzdGVyID0gKG9mZnNl
dCArIGJ5dGVzKSAvIGpvYi0+Y2x1c3Rlcl9zaXplOw0KPj4+PiAgICANCj4+Pj4gLSAgICAgICAg
bmV4dF9jbHVzdGVyID0gRElWX1JPVU5EX1VQKG9mZnNldCwgam9iLT5jbHVzdGVyX3NpemUpOw0K
Pj4+PiAtICAgICAgICBoYml0bWFwX3NldChqb2ItPmNvcHlfYml0bWFwLCBjbHVzdGVyLCBuZXh0
X2NsdXN0ZXIgLSBjbHVzdGVyKTsNCj4+Pj4gLSAgICAgICAgaWYgKG5leHRfY2x1c3RlciA+PSBl
bmQpIHsNCj4+Pj4gKyAgICAgICAgaGJpdG1hcF9zZXQoam9iLT5jb3B5X2JpdG1hcCwgY2x1c3Rl
ciwgbGFzdF9jbHVzdGVyIC0gY2x1c3RlciArIDEpOw0KPj4+DQo+Pj4gV2h5IHRoZSArMT8gIFNo
b3VsZG4ndCB0aGUgZGl2aXNpb24gZm9yIGxhc3RfY2x1c3RlciByb3VuZCB1cCBpbnN0ZWFkPw0K
Pj4+DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICAgb2Zmc2V0ID0gKGxhc3RfY2x1c3RlciArIDEpICog
am9iLT5jbHVzdGVyX3NpemU7DQo+Pj4NCj4+PiBTYW1lIGhlcmUuDQo+Pg0KPj4gbGFzdCBjbHVz
dGVyIGlzIG5vdCAiZW5kIiwgYnV0IGl0J3MgbGFzdCBkaXJ0eSBjbHVzdGVyLiBzbyBudW1iZXIg
b2YgZGlydHkgY2x1c3RlcnMgaXMgbGFzdF9jbHVzdGVyIC0gY2x1c3RlciArIDEsIGFuZCBuZXh0
IG9mZnNldCBpcyBjYWxjdWxhdGVkIHRocm91Z2ggKzEgdG9vLg0KPj4NCj4+IElmIEkgcm91bmQg
dXAgZGl2aXNpb24gcmVzdWx0LCBJJ2xsIGdldCBsYXN0IGZvciBtb3N0IGNhc2VzLCBidXQgImVu
ZCIgKG5leHQgYWZ0ZXIgdGhlIGxhc3QpLCBmb3IgdGhlIGNhc2Ugd2hlbiBvZmZzZXQgJSBqb2It
PmNsdXN0ZXJfc2l6ZSA9PSAwLCBzbywgaG93IHRvIHVzZSBpdD8NCj4gDQo+IERvZXNuJ3QgYmRy
dl9kaXJ0eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhKCkgcmV0dXJuIGEgcmFuZ2UgW29mZnNldCwN
Cj4gb2Zmc2V0ICsgYnl0ZXMpLCBpLmUuIHdoZXJlICJvZmZzZXQgKyBieXRlcyIgaXMgdGhlIGZp
cnN0IGNsZWFuIG9mZnNldD8NCg0Kb29wcywgeW91IGFyZSByaWdodC4gdGhlbiBJIG5lZWQNCnVp
bnQ2NF90IGxhc3RfY2x1c3RlciA9IChvZmZzZXQgKyBieXRlcyAtIDEpIC8gam9iLT5jbHVzdGVy
X3NpemU7DQoNCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

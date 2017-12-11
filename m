Received: from eggs.gnu.org ([2001:4830:134:3::10]:39967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1eORbL-0005A4-Ag
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1eORbK-0000wv-6U
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:10:47 -0500
References: <a2b410dd-1150-16a4-9376-069117a14c98@oracle.com>
	<5b24ac58-738a-ac39-f4ed-6cffb3727a26@oracle.com>
	<bd3649e6-0268-7329-0574-0767fe04b3c9@redhat.com>
From: George Kennedy <george.kennedy@oracle.com>
Message-ID: <35a0dce9-896a-300c-ae39-bb89f6d7d374@oracle.com>
Date: Mon, 11 Dec 2017 12:11:00 -0500
MIME-Version: 1.0
In-Reply-To: <bd3649e6-0268-7329-0574-0767fe04b3c9@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] lsi_scsi: add support for
 PPR Extended Message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

VGhhbmsgeW91IFBhb2xvLA0KDQoiU2lnbmVkLW9mZi1ieTogR2VvcmdlIEtlbm5lZHk8Z2Vv
cmdlLmtlbm5lZHlAb3JhY2xlLmNvbT4iDQoNCkdlb3JnZQ0KDQpPbiAxMi8xMS8yMDE3IDEx
OjU1IEFNLCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiBPbiAxMS8xMi8yMDE3IDE3OjQ1LCBH
ZW9yZ2UgS2VubmVkeSB3cm90ZToNCj4+IFRoZSBMU0kgNTNjODk1YSBjb2RlIGRvZXMgbm90
IGhhbmRsZSB0aGUgUFBSIEV4dGVuZGVkIE1lc3NhZ2UuIEFkZA0KPj4gc3VwcG9ydCB0byBo
YW5kbGUgUFBSIEV4dGVuZGVkIE1lc3NhZ2UgbGlrZSBTRFRSIGFuZCBXRFRSIGFyZSBoYW5k
bGVkLg0KPj4gVGhhdCBpcywgdG8gc2tpcCBwYXN0IHRoZSBtZXNzYWdlIGJ5dGVzIGFuZCBp
Z25vcmUgdGhlIG1lc3NhZ2UuDQo+Pg0KPj4gLS0tDQo+PiAgwqBody9zY3NpL2xzaTUzYzg5
NWEuYyB8IDQgKysrKw0KPj4gIMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9ody9zY3NpL2xzaTUzYzg5NWEuYyBiL2h3L3Njc2kvbHNp
NTNjODk1YS5jDQo+PiBpbmRleCA1OTVjMjYwLi4xZTAyYTg5IDEwMDY0NA0KPj4gLS0tIGEv
aHcvc2NzaS9sc2k1M2M4OTVhLmMNCj4+ICsrKyBiL2h3L3Njc2kvbHNpNTNjODk1YS5jDQo+
PiBAQCAtOTYxLDYgKzk2MSwxMCBAQCBzdGF0aWMgdm9pZCBsc2lfZG9fbXNnb3V0KExTSVN0
YXRlICpzKQ0KPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERQUklOVEYo
IldEVFIgKGlnbm9yZWQpXG4iKTsNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBsc2lfc2tpcF9tc2dieXRlcyhzLCAxKTsNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBicmVhazsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2Ug
NDoNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRFBSSU5URigiUFBSIChp
Z25vcmVkKVxuIik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxzaV9z
a2lwX21zZ2J5dGVzKHMsIDUpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBicmVhazsNCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDoNCj4+ICDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGJhZDsNCj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiBIaSBHZW9yZ2UsDQo+DQo+IGZvciBhIHBhdGNoIHRv
IFFFTVUgdG8gYmUgYWNjZXB0ZWQsIHlvdSBuZWVkIHRvIGNvbmZpcm0gdGhlIG9yaWdpbiBv
Zg0KPiB5b3VyIHBhdGNoIChhY2NvcmRpbmcgdG8gdGhlICJEZXZlbG9wZXIgQ2VydGlmaWNh
dGUgb2YgT3JpZ2luIiwgc2VlDQo+IGh0dHBzOi8vZGV2ZWxvcGVyY2VydGlmaWNhdGUub3Jn
LykuDQo+DQo+IEluIG9yZGVyIHRvIGRvIHRoaXMsIGl0J3MgZW5vdWdoIHRvIHJlcGx5IHRv
IHRoaXMgbWVzc2FnZSB3aXRoDQo+ICJTaWduZWQtb2ZmLWJ5OiBHZW9yZ2UgS2VubmVkeSA8
Z2VvcmdlLmtlbm5lZHlAb3JhY2xlLmNvbT4iIGluIHRoZSByZXBseS4NCj4NCj4gVGhhbmtz
LA0KPg0KPiBQYW9sbw0KDQo=

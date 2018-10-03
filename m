Received: from eggs.gnu.org ([2001:4830:134:3::10]:56733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7hlL-0006E4-50
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7hlF-0007xI-CH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:04:27 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 14:04:11 +0000
Message-ID: <7dbf566b-8090-82cf-9a9b-d969e9e0a60f@virtuozzo.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
	<20181002230218.13949-6-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-6-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B3C3A373FF2034B87F8B7EBB8F1CDD9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 5/6] block/backup: prohibit backup from
 using in use bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

MDMuMTAuMjAxOCAwMjowMiwgSm9obiBTbm93IHdyb3RlOg0KPiBJZiB0aGUgYml0bWFwIGlzIGZy
b3plbiwgd2Ugc2hvdWxkbid0IHRvdWNoIGl0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNu
b3cgPGpzbm93QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgYmxvY2tk
ZXYuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9ibG9ja2Rldi5jIGIvYmxvY2tk
ZXYuYw0KPiBpbmRleCBkMGZlYmZjYTc5Li4wOThkNGMzMzdmIDEwMDY0NA0KPiAtLS0gYS9ibG9j
a2Rldi5jDQo+ICsrKyBiL2Jsb2NrZGV2LmMNCj4gQEAgLTM1MTIsMTAgKzM1MTIsMTAgQEAgc3Rh
dGljIEJsb2NrSm9iICpkb19kcml2ZV9iYWNrdXAoRHJpdmVCYWNrdXAgKmJhY2t1cCwgSm9iVHhu
ICp0eG4sDQo+ICAgICAgICAgICAgICAgYmRydl91bnJlZih0YXJnZXRfYnMpOw0KPiAgICAgICAg
ICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgICAgICAgfQ0KPiAtICAgICAgICBpZiAoYmRydl9kaXJ0
eV9iaXRtYXBfcW1wX2xvY2tlZChibWFwKSkgew0KPiArICAgICAgICBpZiAoYmRydl9kaXJ0eV9i
aXRtYXBfdXNlcl9sb2NrZWQoYm1hcCkpIHsNCj4gICAgICAgICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICJCaXRtYXAgJyVzJyBpcyBjdXJyZW50bHkg
bG9ja2VkIGFuZCBjYW5ub3QgYmUgdXNlZCBmb3IgIg0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAiYmFja3VwIiwgYmFja3VwLT5iaXRtYXApOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAi
Qml0bWFwICclcycgaXMgY3VycmVudGx5IGluIHVzZSBieSBhbm90aGVyIG9wZXJhdGlvbiINCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgIiBhbmQgY2Fubm90IGJlIHVzZWQgZm9yIGJhY2t1cCIs
IGJhY2t1cC0+Yml0bWFwKTsNCj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgICAg
IH0NCj4gICAgICAgfQ0KPiBAQCAtMzYyMCwxMCArMzYyMCwxMCBAQCBCbG9ja0pvYiAqZG9fYmxv
Y2tkZXZfYmFja3VwKEJsb2NrZGV2QmFja3VwICpiYWNrdXAsIEpvYlR4biAqdHhuLA0KPiAgICAg
ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkJpdG1hcCAnJXMnIGNvdWxkIG5vdCBiZSBmb3Vu
ZCIsIGJhY2t1cC0+Yml0bWFwKTsNCj4gICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAg
ICAgIH0NCj4gLSAgICAgICAgaWYgKGJkcnZfZGlydHlfYml0bWFwX3FtcF9sb2NrZWQoYm1hcCkp
IHsNCj4gKyAgICAgICAgaWYgKGJkcnZfZGlydHlfYml0bWFwX3VzZXJfbG9ja2VkKGJtYXApKSB7
DQo+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAiQml0bWFwICclcycgaXMgY3VycmVudGx5IGxvY2tlZCBhbmQgY2Fubm90IGJlIHVzZWQg
Zm9yICINCj4gLSAgICAgICAgICAgICAgICAgICAgICAgImJhY2t1cCIsIGJhY2t1cC0+Yml0bWFw
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIkJpdG1hcCAnJXMnIGlzIGN1cnJlbnRseSBp
biB1c2UgYnkgYW5vdGhlciBvcGVyYXRpb24iDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICIg
YW5kIGNhbm5vdCBiZSB1c2VkIGZvciBiYWNrdXAiLCBiYWNrdXAtPmJpdG1hcCk7DQo+ICAgICAg
ICAgICAgICAgZ290byBvdXQ7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQoNCg==

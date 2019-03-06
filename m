Received: from eggs.gnu.org ([209.51.188.92]:40960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1X3G-0001Gy-Rt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1X3E-0006Dy-TI
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:57:42 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 13:57:32 +0000
Message-ID: <bf5ac5ae-e1d7-2ddf-e00d-7c2c175d18d7@virtuozzo.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-7-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-7-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <263A19E14339F24AB7215195247A843E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

MDEuMDMuMjAxOSAyMjoxNSwgSm9obiBTbm93IHdyb3RlOg0KPiBXZSBkaWRuJ3QgZG8gYW55IHN0
YXRlIGNoZWNraW5nIG9uIHNvdXJjZSBiaXRtYXBzIGF0IGFsbCwNCj4gc28gdGhpcyBhZGRzIGlu
Y29uc2lzdGVudCBhbmQgYnVzeSBjaGVja3MuIHJlYWRvbmx5IGlzDQo+IGFsbG93ZWQsIHNvIHlv
dSBjYW4gc3RpbGwgY29weSBhIHJlYWRvbmx5IGJpdG1hcCB0byBhIG5ldw0KPiBkZXN0aW5hdGlv
biB0byB1c2UgaXQgZm9yIG9wZXJhdGlvbnMgbGlrZSBkcml2ZS1iYWNrdXAuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4N
Cg0KPiAtLS0NCj4gICBibG9jay9kaXJ0eS1iaXRtYXAuYyB8IDMgKysrDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2RpcnR5LWJp
dG1hcC5jIGIvYmxvY2svZGlydHktYml0bWFwLmMNCj4gaW5kZXggNzY5NjY4Y2NkYy4uODQwM2M5
OTgxZCAxMDA2NDQNCj4gLS0tIGEvYmxvY2svZGlydHktYml0bWFwLmMNCj4gKysrIGIvYmxvY2sv
ZGlydHktYml0bWFwLmMNCj4gQEAgLTgyNSw2ICs4MjUsOSBAQCB2b2lkIGJkcnZfbWVyZ2VfZGly
dHlfYml0bWFwKEJkcnZEaXJ0eUJpdG1hcCAqZGVzdCwgY29uc3QgQmRydkRpcnR5Qml0bWFwICpz
cmMsDQo+ICAgICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgfQ0KPiAgIA0KPiArICAgIGlmIChi
ZHJ2X2RpcnR5X2JpdG1hcF9jaGVjayhzcmMsIEJEUlZfQklUTUFQX0FMTE9XX1JPLCBlcnJwKSkg
ew0KPiArICAgICAgICBnb3RvIG91dDsNCj4gKyAgICB9DQo+ICAgDQo+ICAgICAgIGlmICghaGJp
dG1hcF9jYW5fbWVyZ2UoZGVzdC0+Yml0bWFwLCBzcmMtPmJpdG1hcCkpIHsNCj4gICAgICAgICAg
IGVycm9yX3NldGcoZXJycCwgIkJpdG1hcHMgYXJlIGluY29tcGF0aWJsZSBhbmQgY2FuJ3QgYmUg
bWVyZ2VkIik7DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

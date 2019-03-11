Received: from eggs.gnu.org ([209.51.188.92]:53968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Frp-0008GY-H0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h3Fmo-00083r-72
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:55:50 -0400
Received: from mail-eopbgr50118.outbound.protection.outlook.com
	([40.107.5.118]:9733
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1h3Fmn-00081d-Iw
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:55:50 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Mar 2019 07:55:43 +0000
Message-ID: <c04d20fe-d6a5-5648-b7cb-aa40d5b36e77@virtuozzo.com>
References: <20190310113408.59912-1-liq3ea@163.com>
In-Reply-To: <20190310113408.59912-1-liq3ea@163.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B64E1F554ED194AAF83CD285E8D8851@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] tests: test-bdrv-graph-mod: fix memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, "kwolf@redhat.com" <kwolf@redhat.com>
Cc: "liq3ea@gmail.com" <liq3ea@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

MTAuMDMuMjAxOSAxNDozNCwgTGkgUWlhbmcgd3JvdGU6DQo+IEZpeGVzOiAyZGJmYWRmDQo+IFNw
b3R0ZWQgYnkgQVNBTiB3aGVuICdtYWtlIGNoZWNrJy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExp
IFFpYW5nIDxsaXEzZWFAMTYzLmNvbT4NCg0KT29wcywgbXkgZmF1bHQsIHRoYW5rIHlvdSBmb3Ig
Zml4aW5nIHRoaXMhDQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCj4gLS0tDQo+ICAgdGVzdHMvdGVzdC1iZHJ2
LWdyYXBoLW1vZC5jIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGVzdC1iZHJ2LWdyYXBoLW1vZC5jIGIvdGVzdHMvdGVz
dC1iZHJ2LWdyYXBoLW1vZC5jDQo+IGluZGV4IDQ1OGRmYTY2NjEuLjhiZjBmZTczNWQgMTAwNjQ0
DQo+IC0tLSBhL3Rlc3RzL3Rlc3QtYmRydi1ncmFwaC1tb2QuYw0KPiArKysgYi90ZXN0cy90ZXN0
LWJkcnYtZ3JhcGgtbW9kLmMNCj4gQEAgLTExNyw2ICsxMTcsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0
X3VwZGF0ZV9wZXJtX3RyZWUodm9pZCkNCj4gICANCj4gICAgICAgYmRydl91bnJlZihicyk7DQo+
ICAgICAgIGJsa191bnJlZihyb290KTsNCj4gKyAgICBlcnJvcl9mcmVlKGxvY2FsX2Vycik7DQo+
ICAgfQ0KPiAgIA0KPiAgIC8qDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==

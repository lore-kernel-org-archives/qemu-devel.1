Received: from eggs.gnu.org ([2001:4830:134:3::10]:47409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ecRpu-0000Ao-EU
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ecRpq-0001rL-53
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:15:42 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2309 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ecRpp-0001q8-Pj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:15:38 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Fri, 19 Jan 2018 08:13:24 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB52A7A@DGGEMM505-MBS.china.huawei.com>
References: <cover.1516329752.git.arei.gonglei@huawei.com>
	<151634631594.596.13980731914055637021@5adcb62bf0d6>
In-Reply-To: <151634631594.596.13980731914055637021@5adcb62bf0d6>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "famz@redhat.com" <famz@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, longpeng <longpeng2@huawei.com>

Wy4uLl0NCg0KPiBDb25maWd1cmUgb3B0aW9uczoNCj4gLS1lbmFibGUtd2Vycm9yIC0tdGFyZ2V0
LWxpc3Q9eDg2XzY0LXNvZnRtbXUsYWFyY2g2NC1zb2Z0bW11IC0tDQo+IHByZWZpeD0vdG1wL3Fl
bXUtdGVzdC9pbnN0YWxsDQpbLi4uXQ0KDQo+IEtWTSBzdXBwb3J0ICAgICAgIHllcw0KPiBIQVgg
c3VwcG9ydCAgICAgICBubw0KPiBIVkYgc3VwcG9ydCAgICAgICBubw0KPiBUQ0cgc3VwcG9ydCAg
ICAgICB5ZXMNCj4gVENHIGRlYnVnIGVuYWJsZWQgbm8NCj4gVENHIGludGVycHJldGVyICAgbm8N
Cj4gbWFsbG9jIHRyaW0gc3VwcG9ydCB5ZXMNCj4gUkRNQSBzdXBwb3J0ICAgICAgeWVzDQo+IGZk
dCBzdXBwb3J0ICAgICAgIHllcw0KPiBwcmVhZHYgc3VwcG9ydCAgICB5ZXMNCj4gZmRhdGFzeW5j
ICAgICAgICAgeWVzDQo+IG1hZHZpc2UgICAgICAgICAgIHllcw0KPiBwb3NpeF9tYWR2aXNlICAg
ICB5ZXMNCj4gbGliY2FwLW5nIHN1cHBvcnQgbm8NCj4gdmhvc3QtbmV0IHN1cHBvcnQgeWVzDQo+
IHZob3N0LWNyeXB0byBzdXBwb3J0IHllcw0KPiB2aG9zdC1zY3NpIHN1cHBvcnQgeWVzDQo+IHZo
b3N0LXZzb2NrIHN1cHBvcnQgeWVzDQo+IHZob3N0LXVzZXIgc3VwcG9ydCB5ZXMNClsuLi5dDQoN
Cj4gbWFrZVsxXTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgYC4uL2JhY2tlbmRzL2NyeXB0
b2Rldi12aG9zdC11c2VyLm8nLA0KPiBuZWVkZWQgYnkgYHFlbXUtc3lzdGVtLXg4Nl82NCcuICBT
dG9wLg0KPiBtYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KDQpC
dXQgaXQncyBzdWNjZXNzZnVsbHkgY29tcGlsZWQgdXNpbmcgY2VudG9zNyBhbmQgbWluZ3czMiBs
b2NhbGx5LCBhbmQgSSBjb3VsZG4ndA0KcmVwcm9kdWNlIHRoaXMuIElzIGl0IHJlbGF0ZWQgdG8g
ZG9ja2VyPyAoSSBkb24ndCBoYXZlIGRvY2tlciBlbnZpcm9ubWVudCBpbiBoYW5kKQ0KDQpSZWdh
cmRzLA0KSmF5DQoNCg0K

Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2ECC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6899D20672
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 16:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6899D20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iajHJ-0005vx-At
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 11:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaifv-0000Mj-R4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaifo-00028g-W1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:59:15 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:46077)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iaifo-0001pw-Ma; Fri, 29 Nov 2019 10:59:12 -0500
IronPort-SDR: RrpVsafef8GvYfhN9b7gems2e8x126OoQCTOXxsVeGPXVjw23p4J6Ti24F/6isr7sP266CWE4G
 JPsEQwin7ByMoTcb7PHxwP6lDfJBEPOQwFNgM2NlwaASAze3h3v4UK7xv3tYrmh4jvJ7YLNKJX
 9NvuOgMZJ6EBsIYnRQq+Ou/lN+8P4sl2KaoML2UeqsH7+4qJ6Jq/R3S5Wy/WTGckPe5UhT+lcz
 5qxgghijQuHKc/RANCB2veCUFaRBdAWR5d7GHPJzBsAgMN9TdkRw9A736b5e+hSD4CbreMLMsP
 qSw=
X-IronPort-AV: E=Sophos;i="5.69,257,1571731200"; d="scan'208";a="43631118"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa3.mentor.iphmx.com with ESMTP; 29 Nov 2019 07:59:06 -0800
IronPort-SDR: 5RegC455+GJpQy38oG9WxXAB++Z6w1Km3HLqUFxfu+IwizpNJ6sTm0Qt0UGHathjtP7v75wl8/
 IjmIGFqp5IT9LBYTGw1OxjxXV3GTwgkRGPujrDXe2tgGCMUx2ivxQhCfcoJwNDVRIWDN5IG7rD
 ZsjherK8pmUMYuUgYiqEgrgMu/Q2MoDRPdjBQLLKI6iw9aTPycs6rjA/+S8WNQ47/DTTzc9tOg
 s5JEz+rGoCE2b8UwJe8kcUGAC1m5q2kHFO3KS6pse4GD/nQfFKGjV+mxzQFvfacmmM0msL22v4
 6ME=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "bilalwasim676@gmail.com" <bilalwasim676@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
Thread-Topic: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
Thread-Index: AQHVpsZtzk/Nr8P2J0mB7aONo8AxiKeiSHsAgAAFdlA=
Date: Fri, 29 Nov 2019 15:59:00 +0000
Message-ID: <8c956ae31e8f44a2b831a5030b2448b4@SVR-IES-MBX-03.mgc.mentorg.com>
References: <20191129150508.24404-1-bilalwasim676@gmail.com>
 <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
In-Reply-To: <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
Accept-Language: en-GB, en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.137.180
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, "aa1ronham@gmail.com" <aa1ronham@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "linux@roeck-us.net" <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmtzIGZvciB0aGUgcG9pbnRlcnMgcGhpbGlwcGUuLiBJcyB0aGUgcGF0Y2ggb2theSB0byBi
ZSBtZXJnZWQgd2l0aG91dCBpdCBvciBkbyBJIG5lZWQgdG8gZG8gYSByZS1zdWJtaXNzaW9uIHdp
dGggdGhlIHVwZGF0ZWQgdXNlcm5hbWUgPw0KDQotIEJpbGFsIA0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgW21haWx0bzpwaGlsbWRA
cmVkaGF0LmNvbV0gDQpTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI5LCAyMDE5IDg6MzggUE0NClRv
OiBiaWxhbHdhc2ltNjc2QGdtYWlsLmNvbTsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpDYzogcGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBhYTFyb25oYW1AZ21haWwuY29tOyBqY2RAdHJpYnVkdWJv
aXMubmV0OyBxZW11LWFybUBub25nbnUub3JnOyBXYXNpbSwgQmlsYWwgPEJpbGFsX1dhc2ltQG1l
bnRvci5jb20+OyBsaW51eEByb2Vjay11cy5uZXQ7IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvaW14X2ZlYzogVXBkYXRpbmcgdGhlIElN
WF9GRUMgSVAgdG8gc3VwcG9ydCBsb29wYmFjayBtb2RlLg0KDQpIaSBCaWxhbCwNCg0KQ2MnaW5n
IEphc29uLCB0aGUgbWFpbnRhaW5lciBvZiBuZXR3b3JrIGRldmljZXMuDQoNCk9uIDExLzI5LzE5
IDQ6MDUgUE0sIGJpbGFsd2FzaW02NzZAZ21haWwuY29tIHdyb3RlOg0KPiBGcm9tOiBid2FzaW0g
PGJpbGFsX3dhc2ltQG1lbnRvci5jb20+DQoNCllvdXIgZ2l0IHNldHVwIG1pc3NlcyB5b3VyICd1
c2VyLm5hbWUnLCB5b3UgY291bGQgZml4IGl0IHJ1bm5pbmc6DQoNCiAgIGdpdCBjb25maWcgdXNl
ci5uYW1lICJCaWxhbCBXYXNpbSINCg0KKGV2ZW50dWFsbHkgd2l0aCB0aGUgLS1nbG9iYWwgb3B0
aW9uKS4NCg0KVGhlIHBhdGNoIGxvb2tzIGdvb2Qgb3RoZXJ3aXNlLg0KDQpUaGFua3MhDQoNCj4g
TG9vcGJhY2sgbW9kZSBvbmx5IHdvcmtzIHdoZW4gc3BlY2lmaWMgY29uZGl0aW9ucyAoYXMgZGlj
dGF0ZWQgYnkgdGhlIA0KPiBJUCBndWlkZSkgYXJlIG1ldCwgaS5lLiB0aGUgTUlJX01PREUgaXMg
c2V0IGFuZCB0aGUgUk1JSV9NT0RFIGlzIA0KPiBjbGVhcmVkLiBJZiBub3QsIHdlIHNpbXBseSBz
ZW5kIHRoZSBwYWNrZXQgb24gdGhlIG91dHB1dCBxdWV1ZSAoZm9yIFRYIA0KPiB0byB0aGUgaG9z
dCBuZXR3b3JrKS4gVGVzdGVkIGJ5IHJ1bm5pbmcgYSBjdXN0b20gUlRPUyBhbmQgVFhpbmcgYSB0
b24gDQo+IG9mIHBhY2tldHMuIFRoZSBzYW1lIHBhY2tldHMgd2VyZSByZWNlaXZlZCBvbiB0aGUg
Ulggc2lkZS4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaWxhbCBXYXNpbSA8YmlsYWxfd2FzaW1A
bWVudG9yLmNvbT4NCj4gLS0tDQo+ICAgaHcvbmV0L2lteF9mZWMuYyB8IDI3ICsrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L25ldC9pbXhfZmVjLmMgYi9ody9u
ZXQvaW14X2ZlYy5jIGluZGV4IA0KPiBiZDk5MjM2ODY0Li5jNTFlN2Y3MzYzIDEwMDY0NA0KPiAt
LS0gYS9ody9uZXQvaW14X2ZlYy5jDQo+ICsrKyBiL2h3L25ldC9pbXhfZmVjLmMNCj4gQEAgLTI1
Niw2ICsyNTYsMjkgQEAgc3RhdGljIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX2lt
eF9ldGggPSANCj4gew0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIGlteF9ldGhfdXBkYXRlKElNWEZF
Q1N0YXRlICpzKTsNCj4gICANCj4gKy8qDQo+ICsgKiBGdW5jdGlvbiB0byBjaGVjayBpZiB0aGUg
TUFDIGlzIGNvbmZpZ3VyZWQgdG8gcnVuIGluIGxvb3BiYWNrIG1vZGUuDQo+ICsgKiBJZiBzbywg
aW52b2tlIHRoZSAicmVjZWl2ZSIgcm91dGluZS4NCj4gKyAqIEVsc2Ugd3JpdGUgdG8gdGhlIG91
dHB1dC4NCj4gKyAqICovDQo+ICtzdGF0aWMgdm9pZCBzZW5kX3BrdChJTVhGRUNTdGF0ZSAqcywg
dWludDhfdCAqZnJhbWUsIGludCBmcmFtZV9zaXplKSANCj4gK3sNCj4gKyAgICBOZXRDbGllbnRT
dGF0ZSAqbmMgPSBxZW11X2dldF9xdWV1ZShzLT5uaWMpOw0KPiArDQo+ICsgICAgLyoNCj4gKyAg
ICAgKiBMb29wYmFjayBvciBOb3JtYWwgbW9kZSA/DQo+ICsgICAgICogUGVyIHRoZSBGRUMgTWFu
dWFsOiBJZiBsb29wYmFjayBpcyBlbmFibGVkLCB0aGUgTUlJX01PREUNCj4gKyAgICAgKiBzaG91
bGQgYmUgU0VUIGFuZCB0aGUgUk1JSV9NT0RFIHNob3VsZCBiZSBjbGVhcmVkLiBMb29wYmFjaw0K
PiArICAgICAqIHdpbGwgb25seSB3b3JrIGlmIHRoaXMgY3JpdGVyaW9uIGlzIG1ldC4gSWYgbm90
IG1ldCwNCj4gKyAgICAgKiB3ZSB3aWxsIHNlbmQgdGhlIGZyYW1lIG9uIHRoZSBvdXRwdXQgcXVl
dWUuICovDQo+ICsgICAgaWYgKChzLT5yZWdzW0VORVRfUkNSXSAmIEVORVRfUkNSX0xPT1ApICYm
IChzLT5yZWdzW0VORVRfUkNSXSAmIEVORVRfUkNSX01JSV9NT0RFKQ0KPiArICAgICAgICAgICAg
JiYgIShzLT5yZWdzW0VORVRfUkNSXSAmIEVORVRfUkNSX1JNSUlfTU9ERSkpIHsNCj4gKyAgICAg
ICAgbmMtPmluZm8tPnJlY2VpdmUobmMsIGZyYW1lLCBmcmFtZV9zaXplKTsNCj4gKyAgICB9IGVs
c2Ugew0KPiArICAgICAgICBxZW11X3NlbmRfcGFja2V0KG5jLCBmcmFtZSwgZnJhbWVfc2l6ZSk7
DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICAgLyoNCj4gICAgKiBUaGUgTUlJIHBoeSBjb3VsZCBy
YWlzZSBhIEdQSU8gdG8gdGhlIHByb2Nlc3NvciB3aGljaCBpbiB0dXJuDQo+ICAgICogY291bGQg
YmUgaGFuZGxlZCBhcyBhbiBpbnRlcnJwdCBieSB0aGUgT1MuDQo+IEBAIC00ODgsNyArNTExLDcg
QEAgc3RhdGljIHZvaWQgaW14X2ZlY19kb190eChJTVhGRUNTdGF0ZSAqcykNCj4gICAgICAgICAg
IGZyYW1lX3NpemUgKz0gbGVuOw0KPiAgICAgICAgICAgaWYgKGJkLmZsYWdzICYgRU5FVF9CRF9M
KSB7DQo+ICAgICAgICAgICAgICAgLyogTGFzdCBidWZmZXIgaW4gZnJhbWUuICAqLw0KPiAtICAg
ICAgICAgICAgcWVtdV9zZW5kX3BhY2tldChxZW11X2dldF9xdWV1ZShzLT5uaWMpLCBzLT5mcmFt
ZSwgZnJhbWVfc2l6ZSk7DQo+ICsgICAgICAgICAgICBzZW5kX3BrdChzLCAodWludDhfdCAqKSZz
LT5mcmFtZSwgZnJhbWVfc2l6ZSk7DQo+ICAgICAgICAgICAgICAgcHRyID0gcy0+ZnJhbWU7DQo+
ICAgICAgICAgICAgICAgZnJhbWVfc2l6ZSA9IDA7DQo+ICAgICAgICAgICAgICAgcy0+cmVnc1tF
TkVUX0VJUl0gfD0gRU5FVF9JTlRfVFhGOyBAQCAtNTg2LDcgKzYwOSw3IEBAIA0KPiBzdGF0aWMg
dm9pZCBpbXhfZW5ldF9kb190eChJTVhGRUNTdGF0ZSAqcywgdWludDMyX3QgaW5kZXgpDQo+ICAg
ICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgIC8qIExhc3QgYnVmZmVyIGluIGZyYW1lLiAg
Ki8NCj4gICANCj4gLSAgICAgICAgICAgIHFlbXVfc2VuZF9wYWNrZXQocWVtdV9nZXRfcXVldWUo
cy0+bmljKSwgcy0+ZnJhbWUsIGZyYW1lX3NpemUpOw0KPiArICAgICAgICAgICAgc2VuZF9wa3Qo
cywgKHVpbnQ4X3QgKikmcy0+ZnJhbWUsIGZyYW1lX3NpemUpOw0KPiAgICAgICAgICAgICAgIHB0
ciA9IHMtPmZyYW1lOw0KPiAgIA0KPiAgICAgICAgICAgICAgIGZyYW1lX3NpemUgPSAwOw0KPiAN
Cg0K


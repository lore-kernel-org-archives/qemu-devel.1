Received: from eggs.gnu.org ([2001:4830:134:3::10]:41908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJdMc-0001Pf-OQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJdMZ-00062t-J3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:43:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJdMZ-00061x-0A
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:43:39 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 28 Nov 2017 10:43:16 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
In-Reply-To: <6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyOCwg
MjAxNyA2OjAyIFBNDQo+IFRvOiBHb25nbGVpIChBcmVpKTsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgSHVhbmd3ZWlkb25nIChDKTsgc3RlZmFuaGFAcmVkaGF0
LmNvbTsgWmhvdWppYW4NCj4gKGpheSk7IHBhc2ljQGxpbnV4LnZuZXQuaWJtLmNvbTsgbG9uZ3Bl
bmc7IHhpbi56ZW5nQGludGVsLmNvbTsNCj4gcm95LmZhbi56aGFuZ0BpbnRlbC5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLzRdIGNyeXB0b2Rldi12aG9zdC11c2VyOiBhZGQgY3J5cHRvIHNl
c3Npb24gaGFuZGxlcg0KPiANCj4gT24gMjgvMTEvMjAxNyAxMDowMywgR29uZ2xlaSB3cm90ZToN
Cj4gPiBJbnRyb2R1Y2UgdHdvIHZob3N0LXVzZXIgbWVhc3NnZXM6DQo+IFZIT1NUX1VTRVJfQ1JF
QVRFX0NSWVBUT19TRVNTSU9ODQo+ID4gYW5kIFZIT1NUX1VTRVJfQ0xPU0VfQ1JZUFRPX1NFU1NJ
T04uIEF0IHRoaXMgcG9pbnQsIHRoZSBRRU1VIHNpZGUNCj4gPiBzdXBwb3J0IGNyeXB0byBvcGVy
YXRpb24gaW4gY3J5cHRvZGV2IGhvc3QtdXNlciBiYWNrZW5kLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogR29uZ2xlaSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTG9uZ3BlbmcoTWlrZSkgPGxvbmdwZW5nMkBodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFpob3VqaWFuIDxqaWFuamF5Lnpob3VAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgYmFj
a2VuZHMvY3J5cHRvZGV2LXZob3N0LXVzZXIuYyAgIHwgNTAgKysrKysrKysrKysrKysrKystLS0t
LQ0KPiA+ICBkb2NzL2ludGVyb3Avdmhvc3QtdXNlci50eHQgICAgICAgfCAxOSArKysrKysrKysN
Cj4gPiAgaHcvdmlydGlvL3Zob3N0LXVzZXIuYyAgICAgICAgICAgIHwgODkNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvaHcvdmlydGlvL3Zo
b3N0LWJhY2tlbmQuaCB8ICA4ICsrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNTUgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+IA0KPiBBcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCBW
SVJUSU9fQ1JZUFRPX0NJUEhFUl9DUkVBVEVfU0VTU0lPTiBpcyBjYWxsZWQgYXMNCj4gYSByZXN1
bHQgb2Ygc2VuZGluZyBhIG1lc3NhZ2Ugb24gdGhlIGNvbnRyb2wgdmlydHF1ZXVlLg0KPiANClZJ
UlRJT19DUllQVE9fQ0lQSEVSX0NSRUFURV9TRVNTSU9OIGlzIGEgbWVzc2FnZSB0eXBlIG9mIGNv
bnRyb2wgcXVldWUsDQpNZWFucyBjcmVhdGluZyBhIHNlc3Npb24gZm9yIG5leHQgY3J5cHRvIHJl
cXVlc3RzLg0KDQo+IFdoeSBjYW4ndCB2aG9zdC11c2VyIGFsc28gcHJvY2VzcyBjcmVhdGUvZGVz
dHJveSBzZXNzaW9uIG1lc3NhZ2VzIG9uIHRoZQ0KPiBjb250cm9sIHZpcnRxdWV1ZSwgaW5zdGVh
ZCBvZiBoYXZpbmcgZGV2aWNlLXNwZWNpZmljIG1lc3NhZ2VzIGluIHRoZQ0KPiBwcm90b2NvbD8N
Cj4gDQpZb3UgbWVhbiB3ZSBjYW4gc2hhcmUgY29udHJvbCB2aXJ0cXVldWUgdG8gRFBESyBhcyB3
ZWxsPyBMaWtlIGRhdGEgcXVldWVzPw0KDQpNYXliZSBJIGRvbid0IGdldCB5b3VyIHBvaW50LiA6
KA0KDQpUaGFua3MsDQotR29uZ2xlaQ0K

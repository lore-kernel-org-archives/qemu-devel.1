Received: from eggs.gnu.org ([2001:4830:134:3::10]:58386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJsCW-0001ph-Bf
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:34:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJsCS-0001Kj-CC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:34:16 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2234 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eJsCS-0001Ip-05
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:34:12 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 29 Nov 2017 02:33:59 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A8D54@DGGEMA505-MBS.china.huawei.com>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
	<3f0ed9b0-ff77-bb0f-c868-609abf0826b2@redhat.com>
In-Reply-To: <3f0ed9b0-ff77-bb0f-c868-609abf0826b2@redhat.com>
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
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "jianfeng.tan@intel.com" <jianfeng.tan@intel.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAyOCwg
MjAxNyA3OjIwIFBNDQo+IFRvOiBHb25nbGVpIChBcmVpKTsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+IENjOiBtc3RAcmVkaGF0LmNvbTsgSHVhbmd3ZWlkb25nIChDKTsgc3RlZmFuaGFAcmVkaGF0
LmNvbTsgWmhvdWppYW4NCj4gKGpheSk7IHBhc2ljQGxpbnV4LnZuZXQuaWJtLmNvbTsgbG9uZ3Bl
bmc7IHhpbi56ZW5nQGludGVsLmNvbTsNCj4gcm95LmZhbi56aGFuZ0BpbnRlbC5jb20NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLzRdIGNyeXB0b2Rldi12aG9zdC11c2VyOiBhZGQgY3J5cHRvIHNl
c3Npb24gaGFuZGxlcg0KPiANCj4gT24gMjgvMTEvMjAxNyAxMjowNiwgR29uZ2xlaSAoQXJlaSkg
d3JvdGU6DQo+ID4+PiBZb3UgbWVhbiB3ZSBjYW4gc2hhcmUgY29udHJvbCB2aXJ0cXVldWUgdG8g
RFBESyBhcyB3ZWxsPyBMaWtlIGRhdGENCj4gcXVldWVzPw0KPiA+PiBJIGRvbid0IGtub3cgOikg
YnV0IHdoeSBub3Q/DQo+ID4+DQo+ID4gQ3VycmVudCB0aGVyZSBhcmUgdHdvIG1haW4gcmVhc29u
cyBmb3IgdGhpcyBkZXNpZ246DQo+ID4NCj4gPiAxKSB3ZSBzaG91bGQgdXNlIGFub3RoZXIgY3B1
IHRvIHBvbGxpbmcgdGhlIGNvbnRyb2wgdmlydHF1ZXVlLCB3aGljaCBpcw0KPiBleHBlbnNpdmUu
DQo+IA0KPiBJSVJDIERQREsgYWxzbyBzdXBwb3J0cyBpbnRlcnJ1cHQgbW9kZSwgZG9lc24ndCBp
dD8gIElzIGl0IHBvc3NpYmxlIHRvDQo+IGRvIGludGVycnVwdCBtb2RlIGZvciBzb21lIHZpcnRx
dWV1ZXMgYW5kIHBvbGwgbW9kZSBmb3Igb3RoZXJzPw0KPiANCg0KVGhlIGludGVsIGd1eSBUYW4g
KENjaW5nKSBzYWlkIHRvIG1lOg0KDQoiIEludGVycnVwdCBtb2RlIGZvciB2aG9zdC11c2VyIGlz
IHN0aWxsIG5vdCBzdXBwb3J0ZWQgaW4gY3VycmVudCANCmltcGxlbWVudGF0aW9uLiBCdXQgd2Ug
YXJlIGV2YWx1YXRpbmcgdGhlIG5lY2Vzc2l0eSBub3cuDQoNCkFuZCB5ZXMsIHRoZSBtb2RlIChw
b2xsaW5nIG9yIGludGVycnVwdCkgY2FuIGJlIGRpZmZlcmVudCBmb3IgZGlmZmVyZW50IA0KcXVl
dWVzLiINCg0KPiA+IDIpIHdlIHNob3VsZCBjb3B5IHRoZSBsb2dpYyBvZiBwYXJzaW5nIGNvbnRy
b2wgbWVzc2FnZSB0byBEUERLLCB3aGljaCBicmVhaw0KPiA+ICBjdXJyZW50IGxheWVyZWQgYXJj
aGl0ZWN0dXJlIC4NCj4gDQo+IEJ1dCBpc24ndCBpdCBhbHJlYWR5IGEgbGF5ZXJpbmcgdmlvbGF0
aW9uIHRoYXQgeW91J3JlIGFkZGluZyAqc29tZSoNCj4gY29udHJvbCBtZXNzYWdlcyB0byB0aGUg
dmhvc3QtdXNlciBwcm90b2NvbD8gIEkgYW0gbm90IHN1cmUgd2h5IG9ubHkNCj4gdGhlc2UgdHdv
IGFyZSBuZWNlc3NhcnkuDQo+IA0KU29ycnksIGJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgaXMgbGF5
ZXJpbmcgdmlvbGF0aW9uLCBqdXN0IGxpa2UgInZob3N0X25ldF9zZXRfbXR1Ig0KZm9yIHZob3N0
LW5ldCBhbmQgInZob3N0X3Zzb2NrX3NldF9ndWVzdF9jaWRfb3AiIGZvciB2aG9zdF92c29jay4g
VGhleSdyZSBhbGwNCmRldmljZS1zcGVjaWZpYyBtZXNzYWdlcy4gQXJlbid0IHRoZXk/DQoNClRo
YW5rcywNCi1Hb25nbGVpDQoNCj4gUGFvbG8NCj4gDQo+ID4gSSdtIG5vdCBzdXJlIGlmIHRoZXJl
IGFyZSBhbnkgb3RoZXIgaGlkZGVuIGlzc3VlcyBmb3IgZnV0dXJlIHNjYWxhYmlsaXR5LCBzdWNo
IGFzDQo+ID4gdXNpbmcgUWVtdSB0byBtYW5hZ2Ugc29tZSBjb250cm9sIG1lc3NhZ2VzLCBhdm9p
ZGluZyBELURvcyBhdHRhY2sgZXRjLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IC1Hb25nbGVpDQoN
Cg==

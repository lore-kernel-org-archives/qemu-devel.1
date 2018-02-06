Received: from eggs.gnu.org ([2001:4830:134:3::10]:54475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eizI7-0006Jr-Ru
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eizI2-0001Wh-T0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:11:51 -0500
Received: from [45.249.212.255] (port=52230 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eizI2-0001VS-I0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:11:46 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 6 Feb 2018 08:24:36 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA543B64@DGGEMA505-MBX.china.huawei.com>
References: <1517492876-28428-1-git-send-email-arei.gonglei@huawei.com>
	<d2f644da-e6c8-da3a-55e4-13ae69c44fc4@redhat.com>
	<CAFEAcA_6wg6aS_g0mGcNyjC57BVoU+pxdaRU3buM5J6b3XNW-Q@mail.gmail.com>
	<fa226f5f-77c4-7167-29c6-9baf08737239@redhat.com>
In-Reply-To: <fa226f5f-77c4-7167-29c6-9baf08737239@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] rtc: placing RTC memory region outside BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDA1LCAy
MDE4IDEwOjA0IFBNDQo+IFRvOiBQZXRlciBNYXlkZWxsDQo+IENjOiBHb25nbGVpIChBcmVpKTsg
UUVNVSBEZXZlbG9wZXJzOyBIdWFuZ3dlaWRvbmcgKEMpDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1k
ZXZlbF0gW1BBVENIXSBydGM6IHBsYWNpbmcgUlRDIG1lbW9yeSByZWdpb24gb3V0c2lkZSBCUUwN
Cj4gDQo+IE9uIDA0LzAyLzIwMTggMTk6MDIsIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+ID4gT24g
MSBGZWJydWFyeSAyMDE4IGF0IDE0OjIzLCBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPiB3cm90ZToNCj4gPj4gT24gMDEvMDIvMjAxOCAwODo0NywgR29uZ2xlaSB3cm90ZToNCj4g
Pj4+IGRpZmYgLS1naXQgYS9ody90aW1lci9tYzE0NjgxOHJ0Yy5jIGIvaHcvdGltZXIvbWMxNDY4
MThydGMuYw0KPiA+Pj4gaW5kZXggMzVhMDVhNi4uZDlkOTljNSAxMDA2NDQNCj4gPj4+IC0tLSBh
L2h3L3RpbWVyL21jMTQ2ODE4cnRjLmMNCj4gPj4+ICsrKyBiL2h3L3RpbWVyL21jMTQ2ODE4cnRj
LmMNCj4gPj4+IEBAIC05ODYsNiArOTg2LDcgQEAgc3RhdGljIHZvaWQgcnRjX3JlYWxpemVmbihE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPiAqKmVycnApDQo+ID4+PiAgICAgIHFlbXVfcmVnaXN0
ZXJfc3VzcGVuZF9ub3RpZmllcigmcy0+c3VzcGVuZF9ub3RpZmllcik7DQo+ID4+Pg0KPiA+Pj4g
ICAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPmlvLCBPQkpFQ1QocyksICZjbW9zX29wcywg
cywgInJ0YyIsIDIpOw0KPiA+Pj4gKyAgICBtZW1vcnlfcmVnaW9uX2NsZWFyX2dsb2JhbF9sb2Nr
aW5nKCZzLT5pbyk7DQo+ID4+PiAgICAgIGlzYV9yZWdpc3Rlcl9pb3BvcnQoaXNhZGV2LCAmcy0+
aW8sIGJhc2UpOw0KPiA+Pj4NCj4gPj4+ICAgICAgcWRldl9zZXRfbGVnYWN5X2luc3RhbmNlX2lk
KGRldiwgYmFzZSwgMyk7DQo+ID4+Pg0KPiA+Pg0KPiA+PiBUaGlzIGlzIG5vdCBlbm91Z2gsIHlv
dSBuZWVkIHRvIGFkZCBhIG5ldyBsb2NrIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ID4+IE90
aGVyd2lzZSB0d28gdkNQVXMgY2FuIGFjY2VzcyB0aGUgUlRDIHRvZ2V0aGVyIGFuZCBtYWtlIGEg
bWVzcy4NCj4gPg0KPiA+IERvIHlvdSBhbHNvIG5lZWQgdG8gZG8gc29tZXRoaW5nIHRvIHRha2Ug
dGhlIGdsb2JhbCBsb2NrIGJlZm9yZQ0KPiA+IHJhaXNpbmcgdGhlIG91dGJvdW5kIElSUSBsaW5l
IChzaW5jZSBpdCBtaWdodCBiZSBjb25uZWN0ZWQgdG8gYSBkZXZpY2UNCj4gPiB0aGF0IGRvZXMg
bmVlZCB0aGUgZ2xvYmFsIGxvY2spLCBvciBhbSBJIGNvbmZ1c2VkID8NCj4gDQo+IFllcywgdGhh
dCdzIGEgZ29vZCBwb2ludC4gIE1vc3Qgb2YgdGhlIHRpbWUgdGhlIElSUSBsaW5lIGlzIHJhaXNl
ZCBpbiBhDQo+IHRpbWVyLCBidXQgbm90IGFsd2F5cy4NCj4gDQpTbywgdGFraW5nIEJRTCBpcyBu
ZWNlc3NhcnksIGFuZCB3aGF0IHdlIGNhbiBkbyBpcyB0cnlpbmcgb3VyIGJlc3QgdG8gbmFycm93
DQpkb3duIHRoZSBwcm9jZXNzIG9mIGxvY2tpbmcgPyBGb3IgZXhhbXBsZSwgZG8gdGhlIGZvbGxv
d2luZyB3cmFwcGluZzoNCg0Kc3RhdGljIHZvaWQgcnRjX3Jhc2llX2lycShSVENTdGF0ZSAqcykN
CnsNCiAgICBxZW11X211dGV4X2xvY2tfaW90aHJlYWQoKTsNCiAgICBxZW11X2lycV9yYWlzZShz
LT5pcnEpOw0KICAgIHFlbXVfbXV0ZXhfdW5sb2NrX2lvdGhyZWFkKCk7DQp9DQoNCnN0YXRpYyB2
b2lkIHJ0Y19sb3dlcl9pcnEoUlRDU3RhdGUgKnMpDQp7DQogICAgcWVtdV9tdXRleF9sb2NrX2lv
dGhyZWFkKCk7DQogICAgcWVtdV9pcnFfbG93ZXIocy0+aXJxKTsNCiAgICBxZW11X211dGV4X3Vu
bG9ja19pb3RocmVhZCgpOw0KfQ0KDQpUaGFua3MsDQotR29uZ2xlaQ0K

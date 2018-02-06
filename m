Received: from eggs.gnu.org ([2001:4830:134:3::10]:58415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ej2wb-0002my-BC
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ej2wV-0003mv-Df
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:05:53 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2313 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ej2wV-0003ej-2W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:05:47 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 6 Feb 2018 13:05:33 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA543EF3@DGGEMA505-MBX.china.huawei.com>
References: <1517492876-28428-1-git-send-email-arei.gonglei@huawei.com>
	<d2f644da-e6c8-da3a-55e4-13ae69c44fc4@redhat.com>
	<CAFEAcA_6wg6aS_g0mGcNyjC57BVoU+pxdaRU3buM5J6b3XNW-Q@mail.gmail.com>
	<fa226f5f-77c4-7167-29c6-9baf08737239@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA543B64@DGGEMA505-MBX.china.huawei.com>
	<CAFEAcA_-j5baz-iy16TfzwcUgze1Fs9Fx=uKTkHJKuJ=hpjdqw@mail.gmail.com>
In-Reply-To: <CAFEAcA_-j5baz-iy16TfzwcUgze1Fs9Fx=uKTkHJKuJ=hpjdqw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldGVyIE1heWRlbGwgW21h
aWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmddDQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5
IDA2LCAyMDE4IDU6NDkgUE0NCj4gVG86IEdvbmdsZWkgKEFyZWkpDQo+IENjOiBQYW9sbyBCb256
aW5pOyBRRU1VIERldmVsb3BlcnM7IEh1YW5nd2VpZG9uZyAoQykNCj4gU3ViamVjdDogUmU6IFtR
ZW11LWRldmVsXSBbUEFUQ0hdIHJ0YzogcGxhY2luZyBSVEMgbWVtb3J5IHJlZ2lvbiBvdXRzaWRl
IEJRTA0KPiANCj4gT24gNiBGZWJydWFyeSAyMDE4IGF0IDA4OjI0LCBHb25nbGVpIChBcmVpKSA8
YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+IHdyb3RlOg0KPiA+IFNvLCB0YWtpbmcgQlFMIGlz
IG5lY2Vzc2FyeSwgYW5kIHdoYXQgd2UgY2FuIGRvIGlzIHRyeWluZyBvdXIgYmVzdCB0byBuYXJy
b3cNCj4gPiBkb3duIHRoZSBwcm9jZXNzIG9mIGxvY2tpbmcgPyBGb3IgZXhhbXBsZSwgZG8gdGhl
IGZvbGxvd2luZyB3cmFwcGluZzoNCj4gPg0KPiA+IHN0YXRpYyB2b2lkIHJ0Y19yYXNpZV9pcnEo
UlRDU3RhdGUgKnMpDQo+ID4gew0KPiA+ICAgICBxZW11X211dGV4X2xvY2tfaW90aHJlYWQoKTsN
Cj4gPiAgICAgcWVtdV9pcnFfcmFpc2Uocy0+aXJxKTsNCj4gPiAgICAgcWVtdV9tdXRleF91bmxv
Y2tfaW90aHJlYWQoKTsNCj4gPiB9DQo+ID4NCj4gPiBzdGF0aWMgdm9pZCBydGNfbG93ZXJfaXJx
KFJUQ1N0YXRlICpzKQ0KPiA+IHsNCj4gPiAgICAgcWVtdV9tdXRleF9sb2NrX2lvdGhyZWFkKCk7
DQo+ID4gICAgIHFlbXVfaXJxX2xvd2VyKHMtPmlycSk7DQo+ID4gICAgIHFlbXVfbXV0ZXhfdW5s
b2NrX2lvdGhyZWFkKCk7DQo+ID4gfQ0KPiANCj4gSWYgeW91IGRvIHRoYXQgeW91J2xsIGFsc28g
bmVlZCB0byBiZSBjYXJlZnVsIGFib3V0IG5vdCBjYWxsaW5nDQo+IHRob3NlIGZ1bmN0aW9ucyBm
cm9tIGNvbnRleHRzIHdoZXJlIHlvdSBhbHJlYWR5IGhvbGQgdGhlIGlvdGhyZWFkDQo+IG11dGV4
IChlZyB0aW1lciBjYWxsYmFja3MpLCBzaW5jZSB5b3UgY2FuJ3QgbG9jayBhIG11dGV4IHlvdQ0K
PiBhbHJlYWR5IGhhdmUgbG9ja2VkLg0KPiANCkV4YWN0bHksIGFsbCBjb250ZXh0cyBjYXVzZWQg
YnkgdGhlIG1haW4gcHJvY2Vzcy4gOikNClRocmVlIHRpbWVycyBjYWxsYmFja3MsIGNhbGxpbmcg
cnRjX3Jlc2V0KCkuDQoNClRoYW5rcywNCi1Hb25nbGVpDQo=

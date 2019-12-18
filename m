Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C614320665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C614320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXmL-0002sb-0Y
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tu.guoyi@h3c.com>) id 1ihXlQ-0002Hw-Vt
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tu.guoyi@h3c.com>) id 1ihXlP-0008B9-5n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:45:12 -0500
Received: from smtp.h3c.com ([60.191.123.56]:50549 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tu.guoyi@h3c.com>)
 id 1ihXlO-0007Xb-GY; Wed, 18 Dec 2019 06:45:11 -0500
Received: from DAG2EX09-IDC.srv.huawei-3com.com ([10.8.0.72])
 by h3cspam01-ex.h3c.com with ESMTPS id xBIBippc091842
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2019 19:44:51 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX09-IDC.srv.huawei-3com.com (10.8.0.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Dec 2019 19:44:55 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%6])
 with mapi id 15.01.1713.004; Wed, 18 Dec 2019 19:44:55 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: RE: [PATCH] qcow2: Move error check of local_err near its assignment
Thread-Topic: [PATCH] qcow2: Move error check of local_err near its assignment
Thread-Index: AdW1Sk9pyaSaCMAlRUyLwKs8KWho0v//8YEA//9WupA=
Date: Wed, 18 Dec 2019 11:44:54 +0000
Message-ID: <90dcd4f2e815479e839913672e14da57@h3c.com>
References: <c9d3fc7246ec4c1f9a6cde9ed3c3ae57@h3c.com>
 <20191218093252.GB4632@linux.fritz.box>
In-Reply-To: <20191218093252.GB4632@linux.fritz.box>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.112]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com xBIBippc091842
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 60.191.123.56
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
Cc: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTguMTIuMjAxOSAxNzozMyBLZXZpbiBXb2xmIHdyb3RlOg0KPiANCj4gQW0gMTguMTIuMjAx
OSB1bSAwMzoyNiBoYXQgVHVndW95aSBnZXNjaHJpZWJlbjoNCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEd1b3lpIFR1IDx0dS5ndW95aUBoM2MuY29tPg0KPiANCj4gRW1wdHkgY29tbWl0IG1lc3Nh
Z2VzIGFyZSByYXJlbHkgYWNjZXB0YWJsZS4gWW91IHNob3VsZCBleHBsYWluIGhlcmUgd2h5DQo+
IHlvdSBhcmUgbWFraW5nIHRoZSBjaGFuZ2UgYW5kIHdoeSBpdCdzIGNvcnJlY3QgKGZvciBleGFt
cGxlIGJ5IGNvbXBhcmluZw0KPiB3aXRoIHdoZW4gaXQgd2FzIGludHJvZHVjZWQpLg0KPiANCj4g
SW4gdGhpcyBjYXNlLCB0aGUgbG9jYWxfZXJyIGNoZWNrIG91dHNpZGUgb2YgdGhlIGlmIGJsb2Nr
IHdhcyBuZWNlc3Nhcnkgd2hlbiBpdA0KPiB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQgZDEyNThk
ZDBjODcgYmVjYXVzZSBpdCBuZWVkZWQgdG8gYmUgZXhlY3V0ZWQNCj4gZXZlbiBpZiBxY293Ml9s
b2FkX2F1dG9sb2FkaW5nX2RpcnR5X2JpdG1hcHMoKSByZXR1cm5lZCBmYWxzZS4NCj4gDQo+IEFm
dGVyIHNvbWUgbW9kaWZpY2F0aW9ucyB0aGF0IGFsbCByZXF1aXJlZCB0aGUgZXJyb3IgY2hlY2sg
dG8gcmVtYWluIHdoZXJlIGl0DQo+IGlzLCBjb21taXQgOWM5OGYxNDVkZmIgZmluYWxseSBtb3Zl
ZCB0aGUNCj4gcWNvdzJfbG9hZF9kaXJ0eV9iaXRtYXBzKCkgY2FsbCBpbnRvIHRoZSBpZiBibG9j
aywgc28gbm93IHRoZSBlcnJvciBjaGVjaw0KPiBzaG91bGQgYmUgdGhlcmUsIHRvby4NCj4gDQo+
IFRoaXMgaXMgaW5mb3JtYXRpb24gdGhhdCBzaG91bGQgYmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
IHJhdGhlciB0aGFuDQo+IHJlcXVpcmluZyBlYWNoIHJlYWRlciB0byBkbyB0aGUgcmVzZWFyY2gu
DQo+IA0KPiBQbGVhc2UgYWxzbyBtYWtlIHN1cmUgdG8gQ0MgdGhlIGF1dGhvciBvZiB0aGUgY29k
ZSB0aGF0IHlvdSdyZSBtb2RpZnlpbmcsIGluDQo+IHRoaXMgY2FzZSBWbGFkaW1pci4NCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL2Jsb2NrL3Fjb3cyLmMgYi9ibG9jay9xY293Mi5jIGluZGV4IDdjMTg3
MjEuLmNlM2RiMjkNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9ibG9jay9xY293Mi5jDQo+ID4gKysr
IGIvYmxvY2svcWNvdzIuYw0KPiA+IEBAIC0xNzA1LDE0ICsxNzA1LDE0IEBAIHN0YXRpYyBpbnQg
Y29yb3V0aW5lX2ZuDQo+IHFjb3cyX2RvX29wZW4oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0
ICpvcHRpb25zLA0KPiA+ICAgICAgaWYgKCEoYmRydl9nZXRfZmxhZ3MoYnMpICYgQkRSVl9PX0lO
QUNUSVZFKSkgew0KPiA+ICAgICAgICAgIC8qIEl0J3MgY2FzZSAxLCAyIG9yIDMuMi4gT3IgMy4x
IHdoaWNoIGlzIEJVRyBpbiBtYW5hZ2VtZW50IGxheWVyLg0KPiAqLw0KPiA+ICAgICAgICAgIGJv
b2wgaGVhZGVyX3VwZGF0ZWQgPSBxY293Ml9sb2FkX2RpcnR5X2JpdG1hcHMoYnMsDQo+ID4gJmxv
Y2FsX2Vycik7DQo+ID4gKyAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+ID4gKyAg
ICAgICAgICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpOw0KPiA+ICsgICAgICAg
ICAgICByZXQgPSAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICBnb3RvIGZhaWw7DQo+ID4gKyAg
ICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgdXBkYXRlX2hlYWRlciA9IHVwZGF0ZV9oZWFkZXIg
JiYgIWhlYWRlcl91cGRhdGVkOw0KPiA+ICAgICAgfQ0KPiA+IC0gICAgaWYgKGxvY2FsX2VyciAh
PSBOVUxMKSB7DQo+ID4gLSAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7
DQo+ID4gLSAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4gPiAtICAgICAgICBnb3RvIGZhaWw7DQo+
ID4gLSAgICB9DQo+ID4NCj4gPiAgICAgIGlmICh1cGRhdGVfaGVhZGVyKSB7DQo+ID4gICAgICAg
ICAgcmV0ID0gcWNvdzJfdXBkYXRlX2hlYWRlcihicyk7DQo+IA0KPiBUaGUgY2hhbmdlIGl0c2Vs
ZiBsb29rcyBnb29kIHRvIG1lLCBidXQgSSdsbCBsZXQgVmxhZGltaXIgaGF2ZSBhIGxvb2sgYXMg
d2VsbC4gSWYNCj4gdGhlcmUgYXJlIG5vIG1vcmUgY29tbWVudHMsIEknbSBsb29raW5nIGZvcndh
cmQgdG8gYSB2MiBwYXRjaCB3aXRoIGENCj4gbm9uLWVtcHR5IGNvbW1pdCBtZXNzYWdlLg0KPiAN
Cj4gS2V2aW4NCg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQsIEkgd2lsbCBzZW5kIHRoZSB2
MiBwYXRjaA0KDQotLQ0KQmVzdCByZWdhcmRzLA0KR3VveWkNCg==


Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB426C2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 09:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7F82083E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 09:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7F82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMT68-0007na-NZ
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 05:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jMT5H-00075w-LW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 05:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jMT5F-0003yc-M0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 05:02:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:26638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jMT5F-0003xc-Dl
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 05:02:49 -0400
IronPort-SDR: YgdhGgm+s/yXmSsBHsrCrLOW8Yqe5LlDEm0saaqG5r59uMi1i5ZcFwWRV7pGtzVeOpwuUqmfmN
 JBzlsHkn22bA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 02:02:45 -0700
IronPort-SDR: Ng+acyH8ooED1UOVOfv0pf5eMgVoPJ1HpUkqj50yV+cUWAL28Cwjj4T37FlBxypv2yp2Ye2faA
 46+OK4sbs8tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,362,1580803200"; d="scan'208";a="425442825"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga005.jf.intel.com with ESMTP; 09 Apr 2020 02:02:45 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Apr 2020 02:02:45 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Apr 2020 17:02:42 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 9 Apr 2020 17:02:42 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Derek Su <jwsu1986@gmail.com>
Subject: RE: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Thread-Topic: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Thread-Index: AQHWBP8jbziCKwk6wUatrdITk0cinKhvJO0AgAFH8mD//38BAIAApPCw
Date: Thu, 9 Apr 2020 09:02:42 +0000
Message-ID: <c750109305194fa28a2391d92dc314ee@intel.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-3-dereksu@qnap.com> <20200408211842.2c0f1e4a@luklap>
 <3f0534dbaa744ee4bff9f11615a3b964@intel.com>
 <CAFKS8hV_FKUj2Dg76UwP49JcmnoDgAQcBVCNdj2SizMfckYxVw@mail.gmail.com>
In-Reply-To: <CAFKS8hV_FKUj2Dg76UwP49JcmnoDgAQcBVCNdj2SizMfckYxVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Lukas Straub <lukasstraub2@web.de>,
 "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 "chyang@qnap.com" <chyang@qnap.com>, Derek Su <dereksu@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGVyZWsgU3UgPGp3c3Ux
OTg2QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDksIDIwMjAgMzoxMSBQTQ0K
PiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiBDYzogTHVrYXMgU3Ry
YXViIDxsdWthc3N0cmF1YjJAd2ViLmRlPjsgRGVyZWsgU3UgPGRlcmVrc3VAcW5hcC5jb20+Ow0K
PiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGxpemhpamlhbkBjbi5mdWppdHN1LmNvbTsgY2h5YW5n
QHFuYXAuY29tOw0KPiBqYXNvd2FuZ0ByZWRoYXQuY29tOyBjdGNoZW5nQHFuYXAuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBuZXQvY29sby1jb21wYXJlLmM6IGhhbmRsaW5nIG9m
IHRoZSBmdWxsIHByaW1hcnkNCj4gb3Igc2Vjb25kYXJ5IHF1ZXVlDQo+IA0KPiBIZWxsbywgWmhh
bmcgYW5kIEx1a2FzDQo+IA0KPiBTdXJlLCBhZnRlciBteSByZS10ZXN0LCB0aGUgcGVyZm9ybWFu
Y2UgaXMgaHVydC4gV2lsbCB1cGRhdGUgaXQgbGF0ZXIuDQo+IA0KPiBCeSB0aGUgd2F5LCBjb3Vs
ZCBJIGFsc28gbW92ZSB0aGUgImVycm9yX3JlcG9ydCgiY29sbyBjb21wYXJlDQo+IHByaW1hcnkv
c2Vjb25kYXJ5IHF1ZXVlIHNpemUgdG9vIGJpZywgZHJvcCBwYWNrZXQiKTsiIHRvIHRyYWNlPw0K
DQpZZXMuDQoNCj4gVGhlIHVzZSBvZiBlcnJvcl9yZXBvcnQgaXMgYSBsaXR0bGUgc3RyYW5nZSBh
bmQgbWFrZSBhIGZsb29kIGluIGxvZy4NCj4gDQo+IE1heSBJICBhbHNvIG1ha2UgIk1BWF9RVUVV
RV9TSVpFIiAgYmUgdXNlci1jb25maWd1cmFibGUgaW4gdGhpcyBzZXJpZXM/DQoNCkkgaGF2ZSB0
aGlzIHBhdGNoIGludGVybmFsIGFuZCB3aWxsIHNlbmQgaXQgbGF0ZXIuDQoNClRoYW5rcw0KWmhh
bmcgQ2hlbg0KDQo+IA0KPiBUaGFua3MsDQo+IERlcmVrIFN1DQo+IA0KPiANCj4gDQo+IA0KPiBa
aGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+IOaWvCAyMDIw5bm0NOaciDnml6Ug6YCx
5ZubIOS4i+WNiDI6NTkNCj4g5a+r6YGT77yaDQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTHVrYXMgU3RyYXViIDxsdWthc3N0cmF1
YjJAd2ViLmRlPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEFwcmlsIDksIDIwMjAgMzoxOSBBTQ0K
PiA+ID4gVG86IERlcmVrIFN1IDxkZXJla3N1QHFuYXAuY29tPg0KPiA+ID4gQ2M6IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsgbGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tOw0KPiA+ID4gY2h5YW5nQHFu
YXAuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBjdGNoZW5nQHFuYXAuY29tOyBaaGFuZywNCj4g
Q2hlbg0KPiA+ID4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgandzdTE5ODZAZ21haWwuY29tDQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gbmV0L2NvbG8tY29tcGFyZS5jOiBoYW5k
bGluZyBvZiB0aGUgZnVsbA0KPiA+ID4gcHJpbWFyeSBvciBzZWNvbmRhcnkgcXVldWUNCj4gPiA+
DQo+ID4gPiBPbiBTYXQsIDI4IE1hciAyMDIwIDIwOjQ2OjQ2ICswODAwDQo+ID4gPiBEZXJlayBT
dSA8ZGVyZWtzdUBxbmFwLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBUaGUgcGVydmlvdXMg
aGFuZGxpbmcgb2YgdGhlIGZ1bGwgcHJpbWFyeSBvciBxdWV1ZSBpcyBvbmx5DQo+ID4gPiA+IGRy
b3BwaW5nIHRoZSBwYWNrZXQuIElmIHRoZXJlIGFyZSBsb3RzIG9mIGNsaWVudHMgdG8gdGhlIGd1
ZXN0IFZNLCB0aGUNCj4gImRyb3AiDQo+ID4gPiA+IHdpbGwgbGVhZCB0byB0aGUgbG9zdCBvZiB0
aGUgbmV0d29ya2luZyBjb25uZWN0aW9uIHVudGlsIG5leHQNCj4gPiA+ID4gY2hlY2twb2ludC4N
Cj4gPiA+ID4NCj4gPiA+ID4gVG8gYWRkcmVzcyB0aGUgaXNzdWUsIHRoaXMgcGF0Y2ggZHJvcHMg
dGhlIHBhY2tldCBmaXJzdGx5Lg0KPiA+ID4gPiBUaGVuLCBkbyBjaGVja3BvaW50IGFuZCBmbHVz
aCBwYWNrZXRzLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEZXJlayBTdSA8ZGVy
ZWtzdUBxbmFwLmNvbT4NCj4gPiA+DQo+ID4gPiBIZWxsbywNCj4gPiA+IEkgaGFkIGEgbG9vayBh
dCB0aGlzIGFnYWluIGFuZCBkaWQgc29tZSBiZW5jaG1hcmtpbmcuDQo+ID4gPiBGaXJzdCBqdXN0
IHFlbXUgNS4wLXJjMSB3aXRoIG15IGJ1Z2ZpeGVzICgNCj4gPiA+IGh0dHBzOi8vbGlzdHMubm9u
Z251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIwLQ0KPiA+ID4gMDQvbXNnMDE0MzIu
aHRtbCApIFRoZW4gcWVtdSA1LjAtcmMxIHdpdGggbXkgYnVnZml4ZXMgYW5kIHRoaXMgcGF0Y2gN
Cj4gPiA+IHNlcmllcy4NCj4gPiA+DQo+ID4gPiBUaGlzIGNvbW1pdCBodXJ0cyBwZXJmb3JtYW5j
ZSB0b28gbXVjaDoNCj4gPiA+IENsaWVudC10by1zZXJ2ZXIgYmFuZHdpZHRoIGZhbGxzIGZyb20g
fjQ1LjkgTWJpdC9zIHRvIDIyLjkgTWJpdC9zLg0KPiA+ID4gU2VydmVyLXRvLWNsaWVudCBiYW5k
d2lkdGggZmFsbHMgZnJvbSB+Ni4zIE1iaXQvcyB0byBqdXN0IH42NzQgS2JpdC9zLg0KPiA+ID4g
QXZlcmFnZSBsYXRlbmN5IHJpc2VzIGZyb20gfjE5N21zIHRvIH4zOTdtcy4NCj4gPiA+DQo+ID4g
PiBNZWFud2hpbGUgdGhlIHBhY2tldCBsb3NzIHdpdGhvdXQgdGhpcyBjb21taXQgaXMgbmVnbGln
aWJsZSwgb25seQ0KPiA+ID4gMS0yIHBpbmcgcGFja2V0cyBnb3QgbG9zdCBkdXJpbmcgZWFjaCB0
ZXN0IHJ1bi4NCj4gPiA+DQo+ID4gPiBJbnN0ZWFkIEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgdHVy
biB0aGUgZXJyb3IgbWVzc2FnZSBpbnRvIGEgdHJhY2UNCj4gPiA+IHNvIGl0IGRvZXNuJ3QgZmxv
b2QgdGhlIGxvZ3MuDQo+ID4NCj4gPiBXZSByZS10ZXN0IHRoaXMgcGF0Y2gsIEx1a2FzIGlzIHJp
Z2h0Lg0KPiA+IFNvcnJ5IGZvciB0aGUgb3JpZ2luYWwgaWRlYSwgbG9va3MgbGlrZSBpdCBkaWQg
bm90IHNob3cgYmV0dGVyIHBlcmZvcm1hbmNlIGluDQo+IHRoZSB0ZXN0Lg0KPiA+IEFncmVlIHdp
dGggTHVrYXMncyBjb21tZW50cy4gRGVyZWssIGNhbiB5b3UgcGxlYXNlIGNoYW5nZSBpdD8NCj4g
Pg0KPiA+IFRoYW5rcw0KPiA+IFpoYW5nIENoZW4NCj4gPg0KPiA+DQo+ID4gPg0KPiA+ID4gUmVn
YXJkcywNCj4gPiA+IEx1a2FzIFN0cmF1Yg0K


Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA02C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB122072C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 07:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB122072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3xCM-0003WU-Dy
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 02:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j3xBc-0002cg-W1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j3xBb-0006g6-IR
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:20:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:42053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1j3xBb-0006fc-Ap
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 02:20:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Feb 2020 23:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; d="scan'208";a="258475445"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga004.fm.intel.com with ESMTP; 17 Feb 2020 23:20:48 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 17 Feb 2020 23:20:46 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.95]) with mapi id 14.03.0439.000;
 Mon, 17 Feb 2020 23:20:45 -0800
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: docs: Update vhost-user spec regarding backend program conventions
Thread-Topic: docs: Update vhost-user spec regarding backend program
 conventions
Thread-Index: AQHV4O9TY4yCVz7xVU+TIDtOwGOnlKgXB3uAgAQw4QCAAAoiAIAABcMAgAXT2IA=
Date: Tue, 18 Feb 2020 07:20:44 +0000
Message-ID: <0ef9d09b2bea4399f20b8d283b46467dcfeedac8.camel@intel.com>
References: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
 <CAMxuvazRMzO=7N3FjH74QBk1ehxwaM8rymFcn5_aDppU8_z+LA@mail.gmail.com>
 <98d72096ad005ecfd5861e4f8f74a9c503e976b2.camel@intel.com>
 <CAMxuvaztAsaXeGeuMp=mhq3BC7cRLbQh+6d9a2RuZ59DU9U5_g@mail.gmail.com>
 <20200214142112.GD613610@redhat.com>
In-Reply-To: <20200214142112.GD613610@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.25.223]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB68BB435A00AB41B29240EB26626BB3@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDIwLTAyLTE0IGF0IDE0OjIxICswMDAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdy
b3RlOg0KPiBPbiBGcmksIEZlYiAxNCwgMjAyMCBhdCAwMzowMDozNFBNICswMTAwLCBNYXJjLUFu
ZHLDqSBMdXJlYXUgd3JvdGU6DQo+ID4gSGkNCj4gPiANCj4gPiBPbiBGcmksIEZlYiAxNCwgMjAy
MCBhdCAyOjI0IFBNIEJvZXVmLCBTZWJhc3RpZW4NCj4gPiA8c2ViYXN0aWVuLmJvZXVmQGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gPiBIaSBNYXJjLUFuZHJlLA0KPiA+ID4gDQo+ID4gPiBPbiBUdWUs
IDIwMjAtMDItMTEgYXQgMjI6MjQgKzAxMDAsIE1hcmMtQW5kcsOpIEx1cmVhdSB3cm90ZToNCj4g
PiA+ID4gSGkNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgRmViIDExLCAyMDIwIGF0IDQ6MjQg
UE0gQm9ldWYsIFNlYmFzdGllbg0KPiA+ID4gPiA8c2ViYXN0aWVuLmJvZXVmQGludGVsLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4gRnJvbSBjMDczZDUyOGI4Y2Q3MDgyODMyZmQxODI1ZGMzM2RkNjVi
MzA1YWEyIE1vbiBTZXAgMTcNCj4gPiA+ID4gPiAwMDowMDowMA0KPiA+ID4gPiA+IDIwMDENCj4g
PiA+ID4gPiBGcm9tOiBTZWJhc3RpZW4gQm9ldWYgPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+
DQo+ID4gPiA+ID4gRGF0ZTogVHVlLCAxMSBGZWIgMjAyMCAxNjowMToyMiArMDEwMA0KPiA+ID4g
PiA+IFN1YmplY3Q6IFtQQVRDSF0gZG9jczogVXBkYXRlIHZob3N0LXVzZXIgc3BlYyByZWdhcmRp
bmcNCj4gPiA+ID4gPiBiYWNrZW5kDQo+ID4gPiA+ID4gcHJvZ3JhbQ0KPiA+ID4gPiA+ICBjb252
ZW50aW9ucw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSB2aG9zdC11c2VyIHNwZWNpZmljYXRp
b24gaXMgbm90IGNsZWFybHkgc3RhdGluZyB0aGUNCj4gPiA+ID4gPiBleHBlY3RlZA0KPiA+ID4g
PiA+IGJlaGF2aW9yIGZyb20gYSBiYWNrZW5kIHByb2dyYW0gd2hlbmV2ZXIgdGhlIGNsaWVudA0K
PiA+ID4gPiA+IGRpc2Nvbm5lY3RzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgcGF0Y2gg
YWRkcmVzc2VzIHRoZSBpc3N1ZSBieSBkZWZpbmluZyB0aGUgZGVmYXVsdA0KPiA+ID4gPiA+IGJl
aGF2aW9yIGFuZA0KPiA+ID4gPiA+IHByb3Bvc2luZyBhbiBhbHRlcm5hdGl2ZSB0aHJvdWdoIGEg
Y29tbWFuZCBsaW5lIG9wdGlvbi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCeSBkZWZhdWx0LCBh
IGJhY2tlbmQgcHJvZ3JhbSB3aWxsIGhhdmUgdG8ga2VlcCBsaXN0ZW5pbmcNCj4gPiA+ID4gPiBl
dmVuIGlmDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gY2xpZW50IGRpc2Nvbm5lY3RzLCB1bmxl
c3MgdG9sZCBvdGhlcndpc2UgdGhyb3VnaCB0aGUgbmV3bHkNCj4gPiA+ID4gPiBpbnRyb2R1Y2Vk
DQo+ID4gPiA+ID4gb3B0aW9uIC0tZXhpdC1vbi1kaXNjb25uZWN0Lg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNlYmFzdGllbiBCb2V1ZiA8c2ViYXN0aWVuLmJvZXVmQGlu
dGVsLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRvY3MvaW50ZXJvcC92
aG9zdC11c2VyLnJzdCB8IDEwICsrKysrKysrKysNCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZG9j
cy9pbnRlcm9wL3Zob3N0LXVzZXIucnN0DQo+ID4gPiA+ID4gYi9kb2NzL2ludGVyb3Avdmhvc3Qt
DQo+ID4gPiA+ID4gdXNlci5yc3QNCj4gPiA+ID4gPiBpbmRleCA1ZjhiM2E0NTZiLi5kYTlhMWVi
YzRjIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RvY3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdA0K
PiA+ID4gPiA+ICsrKyBiL2RvY3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdA0KPiA+ID4gPiA+IEBA
IC0xMzIzLDYgKzEzMjMsMTAgQEAgVGhlIGJhY2tlbmQgcHJvZ3JhbSBtdXN0IGVuZCAoYXMNCj4g
PiA+ID4gPiBxdWlja2x5IGFuZA0KPiA+ID4gPiA+IGNsZWFubHkgYXMgcG9zc2libGUpIHdoZW4N
Cj4gPiA+ID4gPiAgdGhlIFNJR1RFUk0gc2lnbmFsIGlzIHJlY2VpdmVkLiBFdmVudHVhbGx5LCBp
dCBtYXkgcmVjZWl2ZQ0KPiA+ID4gPiA+IFNJR0tJTEwNCj4gPiA+ID4gPiBieQ0KPiA+ID4gPiA+
ICB0aGUgbWFuYWdlbWVudCBsYXllciBhZnRlciBhIGZldyBzZWNvbmRzLg0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ICtCeSBkZWZhdWx0LCB0aGUgYmFja2VuZCBwcm9ncmFtIGNvbnRpbnVlcyBydW5u
aW5nIGFmdGVyIHRoZQ0KPiA+ID4gPiA+IGNsaWVudA0KPiA+ID4gPiA+ICtkaXNjb25uZWN0cy4g
SXQgYWNjZXB0cyBvbmx5IDEgY29ubmVjdGlvbiBhdCBhIHRpbWUgb24gZWFjaA0KPiA+ID4gPiA+
IFVOSVgNCj4gPiA+ID4gPiBkb21haW4NCj4gPiA+ID4gPiArc29ja2V0Lg0KPiA+ID4gPiANCj4g
PiA+ID4gSSBkb24ndCB0aGluayB0aGF0J3MgdGhlIG1vc3QgY29tbW9uIGJlaGF2aW91ci4gbGli
dmhvc3QtdXNlcg0KPiA+ID4gPiB3aWxsDQo+ID4gPiA+IHBhbmljKCkgb24gZGlzY29ubmVjdCBp
biBnZW5lcmFsLCB1bmxlc3MgdGhlIGVycm9yL2V4aXQgaXMNCj4gPiA+ID4gaGFuZGxlZA0KPiA+
ID4gPiBncmFjZWZ1bGx5IGJ5IHRoZSBiYWNrZW5kLg0KPiA+ID4gDQo+ID4gPiBJdCdzIG5vdCB0
aGUgZGVmYXVsdCBiZWhhdmlvciBmcm9tIGxpYnZob3N0LXVzZXIsIGJ1dCB0aGF0J3MNCj4gPiA+
IGV4YWN0bHkNCj4gPiA+IHNvbWV0aGluZyBJJ2QgbGlrZSB0byBzZWUgY2hhbmdpbmcuIFRoaXMg
c2hvdWxkIGJlIHRoZSBub3JtYWwNCj4gPiA+IGNhc2UgaWYNCj4gPiA+IHlvdSB0aGluayBhYm91
dCBhIHN0YW5kYXJkIGNsaWVudC9zZXJ2ZXIgY29ubmVjdGlvbiwgd2hlcmUgdGhlDQo+ID4gPiBz
ZXJ2ZXINCj4gPiA+IHdvdWxkIHNpbXBseSBsaXN0ZW4gYWdhaW4gYWZ0ZXIgdGhlIGNsaWVudCBk
aXNjb25uZWN0cy4NCj4gPiANCj4gPiBJIGRpc2FncmVlLCBhICJub3JtYWwiIGxpZmVjeWNsZSBp
cyBhIHNpbmdsZSBjb25uZWN0aW9uICYgaW5zdGFuY2UNCj4gPiBwZXIgZGV2aWNlLg0KPiA+IA0K
PiA+IEhhdmluZyB0aGUgYmFja2VuZCBoYW5kbGUgbXVsdGlwbGUgY29ubmVjdGlvbnMgaXMgbmVl
ZGxlc3NseSBtb3JlDQo+ID4gY29tcGxpY2F0ZWQuIFlvdSBuZWVkIHRvIGNvcnJlY3RseSBoYW5k
bGUgbXVsdGlwbGUgc3RhdGVzLCBmbHVzaGVkDQo+ID4gYW55dGhpbmcgcHJpdmF0ZSBiZXR3ZWVu
IGNvbm5lY3Rpb25zIGV0Yy4gSXQgc2hvdWxkIGJlIG9wdGlvbmFsLg0KPiA+IA0KPiA+IA0KPiA+
ID4gPiBUaGUgbW9zdCBjb21tb24gY2FzZSBpcyB0byBoYXZlIDEtMSByZWxhdGlvbiBiZXR3ZWVu
DQo+ID4gPiA+IGRldmljZS9xZW11DQo+ID4gPiA+IGluc3RhbmNlIGFuZCBiYWNrZW5kLg0KPiA+
ID4gDQo+ID4gPiBZZXMgdGhpcyBwYXJ0IGlzIGZpbmUsIGJ1dCB0aGF0J3Mgbm90IGEgcmVhc29u
IHdoeSB0aGUgYmFja2VuZA0KPiA+ID4gc2hvdWxkDQo+ID4gPiB0ZXJtaW5hdGVzLg0KPiA+IA0K
PiA+IEl0IGlzIHNpbXBsZXIgdG8gZW5zdXJlIGl0IGlzIHJlc2V0IGNvcnJlY3RseS4NCj4gPiAN
Cj4gPiA+ID4gV2h5IG5vdCByZXN0YXJ0IHRoZSBiYWNrZW5kIGZvciBhbm90aGVyIGluc3RhbmNl
Pw0KPiA+ID4gDQo+ID4gPiBCZWNhdXNlIHlvdSBuZWVkIHNvbWUgbWFuYWdlbWVudCB0b29sIHRv
IGRvIHNvLiBBbmQgSSB0aGluayB0aGF0DQo+ID4gPiBieQ0KPiA+ID4gZGVmYXVsdCBpdCBjb3Vs
ZCBiZSBpbnRlcmVzdGluZyB0byBoYXZlIHRoZSBsZWFzdCBhbW91bnQgb2YgZXh0cmENCj4gPiA+
IG1hbmFnZW1lbnQgaW52b2x2ZWQuDQo+ID4gDQo+ID4gVGhlIG1hbmFnZW1lbnQgbGF5ZXIgc2hv
dWxkIGJlIGludm9sdmVkIGlmIGFueSBzaWRlIGNyYXNoZXMgb3INCj4gPiByZXN0YXJ0IGFueXdh
eS4NCj4gDQo+IEZ1cnRoZXIsIHRoaXMgdmhvc3QtdXNlci5yc3Qgc3BlYyBkb2N1bWVudCBpcyBl
eHBsaWNpdGx5IGRlc2NyaWJpbmcNCj4gdGhlIGNvbnRyYWN0IGJldHdlZW4gdGhlIHZob3N0LXVz
ZXIgYmluYXJpZXMgYW5kIHRoZSBtYW5hZ2VtZW50DQo+IGxheWVyLiBTbyBpdCBkb2Vzbid0IG1h
a2Ugc2Vuc2UgdG8gc2F5IHVwZGF0ZSB0aGlzIGRvYyB0byBkZXNjcmliZQ0KPiBkZXNpcmVkIHNl
bWFudGljcyBmb3IgdXNhZ2UgL3dpdGhvdXQvIGEgbWFuYWdlbWVudCBsYXllci4NCg0KSXMgaXQ/
IFdoYXQgSSBjYWxsIG1hbmFnZW1lbnQgbGF5ZXIgaXMgc29tZXRoaW5nIGxpa2UgS2F0YSBDb250
YWluZXJzLA0Kc3Bhd25pbmcgYm90aCB0aGUgYmFja2VuZCBhbmQgdGhlIFZNTS4gSU1PLCB0aGUg
ZG9jdW1lbnQgaXMgbW9yZSBhYm91dA0KZGVzY3JpYmluZyB0aGUgcHJvdG9jb2wgYW5kIGhvdyB0
aGUgY29tbXVuaWNhdGlvbiBpcyBoYW5kbGVkIGJldHdlZW4NCnRoZSBiYWNrZW5kIGFuZCB0aGUg
Vk1NLg0KDQo+IA0KPiBTbyBJIGFncmVlLCB0aGUgZGVmYXVsdCBiZWhhdmlvdXIgc2hvdWxkIGJl
IHRoYXQgdGhlcmUgaXMgb25lIGJpbmFyeQ0KPiBzcGF3bmVkIGF0IHRpbWUgdGhlIGFzc29jaWF0
ZWQgZGV2aWNlIGlzIGluaXRpYWxpemF0aW9uLCBhbmQgdGhhdA0KPiB0aGUgbGlmZXRpbWUgb2Yg
dGhlIGJpbmFyeSBpcyAxOjEgYXNzb2NpYXRlZCB3aXRoIHRoZSBsaWZldGltZSBvZg0KPiB0aGUg
Vk0sIG9yIHVudGlsIHRoZSBkZXZpY2UgaXMgdW5wbHVnZ2VkLiANCg0KSWYgeW91IGFsbCBhZ3Jl
ZSBvbiB0aGlzLCB0aGVuIGF0IGxlYXN0IHdlIHNob3VsZCBtYWtlIHRoaXMgY2xlYXIgaW4NCnRo
ZSBkb2N1bWVudC4gSSdsbCB1cGRhdGUgdGhlIHBhdGNoLg0KDQpUaGFua3MsDQpTZWJhc3RpZW4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gRGFuaWVsDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50ZWwgQ29ycG9yYXRp
b24gU0FTIChGcmVuY2ggc2ltcGxpZmllZCBqb2ludCBzdG9jayBjb21wYW55KQpSZWdpc3RlcmVk
IGhlYWRxdWFydGVyczogIkxlcyBNb250YWxldHMiLSAyLCBydWUgZGUgUGFyaXMsIAo5MjE5NiBN
ZXVkb24gQ2VkZXgsIEZyYW5jZQpSZWdpc3RyYXRpb24gTnVtYmVyOiAgMzAyIDQ1NiAxOTkgUi5D
LlMuIE5BTlRFUlJFCkNhcGl0YWw6IDQsNTcyLDAwMCBFdXJvcwoKVGhpcyBlLW1haWwgYW5kIGFu
eSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9yCnRoZSBz
b2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBBbnkgcmV2aWV3IG9yIGRpc3Ry
aWJ1dGlvbgpieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkCnJlY2lwaWVudCwgcGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVs
ZXRlIGFsbCBjb3BpZXMuCg==



Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA4DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D1024649
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D1024649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2b06-0008JR-28
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j2axJ-0005GY-4s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1j2axG-00074o-UG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:24:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:60120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1j2axG-0006ox-Lb
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:24:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 05:24:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; d="scan'208";a="223016036"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga007.jf.intel.com with ESMTP; 14 Feb 2020 05:24:20 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 05:24:20 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.167]) with mapi id 14.03.0439.000;
 Fri, 14 Feb 2020 05:24:20 -0800
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Subject: Re: docs: Update vhost-user spec regarding backend program conventions
Thread-Topic: docs: Update vhost-user spec regarding backend program
 conventions
Thread-Index: AQHV4O9TY4yCVz7xVU+TIDtOwGOnlKgXB3uAgAQw4QA=
Date: Fri, 14 Feb 2020 13:24:19 +0000
Message-ID: <98d72096ad005ecfd5861e4f8f74a9c503e976b2.camel@intel.com>
References: <15a5fbc76266fb51b365e66872c105b9e2832999.camel@intel.com>
 <CAMxuvazRMzO=7N3FjH74QBk1ehxwaM8rymFcn5_aDppU8_z+LA@mail.gmail.com>
In-Reply-To: <CAMxuvazRMzO=7N3FjH74QBk1ehxwaM8rymFcn5_aDppU8_z+LA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.24.179]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F10114D1E872744B8926BCA22BF9A93@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgTWFyYy1BbmRyZSwNCg0KT24gVHVlLCAyMDIwLTAyLTExIGF0IDIyOjI0ICswMTAwLCBNYXJj
LUFuZHLDqSBMdXJlYXUgd3JvdGU6DQo+IEhpDQo+IA0KPiBPbiBUdWUsIEZlYiAxMSwgMjAyMCBh
dCA0OjI0IFBNIEJvZXVmLCBTZWJhc3RpZW4NCj4gPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+
IHdyb3RlOg0KPiA+IEZyb20gYzA3M2Q1MjhiOGNkNzA4MjgzMmZkMTgyNWRjMzNkZDY1YjMwNWFh
MiBNb24gU2VwIDE3IDAwOjAwOjAwDQo+ID4gMjAwMQ0KPiA+IEZyb206IFNlYmFzdGllbiBCb2V1
ZiA8c2ViYXN0aWVuLmJvZXVmQGludGVsLmNvbT4NCj4gPiBEYXRlOiBUdWUsIDExIEZlYiAyMDIw
IDE2OjAxOjIyICswMTAwDQo+ID4gU3ViamVjdDogW1BBVENIXSBkb2NzOiBVcGRhdGUgdmhvc3Qt
dXNlciBzcGVjIHJlZ2FyZGluZyBiYWNrZW5kDQo+ID4gcHJvZ3JhbQ0KPiA+ICBjb252ZW50aW9u
cw0KPiA+IA0KPiA+IFRoZSB2aG9zdC11c2VyIHNwZWNpZmljYXRpb24gaXMgbm90IGNsZWFybHkg
c3RhdGluZyB0aGUgZXhwZWN0ZWQNCj4gPiBiZWhhdmlvciBmcm9tIGEgYmFja2VuZCBwcm9ncmFt
IHdoZW5ldmVyIHRoZSBjbGllbnQgZGlzY29ubmVjdHMuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBh
ZGRyZXNzZXMgdGhlIGlzc3VlIGJ5IGRlZmluaW5nIHRoZSBkZWZhdWx0IGJlaGF2aW9yIGFuZA0K
PiA+IHByb3Bvc2luZyBhbiBhbHRlcm5hdGl2ZSB0aHJvdWdoIGEgY29tbWFuZCBsaW5lIG9wdGlv
bi4NCj4gPiANCj4gPiBCeSBkZWZhdWx0LCBhIGJhY2tlbmQgcHJvZ3JhbSB3aWxsIGhhdmUgdG8g
a2VlcCBsaXN0ZW5pbmcgZXZlbiBpZg0KPiA+IHRoZQ0KPiA+IGNsaWVudCBkaXNjb25uZWN0cywg
dW5sZXNzIHRvbGQgb3RoZXJ3aXNlIHRocm91Z2ggdGhlIG5ld2x5DQo+ID4gaW50cm9kdWNlZA0K
PiA+IG9wdGlvbiAtLWV4aXQtb24tZGlzY29ubmVjdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTZWJhc3RpZW4gQm9ldWYgPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkb2NzL2ludGVyb3Avdmhvc3QtdXNlci5yc3QgfCAxMCArKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Rv
Y3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdCBiL2RvY3MvaW50ZXJvcC92aG9zdC0NCj4gPiB1c2Vy
LnJzdA0KPiA+IGluZGV4IDVmOGIzYTQ1NmIuLmRhOWExZWJjNGMgMTAwNjQ0DQo+ID4gLS0tIGEv
ZG9jcy9pbnRlcm9wL3Zob3N0LXVzZXIucnN0DQo+ID4gKysrIGIvZG9jcy9pbnRlcm9wL3Zob3N0
LXVzZXIucnN0DQo+ID4gQEAgLTEzMjMsNiArMTMyMywxMCBAQCBUaGUgYmFja2VuZCBwcm9ncmFt
IG11c3QgZW5kIChhcyBxdWlja2x5IGFuZA0KPiA+IGNsZWFubHkgYXMgcG9zc2libGUpIHdoZW4N
Cj4gPiAgdGhlIFNJR1RFUk0gc2lnbmFsIGlzIHJlY2VpdmVkLiBFdmVudHVhbGx5LCBpdCBtYXkg
cmVjZWl2ZSBTSUdLSUxMDQo+ID4gYnkNCj4gPiAgdGhlIG1hbmFnZW1lbnQgbGF5ZXIgYWZ0ZXIg
YSBmZXcgc2Vjb25kcy4NCj4gPiANCj4gPiArQnkgZGVmYXVsdCwgdGhlIGJhY2tlbmQgcHJvZ3Jh
bSBjb250aW51ZXMgcnVubmluZyBhZnRlciB0aGUgY2xpZW50DQo+ID4gK2Rpc2Nvbm5lY3RzLiBJ
dCBhY2NlcHRzIG9ubHkgMSBjb25uZWN0aW9uIGF0IGEgdGltZSBvbiBlYWNoIFVOSVgNCj4gPiBk
b21haW4NCj4gPiArc29ja2V0Lg0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0J3MgdGhlIG1vc3Qg
Y29tbW9uIGJlaGF2aW91ci4gbGlidmhvc3QtdXNlciB3aWxsDQo+IHBhbmljKCkgb24gZGlzY29u
bmVjdCBpbiBnZW5lcmFsLCB1bmxlc3MgdGhlIGVycm9yL2V4aXQgaXMgaGFuZGxlZA0KPiBncmFj
ZWZ1bGx5IGJ5IHRoZSBiYWNrZW5kLg0KDQpJdCdzIG5vdCB0aGUgZGVmYXVsdCBiZWhhdmlvciBm
cm9tIGxpYnZob3N0LXVzZXIsIGJ1dCB0aGF0J3MgZXhhY3RseQ0Kc29tZXRoaW5nIEknZCBsaWtl
IHRvIHNlZSBjaGFuZ2luZy4gVGhpcyBzaG91bGQgYmUgdGhlIG5vcm1hbCBjYXNlIGlmDQp5b3Ug
dGhpbmsgYWJvdXQgYSBzdGFuZGFyZCBjbGllbnQvc2VydmVyIGNvbm5lY3Rpb24sIHdoZXJlIHRo
ZSBzZXJ2ZXINCndvdWxkIHNpbXBseSBsaXN0ZW4gYWdhaW4gYWZ0ZXIgdGhlIGNsaWVudCBkaXNj
b25uZWN0cy4NCg0KPiANCj4gVGhlIG1vc3QgY29tbW9uIGNhc2UgaXMgdG8gaGF2ZSAxLTEgcmVs
YXRpb24gYmV0d2VlbiBkZXZpY2UvcWVtdQ0KPiBpbnN0YW5jZSBhbmQgYmFja2VuZC4NCg0KWWVz
IHRoaXMgcGFydCBpcyBmaW5lLCBidXQgdGhhdCdzIG5vdCBhIHJlYXNvbiB3aHkgdGhlIGJhY2tl
bmQgc2hvdWxkDQp0ZXJtaW5hdGVzLg0KDQo+IA0KPiBXaHkgbm90IHJlc3RhcnQgdGhlIGJhY2tl
bmQgZm9yIGFub3RoZXIgaW5zdGFuY2U/DQoNCkJlY2F1c2UgeW91IG5lZWQgc29tZSBtYW5hZ2Vt
ZW50IHRvb2wgdG8gZG8gc28uIEFuZCBJIHRoaW5rIHRoYXQgYnkNCmRlZmF1bHQgaXQgY291bGQg
YmUgaW50ZXJlc3RpbmcgdG8gaGF2ZSB0aGUgbGVhc3QgYW1vdW50IG9mIGV4dHJhDQptYW5hZ2Vt
ZW50IGludm9sdmVkLg0KDQo+IA0KPiA+ICsNCj4gPiAgVGhlIGZvbGxvd2luZyBjb21tYW5kIGxp
bmUgb3B0aW9ucyBoYXZlIGFuIGV4cGVjdGVkIGJlaGF2aW91ci4NCj4gPiBUaGV5DQo+ID4gIGFy
ZSBtYW5kYXRvcnksIHVubGVzcyBleHBsaWNpdGx5IHNhaWQgZGlmZmVyZW50bHk6DQo+ID4gDQo+
ID4gQEAgLTEzMzcsNiArMTM0MSwxMiBAQCBhcmUgbWFuZGF0b3J5LCB1bmxlc3MgZXhwbGljaXRs
eSBzYWlkDQo+ID4gZGlmZmVyZW50bHk6DQo+ID4gICAgdmhvc3QtdXNlciBzb2NrZXQgYXMgZmls
ZSBkZXNjcmlwdG9yIEZETlVNLiBJdCBpcyBpbmNvbXBhdGlibGUNCj4gPiB3aXRoDQo+ID4gICAg
LS1zb2NrZXQtcGF0aC4NCj4gPiANCj4gPiArLS1leGl0LW9uLWRpc2Nvbm5lY3QNCj4gPiArDQo+
ID4gKyAgV2hlbiB0aGlzIG9wdGlvbiBpcyBwcm92aWRlZCwgdGhlIGJhY2tlbmQgcHJvZ3JhbSBt
dXN0IHRlcm1pbmF0ZQ0KPiA+IHdoZW4NCj4gPiArICB0aGUgY2xpZW50IGRpc2Nvbm5lY3RzLiBU
aGlzIGNhbiBiZSB1c2VkIHRvIGtlZXAgdGhlIGJhY2tlbmQNCj4gPiBwcm9ncmFtJ3MNCj4gPiAr
ICBsaWZldGltZSBzeW5jaHJvbml6ZWQgd2l0aCBpdHMgY2xpZW50IHByb2Nlc3MuDQo+IA0KPiBU
aGlzIHNlY3Rpb24gbGlzdCBvcHRpb25zIHRoYXQgYXJlIG1hbmRhdG9yeS4gSXQncyBwcm9iYWJs
eSBhIGJpdA0KPiBsYXRlDQo+IHRvIGFkZCBtb3JlIG1hbmRhdG9yeSBvcHRpb25zIChJIHJlZ3Jl
dCBhbHJlYWR5IHNvbWUgb2YgdGhlbSkNCg0KVGhlIHNwZWMgc3RhdGVzICJUaGV5IGFyZSBtYW5k
YXRvcnksIHVubGVzcyBleHBsaWNpdGx5IHNhaWQNCmRpZmZlcmVudGx5IiwgYW5kIGluIHRoaXMg
Y2FzZSBJJ20gZXhwbGljaXRlbHkgc2F5aW5nICJXaGVuIHRoaXMgb3B0aW9uDQppcyBwcm92aWRl
ZCIsIHdoaWNoIG1lYW5zIGlmIGl0J3Mgbm90IHByb3ZpZGVkIGl0J3MgZmluZSBhbmQgd2UgY2Fu
DQppZ25vcmUgdGhlIGZhY3QgaXQncyBub3QgdGhlcmUuDQoNCj4gDQo+IERvIHdlIG5lZWQgdG8g
c3BlY2lmeSB0aGUgYmVoYXZpb3VyIG9uIGNsaWVudCBkaXNjb25uZWN0PyBDYW4ndCB3ZQ0KPiBs
ZWF2ZSB0aGF0IHRvIHRoZSBiYWNrZW5kIGFuZCBtYW5hZ2VtZW50IGxheWVyIHRvIGRlY2lkZT8N
Cg0KTXkgZ29hbCBoZXJlIGlzIHRvIG1ha2UgdGhlIHNwZWMgYSBiaXQgbGVzcyBsb29zZS4gSSBr
bm93IGxpYnZob3N0LXVzZXIgDQppcyB0aGUgZGUtZmFjdG8gaW1wbGVtZW50YXRpb24gYnV0IHdl
IGNhbm5vdCBqdXN0IGFzc3VtZSBldmVyeXRoaW5nIG91dA0Kb2YgdGhlIGxpYnZob3N0LXVzZXIg
aW1wbGVtZW50YXRpb24sIGVzcGVjaWFsbHkgc2luY2UgdGhlcmUgaXMgYQ0KZGVkaWNhdGVkIHNw
ZWMuIFRoYXQncyB0aGUgcmVhc29uIHdoeSBJIHRob3VnaHQgaXQnZCBiZSBuaWNlIHRvIGhhdmUN
CnRoZSBiYWNrZW5kIGJlaGF2aW9yIHdlbGwgZGVmaW5lZCBpbiB0aGUgc3BlYy4NClRoZSBwb2lu
dCBpcywgcmVseWluZyBvbiB0aGUgY3VycmVudCBkZWZpbml0aW9uLCB0aGVyZSdzIG5vdCBlbm91
Z2gNCmluZm9ybWF0aW9uIHRvIG1ha2Ugc3VyZSBhIFZNTSB3aWxsIHByb3Blcmx5IGludGVyZmFj
ZSB3aXRoIGEgdmhvc3QtDQp1c2VyIGJhY2tlbmQuDQoNClRoYW5rcywNClNlYmFzdGllbg0KDQo+
IA0KPiANCj4gPiArDQo+ID4gIC0tcHJpbnQtY2FwYWJpbGl0aWVzDQo+ID4gDQo+ID4gICAgT3V0
cHV0IHRvIHN0ZG91dCB0aGUgYmFja2VuZCBjYXBhYmlsaXRpZXMgaW4gSlNPTiBmb3JtYXQsIGFu
ZA0KPiA+IHRoZW4NCj4gPiAtLQ0KPiA+IDIuMjAuMQ0KPiA+IA0KPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
LS0tLQ0KPiA+IEludGVsIENvcnBvcmF0aW9uIFNBUyAoRnJlbmNoIHNpbXBsaWZpZWQgam9pbnQg
c3RvY2sgY29tcGFueSkNCj4gPiBSZWdpc3RlcmVkIGhlYWRxdWFydGVyczogIkxlcyBNb250YWxl
dHMiLSAyLCBydWUgZGUgUGFyaXMsDQo+ID4gOTIxOTYgTWV1ZG9uIENlZGV4LCBGcmFuY2UNCj4g
PiBSZWdpc3RyYXRpb24gTnVtYmVyOiAgMzAyIDQ1NiAxOTkgUi5DLlMuIE5BTlRFUlJFDQo+ID4g
Q2FwaXRhbDogNCw1NzIsMDAwIEV1cm9zDQo+ID4gDQo+ID4gVGhpcyBlLW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwNCj4gPiBmb3INCj4g
PiB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmlldyBv
cg0KPiA+IGRpc3RyaWJ1dGlvbg0KPiA+IGJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVk
LiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQNCj4gPiByZWNpcGllbnQsIHBsZWFzZSBjb250
YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLg0KLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVs
IENvcnBvcmF0aW9uIFNBUyAoRnJlbmNoIHNpbXBsaWZpZWQgam9pbnQgc3RvY2sgY29tcGFueSkK
UmVnaXN0ZXJlZCBoZWFkcXVhcnRlcnM6ICJMZXMgTW9udGFsZXRzIi0gMiwgcnVlIGRlIFBhcmlz
LCAKOTIxOTYgTWV1ZG9uIENlZGV4LCBGcmFuY2UKUmVnaXN0cmF0aW9uIE51bWJlcjogIDMwMiA0
NTYgMTk5IFIuQy5TLiBOQU5URVJSRQpDYXBpdGFsOiA0LDU3MiwwMDAgRXVyb3MKClRoaXMgZS1t
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFs
IGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJldmll
dyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBzZW5k
ZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=



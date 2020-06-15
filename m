Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 04:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B03D2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 04:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B03D2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkgmJ-0004wa-OT
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 00:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jkgl7-0004QF-VR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 00:30:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:15230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jkgl5-0007K6-8T
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 00:30:09 -0400
IronPort-SDR: pvOKuSfp5birrtZzGvKUO5mVCoZKEhVOyuvylaZnamJacH8V+5VGJmsT+rHGwAfGOxUM+xbeEs
 SH5CvOryvVag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 21:29:56 -0700
IronPort-SDR: zbCCY092B7Ei1M2xDUuaCME6HWZdfxSIProk24LftUXSt8kj0eDeHyT7IhsSYFs7y5p+AArAhI
 4ugQoKPc3t9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,513,1583222400"; d="scan'208";a="382401474"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2020 21:29:56 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 21:29:56 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 15 Jun 2020 12:29:54 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 15 Jun 2020 12:29:54 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Zhanghailiang <zhang.zhanghailiang@huawei.com>, Like Xu
 <like.xu@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Thread-Topic: [PATCH 1/2] migration/colo: fix typo in the COLO Framework module
Thread-Index: AQHWQihvBC6zNO1tcEKxj7OL2NrY7ajYYGEAgAANOQCAAAu/AIAAnIfg
Date: Mon, 15 Jun 2020 04:29:54 +0000
Message-ID: <8dd6cb061a5141bc8e92f26fac7ee672@intel.com>
References: <20200614084510.7917-1-like.xu@linux.intel.com>
 <17a0016f32fb471fa57e4f0c21ecb19d@huawei.com>
 <0d30a6ce-6641-dc82-10e5-cd748dbf104a@linux.intel.com>
 <39e096702ae54e109ae7599525161739@huawei.com>
In-Reply-To: <39e096702ae54e109ae7599525161739@huawei.com>
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
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 00:29:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SXQgbG9va3Mgbm9ybWFsIHRvIG1lLg0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWRldmVsIDxxZW11LWRldmVsLQ0KPiBi
b3VuY2VzK2NoZW4uemhhbmc9aW50ZWwuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBaaGFu
Z2hhaWxpYW5nDQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxNSwgMjAyMCAxMTowNiBBTQ0KPiBUbzog
TGlrZSBYdSA8bGlrZS54dUBsaW51eC5pbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcN
Cj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIG1pZ3JhdGlvbi9jb2xvOiBmaXggdHlwbyBpbiB0
aGUgQ09MTyBGcmFtZXdvcmsNCj4gbW9kdWxlDQo+IA0KPiANCj4gSSBoYXZlIGNoZWNrZWQgdGhp
cyBwYXRjaCBpbiBtYWlsIGFyY2hpdmUsIGl0IGhhcyBubyBwcm9ibGVtLCBJdCBzZWVtcyB0aGF0
IG15DQo+IGVtYWlsIHNldHVwIGhhcyBzb21lIHByb2JsZW0uIEl0IGRpZG4ndCBzaG93IHRoZSBy
aWdodCBuZXdsaW5lIEluIHRoaXMgcGF0Y2guDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IExpa2UgWHUgW21haWx0bzpsaWtlLnh1QGxpbnV4LmludGVs
LmNvbV0NCj4gPiBTZW50OiBNb25kYXksIEp1bmUgMTUsIDIwMjAgMTA6MjQgQU0NCj4gPiBUbzog
WmhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsNCj4gPiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbWlncmF0aW9u
L2NvbG86IGZpeCB0eXBvIGluIHRoZSBDT0xPDQo+ID4gRnJhbWV3b3JrIG1vZHVsZQ0KPiA+DQo+
ID4gT24gMjAyMC82LzE1IDk6MzYsIFpoYW5naGFpbGlhbmcgd3JvdGU6DQo+ID4gPiBIaSBMaWtl
LA0KPiA+ID4NCj4gPiA+IFBsZWFzZSBjaGVjayB0aGlzIHBhdGNoLCBJdCBzZWVtcyB0aGF0IHlv
dSBkaWRuJ3QgdXNlIGdpdA0KPiA+ID4gZm9ybWF0LXBhdGNoIGNvbW1hbmQgdG8gZ2VuZXJhdGUg
dGhpcyBwYXRjaCwgSXQgaXMgaW4gd3JvbmcgZm9ybWF0Lg0KPiA+DQo+ID4gSSByZWJhc2UgdGhl
IHBhdGNoIG9uIHRoZSB0b3AgY29tbWl0IG9mDQo+ID4gN2QzNjYwZTc5ODMwYTA2OWYxODQ4YmI0
ZmExY2RmOGY2NjY0MjRmYiwNCj4gPiBhbmQgaG9wZSBpdCBoZWxwcyB5b3UuDQo+ID4NCj4gPiA+
DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBIYWlsaWFuZw0KPiA+DQo+ID4gIEZyb20gMTVjMTliZTli
ZTA3NTk4ZDQyNjRhNGE4NGI4NWQ0ZWZhNzliZmY5ZCBNb24gU2VwIDE3DQo+ID4gMDA6MDA6MDAg
MjAwMQ0KPiA+IEZyb206IExpa2UgWHUgPGxpa2UueHVAbGludXguaW50ZWwuY29tPg0KPiA+IERh
dGU6IE1vbiwgMTUgSnVuIDIwMjAgMTA6MTA6NTcgKzA4MDANCj4gPiBTdWJqZWN0OiBbUEFUQ0gg
MS8yXSBtaWdyYXRpb24vY29sbzogZml4IHR5cG8gaW4gdGhlIENPTE8gRnJhbWV3b3JrDQo+ID4g
bW9kdWxlDQo+ID4NCj4gPiBDYzogSGFpbGlhbmcgWmhhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdA
aHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaWtlIFh1IDxsaWtlLnh1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRvY3MvQ09MTy1GVC50eHQgfCA4ICsrKystLS0tDQo+
ID4gICBtaWdyYXRpb24vY29sby5jIHwgMiArLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZG9jcy9D
T0xPLUZULnR4dCBiL2RvY3MvQ09MTy1GVC50eHQgaW5kZXgNCj4gPiBjOGUxNzQwOTM1Li5mZGMw
MjA3Y2ZmIDEwMDY0NA0KPiA+IC0tLSBhL2RvY3MvQ09MTy1GVC50eHQNCj4gPiArKysgYi9kb2Nz
L0NPTE8tRlQudHh0DQo+ID4gQEAgLTEwLDcgKzEwLDcgQEAgU2VlIHRoZSBDT1BZSU5HIGZpbGUg
aW4gdGhlIHRvcC1sZXZlbCBkaXJlY3RvcnkuDQo+ID4gICBUaGlzIGRvY3VtZW50IGdpdmVzIGFu
IG92ZXJ2aWV3IG9mIENPTE8ncyBkZXNpZ24gYW5kIGhvdyB0byB1c2UgaXQuDQo+ID4NCj4gPiAg
ID09IEJhY2tncm91bmQgPT0NCj4gPiAtVmlydHVhbCBtYWNoaW5lIChWTSkgcmVwbGljYXRpb24g
aXMgYSB3ZWxsIGtub3duIHRlY2huaXF1ZSBmb3INCj4gPiBwcm92aWRpbmcNCj4gPiArVmlydHVh
bCBtYWNoaW5lIChWTSkgcmVwbGljYXRpb24gaXMgYSB3ZWxsLWtub3duIHRlY2huaXF1ZSBmb3IN
Cj4gPiArcHJvdmlkaW5nDQo+ID4gICBhcHBsaWNhdGlvbi1hZ25vc3RpYyBzb2Z0d2FyZS1pbXBs
ZW1lbnRlZCBoYXJkd2FyZSBmYXVsdCB0b2xlcmFuY2UsDQo+ID4gICBhbHNvIGtub3duIGFzICJu
b24tc3RvcCBzZXJ2aWNlIi4NCj4gPg0KPiA+IEBAIC0xMDMsNyArMTAzLDcgQEAgUHJpbWFyeSBz
aWRlLg0KPiA+DQo+ID4gICBDT0xPIFByb3h5Og0KPiA+ICAgRGVsaXZlcnMgcGFja2V0cyB0byBQ
cmltYXJ5IGFuZCBTZWNvbmRhcnksIGFuZCB0aGVuIGNvbXBhcmUgdGhlDQo+ID4gcmVzcG9uc2Vz
IGZyb20gLWJvdGggc2lkZS4gVGhlbiBkZWNpZGUgd2hldGhlciB0byBzdGFydCBhIGNoZWNrcG9p
bnQNCj4gPiBhY2NvcmRpbmcgdG8gc29tZSBydWxlcy4NCj4gPiArYm90aCBzaWRlcy4gVGhlbiBk
ZWNpZGUgd2hldGhlciB0byBzdGFydCBhIGNoZWNrcG9pbnQgYWNjb3JkaW5nIHRvDQo+ID4gK3Nv
bWUNCj4gPiBydWxlcy4NCj4gPiAgIFBsZWFzZSByZWZlciB0byBkb2NzL2NvbG8tcHJveHkudHh0
IGZvciBtb3JlIGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gICBOb3RlOg0KPiA+IEBAIC0xNDYsMTIg
KzE0NiwxMiBAQCBpbiB0ZXN0IHByb2NlZHVyZS4NCj4gPg0KPiA+ICAgPT0gVGVzdCBwcm9jZWR1
cmUgPT0NCj4gPiAgIE5vdGU6IEhlcmUgd2UgYXJlIHJ1bm5pbmcgYm90aCBpbnN0YW5jZXMgb24g
dGhlIHNhbWUgaG9zdCBmb3INCj4gPiB0ZXN0aW5nLCAtY2hhbmdlIHRoZSBJUCBBZGRyZXNzZXMg
aWYgeW91IHdhbnQgdG8gcnVuIGl0IG9uIHR3byBob3N0cy4NCj4gPiBJbml0YWxseQ0KPiA+ICtj
aGFuZ2UgdGhlIElQIEFkZHJlc3NlcyBpZiB5b3Ugd2FudCB0byBydW4gaXQgb24gdHdvIGhvc3Rz
LiBJbml0aWFsbHkNCj4gPiAgIDEyNy4wLjAuMSBpcyB0aGUgUHJpbWFyeSBIb3N0IGFuZCAxMjcu
MC4wLjIgaXMgdGhlIFNlY29uZGFyeSBIb3N0Lg0KPiA+DQo+ID4gICA9PSBTdGFydHVwIHFlbXUg
PT0NCj4gPiAgIDEuIFByaW1hcnk6DQo+ID4gLU5vdGU6IEluaXRhbGx5LCAkaW1hZ2Vmb2xkZXIv
cHJpbWFyeS5xY293MiBuZWVkcyB0byBiZSBjb3BpZWQgdG8gYWxsIGhvc3RzLg0KPiA+ICtOb3Rl
OiBJbml0aWFsbHksICRpbWFnZWZvbGRlci9wcmltYXJ5LnFjb3cyIG5lZWRzIHRvIGJlIGNvcGll
ZCB0byBhbGwNCj4gaG9zdHMuDQo+ID4gICBZb3UgZG9uJ3QgbmVlZCB0byBjaGFuZ2UgYW55IElQ
J3MgaGVyZSwgYmVjYXVzZSAwLjAuMC4wIGxpc3RlbnMgb24gYW55DQo+ID4gICBpbnRlcmZhY2Uu
IFRoZSBjaGFyZGV2J3Mgd2l0aCAxMjcuMC4wLjEgSVAncyBsb29wYmFjayB0byB0aGUgbG9jYWwg
cWVtdQ0KPiA+ICAgaW5zdGFuY2UuDQo+ID4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9jb2xvLmMg
Yi9taWdyYXRpb24vY29sby5jIGluZGV4DQo+ID4gZWE3ZDFlOWQ0ZS4uODA3ODhkNDZiNSAxMDA2
NDQNCj4gPiAtLS0gYS9taWdyYXRpb24vY29sby5jDQo+ID4gKysrIGIvbWlncmF0aW9uL2NvbG8u
Yw0KPiA+IEBAIC02MzIsNyArNjMyLDcgQEAgb3V0Og0KPiA+ICAgICAgIC8qDQo+ID4gICAgICAg
ICogSXQgaXMgc2FmZSB0byB1bnJlZ2lzdGVyIG5vdGlmaWVyIGFmdGVyIGZhaWxvdmVyIGZpbmlz
aGVkLg0KPiA+ICAgICAgICAqIEJlc2lkZXMsIGNvbG9fZGVsYXlfdGltZXIgYW5kIGNvbG9fY2hl
Y2twb2ludF9zZW0gY2FuJ3QgYmUNCj4gPiAtICAgICAqIHJlbGVhc2VkIGJlZm9yIHVucmVnaXN0
ZXIgbm90aWZpZXIsIG9yIHRoZXJlIHdpbGwgYmUgdXNlLWFmdGVyLWZyZWUNCj4gPiArICAgICAq
IHJlbGVhc2VkIGJlZm9yZSB1bnJlZ2lzdGVyIG5vdGlmaWVyLCBvciB0aGVyZSB3aWxsIGJlDQo+
ID4gKyB1c2UtYWZ0ZXItZnJlZQ0KPiA+ICAgICAgICAqIGVycm9yLg0KPiA+ICAgICAgICAqLw0K
PiA+ICAgICAgIGNvbG9fY29tcGFyZV91bnJlZ2lzdGVyX25vdGlmaWVyKCZwYWNrZXRzX2NvbXBh
cmVfbm90aWZpZXIpOw0KPiA+IC0tDQo+ID4gMi4yMS4zDQo+ID4NCg0K


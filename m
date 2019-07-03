Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F304C5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377492064A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377492064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58569 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiTxX-0000u5-Ef
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 21:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hiTwi-0008RB-PX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hiTwh-00017O-6D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:20:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:53170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hiTwg-00011e-R6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:20:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 18:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="174782258"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga002.jf.intel.com with ESMTP; 02 Jul 2019 18:20:24 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 18:20:24 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 18:20:23 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.134]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 09:20:22 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [PULL 16/17] COLO-compare: Add colo-compare remote notify support
Thread-Index: AQHVMH5bJkceZBdwFku7M0vfrcWALqa3Jy8AgADvAkCAAAM0oA==
Date: Wed, 3 Jul 2019 01:20:21 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061B3F0E@shsmsx102.ccr.corp.intel.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
 <1562034689-6539-17-git-send-email-jasowang@redhat.com>
 <CAFEAcA_mC2mfgDj+QqtGFNuxi+UCBq=XuZOswgZMGuEnpkg=sA@mail.gmail.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTE3YjFjYzktY2VlNy00NmNlLTg3MWQtZjU3MTJhNWM5MmE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUllRS05uRTNzODEwOW91Qit1alN5eEFCdVJcL1hmTm1QbDRKbXUxRUR4OHRrckZHdUJtWEdXR2ZhajAxQlJ0NDkifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PULL 16/17] COLO-compare: Add colo-compare remote
 notify support
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBaaGFuZywgQ2hlbg0K
PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMywgMjAxOSA5OjA4IEFNDQo+IFRvOiAnUGV0ZXIgTWF5
ZGVsbCcgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEphc29uIFdhbmcNCj4gPGphc293YW5n
QHJlZGhhdC5jb20+DQo+IENjOiBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zz4NCj4gU3ViamVjdDogUkU6IFtQVUxMIDE2LzE3XSBDT0xPLWNvbXBhcmU6IEFkZCBjb2xvLWNv
bXBhcmUgcmVtb3RlIG5vdGlmeQ0KPiBzdXBwb3J0DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWlsdG86cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiA+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAzLCAyMDE5IDI6
NTEgQU0NCj4gPiBUbzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gPiBDYzog
UUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+OyBaaGFuZywgQ2hlbg0KPiA+
IDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BVTEwgMTYvMTddIENP
TE8tY29tcGFyZTogQWRkIGNvbG8tY29tcGFyZSByZW1vdGUgbm90aWZ5DQo+ID4gc3VwcG9ydA0K
PiA+DQo+ID4gT24gVHVlLCAyIEp1bCAyMDE5IGF0IDAzOjMyLCBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVu
LnpoYW5nQGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoIG1ha2UgY29sby1jb21w
YXJlIGNhbiBzZW5kIG1lc3NhZ2UgdG8gcmVtb3RlIENPTE8NCj4gPiA+IGZyYW1lKFhlbikNCj4g
PiB3aGVuIG9jY3VyIGNoZWNrcG9pbnQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhh
bmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+DQo+ID4gSGk7IENvdmVyaXR5IHJlcG9y
dHMgYSBwcm9ibGVtIChDSUQgMTQwMjc4NSkgd2l0aCB0aGlzIGZ1bmN0aW9uOg0KPiA+DQo+ID4g
PiBAQCAtOTg5LDcgKzEwMDYsMjQgQEAgc3RhdGljIHZvaWQNCj4gPiA+IGNvbXBhcmVfc2VjX3Jz
X2ZpbmFsaXplKFNvY2tldFJlYWRTdGF0ZSAqc2VjX3JzKQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMg
dm9pZCBjb21wYXJlX25vdGlmeV9yc19maW5hbGl6ZShTb2NrZXRSZWFkU3RhdGUgKm5vdGlmeV9y
cykNCj4gPiA+IHsNCj4gPiA+ICsgICAgQ29tcGFyZVN0YXRlICpzID0gY29udGFpbmVyX29mKG5v
dGlmeV9ycywgQ29tcGFyZVN0YXRlLA0KPiA+ID4gKyBub3RpZnlfcnMpOw0KPiA+ID4gKw0KPiA+
ID4gICAgICAvKiBHZXQgWGVuIGNvbG8tZnJhbWUncyBub3RpZnkgYW5kIGhhbmRsZSB0aGUgbWVz
c2FnZSAqLw0KPiA+ID4gKyAgICBjaGFyICpkYXRhID0gZ19tZW1kdXAobm90aWZ5X3JzLT5idWYs
IG5vdGlmeV9ycy0+cGFja2V0X2xlbik7DQo+ID4gPiArICAgIGNoYXIgbXNnW10gPSAiQ09MT19D
T01QQVJFX0dFVF9YRU5fSU5JVCI7DQo+ID4gPiArICAgIGludCByZXQ7DQo+ID4gPiArDQo+ID4g
PiArICAgIGlmICghc3RyY21wKGRhdGEsICJDT0xPX1VTRVJTUEFDRV9QUk9YWV9JTklUIikpIHsN
Cj4gPiA+ICsgICAgICAgIHJldCA9IGNvbXBhcmVfY2hyX3NlbmQocywgKHVpbnQ4X3QgKiltc2cs
IHN0cmxlbihtc2cpLCAwLCB0cnVlKTsNCj4gPiA+ICsgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+
ID4gPiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJOb3RpZnkgWGVuIENPTE8tZnJhbWUgSU5J
VCBmYWlsZWQiKTsNCj4gPiA+ICsgICAgICAgIH0NCj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+
ID4gKyAgICBpZiAoIXN0cmNtcChkYXRhLCAiQ09MT19DSEVDS1BPSU5UIikpIHsNCj4gPiA+ICsg
ICAgICAgIC8qIGNvbG8tY29tcGFyZSBkbyBjaGVja3BvaW50LCBmbHVzaCBwcmkgcGFja2V0IGFu
ZCByZW1vdmUNCj4gPiA+ICsgc2VjIHBhY2tldA0KPiA+ICovDQo+ID4gPiArICAgICAgICBnX3F1
ZXVlX2ZvcmVhY2goJnMtPmNvbm5fbGlzdCwgY29sb19mbHVzaF9wYWNrZXRzLCBzKTsNCj4gPiA+
ICsgICAgfQ0KPiA+ID4gIH0NCj4gPg0KPiA+IFdlIGFsbG9jYXRlIGRhdGEgdXNpbmcgZ19tZW1k
dXAoKSwgYnV0IHdlIG5ldmVyIGZyZWUgaXQgYmVmb3JlDQo+ID4gcmV0dXJuaW5nLCBzbyB0aGUg
ZnVuY3Rpb24gaGFzIGEgbWVtb3J5IGxlYWsuIEl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoeQ0KPiA+
IHdlJ3JlIGR1cGxpY2F0aW5nIHRoZSBzdHJpbmcgYXQgYWxsIC0tIGl0IHdvdWxkIGJlIGNsZWFu
ZXIgdG8gZG8gdGhlDQo+ID4gY2hlY2sgb2YgdGhlIHBhY2tldCBjb250ZW50cyB0byBpZGVudGlm
eSBpbi1wbGFjZS4gVGhhdCB3b3VsZCBiZSB0aGUgYmVzdCB3YXkNCj4gdG8gZml4L2F2b2lkIHRo
ZSBsZWFrLg0KPiA+DQo+ID4gU29tZSBvdGhlciB0aGluZ3MgSSBub3RpY2UgcmVhZGluZyB0aGUg
ZnVuY3Rpb246DQo+ID4NCj4gPiAoMSkgYWZ0ZXIgdGhlIGZpcnN0IGlmKCkgd2Ugd2lsbCBnbyBh
aGVhZCBhbmQgY2hlY2sgdGhlIHNlY29uZCBpZigpLg0KPiA+IFRoaXMgbWVhbnMgd2UnbGwgdW5u
ZWNlc3NhcmlseSBjaGVjayB3aGV0aGVyIHRoZSBkYXRhIHN0cmluZyBtYXRjaGVzDQo+ID4gQ09M
T19DSEVDS1BPSU5ULCB3aGVuIHdlIGtub3cgYWxyZWFkeSBpdCBjYW5ub3QuIEkgdGhpbmsgYW4g
aWYNCj4gPiAoIXN0cmNtcCguLi4pKSB7IC4uLiB9IGVsc2UgaWYgKCFzdHJjbXAoLi4uKSkgeyAu
Li4gfSBzdHJ1Y3R1cmUgd291bGQgYmUgbW9yZSBub3JtYWwNCj4gQyBoZXJlLg0KPiA+DQo+ID4g
KDIpIHRoZSBnX21lbWR1cCgpIGNhbGwgaXMgdHJlYXRpbmcgdGhlIGRhdGEgYXMgYSBidWZmZXIt
YW5kLWxlbmd0aCwNCj4gPiBhbmQgd2UgZG9uJ3QgZW5mb3JjZSB0aGF0IGl0IGlzIE5VTC10ZXJt
aW5hdGVkLiBCdXQgdGhlbiB3ZSBkbyBhDQo+ID4gc3RyY21wKCkgYWdhaW5zdCBpdCwgd2hpY2gg
YXNzdW1lcyB0aGF0IHRoZSBkYXRhIGlzIGEgTlVMLXRlcm1pbmF0ZWQNCj4gPiBzdHJpbmcuIElz
IHRoaXMgc2FmZSA/DQo+ID4NCj4gPiAoMykgTW9yZSBtaW5vciBwb2ludDogeW91IGNvdWxkIG1h
cmsgJ21zZycgYXMgY29uc3QgaGVyZSwgc2luY2UgSQ0KPiA+IHRoaW5rIHdlIG5ldmVyIG5lZWQg
dG8gbW9kaWZ5IGl0Lg0KPiANCj4gT0ssIEkgd2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0K
PiBUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KPiANCg0KSSBmb3VuZCB0aGlzIHBhdGNoIGhh
cyBiZWVuIG1lcmdlZCwgSSB3aWxsIHNlbmQgYSBwYXRjaCB0byBmaXggdGhlIGlzc3VlcyBvZiBw
ZXRlciBjb21tZW50cy4NCg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoNCj4gDQo+IFRoYW5rcw0KPiBa
aGFuZyBDaGVuDQo+IA0KPiA+DQo+ID4gdGhhbmtzDQo+ID4gLS0gUE1NDQo=


Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3412EC5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A75B20673
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 01:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A75B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiTmM-0001Ti-5m
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 21:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hiTl6-00012A-4y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hiTl1-0001Cm-7N
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:08:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:46342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hiTkz-00017p-F8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 21:08:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jul 2019 18:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,445,1557212400"; d="scan'208";a="174779828"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga002.jf.intel.com with ESMTP; 02 Jul 2019 18:08:12 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 18:08:12 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 18:08:11 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.60]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 09:08:09 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [PULL 16/17] COLO-compare: Add colo-compare remote notify support
Thread-Index: AQHVMH5bJkceZBdwFku7M0vfrcWALqa3Jy8AgADvAkA=
Date: Wed, 3 Jul 2019 01:08:09 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061B3E74@shsmsx102.ccr.corp.intel.com>
References: <1562034689-6539-1-git-send-email-jasowang@redhat.com>
 <1562034689-6539-17-git-send-email-jasowang@redhat.com>
 <CAFEAcA_mC2mfgDj+QqtGFNuxi+UCBq=XuZOswgZMGuEnpkg=sA@mail.gmail.com>
In-Reply-To: <CAFEAcA_mC2mfgDj+QqtGFNuxi+UCBq=XuZOswgZMGuEnpkg=sA@mail.gmail.com>
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
X-Received-From: 134.134.136.100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCBb
bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5
IDMsIDIwMTkgMjo1MSBBTQ0KPiBUbzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4N
Cj4gQ2M6IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgWmhhbmcsIENo
ZW4NCj4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BVTEwgMTYvMTdd
IENPTE8tY29tcGFyZTogQWRkIGNvbG8tY29tcGFyZSByZW1vdGUgbm90aWZ5DQo+IHN1cHBvcnQN
Cj4gDQo+IE9uIFR1ZSwgMiBKdWwgMjAxOSBhdCAwMzozMiwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5n
QGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggbWFrZSBjb2xvLWNvbXBhcmUgY2FuIHNl
bmQgbWVzc2FnZSB0byByZW1vdGUgQ09MTyBmcmFtZShYZW4pDQo+IHdoZW4gb2NjdXIgY2hlY2tw
b2ludC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+DQo+IA0KPiBIaTsgQ292ZXJpdHkgcmVwb3J0cyBhIHByb2JsZW0gKENJRCAxNDAyNzg1KSB3
aXRoIHRoaXMgZnVuY3Rpb246DQo+IA0KPiA+IEBAIC05ODksNyArMTAwNiwyNCBAQCBzdGF0aWMg
dm9pZA0KPiA+IGNvbXBhcmVfc2VjX3JzX2ZpbmFsaXplKFNvY2tldFJlYWRTdGF0ZSAqc2VjX3Jz
KQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIGNvbXBhcmVfbm90aWZ5X3JzX2ZpbmFsaXplKFNvY2tl
dFJlYWRTdGF0ZSAqbm90aWZ5X3JzKSAgew0KPiA+ICsgICAgQ29tcGFyZVN0YXRlICpzID0gY29u
dGFpbmVyX29mKG5vdGlmeV9ycywgQ29tcGFyZVN0YXRlLA0KPiA+ICsgbm90aWZ5X3JzKTsNCj4g
PiArDQo+ID4gICAgICAvKiBHZXQgWGVuIGNvbG8tZnJhbWUncyBub3RpZnkgYW5kIGhhbmRsZSB0
aGUgbWVzc2FnZSAqLw0KPiA+ICsgICAgY2hhciAqZGF0YSA9IGdfbWVtZHVwKG5vdGlmeV9ycy0+
YnVmLCBub3RpZnlfcnMtPnBhY2tldF9sZW4pOw0KPiA+ICsgICAgY2hhciBtc2dbXSA9ICJDT0xP
X0NPTVBBUkVfR0VUX1hFTl9JTklUIjsNCj4gPiArICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsg
ICAgaWYgKCFzdHJjbXAoZGF0YSwgIkNPTE9fVVNFUlNQQUNFX1BST1hZX0lOSVQiKSkgew0KPiA+
ICsgICAgICAgIHJldCA9IGNvbXBhcmVfY2hyX3NlbmQocywgKHVpbnQ4X3QgKiltc2csIHN0cmxl
bihtc2cpLCAwLCB0cnVlKTsNCj4gPiArICAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAg
ICAgICAgICBlcnJvcl9yZXBvcnQoIk5vdGlmeSBYZW4gQ09MTy1mcmFtZSBJTklUIGZhaWxlZCIp
Ow0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBpZiAoIXN0cmNt
cChkYXRhLCAiQ09MT19DSEVDS1BPSU5UIikpIHsNCj4gPiArICAgICAgICAvKiBjb2xvLWNvbXBh
cmUgZG8gY2hlY2twb2ludCwgZmx1c2ggcHJpIHBhY2tldCBhbmQgcmVtb3ZlIHNlYyBwYWNrZXQN
Cj4gKi8NCj4gPiArICAgICAgICBnX3F1ZXVlX2ZvcmVhY2goJnMtPmNvbm5fbGlzdCwgY29sb19m
bHVzaF9wYWNrZXRzLCBzKTsNCj4gPiArICAgIH0NCj4gPiAgfQ0KPiANCj4gV2UgYWxsb2NhdGUg
ZGF0YSB1c2luZyBnX21lbWR1cCgpLCBidXQgd2UgbmV2ZXIgZnJlZSBpdCBiZWZvcmUgcmV0dXJu
aW5nLCBzbw0KPiB0aGUgZnVuY3Rpb24gaGFzIGEgbWVtb3J5IGxlYWsuIEl0J3Mgbm90IGNsZWFy
IHRvIG1lIHdoeSB3ZSdyZSBkdXBsaWNhdGluZyB0aGUNCj4gc3RyaW5nIGF0IGFsbCAtLSBpdCB3
b3VsZCBiZSBjbGVhbmVyIHRvIGRvIHRoZSBjaGVjayBvZiB0aGUgcGFja2V0IGNvbnRlbnRzIHRv
DQo+IGlkZW50aWZ5IGluLXBsYWNlLiBUaGF0IHdvdWxkIGJlIHRoZSBiZXN0IHdheSB0byBmaXgv
YXZvaWQgdGhlIGxlYWsuDQo+IA0KPiBTb21lIG90aGVyIHRoaW5ncyBJIG5vdGljZSByZWFkaW5n
IHRoZSBmdW5jdGlvbjoNCj4gDQo+ICgxKSBhZnRlciB0aGUgZmlyc3QgaWYoKSB3ZSB3aWxsIGdv
IGFoZWFkIGFuZCBjaGVjayB0aGUgc2Vjb25kIGlmKCkuDQo+IFRoaXMgbWVhbnMgd2UnbGwgdW5u
ZWNlc3NhcmlseSBjaGVjayB3aGV0aGVyIHRoZSBkYXRhIHN0cmluZyBtYXRjaGVzDQo+IENPTE9f
Q0hFQ0tQT0lOVCwgd2hlbiB3ZSBrbm93IGFscmVhZHkgaXQgY2Fubm90LiBJIHRoaW5rIGFuIGlm
ICghc3RyY21wKC4uLikpDQo+IHsgLi4uIH0gZWxzZSBpZiAoIXN0cmNtcCguLi4pKSB7IC4uLiB9
IHN0cnVjdHVyZSB3b3VsZCBiZSBtb3JlIG5vcm1hbCBDIGhlcmUuDQo+IA0KPiAoMikgdGhlIGdf
bWVtZHVwKCkgY2FsbCBpcyB0cmVhdGluZyB0aGUgZGF0YSBhcyBhIGJ1ZmZlci1hbmQtbGVuZ3Ro
LCBhbmQgd2UNCj4gZG9uJ3QgZW5mb3JjZSB0aGF0IGl0IGlzIE5VTC10ZXJtaW5hdGVkLiBCdXQg
dGhlbiB3ZSBkbyBhDQo+IHN0cmNtcCgpIGFnYWluc3QgaXQsIHdoaWNoIGFzc3VtZXMgdGhhdCB0
aGUgZGF0YSBpcyBhIE5VTC10ZXJtaW5hdGVkIHN0cmluZy4gSXMNCj4gdGhpcyBzYWZlID8NCj4g
DQo+ICgzKSBNb3JlIG1pbm9yIHBvaW50OiB5b3UgY291bGQgbWFyayAnbXNnJyBhcyBjb25zdCBo
ZXJlLCBzaW5jZSBJIHRoaW5rIHdlDQo+IG5ldmVyIG5lZWQgdG8gbW9kaWZ5IGl0Lg0KDQpPSywg
SSB3aWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3
Lg0KDQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=


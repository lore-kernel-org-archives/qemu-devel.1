Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1160BC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC5821882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC5821882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hix9q-0005nq-6s
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 04:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hix8H-0004mk-RI
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hix8G-00031A-9T
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:30:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:42466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hix8F-0002oF-Uv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:30:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jul 2019 01:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; d="scan'208";a="169389112"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga006.jf.intel.com with ESMTP; 04 Jul 2019 01:30:12 -0700
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 01:30:12 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 01:30:12 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.55]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 16:30:10 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [PATCH] net/colo-compare.c: Fix memory leak and code style issue.
Thread-Index: AQHVMUCopfg6F+XrzUC+6h46ZejGq6a4LCCAgAH2WnA=
Date: Thu, 4 Jul 2019 08:30:09 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061B873C@shsmsx102.ccr.corp.intel.com>
References: <20190703013805.2722-1-chen.zhang@intel.com>
 <CAFEAcA-P9_2QfRrSLkPCiuzakhNWjJ+Rn56Rtq99_eKGyp7afw@mail.gmail.com>
In-Reply-To: <CAFEAcA-P9_2QfRrSLkPCiuzakhNWjJ+Rn56Rtq99_eKGyp7afw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTM5ZjZhMDYtOWRiOC00ODEzLThiMGItYTI0ZWE2MjNlNzEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZDQ1a0JZTE9MUGtheGlsUzJHQTNHdlEyY1lqUVRcLzB6eWp0YWF6VGdDQTYxSVA5enR6TEM3Z09jXC9VYUVsZm1kIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCBb
bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5
IDMsIDIwMTkgNjozMSBQTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29t
Pg0KPiBDYzogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsgSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47DQo+IHFlbXUtZGV2IDxxZW11LWRldmVsQG5vbmdudS5v
cmc+OyBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBuZXQvY29sby1jb21wYXJlLmM6IEZpeCBtZW1vcnkgbGVhayBhbmQgY29kZSBzdHlsZSBp
c3N1ZS4NCj4gDQo+IE9uIFdlZCwgMyBKdWwgMjAxOSBhdCAwMjo0MiwgWmhhbmcgQ2hlbiA8Y2hl
bi56aGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogWmhhbmcgQ2hlbiA8Y2hl
bi56aGFuZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBBZGRyZXNzIFBldGVyJ3MgY29tbWVudHMgaW4g
cGF0Y2ggIkNPTE8tY29tcGFyZTpBZGQgY29sby1jb21wYXJlDQo+ID4gcmVtb3RlIG5vdGlmeSBz
dXBwb3J0Ii4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIENoZW4gPGNoZW4uemhhbmdA
aW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQvY29sby1jb21wYXJlLmMgfCAxMyArKysrKyst
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NvbG8tY29tcGFyZS5jIGIvbmV0L2NvbG8t
Y29tcGFyZS5jIGluZGV4DQo+ID4gOTA5ZGQ2YzZlYi4uMzYzYjFlZGQxMSAxMDA2NDQNCj4gPiAt
LS0gYS9uZXQvY29sby1jb21wYXJlLmMNCj4gPiArKysgYi9uZXQvY29sby1jb21wYXJlLmMNCj4g
PiBAQCAtMTAwOCwyMSArMTAwOCwyMCBAQCBzdGF0aWMgdm9pZA0KPiA+IGNvbXBhcmVfbm90aWZ5
X3JzX2ZpbmFsaXplKFNvY2tldFJlYWRTdGF0ZSAqbm90aWZ5X3JzKSAgew0KPiA+ICAgICAgQ29t
cGFyZVN0YXRlICpzID0gY29udGFpbmVyX29mKG5vdGlmeV9ycywgQ29tcGFyZVN0YXRlLA0KPiA+
IG5vdGlmeV9ycyk7DQo+ID4NCj4gPiAtICAgIC8qIEdldCBYZW4gY29sby1mcmFtZSdzIG5vdGlm
eSBhbmQgaGFuZGxlIHRoZSBtZXNzYWdlICovDQo+ID4gLSAgICBjaGFyICpkYXRhID0gZ19tZW1k
dXAobm90aWZ5X3JzLT5idWYsIG5vdGlmeV9ycy0+cGFja2V0X2xlbik7DQo+ID4gLSAgICBjaGFy
IG1zZ1tdID0gIkNPTE9fQ09NUEFSRV9HRVRfWEVOX0lOSVQiOw0KPiA+ICsgICAgY29uc3QgY2hh
ciBtc2dbXSA9ICJDT0xPX0NPTVBBUkVfR0VUX1hFTl9JTklUIjsNCj4gPiAgICAgIGludCByZXQ7
DQo+ID4NCj4gPiAtICAgIGlmICghc3RyY21wKGRhdGEsICJDT0xPX1VTRVJTUEFDRV9QUk9YWV9J
TklUIikpIHsNCj4gPiArICAgIGlmICghc3RyY21wKChjaGFyICopbm90aWZ5X3JzLT5idWYsICJD
T0xPX1VTRVJTUEFDRV9QUk9YWV9JTklUIikpDQo+ID4gKyB7DQo+IA0KPiBUaGlzIGlzIChzdGls
bCkgYXNzdW1pbmcgdGhhdCB0aGUgYnVmZmVyIHlvdSdyZSBwYXNzZWQgaW4gaGFzIGEgTlVMLXRl
cm1pbmF0ZWQNCj4gc3RyaW5nOiBpZiBub3QsIGl0IGNvdWxkIHJ1biBvZmYgdGhlIGVuZCBvZiBp
dC4gV2hhdCB5b3Ugd2FudCB0byBjaGVjayBpczoNCj4gKDEpIGlzIHRoZSBwYWNrZXRfbGVuIGxv
bmcgZW5vdWdoIGZvciB0aGUgc3RyaW5nIHdlJ3JlIGxvb2tpbmcgZm9yIChpbmNsdWRpbmcgdGhl
DQo+IHRlcm1pbmF0aW5nIE5VTCkgYW5kDQo+ICgyKSBpZiBzbywgZG9lcyBhIHNpbXBsZSAiY29t
cGFyZSB0aGVzZSBOIGJ5dGVzIiBjaGVjayBtYXRjaD8NCj4gDQo+IFNvbWV0aGluZyBsaWtlDQo+
IA0KPiBzdGF0aWMgYm9vbCBwYWNrZXRfbWF0Y2hlc19zdHIoY29uc3QgY2hhciAqc3RyLCB1aW50
OF90ICpidWYsIHVpbnQzMl90DQo+IHBhY2tldF9sZW4pDQo+IHsNCj4gICAgIGlmIChwYWNrZXRf
bGVuIDw9IHN0cmxlbihzdHIpKSB7DQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgfQ0K
PiAgICAgcmV0dXJuICFtZW1jbXAoc3RyLCBidWYsIHN0cmxlbihzdHIpICsgMSk7IH0NCj4gDQo+
IG1pZ2h0IGJlIGEgdXNlZnVsIHV0aWxpdHkgZnVuY3Rpb24uIChub3RpY2UgdGhhdCB3ZSBhcmUg
aW5jbHVkaW5nIHRoZSBOVUwgYnl0ZSBpbg0KPiBvdXIgY29tcGFyaXNvbiBjaGVjaykuDQo+IA0K
PiBJbiBnZW5lcmFsIHRoaXMgY29kZSBkb2Vzbid0IHNlZW0gdG8gaGF2ZSBiZWVuIHdyaXR0ZW4g
d2l0aCBhbiBleWUgdG8gdGhlDQo+IHBhY2tldCBjb250ZW50cyBiZWluZyBwb3NzaWJseS1tYWxp
Y2lvdXMuIEZvciBpbnN0YW5jZQ0KPiBjb2xvX2NvbXBhcmVfcGFja2V0X3BheWxvYWQoKSBkb2Vz
bid0IHNlZW0gdG8gY2hlY2sgdGhhdCB0aGUgcGFja2V0cw0KPiBhY3R1YWxseSBhcmUgYm90aCBs
b25nIGVub3VnaCBmb3IgdGhlIGxlbmd0aCBiZWluZyBjb21wYXJlZC4gVGhpcyBjb3VsZA0KPiBw
ZXJoYXBzIGRvIHdpdGggc29tZSByZXZpZXcvYXVkaXQgYnkgc29tZWJvZHkuDQoNCk9LLCBJIHdp
bGwgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCkFib3V0IHRoZSBpc3N1ZXMgb2YgY29sb19jb21w
YXJlX3BhY2tldF9wYXlsb2FkKCksIEkgd2lsbCBzZW5kIGFub3RoZXIgcGF0Y2ggdG8gZml4Lg0K
DQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K


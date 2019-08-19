Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89119C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604C22087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604C22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkdT-0006ws-K3
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hzkZT-0003fo-0x
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hzkZQ-0005WR-Tl
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:31:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:9167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1hzkZQ-0005Tn-Kr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:31:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Aug 2019 09:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; d="scan'208";a="195569427"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 09:20:49 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 19 Aug 2019 09:20:48 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.78]) with mapi id 14.03.0439.000;
 Mon, 19 Aug 2019 09:20:48 -0700
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "stefanha@redhat.com" <stefanha@redhat.com>, "virtio-fs@redhat.com"
 <virtio-fs@redhat.com>
Thread-Topic: [kata-dev] [ANNOUNCE] virtio-fs v0.3 release
Thread-Index: AQHVVqfgcEkS3cKdskecnZZk2Fe4KacDHCaA
Date: Mon, 19 Aug 2019 16:20:48 +0000
Message-ID: <ecce288d13998b03a76226462cf02eb2206ecaa9.camel@intel.com>
References: <20190819160426.GB2625@stefanha-x1.localdomain>
In-Reply-To: <20190819160426.GB2625@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.20.106]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBDB220D8D26FD4585330D95132A12CA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [kata-dev] [ANNOUNCE] virtio-fs v0.3 release
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
 "kata-dev@lists.katacontainers.io" <kata-dev@lists.katacontainers.io>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhdCdzIGdyZWF0IG5ld3MgOikNCg0KU2ViYXN0aWVuDQoNCk9uIE1vbiwgMjAxOS0wOC0xOSBh
dCAxNzowNCArMDEwMCwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBJIGFtIGRlbGlnaHRlZCB0
byBhbm5vdW5jZSB0aGUgcmVsZWFzZSBvZiB2aXJ0aW8tZnMgdjAuMywgYSBzaGFyZWQNCj4gZmls
ZQ0KPiBzeXN0ZW0gdGhhdCBsZXRzIHZpcnR1YWwgbWFjaGluZXMgYWNjZXNzIGEgZGlyZWN0b3J5
IHRyZWUgb24gdGhlDQo+IGhvc3QuDQo+IFRoaXMgcmVsZWFzZSBpcyBiYXNlZCBvbiBRRU1VIDQu
MS4wIGFuZCBMaW51eCA1LjMtcmMzLg0KPiANCj4gRm9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQg
dmlydGlvLWZzOiBodHRwczovL3ZpcnRpby1mcy5naXRsYWIuaW8vDQo+IA0KPiBUaGlzIGlzIGEg
ZGV2ZWxvcG1lbnQgcmVsZWFzZSBhaW1lZCBhdCBlYXJseSBhZG9wdGVycyBvZiB2aXJ0aW8tDQo+
IGZzLiAgV29yayBpcw0KPiBiZWluZyBkb25lIHRvIHVwc3RyZWFtIHRoZSBjb2RlIGludG8gTGlu
dXggYW5kIFFFTVUuICBXZSBleHBlY3QgdG8NCj4gc3RvcA0KPiBwdWJsaXNoaW5nIHZpcnRpby1m
cyByZWxlYXNlcyBvbmNlIHRoZSBjb2RlIGhhcyBiZWVuIG1lcmdlZCBieSB0aGVzZQ0KPiB1cHN0
cmVhbQ0KPiBwcm9qZWN0cy4NCj4gDQo+IFdoZXJlIHRvIGdldCBpdDoNCj4gDQo+ICAgaHR0cHM6
Ly9naXRsYWIuY29tL3ZpcnRpby1mcy9saW51eC8tL3RhZ3MvdmlydGlvLWZzLXYwLjMNCj4gICBo
dHRwczovL2dpdGxhYi5jb20vdmlydGlvLWZzL3FlbXUvLS90YWdzL3ZpcnRpby1mcy12MC4zDQo+
IA0KPiBDaGFuZ2VzOg0KPiANCj4gICogUGxlYXNlIG5vdGUgdGhhdCB0aGUgbW91bnQgc3ludGF4
IGhhcyBjaGFuZ2VkIHRvOg0KPiANCj4gICAgICAjIG1vdW50IC10IHZpcnRpb19mcyBteWZzIC9t
bnQgLW8gLi4uDQo+IA0KPiAgICBUaGUgb2xkIHN5bnRheCB3YXMgIm1vdW50IC10IHZpcnRpb19m
cyBub25lIC9tbnQgLW8gdGFnPW15ZnMsLi4uIi4NCj4gDQo+ICAqIHZpcnRpb2ZzZCAtLWZkPUZE
TlVNIHRha2VzIGEgbGlzdGVuIHNvY2tldCBmaWxlIGRlc2NyaXB0b3INCj4gbnVtYmVyLiAgRmls
ZQ0KPiAgICBkZXNjcmlwdG9yIHBhc3NpbmcgaXMgYW4gYWx0ZXJuYXRpdmUgd2F5IHRvIG1hbmFn
ZSB0aGUgdmhvc3QtdXNlcg0KPiBVTklYDQo+ICAgIGRvbWFpbiBzb2NrZXQuICBUaGUgcGFyZW50
IHByb2Nlc3Mgbm8gbG9uZ2VyIG5lZWRzIHRvIHdhaXQgZm9yDQo+IHZpcnRpb2ZzZCB0bw0KPiAg
ICBjcmVhdGUgdGhlIGxpc3RlbiBzb2NrZXQgYmVmb3JlIHNwYXduaW5nIHRoZSBWTS4NCj4gDQo+
ICAqIHZpcnRpb2ZzZCAtLXN5c2xvZyBsb2dzIHRvIHN5c2xvZygyKSBpbnN0ZWFkIG9mIHN0ZGVy
ci4gIFVzZWZ1bA0KPiBmb3IgdW5pZnlpbmcNCj4gICAgbG9nZ2luZyBhbmQgd2hlbiB0aGUgdmly
dGlvZnNkIHByb2Nlc3MgaXMgbm90IGJlaW5nIHN1cGVydmlzZWQuDQo+IA0KPiAgKiB2aXJ0aW9m
c2QgLS10aHJlYWQtcG9vbC1zaXplPU5VTSBzZXRzIHRoZSBtYXhpbXVtIG51bWJlciBvZiB3b3Jr
ZXINCj4gdGhyZWFkcw0KPiAgICBmb3IgRlVTRSByZXF1ZXN0IHByb2Nlc3NpbmcuICBUaGlzIGNh
biBiZSB1c2VkIHRvIGNvbnRyb2wgdGhlIGhvc3QNCj4gcXVldWUNCj4gICAgZGVwdGguICBUaGUg
ZGVmYXVsdCBpcyA2NC4NCj4gDQo+ICAqIFBlcmZvcm1hbmNlIGltcHJvdmVtZW50cyBhbmQgYnVn
IGZpeGVzLg0KPiANCj4gTm90ZSBmb3IgS2F0YSBDb250YWluZXJzOiB0aGUgbmV3IGtlcm5lbCBp
cyBub3QgY29tcGF0aWJsZSB3aXRoDQo+IGV4aXN0aW5nDQo+IEthdGEgQ29udGFpbmVycyByZWxl
YXNlcyBkdWUgdG8gdGhlIG1vdW50IHN5bnRheCBjaGFuZ2UuICBUbyB0cnkgaXQNCj4gb3V0LA0K
PiBwbGVhc2UgYXBwbHkgdGhlIGZvbGxvd2luZyBrYXRhLXJ1bnRpbWUgcGF0Y2g6DQo+IA0KPiAg
IA0KPiBodHRwczovL2dpdGxhYi5jb20vdmlydGlvLWZzL3J1bnRpbWUvY29tbWl0L2EyZTQ0ZGU4
MTdlNDM4YzAyYTQ5NWNmMjU4MDM5Nzc0NTI3ZTMxNzgNCj4gDQo+IEthdGEgQ29udGFpbmVycyBw
YXRjaGVzIGZvciB2aXJ0aW8tZnMgdjAuMyBhcmUgdW5kZXIgZGV2ZWxvcG1lbnQgYW5kDQo+IHdp
bGwgYmUNCj4gc3VibWl0dGVkIHRvIEthdGEgc29vbi4NCj4gDQo+IFRoYW5rcyB0byB0aGUgZm9s
bG93aW5nIHBlb3BsZSBmb3IgY29udHJpYnV0aW5nIGNvZGUgYW5kIHRvIG1hbnkgbW9yZQ0KPiBm
b3IgaGVscGluZyB0aGUgdmlydGlvLWZzIGVmZm9ydDoNCj4gDQo+IERyLiBEYXZpZCBBbGFuIEdp
bGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+DQo+IEVyaWMgUmVuIDxyZW56aGVuQGxpbnV4LmFs
aWJhYmEuY29tPg0KPiBFcnl1IEd1YW4gPGVndWFuQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBHYW5l
c2ggTWFoYXJhaiBNYWhhbGluZ2FtIDxnYW5lc2gubWFoYWxpbmdhbUBpbnRlbC5jb20+DQo+IEpp
dWZlaSBYdWUgPGppdWZlaS54dWVAbGludXguYWxpYmFiYS5jb20+DQo+IExpdSBCbyA8Ym8ubGl1
QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBNYXNheW9zaGkgTWl6dW1hIDxtLm1penVtYUBqcC5mdWpp
dHN1LmNvbT4NCj4gTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+DQo+IFBlbmcg
VGFvIDx0YW8ucGVuZ0BsaW51eC5hbGliYWJhLmNvbT4NCj4gcGlhb2p1biA8cGlhb2p1bkBodWF3
ZWkuY29tPg0KPiBTZWJhc3RpZW4gQm9ldWYgPHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20+DQo+
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gVml2ZWsgR295YWwgPHZn
b3lhbEByZWRoYXQuY29tPg0KPiBYaWFvZ3VhbmcgV2FuZyA8eGlhb2d1YW5nLndhbmdAbGludXgu
YWxpYmFiYS5jb20+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQo+IGthdGEtZGV2IG1haWxpbmcgbGlzdA0KPiBrYXRhLWRldkBsaXN0cy5rYXRhY29u
dGFpbmVycy5pbw0KPiBodHRwOi8vbGlzdHMua2F0YWNvbnRhaW5lcnMuaW8vY2dpLWJpbi9tYWls
bWFuL2xpc3RpbmZvL2thdGEtZGV2DQo=


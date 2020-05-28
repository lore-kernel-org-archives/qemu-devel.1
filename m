Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF066C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35BA2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35BA2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeLOm-0002Xe-Qh
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeLNq-0001Lu-L2
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:27:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:2048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeLNo-0006gz-Kf
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:27:53 -0400
IronPort-SDR: XNo47YTm4liUEHfNfIXk9IdXKtZo81BeslbSAob3ci4/yNpaV5ArWP30lnjKjZzu5kPZFmgEuF
 qQLbZ9Vm2WNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 09:27:48 -0700
IronPort-SDR: z9OJXQjTLI9icFJfY1IsLd3xhobvDOTST6AlEx3gbf5zpaj+u+GfuO19C4ehNoXxQD+px56nVV
 VXQEu0E/ys9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; d="scan'208";a="414655528"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by orsmga004.jf.intel.com with ESMTP; 28 May 2020 09:27:48 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 09:27:47 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.205]) with mapi id 14.03.0439.000;
 Thu, 28 May 2020 09:27:47 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Thread-Topic: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Thread-Index: AQHWHPxgprv/zXvgEUuLq6cJexZCW6izQRuAgAoXyoCAAJuUgIAAYL0A
Date: Thu, 28 May 2020 16:27:47 +0000
Message-ID: <df4f00e877ff993512bbd5204541b44b20fdc9f4.camel@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
 <20200428012810.10877-3-vishal.l.verma@intel.com>
 <20200521171657.778f20a4@redhat.com>
 <b91f0709d2a425e39d8ecaff5824c022dc893ee6.camel@intel.com>
 <20200528124131.19cc986e@redhat.com>
In-Reply-To: <20200528124131.19cc986e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <61D406DD8DA18040A003E07893773AD6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=vishal.l.verma@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 12:27:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDEyOjQxICswMjAwLCBJZ29yIE1hbW1lZG92IHdyb3RlOg0K
PiBPbiBUaHUsIDI4IE1heSAyMDIwIDAxOjI0OjQyICswMDAwDQo+ICJWZXJtYSwgVmlzaGFsIEwi
IDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0wNS0y
MSBhdCAxNzoxNiArMDIwMCwgSWdvciBNYW1tZWRvdiB3cm90ZToNCj4gPiANClsuLl0NCj4gPiA+
IA0KPiA+ID4gVGhlcmUgaXMgQVJNIHZlcnNpb24gb2YgYnVpbGRfc3JhdCgpLA0KPiA+ID4gSSBz
dWdnZXN0IHRvIHB1dCB0aGlzIE5WRElNTSBzcGVjaWZpYyBwYXJ0IGluIGhlbHBlciBmdW5jdGlv
biB3aXRoaW4gaHcvYWNwaS9udmRpbW0uYw0KPiA+ID4gYW5kIHVzZSBpdCBmcm9tIGJvdGggYnVp
bGRfc3JhdCgpIGZ1bmN0aW9ucy4gIA0KPiA+IA0KPiA+IFNwbGl0dGluZyB0aGUgd29yayBvdXQg
aW50byBhIGhlbHBlciBmdW5jdGlvbiBpbiBudmRpbW0uYyBkb2VzIG1ha2UNCj4gPiBzZW5zZSwg
YW5kIEkndmUgZG9uZSB0aGF0LiBIb3dldmVyLCBsb29raW5nIGF0IHRoZSBhcm0gdmVyc2lvbiBv
Zg0KPiA+IGJ1aWxkX3NyYXQgYW5kIGdlbmVyYWxseSBpbiB2aXJ0LWFjcGktYnVpbGQuYywgSSBk
b24ndCBzZWUgYW55IE5WRElNTQ0KPiA+IHN1cHBvcnQsIHNvIHVubGVzcyBJJ20gbWlzdGFrZW4s
IGl0IHdvdWxkbid0IG1ha2Ugc2Vuc2UgdG8gYWN0dWFsbHkgY2FsbA0KPiA+IHRoaXMgZnJvbSB0
aGUgYXJtIHZlcnNpb24gb2YgYnVpbGRfc3JhdC4NCj4gDQo+IHBlcmhhcHMgeW91IGFyZSBsb29r
aW4gaW50byBvbGQgdmVyc2lvbiBvbiBRRU1VDQo+IGN1cnJlbnQgSEVBRCBoYXMgZm9sbG93aW4g
c25pcHBldDoNCj4gDQo+IHZpcnQtYWNwaS1idWlsZC5jOg0KPiAgICAgaWYgKG1zLT5udmRpbW1z
X3N0YXRlLT5pc19lbmFibGVkKSB7DQo+ICAgICAgICAgbnZkaW1tX2J1aWxkX2FjcGkodGFibGVf
b2Zmc2V0cywgdGFibGVzX2Jsb2IsIHRhYmxlcy0+bGlua2VyLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1zLT5udmRpbW1zX3N0YXRlLCBtcy0+cmFtX3Nsb3RzKTsNCj4gICAgIH0NCj4g
IA0KU29ycnksIEkganVtcGVkIHRoZSBndW4gb24gc2VuZGluZyB2MyBhbmQgZGlkbid0IHNlZSB0
aGlzIGVtYWlsIHVudGlsDQphZnRlciBzZW5kaW5nIGl0LiBZb3UncmUgcmlnaHQsIEkgdGhpbmsg
SSB3YXMgb24gYW4gb2xkZXIgdmVyc2lvbg0KYmVmb3JlLiBJJ3ZlIGFkZGVkIHRoZSBudmRpbW0g
Yml0IHRvIGJ1aWxkX3NyYXQgaGVyZSBhbmQgZ29pbmcgdG8gcnVuDQp0aHJvdWdoIHRoZSB0ZXN0
cy4gSWYgZXZlcnl0aGluZyBsb29rcyBvayBJJ2xsIHNlbmQgYSB2NC4NCg==


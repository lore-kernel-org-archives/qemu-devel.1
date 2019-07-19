Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E7EC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39703208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 01:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39703208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoI7C-0004kR-6X
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 21:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59777)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hoI6y-000490-12
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hoI6w-0002Pn-US
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:55:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:30338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hoI6w-0002NK-Le
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 21:55:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jul 2019 18:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,280,1559545200"; d="scan'208";a="319831734"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga004.jf.intel.com with ESMTP; 18 Jul 2019 18:54:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jul 2019 18:54:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 18 Jul 2019 18:54:57 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Jul 2019 18:54:56 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.162]) with mapi id 14.03.0439.000;
 Fri, 19 Jul 2019 09:54:55 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [PATCH V3] net/colo-compare.c: Fix memory leak and code style
 issue.
Thread-Index: AQHVPUsLqGBEGDJMrk2Ek2iZfotKjqbP3HSAgAFRaVA=
Date: Fri, 19 Jul 2019 01:54:55 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061D0413@shsmsx102.ccr.corp.intel.com>
References: <20190718092219.20081-1-chen.zhang@intel.com>
 <CAFEAcA-HK_aSynZ2bEvg1W64L3U7amuDRLGr+8DVqcGujiOkgg@mail.gmail.com>
In-Reply-To: <CAFEAcA-HK_aSynZ2bEvg1W64L3U7amuDRLGr+8DVqcGujiOkgg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjBjYjQzYzgtMDNiMC00OWU4LWE5YTEtYzhkOGRmYjU1Njc1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicFRTS29aODg0YkJOandjSk93U2FBMWlUejltWTZEekF6ZVc2VzJwVGg2N1lBWnI2dWFmNW9vd0lsMG1aSFNoRyJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH V3] net/colo-compare.c: Fix memory leak and
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldGVyIE1heWRlbGwgW21h
aWx0bzpwZXRlci5tYXlkZWxsQGxpbmFyby5vcmddDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE4
LCAyMDE5IDk6NDIgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4N
Cj4gQ2M6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Ow0KPiBxZW11LWRldiA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PjsgWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWM10gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5IGxlYWsgYW5kIGNvZGUgc3R5bGUN
Cj4gaXNzdWUuDQo+IA0KPiBPbiBUaHUsIDE4IEp1bCAyMDE5IGF0IDEwOjI3LCBaaGFuZyBDaGVu
IDxjaGVuLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBaaGFuZyBDaGVu
IDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdG8gZml4IHRoZSBv
cmlnaW4gImNoYXIgKmRhdGEiIG1lbm9yeSBsZWFrLCBjb2RlIHN0eWxlDQo+ID4gaXNzdWUgYW5k
IGFkZCBuZWNlc3NhcnkgY2hlY2sgaGVyZS4NCj4gPiBSZXBvcnRlZC1ieTogQ292ZXJpdHkgKENJ
RCAxNDAyNzg1KQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFu
Z0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9jb2xvLWNvbXBhcmUuYyB8IDI4ICsrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NvbG8tY29t
cGFyZS5jIGIvbmV0L2NvbG8tY29tcGFyZS5jIGluZGV4DQo+ID4gOTA5ZGQ2YzZlYi4uZmNjY2I0
YzZmNiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvY29sby1jb21wYXJlLmMNCj4gPiArKysgYi9uZXQv
Y29sby1jb21wYXJlLmMNCj4gPiBAQCAtMTI3LDYgKzEyNywxNyBAQCBzdGF0aWMgaW50IGNvbXBh
cmVfY2hyX3NlbmQoQ29tcGFyZVN0YXRlICpzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3Qgdm5ldF9oZHJfbGVuLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBub3RpZnlfcmVtb3RlX2ZyYW1lKTsNCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBw
YWNrZXRfbWF0Y2hlc19zdHIoY29uc3QgY2hhciAqc3RyLA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDhfdCAqYnVmLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgcGFja2V0X2xlbikgew0KPiA+ICsgICAgaWYgKHBhY2tldF9sZW4g
IT0gc3RybGVuKHN0cikpIHsNCj4gDQo+IElzICchPScgZGVmaW5pdGVseSBjb3JyZWN0PyAoaWUg
dGhlIGluY29taW5nIHBhY2tldCBtdXN0DQo+ICpub3QqIGNvbnRhaW4gYSB0cmFpbGluZyAnXDAn
IG9yIGFueSBvdGhlciB0cmFpbGluZyBkYXRhKSA/DQoNClllcywgdGhlIHBhY2tldCBub3QgY29u
dGFpbiBhIHRyYWlsLg0KQXMgSmFzb24gY29tbWVudHMgYmVmb3JlLCB5b3UgY2FuIHNlZSB0aGUg
bmV0L25ldC5jICAibmV0X2ZpbGxfcnN0YXRlKCkiLg0KV2UganVzdCBnb3QgdGhlIGxlbmd0aCBh
bmQgZGF0YS4NCg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoNCj4gDQo+IElzIHRoZXJlIGEgc3BlY2lm
aWNhdGlvbiBvZiB0aGUgcHJvdG9jb2wgc29tZXdoZXJlPyBJZiBzbywgdGhhdCBwcmVzdW1hYmx5
DQo+IHNob3VsZCBzYXkgb25lIHdheSBvciB0aGUgb3RoZXIuDQo+IA0KPiA+ICsgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICByZXR1cm4gIW1lbWNtcChz
dHIsIGJ1Ziwgc3RybGVuKHN0cikpOyB9DQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=


Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B470C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7956521955
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 18:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7956521955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpdDK-0006Po-HO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 14:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hpdD9-00061O-J3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hpdD8-0000Yq-JM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:38:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:60646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hpdD8-0000Wm-BY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 14:38:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2019 11:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,296,1559545200"; d="scan'208";a="163255112"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga008.jf.intel.com with ESMTP; 22 Jul 2019 11:38:54 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 11:38:53 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 11:38:53 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.110]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 02:38:51 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [PATCH V5] net/colo-compare.c: Fix memory leak and code style
 issue.
Thread-Index: AQHVQLJBW57R7XLKhU2qIxRloMr28KbWXTyAgACY8UA=
Date: Mon, 22 Jul 2019 18:38:51 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061D67D3@shsmsx102.ccr.corp.intel.com>
References: <20190722171828.11322-1-chen.zhang@intel.com>
 <CAFEAcA8==zAupCx=3sZt2tNUQH4OKza7FGhkwuCyxHpguTMGTA@mail.gmail.com>
In-Reply-To: <CAFEAcA8==zAupCx=3sZt2tNUQH4OKza7FGhkwuCyxHpguTMGTA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzA0MzAzZWUtZTVmZS00NDIwLWI0MWEtYmExZjcxNjVmZTkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZlJiOVdHVlo3elozeUxBczAyYnNZQ3pCZmNreVRFYkpcLzR4NGZETjByYzlCOUJyWDA3NTBaXC9PSXplREhiNUtpIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH V5] net/colo-compare.c: Fix memory leak and
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

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxs
IFttYWlsdG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBKdWx5
IDIzLCAyMDE5IDE6MjUgQU0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNv
bT4NCj4gQ2M6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+Ow0KPiBxZW11LWRldiA8cWVtdS1kZXZlbEBub25nbnUu
b3JnPjsgWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCBWNV0gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5IGxlYWsgYW5kIGNvZGUgc3R5
bGUNCj4gaXNzdWUuDQo+IA0KPiBPbiBNb24sIDIyIEp1bCAyMDE5IGF0IDE4OjIzLCBaaGFuZyBD
aGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBaaGFuZyBD
aGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdG8gZml4IHRo
ZSBvcmlnaW4gImNoYXIgKmRhdGEiIG1lbW9yeSBsZWFrLCBjb2RlIHN0eWxlDQo+ID4gaXNzdWUg
YW5kIGFkZCBuZWNlc3NhcnkgY2hlY2sgaGVyZS4NCj4gPiBSZXBvcnRlZC1ieTogQ292ZXJpdHkg
KENJRCAxNDAyNzg1KQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56
aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9jb2xvLWNvbXBhcmUuYyB8IDI3ICsr
KysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IFJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxs
IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0aWVu
Y2UgaW4gc2VuZGluZyBvdXQgYWxsIHRoZXNlIHZlcnNpb25zIGFzIHdlIHdvcmtlZA0KPiB0aHJv
dWdoIHRoZSBjb2RlIHJldmlldyBwcm9jZXNzLg0KDQpUaGFuayB5b3UgdG9vfg0KTWF5YmUgeW91
IG9yIEphc29uIGNhbiBwaWNrIHVwIHRoaXMgcGF0Y2g/DQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0K
DQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=


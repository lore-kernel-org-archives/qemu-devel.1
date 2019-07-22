Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6247DC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE422190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE422190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbu3-0001Ya-B1
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hpbtq-00014l-2n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hpbtp-0004gH-0s
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:14:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:23367)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hpbto-0004fO-Oy
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:14:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2019 10:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; d="scan'208";a="170920167"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2019 10:14:52 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 10:14:52 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 22 Jul 2019 10:14:51 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.110]) with mapi id 14.03.0439.000;
 Tue, 23 Jul 2019 01:14:50 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [PATCH V4] net/colo-compare.c: Fix memory leak and code style
 issue.
Thread-Index: AQHVP6M+bpjqmBI/iECJO/qLnFHpn6bWGroAgADHadA=
Date: Mon, 22 Jul 2019 17:14:49 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061D645F@shsmsx102.ccr.corp.intel.com>
References: <20190721085854.12026-1-chen.zhang@intel.com>
 <CAFEAcA9UF716KmhsbO+p8TFTiC2+MwCFYK99ZvrNWddkxioqeA@mail.gmail.com>
In-Reply-To: <CAFEAcA9UF716KmhsbO+p8TFTiC2+MwCFYK99ZvrNWddkxioqeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzA1MGJhY2YtNWJmYy00ZTE3LWFkOTEtNjBiMzllNjVhOTJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQzIrNVlFU2tcL1doSDBNcmhqbW5aNUlqTk1sb0crZmdvaE9kRFFYaEpRYWFkaWlTcXROZk9kS3hWeXhmK1A0WlIifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH V4] net/colo-compare.c: Fix memory leak and
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
bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogTW9uZGF5LCBKdWx5IDIy
LCAyMDE5IDk6MTkgUE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4N
Cj4gQ2M6IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Ow0KPiBxZW11LWRldiA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PjsgWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWNF0gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5IGxlYWsgYW5kIGNvZGUgc3R5bGUN
Cj4gaXNzdWUuDQo+IA0KPiBPbiBTdW4sIDIxIEp1bCAyMDE5IGF0IDEwOjA0LCBaaGFuZyBDaGVu
IDxjaGVuLnpoYW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBaaGFuZyBDaGVu
IDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdG8gZml4IHRoZSBv
cmlnaW4gImNoYXIgKmRhdGEiIG1lbW9yeSBsZWFrLCBjb2RlIHN0eWxlDQo+ID4gaXNzdWUgYW5k
IGFkZCBuZWNlc3NhcnkgY2hlY2sgaGVyZS4NCj4gPiBSZXBvcnRlZC1ieTogQ292ZXJpdHkgKENJ
RCAxNDAyNzg1KQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFu
Z0BpbnRlbC5jb20+DQo+IA0KPiA+IEBAIC0xMDA4LDIxICsxMDE5LDI0IEBAIHN0YXRpYyB2b2lk
DQo+ID4gY29tcGFyZV9ub3RpZnlfcnNfZmluYWxpemUoU29ja2V0UmVhZFN0YXRlICpub3RpZnlf
cnMpICB7DQo+ID4gICAgICBDb21wYXJlU3RhdGUgKnMgPSBjb250YWluZXJfb2Yobm90aWZ5X3Jz
LCBDb21wYXJlU3RhdGUsDQo+ID4gbm90aWZ5X3JzKTsNCj4gPg0KPiA+IC0gICAgLyogR2V0IFhl
biBjb2xvLWZyYW1lJ3Mgbm90aWZ5IGFuZCBoYW5kbGUgdGhlIG1lc3NhZ2UgKi8NCj4gPiAtICAg
IGNoYXIgKmRhdGEgPSBnX21lbWR1cChub3RpZnlfcnMtPmJ1Ziwgbm90aWZ5X3JzLT5wYWNrZXRf
bGVuKTsNCj4gPiAtICAgIGNoYXIgbXNnW10gPSAiQ09MT19DT01QQVJFX0dFVF9YRU5fSU5JVCI7
DQo+ID4gKyAgICBjb25zdCBjaGFyIG1zZ1tdID0gIkNPTE9fQ09NUEFSRV9HRVRfWEVOX0lOSVQi
Ow0KPiA+ICAgICAgaW50IHJldDsNCj4gPg0KPiA+IC0gICAgaWYgKCFzdHJjbXAoZGF0YSwgIkNP
TE9fVVNFUlNQQUNFX1BST1hZX0lOSVQiKSkgew0KPiA+ICsgICAgaWYgKHBhY2tldF9tYXRjaGVz
X3N0cigiQ09MT19VU0VSU1BBQ0VfUFJPWFlfSU5JVCIsDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG5vdGlmeV9ycy0+YnVmLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICBub3RpZnlfcnMtPnBhY2tldF9sZW4pKSB7DQo+ID4gICAgICAgICAgcmV0ID0gY29tcGFyZV9j
aHJfc2VuZChzLCAodWludDhfdCAqKW1zZywgc3RybGVuKG1zZyksIDAsIHRydWUpOw0KPiA+ICAg
ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiTm90
aWZ5IFhlbiBDT0xPLWZyYW1lIElOSVQgZmFpbGVkIik7DQo+ID4gICAgICAgICAgfQ0KPiA+IC0g
ICAgfQ0KPiA+IC0NCj4gPiAtICAgIGlmICghc3RyY21wKGRhdGEsICJDT0xPX0NIRUNLUE9JTlQi
KSkgew0KPiA+ICsgICAgfSBlbHNlIGlmIChwYWNrZXRfbWF0Y2hlc19zdHIoIkNPTE9fQ0hFQ0tQ
T0lOVCIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBub3RpZnlfcnMt
PmJ1ZiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vdGlmeV9ycy0+
cGFja2V0X2xlbikpIHsNCj4gPiAgICAgICAgICAvKiBjb2xvLWNvbXBhcmUgZG8gY2hlY2twb2lu
dCwgZmx1c2ggcHJpIHBhY2tldCBhbmQgcmVtb3ZlIHNlYyBwYWNrZXQNCj4gKi8NCj4gPiAgICAg
ICAgICBnX3F1ZXVlX2ZvcmVhY2goJnMtPmNvbm5fbGlzdCwgY29sb19mbHVzaF9wYWNrZXRzLCBz
KTsNCj4gPiArICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJDT0xPIGNv
bXBhcmUgZ290IHVuc3VwcG9ydGVkIGluc3RydWN0aW9uICclcyciLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAoY2hhciAqKW5vdGlmeV9ycy0+YnVmKTsNCj4gPiAgICAgIH0NCj4gDQo+IFRo
ZSBub3RpZnlfcnMtPmJ1ZiBpcyBub3QgTlVMLXRlcm1pbmF0ZWQsIHNvIHlvdSBjYW4ndCB1c2Ug
aXQgaW4gYSAlcyBmb3JtYXQNCj4gc3RyaW5nIGxpa2UgdGhpcy4gVGhlIHNpbXBsZXN0IGZpeCBp
cyBqdXN0IHRvIG5vdCB0cnkgdG8gcHJpbnQgdGhlIGNvbnRlbnRzIG9mIHRoZQ0KPiBpbmNvbWlu
ZyBwYWNrZXQgYXQgYWxsLg0KPiANCj4gVGhlIHJlc3Qgb2YgdGhlIHBhdGNoIGxvb2tzIGdvb2Qu
DQoNClRoYW5rcyBmb3IgcmVtaW5kaW5nLiBJIHdpbGwgcmVtb3ZlIGl0IGluIG5leHQgdmVyc2lv
bi4NCg0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K


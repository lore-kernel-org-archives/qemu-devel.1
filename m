Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17505C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9662223E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9662223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKyez-0008Q2-Kk
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 02:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKycl-0007AU-Rf
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:51:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:16010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKycg-0001Lj-4R
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:51:31 -0400
IronPort-SDR: fzp8Fanza+jexPArNH+g6Tsf+rfy0GMSZ9EOOcCaT/jkoaeea+uCTNmRzQn7QsQ1vW4OdoaOMW
 Js3lro/QQgsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224947612"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="224947612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 23:51:21 -0700
IronPort-SDR: Ls0PoQxW2Pb45CRLyKT5zPwPNy3JHKkptlYyBPveUA+K4vA35Ycx9E4E5uMxg7xtz4hgN9MtSg
 DouHl5k9teZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="290688539"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2020 23:51:21 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 23:51:21 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 14:51:19 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 14:51:19 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: RE: [PATCH 1/3] colo-compare: return -1 if no packet is queued
Thread-Topic: [PATCH 1/3] colo-compare: return -1 if no packet is queued
Thread-Index: AQHWkMaM/VdgRrmbx02bMbjfHxwoLal1cpbA///IOACAAI7ykA==
Date: Wed, 23 Sep 2020 06:51:19 +0000
Message-ID: <d492e76280f24f508fa844d1c8e99b43@intel.com>
References: <20200922095525.4081603-1-lizhijian@cn.fujitsu.com>
 <20200922095525.4081603-2-lizhijian@cn.fujitsu.com>
 <e1841d5119ff4d82ad01586d08ea45ec@intel.com>
 <5019ad5f-439e-ff9e-f67e-41e2ea76b615@cn.fujitsu.com>
In-Reply-To: <5019ad5f-439e-ff9e-f67e-41e2ea76b615@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=chen.zhang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 02:51:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWmhpamlhbiA8bGl6
aGlqaWFuQGNuLmZ1aml0c3UuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMywg
MjAyMCAyOjE4IFBNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBq
YXNvd2FuZ0ByZWRoYXQuY29tDQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzNdIGNvbG8tY29tcGFyZTogcmV0dXJuIC0xIGlmIG5vIHBhY2tldCBp
cyBxdWV1ZWQNCj4gDQo+IA0KPiANCj4gT24gOS8yMy8yMCA5OjQxIEFNLCBaaGFuZywgQ2hlbiB3
cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXks
IFNlcHRlbWJlciAyMiwgMjAyMCA1OjU1IFBNDQo+ID4+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56
aGFuZ0BpbnRlbC5jb20+OyBqYXNvd2FuZ0ByZWRoYXQuY29tDQo+ID4+IENjOiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4gPj4g
U3ViamVjdDogW1BBVENIIDEvM10gY29sby1jb21wYXJlOiByZXR1cm4gLTEgaWYgbm8gcGFja2V0
IGlzIHF1ZXVlZA0KPiA+Pg0KPiA+PiBSZXR1cm4gMCB3aWxsIHRyaWdnZXIgYSBwYWNrZXQgY29t
cGFyaXNvbg0KPiA+Pg0KPiA+IFllcywgd2UgbmVlZCBhY3RpdmUgdHJpZ2dlciBhIGNoZWNrcG9p
bnQgdG8gZmx1c2ggYWxsIHRoZSBxdWV1ZWQgcGFja2V0cw0KPiBoZXJlLg0KPiBQcmV2aW91c2x5
LCBubyBuZXcgY2hlY2twb2ludCB3aWxsIGJlIHRyaWdnZXJlZCBzaW5jZSBubyBuZXcgcGFja2V0
IGlzDQo+IHF1ZXVlZCB0aG91Z2ggY29sb19jb21wYXJlX2Nvbm5lY3Rpb24oKSBpcyBjYWxsZWQu
DQo+IGFjdHVhbGx5IHdlIHNob3VsZCBzZW5kIGEgbm90aWZ5IHRvIGNvbG8gZnJhbWUgaW1tZWRp
YXRlbHksIG5vIG5lZWQgdG8NCj4gY29tcGFyZSB0aGVtIGFueSBtb3JlIGluIG9yZGVyIHRvIGxl
c3MgbGF0ZW5jeS4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LiBXZSBjYW4gY2hhbmdlIHRoaXMgcGF0
Y2ggdG8gZGlyZWN0bHkgc2VuZCBub3RpZnkgaGVyZS4NCg0KVGhhbmtzDQpaaGFuZyBDaGVuDQoN
Cj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9uZXQvY29sby1jb21wYXJl
LmMgaW5kZXgNCj4gM2E0NWQ2NDE3NS4uMjMwOTJlNDQ5NiAxMDA2NDQNCj4gLS0tIGEvbmV0L2Nv
bG8tY29tcGFyZS5jDQo+ICsrKyBiL25ldC9jb2xvLWNvbXBhcmUuYw0KPiBAQCAtMjg1LDEwICsy
ODUsMTMgQEAgc3RhdGljIGludCBwYWNrZXRfZW5xdWV1ZShDb21wYXJlU3RhdGUgKnMsIGludA0K
PiBtb2RlLCBDb25uZWN0aW9uICoqY29uKQ0KPiAgwqDCoMKgwqAgfQ0KPiANCj4gIMKgwqDCoMKg
IGlmICghcmV0KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCAvKiBxdWV1ZSBpcyB0b28gbG9uZywgZG8g
YSBjaGVja3BvaW50IHRvIHJlbGVhc2UgYWxsIHF1ZXVlZA0KPiArcGFja2V0cyAqLw0KPiArwqDC
oMKgwqDCoMKgwqAgY29sb19jb21wYXJlX2luY29uc2lzdGVuY3lfbm90aWZ5KHMpOw0KPiAgwqDC
oMKgwqDCoMKgwqDCoCB0cmFjZV9jb2xvX2NvbXBhcmVfZHJvcF9wYWNrZXQoY29sb19tb2RlW21v
ZGVdLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJxdWV1ZSBzaXplIHRvbyBiaWcsIGRy
b3AgcGFja2V0Iik7DQo+ICDCoMKgwqDCoMKgwqDCoMKgIHBhY2tldF9kZXN0cm95KHBrdCwgTlVM
TCk7DQo+ICDCoMKgwqDCoMKgwqDCoMKgIHBrdCA9IE5VTEw7DQo+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLTE7DQo+ICDCoMKgwqDCoCB9DQo+IA0KPiAgwqDCoMKgwqAgKmNvbiA9IGNvbm47DQo+
IA0KPiANCj4gPiBPdGhlcndpc2UsIHdlIHNob3VsZCBkcm9wIGFsbCB0aGUgcGFja2V0IGFmdGVy
IHRoaXMgdGltZSBzdGlsbCBuZXh0DQo+IGNoZWNrcG9pbnQuDQo+ID4gU28sIEkgdGhpbmsgb3Jp
Z2luYWwgbG9naWMgaXMgYSBiZXR0ZXIgY2hvaWNlLg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gWmhh
bmcgQ2hlbg0KPiA+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBj
bi5mdWppdHN1LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgbmV0L2NvbG8tY29tcGFyZS5jIHwgMSAr
DQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9uZXQvY29sby1jb21wYXJlLmMgaW5kZXgNCj4g
Pj4gM2E0NWQ2NDE3NS4uMDM5YjUxNTYxMSAxMDA2NDQNCj4gPj4gLS0tIGEvbmV0L2NvbG8tY29t
cGFyZS5jDQo+ID4+ICsrKyBiL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+PiBAQCAtMjg5LDYgKzI4
OSw3IEBAIHN0YXRpYyBpbnQgcGFja2V0X2VucXVldWUoQ29tcGFyZVN0YXRlICpzLCBpbnQNCj4g
Pj4gbW9kZSwgQ29ubmVjdGlvbiAqKmNvbikNCj4gPj4gICAgICAgICAgICAgICAicXVldWUgc2l6
ZSB0b28gYmlnLCBkcm9wIHBhY2tldCIpOw0KPiA+PiAgICAgICAgICAgcGFja2V0X2Rlc3Ryb3ko
cGt0LCBOVUxMKTsNCj4gPj4gICAgICAgICAgIHBrdCA9IE5VTEw7DQo+ID4+ICsgICAgICAgIHJl
dHVybiAtMTsNCj4gPj4gICAgICAgfQ0KPiA+Pg0KPiA+PiAgICAgICAqY29uID0gY29ubjsNCj4g
Pj4gLS0NCj4gPj4gMi4yOC4wDQo+ID4+DQo+ID4+DQo+ID4NCj4gPg0KPiANCj4gDQoNCg==


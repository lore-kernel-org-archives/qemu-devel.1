Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB12C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945A420693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 07:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945A420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7Pe-0003v3-BA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hl7N7-0002uj-1t
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hl7N5-0006yH-Sc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:50:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:21366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hl7N5-0006o6-Ix
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 03:50:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 00:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; d="scan'208";a="192960752"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2019 00:50:30 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 00:50:30 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 00:50:30 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.3]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.55]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 15:50:28 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-dev <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH V2] net/colo-compare.c: Fix memory leak
 and code style issue.
Thread-Index: AQHVMkRVre1oFuzpr0u+Ffrjw6TuIabCueOAgADCIXA=
Date: Wed, 10 Jul 2019 07:50:27 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78061C2546@shsmsx102.ccr.corp.intel.com>
References: <20190704083647.30614-1-chen.zhang@intel.com>
 <ad2627e3-8198-42f2-a89d-8e6a5596ef20@redhat.com>
In-Reply-To: <ad2627e3-8198-42f2-a89d-8e6a5596ef20@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWViMWVhMGItOTI5ZC00ODhiLTk3NzAtZjM2NWFlZTc1Y2I2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieEUzZVNzU1wveHpZZjNmTHpKZGNBcFN2TVZkR01vbVo2RFcwekJyMUlhNjd2bHFtcVBYZ2RlRjhQZ254ZW9Sb0QifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH V2] net/colo-compare.c: Fix memory leak and
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgOSwgMjAxOSAx
MDo0OCBQTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPjsNCj4gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPjsgcWVtdS1kZXYgPHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+
DQo+IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1FlbXUtZGV2ZWxdIFtQQVRDSCBWMl0gbmV0L2NvbG8tY29tcGFyZS5jOiBGaXggbWVtb3J5IGxl
YWsNCj4gYW5kIGNvZGUgc3R5bGUgaXNzdWUuDQo+IA0KPiANCj4gT24gMjAxOS83LzQg5LiL5Y2I
NDozNiwgWmhhbmcgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5n
QGludGVsLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdG8gZml4IHRoZSBvcmlnaW4gImNoYXIg
KmRhdGEiIG1lbm9yeSBsZWFrLCBjb2RlIHN0eWxlDQo+ID4gaXNzdWUgYW5kIGFkZCBuZWNlc3Nh
cnkgY2hlY2sgaGVyZS4NCj4gPiBSZXBvcnRlZC1ieTogQ292ZXJpdHkgKENJRCAxNDAyNzg1KQ0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+
DQo+ID4gLS0tDQo+ID4gICBuZXQvY29sby1jb21wYXJlLmMgfCAyOCArKysrKysrKysrKysrKysr
KysrKystLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9u
ZXQvY29sby1jb21wYXJlLmMgaW5kZXgNCj4gPiA5MDlkZDZjNmViLi5lZDM0OWY1ZjZhIDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9jb2xvLWNvbXBhcmUuYw0KPiA+ICsrKyBiL25ldC9jb2xvLWNvbXBh
cmUuYw0KPiA+IEBAIC0xMjcsNiArMTI3LDE3IEBAIHN0YXRpYyBpbnQgY29tcGFyZV9jaHJfc2Vu
ZChDb21wYXJlU3RhdGUgKnMsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDMyX3Qgdm5ldF9oZHJfbGVuLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgbm90aWZ5X3JlbW90ZV9mcmFtZSk7DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgcGFja2V0X21h
dGNoZXNfc3RyKGNvbnN0IGNoYXIgKnN0ciwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ4X3QgKmJ1ZiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVpbnQzMl90IHBhY2tldF9sZW4pIHsNCj4gPiArICAgIGlmIChwYWNrZXRfbGVuIDw9IHN0cmxl
bihzdHIpKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiArICAgIHJldHVybiAhbWVtY21wKHN0ciwgYnVmLCBzdHJsZW4oc3RyKSArIDEpOw0KPiAN
Cj4gDQo+IFRoaXMgYXNzdW1lcyBidWYgaXMgTlVMTCB0ZXJtaW5hdGVkICh5b3UgcGFzcyBub3Rp
ZnlfcnMtPmJ1Zikgd2hpY2ggaXMgbm90DQo+IGNvcnJlY3QgSSB0aGluaz8NCg0KWWVzLCB5b3Ug
YXJlIHJpZ2h0Lg0KSG93IGFib3V0IHRoaXM6DQoNCnN0YXRpYyBib29sIHBhY2tldF9tYXRjaGVz
X3N0cihjb25zdCBjaGFyICpzdHIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDhfdCAqYnVmLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhY2tl
dF9sZW4pIHsNCiAgICBpZiAocGFja2V0X2xlbiAhPSBzdHJsZW4oc3RyKSB8fCAhYnVmKSB7DQog
ICAgICAgIHJldHVybiBmYWxzZTsNCiAgICB9DQoNCiAgICByZXR1cm4gIW1lbWNtcChzdHIsIGJ1
Ziwgc3RybGVuKHN0cikpOw0KfQ0KDQpUaGFua3MNClpoYW5nIENoZW4NCg0KDQo+IA0KPiBUaGFu
a3MNCj4gDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgbm90aWZ5X3JlbW90
ZV9mcmFtZShDb21wYXJlU3RhdGUgKnMpDQo+ID4gICB7DQo+ID4gICAgICAgY2hhciBtc2dbXSA9
ICJET19DSEVDS1BPSU5UIjsNCj4gPiBAQCAtMTAwOCwyMSArMTAxOSwyNCBAQCBzdGF0aWMgdm9p
ZA0KPiBjb21wYXJlX25vdGlmeV9yc19maW5hbGl6ZShTb2NrZXRSZWFkU3RhdGUgKm5vdGlmeV9y
cykNCj4gPiAgIHsNCj4gPiAgICAgICBDb21wYXJlU3RhdGUgKnMgPSBjb250YWluZXJfb2Yobm90
aWZ5X3JzLCBDb21wYXJlU3RhdGUsDQo+ID4gbm90aWZ5X3JzKTsNCj4gPg0KPiA+IC0gICAgLyog
R2V0IFhlbiBjb2xvLWZyYW1lJ3Mgbm90aWZ5IGFuZCBoYW5kbGUgdGhlIG1lc3NhZ2UgKi8NCj4g
PiAtICAgIGNoYXIgKmRhdGEgPSBnX21lbWR1cChub3RpZnlfcnMtPmJ1Ziwgbm90aWZ5X3JzLT5w
YWNrZXRfbGVuKTsNCj4gPiAtICAgIGNoYXIgbXNnW10gPSAiQ09MT19DT01QQVJFX0dFVF9YRU5f
SU5JVCI7DQo+ID4gKyAgICBjb25zdCBjaGFyIG1zZ1tdID0gIkNPTE9fQ09NUEFSRV9HRVRfWEVO
X0lOSVQiOw0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAtICAgIGlmICghc3RyY21wKGRh
dGEsICJDT0xPX1VTRVJTUEFDRV9QUk9YWV9JTklUIikpIHsNCj4gPiArICAgIGlmIChwYWNrZXRf
bWF0Y2hlc19zdHIoIkNPTE9fVVNFUlNQQUNFX1BST1hZX0lOSVQiLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICBub3RpZnlfcnMtPmJ1ZiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbm90aWZ5X3JzLT5wYWNrZXRfbGVuKSkgew0KPiA+ICAgICAgICAgICByZXQgPSBj
b21wYXJlX2Nocl9zZW5kKHMsICh1aW50OF90ICopbXNnLCBzdHJsZW4obXNnKSwgMCwgdHJ1ZSk7
DQo+ID4gICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gICAgICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoIk5vdGlmeSBYZW4gQ09MTy1mcmFtZSBJTklUIGZhaWxlZCIpOw0KPiA+ICAgICAgICAg
ICB9DQo+ID4gLSAgICB9DQo+ID4gLQ0KPiA+IC0gICAgaWYgKCFzdHJjbXAoZGF0YSwgIkNPTE9f
Q0hFQ0tQT0lOVCIpKSB7DQo+ID4gKyAgICB9IGVsc2UgaWYgKHBhY2tldF9tYXRjaGVzX3N0cigi
Q09MT19DSEVDS1BPSU5UIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG5vdGlmeV9ycy0+YnVmLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bm90aWZ5X3JzLT5wYWNrZXRfbGVuKSkgew0KPiA+ICAgICAgICAgICAvKiBjb2xvLWNvbXBhcmUg
ZG8gY2hlY2twb2ludCwgZmx1c2ggcHJpIHBhY2tldCBhbmQgcmVtb3ZlIHNlYyBwYWNrZXQNCj4g
Ki8NCj4gPiAgICAgICAgICAgZ19xdWV1ZV9mb3JlYWNoKCZzLT5jb25uX2xpc3QsIGNvbG9fZmx1
c2hfcGFja2V0cywgcyk7DQo+ID4gKyAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgIGVycm9yX3Jl
cG9ydCgiQ09MTyBjb21wYXJlIGdvdCB1bnN1cHBvcnRlZCBpbnN0cnVjdGlvbiAnJXMnIiwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgKGNoYXIgKilub3RpZnlfcnMtPmJ1Zik7DQo+ID4gICAg
ICAgfQ0KPiA+ICAgfQ0KPiA+DQo=


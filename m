Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F27C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C23E2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C23E2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiM8-00028w-KB
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38489)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hiiJf-0000TB-3X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hiiJZ-0002YA-5P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:41:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:45053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hiiJY-0002Vm-Lo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:41:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Jul 2019 09:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; d="scan'208";a="164400865"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga008.fm.intel.com with ESMTP; 03 Jul 2019 09:40:56 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.38]) by
 fmsmsx104.amr.corp.intel.com ([169.254.3.66]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 09:40:56 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Thread-Topic: [PATCH] hw/i386: Fix linker error when ISAPC is disabled
Thread-Index: AQHVMbb+drGPa6kziEinFlTruSZuLqa5iKYAgAAFaIA=
Date: Wed, 3 Jul 2019 16:40:56 +0000
Message-ID: <69cb55e2b337cd24f195305683a070cda8b0befd.camel@intel.com>
References: <20190703154958.29004-1-julio.montes@intel.com>
 <366f287a-7f83-235c-5141-331117f50bb4@redhat.com>
In-Reply-To: <366f287a-7f83-235c-5141-331117f50bb4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.186.140]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5C309EF9A8E8D4282C17585C8425315@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
 disabled
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
Cc: "mst@redhat.com" <mst@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTA3LTAzIGF0IDE4OjIxICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBPbiAwMy8wNy8xOSAxNzo0OSwgSnVsaW8gTW9udGVzIHdyb3RlOg0KPiA+IEluIHBjX2luaXQx
KCksIElTQSBJREUgaXMgaW5pdGlhbGl6ZWQgd2l0aG91dCBjaGVja2luZyBpZiBJU0FQQyBvcg0K
PiA+IElERV9JU0ENCj4gPiBjb25maWdzIGFyZSBlbmFibGVkLiBUaGlzIHJlc3VsdHMgaW4gYSBs
aW5rIGVycm9yIHdoZW4NCj4gPiBDT05GSUdfSVNBUEMgaXMgc2V0IHRvICduJyBpbiB0aGUgZmls
ZSBkZWZhdWx0LWNvbmZpZ3MvaTM4Ni0NCj4gPiBzb2Z0bW11Lm1hazoNCj4gPiANCj4gPiBody9p
Mzg2L3BjX3BpaXgubzogSW4gZnVuY3Rpb24gYHBjX2luaXQxJzoNCj4gPiBody9pMzg2L3BjX3Bp
aXguYzoyNjE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlzYV9pZGVfaW5pdCcNCj4gPiBody9p
Mzg2L3BjX3BpaXguYzoyNjE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGlzYV9pZGVfaW5pdCcN
Cj4gPiANCj4gPiBQbGFjZSBpZGVfaXNhIGNvZGUgdW5kZXIgI2lmZGVmIENPTkZJR19JREVfSVNB
IHRvIGZpeCBsaW5rZXIgZXJyb3JzDQo+IA0KPiBCdXQgdGhlcmUgaXMgbm90aGluZyB0aGF0IGRl
ZmluZXMgQ09ORklHX0lERV9JU0EsIHJpZ2h0Pw0KDQp5ZXMgSSB0aGluayB5b3UncmUgcmlnaHQs
IGRvIEkgbmVlZCB0byB1c2UgI2lmZGVmIENPTkZJR19JU0FQQyBpbnN0ZWFkPw0Kb3IgaG93IEkg
Y2FuIGRlZmluZSBDT05GSUdfSURFX0lTQSBhdCBidWlsZCB0aW1lPw0KDQo+IA0KPiBQYW9sbw0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKdWxpbyBNb250ZXMgPGp1bGlvLm1vbnRlc0BpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gIGh3L2kzODYvcGNfcGlpeC5jIHwgMTEgKysrKysrKystLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9wY19waWl4LmMgYi9ody9pMzg2L3BjX3BpaXguYw0K
PiA+IGluZGV4IGMwN2M0YTViMzguLmI5M2Y5MzI3YmUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvaTM4
Ni9wY19waWl4LmMNCj4gPiArKysgYi9ody9pMzg2L3BjX3BpaXguYw0KPiA+IEBAIC02MSw5ICs2
MSwxMSBAQA0KPiA+ICANCj4gPiAgI2RlZmluZSBNQVhfSURFX0JVUyAyDQo+ID4gIA0KPiA+ICsj
aWZkZWYgQ09ORklHX0lERV9JU0ENCj4gPiAgc3RhdGljIGNvbnN0IGludCBpZGVfaW9iYXNlW01B
WF9JREVfQlVTXSA9IHsgMHgxZjAsIDB4MTcwIH07DQo+ID4gIHN0YXRpYyBjb25zdCBpbnQgaWRl
X2lvYmFzZTJbTUFYX0lERV9CVVNdID0geyAweDNmNiwgMHgzNzYgfTsNCj4gPiAgc3RhdGljIGNv
bnN0IGludCBpZGVfaXJxW01BWF9JREVfQlVTXSA9IHsgMTQsIDE1IH07DQo+ID4gKyNlbmRpZg0K
PiA+ICANCj4gPiAgLyogUEMgaGFyZHdhcmUgaW5pdGlhbGlzYXRpb24gKi8NCj4gPiAgc3RhdGlj
IHZvaWQgcGNfaW5pdDEoTWFjaGluZVN0YXRlICptYWNoaW5lLA0KPiA+IEBAIC0yNTQsNyArMjU2
LDEwIEBAIHN0YXRpYyB2b2lkIHBjX2luaXQxKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwNCj4gPiAg
ICAgICAgICB9DQo+ID4gICAgICAgICAgaWRlYnVzWzBdID0gcWRldl9nZXRfY2hpbGRfYnVzKCZk
ZXYtPnFkZXYsICJpZGUuMCIpOw0KPiA+ICAgICAgICAgIGlkZWJ1c1sxXSA9IHFkZXZfZ2V0X2No
aWxkX2J1cygmZGV2LT5xZGV2LCAiaWRlLjEiKTsNCj4gPiAtICAgIH0gZWxzZSB7DQo+ID4gKyAg
ICAgICAgcGNfY21vc19pbml0KHBjbXMsIGlkZWJ1c1swXSwgaWRlYnVzWzFdLCBydGNfc3RhdGUp
Ow0KPiA+ICsgICAgfQ0KPiA+ICsjaWZkZWYgQ09ORklHX0lERV9JU0ENCj4gPiArZWxzZSB7DQo+
ID4gICAgICAgICAgZm9yKGkgPSAwOyBpIDwgTUFYX0lERV9CVVM7IGkrKykgew0KPiA+ICAgICAg
ICAgICAgICBJU0FEZXZpY2UgKmRldjsNCj4gPiAgICAgICAgICAgICAgY2hhciBidXNuYW1lW10g
PSAiaWRlLjAiOw0KPiA+IEBAIC0yNjgsOSArMjczLDkgQEAgc3RhdGljIHZvaWQgcGNfaW5pdDEo
TWFjaGluZVN0YXRlICptYWNoaW5lLA0KPiA+ICAgICAgICAgICAgICBidXNuYW1lWzRdID0gJzAn
ICsgaTsNCj4gPiAgICAgICAgICAgICAgaWRlYnVzW2ldID0gcWRldl9nZXRfY2hpbGRfYnVzKERF
VklDRShkZXYpLCBidXNuYW1lKTsNCj4gPiAgICAgICAgICB9DQo+ID4gKyAgICAgICAgcGNfY21v
c19pbml0KHBjbXMsIGlkZWJ1c1swXSwgaWRlYnVzWzFdLCBydGNfc3RhdGUpOw0KPiA+ICAgICAg
fQ0KPiA+IC0NCj4gPiAtICAgIHBjX2Ntb3NfaW5pdChwY21zLCBpZGVidXNbMF0sIGlkZWJ1c1sx
XSwgcnRjX3N0YXRlKTsNCj4gPiArI2VuZGlmDQo+ID4gIA0KPiA+ICAgICAgaWYgKHBjbWMtPnBj
aV9lbmFibGVkICYmIG1hY2hpbmVfdXNiKG1hY2hpbmUpKSB7DQo+ID4gICAgICAgICAgcGNpX2Ny
ZWF0ZV9zaW1wbGUocGNpX2J1cywgcGlpeDNfZGV2Zm4gKyAyLCAicGlpeDMtdXNiLQ0KPiA+IHVo
Y2kiKTsNCj4gPiANCg==


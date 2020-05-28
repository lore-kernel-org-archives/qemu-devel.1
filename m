Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82440C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575B32072D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575B32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeL5q-0007It-FA
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeL2E-0004ps-9f
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:05:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:32080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jeL2C-0002J6-2w
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:05:33 -0400
IronPort-SDR: +XJ97uR54qhEvtUGnxR5Er0PaH//8epWyMRdr4P5+bXhkSCIFJho+PZzGxUWcaZ7Htky143Ofe
 wHiNreZSJLbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 09:05:23 -0700
IronPort-SDR: KKrR/KtBbgMgbTCOyXU1WJ+83hjt3nPACg/tgNOv7OUa+XxNEes8W1uPmjflg7/88TokQyxRn/
 dWoKQGJxn7Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; d="scan'208";a="302857683"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by orsmga008.jf.intel.com with ESMTP; 28 May 2020 09:05:23 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.143]) with mapi id 14.03.0439.000;
 Thu, 28 May 2020 09:05:22 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH v2 2/3] hw/acpi-build: account for NVDIMM numa nodes in
 SRAT
Thread-Topic: [PATCH v2 2/3] hw/acpi-build: account for NVDIMM numa nodes in
 SRAT
Thread-Index: AQHWNLOi43Pbr9sMpUeIFidMXr7HDai9z7oAgABPWoA=
Date: Thu, 28 May 2020 16:05:22 +0000
Message-ID: <7bbbc2706e7b886d55aa23b5ae67200a363f7b6f.camel@intel.com>
References: <20200528054807.21278-1-vishal.l.verma@intel.com>
 <20200528054807.21278-3-vishal.l.verma@intel.com>
 <20200528131946.3a09cd20@redhat.com>
In-Reply-To: <20200528131946.3a09cd20@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F545879F8FA9184B9518F9065365A8FC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=vishal.l.verma@intel.com; helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 12:05:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "mst@redhat.com" <mst@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDIwLTA1LTI4IGF0IDEzOjE5ICswMjAwLCBJZ29yIE1hbW1lZG92IHdyb3RlOg0K
DQpbLi5dDQo+ID4gQEAgLTEzMzQsNiArMTMzNSwzMSBAQCBzdGF0aWMgdm9pZCBudmRpbW1fYnVp
bGRfc3NkdChHQXJyYXkgKnRhYmxlX29mZnNldHMsIEdBcnJheSAqdGFibGVfZGF0YSwNCj4gPiAg
ICAgIGZyZWVfYW1sX2FsbG9jYXRvcigpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICt2b2lkICpudmRp
bW1fYnVpbGRfc3JhdChHQXJyYXkgKnRhYmxlX2RhdGEpDQo+ID4gK3sNCj4gPiArICAgIEFjcGlT
cmF0TWVtb3J5QWZmaW5pdHkgKm51bWFtZW0gPSBOVUxMOw0KPiA+ICsgICAgR1NMaXN0ICpkZXZp
Y2VfbGlzdCA9IG52ZGltbV9nZXRfZGV2aWNlX2xpc3QoKTsNCj4gPiArDQo+ID4gKyAgICBmb3Ig
KDsgZGV2aWNlX2xpc3Q7IGRldmljZV9saXN0ID0gZGV2aWNlX2xpc3QtPm5leHQpIHsNCj4gPiAr
ICAgICAgICBEZXZpY2VTdGF0ZSAqZGV2ID0gZGV2aWNlX2xpc3QtPmRhdGE7DQo+IEknZCB1c2Ug
T2JqZWN0IGhlcmUgd2l0aCBPQkpFQ1QoKSBjYXN0IGFuZCBkcm9wIGNhc3RzIGJlb2x3IGluIHBy
b3BlcnR5IGdldHRlcnMNCj4gDQpEb25lLCB0aGF0IG1ha2VzIGl0IG11Y2ggY2xlYW5lci4NCg0K
PiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2FjcGktYnVpbGQuYyBiL2h3L2kzODYvYWNwaS1idWls
ZC5jDQo+ID4gaW5kZXggMmUxNWY2ODQ4ZS4uMTQ2MWQ4YTcxOCAxMDA2NDQNCj4gPiAtLS0gYS9o
dy9pMzg2L2FjcGktYnVpbGQuYw0KPiA+ICsrKyBiL2h3L2kzODYvYWNwaS1idWlsZC5jDQo+ID4g
QEAgLTI0MjgsNiArMjQyOCwxNiBAQCBidWlsZF9zcmF0KEdBcnJheSAqdGFibGVfZGF0YSwgQklP
U0xpbmtlciAqbGlua2VyLCBNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1FTV9BRkZJTklUWV9FTkFCTEVEKTsNCj4gPiAgICAgICAgICB9
DQo+ID4gICAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKG1hY2hpbmUtPm52ZGltbXNfc3RhdGUt
PmlzX2VuYWJsZWQpIHsNCj4gPiArICAgICAgICB2b2lkICpyZXQ7DQo+ID4gKw0KPiA+ICsgICAg
ICAgIHJldCA9IG52ZGltbV9idWlsZF9zcmF0KHRhYmxlX2RhdGEpOw0KPiA+ICsgICAgICAgIGlm
IChyZXQgIT0gTlVMTCkgew0KPiA+ICsgICAgICAgICAgICBudW1hbWVtID0gcmV0Ow0KPiA+ICsg
ICAgICAgIH0NCj4gDQo+IHdoeSBkbyB3ZSBuZWVkIHJldHVybiB2YWx1ZSBoZXJlIGFuZCBhIHRl
c3QgY29uZGl0aW9uIGFuZCBhc3NpZ24gJ3JldCcgdG8gbnVtYW1lbT8NCg0KQWggSSB0aG91Z2h0
IG51bWFtZW0gd2FzIHByb3BhZ2F0ZWQgdGhyb3VnaCB0aGUgZGlmZmVyZW50IHBhcnRzIG9mIHRo
ZQ0KYnVpbGRfc3JhdCBmbG93LCBidXQgSSBtaXNyZWFkLiBZb3UncmUgcmlnaHQgaXQgaXMgbm90
IG5lZWRlZCwgcmVtb3ZpbmcuDQoNCg==


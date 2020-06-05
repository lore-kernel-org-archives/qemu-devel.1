Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 00:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABE6206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 00:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABE6206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh0dd-0002wr-U9
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 20:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jh0d6-0002XR-Mf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 20:54:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:32236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jh0d3-0002jI-9g
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 20:54:39 -0400
IronPort-SDR: dQ66m7EK7OZ2NZ220YmpFvcHNTa/4LCLIt4/ekht1sYlNGP4dUKmlUJa0U5Bjs+yph+RczjBzi
 QE3yOhnWYFvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 17:54:30 -0700
IronPort-SDR: IoR/cGaszVE4QTgGAgbwOmHH1hu1MWcgmVAIG1jkVxW7q4xaOGTDbgktXoctq3BXFiwAa3E23G
 3GDbxnsXFCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,474,1583222400"; d="scan'208";a="259043032"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
 by fmsmga008.fm.intel.com with ESMTP; 04 Jun 2020 17:54:30 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jun 2020 17:54:29 -0700
Received: from orsmsx121.amr.corp.intel.com ([169.254.10.222]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.206]) with mapi id 14.03.0439.000;
 Thu, 4 Jun 2020 17:54:29 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "imammedo@redhat.com" <imammedo@redhat.com>
Subject: Re: [PATCH v4 2/3] hw/acpi/nvdimm: add a helper to augment SRAT
 generation
Thread-Topic: [PATCH v4 2/3] hw/acpi/nvdimm: add a helper to augment SRAT
 generation
Thread-Index: AQHWNUA2VG31lbrZsEq/gWF/hD043ajIwgEAgADwkIA=
Date: Fri, 5 Jun 2020 00:54:28 +0000
Message-ID: <73b11cd452acffc18f7083f1ea7e5ca22cade31f.camel@intel.com>
References: <20200528223437.12568-1-vishal.l.verma@intel.com>
 <20200528223437.12568-3-vishal.l.verma@intel.com>
 <20200604123326.38f7a368@redhat.com>
In-Reply-To: <20200604123326.38f7a368@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4100350B810D5142833A645EEEFA7D66@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=vishal.l.verma@intel.com; helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 20:54:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

T24gVGh1LCAyMDIwLTA2LTA0IGF0IDEyOjMzICswMjAwLCBJZ29yIE1hbW1lZG92IHdyb3RlOg0K
PiBPbiBUaHUsIDI4IE1heSAyMDIwIDE2OjM0OjM2IC0wNjAwDQo+IFZpc2hhbCBWZXJtYSA8dmlz
aGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gTlZESU1NcyBjYW4gYmVsb25n
IHRvIHRoZWlyIG93biBwcm94aW1pdHkgZG9tYWlucywgYXMgZGVzY3JpYmVkIGJ5IHRoZQ0KPiA+
IE5GSVQuIEluIHN1Y2ggY2FzZXMsIHRoZSBTUkFUIG5lZWRzIHRvIGhhdmUgTWVtb3J5IEFmZmlu
aXR5IHN0cnVjdHVyZXMNCj4gPiBpbiB0aGUgU1JBVCBmb3IgdGhlc2UgTlZESU1Ncywgb3RoZXJ3
aXNlIExpbnV4IGRvZXNuJ3QgcG9wdWxhdGUgbm9kZQ0KPiA+IGRhdGEgc3RydWN0dXJlcyBwcm9w
ZXJseSBkdXJpbmcgTlVNQSBpbml0aWFsaXphdGlvbi4gU2VlIHRoZSBmb2xsb3dpbmcNCj4gPiBm
b3IgYW4gZXhhbXBsZSBmYWlsdXJlIGNhc2UuDQo+ID4gDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbnZkaW1tLzIwMjAwNDE2MjI1NDM4LjE1MjA4LTEtdmlzaGFsLmwudmVybWFA
aW50ZWwuY29tLw0KPiA+IA0KPiA+IEludHJvZHVjZSBhIG5ldyBoZWxwZXIsIG52ZGltbV9idWls
ZF9zcmF0KCksIGFuZCBjYWxsIGl0IGZvciBib3RoIHRoZQ0KPiA+IGkzODYgYW5kIGFybSB2ZXJz
aW9ucyBvZiAnYnVpbGRfc3JhdCgpJyB0byBhdWdtZW50IHRoZSBTUkFUIHdpdGgNCj4gPiBtZW1v
cnkgYWZmaW5pdHkgaW5mb3JtYXRpb24gZm9yIE5WRElNTXMuDQo+ID4gDQo+ID4gVGhlIHJlbGV2
YW50IGNvbW1hbmQgbGluZSBvcHRpb25zIHRvIGV4ZXJjaXNlIHRoaXMgYXJlIGJlbG93LiBOb2Rl
cyAwLTENCj4gPiBjb250YWluIENQVXMgYW5kIHJlZ3VsYXIgbWVtb3J5LCBhbmQgbm9kZXMgMi0z
IGFyZSB0aGUgTlZESU1NIGFkZHJlc3MNCj4gPiBzcGFjZS4NCj4gPiANCj4gPiAgIC1udW1hIG5v
ZGUsbm9kZWlkPTAsbWVtPTIwNDhNLA0KPiA+ICAgLW51bWEgbm9kZSxub2RlaWQ9MSxtZW09MjA0
OE0sDQo+IA0KPiBwbHMgbm90ZSB0aGF0ICdtZW0nIGlzIGFib3V0IHRvIGJlIGRpc2FibGVkIGZv
ciBuZXcgbWFjaGluZSB0eXBlcyBpbiBmYXZvciBvZiBtZW1kZXYNCj4gc28gdGhpcyBDTEkgd29u
J3Qgd29yay4NCj4gSXQgd291bGQgYmUgbmljZSB0byB1cGRhdGUgY29tbWl0IG1lc3NhZ2Ugd2l0
aCBtZW1kZXYgdmFyaWFudCBvZiBDTEkNCg0KSSBzYXcgdGhlIHdhcm5pbmdzIHByaW50ZWQgLSBJ
IGRpZCB0cnkgdG8gdXNlIG1lbWRldnMsIGJ1dCBpdCBkaWRuJ3QNCnF1aXRlIHdvcmsgd2l0aCBt
eSB1c2UgY2FzZS4gSSdtIHN1cHBseWluZyBtZW09MCBmb3IgdGhlIHBtZW0vbnZkaW1tDQpkZXZp
Y2VzIHRoYXQgSSB3YW50IHRvIGdpdmUgYSBzcGVjaWZpYyBudW1hIG5vZGUsIGJ1dCBub3QgZ2l2
ZSB0aGVtIGFueQ0KbW9yZSByZWd1bGFyIG1lbW9yeSBhc2lkZSBmcm9tIHRoZSBudmRpbW0gaXRz
ZWxmIChzZWUgbm9kZXMgNCBhbmQgNQ0KYmVsb3cpLiBBbmQgZm9yIHNvbWUgcmVhc29uIEkgY291
bGRuJ3QgZG8gdGhhdCB3aXRoIG1lbWRldnMuDQoNCkhlcmUgaXMgdGhlIGZ1bGwgY29tbWFuZCBs
aW5lIEknbSB1c2luZyBmb3IgZXhhbXBsZS4gSSdkIGFwcHJlY2lhdGUgYW55DQpwb2ludGVycyBv
biBjb252ZXJ0aW5nIG92ZXIgdG8gbWVtZGV2cyBmdWxseS4NCg0KICAgcWVtdS1zeXN0ZW0teDg2
XzY0IA0KICAgLW1hY2hpbmUgcGMsYWNjZWw9a3ZtLG52ZGltbSwgDQogICAtbSA4MTkyTSxzbG90
cz00LG1heG1lbT00MDk2ME0gDQogICAtc21wIDgsc29ja2V0cz0yLGNvcmVzPTIsdGhyZWFkcz0y
IA0KICAgLWVuYWJsZS1rdm0gDQogICAtZGlzcGxheSBub25lIA0KICAgLW5vZ3JhcGhpYyANCiAg
IC1kcml2ZSBmaWxlPXJvb3QuaW1nLGZvcm1hdD1yYXcsbWVkaWE9ZGlzayANCiAgIC1rZXJuZWwg
Li9ta29zaS5leHRyYS9ib290L3ZtbGludXotNS43LjAtMDAwMDEtZzg3YWQ5NjNiYWMyMyANCiAg
IC1pbml0cmQgbWtvc2kuZXh0cmEvYm9vdC9pbml0cmFtZnMtNS43LjAtMDAwMDEtZzg3YWQ5NjNi
YWMyMy5pbWcgDQogICAtYXBwZW5kIHNlbGludXg9MCBhdWRpdD0wIGNvbnNvbGU9dHR5MCBjb25z
b2xlPXR0eVMwIHJvb3Q9L2Rldi9zZGEyIGlnbm9yZV9sb2dsZXZlbCBydyANCiAgIC1kZXZpY2Ug
ZTEwMDAsbmV0ZGV2PW5ldDAgDQogICAtbmV0ZGV2IHVzZXIsaWQ9bmV0MCxob3N0ZndkPXRjcDo6
MTAwMjItOjIyIA0KICAgLXNuYXBzaG90IA0KICAgLW51bWEgbm9kZSxub2RlaWQ9MCxtZW09MjA0
OE0sIA0KICAgLW51bWEgY3B1LG5vZGUtaWQ9MCxzb2NrZXQtaWQ9MCANCiAgIC1udW1hIG5vZGUs
bm9kZWlkPTEsbWVtPTIwNDhNLCANCiAgIC1udW1hIGNwdSxub2RlLWlkPTEsc29ja2V0LWlkPTEg
DQogICAtbnVtYSBub2RlLG5vZGVpZD0yLG1lbT0yMDQ4TSwgDQogICAtbnVtYSBub2RlLG5vZGVp
ZD0zLG1lbT0yMDQ4TSwgDQogICAtbnVtYSBub2RlLG5vZGVpZD00LG1lbT0wLCANCiAgIC1vYmpl
Y3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1udm1lbTAsc2hhcmUsbWVtLXBhdGg9bnZkaW1tLTAs
c2l6ZT0xNjM4NE0sYWxpZ249MUcgDQogICAtZGV2aWNlIG52ZGltbSxtZW1kZXY9bnZtZW0wLGlk
PW52MCxsYWJlbC1zaXplPTJNLG5vZGU9NCANCiAgIC1udW1hIG5vZGUsbm9kZWlkPTUsbWVtPTAs
IA0KICAgLW9iamVjdCBtZW1vcnktYmFja2VuZC1maWxlLGlkPW52bWVtMSxzaGFyZSxtZW0tcGF0
aD1udmRpbW0tMSxzaXplPTE2Mzg0TSxhbGlnbj0xRyANCiAgIC1kZXZpY2UgbnZkaW1tLG1lbWRl
dj1udm1lbTEsaWQ9bnYxLGxhYmVsLXNpemU9Mk0sbm9kZT01IA0KDQo+IA0KPiA+ICAgLW51bWEg
bm9kZSxub2RlaWQ9MixtZW09MCwNCj4gPiAgIC1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxp
ZD1udm1lbTAsc2hhcmUsbWVtLXBhdGg9bnZkaW1tLTAsc2l6ZT0xNjM4NE0sYWxpZ249MTI4TQ0K
PiA+ICAgLWRldmljZSBudmRpbW0sbWVtZGV2PW52bWVtMCxpZD1udjAsbGFiZWwtc2l6ZT0yTSxu
b2RlPTINCj4gPiAgIC1udW1hIG5vZGUsbm9kZWlkPTMsbWVtPTAsDQo+ID4gICAtb2JqZWN0IG1l
bW9yeS1iYWNrZW5kLWZpbGUsaWQ9bnZtZW0xLHNoYXJlLG1lbS1wYXRoPW52ZGltbS0xLHNpemU9
MTYzODRNLGFsaWduPTEyOE0NCj4gPiAgIC1kZXZpY2UgbnZkaW1tLG1lbWRldj1udm1lbTEsaWQ9
bnYxLGxhYmVsLXNpemU9Mk0sbm9kZT0zDQo+ID4gDQo+ID4gQ2M6IEppbmdxaSBMaXUgPGppbmdx
aS5saXVAaW50ZWwuY29tPg0KPiA+IENjOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBKaW5ncWkgTGl1IDxqaW5ncWkubGl1QGludGVsLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNv
bT4NCj4gDQo+IFJldmlld2VkLWJ5OiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29t
Pg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgSWdvciAtIEknbSBwcmV0dHkgdW5mYW1pbGlhciB3
aXRoIHFlbXUgZGV2ZWxvcG1lbnQNCi0gd2hhdCBhcmUgdGhlIG5leHQgc3RlcHM/IElzIHRoZXJl
IGEgY2VydGFpbiBtYWludGFpbmVyL3RyZWUgSSBjb3VsZA0Kd2F0Y2ggZm9yIHRoZSBpbmNsdXNp
b24gb2YgdGhpcz8NCg0KPiANCj4gPiAtLS0NCj4gPiAgaHcvYWNwaS9udmRpbW0uYyAgICAgICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaHcvYXJtL3ZpcnQtYWNwaS1idWls
ZC5jIHwgIDQgKysrKw0KPiA+ICBody9pMzg2L2FjcGktYnVpbGQuYyAgICAgfCAgNSArKysrKw0K
PiA+ICBpbmNsdWRlL2h3L21lbS9udmRpbW0uaCAgfCAgMSArDQo+ID4gIDQgZmlsZXMgY2hhbmdl
ZCwgMzMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IA0K


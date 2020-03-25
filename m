Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A395C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09E52076A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 12:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09E52076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5SB-00071A-0b
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 08:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH5RW-0006cf-KR
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH5RU-00004y-WC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:47:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:26769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH5RU-0008VY-P0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 08:47:32 -0400
IronPort-SDR: AE/scgy040jDYJMsKJVexosFVs80wBKY4ux4vsy8ltw9CTwgC9oXzjoitmzmx+BPENzbfTDBak
 0ICyhN53exgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 05:47:31 -0700
IronPort-SDR: w91g1J1XFlQxkfFaBqFwei5cuqUa5FimNiCGlfwsIvkFd10dpKJNu8x/4jpha+n7mh5beRuUXm
 m+DECLVfjP9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="282126980"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2020 05:47:30 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 05:47:30 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 05:47:30 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.86]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 20:47:26 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 14/22] intel_iommu: bind/unbind guest page table to host
Thread-Topic: [PATCH v1 14/22] intel_iommu: bind/unbind guest page table to
 host
Thread-Index: AQHWAEW2HzdudG5l606qpAWL4DnMMKhXgbMAgAHDqLA=
Date: Wed, 25 Mar 2020 12:47:26 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A2021FA@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-15-git-send-email-yi.l.liu@intel.com>
 <20200324174642.GY127076@xz-x1>
In-Reply-To: <20200324174642.GY127076@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMjUsIDIwMjAgMTo0NyBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjUsIDIwMjAgMTo0NyBBTQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxIDE0LzIyXSBpbnRlbF9pb21tdTogYmluZC91bmJpbmQgZ3Vlc3QgcGFn
ZSB0YWJsZSB0byBob3N0DQo+IA0KPiBPbiBTdW4sIE1hciAyMiwgMjAyMCBhdCAwNTozNjoxMUFN
IC0wNzAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGNhcHR1cmVzIHRoZSBndWVz
dCBQQVNJRCB0YWJsZSBlbnRyeSBtb2RpZmljYXRpb25zIGFuZA0KPiA+IHByb3BhZ2F0ZXMgdGhl
IGNoYW5nZXMgdG8gaG9zdCB0byBzZXR1cCBkdWFsIHN0YWdlIERNQSB0cmFuc2xhdGlvbi4NCj4g
PiBUaGUgZ3Vlc3QgcGFnZSB0YWJsZSBpcyBjb25maWd1cmVkIGFzIDFzdCBsZXZlbCBwYWdlIHRh
YmxlIChHVkEtPkdQQSkNCj4gPiB3aG9zZSB0cmFuc2xhdGlvbiByZXN1bHQgd291bGQgZnVydGhl
ciBnbyB0aHJvdWdoIGhvc3QgVlQtZCAybmQgbGV2ZWwNCj4gPiBwYWdlIHRhYmxlKEdQQS0+SFBB
KSB1bmRlciBuZXN0ZWQgdHJhbnNsYXRpb24gbW9kZS4gVGhpcyBpcyB0aGUga2V5DQo+ID4gcGFy
dCBvZiB2U1ZBIHN1cHBvcnQsIGFuZCBhbHNvIGEga2V5IHRvIHN1cHBvcnQgSU9WQSBvdmVyIDFz
dC0gbGV2ZWwNCj4gPiBwYWdlIHRhYmxlIGZvciBJbnRlbCBWVC1kIGluIHZpcnR1YWxpemF0aW9u
IGVudmlyb25tZW50Lg0KPiA+DQo+ID4gQ2M6IEtldmluIFRpYW4gPGtldmluLnRpYW5AaW50ZWwu
Y29tPg0KPiA+IENjOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0K
PiA+IENjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gQ2M6IFlpIFN1biA8eWku
eS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+IENjOiBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KPiA+IENjOiBSaWNoYXJkIEhlbmRlcnNvbiA8cnRoQHR3aWRkbGUubmV0Pg0K
PiA+IFNpZ25lZC1vZmYtYnk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0t
DQo+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDk4DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+ICBody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmggfCAyNSArKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExOCBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBpbmRleA0KPiA+IGM5ODVj
YWUuLjA0MjNjODMgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4g
KysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ID4gQEAgLTQxLDYgKzQxLDcgQEANCj4gPiAg
I2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+ID4gICNpbmNsdWRlICJ0cmFjZS5oIg0K
PiA+ICAjaW5jbHVkZSAicWVtdS9qaGFzaC5oIg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9tbXUu
aD4NCj4gPg0KPiA+ICAvKiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4gPiAgI2RlZmlu
ZSBWVERfQ0VfR0VUX1JJRDJQQVNJRChjZSkgXA0KPiA+IEBAIC02OTUsNiArNjk2LDE2IEBAIHN0
YXRpYyBpbmxpbmUgdWludDE2X3QNCj4gdnRkX3BlX2dldF9kb21haW5faWQoVlREUEFTSURFbnRy
eSAqcGUpDQo+ID4gICAgICByZXR1cm4gVlREX1NNX1BBU0lEX0VOVFJZX0RJRCgocGUpLT52YWxb
MV0pOw0KPiA+ICB9DQo+ID4NClsuLi5dDQo+ID4gKw0KPiA+ICsgICAgYmluZF9kYXRhID0gZ19t
YWxsb2MwKHNpemVvZigqYmluZF9kYXRhKSk7DQo+ID4gKyAgICBiaW5kX2RhdGEtPnBhc2lkID0g
cGFzaWQ7DQo+ID4gKyAgICBnX2JpbmRfZGF0YSA9ICZiaW5kX2RhdGEtPmJpbmRfZGF0YS5ncGFz
aWRfYmluZDsNCj4gPiArDQo+ID4gKyAgICBnX2JpbmRfZGF0YS0+ZmxhZ3MgPSAwOw0KPiA+ICsg
ICAgZ19iaW5kX2RhdGEtPnZ0ZC5mbGFncyA9IDA7DQo+ID4gKyAgICBzd2l0Y2ggKG9wKSB7DQo+
ID4gKyAgICBjYXNlIFZURF9QQVNJRF9CSU5EOg0KPiA+ICsgICAgY2FzZSBWVERfUEFTSURfVVBE
QVRFOg0KPiANCj4gSXMgVlREX1BBU0lEX1VQREFURSB1c2VkIGFueXdoZXJlPw0KDQpIbW1tLCB0
aGVyZSBpcyB1cGRhdGUgY2FzZSBpbiB0aGUgY29kZS4gQnV0LCB0aGlzIG1hY3JvIGlzIG5vdA0K
dXNlZCBleHBsaWNpdGx5IGluIHRoaXMgcGF0Y2guIE1heWJlIEkgc2hvdWxkIGRyb3AgaXQuDQoN
ClJlZ2FyZHMsDQpZaSBMaXUNCg0K


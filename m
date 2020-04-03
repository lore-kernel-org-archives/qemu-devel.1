Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39521C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 086E72073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086E72073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNLG-0005Ln-4G
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNKR-0004fJ-IJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNKP-0007t0-MN
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:29:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:1867)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKNKP-0007pF-CU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:29:49 -0400
IronPort-SDR: wZBESKR5pB/2dSMlyBfW+ORcJ9jfTlqEui3cocIijeOxmgL4W0Oi4x6cTkyeV4Sh+U2MKw2o8N
 2DFR2y6CeUIw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 07:29:45 -0700
IronPort-SDR: OMgZC6PTstbqz4oW7leK+A6kOGnGt9CtuIg3gW/itn1kSN4CEhbzAw8SFNRQ/fES//hZ8XWK7l
 X/5AmojS/cJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; d="scan'208";a="329180601"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga001.jf.intel.com with ESMTP; 03 Apr 2020 07:29:44 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 07:29:44 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 07:29:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 22:29:40 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v2 15/22] intel_iommu: bind/unbind guest page table to host
Thread-Topic: [PATCH v2 15/22] intel_iommu: bind/unbind guest page table to
 host
Thread-Index: AQHWBkplKGJEo59YsUeJrUOkrr1+EKhloPgAgAHaffA=
Date: Fri, 3 Apr 2020 14:29:39 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A220D4A@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-16-git-send-email-yi.l.liu@intel.com>
 <20200402180920.GD103677@xz-x1>
In-Reply-To: <20200402180920.GD103677@xz-x1>
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
X-Received-From: 192.55.52.120
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXBy
aWwgMywgMjAyMCAyOjA5IEFNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxNS8yMl0gaW50ZWxfaW9tbXU6IGJpbmQvdW5iaW5k
IGd1ZXN0IHBhZ2UgdGFibGUgdG8gaG9zdA0KPiANCj4gT24gU3VuLCBNYXIgMjksIDIwMjAgYXQg
MDk6MjQ6NTRQTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgdnRkX2Jp
bmRfZ3Vlc3RfcGFzaWQoSW50ZWxJT01NVVN0YXRlICpzLCBWVERCdXMgKnZ0ZF9idXMsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRldmZuLCBpbnQgcGFzaWQsIFZU
RFBBU0lERW50cnkgKnBlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZU
RFBBU0lET3Agb3ApIHsNCj4gPiArICAgIFZUREhvc3RJT01NVUNvbnRleHQgKnZ0ZF9kZXZfaWN4
Ow0KPiA+ICsgICAgSG9zdElPTU1VQ29udGV4dCAqaW9tbXVfY3R4Ow0KPiA+ICsgICAgRHVhbElP
TU1VU3RhZ2UxQmluZERhdGEgKmJpbmRfZGF0YTsNCj4gPiArICAgIHN0cnVjdCBpb21tdV9ncGFz
aWRfYmluZF9kYXRhICpnX2JpbmRfZGF0YTsNCj4gPiArICAgIGludCByZXQgPSAtMTsNCj4gPiAr
DQo+ID4gKyAgICB2dGRfZGV2X2ljeCA9IHZ0ZF9idXMtPmRldl9pY3hbZGV2Zm5dOw0KPiA+ICsg
ICAgaWYgKCF2dGRfZGV2X2ljeCkgew0KPiA+ICsgICAgICAgIC8qIG1lYW5zIG5vIG5lZWQgdG8g
Z28gZnVydGhlciwgZS5nLiBmb3IgZW11bGF0ZWQgZGV2aWNlcyAqLw0KPiA+ICsgICAgICAgIHJl
dHVybiAwOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlvbW11X2N0eCA9IHZ0ZF9kZXZf
aWN4LT5pb21tdV9jdHg7DQo+ID4gKyAgICBpZiAoIWlvbW11X2N0eCkgew0KPiA+ICsgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGlmICghKGlvbW11
X2N0eC0+c3RhZ2UxX2Zvcm1hdHMNCj4gPiArICAgICAgICAgICAgICYgSU9NTVVfUEFTSURfRk9S
TUFUX0lOVEVMX1ZURCkpIHsNCj4gPiArICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiSU9NTVUg
U3RhZ2UgMSBmb3JtYXQgaXMgbm90IGNvbXBhdGlibGUhXG4iKTsNCj4gPiArICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBiaW5kX2RhdGEgPSBnX21h
bGxvYzAoc2l6ZW9mKCpiaW5kX2RhdGEpKTsNCj4gPiArICAgIGJpbmRfZGF0YS0+cGFzaWQgPSBw
YXNpZDsNCj4gPiArICAgIGdfYmluZF9kYXRhID0gJmJpbmRfZGF0YS0+YmluZF9kYXRhLmdwYXNp
ZF9iaW5kOw0KPiA+ICsNCj4gPiArICAgIGdfYmluZF9kYXRhLT5mbGFncyA9IDA7DQo+ID4gKyAg
ICBnX2JpbmRfZGF0YS0+dnRkLmZsYWdzID0gMDsNCj4gPiArICAgIHN3aXRjaCAob3ApIHsNCj4g
PiArICAgIGNhc2UgVlREX1BBU0lEX0JJTkQ6DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPnZl
cnNpb24gPSBJT01NVV9VQVBJX1ZFUlNJT047DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEtPmZv
cm1hdCA9IElPTU1VX1BBU0lEX0ZPUk1BVF9JTlRFTF9WVEQ7DQo+ID4gKyAgICAgICAgZ19iaW5k
X2RhdGEtPmdwZ2QgPSB2dGRfcGVfZ2V0X2ZscHRfYmFzZShwZSk7DQo+ID4gKyAgICAgICAgZ19i
aW5kX2RhdGEtPmFkZHJfd2lkdGggPSB2dGRfcGVfZ2V0X2ZsX2F3KHBlKTsNCj4gPiArICAgICAg
ICBnX2JpbmRfZGF0YS0+aHBhc2lkID0gcGFzaWQ7DQo+ID4gKyAgICAgICAgZ19iaW5kX2RhdGEt
PmdwYXNpZCA9IHBhc2lkOw0KPiA+ICsgICAgICAgIGdfYmluZF9kYXRhLT5mbGFncyB8PSBJT01N
VV9TVkFfR1BBU0lEX1ZBTDsNCj4gPiArICAgICAgICBnX2JpbmRfZGF0YS0+dnRkLmZsYWdzID0N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoVlREX1NNX1BBU0lEX0VOVFJZX1NS
RV9CSVQocGUtPnZhbFsyXSkNCj4gPiArID8gMSA6IDApDQo+IA0KPiBUaGlzIGV2YWx1YXRlcyB0
byAxIGlmIFZURF9TTV9QQVNJRF9FTlRSWV9TUkVfQklUKHBlLT52YWxbMl0pLCBvciAwLg0KPiBE
byB5b3Ugd2FudCB0byB1c2UgSU9NTVVfU1ZBX1ZURF9HUEFTSURfU1JFIGluc3RlYWQgb2YgMT8g
IFNhbWUgcXVlc3Rpb24gdG8NCj4gYWxsIHRoZSByZXN0Lg0KDQpvb3BzLCB5ZXMgaXQgaXMuIHlv
dSBhcmUgcmlnaHQuIHRoYW5rcyBmb3IgY2F0Y2hpbmcgaXQuIER1cmluZyB2ZXJpZmljYXRpb24s
IG9ubHkNCnRoZSBTUkUgYml0IGlzIHVzZWQsIHNvIGl0J3Mgbm90IHNwb3R0ZWQgaW4gdGVzdGlu
Zy4NCg0KUmVnYXJkcywNCllpIExpdQ0K


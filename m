Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AF2C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 11:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950CA20769
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 11:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950CA20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKh9q-0001pc-Mc
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 07:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKh9G-0001Of-Pa
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 07:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKh9E-0005yc-MG
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 07:39:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:9990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKh9E-0005sL-EE
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 07:39:36 -0400
IronPort-SDR: +f8wrzGiReWfdhvVW8OTyF+U+mnRFaNt0eXCaD52BVbDOMryIPPlezGCZRYpVwUYvp8bSAlOzL
 1JhigPi92LjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2020 04:39:32 -0700
IronPort-SDR: 4wgZsb05D7VLxi1sLvg3AyX90sCy/OyltFJiQNcb64CkMLDQxprKxTL+mHroiNFLqf+g+dGkFE
 dBYHunkUuQwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,343,1580803200"; d="scan'208";a="241349948"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2020 04:39:32 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 4 Apr 2020 04:39:32 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 4 Apr 2020 04:39:31 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.138]) with mapi id 14.03.0439.000;
 Sat, 4 Apr 2020 19:39:28 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Thread-Topic: [PATCH v2 13/22] intel_iommu: add PASID cache management
 infrastructure
Thread-Index: AQHWBkpjDlzgAqAO2kCfS3rvS1hmKKhkcUmAgADtXCD///hbAIACJjmw//+XZYCAAcnKoA==
Date: Sat, 4 Apr 2020 11:39:27 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A221B8C@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-14-git-send-email-yi.l.liu@intel.com>
 <20200402000225.GC7174@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A21EAAD@SHSMSX104.ccr.corp.intel.com>
 <20200402134436.GI7174@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A220DE7@SHSMSX104.ccr.corp.intel.com>
 <20200403161931.GO103677@xz-x1>
In-Reply-To: <20200403161931.GO103677@xz-x1>
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
X-Received-From: 134.134.136.31
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiBTZW50
OiBTYXR1cmRheSwgQXByaWwgNCwgMjAyMCAxMjoyMCBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+IA0KPiBPbiBGcmksIEFwciAwMywgMjAyMCBhdCAwMzowNTo1N1BN
ICswMDAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMiwgMjAyMCA5OjQ1IFBNDQo+
ID4gPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDEzLzIyXSBpbnRlbF9pb21tdTogYWRkIFBBU0lEIGNhY2hlIG1hbmFnZW1l
bnQNCj4gPiA+IGluZnJhc3RydWN0dXJlDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBBcHIgMDIsIDIw
MjAgYXQgMDY6NDY6MTFBTSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+ID4NCj4gPiA+IFsu
Li5dDQo+ID4gPg0KPiA+ID4gPiA+ID4gKy8qKg0KPiA+ID4gPiA+ID4gKyAqIFRoaXMgZnVuY3Rp
b24gcmVwbGF5IHRoZSBndWVzdCBwYXNpZCBiaW5kaW5ncyB0byBob3RzIGJ5DQo+ID4gPiA+ID4g
PiArICogd2Fsa2luZyB0aGUgZ3Vlc3QgUEFTSUQgdGFibGUuIFRoaXMgZW5zdXJlcyBob3N0IHdp
bGwgaGF2ZQ0KPiA+ID4gPiA+ID4gKyAqIGxhdGVzdCBndWVzdCBwYXNpZCBiaW5kaW5ncy4gQ2Fs
bGVyIHNob3VsZCBob2xkIGlvbW11X2xvY2suDQo+ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4g
PiArc3RhdGljIHZvaWQgdnRkX3JlcGxheV9ndWVzdF9wYXNpZF9iaW5kaW5ncyhJbnRlbElPTU1V
U3RhdGUgKnMsDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBWVERQQVNJRENhY2hlSW5mbw0KPiA+ID4gPiA+ID4gKypwY19pbmZvKSB7DQo+
ID4gPiA+ID4gPiArICAgIFZUREhvc3RJT01NVUNvbnRleHQgKnZ0ZF9kZXZfaWN4Ow0KPiA+ID4g
PiA+ID4gKyAgICBpbnQgc3RhcnQgPSAwLCBlbmQgPSBWVERfSFBBU0lEX01BWDsNCj4gPiA+ID4g
PiA+ICsgICAgdnRkX3Bhc2lkX3RhYmxlX3dhbGtfaW5mbyB3YWxrX2luZm8gPSB7LmZsYWdzID0g
MH07DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBTbyB2dGRfcGFzaWRfdGFibGVfd2Fsa19pbmZvIGlz
IHN0aWxsIHVzZWQuICBJIHRob3VnaHQgd2UgaGFkDQo+ID4gPiA+ID4gcmVhY2hlZCBhIGNvbnNl
bnN1cyB0aGF0IHRoaXMgY2FuIGJlIGRyb3BwZWQ/DQo+ID4gPiA+DQo+ID4gPiA+IHllYWgsIEkg
ZGlkIGhhdmUgY29uc2lkZXJlZCB5b3VyIHN1Z2dlc3Rpb24gYW5kIHBsYW4gdG8gZG8gaXQuIEJ1
dA0KPiA+ID4gPiB3aGVuIEkgc3RhcnRlZCBjb2RpbmcsIGl0IGxvb2tzIGEgbGl0dGxlIGJpdCB3
ZWlyZCB0byBtZToNCj4gPiA+ID4gRm9yIG9uZSwgdGhlcmUgaXMgYW4gaW5wdXQgVlREUEFTSURD
YWNoZUluZm8gaW4gdGhpcyBmdW5jdGlvbi4gSXQgbWF5DQo+ID4gPiA+IGJlIG5hdHVyZSB0byB0
aGluayBhYm91dCBwYXNzaW5nIHRoZSBwYXJhbWV0ZXIgdG8gZnVydGhlciBjYWxsaW5nDQo+ID4g
PiA+ICh2dGRfcmVwbGF5X3Bhc2lkX2JpbmRfZm9yX2RldigpKS4gQnV0LCB3ZSBjYW4ndCBkbyB0
aGF0LiBUaGUNCj4gPiA+ID4gdnRkX2J1cy9kZXZmbiBmaWVsZHMgc2hvdWxkIGJlIGZpbGxlZCB3
aGVuIGxvb3BpbmcgdGhlIGFzc2lnbmVkDQo+ID4gPiA+IGRldmljZXMsIG5vdCB0aGUgb25lIHBh
c3NlZCBieSB2dGRfcmVwbGF5X2d1ZXN0X3Bhc2lkX2JpbmRpbmdzKCkgY2FsbGVyLg0KPiA+ID4N
Cj4gPiA+IEhhY2t5IHdheSBpcyB3ZSBjYW4gZGlyZWN0bHkgbW9kaWZ5IFZURFBBU0lEQ2FjaGVJ
bmZvKiB3aXRoIGJ1cy9kZXZmbiBmb3INCj4gdGhlDQo+ID4gPiBsb29wLiAgT3RoZXJ3aXNlIHdl
IGNhbiBkdXBsaWNhdGUgdGhlIG9iamVjdCB3aGVuIGxvb3BpbmcsIHNvIHRoYXQgd2UgY2FuIGF2
b2lkDQo+ID4gPiBpbnRyb2R1Y2luZyBhIG5ldyBzdHJ1Y3Qgd2hpY2ggc2VlbXMgdG8gY29udGFp
biBtb3N0bHkgdGhlIHNhbWUgaW5mb3JtYXRpb24uDQo+ID4NCj4gPiBJIHNlZS4gUGxlYXNlIHNl
ZSBiZWxvdyByZXBseS4NCj4gPg0KPiA+ID4gPiBGb3IgdHdvLCByZXVzaW5nIHRoZSBWVERQQVNJ
RENhY2hlSW5mbyBmb3IgcGFzc2luZyB3YWxrIGluZm8gbWF5DQo+ID4gPiA+IHJlcXVpcmUgdGhl
IGZpbmFsIHVzZXIgZG8gdGhlIHNhbWUgdGhpbmcgYXMgd2hhdCB0aGUNCj4gPiA+ID4gdnRkX3Jl
cGxheV9ndWVzdF9wYXNpZF9iaW5kaW5ncygpIGhhcyBkb25lIGhlcmUuDQo+ID4gPg0KPiA+ID4g
SSBkb24ndCBzZWUgaXQgaGFwcGVuLCBjb3VsZCB5b3UgZXhwbGFpbj8NCj4gPg0KPiA+IG15IGNv
bmNlcm4gaXMgYXJvdW5kIGZsYWdzIGZpZWxkIGluIFZURFBBU0lEQ2FjaGVJbmZvLiBUaGUgZmxh
Z3Mgbm90DQo+ID4gb25seSBpbmRpY2F0ZXMgdGhlIGludmFsaWRhdGlvbiBncmFudWxhcml0eSwg
YnV0IGFsc28gaW5kaWNhdGVzIHRoZQ0KPiA+IGZpZWxkIHByZXNlbmNlLiBlLmcuIFZURF9QQVNJ
RF9DQUNIRV9ERVZTSSBpbmRpY2F0ZXMgdGhlIHZ0ZF9idXMvZGV2Zm4NCj4gPiBmaWVsZHMgYXJl
IHZhbGlkLiBJZiByZXVzZSBpdCB0byBwYXNzIHdhbGsgaW5mbyB0byB2dGRfc21fcGFzaWRfdGFi
bGVfd2Fsa19vbmUsDQo+ID4gaXQgd291bGQgYmUgbWVhbmluZ2xlc3MgYXMgdnRkX2J1cy9kZXZm
biBmaWVsZHMgYXJlIGFsd2F5cyB2YWxpZC4gQnV0DQo+ID4gSSdtIGZpbmUgdG8gcmV1c2UgaXQn
cyBtb3JlIHByZWZlcmVkLiBJbnN0ZWFkIG9mIG1vZGlmeWluZyB0aGUgdnRkX2J1cy9kZXZuDQo+
ID4gaW4gVlREUEFTSURDYWNoZUluZm8qLCBJJ2QgcmF0aGVyIHRvIGRlZmluZSBhbm90aGVyIFZU
RFBBU0lEQ2FjaGVJbmZvIHZhcmlhYmxlDQo+ID4gYW5kIHBhc3MgaXQgdG8gdnRkX3NtX3Bhc2lk
X3RhYmxlX3dhbGtfb25lLiBUaGlzIG1heSBub3QgYWZmZWN0IHRoZSBmdXR1cmUNCj4gPiBjYWxs
ZXIgb2YgdnRkX3JlcGxheV9ndWVzdF9wYXNpZF9iaW5kaW5ncygpIGFzIHZ0ZF9idXMvZGV2Zm4g
ZmllbGQgYXJlIG5vdA0KPiA+IGRlc2lnbmVkIHRvIGJyaW5nIHNvbWV0aGluZyBiYWNrIHRvIGNh
bGxlci4NCj4gDQo+IFllYWgsIGxldCdzIGdpdmUgaXQgYSBzaG90LiAgSSBrbm93IGl0J3Mgbm90
IGlkZWFsLCBidXQgSU1ITyBpdCdzDQo+IHN0aWxsIGJldHRlciB0aGFuIGRlZmluaW5nIHRoZSBw
YWdlX3dhbGsgc3RydWN0IGFuZCB0aGF0IG1pZ2h0IGNvbmZ1c2UNCj4gcmVhZGVycyBvbiB3aGF0
J3MgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgdHdvLiAgV2hlbiBkdXBsaWNhdGluZw0KPiB0
aGUgb2JqZWN0LCB3ZSBjYW4gYWRkIHNvbWUgY29tbWVudCBleHBsYWluaW5nIHRoaXMuDQoNCmdv
dCBpdC4gSSdsbCBkcm9wIHRoZSBwYWdlX3dhbGsgc3RydWN0IGFuZCBhZGQgYWRkaXRpb25hbCBj
b21tZW50cy4gOi0pDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==


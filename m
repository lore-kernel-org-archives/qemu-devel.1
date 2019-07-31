Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4AC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BC720679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 23:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BC720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsxxV-00052O-4k
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 19:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51614)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kevin.tian@intel.com>) id 1hsxwZ-000433-VW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1hsxwZ-0001TB-3H
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 19:23:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:5182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1hsxwY-0001OU-Rj; Wed, 31 Jul 2019 19:23:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 16:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,332,1559545200"; d="scan'208";a="174973704"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga003.jf.intel.com with ESMTP; 31 Jul 2019 16:23:29 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 31 Jul 2019 16:23:28 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 31 Jul 2019 16:23:28 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.112]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.163]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 07:23:26 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the IOAPIC MSI
 reserved region when relevant
Thread-Index: AQHVRvuB+lYfnIqunUiYF7Ql9SMCpqbjCI0AgADC99CAAMu+AIAABW2AgADAzMA=
Date: Wed, 31 Jul 2019 23:23:26 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19CAFD1AF@SHSMSX104.ccr.corp.intel.com>
References: <20190730172137.23114-1-eric.auger@redhat.com>
 <20190730172137.23114-12-eric.auger@redhat.com>
 <20190730153628-mutt-send-email-mst@kernel.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19CAF8E1B@SHSMSX104.ccr.corp.intel.com>
 <20190731151834-mutt-send-email-mst@kernel.org>
 <95de34e9-1b1a-3eff-cebb-ee146e9acc78@redhat.com>
In-Reply-To: <95de34e9-1b1a-3eff-cebb-ee146e9acc78@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDQ3ZTA0ZTktNDgwNC00ZjcwLWFkZjgtMDNkMTI3YTM5ZmNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoib2lZR0hYWkZqbStORFBUdktsdldMU0wweTVNV3FHMlZMNThETzVnTmRBVjM3elVEbHIrclJvTTVcL1B2RUI0WFIifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH for-4.2 v10 11/15] virtio-iommu: Expose the
 IOAPIC MSI reserved region when relevant
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "tn@semihalf.com" <tn@semihalf.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBBdWdlciBFcmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50
OiBUaHVyc2RheSwgQXVndXN0IDEsIDIwMTkgMzo0NSBBTQ0KPiANCj4gSGkgTWljaGFlbCwNCj4g
DQo+IE9uIDcvMzEvMTkgOToyNSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgSnVsIDMwLCAyMDE5IGF0IDExOjIwOjQ0UE0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3Rl
Og0KPiA+Pj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIFttYWlsdG86bXN0QHJlZGhhdC5jb21d
DQo+ID4+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMzEsIDIwMTkgMzozOCBBTQ0KPiA+Pj4NCj4g
Pj4+IE9uIFR1ZSwgSnVsIDMwLCAyMDE5IGF0IDA3OjIxOjMzUE0gKzAyMDAsIEVyaWMgQXVnZXIg
d3JvdGU6DQo+ID4+Pj4gV2UgaW50cm9kdWNlIGEgbmV3IG1zaV9ieXBhc3MgZmllbGQgd2hpY2gg
aW5kaWNhdGVzIHdoZXRoZXINCj4gPj4+PiB0aGUgSU9BUElDIE1TSSB3aW5kb3cgWzB4RkVFMDAw
MDAgLSAweEZFRUZGRkZGXSBtdXN0IGJlIGV4cG9zZWQNCj4gPj4NCj4gPj4gaXQncyBub3QgZ29v
ZCB0byBjYWxsIGl0IElPQVBJQyBNU0kgd2luZG93LiBhbnkgd3JpdGUgdG8gdGhpcyByYW5nZSwg
ZWl0aGVyDQo+ID4+IGZyb20gSU9BUElDIG9yIFBDSSBkZXZpY2UsIGlzIGludGVycHJldGVkIGJ5
IHRoZSBwbGF0Zm9ybSBhcyBpbnRlcnJ1cHQNCj4gPj4gcmVxdWVzdC4gSSdkIGNhbGwgaXQgIng4
NiBpbnRlcnJ1cHQgYWRkcmVzcyByYW5nZSIuDQo+ID4NCj4gPiBJc24ndCB0aGlzIEFQSUNfREVG
QVVMVF9BRERSRVNTPyBJJ20gbm90IHN1cmUgZ3Vlc3RzIGNhbid0IGNoYW5nZSBpdA0KPiA+IGV2
ZW4gdGhvdWdoIEknbSBub3Qgc3VyZSBxZW11IHN1cHBvcnRzIGNoYW5naW5nIGl0Lg0KPiANCj4g
VGhhdCdzIGluZGVlZCBtYXRjaGluZzoNCj4gDQo+ICNkZWZpbmUgQVBJQ19ERUZBVUxUX0FERFJF
U1MgMHhmZWUwMDAwMA0KPiAjZGVmaW5lIEFQSUNfU1BBQ0VfU0laRSAgICAgIDB4MTAwMDAwDQo+
IA0KDQpUaGV5IGFyZSBkaWZmZXJlbnQgdGhpbmcsIHRob3VnaCB2YWx1ZSBtYXRjaGVzLiBBUElD
IGRlZmF1bHQgYWRkcmVzcw0KaXMgdGhlIG1lbW9yeS1tYXBwZWQgcmVnaW9uIGZvciBzb2Z0d2Fy
ZSB0byBhY2Nlc3MgQVBJQyByZWdpc3Rlci4gSXQNCmNhbiBiZSByZWxvY2F0ZWQgYnkgdGhlIHNv
ZnR3YXJlLCB3aXRoIGRlZmF1bHQgYXMgMHhmZWUwMDAwMC4gT24gdGhlDQpvdGhlciBoYW5kLCB0
aGUgaW50ZXJydXB0IGFkZHJlc3MgcmFuZ2UgaXMgZm9yIHJvb3QgY29tcGxleCB0byBpbnRlcnBy
ZXQNCmludGVycnVwdCBtZXNzYWdlIGZyb20gZGV2aWNlcy4gWW91IGNhbiBsb29rIGF0IEludGVs
IFNETSAzQSwgMTAuMTENCk1lc3NhZ2UgU2lnbmFsbGVkIEludGVycnVwdHMsIHdoZXJlIHRoZSBt
ZXNzYWdlIGFkZHJlc3MgcmVnaXN0ZXINCmZvcm1hdCBpcyBkZWZpbmVkIHdpdGggMHhmZWUgYXMg
dGhlIGhhcmQgcHJlZml4Lg0KDQpUaGFua3MNCktldmluDQo=


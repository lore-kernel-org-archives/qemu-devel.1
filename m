Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE56CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 07:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5222085B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 07:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5222085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQnxE-0002Bd-3u
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 03:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iQnwY-0001fZ-EY
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 03:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iQnwW-0006K5-Gv
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 03:35:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:40417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iQnwW-0006Hc-9Z
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 03:35:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Nov 2019 00:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,258,1569308400"; d="scan'208";a="204080629"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga003.jf.intel.com with ESMTP; 02 Nov 2019 00:35:23 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 2 Nov 2019 00:35:23 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 2 Nov 2019 00:35:22 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.41]) with mapi id 14.03.0439.000;
 Sat, 2 Nov 2019 15:35:21 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Thread-Topic: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VM
Thread-Index: AQHVimskKWib+KQlOUaXXMOVBk8bu6dql/6AgACL3iCACInPAIAAoJWAgAEjFoCAAIoK8P//f5WAgAABiYCAAg37kA==
Date: Sat, 2 Nov 2019 07:35:19 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5E2309@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <367adad0-eb05-c950-21d7-755fffacbed6@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0619@SHSMSX104.ccr.corp.intel.com>
 <fa994379-a847-0ffe-5043-40a2aefecf43@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A0EACA6@SHSMSX104.ccr.corp.intel.com>
 <960389b5-2ef4-8921-fc28-67c9a6398c43@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5E17C7@SHSMSX104.ccr.corp.intel.com>
 <18534f1b-3488-994b-73e2-17e7d8ccb4c2@redhat.com>
 <4fae7d47-93c6-1278-b55e-ec06fa3ca7f1@redhat.com>
In-Reply-To: <4fae7d47-93c6-1278-b55e-ec06fa3ca7f1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTk1MDM1NTItOTQ0Yi00NGQxLTk1NWItMWY3NmRkMTQxNjVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYkJLM1ZGZmxDSE9ISDZuXC9SVXFPelc4azh4UnhYU3p2NWRmcld2K1hKZkdmZkdBNlEzaXFuSEF1eXJSRHhvbjEifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gU2VudDog
RnJpZGF5LCBOb3ZlbWJlciAxLCAyMDE5IDQ6MTAgUE0NCj4gDQo+IA0KPiBPbiAyMDE5LzExLzEg
5LiL5Y2INDowNCwgSmFzb24gV2FuZyB3cm90ZToNCj4gPg0KPiA+IE9uIDIwMTkvMTEvMSDkuIvl
jYgzOjQ2LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+IEZyb206IEphc29uIFdhbmcgW21haWx0
bzpqYXNvd2FuZ0ByZWRoYXQuY29tXQ0KPiA+Pj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAy
MDE5IDM6MzAgUE0NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gT24gMjAxOS8xMC8zMSDkuIvljYgxMDow
NywgTGl1LCBZaSBMIHdyb3RlOg0KPiA+Pj4+PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFz
b3dhbmdAcmVkaGF0LmNvbV0NCj4gPj4+Pj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMzEsIDIw
MTkgNTozMyBBTQ0KPiA+Pj4+PiBTdWJqZWN0OiBSZTogW1JGQyB2MiAwMC8yMl0gaW50ZWxfaW9t
bXU6IGV4cG9zZSBTaGFyZWQgVmlydHVhbA0KPiA+Pj4gQWRkcmVzc2luZyB0byBWTQ0KPiA+Pj4+
Pg0KPiA+Pj4+PiBPbiAyMDE5LzEwLzI1IOS4i+WNiDY6MTIsIFRpYW4sIEtldmluIHdyb3RlOg0K
PiA+Pj4+Pj4+IEZyb206IEphc29uIFdhbmcgW21haWx0bzpqYXNvd2FuZ0ByZWRoYXQuY29tXQ0K
PiA+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNSwgMjAxOSA1OjQ5IFBNDQo+ID4+Pj4+
Pj4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IE9uIDIwMTkvMTAvMjQg5LiL5Y2IODozNCwgTGl1IFlp
IEwgd3JvdGU6DQo+ID4+Pj4+Pj4+IFNoYXJlZCB2aXJ0dWFsIGFkZHJlc3MgKFNWQSksIGEuay5h
LCBTaGFyZWQgdmlydHVhbCBtZW1vcnkNCj4gPj4+Pj4+Pj4gKFNWTSkgb24NCj4gPj4+Pj4+Pj4g
SW50ZWwgcGxhdGZvcm1zIGFsbG93IGFkZHJlc3Mgc3BhY2Ugc2hhcmluZyBiZXR3ZWVuIGRldmlj
ZSBETUENCj4gPj4+IGFuZA0KPiA+Pj4+Pj4+IGFwcGxpY2F0aW9ucy4NCj4gPj4+Pj4+Pg0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gSW50ZXJlc3RpbmcsIHNvIHRoZSBiZWxvdyBmaWd1cmUgZGVtb25z
dHJhdGVzIHRoZSBjYXNlIG9mIFZNLiBJDQo+ID4+Pj4+Pj4gd29uZGVyIGhvdyBtdWNoIGRpZmZl
cmVuY2VzIGlmIHdlIGNvbXBhcmUgaXQgd2l0aCBkb2luZyBTVk0NCj4gPj4+IGJldHdlZW4NCj4g
Pj4+Pj4+PiBkZXZpY2UgYW5kIGFuIG9yZGluYXJ5IHByb2Nlc3MgKGUuZyBkcGRrKT8NCj4gPj4+
Pj4+Pg0KPiA+Pj4+Pj4+IFRoYW5rcw0KPiA+Pj4+Pj4gT25lIGRpZmZlcmVuY2UgaXMgdGhhdCBv
cmRpbmFyeSBwcm9jZXNzIHJlcXVpcmVzIG9ubHkgc3RhZ2UtMQ0KPiA+Pj4+Pj4gdHJhbnNsYXRp
b24sIHdoaWxlIFZNIHJlcXVpcmVzIG5lc3RlZCB0cmFuc2xhdGlvbi4NCj4gPj4+Pj4gQSBzaWxs
eSBxdWVzdGlvbiwgdGhlbiBJIGJlbGlldmUgdGhlcmUncyBubyBuZWVkIGZvciBWRklPIERNQSBB
UEkNCj4gPj4+Pj4gaW4gdGhpcw0KPiA+Pj4gY2FzZSBjb25zaWRlcg0KPiA+Pj4+PiB0aGUgcGFn
ZSB0YWJsZSBpcyBzaGFyZWQgYmV0d2VlbiBNTVUgYW5kIElPTU1VPw0KPiA+Pj4+IEVjaG8gS2V2
aW4ncyByZXBseS4gV2UgdXNlIG5lc3RlZCB0cmFuc2xhdGlvbiBoZXJlLiBGb3Igc3RhZ2UtMSwN
Cj4gPj4+PiB5ZXMsIG5vDQo+ID4+PiBuZWVkIHRvIHVzZQ0KPiA+Pj4+IFZGSU8gRE1BIEFQSS4g
Rm9yIHN0YWdlLTIsIHdlIHN0aWxsIHVzZSBWRklPIERNQSBBUEkgdG8gcHJvZ3JhbSB0aGUNCj4g
Pj4+IEdQQS0+SFBBDQo+ID4+Pj4gbWFwcGluZyB0byBob3N0LiA6LSkNCj4gPj4+DQo+ID4+PiBD
b29sLCB0d28gbW9yZSBxdWVzdGlvbnM6DQo+ID4+Pg0KPiA+Pj4gLSBDYW4gRVBUIHNoYXJlcyBp
dHMgcGFnZSB0YWJsZSB3aXRoIElPTU1VIEwyPw0KPiA+PiB5ZXMsIHRoZWlyIGZvcm1hdHMgYXJl
IGNvbXBhdGlibGUuDQo+ID4+DQo+ID4+PiAtIFNpbWlsYXIgdG8gRVBULCB3aGVuIEdQQS0+SFBB
IChhY3R1YWxseSBIVkEtPkhQQSkgaXMgbW9kaWZpZWQgYnkNCj4gbW0sDQo+ID4+PiBWRklPIG5l
ZWQgdG8gdXNlIE1NVSBub3RpZmllciBkbyBtb2RpZnkgTDIgYWNjb3JkaW5nbHkgYmVzaWRlcyBE
TUENCj4gQVBJPw0KPiA+Pj4NCj4gPj4gVkZJTyBkZXZpY2VzIG5lZWQgdG8gcGluLWRvd24gZ3Vl
c3QgbWVtb3J5IHBhZ2VzIHRoYXQgYXJlIG1hcHBlZA0KPiA+PiBpbiBJT01NVS4gU28gbm90aWZp
ZXIgaXMgbm90IHJlcXVpcmVkIHNpbmNlIG1tIHdvbid0IGNoYW5nZSB0aGUNCj4gbWFwcGluZw0K
PiA+PiBmb3IgdGhvc2UgcGFnZXMuDQo+ID4NCj4gPg0KPiA+IFRoZSBHVVAgdGVuZHMgdG8gbGVh
ZCBhIGxvdCBvZiBpc3N1ZXMsIHdlIG1heSBjb25zaWRlciB0byBhbGxvdw0KPiA+IHVzZXJzcGFj
ZSB0byBjaG9vc2UgdG8gbm90IHBpbiB0aGVtIGluIHRoZSBmdXR1cmUuDQo+IA0KPiANCj4gQnR3
LCBJJ20gYXNraW5nIHNpbmNlIEkgc2VlIE1NVSBub3RpZmllciBpcyB1c2VkIGJ5IGludGVsLXN2
bS5jIHRvIGZsdXNoDQo+IElPVExCLiAoSSBkb24ndCBzZWUgYW55IHVzZXJzIGluIGtlcm5lbCBz
b3VyY2UgdGhhdCB1c2UgdGhhdCBBUEkgdGhvdWdoDQo+IGUuZyBpbnRlbF9zdm1fYmluZF9tbSgp
KS4NCj4gDQoNCmludGVsLXN2bS5jIHJlcXVpcmVzIE1NVSBub3RpZmllciB0byBpbnZhbGlkYXRl
IElPVExCIHVwb24gYW55IGNoYW5nZQ0Kb24gdGhlIENQVSBwYWdlIHRhYmxlLCB3aGVuIHRoZSBs
YXR0ZXIgaXMgc2hhcmVkIHdpdGggZGV2aWNlIGluIFNWQQ0KY2FzZS4gQnV0IGZvciBWRklPIHVz
YWdlLCB3aGljaCBpcyBiYXNlZCBvbiBzdGFnZTIsIHRoZSBtYXAvdW5tYXAgDQpyZXF1ZXN0cyBl
eHBsaWNpdGx5IGNvbWUgZnJvbSB1c2Vyc3BhY2UuIHRoZXJlIGlzIG5vIG5lZWQgdG8gc3luYyB3
aXRoDQptbS4NCg0KVGhhbmtzDQpLZXZpbg0K


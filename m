Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E3ECA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BD02080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 07:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BD02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQReU-00052F-10
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 03:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iQRdZ-0004ZQ-OZ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iQRdX-0001FP-2N
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:46:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:10991)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iQRdW-0000zI-KR
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 03:46:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Nov 2019 00:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,254,1569308400"; d="scan'208";a="402149365"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga006.fm.intel.com with ESMTP; 01 Nov 2019 00:46:14 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 1 Nov 2019 00:46:14 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 1 Nov 2019 00:46:13 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.2]) with mapi id 14.03.0439.000;
 Fri, 1 Nov 2019 15:46:11 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Thread-Topic: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VM
Thread-Index: AQHVimskKWib+KQlOUaXXMOVBk8bu6dql/6AgACL3iCACInPAIAAoJWAgAEjFoCAAIoK8A==
Date: Fri, 1 Nov 2019 07:46:11 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5E17C7@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <367adad0-eb05-c950-21d7-755fffacbed6@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0619@SHSMSX104.ccr.corp.intel.com>
 <fa994379-a847-0ffe-5043-40a2aefecf43@redhat.com>
 <A2975661238FB949B60364EF0F2C25743A0EACA6@SHSMSX104.ccr.corp.intel.com>
 <960389b5-2ef4-8921-fc28-67c9a6398c43@redhat.com>
In-Reply-To: <960389b5-2ef4-8921-fc28-67c9a6398c43@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTdhNzUyNzUtYjk5YS00ZTAwLThjMjMtMzVjZWVkNzU5YWNiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNXJrYm5tMEhaakxEQk1UUjFpSloxRzVWVTJUUDhvQUxlZWI0MkV6UE9VWmpDcUpmS3JEanhkdVhsZTVDeGZuaCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
RnJpZGF5LCBOb3ZlbWJlciAxLCAyMDE5IDM6MzAgUE0NCj4gDQo+IA0KPiBPbiAyMDE5LzEwLzMx
IOS4i+WNiDEwOjA3LCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4+IEZyb206IEphc29uIFdhbmcgW21h
aWx0bzpqYXNvd2FuZ0ByZWRoYXQuY29tXQ0KPiA+PiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAz
MSwgMjAxOSA1OjMzIEFNDQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIHYyIDAwLzIyXSBpbnRlbF9p
b21tdTogZXhwb3NlIFNoYXJlZCBWaXJ0dWFsDQo+IEFkZHJlc3NpbmcgdG8gVk0NCj4gPj4NCj4g
Pj4NCj4gPj4gT24gMjAxOS8xMC8yNSDkuIvljYg2OjEyLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4g
Pj4+PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPj4+
PiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjUsIDIwMTkgNTo0OSBQTQ0KPiA+Pj4+DQo+ID4+Pj4N
Cj4gPj4+PiBPbiAyMDE5LzEwLzI0IOS4i+WNiDg6MzQsIExpdSBZaSBMIHdyb3RlOg0KPiA+Pj4+
PiBTaGFyZWQgdmlydHVhbCBhZGRyZXNzIChTVkEpLCBhLmsuYSwgU2hhcmVkIHZpcnR1YWwgbWVt
b3J5IChTVk0pIG9uDQo+ID4+Pj4+IEludGVsIHBsYXRmb3JtcyBhbGxvdyBhZGRyZXNzIHNwYWNl
IHNoYXJpbmcgYmV0d2VlbiBkZXZpY2UgRE1BDQo+IGFuZA0KPiA+Pj4+IGFwcGxpY2F0aW9ucy4N
Cj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gSW50ZXJlc3RpbmcsIHNvIHRoZSBiZWxvdyBmaWd1cmUg
ZGVtb25zdHJhdGVzIHRoZSBjYXNlIG9mIFZNLiBJDQo+ID4+Pj4gd29uZGVyIGhvdyBtdWNoIGRp
ZmZlcmVuY2VzIGlmIHdlIGNvbXBhcmUgaXQgd2l0aCBkb2luZyBTVk0NCj4gYmV0d2Vlbg0KPiA+
Pj4+IGRldmljZSBhbmQgYW4gb3JkaW5hcnkgcHJvY2VzcyAoZS5nIGRwZGspPw0KPiA+Pj4+DQo+
ID4+Pj4gVGhhbmtzDQo+ID4+PiBPbmUgZGlmZmVyZW5jZSBpcyB0aGF0IG9yZGluYXJ5IHByb2Nl
c3MgcmVxdWlyZXMgb25seSBzdGFnZS0xDQo+ID4+PiB0cmFuc2xhdGlvbiwgd2hpbGUgVk0gcmVx
dWlyZXMgbmVzdGVkIHRyYW5zbGF0aW9uLg0KPiA+Pg0KPiA+PiBBIHNpbGx5IHF1ZXN0aW9uLCB0
aGVuIEkgYmVsaWV2ZSB0aGVyZSdzIG5vIG5lZWQgZm9yIFZGSU8gRE1BIEFQSSBpbiB0aGlzDQo+
IGNhc2UgY29uc2lkZXINCj4gPj4gdGhlIHBhZ2UgdGFibGUgaXMgc2hhcmVkIGJldHdlZW4gTU1V
IGFuZCBJT01NVT8NCj4gPiBFY2hvIEtldmluJ3MgcmVwbHkuIFdlIHVzZSBuZXN0ZWQgdHJhbnNs
YXRpb24gaGVyZS4gRm9yIHN0YWdlLTEsIHllcywgbm8NCj4gbmVlZCB0byB1c2UNCj4gPiBWRklP
IERNQSBBUEkuIEZvciBzdGFnZS0yLCB3ZSBzdGlsbCB1c2UgVkZJTyBETUEgQVBJIHRvIHByb2dy
YW0gdGhlDQo+IEdQQS0+SFBBDQo+ID4gbWFwcGluZyB0byBob3N0LiA6LSkNCj4gDQo+IA0KPiBD
b29sLCB0d28gbW9yZSBxdWVzdGlvbnM6DQo+IA0KPiAtIENhbiBFUFQgc2hhcmVzIGl0cyBwYWdl
IHRhYmxlIHdpdGggSU9NTVUgTDI/DQoNCnllcywgdGhlaXIgZm9ybWF0cyBhcmUgY29tcGF0aWJs
ZS4NCg0KPiANCj4gLSBTaW1pbGFyIHRvIEVQVCwgd2hlbiBHUEEtPkhQQSAoYWN0dWFsbHkgSFZB
LT5IUEEpIGlzIG1vZGlmaWVkIGJ5IG1tLA0KPiBWRklPIG5lZWQgdG8gdXNlIE1NVSBub3RpZmll
ciBkbyBtb2RpZnkgTDIgYWNjb3JkaW5nbHkgYmVzaWRlcyBETUEgQVBJPw0KPiANCg0KVkZJTyBk
ZXZpY2VzIG5lZWQgdG8gcGluLWRvd24gZ3Vlc3QgbWVtb3J5IHBhZ2VzIHRoYXQgYXJlIG1hcHBl
ZA0KaW4gSU9NTVUuIFNvIG5vdGlmaWVyIGlzIG5vdCByZXF1aXJlZCBzaW5jZSBtbSB3b24ndCBj
aGFuZ2UgdGhlIG1hcHBpbmcNCmZvciB0aG9zZSBwYWdlcy4NCg0KVGhhbmtzDQpLZXZpbg0K


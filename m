Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E76CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 05:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6A120862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 05:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6A120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ3DD-00055z-QN
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 01:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1iQ3C7-0004ds-Gh
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 01:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1iQ3C5-0000MQ-Lg
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 01:40:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:35545)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1iQ3C5-0000HA-Dp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 01:40:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 22:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; d="scan'208";a="230728280"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by fmsmga002.fm.intel.com with ESMTP; 30 Oct 2019 22:40:13 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 22:40:03 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 22:40:02 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.127]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.215]) with mapi id 14.03.0439.000;
 Thu, 31 Oct 2019 13:39:59 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing to VM
Thread-Topic: [RFC v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VM
Thread-Index: AQHVimskKWib+KQlOUaXXMOVBk8bu6dql/6AgACL3iCACInPAIAAmD6A
Date: Thu, 31 Oct 2019 05:39:59 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D5E049B@SHSMSX104.ccr.corp.intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <367adad0-eb05-c950-21d7-755fffacbed6@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D5D0619@SHSMSX104.ccr.corp.intel.com>
 <fa994379-a847-0ffe-5043-40a2aefecf43@redhat.com>
In-Reply-To: <fa994379-a847-0ffe-5043-40a2aefecf43@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODZlMDkzZGMtMDRjNS00Nzk2LWJjNDktMTAyZTVlM2I1MTRlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRG01dzFJSnhDMXdhQmUrNkE2Q1F1NFFQQUxvUGpSOFZmRzFYQ3FXSWdtNm1weTBCdTFRWWh5ZlZwWmdmN2dnUSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
VGh1cnNkYXksIE9jdG9iZXIgMzEsIDIwMTkgMTI6MzMgUE0NCj4gDQo+IA0KPiBPbiAyMDE5LzEw
LzI1IOS4i+WNiDY6MTIsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBKYXNvbiBXYW5n
IFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPj4gU2VudDogRnJpZGF5LCBPY3RvYmVy
IDI1LCAyMDE5IDU6NDkgUE0NCj4gPj4NCj4gPj4NCj4gPj4gT24gMjAxOS8xMC8yNCDkuIvljYg4
OjM0LCBMaXUgWWkgTCB3cm90ZToNCj4gPj4+IFNoYXJlZCB2aXJ0dWFsIGFkZHJlc3MgKFNWQSks
IGEuay5hLCBTaGFyZWQgdmlydHVhbCBtZW1vcnkgKFNWTSkgb24NCj4gSW50ZWwNCj4gPj4+IHBs
YXRmb3JtcyBhbGxvdyBhZGRyZXNzIHNwYWNlIHNoYXJpbmcgYmV0d2VlbiBkZXZpY2UgRE1BIGFu
ZA0KPiA+PiBhcHBsaWNhdGlvbnMuDQo+ID4+DQo+ID4+DQo+ID4+IEludGVyZXN0aW5nLCBzbyB0
aGUgYmVsb3cgZmlndXJlIGRlbW9uc3RyYXRlcyB0aGUgY2FzZSBvZiBWTS4gSSB3b25kZXINCj4g
Pj4gaG93IG11Y2ggZGlmZmVyZW5jZXMgaWYgd2UgY29tcGFyZSBpdCB3aXRoIGRvaW5nIFNWTSBi
ZXR3ZWVuIGRldmljZQ0KPiA+PiBhbmQNCj4gPj4gYW4gb3JkaW5hcnkgcHJvY2VzcyAoZS5nIGRw
ZGspPw0KPiA+Pg0KPiA+PiBUaGFua3MNCj4gPiBPbmUgZGlmZmVyZW5jZSBpcyB0aGF0IG9yZGlu
YXJ5IHByb2Nlc3MgcmVxdWlyZXMgb25seSBzdGFnZS0xIHRyYW5zbGF0aW9uLA0KPiA+IHdoaWxl
IFZNIHJlcXVpcmVzIG5lc3RlZCB0cmFuc2xhdGlvbi4NCj4gDQo+IA0KPiBBIHNpbGx5IHF1ZXN0
aW9uLCB0aGVuIEkgYmVsaWV2ZSB0aGVyZSdzIG5vIG5lZWQgZm9yIFZGSU8gRE1BIEFQSSBpbg0K
PiB0aGlzIGNhc2UgY29uc2lkZXIgdGhlIHBhZ2UgdGFibGUgaXMgc2hhcmVkIGJldHdlZW4gTU1V
IGFuZCBJT01NVT8NCj4gDQoNCnllcywgb25seSBuZWVkIHRvIGludGVyY2VwdCBndWVzdCBpb3Rs
YiBpbnZhbGlkYXRpb24gcmVxdWVzdCBvbiBzdGFnZS0xIA0KdHJhbnNsYXRpb24gYW5kIHRoZW4g
Zm9yd2FyZCB0byBJT01NVSB0aHJvdWdoIG5ldyBWRklPIEFQSS4gRXhpc3RpbmcNClZGSU8gRE1B
IEFQSSBhcHBsaWVzIHRvIG9ubHkgdGhlIHN0YWdlLTIgdHJhbnNsYXRpb24gKEdQQS0+SFBBKSBo
ZXJlLg0KDQpUaGFua3MNCktldmluDQo=


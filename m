Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC357C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 08:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91850217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 08:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91850217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2tAC-00019H-RP
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 03:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j2t9e-0000kO-JF
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j2t9d-0005oo-K1
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:50:26 -0500
Received: from mga18.intel.com ([134.134.136.126]:28505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j2t9d-0005na-BC
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 03:50:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Feb 2020 00:50:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,443,1574150400"; d="scan'208";a="433280509"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga005.fm.intel.com with ESMTP; 15 Feb 2020 00:50:23 -0800
Received: from fmsmsx152.amr.corp.intel.com (10.18.125.5) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 15 Feb 2020 00:50:23 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX152.amr.corp.intel.com (10.18.125.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 15 Feb 2020 00:50:22 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.201]) with mapi id 14.03.0439.000;
 Sat, 15 Feb 2020 16:50:20 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v3 16/25] intel_iommu: add PASID cache management
 infrastructure
Thread-Topic: [RFC v3 16/25] intel_iommu: add PASID cache management
 infrastructure
Thread-Index: AQHV1p1QpD/IVrZuSU6bcoY7cN43AagWNKIAgAEU7GD///SzgIABQpxQgABMTYCAAz89AA==
Date: Sat, 15 Feb 2020 08:50:20 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1BE87E@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-17-git-send-email-yi.l.liu@intel.com>
 <20200211233548.GO984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA669@SHSMSX104.ccr.corp.intel.com>
 <20200212152629.GA1083891@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BBCA9@SHSMSX104.ccr.corp.intel.com>
 <20200213151415.GC1103216@xz-x1>
In-Reply-To: <20200213151415.GC1103216@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjJmNDcwZmUtMWVkMS00OGMzLTk1YTQtMDllOTgzOTNlYzQ4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid3VKVE5cL0ltdHdpOW8wZEp2MUFRSUJpWDFzc0dtYWZKXC94YUIyTVBPOGx2bm8xanluUHRkVExJTkxlVEUyeUJnIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo
 Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgWHUgPHBldGVy
eEByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMTMsIDIwMjAgMTE6MTQg
UE0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1JGQyB2MyAxNi8yNV0gaW50ZWxfaW9tbXU6IGFkZCBQQVNJRCBjYWNoZSBtYW5hZ2VtZW50DQo+
IGluZnJhc3RydWN0dXJlDQo+IA0KPiBPbiBUaHUsIEZlYiAxMywgMjAyMCBhdCAwMjo1OTozN0FN
ICswMDAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gPiAtIFJlbW92ZSB0aGUgdnRkX3Bhc2lkX2Fz
IGNoZWNrIHJpZ2h0IGJlbG93IGJlY2F1c2UgaXQncyBub3QgbmVlZGVkLg0KPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICsgICAgICAgIGlmICh2dGRfcGFzaWRfYXMgJiYNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl4NCj4gPg0KPiA+IHllcywgaXQgaXMu
IEluIGN1cnJlbnQgc2VyaWVzIHZ0ZF9hZGRfZmluZF9wYXNpZF9hcygpIGRvZXNu4oCZdCBjaGVj
ayB0aGUNCj4gPiByZXN1bHQgb2YgdnRkX3Bhc2lkX2FzIG1lbSBhbGxvY2F0aW9uLCBzbyBubyBu
ZWVkIHRvIGNoZWNrIHZ0ZF9wYXNpZF9hcw0KPiA+IGhlcmUgZWl0aGVyLiBIb3dldmVyLCBpdCBt
aWdodCBiZSBiZXR0ZXIgdG8gY2hlY2sgdGhlIGFsbG9jYXRpb24gcmVzdWx0DQo+ID4gb3IgaXQg
d2lsbCByZXN1bHQgaW4gaXNzdWUgaWYgYWxsb2NhdGlvbiBmYWlsZWQuIFdoYXQncyB5b3VyIHBy
ZWZlcmVuY2UNCj4gPiBoZXJlPw0KPiANCj4gVGhhdCBzaG91bGQgbm90IGJlIG5lZWRlZCwgYmVj
YXVzZSBJSVJDIGdfbWFsbG9jMCgpIHdpbGwgZGlyZWN0bHkNCj4gY29yZWR1bXAgaWYgYWxsb2Nh
dGlvbiBmYWlscy4gIEV2ZW4gaWYgbm90LCBpdCdsbCBjb3JlZHVtcCBpbg0KPiB2dGRfYWRkX2Zp
bmRfcGFzaWRfYXMoKSBzb29uIHdoZW4gYWNjZXNzaW5nIHRoZSBOVUxMIHBvaW50ZXIuDQoNCkNv
b2wsIHRoYW5rcyBmb3IgdGhpcyBtZXNzYWdlLiBUaGVuIEknbGwgZm9sbG93IHlvdXIgc3VnZ2Vz
dGlvbiAgdG8gIHJlbW92ZQ0KdGhlIHZ0ZF9wYXNpZF9hcyBjaGVjay4NCg0KUmVnYXJkcywNCllp
IExpdQ0K


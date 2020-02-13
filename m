Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B765C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4080D20873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4080D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24Rp-00052S-GK
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j24Qw-0004Xm-K0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j24Qu-0007CW-Py
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:40:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:20585)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j24Qu-00077z-IA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:40:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 18:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; d="scan'208";a="233976128"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga003.jf.intel.com with ESMTP; 12 Feb 2020 18:40:48 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 18:40:47 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 18:40:47 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.222]) with mapi id 14.03.0439.000;
 Thu, 13 Feb 2020 10:40:45 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v3 14/25] intel_iommu: add virtual command capability support
Thread-Topic: [RFC v3 14/25] intel_iommu: add virtual command capability
 support
Thread-Index: AQHV1p1OZ3QtxF5MCUauWTZBa4G1JagWGOQAgAJEBHA=
Date: Thu, 13 Feb 2020 02:40:45 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1BBBF4@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-15-git-send-email-yi.l.liu@intel.com>
 <20200211215630.GN984290@xz-x1>
In-Reply-To: <20200211215630.GN984290@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzUxYTFjZGUtOTJkNy00YTRjLWJmYjYtMzI3OWJmZDNlYTNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRm9aQ05WbnNpbVNubTdqOGRLd2h1WkhFaTdaaWsrNFZMZEl0REpoSERUbTF2ZE1TZVdPY1NiVTVCMDZjdWJKNyJ9
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
RmVicnVhcnkgMTIsIDIwMjAgNTo1NyBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYzIDE0LzI1XSBpbnRlbF9pb21tdTogYWRkIHZp
cnR1YWwgY29tbWFuZCBjYXBhYmlsaXR5IHN1cHBvcnQNCj4gDQo+IE9uIFdlZCwgSmFuIDI5LCAy
MDIwIGF0IDA0OjE2OjQ1QU0gLTA4MDAsIExpdSwgWWkgTCB3cm90ZToNCj4gPiArLyoNCj4gPiAr
ICogVGhlIGJhc2ljIGlkZWEgaXMgdG8gbGV0IGh5cGVydmlzb3IgdG8gc2V0IGEgcmFuZ2UgZm9y
IGF2YWlsYWJsZQ0KPiA+ICsgKiBQQVNJRHMgZm9yIFZNcy4gT25lIG9mIHRoZSByZWFzb25zIGlz
IFBBU0lEICMwIGlzIHJlc2VydmVkIGJ5DQo+ID4gKyAqIFJJRF9QQVNJRCB1c2FnZS4gV2UgaGF2
ZSBubyBpZGVhIGhvdyBtYW55IHJlc2VydmVkIFBBU0lEcyBpbiBmdXR1cmUsDQo+ID4gKyAqIHNv
IGhlcmUganVzdCBhbiBldmFsdWF0ZWQgdmFsdWUuIEhvbmVzdGx5LCBzZXQgaXQgYXMgIjEiIGlz
IGVub3VnaA0KPiA+ICsgKiBhdCBjdXJyZW50IHN0YWdlLg0KPiA+ICsgKi8NCj4gPiArI2RlZmlu
ZSBWVERfTUlOX0hQQVNJRCAgICAgICAgICAgICAgMQ0KPiA+ICsjZGVmaW5lIFZURF9NQVhfSFBB
U0lEICAgICAgICAgICAgICAweEZGRkZGDQo+IA0KPiBPbmUgbW9yZSBxdWVzdGlvbjogSSBzZWUg
dGhhdCBQQVNJRCBpcyBkZWZpbmVkIGFzIDIwYml0cyBsb25nLiAgSXQncw0KPiBmaW5lLiAgSG93
ZXZlciBJIHN0YXJ0IHRvIGdldCBjb25mdXNlZCBvbiBob3cgdGhlIFNjYWxhYmxlIE1vZGUgUEFT
SUQNCj4gRGlyZWN0b3J5IGNvdWxkIHNlcnZpY2UgdGhhdCBtdWNoIG9mIFBBU0lEIGVudHJpZXMu
DQo+IA0KPiBJJ20gbG9va2luZyBhdCBzcGVjIDMuNC4zLCBGaWd1cmUgMy04Lg0KPiANCj4gRmly
c3RseSwgd2Ugb25seSBoYXZlIHR3byBsZXZlbHMgZm9yIGEgUEFTSUQgdGFibGUuICBUaGUgY29u
dGV4dCBlbnRyeQ0KPiBvZiBhIGRldmljZSBzdG9yZXMgYSBwb2ludGVyIHRvIHRoZSAiU2NhbGFi
bGUgTW9kZSBQQVNJRCBEaXJlY3RvcnkiDQo+IHBhZ2UuIEkgc2VlIHRoYXQgdGhlcmUncmUgMl4x
NCBlbnRyaWVzIGluICJTY2FsYWJsZSBNb2RlIFBBU0lEDQo+IERpcmVjdG9yeSIgcGFnZSwgZWFj
aCBpcyBhICJTY2FsYWJsZSBNb2RlIFBBU0lEIFRhYmxlIi4NCj4gSG93ZXZlci4uLiBob3cgZG8g
d2UgZml0IGluIHRoZSA0SyBwYWdlIGlmIGVhY2ggZW50cnkgaXMgYSBwb2ludGVyIG9mDQo+IHg4
Nl82NCAoOCBieXRlcykgd2hpbGUgdGhlcmUncmUgMl4xNCBlbnRyaWVzPyAgQSBzaW1wbGUgbWF0
aCBnaXZlcyBtZQ0KPiA0Sy84ID0gNTEyLCB3aGljaCBtZWFucyB0aGUgIlNjYWxhYmxlIE1vZGUg
UEFTSUQgRGlyZWN0b3J5IiBwYWdlIGNhbg0KPiBvbmx5IGhhdmUgNTEyIGVudHJpZXMsIHRoZW4g
aG93IHRoZSAyXjE0IGNvbWUgZnJvbT8gIEhtbT8/DQoNCkkgY2hlY2tlZCB3aXRoIEtldmluLiBU
aGUgc3BlYyBkb2Vzbid0IHNheSB0aGUgZGlyIHRhYmxlIGlzIDRLLiBJdCBzYXlzIDRLDQpvbmx5
IGZvciBwYXNpZCB0YWJsZS4gQWxzbywgaWYgeW91IGxvb2sgYXQgOS40LCBzY2FsYWJlLW1vZGUg
Y29udGV4dCBlbnRyeQ0KaW5jbHVkZXMgYSBQRFRTIGZpZWxkIHRvIHNwZWNpZnkgdGhlIGFjdHVh
bCBzaXplIG9mIHRoZSBkaXJlY3RvcnkgdGFibGUuDQoNCj4gQXBhcnQgb2YgdGhpczogYWxzbyBJ
IGp1c3Qgbm90aWNlZCAod2hlbiByZWFkaW5nIHRoZSBsYXR0ZXIgcGFydCBvZg0KPiB0aGUgc2Vy
aWVzKSB0aGF0IHRoZSB0aW1lIHRoYXQgYSBwYXNpZCB0YWJsZSB3YWxrIGNhbiBjb25zdW1lIHdp
bGwNCj4gZGVwZW5kIG9uIHRoaXMgdmFsdWUgdG9vLiAgSSdkIHN1Z2dlc3QgdG8gbWFrZSB0aGlz
IGFzIHNtYWxsIGFzIHdlDQo+IGNhbiwgYXMgbG9uZyBhcyBpdCBzYXRpc2ZpZXMgdGhlIHVzYWdl
LiAgV2UgY2FuIGV2ZW4gYnVtcCBpdCBpbiB0aGUNCj4gZnV0dXJlLg0KDQpJIHNlZS4gVGhpcyBs
b29rcyB0byBiZSBhbiBvcHRpbWl6YXRpb24uIHJpZ2h0PyBJbnN0ZWFkIG9mIG1vZGlmeSB0aGUN
CnZhbHVlIG9mIHRoaXMgbWFjcm8sICBJIHRoaW5rIHdlIGNhbiBkbyB0aGlzIG9wdGltaXphdGlv
biBieSB0cmFja2luZw0KdGhlIGFsbG9jYXRlZCBQQVNJRHMgaW4gUUVNVS4gVGh1cywgdGhlIHBh
c2lkIHRhYmxlIHdhbGsgIHdvdWxkIGJlIG1vcmUNCmVmZmljaWVudCBhbmQgYWxzbyBubyBkZXBl
bmRlbmN5IG9uIHRoZSBWVERfTUFYX0hQQVNJRC4gRG9lcyBpdCBtYWtlDQpzZW5zZSB0byB5b3U/
IDotKQ0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=


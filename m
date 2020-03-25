Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA0C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76DC206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76DC206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3Xc-0008Gh-Pp
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH3SS-0008GM-DA
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH3SQ-0001vS-CU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:35232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH3SQ-0001kZ-52
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:40:22 -0400
IronPort-SDR: O8cXcs0Bxu6AVBZhy9f/Yku/Kr8eBgsPwirRdDnzikmPq8gUh5Lzuz9rm93FLO8XcS3RT9RTVL
 /3LeD3Lfy7Rw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 03:40:13 -0700
IronPort-SDR: QlNTJjIzx9iOQk2UUPnC15Dwah5AslmRQPSvLxxIzBwk78OdCgPw9Kj5c9I10BFTGBqliIIaBT
 srMRXJRbS0qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; d="scan'208";a="393587249"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 03:40:12 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 03:40:12 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 03:40:11 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.201]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 18:40:08 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 18/22] vfio: add support for flush iommu stage-1 cache
Thread-Topic: [PATCH v1 18/22] vfio: add support for flush iommu stage-1 cache
Thread-Index: AQHWAEW38keupAMDxUWxV+Of7sKHqqhXisuAgAGX/eA=
Date: Wed, 25 Mar 2020 10:40:08 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A201F8D@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-19-git-send-email-yi.l.liu@intel.com>
 <20200324181915.GC127076@xz-x1>
In-Reply-To: <20200324181915.GC127076@xz-x1>
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
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMjUsIDIwMjAgMjoxOSBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTgvMjJdIHZmaW86IGFkZCBzdXBwb3J0IGZv
ciBmbHVzaCBpb21tdSBzdGFnZS0xIGNhY2hlDQo+IA0KPiBPbiBTdW4sIE1hciAyMiwgMjAyMCBh
dCAwNTozNjoxNUFNIC0wNzAwLCBMaXUgWWkgTCB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGFkZHMg
Zmx1c2hfc3RhZ2UxX2NhY2hlKCkgZGVmaW5pdGlvbiBpbiBIb3N0SU9NVUNvbnRleHRDbGFzcy4N
Cj4gPiBBbmQgYWRkcyBjb3JyZXNwb25kaW5nIGltcGxlbWVudGF0aW9uIGluIFZGSU8uIFRoaXMg
aXMgdG8gZXhwb3NlIGEgd2F5DQo+ID4gZm9yIHZJT01NVSB0byBmbHVzaCBzdGFnZS0xIGNhY2hl
IGluIGhvc3Qgc2lkZSBzaW5jZSBndWVzdCBvd25zDQo+ID4gc3RhZ2UtMSB0cmFuc2xhdGlvbiBz
dHJ1Y3R1cmVzIGluIGR1YWwgc3RhZ2UgRE1BIHRyYW5zbGF0aW9uIGNvbmZpZ3VyYXRpb24uDQo+
ID4NCj4gPiBDYzogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo+ID4gQ2M6IEph
Y29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFBldGVyIFh1
IDxwZXRlcnhAcmVkaGF0LmNvbT4NCj4gPiBDYzogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRo
YXQuY29tPg0KPiA+IENjOiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBD
YzogRGF2aWQgR2lic29uIDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+DQo+ID4gQ2M6IEFs
ZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBQZXRl
ciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQoNClRoYW5rcywgUGV0ZXIuDQoNClJlZ2FyZHMsDQpZ
aSBMaXUNCg==


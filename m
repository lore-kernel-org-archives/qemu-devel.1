Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E4C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30DA20774
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 07:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30DA20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIoWi-0001BG-Oa
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 03:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jIoVq-0000Sl-OC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jIoVo-0005GY-N8
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:07:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:17654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jIoVo-0005DG-DZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 03:07:08 -0400
IronPort-SDR: EV0SdzS+XYLO0PY7p0YeotL+JSsBxB9+v2+yn+2kAnEucyEsv6HYM+s7x0vshr+mOFArSR7FCA
 Efu6at07yrvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 00:07:04 -0700
IronPort-SDR: QGN8eDhpxmi/o3hHa5+yq50mypEFuY+72r+aSQs8PFbOrAJ69yeDj6sfHrtMzT7MDEr7bmGGCN
 avTg5f1g5EcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; d="scan'208";a="251798831"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga006.jf.intel.com with ESMTP; 30 Mar 2020 00:07:03 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 00:07:02 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 00:07:03 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 15:06:59 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v1 02/22] header file update VFIO/IOMMU vSVA APIs
Thread-Topic: [PATCH v1 02/22] header file update VFIO/IOMMU vSVA APIs
Thread-Index: AQHWAEWzGPuJuT4J30ONAJq1EYpf86hfSKQAgAF557A=
Date: Mon, 30 Mar 2020 07:06:59 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A217A6A@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-3-git-send-email-yi.l.liu@intel.com>
 <288fdc64-9701-3e3e-2412-acc655f18b7a@redhat.com>
In-Reply-To: <288fdc64-9701-3e3e-2412-acc655f18b7a@redhat.com>
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiBGcm9tOiBBdWdlciBFcmljIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgTWFyY2ggMzAsIDIwMjAgMTI6MzMgQU0NCj4gVG86IExpdSwgWWkgTCA8
eWkubC5saXVAaW50ZWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYxIDAyLzIyXSBoZWFkZXIgZmlsZSB1cGRhdGUgVkZJTy9JT01NVSB2U1ZBIEFQ
SXMNCj4gDQo+IEhpIFlpLA0KPiANCj4gT24gMy8yMi8yMCAxOjM1IFBNLCBMaXUgWWkgTCB3cm90
ZToNCj4gPiBUaGUga2VybmVsIHVhcGkvbGludXgvaW9tbXUuaCBoZWFkZXIgZmlsZSBpbmNsdWRl
cyB0aGUgZXh0ZW5zaW9ucyBmb3INCj4gPiB2U1ZBIHN1cHBvcnQuIGUuZy4gYmluZCBncGFzaWQs
IGlvbW11IGZhdWx0IHJlcG9ydCByZWxhdGVkIHVzZXINCj4gPiBzdHJ1Y3R1cmVzIGFuZCBldGMu
DQo+ID4NCj4gPiBOb3RlOiB0aGlzIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoIGEgZnVsbCBoZWFk
ZXIgZmlsZXMgdXBkYXRlIHdoZW4gdGhlDQo+ID4gdlNWQSB1UEFQSSBpcyBzdGFibGUuDQo+IA0K
PiBVbnRpbCB0aGlzIGdldHMgdXBzdHJlYW1lZCwgbWF5YmUgYWRkIHRoZSBicmFuY2ggYWdhaW5z
dCB3aGljaCB5b3UgdXBkYXRlZCB0aGUNCj4gaGVhZGVycz8NCg0KZ29vZCBwb2ludCwgSSBjYW4g
YWRkIGl0IGhlcmUgaW4gdjMuLi4ganVzdCBzZW50IG91dCB2Mi4NCg0KVGhhbmtzLA0KWWkgTGl1
DQoNCg==


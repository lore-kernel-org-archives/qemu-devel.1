Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A1BC2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F612073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F612073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNOY-0000BM-56
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNNX-0007zr-Va
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jKNNW-0003Zk-OU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:33:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:62634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jKNNW-0003Ys-GX
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:33:02 -0400
IronPort-SDR: 0n53VApLNFkISH/pZmRy9iHGb8WTO/kszD/0K8u4whQFaC0JsmagjVRIqjD0IJdXz9hv96aK33
 nvJW560MQ2Xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 07:33:00 -0700
IronPort-SDR: nKqQBPM2pjbJRq2UmHiUnsjlo43jFfREYVzpnzZlEPDZR7j+o2gA7vPBClEZw1t1uh4TTPjkq8
 xT5uU5OHTXug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; d="scan'208";a="329181331"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga001.jf.intel.com with ESMTP; 03 Apr 2020 07:32:59 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 07:32:59 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 07:32:59 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 22:32:55 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Thread-Topic: [PATCH v2 00/22] intel_iommu: expose Shared Virtual Addressing
 to VMs
Thread-Index: AQHWBkpi4SFlYLfwBEaCXIDf+JnUMqhlofiAgAHaG1A=
Date: Fri, 3 Apr 2020 14:32:55 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A220D6C@SHSMSX104.ccr.corp.intel.com>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <20200402181255.GE103677@xz-x1>
In-Reply-To: <20200402181255.GE103677@xz-x1>
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXBy
aWwgMywgMjAyMCAyOjEzIEFNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMC8yMl0gaW50ZWxfaW9tbXU6IGV4cG9zZSBTaGFy
ZWQgVmlydHVhbCBBZGRyZXNzaW5nIHRvDQo+IFZNcw0KPiANCj4gT24gU3VuLCBNYXIgMjksIDIw
MjAgYXQgMDk6MjQ6MzlQTSAtMDcwMCwgTGl1IFlpIEwgd3JvdGU6DQo+ID4gVGVzdHM6IGJhc2Np
IHZTVkEgZnVuY3Rpb25hbGl0eSB0ZXN0LA0KPiANCj4gQ291bGQgeW91IGVsYWJvcmF0ZSB3aGF0
J3MgdGhlIGZ1bmN0aW9uYWxpdHkgdGVzdD8gIERvZXMgdGhhdCBjb250YWlucw0KPiBhdCBsZWFz
dCBzb21lIElPcyBnbyB0aHJvdWdoIHRoZSBTVkEtY2FwYWJsZSBkZXZpY2Ugc28gdGhlIG5lc3Rl
ZCBwYWdlDQo+IHRhYmxlIGlzIHVzZWQ/ICBJIHRob3VnaHQgaXQgd2FzIGEgeWVzLCBidXQgYWZ0
ZXIgSSBub3RpY2UgdGhhdCB0aGUNCj4gQklORCBtZXNzYWdlIGZsYWdzIHNlZW1zIHRvIGJlIHdy
b25nLCBJIHJlYWxseSB0aGluayBJIHNob3VsZCBhc2sgdGhpcw0KPiBsb3VkLi4NCg0KYXMganVz
dCByZXBsaWVkLCBpbiB0aGUgdmVyaWZpY2F0aW9uLCBvbmx5IHRoZSBTUkUgYml0IGlzIHVzZWQu
IFNvIGl0J3Mgbm90DQpzcG90dGVkLiBJbiBteSBmdW5jdGlvbmFsaXR5IHRlc3QsIEkndmUgcGFz
c3RocnUgYSBTVkEtY2FwYWJsZSBkZXZpY2UNCmFuZCBpc3N1ZSBTVkEgdHJhbnNhY3Rpb25zLg0K
DQo+ID4gVk0gcmVib290L3NodXRkb3duL2NyYXNoLA0KPiANCj4gV2hhdCdzIHRoZSBWTSBjcmFz
aCB0ZXN0Pw0KDQppdCdzIGN0cmwrYyB0byBraWxsIHRoZSBWTS4NCg0KPiA+IGtlcm5lbCBidWls
ZCBpbg0KPiA+IGd1ZXN0LCBib290IFZNIHdpdGggdlNWQSBkaXNhYmxlZCwgZnVsbCBjb21hcGls
YXRpb24gd2l0aCBhbGwgYXJjaHMuDQo+IA0KPiBJIGJlbGlldmUgSSd2ZSBzYWlkIHNpbWlsYXIg
dGhpbmdzLCBidXQuLi4gIEknZCBhcHByZWNpYXRlIGlmIHlvdSBjYW4NCj4gYWxzbyBzbW9rZSBv
biAybmQtbGV2ZWwgb25seSB3aXRoIHRoZSBzZXJpZXMgYXBwbGllZC4NCg0KeWVhaCwgeW91IG1l
YW4gdGhlIGxlZ2FjeSBjYXNlLCBJIGJvb3RlZCB3aXRoIHN1Y2ggY29uZmlnLg0KDQpSZWdhcmRz
LA0KWWkgTGl1DQo=


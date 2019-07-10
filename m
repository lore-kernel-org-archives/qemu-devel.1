Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B32C71142
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 12:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706622064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 12:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706622064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlBmk-0008Jv-HE
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 08:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59535)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hlBjA-0007Yf-8t
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hlBj5-0002HQ-79
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:29:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:3590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hlBiw-0001uX-73
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 08:29:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 05:29:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; d="scan'208";a="167714214"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2019 05:29:17 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 05:29:17 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 10 Jul 2019 05:29:17 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.110]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.22]) with mapi id 14.03.0439.000;
 Wed, 10 Jul 2019 20:29:15 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <zhexu@redhat.com>
Thread-Topic: [RFC v1 02/18] linux-headers: import vfio.h from kernel
Thread-Index: AQHVM+yh2rNFaB2oxk6WEbspcoSec6bBBYMAgALIrGA=
Date: Wed, 10 Jul 2019 12:29:15 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439F2A747@SHSMSX104.ccr.corp.intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-3-git-send-email-yi.l.liu@intel.com>
 <20190709015800.GA566@xz-x1>
In-Reply-To: <20190709015800.GA566@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTY1NTQ5ZmMtY2NjNi00OGM0LWExOTktYWFjN2M3ZjE2ODE4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSVdybks4WWRkZUp6dnVGWG0zYmExRjg1alI2SUh2YVZYRkFySGtyZk9NXC9WejBXQ3paR1lxaGtcL2phdng2NGVmIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [RFC v1 02/18] linux-headers: import vfio.h from
 kernel
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBrdm0tb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86a3ZtLW93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmDQo+IE9mIFBldGVyIFh1DQo+IFNlbnQ6IFR1ZXNkYXksIEp1
bHkgOSwgMjAxOSA5OjU4IEFNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtSRkMgdjEgMDIvMThdIGxpbnV4LWhlYWRlcnM6IGltcG9ydCB2Zmlv
LmggZnJvbSBrZXJuZWwNCj4gDQo+IE9uIEZyaSwgSnVsIDA1LCAyMDE5IGF0IDA3OjAxOjM1UE0g
KzA4MDAsIExpdSBZaSBMIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggaW1wb3J0cyB0aGUgdklPTU1V
IHJlbGF0ZWQgZGVmaW5pdGlvbnMgZnJvbSBrZXJuZWwNCj4gPiB1YXBpL3ZmaW8uaC4gZS5nLiBw
YXNpZCBhbGxvY2F0aW9uLCBndWVzdCBwYXNpZCBiaW5kLCBndWVzdCBwYXNpZA0KPiA+IHRhYmxl
IGJpbmQgYW5kIGd1ZXN0IGlvbW11IGNhY2hlIGludmFsaWRhdGlvbi4NCj4gPg0KPiA+IENjOiBL
ZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPiBDYzogSmFjb2IgUGFuIDxqYWNv
Yi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBDYzogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPg0KPiA+IENjOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4g
Q2M6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
aSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IEp1c3QgYSBub3RlIHRoYXQg
aW4gdGhlIGxhc3QgdmVyc2lvbiB5b3UgY2FuIHVzZSBzY3JpcHRzL3VwZGF0ZS1saW51eC1oZWFk
ZXJzLnNoIHRvDQo+IHVwZGF0ZSB0aGUgaGVhZGVycy4gIEZvciB0aGlzIFJGQyBpdCdzIHBlcmZl
Y3RseSBmaW5lLg0KDQp5ZXAsIHRoYW5rcyBmb3IgdGhlIHJlbWluZC4NCg0KPiAtLQ0KPiBQZXRl
ciBYdQ0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=


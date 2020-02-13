Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D111C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D6020873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D6020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24VU-0006UR-D3
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j24Uo-00061w-0I
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j24Um-0003to-VZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:44:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:18680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j24Um-0003rY-MO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:44:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Feb 2020 18:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; d="scan'208";a="257028350"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2020 18:44:50 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 18:44:50 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 12 Feb 2020 18:44:49 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.5]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.222]) with mapi id 14.03.0439.000;
 Thu, 13 Feb 2020 10:44:47 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [RFC v3 13/25] intel_iommu: modify x-scalable-mode to be string
 option
Thread-Topic: [RFC v3 13/25] intel_iommu: modify x-scalable-mode to be
 string option
Thread-Index: AQHV1p1OaPbyEoP2OUqqqdiprp3R66gV87yAgAFI6dCAAAyTAIABOICQ
Date: Thu, 13 Feb 2020 02:44:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1BBC3E@SHSMSX104.ccr.corp.intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-14-git-send-email-yi.l.liu@intel.com>
 <20200211194331.GK984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA573@SHSMSX104.ccr.corp.intel.com>
 <20200212160544.GC1083891@xz-x1>
In-Reply-To: <20200212160544.GC1083891@xz-x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGFjNDMyMmQtZWQxZS00MjU2LWE3MTgtYmQ3MTQyMTZiYzNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiS2FXMGZRVkoxUVdoOG9IbjVUc2pMR1RcLzZvXC9nSmR2M2V5UFR3c0ZmTE9pT3RPWFlVV1BlY1B3TGVHRUhVZURrIn0=
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBG
ZWJydWFyeSAxMywgMjAyMCAxMjowNiBBTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYzIDEzLzI1XSBpbnRlbF9pb21tdTogbW9kaWZ5
IHgtc2NhbGFibGUtbW9kZSB0byBiZSBzdHJpbmcNCj4gb3B0aW9uDQo+IA0KPiBPbiBXZWQsIEZl
YiAxMiwgMjAyMCBhdCAwNzoyODoyNEFNICswMDAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gPiBG
cm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXks
IEZlYnJ1YXJ5IDEyLCAyMDIwIDM6NDQgQU0NCj4gPiA+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUkZDIHYzIDEzLzI1XSBpbnRlbF9pb21t
dTogbW9kaWZ5IHgtc2NhbGFibGUtbW9kZSB0bw0KPiA+ID4gYmUgc3RyaW5nIG9wdGlvbg0KPiA+
ID4NCj4gPiA+IE9uIFdlZCwgSmFuIDI5LCAyMDIwIGF0IDA0OjE2OjQ0QU0gLTA4MDAsIExpdSwg
WWkgTCB3cm90ZToNCj4gPiA+ID4gRnJvbTogTGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4gPiA+ID4NCj4gPiA+ID4gSW50ZWwgVlQtZCAzLjAgaW50cm9kdWNlcyBzY2FsYWJsZSBtb2Rl
LCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YNCj4gPiA+ID4gY2FwYWJpbGl0aWVzIHJlbGF0ZWQgdG8g
c2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBhcmUNCj4gPiA+ID4gbXVsdGlw
bGUNCj4gPiA+IGNvbWJpbmF0aW9ucy4NCj4gPiA+ID4gV2hpbGUgdGhpcyB2SU9NTVUgaW1wbGVt
ZW50YXRpb24gd2FudHMgc2ltcGxpZnkgaXQgZm9yIHVzZXIgYnkNCj4gPiA+ID4gcHJvdmlkaW5n
IHR5cGljYWwgY29tYmluYXRpb25zLiBVc2VyIGNvdWxkIGNvbmZpZyBpdCBieQ0KPiA+ID4gPiAi
eC1zY2FsYWJsZS1tb2RlIiBvcHRpb24uIFRoZSB1c2FnZSBpcyBhcyBiZWxvdzoNCj4gPiA+ID4N
Cj4gPiA+ID4gIi1kZXZpY2UgaW50ZWwtaW9tbXUseC1zY2FsYWJsZS1tb2RlPVsibGVnYWN5Inwi
bW9kZXJuIl0iDQo+ID4gPg0KPiA+ID4gTWF5YmUgYWxzbyAib2ZmIiB3aGVuIHNvbWVvbmUgd2Fu
dHMgdG8gZXhwbGljaXRseSBkaXNhYmxlIGl0Pw0KPiA+DQo+ID4gZW1tbSwgSSAgdGhpbmsgeC1z
Y2FsYWJsZS1tb2RlIHNob3VsZCBiZSBkaXNhYmxlZCBieSBkZWZhdWx0LiBJdCBpcw0KPiA+IGVu
YWJsZWQgb25seSB3aGVuICJsZWdhY3kiIG9yICJtb2Rlcm4iIGlzIGNvbmZpZ3VyZWQuIEknbSBm
aW5lIHRvIGFkZA0KPiA+ICJvZmYiIGFzIGFuIGV4cGxpY2l0IHdheSB0byB0dXJuIGl0IG9mZiBp
ZiB5b3UgdGhpbmsgaXQgaXMgbmVjZXNzYXJ5Lg0KPiA+IDotKQ0KPiANCj4gSXQncyBub3QgbmVj
ZXNzYXJ5LiAgSXQnbGwgYmUgbmVjZXNzYXJ5IHdoZW4gd2UgcmVtb3ZlICJ4LSIgYW5kIGNoYW5n
ZSB0aGUNCj4gZGVmYXVsdCB2YWx1ZS4gIEhvd2V2ZXIgaXQnbGwgYWx3YXlzIGJlIGdvb2QgdG8g
cHJvdmlkZSBhbGwgb3B0aW9ucyBleHBsaWNpdGx5IGluIHRoZQ0KPiBwYXJhbWV0ZXIgc3RhcnRp
bmcgZnJvbSB3aGVuIHdlIGRlc2lnbiBpdCwgaW1oby4gIEl0J3Mgc3RpbGwgZXhwZXJpbWVudGFs
LCBzby4uLg0KPiBZb3VyIGNhbGwuIDopDQoNCkdvdCBpdC4gTGV0IG1lIGFkZCBpdCBpbiBuZXh0
IHZlcnNpb24uIPCfmIoNCg0KUmVnYXJkcywNCllpIExpdQ0K


Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32C1C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891F720775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891F720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgP8-0005lI-Nr
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jGgNw-0004TS-1x
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jGgNv-0008WG-0Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:02:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:51056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jGgNu-0008VG-MI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:02:10 -0400
IronPort-SDR: n12+cO+cME2f/GvseKMfZ74dNMJKOuffvcMj/7+ao7+lhUIvh87bDghB583YtWOCi1jjG1N3S6
 p3uwojRBz4yA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 03:02:09 -0700
IronPort-SDR: 3hxktaP9YRptOTJ7L3AO8JGLWaBUQxVraDh4maKiTemZEp3c2qLAEiv1gD0jEDUsfUuDhJDL+Z
 Au9hFwCFRVkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="446165953"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2020 03:02:09 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 03:02:09 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.96]) with mapi id 14.03.0439.000;
 Tue, 24 Mar 2020 18:02:05 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 06/22] hw/pci: introduce
 pci_device_set/unset_iommu_context()
Thread-Topic: [PATCH v1 06/22] hw/pci: introduce
 pci_device_set/unset_iommu_context()
Thread-Index: AQHWAEW1Ny26yVgYEkqv+QbSE9Yz16hWKZuAgAFcIHA=
Date: Tue, 24 Mar 2020 10:02:04 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A200286@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-7-git-send-email-yi.l.liu@intel.com>
 <20200323211509.GP127076@xz-x1>
In-Reply-To: <20200323211509.GP127076@xz-x1>
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
X-Received-From: 192.55.52.136
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

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDI0LCAyMDIwIDU6MTUgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA2LzIyXSBody9wY2k6IGludHJvZHVjZQ0KPiBw
Y2lfZGV2aWNlX3NldC91bnNldF9pb21tdV9jb250ZXh0KCkNCj4gDQo+IE9uIFN1biwgTWFyIDIy
LCAyMDIwIGF0IDA1OjM2OjAzQU0gLTA3MDAsIExpdSBZaSBMIHdyb3RlOg0KPiANCj4gWy4uLl0N
Cj4gDQo+ID4gK0FkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBD
SURldmljZSAqZGV2KSB7DQo+ID4gKyAgICBQQ0lCdXMgKmJ1czsNCj4gPiArICAgIHVpbnQ4X3Qg
ZGV2Zm47DQo+ID4gKw0KPiA+ICsgICAgcGNpX2RldmljZV9nZXRfaW9tbXVfYnVzX2RldmZuKGRl
diwgJmJ1cywgJmRldmZuKTsNCj4gPiArICAgIGlmIChidXMgJiYgYnVzLT5pb21tdV9vcHMgJiYN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgYnVzLT5pb21tdV9vcHMtPmdldF9hZGRyZXNzX3Nw
YWNlKSB7DQo+IA0KPiBOaXQ6IFNpbmNlIHdlJ3JlIG1vdmluZyBpdCBhcm91bmQsIG1heWJlIHJl
LWFsaWduIGl0IHRvIGxlZnQgYnJhY2tldD8NCj4gU2FtZSB0byBiZWxvdyB0d28gcGxhY2VzLg0K
DQpnb3QgaXQuIHdpbGwgZG8gaXQuDQoNCj4gV2l0aCB0aGUgaW5kZW50IGZpeGVkOg0KPiANCj4g
UmV2aWV3ZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIGZvciB0
aGUgY29tbWVudHMuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0K


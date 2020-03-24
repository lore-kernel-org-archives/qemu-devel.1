Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A5EC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E4320775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 10:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E4320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGgOY-0004kF-LX
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jGgN6-0004BK-HR
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jGgN0-00087s-Sm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:01:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:60034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jGgN0-000828-Jw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 06:01:14 -0400
IronPort-SDR: cuhEopL0vemaHRxRUM32Cm2KHbg099dFrCqwrw2Sj1VvhaM5J2FsyYGH6pV+s0nSRTxvFZ+IEs
 +utgOEHT3PuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 03:01:05 -0700
IronPort-SDR: KYOP6eP0u/BHet1K/7xFsyBxc1A19yEIEIt9QwoyudjSunHVmh5O/7CPRteaggzf4TjKdl7Fyw
 7F3H6QvsrzZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; d="scan'208";a="446165647"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2020 03:01:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Mar 2020 03:01:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Mar 2020 03:01:04 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Mar 2020 03:01:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.201]) with mapi id 14.03.0439.000;
 Tue, 24 Mar 2020 18:01:00 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 04/22] hw/iommu: introduce HostIOMMUContext
Thread-Topic: [PATCH v1 04/22] hw/iommu: introduce HostIOMMUContext
Thread-Index: AQHWAEW0rB33oVdQrU+mDi1gUUEnsahWJQuAgAFKGUA=
Date: Tue, 24 Mar 2020 10:00:59 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A200268@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-5-git-send-email-yi.l.liu@intel.com>
 <20200323205849.GO127076@xz-x1>
In-Reply-To: <20200323205849.GO127076@xz-x1>
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
X-Received-From: 134.134.136.65
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
cmNoIDI0LCAyMDIwIDQ6NTkgQU0NCj4gVG86IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA0LzIyXSBody9pb21tdTogaW50cm9kdWNlIEhv
c3RJT01NVUNvbnRleHQNCj4gDQo+IE9uIFN1biwgTWFyIDIyLCAyMDIwIGF0IDA1OjM2OjAxQU0g
LTA3MDAsIExpdSBZaSBMIHdyb3RlOg0KWy4uLl0NCj4gPiArDQo+ID4gK3ZvaWQgaG9zdF9pb21t
dV9jdHhfaW5pdCh2b2lkICpfaG9zdF9pY3gsIHNpemVfdCBpbnN0YW5jZV9zaXplLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbXJ0eXBlbmFtZSwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGZsYWdzKQ0KPiA+ICt7DQo+ID4gKyAgICBI
b3N0SU9NTVVDb250ZXh0ICpob3N0X2ljeDsNCj4gPiArDQo+ID4gKyAgICBvYmplY3RfaW5pdGlh
bGl6ZShfaG9zdF9pY3gsIGluc3RhbmNlX3NpemUsIG1ydHlwZW5hbWUpOw0KPiA+ICsgICAgaG9z
dF9pY3ggPSBIT1NUX0lPTU1VX0NPTlRFWFQoX2hvc3RfaWN4KTsNCj4gPiArICAgIGhvc3RfaWN4
LT5mbGFncyA9IGZsYWdzOw0KPiA+ICsgICAgaG9zdF9pY3gtPmluaXRpYWxpemVkID0gdHJ1ZTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArdm9pZCBob3N0X2lvbW11X2N0eF9kZXN0cm95KEhvc3RJT01N
VUNvbnRleHQgKmhvc3RfaWN4KQ0KPiA+ICt7DQo+ID4gKyAgICBob3N0X2ljeC0+ZmxhZ3MgPSAw
eDA7DQo+ID4gKyAgICBob3N0X2ljeC0+aW5pdGlhbGl6ZWQgPSBmYWxzZTsNCj4gPiArfQ0KPiAN
Cj4gQ2FuIHdlIHNpbXBseSBwdXQgdGhpcyBpbnRvIC5pbnN0YW5jZV9maW5hbGl6ZSgpIGFuZCBi
ZSBjYWxsZWQNCj4gYXV0b21hdGljYWxseSB3aGVuIHRoZSBvYmplY3QgbG9zZXMgdGhlIGxhc3Qg
cmVmY291bnQ/DQo+IA0KPiBBY3R1YWxseSBhbiBlYXNpZXIgd2F5IG1heSBiZSBkcm9wcGluZyB0
aGlzIGRpcmVjdGx5Li4gIElmIHRoZSBvYmplY3QNCj4gaXMgdG8gYmUgZGVzdHJveWVkIHRoZW4g
SU1ITyB3ZSBkb24ndCBuZWVkIHRvIGNhcmUgYWJvdXQgZmxhZ3MgYXQgYWxsLA0KPiB3ZSBqdXN0
IGZyZWUgbWVtb3JpZXMgd2UgdXNlLCBidXQgZm9yIHRoaXMgb2JqZWN0IGl0J3Mgbm9uZS4NCg0K
cmlnaHQsIEknbGwgZHJvcCB0aGlzIGZ1bmN0aW9uLiA6LSkNCg0KPiA+ICsNCj4gPiArc3RhdGlj
IHZvaWQgaG9zdF9pY3hfaW5pdF9mbihPYmplY3QgKm9iaikNCj4gPiArew0KPiA+ICsgICAgSG9z
dElPTU1VQ29udGV4dCAqaG9zdF9pY3ggPSBIT1NUX0lPTU1VX0NPTlRFWFQob2JqKTsNCj4gPiAr
DQo+ID4gKyAgICBob3N0X2ljeC0+ZmxhZ3MgPSAweDA7DQo+ID4gKyAgICBob3N0X2ljeC0+aW5p
dGlhbGl6ZWQgPSBmYWxzZTsNCj4gDQo+IEhlcmUgaXMgYWxzbyBhIGJpdCBzdHJhbmdlLi4uICBJ
SVVDIHRoZSBvbmx5IHdheSB0byBpbml0IHRoaXMgb2JqZWN0DQo+IGlzIHZpYSBob3N0X2lvbW11
X2N0eF9pbml0KCkgd2hlcmUgYWxsIHRoZXNlIGZsYWdzIHdpbGwgYmUgc2V0LiAgQnV0DQo+IGlm
IHNvLCB0aGVuIHdlJ3JlIHNldHRpbmcgYWxsIHRoZXNlIHR3aWNlIGFsd2F5cy4gIE1heWJlIHRo
aXMgZnVuY3Rpb24NCj4gY2FuIGJlIGRyb3BwZWQgdG9vPw0KDQp5ZXMsIGl0IGlzLiBBdCBsZWFz
dCwgaXQgaXMgbm90IG5lY2Vzc2FyeSBmb3Igbm93LiBXaWxsIGRyb3AgaXQuDQoNClRoYW5rcywN
CllpIExpdQ0KDQo=


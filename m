Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C1FC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E32620714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E32620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2UR-0004Y0-BV
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1jH2Ts-00048K-73
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1jH2Tq-0007n7-Sm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:37:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:46667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1jH2Tq-0007ju-KN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:37:46 -0400
IronPort-SDR: 09Q6RSJNOeaPWzEQSwdkgdm79p6JbIUdp5uSVpBnTRdUL+WZp6XBdw6KYe3VgoCaeMM5bWsepe
 DEeRwE9jL9wg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 02:37:41 -0700
IronPort-SDR: vhPjM/cowDlQDWyPp9g8cDTlRnVOlTcGWufI14tK3cz67FB29nlKsk1CIcqtF35xUflW9rwh1d
 xZn0wNGBUPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,303,1580803200"; d="scan'208";a="393574042"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 02:37:41 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 02:37:41 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Mar 2020 02:37:41 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.155]) with mapi id 14.03.0439.000;
 Wed, 25 Mar 2020 17:37:37 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH v1 07/22] intel_iommu: add set/unset_iommu_context callback
Thread-Topic: [PATCH v1 07/22] intel_iommu: add set/unset_iommu_context
 callback
Thread-Index: AQHWAEW1iID+2pWxMk+TzTXpt3GsyKhWLYeAgAFYgbD//9PfAIABtbwQ
Date: Wed, 25 Mar 2020 09:37:37 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A201DFC@SHSMSX104.ccr.corp.intel.com>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-8-git-send-email-yi.l.liu@intel.com>
 <20200323212911.GQ127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A20041A@SHSMSX104.ccr.corp.intel.com>
 <20200324152416.GV127076@xz-x1>
In-Reply-To: <20200324152416.GV127076@xz-x1>
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1h
cmNoIDI0LCAyMDIwIDExOjI0IFBNDQo+IFRvOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwNy8yMl0gaW50ZWxfaW9tbXU6IGFkZCBzZXQv
dW5zZXRfaW9tbXVfY29udGV4dCBjYWxsYmFjaw0KPiANCj4gT24gVHVlLCBNYXIgMjQsIDIwMjAg
YXQgMTE6MTU6MjRBTSArMDAwMCwgTGl1LCBZaSBMIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+
ID4gPiA+ICBzdHJ1Y3QgVlRESU9UTEJFbnRyeSB7DQo+ID4gPiA+IEBAIC0yNzEsNiArMjgyLDgg
QEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7DQo+ID4gPiA+ICAgICAgLyoNCj4gPiA+ID4gICAg
ICAgKiBQcm90ZWN0cyBJT01NVSBzdGF0ZXMgaW4gZ2VuZXJhbC4gIEN1cnJlbnRseSBpdCBwcm90
ZWN0cyB0aGUNCj4gPiA+ID4gICAgICAgKiBwZXItSU9NTVUgSU9UTEIgY2FjaGUsIGFuZCBjb250
ZXh0IGVudHJ5IGNhY2hlIGluIFZUREFkZHJlc3NTcGFjZS4NCj4gPiA+ID4gKyAgICAgKiBQcm90
ZWN0IHRoZSB1cGRhdGUvdXNhZ2Ugb2YgSG9zdElPTU1VQ29udGV4dCBwb2ludGVyIGNhY2hlZCBp
bg0KPiA+ID4gPiArICAgICAqIFZUREJ1cy0+ZGV2X2ljeCBhcnJheSBhcyBhcnJheSBlbGVtZW50
cyBtYXkgYmUgdXBkYXRlZCBieQ0KPiA+ID4gPiArIGhvdHBsdWcNCj4gPiA+DQo+ID4gPiBJIHRo
aW5rIHRoZSBjb250ZXh0IHVwZGF0ZSBkb2VzIG5vdCBuZWVkIHRvIGJlIHVwZGF0ZWQsIGJlY2F1
c2UgdGhleQ0KPiA+ID4gc2hvdWxkIGFsd2F5cyBiZSB3aXRoIHRoZSBCUUwsIHJpZ2h0Pw0KPiA+
DQo+ID4gSG1tbW0sIG1heWJlIEkgdXNlZCBiYWQgZGVzY3JpcHRpb24uIE15IHB1cnBvc2UgaXMg
dG8gcHJvdGVjdCB0aGUNCj4gPiBzdG9yZWQgSG9zdElPTU1VQ29udGV4dCBwb2ludGVyIGluIHZJ
T01NVS4gV2l0aA0KPiA+IHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2NvbnRleHQsDQo+ID4g
dklPTU1VIGhhdmUgYSBjb3B5IG9mIEhvc3RJT01NVUNvbnRleHQuIElmIFZGSU8gY29udGFpbmVy
IGlzIHJlbGVhc2VkDQo+ID4gKGUuZy4gaG90cHVsZyBvdXQgZGV2aWNlKSwgSG9zdElPTU1VQ29u
dGV4dCB3aWxsIGFsb3MgYmUgcmVsZWFzZWQuDQo+ID4gVGhpcyB3aWxsIHRyaWdnZXIgdGhlIHBj
aV9kZXZpY2VfdW5zZXRfaW9tbXVfY29udGV4dCgpIHRvIGNsZWFuIHRoZQ0KPiA+IGNvcHkuIFRv
IGF2b2lkIHVzaW5nIGEgc3RhbGVkIEhvc3RJT01NVUNvbnRleHQgaW4gdklPTU1VLCB2SU9NTVUN
Cj4gPiBzaG91bGQgaGF2ZSBhIGxvY2sgdG8gYmxvY2sgdGhlIHBjaV9kZXZpY2VfdW5zZXRfaW9t
bXVfY29udGV4dCgpDQo+ID4gY2FsbGluZyB1bnRpbCBvdGhlciB0aHJlYWRzIGZpbmlzaGVkIHRo
ZWlyIEhvc3RJT01NVUNvbnRleHQgdXNhZ2UuIERvDQo+ID4geW91IHdhbnQgYSBkZXNjcmlwdGlv
biB1cGRhdGUgaGVyZSBvciBvdGhlciBwcmVmZXJlbmNlPw0KPiANCj4gWWVhaCwgYnV0IGhvdCBw
bHVnL3VucGx1ZyB3aWxsIHN0aWxsIHRha2UgdGhlIEJRTD8NCj4NCj4gQWggYnR3IEkgdGhpbmsg
aXQncyBhbHNvIE9LIHRvIHRha2UgdGhlIGxvY2sgaWYgeW91IHdhbnQgb3Igbm90IHN1cmUgYWJv
dXQgd2hldGhlcg0KPiB3ZSdsbCBhbHdheXMgdGFrZSB0aGUgQlFMIGluIHRoZXNlIHBhdGhzLiAN
Cg0KSSBndWVzcyBiZXR0ZXIgdG8gaGF2ZSBhbiBpbnRlcm5hbCBzeW5jIHRvIGF2b2lkIHJlZmVy
ZW5jZSBzdGFsZXMgSG9zdElPTU1VQ29udGV4dC4gOi0pDQoNCj4gQnV0IGlmIHNvLCBpbnN0ZWFk
IG9mIGFkZGluZyBhbm90aGVyDQo+ICJQcm90ZWN0IHRoZSAuLi4iIHNlbnRlbmNlIHRvIHRoZSBj
b21tZW50LCB3b3VsZCB5b3UgbWluZCBsaXN0IG91dCB3aGF0IHRoZSBsb2NrIGlzDQo+IHByb3Rl
Y3Rpbmc/DQo+IA0KPiAgIC8qDQo+ICAgICogaW9tbXVfbG9jayBwcm90ZWN0czoNCj4gICAgKiAt
IHBlci1JT01NVSBJT1RMQiBjYWNoZXMNCj4gICAgKiAtIGNvbnRleHQgZW50cnkgY2FjaGVzDQo+
ICAgICogLSAuLi4NCj4gICAgKi8NCj4gDQo+IE9yIGFueXRoaW5nIGJldHRlciB0aGFuIHRoYXQu
ICBUaGFua3MsDQoNCkl0IGxvb2tzIGdvb2QgdG8gbWUuIExldCBtZSB1cGRhdGUgaXQgaW4gbmV4
dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=


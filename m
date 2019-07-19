Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE44DC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A342C2186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A342C2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoV3w-0006pj-Sw
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hoV3l-0006Qp-SN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hoV3f-0004Rz-GH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:44:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:24214)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hoV3Y-0003sm-S3
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:44:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jul 2019 08:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,282,1559545200"; d="scan'208";a="343722396"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga005.jf.intel.com with ESMTP; 19 Jul 2019 08:42:57 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 19 Jul 2019 08:42:57 -0700
Received: from fmsmsx104.amr.corp.intel.com ([169.254.3.188]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.168]) with mapi id 14.03.0439.000;
 Fri, 19 Jul 2019 08:42:57 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "stefanha@gmail.com" <stefanha@gmail.com>, "slp@redhat.com"
 <slp@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
Thread-Index: AQHVPkSNSZuO7UXnLUSPU5vhofY8YabSihOA
Date: Fri, 19 Jul 2019 15:42:56 +0000
Message-ID: <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain>
 <87d0i7tlkl.fsf@redhat.com>
 <20190719102915.GG18585@stefanha-x1.localdomain>
 <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
In-Reply-To: <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.218.162.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABBFF2C33E0EA54AA430AF503EE2DAE4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA3LTE5IGF0IDE2OjA5ICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIEZyaSwgSnVsIDE5LCAyMDE5IGF0IDI6NDggUE0gU2VyZ2lvIExvcGV6IDxzbHBAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+ID4gU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBnbWFpbC5jb20+
IHdyaXRlczoNCj4gPiA+IE9uIFRodSwgSnVsIDE4LCAyMDE5IGF0IDA1OjIxOjQ2UE0gKzAyMDAs
IFNlcmdpbyBMb3BleiB3cm90ZToNCj4gPiA+ID4gU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBn
bWFpbC5jb20+IHdyaXRlczoNCj4gPiA+ID4gDQo+ID4gPiA+ID4gT24gVHVlLCBKdWwgMDIsIDIw
MTkgYXQgMDI6MTE6MDJQTSArMDIwMCwgU2VyZ2lvIExvcGV6IHdyb3RlOg0KPiA+ID4gPiAgLS0t
LS0tLS0tLS0tLS0NCj4gPiA+ID4gIHwgQ29uY2x1c2lvbiB8DQo+ID4gPiA+ICAtLS0tLS0tLS0t
LS0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIGF2ZXJhZ2UgYm9vdCB0aW1lIG9mIG1pY3Jvdm0g
aXMgYSB0aGlyZCBvZiBRMzUncyAoMTE1bXMgdnMuDQo+ID4gPiA+IDM2M21zKSwNCj4gPiA+ID4g
YW5kIGlzIHNtYWxsZXIgb24gYWxsIHNlY3Rpb25zIChRRU1VIGluaXRpYWxpemF0aW9uLCBmaXJt
d2FyZQ0KPiA+ID4gPiBvdmVyaGVhZA0KPiA+ID4gPiBhbmQga2VybmVsIHN0YXJ0LXRvLXVzZXIp
Lg0KPiA+ID4gPiANCj4gPiA+ID4gTWljcm92bSdzIG1lbW9yeSB0cmVlIGlzIGFsc28gdmlzaWJs
eSBzaW1wbGVyLCBzaWduaWZpY2FudGx5DQo+ID4gPiA+IHJlZHVjaW5nDQo+ID4gPiA+IHRoZSBl
eHBvc2VkIHN1cmZhY2UgdG8gdGhlIGd1ZXN0Lg0KPiA+ID4gPiANCj4gPiA+ID4gV2hpbGUgd2Ug
Y2FuIGNlcnRhaW5seSB3b3JrIG9uIG1ha2luZyBRMzUgc21hbGxlciwgSSBkZWZpbml0ZWx5DQo+
ID4gPiA+IHRoaW5rDQo+ID4gPiA+IGl0J3MgYmV0dGVyIChhbmQgd2F5IHNhZmVyISkgaGF2aW5n
IGEgc3BlY2lhbGl6ZWQgbWFjaGluZSB0eXBlDQo+ID4gPiA+IGZvciBhDQo+ID4gPiA+IHNwZWNp
ZmljIHVzZSBjYXNlLCB0aGFuIGEgbWluaW1hbCBRMzUgd2hvc2UgYmVoYXZpb3INCj4gPiA+ID4g
c2lnbmlmaWNhbnRseQ0KPiA+ID4gPiBkaXZlcmdlcyBmcm9tIGEgY29udmVudGlvbmFsIFEzNS4N
Cj4gPiA+IA0KPiA+ID4gSW50ZXJlc3RpbmcsIHNvIG5vdCBhIDEweCBkaWZmZXJlbmNlISAgVGhp
cyBtaWdodCBiZSBhbWVuYWJsZSB0bw0KPiA+ID4gb3B0aW1pemF0aW9uLg0KPiA+ID4gDQo+ID4g
PiBNeSBjb25jZXJuIHdpdGggbWljcm92bSBpcyB0aGF0IGl0J3Mgc28gbGltaXRlZCB0aGF0IGZl
dyB1c2Vycw0KPiA+ID4gd2lsbCBiZQ0KPiA+ID4gYWJsZSB0byBiZW5lZml0IGZyb20gdGhlIHJl
ZHVjZWQgYXR0YWNrIHN1cmZhY2UgYW5kIGZhc3Rlcg0KPiA+ID4gc3RhcnR1cCB0aW1lLg0KPiA+
ID4gSSB0aGluayBpdCdzIHdvcnRoIGludmVzdGlnYXRpbmcgc2xpbW1pbmcgZG93biBRMzUgZnVy
dGhlciBmaXJzdC4NCj4gPiA+IA0KPiA+ID4gSW4gdGVybXMgb2Ygc3RhcnR1cCB0aW1lIHRoZSBm
aXJzdCBzdGVwIHdvdWxkIGJlIHByb2ZpbGluZyBRMzUNCj4gPiA+IGtlcm5lbA0KPiA+ID4gc3Rh
cnR1cCB0byBmaW5kIG91dCB3aGF0J3MgdGFraW5nIHNvIGxvbmcgKGZpcm13YXJlDQo+ID4gPiBp
bml0aWFsaXphdGlvbiwgUENJDQo+ID4gPiBwcm9iaW5nLCBldGMpPw0KPiA+IA0KPiA+IFNvbWUg
ZmluZGluZ3M6DQo+ID4gDQo+ID4gIDEuIEV4cG9zaW5nIHRoZSBUU0NfREVBRExJTkUgQ1BVIGZs
YWcgKGkuZS4gdXNpbmcgIi1jcHUgaG9zdCIpDQo+ID4gc2F2ZXMgYQ0KPiA+ICAgICB3aG9vcGlu
ZyAxMjBtcyBieSBhdm9pZGluZyB0aGUgQVBJQyB0aW1lciBjYWxpYnJhdGlvbiBhdA0KPiA+ICAg
ICBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9hcGljLmM6Y2FsaWJyYXRlX0FQSUNfY2xvY2sNCj4gPiAN
Cj4gPiBBdmVyYWdlIGJvb3QgdGltZSB3aXRoICItY3B1IGhvc3QiDQo+ID4gIHFlbXVfaW5pdF9l
bmQ6IDc2LjQwODk1MA0KPiA+ICBsaW51eF9zdGFydF9rZXJuZWw6IDExNi4xNjYxNDIgKCszOS43
NTcxOTIpDQo+ID4gIGxpbnV4X3N0YXJ0X3VzZXI6IDI0Mi45NTQzNDcgKCsxMjYuNzg4MjA1KQ0K
PiA+IA0KPiA+IEF2ZXJhZ2UgYm9vdCB0aW1lIHdpdGggZGVmYXVsdCAiY3B1Ig0KPiA+ICBxZW11
X2luaXRfZW5kOiA3Ny40Njc4NTINCj4gPiAgbGludXhfc3RhcnRfa2VybmVsOiAxMTYuNjg4NDcy
ICgrMzkuMjIwNjIpDQo+ID4gIGxpbnV4X3N0YXJ0X3VzZXI6IDM2My4wMzMzNjUgKCsyNDYuMzQ0
ODkzKQ0KPiANCj4gXG8vDQo+IA0KPiA+ICAyLiBUaGUgb3RoZXIgMTMwbXMgYXJlIGEgZGlyZWN0
IHJlc3VsdCBvZiBQQ0kgYW5kIEFDUEkgcHJlc2VuY2UNCj4gPiAodGVzdGVkDQo+ID4gICAgIHdp
dGggYSBrZXJuZWwgd2l0aG91dCBzdXBwb3J0IGZvciB0aG9zZSBlbGVtZW50cykuIEknbGwgcHVi
bGlzaA0KPiA+IHNvbWUNCj4gPiAgICAgZGV0YWlsZWQgbnVtYmVycyBuZXh0IHdlZWsuDQo+IA0K
PiBIZXJlIGFyZSB0aGUgS2F0YSBDb250YWluZXJzIGtlcm5lbCBwYXJhbWV0ZXJzOg0KPiANCj4g
dmFyIGtlcm5lbFBhcmFtcyA9IFtdUGFyYW17DQo+ICAgICAgICAgeyJ0c2MiLCAicmVsaWFibGUi
fSwNCj4gICAgICAgICB7Im5vX3RpbWVyX2NoZWNrIiwgIiJ9LA0KPiAgICAgICAgIHsicmN1cGRh
dGUucmN1X2V4cGVkaXRlZCIsICIxIn0sDQo+ICAgICAgICAgeyJpODA0Mi5kaXJlY3QiLCAiMSJ9
LA0KPiAgICAgICAgIHsiaTgwNDIuZHVtYmtiZCIsICIxIn0sDQo+ICAgICAgICAgeyJpODA0Mi5u
b3BucCIsICIxIn0sDQo+ICAgICAgICAgeyJpODA0Mi5ub2F1eCIsICIxIn0sDQo+ICAgICAgICAg
eyJub3JlcGxhY2Utc21wIiwgIiJ9LA0KPiAgICAgICAgIHsicmVib290IiwgImsifSwNCj4gICAg
ICAgICB7ImNvbnNvbGUiLCAiaHZjMCJ9LA0KPiAgICAgICAgIHsiY29uc29sZSIsICJodmMxIn0s
DQo+ICAgICAgICAgeyJpb21tdSIsICJvZmYifSwNCj4gICAgICAgICB7ImNyeXB0b21nci5ub3Rl
c3RzIiwgIiJ9LA0KPiAgICAgICAgIHsibmV0LmlmbmFtZXMiLCAiMCJ9LA0KPiAgICAgICAgIHsi
cGNpIiwgImxhc3RidXM9MCJ9LA0KPiB9DQo+IA0KPiBwY2kgbGFzdGJ1cz0wIGxvb2tzIGludGVy
ZXN0aW5nIGFuZCBzbyBkbyBzb21lIG9mIHRoZSBvdGhlcnMgOikuDQo+IA0KDQp5ZWFoLCBwY2k9
bGFzdGJ1cz0wIGlzIHZlcnkgaGVscGZ1bCB0byByZWR1Y2UgdGhlIGJvb3QgdGltZSBpbiBxMzUs
DQprZXJuZWwgd29uJ3Qgc2NhbiB0aGUgMjU1Li4gYnVzZXMgOikNCg0KPiBTdGVmYW4NCj4gDQo=


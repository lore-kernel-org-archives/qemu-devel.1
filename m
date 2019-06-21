Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D79C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03332083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03332083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDRz-0006MV-0V
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:55:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1heDKz-00084e-3n
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1heDHF-00070k-5I
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:44:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:63019)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1heDHD-0006vq-A8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:44:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 23:43:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; d="scan'208";a="243883645"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga001.jf.intel.com with ESMTP; 20 Jun 2019 23:43:55 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Jun 2019 23:43:54 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Jun 2019 23:43:54 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.33]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.72]) with mapi id 14.03.0439.000;
 Fri, 21 Jun 2019 14:43:52 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 "Li Zhijian" <lizhijian@cn.fujitsu.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang
 <zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>, "Stefano
 Stabellini" <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>
Thread-Topic: [PATCH V2 0/5] Add Xen COLO support
Thread-Index: AQHVHuNRBWevQzBoQk2i1pAZg06es6aTwJgAgACjccCAEVckwA==
Date: Fri, 21 Jun 2019 06:43:52 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780618AD39@shsmsx102.ccr.corp.intel.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
 <e02f265c-a0f4-0b34-e3e9-48f0d9eefaf8@redhat.com>
 <9CFF81C0F6B98A43A459C9EDAD400D780615AACB@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <9CFF81C0F6B98A43A459C9EDAD400D780615AACB@shsmsx102.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzBmYWFhYTItYTBiNy00ZWM0LTllM2YtZGUzMDBiZTlmZTM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ0VSa0krdmRYemVheWFXQzkxTzRNKytIU0Q0RjdQVE5tcDQ5Z1pGcGN1U2xvS296SHNnWTFaVVkzdG9DT0xaQSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH V2 0/5] Add Xen COLO support
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QW55b25lIGhhdmUgYW55IGNvbW1lbnRzIGFib3V0IHRoaXMgc2VyaWVzPw0KDQpUaGFua3MNClpo
YW5nIENoZW4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFFlbXUt
ZGV2ZWwgW21haWx0bzpxZW11LWRldmVsLQ0KPiBib3VuY2VzK2NoZW4uemhhbmc9aW50ZWwuY29t
QG5vbmdudS5vcmddIE9uIEJlaGFsZiBPZiBaaGFuZywgQ2hlbg0KPiBTZW50OiBNb25kYXksIEp1
bmUgMTAsIDIwMTkgMTo1NiBQTQ0KPiBUbzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT47IExpIFpoaWppYW4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47DQo+IERyLiBEYXZpZCBB
bGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+OyBKdWFuIFF1aW50ZWxhDQo+IDxxdWlu
dGVsYUByZWRoYXQuY29tPjsgemhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3
ZWkuY29tPjsNCj4gcWVtdS1kZXYgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFN0ZWZhbm8gU3Rh
YmVsbGluaQ0KPiA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz47IFBhdWwgRHVycmFudCA8cGF1bC5k
dXJyYW50QGNpdHJpeC5jb20+DQo+IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSCBWMiAwLzVdIEFkZCBYZW4gQ09M
TyBzdXBwb3J0DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86amFzb3dhbmdAcmVkaGF0LmNvbV0NCj4gPiBTZW50
OiBNb25kYXksIEp1bmUgMTAsIDIwMTkgMTI6MDkgUE0NCj4gPiBUbzogWmhhbmcsIENoZW4gPGNo
ZW4uemhhbmdAaW50ZWwuY29tPjsgTGkgWmhpamlhbg0KPiA+IDxsaXpoaWppYW5AY24uZnVqaXRz
dS5jb20+OyBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0DQo+ID4gPGRnaWxiZXJ0QHJlZGhhdC5jb20+
OyBKdWFuIFF1aW50ZWxhIDxxdWludGVsYUByZWRoYXQuY29tPjsNCj4gPiB6aGFuZ2hhaWxpYW5n
IDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBxZW11LWRldg0KPiA+IDxxZW11LWRl
dmVsQG5vbmdudS5vcmc+OyBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5v
cmc+Ow0KPiA+IFBhdWwgRHVycmFudCA8cGF1bC5kdXJyYW50QGNpdHJpeC5jb20+DQo+ID4gQ2M6
IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCBWMiAwLzVdIEFkZCBYZW4gQ09MTyBzdXBwb3J0DQo+ID4NCj4gPg0KPiA+IE9uIDIwMTkvNi8x
MCDkuIrljYgxMjo0NCwgWmhhbmcgQ2hlbiB3cm90ZToNCj4gPiA+IEZyb206IFpoYW5nIENoZW4g
PGNoZW4uemhhbmdAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+IFhlbiBDT0xPIGJhc2VkIG9uIEtW
TSBDT0xPIGFyY2hpdGVjdHVyZSwgaXQgc2hhcmVkIENPTE8gcHJveHkgYW5kDQo+ID4gPiBibG9j
ayByZXBsaWNhdGlvbiB3aXRoIEtWTSBDT0xPLiBUaGUgb25seSBkaWZmZXJlY2UgaXMgWGVuIENP
TE8gaGF2ZQ0KPiA+ID4gb3duIENPTE8tZnJhbWUgdG8gaGFuZGxlIGxpdmUgbWlncmF0aW9uIHJl
bGF0ZWQgZnVuY3Rpb24sIHNvIHdlIG5lZWQNCj4gPiA+IHRoaXMgc2VyaWVzIG1ha2UgWGVuIENP
TE8gZnJhbWUgY2FuIGNvbW11bmljYXRlIHdpdGggb3RoZXIgQ09MTw0KPiA+ID4gbW9kdWxlcyBp
biBxZW11LiBYZW4gc2lkZSByZWxhdGVkIHBhdGNoZXMgaGF2ZSBiZWVuIG1lcmdlZC4NCj4gPg0K
PiA+DQo+ID4gQW55IHBvaW50ZXIgdG8gdGhpcz8NCj4gPg0KPiANCj4gWWVzLCBwbGVhc2Ugc2Vl
IHRoaXMgdGhyZWFkOg0KPiANCj4gaHR0cHM6Ly9saXN0cy54ZW4ub3JnL2FyY2hpdmVzL2h0bWwv
eGVuLWRldmVsLzIwMTctMDMvbXNnMDA3MTguaHRtbA0KPiANCj4gVGhhbmtzDQo+IFpoYW5nIENo
ZW4NCj4gDQo+ID4gVGhhbmtzDQo+ID4NCj4gPg0KPiA+ID4NCj4gPiA+IFYyOg0KPiA+ID4gICAt
IFJlYmFzZSBvbiB1cHN0cmVhbSBjb2RlLg0KPiA+ID4gICAtIE9wdGltaXplIGNvZGUgYnkgWmhp
amlhbidzIGNvbW1lbnRzIGluIHBhdGNoIDQvNS4NCj4gPiA+ICAgLSBSZW1vdmUgb3JpZ2luIDUv
NiBwYXRjaC4NCj4gPiA+DQo+ID4gPiBWMToNCj4gPiA+ICAgLSBJbml0aWFsIHBhdGNoLg0KPiA+
ID4NCj4gPiA+IFpoYW5nIENoZW4gKDUpOg0KPiA+ID4gICAgQ09MTy1jb21wYXJlOiBBZGQgbmV3
IHBhcmFtZXRlciB0byBjb21tdW5pY2F0ZSB3aXRoIHJlbW90ZSBjb2xvLQ0KPiA+IGZyYW1lDQo+
ID4gPiAgICBDT0xPLWNvbXBhcmU6IEFkZCByZW1vdGUgbm90aWZpY2F0aW9uIGNoYXJkZXYgaGFu
ZGxlciBmcmFtZQ0KPiA+ID4gICAgQ09MTy1jb21wYXJlOiBNYWtlIHRoZSBjb21wYXJlX2Nocl9z
ZW5kKCkgY2FuIHNlbmQgbm90aWZpY2F0aW9uDQo+ID4gPiAgICAgIG1lc3NhZ2UuDQo+ID4gPiAg
ICBDT0xPLWNvbXBhcmU6IEFkZCBjb2xvLWNvbXBhcmUgcmVtb3RlIG5vdGlmeSBzdXBwb3J0DQo+
ID4gPiAgICBtaWdyYXRpb24vY29sby5jOiBBZGQgbWlzc2VkIGZpbHRlciBub3RpZnkgZm9yIFhl
biBDT0xPLg0KPiA+ID4NCj4gPiA+ICAgbWlncmF0aW9uL2NvbG8uYyAgIHwgICAyICsNCj4gPiA+
ICAgbmV0L2NvbG8tY29tcGFyZS5jIHwgMTU1DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0NCj4gPiAtLS0NCj4gPiA+ICAgcWVtdS1vcHRpb25zLmh4ICAg
IHwgIDMzICsrKysrKysrKy0NCj4gPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNzEgaW5zZXJ0aW9u
cygrKSwgMTkgZGVsZXRpb25zKC0pDQo+ID4gPg0K


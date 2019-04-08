Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E0C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 00:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF0F20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 00:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF0F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45285 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDIDt-00035I-0M
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 20:33:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1hDID4-0002mQ-80
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 20:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1hDID2-00084E-OT
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 20:32:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1hDID2-0007pU-B1
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 20:32:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Apr 2019 17:32:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; d="scan'208";a="221406587"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
	by orsmga001.jf.intel.com with ESMTP; 07 Apr 2019 17:32:15 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
	fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 7 Apr 2019 17:32:15 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
	fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Sun, 7 Apr 2019 17:32:15 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.92]) by
	SHSMSX106.ccr.corp.intel.com ([169.254.10.21]) with mapi id
	14.03.0415.000; Mon, 8 Apr 2019 08:32:13 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Elijah Shakkour <elijahsh@mellanox.com>, Peter Xu <peterx@redhat.com>
Thread-Topic: QEMU and vIOMMU support for emulated VF passthrough to nested
	(L2) VM
Thread-Index: AQHU6rQUf10CGYezxEGbJ2w753/2CaYrmjwQgASbDICAATnhUA==
Date: Mon, 8 Apr 2019 00:32:12 +0000
Message-ID:
 <AADFC41AFE54684AB9EE6CBC0274A5D19C9D1F97@SHSMSX104.ccr.corp.intel.com>
References: <AM6PR05MB6616E9FDE038EA2B0665DD9CBD540@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401024710.GB8853@xz-x1>
	<AM6PR05MB6616E9F5EE3B3B531266B73DBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190401102515.GD8853@xz-x1>
	<AM6PR05MB6616E41924ADEC1CFC6053BFBD550@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<c89218b50e3b015edc4d7f9490138929a97b8268.camel@oracle.com>
	<AM6PR05MB6616081C90DBA9C552B847BEBD560@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190403024018.GK11008@xz-x1>
	<AM6PR05MB6616802C8D185F294565E74CBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<AM6PR05MB66164C0598CFA23FFEEC6C4BBD570@AM6PR05MB6616.eurprd05.prod.outlook.com>
	<20190404065948.GB23212@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9CE809@SHSMSX104.ccr.corp.intel.com>
	<AM6PR05MB6616FF1FD229194F40882133BD530@AM6PR05MB6616.eurprd05.prod.outlook.com>
In-Reply-To: <AM6PR05MB6616FF1FD229194F40882133BD530@AM6PR05MB6616.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmE5YzhlMmQtZTFjNS00N2Y4LTg2NTItYmRkY2ZjMTQ3ZWJmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic1pUYWdvODhDcjRUMUpXTDBOSGVrNUEwRWdFQmlWY3FYVnV4SmNQbXNWcitXWDZkZG5EcmtqSVVpeFwvdVJBdUMifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] QEMU and vIOMMU support for emulated VF
 passthrough to nested (L2) VM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
	Knut Omang <knut.omang@oracle.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408003212.TaPzSMshWZwtRgbtczVAi82hKxYb9_aZ-vYoGzCgCbg@z>

PiBGcm9tOiBFbGlqYWggU2hha2tvdXIgW21haWx0bzplbGlqYWhzaEBtZWxsYW5veC5jb21dDQo+
IFNlbnQ6IFN1bmRheSwgQXByaWwgNywgMjAxOSA5OjQ3IFBNDQo+IA0KPiANCj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFRpYW4sIEtldmluIDxrZXZpbi50aWFuQGlu
dGVsLmNvbT4NCj4gPiBTZW50OiBUaHVyc2RheSwgQXByaWwgNCwgMjAxOSAxMDo1OCBBTQ0KPiA+
IFRvOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+OyBFbGlqYWggU2hha2tvdXINCj4gPiA8
ZWxpamFoc2hAbWVsbGFub3guY29tPg0KPiA+IENjOiBLbnV0IE9tYW5nIDxrbnV0Lm9tYW5nQG9y
YWNsZS5jb20+OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPiA8bXN0QHJlZGhhdC5jb20+OyBBbGV4
IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPjsNCj4gPiBNYXJjZWwgQXBm
ZWxiYXVtIDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47IFN0ZWZhbiBIYWpub2N6aQ0KPiA+
IDxzdGVmYW5oYUBnbWFpbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiBTdWJqZWN0
OiBSRTogUUVNVSBhbmQgdklPTU1VIHN1cHBvcnQgZm9yIGVtdWxhdGVkIFZGIHBhc3N0aHJvdWdo
IHRvDQo+ID4gbmVzdGVkIChMMikgVk0NCj4gPg0KPiA+ID4gRnJvbTogUGV0ZXIgWHUgW21haWx0
bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCA0LCAyMDE5
IDM6MDAgUE0NCj4gPiA+DQo+ID4gPiBPbiBXZWQsIEFwciAwMywgMjAxOSBhdCAxMDoxMDozNVBN
ICswMDAwLCBFbGlqYWggU2hha2tvdXIgd3JvdGU6DQo+ID4gPg0KPiA+ID4gWy4uLl0NCj4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFlvdSBjYW4gYWxzbyB0cnkgdG8gZW5hYmxlIFZULWQgZGV2
aWNlIGxvZyBieSBhcHBlbmRpbmc6DQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgLXRyYWNlIGVuYWJsZT0idnRkXyoiDQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+ID4gPiA+IEluIGNhc2UgaXQgZHVtcHMgYW55dGhpbmcgdXNlZnVsIGZvciB5b3Uu
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhlcmUgaXMgdGhlIHJlbGV2YW50IGR1bXAg
KGRldiAwMTowMC4wMSBpcyBteSBWRik6DQo+ID4gPiA+ID4gPiA+ICINCj4gPiA+ID4gPiA+ID4g
dnRkX2ludl9kZXNjX2NjX2RldmljZSBjb250ZXh0IGludmFsaWRhdGUgZGV2aWNlIDAxOjAwLjAx
DQo+ID4gPiA+ID4gPiA+IHZ0ZF9jZV9ub3RfcHJlc2VudCBDb250ZXh0IGVudHJ5IGJ1cyAxIGRl
dmZuIDEgbm90IHByZXNlbnQNCj4gPiA+ID4gPiA+ID4gdnRkX3N3aXRjaF9hZGRyZXNzX3NwYWNl
IERldmljZSAwMTowMC4xIHN3aXRjaGluZyBhZGRyZXNzDQo+ID4gPiA+ID4gPiA+IHNwYWNlIChp
b21tdQ0KPiA+ID4gPiA+ID4gPiBlbmFibGVkPTEpIHZ0ZF9jZV9ub3RfcHJlc2VudCBDb250ZXh0
IGVudHJ5IGJ1cyAxIGRldmZuIDEgbm90DQo+ID4gPiA+ID4gPiA+IHByZXNlbnQgdnRkX2VyciBE
ZXRlY3RlZCBpbnZhbGlkIGNvbnRleHQgZW50cnkgd2hlbiB0cnlpbmcgdG8NCj4gPiA+ID4gPiA+
ID4gc3luYyBzaGFkb3cgcGFnZSB0YWJsZQ0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoZXNl
IGxpbmVzIG1lYW4gdGhhdCB0aGUgZ3Vlc3Qgc2VudCBhIGRldmljZSBpbnZhbGlkYXRpb24gdG8N
Cj4gPiA+ID4gPiA+IHlvdXIgVkYgYnV0IHRoZSBJT01NVSBmb3VuZCB0aGF0IHRoZSBkZXZpY2Ug
Y29udGV4dCBlbnRyeSBpcw0KPiA+IG1pc3NpbmcuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiB2dGRfaW90bGJfY2NfdXBkYXRlIElPVExCIGNvbnRleHQgdXBkYXRlIGJ1cyAweDEgZGV2Zm4g
MHgxDQo+ID4gPiA+ID4gPiA+IGhpZ2gNCj4gPiA+ID4gPiA+ID4gMHgxMDIgbG93IDB4MmQwMDcw
MDMgZ2VuIDAgLT4gZ2VuIDINCj4gPiA+ID4gPiA+ID4gdnRkX2Vycl9kbWFyX3NscHRlX3Jlc3Zf
ZXJyb3IgaW92YQ0KPiA+ID4gPiA+ID4gPiAweGYwOGU3MDAwIGxldmVsIDIgc2xwdGUgMHgyYTU0
MDA4ZjcNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIGxpbmUgc2hvdWxkIG5vdCBleGlz
dCBpbiBsYXRlc3QgUUVNVS4gIEFyZSB5b3Ugc3VyZSB5b3UncmUNCj4gPiA+ID4gPiA+IHVzaW5n
IHRoZSBsYXRlc3QgUUVNVT8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgbW92ZWQgbm93IHRvIFFF
TVUgNC4wIFJDMi4NCj4gPiA+ID4gPiBUaGlzIGlzIHRoZSB3aGF0IEkgZ2V0IG5vdzoNCj4gPiA+
ID4gPiB2dGRfaW90bGJfY2NfdXBkYXRlIElPVExCIGNvbnRleHQgdXBkYXRlIGJ1cyAweDEgZGV2
Zm4gMHgxIGhpZ2gNCj4gPiA+ID4gPiAweDEwMg0KPiA+ID4gbG93DQo+ID4gPiA+ID4gMHgyZjAw
NzAwMyBnZW4gMCAtPiBnZW4gMQ0KPiA+ID4gPiA+IHFlbXUtc3lzdGVtLXg4Nl82NDogdnRkX2lv
dmFfdG9fc2xwdGU6IGRldGVjdGVkIHNwbHRlIHJlc2VydmUNCj4gPiA+ID4gPiBub24temVybyBp
b3ZhPTB4ZjBkMjkwMDAsIGxldmVsPTB4MnNscHRlPTB4MjlmNjAwOGY3KQ0KPiA+ID4gPiA+IHZ0
ZF9mYXVsdF9kaXNhYmxlZCBGYXVsdCBwcm9jZXNzaW5nIGRpc2FibGVkIGZvciBjb250ZXh0IGVu
dHJ5DQo+ID4gPiA+ID4gcWVtdS1zeXN0ZW0teDg2XzY0OiB2dGRfaW9tbXVfdHJhbnNsYXRlOiBk
ZXRlY3RlZCB0cmFuc2xhdGlvbg0KPiA+ID4gPiA+IGZhaWx1cmUgKGRldj0wMTowMDowMSwgaW92
YT0weGYwZDI5MDAwKSBVbmFzc2lnbmVkIG1lbSByZWFkDQo+ID4gPiAwMDAwMDAwMGYwZDI5MDAw
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJJ20gbm90IGZhbWlsaWFyIHdpdGggdklPTU1VIHJlZ2lz
dGVycywgYnV0IEkgbm90aWNlZCB0aGF0IEkgbXVzdA0KPiA+ID4gPiA+IHJlcG9ydCBzbm9vcCBj
b250cm9sIHN1cHBvcnQgdG8gSHlwZXItViAoaS5lLiBiaXQgNyBpbiBleHRlbmRlZA0KPiA+ID4g
PiA+IGNhcGFiaWxpdHkgcmVnaXN0ZXINCj4gPiA+IG9mDQo+ID4gPiA+ID4gdklPTU1VKSBpbi1v
cmRlciB0byBzYXRpc2Z5IElPTU1VIHN1cHBvcnQgZm9yIFNSSU9WLg0KPiA+ID4gPiA+IHZJT01N
VS5lY2FwIGJlZm9yZSAgICAweGYwMGY1ZQ0KPiA+ID4gPiA+IHZJT01NVS5lY2FwIGFmdGVyICAg
ICAgIDB4ZjAwZmRlDQo+ID4gPiA+ID4gQnV0IEkgc2VlIHRoYXQgdklPTU1VIGRvZXNuJ3QgcmVh
bGx5IHN1cHBvcnQgc25vb3AgY29udHJvbC4NCj4gPiA+ID4gPiBDb3VsZCB0aGlzIGJlIHRoZSBw
cm9ibGVtIHRoYXQgZmFpbHMgSU9WQSByYW5nZSBjaGVjayBpbiB0aGlzDQo+ID4gPiA+ID4gZnVu
Y3Rpb24gdnRkX2lvdmFfcmFuZ2VfY2hlY2soKT8NCj4gPiA+ID4NCj4gPiA+ID4gU29ycnksIEkg
bWVhbnQgdGhlIFNMUFRFIHJlc2VydmVkIG5vbi16ZXJvIGNoZWNrIGZhaWx1cmUgaW4NCj4gPiA+
IHZ0ZF9zbHB0ZV9ub256ZXJvX3JzdmQoKQ0KPiA+ID4gPiBBbmQgTk9UIElPVkEgcmFuZ2UgY2hl
Y2sgZmFpbHVyZSAoc2luY2UgcmFuZ2UgY2hlY2sgZGlkbid0IGZhaWwpDQo+ID4gPg0KPiA+ID4g
UHJvYmFibHkuICBDdXJyZW50bHkgVlQtZCBlbXVsYXRpb24gZG9lcyBub3Qgc3VwcG9ydCBzbm9v
cGluZyBjb250cm9sLA0KPiA+ID4gYW5kIGlmIHlvdSBtb2RpZnkgdGhhdCBlY2FwIG9ubHkgeW91
IHByb2JhYmx5IHdpbGwgZW5jb3VudGVyIHRoaXMNCj4gPiA+IHByb2JsZW0gYmVjYXVzZSB0aGVu
IHRoZSBndWVzdCBrZXJuZWwgd2lsbCBzZXR1cCB0aGUgU05QIGJpdCBpbiB0aGUNCj4gPiA+IElP
TU1VIHBhZ2UgdGFibGUgZW50cmllcyB3aGljaCB3aWxsIHZpb2xhdGUgdGhlIHJlc2VydmVkIGJp
dHMgaW4gdGhlDQo+ID4gPiBlbXVsYXRpb24gY29kZSB0aGVuIHlvdSBjYW4gc2VlIHRoZXNlIGVy
cm9ycy4NCj4gPiA+DQo+ID4gPiBOb3cgdGFsa2luZyBhYm91dCBpbXBsZW1lbnRpbmcgdGhlIFNu
b29wIENvbnRyb2wgZm9yIEludGVsIElPTU1VIGZvcg0KPiA+ID4gcmVhbCAod2hpY2ggY29ycmVz
cG9uZHMgdG8gdnQtZCBlY2FwIGJpdCA3KSAtIEknZCBjb25mZXNzIEknbSBub3QgMTAwJQ0KPiA+
ID4gY2xlYXIgb24gd2hhdCBkb2VzIHRoZSAic25vb3BpbmciIG1lYW4gYW5kIHdoYXQgd2UgbmVl
ZCB0byBkbyBhcyBhbg0KPiA+ID4gZW11bGF0b3IuIEknbSBxdW90dGluZyBmcm9tIHNwZWM6DQo+
ID4gPg0KPiA+ID4gICAiU25vb3AgYmVoYXZpb3IgZm9yIGEgbWVtb3J5IGFjY2VzcyAodG8gYSB0
cmFuc2xhdGlvbiBzdHJ1Y3R1cmUNCj4gPiA+ICAgZW50cnkgb3IgYWNjZXNzIHRvIHRoZSBtYXBw
ZWQgcGFnZSkgc3BlY2lmaWVzIGlmIHRoZSBhY2Nlc3MgaXMNCj4gPiA+ICAgY29oZXJlbnQgKHNu
b29wcyB0aGUgcHJvY2Vzc29yIGNhY2hlcykgb3Igbm90LiINCj4gPiA+DQo+ID4gPiBJZiBpdCBp
cyBvbmx5IGEgY2FwYWJpbGl0eSBzaG93aW5nIHRoYXQgd2hldGhlciB0aGUgaGFyZHdhcmUgaXMN
Cj4gPiA+IGNhcGFibGUgb2Ygc25vb3BpbmcgcHJvY2Vzc29yIGNhY2hlcywgdGhlbiBJIGRvbid0
IHRoaW5rIHdlIG5lZWQgdG8gZG8NCj4gPiA+IG11Y2ggaGVyZSBhcyBhbiBlbXVsYXRvciBvZiBW
VC1kIHNpbXBseSBiZWNhdXNlIHdoZW4gd2UgYWNjZXNzIHRoZQ0KPiA+ID4gZGF0YSB3ZSdyZSBz
dGlsbCBmcm9tIHRoZSBwcm9jZXNzb3IncyBzaWRlIChiZWNhdXNlIHdlJ3JlIGVtdWxhdGluZw0K
PiA+ID4gdGhlIElPTU1VIGJlaGF2aW9yIG9ubHkpIHNvIHRoZSBjYWNoZSBzaG91bGQgYWx3YXlz
IGJlZW4gY29oZXJlbnQNCj4gZnJvbQ0KPiA+ID4gdGhlIFBPViBvZiBndWVzdCB2Q1BVcywganVz
dCBsaWtlIGhvdyB0aGUgcHJvY2Vzc29ycyBwcm92aWRlIGNhY2hlDQo+ID4gPiBjb2hlcmVuY2Ug
YmV0d2VlbiB0d28gY29yZXMgKHNvIElNSE8gaGVyZSB0aGUgVlQtZCBlbXVsYXRpb24gY29kZQ0K
PiBjYW4NCj4gPiA+IGJlIHJ1biBvbiBvbmUgY29yZS90aHJlYWQsIGFuZCB0aGUgdmNwdSB3aGlj
aCBydW5zIHRoZSBndWVzdCBpb21tdQ0KPiA+ID4gZHJpdmVyIGNhbiBiZSBydW4gb24gYW5vdGhl
ciBjb3JlL3RocmVhZCkuICBJZiBzbywgbWF5YmUgd2UgY2FuIHNpbXBseQ0KPiA+ID4gZGVjbGFy
ZSBzdXBwb3J0IG9mIHRoYXQgYnV0IHdlIGF0IGxlYXN0IGFsc28gbmVlZCB0byByZW1vdmUgdGhl
IFNOUA0KPiA+ID4gYml0IGZyb20gdnRkX3BhZ2luZ19lbnRyeV9yc3ZkX2ZpZWxkW10gYXJyYXkg
dG8gcmVmbGVjdCB0aGF0IHdlDQo+ID4gPiB1bmRlcnN0YW5kIHRoYXQgYml0Lg0KPiA+ID4NCj4g
PiA+IENDaW5nIEFsZXggYW5kIEtldmluIHRvIHNlZSB3aGV0aGVyIEknbSBtaXN1bmRlcnN0YW5k
aW5nIG9yIGluIGNhc2Ugb2YNCj4gPiA+IGFueSBmdXJ0aGVyIGlucHV0IG9uIHRoZSBzbm9vcGlu
ZyBzdXBwb3J0Lg0KPiA+ID4NCj4gPg0KPiA+IGZvciBzb2Z0d2FyZSBETUEgeWVzIHNub29wIGlz
IGd1YXJhbnRlZWQgc2luY2UgaXQncyBqdXN0IENQVSBhY2Nlc3MuDQo+ID4NCj4gPiBIb3dldmVy
IGZvciBWRklPIGRldmljZSBpLmUuIGhhcmR3YXJlIERNQSwgc25vb3Agc2hvdWxkIGJlIHJlcG9y
dGVkDQo+ID4gYmFzZWQgb24gcGh5c2ljYWwgSU9NTVUgY2FwYWJpbGl0eS4gSXQncyBmaW5lIHRv
IHJlcG9ydCBubyBzbm9vcCBjb250cm9sIG9uDQo+ID4gdklPTU1VIChjdXJyZW50IHN0YXRlKSBl
dmVuIHdoZW4gaXQncyBwaHlzaWNhbGx5IHN1cHBvcnRlZC4gSXQganVzdCByZXN1bHRzDQo+ID4g
dGhhdCBMMSBWTU0gbXVzdCBmYXZvciBndWVzdCBjYWNoZSBhdHRyaWJ1dGVzIGluc3RlYWQgb2Yg
Zm9yY2luZyBXQiBpbiBMMQ0KPiA+IEVQVCB3aGVuIGRvaW5nIG5lc3RlZCBwYXNzdGhyb3VnaC4g
SG93ZXZlciBpdCdzIGluY29ycmVjdCB0byByZXBvcnQgc25vb3ANCj4gPiBjb250cm9sIG9uIHZJ
T01NVSB3aGVuIHBoeXNpY2FsbHkgaXQncyBub3Qgc3VwcG9ydGVkLCBvdGhlcndpc2UgTDEgVk1N
DQo+ID4gbWF5IGZvcmNlIFdCIGluIEwxIEVQVCBhbmQgZW5hYmxlIHNub29wIGZpZWxkIGluIHZJ
T01NVSAybmQgbGV2ZWwgUFRFDQo+IHdpdGgNCj4gPiBhc3N1bXB0aW9uIHRoYXQgaGFyZHdhcmUg
c25vb3AgaXMgZ3VhcmFudGVlZCAoaG93ZXZlciBpdCBpc24ndCkuIFRoZW4gaXQNCj4gPiBiZWNv
bWVzIGEgY29ycmVjdG5lc3MgaXNzdWUuDQo+ID4NCj4gDQo+IElmIG15IGRldmljZSBpcyBmdWxs
eSBlbXVsYXRlZCwgY2FuIEkgaWdub3JlIHRoZSBTTlAgYml0IGluIHRoZSBTTFBURT8gV2hhdCBp
cw0KPiB0aGUgY29zdCBvZiBpZ25vcmluZyBpdCBpbiBzdWNoIGEgY2FzZT8gV2hhdCBjb3VsZCBn
byB3cm9uZz8NCj4gKEkgdHJpZWQgdG8gaWdub3JlIGl0IGFuZCBpdCBzZWVtcyB0aGF0IHRyYW5z
bGF0aW9ucyB3b3JrIGZvciBtZSBub3cpLg0KPiANCg0KSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1l
YW50IGJ5ICdpZ25vcmUnIGhlcmUuIEJ1dCBhcyBlYXJsaWVyIHBvaW50ZWQNCm91dCBieSBQZXRl
ciwgZm9yIGVtdWxhdGVkIGRldmljZXMgeW91IGRvbid0IG5lZWQgZG8gYW55dGhpbmcgc3BlY2lh
bA0KaGVyZS4gWW91IGNhbiBqdXN0IHJlcG9ydCBzbm9vcCBjYXBhYmlsaXR5IGFuZCB0aGVuIHJl
bW92ZSBpdCBmcm9tDQpyZXNlcnZlZCBiaXQgY2hlY2sgaW4gU0xQVEUuDQoNClRoYW5rcw0KS2V2
aW4NCg==


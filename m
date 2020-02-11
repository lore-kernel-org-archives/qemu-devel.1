Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54894C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E862070A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E862070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1RO3-0003cy-8Q
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1j1RNP-0003At-HM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:58:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1j1RNN-0005TY-FQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:58:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:16096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1j1RNN-0005IV-6N
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:58:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Feb 2020 00:58:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; d="scan'208";a="226441917"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga008.jf.intel.com with ESMTP; 11 Feb 2020 00:58:30 -0800
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Feb 2020 00:58:24 -0800
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 16:58:22 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 11 Feb 2020 16:58:22 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Thread-Topic: [PATCH V4 0/5] Introduce Advanced Watch Dog module
Thread-Index: AQHVtNkQRvIivFPjlkOOUrHE3VnstKfevUyAgBKjcBCAASn2AIAjdzsw
Date: Tue, 11 Feb 2020 08:58:22 +0000
Message-ID: <3049425105b94f6cb9cd846c84c95a84@intel.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
 <fa1ed6cb-63d7-ee83-a5a0-b099b662fef2@intel.com>
 <0502a0db0a17484c9220b3a63c40b397@intel.com>
 <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
In-Reply-To: <08a1a225-52c1-4e6c-85f7-fcf6612b5383@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTMwMTEzZDUtMTczOS00ZDFmLWI5ZGMtN2FjNjcwNTRiODAxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieHc3WkRnWnNoUHArVVVtNVI5MVBuektCRlFoTWV4K3F4aWt6VnNMamRrS2E3SnVsamhYRlhFMHBtdjh0a1J4ZyJ9
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDIwLCAyMDIwIDEwOjU3
IEFNDQo+IFRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBQYW9sbyBCb256
aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEByZWRoYXQuY29tPjsNCj4gcWVtdS1kZXYgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4g
Q2M6IFpoYW5nIENoZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggVjQgMC81XSBJbnRyb2R1Y2UgQWR2YW5jZWQgV2F0Y2ggRG9nIG1vZHVsZQ0KPiANCj4gDQo+
IE9uIDIwMjAvMS8xOSDkuIvljYg1OjEwLCBaaGFuZywgQ2hlbiB3cm90ZToNCj4gPiBIaX4NCj4g
Pg0KPiA+IEFueW9uZSBoYXZlIGNvbW1lbnRzIGFib3V0IHRoaXMgbW9kdWxlPw0KPiANCj4gDQo+
IEhpIENoZW46DQo+IA0KPiBJIHdpbGwgdGFrZSBhIGxvb2sgYXQgdGhpcyBzZXJpZXMuDQoNClNv
cnJ5IGZvciBzbG93IHJlcGx5IGR1ZSB0byBDTlkgYW5kIGV4dGVuZCBsZWF2ZS4NCk9LLCB3YWl0
aW5nIHlvdXIgY29tbWVudHN+IFRoYW5rc34NCg0KPiANCj4gVHdvIGdlbmVyYWwgcXVlc3Rpb25z
Og0KPiANCj4gLSBpZiBpdCBjYW4gZGV0ZWN0IG1vcmUgdGhhbiBuZXR3b3JrIHN0YWxsLCBpdCBz
aG91bGQgbm90IGJlbG9uZyB0byAvbmV0DQoNClRoaXMgbW9kdWxlIHVzZSBuZXR3b3JrIGNvbm5l
Y3Rpb24gc3RhdHVzIHRvIGRldGVjdCBhbGwgdGhlIGlzc3VlKEhvc3QgdG8gR3Vlc3QvSG9zdCB0
byBIb3N0L0hvc3QgdG8gQWRtaW4uLi4pLg0KVGhlIHRhcmdldCBpcyBtb3JlIHRoYW4gbmV0d29y
ayBidXQgYWxsIHVzZSBuZXR3b3JrIHdheS4gU28gaXQgaXMgbG9va3MgYSB0cmlja3kgcHJvYmxl
bS4NCg0KPiAtIG5lZWQgdG8gY29udmluY2UgbGlidmlydCBndXlzIGZvciB0aGlzIHByb3Bvc2Fs
LCBzaW5jZSB1c3VhbGx5IGl0J3MgdGhlIGR1dHkgb2YNCj4gdXBwZXIgbGF5ZXIgaW5zdGVhZCBv
ZiBxZW11IGl0c2VsZg0KPiANCg0KWWVzLCBJdCBsb29rcyBhIHVwcGVyIGxheWVyIHJlc3BvbnNp
YmlsaXR5LCBidXQgSW4gdGhlIGNvdmVyIGxhdHRlciBJIGhhdmUgZXhwbGFpbmVkIHRoZSByZWFz
b24gd2h5IHdlIG5lZWQgdGhpcyBpbiBRZW11Lg0KIHRyeSB0byBtYWtlIHRoaXMgbW9kdWxlIGFz
IHNpbXBsZSBhcyBwb3NzaWJsZS4gVGhpcyBtb2R1bGUgZ2l2ZSB1cHBlciBsYXllciBzb2Z0d2Fy
ZSBhIG5ldyB3YXkgdG8gY29ubmVjdC9tb25pdG9yaW5nIFFlbXUuDQpBbmQgZHVlIHRvIGFsbCB0
aGUgQ09MTyBjb2RlIGltcGxlbWVudCBpbiBRZW11IHNpZGUsIE1hbnkgY3VzdG9tZXIgd2FudCB0
byB1c2UgdGhpcyBGVCBzb2x1dGlvbiB3aXRob3V0IG90aGVyIGRlcGVuZGVuY2llcywNCml0IGlz
IHZlcnkgZWFzeSB0byBpbnRlZ3JhdGVkIHRvIHJlYWwgcHJvZHVjdC4gDQoNClRoYW5rcw0KWmhh
bmcgQ2hlbg0KDQo+IFRoYW5rcw0KPiANCj4gDQo+ID4gV2UgaGF2ZSBzb21lIGNsaWVudHMgYWxy
ZWFkeSB0cnkgdG8gdXNlIHRoaXMgbW9kdWxlIHdpdGggQ09MTy4gUGxlYXNlDQo+IHJldmlldyB0
aGlzIHBhcnQuDQo+ID4gSWYgbm8gb25lIHdhbnQgdG8gbWFpbnRhaW4gdGhpcyBtb2R1bGUsIEkg
Y2FuIG1haW50YWluIHRoaXMgbW9kdWxlIG15c2VsZi4NCj4gPg0KPiA+IFRoYW5rcw0KPiA+IFpo
YW5nIENoZW4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBRZW11LWRldmVsIDxxZW11LWRldmVsLQ0KPiA+PiBib3VuY2VzK2NoZW4uemhhbmc9aW50ZWwu
Y29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBaaGFuZywgQ2hlbg0KPiA+PiBTZW50OiBUdWVz
ZGF5LCBKYW51YXJ5IDcsIDIwMjAgMTI6MzMgUE0NCj4gPj4gVG86IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+ID4+IDxwYm9uemluaUByZWRoYXQuY29t
PjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gPHBoaWxtZEByZWRoYXQuY29tPjsNCj4gPj4g
cWVtdS1kZXYgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gQ2M6IFpoYW5nIENoZW4gPHpo
YW5nY2tpZEBnbWFpbC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMC81XSBJbnRy
b2R1Y2UgQWR2YW5jZWQgV2F0Y2ggRG9nIG1vZHVsZQ0KPiA+Pg0KPiA+PiBIaSBBbGwsDQo+ID4+
DQo+ID4+IE5vIG5ld3MgZm9yIGEgd2hpbGUgYWJvdXQgdGhpcyBzZXJpZXMuDQo+ID4+DQo+ID4+
IFRoaXMgdmVyc2lvbiBhbHJlYWR5IGFkZCBuZXcgZG9jcyB0byBhZGRyZXNzIFBhb2xvJ3MgY29t
bWVudHMuDQo+ID4+DQo+ID4+IFBsZWFzZSBnaXZlIG1lIG1vcmUgY29tbWVudHMuDQo+ID4+DQo+
ID4+DQo+ID4+IFRoYW5rcw0KPiA+Pg0KPiA+PiBaaGFuZyBDaGVuDQo+ID4+DQo+ID4+DQo+ID4+
IE9uIDEyLzE3LzIwMTkgODo0NSBQTSwgWmhhbmcsIENoZW4gd3JvdGU6DQo+ID4+PiBGcm9tOiBa
aGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT4NCj4gPj4+DQo+ID4+PiBBZHZhbmNlZCBX
YXRjaCBEb2cgaXMgYW4gdW5pdmVyc2FsIG1vbml0b3JpbmcgbW9kdWxlIG9uIFZNTSBzaWRlLCBp
dA0KPiA+Pj4gY2FuIGJlIHVzZWQgdG8gZGV0ZWN0IG5ldHdvcmsgZG93bihWTU0gdG8gZ3Vlc3Qs
IFZNTSB0byBWTU0sDQo+IFZNTQ0KPiA+PiB0bw0KPiA+Pj4gYW5vdGhlciByZW1vdGUgc2VydmVy
KSBhbmQgZG8gcHJldmlvdXNseSBzZXQgb3BlcmF0aW9uLiBDdXJyZW50IEFXRA0KPiA+Pj4gcGF0
Y2gganVzdCBhY2NlcHQgYW55IGlucHV0IGFzIHRoZSBzaWduYWwgdG8gcmVmcmVzaCB0aGUgd2F0
Y2hkb2cNCj4gPj4+IHRpbWVyLCBhbmQgd2UgY2FuIGFsc28gbWFrZSBhIGNlcnRhaW4gaW50ZXJh
Y3RpdmUgcHJvdG9jb2wgaGVyZS4gRm9yDQo+ID4+PiB0aGUgb3V0cHV0cywgdXNlciBjYW4gcHJl
LXdyaXRlIHNvbWUgY29tbWFuZCBvciBzb21lIG1lc3NhZ2VzIGluDQo+IHRoZQ0KPiA+Pj4gQVdE
IG9wdC1zY3JpcHQuIFdlIG5vdGljZWQgdGhhdCB0aGVyZSBpcyBubyB3YXkgZm9yIFZNTSBjb21t
dW5pY2F0ZQ0KPiA+Pj4gZGlyZWN0bHksIG1heWJlIHNvbWUgcGVvcGxlIHRoaW5rIHdlIGRvbid0
IG5lZWQgc3VjaCB0aGluZ3ModXAgbGF5ZXINCj4gPj4+IHNvZnR3YXJlIGxpa2Ugb3BlbnN0YWNr
IGNhbiBoYW5kbGUgaXQpLiBzbyB3ZSBlbmdhZ2VkIHdpdGggcmVhbA0KPiA+Pj4gY3VzdG9tZXIg
Zm91bmQgdGhhdCB0aGV5IG5lZWQgYSBsaWdodHdlaWdodCBhbmQgZWZmaWNpZW50IG1lY2hhbmlz
bQ0KPiA+Pj4gdG8gc29sdmUgc29tZSBwcmFjdGljYWwgcHJvYmxlbXMsDQo+ID4+Pg0KPiA+Pj4g
Rm9yIGV4YW1wbGUgRWRnZSBDb21wdXRpbmcgY2FzZXModGhleSB0aGluayBoaWdoIGxldmVsIHNv
ZnR3YXJlIGlzDQo+ID4+PiB0b28gaGVhdnkgdG8gdXNlIGluIEVkZ2Ugb3IgaXQgaXMgaGFyZCB0
byBtYW5hZ2UgYW5kIGNvbWJpbmUgd2l0aCBWTQ0KPiBpbnN0YW5jZSkuDQo+ID4+PiBJdCBtYWtl
IHVzZXIgaGF2ZSBiYXNpYyBWTS9Ib3N0IG5ldHdvcmsgbW9uaXRvcmluZyB0b29scyBhbmQgYmFz
aWMNCj4gPj4+IGZhbHNlIHRvbGVyYW5jZSBhbmQgcmVjb3Zlcnkgc29sdXRpb24uLg0KPiA+Pj4N
Cj4gPj4+IFBsZWFzZSBzZWUgdGhlIGRldGFpbCBkb2N1bWVudGF0aW9uIGluIHRoZSBsYXN0IHBh
dGNoLg0KPiA+Pj4NCj4gPj4+IFY0Og0KPiA+Pj4gICAgLSBBZGQgbW9yZSBpbnRyb2R1Y3Rpb24g
aW4gcWVtdS1vcHRpb25zLmh4DQo+ID4+PiAgICAtIEFkZHJlc3NlZCBQYW9sbydzIGNvbW1lbnRz
IGFkZCBkb2NzL2F3ZC50eHQgZm9yIHRoZSBBV0QgbW9kdWxlDQo+ID4+IGRldGFpbC4NCj4gPj4+
IFYzOg0KPiA+Pj4gICAgLSBSZWJhc2VkIG9uIFFlbXUgNC4yLjAtcmMxIGNvZGUuDQo+ID4+PiAg
ICAtIEZpeCBjb21taXQgbWVzc2FnZSBpc3N1ZS4NCj4gPj4+DQo+ID4+PiBWMjoNCj4gPj4+ICAg
IC0gQWRkcmVzc2VkIFBoaWxpcHBlIGNvbW1lbnRzIGFkZCBjb25maWd1cmUgc2VsZWN0b3IgZm9y
IEFXRC4NCj4gPj4+DQo+ID4+PiBJbml0aWFsOg0KPiA+Pj4gICAgLSBJbml0aWFsIHZlcnNpb24u
DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IFpoYW5nIENoZW4gKDUpOg0KPiA+Pj4gICAgIG5ldC9hd2Qu
YzogSW50cm9kdWNlIEFkdmFuY2VkIFdhdGNoIERvZyBtb2R1bGUgZnJhbWV3b3JrDQo+ID4+PiAg
ICAgbmV0L2F3ZC5jOiBJbml0YWlsaXplIGlucHV0L291dHB1dCBjaGFyZGV2DQo+ID4+PiAgICAg
bmV0L2F3ZC5jOiBMb2FkIGFkdmFuY2VkIHdhdGNoIGRvZyB3b3JrZXIgdGhyZWFkIGpvYg0KPiA+
Pj4gICAgIHZsLmM6IE1ha2UgQWR2YW5jZWQgV2F0Y2ggRG9nIGRlbGF5ZWQgaW5pdGlhbGl6YXRp
b24NCj4gPj4+ICAgICBkb2NzL2F3ZC50eHQ6IEFkZCBkb2MgdG8gaW50cm9kdWNlIEFkdmFuY2Vk
IFdhdGNoRG9nKEFXRCkNCj4gbW9kdWxlDQo+ID4+Pg0KPiA+Pj4gICAgY29uZmlndXJlICAgICAg
ICAgfCAgIDkgKw0KPiA+Pj4gICAgZG9jcy9hd2QudHh0ICAgICAgfCAgODggKysrKysrKysrDQo+
ID4+PiAgICBuZXQvTWFrZWZpbGUub2JqcyB8ICAgMSArDQo+ID4+PiAgICBuZXQvYXdkLmMgICAg
ICAgICB8IDQ5MQ0KPiA+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ID4+PiAgICBxZW11LW9wdGlvbnMuaHggICB8ICAyMCArKw0KPiA+Pj4gICAgdmwu
YyAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+Pj4gICAgNiBmaWxlcyBjaGFuZ2VkLCA2MTYgaW5z
ZXJ0aW9ucygrKQ0KPiA+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3MvYXdkLnR4dA0KPiA+
Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IG5ldC9hd2QuYw0KPiA+Pj4NCg0K


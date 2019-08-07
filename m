Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3932C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC1621E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC1621E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOkq-0003KF-Qe
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hvOjy-0002MG-8K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hvOjx-0006JE-1R
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:24:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:25299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1hvOjw-0006F2-Ot
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:24:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 09:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; d="scan'208";a="374463221"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2019 09:24:37 -0700
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 09:24:37 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.99]) with mapi id 14.03.0439.000;
 Wed, 7 Aug 2019 09:24:36 -0700
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>
Thread-Topic: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
Thread-Index: AQHVTSw+I7kmgADAmUOtvYF7P6PObabwT+2AgAAETwA=
Date: Wed, 7 Aug 2019 16:24:36 +0000
Message-ID: <e99d520edca6deca1ff6b838fd43f1bde00761ee.camel@intel.com>
References: <8df105774471bc72bca1397b4058ecc66d963848.camel@intel.com>
 <20190807160917.GI2867@work-vm>
In-Reply-To: <20190807160917.GI2867@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.199.52]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEB46965F1C5DE428F956B75D873A672@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] libvhost-user: Fix the
 VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDE3OjA5ICswMTAwLCBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0
IHdyb3RlOg0KPiAqIEJvZXVmLCBTZWJhc3RpZW4gKHNlYmFzdGllbi5ib2V1ZkBpbnRlbC5jb20p
IHdyb3RlOg0KPiA+IEZyb20gMGE1M2E4MWRiNmRkMDY5ZjliN2JjZGNkMzg2ODQ1YmNlYjNhMmFj
NiBNb24gU2VwIDE3IDAwOjAwOjAwDQo+ID4gMjAwMQ0KPiA+IEZyb206IFNlYmFzdGllbiBCb2V1
ZiA8c2ViYXN0aWVuLmJvZXVmQGludGVsLmNvbT4NCj4gPiBEYXRlOiBXZWQsIDcgQXVnIDIwMTkg
MDc6MTU6MzIgLTA3MDANCj4gPiBTdWJqZWN0OiBbUEFUQ0hdIGxpYnZob3N0LXVzZXI6IEZpeCB0
aGUNCj4gPiBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfU0xBVkVfU0VORF9GRA0KPiA+ICBjaGVjaw0K
PiA+IA0KPiA+IFZob3N0IHVzZXIgcHJvdG9jb2wgZmVhdHVyZXMgYXJlIHNldCBhcyBhIGJpdG1h
c2suIEFuZCB0aGUNCj4gPiBmb2xsb3dpbmcNCj4gPiBjb25zdGFudCBWSE9TVF9VU0VSX1BST1RP
Q09MX0ZfU0xBVkVfU0VORF9GRCB2YWx1ZSBpcyAxMCBiZWNhdXNlDQo+ID4gdGhlDQo+ID4gYml0
DQo+ID4gMTAgaW5kaWNhdGVzIGlmIHRoZSBmZWF0dXJlcyBpcyBzZXQgb3Igbm90Lg0KPiA+IA0K
PiA+IFRoZSBwcm9wZXIgd2F5IHRvIGNoZWNrIGZvciB0aGUgcHJlc2VuY2Ugb3IgYWJzZW5jZSBv
ZiB0aGlzIGZlYXR1cmUNCj4gPiBpcw0KPiA+IHRvIHNoaWZ0IDEgYnkgdGhlIHZhbHVlIG9mIHRo
aXMgY29uc3RhbnQgYW5kIHRoZW4gbWFzayBpdCB3aXRoIHRoZQ0KPiA+IGFjdHVhbCBiaXRtYXNr
IHJlcHJlc2VudGluZyB0aGUgc3VwcG9ydGVkIHByb3RvY29sIGZlYXR1cmVzLg0KPiA+IA0KPiA+
IFRoaXMgcGF0Y2ggYWltcyB0byBmaXggdGhlIGN1cnJlbnQgY29kZSBhcyBpdCB3YXMgbm90IGRv
aW5nIHRoZQ0KPiA+IHNoaWZ0aW5nLCBidXQgaW5zdGVhZCBpdCB3YXMgbWFza2luZyBkaXJlY3Rs
eSB3aXRoIHRoZSB2YWx1ZSBvZiB0aGUNCj4gPiBjb25zdGFudCBpdHNlbGYuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogU2ViYXN0aWVuIEJvZXVmIDxzZWJhc3RpZW4uYm9ldWZAaW50ZWwuY29t
Pg0KPiANCj4gTmljZWx5IHNwb3R0ZWQuDQo+IA0KPiBUd28gdGhpbmdzOw0KPiAgIGEpIEkgdGhp
bmsgeW91ciBtYWlsIGNsaWVudCBoYXMgd3JhcHBlZCB0aGUgbGluZXMgYXQgc29tZSBwb2ludC4N
Cj4gICBiKSBJIHRoaW5rIHRoaXMgaXMgd2h5IHRoZSBoYXNfZmVhdHVyZSgpIGZ1bmN0aW9uZSBl
eGlzdHMsIHNvIGRvZXMNCj4gICAgICB0aGF0IGJlY29tZQ0KPiANCj4gICAgICAgaWYgKCFoYXNf
ZmVhdHVyZShkZXYtPnByb3RvY29sX2ZlYXR1cmVzLA0KPiBWSE9TVF9VU0VSX1BST1RPQ09MX0Zf
U0xBVkVfU0VORF9GRCkpDQoNCkFoIHllcyBidXQgdGhhdCdzIGJlY2F1c2UgSSBmb3Jnb3QgdG8g
Y2hlY2sgdGhlIHBhdGNoIGZvcm1hdCBmaXJzdCA6KA0KDQpJJ20gZ29pbmcgdG8gdXBkYXRlIHRo
ZSBwYXRjaC4NCg0KVGhhbmtzLA0KU2ViYXN0aWVuDQo+IA0KPiBEYXZlDQo+IA0KPiA+IC0tLQ0K
PiA+ICBjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5jIHwgNCArKy0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMNCj4g
PiBiL2NvbnRyaWIvbGlidmhvc3QtDQo+ID4gdXNlci9saWJ2aG9zdC11c2VyLmMNCj4gPiBpbmRl
eCBmYjYxMTQyYmNjLi4xMTkwOWZiN2MxIDEwMDY0NA0KPiA+IC0tLSBhL2NvbnRyaWIvbGlidmhv
c3QtdXNlci9saWJ2aG9zdC11c2VyLmMNCj4gPiArKysgYi9jb250cmliL2xpYnZob3N0LXVzZXIv
bGlidmhvc3QtdXNlci5jDQo+ID4gQEAgLTExMTIsNyArMTExMiw3IEBAIGJvb2wgdnVfc2V0X3F1
ZXVlX2hvc3Rfbm90aWZpZXIoVnVEZXYgKmRldiwNCj4gPiBWdVZpcnRxICp2cSwgaW50IGZkLA0K
PiA+ICANCj4gPiAgICAgIHZtc2cuZmRfbnVtID0gZmRfbnVtOw0KPiA+ICANCj4gPiAtICAgIGlm
ICgoZGV2LT5wcm90b2NvbF9mZWF0dXJlcyAmDQo+ID4gVkhPU1RfVVNFUl9QUk9UT0NPTF9GX1NM
QVZFX1NFTkRfRkQpDQo+ID4gPT0gMCkgew0KPiA+ICsgICAgaWYgKChkZXYtPnByb3RvY29sX2Zl
YXR1cmVzICYgKDFVTEwgPDwNCj4gPiBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfU0xBVkVfU0VORF9G
RCkpID09IDApIHsNCj4gPiAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gICAgICB9DQo+ID4g
IA0KPiA+IEBAIC0yNTM3LDcgKzI1MzcsNyBAQCBpbnQ2NF90IHZ1X2ZzX2NhY2hlX3JlcXVlc3Qo
VnVEZXYgKmRldiwNCj4gPiBWaG9zdFVzZXJTbGF2ZVJlcXVlc3QgcmVxLCBpbnQgZmQsDQo+ID4g
IA0KPiA+ICAgICAgdm1zZy5mZF9udW0gPSBmZF9udW07DQo+ID4gIA0KPiA+IC0gICAgaWYgKChk
ZXYtPnByb3RvY29sX2ZlYXR1cmVzICYNCj4gPiBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfU0xBVkVf
U0VORF9GRCkNCj4gPiA9PSAwKSB7DQo+ID4gKyAgICBpZiAoKGRldi0+cHJvdG9jb2xfZmVhdHVy
ZXMgJiAoMVVMTCA8PA0KPiA+IFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9TTEFWRV9TRU5EX0ZEKSkg
PT0gMCkgew0KPiA+ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAgICAgfQ0KPiA+ICAN
Cj4gPiAtLSANCj4gPiAyLjE3LjENCj4gDQo+IC0tDQo+IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQg
LyBkZ2lsYmVydEByZWRoYXQuY29tIC8gTWFuY2hlc3RlciwgVUsNCg==


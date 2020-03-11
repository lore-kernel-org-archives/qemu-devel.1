Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A06C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D7620727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D7620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2Dd-0002Vi-QH
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sebastien.boeuf@intel.com>) id 1jC2Ck-00017z-Nt
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1jC2Ci-00080w-R9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:19:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:38335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1jC2Ci-0007qF-Ib
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:19:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 07:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="246045011"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by orsmga006.jf.intel.com with ESMTP; 11 Mar 2020 07:19:04 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 07:19:04 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.95]) with mapi id 14.03.0439.000;
 Wed, 11 Mar 2020 07:19:03 -0700
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "stefanha@gmail.com" <stefanha@gmail.com>, "marcandre.lureau@gmail.com"
 <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v2] docs: Update vhost-user spec regarding backend
 program conventions
Thread-Topic: [PATCH v2] docs: Update vhost-user spec regarding backend
 program conventions
Thread-Index: AQHV6z/IgEzOru4fF0CdsJzQLT3Sr6g8FuGAgAAE0ACAB+MuAA==
Date: Wed, 11 Mar 2020 14:19:03 +0000
Message-ID: <717f4005879504627a0bff4dd55ec0e166dfeb88.camel@intel.com>
References: <20200224182454.24610-1-sebastien.boeuf@intel.com>
 <20200306123453.GI1335569@stefanha-x1.localdomain>
 <CAJ+F1CJpMzra8VSYWKgtwZJkxvEX_HTqT=Sr9yvmX=NMH=9MSg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJpMzra8VSYWKgtwZJkxvEX_HTqT=Sr9yvmX=NMH=9MSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.29.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B129DFB7E4A82E49AD9455D7D62A4387@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCk9uIEZyaSwgMjAyMC0wMy0wNiBhdCAxMzo1MiArMDEwMCwgTWFyYy1BbmRyw6kgTHVy
ZWF1IHdyb3RlOg0KPiBIaQ0KPiANCj4gT24gRnJpLCBNYXIgNiwgMjAyMCBhdCAxOjM1IFBNIFN0
ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPiBPbiBNb24s
IEZlYiAyNCwgMjAyMCBhdCAwNzoyNDo1NFBNICswMTAwLCBTZWJhc3RpZW4gQm9ldWYgd3JvdGU6
DQo+ID4gPiBUaGUgdmhvc3QtdXNlciBzcGVjaWZpY2F0aW9uIGlzIG5vdCBjbGVhcmx5IHN0YXRp
bmcgdGhlIGV4cGVjdGVkDQo+ID4gPiBiZWhhdmlvciBmcm9tIGEgYmFja2VuZCBwcm9ncmFtIHdo
ZW5ldmVyIHRoZSBjbGllbnQgZGlzY29ubmVjdHMuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2gg
YWRkcmVzc2VzIHRoZSBpc3N1ZSBieSBkZWZpbmluZyB0aGUgZGVmYXVsdCBiZWhhdmlvcg0KPiA+
ID4gYW5kDQo+ID4gPiBwcm9wb3NpbmcgYW4gYWx0ZXJuYXRpdmUgdGhyb3VnaCBhIGNvbW1hbmQg
bGluZSBvcHRpb24uDQo+ID4gPiANCj4gPiA+IEJ5IGRlZmF1bHQsIGEgYmFja2VuZCBwcm9ncmFt
IHdpbGwgdGVybWluYXRlIHdoZW5ldmVyIHRoZSBjbGllbnQNCj4gPiA+IGRpc2Nvbm5lY3RzLCB1
bmxlc3MgdG9sZCBvdGhlcndpc2UgdGhyb3VnaCB0aGUgbmV3bHkgaW50cm9kdWNlZA0KPiA+ID4g
b3B0aW9uIC0ta2VlcC1saXN0ZW5pbmcuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNl
YmFzdGllbiBCb2V1ZiA8c2ViYXN0aWVuLmJvZXVmQGludGVsLmNvbT4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGRvY3MvaW50ZXJvcC92aG9zdC11c2VyLnJzdCB8IDEyICsrKysrKysrKysrKw0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gUGVyaGFwcyAt
LWtlZXAtbGlzdGVuaW5nIHNob3VsZCBiZSBvcHRpb25hbD8NCj4gDQo+IEkgdGhpbmsgaXQgc2hv
dWxkIGJlIG9wdGlvbmFsLCBhbmQgZmxhZ2dlZCBieSBhIGNhcGFiaWxpdHkuDQoNCkNvdWxkIHlv
dSBwbGVhc2UgZWxhYm9yYXRlIG9uIHRoYXQ/IEhvdyBjYW4gSSBkbyB0aGF0Pw0KDQpUaGFua3Ms
DQpTZWJhc3RpZW4NCj4gDQo+ID4gSWYgdGhlIG1haW50YWluZXJzIGFyZSBoYXBweSB3aXRoIHRo
ZSBwYXRjaCBhcyBpcyB0aGVuIHNvIGFtIEk6DQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFN0ZWZh
biBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gDQo+IA0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCklu
dGVsIENvcnBvcmF0aW9uIFNBUyAoRnJlbmNoIHNpbXBsaWZpZWQgam9pbnQgc3RvY2sgY29tcGFu
eSkKUmVnaXN0ZXJlZCBoZWFkcXVhcnRlcnM6ICJMZXMgTW9udGFsZXRzIi0gMiwgcnVlIGRlIFBh
cmlzLCAKOTIxOTYgTWV1ZG9uIENlZGV4LCBGcmFuY2UKUmVnaXN0cmF0aW9uIE51bWJlcjogIDMw
MiA0NTYgMTk5IFIuQy5TLiBOQU5URVJSRQpDYXBpdGFsOiA0LDU3MiwwMDAgRXVyb3MKClRoaXMg
ZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIG1hdGVy
aWFsIGZvcgp0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gQW55IHJl
dmlldyBvciBkaXN0cmlidXRpb24KYnkgb3RoZXJzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZApyZWNpcGllbnQsIHBsZWFzZSBjb250YWN0IHRoZSBz
ZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzLgo=



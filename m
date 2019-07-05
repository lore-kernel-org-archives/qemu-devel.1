Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D413C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4A020989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4A020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjTp6-0006HK-Av
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hjTo9-0005hy-Si
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hjTo7-0000O3-Hl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:23:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:14928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hjTo1-0008HE-Tz
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:23:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jul 2019 12:23:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,456,1557212400"; d="scan'208";a="339895621"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga005.jf.intel.com with ESMTP; 05 Jul 2019 12:23:13 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.14]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.17]) with mapi id 14.03.0439.000;
 Fri, 5 Jul 2019 12:23:13 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "no-reply@patchew.org" <no-reply@patchew.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "philmd@redhat.com" <philmd@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
 disabled
Thread-Index: AQHVMbb+drGPa6kziEinFlTruSZuLqa5iKYAgAAFaICAAEsSAIABXnUAgAGGNwCAAAFQAIAAIPmA
Date: Fri, 5 Jul 2019 19:23:12 +0000
Message-ID: <571afa76f4a06d2e75559dc749ebdf81691e2a87.camel@intel.com>
References: <156234722758.4200.12901651265660617488@c4a48874b076>
 <f07efb8a-0010-09f4-2d25-a803a3dc9161@redhat.com>
In-Reply-To: <f07efb8a-0010-09f4-2d25-a803a3dc9161@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.218.170.154]
Content-Type: text/plain; charset="utf-8"
Content-ID: <76CA61F57575A046AADD0A6CCCDE582C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix linker error when ISAPC is
 disabled
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA3LTA1IGF0IDE5OjI1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gT24gNy81LzE5IDc6MjAgUE0sIG5vLXJlcGx5QHBhdGNoZXcub3JnIHdyb3Rl
Og0KPiA+IFBhdGNoZXcgVVJMOiANCj4gPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA3
MDQxODAzNTAuMjA4Ni0xLWp1bGlvLm1vbnRlc0BpbnRlbC5jb20vDQo+ID4gDQo+ID4gSGksDQo+
ID4gDQo+ID4gVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxl
YXNlIGZpbmQgdGhlDQo+ID4gZGV0YWlscyBiZWxvdy4NCj4gPiANCj4gPiBUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0DQo+ID4gaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA3MDQxODAz
NTAuMjA4Ni0xLWp1bGlvLm1vbnRlc0BpbnRlbC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNz
YWdlLg0KPiA+IC0tLQ0KPiANCj4gbWFrZVsxXTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQg
J2NvbmZpZy1kZXZpY2VzLm1haycsIG5lZWRlZCBieQ0KPiAnY29uZmlnLWRldmljZXMuaC10aW1l
c3RhbXAnLiAgU3RvcC4NCj4gbWFrZTogKioqIFtNYWtlZmlsZTo0NzI6IGFhcmNoNjRfYmUtbGlu
dXgtdXNlci9hbGxdIEVycm9yIDINCj4gbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4NCj4gDQo+IEkgZ3Vlc3MgbGludXgtdXNlciAoYW5kIGJzZC11c2VyKSBkb2Vzbid0
IG5lZWQgdGhhdCBoZWFkZXIuLi4NCg0KR29vZCBjYXRjaCEgc2VuZGluZyB2MyByaWdodCBhd2F5
LCB0aGFua3MNCg0K


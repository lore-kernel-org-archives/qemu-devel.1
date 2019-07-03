Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A831C06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9882187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 13:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9882187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hifFQ-0005xp-5U
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 09:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hifEw-0005Y2-TM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hifEv-0001nd-NV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:24:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:63174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hifEv-0001fo-Da
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 09:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Jul 2019 06:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; d="scan'208";a="154755776"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 03 Jul 2019 06:23:57 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jul 2019 06:23:57 -0700
Received: from fmsmsx107.amr.corp.intel.com ([169.254.6.38]) by
 FMSMSX102.amr.corp.intel.com ([169.254.10.2]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 06:23:56 -0700
From: "Montes, Julio" <julio.montes@intel.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] monitor: vnc: Fix compilation error if
 CONFIG_VNC is disable
Thread-Index: AQHVMQiTsWE4EcllGki+M/Ivqq5iyaa5BAuAgABUWwA=
Date: Wed, 3 Jul 2019 13:23:56 +0000
Message-ID: <999558d036462e63c7ee389b1a883c21b8b6376b.camel@intel.com>
References: <20190702190131.5780-1-julio.montes@intel.com>
 <20190703082159.ewnjivevv2wzmdxm@steredhat>
In-Reply-To: <20190703082159.ewnjivevv2wzmdxm@steredhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.102.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A28395CCC15130459A4A58FAA5DCBCDD@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [PATCH] monitor: vnc: Fix compilation error if
 CONFIG_VNC is disable
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
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gV2VkLCAyMDE5LTA3LTAzIGF0IDEwOjIxICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6DQo+IE9uIFR1ZSwgSnVsIDAyLCAyMDE5IGF0IDA3OjAxOjMxUE0gKzAwMDAsIEp1bGlvIE1v
bnRlcyB3cm90ZToNCj4gPiBIb3cgdG8gcmVwcm9kdWNlIGl0Pw0KPiA+ID09PQ0KPiA+IA0KPiA+
IGBgYA0KPiA+ICQgLi9jb25maWd1cmUgLS1kaXNhYmxlLXNwaWNlIC0tZGlzYWJsZS12dGUgLS1k
aXNhYmxlLXZuYyBcDQo+ID4gICAgIC0tZGlzYWJsZS12bmMtanBlZyAtLWRpc2FibGUtdm5jLXBu
ZyAtLWRpc2FibGUtdm5jLXNhc2wNCj4gPiAkIG1ha2UNCj4gPiAuLi4NCj4gPiBtb25pdG9yL2ht
cC1jbWRzLmM6IEluIGZ1bmN0aW9uIOKAmGhtcF9jaGFuZ2XigJk6DQo+ID4gbW9uaXRvci9obXAt
Y21kcy5jOjE5ODU6MTc6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUg4oCYaG1wX21vbuKAmQ0KPiA+
ICAgICAgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQ0KPiA+ICAgICAgTW9uaXRvckhNUCAqaG1w
X21vbiA9IGNvbnRhaW5lcl9vZihtb24sIE1vbml0b3JITVAsIGNvbW1vbik7DQo+ID4gYGBgDQo+
ID4gDQo+ID4gRml4DQo+ID4gPT09DQo+ID4gDQo+ID4gTW92ZSBgaG1wX21vbmAgdmFyaWFibGUg
d2l0aGluIHRoZSBgQ09ORklHX1ZOQ2AgYmxvY2sNCj4gPiANCj4gDQo+IEhpIEp1bGlvLA0KPiB0
aGFua3MgZm9yIHRoZSBwYXRjaCwgYnV0IENocmlzdG9waGUgc2VudCBhIHZlcnkgc2ltaWxhciBw
YXRjaCBsYXN0DQo+IHdlZWs6IA0KPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAxOTA2MjUx
MjM5MDUuMjU0MzQtMS1kaW5lY2hpbkByZWRoYXQuY29tLw0KDQpUaGFua3MgU3RlZmFubywgcGxl
YXNlIGlnbm9yZSB0aGlzIHBhdGNoIDopDQoNCj4gDQo+IENoZWVycywNCj4gU3RlZmFubw0K


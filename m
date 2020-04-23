Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD8C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66E820781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66E820781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXit-00083w-2x
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRXhv-0007dE-RS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRXhu-0000LL-5n
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:59:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:25504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRXht-0000L4-JY
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 04:59:41 -0400
IronPort-SDR: hHr3Jwf0P416o9Z++sDxXFHUbrwH1kbWYISFk9XsH50P1aiWoruW9etDm4OopN9BUizfmbOQic
 UM1cniBlX3vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 01:59:33 -0700
IronPort-SDR: 0aw7RZOjHmY9Hv3hR8Iw+/fEjlom4gFjqLqTMPhnZru0bjZUFY9ht9EY6KY4rkyzzSNxIZzVhR
 bLbhhy5muoAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; d="scan'208";a="430250149"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga005.jf.intel.com with ESMTP; 23 Apr 2020 01:59:32 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 23 Apr 2020 01:59:13 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Apr 2020 16:59:11 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 23 Apr 2020 16:59:11 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Topic: [PATCH 0/2] net/colo-compare.c: Expose "max_queue_size" to users
 and clean up
Thread-Index: AQHWD7P+xm/8Bq9SCE2KY4WVvkZ5vqiCyuwQgAMpKICAAIZ5EA==
Date: Thu, 23 Apr 2020 08:59:11 +0000
Message-ID: <310162af410e43ea9e0d0a22012e1929@intel.com>
References: <20200411033824.19389-1-chen.zhang@intel.com>
 <716ca2bcd9e64c37a79509c468e18485@intel.com>
 <18466058-4184-2c6e-d740-2a1479395506@redhat.com>
In-Reply-To: <18466058-4184-2c6e-d740-2a1479395506@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.120; envelope-from=chen.zhang@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 04:59:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.120
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
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDQ6NTQg
UE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IHFlbXUtZGV2IDxx
ZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPg0KPiBDYzogWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdt
YWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIG5ldC9jb2xvLWNvbXBhcmUuYzog
RXhwb3NlICJtYXhfcXVldWVfc2l6ZSIgdG8NCj4gdXNlcnMgYW5kIGNsZWFuIHVwDQo+IA0KPiAN
Cj4gT24gMjAyMC80LzIzIOS4i+WNiDM6MzEsIFpoYW5nLCBDaGVuIHdyb3RlOg0KPiA+IEhpIEph
c29uLA0KPiA+DQo+ID4gUGxlYXNlIHJldmlldyB0aGlzIHNlcmllcyB3aGVuIHlvdSBmcmVlLg0K
PiA+DQo+ID4gVGhhbmtzDQo+ID4gWmhhbmcgQ2hlbg0KPiA+DQo+IA0KPiBTdXJlLg0KPiANCj4g
SSB3b25kZXIgbWF5YmUgaXQncyBiZXR0ZXIgZS5nIHlvdSBjYW4gcmV2aWV3IGFuZCBjb2xsZWN0
IHRoZSBwYXRjaGVzIHRoYXQNCj4gbG9va3MgZ29vZCBhbmQgc2VuZCB0aGVtIHRvIG1lIHBlcmlv
ZGljYWxseT8NCg0KT0ssIEkgd2lsbCBxdWV1ZSBDT0xPIHJlbGF0ZWQgcGF0Y2ggYXMgb25lIHNl
cmllcyB0byB5b3UuDQpEbyBJIG5lZWQgc2VuZCBhIHB1bGwgcmVxdWVzdD8gb3IganVzdCBhIGJp
ZyBwYXRjaCBzZXQ/DQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQo+IA0KPiBUaGFua3MNCg0K


Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F123422243
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F123422243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSyB3-0004J6-R3
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 03:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSy9T-0002oh-PK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:58:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:35193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSy9R-0002Iq-Qj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 03:58:19 -0400
IronPort-SDR: D+AS6VSy71REOInQD6NJ3pGmHdXJ4zBlKvmde0Z+Hsc0QbZTEyLaRnD38fNBR6CsPLmsmxij3E
 2FokWxtGAdnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162827543"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; d="scan'208";a="162827543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 00:58:15 -0700
IronPort-SDR: G7DjIM2QngxKrbI3iu4Uc/CsmvpUesRZMME3P2v7HZnAv3rKASLbpR1DOVQl9L7fS9nn9Gyd2l
 jFUaI30P4/HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; d="scan'208";a="520691442"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2020 00:58:15 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 00:58:14 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 15 Oct 2020 15:58:12 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 15 Oct 2020 15:58:12 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Subject: RE: [PATCH 00/10] COLO project queued patches 20-Oct
Thread-Topic: [PATCH 00/10] COLO project queued patches 20-Oct
Thread-Index: AQHWofuZjvvdY5FZRE6KB5kr3NlE86mXxw4AgACGqZA=
Date: Thu, 15 Oct 2020 07:58:12 +0000
Message-ID: <f71889f9bb054cdd8c294028878c739c@intel.com>
References: <20201014072555.12515-1-chen.zhang@intel.com>
 <7638dbe1-9095-28e2-0b5f-2eeaa5e3f98e@redhat.com>
In-Reply-To: <7638dbe1-9095-28e2-0b5f-2eeaa5e3f98e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.93; envelope-from=chen.zhang@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 03:58:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTUsIDIwMjAgMzo1
NiBQTQ0KPiBUbzogWmhhbmcsIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPjsgcWVtdS1kZXYg
PHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBaaGFuZyBDaGVuIDx6aGFuZ2NraWRA
Z21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEwXSBDT0xPIHByb2plY3QgcXVl
dWVkIHBhdGNoZXMgMjAtT2N0DQo+IA0KPiANCj4gT24gMjAyMC8xMC8xNCDkuIvljYgzOjI1LCBa
aGFuZyBDaGVuIHdyb3RlOg0KPiA+IEZyb206IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwu
Y29tPg0KPiA+DQo+ID4gSGkgSmFzb24sIHRoaXMgc2VyaWVzIGluY2x1ZGUgbGF0ZXN0IENPTE8g
cmVsYXRlZCBwYXRjaGVzLg0KPiA+IHBsZWFzZSBjaGVjayBhbmQgbWVyZ2UgaXQuDQo+ID4NCj4g
PiBUaGFua3MNCj4gPiBaaGFuZyBDaGVuDQo+IA0KPiANCj4gSGk6DQo+IA0KPiBJIHdhbnQgdG8g
bWVyZ2UgYnV0IEkgZG9uJ3QgZ2V0IHBhdGNoIDEwLzEwLg0KPiANCj4gSXMgdGhhdCBsb3N0IGR1
cmluZyBwb3N0aW5nPw0KDQpPaCwgU29ycnkgSSBtaXNzZWQgaXQuDQpBbHJlYWR5IHJlc2VuZCBp
dDoNCltQQVRDSCAxMC8xMF0gbmV0L2NvbG8tY29tcGFyZS5jOiBJbmNyZWFzZSBkZWZhdWx0IHF1
ZXVlZCBwYWNrZXQgc2NhbiBmcmVxdWVuY3kNCg0KVGhhbmtzDQpDaGVuDQoNCj4gDQo+IFRoYW5r
cw0KPiANCj4gDQo+ID4NCj4gPiBMaSBaaGlqaWFuICgyKToNCj4gPiAgICBjb2xvLWNvbXBhcmU6
IGZpeCBtaXNzaW5nIGNvbXBhcmVfc2VxIGluaXRpYWxpemF0aW9uDQo+ID4gICAgY29sby1jb21w
YXJlOiBjaGVjayBtYXJrIGluIG11dHVhbCBleGNsdXNpb24NCj4gPg0KPiA+IFBhbiBOZW5neXVh
biAoMSk6DQo+ID4gICAgbmV0L2ZpbHRlci1yZXdyaXRlcjogZGVzdHJveSBnX2hhc2hfdGFibGUg
aW4gY29sb19yZXdyaXRlcl9jbGVhbnVwDQo+ID4NCj4gPiBSYW8sIExlaSAoMyk6DQo+ID4gICAg
T3B0aW1pemUgc2VxX3NvcnRlciBmdW5jdGlvbiBmb3IgY29sby1jb21wYXJlDQo+ID4gICAgUmVk
dWNlIHRoZSB0aW1lIG9mIGNoZWNrcG9pbnQgZm9yIENPTE8NCj4gPiAgICBGaXggdGhlIHFlbXUg
Y3Jhc2ggd2hlbiBndWVzdCBzaHV0ZG93biBpbiBDT0xPIG1vZGUNCj4gPg0KPiA+IFpoYW5nIENo
ZW4gKDQpOg0KPiA+ICAgIG5ldC9jb2xvLWNvbXBhcmUuYzogRml4IGNvbXBhcmVfdGltZW91dCBm
b3JtYXQgaXNzdWUNCj4gPiAgICBuZXQvY29sby1jb21wYXJlLmM6IENoYW5nZSB0aGUgdGltZXIg
Y2xvY2sgdHlwZQ0KPiA+ICAgIG5ldC9jb2xvLWNvbXBhcmUuYzogQWRkIHNlY29uZGFyeSBvbGQg
cGFja2V0IGRldGVjdGlvbg0KPiA+ICAgIG5ldC9jb2xvLWNvbXBhcmUuYzogSW5jcmVhc2UgZGVm
YXVsdCBxdWV1ZWQgcGFja2V0IHNjYW4gZnJlcXVlbmN5DQo+ID4NCj4gPiAgIG1pZ3JhdGlvbi9y
YW0uYyAgICAgICB8IDE0ICsrKysrKysrKystDQo+ID4gICBuZXQvY29sby1jb21wYXJlLmMgICAg
fCA1NyArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICBu
ZXQvY29sby5jICAgICAgICAgICAgfCAgNSArLS0tDQo+ID4gICBuZXQvZmlsdGVyLXJld3JpdGVy
LmMgfCAgMiArKw0KPiA+ICAgc29mdG1tdS92bC5jICAgICAgICAgIHwgIDEgKw0KPiA+ICAgNSBm
aWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCj4gPg0KDQo=


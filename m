Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129F8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D808F20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D808F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jehAQ-0002QA-3t
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jeh9g-0001z4-Qk
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:42:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:40562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jeh9e-0008RN-HH
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:42:44 -0400
IronPort-SDR: XZXsfDUMqo4m2pGEZ7YJJm/c7MQStDs2RpIdUHGq54F/FwarTmzT+PYy9DB7GuVicxkFAA+Xqs
 Ncwc3EbYYl1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 08:42:30 -0700
IronPort-SDR: ZNL82atgL3VQ6wiAY+rTm3wbgTqMFj1TWfknCrRkJ4sbunLGzF5uBJy+8tRRXiG3QE41lIXu6h
 MI210x5fsi4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; d="scan'208";a="256115520"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 29 May 2020 08:42:30 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 29 May 2020 08:42:30 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 29 May 2020 23:42:28 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Fri, 29 May 2020 23:42:28 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Bug 1881231 <1881231@bugs.launchpad.net>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [Bug 1881231] Re: colo: Can not recover colo after svm failover
 twice
Thread-Topic: [Bug 1881231] Re: colo: Can not recover colo after svm failover
 twice
Thread-Index: AQHWNZ+McC8c46bGk0ydNIjDPx0bA6i/M5yA
Date: Fri, 29 May 2020 15:42:28 +0000
Message-ID: <7e259d3f57f94d909f78039ed4c4c460@intel.com>
References: <159072520391.13844.465385675639953986.malonedeb@soybean.canonical.com>
 <159074563281.5613.7928812716162105847.malone@wampee.canonical.com>
In-Reply-To: <159074563281.5613.7928812716162105847.malone@wampee.canonical.com>
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
Received-SPF: pass client-ip=192.55.52.93; envelope-from=chen.zhang@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 11:42:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "ye.zou@zstack.io" <ye.zou@zstack.io>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgWWUsDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0ZXN0IGFuZCByZXBvcnQsIEkgd2lsbCB0cnkg
dG8gZml4IHRoaXMgaXNzdWUuDQoNClRoYW5rcw0KWmhhbmcgQ2hlbg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWwtDQo+IGJvdW5j
ZXMrY2hlbi56aGFuZz1pbnRlbC5jb21Abm9uZ251Lm9yZz4gT24gQmVoYWxmIE9mIHllLnpvdQ0K
PiBTZW50OiBGcmlkYXksIE1heSAyOSwgMjAyMCA1OjQ3IFBNDQo+IFRvOiBxZW11LWRldmVsQG5v
bmdudS5vcmcNCj4gU3ViamVjdDogW0J1ZyAxODgxMjMxXSBSZTogY29sbzogQ2FuIG5vdCByZWNv
dmVyIGNvbG8gYWZ0ZXIgc3ZtIGZhaWxvdmVyIHR3aWNlDQo+IA0KPiBJbiBzdGVwIDMgSSB1c2Vk
IGZvbGxvd2luZyBjb21tYW5kczoNCj4gb24gcHJpbWFyeSB2bSBjb25zb2xlOg0KPiB7ImV4ZWN1
dGUiOiAiZHJpdmUtbWlycm9yIiwgImFyZ3VtZW50cyI6eyAiZGV2aWNlIjogImNvbG8tZGlzazAi
LCAiam9iLWlkIjoNCj4gInJlc3luYyIsICJ0YXJnZXQiOiAibmJkOi8vMTY5LjI1NC42Ni4xMDo5
OTk5L3BhcmVudDAiLCAibW9kZSI6DQo+ICJleGlzdGluZyIsImZvcm1hdCI6InJhdyIsInN5bmMi
OiJmdWxsIn0gfQ0KPiANCj4gLy8gdGlsbCB0aGUgam9iIHJlYWR5DQo+IHsgImV4ZWN1dGUiOiAi
cXVlcnktYmxvY2stam9icyIgfQ0KPiANCj4geyJleGVjdXRlIjogInN0b3AifQ0KPiB7ImV4ZWN1
dGUiOiAiYmxvY2stam9iLWNhbmNlbCIsICJhcmd1bWVudHMiOnsgImRldmljZSI6ICJyZXN5bmMi
fSB9DQo+IA0KPiB7J2V4ZWN1dGUnOiAnaHVtYW4tbW9uaXRvci1jb21tYW5kJywgJ2FyZ3VtZW50
cyc6IHsnY29tbWFuZC1saW5lJzoNCj4gJ2RyaXZlX2FkZCAtbiBidWRkeQ0KPiBkcml2ZXI9cmVw
bGljYXRpb24sbW9kZT1wcmltYXJ5LGZpbGUuZHJpdmVyPW5iZCxmaWxlLmhvc3Q9MTY5LjI1NC42
Ni4xMCxmaWxlLg0KPiBwb3J0PTk5OTksZmlsZS5leHBvcnQ9cGFyZW50MCxub2RlLW5hbWU9cmVw
bGljYXRpb24wJ319DQo+IHsnZXhlY3V0ZSc6ICd4LWJsb2NrZGV2LWNoYW5nZScsICdhcmd1bWVu
dHMnOnsncGFyZW50JzogJ2NvbG8tZGlzazAnLCAnbm9kZSc6DQo+ICdyZXBsaWNhdGlvbjAnIH0g
fQ0KPiB7J2V4ZWN1dGUnOiAnbWlncmF0ZS1zZXQtY2FwYWJpbGl0aWVzJywgJ2FyZ3VtZW50cyc6
IHsnY2FwYWJpbGl0aWVzJzogWyB7J2NhcGFiaWxpdHknOg0KPiAneC1jb2xvJywgJ3N0YXRlJzog
dHJ1ZSB9IF0gfSB9DQo+IHsnZXhlY3V0ZSc6ICdtaWdyYXRlJywgJ2FyZ3VtZW50cyc6IHsndXJp
JzogJ3RjcDoxNjkuMjU0LjY2LjEwOjk5OTgnIH0gfQ0KPiB7ICJleGVjdXRlIjogIm1pZ3JhdGUt
c2V0LXBhcmFtZXRlcnMiICwgImFyZ3VtZW50cyI6eyAieC1jaGVja3BvaW50LWRlbGF5IjoNCj4g
MTAwMDAgfSB9DQo+IA0KPiAtLQ0KPiBZb3UgcmVjZWl2ZWQgdGhpcyBidWcgbm90aWZpY2F0aW9u
IGJlY2F1c2UgeW91IGFyZSBhIG1lbWJlciBvZiBxZW11LQ0KPiBkZXZlbC1tbCwgd2hpY2ggaXMg
c3Vic2NyaWJlZCB0byBRRU1VLg0KPiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9idWdzLzE4
ODEyMzENCj4gDQo+IFRpdGxlOg0KPiAgIGNvbG86IENhbiBub3QgIHJlY292ZXIgY29sbyBhZnRl
ciBzdm0gZmFpbG92ZXIgdHdpY2UNCj4gDQo+IFN0YXR1cyBpbiBRRU1VOg0KPiAgIE5ldw0KPiAN
Cj4gQnVnIGRlc2NyaXB0aW9uOg0KPiAgIEhpIEV4cGVydCwNCj4gICB4LWJsb2NrZGV2LWNoYW5n
ZSBtZXQgc29tZSBlcnJvciwgZHVyaW5nIHRlc3RpbmcgY29sbw0KPiANCj4gICBIb3N0IG9zOg0K
PiAgIENlbnRPUyBMaW51eCByZWxlYXNlIDcuNi4xODEwIChDb3JlKQ0KPiANCj4gICBSZXByb2R1
Y2Ugc3RlcHM6DQo+ICAgMS4gY3JlYXRlIGNvbG8gdm0gZm9sbG93aW5nDQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS9xZW11L3FlbXUvYmxvYi9tYXN0ZXIvZG9jcy9DT0xPLUZULnR4dA0KPiAgIDIuIGtp
bGwgc2Vjb25kYXJ5IHZtIGFuZCByZW1vdmUgdGhlIG5iZCBjaGlsZCBmcm9tIHRoZSBxdW9ydW0g
dG8gd2FpdCBmb3INCj4gcmVjb3Zlcg0KPiAgICAgdHlwZSB0aG9zZSBjb21tYW5kcyBvbiBwcmlt
YXJ5IHZtIGNvbnNvbGU6DQo+ICAgICB7ICdleGVjdXRlJzogJ3gtYmxvY2tkZXYtY2hhbmdlJywg
J2FyZ3VtZW50cyc6IHsncGFyZW50JzogJ2NvbG8tZGlzazAnLCAnY2hpbGQnOg0KPiAnY2hpbGRy
ZW4uMSd9fQ0KPiAgICAgeyAnZXhlY3V0ZSc6ICdodW1hbi1tb25pdG9yLWNvbW1hbmQnLCdhcmd1
bWVudHMnOiB7J2NvbW1hbmQtbGluZSc6DQo+ICdkcml2ZV9kZWwgcmVwbGljYXRpb24wJ319DQo+
ICAgICB7ICdleGVjdXRlJzogJ3gtY29sby1sb3N0LWhlYXJ0YmVhdCd9DQo+ICAgMy4gcmVjb3Zl
ciBjb2xvDQo+ICAgNC4ga2lsbCBzZWNvbmRhcnkgdm0gYWdhaW4gYWZ0ZXIgcmVjb3ZlciBjb2xv
IGFuZCB0eXBlIHNhbWUgY29tbWFuZHMgYXMNCj4gc3RlcCAyOg0KPiAgICAgeyAnZXhlY3V0ZSc6
ICd4LWJsb2NrZGV2LWNoYW5nZScsICdhcmd1bWVudHMnOiB7J3BhcmVudCc6ICdjb2xvLWRpc2sw
JywgJ2NoaWxkJzoNCj4gJ2NoaWxkcmVuLjEnfX0NCj4gICAgIHsgJ2V4ZWN1dGUnOiAnaHVtYW4t
bW9uaXRvci1jb21tYW5kJywnYXJndW1lbnRzJzogeydjb21tYW5kLWxpbmUnOg0KPiAnZHJpdmVf
ZGVsIHJlcGxpY2F0aW9uMCd9fQ0KPiAgICAgeyAnZXhlY3V0ZSc6ICd4LWNvbG8tbG9zdC1oZWFy
dGJlYXQnfQ0KPiAgICAgYnV0IHRoZSBmaXJzdCBjb21tYW5kIGdvdCBlcnJvcg0KPiAgICAgeyAn
ZXhlY3V0ZSc6ICd4LWJsb2NrZGV2LWNoYW5nZScsICdhcmd1bWVudHMnOiB7J3BhcmVudCc6ICdj
b2xvLWRpc2swJywgJ2NoaWxkJzoNCj4gJ2NoaWxkcmVuLjEnfX0NCj4gICB7ImVycm9yIjogeyJj
bGFzcyI6ICJHZW5lcmljRXJyb3IiLCAiZGVzYyI6ICJOb2RlICdjb2xvLWRpc2swJyBkb2VzIG5v
dCBoYXZlDQo+IGNoaWxkICdjaGlsZHJlbi4xJyJ9fQ0KPiANCj4gICBhY2NvcmRpbmcgdG8gaHR0
cHM6Ly93d3cucWVtdS5vcmcvZG9jcy9tYXN0ZXIvcWVtdS1xbXAtcmVmLmh0bWwNCj4gICBDb21t
YW5kOiB4LWJsb2NrZGV2LWNoYW5nZQ0KPiAgIER5bmFtaWNhbGx5IHJlY29uZmlndXJlIHRoZSBi
bG9jayBkcml2ZXIgc3RhdGUgZ3JhcGguIEl0IGNhbiBiZSB1c2VkIHRvIGFkZCwNCj4gcmVtb3Zl
LCBpbnNlcnQgb3IgcmVwbGFjZSBhIGdyYXBoIG5vZGUuIEN1cnJlbnRseSBvbmx5IHRoZSBRdW9y
dW0gZHJpdmVyDQo+IGltcGxlbWVudHMgdGhpcyBmZWF0dXJlIHRvIGFkZCBvciByZW1vdmUgaXRz
IGNoaWxkLiBUaGlzIGlzIHVzZWZ1bCB0byBmaXggYQ0KPiBicm9rZW4gcXVvcnVtIGNoaWxkLg0K
PiANCj4gICBJdCBzZWVtcyB4LWJsb2NrZGV2LWNoYW5nZSBub3Qgd29ya2VkIGFzIGV4cGVjdGVk
Lg0KPiANCj4gICBUaGFua3MuDQo+IA0KPiBUbyBtYW5hZ2Ugbm90aWZpY2F0aW9ucyBhYm91dCB0
aGlzIGJ1ZyBnbyB0bzoNCj4gaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8rYnVnLzE4
ODEyMzEvK3N1YnNjcmlwdGlvbnMNCg0K


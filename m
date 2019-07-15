Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F457C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56A6220C01
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A6220C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmxl3-0005Ld-L8
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58403)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <LMa@suse.com>) id 1hmxkp-0004jU-07
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <LMa@suse.com>) id 1hmxkn-0002fj-HW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:58:42 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:59828)
 by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <LMa@suse.com>)
 id 1hmxkk-0002dE-AD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:58:39 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY
 m9a0002g.houston.softwaregrp.com WITH ESMTP; 
 Mon, 15 Jul 2019 09:58:36 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 15 Jul 2019 09:43:17 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 15 Jul 2019 09:43:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1CsncF3zInhtUhby+VxTh6kxGX5ADaH1uJ2mdF9r/3riu32RQRM6aAjtEzhZNV0Fcf7kBGyBKewwaXWQxqVeHyS4BD6y9uKKvQ2OsEpGRwhSZ+buT+xg2nflBLLUgjdoC7LXEEXMK8eYWjkTh7eqs2BU5QyQTWXd8KVQK1NHiqd0a39fnRQ9PfO5oGo6PsbknflgmFTrcudMcc1243opm8PILeJpYrQ+8ClLPbmLH/CACTP6bwyaCOVMeqj7HG1VLTRNmfHS1CdB+7MwAZGztZRwFyrroqcOPN3p9MRHL9WLd+OGXmLjI1y3So0IK7py7wyeocOHwQSlJW5sFyuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWWypgFc2PbBnVMp1r5VZgPw3N8owV9uVWO3uXj4Ju8=;
 b=cDrRv7pkvNtczn8JwQtc7EsvweklAjDPPLMJYXw8i3GE7Ja0Nv5by/+eL3l+4GbTfeiF1nYr039i/U2yYHW8dk3jW9MU14A/j9xPPduMPeTwCTNVsnRJXwrgoU5I7OgsJQBewWsWBOGSQ8DmE+Beg1mMzC//UioRIYdgkfwPS/S1KxnRxd4zOabGUgwcvvblPIjJRVHOOxjt9w0CvFkr2EfJA39KSpCeciqyxeWFi4gaaA/6yjdvwypEeUwmQJbThC2bT8npWJiLRRjYEvAKlvqwPCqBvyCv4s5zLi+9iuBtWJnLcX+vNrRD/XXxkbo9b0qjc36GpfMGdgW4wLBigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from BY5PR18MB3313.namprd18.prod.outlook.com (10.255.137.156) by
 BY5SPR01MB0002.namprd18.prod.outlook.com (52.133.255.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 09:43:16 +0000
Received: from BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::b588:8e99:5614:73ad]) by BY5PR18MB3313.namprd18.prod.outlook.com
 ([fe80::b588:8e99:5614:73ad%4]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 09:43:16 +0000
From: Lin Ma <LMa@suse.com>
To: " Dr. David Alan Gilbert " <dgilbert@redhat.com>
Thread-Topic: =?utf-8?B?562U5aSNOiBbUWVtdS1kZXZlbF0gbWlncmF0ZV9zZXRfc3BlZWQgaGFzIG5v?=
 =?utf-8?Q?_effect_if_the_guest_is_using_hugepages.?=
Thread-Index: AdU3zTKKe7aEJr5KQ9WS3a20E1+sggABau2GADHRVOAABQNSHgCQn6Sw
Date: Mon, 15 Jul 2019 09:43:16 +0000
Message-ID: <BY5PR18MB3313850D2845C27026891170C5CF0@BY5PR18MB3313.namprd18.prod.outlook.com>
References: <BY5PR18MB3313E1E22A22D236D4C2680DC5F30@BY5PR18MB3313.namprd18.prod.outlook.com>
 <20190711102410.GH3971@work-vm>
 <BY5PR18MB331347C441DA068E32BFDE53C5F20@BY5PR18MB3313.namprd18.prod.outlook.com>
 <20190712123400.GJ2730@work-vm>
In-Reply-To: <20190712123400.GJ2730@work-vm>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=LMa@suse.com; 
x-originating-ip: [45.122.156.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57a6118b-5945-4fe9-55e1-08d70908dd02
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BY5SPR01MB0002; 
x-ms-traffictypediagnostic: BY5SPR01MB0002:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5SPR01MB0002E81DC6BE79A117F25185C5CF0@BY5SPR01MB0002.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(53754006)(68736007)(476003)(6506007)(5660300002)(446003)(11346002)(81166006)(52536014)(71200400001)(74316002)(316002)(486006)(6116002)(8936002)(71190400001)(186003)(26005)(33656002)(224303003)(3846002)(7696005)(102836004)(81156014)(76176011)(25786009)(76116006)(6436002)(80792005)(53936002)(66476007)(64756008)(66446008)(66556008)(66946007)(14454004)(2906002)(966005)(9686003)(55016002)(6306002)(478600001)(4326008)(99286004)(6916009)(86362001)(66066001)(305945005)(256004)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BY5SPR01MB0002;
 H:BY5PR18MB3313.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qgp2AIBHyNDzxWJE+FflCA8D6RC90jL82HSDSf34/TLpBWE7bcUiO5spUpv9MlUUi8Cc6xG/eO7UuPzSV1y3DIR3BXGMJl51LbsKwpkfefQNBiZ7VxBqfPxaEk33b2cwhKu6UA91GU2fwKagJGHoBniKzUuBmxkyZv3QjBgllQkJKTiinKwRqwY1hfYp4lb2dfAKNPZtA65thccQa7kr32R+mugmxzTxsxh5etp6p1P9Tc6tEgs6Nt0Z0afSfMe5JD+/nn7vk70qnlig8jZou7YMsTvAr4lcMk9SU9xYJcrWuV7Kpc8/pOTLRXEZt7DrAKvspCjEpw/JYm/W1AQY1AHxVtuXJa1y3Fuw1iNnMzGs0c2juzRcpTi/qCxDkvfzxovMfYAcNfp3llfwGmi4wTkH6671HBdgxArdEgiCsP0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6118b-5945-4fe9-55e1-08d70908dd02
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 09:43:16.6991 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LMa@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5SPR01MB0002
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 15.124.64.67
Subject: [Qemu-devel] =?utf-8?b?5Zue5aSNOiDnrZTlpI06ICBtaWdyYXRlX3NldF9z?=
 =?utf-8?q?peed_has_no_effect_if_the_guest_is_using_hugepages=2E?=
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IERyLiBEYXZpZCBBbGFu
IEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+DQo+IOWPkemAgeaXtumXtDogMjAxOeW5tDfm
nIgxMuaXpSAyMDozNA0KPiDmlLbku7bkuro6IExpbiBNYSA8TE1hQHN1c2UuY29tPg0KPiDmioTp
gIE6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiDkuLvpopg6IFJlOiDnrZTlpI06IFtRZW11LWRl
dmVsXSBtaWdyYXRlX3NldF9zcGVlZCBoYXMgbm8gZWZmZWN0IGlmIHRoZSBndWVzdCBpcw0KPiB1
c2luZyBodWdlcGFnZXMuDQo+IA0KPiAqIExpbiBNYSAoTE1hQHN1c2UuY29tKSB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4gPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+ID4gPiDlj5Hku7bkuro6IERy
LiBEYXZpZCBBbGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+DQo+ID4gPiDlj5HpgIHm
l7bpl7Q6IDIwMTnlubQ35pyIMTHml6UgMTg6MjQNCj4gPiA+IOaUtuS7tuS6ujogTGluIE1hIDxM
TWFAc3VzZS5jb20+DQo+ID4gPiDmioTpgIE6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+ID4g
5Li76aKYOiBSZTogW1FlbXUtZGV2ZWxdIG1pZ3JhdGVfc2V0X3NwZWVkIGhhcyBubyBlZmZlY3Qg
aWYgdGhlIGd1ZXN0IGlzDQo+ID4gPiB1c2luZyBodWdlcGFnZXMuDQo+ID4gPg0KPiA+ID4gKiBM
aW4gTWEgKExNYUBzdXNlLmNvbSkgd3JvdGU6DQo+ID4gPiA+IEhpIGFsbCwNCj4gPiA+DQo+ID4g
PiBIaSBMaW4sDQo+ID4NCj4gPiBIaSBEYXZlLA0KPiA+ID4NCj4gPiA+ID4gV2hlbiBJIGxpdmUg
bWlncmF0ZSBhIHFlbXUva3ZtIGd1ZXN0LCBJZiB0aGUgZ3Vlc3QgaXMgdXNpbmcgaHVnZQ0KPiA+
ID4gPiBwYWdlcywgSSBmb3VuZCB0aGF0IHRoZSBtaWdyYXRlX3NldF9zcGVlZCBjb21tYW5kIGhh
ZCBubyBlZmZlY3QNCj4gPiA+ID4gZHVyaW5nDQo+ID4gPiBzdGFnZSAyLg0KPiA+ID4NCj4gPiA+
IENhbiB5b3UgZXhwbGFpbiB3aGF0IHlvdSBtZWFuIGJ5ICdzdGFnZSAyJz8NCj4gPiBXZSBrbm93
IHRoYXQgdGhlIGxpdmUgbWlncmF0aW9uIGNvbnRhaW5zIDMgc3RhZ2VzOg0KPiA+IFN0YWdlIDE6
IE1hcmsgYWxsIG9mIFJBTSBkaXJ0eS4NCj4gPiBTdGFnZSAyOiBLZWVwIHNlbmRpbmcgZGlydHkg
UkFNIHBhZ2VzIHNpbmNlIGxhc3QgaXRlcmF0aW9uIFN0YWdlIDM6DQo+ID4gU3RvcCBndWVzdCwg
dHJhbnNmZXIgcmVtYWluaW5nIGRpcnR5IFJBTSwgZGV2aWNlIHN0YXRlIChQbGVhc2UgcmVmZXIN
Cj4gPiB0bw0KPiA+IGh0dHBzOi8vZGV2ZWxvcGVycy5yZWRoYXQuY29tL2Jsb2cvMjAxNS8wMy8y
NC9saXZlLW1pZ3JhdGluZy1xZW11LWt2bS0NCj4gPiB2aXJ0dWFsLW1hY2hpbmVzLyNsaXZlLW1p
Z3JhdGlvbiBmb3IgZnVydGhlciBkZXRhaWxzKQ0KPiANCj4gT0ssIHllaCB0aGUgbnVtYmVyaW5n
IGlzIHByZXR0eSBhcmJpdHJhcnkgc28gaXQncyBub3Qgc29tZXRoaW5nIEkgbm9ybWFsbHkgdGhp
bmsNCj4gYWJvdXQgbGlrZSB0aGF0Lg0KPiANCj4gPg0KPiA+ID4gPiBJdCB3YXMgY2F1c2VkIGJ5
IGNvbW1pdCA0YzAxMWMzIHBvc3Rjb3B5OiBTZW5kIHdob2xlIGh1Z2UgcGFnZXMNCj4gPiA+ID4N
Cj4gPiA+ID4gSSdtIHdvbmRlcmluZyB0aGF0IGlzIGl0IGJ5IGRlc2lnbiBvciBpcyBpdCBhIGJ1
ZyB3YWl0aW5nIGZvciBmaXg/DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyB0aGUgZmlyc3QgcmVwb3J0
IEkndmUgc2VlbiBmb3IgaXQuICBIb3cgZGlkIHlvdSBjb25jbHVkZQ0KPiA+ID4gdGhhdA0KPiA+
ID4gNGMwMTFjMyBjYXVzZWQgaXQ/ICBXaGlsZSBJIGNhbiBzZWUgaXQgbWlnaHQgaGF2ZSBzb21l
IGVmZmVjdCBvbiB0aGUNCj4gPiA+IGJhbmR3aWR0aCBtYW5hZ2VtZW50LCBJJ20gc3VycHJpc2Vk
IGl0IGhhcyB0aGlzIG11Y2ggZWZmZWN0Lg0KPiA+DQo+ID4gV2hpbGUgZGlnZ2luZyBpbnRvIHRo
ZSBiYW5kd2lkdGggaXNzdWUsIEdpdCBiaXNlY3Qgc2hvd3MgdGhhdCB0aGlzIGNvbW1pdCB3YXMN
Cj4gdGhlIGZpcnN0IGJhZCBjb21taXQuDQo+IA0KPiBPSy4NCj4gDQo+ID4gPiBXaGF0IHNpemUg
aHVnZSBwYWdlcyBhcmUgeW91IHVzaW5nIC0gMk1CIG9yIDFHQj8NCj4gPg0KPiA+IFdoZW4gSSBo
aXQgdGhpcyBpc3N1ZSBJIHdhcyB1c2luZyAxR0IgaHVnZSBwYWdlIHNpemUuDQo+ID4gSSB0ZXN0
ZWQgdGhpcyBpc3N1ZSB3aXRoIDJNQiBwYWdlIHNpemUgdG9kYXkgT24gR2lnYWJpdCBMQU4sIEFs
dGhvdWdoDQo+ID4gdGhlIGJhbmR3aWR0aCBjb250cm9sIGxvb2tzIGEgbGl0dGxlIGJldHRlciB0
aGFuIHVzaW5nIDFHQiwgQnV0IG5vdCB0b28gbXVjaC4NCj4gUGxlYXNlIHJlZmVyIHRvIHRoZSBi
ZWxvdyB0ZXN0IHJlc3VsdC4NCj4gDQo+IE9LLCBJIGNhbiBjZXJ0YWlubHkgc2VlIHdoeSB0aGlz
IG1pZ2h0IGhhcHBlbiB3aXRoIDFHQiBodWdlIHBhZ2VzOyBJIG5lZWQgdG8NCj4gaGF2ZSBhIHRo
aW5rIGFib3V0IGEgZml4Lg0KPiANCj4gPiA+IEkgY2FuIGltYWdpbmUgd2UgbWlnaHQgaGF2ZSBh
IHByb2JsZW0gdGhhdCBzaW5jZSB3ZSBvbmx5IGRvIHRoZQ0KPiA+ID4gc2xlZXAgYmV0d2VlbiB0
aGUgaHVnZXBhZ2VzLCBpZiB3ZSB3ZXJlIHVzaW5nIDFHQiBodWdlcGFnZXMgdGhlbg0KPiA+ID4g
d2UnZCBzZWUgPGJpZyBjaHVuayBvZg0KPiA+ID4gZGF0YT5bc2xlZXBdPGJpZyBjaHVuayBvZiBk
YXRhPltzbGVlcF0gd2hpY2ggaXNuJ3QgYXMgc21vb3RoIGFzIGl0IHVzZWQgdG8NCj4gYmUuDQo+
ID4gPg0KPiA+ID4gQ2FuIHlvdSBnaXZlIG1lIHNvbWUgbW9yZSBkZXRhaWxzIG9mIHlvdXIgdGVz
dD8NCj4gPg0KPiA+IExpdmUgbWlncmF0aW9uIGJhbmR3aWR0aCBtYW5hZ2VtZW50IHRlc3Rpbmcg
d2l0aCAyTUIgaHVnZXBhZ2Ugc2l6ZToNCj4gPiBzbGVzMTJzcDRfaTQ0MGZ4IGlzIGEgcWVtdS9r
dm0gZ3Vlc3Qgd2l0aCA2R0IgbWVtb3J5IHNpemUuDQo+ID4gTm90ZTogdGhlIHRocm91Z2hwdXQg
dmFsdWUgaXMgYXBwcm94aW1hdGluZyB2YWx1ZS4NCj4gPg0KPiA+IFRlcm1pbmFsIDE6DQo+ID4g
dmlyc2ggbWlncmF0ZS1zZXRzcGVlZCBzbGVzMTJzcDRfaTQ0MGZ4ICRiYW5kd2lkdGggJiYgdmly
c2ggbWlncmF0ZQ0KPiA+IC0tbGl2ZSBzbGVzMTJzcDRfaTQ0MGZ4IHFlbXUrdGNwOi8vNTgxMGYv
c3lzdGVtDQo+ID4NCj4gPiBUZXJtaW5hbCAyOg0KPiA+IHZpcnNoIHFlbXUtbW9uaXRvci1jb21t
YW5kIHNsZXMxMnNwNF9pNDQwZnggLS1obXAgImluZm8gbWlncmF0ZSINCj4gPg0KPiA+IGJhbmR3
aWR0aD01DQo+ID4gdGhyb3VnaHB1dDogMTYwIG1icHMNCj4gPg0KPiA+IGJhbmR3aWR0aD0xMA0K
PiA+IHRocm91Z2hwdXQ6IDE2NyBtYnBzDQo+ID4NCj4gPiBiYW5kd2lkdGg9MTUNCj4gPiB0aHJv
dWdocHV0OiAxNjggbWJwcw0KPiA+DQo+ID4gYmFuZHdpZHRoPTIwDQo+ID4gdGhyb3VnaHB1dDog
MTY4IG1icHMNCj4gPg0KPiA+IGJhbmR3aWR0aD0yMQ0KPiA+IHRocm91Z2hwdXQ6IDMzNiBtYnBz
DQo+ID4NCj4gPiBiYW5kd2lkdGg9MjINCj4gPiB0aHJvdWdocHV0OiAzMzYgbWJwcw0KPiA+DQo+
ID4gYmFuZHdpZHRoPTI1DQo+ID4gdGhyb3VnaHB1dDogMzM1Ljg3IG1icHMNCj4gPg0KPiA+IGJh
bmR3aWR0aD0zMA0KPiA+IHRocm91Z2hwdXQ6IDMzNSBtYnBzDQo+ID4NCj4gPiBiYW5kd2lkdGg9
MzUNCj4gPiB0aHJvdWdocHV0OiAzMzUgbWJwcw0KPiA+DQo+ID4gYmFuZHdpZHRoPTQwDQo+ID4g
dGhyb3VnaHB1dDogMzM1IG1icHMNCj4gPg0KPiA+IGJhbmR3aWR0aD00NQ0KPiA+IHRocm91Z2hw
dXQ6IDUwNC4wMCBtYnBzDQo+ID4NCj4gPiBiYW5kd2lkdGg9NTANCj4gPiB0aHJvdWdocHV0OiA1
MDAuMDAgbWJwcw0KPiA+DQo+ID4gYmFuZHdpZHRoPTU1DQo+ID4gdGhyb3VnaHB1dDogNTAwLjAw
IG1icHMNCj4gPg0KPiA+IGJhbmR3aWR0aD02MA0KPiA+IHRocm91Z2hwdXQ6IDUwMC4wMCBtYnBz
DQo+ID4NCj4gPiBiYW5kd2lkdGg9NjUNCj4gPiB0aHJvdWdocHV0OiA2NTAuMDAgbWJwcw0KPiA+
DQo+ID4gYmFuZHdpZHRoPTcwDQo+ID4gdGhyb3VnaHB1dDogNjYwLjAwIG1icHMNCj4gDQo+IE9L
LCBzbyBtaWdyYXRlLXNldHNwZWVkIHRha2VzIGEgYmFuZHdpZHRoIGluIE1CeXRlcy9zZWMgYW5k
IEkgZ3Vlc3MgeW91J3JlDQo+IHRocm91Z2hwdXQgaXMgaW4gTUJpdC9zZWMgLSBzbyBhdCB0aGUg
aGlnaGVyIGVuZCBpdCdzIGFib3V0IHJpZ2h0LCBhbmQgYXQgdGhlIGxvd2VyDQo+IGVuZCBpdCdz
IHdheSBvZmYuDQo+IA0KPiBMZXQgbWUgdGhpbmsgYWJvdXQgYSBmaXggZm9yIHRoaXMuDQo+IA0K
PiBXaGF0IGFyZSB5b3UgdXNpbmcgdG8gbWVhc3VyZSB0aHJvdWdocHV0Pw0KDQpJIHVzZSAnd2F0
Y2gnIGNvbW1hbmQgdG8gb2JzZXJ2ZSB0aGUgb3V0cHV0IG9mIHFlbXUgaG1wIGNvbW1hbmQgJ2lu
Zm8gbWlncmF0ZScsIGNhbGN1bGF0ZSB0aGUNCmF2ZXJhZ2UgdmFsdWUgb2YgdGhyb3VnaHB1dCBm
aWVsZCBkdXJpbmcgc3RhZ2UgMiBvZiBsaXZlIG1pZ3JhdGlvbi4NCg0KVGhhbmtzIGZvciB0YWtp
bmcgdGltZSB0byBkaWcgaW50byB0aGlzIGlzc3VlLA0KTGluDQo=


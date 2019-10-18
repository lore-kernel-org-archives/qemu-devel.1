Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72537CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B61A21835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B61A21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVog-0004xv-Gc
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <BROGERS@suse.com>) id 1iLVl0-0001cP-2D
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <BROGERS@suse.com>) id 1iLVkz-00036B-2S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:09:41 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:56129)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <BROGERS@suse.com>)
 id 1iLVkw-00033w-7B; Fri, 18 Oct 2019 13:09:38 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0039g.houston.softwaregrp.com WITH ESMTP; 
 Fri, 18 Oct 2019 17:08:40 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 18 Oct 2019 16:51:46 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 18 Oct 2019 16:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq2QLqESvw5xI+mYMWXZst51kayurrSiJbxKeqsGp5t8IYKIVF0WBG0J31jMpsq5PVhzzbxk8X0LA6Nq6wzO7Hk91w9BB+ag3ki5ABDpsM5H/M4uGh9tCLGPKIi8Sydmhh22/pvwLXZQ08zQtt3tNP0TCS9EfZxh6r6gBMloIuXp10F2/V+hosZZhWBPDM4mIe2PzhWO4uD2cfOi3jmDl3+LykjvklpGhwtxeU3vtmeiStCNQa2f08R8nLrtgYND4KwV5S9cghbxsPbAzcyl6J7A6QX1FgJSxwCZ9qqkoSfIrEh8of7bx8Vxf23kz0Xvv+y5v3tt1au+O9DpwIG9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq1BEA3nJSyfbsPzGsRCavKWXcgYISKZDGvXRKWpEAI=;
 b=VCw/6jh2PeDvxbyZ0zLxfD5R2UaRCdIw4kbdi8CWckFqN4qMbJCC2t29RUH77HHV+lYDmGzD+wA4fNJXL5SDBYv2Qw574MAMGIH2L+hdw9wYzNdKq/c43WIsz4ZRhqaXdCJ9obuRlx2uqYvPErhvYhv/PzNc00XtO9mYTX+QfvB+xbm2JOmmoxvvMUbmV5GhXmbRK6QOakHxONXaG9RdYwUvqyqLf/EWESdpX4PxkV1IogkNszvEBOqUlsBKMT32xvCc7i5ta0HTJt1XmSYeOasxhP3eIK3bFW7VBOQMp3DgwlIHOHZFlekjojjztKmlMcU0GhemUsrMj0OQ1vvORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from CH2PR18MB3096.namprd18.prod.outlook.com (52.132.244.221) by
 CH2PR18MB3143.namprd18.prod.outlook.com (52.132.247.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Fri, 18 Oct 2019 16:51:44 +0000
Received: from CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::70b1:8a05:f843:7b20]) by CH2PR18MB3096.namprd18.prod.outlook.com
 ([fe80::70b1:8a05:f843:7b20%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 16:51:43 +0000
From: Bruce Rogers <BROGERS@suse.com>
To: "mreitz@redhat.com" <mreitz@redhat.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH] iotests: Remove 130 from the "auto" group
Thread-Topic: [PATCH] iotests: Remove 130 from the "auto" group
Thread-Index: AQHVhc7syOPvmfrS2ke0R3oyE2GXR6dgnQOA
Date: Fri, 18 Oct 2019 16:51:43 +0000
Message-ID: <a79d17cdbb61168d9d71defe0868784b656377f0.camel@suse.com>
References: <20191018161008.17140-1-thuth@redhat.com>
In-Reply-To: <20191018161008.17140-1-thuth@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BROGERS@suse.com; 
x-originating-ip: [137.65.185.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8073cea0-2f51-4440-0a80-08d753eb7487
x-ms-traffictypediagnostic: CH2PR18MB3143:
x-microsoft-antispam-prvs: <CH2PR18MB31431BC2021F640EA7B9B972D96C0@CH2PR18MB3143.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(99286004)(71190400001)(71200400001)(2201001)(316002)(102836004)(86362001)(2501003)(186003)(256004)(14444005)(26005)(36756003)(486006)(66066001)(229853002)(6116002)(3846002)(476003)(446003)(11346002)(2616005)(6506007)(54906003)(76176011)(14454004)(110136005)(6486002)(478600001)(6436002)(4001150100001)(66476007)(64756008)(66446008)(5660300002)(76116006)(66556008)(66946007)(6512007)(81156014)(2906002)(118296001)(6246003)(8676002)(8936002)(81166006)(7736002)(91956017)(305945005)(25786009)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CH2PR18MB3143;
 H:CH2PR18MB3096.namprd18.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVkqr6BdqXoGqUQ0MMlWEKP7/C6nQbvFIi/q8W84d5YxQ717hf1lHftcQu70laT5A+4GXz1cPOY39O46oP4y7iCco3gP5uI58/wF+CQjsd/X9TSl2OWRziNtbxLxRDTLCft0OCrQlNo4IBilUJHxdrS/7B89Yik5uF9LXXV/NISYskR0cflTqdq5KzpWa42KBSVhdSwakznnJoPttoxry8AO883hSlqmaAZ2OfcXChmXMvQHa8kT566X+mGY2qSLZRFO8VctQdHuw4Fgut8m06R4rH58c6t+qYjfpj/zqCb3gl7iM/JrBuwfsos6V8MQoyBFUujmo0O7csIH7y1yPk4p8qaUL7lSSpid53Ib8R26N/5FoSwUowbPfH434bxjF1rXEKCvesp9F4RbYiacTF6I8jriicxjaVUT2YU2C7m65SIFh1MFh8Da0Ob33aoC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2B2F42C13DC0143A14FFD13C9FDD5E1@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8073cea0-2f51-4440-0a80-08d753eb7487
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 16:51:43.0933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyQA6P7AQ4+RSssgtJ03wKluRObLS5Aeq5wGcZKG87cQy20GfUsisoz8MTHaSn5cVWRsyIixhAd1n1JEDdzlKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3143
X-OriginatorOrg: suse.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 15.124.2.85
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTEwLTE4IGF0IDE4OjEwICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToNCj4g
UGV0ZXIgaGl0IGEgIkNvdWxkIG5vdCBvcGVuICdURVNUX0RJUi90LklNR0ZNVCc6IEZhaWxlZCB0
byBnZXQgc2hhcmVkDQo+ICd3cml0ZScgbG9jayAtIElzIGFub3RoZXIgcHJvY2VzcyB1c2luZyB0
aGUgaW1hZ2UNCj4gW1RFU1RfRElSL3QuSU1HRk1UXT8iDQo+IGVycm9yIHdpdGggMTMwIGFscmVh
ZHkgdHdpY2UuIExvb2tzIGxpa2UgdGhpcyB0ZXN0IGlzIGEgbGl0dGxlIGJpdA0KPiBzaGFreSwg
YW5kIGN1cnJlbnRseSBub2JvZHkgaGFzIGEgcmVhbCBjbHVlIHdoYXQgY291bGQgYmUgY2F1c2lu
Zw0KPiB0aGlzDQo+IGlzc3VlLCBzbyBmb3IgdGhlIHRpbWUgYmVpbmcsIGxldCdzIGRpc2FibGUg
aXQgZnJvbSB0aGUgImF1dG8iIGdyb3VwDQo+IHNvDQo+IHRoYXQgaXQgZG9lcyBub3QgZ2F0ZSB0
aGUgcHVsbCByZXF1ZXN0cy4NCj4gDQoNCkZvciBzb21lIHRpbWUgSSd2ZSBhbHNvIG5lZWRlZCB0
byB3b3JrIGFyb3VuZCBpc3N1ZXMgcnVubmluZyAxMzAuIEkNCmVpdGhlciBkaXNhYmxlZCBpdCwg
b3IgSSBmb3VuZCBhIGZldyBwcm9wZXJseSBwbGFjZWQgc2xlZXBzIGdvdCBpdCB0bw0KcmVsaWFi
bHkgcGFzcy4gTGFzdCB3ZWVrIEkgZmluYWxseSBnb3QgYXJvdW5kIHRvIGludmVzdGlnYXRpbmcg
aXQgYSBiaXQNCm1vcmUgYW5kIGRpc2NvdmVyZWQgdGhhdCB0aGUgZmFpbHVyZSB3YXMgcmVsYXRl
ZCB0byBteSB1c2luZyAtLWVuYWJsZS0NCm1lbWJhcnJpZXIgaW4gbXkgY29uZmlndXJlLg0KDQpJ
IGRpZG4ndCBpbnZlc3RpZ2F0ZSB3aGV0aGVyIHRoZSBibG9jayBpbyB0ZXN0cycgX2NsZWFudXBf
cWVtdSB1c2luZw0Ka2lsbCAtS0lMTCB3YXMgYmVpbmcgcmVsaWVkIG9uIGluIHNvbWUgd2F5IGJ5
IHNvbWUgdGVzdHMsIG9yIGlmIHRoYXQgaXMNCnNpbXBseSBhIHdheSB0byBzcGVlZCB0aGUgdGVz
dGluZyBhbG9uZywgb3Igd2hhdCwgYnV0IEkndmUgZ290dGVuIHRlc3QNCjEzMCB0byByZWxpYWJs
eSBwYXNzIGJ5IGNoYW5naW5nIHRoZSB0ZXN0IHRvIHF1aXQgcHJvcGVybHkgdmlhIHRoZQ0KbW9u
aXRvciwgYW5kIGJ5IGFkZGluZyBhIHdhaXQ9MSBzbyB0aGF0IF9jbGVhbnVwX3FlbXUgZG9lc24n
dCBzaW1wbHkNCmtpbGwgcWVtdS4NCg0KSSBiZWxpZXZlIDE1MyBhbmQgMTYxIGFsc28gc3VmZmVy
IGluIGEgc2ltaWxhciB3YXkuDQoNCkkgaGF2ZW4ndCBnb3R0ZW4gYXJvdW5kIHRvIGZ1bGx5IHVu
ZGVyc3RhbmRpbmcgaG93IHFlbXUncyB1c2luZyB0aGUNCmtlcm5lbCBzeXNfbWVtYmFycmllciBp
cyBhZHZlcnNseSBhZmZlY3RlZCBieSBraWxsaW5nIHFlbXUgaW4gdGhpcyB3YXksDQpidXQgaXQg
c2VlbXMgdGhlcmUncyBhbiBpc3N1ZSB3aXRoIHRoYXQuDQoNCkhvcGVmdWxseSBzb21lb25lIHdo
byBpcyBtb3JlIGZhbWlsaWFyIHdpdGggcWVtdSdzIHVzZSBvZiBtZW1iYXJyaWVyJ3MNCmNhbiBh
ZGQgbW9yZSBkZXRhaWxzIGhlcmUuDQoNCkJydWNlDQo=


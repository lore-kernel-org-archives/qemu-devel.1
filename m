Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECB7C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C44020659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a6NBLCng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C44020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgX7B-0005aa-92
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgWIR-00047e-Uy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hgWIQ-00013R-F7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:47 -0400
Received: from mail-eopbgr30116.outbound.protection.outlook.com
 ([40.107.3.116]:17846 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hgWIH-0000v8-Em; Thu, 27 Jun 2019 11:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEFzHUl78eE7FqcBHP1myQMt6A8C8dFhZo0gbskNkGk=;
 b=a6NBLCngYeiGA9E6PsEsmKe/axZCXSTIp0u265/c47HFaYkTIlwAuWctrHbVyJKCEkMCoe5UbaGzPhcrnMKlLGqFIZoE6SlmQDaqRK3xYhFj0EIg7/p5aUxUOPjhensLxdT0c2Fu//yh0aELCK6bLz4OTXZNObycVVhYVPQZDlQ=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3666.eurprd08.prod.outlook.com (20.177.43.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 15:26:34 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 15:26:34 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v6] qemu-io: add pattern file for write
 command
Thread-Index: AQHVH5BNrxdp/Ppy+EiGbwE3Di2xAaaizugAgAzrW4A=
Date: Thu, 27 Jun 2019 15:26:33 +0000
Message-ID: <973ca865-83ee-5dd0-5c36-906cab220fe9@virtuozzo.com>
References: <20190610132124.3568-1-dplotnikov@virtuozzo.com>
 <9c2edd2b-766c-26e8-436a-d2763e2537c8@virtuozzo.com>
In-Reply-To: <9c2edd2b-766c-26e8-436a-d2763e2537c8@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0154.eurprd05.prod.outlook.com
 (2603:10a6:7:28::41) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fd72061-e8b5-4f5b-8040-08d6fb13d630
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3666; 
x-ms-traffictypediagnostic: AM0PR08MB3666:
x-microsoft-antispam-prvs: <AM0PR08MB36669A80F493C3F6053A0111CFFD0@AM0PR08MB3666.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39850400004)(346002)(376002)(136003)(189003)(199004)(6512007)(8936002)(76176011)(53936002)(52116002)(102836004)(6486002)(478600001)(6246003)(446003)(6436002)(476003)(3846002)(2616005)(68736007)(6116002)(316002)(486006)(53546011)(71190400001)(256004)(71200400001)(11346002)(66066001)(31686004)(81166006)(54906003)(229853002)(2906002)(99286004)(2201001)(386003)(5660300002)(7736002)(110136005)(4326008)(2501003)(14454004)(6506007)(86362001)(305945005)(66946007)(73956011)(64756008)(186003)(8676002)(66476007)(66556008)(26005)(25786009)(31696002)(36756003)(66446008)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3666;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pVZnNR2jHI6GrjcXycvcNJcNCWws62H7FMyWeCYqItK3HkBb6wHWTp8r7iD7vox3S6g0ybRExYsR7F2yF54v8AdUfNBlNasYgu84wGc9ks/zumVFh8SqOBlhCFTcsFKCAdB7NTz9TCkN1Rwn63+A20cUyEMwmS/lOufDX9SgqKSO/Pt3kvVL/lxKrhWGlcOTrucO05hKqoWeQLzkG4FB5iW/Y9BDGcfIx/k76iQcFYk+OlJqMYBdiQBptr8mYiSmw6y+HSNh/z4Erbx0xYGWwIkjtZ3hIE9+fTNJq9xsOoZ5cn9NmQi3f151i8F10QuM8I7yxNV0t3h0l2of4pvyqVQNVzg+zj3VZGUga3qMXsGD6koUYSsfalYs5PYn/f7H6VjJfqDCOIMzIRdYxualKswujq4ghlP7Mkyl5eXJ9CI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A45A163D6BFD8345B82D6353DB3B30CD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd72061-e8b5-4f5b-8040-08d6fb13d630
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 15:26:33.8375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3666
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.116
Subject: Re: [Qemu-devel] [PATCH v6] qemu-io: add pattern file for write
 command
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE5LjA2LjIwMTkgMTM6MDksIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+IDEwLjA2LjIwMTkgMTY6MjEsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4+IFRoZSBw
YXRjaCBhbGxvd3MgdG8gcHJvdmlkZSBhIHBhdHRlcm4gZmlsZSBmb3Igd3JpdGUNCj4+IGNvbW1h
bmQuIFRoZXJlIHdhcyBubyBzaW1pbGFyIGFiaWxpdHkgYmVmb3JlLg0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IERlbmlzIFBsb3RuaWtvdiA8ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0t
DQo+PiB2NjoNCj4+ICAgICAqIHRoZSBwYXR0ZXJuIGZpbGUgaXMgcmVhZCBvbmNlIHRvIHJlZHVj
ZSBpbw0KPj4NCj4+IHY1Og0KPj4gICAgICogZmlsZSBuYW1lIGluaXRpYXRlZCB3aXRoIG51bGwg
dG8gbWFrZSBjb21waWxlcnMgaGFwcHkNCj4+DQo+PiB2NDoNCj4+ICAgICAqIG1pc3Npbmcgc2ln
bmVkLW9mZiBjbGF1c2UgYWRkZWQNCj4+DQo+PiB2MzoNCj4+ICAgICAqIG1pc3NpbmcgZmlsZSBj
bG9zaW5nIGFkZGVkDQo+PiAgICAgKiBleGNsdXNpdmUgZmxhZ3MgcHJvY2Vzc2luZyBjaGFuZ2Vk
DQo+PiAgICAgKiBidWZmZXIgdm9pZCogY29udmVydGVkIHRvIGNoYXIqIHRvIGZpeCBwb2ludGVy
IGFyaXRobWV0aWNzDQo+PiAgICAgKiBmaWxlIHJlYWRpbmcgZXJyb3IgcHJvY2Vzc2luZyBhZGRl
ZA0KPj4gLS0tDQo+PiAgICBxZW11LWlvLWNtZHMuYyB8IDg4ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgODIg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvcWVtdS1p
by1jbWRzLmMgYi9xZW11LWlvLWNtZHMuYw0KPj4gaW5kZXggMDk3NTBhMjNjZS4uZTI3MjAzZjc0
NyAxMDA2NDQNCj4+IC0tLSBhL3FlbXUtaW8tY21kcy5jDQo+PiArKysgYi9xZW11LWlvLWNtZHMu
Yw0KPj4gQEAgLTM0Myw2ICszNDMsNjkgQEAgc3RhdGljIHZvaWQgKnFlbXVfaW9fYWxsb2MoQmxv
Y2tCYWNrZW5kICpibGssIHNpemVfdCBsZW4sIGludCBwYXR0ZXJuKQ0KPj4gICAgICAgIHJldHVy
biBidWY7DQo+PiAgICB9DQo+PiAgICANCj4+ICtzdGF0aWMgdm9pZCAqcWVtdV9pb19hbGxvY19m
cm9tX2ZpbGUoQmxvY2tCYWNrZW5kICpibGssIHNpemVfdCBsZW4sDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmZpbGVfbmFtZSkNCj4+ICt7DQo+PiArICAg
IGNoYXIgKmJ1ZiwgKmJ1Zl9vcmlnaW47DQo+PiArICAgIEZJTEUgKmYgPSBmb3BlbihmaWxlX25h
bWUsICJyIik7DQo+PiArICAgIGludCBsOw0KPiANCj4gc2hvdWxkIGJlIHNpemVfdCwgYW5kIGNv
dWxkIHlvdSBnZXQgaXQgZGVzY3JpcHRpdmUgbmFtZSBwYXR0ZXJuX2xlbiBvciBsaWtlIHRoaXM/
DQo+IA0KPj4gKw0KPj4gKyAgICBpZiAoIWYpIHsNCj4+ICsgICAgICAgIHByaW50ZigiJyVzJzog
JXNcbiIsIGZpbGVfbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsNCj4+ICsgICAgICAgIHJldHVybiBO
VUxMOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmIChxZW11aW9fbWlzYWxpZ24pIHsNCj4+
ICsgICAgICAgIGxlbiArPSBNSVNBTElHTl9PRkZTRVQ7DQo+PiArICAgIH0NCj4+ICsgICAgYnVm
X29yaWdpbiA9IGJsa19ibG9ja2FsaWduKGJsaywgbGVuKTsNCj4+ICsgICAgbWVtc2V0KGJ1Zl9v
cmlnaW4sIDAsIGxlbik7DQo+PiArDQo+PiArICAgIGJ1ZiA9IGJ1Zl9vcmlnaW47DQo+PiArDQo+
PiArICAgIGwgPSBmcmVhZChidWYsIHNpemVvZihjaGFyKSwgbGVuLCBmKTsNCj4+ICsNCj4+ICsg
ICAgaWYgKGZlcnJvcihmKSkgew0KPj4gKyAgICAgICAgcHJpbnRmKCInJXMnOiAlc1xuIiwgZmls
ZV9uYW1lLCBzdHJlcnJvcihlcnJubykpOw0KPj4gKyAgICAgICAgZ290byBlcnJvcjsNCj4+ICsg
ICAgfQ0KPj4gKw0KPj4gKyAgICBpZiAobCA9PSAwKSB7DQo+PiArICAgICAgICBwcmludGYoIicl
cycgaXMgZW1wdHlcbiIsIGZpbGVfbmFtZSk7DQo+PiArICAgICAgICBnb3RvIGVycm9yOw0KPj4g
KyAgICB9DQo+PiArDQo+PiArICAgIGlmIChsIDwgbGVuKSB7DQo+PiArICAgICAgICBjaGFyICpm
aWxlX2J1ZiA9IGdfbWFsbG9jKHNpemVvZihjaGFyKSAqIGwpOw0KPj4gKyAgICAgICAgbWVtY3B5
KGZpbGVfYnVmLCBidWYsIGwpOw0KPiANCj4gSSBzZWUgbm8gcmVhc29uIHRvIGNvcHkgaXQsIHlv
dSBjYW4ganVzdCB1c2UgYnVmX29yaWdpbiBwb2ludGVyDQo+IGluc3RlYWQuDQpJIHVzZSBidWZf
b3JpZ2luIHRvIHNhdmUgdGhlIGJlZ2lubmluZyBwb2ludGVyIHRvIHJldHVybiBpdCBmcm9tIHRo
ZSANCmZ1bmN0aW9uIGF2b2lkaW5nIGxhdGVyIGNhbGN1bGF0aW9uIG9mIHRoZSBiZWdpbm5pbmcg
YWRkcmVzcyBzaW5jZSANCnBvaW50ZXIgb2YgdGhlIGJ1ZiBpcyBjaGFuZ2VkIGluIHRoZSBsb29w
Lg0KPiANCj4+ICsgICAgICAgIGxlbiAtPSBsOw0KPj4gKyAgICAgICAgYnVmICs9IGw7DQo+PiAr
DQo+PiArICAgICAgICB3aGlsZSAobGVuID4gMCkgew0KPj4gKyAgICAgICAgICAgIHNpemVfdCBs
ZW5fdG9fY29weSA9IGxlbiA+IGwgPyBsIDogbGVuOw0KPiANCj4geW91IG1heSB1c2UgTUlOKGxl
biwgbCkNCj4gDQo+PiArDQo+PiArICAgICAgICAgICAgbWVtY3B5KGJ1ZiwgZmlsZV9idWYsIGxl
bl90b19jb3B5KTsNCj4+ICsNCj4+ICsgICAgICAgICAgICBsZW4gLT0gbGVuX3RvX2NvcHk7DQo+
PiArICAgICAgICAgICAgYnVmICs9IGxlbl90b19jb3B5Ow0KPj4gKyAgICAgICAgfQ0KPj4gKyAg
ICAgICAgcWVtdV92ZnJlZShmaWxlX2J1Zik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaWYg
KHFlbXVpb19taXNhbGlnbikgew0KPj4gKyAgICAgICAgYnVmX29yaWdpbiArPSBNSVNBTElHTl9P
RkZTRVQ7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZ290byBvdXQ7DQo+PiArDQo+PiArZXJy
b3I6DQo+PiArICAgIHFlbXVfdmZyZWUoYnVmKTsNCj4+ICsgICAgYnVmX29yaWdpbiA9IE5VTEw7
DQo+PiArb3V0Og0KPj4gKyAgICBmY2xvc2UoZik7DQo+PiArICAgIHJldHVybiBidWZfb3JpZ2lu
Ow0KPj4gK30NCj4+ICsNCj4+ICAgIHN0YXRpYyB2b2lkIHFlbXVfaW9fZnJlZSh2b2lkICpwKQ0K
Pj4gICAgew0KPj4gICAgICAgIGlmIChxZW11aW9fbWlzYWxpZ24pIHsNCj4+IEBAIC05NjUsNyAr
MTAyOCw3IEBAIHN0YXRpYyBjb25zdCBjbWRpbmZvX3Qgd3JpdGVfY21kID0gew0KPj4gICAgICAg
IC5wZXJtICAgICAgID0gQkxLX1BFUk1fV1JJVEUsDQo+PiAgICAgICAgLmFyZ21pbiAgICAgPSAy
LA0KPj4gICAgICAgIC5hcmdtYXggICAgID0gLTEsDQo+PiAtICAgIC5hcmdzICAgICAgID0gIlst
YmNDZm5xdXpdIFstUCBwYXR0ZXJuXSBvZmYgbGVuIiwNCj4+ICsgICAgLmFyZ3MgICAgICAgPSAi
Wy1iY0NmbnF1el0gWy1QIHBhdHRlcm4gfCAtcyBzb3VyY2VfZmlsZV0gb2ZmIGxlbiIsDQo+PiAg
ICAgICAgLm9uZWxpbmUgICAgPSAid3JpdGVzIGEgbnVtYmVyIG9mIGJ5dGVzIGF0IGEgc3BlY2lm
aWVkIG9mZnNldCIsDQo+PiAgICAgICAgLmhlbHAgICAgICAgPSB3cml0ZV9oZWxwLA0KPj4gICAg
fTsNCj4+IEBAIC05NzQsNyArMTAzNyw3IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tl
bmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgew0KPj4gICAgICAgIHN0cnVj
dCB0aW1ldmFsIHQxLCB0MjsNCj4+ICAgICAgICBib29sIENmbGFnID0gZmFsc2UsIHFmbGFnID0g
ZmFsc2UsIGJmbGFnID0gZmFsc2U7DQo+PiAtICAgIGJvb2wgUGZsYWcgPSBmYWxzZSwgemZsYWcg
PSBmYWxzZSwgY2ZsYWcgPSBmYWxzZTsNCj4+ICsgICAgYm9vbCBQZmxhZyA9IGZhbHNlLCB6Zmxh
ZyA9IGZhbHNlLCBjZmxhZyA9IGZhbHNlLCBzZmxhZyA9IGZhbHNlOw0KPj4gICAgICAgIGludCBm
bGFncyA9IDA7DQo+PiAgICAgICAgaW50IGMsIGNudCwgcmV0Ow0KPj4gICAgICAgIGNoYXIgKmJ1
ZiA9IE5VTEw7DQo+PiBAQCAtOTgzLDggKzEwNDYsOSBAQCBzdGF0aWMgaW50IHdyaXRlX2YoQmxv
Y2tCYWNrZW5kICpibGssIGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+ICAgICAgICAvKiBTb21l
IGNvbXBpbGVycyBnZXQgY29uZnVzZWQgYW5kIHdhcm4gaWYgdGhpcyBpcyBub3QgaW5pdGlhbGl6
ZWQuICAqLw0KPj4gICAgICAgIGludDY0X3QgdG90YWwgPSAwOw0KPj4gICAgICAgIGludCBwYXR0
ZXJuID0gMHhjZDsNCj4+ICsgICAgY2hhciAqZmlsZV9uYW1lID0gTlVMTDsNCj4+ICAgIA0KPj4g
LSAgICB3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgImJjQ2ZucFA6cXV6IikpICE9IC0x
KSB7DQo+PiArICAgIHdoaWxlICgoYyA9IGdldG9wdChhcmdjLCBhcmd2LCAiYmNDZm5wUDpxdXpz
OiIpKSAhPSAtMSkgew0KPj4gICAgICAgICAgICBzd2l0Y2ggKGMpIHsNCj4+ICAgICAgICAgICAg
Y2FzZSAnYic6DQo+PiAgICAgICAgICAgICAgICBiZmxhZyA9IHRydWU7DQo+PiBAQCAtMTAyMCw2
ICsxMDg0LDEwIEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQgKmJsaywgaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgICAgICAgICBjYXNlICd6JzoNCj4+ICAgICAgICAgICAg
ICAgIHpmbGFnID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAg
Y2FzZSAncyc6DQo+PiArICAgICAgICAgICAgc2ZsYWcgPSB0cnVlOw0KPj4gKyAgICAgICAgICAg
IGZpbGVfbmFtZSA9IGdfc3RyZHVwKG9wdGFyZyk7DQo+PiArICAgICAgICAgICAgYnJlYWs7DQo+
PiAgICAgICAgICAgIGRlZmF1bHQ6DQo+PiAgICAgICAgICAgICAgICBxZW11aW9fY29tbWFuZF91
c2FnZSgmd3JpdGVfY21kKTsNCj4+ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4g
QEAgLTEwNTEsOCArMTExOSw5IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tlbmQgKmJs
aywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cj4+ICAgICAgICB9DQo+PiAgICANCj4+IC0gICAgaWYgKHpmbGFnICYmIFBmbGFnKSB7DQo+PiAt
ICAgICAgICBwcmludGYoIi16IGFuZCAtUCBjYW5ub3QgYmUgc3BlY2lmaWVkIGF0IHRoZSBzYW1l
IHRpbWVcbiIpOw0KPj4gKyAgICBpZiAoKGludCl6ZmxhZyArIChpbnQpUGZsYWcgKyAoaW50KXNm
bGFnID4gMSkgew0KPj4gKyAgICAgICAgcHJpbnRmKCJPbmx5IG9uZSBvZiAteiwgLVAsIGFuZCAt
cyINCj4+ICsgICAgICAgICAgICAgICAiY2FuIGJlIHNwZWNpZmllZCBhdCB0aGUgc2FtZSB0aW1l
XG4iKTsNCj4+ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiAgICAgICAgfQ0KPj4gICAg
DQo+PiBAQCAtMTA4OCw3ICsxMTU3LDE0IEBAIHN0YXRpYyBpbnQgd3JpdGVfZihCbG9ja0JhY2tl
bmQgKmJsaywgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPj4gICAgICAgIH0NCj4+ICAgIA0KPj4g
ICAgICAgIGlmICghemZsYWcpIHsNCj4+IC0gICAgICAgIGJ1ZiA9IHFlbXVfaW9fYWxsb2MoYmxr
LCBjb3VudCwgcGF0dGVybik7DQo+PiArICAgICAgICBpZiAoc2ZsYWcpIHsNCj4+ICsgICAgICAg
ICAgICBidWYgPSBxZW11X2lvX2FsbG9jX2Zyb21fZmlsZShibGssIGNvdW50LCBmaWxlX25hbWUp
Ow0KPj4gKyAgICAgICAgICAgIGlmICghYnVmKSB7DQo+PiArICAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsgICAgICAgIH0gZWxzZSB7DQo+PiAr
ICAgICAgICAgICAgYnVmID0gcWVtdV9pb19hbGxvYyhibGssIGNvdW50LCBwYXR0ZXJuKTsNCj4+
ICsgICAgICAgIH0NCj4+ICAgICAgICB9DQo+PiAgICANCj4+ICAgICAgICBnZXR0aW1lb2ZkYXko
JnQxLCBOVUxMKTsNCj4+DQo+IA0KPiANCg0KLS0gDQpCZXN0LA0KRGVuaXMNCg==


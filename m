Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAC4C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3719721924
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YNfW2MAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3719721924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIjX-0006NA-RD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFIhL-0004ls-Ll
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFIhK-0004tX-1J
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:00:15 -0400
Received: from mail-ve1eur03on072f.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::72f]:27518
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFIhJ-0004nI-4s; Tue, 01 Oct 2019 10:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj8p7JzHA4HAZmo+6/z7S+db2tJgvyu9OdLY7EOgCnP5V8KlvcVBabK9dFJWA2q/gAtvxrRwl/OFqMBysYp5brOhVX6qQ3WS96eUdgryMnWPT3uuLXUHNq+WLDHyS7tkZwefLDn+UB77Mfi671d5/H/FzWHoC4ZvVC8No/3gJQeY3zfBgrWTjVO5WQcfI2LTGWFeVwfGtuwRp9UeOCAGj74vIFpGjDH4tMcbrEEOXj+ogqfo9vEsn8xzuJdw0JHCObk9UNLt1q1eMdCoji5G5yE/P1aJ5NZyvnk5XQ/5E/opMPqoEcR/hlMu2NMT+2jxDGb4CG9d/3RLQ5qjEPvpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2RKXJF4EfrSuC7VSP3nCoAImP8Lyg96Rdv0F+wD/7Y=;
 b=dnz2NQkC/pXLS/9268jP8BN1bDP8s5073+MYeOdV8PSNwAqe+UOxc88IC1ON9PETWayDEE7ELBarcdFZHOqYtuCr3NfZZFAygbfTew1MBkmJal7+XE2eAdCJoLySEl8aGTXvVWPaQH/lGD2lycS/FSVGngeMqIuw6mHQ0+/NPoPso/7TyBLQ3OKBXmAZmFq2pa/4SFK66zdFrw8i+46DEDqHKXNMqdtgmWQAUMRZ/Bne1OSs18nyw7QoC73L5D8AlvieaFllBPH6SihQ103rWRXuvdEy7nZAa2cZQ2xBbdtvVVJvoDQq0f/zej5Um9QNeArySPhc14meEINwjbm7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2RKXJF4EfrSuC7VSP3nCoAImP8Lyg96Rdv0F+wD/7Y=;
 b=YNfW2MAPyW5ha8kcVJ6InfPFNli58uFYSaP492hav+B5sNkUoVsJlUpStv18W1kv4MJfRPx+vRXS2uLB1A51eKoxU0Fzv1sHFXA/9hZXvFJSWn3UxO5I25AbkBpofTFRCLEfK5HZFG6c0xkUNB7ECdq8Csk14rMp2JfL75W7tB4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5387.eurprd08.prod.outlook.com (52.133.241.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Tue, 1 Oct 2019 14:00:08 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 14:00:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUA
Date: Tue, 1 Oct 2019 14:00:08 +0000
Message-ID: <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
In-Reply-To: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0280.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001170006211
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc88c7a7-05cd-4fbf-2062-08d74677ab64
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5387; 
x-ms-traffictypediagnostic: DB8PR08MB5387:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB53872D32310E893C3C34AC0EC19D0@DB8PR08MB5387.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(39850400004)(376002)(199004)(189003)(11346002)(229853002)(6116002)(446003)(486006)(476003)(6916009)(4326008)(2906002)(3846002)(6486002)(2616005)(71200400001)(6436002)(71190400001)(305945005)(7736002)(86362001)(31696002)(6246003)(6306002)(6512007)(36756003)(64756008)(5024004)(478600001)(66556008)(99286004)(14444005)(54906003)(256004)(66066001)(966005)(52116002)(76176011)(25786009)(66946007)(66476007)(186003)(31686004)(66446008)(102836004)(386003)(26005)(14454004)(6506007)(8676002)(5660300002)(316002)(8936002)(81156014)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5387;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zZmXypBaVfFmOpr3oSISZGEO4VNCyZlBFuJrfrz67OV30ALkPHFWZNLXtGq5FuakWkoANwxdgOenHxrwAm0sGMj6RxIalaf72qM9YHj+4S2FfmoWZxFk1TLnsauyaJBqTV6/GsJ3sGDWW5urHs4sy/dJ85rXI/JYjYAszmJZz/tEUa0Ngp/EQdSqjCBfMCi65O66B2VJxBCVUumYkogxyQ9XfQsNMlEBUu2a2hP3C6x85Gwl2jLvfcUGNlEmcQJbmQdldCSGZs/nyQseabCpt0jzrW1r7TfnqS3zB8eypB66WZAcYBKuS+nHd0K5ZBGWYOAQyrD/2r/x343YewQFVG3mlZazWAc+qsCWIpOo5xEQnm93al3+fOa6iSbQA117slncvoTxchv4CtZdpvXpilwuMkXhscGBIkJm8YYL1EB0bvM0ySygtS5SBcjnwJkBFIYFHHt56IiPpWhyK+NAtw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B0EDE532370FE4A97BF573A197128D5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc88c7a7-05cd-4fbf-2062-08d74677ab64
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 14:00:08.8314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p85plmmWA7CB38uYvSJ9CI1+HWHCj4MSdj6brCvGV6ANcMWUh6cA1IpXzFfWP2CHAHRPJ9E44lIU/p6+hR5Srh9v9GOJ7UcRkUISVB1MsIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5387
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::72f
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAzOjA5LCBKb2huIFNub3cgd3JvdGU6DQo+IEhpIGZvbGtzLCBJIGlkZW50aWZp
ZWQgYSBwcm9ibGVtIHdpdGggdGhlIG1pZ3JhdGlvbiBjb2RlIHRoYXQgUmVkIEhhdCBRRQ0KPiBm
b3VuZCBhbmQgdGhvdWdodCB5b3UnZCBsaWtlIHRvIHNlZSBpdDoNCj4gDQo+IGh0dHBzOi8vYnVn
emlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTY1MjQyNCNjMjANCj4gDQo+IFZlcnks
IHZlcnkgYnJpZWZseTogZHJpdmUtbWlycm9yIGluc2VydHMgYSBmaWx0ZXIgbm9kZSB0aGF0IGNo
YW5nZXMgd2hhdA0KPiBiZHJ2X2dldF9kZXZpY2Vfb3Jfbm9kZV9uYW1lKCkgcmV0dXJucywgd2hp
Y2ggY2F1c2VzIGEgbWlncmF0aW9uIHByb2JsZW0uDQo+IA0KPiANCj4gSWdub3JhbnQgcXVlc3Rp
b24gIzE6IENhbiB3ZSBtdWx0aS1wYXJlbnQgdGhlIGZpbHRlciBub2RlIGFuZA0KPiBzb3VyY2Ut
bm9kZT8gSXQgbG9va3MgbGlrZSBhdCB0aGUgbW9tZW50IGJvdGggY29uc2lkZXIgdGhlaXIgb25s
eSBwYXJlbnQNCj4gdG8gYmUgdGhlIGJsb2NrLWpvYiBhbmQgZG9uJ3QgaGF2ZSBhIGxpbmsgYmFj
ayB0byB0aGVpciBwYXJlbnRzIG90aGVyd2lzZS4NCj4gDQo+IA0KPiBPdGhlcndpc2U6IEkgaGF2
ZSBhIGxvdCBvZiBjbG91ZHkgaWRlYXMgb24gaG93IHRvIHNvbHZlIHRoaXMsIGJ1dA0KPiB1bHRp
bWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQgdGhlICJhZGRyZXNzYWJs
ZSIgbmFtZSBmb3INCj4gdGhlIG5vZGUgdGhlIGJpdG1hcCBpcyBhdHRhY2hlZCB0bywgd2hpY2gg
d291bGQgYmUgdGhlIG5hbWUgb2YgdGhlIGZpcnN0DQo+IGFuY2VzdG9yIG5vZGUgdGhhdCBpc24n
dCBhIGZpbHRlci4gKE9SLCB0aGUgbmFtZSBvZiB0aGUgYmxvY2stYmFja2VuZA0KPiBhYm92ZSB0
aGF0IG5vZGUuKQ0KDQpOb3QgdGhlIG5hbWUgb2YgYW5jZXN0b3Igbm9kZSwgaXQgd2lsbCBicmVh
ayBtYXBwaW5nOiBpdCBtdXN0IGJlIG5hbWUgb2YgdGhlDQpub2RlIGl0c2VsZiBvciBuYW1lIG9m
IHBhcmVudCAobWF5IGJlIHRocm91Z2ggc2V2ZXJhbCBmaWx0ZXJzKSBibG9jay1iYWNrZW5kDQoN
Cj4gDQo+IEEgc2ltcGxlIHdheSB0byBkbyB0aGlzIG1pZ2h0IGJlIGEgImNoaWxkX3VuZmlsdGVy
ZWQiIEJkcnZDaGlsZCByb2xlDQo+IHRoYXQgc2ltcGx5IGJ5cGFzc2VzIHRoZSBmaWx0ZXIgdGhh
dCB3YXMgaW5zZXJ0ZWQgYW5kIHNlcnZlcyBubyByZWFsDQo+IHB1cnBvc2Ugb3RoZXIgdGhhbiB0
byBhbGxvdyB0aGUgY2hpbGQgdG8gaGF2ZSBhIHBhcmVudCBsaW5rIGFuZCBmaW5kIHdobw0KPiBp
dCdzICIiInJlYWwiIiIgcGFyZW50IGlzLg0KPiANCj4gQmVjYXVzZSBvZiBmbHVzaGluZywgcmVv
cGVuLCBzeW5jLCBkcmFpbiAmYyAmYyAmYyBJJ20gbm90IHN1cmUgaG93DQo+IGZlYXNpYmxlIHRo
aXMgcXVpY2sgaWRlYSBtaWdodCBiZSwgdGhvdWdoLg0KPiANCj4gDQo+IC0gQ29yb2xsYXJ5IGZp
eCAjMTogY2FsbCBlcnJvcl9zZXRnIGlmIHRoZSBiaXRtYXAgbm9kZSBuYW1lIHRoYXQncyBhYm91
dA0KPiB0byBnbyBvdmVyIHRoZSB3aXJlIGlzIGFuIGF1dG9nZW5lcmF0ZWQgbm9kZTogdGhpcyBp
cyBuZXZlciBjb3JyZWN0IQ0KPiANCj4gKFdoeSBub3Q/IGJlY2F1c2UgdGhlIHRhcmdldCBpcyBp
bmNhcGFibGUgb2YgbWF0Y2hpbmcgdGhlIG5vZGUtbmFtZQ0KPiBiZWNhdXNlIHRoZXkgYXJlIHJh
bmRvbWx5IGdlbmVyYXRlZCBBTkQgeW91IGNhbm5vdCBzcGVjaWZ5IG5vZGUtbmFtZXMNCj4gd2l0
aCAjIHByZWZpeGVzIGFzIHRoZXkgYXJlIGVzcGVjaWFsbHkgcmVzZXJ2ZWQhDQo+IA0KPiAoVGhp
cyByYWlzZXMgYSByZWxhdGVkIHByb2JsZW06IGlmIHlvdSBleHBsaWNpdGx5IGFkZCBiaXRtYXBz
IHRvIG5vZGVzDQo+IHdpdGggYXV0b2dlbmVyYXRlZCBuYW1lcywgeW91IHdpbGwgYmUgdW5hYmxl
IHRvIG1pZ3JhdGUgdGhlbS4pKQ0KPiANCj4gLS1qcw0KPiANCg0KV2hhdCBhYm91dCB0aGUgZm9s
bG93aW5nOg0KDQpkaWZmIC0tZ2l0IGEvYmxvY2suYyBiL2Jsb2NrLmMNCmluZGV4IDU5NDQxMjQ4
NDUuLjY3MzljMTliZTkgMTAwNjQ0DQotLS0gYS9ibG9jay5jDQorKysgYi9ibG9jay5jDQpAQCAt
MTAwOSw4ICsxMDA5LDIwIEBAIHN0YXRpYyB2b2lkIGJkcnZfaW5oZXJpdGVkX29wdGlvbnMoaW50
ICpjaGlsZF9mbGFncywgUURpY3QgKmNoaWxkX29wdGlvbnMsDQogICAgICAqY2hpbGRfZmxhZ3Mg
PSBmbGFnczsNCiAgfQ0KDQorc3RhdGljIGNvbnN0IGNoYXIgKmJkcnZfY2hpbGRfZ2V0X25hbWUo
QmRydkNoaWxkICpjaGlsZCkNCit7DQorICAgIEJsb2NrRHJpdmVyU3RhdGUgKnBhcmVudCA9IGNo
aWxkLT5vcGFxdWU7DQorDQorICAgIGlmIChwYXJlbnQtPmRydiAmJiBwYXJlbnQtPmRydi0+aXNf
ZmlsdGVyKSB7DQorICAgICAgICByZXR1cm4gYmRydl9nZXRfcGFyZW50X25hbWUocGFyZW50KTsN
CisgICAgfQ0KKw0KKyAgICByZXR1cm4gTlVMTDsNCit9DQorDQogIGNvbnN0IEJkcnZDaGlsZFJv
bGUgY2hpbGRfZmlsZSA9IHsNCiAgICAgIC5wYXJlbnRfaXNfYmRzICAgPSB0cnVlLA0KKyAgICAu
Z2V0X25hbWUgICAgICAgID0gYmRydl9jaGlsZF9nZXRfbmFtZSwNCiAgICAgIC5nZXRfcGFyZW50
X2Rlc2MgPSBiZHJ2X2NoaWxkX2dldF9wYXJlbnRfZGVzYywNCiAgICAgIC5pbmhlcml0X29wdGlv
bnMgPSBiZHJ2X2luaGVyaXRlZF9vcHRpb25zLA0KICAgICAgLmRyYWluZWRfYmVnaW4gICA9IGJk
cnZfY2hpbGRfY2JfZHJhaW5lZF9iZWdpbiwNCkBAIC0xMTYzLDYgKzExNzUsNyBAQCBzdGF0aWMg
aW50IGJkcnZfYmFja2luZ191cGRhdGVfZmlsZW5hbWUoQmRydkNoaWxkICpjLCBCbG9ja0RyaXZl
clN0YXRlICpiYXNlLA0KDQogIGNvbnN0IEJkcnZDaGlsZFJvbGUgY2hpbGRfYmFja2luZyA9IHsN
CiAgICAgIC5wYXJlbnRfaXNfYmRzICAgPSB0cnVlLA0KKyAgICAuZ2V0X25hbWUgICAgICAgID0g
YmRydl9jaGlsZF9nZXRfbmFtZSwNCiAgICAgIC5nZXRfcGFyZW50X2Rlc2MgPSBiZHJ2X2NoaWxk
X2dldF9wYXJlbnRfZGVzYywNCiAgICAgIC5hdHRhY2ggICAgICAgICAgPSBiZHJ2X2JhY2tpbmdf
YXR0YWNoLA0KICAgICAgLmRldGFjaCAgICAgICAgICA9IGJkcnZfYmFja2luZ19kZXRhY2gsDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


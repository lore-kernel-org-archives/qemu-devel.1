Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95AAC2D0BF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BA321823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 15:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mrNQvcKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BA321823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ict74-0003Rv-LC
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 10:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ict1c-0006BE-UM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ict1a-0004LA-CP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:26:40 -0500
Received: from mail-eopbgr130130.outbound.protection.outlook.com
 ([40.107.13.130]:7957 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ict1V-0004Ih-K9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 10:26:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk/yyZaaybDsC8+AZXlC0Iatv+o3dSRz1ydRZFfqzpwebDdLdNRbLnhV7I/4urntZsjThrIKnCvp8GCgLYu6Ua6G9V/5mAzoC7cTaFjQFzuf16FgrnjH56X4XWVlN4TRxxrDsZz0PeajiIYh+MGJYtUMwGHhHhuMUPkAMvcwrwv82VTshugg7HIkmBinRFcWUEYYY+o5v7XFrO+tp5EmACBqe9/Ds6bRPoDFl01XlNZHF3KElMlwHOZKHXf/X4zu2sWtKeSir+FIXBhcsnsthdhM76qiNqSrmo0fNLDUhRhy5FLnXhJw315AUKuosO6XQ8VgFg/R26EN/g2ZhDlq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XJoTQ+ECVGfCh9ZCHITBGNkk8eLfSySc+bjUiJ8qzA=;
 b=F1hkiqT6iuOIFrycNc2ebC2wrVNUal8GHtt0BoRE9g7KzjpO8j/2LNnBLi4u3y5AF55NOMjjq3tG1n9BSZCW/D1yKAXOW0FbpayE2zGkjZZYFjNpg6WJ4cjyGh5E1cCvDMaRt0RsxnkhmS537vbtEjMp/dcYpwNVR3g4+d9y+DvRowHE7jviw5i3+1kyoCoDlo+0bhYuI6/MCbR7mNnb9EgR0eQNyqNAlwdt8y2vmpPjqsnlYYehsXZNwkfvrHZDiWH3576acXjHRpdtKbf+PSD68iXH4F2/IWGTr8vNzFheA9z+JizoAyJg/fooXxLGGk6Ysi6n575if5yskYiG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XJoTQ+ECVGfCh9ZCHITBGNkk8eLfSySc+bjUiJ8qzA=;
 b=mrNQvcKX3u0UfjhhC6kJu4GeGTikGHlZCZ8gX/BJVbf6Ia7GJzQ6mLjly7XiV7+i/652duLksqgwyORkBmvQSLx2zYAJuAOfr0yGm5Js2F5hnGV8GCNN1ilEDQZKW8MujNXTu0Ro4MY4OKPijKJqHy6Xwec49KUEfSAmk+LkSFM=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4310.eurprd08.prod.outlook.com (20.179.5.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 15:26:29 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 15:26:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 05/21] crypto: Fix typo in QCryptoTLSSession's <example>
 comment
Thread-Topic: [PATCH 05/21] crypto: Fix typo in QCryptoTLSSession's <example>
 comment
Thread-Index: AQHVp7ZchP6/b3+2u0y4hgKrf1t9SaersU0A
Date: Thu, 5 Dec 2019 15:26:29 +0000
Message-ID: <6dc25d03-8433-1bcd-0c2c-2e7931635c29@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-6-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-6-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::12)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205182627998
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebacc27d-c948-4920-362e-08d779978040
x-ms-traffictypediagnostic: AM6PR08MB4310:
x-microsoft-antispam-prvs: <AM6PR08MB431055F468C97BC0F30A955BC15C0@AM6PR08MB4310.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(39850400004)(396003)(366004)(189003)(199004)(14444005)(64756008)(66446008)(8936002)(66556008)(66476007)(11346002)(4326008)(305945005)(5660300002)(2616005)(14454004)(81166006)(81156014)(8676002)(6486002)(76176011)(25786009)(316002)(2906002)(99286004)(478600001)(52116002)(110136005)(66946007)(26005)(31686004)(86362001)(186003)(6506007)(31696002)(36756003)(229853002)(102836004)(71200400001)(71190400001)(6512007)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4310;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPWGvzj8xCC6fhaW5ed11cLCGWV8zfJCbgpcln809jTSMXm5nAvAsB6J92sYa/Ftmx2oGtqtEdQ+SP5uVJotudNVtOON4Sdve+gAyeNO6IIOzB2T3ZTCR7vb2T+ySo500/Jhe6wNtMloSQsglxAnC3PJolyaDdcNK62RdLmyz30UkLZzNa7xlyzYWWErkuBLJKZW6hT1AsQkvqTpwmcpgZusGLkxHNJ+5P5yn1vGna7JrY8LvvqRaBs1ZvNzCSPEKyiIFWNiVsoDiaDPmxDIV22kIuqGcXMtcJEh1Vrkue1C4oxDoUhM0W0bb7MSzZ3r+MNX4tYzvBakvfd1ztw71f5DrINi8CZsBCmtPFydyOy1oLxHRUSPbNrfTazV+Ts/F3q7LkaZD/LXhB2zu2YIVIcYaxxvxE/jv1WoIkUyiPvGrZf5UXmWTuYoh9zyUuVN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A80550B11766549B0892910D132E5CF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebacc27d-c948-4920-362e-08d779978040
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 15:26:29.5968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjrvhG0lcp2QxdHyDNL5fj5AAOGnRkEzWxZGm33Jt6MY1MxMGIOprrzYneEwoG4LC0ZNRVaff/N4Iicw7kYaigN7WN3jI/eF/9tnErdnNMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4310
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.130
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IENjOiAiRGFuaWVs
IFAuIEJlcnJhbmfDqSIgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9j
cnlwdG8vdGxzc2Vzc2lvbi5oIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY3J5cHRvL3Rs
c3Nlc3Npb24uaCBiL2luY2x1ZGUvY3J5cHRvL3Rsc3Nlc3Npb24uaA0KPiBpbmRleCBlMDFlMWE5
ZGMyLi4xNWI5Y2VmMDg2IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2NyeXB0by90bHNzZXNzaW9u
LmgNCj4gKysrIGIvaW5jbHVkZS9jcnlwdG8vdGxzc2Vzc2lvbi5oDQo+IEBAIC01Niw3ICs1Niw3
IEBADQo+ICAgICoNCj4gICAgKiBzdGF0aWMgaW50IG15c29ja19ydW5fdGxzKGludCBzb2NrZmQs
DQo+ICAgICogICAgICAgICAgICAgICAgICAgICAgICAgICBRQ3J5cHRvVExTQ3JlZHMgKmNyZWRz
LA0KPiAtICogICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqZXJycCkNCj4gKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiAgICAqIHsNCj4gICAgKiAg
ICBRQ3J5cHRvVExTU2Vzc2lvbiAqc2VzczsNCj4gICAgKg0KPiANCg0KDQpSZXZpZXdlZC1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


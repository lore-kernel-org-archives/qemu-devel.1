Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF5C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE342245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 16:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ipC71JcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE342245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ictxG-0006IH-M7
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 11:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ictv2-0005Zf-LJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ictv0-0004HR-Q1
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:23:56 -0500
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:46210 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ictuz-0004Di-4F
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 11:23:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvDUXlby/olU3TLF0/yZ0UDm4t0s9zMhZ5R8Dy8wwJTecD8zFssbqp49uplEeMzxD61wijBE03Heo+XDXItfUQ/K75iGcrbqY90/VvHYuxFG4CPBy1niDo1AC0qwmA8dAQbcPaN7jwxqOWI2obnXf2+CassQdiF1zhsuTo961+yEoToy+1TMMS6LOW6zzDvAUj+7cYP6M/Q2KqeiStFHRkWOnvpAbzT64AHVXRe3tO534LbyeBHnwzb/V6a4e5mYAQAjUW37DiAoUCwWGrg2VPRHjxHSxyMDrc9G2V8hMWNZf3nZCiyOiKNotkJreUKP9XefK9tR2xK64nW+ccv8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTz8X+gbdp7AiCoYDEckTKZvunFr4RfIt4lRfqyQWkY=;
 b=OkHrwHZjZNU0YayjzCLHQYreqifszKY86YgWTRDGtqJ/Nu0DtWetUyW/5kXur8ITsuYfA593THEBCaiPyNgpvMcC5XRhMdSjr10eAfrkkN0sBg5aCJYrF/3qnXCSkX+ehrDG3CxWtIG46tRVWtxHhiLLnPWLIpCaeqkS1925/Jh4dYaQ4VNPswDRLTEwBfVO5IEJffycngmIlovavRDZX8HlNaMjO1xDKnNefeonL3a5zB1Bsi3JgC94yLI0ZsixtIgico1kAaUl8Y5TZ0hOCaz8Z/Fotr+6mnzsAQUB+47DeldCKw4HoGgA+HweFvprue6Dhjv04pe+TOa7VpmoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTz8X+gbdp7AiCoYDEckTKZvunFr4RfIt4lRfqyQWkY=;
 b=ipC71JcOTj05hN2o/4UdlGy9Pif1QsgUGgat3tuCFmC73CruMV7iQM+oxpzkyo8LWEPps/FUAeY79gDW83KJXMZtwUFMGwYc41YrHQfmspAxTB/M0WF+jm39frMcQ8HdaI8X2sJN0AgPnxNdaObtm1VlpwKhAz2Hs8H2TnpUEVE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4373.eurprd08.prod.outlook.com (20.179.7.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Thu, 5 Dec 2019 16:23:48 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 16:23:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
Thread-Topic: [PATCH 10/21] hw/core: Fix latent fit_load_fdt() error handling
 bug
Thread-Index: AQHVp7Zc+yLwnj0NqE2ZqD9/orOgMKerwU8A
Date: Thu, 5 Dec 2019 16:23:48 +0000
Message-ID: <b42438de-3f05-a949-9304-29c051bc4444@virtuozzo.com>
References: <20191130194240.10517-1-armbru@redhat.com>
 <20191130194240.10517-11-armbru@redhat.com>
In-Reply-To: <20191130194240.10517-11-armbru@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0041.eurprd09.prod.outlook.com
 (2603:10a6:7:15::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191205192346803
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0d6c650-a7e9-47ef-5138-08d7799f8228
x-ms-traffictypediagnostic: AM6PR08MB4373:
x-microsoft-antispam-prvs: <AM6PR08MB43732DD0DC66F97964AF158EC15C0@AM6PR08MB4373.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:409;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(346002)(366004)(396003)(376002)(189003)(199004)(81156014)(86362001)(8936002)(8676002)(52116002)(2616005)(31696002)(6486002)(478600001)(316002)(71190400001)(110136005)(6512007)(99286004)(71200400001)(81166006)(5660300002)(11346002)(25786009)(66946007)(102836004)(66556008)(186003)(66446008)(64756008)(6506007)(66476007)(36756003)(31686004)(26005)(305945005)(14454004)(229853002)(2906002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4373;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hl6zShBt71sv+r5Mbh3MaTzwMDrox+fCgxQ+HbxCpNqFvki8a+aIqJk05S/HrGAmC02pFU0cX+STLZPonZ34hZtq8Ti+BGeyBtSb2u6YfKjLww7ALyQwhdaIJPaM2yalRukXBDlctl4SL7Ukp6Vz7yKBUBf3OGTKP+Zw0/R6TnL2q03rDhXeC0urJanycFNwHxWeMMm++zfV3+JzbnZjei8sLl8Lk8eCjalFcPfEz7G5pto0Ok+GDwxlzjZFd9UlCEybvGNRHs48Ru6tcVLGy5T388jddjyRKsyd7sMRaBo+umnlRV19xOjeNUbVCfGl3IQMzyHoIqbN8iLGz6e8lKejM7nRs6va58EW5R0BFS3xJrX2+MojlI9HVDm7rdGjSmn8iIqtiAE4HU2iTB/dn3lwMl0yhD5y9m1jiOHKlTopxkpEz3A2js7nZxoE9siC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <28ECBCF9B7F8D34FA97C0D65BD5438C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d6c650-a7e9-47ef-5138-08d7799f8228
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 16:23:48.8254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lC66OtNVo6D9u/Dn+9vZslwZCSwSSog2aELvwJvpsfwUpb9rooKPkxAvj6jtdbovUswubIl6HJrMb0OR4Hmn2V4u9ZxZUmGWpraO1ZRu8A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4373
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.105
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMTEuMjAxOSAyMjo0MiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IGZpdF9sb2FkX2Zk
dCgpIHJlY292ZXJzIGZyb20gZml0X2ltYWdlX2FkZHIoKSBmYWlsaW5nIHdpdGggRU5PRU5ULg0K
PiBFeGNlcHQgaXQgZG9lc24ndCB3aGVuIGl0cyBAZXJycCBhcmd1bWVudCBpcyAmZXJyb3JfZmF0
YWwgb3INCj4gJmVycm9yX2Fib3J0LCBiZWNhdXNlIGl0IGJsaW5kbHkgcGFzc2VzIEBlcnJwIHRv
IGZpdF9pbWFnZV9hZGRyKCkuDQo+IE1lc3NlZCB1cCBpbiBjb21taXQgM2ViOTllZGI0OCAibG9h
ZGVyLWZpdDogV2VhbiBvZmYgZXJyb3JfcHJpbnRmKCkiLg0KPiANCj4gVGhlIGJ1ZyBjYW4ndCBi
aXRlIGFzIG5vIGNhbGxlciBhY3R1YWxseSBwYXNzZXMgJmVycm9yX2ZhdGFsIG9yDQo+ICZlcnJv
cl9hYm9ydC4gIEZpeCBpdCBhbnl3YXkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJt
YnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1l
bnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCkhtbSwgYWN0dWFs
bHkgaXQgbWFrZXMgbXkNCiJbUEFUQ0ggdjcgMDEvMjFdIGh3L2NvcmUvbG9hZGVyLWZpdDogZml4
IGZyZWVpbmcgZXJycCBpbiBmaXRfbG9hZF9mZHQiDQp1bm5lY2Vzc2FyeS4gSWYgeW91IHdhbnQg
eW91IG1heSBkcm9wIG15IDAxIChhcyBpdCBjb3ZlcnMgbGVzcyBwcm9ibGVtcyksDQphbmQgaW4g
dGhpcyBjYXNlIHlvdSBtYXkgbm90ZSBpbiB5b3VyIGNvdmVyIGxldHRlciwgdGhhdA0KZXJycCA9
IE5VTEwgaXMgYnJva2VuIGhlcmUgdG9vIChtYXkgYmUgbm9iYWR5IHBhc3MgaXQ/KSwNCmFuZCBu
b3JtYWwgZXJycCBpcyBoYW5kbGVkIHdyb25nLCBhcyAqZXJycCBkb2Vzbid0IHNldCB0byBOVUxM
IGFmdGVyDQplcnJvcl9mcmVlKCplcnJwKSAoc3RpbGwsIHRoZSBvbmx5IGNhbGxlciByZWx5IG9u
IHJldHVybiB2YWx1ZSBtb3JlIHRoYW4gb24NCmVyciwgc28gdGhlIHByb2JsZW0gY2FuJ3QgYmUg
dHJpZ2dlcmVkIHdpdGggY3VycmVudCBjb2RlKQ0KDQo+IC0tLQ0KPiAgIGh3L2NvcmUvbG9hZGVy
LWZpdC5jIHwgMTUgKysrKysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9jb3JlL2xvYWRl
ci1maXQuYyBiL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+IGluZGV4IDk1M2IxNmJjODIuLmM0NjU5
MjFiOGYgMTAwNjQ0DQo+IC0tLSBhL2h3L2NvcmUvbG9hZGVyLWZpdC5jDQo+ICsrKyBiL2h3L2Nv
cmUvbG9hZGVyLWZpdC5jDQo+IEBAIC0xNzgsMTEgKzE3OCwxMiBAQCBzdGF0aWMgaW50IGZpdF9s
b2FkX2ZkdChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBjb25zdCB2b2lkICppdGIsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGNmZywgdm9pZCAqb3BhcXVlLCBjb25zdCB2
b2lkICptYXRjaF9kYXRhLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBrZXJu
ZWxfZW5kLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiArICAgIEVycm9yICplcnIgPSBOVUxMOw0K
PiAgICAgICBjb25zdCBjaGFyICpuYW1lOw0KPiAgICAgICBjb25zdCB2b2lkICpkYXRhOw0KPiAg
ICAgICBjb25zdCB2b2lkICpsb2FkX2RhdGE7DQo+ICAgICAgIGh3YWRkciBsb2FkX2FkZHI7DQo+
IC0gICAgaW50IGltZ19vZmYsIGVycjsNCj4gKyAgICBpbnQgaW1nX29mZjsNCj4gICAgICAgc2l6
ZV90IHN6Ow0KPiAgICAgICBpbnQgcmV0Ow0KPiAgIA0KPiBAQCAtMTk3LDEzICsxOTgsMTMgQEAg
c3RhdGljIGludCBmaXRfbG9hZF9mZHQoY29uc3Qgc3RydWN0IGZpdF9sb2FkZXIgKmxkciwgY29u
c3Qgdm9pZCAqaXRiLA0KPiAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICAgICAgIH0NCj4g
ICANCj4gLSAgICBlcnIgPSBmaXRfaW1hZ2VfYWRkcihpdGIsIGltZ19vZmYsICJsb2FkIiwgJmxv
YWRfYWRkciwgZXJycCk7DQo+IC0gICAgaWYgKGVyciA9PSAtRU5PRU5UKSB7DQo+ICsgICAgcmV0
ID0gZml0X2ltYWdlX2FkZHIoaXRiLCBpbWdfb2ZmLCAibG9hZCIsICZsb2FkX2FkZHIsICZlcnIp
Ow0KPiArICAgIGlmIChyZXQgPT0gLUVOT0VOVCkgew0KPiAgICAgICAgICAgbG9hZF9hZGRyID0g
Uk9VTkRfVVAoa2VybmVsX2VuZCwgNjQgKiBLaUIpICsgKDEwICogTWlCKTsNCj4gLSAgICAgICAg
ZXJyb3JfZnJlZSgqZXJycCk7DQo+IC0gICAgfSBlbHNlIGlmIChlcnIpIHsNCj4gLSAgICAgICAg
ZXJyb3JfcHJlcGVuZChlcnJwLCAidW5hYmxlIHRvIHJlYWQgRkRUIGxvYWQgYWRkcmVzcyBmcm9t
IEZJVDogIik7DQo+IC0gICAgICAgIHJldCA9IGVycjsNCj4gKyAgICAgICAgZXJyb3JfZnJlZShl
cnIpOw0KPiArICAgIH0gZWxzZSBpZiAocmV0KSB7DQo+ICsgICAgICAgIGVycm9yX3Byb3BhZ2F0
ZV9wcmVwZW5kKGVycnAsIGVyciwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
InVuYWJsZSB0byByZWFkIEZEVCBsb2FkIGFkZHJlc3MgZnJvbSBGSVQ6ICIpOw0KPiAgICAgICAg
ICAgZ290byBvdXQ7DQo+ICAgICAgIH0NCj4gICANCj4gDQoNClNvIG11Y2ggYXR0ZW50aW9uIHRv
IHRoYXQgZnVuY3Rpb24gOikNCg0KSSdkIGFsc28gcHJvcG9zZSB0aGUgZm9sbG93aW5nOg0KDQpk
aWZmIC0tZ2l0IGEvaHcvY29yZS9sb2FkZXItZml0LmMgYi9ody9jb3JlL2xvYWRlci1maXQuYw0K
aW5kZXggYzQ2NTkyMWI4Zi4uMmM5ZWZlZWY3YSAxMDA2NDQNCi0tLSBhL2h3L2NvcmUvbG9hZGVy
LWZpdC5jDQorKysgYi9ody9jb3JlL2xvYWRlci1maXQuYw0KQEAgLTE4MCw4ICsxODAsOCBAQCBz
dGF0aWMgaW50IGZpdF9sb2FkX2ZkdChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBjb25z
dCB2b2lkICppdGIsDQogIHsNCiAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KICAgICAgY29uc3Qg
Y2hhciAqbmFtZTsNCi0gICAgY29uc3Qgdm9pZCAqZGF0YTsNCi0gICAgY29uc3Qgdm9pZCAqbG9h
ZF9kYXRhOw0KKyAgICB2b2lkICpkYXRhOw0KKyAgICB2b2lkICpsb2FkX2RhdGE7DQogICAgICBo
d2FkZHIgbG9hZF9hZGRyOw0KICAgICAgaW50IGltZ19vZmY7DQogICAgICBzaXplX3Qgc3o7DQpA
QCAtMjE4LDkgKzIxOCw5IEBAIHN0YXRpYyBpbnQgZml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBm
aXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0YiwNCg0KICAgICAgcmV0ID0gMDsNCiAgb3V0
Og0KLSAgICBnX2ZyZWUoKHZvaWQgKikgZGF0YSk7DQorICAgIGdfZnJlZShkYXRhKTsNCiAgICAg
IGlmIChkYXRhICE9IGxvYWRfZGF0YSkgew0KLSAgICAgICAgZ19mcmVlKCh2b2lkICopIGxvYWRf
ZGF0YSk7DQorICAgICAgICBnX2ZyZWUobG9hZF9kYXRhKTsNCiAgICAgIH0NCiAgICAgIHJldHVy
biByZXQ7DQogIH0NCg0KDQpPciwgZXZlbiBiZXR0ZXI6DQoNCi0tLSBhL2h3L2NvcmUvbG9hZGVy
LWZpdC5jDQorKysgYi9ody9jb3JlL2xvYWRlci1maXQuYw0KQEAgLTE4MCw3ICsxODAsOCBAQCBz
dGF0aWMgaW50IGZpdF9sb2FkX2ZkdChjb25zdCBzdHJ1Y3QgZml0X2xvYWRlciAqbGRyLCBjb25z
dCB2b2lkICppdGIsDQogIHsNCiAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KICAgICAgY29uc3Qg
Y2hhciAqbmFtZTsNCi0gICAgY29uc3Qgdm9pZCAqZGF0YTsNCisgICAgZ19hdXRvZnJlZSB2b2lk
ICpkYXRhID0gTlVMTDsNCisgICAgZ19hdXRvZnJlZSB2b2lkICpmZHRfZmlsdGVyX2RhdGEgPSBO
VUxMOw0KICAgICAgY29uc3Qgdm9pZCAqbG9hZF9kYXRhOw0KICAgICAgaHdhZGRyIGxvYWRfYWRk
cjsNCiAgICAgIGludCBpbWdfb2ZmOw0KQEAgLTIwMiwyNyArMjAzLDIzIEBAIHN0YXRpYyBpbnQg
Zml0X2xvYWRfZmR0KGNvbnN0IHN0cnVjdCBmaXRfbG9hZGVyICpsZHIsIGNvbnN0IHZvaWQgKml0
YiwNCiAgICAgIGlmIChyZXQgPT0gLUVOT0VOVCkgew0KICAgICAgICAgIGxvYWRfYWRkciA9IFJP
VU5EX1VQKGtlcm5lbF9lbmQsIDY0ICogS2lCKSArICgxMCAqIE1pQik7DQogICAgICAgICAgZXJy
b3JfZnJlZShlcnIpOw0KKyAgICAgICAgcmV0dXJuIDA7DQogICAgICB9IGVsc2UgaWYgKHJldCkg
ew0KICAgICAgICAgIGVycm9yX3Byb3BhZ2F0ZV9wcmVwZW5kKGVycnAsIGVyciwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAidW5hYmxlIHRvIHJlYWQgRkRUIGxvYWQgYWRkcmVz
cyBmcm9tIEZJVDogIik7DQotICAgICAgICBnb3RvIG91dDsNCisgICAgICAgIHJldHVybiByZXQ7
DQogICAgICB9DQoNCiAgICAgIGlmIChsZHItPmZkdF9maWx0ZXIpIHsNCi0gICAgICAgIGxvYWRf
ZGF0YSA9IGxkci0+ZmR0X2ZpbHRlcihvcGFxdWUsIGRhdGEsIG1hdGNoX2RhdGEsICZsb2FkX2Fk
ZHIpOw0KKyAgICAgICAgbG9hZF9kYXRhID0gZmR0X2ZpbHRlcl9kYXRhID0NCisgICAgICAgICAg
ICAgICAgbGRyLT5mZHRfZmlsdGVyKG9wYXF1ZSwgZGF0YSwgbWF0Y2hfZGF0YSwgJmxvYWRfYWRk
cik7DQogICAgICB9DQoNCiAgICAgIGxvYWRfYWRkciA9IGxkci0+YWRkcl90b19waHlzKG9wYXF1
ZSwgbG9hZF9hZGRyKTsNCiAgICAgIHN6ID0gZmR0X3RvdGFsc2l6ZShsb2FkX2RhdGEpOw0KICAg
ICAgcm9tX2FkZF9ibG9iX2ZpeGVkKG5hbWUsIGxvYWRfZGF0YSwgc3osIGxvYWRfYWRkcik7DQoN
Ci0gICAgcmV0ID0gMDsNCi1vdXQ6DQotICAgIGdfZnJlZSgodm9pZCAqKSBkYXRhKTsNCi0gICAg
aWYgKGRhdGEgIT0gbG9hZF9kYXRhKSB7DQotICAgICAgICBnX2ZyZWUoKHZvaWQgKikgbG9hZF9k
YXRhKTsNCi0gICAgfQ0KLSAgICByZXR1cm4gcmV0Ow0KKyAgICByZXR1cm4gMDsNCiAgfQ0KDQoN
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


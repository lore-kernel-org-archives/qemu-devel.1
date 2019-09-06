Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE54EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA162082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 12:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AbZfyqxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA162082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Dmj-0007y0-Mh
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 08:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i6DiF-0002mD-93
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i6DiD-0000es-Dw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 08:51:39 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:24555 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i6Dhy-0000Uu-Ud; Fri, 06 Sep 2019 08:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIozBdR3EtCDwKLSxcMQxrXN2ZKjuzbgO0J99oyfkgKIRPJO/zCaIi6RR/7BAAxNjATjp4/PHLHS0cSbGfLgxdhaP7WS15MlDV9Pi0buLWRSKRt9l8lHAn/mI91LNT1mScE489SvlvxGWKqnEe4HSoBd/t4JdAfqx+1kS/nuYk+UJIarLycAm4YfITTDKe5P7Y9b3ZstjsoTqSJqN+o3Ekjyu/k+OL8APKUgxO7hhoLBSYg/dtyg7+WQsKuWQkTKlTNI60aUDjr1+Oi5UE1p818JX64Ff0CYUJ/WbO/1VpV96XpVrXV19eeCalTgXi6WcQwiJ8CbiUmziZLVtXGOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZcyejOtJsN2zi9tazp6HHmhvLrbJbi6inRUWEVhkro=;
 b=U07oyJGSEvM9t6sO0D9/+QO3Ncg0+pWFIBDMzrtvHRO/2g9McaXkyFFfSxuRprWm1SmCMejSyiQduD2s/06uETDhaVENsjiiUS5QAu9nX9uaOvNveqlan3mMABP60N67fQlZbGVvn5um/vwOLLmNyKrZfL7d6lhBZvfZsXW386IIzJogmCm59mkJqEN4vyCVbg2VQXMxsTCBwapYBt4J+q5fCMK07c9hfNHfzUBjpKdtjtxBpB6mwF9KrmbyOduy62TnJL8eNNs1VaU+6q/KRozyJ77sUWUgclj6XXq7WksC2pigTE6gN7XW/0KnEDoT1DhZBe3IVloF60BnqoN57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZcyejOtJsN2zi9tazp6HHmhvLrbJbi6inRUWEVhkro=;
 b=AbZfyqxtMgOUDB/9zqwutue53+J9jAMWq2brGawy4AtNcL4yG+7fzO7f3GTtdzZtzNUYZiTT61PkOecL+w1LrS9KJa7mzvxEOYRIMelHx5P3d5sOlsJOziFzeDu/+1B2n4n1l2c8Kyon8yaORwD4fZijxWiz8JPH7Cktdhkc3+o=
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com (52.134.95.154) by
 AM0PR08MB4225.eurprd08.prod.outlook.com (20.179.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Fri, 6 Sep 2019 12:51:18 +0000
Received: from AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51]) by AM0PR08MB3027.eurprd08.prod.outlook.com
 ([fe80::19a3:6903:45eb:bf51%6]) with mapi id 15.20.2241.018; Fri, 6 Sep 2019
 12:51:18 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PULL 4/9] block: workaround for unaligned byte range in
 fallocate()
Thread-Index: AQHVZBbHNBGdACRYaEOOLBH7AqLtB6cem10A
Date: Fri, 6 Sep 2019 12:51:18 +0000
Message-ID: <1e5fb4a0-f6f8-5720-8de5-3bcd18f6de80@virtuozzo.com>
References: <20190905182132.3563-1-eblake@redhat.com>
 <20190905182132.3563-5-eblake@redhat.com>
In-Reply-To: <20190905182132.3563-5-eblake@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0023.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::33) To AM0PR08MB3027.eurprd08.prod.outlook.com
 (2603:10a6:208:61::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a209b5-deed-459f-59e6-08d732c8e93f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB4225; 
x-ms-traffictypediagnostic: AM0PR08MB4225:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB4225EC27830C0D392157924AF4BA0@AM0PR08MB4225.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:119;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39850400004)(136003)(396003)(189003)(199004)(316002)(2501003)(6116002)(76176011)(102836004)(229853002)(6486002)(6506007)(53546011)(71200400001)(86362001)(305945005)(31696002)(386003)(6512007)(71190400001)(3846002)(110136005)(7736002)(54906003)(66446008)(64756008)(66556008)(66476007)(5660300002)(44832011)(66946007)(66066001)(25786009)(486006)(4326008)(52116002)(81156014)(99286004)(6246003)(14454004)(53936002)(2906002)(31686004)(8676002)(478600001)(81166006)(26005)(186003)(36756003)(476003)(6436002)(14444005)(11346002)(446003)(2616005)(256004)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4225;
 H:AM0PR08MB3027.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mvsY/7aLB/vhc5nkegsjiDRs1vUNzsY3WEa7+1VHMZ1RNreHhuwrfegcmoyK/LW2ezmbsCKBMaKHQZkEX/54XP3rd5PT3oDOH25MImEvorLtTBhlOxVC5wdt4iDPU3fz6viDD2PV93KoJaZlPbMlpXPbgG7Eu2VBlvnQKypGcOVtzq0sqxH0qvmSyEIuRl98larBPjIuG/wKrTewE9YI/yrFSNepEOiai+lKlz4FQUOVKhIxMaZvwowRJWw73S/YEC1P2h28wxZCd3exB2xIryL+Nyvgy7n0UKidoQd2z5aa6C97eQkTsxowgmCnZRO4MGGdaBI1k0J906Rkbi4vOMJCUMPJcq1PlpwaearAZBxG9y3A5JHqKSnRpVJv/b+lW1g/BIZb3BOGHFF3NGdoRpmLYctnbMZncZ7ZHYoDM/Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC71A5D520452B4D92C661AFD5400194@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a209b5-deed-459f-59e6-08d732c8e93f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 12:51:18.7663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntHyIxg0Irs4ynRjxOuZkdldCprpMafknZWiuXoBu2e+sbdvfbO2NEQS7z57DG5bLDP6X+BNYSfxjqwn1tO6cyYuRrzVCNHzpqULQhLt5zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4225
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.97
Subject: Re: [Qemu-devel] [PULL 4/9] block: workaround for unaligned byte
 range in fallocate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "open list:raw" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TWFueSB0aGFua3MNCg0KQW5kcmV5DQoNCk9uIDA1LzA5LzIwMTkgMjE6MjEsIEVyaWMgQmxha2Ug
d3JvdGU6DQo+IEZyb206IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0
dW96em8uY29tPg0KPiANCj4gUmV2ZXJ0IHRoZSBjb21taXQgMTE4Zjk5NDQyZCAnYmxvY2svaW8u
YzogZml4IGZvciB0aGUgYWxsb2NhdGlvbiBmYWlsdXJlJw0KPiBhbmQgdXNlIGJldHRlciBlcnJv
ciBoYW5kbGluZyBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQgZG8gbm90IHN1cHBvcnQNCj4gZmFsbG9j
YXRlKCkgZm9yIGFuIHVuYWxpZ25lZCBieXRlIHJhbmdlLiBBbGxvdyBmYWxsaW5nIGJhY2sgdG8g
cHdyaXRlDQo+IGluIGNhc2UgZmFsbG9jYXRlKCkgcmV0dXJucyBFSU5WQUwuDQo+IA0KPiBTdWdn
ZXN0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+IFN1Z2dlc3RlZC1ieTog
RXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBT
aGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPiBSZXZpZXdlZC1i
eTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBEZW5pcyBW
LiBMdW5ldiA8ZGVuQG9wZW52ei5vcmc+DQo+IE1lc3NhZ2UtSWQ6IDwxNTY2OTEzOTczLTE1NDkw
LTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGJs
b2NrL2lvLmMgICAgICAgICB8IDIgKy0NCj4gICBibG9jay9maWxlLXBvc2l4LmMgfCA3ICsrKysr
KysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2lvLmMgYi9ibG9jay9pby5jDQo+IGluZGV4IDBmYTEw
ODMxZWRiNy4uMTZhNTk4ZmQwODU3IDEwMDY0NA0KPiAtLS0gYS9ibG9jay9pby5jDQo+ICsrKyBi
L2Jsb2NrL2lvLmMNCj4gQEAgLTE3NDYsNyArMTc0Niw3IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5l
X2ZuIGJkcnZfY29fZG9fcHdyaXRlX3plcm9lcyhCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAg
ICAgICAgICAgICBhc3NlcnQoIWJzLT5zdXBwb3J0ZWRfemVyb19mbGFncyk7DQo+ICAgICAgICAg
ICB9DQo+IA0KPiAtICAgICAgICBpZiAocmV0IDwgMCAmJiAhKGZsYWdzICYgQkRSVl9SRVFfTk9f
RkFMTEJBQ0spKSB7DQo+ICsgICAgICAgIGlmIChyZXQgPT0gLUVOT1RTVVAgJiYgIShmbGFncyAm
IEJEUlZfUkVRX05PX0ZBTExCQUNLKSkgew0KPiAgICAgICAgICAgICAgIC8qIEZhbGwgYmFjayB0
byBib3VuY2UgYnVmZmVyIGlmIHdyaXRlIHplcm9lcyBpcyB1bnN1cHBvcnRlZCAqLw0KPiAgICAg
ICAgICAgICAgIEJkcnZSZXF1ZXN0RmxhZ3Mgd3JpdGVfZmxhZ3MgPSBmbGFncyAmIH5CRFJWX1JF
UV9aRVJPX1dSSVRFOw0KPiANCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2ZpbGUtcG9zaXguYyBiL2Js
b2NrL2ZpbGUtcG9zaXguYw0KPiBpbmRleCA3MWYxNjhlZTJmMTMuLjg3YzVhNGNjYmRjOCAxMDA2
NDQNCj4gLS0tIGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+ICsrKyBiL2Jsb2NrL2ZpbGUtcG9zaXgu
Yw0KPiBAQCAtMTU4OCw2ICsxNTg4LDEzIEBAIHN0YXRpYyBpbnQgaGFuZGxlX2Fpb2NiX3dyaXRl
X3plcm9lcyh2b2lkICpvcGFxdWUpDQo+ICAgICAgIGlmIChzLT5oYXNfd3JpdGVfemVyb2VzKSB7
DQo+ICAgICAgICAgICBpbnQgcmV0ID0gZG9fZmFsbG9jYXRlKHMtPmZkLCBGQUxMT0NfRkxfWkVS
T19SQU5HRSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWlvY2ItPmFpb19v
ZmZzZXQsIGFpb2NiLT5haW9fbmJ5dGVzKTsNCj4gKyAgICAgICAgaWYgKHJldCA9PSAtRUlOVkFM
KSB7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICogQWxsb3cgZmFsbGluZyBi
YWNrIHRvIHB3cml0ZSBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQNCj4gKyAgICAgICAgICAgICAqIGRv
IG5vdCBzdXBwb3J0IGZhbGxvY2F0ZSgpIGZvciBhbiB1bmFsaWduZWQgYnl0ZSByYW5nZS4NCj4g
KyAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPiArICAg
ICAgICB9DQo+ICAgICAgICAgICBpZiAocmV0ID09IDAgfHwgcmV0ICE9IC1FTk9UU1VQKSB7DQo+
ICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgICAgIH0NCj4gDQoNCi0tIA0KV2l0
aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==


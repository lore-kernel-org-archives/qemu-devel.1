Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CCDC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F3220674
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VzFeXLdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F3220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU5rJ-0000MA-Rr
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 04:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iU5qd-0008AA-IN
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iU5qc-0007od-E1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:18:59 -0500
Received: from mail-eopbgr00132.outbound.protection.outlook.com
 ([40.107.0.132]:10537 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iU5qV-0007ky-GV; Mon, 11 Nov 2019 04:18:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nivJ8DvnmOb2sEWYUgvnNMPyXq0P8UUMQVuOjYfmyPBIAHPqEm+rJpMo1g6s8G6WqcbFbd28aLIIGm64ICNhNTIdqn9HKgyX0N/vB/ERX4ZYCBGVhAgIOSt+U8nrHRN+dGRdYaQrM8THfiHjy2Tjo25/r39D6Gsn2DEKfzFudJC5y2LG379pbRqPia7X5DitkWgbjbdbmqSVbQ2nWjbVqtzfO48P2RdgLzJK16dttLHExfprrQqWYPib0sSMlM5OmKFt9rzV+W3R1oIk2grTBiE9JHRdwvCN5b3ULhXBVJoOf1LSyHYrXhHvkHP7SAxsqRqfZcMwsYgao0vA6jldPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rejmKzCMwhl2zUdE26IWqnIVQwzKhgHRk7minzg1LA0=;
 b=kCu/ssC2kuIjLtLqkIl0Q2HfLZgOlBB/dt0v3NVz1fQf8yBeMeHteehCC/Pmz88bKteRBWfK2UxFXBfZ1mpsMcHJ45NTGycM6Lz9EoDSBZ2VE3nGMhQaAsJDYlXLNXcvcLLbcNh/IYCQABVR+XvJkCQXxjX87aIkngCBb7Vem96wpsT3hQmJFBiku/QDh4S5bSStfD+pFKwdzwte5RQ2E6Nndbgj5pXdRT06jEZbnBJ3rcbBex/nex1i7Q6rTvu96OgW3BpLpbqQ6bV/sEBYwLmQRoThlFxPA0/z9+A+7IGSotj0AoXI89nttw2sawIAT+4iPVh7rWVqROLpmqrvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rejmKzCMwhl2zUdE26IWqnIVQwzKhgHRk7minzg1LA0=;
 b=VzFeXLdKMxA6NWtI8jNJXVqE2Pan+sTmjJubTBv1/i4xmAHqwjARoiT0SwcBs+8ZJuU4x+DiB1ckdd62bg9VQFyOLznlfGvujea+yIfYjGWvp1vYZrZxVn6wRn61/uGA1pUMqFIA60SOED/uScolxiCaFkhjogcBgIX4kAdEd6U=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2935.eurprd08.prod.outlook.com (10.170.223.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 09:18:48 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::a1ee:668f:c3a5:87b%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 09:18:48 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Roman Kagan <rkagan@virtuozzo.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3] iotests: Test NBD client reconnection
Thread-Topic: [PATCH v3] iotests: Test NBD client reconnection
Thread-Index: AQHVkNUT+UXL9a7TY0mxwK9P+v9TvaeBVR0AgAAEYoCABGbgAA==
Date: Mon, 11 Nov 2019 09:18:48 +0000
Message-ID: <55df73cb-ffe8-e4c6-b97a-346bdf28f1e2@virtuozzo.com>
References: <1572627272-23359-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <feb2b810-3436-6550-43b2-a07ec1fc5280@virtuozzo.com>
 <20191108140527.GA63895@rkaganb.sw.ru>
In-Reply-To: <20191108140527.GA63895@rkaganb.sw.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0007.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::17) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc440166-9c26-4253-684f-08d7668828f9
x-ms-traffictypediagnostic: DB6PR08MB2935:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR08MB2935130BF37A05E6DBE09469F4740@DB6PR08MB2935.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39840400004)(346002)(366004)(136003)(189003)(199004)(66446008)(86362001)(446003)(64756008)(256004)(11346002)(66556008)(14444005)(6436002)(6116002)(3846002)(66476007)(25786009)(31696002)(102836004)(99286004)(2906002)(229853002)(386003)(6506007)(316002)(52116002)(53546011)(76176011)(6486002)(54906003)(71190400001)(71200400001)(110136005)(186003)(66946007)(5660300002)(6246003)(7736002)(36756003)(6512007)(476003)(6306002)(966005)(26005)(31686004)(14454004)(6636002)(8936002)(4326008)(8676002)(81156014)(81166006)(2616005)(478600001)(66066001)(486006)(44832011)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2935;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Oylj1/VRpWG93pXwDoAvcgUL8Gg2YJvAztiQBklhxrA7ym2KvSCnpN2K5ZLFcgjLPirvj58E7cla9BC1UWJ8D5jGP73x1U2zj3vx8KXizoy2EdNmkbtisMlsjXYRdyd4rWJjxpnxW6ZIde1fRDPZt3qzoznfp9oVsGwiEzQyrCmKOThklTNrKwim7iMqg0U0Uwm+fGqbignXWCrkjdsZjktjcgAllT2Y8gtLtdeDu71EcUkPE5zj8mZS5nEaMKs4Ej6gxmHd+1OHPOF8Q1bNc+M+oQzd92J465GcE3bVagDHT0MFJr5ThJPcFC1U0YUuwHbOBqtBPNW5pNJIxAkl5Y0mbd/YzKrI9DIpWnPcKlVsYRU3t7S65KTKHz5T0vOvT4okhSPGIlMC6WCNSqqk5TN25zjZS8ncxPmWHenLpjbVaziozFYFcMQdnfSZXtUYgX9Jk+u4uJkxgAdeTegmMQ90PydrIqK2qhWM4sokq4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9560A569FA7AF946A3EF8D2923B8887D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc440166-9c26-4253-684f-08d7668828f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 09:18:48.7155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6Soanlwl005KHdbsBvO/0kH1EZA2Xpu9RgYDlU8Aa3lT9e0kCPG5iAfVLoeO/dqYdsocSS2WkrpzhWVtbbyii0Tr203LyVZbGpgx3GU/MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2935
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.132
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDA4LzExLzIwMTkgMTc6MDUsIFJvbWFuIEthZ2FuIHdyb3RlOg0KPiBPbiBGcmksIE5v
diAwOCwgMjAxOSBhdCAwMTo0OTo1MFBNICswMDAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IHdyb3RlOg0KPj4gMDEuMTEuMjAxOSAxOTo1NCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6
DQo+Pj4gK2RlZiBjaGVja19wcm9jX05CRChwcm9jLCBjb25uZWN0b3IpOg0KPj4+ICsgICAgdHJ5
Og0KPj4+ICsgICAgICAgIGV4aXRjb2RlID0gcHJvYy53YWl0KHRpbWVvdXQ9MTApDQo+Pj4gKw0K
Pj4+ICsgICAgICAgIGlmIGV4aXRjb2RlIDwgMDoNCj4+PiArICAgICAgICAgICAgbG9nKCdOQkQg
e306IEVYSVQgU0lHTkFMIHt9XG4nLmZvcm1hdChjb25uZWN0b3IsIC1leGl0Y29kZSkpDQo+Pj4g
KyAgICAgICAgICAgIGxvZyhwcm9jLmNvbW11bmljYXRlKClbMF0pDQo+Pj4gKyAgICAgICAgZWxz
ZToNCj4+PiArICAgICAgICAgICAgbGluZSA9IHByb2Muc3Rkb3V0LnJlYWRsaW5lKCkNCj4+DQo+
Pg0KPj4gY291bGQgd2UgdXNlIHByb2MuY29tbXVuaWNhdGUoKSBmb3IgYm90aCBjYXNlcywgd2hh
dCBpcyB0aGUgZGlmZmVyZW5jZT8NCj4gDQo+IEluIGZhY3QgaWYgcHJvYyBwcm9kdWNlcyBhbnkg
bm9uLXRyaXZpYWwgYW1vdW50IG9mIG91dHB1dCB5b3UgYXJlIGJldHRlcg0KPiBvZmYgdXNpbmcg
LmNvbW11bmljYXRlKCkgb3RoZXJ3aXNlIHlvdXIgY2hpbGQgbWF5IGJsb2NrIG9uIG91dHB1dCBh
bmQNCj4gbmV2ZXIgZXhpdC4gIFNlZQ0KPiBodHRwczovL2RvY3MucHl0aG9uLm9yZy8zL2xpYnJh
cnkvc3VicHJvY2Vzcy5odG1sI3N1YnByb2Nlc3MuUG9wZW4uY29tbXVuaWNhdGUNCj4gZm9yIGhv
dyB0byBleHByZXNzIHRoZSBhYm92ZSBsb2dpYyBjb3JyZWN0bHkuICBUaGUgZXhpdCBjb2RlICph
ZnRlcioNCj4gLmNvbW11bmljYXRlIGlzIGF2YWlsYWJsZSBpbiAucmV0dXJuY29kZS4NCj4gDQoN
ClRoZSBwYXR0ZXJuIGJ5IHRoZSBsaW5rIGFib3ZlIGRvZXMgbm90IHdvcmsgKFB5dGhvbjMpOg0K
DQpwcm9jID0gc3VicHJvY2Vzcy5Qb3BlbiguLi4pDQp0cnk6DQogICAgIG91dHMsIGVycnMgPSBw
cm9jLmNvbW11bmljYXRlKHRpbWVvdXQ9MTUpDQpleGNlcHQgVGltZW91dEV4cGlyZWQ6DQogICAg
IHByb2Mua2lsbCgpDQogICAgIG91dHMsIGVycnMgPSBwcm9jLmNvbW11bmljYXRlKCkNCg0KYXMg
J3Byb2MnIGNhbm5vdCBiZSB1c2VkIGZvciBvdXRwdXQgYWZ0ZXIgYmVpbmcga2lsbGVkLiBJdCBy
ZXN1bHRzIGluIA0KYW5vdGhlciBleGNlcHRpb24gYmVpbmcgcmFpc2VkLg0KDQpBbmRyZXkNCg0K
Pj4NCj4+PiArICAgICAgICAgICAgbG9nKCdOQkQge306IHt9Jy5mb3JtYXQoY29ubmVjdG9yLCBs
aW5lLnJzdHJpcCgpKSkNCj4+PiArDQo+Pj4gKyAgICBleGNlcHQgc3VicHJvY2Vzcy5UaW1lb3V0
RXhwaXJlZDoNCj4+PiArICAgICAgICBwcm9jLmtpbGwoKQ0KPj4+ICsgICAgICAgIGxvZygnTkJE
IHt9OiBFUlJPUiB0aW1lb3V0IGV4cGlyZWQnLmZvcm1hdChjb25uZWN0b3IpKQ0KPj4+ICsgICAg
ZmluYWxseToNCj4+PiArICAgICAgICBpZiBjb25uZWN0b3IgPT0gJ3NlcnZlcic6DQo+Pj4gKyAg
ICAgICAgICAgIG9zLnJlbW92ZShuYmRfc29jaykNCj4+PiArICAgICAgICAgICAgb3MucmVtb3Zl
KGNvbmZfZmlsZSkNCj4gDQo+IFJvbWFuLg0KPiANCg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2Fy
ZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K


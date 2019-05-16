Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77693C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E98420657
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BNReynL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRIQ4-0002zP-9g
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:35:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRIP8-0002Yv-5z
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRIP7-0007bl-4G
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:34:46 -0400
Received: from mail-eopbgr00139.outbound.protection.outlook.com
	([40.107.0.139]:46658
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRIP6-0007aP-IC; Thu, 16 May 2019 11:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=m1Cn9eO+llH2k9Fh4dyndEGNROqxeiaQ4tzjBLL1pnc=;
	b=BNReynL/B8Be8uwRTeDpMVNAYGJluPtaQ5RmwLh8NuQnTiu1IMzgHHqA8ZZVEDFAWtm1PJeqC9mlIR0JDRuvHWLZqo+Oj2tS1xN5rEHqFhuBztALlDIHtTDXpgc2mVFGhoXBSLHFy26RP5vuV5ezBv1PbU0TNz/8TXpWUm9U3kc=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB3335.eurprd08.prod.outlook.com (52.135.165.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.25; Thu, 16 May 2019 15:34:41 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Thu, 16 May 2019 15:34:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 3/9] block: add empty account cookie type
Thread-Index: AQHVC/RUE5By577twEaJVdGvp1HqIKZt4dUA
Date: Thu, 16 May 2019 15:34:41 +0000
Message-ID: <7618e582-195b-56c4-7525-d166d7d0e40b@virtuozzo.com>
References: <20190516143314.81302-1-anton.nefedov@virtuozzo.com>
	<20190516143314.81302-4-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516143314.81302-4-anton.nefedov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::19)
	To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190516183438816
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af233c1a-8d75-4945-461d-08d6da14034c
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB3335; 
x-ms-traffictypediagnostic: AM6PR08MB3335:
x-microsoft-antispam-prvs: <AM6PR08MB33350D9488A3D75FB2A33679C10A0@AM6PR08MB3335.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(346002)(376002)(396003)(136003)(199004)(189003)(4326008)(305945005)(31686004)(7736002)(386003)(6506007)(25786009)(6116002)(3846002)(6246003)(102836004)(66946007)(64756008)(229853002)(73956011)(66476007)(66556008)(66446008)(478600001)(66066001)(14454004)(36756003)(71200400001)(71190400001)(2501003)(15650500001)(486006)(2616005)(476003)(446003)(316002)(54906003)(256004)(11346002)(110136005)(76176011)(26005)(99286004)(8676002)(53936002)(14444005)(6436002)(81166006)(81156014)(186003)(6486002)(5660300002)(52116002)(6512007)(31696002)(8936002)(86362001)(2906002)(68736007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3335;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sIlwmZTD3fyo10IB7BBr7TOaUrIJ82zOn/SvT6apgrErRved+PPrlF4zZeqMWECF250K+vP3vsQatZ28/3OiWML5Jh+SpqTbwy98q3faqUqDpuTvbCi8k8sUYBO8vM5LYSGb2C89IQJX1nhlG5gALMU8fE0h90Y1xu8OW9y1fprhGl/mpGEQsehhgmRSjf74fvIi5HCFTfO6Ox+YhYFcrxBtfuISpq9Ve3GgmG+NXCi7uiCfDGa0gE2bsIZBcSafvNEdXXL1eohVPh6BMHYpo/o9fPHeIuELsDJ0OTWMkPuxK2YD97WX9RFs6770jpI6LEcM6Ven39hiD6qkFCMhkMTgbRBNsaTqTRf0z3dGA9eG/EfWZIsdmb2/A1dI/3rMpGRVTWYgPBu2VephvVz1L0oOPdCEr8ory2rs6sRnirg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <935FB97F9559C04C9429853098DEFBC0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af233c1a-8d75-4945-461d-08d6da14034c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 15:34:41.1643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3335
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.139
Subject: Re: [Qemu-devel] [PATCH v8 3/9] block: add empty account cookie type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDUuMjAxOSAxNzozMywgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gVGhpcyBhZGRzIHNvbWUg
cHJvdGVjdGlvbiBmcm9tIGFjY291bnRpbmcgdW5pbml0aWFsaXplZCBjb29raWUuDQo+IFRoYXQg
aXMsIGJsb2NrX2FjY3RfZmFpbGVkL2RvbmUgd2l0aG91dCBwcmV2aW91cyBibG9ja19hY2N0X3N0
YXJ0Ow0KPiBpbiB0aGF0IGNhc2UsIGNvb2tpZSBwcm9iYWJseSBob2xkcyB2YWx1ZXMgZnJvbSBw
cmV2aW91cyBvcGVyYXRpb24uDQo+IA0KPiAoTm90ZTogaXQgbWlnaHQgYWxzbyBiZSB1bmluaXRp
YWxpemVkIGhvbGRpbmcgZ2FyYmFnZSB2YWx1ZSBhbmQgdGhlcmUgaXMNCj4gICBzdGlsbCAiPCBC
TE9DS19NQVhfSU9UWVBFIiBhc3NlcnRpb24gZm9yIHRoYXQuDQo+ICAgU28gYmxvY2tfYWNjdF9m
YWlsZWQvZG9uZSB3aXRob3V0IHByZXZpb3VzIGJsb2NrX2FjY3Rfc3RhcnQgc2hvdWxkIGJlIHVz
ZWQNCj4gICB3aXRoIGNhdXRpb24uKQ0KPiANCj4gQ3VycmVudGx5IHRoaXMgaXMgcGFydGljdWxh
cmx5IHVzZWZ1bCBpbiBpZGUgY29kZSB3aGVyZSBpdCdzIGhhcmQgdG8NCj4ga2VlcCB0cmFjayB3
aGV0aGVyIHRoZSByZXF1ZXN0IHN0YXJ0ZWQgYWNjb3VudGluZyBvciBub3QuIEZvciBleGFtcGxl
LA0KPiB0cmltIHJlcXVlc3RzIGRvIHRoZSBhY2NvdW50aW5nIHNlcGFyYXRlbHkuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZlZG92QHZpcnR1b3p6by5jb20+
DQo+IC0tLQ0KPiAgIGluY2x1ZGUvYmxvY2svYWNjb3VudGluZy5oIHwgMSArDQo+ICAgYmxvY2sv
YWNjb3VudGluZy5jICAgICAgICAgfCA2ICsrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9hY2NvdW50aW5n
LmggYi9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaA0KPiBpbmRleCBiYThiMDRkNTcyLi44Nzhi
NGMzNTgxIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaA0KPiArKysg
Yi9pbmNsdWRlL2Jsb2NrL2FjY291bnRpbmcuaA0KPiBAQCAtMzMsNiArMzMsNyBAQCB0eXBlZGVm
IHN0cnVjdCBCbG9ja0FjY3RUaW1lZFN0YXRzIEJsb2NrQWNjdFRpbWVkU3RhdHM7DQo+ICAgdHlw
ZWRlZiBzdHJ1Y3QgQmxvY2tBY2N0U3RhdHMgQmxvY2tBY2N0U3RhdHM7DQo+ICAgDQo+ICAgZW51
bSBCbG9ja0FjY3RUeXBlIHsNCj4gKyAgICBCTE9DS19BQ0NUX05PTkUgPSAwLA0KPiAgICAgICBC
TE9DS19BQ0NUX1JFQUQsDQo+ICAgICAgIEJMT0NLX0FDQ1RfV1JJVEUsDQo+ICAgICAgIEJMT0NL
X0FDQ1RfRkxVU0gsDQo+IGRpZmYgLS1naXQgYS9ibG9jay9hY2NvdW50aW5nLmMgYi9ibG9jay9h
Y2NvdW50aW5nLmMNCj4gaW5kZXggNzBhM2Q5YTQyNi4uOGQ0MWM4YTgzYSAxMDA2NDQNCj4gLS0t
IGEvYmxvY2svYWNjb3VudGluZy5jDQo+ICsrKyBiL2Jsb2NrL2FjY291bnRpbmcuYw0KPiBAQCAt
MTk1LDYgKzE5NSwxMCBAQCBzdGF0aWMgdm9pZCBibG9ja19hY2NvdW50X29uZV9pbyhCbG9ja0Fj
Y3RTdGF0cyAqc3RhdHMsIEJsb2NrQWNjdENvb2tpZSAqY29va2llLA0KPiAgIA0KPiAgICAgICBh
c3NlcnQoY29va2llLT50eXBlIDwgQkxPQ0tfTUFYX0lPVFlQRSk7DQo+ICAgDQo+ICsgICAgaWYg
KGNvb2tpZS0+dHlwZSA9PSBCTE9DS19BQ0NUX05PTkUpIHsNCg0Kd29ydGggZXJyb3JfcmVwb3J0
KCkgPw0KDQo+ICsgICAgICAgIHJldHVybjsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgcWVtdV9t
dXRleF9sb2NrKCZzdGF0cy0+bG9jayk7DQo+ICAgDQo+ICAgICAgIGlmIChmYWlsZWQpIHsNCj4g
QEAgLTIxNyw2ICsyMjEsOCBAQCBzdGF0aWMgdm9pZCBibG9ja19hY2NvdW50X29uZV9pbyhCbG9j
a0FjY3RTdGF0cyAqc3RhdHMsIEJsb2NrQWNjdENvb2tpZSAqY29va2llLA0KPiAgICAgICB9DQo+
ICAgDQo+ICAgICAgIHFlbXVfbXV0ZXhfdW5sb2NrKCZzdGF0cy0+bG9jayk7DQo+ICsNCj4gKyAg
ICBjb29raWUtPnR5cGUgPSBCTE9DS19BQ0NUX05PTkU7DQo+ICAgfQ0KPiAgIA0KPiAgIHZvaWQg
YmxvY2tfYWNjdF9kb25lKEJsb2NrQWNjdFN0YXRzICpzdGF0cywgQmxvY2tBY2N0Q29va2llICpj
b29raWUpDQo+IA0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=


Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8AEC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0879720840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="p+5eOEcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0879720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVX6-00032m-Na
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxVWW-0002Qx-JH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxVWV-0002sW-Hb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:03:32 -0400
Received: from mail-ve1eur03on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::711]:34174
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hxVWV-0002rf-AE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM3e1ZUYc/KLVydgQlpHUq9viWX3dwyDEsJOkXJkKVWQoFYo0am2WldWeGt4/HF9hVB0R9blPF+z7CW36nvDBSVAkY1pl9TLjCOr6B0WFmFamriehM2qBfuV29dVfS2VLgR+HRNVJQXKegEaVumQfKTMWEX3ebCxxoBEXBzxciwlmi4hdmwOCKvrRnf/xK7xU9p6hDLLK9OtbJaXE7TQUjsWgLFynSe8zeiyaYp8MzlyeUXMjg0Tf1aAXAef5Whe9Ch2vyXV/e1EQAHySPhNOsb+/Ah4VoIZ4sZXq3kT0hXIz7VQNbsZHHwoo7lnvwR0d0/Aw9qraEBEYOj4SnvSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUgp8K1PE5512tpfYOPJ1GPzeB28nGiGszzVozTXZsA=;
 b=BzIZreyKs8pkI4pHFaYbzSKqDlpMaTOe2Am+TpIq/P5xgSXjiR2K7JOgNDkmsbiNzYxfpxLwt6fX24cw45XmqRhasbWz+gylEc1NVfRBz7/FWhNuCQ8+eSsxqRLXcmRu1z75mo0wl2p7VnUhnNbQ48dUpq5JHneU9LdEygw4MFAJ5lmCoUUEr54tx1Zz2pR1E3Thhfc5ALIayexzz02ZYh7X9EjPaueU+pasPRCLjOaRvCiPzRva8/mVoQOLZdn+sEvmDbvhhOlOQDwHowP1LWo+9Wx+HbyhJEuRJWBZ+xe9hXtqAWg3pmT7IpYuWtLWi2ayrbBDABlHJdUUWOnRIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUgp8K1PE5512tpfYOPJ1GPzeB28nGiGszzVozTXZsA=;
 b=p+5eOEcpUiATx5WmNoPmluZPiWtW55azvbD3IMrB2jhvo+HhJvpaCqeEeUHyuHkEm4gjgMC4xoIUHHvBF2guh3iiAdlxgqq2MddyW7SFu7KxIPxKRMBHifs752w3ykkuP1Fxggpk1p9pqxGp94Dfr9NptOpiimkb6XLQy5aGr/E=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4045.eurprd08.prod.outlook.com (20.178.127.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 12:03:29 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 12:03:29 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] Fix: fp-test uninitialized member floatX::exp
Thread-Index: AQHVRr9xspCki27n+kGlF3NZYO6Lkab5ELuA
Date: Tue, 13 Aug 2019 12:03:29 +0000
Message-ID: <573f907d-5016-60c1-c727-c5444a418e1b@virtuozzo.com>
References: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1564481593-776647-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0049.eurprd09.prod.outlook.com
 (2603:10a6:7:15::38) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e68d1edd-820b-4769-b1a0-08d71fe640fc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4045; 
x-ms-traffictypediagnostic: VI1PR08MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB4045196D50B5C11C4AF44C24F4D20@VI1PR08MB4045.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(53936002)(86362001)(66556008)(305945005)(66946007)(478600001)(31696002)(7736002)(81166006)(66476007)(64756008)(6246003)(107886003)(14454004)(66446008)(8676002)(5640700003)(256004)(36756003)(3846002)(81156014)(2906002)(71190400001)(71200400001)(31686004)(6116002)(4326008)(99286004)(6486002)(25786009)(6916009)(2351001)(76176011)(44832011)(2616005)(316002)(8936002)(476003)(229853002)(486006)(6512007)(5660300002)(2501003)(66066001)(11346002)(52116002)(6436002)(446003)(26005)(53546011)(6506007)(386003)(102836004)(186003)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4045;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EkE8XAMsdMDhbDSiLHzyObJC8L9btJEiUez6zS9mC97GtkXMTcz4JNLMMVNuSPhepdob4sGWiPqIaj241XELJfDpozsesqVlIgQpbLa4TxF9TGWebQzu16rq19uFm6ybGbXICSVbggHnAeSgm8BH1uGLIsTPr97XZBwHGeSa3B7QYXc2Syz9D6PcGDJSd5cLkEHTmk8oW1oCD6SkzspBM8xwxnp/Kb9VBMJWJlWsC2k6VnkBfI3R4x5TlmC4v+2apMTJp6Jnb3JOzG05sxXWZCnRvzsNu0AEXaFQYDAnV/8N0wtgOCwnbKwDFqq0V2blv65K+/sSUdrki1pcr90h2X62MwWa+NIWs6fLQRg+PoWHcr1ylprnruicdoLCXlz5mposHh6ew1UE/dv/T0lmABU88pWYQZt9tpRcO9z8NHk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A0D170D72053438B343EE7E9A9D831@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d1edd-820b-4769-b1a0-08d71fe640fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 12:03:29.1025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xneNF9N0gf4gOi//iRaLrtPbPtyHYgE2HkpQAhSxB28zm1dR466TRDU4vZuE2VNzUrV+MK8WNlNprq0GP26j0FbwLYT89TNHjQh9Ro+OpGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4045
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::711
Subject: Re: [Qemu-devel] [PATCH] Fix: fp-test uninitialized member
 floatX::exp
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
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "cota@braap.org" <cota@braap.org>,
 "jhauser@eecs.berkeley.edu" <jhauser@eecs.berkeley.edu>,
 Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UElOR0lORy4uLg0KDQpPbiAzMC8wNy8yMDE5IDEzOjEzLCBBbmRyZXkgU2hpbmtldmljaCB3cm90
ZToNCj4gTm90IGFsbCB0aGUgcGF0aHMgaW4gdGhlIGZ1bmN0aW9ucywgc3VjaCBhcyBmMTZUb0Zs
b2F0WCgpLCBpbml0aWFsaXplDQo+IHRoZSBtZW1iZXIgJ2V4cCcgb2YgdGhlIHN0cnVjdHVyZSBm
bG9hdFguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNo
aW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4gLS0tDQo+ICAgc291cmNlL3Nsb3dmbG9hdC5jIHwg
NCArKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYyBi
L3Rlc3RzL2ZwL2JlcmtlbGV5LXRlc3RmbG9hdC0zL3NvdXJjZS9zbG93ZmxvYXQuYw0KPiBpbmRl
eCA0ZTg0NjU2Li42ZTBmMGE2IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9mcC9iZXJrZWxleS10ZXN0
ZmxvYXQtMy9zb3VyY2Uvc2xvd2Zsb2F0LmMNCj4gKysrIGIvdGVzdHMvZnAvYmVya2VsZXktdGVz
dGZsb2F0LTMvc291cmNlL3Nsb3dmbG9hdC5jDQo+IEBAIC02MjMsNiArNjIzLDcgQEAgc3RhdGlj
IHZvaWQgZjE2VG9GbG9hdFgoIGZsb2F0MTZfdCBhLCBzdHJ1Y3QgZmxvYXRYICp4UHRyICkNCj4g
ICAgICAgeFB0ci0+aXNJbmYgPSBmYWxzZTsNCj4gICAgICAgeFB0ci0+aXNaZXJvID0gZmFsc2U7
DQo+ICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMCkgIT0gMCk7DQo+ICsgICAgeFB0
ci0+ZXhwID0gMDsNCj4gICAgICAgZXhwID0gdWlBPj4xMCAmIDB4MUY7DQo+ICAgICAgIHNpZzY0
ID0gdWlBICYgMHgwM0ZGOw0KPiAgICAgICBzaWc2NCA8PD0gNDU7DQo+IEBAIC03NTksNiArNzYw
LDcgQEAgc3RhdGljIHZvaWQgZjMyVG9GbG9hdFgoIGZsb2F0MzJfdCBhLCBzdHJ1Y3QgZmxvYXRY
ICp4UHRyICkNCj4gICAgICAgeFB0ci0+aXNJbmYgPSBmYWxzZTsNCj4gICAgICAgeFB0ci0+aXNa
ZXJvID0gZmFsc2U7DQo+ICAgICAgIHhQdHItPnNpZ24gPSAoKHVpQSAmIDB4ODAwMDAwMDApICE9
IDApOw0KPiArICAgIHhQdHItPmV4cCA9IDA7DQo+ICAgICAgIGV4cCA9IHVpQT4+MjMgJiAweEZG
Ow0KPiAgICAgICBzaWc2NCA9IHVpQSAmIDB4MDA3RkZGRkY7DQo+ICAgICAgIHNpZzY0IDw8PSAz
MjsNCj4gQEAgLTg5NSw2ICs4OTcsNyBAQCBzdGF0aWMgdm9pZCBmNjRUb0Zsb2F0WCggZmxvYXQ2
NF90IGEsIHN0cnVjdCBmbG9hdFggKnhQdHIgKQ0KPiAgICAgICB4UHRyLT5pc0luZiA9IGZhbHNl
Ow0KPiAgICAgICB4UHRyLT5pc1plcm8gPSBmYWxzZTsNCj4gICAgICAgeFB0ci0+c2lnbiA9ICgo
dWlBICYgVUlOVDY0X0MoIDB4ODAwMDAwMDAwMDAwMDAwMCApKSAhPSAwKTsNCj4gKyAgICB4UHRy
LT5leHAgPSAwOw0KPiAgICAgICBleHAgPSB1aUE+PjUyICYgMHg3RkY7DQo+ICAgICAgIHNpZzY0
ID0gdWlBICYgVUlOVDY0X0MoIDB4MDAwRkZGRkZGRkZGRkZGRiApOw0KPiAgICAgICBpZiAoIGV4
cCA9PSAweDdGRiApIHsNCj4gQEAgLTEyMjAsNiArMTIyMyw3IEBAIHN0YXRpYyB2b2lkIGYxMjhN
VG9GbG9hdFgoIGNvbnN0IGZsb2F0MTI4X3QgKmFQdHIsIHN0cnVjdCBmbG9hdFggKnhQdHIgKQ0K
PiAgICAgICB4UHRyLT5pc1plcm8gPSBmYWxzZTsNCj4gICAgICAgdWlBNjQgPSB1aUFQdHItPnY2
NDsNCj4gICAgICAgeFB0ci0+c2lnbiA9ICgodWlBNjQgJiBVSU5UNjRfQyggMHg4MDAwMDAwMDAw
MDAwMDAwICkpICE9IDApOw0KPiArICAgIHhQdHItPmV4cCA9IDA7DQo+ICAgICAgIGV4cCA9IHVp
QTY0Pj40OCAmIDB4N0ZGRjsNCj4gICAgICAgc2lnLnY2NCA9IHVpQTY0ICYgVUlOVDY0X0MoIDB4
MDAwMEZGRkZGRkZGRkZGRiApOw0KPiAgICAgICBzaWcudjAgID0gdWlBUHRyLT52MDsNCj4gDQoN
Ci0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==


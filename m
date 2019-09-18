Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343ADC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60E0207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kf+6Rnu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60E0207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeBd-0005wm-2V
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAd4b-0005rK-VU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAd4a-0001bk-DT
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:44:57 -0400
Received: from mail-eopbgr00128.outbound.protection.outlook.com
 ([40.107.0.128]:51816 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAd4W-0001Yx-J1; Wed, 18 Sep 2019 12:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLD1TCahOOt0Qdg8KLCiB5SfIZT82VcTz39NE6C7UsKcKwtZc4RUncEAEfTPYqiu22+rV8O/16y4ZHltnOemLIYZVzyoZpKK32bs46C27EDwZwoG3G97dWi2JABN/XnvI5nRsHIAVW8vK+X5KyPHIhKgwj90n9GbqrpZmPrMFTze3UViQ2k2+UaJIPXrHq2d+OYHbLc2q3iUMSHbftAvL4m8l+EbMoub2ilo7TJsehLMDFbvktmSafJD6s+Q7SGoyma6Id7Ku58zcIAUQIwrImnjaX3xwt4vNg36DaHZlv5UX7Rj7tfki5Nb+f403MIsMA5TrHxSxIvxAP1oB2NMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x79o1YqZbtA36oHlig53b3xwBxt5DU/OP/yf+ZWImA0=;
 b=bzxctwW/P6LcLLtj34OOnzOAhBSzk+jW+6T8o1iPg2mkg5aNlvAv3CR2q2rjCMPbYxZOSduDPDydjVO+fZhUNY0U4KSShK75jCkXPtTcn10DvgFOYdS+FlN5J36khilHakIuhrelVTIl+uEs/jieDRP2zdif36iIrLIf6rhID/hNkk3P35aQ9evPfHft02z1P0fwFu83KKbUrW5mW87EvUMC8ArAA2Errr6xua0CKGeH9QGqwYdRRN6NvgoVy8VSRjX4WragYrSXB52O9fp2ZY5SRdYl+lbHIv8QWfF2PWRDkTB6jTlCxy5WT6Eo+XNAC8L3WDjkvS7j2raMI3Y6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x79o1YqZbtA36oHlig53b3xwBxt5DU/OP/yf+ZWImA0=;
 b=Kf+6Rnu0+6DZhbnjbuSWq3caMiyGbW/ild9rjejE9ny5oHhxlBIcGI/nDXyenjjpFHY8nQYZU+0ZFGsZv2U+8X6XJq1gaOr2hnpEXo/+7swlDghoUfvsrjJK3ORHrKZUmJ30fy8fsRonQgEzTBh0ILWZLluXjC78RPJS0dV8UDE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4204.eurprd08.prod.outlook.com (20.179.12.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Wed, 18 Sep 2019 16:44:49 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 16:44:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
Thread-Index: AQHVaP+sHvXQg5mIX0qbfLdZwy5qOKcua+GAgAIQzoCAAMmFgIAAaI+A
Date: Wed, 18 Sep 2019 16:44:49 +0000
Message-ID: <8b13be25-1536-7890-6ff4-0eef2fa104d8@virtuozzo.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-2-jsnow@redhat.com>
 <974b64b8-a191-c529-4e77-6a38b372c4b8@virtuozzo.com>
 <e5d871da-c5e1-1a5e-4714-387cbc93a055@redhat.com>
 <66bdafc2-cbdb-8e41-d4c6-5142729ef7a9@virtuozzo.com>
In-Reply-To: <66bdafc2-cbdb-8e41-d4c6-5142729ef7a9@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918194447616
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31638f25-b86d-4605-624f-08d73c578579
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4204; 
x-ms-traffictypediagnostic: DB8PR08MB4204:
x-microsoft-antispam-prvs: <DB8PR08MB420421CD68D8C00A96D5D37CC18E0@DB8PR08MB4204.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(52314003)(7736002)(8936002)(316002)(81156014)(71200400001)(71190400001)(81166006)(486006)(478600001)(256004)(6486002)(25786009)(36756003)(4326008)(66476007)(6436002)(14454004)(31686004)(8676002)(99286004)(110136005)(6246003)(66556008)(229853002)(6512007)(2501003)(14444005)(31696002)(446003)(386003)(6506007)(305945005)(54906003)(66946007)(64756008)(86362001)(3846002)(66066001)(6116002)(52116002)(66446008)(5660300002)(53546011)(186003)(76176011)(476003)(26005)(11346002)(2616005)(102836004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4204;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c2GDlID1g5K4InryQHa+7ajnDl1aa5gTfIXJkiPeAMEv0ynMXkGZHUrzo1Tu42so9Ov0qRGsVdqTEOM4OyyonF42ns49ct+vX4nFPfu6Ctqncuk962QBjBInxevESqsrDbz42A5uNmU4c8BaX2G/p2uqA/uColjU8UmcEPwg7Ei15hxkxp7tSx48PHHT/f6Ah82krS9KV8wtFW2ZhITRdPptdp8sfhSeC0qUt3g4VRXXC9w2AJh4hWoXqmbkCrRkyz8YwXvScic4wb5BQx8HzuLd8N0dtoBUMZDkruObFAQi6j1fFB2V013MLbl9IMJsQHkyDdPKxn3LgG/BUhRpFJL7jbDc28JyM6PTYJxgUwW8ZGlNXj8eeVQyrA8yiRsQLl0Tew8rOZ7ZLSpXyta7kATlntu2daMmftGtbRNx3hs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEFDE36FC7196A459426EAD17D7A3DA2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31638f25-b86d-4605-624f-08d73c578579
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:44:49.6641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vSpWHNZJMXf78SSI+tOZnKb8F9RMIwqrstGc/HOJUrAsQUeeMCWKT83fIFuLPUkEc6e6OIDHD0H2izsKenW7xemk6Bgic2z6iWBO1MrpIZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4204
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.128
Subject: Re: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDkuMjAxOSAxMzozMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTguMDkuMjAxOSAxOjI5LCBKb2huIFNub3cgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDkvMTYvMTkg
MTA6NTYgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTIuMDku
MjAxOSAzOjE2LCBKb2huIFNub3cgd3JvdGU6DQo+Pj4+IExpa2Ugc2NyaXB0X21haW4sIGJ1dCBk
b2Vzbid0IHJlcXVpcmUgYSBzaW5nbGUgcG9pbnQgb2YgZW50cnkuDQo+Pj4+IFJlcGxhY2UgYWxs
IGV4aXN0aW5nIGluaXRpYWxpemF0aW9uIHNlY3Rpb25zIHdpdGggdGhpcyBkcm9wLWluIHJlcGxh
Y2VtZW50Lg0KPj4+Pg0KPj4+PiBUaGlzIGJyaW5ncyBkZWJ1ZyBzdXBwb3J0IHRvIGFsbCBleGlz
dGluZyBzY3JpcHQtc3R5bGUgaW90ZXN0cy4NCj4+Pj4NCj4+Pj4gTm90ZTogc3VwcG9ydGVkX29z
ZXM9WydsaW51eCddIHdhcyBvbWl0dGVkLCBhcyBpdCBpcyBhIGRlZmF1bHQgYXJndW1lbnQuDQo+
Pj4NCj4+PiBCdXQgYWZ0ZXIgdGhpcyBwYXRjaCBhbGwgdGVzdCB3aGljaCBkaWRuJ3QgY2hlY2sg
b3Mgc3RhcnQgdG8gY2hlY2sgbGludXgNCj4+PiAoYXMgaXQncyBkZWZhdWx0KS4uIFNvIGFsbCB0
ZXN0cyB3aGljaCB3b3JrZWQgb24gb3RoZXIgcGxhdGZvcm1zIHdpbGwgbm93DQo+Pj4gYmUgc2tp
cHBlZCBvbiB0aGVzZSBvdGhlciBwbGF0Zm9ybXM/DQo+Pj4NCj4+PiBGaW5hbGx5IGRvIHdlIHN1
cHBvcnQgc29tZXRoaW5nIGV4Y2VwdCBsaW51eCBmb3IgaW90ZXN0cz8NCj4+PiBmb3IgYmFzaCB0
ZXN0cyBfc3VwcG9ydGVkX29zIGFsc28gdXNlZCBvbmx5IHdpdGggIkxpbnV4IiBpbiA4NyB0ZXN0
cy4uDQo+Pj4NCj4+PiBNYXkgYmUgd2UnZCBiZXR0ZXIgZHJvcCBib3RoIF9zdXBwb3J0ZWRfb3Mg
YW5kIHN1cHBvcnRlZF9vc2VzIGFsbHRvZ2V0aGVyLA0KPj4+IGFuZCBkb24ndCBjYXJlPw0KPj4+
DQo+Pj4gQW55d2F5LCBpZiB3ZSBzdXBwb3J0IG9ubHkgbGludXgsIGFueSByZWFzb24gdG8gc2tp
cCBhbG1vc3QgYWxsIHRlc3RzLA0KPj4+IGlmIHNvbWVvbmUgdHJpZXMgdG8gcnVuIHRlc3Qgb24g
b3RoZXIgcGxhdGZvcm0/IExldCBoaW0gcnVuIHdoYXQgaGUgd2FudHMuDQo+Pj4NCj4+DQo+PiBD
dXJyZW50bHksIHRoZSBmb2xsb3dpbmcgdGVzdHMgYXJlIHB5dGhvbjoNCj4+DQo+PiAwMzAgMDQw
IDA0MSAwNDQgMDQ1IDA1NSAwNTYgMDU3IDA2NSAwOTMgMDk2IDExOCAxMjQgMTI5IDEzMiAxMzYg
MTM5IDE0Nw0KPj4gMTQ4IDE0OSAxNTEgMTUyIDE1NSAxNjMgMTY1IDE2OSAxOTQgMTk2IDE5OSAy
MDIgMjAzIDIwNSAyMDYgMjA3IDIwOCAyMDkNCj4+IDIxMCAyMTEgMjEyIDIxMyAyMTYgMjE4IDIx
OSAyMjIgMjI0IDIyOCAyMzQgMjM1IDIzNiAyMzcgMjM4IDI0MiAyNDUgMjQ2DQo+PiAyNDggMjU0
IDI1NSAyNTYgMjU3IDI1OCAyNjIgMjY2DQo+Pg0KPj4gQW5kIGFzIGl0IHN0YW5kcywgbm9uZSBv
ZiB0aGUgc2NyaXB0LXN0eWxlIHB5dGhvbiB0ZXN0cyB3ZSd2ZSBzZWxlY3RlZA0KPj4gdG8gcnVu
IGluIGBtYWtlIGNoZWNrYCBmYWlsIG9uIHRoZSBGcmVlQlNEIHBsYXRmb3JtLg0KPj4NCj4+IFNv
IGFzIGFuIGV4cGVyaW1lbnQsIEkgbGlmdGVkIHRoZSByZXN0cmljdGlvbiBvbiBweXRob24gdGVz
dHMuIEkga2VwdA0KPj4gcnVubmluZyAuL2NoZWNrIHVudGlsIEkgZm91bmQgc29tZSBpbnZvY2F0
aW9uIHRoYXQgdGhleSBkaWRuJ3Qgc2tpcC4NCj4+DQo+PiBGYWlsdXJlczogMDQ1IDE0NyAxNDkg
MTY5IDE5NCAxOTkgMjExDQo+Pg0KPj4gTm90IHRvbyBiYWQuLi4NCj4+DQo+PiAwNDU6ICtxZW11
Lm1hY2hpbmUuUUVNVU1hY2hpbmVFcnJvcjogc29ja2V0X3NjbV9oZWxwZXIgZG9lcyBub3QgZXhp
c3QNCj4+IDE0OTogV2FudHMgdG8gdXNlICdzdWRvJywgYnV0IG91ciBmcmVlYnNkIGltYWdlIGRv
ZXNuJ3QgaGF2ZSB0aGF0Lg0KPj4gMTk0OiArT1NFcnJvcjogQUZfVU5JWCBwYXRoIHRvbyBsb25n
DQo+PiAyMTE6DQo+PiAtW3sgInN0YXJ0IjogMCwgImxlbmd0aCI6IDMwNzIsICJkZXB0aCI6IDAs
ICJ6ZXJvIjogZmFsc2UsICJkYXRhIjogdHJ1ZSwNCj4+ICJvZmZzZXQiOiAxMDI0fSwNCj4+IC17
ICJzdGFydCI6IDMwNzIsICJsZW5ndGgiOiAzMzU1MTM2MCwgImRlcHRoIjogMCwgInplcm8iOiB0
cnVlLCAiZGF0YSI6DQo+PiB0cnVlLCAib2Zmc2V0IjogNDA5Nn1dDQo+PiArW3sgInN0YXJ0Ijog
MCwgImxlbmd0aCI6IDMxNzQ0LCAiZGVwdGgiOiAwLCAiemVybyI6IGZhbHNlLCAiZGF0YSI6DQo+
PiB0cnVlLCAib2Zmc2V0IjogMTAyNH0sDQo+PiAreyAic3RhcnQiOiAzMTc0NCwgImxlbmd0aCI6
IDMzNTIyNjg4LCAiZGVwdGgiOiAwLCAiemVybyI6IHRydWUsICJkYXRhIjoNCj4+IHRydWUsICJv
ZmZzZXQiOiAzMjc2OH1dDQo+Pg0KPj4NCj4+IDE0OSBjYW4gcHJvYmFibHkgYmUgZml4ZWQsIGFu
ZCAxOTQgYW5kIDIxMSBJIGhhdmUgZmFpbCBpbiBzaW1pbGFyIHdheXMNCj4+IG9uIG15IG93biBM
aW51eCBtYWNoaW5lLCBzbyB0aGF0J3MgcHJvYmFibHkgbm90IEJTRCdzIGZhdWx0Lg0KPj4NCj4+
IEludGVyZXN0aW5nbHksIDE2OSBhbmQgMTk5LCBiaXRtYXAgbWlncmF0aW9uIHJlbGF0ZWQgdGVz
dHMsIGNhdXNlIGENCj4+IFNJR1NFR1YgaW4gUUVNVSAuLi4NCj4+DQo+Pg0KPj4gMTY5Og0KPj4g
K0VFRUUuLi4uRUVFRS4uLi4uLi4uDQo+PiArV0FSTklORzpxZW11Lm1hY2hpbmU6cWVtdSByZWNl
aXZlZCBzaWduYWwgNjoNCj4+IC91c3IvaG9tZS9xZW11L3FlbXUtdGVzdC5JZnNSNjgvYnVpbGQv
dGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82
NA0KPj4gLWNoYXJkZXYNCj4+IHNvY2tldCxpZD1tb24scGF0aD0vdXNyL2hvbWUvcWVtdS9xZW11
LXRlc3QuSWZzUjY4L2J1aWxkL3Rlc3RzL3FlbXUtaW90ZXN0cy9zY3JhdGNoL3RtcHJwYzBpZGJ4
L3FlbXViLTI2NjE3LW1vbml0b3Iuc29jaw0KPj4gLW1vbiBjaGFyZGV2PW1vbixtb2RlPWNvbnRy
b2wgLWRpc3BsYXkgbm9uZSAtdmdhIG5vbmUgLXF0ZXN0DQo+PiB1bml4OnBhdGg9L3Vzci9ob21l
L3FlbXUvcWVtdS10ZXN0Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9x
ZW11Yi0yNjYxNy1xdGVzdC5zb2NrDQo+PiAtbWFjaGluZSBhY2NlbD1xdGVzdCAtbm9kZWZhdWx0
cyAtZGlzcGxheSBub25lIC1tYWNoaW5lIGFjY2VsPXF0ZXN0DQo+PiAtaW5jb21pbmcgZGVmZXIg
LWRyaXZlDQo+PiBpZj12aXJ0aW8saWQ9ZHJpdmUwLGZpbGU9L3Vzci9ob21lL3FlbXUvcWVtdS10
ZXN0Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9kaXNrX2IsZm9ybWF0
PXFjb3cyLGNhY2hlPXdyaXRlYmFjaw0KPj4NCj4+IFRoZSBjb21tb24gdGhyZWFkIGluIDE2OSBp
cyB0aGUgK21pZ2JpdG1hcCB0cmFpdCwgd2hpY2ggLi4uIG1ha2VzIG1lIGENCj4+IGxpdHRsZSBu
ZXJ2b3VzLCBvZiBjb3Vyc2UhDQo+Pg0KPj4NCj4+IDE5OToNCj4+ICtXQVJOSU5HOnFlbXUubWFj
aGluZTpxZW11IHJlY2VpdmVkIHNpZ25hbCA2Og0KPj4gL3Vzci9ob21lL3FlbXUvcWVtdS10ZXN0
Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvLi4vLi4veDg2XzY0LXNvZnRtbXUvcWVt
dS1zeXN0ZW0teDg2XzY0DQo+PiAtY2hhcmRldg0KPj4gc29ja2V0LGlkPW1vbixwYXRoPS91c3Iv
aG9tZS9xZW11L3FlbXUtdGVzdC5JZnNSNjgvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzL3NjcmF0
Y2gvdG1wdnpweWM5ajYvcWVtdWItMzAxNzAtbW9uaXRvci5zb2NrDQo+PiAtbW9uIGNoYXJkZXY9
bW9uLG1vZGU9Y29udHJvbCAtZGlzcGxheSBub25lIC12Z2Egbm9uZSAtcXRlc3QNCj4+IHVuaXg6
cGF0aD0vdXNyL2hvbWUvcWVtdS9xZW11LXRlc3QuSWZzUjY4L2J1aWxkL3Rlc3RzL3FlbXUtaW90
ZXN0cy9zY3JhdGNoL3FlbXViLTMwMTcwLXF0ZXN0LnNvY2sNCj4+IC1tYWNoaW5lIGFjY2VsPXF0
ZXN0IC1ub2RlZmF1bHRzIC1kaXNwbGF5IG5vbmUgLW1hY2hpbmUgYWNjZWw9cXRlc3QNCj4+IC1k
cml2ZQ0KPj4gaWY9dmlydGlvLGlkPWRyaXZlMCxmaWxlPS91c3IvaG9tZS9xZW11L3FlbXUtdGVz
dC5JZnNSNjgvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzL3NjcmF0Y2gvZGlza19iLGZvcm1hdD1x
Y293MixjYWNoZT1ub25lDQo+PiAtaW5jb21pbmcgZXhlYzogY2F0DQo+PiAnL3Vzci9ob21lL3Fl
bXUvcWVtdS10ZXN0Lklmc1I2OC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9taWdf
ZmlmbycNCj4+ICtFDQo+Pg0KPj4NCj4+IFZsYWRpbWlyLCBJIHdhcyBhYmxlIHRvIHByb3Zva2Ug
dGhpcyBlcnJvciBieSBlZGl0aW5nDQo+PiAuL3Rlc3RzL3ZtL01ha2VmaWxlLmluY2x1ZGUgYW5k
IHJlbW92aW5nIHRoZSAtLXNuYXBzaG90IGludm9jYXRpb24sIHRoZW4NCj4+IHVzaW5nIGBtYWtl
IHZtLWJ1aWxkLWZyZWVic2RgIGFuZCBmaW5hbGx5IHR5cGluZyBgbWFrZSB2bS1zc2gtZnJlZWJz
ZGANCj4+IHRvIG9wZW4gdXAgYSBzaGVsbC4NCj4+DQo+PiBUaGVuIHRoZSB0cmlja3MgYXJlIHRo
ZSB1c3VhbCBvbmVzOyBuYXZpZ2F0ZSB0byBpb3Rlc3RzIGRpcmVjdG9yeSwNCj4+IC4vY2hlY2sg
LXYgLXFjb3cyIDE2OSwgZXRjLiBZb3UnbGwgbmVlZCB0byBjcmVhdGUgYSBidWlsZCB0aGF0IGFs
bG93cw0KPj4gUHl0aG9uIHRlc3RzIHRvIHJ1bjsgZG8gaXQgYmVmb3JlIHlvdSBydW4gdGhlIHNu
YXBzaG90LWxlc3MgYnVpbGQuDQo+Pg0KPj4NCj4gDQo+IEludGVyZXN0aW5nLCBJJ2xsIHRyeSB0
byByZXByb2R1Y2UuDQoNCkNvdWxkIHlvdSBwcm92aWRlIG1vcmUgZGV0YWlsZWQgc3RlcHM/DQoN
CiMgbWFrZSB2bS1idWlsZC1mcmVlYnNkDQogICAgIFZNLUlNQUdFIGZyZWVic2QNCiMjIyBEb3du
bG9hZGluZyBpbnN0YWxsIGlzbyAuLi4NCiMjIyBQcmVwYXJpbmcgaXNvIGFuZCBkaXNrIGltYWdl
IC4uLg0KL3Jvb3QvLmNhY2hlL3FlbXUtdm0vaW1hZ2VzL2ZyZWVic2QuaW1nLmluc3RhbGwuaXNv
Lnh6ICgxLzEpDQogICAxMDAgJSAgICAgICA1OTUsMCBNaUIgLyA4NTEsMSBNaUIgPSAwLDY5OSAg
IDE1MyBNaUIvcyAgICAgICAwOjA1DQpGYWlsZWQgdG8gcHJlcGFyZSBndWVzdCBlbnZpcm9ubWVu
dA0KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KICAgRmlsZSAiL3dvcmsvc3Jj
L3FlbXUvbWFzdGVyL3Rlc3RzL3ZtL2Jhc2V2bS5weSIsIGxpbmUgMzUzLCBpbiBtYWluDQogICAg
IHJldHVybiB2bS5idWlsZF9pbWFnZShhcmdzLmltYWdlKQ0KICAgRmlsZSAiL3dvcmsvc3JjL3Fl
bXUvbWFzdGVyL3Rlc3RzL3ZtL2ZyZWVic2QiLCBsaW5lIDg2LCBpbiBidWlsZF9pbWFnZQ0KICAg
ICBpbWdfdG1wLCBzZWxmLnNpemVdKQ0KICAgRmlsZSAiL3Vzci9saWI2NC9weXRob24zLjcvc3Vi
cHJvY2Vzcy5weSIsIGxpbmUgMzQyLCBpbiBjaGVja19jYWxsDQogICAgIHJldGNvZGUgPSBjYWxs
KCpwb3BlbmFyZ3MsICoqa3dhcmdzKQ0KICAgRmlsZSAiL3Vzci9saWI2NC9weXRob24zLjcvc3Vi
cHJvY2Vzcy5weSIsIGxpbmUgMzIzLCBpbiBjYWxsDQogICAgIHdpdGggUG9wZW4oKnBvcGVuYXJn
cywgKiprd2FyZ3MpIGFzIHA6DQogICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNy9zdWJwcm9j
ZXNzLnB5IiwgbGluZSA3NzUsIGluIF9faW5pdF9fDQogICAgIHJlc3RvcmVfc2lnbmFscywgc3Rh
cnRfbmV3X3Nlc3Npb24pDQogICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNy9zdWJwcm9jZXNz
LnB5IiwgbGluZSAxNTIyLCBpbiBfZXhlY3V0ZV9jaGlsZA0KICAgICByYWlzZSBjaGlsZF9leGNl
cHRpb25fdHlwZShlcnJub19udW0sIGVycl9tc2csIGVycl9maWxlbmFtZSkNCkZpbGVOb3RGb3Vu
ZEVycm9yOiBbRXJybm8gMl0gTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeTogJ3FlbXUtaW1nJzog
J3FlbXUtaW1nJw0KbWFrZTogKioqIFsvd29yay9zcmMvcWVtdS9tYXN0ZXIvdGVzdHMvdm0vTWFr
ZWZpbGUuaW5jbHVkZTo0NzogL3Jvb3QvLmNhY2hlL3FlbXUtdm0vaW1hZ2VzL2ZyZWVic2QuaW1n
XSBFcnJvciAyDQojIGxzIHFlbXUtaW1nDQpxZW11LWltZw0KDQpXaGF0IGl0IHdhbnRzPyBJJ3Zl
IG5ldmVyIGRvbmUgc3VjaCBjcm9zcy1idWlsZHMgYmVmb3JlLi4NCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K


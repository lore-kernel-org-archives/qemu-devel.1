Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B6C4CEC5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8A62084F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pLt3OAKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8A62084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8oRT-0008R7-A2
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 12:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8oQ7-0006wD-Rp
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8oQ6-0006uA-NV
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 12:27:39 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com
 ([40.107.7.131]:20519 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8oQ0-0006sp-Qb; Fri, 13 Sep 2019 12:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD/Nj5kdJiMPh0YVbKcNKsi7Xn0dM8D8o3RVKvF0WhBXRXmm5JmSUD0S/TWhDJKuZqxCoKnHbOdA94hmA12PjyNdc8w+4aicIZ/jsKH2De+E0U7UQTeE2LMzOt3yddp+tu8+pWSPWRQtKWFoKXxM0fDKDZi/whQvCsBoyp1uBCSeSfn5rrtqWfvbNbSj9QvQgc+7mIOYiuO1oT4/279zx/Ypul15uD18eJR6n7UWShA5YzzhoPYsjSPl9YFElUMlYmd1eMyAU7UOtKGxiK8TaTgRoAyTkhwyGsSjYcpYmEJfza8l92PuUpUmlWapB2CFoR+0AP1RKCFtejKzu5N1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9XPodiIKneJO+4LkZouRk9pCKxE9igQxERfCa8yWnA=;
 b=M4W8Kht3eKwIxmX1sNivwzhrk3md3nuuA3cDZW9elg1gHAetiQExxR1icg8oHG/aXnyKCfu7tX1XlNBPEpsF0TVXi9V2ZtSUg3aeOL0XXp8wMJAPOtIruV+LMB7CYL97oj9YvigkwgOZYCMyIlis79/NMQgapbdDfuCDH2wtZ9M1eAE2lrQ+mlLEZOYbO5o6fIYVU3fUod6CPXmnacfVMUncu8xHS6WEKWen+YXZpelR/PpgfwIGOT+mLgJoVFp6OJSGBFBiFIHA+jz2196tPG6EcrXzN236K9vdFZzfvM5/8uabvXX1woG0O98xxi6CgNCpHqTubiulT+cChhhRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9XPodiIKneJO+4LkZouRk9pCKxE9igQxERfCa8yWnA=;
 b=pLt3OAKOKGJtLpEeKIiIjbK/i+Zi5S8dk4yPuTuzx5yjVwpQHH7r43p/Dw+N/ULop2Q5YQxD9g4LJ4jxQTMFc/IBADJxHWc2PzKcBWqHmr7Lpbokr86YLzbgwjnyZ+y1XP67Cy23ZTdt6DJ9jy0PGKr9+UE/m4Pv3N8evV8oeo0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4028.eurprd08.prod.outlook.com (20.179.10.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Fri, 13 Sep 2019 16:27:29 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 16:27:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v5 3/3] qemu-iotests: Add test for bz #1745922
Thread-Index: AQHVakfqnOwubWUfBUOuND6B0BQjeacpy7CA
Date: Fri, 13 Sep 2019 16:27:29 +0000
Message-ID: <5645f290-b34e-6b51-00cf-b7c4b4a0927a@virtuozzo.com>
References: <20190913152818.17843-1-mlevitsk@redhat.com>
 <20190913152818.17843-4-mlevitsk@redhat.com>
In-Reply-To: <20190913152818.17843-4-mlevitsk@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::11) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913192725713
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 361f94cf-43d1-4829-df5d-08d738674554
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4028; 
x-ms-traffictypediagnostic: DB8PR08MB4028:
x-microsoft-antispam-prvs: <DB8PR08MB40288276B6A3BB7FDA732E80C1B30@DB8PR08MB4028.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(376002)(346002)(396003)(189003)(199004)(8936002)(4326008)(316002)(476003)(110136005)(54906003)(31686004)(478600001)(6116002)(3846002)(66946007)(66476007)(66556008)(64756008)(66446008)(71190400001)(71200400001)(186003)(6512007)(102836004)(6506007)(6246003)(53936002)(305945005)(7736002)(25786009)(446003)(26005)(6486002)(14454004)(99286004)(6436002)(5660300002)(11346002)(229853002)(2616005)(2501003)(76176011)(36756003)(256004)(486006)(52116002)(66066001)(81166006)(31696002)(81156014)(8676002)(86362001)(2906002)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4028;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8iMPgRXwflpCFVx7rswSNGbfeIKD4lCce8+6dI5r1pG3apVfNlU//bcM0JtTtNM+YlZXtCAYhxIAbvoA14c8Mv+/v2wCvvqQH1ztgq2SvkWdm18SJuvQlVX3v7CNGAqXj4ZnHEsS+S1/LyvM9KsO1IAfJTxIF62z5BPhNE+cQWmMelTPnQy/oo+HJ660H0qfLGNtio4OgaMLQyO7FvXfOslRUrGvO5j1p9NGh0SsWFweFauE1CJ2Exio5MOn7hfkZjf9OM6FCzDJsNUWDM7hnlpVnZsnbd9TGKBqb357yxLCpIS8JOrY08F6X9dnfcggToXntewnwVy5zLtkWKtEA6CW5gDpyytUbMJCR++w+RziL+Oak5yFOQ4ejAXvayIR/nrZvsFUSIEeeHnbYhri3VNZ9twiOUtyKowLBpF+17I=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7DF023670CD474E83004577BF9B4170@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361f94cf-43d1-4829-df5d-08d738674554
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 16:27:29.3042 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vr7EWARe+JErZ2DzsZUr+EhL59Nn07SJ95v1lEmXICklcRsrMuA2qgbXHhn1Sk5yC+QvJml9ycK1ByBIPTOMq57ynKsodofE/fACNcB05BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4028
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.131
Subject: Re: [Qemu-devel] [PATCH v5 3/3] qemu-iotests: Add test for bz
 #1745922
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
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDkuMjAxOSAxODoyOCwgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6
IE1heGltIExldml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9x
ZW11LWlvdGVzdHMvMjYzICAgICB8IDkxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2My5vdXQgfCA0MCArKysrKysrKysrKysr
KysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDIgKw0KPiAgIDMgZmlsZXMg
Y2hhbmdlZCwgMTMzIGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMv
cWVtdS1pb3Rlc3RzLzI2Mw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVz
dHMvMjYzLm91dA0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjMgYi90
ZXN0cy9xZW11LWlvdGVzdHMvMjYzDQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAw
MDAwMDAwMDAuLmQyYzAzMGZhZTkNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMjYzDQoNClsuLl0NCg0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAN
Cj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+IEBAIC0yNzQsNSArMjc0LDcgQEAN
Cj4gICAyNTcgcncNCj4gICAyNTggcncgcXVpY2sNCj4gICAyNjIgcncgcXVpY2sgbWlncmF0aW9u
DQo+ICsyNjMgcncgcXVpY2sNCj4gICAyNjUgcncgYXV0byBxdWljaw0KPiAgIDI2NiBydyBxdWlj
aw0KPiArPj4+Pj4+PiBwYXRjaGVkDQo+IA0KDQpsYXN0IGxpbmUgaXMgYSBtaXN0YWtlLg0KDQph
bHNvLCB0ZXN0IGZhaWxlZCBmb3IgbWU6DQoNCjI2MyAgICAgIGZhaWwgICAgICAgWzE5OjIxOjM1
XSBbMTk6MjE6MzVdICAgICAgICAgICAgICAgICAgICBvdXRwdXQgbWlzbWF0Y2ggKHNlZSAyNjMu
b3V0LmJhZCkNCi0tLSAvd29yay9zcmMvcWVtdS9tYXhpbS1sdWtzL3Rlc3RzL3FlbXUtaW90ZXN0
cy8yNjMub3V0ICAgICAgICAyMDE5LTA5LTEzIDE5OjExOjQ1LjQ2NDcyNzQyNyArMDMwMA0KKysr
IC93b3JrL3NyYy9xZW11L21heGltLWx1a3MvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2My5vdXQuYmFk
ICAgIDIwMTktMDktMTMgMTk6MjE6MzUuNTM1MzgxMjUzICswMzAwDQpAQCAtMiw2ICsyLDcgQEAN
Cg0KICB0ZXN0aW5nIExVS1MgcWNvdzIgZW5jcnlwdGlvbg0KDQorcWVtdS1pbWc6IFRFU1RfRElS
L3QuSU1HRk1UOiBObyBjcnlwdG8gbGlicmFyeSBzdXBwb3J0aW5nIFBCS0RGIGluIHRoaXMgYnVp
bGQ6IEZ1bmN0aW9uIG5vdCBpbXBsZW1lbnRlZA0KICBGb3JtYXR0aW5nICdURVNUX0RJUi90LklN
R0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMDQ4NTc2IGVuY3J5cHQuZm9ybWF0PWx1a3MgZW5jcnlw
dC5rZXktc2VjcmV0PXNlYzAgZW5jcnlwdC5pdGVyLXRpbWU9MTANCiAgPT0gcmVhZGluZyB0aGUg
d2hvbGUgaW1hZ2UgPT0NCiAgcmVhZCAxMDQ4NTc2LzEwNDg1NzYgYnl0ZXMgYXQgb2Zmc2V0IDAN
CkZhaWx1cmVzOiAyNjMNCkZhaWxlZCAxIG9mIDEgdGVzdHMNCg0KDQphbmQgaWYgcmVjb25maWd1
cmUgd2l0aA0KICAtLWVuYWJsZS1nbnV0bHMgLS1lbmFibGUtZ2NyeXB0IC0tZW5hYmxlLXZob3N0
LWNyeXB0byAtLWVuYWJsZS1jcnlwdG8tYWZhbGcNCihkb24ndCBrbm93IHdoaWNoIG9uZSBpcyBh
Y3R1YWxseSBuZWVkZWQpDQppdCB3b3Jrcy4uDQoNCnNvLCB3ZSBhdCBsZWFzdCBzaG91bGQgc2tp
cCB0aGUgdGVzdCBpZiBpdCdzIHVuc3VwcG9ydGVkDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K


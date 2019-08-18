Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91989C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 10:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AB721773
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 10:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=janustech.onmicrosoft.com header.i=@janustech.onmicrosoft.com header.b="0H5ewXX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AB721773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=janustech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzIGe-0000qm-AQ
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 06:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lbloch@janustech.com>) id 1hzIFx-0000LM-If
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 06:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lbloch@janustech.com>) id 1hzIFw-0006d7-FI
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 06:17:49 -0400
Received: from mail-eopbgr690138.outbound.protection.outlook.com
 ([40.107.69.138]:12167 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lbloch@janustech.com>)
 id 1hzIFt-0006au-19; Sun, 18 Aug 2019 06:17:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuEdODJ+jquinroIU+jlvbgzMgp4gEMf/yIFn85lH2zctktqbu3uOHbGTJam8+6UFPv/aTzGlf1+dsx8fjcl2BbtcPUwQkcgD9aezvnkGLf5tZHmNSsnvTLJrBbZlyufmqx30Xhrpl/iVG5LvpSqqyorpzos3bPJ/bR8QtvGgOm094CVyr/0lK75mSAc0jMudgLPzO5C3ZjZRrFdRhUI5uazWdStGUJUo4at0oJdAIM6IzbUrfeYEl9nA/dPGH8VBazlLzoKmB6agSVh8nucPHbZuAeV1N6UQFuAtYEnB/p/rGH7noD8OhmIyOgdj5izXup5qN5oZ02sDvzphK27yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY6lRQGUGLP2ih81USg+q2wWnXrsDwAJewhhDhTaLNA=;
 b=LoIpYJVPJ7j+raZZgYa6jknI6EMk+1XKw3Qy7FTQp7Ibu8JPkzuQ47oDF/+3tG7C3vO1vUuhFavyHd/cCpvzxrH9R6S6JVEiBsEFJVpZVjDnDZa/2wUiNWsQumGypIwKQxbro4uZVw0eAIKRrxhN/kcHjfhqo0PZ/AVaovaYO2ug43Ah9ANQNaExzjEGlhqVoVczr8qrkPhPGoACUSmTG4Ory1ZIlmgupFtRAhbjaoNBax5V+WtyCAMcwD4KvLg8T2sTkD0y3isAZiV3gy66ZN2ZIWT9YN4wJEFteVt415rgLkgb/ztgPWkjHjC8fPLtUAD09QQE1NCbBZwbc3UBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=janustech.com; dmarc=pass action=none
 header.from=janustech.com; dkim=pass header.d=janustech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=janustech.onmicrosoft.com; s=selector2-janustech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY6lRQGUGLP2ih81USg+q2wWnXrsDwAJewhhDhTaLNA=;
 b=0H5ewXX7Ts1IuuiuTpkbGQqi9I+DdDPPXjaKxdmcdMrN+KPLersXwmZyllv8ss4TYzVwkXKuKAbaGg+BcLi51qZhvhf15rkEXDIGcIM1sJPeg040C4k3XTBSSS27l+BmqFDAN5cz31PK1Rf/Ftpl7WdT+t6Y49BI4o6X6etLG1c=
Received: from CY1PR07MB2619.namprd07.prod.outlook.com (10.166.205.20) by
 CY1PR07MB2636.namprd07.prod.outlook.com (10.167.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Sun, 18 Aug 2019 10:17:40 +0000
Received: from CY1PR07MB2619.namprd07.prod.outlook.com
 ([fe80::e00c:cd7c:f91f:898d]) by CY1PR07MB2619.namprd07.prod.outlook.com
 ([fe80::e00c:cd7c:f91f:898d%6]) with mapi id 15.20.2178.018; Sun, 18 Aug 2019
 10:17:40 +0000
From: Leonid Bloch <lbloch@janustech.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH] qcow2: Fix the calculation of the maximum L2 cache size
Thread-Index: AQHVVCy2oNuCoxIbs06CsEcjdzxVqqcAs+wA
Date: Sun, 18 Aug 2019 10:17:40 +0000
Message-ID: <b315a4ab-a643-3ad4-c0d7-39d580136cf3@janustech.com>
References: <20190816121742.29607-1-berto@igalia.com>
In-Reply-To: <20190816121742.29607-1-berto@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::22)
 To CY1PR07MB2619.namprd07.prod.outlook.com
 (2a01:111:e400:c610::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lbloch@janustech.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [141.226.29.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9889500-e01f-4d73-6305-08d723c54cd2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY1PR07MB2636; 
x-ms-traffictypediagnostic: CY1PR07MB2636:
x-microsoft-antispam-prvs: <CY1PR07MB2636BE38B86DE30C790BDFC0CAA90@CY1PR07MB2636.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01334458E5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(366004)(39830400003)(376002)(199004)(189003)(316002)(53546011)(102836004)(14444005)(256004)(110136005)(54906003)(6506007)(386003)(76176011)(52116002)(66066001)(508600001)(6486002)(14454004)(229853002)(486006)(26005)(36756003)(71190400001)(71200400001)(99286004)(186003)(446003)(2616005)(6512007)(53936002)(3846002)(66946007)(66476007)(66556008)(66446008)(25786009)(6116002)(305945005)(7736002)(6436002)(6246003)(2501003)(476003)(11346002)(64756008)(31696002)(86362001)(5660300002)(4326008)(2906002)(31686004)(81156014)(81166006)(8936002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY1PR07MB2636;
 H:CY1PR07MB2619.namprd07.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: janustech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nLCsaqc8qSKgPtjUkaFpjGkIcw2LaIRFoBfeM8Pye8Kzv9wST0bCRAJDHQUGJGL583o0D6UOnHsUuC8Z5NN+sD4tHLU+W1bq08Ad8MSYw+EWqbIXHP+HTw/PK1XgikWxMlQ8BK1YaulX/XgdvBYzKmhlTZj3k+QT0gltbbh+R+EJpSUJCzwHVrpqVwG+tSf3kUK/g0CqoK5HO8Xhl/q6IERJBvZYWgWsLwhc9g96qKH5Q2azH5tROLsfFw/PAFu2ObZMJjsLLoUurvvo3XvbgpiXL6xAy4jkxfzN/9vGE6AZ84JV9JNofxeqIq/8n4aKVCaVjGTwsl+Rl0emDqv5Ur2CRhXaEd6D2vWln4zs3R3DbgaVMBp5jvUaZom+zcMtoVxjqehBZuvlq+CsXMN9gc4U1EMYwfedAwlGecKrGDs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E856BE9942DC314DB4EE3648055B717E@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: janustech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9889500-e01f-4d73-6305-08d723c54cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2019 10:17:40.3259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34eb020e-3cf3-43a1-afeb-f5cf1310628e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lzMarKfYi89c8EwdPISG7p/I7k/eF7KGc+IVHAwuc/UgponKu+crUoZw9fe0zygqYkJqy07adzRtcYE0n2Scgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2636
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.138
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix the calculation of the maximum
 L2 cache size
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

VGhhbmtzLCBCZXJ0byENCg0KT24gOC8xNi8xOSAzOjE3IFBNLCBBbGJlcnRvIEdhcmNpYSB3cm90
ZToNCj4gVGhlIHNpemUgb2YgdGhlIHFjb3cyIEwyIGNhY2hlIGRlZmF1bHRzIHRvIDMyIE1CLCB3
aGljaCBjYW4gYmUgZWFzaWx5DQo+IGxhcmdlciB0aGFuIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBM
MiBtZXRhZGF0YSB0aGF0IHRoZSBpbWFnZSBjYW4gaGF2ZS4NCj4gRm9yIGV4YW1wbGU6IHdpdGgg
NjQgS0IgY2x1c3RlcnMgdGhlIHVzZXIgd291bGQgbmVlZCBhIHFjb3cyIGltYWdlDQo+IHdpdGgg
YSB2aXJ0dWFsIHNpemUgb2YgMjU2IEdCIGluIG9yZGVyIHRvIGhhdmUgMzIgTUIgb2YgTDIgbWV0
YWRhdGEuDQo+IA0KPiBCZWNhdXNlIG9mIHRoYXQsIHNpbmNlIGNvbW1pdCBiNzQ5NTYyZDk4MjJk
MTRlZjY5YzllYWE1Zjg1OTAzMDEwYjg2YzMwDQo+IHdlIGZvcmJpZCB0aGUgTDIgY2FjaGUgdG8g
YmVjb21lIGxhcmdlciB0aGFuIHRoZSBtYXhpbXVtIGFtb3VudCBvZiBMMg0KPiBtZXRhZGF0YSBm
b3IgdGhlIGltYWdlLCBjYWxjdWxhdGVkIHVzaW5nIHRoaXMgZm9ybXVsYToNCj4gDQo+ICAgICAg
dWludDY0X3QgbWF4X2wyX2NhY2hlID0gdmlydHVhbF9kaXNrX3NpemUgLyAocy0+Y2x1c3Rlcl9z
aXplIC8gOCk7DQo+IA0KPiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMgZm9ybXVsYSBpcyB0aGF0IHRo
ZSByZXN1bHQgc2hvdWxkIGJlIHJvdW5kZWQgdXANCj4gdG8gdGhlIGNsdXN0ZXIgc2l6ZSBiZWNh
dXNlIGFuIEwyIHRhYmxlIG9uIGRpc2sgYWx3YXlzIHRha2VzIG9uZSBmdWxsDQo+IGNsdXN0ZXIu
DQo+IA0KPiBGb3IgZXhhbXBsZSwgYSAxMjgwIE1CIHFjb3cyIGltYWdlIHdpdGggNjQgS0IgY2x1
c3RlcnMgbmVlZHMgZXhhY3RseQ0KPiAxNjAgS0Igb2YgTDIgbWV0YWRhdGEsIGJ1dCB3ZSBuZWVk
IDE5MiBLQiBvbiBkaXNrICgzIGNsdXN0ZXJzKSBldmVuIGlmDQo+IHRoZSBsYXN0IDMyIEtCIG9m
IHRob3NlIGFyZSBub3QgZ29pbmcgdG8gYmUgdXNlZC4NCj4gDQo+IEhvd2V2ZXIgUUVNVSByb3Vu
ZHMgdGhlIG51bWJlcnMgZG93biBhbmQgb25seSBjcmVhdGVzIDIgY2FjaGUgdGFibGVzDQo+ICgx
MjggS0IpLCB3aGljaCBpcyBub3QgZW5vdWdoIGZvciB0aGUgaW1hZ2UuDQo+IA0KPiBBIHF1aWNr
IHRlc3QgZG9pbmcgNEtCIHJhbmRvbSB3cml0ZXMgb24gYSAxMjgwIE1CIGltYWdlIGdpdmVzIG1l
DQo+IGFyb3VuZCA1MDAgSU9QUywgd2hpbGUgd2l0aCB0aGUgY29ycmVjdCBjYWNoZSBzaXplIEkg
Z2V0IDE2SyBJT1BTLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRv
QGlnYWxpYS5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3Fjb3cyLmMgfCA2ICsrKysrLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ibG9jay9xY293Mi5jIGIvYmxvY2svcWNvdzIuYw0KPiBpbmRleCAwMzliZGMyZjdl
Li44NjU4Mzk2ODJjIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9xY293Mi5jDQo+ICsrKyBiL2Jsb2Nr
L3Fjb3cyLmMNCj4gQEAgLTgyNiw3ICs4MjYsMTEgQEAgc3RhdGljIHZvaWQgcmVhZF9jYWNoZV9z
aXplcyhCbG9ja0RyaXZlclN0YXRlICpicywgUWVtdU9wdHMgKm9wdHMsDQo+ICAgICAgIGJvb2wg
bDJfY2FjaGVfZW50cnlfc2l6ZV9zZXQ7DQo+ICAgICAgIGludCBtaW5fcmVmY291bnRfY2FjaGUg
PSBNSU5fUkVGQ09VTlRfQ0FDSEVfU0laRSAqIHMtPmNsdXN0ZXJfc2l6ZTsNCj4gICAgICAgdWlu
dDY0X3QgdmlydHVhbF9kaXNrX3NpemUgPSBicy0+dG90YWxfc2VjdG9ycyAqIEJEUlZfU0VDVE9S
X1NJWkU7DQo+IC0gICAgdWludDY0X3QgbWF4X2wyX2NhY2hlID0gdmlydHVhbF9kaXNrX3NpemUg
LyAocy0+Y2x1c3Rlcl9zaXplIC8gOCk7DQo+ICsgICAgdWludDY0X3QgbWF4X2wyX2VudHJpZXMg
PSBESVZfUk9VTkRfVVAodmlydHVhbF9kaXNrX3NpemUsIHMtPmNsdXN0ZXJfc2l6ZSk7DQo+ICsg
ICAgLyogQW4gTDIgdGFibGUgaXMgYWx3YXlzIG9uZSBjbHVzdGVyIGluIHNpemUgc28gdGhlIG1h
eCBjYWNoZSBzaXplDQo+ICsgICAgICogc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgdGhlIGNsdXN0
ZXIgc2l6ZS4gKi8NCj4gKyAgICB1aW50NjRfdCBtYXhfbDJfY2FjaGUgPSBST1VORF9VUChtYXhf
bDJfZW50cmllcyAqIHNpemVvZih1aW50NjRfdCksDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcy0+Y2x1c3Rlcl9zaXplKTsNCj4gICANCj4gICAgICAgY29tYmluZWRf
Y2FjaGVfc2l6ZV9zZXQgPSBxZW11X29wdF9nZXQob3B0cywgUUNPVzJfT1BUX0NBQ0hFX1NJWkUp
Ow0KPiAgICAgICBsMl9jYWNoZV9zaXplX3NldCA9IHFlbXVfb3B0X2dldChvcHRzLCBRQ09XMl9P
UFRfTDJfQ0FDSEVfU0laRSk7DQo+IA0K


Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF35216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="g5J9Rlrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF35216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafzs-0006X5-1V
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iafnv-0007tB-Al
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iafnp-0000Dd-RY
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:55:19 -0500
Received: from mail-he1eur01on070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::70e]:33019
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iafnp-0008PD-IJ; Fri, 29 Nov 2019 07:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrebWi/6UoTCt18S0H2IHBJ+wWx+rJCLeS9NRm8ahMdn+LJ/9Akmh00cKCpdzP8ZoL5a0FwgpH5uLVzY1n5oqL2dEahk8XazzG2rbWwyOkhdHJWwAJ9uGFmsYgxxUIkTZTgq+9vNnI7alhJ9b6v5qYBNIJwqPJa8AuF2YltLngpJqoAY/YOVb19D4m3BddVEecXF02wNyFYmT0SGvLIgumwrQKWTUoK1qB6gPdua+SmPN0efRlyfJ37/hwGqBpBNM2MYAsNW5EMjV4D6UjGqMxxherEPbTxP94OZzjZimDqU/rvKv4c0IyH1HFGsH8h4xC5sTuCO5k8sgmotCoPr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCGv5DxmTKnCKhmG9T5AbcAFVLcqAWsiPUitrq/lbaw=;
 b=WaKye70JmlVsbg7ijo+Lw2gif5jdKwYFqmVOCo18KCllmH0sMkMfjCYdqSoj51oMky9Su9jt/X5Y/dyeZbrpzki0xbf6yuWSZkMBkUPYW2Qr9wAT3GmibgdP9GNc5rZ9FmpzbnQBnW94ZkGIyN0FxGjeI45RMYqk6wjQ0ko2otKXO6at+3yn6MnCSYJzTtBCGJkepJ3Wk9yGJJJSy1Ay/Rt1w2JYXJTFxGtf6zujCtlTR2yUJTF1DT5a1iG4snGLoxsoC7/KuN7sX9//l08VVmVaDpLgM7Jx4Gv1Q7NlXH7W2DPQBzLyBlGOpY2gWxUOvPBNL32R9LhR3HQM5Rp4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCGv5DxmTKnCKhmG9T5AbcAFVLcqAWsiPUitrq/lbaw=;
 b=g5J9RlrmUF8TTjSU7nNouHb6EtijAx+EYPZIEFXgYdI1exTadIti+UC2nFT5fMPQFA4ftPEEyaMpqTcTYhrEy0JCkzkDyqpGvd+Pjwm3AfV4FXVAvmlVJLWdycaXouFKd1ewuub8WY0IO9AycU5+b34Rlh+aP6o9G8XINd8XXtc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4213.eurprd08.prod.outlook.com (20.178.91.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Fri, 29 Nov 2019 12:55:04 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 12:55:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 00/23] block: Fix check_to_replace_node()
Thread-Topic: [PATCH for-5.0 v2 00/23] block: Fix check_to_replace_node()
Thread-Index: AQHVmKlpfvOoU/F0/UCS/QjP1du9qqeiYNKA///UqQCAAAGegA==
Date: Fri, 29 Nov 2019 12:55:04 +0000
Message-ID: <e1d9f786-1849-2b6b-a585-09a779dbc29f@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <a134c8a6-17c1-34bc-79f6-76062ff0c668@virtuozzo.com>
 <2fd76d27-d60e-a9d1-f42a-89b9bd0d5dcb@redhat.com>
In-Reply-To: <2fd76d27-d60e-a9d1-f42a-89b9bd0d5dcb@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0014.eurprd07.prod.outlook.com
 (2603:10a6:7:67::24) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129155501807
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08fdc04b-bf58-401d-3bc3-08d774cb5a77
x-ms-traffictypediagnostic: AM6PR08MB4213:
x-microsoft-antispam-prvs: <AM6PR08MB42132C1B7395739C633C0F8DC1460@AM6PR08MB4213.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(376002)(136003)(346002)(189003)(199004)(25786009)(66946007)(229853002)(66556008)(66476007)(66446008)(14454004)(64756008)(7736002)(8676002)(6306002)(36756003)(2906002)(71200400001)(305945005)(478600001)(71190400001)(26005)(186003)(446003)(66066001)(4744005)(6512007)(53546011)(256004)(81156014)(81166006)(6486002)(52116002)(8936002)(2616005)(11346002)(102836004)(54906003)(76176011)(86362001)(110136005)(99286004)(5660300002)(2501003)(316002)(31696002)(6246003)(6116002)(6436002)(966005)(31686004)(386003)(6506007)(3846002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4213;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hH/rA8T+8rTcts0LBNan7t7IuIzHwKauzqdAcF7L7qyZr5f4e0aqo2nZn6j85WuioBJ8UMQecZliGmhWeCmzKNYxl9FJZq4qBOeFkoTOIW8tBr2JwOANQm7hwg9eL23QsQJAvVUN6HWvWtsAjPbA8/B2ATlqCU+bKLYlWh/+Sc7DkFKzoq5vzY/VcNpYkLyju7eFFif0ufpWN5iwKrqNoJpntuhlzM+bBcDFJl2PDdM/31+kpry9d+TTvixJHSDOrO7nd6d80AEj1x491AyRcFB0z358H4Fls3kIqTWIKIghQbXWuZ4pr/8iwpfPCeyVulmoPPAcZD7DRPXMxHpCC1uKUejrf86cQzto3Yho2rLtZcIC+qf1nBQ7Q7hp8pjaPHWnxBHQGUp9sY7ZtcLgcBrrRoPe2yKwjJEbrPRZS7Z6zNDYNPY1UDGInKXK7yK7z42A4biCFftXLn2/LlHiF0hA2pvqvvTMsdMmNpQRV/w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <48B135EC45FA1C408EBF16ACF094BA85@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fdc04b-bf58-401d-3bc3-08d774cb5a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 12:55:04.3289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQT+MgFts/3G8zDlazIqvODmOFmBZg0hIVQFZdXywLgrZaftmqKiQGHkVvnG3+VsFaqBTOZBw1qlJmv3GQoKEb6sDDT/QzWxd+PjQnLu1Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4213
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1e::70e
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMTEuMjAxOSAxNTo0OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4xMS4xOSAxMzoyNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDMgbGFzdCBpb3Rlc3RzIHBh
dGNoZXMgZG9uJ3QgYXBwbHkgbm93Li4gRG8geW91IGhhdmUgYSBicmFuY2ggcHVzaGVkIHNvbWV3
aGVyZT8NCj4gDQo+IEhtLCBpdOKAmXMgYmFzZWQgb24g4oCcaW90ZXN0czogVGVzdCBmYWlsaW5n
IG1pcnJvciBjb21wbGV0ZeKAnSwgbWF5YmUgYmVjYXVzZQ0KPiBvZiB0aGF0Lg0KPiANCj4gRG9l
cyB0aGlzIHdvcms/DQo+IA0KPiBodHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUu
Z2l0IGZpeC1jYW4tcmVwbGFjZS12Mg0KPiANCg0KSG1tLCBJIHJlbWVtYmVyIGluIHBhc3QsIGZl
dGNoaW5nIGZyb20gdGhpcyByZXBvIGFsd2F5cyBoYW5nIGZvciBtZS4NCkJ1dCBub3cgaXQgd29y
a3MsIHRoYW5rcy4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


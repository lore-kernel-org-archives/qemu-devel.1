Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB8C3F2D7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 03:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41192146E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 03:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="ZxrATMOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41192146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9KSg-0003sL-Tj
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 22:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1j9KRy-0003EE-V4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 22:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1j9KRx-0001fH-NE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 22:11:58 -0500
Received: from smtpe1.intersmtp.com ([213.121.35.71]:27897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1j9KRx-0001dI-5m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 22:11:57 -0500
Received: from tpw09926dag05h.domain1.systemhost.net (10.9.202.32) by
 BWP09926076.bt.com (10.36.82.107) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 4 Mar
 2020 03:11:28 +0000
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 tpw09926dag05h.domain1.systemhost.net (10.9.202.32) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 4 Mar 2020 03:11:54 +0000
Received: from RDW083A011ED67.bt.com (10.187.98.37) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 4 Mar 2020 03:11:54
 +0000
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.56) by
 smtpe1.intersmtp.com (62.239.224.235) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 4 Mar 2020 03:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX6GTWSs/tnrIu8WGvsLlMHu+gxty5QMOoiqfvi46R/B8AN8jtNEtqWLYoYlCQ08JJzgAwgp+EBTcRq0s6dkSyKOg3ew+Ccp1XeX722ooOSHNI9eUvJ/KPx1zQ4GiAUp5/Gkx5koi95vGTjaxas6bIPGaIaKUHJbXq5a92rwvTfV306oYDCHceMV4m+4vM/U6jb7yDfO7tkkkhTCYqMTuuAFZk53zeuXmh7ZBJTF7xLyqUbgx/T0jieorQTon2SzPZpSMq+Pe25pHHQe1XUWXcwpsTRsZ4diOC3P7+lMw9P4WefIQgGRff5r4nvQn1nRFq7vv/7YVbIdR5wSULQmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVbnW5I7IMN01q2n4yNKX6A2rU1jfv21dBpELZc/Uns=;
 b=RMAVVfe4r5OcrTZ25gfClvz9OISdx3+vA7t2aleth7n18pDniwxVZzvzjRUoYiaSHPp6eVyZ+nDmUWiVt6Sgn1lIwRkdrV9m6VpNQT/D2XdmV12LkIsmpr8BQC1CPHJTQzV4Qe4ELFLEVsTQ3Sj/5jTQD12eO0TzKR+J5s9JO6JuLz0C+fkh0mWfTdsTWDcjlQhoqePI17eeh6XYK/LiqXMCwPqPf0l3eBYXUVgZ5N3dPkmQBgehiQEAgmxAeIit7ItmLwOv8kytCS8XOH4vFtIz2OvBtPv+73kjbdJS/F3cOkN1zSjEh5vXOOQc78WRuKiRioMIMvicngq56Nuq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVbnW5I7IMN01q2n4yNKX6A2rU1jfv21dBpELZc/Uns=;
 b=ZxrATMOdSHrqIb6MNVKwk1qQhszA9acRNeL7mtEiY4COfZ9lQNJjm5qifDdgOF7Vssi8qUY6zrlV6BJHuHNfiB+XL5lyOesRbP6EuPbWhQbYeJ2Aki8rzuuzO2VKwJiF08kKMFZie6aZZE6sLAaMkHe8VqXPKYuUVqmX/ShO8SY=
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) by
 LO2P123MB1885.GBRP123.PROD.OUTLOOK.COM (20.176.154.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 03:11:53 +0000
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::312f:184d:74b1:28c5]) by LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::312f:184d:74b1:28c5%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 03:11:53 +0000
From: <jasper.lowell@bt.com>
To: <balaton@eik.bme.hu>
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
Thread-Topic: [PATCH] hw/ide: Remove status register read side effect
Thread-Index: AQHV6IMztk0nS91QXUSAhbuFxp1TiagnnJkAgAADjoCAAAXGgIAAvUiAgACESgCAAmZZAIAAvBaAgADuooCABx1uAIADvlaA
Date: Wed, 4 Mar 2020 03:11:53 +0000
Message-ID: <06be591e667c6b72c78ae3a33e3092ab323fdb8b.camel@bt.com>
References: <20200221065015.337915-1-jasper.lowell@bt.com>
 <f432a118-f6be-d6ff-fe37-35b6244f3b97@ilande.co.uk>
 <alpine.LMD.2.03.2002222042370.1577@eik.bme.hu>
 <alpine.LMD.2.03.2002222101580.1577@eik.bme.hu>
 <5f336bc8838b5bfebfcc5829a3fae0a34a2ebac0.camel@bt.com>
 <alpine.BSF.2.22.395.2002231522530.69746@zero.eik.bme.hu>
 <5ca992b3a358610c897d923009fe9f7a8febc17f.camel@bt.com>
 <alpine.BSF.2.22.395.2002251515290.22173@zero.eik.bme.hu>
 <2e972e94627a39cf45504ed244828d065d743910.camel@bt.com>
 <alpine.BSF.2.22.395.2003011847220.28669@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003011847220.28669@zero.eik.bme.hu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [61.68.11.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31cbed44-be71-4884-898e-08d7bfe9ca01
x-ms-traffictypediagnostic: LO2P123MB1885:
x-microsoft-antispam-prvs: <LO2P123MB1885B3F200717D01C331D50883E50@LO2P123MB1885.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(8936002)(54906003)(8676002)(5660300002)(81156014)(6486002)(6512007)(71200400001)(2906002)(186003)(316002)(81166006)(478600001)(2616005)(26005)(66946007)(66446008)(91956017)(36756003)(66556008)(76116006)(6916009)(86362001)(64756008)(6506007)(66476007)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:LO2P123MB1885;
 H:LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +F2P47pq9kCOD54LnlgwKCB8FVmDow0f5uZhZd/X7Gzb1nAs7swdZj638riZZyzhKbNHljq/k+xS4weAWml2f2YxYtURRl5bS2m7vOtQLU76BmJ2bHKTvL3rlVOU0Zu49eLloNXsrfab+xF7drIzm9HmScihUPucLzdQIFhu7BDJQwKh0QLUIBgF7c5hFpesRJ7bwcESosTVmubitXGNt99OrZqVXDVtoisS8cw9J/VcV9kGS9GeYqcRyJcCq/hyNN1iwH3zqqt7J6/lRcgX1c6BIwwWJximgyphChuBlpsZg17c3oe/SlVWYA9t6uxOp1RmqNZsz2pdSVUY3eA6BMiLYliTLCLShJJ4Gl0BhJnXvdVixlvIvRaT9XmxBpVQ/jP5PbOkGZiRYz9uE7hRvFXGIhhOOhQ0WsI5bXl2hGXVwXO5fxEipzwq6RuBUIv+
x-ms-exchange-antispam-messagedata: G0M3526entU2FJ8EYLeuHcV8+8QSkemjCO2Wr8Fhi9Mbv7pf0sHowlslsyevcsH8QZvuex2vkgFoXAs4poIAZ9zh1f71nxWzYaflt+di5RHnVyY0NLUM4YZZ0M4BCVaFrnOcEs1BqeI2fc03EcsKjQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <94DE7B0C92C96348B17A6C4A12ED49CA@GBRP123.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cbed44-be71-4884-898e-08d7bfe9ca01
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 03:11:53.2668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vtln1F6Bps/DiOD8NisC66V480YX2wrsrx+pGw4Mp2/q8QaoW8hlOtkoxEwQffoQ1rrfU/MZsK+byOQsci8PRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB1885
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.71
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
Cc: jsnow@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBjbWQ2NDZfdXBkYXRlX2lycSgpIG9ubHkgc2VlbXMgdG8gcmFpc2UgUENJIGludGVycnVwdCwg
c2hvdWxkIGl0IGFsc28NCj4gaGF2ZSANCj4gYW4gb3B0aW9uIHRvIHVzZSBJTlQgMTQgYW5kIDE1
IGluIGxlZ2FjeSBtb2RlIHNpbWlsYXIgdG8gd2hhdCBteQ0KPiBwYXRjaCANCj4gZG9lcyBmb3Ig
dmlhLWlkZT8NCg0KTG9va2luZyB0aHJvdWdoIC9xZW11L2h3L2lkZS9jbWQ2NDYuYyBpdCBkb2Vz
bid0IGxvb2sgbGlrZSBRRU1VIGhhcw0Kc3VwcG9ydCBmb3IgbGVnYWN5IG1vZGUuIEF0IHRoZSB2
ZXJ5IGxlYXN0LCBpdCBsb29rcyBsaWtlIHdlIGRlZmF1bHQgdG8NClBDSSBuYXRpdmUgbW9kZToN
Cg0Kc3RhdGljIHZvaWQgcGNpX2NtZDY0Nl9pZGVfcmVhbGl6ZShQQ0lEZXZpY2UgKmRldiwgRXJy
b3IgKiplcnJwKQ0KCS4uLg0KCXBjaV9jb25mW1BDSV9DTEFTU19QUk9HXSA9IDB4OGY7DQoJLi4u
DQoNClRvIGFkZCBzdXBwb3J0IGZvciBsZWdhY3kgbW9kZSBpdCB3b3VsZCByZXF1aXJlIGNoYW5n
aW5nDQpjbWQ2NDZfdXBkYXRlX2lycSgpIGFuZCBtYXliZSBjbWQ2NDZfc2V0X2lycSgpIHNvIHRo
YXQgaW50ZXJydXB0cyBhcmUNCmNvbmRpdGlvbmFsbHkgcmFpc2VkIG9uIElSUTE0IGFuZC9vciBJ
UlExNSB3aGVuIHRoZSBwb3J0cyBhcmUgaW4gbGVnYWN5DQptb2RlLg0KDQpUaGFua3MsDQpKYXNw
ZXIgTG93ZWxsLg0KDQoNCk9uIFN1biwgMjAyMC0wMy0wMSBhdCAxOTowMiArMDEwMCwgQkFMQVRP
TiBab2x0YW4gd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4gT24gV2VkLCAyNiBGZWIgMjAyMCwgamFz
cGVyLmxvd2VsbEBidC5jb20gd3JvdGU6DQo+ID4gQWNjb3JkaW5nIHRvIHRoZSBDTUQ2NDZVMiBz
cGVjaWZpY2F0aW9uOg0KPiA+ICJXaGVuIGFuIElERSBwb3J0IGlzIGluIFBDSSBJREUgTGVnYWN5
IE1vZGUsIHRoZSBQQ0k2NDZVMiBpcw0KPiA+IGNvbXBhdGlibGUNCj4gPiB3aXRoIHN0YW5kYXJk
IElTQSBJREUuIFRoZSBJREUgdGFzayBmaWxlIHJlZ2lzdGVycyBhcmUgbWFwcGVkIHRvDQo+ID4g
dGhlDQo+ID4gc3RhbmRhcmQgSVNBIHBvcnQgYWRkcmVzc2VzLCBhbmQgSURFIGRyaXZlIGludGVy
cnVwdHMgb2NjdXIgYXQNCj4gPiBJUlExNA0KPiA+IChwcmltYXJ5KSBvciBJUlExNSAoc2Vjb25k
YXJ5KS4iDQo+ID4gDQo+ID4gSW4gbGVnYWN5IG1vZGUsIElSUTE0IGFuZCBJUlExNSBtaXJyb3Ig
dGhlIHN0YXRlIG9mIElOVFJRIG9uIGVhY2gNCj4gPiBvZg0KPiA+IHRoZSBzZWxlY3RlZCBJREUg
ZGV2aWNlcy4gUUVNVSBhcHBlYXJzIHRvIGVtdWxhdGUgdGhpcyBjb3JyZWN0bHkuDQo+IA0KPiBT
byBDTUQ2NDYgYWxzbyBzZWVtcyB0byBoYXZlIGEgbGVnYWN5IG1vZGUuIEkndmUgYWxzbyBzZWVu
IGEgQ01EDQo+IFBDSTA2NDBCIA0KPiBzcGVjIHdoaWNoIGlzIHByb2FiYWJseSBhIHNpbWlsYXIg
Y2hpcCB3aGljaCBzYXlzIGZvciBpbnRlcnJ1cHQNCj4gaGFuZGxpbmc6DQo+IA0KPiAiV2hlbiBE
U0ExIGlzIHB1bGxlZCBsb3cgZHVyaW5nIHJlc2V0LCBib3RoIElERSBwb3J0cyBhcmUgaW4gUENJ
IElERSANCj4gTGVnYWN5IE1vZGUuIFdoZW4gRFNBMSBoYXMgbm8gcHVsbC1kb3duIGR1cmluZyBy
ZXNldCwgZWFjaCBJREUgcG9ydA0KPiBtYXkgDQo+IGluZGVwZW5kZW50bHkgYmUgc2V0IHRvIFBD
SSBJREUgTGVnYWN5IE1vZGUgb3IgTmF0aXZlIE1vZGUgdmlhIHRoZSANCj4gUHJvZ3JhbW1pbmcg
SW50ZXJmYWNlIEJ5dGUgKGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgUFJPR0lGLCBJbmRleCA5aCku
DQo+IFdoZW4gDQo+IGFuIElERSBwb3J0IGlzIGluIFBDSSBJREUgTGVnYWN5IE1vZGUsIHRoZSBQ
Q0ktMDY0MEIgaXMgY29tcGF0aWJsZQ0KPiB3aXRoIA0KPiBzdGFuZGFyZCBJU0EgSURFLiBUaGUg
SURFIHRhc2sgZmlsZSByZWdpc3RlcnMgYXJlIG1hcHBlZCB0byB0aGUNCj4gc3RhbmRhcmQgDQo+
IElTQSBwb3J0IGFkZHJlc3NlcywgYW5kIElERSBkcml2ZSBpbnRlcnJ1cHRzIG9jY3VyIGF0IElS
UTE0IChwcmltYXJ5KQ0KPiBvciANCj4gSVJRMTUgKHNlY29uZGFyeSkuDQo+IA0KPiBXaGVuIGFu
IElERSBwb3J0IGlzIGluIFBDSSBJREUgTmF0aXZlIE1vZGUsIHRoZSBJREUgdGFzayBmaWxlDQo+
IHJlZ2lzdGVycyANCj4gbWF5IGJlIG1hcHBlZCB0byBub24tc3RhbmRhcmQgcG9ydCBhZGRyZXNz
ZXMsIGFuZCBJREUgZHJpdmUNCj4gaW50ZXJydXB0cyANCj4gb2NjdXIgYXQgUENJIElOVEEuIFRo
ZXJlZm9yZSwgaWYgYm90aCBJREUgcG9ydHMgYXJlIGluIFBDSSBJREUNCj4gTmF0aXZlIA0KPiBN
b2RlLCBkcml2ZSBpbnRlcnJ1cHRzIGZyb20gYm90aCBJREUgcG9ydHMgYXJlIG11bHRpcGxleGVk
IGludG8gUENJDQo+IElOVEEuIA0KPiBJbiB0aGlzIGNhc2UsIHRoZSBpbnRlcnJ1cHQgc3RhdHVz
IGJpdHMgbXVzdCBiZSBwb2xsZWQgdG8gZGV0ZXJtaW5lDQo+IHdoaWNoIA0KPiBJREUgcG9ydCBn
ZW5lcmF0ZWQgdGhlIGludGVycnVwdCwgb3Igd2hldGhlciB0aGUgaW50ZXJydXB0IHdhcw0KPiBn
ZW5lcmF0ZWQgDQo+IGJ5IGFub3RoZXIgUENJIGRldmljZSBzaGFyaW5nIElOVEEgb24gdGhlIGJ1
cy4iDQo+IA0KPiBUaGlzIHNhbWUgZXhwbGFuYXRpb24gYWxzbyBhcHBlYXJzIGluIENNRDY0NiBk
b2MuIFNvIHdoYXQgbW9kZSBpcw0KPiB0aGUgDQo+IFBST0dfSUYgY29uZmlnIHJlZyBzZXQgdG8g
YW5kIGRvIHRoZSBpbnRlcnJ1cHRzIHJhaXNlZCBtYXRjaCB0aGF0PyANCj4gY21kNjQ2X3VwZGF0
ZV9pcnEoKSBvbmx5IHNlZW1zIHRvIHJhaXNlIFBDSSBpbnRlcnJ1cHQsIHNob3VsZCBpdCBhbHNv
DQo+IGhhdmUgDQo+IGFuIG9wdGlvbiB0byB1c2UgSU5UIDE0IGFuZCAxNSBpbiBsZWdhY3kgbW9k
ZSBzaW1pbGFyIHRvIHdoYXQgbXkNCj4gcGF0Y2ggDQo+IGRvZXMgZm9yIHZpYS1pZGU/DQo+IA0K
PiBBZGRpdGlvbmFsbHkgU29sYXJpcyBtYXkgYWxzbyBnZXQgaW5mbyBmcm9tIHRoZSBPRiBkZXZp
Y2UgdHJlZSBzbw0KPiB0aGF0IG1heSANCj4gYWxzbyBoYXZlIHRvIG1hdGNoIHRoZSBkZXZpY2Ug
Y29uZmlnLg0KPiANCj4gSSdtIG5vdCBzdXJlIHRoaXMgaGVscHMgYnV0IEkgZG9uJ3QgaGF2ZSBh
bnkgYmV0dGVyIGlkZWEuDQo+IA0KPiBSZWdhcmRzLA0KPiBCQUxBVE9OIFpvbHRhbg0KPiANCg==


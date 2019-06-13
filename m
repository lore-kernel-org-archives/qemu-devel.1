Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C5C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E962173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FzePHAYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E962173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMR7-0001K1-5h
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMPH-0008Jp-GF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMPG-00029H-Dt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:52:31 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com
 ([40.107.0.102]:59136 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMPC-00026b-MA; Thu, 13 Jun 2019 05:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1a3ElHGUAITWfjpIK9LR/9yRwXas5QTYU/6+Xu7zGA=;
 b=FzePHAYBxNsOjCCNUyfQsSwFgRjeucM9+lYJcT65PagCPwS2yVgjk5rgy2JB1a+Qur19BkKfVLDHsTnvknXEqXl3Rp9t/VvXdE+tzMrByWUxf3EZ0CQ9hEMryBu/vYGFvgj6yJzQB/bwgifyx9WXplbBi+BiNuqvF/4L6jiSbq8=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4993.eurprd08.prod.outlook.com (10.255.28.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 09:52:24 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 09:52:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 3/7] iotests: Valgrind fails to work with nonexistent
 directory
Thread-Index: AQHVIH/Vo17tEwtH7ECJB3PFfLbkLqaZWmQA
Date: Thu, 13 Jun 2019 09:52:24 +0000
Message-ID: <1960f611-4650-fa6b-4ccf-7eecd5ca5dc0@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::16)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613125222329
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 780bbf46-338c-4194-573d-08d6efe4d5f7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB4993; 
x-ms-traffictypediagnostic: AM0PR08MB4993:
x-microsoft-antispam-prvs: <AM0PR08MB49939FFAB8D7A79E6D12B572C1EF0@AM0PR08MB4993.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(346002)(39850400004)(366004)(199004)(189003)(102836004)(26005)(486006)(478600001)(476003)(186003)(256004)(66946007)(66446008)(64756008)(66556008)(66476007)(73956011)(2616005)(81156014)(8676002)(446003)(81166006)(11346002)(229853002)(6436002)(86362001)(6486002)(2501003)(14454004)(2201001)(31696002)(107886003)(6246003)(66066001)(53936002)(71190400001)(71200400001)(99286004)(68736007)(6506007)(7736002)(305945005)(386003)(5660300002)(52116002)(76176011)(6512007)(3846002)(6116002)(8936002)(25786009)(31686004)(4326008)(36756003)(2906002)(316002)(54906003)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4993;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cc3YcO99K0MJFTO79eCWsHYwaNIuCg9PHNrx+/C5L6tuNbWqYy0IQrYabVxigWmUBBsEDpc2Oa4skantvdQVgWg4davdzc1uGBL2+fwbYG0Xpu7E9i/H9jMjBX7mJnNuUkAx8nz3ntSSYR2NI75ZEjIsrz8afxPEGQzXwX8Apzz9vDceIFI4sSqA4yDc8bxWVrzzHsiJETVhLKV8yYSwBY2khEcEC4kTMmq+P7nrcvdCKVdMi0kG5WzNNU8W9lr8M3gntXshPYkj5MpaV7ynB5lbf+K1A1tv/mg/4Rk8dZShxcDIEGBgktLdAusJ7ajeb4vp53FF27RnhkIj/pe/iNyT3xCgCAnunZw4SuC/O1a2zMsn0Sgk8K3rcqluE2mLPr5HCXs3tHJVemyxxOCV8jlc5NjvX/Bb/yjFa/suj2g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45551CC02408BD42B8042A05C63DFEC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780bbf46-338c-4194-573d-08d6efe4d5f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:52:24.4800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4993
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.102
Subject: Re: [Qemu-devel] [PATCH v2 3/7] iotests: Valgrind fails to work
 with nonexistent directory
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAyMTowMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBWYWxncmlu
ZCB1c2VzIHRoZSBleHBvcnRlZCB2YXJpYWJsZSBUTVBESVIgYW5kIGZhaWxzIGlmIHRoZQ0KPiBk
aXJlY3RvcnkgZG9lcyBub3QgZXhpc3QuIExldCB1cyBleGNsdWRlIHN1Y2ggYSB0ZXN0IGNhc2Ug
ZnJvbQ0KPiBiZWluZyBydW4gdW5kZXIgdGhlIFZhbGdyaW5kLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQoN
CkhtbSwgaXNuJ3QgaXQgcHJlZmVyYWJsZSB0byBza2lwIHVuc3VwcG9ydGVkIGJ5DQp2YWxncmlu
ZCBpb3Rlc3RzLCBpbnN0ZWFkIHNpbGVudGx5IGRpc2FibGUgdmFsZ3JpbmQgaW4gdGhlbT8NCg0K
PiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDUxIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzA1MSBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNTENCj4gaW5kZXggMjAwNjYwZi4uY2NjNWJjMiAx
MDA3NTUNCj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1MQ0KPiArKysgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMDUxDQo+IEBAIC0zNzcsNiArMzc3LDcgQEAgcHJpbnRmICViICJxZW11LWlvICRk
ZXZpY2VfaWQgXCJ3cml0ZSAtUCAweDMzIDAgNGtcIlxuY29tbWl0ICRkZXZpY2VfaWRcbiIgfA0K
PiAgICRRRU1VX0lPIC1jICJyZWFkIC1QIDB4MzMgMCA0ayIgIiRURVNUX0lNRyIgfCBfZmlsdGVy
X3FlbXVfaW8NCj4gICANCj4gICAjIFVzaW5nIHNuYXBzaG90PW9uIHdpdGggYSBub24tZXhpc3Rl
bnQgVE1QRElSDQoNCih5b3UgY2FuIGFkZCBpbnRvIGNvbW1lbnQ6ICJWYWxncmluZCBuZWVkcyBU
TVBESVIsIHNvIGRpc2FibGUgaXQiDQoNCj4gK1ZBTEdSSU5EX1FFTVU9IiIgXA0KPiAgIFRNUERJ
Uj0vbm9uZXhpc3RlbnQgcnVuX3FlbXUgLWRyaXZlIGRyaXZlcj1udWxsLWNvLHNuYXBzaG90PW9u
DQo+ICAgDQo+ICAgIyBVc2luZyBzbmFwc2hvdD1vbiB0b2dldGhlciB3aXRoIHJlYWQtb25seT1v
bg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


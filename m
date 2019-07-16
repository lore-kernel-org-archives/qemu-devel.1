Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E1DC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9863620665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b1pCS31Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9863620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnN6o-0008KH-HK
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnN6Y-0007vm-67
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hnN6X-0005XU-1k
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:02:50 -0400
Received: from mail-eopbgr40104.outbound.protection.outlook.com
 ([40.107.4.104]:44263 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hnN6W-0005Wc-RN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:02:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2N0H0Kehjgo1Ozb6TK8sYh1ii2jpvH+jL9b8BvdZnS6pH3jhKLu7EdErRNzlLmSftytTs9IN+V8hckOP3jPjVJr4vPXhr/ZpX+GbtnEidwJ8fkZ8tsbCbSL7BlbacD2VMCv0wOQRqfWDTNL3vwYdGcKRsZwfMiWWMa0djQAW7RpmImthH6blE3WIEIJACloMH/YMFqMAXGDVJdmrcdyZ711dxhFjKAAS16wVDMUrmeZB129aP84XJHoQhEjkcuDC+xjuf1bTJN4jK4h3FsmA/E9c1Tz0qfiVBWQTFdIRka2ZbRZalNiWhtNDfYUt8UdzNg5nvyJXc96LZ1H/C5IPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzHae4mqvvoBRgNkQ0BwzU6iU+zvOozRQuHa7/v4Cjs=;
 b=Au3fO3Gn+DPGdz5tJVRG/vLIPJ6J/A12nYT7BkStc9+vVBD95i+koTWuTrgMpojRgicP1Ck4ddUkbIwJbxrfnBxtg22ZyPiq2kBTsnjYIASO0gROWcAZLb1AvgvT19VSEXZjnMtFhaYY9d9vJlx+h2FEXod5cfMO6uChkBxo7dSxBT9F7t+tBxgMa/qJD3LPkVJ3wVyXuBAUx2bZR7aAqM5h4OtddKcrkRnFoWj+SUjeGawEiwl6xulcUzGEJLZV764NjJfVWXqe+Zyn4ypmM1MTSGpkMXjR9bmQ/ihe8sytV1HJdD6dnh4rt6NvjTdUU8gxXyUWCWoaYt4lzGtaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzHae4mqvvoBRgNkQ0BwzU6iU+zvOozRQuHa7/v4Cjs=;
 b=b1pCS31QyKPpRPcBQ51JQHnmVVlnHq++pDg3/0exJ4V5CYZnD0KmEkj59/NGcO9XOOGwL7PNehyEQfBPsBGTb8o9Ll7yPOwXkmP4GXgnZgHe1YLpFRoJ3BCozOizgA7iPKYNJBUpYmxELTX/nT/v9l+0si/3rUlJFbvCr5PkIuw=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB5392.eurprd08.prod.outlook.com (52.133.245.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Tue, 16 Jul 2019 13:02:31 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::4c3d:79b3:a884:18c4%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 13:02:31 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
Thread-Index: AQHVOOZ1DwB6Iz4ObkKXlmNSu3G56abL8iuAgAFJeoA=
Date: Tue, 16 Jul 2019 13:02:31 +0000
Message-ID: <9c92d2d8-acc9-4a68-5db2-4d341cb3db4e@virtuozzo.com>
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
In-Reply-To: <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0074.eurprd07.prod.outlook.com
 (2603:10a6:3:64::18) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7fa21af-b45f-47d4-e425-08d709eddd0a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB5392; 
x-ms-traffictypediagnostic: VI1PR08MB5392:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB5392CBC661284464BE264C54F4CE0@VI1PR08MB5392.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(39850400004)(346002)(136003)(376002)(396003)(366004)(199004)(189003)(14454004)(316002)(68736007)(110136005)(25786009)(2501003)(186003)(71190400001)(26005)(52116002)(8936002)(4326008)(5660300002)(54906003)(229853002)(102836004)(44832011)(71200400001)(6116002)(99286004)(966005)(76176011)(478600001)(305945005)(7736002)(86362001)(8676002)(53936002)(66476007)(66556008)(66446008)(66946007)(486006)(64756008)(256004)(6512007)(31696002)(36756003)(6246003)(107886003)(6486002)(386003)(2616005)(11346002)(4744005)(2906002)(6506007)(6436002)(3846002)(66066001)(446003)(53546011)(81156014)(81166006)(6306002)(476003)(31686004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB5392;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HZA14hm2EhqC7i1/In4ryMsFNlBj2LM3/t3+f683H4+MLqV0zUqAsJgfISf0UZgES483caLnZOuT9tVX7e4TKSczPTob9x2lAmYlGYDrQLcEOzWC1+uh6Nw75nvckjgF/2KBUGCWK0ejxF4bAyOUqVcm13x6V/XQiS4KRwjKnz9S/gTBWS0ixORd/GN4i+eJ9ND5yJY75gqxYN7uM0iGtv6WDTkpJpGmS3YEvP02Gyb2oTZhPTiLLYBERA6NQPwHKbmLE+vQ3ZPIwytc/iIMcHHS4ASIA1kGi+mBtyy9k0rEOIMTSwtGF3IyrGAHvnLFyh377xwTeXZdRmOt9Nm3Vj0TegNsbrPPGkdbXoskY1m57AZ16g1Djp/97rK7XqLIhl+jKqrJMkQGI6CM9u1LXPkP3oPTMy+EMD5TIZeNM9k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16ACCC2126E2A14F89AA9FEC996C3CE0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fa21af-b45f-47d4-e425-08d709eddd0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 13:02:31.7881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5392
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.104
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Roman Kagan <rkagan@virtuozzo.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE1LzA3LzIwMTkgMjA6MjMsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMTIuMDcuMTkg
MjE6MTcsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gV2hlbiB0Y3BfY2hyX2Rpc2Nvbm5l
Y3QoKSBpcyBjYWxsZWQsIG90aGVyIHRocmVhZCBtYXkgYmUgc3RpbGwgd3JpdGluZw0KPj4gdG8g
dGhlIGNoYW5uZWwuIFRoaXMgcGF0Y2ggcHJvdGVjdHMgb25seSByZWFkIG9wZXJhdGlvbnMgdGhh
dCBpbml0aWF0ZQ0KPj4gdGhlIGRpc2Nvbm5lY3Rpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
QW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiAt
LS0NCj4gDQo+IEhhdmUgeW91IGxvb2tlZCBhdA0KPiBodHRwczovL2xpc3RzLm5vbmdudS5vcmcv
YXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOS0wMi9tc2cwNjE3NC5odG1sDQo+IGFscmVhZHk/
ICBGcm9tIGEgZ2xhbmNlLCBpdCBsb29rcyBsaWtlIHRoYXQgc2VyaWVzIHN1cGVyc2VkZXMgdGhp
cyBvbmUuDQo+IA0KDQpObywgSSBoYWQgbWlzc2VkIHRoYXQgc2VyaWVzIHdoZW4gSSB0YWNrbGVk
IHRvIHJlc29sdmUgdGhlIGlzc3VlLg0KVGhhbmsgeW91IE1heCBmb3IgbGV0dGluZyBtZSBrbm93
LiBQbGVhc2UgaW5jbHVkZSBtZSB0byBjYyB0aGVyZS4NCk15IHNlcmllcyByZXNvbHZlcyB0aGUg
cGFydGljdWxhciBjYXNlLiBUaGUgdGVzdHMgcGFzcy4NCg0KQW5kcmV5DQoNCj4gKE5vLCBJIGRv
buKAmXQga25vdyB3aHkgdGhlIG90aGVyIHNlcmllcyBpcyBkZWxheWVkLiAgSSBrZWVwIHJlbWlu
ZGluZw0KPiBQYW9sbyBvZiBpdC4pDQo+IA0KPiBNYXgNCj4gDQoNCi0tIA0KV2l0aCB0aGUgYmVz
dCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg0K


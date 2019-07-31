Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E8C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2797206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Fo777J2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2797206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsnMO-0006dH-20
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 08:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hsnLh-00064j-4D
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hsnLf-0006bU-TK
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:04:53 -0400
Received: from mail-eopbgr80101.outbound.protection.outlook.com
 ([40.107.8.101]:60771 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hsnLc-0006Y7-W5; Wed, 31 Jul 2019 08:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grpHDtWprOVhDeYy0o00wtmflcvu4mJXbxwCQ2Fn/K4C7cjFytu1++DlYCpTCjJ5rV9TC1L3G21c9i9cWWC3gpt/M9Tz1jMe7qKUFcv1ycma1YsqFOPpWgCAFLQikkf5my0nOppiyqwL7Q5omW3ikK4zssF6eQVdcS+3qN2NY4J+6cgub0HOKYzMwDXsm5//tN1RTrjAJ6X5zzBISqowLY/y3/kG4Hwcsc8H7PnyAgY+ASzY6A3BaCIIqEqi+NniNZ5LHng+S7tW+Wn7cW5rfDww4Lyv38t4JjdGGO0icq/iomWXEMbFUbnm9ebOetgc+n8aZXvxoe0XVnga1Xwh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yilQWr7gqdzBqbFGRwV7j8g6Cey0XHXd2U0NVWn2ZG0=;
 b=NvK8Wlmc9X1iSE6zoWRmJOAgMid0yYyRCnlCCm10WpQwlU4qnLoDYrQBsH7mJlV67bUaoPv2spJgR9T3RfAu1gOQExlrqzwm2+YmNpKAjU/dQqI0S/wJicfTCFf1DgxKyRWl7H2U6uop/Ekcr9ps7jim8PflLVGZUfLspTRmqBniSOb0FHlnWayW+4r8NZlqfsr+YfHJAfjZEFjMj66LE9kTj7GBuvJcLENQIxaXoE1Z3bV2LYk5xKSZLgH6/6L4yflLk+Sj7ypDYRK9NIS5l+Gg4if2nSun2nX/Oizomjpr4wyQ0fvLh1bnLi1Ch9s8nGw1385eATDA8yLpImbgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yilQWr7gqdzBqbFGRwV7j8g6Cey0XHXd2U0NVWn2ZG0=;
 b=Fo777J2FPnHx653/I0nKZsdIrxW5W8D1O0vcjTxwfgFSGfpZeEyBPye04VlL26Plj5EpwA+gJnk58C/IAPjSN8egryaPmwhrQwxwryDxrnS2DHTI/FKHzL9S8+IDQFtjxJckImIjMjdfhuxmitjtOcotcxKQck2SRXZdKx3yvF8=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3469.eurprd08.prod.outlook.com (20.177.59.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:04:45 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:04:44 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 3/3] i386/kvm: initialize struct at full before ioctl call
Thread-Index: AQHVRvAnLLtzNA+T0EeBbI/1wGIp+qbjic2AgADKawCAAE4tAA==
Date: Wed, 31 Jul 2019 12:04:44 +0000
Message-ID: <08958a7e-1952-caf7-ab45-2fd503db418c@virtuozzo.com>
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1564502498-805893-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <14b60c5b-6ed4-0f4d-17a8-6ec861115c1e@redhat.com>
 <30f40221-d2d2-780b-3375-910e9f755edd@de.ibm.com>
In-Reply-To: <30f40221-d2d2-780b-3375-910e9f755edd@de.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::35)
 To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ab02044-8263-48a3-3822-08d715af46be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3469; 
x-ms-traffictypediagnostic: VI1PR08MB3469:
x-microsoft-antispam-prvs: <VI1PR08MB3469E7E52B6E049612BC837CF4DF0@VI1PR08MB3469.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(376002)(39850400004)(136003)(346002)(199004)(189003)(66476007)(102836004)(86362001)(6116002)(66556008)(52116002)(71190400001)(186003)(107886003)(36756003)(486006)(99286004)(64756008)(71200400001)(53546011)(3846002)(76176011)(66066001)(386003)(44832011)(305945005)(66446008)(54906003)(6506007)(66946007)(7416002)(6512007)(5660300002)(110136005)(31696002)(4326008)(229853002)(256004)(6486002)(53936002)(476003)(81166006)(31686004)(11346002)(2616005)(316002)(26005)(68736007)(2201001)(6246003)(6436002)(8676002)(2501003)(7736002)(8936002)(446003)(81156014)(478600001)(25786009)(14454004)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3469;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Arcn5437whNXUyLF2PB4nMOXWlr4kTb/S01Ee+K2HbvkkvOwy/CGIWYGqtyBbGBvaoRzT6R+u8UmKTcEkCWBCRoPlDJ8dsOsWh26mp/BhT/Uwlj/1G3PCJVCTgyqxwUoY+ZkSQLbXl4/Sq35D3rDRdvru+BhojASYibZWk44iSdas3qaVuprPa8641n1CfgxyMUieG1zrQZOZbB+jKeTL10+Zt2/azuD+x8KN/p7s7i49a2Wp/kQGXORugKl0ivULnVx0JYbZr17M8b5T913ZGvzXKHNkW9en1VOYAxnKnyx1COokPJ8jpb1L4QjX8+hPY+NcYh5KETEInLkx1HoKvYh4wWvG/LkRtJhKT4I2sRA98Gt5Hu2xWFHu1N01JdwWGhVSUKqd/dXl8cCaQSEHwvlzgEyOV0HkYs8ARq8Z68=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEBD0B39DB78A6469C8D26470591EE39@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab02044-8263-48a3-3822-08d715af46be
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:04:44.8424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3469
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.101
Subject: Re: [Qemu-devel] [PATCH 3/3] i386/kvm: initialize struct at full
 before ioctl call
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Denis Lunev <den@virtuozzo.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMzEvMDcvMjAxOSAxMDoyNCwgQ2hyaXN0aWFuIEJvcm50cmFlZ2VyIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDMwLjA3LjE5IDIxOjIwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPj4gT24gMzAvMDcv
MTkgMTg6MDEsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4+IE5vdCB0aGUgd2hvbGUgc3Ry
dWN0dXJlIGlzIGluaXRpYWxpemVkIGJlZm9yZSBwYXNzaW5nIGl0IHRvIHRoZSBLVk0uDQo+Pj4g
UmVkdWNlIHRoZSBudW1iZXIgb2YgVmFsZ3JpbmQgcmVwb3J0cy4NCj4+Pg0KPj4+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29t
Pg0KPj4NCj4+IENocmlzdGlhbiwgaXMgdGhpcyB0aGUgcmlnaHQgZml4PyAgSXQncyBub3QgZXhw
ZW5zaXZlIHNvIGl0IHdvdWxkbid0IGJlDQo+PiBhbiBpc3N1ZSwganVzdCBjaGVja2luZyBpZiB0
aGVyZSdzIGFueSBiZXR0ZXIgYWx0ZXJuYXRpdmUuDQo+IA0KPiBJIHRoaW5rIGFsbCBvZiB0aGVz
ZSB2YXJpYW50cyBhcmUgdmFsaWQgd2l0aCBwcm9zIGFuZCBjb25zDQo+IDEuIHRlYWNoIHZhbGdy
aW5kIGFib3V0IHRoaXM6DQo+IEFkZCB0byBjb3JlZ3JpbmQvbV9zeXN3cmFwL3N5c3dyYXAtbGlu
dXguYyAoYW5kIHRoZSByZWxldmFudCBoZWFkZXIgZmlsZXMpDQo+IGtub3dsZWRnZSBhYm91dCB3
aGljaCBwYXJ0cyBhcmUgYWN0dWFsbHkgdG91Y2hlZC4NCj4gMi4gdXNlIGRlc2lnbmF0ZWQgaW5p
dGlhbGl6ZXJzDQo+IDMuIHVzZSBtZW1zZXQNCj4gMy4gdXNlIGEgdmFsZ3JpbmQgY2FsbGJhY2sg
VkdfVVNFUlJFUV9fTUFLRV9NRU1fREVGSU5FRCB0byB0ZWxsIHRoYXQgdGhpcyBtZW1vcnkgaXMg
ZGVmaW5lZA0KPiANCg0KVGhhbmsgeW91IGFsbCB2ZXJ5IG11Y2ggZm9yIHRha2luZyBwYXJ0IGlu
IHRoZSBkaXNjdXNzaW9uLg0KQWxzbywgb25lIG1heSB1c2UgdGhlIFZhbGdyaW5kIHRlY2hub2xv
Z3kgdG8gc3VwcHJlc3MgdGhlIHVud2FudGVkIA0KcmVwb3J0cyBieSBhZGRpbmcgdGhlIFZhbGdy
aW5kIHNwZWNpZmljIGZvcm1hdCBmaWxlIHZhbGdyaW5kLnN1cHAgdG8gdGhlIA0KUUVNVSBwcm9q
ZWN0LiBUaGUgZmlsZSBjb250ZW50IGlzIGV4dGVuZGFibGUgZm9yIGZ1dHVyZSBuZWVkcy4NCkFs
bCB0aGUgY2FzZXMgd2UgbGlrZSB0byBzdXBwcmVzcyB3aWxsIGJlIHJlY291bnRlZCBpbiB0aGF0
IGZpbGUuDQpBIGNhc2UgbG9va3MgbGlrZSB0aGUgc3RhY2sgZnJhZ21lbnRzLiBGb3IgaW5zdGFu
Y2UsIGZyb20gUUVNVSBibG9jazoNCg0Kew0KICAgIGh3L2Jsb2NrL2hkLWdlb21ldHJ5LmMNCiAg
ICBNZW1jaGVjazpDb25kDQogICAgZnVuOmd1ZXNzX2Rpc2tfbGNocw0KICAgIGZ1bjpoZF9nZW9t
ZXRyeV9ndWVzcw0KICAgIGZ1bjpibGtjb25mX2dlb21ldHJ5DQogICAgLi4uDQogICAgZnVuOmRl
dmljZV9zZXRfcmVhbGl6ZWQNCiAgICBmdW46cHJvcGVydHlfc2V0X2Jvb2wNCiAgICBmdW46b2Jq
ZWN0X3Byb3BlcnR5X3NldA0KICAgIGZ1bjpvYmplY3RfcHJvcGVydHlfc2V0X3FvYmplY3QNCiAg
ICBmdW46b2JqZWN0X3Byb3BlcnR5X3NldF9ib29sDQp9DQoNClRoZSBudW1iZXIgb2Ygc3VwcHJl
c3NlZCBjYXNlcyBhcmUgcmVwb3J0ZWQgYnkgdGhlIFZhbGdyaW5kIHdpdGggZXZlcnkgDQpydW46
ICJFUlJPUiBTVU1NQVJZOiA1IGVycm9ycyBmcm9tIDMgY29udGV4dHMgKHN1cHByZXNzZWQ6IDAg
ZnJvbSAwKSINCg0KQW5kcmV5DQoNCj4+DQo+PiBQYW9sbw0KPj4NCj4+PiAtLS0NCj4+PiAgIHRh
cmdldC9pMzg2L2t2bS5jIHwgMyArKysNCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9rdm0uYyBiL3RhcmdldC9p
Mzg2L2t2bS5jDQo+Pj4gaW5kZXggZGJiYjEzNy4uZWQ1N2UzMSAxMDA2NDQNCj4+PiAtLS0gYS90
YXJnZXQvaTM4Ni9rdm0uYw0KPj4+ICsrKyBiL3RhcmdldC9pMzg2L2t2bS5jDQo+Pj4gQEAgLTE5
MCw2ICsxOTAsNyBAQCBzdGF0aWMgaW50IGt2bV9nZXRfdHNjKENQVVN0YXRlICpjcykNCj4+PiAg
ICAgICAgICAgcmV0dXJuIDA7DQo+Pj4gICAgICAgfQ0KPj4+ICAgDQo+Pj4gKyAgICBtZW1zZXQo
Jm1zcl9kYXRhLCAwLCBzaXplb2YobXNyX2RhdGEpKTsNCj4+PiAgICAgICBtc3JfZGF0YS5pbmZv
Lm5tc3JzID0gMTsNCj4+PiAgICAgICBtc3JfZGF0YS5lbnRyaWVzWzBdLmluZGV4ID0gTVNSX0lB
MzJfVFNDOw0KPj4+ICAgICAgIGVudi0+dHNjX3ZhbGlkID0gIXJ1bnN0YXRlX2lzX3J1bm5pbmco
KTsNCj4+PiBAQCAtMTcwNiw2ICsxNzA3LDcgQEAgaW50IGt2bV9hcmNoX2luaXRfdmNwdShDUFVT
dGF0ZSAqY3MpDQo+Pj4gICANCj4+PiAgICAgICBpZiAoaGFzX3hzYXZlKSB7DQo+Pj4gICAgICAg
ICAgIGVudi0+eHNhdmVfYnVmID0gcWVtdV9tZW1hbGlnbig0MDk2LCBzaXplb2Yoc3RydWN0IGt2
bV94c2F2ZSkpOw0KPj4+ICsgICAgICAgIG1lbXNldChlbnYtPnhzYXZlX2J1ZiwgMCwgc2l6ZW9m
KHN0cnVjdCBrdm1feHNhdmUpKTsNCj4+PiAgICAgICB9DQo+Pj4gICANCj4+PiAgICAgICBtYXhf
bmVzdGVkX3N0YXRlX2xlbiA9IGt2bV9tYXhfbmVzdGVkX3N0YXRlX2xlbmd0aCgpOw0KPj4+IEBA
IC0zNDc3LDYgKzM0NzksNyBAQCBzdGF0aWMgaW50IGt2bV9wdXRfZGVidWdyZWdzKFg4NkNQVSAq
Y3B1KQ0KPj4+ICAgICAgICAgICByZXR1cm4gMDsNCj4+PiAgICAgICB9DQo+Pj4gICANCj4+PiAr
ICAgIG1lbXNldCgmZGJncmVncywgMCwgc2l6ZW9mKGRiZ3JlZ3MpKTsNCj4+PiAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgNDsgaSsrKSB7DQo+Pj4gICAgICAgICAgIGRiZ3JlZ3MuZGJbaV0gPSBlbnYt
PmRyW2ldOw0KPj4+ICAgICAgIH0NCj4+PiAtLSANCj4+PiAxLjguMy4xDQo+Pj4NCj4+DQo+Pg0K
PiANCg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K


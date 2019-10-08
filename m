Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76784C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F97120673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dMt6oQ7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F97120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHldQ-0006sl-Nx
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlaV-00051L-DD
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHlaT-0006Pt-RK
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:15:23 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com
 ([40.107.4.129]:33094 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHlaT-0006NF-IJ; Tue, 08 Oct 2019 05:15:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4rs9wJedNm7QLPsVZ+ydzsCnC5M82hDoxnLZUfz63hOesVAYL2P64TL3zVSkHYTjZeXRwib956fpulKZkvpCm6hOzAaxmV8lWzREiVeuRQzj6mWNv30SOgive3nh2SzkvL1ZDcqRlPeNYK0ugA81hGFaedyLJ1hlTO8K2VKYToLsRoONfNbXPvRIrnF7oJuiJkMiOH7jz8/o2vAbjpHZSC8Unj0ab75NDawUSv6zqgPxxRDBg707wKH/mzmbCoVgTiQMoAzZBt6ExVXXpt4yB648/BUimjd1BN/W5c7hv4RvP5UNYDatQGq5jXgXAdJVqxN3ucvIDnxavZEDR9IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNjj6k5NoW6tYnm2vXC54qFylnLmgLHfjjW2Cg5Wtpo=;
 b=epj0mEqjnAfibhoAbUYZwqtC5wKAOtfqNMfUJMN5bvXrZ77iPm57MNX1SRbhuRRAKEpIJbQg58LRb1QgbVC08Ta2QBlExvL3kqaXEUDgJ1fSMSa6Xzvi1HQnU9Bxq/Dp/58+Q/xLETQMyzo3qm79WCH1Rb7sB2J51o5rYTD5xVZU+tKG6R2/Ascgf9DQzHjz3Z4mZhRaiQeFD+MFAqAF9LjRIN4k1mGfYfoQGmpojLIclWLYeBgXKcLsg2VJqN9JjmWw509pDDa0U6gKlvrE7ECKdIG0Y64ON90EzDGYnY+8HrzA5ss2D754jBlsWHXFQ/HOsl6PvClqTPPxma5DyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNjj6k5NoW6tYnm2vXC54qFylnLmgLHfjjW2Cg5Wtpo=;
 b=dMt6oQ7It/crRk0bLJO6i+qQaaQ8NfImty3+T3uNYtrixbba4uYEegzAWwOWrcQkb6kHnI2u73i4IfNDYqQiH5uxQzAbFqqKOyVlinY/oW7Ad/Bvfc9zy4phn/tV/6hX/1TvSBKw4Nxmrp0nEQHYkByaNSNG5lnxNVIZP9isBR4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5417.eurprd08.prod.outlook.com (52.133.241.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Tue, 8 Oct 2019 09:15:17 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 09:15:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 5/6] block/block-copy: add memory limit
Thread-Topic: [PATCH 5/6] block/block-copy: add memory limit
Thread-Index: AQHVeg4yoh/rEPB1r0SkNCk9cwC6DKdPU0UAgAAc4QCAAQodgIAAA2kA
Date: Tue, 8 Oct 2019 09:15:17 +0000
Message-ID: <c6cfb56c-970d-ab44-ee93-639c65370dc2@virtuozzo.com>
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-6-vsementsov@virtuozzo.com>
 <8aa011d7-3f11-2df5-d77e-5c5176ab63ed@redhat.com>
 <49b99621-2d8a-f4a8-d31a-e64a727952a9@virtuozzo.com>
 <8bd41e8a-acfb-8f55-b2d3-ae909dc21ae7@redhat.com>
In-Reply-To: <8bd41e8a-acfb-8f55-b2d3-ae909dc21ae7@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0169.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191008121514678
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68c82b85-1e97-458f-f2e9-08d74bd00928
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600168)(711020)(4605104)(1401328)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5417; 
x-ms-traffictypediagnostic: DB8PR08MB5417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5417FF64CF36EC54EFDF5D00C19A0@DB8PR08MB5417.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:55;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(31696002)(102836004)(53546011)(6116002)(2616005)(6486002)(14454004)(2501003)(6506007)(305945005)(81166006)(66946007)(71200400001)(8676002)(5660300002)(11346002)(66446008)(64756008)(8936002)(25786009)(81156014)(386003)(52116002)(478600001)(66556008)(71190400001)(7736002)(99286004)(186003)(26005)(446003)(229853002)(54906003)(6246003)(486006)(6512007)(2906002)(36756003)(3846002)(316002)(66066001)(76176011)(66476007)(110136005)(107886003)(6436002)(256004)(31686004)(14444005)(4326008)(476003)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5417;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IEZ7G3zSI9jT2ya8bxROm4Dj7rcU6Vhk6b1iWOCDEjbnadubC1HMweM8Sq+/VmVeQpyNlhW4suacGfpGPw8ocBIQ13HtHPTHFvMj/OtvOZZGJdUFCwMUtqBm2BPDJDkyDTmX0v/rH464ke1jegx+aH8XhleRVi5cZpi/zcaRSt6AQF3lBJjkaaTs7qfJLjLXiTtTc6nQnq3d9Vxqq3T1xZucxowMKcowAm7F8VBwO8llRRXeX4HfDXEKl90T9JK1ocy4xedsLXyDmdZ+wCsaQGG1hM+4Mf0PG6NOAGkcm90I+fpvdFphtsqNKEVUZGYIm+/0gDyzq/6ioaEjktXYYsT8IVo5D8WOTPjq2j+etR/6nHRhwXuuNP21JCudT3g2EoMAI9QKf3XzKo50Jrmbr7KhUHDKhomb77Ph1ddCvfg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E38EBE713B04048B7CF7E851D642CF4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c82b85-1e97-458f-f2e9-08d74bd00928
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 09:15:17.6454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YsIFOjKHQqNhPRFh/ymoRwLGnpY2Nvne4zSNt2nzXvjVnevjxVopYX3woVkERfiPm4njBaYdBJk74rLl0pgZuhs2IhcEXZU9X5yh9iknFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5417
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.129
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxMjowMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNy4xMC4xOSAxOToxMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA3LjEwLjIwMTkgMTg6Mjcs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwMy4xMC4xOSAxOToxNSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gQ3VycmVudGx5IHRvdGFsIGFsbG9jYXRpb24gZm9y
IHBhcmFsbGVsIHJlcXVlc3RzIHRvIGJsb2NrLWNvcHkgaW5zdGFuY2UNCj4+Pj4gaXMgdW5saW1p
dGVkLiBMZXQncyBsaW1pdCBpdCB0byAxMjggTWlCLg0KPj4+Pg0KPj4+PiBGb3Igbm93IGJsb2Nr
LWNvcHkgaXMgdXNlZCBvbmx5IGluIGJhY2t1cCwgc28gYWN0dWFsbHkgd2UgbGltaXQgdG90YWwN
Cj4+Pj4gYWxsb2NhdGlvbiBmb3IgYmFja3VwIGpvYi4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgaW5jbHVkZS9ibG9jay9ibG9jay1jb3B5LmggfCAzICsrKw0K
Pj4+PiAgICBibG9jay9ibG9jay1jb3B5LmMgICAgICAgICB8IDUgKysrKysNCj4+Pj4gICAgMiBm
aWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYmxvY2svYmxvY2stY29weS5oIGIvaW5jbHVkZS9ibG9jay9ibG9jay1jb3B5LmgNCj4+
Pj4gaW5kZXggZTJlMTM1ZmYxYi4uYmI2NjZlNzA2OCAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVk
ZS9ibG9jay9ibG9jay1jb3B5LmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9jay1jb3B5
LmgNCj4+Pj4gQEAgLTE2LDYgKzE2LDcgQEANCj4+Pj4gICAgI2RlZmluZSBCTE9DS19DT1BZX0gN
Cj4+Pj4gICAgDQo+Pj4+ICAgICNpbmNsdWRlICJibG9jay9ibG9jay5oIg0KPj4+PiArI2luY2x1
ZGUgInFlbXUvY28tc2hhcmVkLWFtb3VudC5oIg0KPj4+PiAgICANCj4+Pj4gICAgdHlwZWRlZiBz
dHJ1Y3QgQmxvY2tDb3B5SW5GbGlnaHRSZXEgew0KPj4+PiAgICAgICAgaW50NjRfdCBzdGFydF9i
eXRlOw0KPj4+PiBAQCAtNjksNiArNzAsOCBAQCB0eXBlZGVmIHN0cnVjdCBCbG9ja0NvcHlTdGF0
ZSB7DQo+Pj4+ICAgICAgICAgKi8NCj4+Pj4gICAgICAgIFByb2dyZXNzUmVzZXRDYWxsYmFja0Z1
bmMgcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2s7DQo+Pj4+ICAgICAgICB2b2lkICpwcm9ncmVzc19v
cGFxdWU7DQo+Pj4+ICsNCj4+Pj4gKyAgICBRZW11Q29TaGFyZWRBbW91bnQgKm1lbTsNCj4+Pj4g
ICAgfSBCbG9ja0NvcHlTdGF0ZTsNCj4+Pj4gICAgDQo+Pj4+ICAgIEJsb2NrQ29weVN0YXRlICpi
bG9ja19jb3B5X3N0YXRlX25ldyhCZHJ2Q2hpbGQgKnNvdXJjZSwgQmRydkNoaWxkICp0YXJnZXQs
DQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9ibG9jay1jb3B5LmMgYi9ibG9jay9ibG9jay1jb3B5
LmMNCj4+Pj4gaW5kZXggY2M0OWQyMzQ1ZC4uZTcwMGMyMGQwZiAxMDA2NDQNCj4+Pj4gLS0tIGEv
YmxvY2svYmxvY2stY29weS5jDQo+Pj4+ICsrKyBiL2Jsb2NrL2Jsb2NrLWNvcHkuYw0KPj4+PiBA
QCAtMjEsNiArMjEsNyBAQA0KPj4+PiAgICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPj4+PiAg
ICANCj4+Pj4gICAgI2RlZmluZSBCTE9DS19DT1BZX01BWF9DT1BZX1JBTkdFICgxNiAqIE1pQikN
Cj4+Pj4gKyNkZWZpbmUgQkxPQ0tfQ09QWV9NQVhfTUVNICgxMjggKiBNaUIpDQo+Pj4+ICAgIA0K
Pj4+PiAgICBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gYmxvY2tfY29weV93YWl0X2luZmxpZ2h0
X3JlcXMoQmxvY2tDb3B5U3RhdGUgKnMsDQo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IHN0YXJ0LA0KPj4+PiBAQCAt
NjQsNiArNjUsNyBAQCB2b2lkIGJsb2NrX2NvcHlfc3RhdGVfZnJlZShCbG9ja0NvcHlTdGF0ZSAq
cykNCj4+Pj4gICAgICAgIH0NCj4+Pj4gICAgDQo+Pj4+ICAgICAgICBiZHJ2X3JlbGVhc2VfZGly
dHlfYml0bWFwKHMtPnNvdXJjZS0+YnMsIHMtPmNvcHlfYml0bWFwKTsNCj4+Pj4gKyAgICBxZW11
X2NvX3NoYXJlZF9hbW91bnRfZnJlZShzLT5tZW0pOw0KPj4+PiAgICAgICAgZ19mcmVlKHMpOw0K
Pj4+PiAgICB9DQo+Pj4+ICAgIA0KPj4+PiBAQCAtOTUsNiArOTcsNyBAQCBCbG9ja0NvcHlTdGF0
ZSAqYmxvY2tfY29weV9zdGF0ZV9uZXcoQmRydkNoaWxkICpzb3VyY2UsIEJkcnZDaGlsZCAqdGFy
Z2V0LA0KPj4+PiAgICAgICAgICAgIC5jbHVzdGVyX3NpemUgPSBjbHVzdGVyX3NpemUsDQo+Pj4+
ICAgICAgICAgICAgLmxlbiA9IGJkcnZfZGlydHlfYml0bWFwX3NpemUoY29weV9iaXRtYXApLA0K
Pj4+PiAgICAgICAgICAgIC53cml0ZV9mbGFncyA9IHdyaXRlX2ZsYWdzLA0KPj4+PiArICAgICAg
ICAubWVtID0gcWVtdV9jb19zaGFyZWRfYW1vdW50X25ldyhCTE9DS19DT1BZX01BWF9NRU0pLA0K
Pj4+PiAgICAgICAgfTsNCj4+Pj4gICAgDQo+Pj4+ICAgICAgICBzLT5jb3B5X3JhbmdlX3NpemUg
PSBRRU1VX0FMSUdOX0RPV04obWF4X3RyYW5zZmVyLCBjbHVzdGVyX3NpemUpLA0KPj4+PiBAQCAt
MzE2LDcgKzMxOSw5IEBAIGludCBjb3JvdXRpbmVfZm4gYmxvY2tfY29weShCbG9ja0NvcHlTdGF0
ZSAqcywNCj4+Pj4gICAgDQo+Pj4+ICAgICAgICAgICAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAo
cy0+Y29weV9iaXRtYXAsIHN0YXJ0LCBjaHVua19lbmQgLSBzdGFydCk7DQo+Pj4+ICAgIA0KPj4+
PiArICAgICAgICBxZW11X2NvX2dldF9hbW91bnQocy0+bWVtLCBjaHVua19lbmQgLSBzdGFydCk7
DQo+Pj4NCj4+PiBOb3cgdGhhdCBJIHNlZSBpdCBsaWtlIHRoaXMsIG1heWJlIHRoZSBuYW1lIGlz
IHRvbyBzaG9ydC4gIFRoaXMgc291bmRzDQo+Pj4gbGlrZSBpdCB3YXMgdHJ5aW5nIHRvIGdldCBz
b21lIGFtb3VudCBvZiBjb3JvdXRpbmVzLg0KPj4+DQo+Pj4gV291bGQg4oCccWVtdV9jb19nZXRf
ZnJvbV9zaGFyZWRfYW1vdW504oCdIGJlIHRvbyBsb25nPyAgKFNvbWV0aGluZyBsaWtlDQo+Pj4g
cWVtdV9jb19zaGFtX2FsbG9jKCkgd291bGQgYmUgZnVubnksIGJ1dCBtYXliZSBub3QuICA6LSkg
IE9yIG1heWJlDQo+Pj4gZXhhY3RseSBiZWNhdXNlIGl04oCdcyBmdW5ueS4pDQo+Pj4NCj4+DQo+
PiBobW0gc2hhbSBtYXkgYmUgaW50ZXJwcmV0ZWQgYXMgc2hhcmVkIG1lbW9yeSwgbm90IG9ubHkg
bGlrZSBzaGFtZS4uDQo+IA0KPiDigJxzaGFt4oCdIGlzIGFsc28gYSB3b3JkIGJ5IGl0c2VsZi4g
Oi0pDQoNCkhtbSBkaWRuJ3Qga25vdywgbWUgZ28gdG8gZ29vZ2xlIHRyYW5zbGF0ZS4gT0ssIHNo
YW0gbG9va3MgYSBsb3QgbmljZXIgdGhhbiBzaGFtZSkNCg0KPiANCj4+IEFuZCBpZiB3ZSBjYWxs
IGl0IF9hbGxvYywgdGhlIG9wcG9zaXRlIHNob3VsZCBiZSBfZnJlZSwgYnV0IGhvdyB0bw0KPj4g
ZGlzdGluZ3Vpc2ggaXQgZnJvbSBmcmVlaW5nIHRoZSB3aG9sZSBvYmplY3Q/IEhtbSwgdXNlIGNy
ZWF0ZS9kZXN0cm95IGZvcg0KPj4gdGhlIHdob2xlIG9iamVjdCBtYXliZS4NCj4+DQo+PiBNYXkg
YmUsIGRyb3AgInFlbXVfIiA/IEl0J3Mgbm90IHZlcnkgaW5mb3JtYXRpdmUuIE9yIG1heSBiZSBk
cm9wICJjb18iPy4NCj4+DQo+PiBJIGRvbid0IGxpa2Ugc2hhbWluZyBteSBzaGFyZWQgYW1vdW50
IDopDQo+IA0KPiBJdOKAmXMgd29yc2UgY2FsbGluZyBpdCBhbGwgYSBzaGFtLg0KPiANCj4+IE1h
eSBiZSwgd2Ugc2hvdWxkIGltYWdpbmUsIHdoYXQgYXJlIHdlIGFsbG9jYXRpbmc/IE1heSBiZSBi
YWxscz8NCj4+DQo+PiBzdHJ1Y3QgQmFsbEFsbG9jYXRvcg0KPj4NCj4+IGJhbGxfYWxsb2NhdG9y
X2NyZWF0ZQ0KPj4gYmFsbF9hbGxvY2F0b3JfZGVzdHJveQ0KPj4NCj4+IGNvX3RyeV9hbGxvY19i
YWxscw0KPj4gY29fYWxsb2NfYmFsbHMNCj4+IGNvX2ZyZWVfYmFsbHMNCj4+DQo+PiBPciBiYXJz
PyBPciB3aGljaCB0aGluZyBtYXkgYmUgdXNlZCBmb3IgZnVubnkgbmFtaW5nIGFuZCB0byBub3Qg
aW50ZXJzZWN0DQo+PiB3aXRoIGV4aXN0aW5nIGNvbmNlcHRzIGxpa2UgbWVtb3J5Pw0KPiANCj4g
SSBsb3ZlIGl0ICh0aGFua3MgZm9yIG1ha2luZyBteSBtb3JuaW5nKSwgYnV0IEkgZmVhciBpdCBt
YXkgYmUNCj4gaW50ZXJwcmV0ZWQgYXMgcmlzcXXDqS4NCj4gDQo+IE1heWJlIGp1c3Qgc2hyZXMg
Zm9yIHNoYXJlZCByZXNvdXJjZT8gIFNvIGFsbG9jX2Zyb21fc2hyZXM/DQo+IA0KDQpPSyBmb3Ig
bWUuIEJ1dC4uIEhvdyB0byBuYW1lIF9mcmVlIGZ1bmN0aW9uIHRoYW4/DQoNCnN0cnVjdCBTaGFy
ZWRSZXNvdXJjZQ0KDQpzaHJlc19jcmVhdGUNCnNocmVzX2Rlc3Ryb3kNCg0KY29fdHJ5X2FsbG9j
X2Zyb21fc2hyZXMNCmNvX2FsbG9jX2Zyb21fc2hyZXMNCmNvX2ZyZWVfPz8/DQoNCmNvX2ZyZWVf
cmVzX2FsbG9jZWRfZnJvbV9zaHJlcyA/IDopDQoNCm9yDQoNCmNvX3RyeV9nZXRfZnJvbV9zaHJl
cw0KY29fZ2V0X2Zyb21fc2hyZXMNCmNvX3B1dF90b19zaHJlcw0KDQo+Pj4NCj4+Pj4gICAgICAg
ICAgICByZXQgPSBibG9ja19jb3B5X2RvX2NvcHkocywgc3RhcnQsIGNodW5rX2VuZCwgZXJyb3Jf
aXNfcmVhZCk7DQo+Pj4+ICsgICAgICAgIHFlbXVfY29fcHV0X2Ftb3VudChzLT5tZW0sIGNodW5r
X2VuZCAtIHN0YXJ0KTsNCj4+Pj4gICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPj4+PiAgICAg
ICAgICAgICAgICBiZHJ2X3NldF9kaXJ0eV9iaXRtYXAocy0+Y29weV9iaXRtYXAsIHN0YXJ0LCBj
aHVua19lbmQgLSBzdGFydCk7DQo+Pj4+ICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4+Pg0KPj4+
DQo+Pj4NCj4+DQo+Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8BCC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA86E21743
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KR//Ww7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA86E21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4nE-0005Iz-Sx
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw4mq-0004sZ-4W
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw4mp-0000hP-6o
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:18:28 -0400
Received: from mail-eopbgr150121.outbound.protection.outlook.com
 ([40.107.15.121]:35909 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw4mo-0000gK-Mx; Fri, 09 Aug 2019 09:18:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El7UBxo3DXomz27OHCtaEvwm+6J162+dIyX85ebPG2+frujRziAG6qWkIA64b1U7zWrqoSqNJHkUCSQqsWyAAvTpMhXJCCe+QNIVQidXo0N5ehQEC3kDqIOo7De2CkbmzmPNvbKBEeTNM+3Ssc6vwCxknl46887KrpC9rndd0ILp29bjK20VaNAAFvV7Mye6SbV1MO4+6lrG35Y5q/4j3gGDYDZChyEAcQ+ZiIE9by/T3aQ/0nVtRlJkWtVo61J1ET6F/UvTtZDiZbyC/sT8hSoBr7FGyNzIsg+SaC7nuzTKMaIpPIagcBXepcE261WrXF+sRTvGNQQmuYT9IaKT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtpRmdSLji0JVzVyBC9OGGNS5HuMJFs8Qt813Ev7bkM=;
 b=YqZv5d2VfB/Sd5eFP0Q+Wkh5Rr+fnhMnD3/awNcDhFW2kDxm2btj0r6Vr3zjKt1aR96/1WLLQXRfhN1noyUjUd4BpfipZP6WCX/2qREmmiSggpHYLoZ+qV90PPc4ppgVvjQsxDy47VbzcgTE1/uch8RZwHn4YNjS7EHxrgAaog3g5selaXhIt9oukGcXV1QaS1nf9/dX0lQ+obUwBTy67yy2exPprGnqmbx8+Ka5yRlRV/20qcdr3PmGsi+FyAkLfCF8FrlgfqiyaCAtnO9MMww8qN65sJFvXRRW7KXR0Gp0uFv8d6nqrK3iDbXhid+icx2o3KkRZn3jUHkuQ+X63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtpRmdSLji0JVzVyBC9OGGNS5HuMJFs8Qt813Ev7bkM=;
 b=KR//Ww7qf9nd29VyENzC8CHyim6hVhHf38mAg6pFrTXSuGmSTX99tuNiZUL/HLgrTyq5ZbTCLWj4Q+vtpfWP2lOgkOO+mHJTNPY8/43s6TP2fp6ZsBneEpeEicR9iNDiy1C2Sh9wjF9doDaUxZgQzz/hJqHIrIkQkxsVLC+4gWU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4939.eurprd08.prod.outlook.com (10.255.4.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 13:18:23 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 13:18:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow
 <jsnow@redhat.com>
Thread-Topic: backup bug or question
Thread-Index: AQHVTrTrc8JESPxQGUmDMebwH05otA==
Date: Fri, 9 Aug 2019 13:18:23 +0000
Message-ID: <6826e3c2-bc6e-b2a2-1bf1-3ed31079f0ee@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0005.eurprd03.prod.outlook.com
 (2603:10a6:3:76::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b213423a-015b-47ab-db31-08d71ccc0e63
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4939; 
x-ms-traffictypediagnostic: DB8PR08MB4939:
x-microsoft-antispam-prvs: <DB8PR08MB493971BFD8B46975955D1EEBC1D60@DB8PR08MB4939.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(39850400004)(136003)(366004)(189003)(199004)(6116002)(8676002)(66066001)(14444005)(4744005)(7736002)(476003)(3480700005)(305945005)(256004)(2616005)(3846002)(6512007)(478600001)(53936002)(386003)(66476007)(66556008)(64756008)(66446008)(186003)(66946007)(81166006)(26005)(81156014)(99286004)(71200400001)(71190400001)(110136005)(25786009)(6436002)(52116002)(31686004)(5660300002)(86362001)(31696002)(486006)(102836004)(14454004)(316002)(6506007)(36756003)(6486002)(8936002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4939;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UyfrYazVqNHrQvE2v5zcKoTurd3DvMYYljvyv4gsiKkBAo+AntU9Ygmf2RBWicRDesuF2DeVbBkBSwNVPJW+vNF8WZatnwIm6ELoU+WVQHODJfd5OLsnm+oulPfnC0o/9wWKJnv9DGb+ax0fijb0FRIIDtpHHEd9TIYP+KsinLnK9CAlizlLgAFEtUwaZ5CWxiVYR2M7oxr7/76pf4i5YFj+bviB0qS3uwgEKfeV/HNPkO9yIODlJXhlxuwJ0Vhc10RsekQAPVpmf8HBWEYfcQEGdGzG1MURZEolACDHlYxvbN92HV0dmo9reLz8igd9uU537ozghpfE2+u/IOj/bUnSnp04D825Ptkgb4e8EWTZR1ykl793S8Mzqw43lxQG4l18nM8rZTc7QNHNT86j3QhjKFhikKfBDdU6zEAWz3s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <00FFE2FCBB8D62489A0D8139610ABD5C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b213423a-015b-47ab-db31-08d71ccc0e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 13:18:23.8147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKB+paPq2CzIhc/cfyCS2aoGcH598mtBKunx+WwrE0kpUt+eS6b4maAEV9Ut2nuKnFFw6ceiUvwDwqAIhkpefQBtVpWUqrBYOJs2wjghLXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4939
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.121
Subject: [Qemu-devel] backup bug or question
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCkhtbSwgaGFja2luZyBhcm91bmQgYmFja3VwIEkgaGF2ZSBhIHF1ZXN0aW9uOg0KDQpX
aGF0IHByZXZlbnRzIGd1ZXN0IHdyaXRlIHJlcXVlc3QgYWZ0ZXIgam9iX3N0YXJ0IGJ1dCBiZWZv
cmUgc2V0dGluZw0Kd3JpdGUgbm90aWZpZXI/DQoNCmNvZGUgcGF0aDoNCg0KcW1wX2RyaXZlX2Jh
Y2t1cCBvciB0cmFuc2FjdGlvbiB3aXRoIGJhY2t1cA0KDQogICAgam9iX3N0YXJ0DQogICAgICAg
YWlvX2NvX2VudGVyKGpvYl9jb19lbnRyeSkgLyogbWF5IG9ubHkgc2NoZWR1bGUgZXhlY3V0aW9u
LCBpc24ndCBpdCA/ICovDQoNCi4uLi4NCg0Kam9iX2NvX2VudHJ5DQogICAgam9iX3BhdXNlX3Bv
aW50KCkgLyogaXQgZGVmaW5pdGVseSB5aWVsZHMsIGlzbid0IGl0IGJhZD8gKi8NCiAgICBqb2It
PmRyaXZlci0+cnVuKCkgLyogYmFja3VwX3J1biAqLw0KDQotLS0tDQoNCmJhY2t1cF9ydW4oKQ0K
ICAgIGJkcnZfYWRkX2JlZm9yZV93cml0ZV9ub3RpZmllcigpDQoNCi4uLg0KDQpBbmQgd2hhdCBn
dWFyYW50ZWVzIHdlIGdpdmUgdG8gdGhlIHVzZXI/IElzIGl0IGd1YXJhbnRlZWQgdGhhdCB3cml0
ZSBub3RpZmllciBpcw0Kc2V0IHdoZW4gcW1wIGNvbW1hbmQgcmV0dXJucz8NCg0KQW5kIEkgZ3Vl
c3MsIGlmIHdlIHN0YXJ0IHNldmVyYWwgYmFja3VwcyBpbiBhIHRyYW5zYWN0aW9uIGl0IHNob3Vs
ZCBiZSBndWFyYW50ZWVkDQp0aGF0IHRoZSBzZXQgb2YgYmFja3VwcyBpcyBjb25zaXN0ZW50IGFu
ZCBjb3JyZXNwb25kIHRvIG9uZSBwb2ludCBpbiB0aW1lLi4uDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==


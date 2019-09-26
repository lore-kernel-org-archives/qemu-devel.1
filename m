Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60DCC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57156207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uDNHBvF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57156207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRKv-0003hN-65
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDR2I-0001oV-5n
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDR2F-0001kq-Sn
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:30:08 -0400
Received: from mail-eopbgr140102.outbound.protection.outlook.com
 ([40.107.14.102]:5097 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDR2D-0001dP-L2; Thu, 26 Sep 2019 06:30:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucj66Qp+YJZINSWMiYS32dl93bUEDEeERynWmxsB8t/6JeESYNRrMRpzLpaK+jjGRKbORAH7cooB5VhsO+3ppebFouUhZmHenFSigjsizQO74nsnztr8M0bUF+HDjehcyp9WcDkEQmMsIZzqKfYxa/R1zUo/kF4YHohX6ryuejhStNRouPvsYax+UCoxOdyi7Axd5BuxBvd7SFR62Veqg7vYUokpJFk667LqJpAVthM8QY/v4TXwp5HPz3JsiUR2SDPhbtL16jlNOP7k+CoFsl/rsZWw/jFkYoCxjKW2aV58w67vsEdhO/oMDat8aas7TjniYP7W1UN9bqMCJbhh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFOQGhfxi4T9tQTYWGH/ovxd+ASCm3BuiRHLpxiRL84=;
 b=Jvk7ELI3Jqeslg3DizrkJLa/3PHaYxHhXNKjcL8PF2Ga6HSRwbf52mapygouvnt/gW44HiDFyS8UHG92MElgksXrPeywr9pWYSaiDBget/21eInKfjRtZmUWSWVEyA1rAD09W901JXvv4ADDln0Wydsv1ug4bOaUxqWpevRim8FJFmD0BfLZwrv9GmNcipYHwsDC2j2ur86Ea90zmnfulRMJ/559BN3Z5st5JZaYlQExvl2//8u+oVtUMeFgCBah8oFm2+BrR1h6sS7dWge85s1srbnn7vqOZ1F1QhW4mDqNpd0xg/M3tKzvto5P5a7TJ61ori9JZ8oyrrLyqcubPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFOQGhfxi4T9tQTYWGH/ovxd+ASCm3BuiRHLpxiRL84=;
 b=uDNHBvF3z8VKdglpUj7IgXsL/I8e1PHq4A6ClRSzR25OadM25kzX+SyslrpB0yoZBSyvP5aPUn9+jWpMdNIvNs+fwoRcqR4E6NFZiG/1v6kOoRxHOSfiJEWrEV1//gq252TPcsL3rPiuFwe6StTCIsmBcsQe1PyWO5w08la/v3I=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8SPR01MB0010.eurprd08.prod.outlook.com (20.179.13.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Thu, 26 Sep 2019 10:29:46 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 10:29:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v14 14/14] block/backup: use backup-top instead of write
 notifiers
Thread-Topic: [PATCH v14 14/14] block/backup: use backup-top instead of write
 notifiers
Thread-Index: AQHVdFTgYZV6twD5806OCVJr3b+RBqc9wfSA
Date: Thu, 26 Sep 2019 10:29:46 +0000
Message-ID: <46ed194b-5abf-b853-cb2d-e09432a97e04@virtuozzo.com>
References: <20190926102614.28999-1-vsementsov@virtuozzo.com>
 <20190926102614.28999-15-vsementsov@virtuozzo.com>
In-Reply-To: <20190926102614.28999-15-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0146.eurprd06.prod.outlook.com
 (2603:10a6:7:16::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926132943825
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15123398-51aa-44ff-5604-08d7426c73af
x-ms-traffictypediagnostic: DB8SPR01MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8SPR01MB00109085973F6E816E08F9E2C1860@DB8SPR01MB0010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(366004)(39850400004)(136003)(199004)(189003)(25786009)(102836004)(186003)(6512007)(478600001)(6486002)(5660300002)(14454004)(36756003)(316002)(476003)(256004)(2616005)(6116002)(305945005)(4744005)(486006)(31686004)(66066001)(99286004)(7736002)(6916009)(2906002)(4326008)(6246003)(64756008)(66946007)(31696002)(107886003)(2351001)(54906003)(8676002)(81166006)(71200400001)(81156014)(2501003)(446003)(11346002)(8936002)(6436002)(76176011)(66556008)(66476007)(386003)(6506007)(66446008)(26005)(3846002)(5640700003)(52116002)(229853002)(71190400001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8SPR01MB0010;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qyutfeBfUMte9ro3gdsx2S09AW75yn3YgVr8OHLQ0o8O9ICEZ1Y/rAkmZ/Xuftq2M5Bg3NNPtu7G9vE55M1ky+C3FpE9Fi0lmU4G4hTMMUXi330LAlELz1+qlzDfkGbEC574esjJOBehe8tres7Z+3v8+d4SmHWdKMlQclqLSOFOfQEqJ/QFDQOtlicf9UKeZlFsmegZhHVu6Azvb4VO1Y078P7U7ukCmS9DmiA/XQpJSCA5HKjIkNadWybW0wJumfjRhzJG6hT2QWYbXGCfzzjlcqWHRFrSwAn61DMpg7jvU62OdbblKCfzd2ot3vBPdVT0Wpv8PC4YRiBFEtmVzHN1Z0vgnc76qz9a+ZVfSVXhtv+YkqwshSFfYaADBkiOfrREL6xeYQ959XNPXTr2XIw5P13mlQZRYt8ybgyxJ0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DCCDBA5C480DA4A8FD5D354E673AF0A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15123398-51aa-44ff-5604-08d7426c73af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 10:29:46.1956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SumY465VVNq/c9UVs2T4QPYkykQw2ndix05ZAHZt4HE4iCQ+90M2kSJifauqHnfMgoJxwqAS1JYc54Nfk9RXXAqFzu9cmP3j3hoo2Yq162k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8SPR01MB0010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.102
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjYuMDkuMjAxOSAxMzoyNiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
RHJvcCB3cml0ZSBub3RpZmllcnMgYW5kIHVzZSBmaWx0ZXIgbm9kZSBpbnN0ZWFkLg0KPiANCj4g
PSBDaGFuZ2VzID0NCj4gDQo+IDEuIEFkZCBmaWx0ZXItbm9kZS1uYW1lIGFyZ3VtZW50IGZvciBi
YWNrdXAgcW1wIGFwaS4gV2UgaGF2ZSB0byBkbyBpdA0KPiBpbiB0aGlzIGNvbW1pdCwgYXMgMjU3
IG5lZWRzIHRvIGJlIGZpeGVkLg0KPiANCg0KWy4uXQ0KDQo+IA0KPiAyNTc6IFRoZSB0ZXN0IHdh
bnRzIHRvIGVtdWxhdGUgZ3Vlc3Qgd3JpdGUgZHVyaW5nIGJhY2t1cC4gVGhleSBzaG91bGQNCj4g
Z28gdG8gZmlsdGVyIG5vZGUsIG5vdCB0byBvcmlnaW5hbCBzb3VyY2Ugbm9kZSwgb2YgY291cnNl
LiBUaGVyZWZvcmUgd2UNCj4gbmVlZCB0byBzcGVjaWZ5IGZpbHRlciBub2RlIG5hbWUgYW5kIHVz
ZSBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXk8
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPiBSZXZpZXdlZC1ieTogTWF4IFJlaXR6PG1yZWl0
ekByZWRoYXQuY29tPg0KDQpTb3JyeSwgSSBmb3JnZXQgdG8gZHJvcCByLWIgbWFyay4gUGF0Y2gg
aXMgdXBkYXRlZC4NCg0KKGhtbSwgYWdhaW4gc29tZXRoaW5nIHdyb25nIGFib3V0IHdoaXRlc3Bh
Y2UgYmV0d2VlbiBuYW1lIGFuZCBlbWFpbCwgSSBzZWUNCml0IGluIG9yaWdpbmFsIG1lc3NhZ2Us
IGJ1dCB3aGVuIEkgY29tcG9zaW5nIHRoaXMgcmVwbHksIHRoZXJlIGlzIG5vIHdoaXRlc3BhY2UN
CnF1b3RlKQ0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


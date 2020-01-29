Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221DEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A37206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MbzhVXBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A37206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwrfU-0000NH-3j
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 13:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iwrej-0008Kr-6i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iwreh-0000EP-Tj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:01:36 -0500
Received: from mail-eopbgr60123.outbound.protection.outlook.com
 ([40.107.6.123]:37863 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iwreh-0000DB-1a; Wed, 29 Jan 2020 13:01:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnhuMJ4NJPf9tJiami7XmlqOcomeUrlgGCLKAJIBJTidTu7dGEKj2vRcm0Iz00l+JaHt9dRvnsc4H4Qxk+Y9G2+z/6kfRQgpBUKwPnkzqVhHcI9Wwx0XP/BR4BXt1Id8GggvK0MULsL6fEiC7URLuZfQa8+YyTdF/Efby1ocKiqHfaaPckQNDmrWWnQPfUdvFK8aZZUYhFoCDaUr+tnqZfjiFuHqEly9Y2mlVSX4X01MM+A4eCfyFS+x//hzcLV1/Pvef1pCvb1nCM9P3e+cvy8ESGMF876sr7kwH5OOdUByJI1Wni96F1hjtXLzhVzfHM0XzZZY6MKwedesQur1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkM8Y79RwuVHuVPixJrx+pwdKeTFYSvrHvFAWonJJ2M=;
 b=Stdjx2MD9c+b0TSzsjRsHrf07OoDXF1bdYQInacFZzt9ASHbxi4fvUkqKm/s5lmRnTt2uPezmVwr3icVF8Win+x/IDwtFqs36Cqj4F6WpX4mDd711t68Li/ZIyY+J9Bu5Y0egUrodK+ZmInuNOLc12tfEw946x0w4o+YKz0mkm9ZQjEvy24Fcg0GdsK0n5NxEe83LwoiiQCv7qUDEg0tOlNsfVrCjTOC9xwgFk3tCFr+8vH2BYOvtei5PDnPLaA6D+shvvsVgBGLl8PTjxzE2XO+SWdL6qb2SYX4llfFqnGJB9FMdNhka8nOzHkfxuT5iw1LVJm84xat5uKnKGWyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkM8Y79RwuVHuVPixJrx+pwdKeTFYSvrHvFAWonJJ2M=;
 b=MbzhVXBNeaqr9huZe/OFiDpQ9D1EJqQ6VygDiiby35nT44kRa42bKEe+ivdGoxXH95zy+ROBCWy2oUNgihZqMkiMDBngxDV3k0SSHrbuh0kA+jPvSVL1p5anW2P0fYQGgZPVcg1GAwnu1lCH/MfYrVIdKbIpnvOvYe44S6+InNw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3528.eurprd08.prod.outlook.com (20.177.114.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 18:01:31 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 18:01:31 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0401CA0073.eurprd04.prod.outlook.com (2603:10a6:3:19::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Wed, 29 Jan 2020 18:01:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu block <qemu-block@nongnu.org>
Subject: request_alignment vs file size, how to fix crash?
Thread-Topic: request_alignment vs file size, how to fix crash?
Thread-Index: AQHV1s4i+bWYuR7nLUu+qtunrio2PA==
Date: Wed, 29 Jan 2020 18:01:31 +0000
Message-ID: <2ca46523-44a2-1a48-dfa3-11bda9eef8e8@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0073.eurprd04.prod.outlook.com
 (2603:10a6:3:19::41) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 006a07b9-4ef6-444e-5ba7-08d7a4e54551
x-ms-traffictypediagnostic: AM6PR08MB3528:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB35289E3483603C0009C23F82C1050@AM6PR08MB3528.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(366004)(396003)(136003)(346002)(199004)(189003)(6486002)(8676002)(66476007)(64756008)(66446008)(81166006)(81156014)(66946007)(66556008)(316002)(71200400001)(4326008)(6916009)(8936002)(186003)(107886003)(16576012)(26005)(16526019)(2906002)(36756003)(52116002)(5660300002)(31696002)(86362001)(54906003)(2616005)(31686004)(956004)(478600001)(4744005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3528;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsGApDaW1zGFYhKp1KOvz78ZAh8FePGSjOW7gaVvXOb8ZckeAz+DmC4836ErGZ4MyxKRJNXHcJlXo2ukxGNg2h5ww4LPvDDYbnsunfORElw9y+NgEboRcR+p5QxT+DJYQ6+SfF78wSZCff+nH6+UcgDK0wwnMzWbHt5j9GHvtXyqvflcVdE2/Z+bcMoxyj3188qtJwkusJjYxSk5xvLQP9eymxAJB429DLPrIs26mFs7LFtaduTur5h8AjuOIMYV0djjlA+80sIpsJY3Q4BzFagSG0z9EtNwSha7yzHFHQdKxCIty0LCvcJzyDZql+vOHTg9hSnXaOu5QJFV6u3OooIa5PB7JNQRo+BxahVtXkMBCMsNIAngMLAFm54m6YYFYx/VNL5vhdH6+BJpttGK6CjAlfF9rS//6sXexnPtmQb9nBmvxshbA0c48nlHdK67
x-ms-exchange-antispam-messagedata: URyQLfsdu+nI66vSAyCBvYO2TZntM8Zzh0z4yGPiDFvf20HdeDuMEh/WaYfJXJzFzDPKkGCyvDVpjtcCJnWqxGvjcWDygoMvcGL9LkRYOkXUH5AyNerJS+nYgoGvb5yZBWGkGwf9v0ms4DWtBXcGDg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CC71CBA87E49841A147284A04793529@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006a07b9-4ef6-444e-5ba7-08d7a4e54551
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 18:01:31.4999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEcyywMIPA9KEDk1mZ0TGr0vW2stBKoqYQEGW/6dq3baUzCJenlH+3yD9WNsFwE6t+0loOLmk2j51IuVcmNUIdOuCTjsi2lHha4WqWrcxrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3528
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.123
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
Cc: Kevin Wolf <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCkkgZm91bmQgYSBjcmFzaCwgd2hpY2ggbWF5IGJlIHNpbXBseSB0cmlnZ2VyZWQgZm9y
IGltYWdlcyB1bmFsaWduZWQgdG8gcmVxdWVzdF9hbGlnbm1lbnQ6DQoNCiMgLi9xZW11LWlvIC0t
aW1hZ2Utb3B0cyAtYyAnd3JpdGUgMCA1MTInIGRyaXZlcj1ibGtkZWJ1ZyxhbGlnbj00MDk2LGlt
YWdlLmRyaXZlcj1udWxsLWNvLGltYWdlLnNpemU9NTEyDQpxZW11LWlvOiBibG9jay9pby5jOjE1
MDU6IGJkcnZfYWxpZ25lZF9wd3JpdGV2OiBBc3NlcnRpb24gYGVuZF9zZWN0b3IgPD0gYnMtPnRv
dGFsX3NlY3RvcnMgfHwgY2hpbGQtPnBlcm0gJiBCTEtfUEVSTV9SRVNJWkUnIGZhaWxlZC4NCkFi
b3J0ZWQgKGNvcmUgZHVtcGVkKQ0KDQpUaGUgcHJvYmxlbSBpcyBvYnZpb3VzOiA1MTIgaXMgYWxp
Z25lZCB0byA0MDk2IGFuZCBiZWNvbWVzIGxhcmdlciB0aGFuIGZpbGUgc2l6ZS4NCg0KSSBmYWNl
ZCBpdCBhZnRlciByZWJhc2luZyBvdXIgZG93bnN0cmVhbSBicmFuY2hlcyB0byBuZXdlciBSaGVs
IHZlcnNpb25zLiBTZWVtcyB0aGF0IGFmdGVyIHNvbWUgdXBkYXRlcyBvZiBhbGlnbm1lbnQgZGV0
ZWN0aW9uIGluIGZpbGUtcG9zaXguYywgaXQgc3RhcnRlZCB0byBkZXRlY3QgNDA5NiBhbGlnbm1l
bnQgaW4gb3VyIGJ1aWxkIGVudmlyb25tZW50LCBhbmQgaW90ZXN0IDE1MiBzdGFydGVkIHRvIGNy
YXNoIChhcyBpdCBvcGVyYXRlcyBvbiBmaWxlIG9mIDUxMiBieXRlcykuDQoNCk15IHF1ZXN0aW9u
IGlzOg0KDQpXaGF0IGlzIHdyb25nPyBTaG91bGQgd2UgcmVzdHJpY3QgaW1hZ2VzIHRvIGJlIGFs
aWduZWQgdG8gcmVxdWVzdF9hbGlnbm1lbnQsIG9yIGFsbG93IHVuYWxpZ25lZCBvcGVyYXRpb25z
IGF0IEVPRiwgaWYgZmlsZSBpcyB1bmFsaWduZWQgaXRzZWxmPw0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=


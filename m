Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEEC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9D02077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qH9IRezn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9D02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTvN-0002Cc-5a
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icTcS-0000lg-L0
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icTcO-0002Jx-KM
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 07:18:57 -0500
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:18766 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icTcE-00011T-QP; Wed, 04 Dec 2019 07:18:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyHHn3sXKma4uY3xlFo4ibZ/juFXjU8dtIpmsQLZwlLGQA/3fb+Kfx+dwZnELQnEml3eAf7WO9G+7wZhTBKhdGOsnF3A/MkHjvM6S101x0IFwZ0/csQMQyqcZQAv6IDc42Ds6Q29C7JMXbvYiwumRRcSMoWvIiHKgnvpdC03WWqEBu98uOPAM3BevpH8b0QKb8q32iSDaR31dR5cz2oe48kvvYXUIE4ZgmJS2ae33S957s9Y46T+RPP/gJsESI+Ebrlpx7GFJwTOlkftLKWpco4ba491WM5CFogyXYV4de6h/KYWK0M8CzVQ2rEEPRj1hMySiG2Bfu/nk2UqpriA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ5O3mRKNlHSIm50sF5DW6/5dl0pgExPvRTmYv5ED98=;
 b=K2jA+zVTDYgyjuluWKM6BPBu6AA+GOAhqV4IopJASVl0oQVVU85LC+ErthBGHArPuVwkJWkfCDmCGuqkWNBN65KpXt+Lh1G0u8dvwtNModgQslxKFmux8107iYclHZchc+69lMjTZKi8w8mjESnYWzPo2fdd+29MgfWpzZLd7eb200KDKVYEKRqWkfKqhKebksyeDCCg1Kgz8wKlUwx12d8y+XLYHbXBLbhtfvF8tGKK3dP0xTvM/zygq2JebK95Go/eC89aSwGbZFNS9KVocbemlMxDP1t1lRPuDHKkNu/YAu9UQOOCdJ+oncn32gcw/5d+XPB4qb6qqgyKTWljsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ5O3mRKNlHSIm50sF5DW6/5dl0pgExPvRTmYv5ED98=;
 b=qH9IRezndM8onlWW/GhpCXz5+bQgTEN3G53RlGfjvopEyqjpg+JIJtEGjcVfPBSWJxo4q6mUsCNvdGZFniFxLvg7bQmSirEMR5M0cOedk+anbU0dw/kgy13nvYhVl668e2qAY0Ljz4+hdPoK5dC2Ebjte249DuQ3YECko9k0Sn8=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4598.eurprd08.prod.outlook.com (20.178.88.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 12:18:42 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 12:18:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>
Subject: NBD reconnect on open
Thread-Topic: NBD reconnect on open
Thread-Index: AQHVqpz3DKEqH9yc00uZ/9MlANyxnw==
Date: Wed, 4 Dec 2019 12:18:41 +0000
Message-ID: <f2f45e40-ae57-3366-c018-11579775031b@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0013.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::23) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f01071dc-5aac-43f0-1202-08d778b419be
x-ms-traffictypediagnostic: AM6PR08MB4598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4598CCB4AB77D45A92024FD1C15D0@AM6PR08MB4598.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(39840400004)(396003)(366004)(136003)(189003)(199004)(14454004)(52116002)(71200400001)(8936002)(316002)(66946007)(6512007)(478600001)(6916009)(66446008)(6506007)(102836004)(64756008)(31696002)(66556008)(14444005)(66476007)(6486002)(31686004)(36756003)(26005)(305945005)(6436002)(2906002)(4326008)(7736002)(6116002)(54906003)(99286004)(86362001)(8676002)(186003)(5660300002)(2616005)(81166006)(3846002)(81156014)(71190400001)(4744005)(25786009)(3480700005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4598;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fulk39cX75Vh75QouZafkod6WKsL7TLMJ/mSn6Mqi8awcmFZ6TVrEA7Q6bkTWqihEqwRVRPm18sxH22kSx/J3l3vtD6WP6ciHZAqDDSh0wbbQvto4PfVwLOj6CjA4AxUxu4akuoSX6SAAY2lOs01L9PzOZPIMKp4eZIAqbhez2aqxIgtHIT2SRqjGllnXZQ5MQAUf+Y9JHlKMTQPzNUopKkMW36rAti3ahtFPdkK0fNNf2PMwQFrTVw20qbjJx1TKN5SXMFj3CFC5C0VcGdAXNcwEADaYmfP/GFHUQNW6lRw3VXhFe79oWDnoqwogAktahyCcLfCd1btZpX3+pCVnpVxJ02aSSSgPS9lWxPQGJ4z56faX6e0JXeDLET/srmXo07pmpOxTo4CK0rJdxGbr8hBEnz8C29RoGCP1dyxKNj6nJEyrhowH/mRottupbAW
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2C49BD92C58748B469712BD5F91315@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01071dc-5aac-43f0-1202-08d778b419be
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 12:18:42.3344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmL5Y9gwR+Ei41AxIEiC8pDmAjVRT5QT13WcViwCkZXgjUCD0vNFMq3RNsVMb42WSxt+4Z7VAlrzKOo2ETcZa1NGxuQEPD7iJs4VpTXKoOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4598
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.134
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
 qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYyENCg0KVGhlcmUgaXMgYSBxdWVzdGlvbiB0byBkaXNjdXNzLg0KDQpXZSBuZWVkIHRv
IG1ha2UgYW4gb3B0aW9uIHRvIGFsbG93IG5iZC1yZWNvbm5lY3QgbG9vcCBvbiBuYmQtb3Blbi4N
CkZvciBleGFtcGxlLCBhZGQgb3B0aW9uYWwgbmJkIGJsb2NrZGV2IG9wdGlvbiBvcGVuLXJlY29u
bmVjdC1kZWxheSwgdG8NCm1ha2UgaXQgcG9zc2libGUgdG8gc3RhcnQgcWVtdSB3aXRoIHNwZWNp
ZmllZCBuYmQgY29ubmVjdGlvbiwgd2hlbiBuYmQNCnNlcnZlciBpcyBkb3duLCBhbmQgbWFrZSBz
ZXZlcmFsIHRyaWVzIHRvIGNvbm5lY3QgYmVmb3JlIHN0YXJ0aW5nIHRoZQ0KZ3Vlc3QuDQoNClNv
LCB3ZSBuZWVkIGl0IGZvciBuYmQgb3BlbmVkIGZyb20gY29tbWFuZGxpbmUgYXJndW1lbnRzLCBh
bmQgdGhpcyBjYXNlDQpzZWVtcyBPSy4NCg0KQnV0IGFkZGluZyBvcHRpb24gdG8gUUFQSSwgd2Ug
YWxzbyBhbGxvdyBpdCBmb3IgcW1wIGJsb2NrZGV2LWFkZCwgYW5kDQpyZWNvbm5lY3RpbmcgaW4g
Y29udGV4dCBvZiBxbXAgY29tbWFuZCBleGVjdXRpb24gaXMgYSB3cm9uZyB0aGluZy4uDQoNCkkg
Y2FuIGFkZCBuZXcgb3B0aW9uIG9ubHkgdG8gb3B0aW9ucyBpbiBibG9jay9uYmQuYywgYnV0IHRo
aXMgd2F5DQotYmxvY2tkZXYgY29tbWFuZCBsaW5lIG9wdGlvbiB3aWxsIG5vdCB3b3JrLCBpdCBu
ZWVkcyBRQVBJIGRlZmluaXRpb24uDQoNCldoYXQgZG8geW91IHRoaW5rIGFib3V0IGl0Pw0KDQpJ
IGNhbiBkZXRlY3Qgc29tZWhvdyBpbiBuYmRfb3BlbiB0aGF0IHdlIGFyZSBpbiBxbXAgbW9uaXRv
ciBjb250ZXh0LCBhbmQNCnJldHVybiBlcnJvciBpZiBvcGVuLXJlY29ubmVjdC1kZWxheSBzcGVj
aWZpZWQuLiBJcyBpdCBPSz8gSXMgdGhlcmUgYQ0Kd2F5IHRvIGRvIGl0Pw0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==


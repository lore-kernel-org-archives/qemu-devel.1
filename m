Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51EBC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2712176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hupenJMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2712176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaGT2-0005Tp-Cm
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 04:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaGKr-0007ZS-1G
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:43:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iaG95-0002vz-GJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:31:32 -0500
Received: from mail-eopbgr50118.outbound.protection.outlook.com
 ([40.107.5.118]:26837 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iaG94-0002jm-Mr; Thu, 28 Nov 2019 04:31:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZh01scV7UGBztQK8dB4oQtJUjk4koqft6ovSmnaAz68k4UrKm6V2+e4kGU0vK6BAR4rtkzETiyRS7Jd8xCHebqysrtyiD9bPW75GDiKyNUeWQENQkSzI11le7443hoXQolfvxKXQVBIp6DK+8q34wLZx1fV3LyU2C+P/OKbpctmAPi1Krm4eNqZcKoC1owfgaieeXo23t5JCj/cRby0cEVJ9t1/H9yVPbngFkwbCRDTzDUtGOJ5D/tNwtEKwlU5QWikDAz8Hu8FpUa1Bfw941pC13EYngDwN0Dbpx137gtYBIBUOKgBd1WrFysn1IbpaGGl2hBn8L1qTbIQEgGLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5B1XVgthzw/L75zO05RP6LhrbFkNimWydJ3zgRrJJw=;
 b=fR3gVyMiDZD0BUNyAdSqPy4LNJzwrrBp1lnPYUdT2Cb98zBdHnbB4lJsom5M2l+lC40uuiNPzGWyU4H93553UO7EjFjOeczIlHozNZlXvySn9onwklUx7q19eJDWJWTuQVO87VMhRVqjwV0k0e1xoP39Qip+oLbNFRolSo7GgQ8fmUbGknb11RB6Fjyjbw2wkMjF+pU9HecpgY7OvBmFndyiIzkjdzHw4hbFzNrm8DZbAjqKfRUXGzyPsL/OH2cxrOFOtFw75xZfu/TdHu6i2q9B8g6MIqbTjPDlK3OvUZN23qS9Vejrjdf5TGqj3tnjl1Rq34JihAHxuQEj3fkXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5B1XVgthzw/L75zO05RP6LhrbFkNimWydJ3zgRrJJw=;
 b=hupenJMnLBvONemkXSYgYcDGmyjg/MuxKOd8ZSl+9do8a0GlCaJ6jSEjMZfOSvKKuyKjGG40d4e7rqIaCPBmPCzPkjUuO2Lycaxn2nTNqczVQ5yfpLNF/Y4bfdZdZ8CtTSjwIPCRXCl8A2aR2CZUBPPJ5CRa2cwWWhnhPn0QCCI=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3271.eurprd08.prod.outlook.com (52.135.164.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 09:31:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Thu, 28 Nov 2019
 09:31:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 02/31] block: Add BdrvChildRole
Thread-Topic: [PATCH for-5.0 02/31] block: Add BdrvChildRole
Thread-Index: AQHVpSYN9F2/RBWt9UO3N3Nh8sSJa6egUucA
Date: Thu, 28 Nov 2019 09:31:26 +0000
Message-ID: <9d6e35ea-eed6-716a-75aa-e8f47f35b6b7@virtuozzo.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
 <20191127131624.1062403-3-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::35) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191128123124127
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42c296e9-c3e2-4660-c52d-08d773e5bd85
x-ms-traffictypediagnostic: AM6PR08MB3271:
x-microsoft-antispam-prvs: <AM6PR08MB32715F9CD6D88F8B9E33F872C1470@AM6PR08MB3271.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(366004)(136003)(346002)(376002)(189003)(199004)(8936002)(186003)(81166006)(25786009)(386003)(2501003)(86362001)(256004)(6506007)(81156014)(54906003)(110136005)(31696002)(229853002)(305945005)(8676002)(6246003)(14454004)(6436002)(102836004)(7736002)(66066001)(6486002)(316002)(26005)(3846002)(6116002)(66476007)(66556008)(64756008)(66446008)(52116002)(66946007)(76176011)(71200400001)(71190400001)(2906002)(446003)(99286004)(31686004)(5660300002)(4326008)(36756003)(2616005)(478600001)(11346002)(6512007)(156123004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3271;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjY6CMFJyi9ptxKmoWAW81wjAmdD98lh+5osNMd/G6hd/nm2lkhPrPDPmFWcKuiXb6ALhH2QpjItWUWp7dhcex59qnpwly/uLbbFAv140wULHi138pw6c604EgMZKyQZHnxWvJq5fZY9JEH00z6l4f8yHwkQaSVYfF/NG52t+MeTb8rKdKRCJe5uEu3+GjpJNkQbpNNZBjdCB5tJqw/F9H/TTSVhzBMedp5IQhnd8Mmcp2kyoJR15IsMgoNRCQsnyaEgBx5XodL8G6519VjKi86GJUaKlNaEz7BK2NlJ2k4zrtbv8Y+wLMZk/TaL/nwkl7VQa4CsP+bqHPJs5VJrpKtOBZSSjFEMQkL5sdlUVeoDWp7gG2P2aKPSCBKrrdit1u/D2jBvCW5VerW4iti/v7LJ2o8+Bo+4l7EhBJ18UkSrUppjAEfAJCjJbdn0c+ju
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66CE08E2E81E5F47AAAA340434AB6B51@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c296e9-c3e2-4660-c52d-08d773e5bd85
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 09:31:26.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+mDt6Vh4jG/qKtJHifWitYj5fx2B19mJwhBKEJyJNwwOxJIvoVKgu97ecXfn9sm4jjjcvXKRbQVBCM3meyfht8WVKZAHMYrBdZ1A3MLjIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3271
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.118
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMTEuMjAxOSAxNjoxNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGVudW0gd2lsbCBzdXBw
bGVtZW50IEJkcnZDaGlsZENsYXNzIHdoZW4gaXQgY29tZXMgdG8gd2hhdCByb2xlIChvcg0KPiBj
b21iaW5hdGlvbiBvZiByb2xlcykgYSBjaGlsZCB0YWtlcyBmb3IgaXRzIHBhcmVudC4NCj4gDQo+
IEJlY2F1c2UgZW1wdHkgZW51bXMgYXJlIG5vdCBhbGxvd2VkLCBsZXQgdXMganVzdCBzdGFydCB3
aXRoIGl0IGZpbGxlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJl
ZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxvY2suaCB8IDM4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDM4IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmggYi9p
bmNsdWRlL2Jsb2NrL2Jsb2NrLmgNCj4gaW5kZXggMzg5NjNlZjIwMy4uMzY4MTdkNTY4OSAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9ibG9jay9ibG9jay5oDQo+ICsrKyBiL2luY2x1ZGUvYmxvY2sv
YmxvY2suaA0KPiBAQCAtMjc5LDYgKzI3OSw0NCBAQCBlbnVtIHsNCj4gICAgICAgREVGQVVMVF9Q
RVJNX1VOQ0hBTkdFRCAgICAgID0gQkxLX1BFUk1fQUxMICYgfkRFRkFVTFRfUEVSTV9QQVNTVEhS
T1VHSCwNCj4gICB9Ow0KPiAgIA0KPiArdHlwZWRlZiBlbnVtIEJkcnZDaGlsZFJvbGUgew0KDQpE
b24ndCB5b3Ugd2FudCB0byBjYWxsIGl0IGp1c3QgQmRydkNoaWxkRmxhZ3MgPw0KQmVuZWZpdHM6
DQoNCjEuIERvIG5vdCBpbnRlcnNlY3Qgd2l0aCBvbGQgQmRydkNoaWxkUm9sZS4NCjIuIEkgdGhp
bmssIEJEUlZfQ0hJTERfU1RBWV9BVF9OT0RFIGlzIG5vdCBhIHJvbGUsIGJ1dCBqdXN0IGEgcHJv
cGVydHkgb3IgZmxhZy4uDQoNCj4gKyAgICAvKg0KPiArICAgICAqIElmIHByZXNlbnQsIGJkcnZf
cmVwbGFjZV9ub2RlKCkgd2lsbCBub3QgY2hhbmdlIHRoZSBub2RlIHRoaXMNCj4gKyAgICAgKiBC
ZHJ2Q2hpbGQgcG9pbnRzIHRvLg0KPiArICAgICAqLw0KPiArICAgIEJEUlZfQ0hJTERfU1RBWV9B
VF9OT0RFID0gKDEgPDwgMCksDQo+ICsNCj4gKyAgICAvKiBDaGlsZCBzdG9yZXMgZGF0YSAqLw0K
PiArICAgIEJEUlZfQ0hJTERfREFUQSAgICAgICAgID0gKDEgPDwgMSksDQo+ICsNCj4gKyAgICAv
KiBDaGlsZCBzdG9yZXMgbWV0YWRhdGEgKi8NCj4gKyAgICBCRFJWX0NISUxEX01FVEFEQVRBICAg
ICA9ICgxIDw8IDIpLA0KPiArDQo+ICsgICAgLyogRmlsdGVyZWQgY2hpbGQgKi8NCj4gKyAgICBC
RFJWX0NISUxEX0ZJTFRFUkVEICAgICA9ICgxIDw8IDMpLA0KPiArDQo+ICsgICAgLyogQ2hpbGQg
dG8gQ09XIGZyb20gKGJhY2tpbmcgY2hpbGQpICovDQo+ICsgICAgQkRSVl9DSElMRF9DT1cgICAg
ICAgICAgPSAoMSA8PCA0KSwNCj4gKw0KPiArICAgIC8qIENoaWxkIGlzIGV4cGVjdGVkIHRvIGJl
IGEgcHJvdG9jb2wgbm9kZSAqLw0KPiArICAgIEJEUlZfQ0hJTERfUFJPVE9DT0wgICAgID0gKDEg
PDwgNSksDQo+ICsNCj4gKyAgICAvKiBDaGlsZCBpcyBleHBlY3RlZCB0byBiZSBhIGZvcm1hdCBu
b2RlICovDQo+ICsgICAgQkRSVl9DSElMRF9GT1JNQVQgICAgICAgPSAoMSA8PCA2KSwNCj4gKw0K
PiArICAgIC8qDQo+ICsgICAgICogVGhlIHByaW1hcnkgY2hpbGQuICBGb3IgbW9zdCBkcml2ZXJz
LCB0aGlzIGlzIHRoZSBjaGlsZCB3aG9zZQ0KPiArICAgICAqIGZpbGVuYW1lIGFwcGxpZXMgYmVz
dCB0byB0aGUgcGFyZW50IG5vZGUuDQo+ICsgICAgICovDQo+ICsgICAgQkRSVl9DSElMRF9QUklN
QVJZICAgICAgPSAoMSA8PCA3KSwNCj4gKw0KPiArICAgIC8qIFVzZWZ1bCBjb21iaW5hdGlvbiBv
ZiBmbGFncyAqLw0KPiArICAgIEJEUlZfQ0hJTERfSU1BR0UgICAgICAgID0gQkRSVl9DSElMRF9E
QVRBDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IEJEUlZfQ0hJTERfTUVUQURB
VEENCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgQkRSVl9DSElMRF9QUk9UT0NP
TA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCBCRFJWX0NISUxEX1BSSU1BUlks
DQo+ICt9IEJkcnZDaGlsZFJvbGU7DQo+ICsNCj4gICBjaGFyICpiZHJ2X3Blcm1fbmFtZXModWlu
dDY0X3QgcGVybSk7DQo+ICAgdWludDY0X3QgYmRydl9xYXBpX3Blcm1fdG9fYmxrX3Blcm0oQmxv
Y2tQZXJtaXNzaW9uIHFhcGlfcGVybSk7DQo+ICAgDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRz
LA0KVmxhZGltaXINCg==


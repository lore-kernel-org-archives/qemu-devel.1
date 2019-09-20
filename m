Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9424F207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S5QLQmrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9424F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKKV-0003SJ-G9
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBK4d-0004vd-74
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBK4b-0008AR-Uh
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:39:50 -0400
Received: from mail-eopbgr70100.outbound.protection.outlook.com
 ([40.107.7.100]:39714 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBK4b-0008A1-6u; Fri, 20 Sep 2019 10:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS3iQ7nP6u1kcykumB28kOJfgzXa+SS4hvns1OUvlBQuhjJ0ReuXFhveUUf4VQvKFHId38tQPCrmq7Zj8OiJS86PD4mqhxRlzTQD2BU9f6PK3rHnfQ0U6vXLxg7fMEptl70x8zMkd4uG08lSalm72Ip8WBKniT61I8QFogHsI0vQqvX13KLQdWdottDhqtoppXei6clf/Ra0iM75ufUC0jy3cZjTIiZvLIhQu7o/EPpgLjQtod9Q6tPjc7MYddV2QGJumxO0/Dkd8LjKPSSYNaNeXo1AC0/xZx5O9ZtVKNCuRRs03gPtAx1E4ImTXSytGSZVPvZYepfCmT9CgJsDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suEjg7Tgz07ULgVvZFPFhwvgq5+GUYwaa3KC8a4Dk1U=;
 b=KI7UxLtGqPKMhwAgnOSTyhW5s+12AkXvKo2qrZcAW5jZAW6wUhIbR5wipEJ9x7mVHrC8WTprb5US3JjWJyoWk82mMSA8mWzm5gIB/mzE/gYsVbZT+4F4h8Lvfme4xSmL8ldvqQRFUWEa3slTHkD+mFjvUttvQ8y0FROKRjWiIw712stU8FsnAv/ygi1IZI4gzwYBMU1daGweTDXc86zrR1Px732PxwpUJcLXsS8xKFnAIqIyE3Tpu5meM27amjpFNy7coM9DBxD6WtV60wtvSw6hi/yQOvK9wcOrNkAckT0PK/BtGGPnNbW2UdpSC0mQc1qy9mW6P9fQODOlysrUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suEjg7Tgz07ULgVvZFPFhwvgq5+GUYwaa3KC8a4Dk1U=;
 b=S5QLQmrVzcZHerHG6FVrcZ7gHuN0bI1L8jVpDYP9c4nsJQT09489w7shk4zzupaXit34O6PypVGCU0GVrpY4oQJ3yzOljXE1kWrdhtpA6Ihs4zIXF6ZbsP0coBacOQ3EtHSP4cGPl95d3qKf7q75zdlGjMLnsQUgE99tCzRUMTc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5466.eurprd08.prod.outlook.com (52.133.242.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 14:39:46 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 14:39:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Topic: [PATCH v5 0/5] qcow2: async handling of fragmented io
Thread-Index: AQHVbLeo76n3Ba9lJkqJlS+3Y8+k26c0bngAgAAMPwCAAA0OgIAAA7gAgAAXQQCAAAZPAA==
Date: Fri, 20 Sep 2019 14:39:46 +0000
Message-ID: <8507c484-2dd2-e4f2-aafb-4fad4045b0da@virtuozzo.com>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
 <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
 <35b1c4ff-76eb-f07e-5e74-f88e7c811414@redhat.com>
In-Reply-To: <35b1c4ff-76eb-f07e-5e74-f88e7c811414@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0342.eurprd05.prod.outlook.com
 (2603:10a6:7:92::37) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190920173944774
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb0f4f5e-b578-4c06-e698-08d73dd86236
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5466; 
x-ms-traffictypediagnostic: DB8PR08MB5466:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB54666CD5508F16ED73B171D5C1880@DB8PR08MB5466.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(39840400004)(346002)(396003)(189003)(199004)(71190400001)(54906003)(110136005)(4326008)(6246003)(66556008)(66946007)(66066001)(14454004)(64756008)(966005)(66476007)(316002)(6306002)(6436002)(6512007)(6486002)(107886003)(229853002)(2501003)(3846002)(478600001)(305945005)(7736002)(31696002)(6116002)(2906002)(66446008)(2616005)(76176011)(476003)(36756003)(8676002)(81156014)(81166006)(31686004)(386003)(86362001)(186003)(53546011)(102836004)(52116002)(99286004)(6506007)(446003)(11346002)(486006)(25786009)(26005)(8936002)(5660300002)(71200400001)(4744005)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5466;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2IIccEXxAC7FdiyaRDfOYEYhOwrLhJzwCn0wOkiW/9GHAEFJGdBkNsmDeKQJFpJEd/dc3mJks8BaH7m0XsYZZXcHhfLgN+ozxgvGvn16BHdMGD0H9aqwuGKY4TiJK5M2Bi4k6ZmsfJneS3/xtcy3XPrLZdcZbotwTQ0bbXbp310VkB0qrWd2E6CdzxSIMtcrPxMc3bS+0haa8lfVOtBFtshQ1DnirZdT1ABs+veAIT0zbV6UsKjZvU3PK1rLlrrmq2nDSss2eRi/ffvUuRQoeRsHiFhkv5e6PgRd5wDaMnvcao/vXrCAxDSpXV5smgA1Ex+RooYeCkvX9YHYSjBJLGkUGveYReJQiyjOXnLMWuyre7Dwalu2Py4LOtFC+NXwSroOTB2e4UfSxv1zz7ECwwEys595qhHsX1MWhWOOOSE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E183F95C923A546BA7177C1CD952C89@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0f4f5e-b578-4c06-e698-08d73dd86236
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 14:39:46.7981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vUmD+hF6PLmK4xuiJH3WQ0pDWVhu+8ksAUij/0AxdiydcxtDXdEiAnU/Hy93KjRSmXvnULB9uRP0oeJ0/ADvR7XCO4TVx+K/4D2jA/lWCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5466
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.100
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxNzoxNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8yMC8xOSA3OjUzIEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPiANCj4+Pg0KPj4+IEl0IGRv
ZXNu4oCZdCBtYXR0ZXIgbXVjaCB0byBtZSwgSSBkaWZmIGFsbCBwYXRjaGVzIGFueXdheS4gOi0p
DQo+Pj4NCj4+DQo+PiB0aGVuIGEgYml0IG9mZnRvcGljOg0KPj4NCj4+IFdoaWNoIHRvb2xzIGFy
ZSB5b3UgdXNlPw0KPj4NCj4+IEkndmUgc29tZSBzY3JpcHRzIHRvIGNvbXBhcmUgZGlmZmVyZW50
IHZlcnNpb25zIG9mIG9uZSBzZXJpZSAob3IgdG8gY2hlY2ssIHdoYXQNCj4+IHdhcyBjaGFuZ2Vk
IGluIHBhdGNoZXMgZHVyaW5nIHNvbWUgcG9ydGluZyBwcm9jZXNzLi4pLi4gVGhlIGNvcmUgdGhp
bmcgaXMgdG8gZmlsdGVyDQo+PiBzb21lIG5vdCBpbnRlcmVzdGluZyBudW1iZXJzIGFuZCBoYXNo
ZXMsIHdoaWNoIG1ha2VzIGRpZmZzIGRpcnR5LCBhbmQgdGhlbiBjYWxsIHZpbWRpZmYuDQo+PiBC
dXQgbWF5YmUgSSd2ZSByZWludmVudGVkIHRoZSB3aGVlbC4NCj4gDQo+IEkgdXNlIGdpdC1iYWNr
cG9ydC1kaWZmIHRvIGdldCBhIGd1aSBjb21wYXJpc29uIGJldHdlZW4gdHdvIHBhdGNoDQo+IHNl
cmllczsgaHR0cHM6Ly9naXRodWIuY29tL2NvZHlwcmltZS9naXQtc2NyaXB0cy5naXQNCj4gDQoN
Ck9oLCB0aGF0J3MgY29vbCwgdGhhbmtzIQ0KDQpIbW0sIGJ1dCBpdCBkZWZpbml0ZWx5IGxhY2tz
IG15IGVhdC1naXQtbnVtYmVycyBzY3JpcHQuLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=


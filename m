Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342DBC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A722173C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 09:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GxibU+30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A722173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMPk-0008PD-9p
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54012)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMOC-0006kI-P7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbMOA-0001e8-Pn
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 05:51:24 -0400
Received: from mail-eopbgr10134.outbound.protection.outlook.com
 ([40.107.1.134]:34695 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbMIr-00076m-7q; Thu, 13 Jun 2019 05:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lodeCZ3Xpa6XwokOvqUBEzdsIDbhBy4WPQO8CQL44qI=;
 b=GxibU+30/fJg8aKptSWBTayMzLpnsKEoOWK+NdZd0xats1gFehfmWAokUD0GVOnM/eLe12hOG89k+Ub9PtTnvRXJ3sG19lQIg0Ch1ekZc5hIR71X76wX619wc35LyAYYEFwyJxuvN1KXyS4fS30+Jh5Xvp1S/TJWdbYYiJ6K+Tc=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3138.eurprd08.prod.outlook.com (52.134.126.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 09:45:48 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 09:45:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 1/7] iotests: allow Valgrind checking all QEMU
 processes
Thread-Index: AQHVIH/XsHvl7lRSGk+ZikRKaPdDm6aZWIwA
Date: Thu, 13 Jun 2019 09:45:48 +0000
Message-ID: <a5c7253e-8cf2-643d-befc-b9e222c66395@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1560276131-683243-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0056.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::24) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613124546539
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6d732d4-315d-4d7f-c7cf-08d6efe3ea03
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3138; 
x-ms-traffictypediagnostic: AM0PR08MB3138:
x-microsoft-antispam-prvs: <AM0PR08MB313826BCBEC2C2548BC0DBA6C1EF0@AM0PR08MB3138.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39850400004)(136003)(346002)(366004)(189003)(199004)(71190400001)(2201001)(8676002)(256004)(31686004)(6116002)(6506007)(305945005)(11346002)(6436002)(186003)(2616005)(68736007)(81166006)(7736002)(446003)(26005)(3846002)(2906002)(86362001)(4744005)(31696002)(25786009)(81156014)(486006)(71200400001)(8936002)(6512007)(6486002)(99286004)(52116002)(229853002)(53936002)(102836004)(107886003)(36756003)(66556008)(66946007)(14454004)(66446008)(5660300002)(66476007)(110136005)(73956011)(54906003)(386003)(76176011)(6246003)(316002)(66066001)(64756008)(478600001)(4326008)(476003)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3138;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aH+AEuS5PncnOslMA8YSaC3KjQuTtERfPqySV+C1C237/UtuFPwy9kFdQOEID36p2jtCztEC+Wt51WEgWvLWleSA85FTV018N2P888ePOR5/LpBkUKAY3diIkawOo8ayB+TyRb/ZV/hhtMn3frmeaKbL5ZbzwPQmxca04nlG6UBPF0Iu6P1Cr3qlI8tB9oeUiYoSzgGHoeHxM8vUZXaSHp9Btw2PzlGgFmvgDqjbk5EfgXCQvPjJXlwXepNxjFWRJUvnGsBtLSAEtJEOAeBhDJOJL/5Q64/3N5vpRP5hPyC8+DkClftsIAwSXcCGgyiajyZyfr9foByJSfOlmLZS2K+k8aq0x9yT0uVmjDqJz6AFpFQo4dbG+ZLxYjAv5eb7bn0RPaExYlNNZPZVBz4YXHWnzCgLIVyHhcbZTHbYTBI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27E5D2E2DD8CF944B8951D5C1436F69C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d732d4-315d-4d7f-c7cf-08d6efe3ea03
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:45:48.5303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3138
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.134
Subject: Re: [Qemu-devel] [PATCH v2 1/7] iotests: allow Valgrind checking
 all QEMU processes
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

MTEuMDYuMjAxOSAyMTowMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFdpdGggdGhlICct
dmFsZ3JpbmQnIG9wdGlvbiwgbGV0IGFsbCB0aGUgUUVNVSBwcm9jZXNzZXMgYmUgcnVuIHVuZGVy
DQo+IHRoZSBWYWxncmluZCB0b29sLiBUaGUgVmFsZ3JpbmQgb3duIHBhcmFtZXRlcnMgbWF5IGJl
IHNldCB3aXRoIGl0cw0KPiBlbnZpcm9ubWVudCB2YXJpYWJsZSBWQUxHUklORF9PUFRTLCBlLmcu
DQo+IFZBTEdSSU5EX09QVFM9Ii0tbGVhay1jaGVjaz15ZXMiIC4vY2hlY2sgLXFjb3cyIC12YWxn
cmluZCA8dGVzdCM+DQo+IG9yIHRoZXkgbWF5IGJlIGxpc3RlZCBpbiB0aGUgVmFsZ3JpbmQgY2hl
Y2tlZCBmaWxlIC4vLnZhbGdyaW5kcmMgb3INCj4gfi8udmFsZ3JpbmRyYyBsaWtlDQo+IC0tbWVt
Y2hlY2s6bGVhay1jaGVjaz1ubw0KPiAtLW1lbWNoZWNrOnRyYWNrLW9yaWdpbnM9eWVzDQo+IEFm
dGVyIGluY2x1ZGluZyB0aGUgVmFsZ3JpbmQgaW50byB0aGUgUUVNVSBwcm9jZXNzZXMgd3JhcHBl
cnMgaW4gdGhlDQo+IGNvbW1vbi5yYyBzY3JpcHQsIHRoZSBiZW5jaG1hcmsgb3V0cHV0IGZvciB0
aGUgdGVzdHMgMDM5IDA2MSAxMzcgaXMgdG8NCj4gYmUgYW1lbmRlZC4NCg0KSWYgdGVzdHMgb3V0
cHV0cyBjaGFuZ2VkLCBwbGVhc2UgZGVzY3JpYmUgaGVyZSBpbiBzaG9ydDogd2h5Pw0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


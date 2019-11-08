Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A12FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE732178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uBKTCGPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE732178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4DJ-0000LU-ND
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:22:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT495-0006XF-Ac
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iT492-0001Ck-5v
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:17:47 -0500
Received: from mail-eopbgr70095.outbound.protection.outlook.com
 ([40.107.7.95]:64329 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iT48y-000152-JU
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:17:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYVvvf2kig/ymxDl1e/0rlRgjUPwpGG4hhv5rvMZ2y6Gha52JvoN3Kcn+U4vnSUuhqPbIN/8W4atBTs7ZimQRijKGgtRndAXiEgsy8uwUBuIqxPd0u8D4SWGfpFRktoqMEegjFpQJbN7Wmj+hQoP13+flTfODJhzPUIIppEhzkNeUJGBqfpxP0Td4b/r2niAgBNACefyS4oWnPwGhP6ZgQWGuMQZpEw6IJVF1ATXsjBJPz71OM/7XE7+7n3hqxARuYPOnw/VxOOpMogBIr4HuEnK5z3mRLhr4KGGDphp2pod/XxMzGaswxMjNhYkkKMtAhCamsEd9gMax02E5J+4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4SmlmOaErJ2hZg04yh/DN/4Iwm4xChJi+BTRs2xqyM=;
 b=nxcECM7f3LLTYb0qVfDIwLt8/9hLc8UjeZHRvfUUu6ErPSM3VKkfsPMNbcFe6WQic/t0qUdF5dIdMIooEECK66t+WCm6ye4LgXQtdS0WV937NTyseMxb7iSeevyse75/6c4CjYCOTwGLCsm0T1mT6v4YDsAkV9OynGL4QmcEjw68dQeqvzlsfZ6imacPzduSi1EYtbcmRK3PcH1Q+LlifNqYhQWr9MpiwNsQwgKH7TFxGmqcAY4g51Vc9w/5LAM8mUVk/mEXjg08nxVMBHTbSrCctJcOxP578n0MnTrgaHhItx+PXVdZpvy8thra6sJxOmuals13LVlv2f4GraXGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4SmlmOaErJ2hZg04yh/DN/4Iwm4xChJi+BTRs2xqyM=;
 b=uBKTCGPeGv/3JwGQQBI1nvtdLQYwoLgveBmhSggMIZJocPHxiuceNVq6s+AuVPsrOzsyb4tuT8BzfdMOEWPfFFbdEZr5x/1JjFOL8L0ieAdKvGtJeiZ8WGYLTzkclvcOawcaFht7E0RWnR8U1xzTcYq8kwYIO+f6XZDDoIhiK2A=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3188.eurprd08.prod.outlook.com (52.134.94.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 13:17:37 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::41f0:981:fd75:9946%3]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 13:17:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: qxl - spice crash, memslot_get_virt: address generation is not valid
Thread-Topic: qxl - spice crash, memslot_get_virt: address generation is not
 valid
Thread-Index: AQHVljbj1x0m8nXmeUG0RhPIt/KulA==
Date: Fri, 8 Nov 2019 13:17:36 +0000
Message-ID: <c6cd8eba-dbb1-10fd-7f55-989de1503c03@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0033.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::22)
 To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50162323-6734-4089-7469-08d7644e05fa
x-ms-traffictypediagnostic: AM0PR08MB3188:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB318807153324CFE960431A1EC17B0@AM0PR08MB3188.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(39840400004)(396003)(376002)(199004)(189003)(53754006)(102836004)(36756003)(52116002)(486006)(71190400001)(71200400001)(14454004)(31686004)(6916009)(4326008)(966005)(478600001)(256004)(31696002)(66946007)(25786009)(66476007)(66556008)(64756008)(66446008)(86362001)(5660300002)(316002)(6116002)(8676002)(81166006)(186003)(3846002)(8936002)(81156014)(6436002)(6486002)(6506007)(26005)(6306002)(2906002)(54906003)(476003)(5024004)(305945005)(386003)(7736002)(6512007)(66066001)(2616005)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3188;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kQqMEfi1jqwyMZ2hKoYEwwLOyRpDv2X6M09spcfenjt/sPpFf6Fsn4tE4J+xfPFJxaUgQZ87+C00X4lsyzajPUoauNYzt4crBs9Ik6MeVZIihbbIa8tKuNbhwx5JMlRdNrPDi51O/85cumf/pbT6hdDtAp2DZds/Xxt7swLPxqtOBnm1CbFctShexsoHiaYra26Fj9aHFChgFxQDk4JYJZVLg3pz3MJf6eutVFJww7uttoJqoAXL8RnYJtF0vjJTM8+1WQIF1+5eTxcs6FNuhrPZ14kSTQlBftBFJdbn3NVyTL9OPBSd4fj4QdOA+H0fr0BXd0TmmUFtGIckGtUzqomh2ZLEEfTJoIk/yTRFP2prjlIchEi1SmbkaOtF1rOxDdCwZII5PIWWZTiKt84vvxg1t5mTn8yB6QRALFFSNqN5XiXJOk64CiK3e6sxSLXG4NoQPdcm1uiRLvMyu4eWedGzAFTMWDKHkwL6lxoVWHc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BFA06AFEC67E4586BDEB51AECDD456@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50162323-6734-4089-7469-08d7644e05fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 13:17:36.8170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lxEJcpPJ78dlDUZekog5K6ECfBxXVSFP6OPN4i8itQe+xjcwJxf1Qp3uH7AQVKlhn7cquuAHdieI/B5TU15cUMExyqyclzi0hz+rp4rfZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3188
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.95
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
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "cfergeau@redhat.com" <cfergeau@redhat.com>,
 "fziglio@redhat.com" <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsIQ0KDQpIb3BlIHNvbWVvbmUgY291bGQgaGVscCBtZSB3aXRoIHRoZSBmb2xsb3dpbmcu
DQoNClNlZW1zIHdlJ3ZlIGZhY2VkIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1
Zy5jZ2k/aWQ9MTU0MDkxOSBRZW11IGJ1Zy4gSXQgd2FzDQooQUZBSVUpIHdvcmthcm91bmRlZCBp
biBzcGljZSwgaW4gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0x
NTY3OTQ0ICwNCndoaWNoIG1hcmtlZCBpcyBmaXhlZCBpbiBzcGljZS0wLjE0LjAtNC4uDQoNClN0
aWxsLCBvdXIgY3Jhc2ggaXMgb24gc3BpY2Utc2VydmVyLTAuMTQuMC03ICwgd2hpY2ggaXMgaGln
aGVyLi4NClFlbXUgaXMgYmFzZWQgb24gcmhldi0yLjEyLjAtMzMsIGFuZCBJIGRvbid0IHNlZSBp
biB1cHN0cmVhbSBhbnkgcmVsYXRlZCBmaXhlcy4NCg0KMTU2Nzk0NCBkaXNjdXNzaW9ucyBoYXMg
Zml4ZXMgaW4gYXR0YWNobWVudHMgYnkgQ2hyaXN0b3BoZSBhbmQgRnJlZGlhbm8uLiBCdXQgSSBj
YW4ndCBmaW5kDQphbnl0aGluZyBpbiBRZW11IG1haWxpbmcgbGlzdCBhcmNoaXZlcy4gV2hhdCBp
cyB0aGUgcHJvYmxlbSB3aXRoIHRoZSBwYXRjaD8NCg0KPT09DQpiYWNrdHJhY2UNCg0KIzAgIDB4
MDAwMDdmZDE3ODVmODMzNyBpbiBfX0dJX3JhaXNlIChzaWc9c2lnQGVudHJ5PTYpIGF0IC4uL25w
dGwvc3lzZGVwcy91bml4L3N5c3YvbGludXgvcmFpc2UuYzo1NQ0KIzEgIDB4MDAwMDdmZDE3ODVm
OWEyOCBpbiBfX0dJX2Fib3J0ICgpIGF0IGFib3J0LmM6OTANCiMyICAweDAwMDA3ZmQxNzllM2Vj
ZmMgaW4gc3BpY2VfbG9ndiAobG9nX2RvbWFpbj0weDdmZDE3OWVhZmJmMSAiU3BpY2UiLCBhcmdz
PTB4N2ZkMTI1NjFlNDYwLCBmb3JtYXQ9MHg3ZmQxNzllYjZkMzAgImFkZHJlc3MgZ2VuZXJhdGlv
biBpcyBub3QgdmFsaWQsIGdyb3VwX2lkICVkLCBzbG90X2lkICVkLCBnZW4gJWQsIHNsb3RfZ2Vu
ICVkXG4iLA0KICAgICBmdW5jdGlvbj0weDdmZDE3OWViNmYzMCA8X19GVU5DVElPTl9fLjE2MDQx
PiAibWVtc2xvdF9nZXRfdmlydCIsIHN0cmxvYz0weDdmZDE3OWViNmUyNiAibWVtc2xvdC5jOjEy
MiIsIGxvZ19sZXZlbD1HX0xPR19MRVZFTF9DUklUSUNBTCkgYXQgbG9nLmM6MTgzDQojMyAgc3Bp
Y2VfbG9nIChsb2dfbGV2ZWw9bG9nX2xldmVsQGVudHJ5PUdfTE9HX0xFVkVMX0NSSVRJQ0FMLCBz
dHJsb2M9c3RybG9jQGVudHJ5PTB4N2ZkMTc5ZWI2ZTI2ICJtZW1zbG90LmM6MTIyIiwgZnVuY3Rp
b249ZnVuY3Rpb25AZW50cnk9MHg3ZmQxNzllYjZmMzAgPF9fRlVOQ1RJT05fXy4xNjA0MT4gIm1l
bXNsb3RfZ2V0X3ZpcnQiLA0KICAgICBmb3JtYXQ9Zm9ybWF0QGVudHJ5PTB4N2ZkMTc5ZWI2ZDMw
ICJhZGRyZXNzIGdlbmVyYXRpb24gaXMgbm90IHZhbGlkLCBncm91cF9pZCAlZCwgc2xvdF9pZCAl
ZCwgZ2VuICVkLCBzbG90X2dlbiAlZFxuIikgYXQgbG9nLmM6MTk2DQojNCAgMHgwMDAwN2ZkMTc5
ZTA1NzlmIGluIG1lbXNsb3RfZ2V0X3ZpcnQgKGluZm89aW5mb0BlbnRyeT0weDU1NmYyMDljNDRm
MCwgYWRkcj1hZGRyQGVudHJ5PTg0NDQyNDkzMDEzMTk2OCwgYWRkX3NpemU9YWRkX3NpemVAZW50
cnk9MjAsIGdyb3VwX2lkPWdyb3VwX2lkQGVudHJ5PTEsIGVycm9yPWVycm9yQGVudHJ5PTB4N2Zk
MTI1NjFlNWQ0KQ0KICAgICBhdCBtZW1zbG90LmM6MTIxDQojNSAgMHgwMDAwN2ZkMTc5ZTBlMDA3
IGluIHJlZF9nZXRfZGF0YV9jaHVua3NfcHRyIChzbG90cz1zbG90c0BlbnRyeT0weDU1NmYyMDlj
NDRmMCwgZ3JvdXBfaWQ9Z3JvdXBfaWRAZW50cnk9MSwgbWVtc2xvdF9pZD0wLCByZWQ9cmVkQGVu
dHJ5PTB4N2ZkMTI1NjFlNjMwLCBxeGw9MHg3ZmQxMjhlMDQwMTYpIGF0IHJlZC1wYXJzZS1xeGwu
YzoxNDYNCiM2ICAweDAwMDA3ZmQxNzllMTA2YWUgaW4gcmVkX2dldF9jdXJzb3IgKGFkZHI9NzIw
NTc1OTQwNDQyMzU3NzYsIHJlZD0weDU1NmYyMDlkOGQ0OCwgZ3JvdXBfaWQ9MSwgc2xvdHM9MHg1
NTZmMjA5YzQ0ZjApIGF0IHJlZC1wYXJzZS1xeGwuYzoxNDQxDQojNyAgcmVkX2dldF9jdXJzb3Jf
Y21kIChzbG90cz1zbG90c0BlbnRyeT0weDU1NmYyMDljNDRmMCwgZ3JvdXBfaWQ9MSwgcmVkPXJl
ZEBlbnRyeT0weDU1NmYyMDlkOGQyMCwgYWRkcj08b3B0aW1pemVkIG91dD4pIGF0IHJlZC1wYXJz
ZS1xeGwuYzoxNDgyDQojOCAgMHgwMDAwN2ZkMTc5ZTIxMzhmIGluIHJlZF9wcm9jZXNzX2N1cnNv
cl9jbWQgKHdvcmtlcj13b3JrZXJAZW50cnk9MHg1NTZmMjA5YzQ0NjAsIGV4dD1leHRAZW50cnk9
MHg1NTZmMjJmNTgwMDApIGF0IHJlZC13b3JrZXIuYzoxMTENCiM5ICAweDAwMDA3ZmQxNzllMjE1
MmIgaW4gbG9hZHZtX2NvbW1hbmQgKGV4dD0weDU1NmYyMmY1ODAwMCwgd29ya2VyPTB4NTU2ZjIw
OWM0NDYwKSBhdCByZWQtd29ya2VyLmM6OTgwDQojMTAgaGFuZGxlX2Rldl9sb2Fkdm1fY29tbWFu
ZHMgKG9wYXF1ZT0weDU1NmYyMDljNDQ2MCwgcGF5bG9hZD08b3B0aW1pemVkIG91dD4pIGF0IHJl
ZC13b3JrZXIuYzoxMDAyDQojMTEgMHgwMDAwN2ZkMTc5ZGVkNjVkIGluIGRpc3BhdGNoZXJfaGFu
ZGxlX3NpbmdsZV9yZWFkIChkaXNwYXRjaGVyPTB4NTU2ZjIxYjZiOGQwKSBhdCBkaXNwYXRjaGVy
LmM6Mjg0DQojMTIgZGlzcGF0Y2hlcl9oYW5kbGVfcmVjdl9yZWFkIChkaXNwYXRjaGVyPTB4NTU2
ZjIxYjZiOGQwKSBhdCBkaXNwYXRjaGVyLmM6MzA0DQojMTMgMHgwMDAwN2ZkMTc5ZGYzZTZiIGlu
IHdhdGNoX2Z1bmMgKHNvdXJjZT08b3B0aW1pemVkIG91dD4sIGNvbmRpdGlvbj08b3B0aW1pemVk
IG91dD4sIGRhdGE9MHg1NTZmMjA4ZGMwOTApIGF0IGV2ZW50LWxvb3AuYzoxMjgNCiMxNCAweDAw
MDA3ZmQxOTA3NDIwNDkgaW4gZ19tYWluX2Rpc3BhdGNoIChjb250ZXh0PTB4NTU2ZjIwOTVlZmQw
KSBhdCBnbWFpbi5jOjMxNzUNCiMxNSBnX21haW5fY29udGV4dF9kaXNwYXRjaCAoY29udGV4dD1j
b250ZXh0QGVudHJ5PTB4NTU2ZjIwOTVlZmQwKSBhdCBnbWFpbi5jOjM4MjgNCiMxNiAweDAwMDA3
ZmQxOTA3NDIzYTggaW4gZ19tYWluX2NvbnRleHRfaXRlcmF0ZSAoY29udGV4dD0weDU1NmYyMDk1
ZWZkMCwgYmxvY2s9YmxvY2tAZW50cnk9MSwgZGlzcGF0Y2g9ZGlzcGF0Y2hAZW50cnk9MSwgc2Vs
Zj08b3B0aW1pemVkIG91dD4pIGF0IGdtYWluLmM6MzkwMQ0KIzE3IDB4MDAwMDdmZDE5MDc0MjY3
YSBpbiBnX21haW5fbG9vcF9ydW4gKGxvb3A9MHg1NTZmMjJhZWVhMDApIGF0IGdtYWluLmM6NDA5
Nw0KIzE4IDB4MDAwMDdmZDE3OWUyMjVkYSBpbiByZWRfd29ya2VyX21haW4gKGFyZz0weDU1NmYy
MDljNDQ2MCkgYXQgcmVkLXdvcmtlci5jOjEzNzINCiMxOSAweDAwMDA3ZmQxNzg5OTdlNjUgaW4g
c3RhcnRfdGhyZWFkIChhcmc9MHg3ZmQxMjU2MjE3MDApIGF0IHB0aHJlYWRfY3JlYXRlLmM6MzA3
DQojMjAgMHgwMDAwN2ZkMTc4NmMwODhkIGluIGNsb25lICgpIGF0IC4uL3N5c2RlcHMvdW5peC9z
eXN2L2xpbnV4L3g4Nl82NC9jbG9uZS5TOjExMQ0KDQooZ2RiKSBmciAyDQojMiAgMHgwMDAwN2Zk
MTc5ZTNlY2ZjIGluIHNwaWNlX2xvZ3YgKGxvZ19kb21haW49MHg3ZmQxNzllYWZiZjEgIlNwaWNl
IiwgYXJncz0weDdmZDEyNTYxZTQ2MCwgZm9ybWF0PTB4N2ZkMTc5ZWI2ZDMwICJhZGRyZXNzIGdl
bmVyYXRpb24gaXMgbm90IHZhbGlkLCBncm91cF9pZCAlZCwgc2xvdF9pZCAlZCwgZ2VuICVkLCBz
bG90X2dlbiAlZFxuIiwNCiAgICAgZnVuY3Rpb249MHg3ZmQxNzllYjZmMzAgPF9fRlVOQ1RJT05f
Xy4xNjA0MT4gIm1lbXNsb3RfZ2V0X3ZpcnQiLCBzdHJsb2M9MHg3ZmQxNzllYjZlMjYgIm1lbXNs
b3QuYzoxMjIiLCBsb2dfbGV2ZWw9R19MT0dfTEVWRUxfQ1JJVElDQUwpIGF0IGxvZy5jOjE4Mw0K
MTgzICAgICAgICAgICAgIGFib3J0KCk7DQooZ2RiKSBsaXN0DQoxNzggICAgICAgICBnX2xvZyhs
b2dfZG9tYWluLCBsb2dfbGV2ZWwsICIlcyIsIGxvZ19tc2ctPnN0cik7DQoxNzkgICAgICAgICBn
X3N0cmluZ19mcmVlKGxvZ19tc2csIFRSVUUpOw0KMTgwDQoxODEgICAgICAgICBpZiAoKGFib3J0
X21hc2sgJiBsb2dfbGV2ZWwpICE9IDApIHsNCjE4MiAgICAgICAgICAgICBzcGljZV9iYWNrdHJh
Y2UoKTsNCjE4MyAgICAgICAgICAgICBhYm9ydCgpOw0KMTg0ICAgICAgICAgfQ0KMTg1ICAgICB9
DQoxODYNCjE4NyAgICAgdm9pZCBzcGljZV9sb2coR0xvZ0xldmVsRmxhZ3MgbG9nX2xldmVsLA0K
KGdkYikgZnIgNA0KIzQgIDB4MDAwMDdmZDE3OWUwNTc5ZiBpbiBtZW1zbG90X2dldF92aXJ0IChp
bmZvPWluZm9AZW50cnk9MHg1NTZmMjA5YzQ0ZjAsIGFkZHI9YWRkckBlbnRyeT04NDQ0MjQ5MzAx
MzE5NjgsIGFkZF9zaXplPWFkZF9zaXplQGVudHJ5PTIwLCBncm91cF9pZD1ncm91cF9pZEBlbnRy
eT0xLCBlcnJvcj1lcnJvckBlbnRyeT0weDdmZDEyNTYxZTVkNCkNCiAgICAgYXQgbWVtc2xvdC5j
OjEyMQ0KMTIxICAgICAgICAgICAgIHNwaWNlX2NyaXRpY2FsKCJhZGRyZXNzIGdlbmVyYXRpb24g
aXMgbm90IHZhbGlkLCBncm91cF9pZCAlZCwgc2xvdF9pZCAlZCwgZ2VuICVkLCBzbG90X2dlbiAl
ZFxuIiwNCihnZGIpIGxpc3QNCjExNiAgICAgICAgIHNsb3QgPSAmaW5mby0+bWVtX3Nsb3RzW2dy
b3VwX2lkXVtzbG90X2lkXTsNCjExNw0KMTE4ICAgICAgICAgZ2VuZXJhdGlvbiA9IG1lbXNsb3Rf
Z2V0X2dlbmVyYXRpb24oaW5mbywgYWRkcik7DQoxMTkgICAgICAgICBpZiAoZ2VuZXJhdGlvbiAh
PSBzbG90LT5nZW5lcmF0aW9uKSB7DQoxMjAgICAgICAgICAgICAgcHJpbnRfbWVtc2xvdHMoaW5m
byk7DQoxMjEgICAgICAgICAgICAgc3BpY2VfY3JpdGljYWwoImFkZHJlc3MgZ2VuZXJhdGlvbiBp
cyBub3QgdmFsaWQsIGdyb3VwX2lkICVkLCBzbG90X2lkICVkLCBnZW4gJWQsIHNsb3RfZ2VuICVk
XG4iLA0KMTIyICAgICAgICAgICAgICAgICAgIGdyb3VwX2lkLCBzbG90X2lkLCBnZW5lcmF0aW9u
LCBzbG90LT5nZW5lcmF0aW9uKTsNCjEyMyAgICAgICAgICAgICAqZXJyb3IgPSAxOw0KMTI0ICAg
ICAgICAgICAgIHJldHVybiAwOw0KMTI1ICAgICAgICAgfQ0KKGdkYikgcCBncm91cF9pZA0KJDEg
PSAxDQooZ2RiKSBwIHNsb3RfaWQNCiQyID0gMA0KKGdkYikgcCBnZW5lcmF0aW9uDQokMyA9IDMN
CihnZGIpIHAgc2xvdC0+Z2VuZXJhdGlvbg0KJDQgPSAwDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K


Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20117C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2C321D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m5C26+Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2C321D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5vW-0007YV-0F
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5un-00075L-8M
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5um-00006o-2S
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:57:01 -0400
Received: from mail-eopbgr30103.outbound.protection.outlook.com
 ([40.107.3.103]:62209 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD5ul-00006L-So; Wed, 25 Sep 2019 07:57:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgSsouQteUDuQaT398C6L3/7lBxu5sfj2bARgmPSqaOVGtj9LgrXBkv8PjuLJCpiqQntDFBD73BW9lEI1kt6/Kb/flAF6GIVtHIu2cIeMPdAo4+yLa4/45GG5M/GWifMXyNoeOCoFItktVKBjzBowt8GMyZJVIBT29UjLPF6kIiOG7LtYX1qJSsfqLK1fsuKLn5Hv4XUH3JI0nZD7bWhUc+/MxNa01e2Yy+NSKJuW8qphYW6HL4OfvNr3Dal4HBNwsctRqoiU8LjoR6SmzJU3ACacQNmMpcsCYdCxf9bf8xEe11O4tenlSXvg62S5b3ltDJA9R7jNQBx4XEaVKqMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODmZpxilDsuL0tb9Hz0VwsCOdF4S/1rQP9Cga65NGqk=;
 b=ASL8pP17/tO057kU1od2FcBXrddc/+GDgMkDj3ImbF25ebAP1NVj90BBSI0hFKPkc1ZnoCg+h5vcmMufG04lpetrzKi63EgKAtjGe7oP7tsdJcrp84t5CGsPqmgwWhN+F9D5Vmxr7HRcjoA5VKGScSTLAonH3W0FtjOpDRBMlKOoKW2aK/bR2EoA4sZVj6Luc+PzmXEk4sEhpIHtokZifqMBM0TnLcQ7SwwJFTXqa0dPip4T67ypaeKfRreA4k8MVWiRkxj6VBmJw5XpZMEJp67s5inPohDnvO83EOr9hvMcjPgrFMgqlttNUb7ZBwuQSY3kZGIYe3/s3yenv30mgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODmZpxilDsuL0tb9Hz0VwsCOdF4S/1rQP9Cga65NGqk=;
 b=m5C26+MiFs4y99oPiuV2p6T6NBW35aBHA4xIDxa7jxVUmwbPj0T0DX+gEzkdWM+8GP+J2NCclAdBX3mmAt4OqD1AkeQNkGDcAcdd+xEnNeVhfAdc2KeknPVb8J2oYIE7JwPg7hBYb7jC8W1pFhKdszZWzcsPPCmBgJykYrs7r00=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5050.eurprd08.prod.outlook.com (10.255.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 11:56:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:56:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 05/22] quorum: Fix child permissions
Thread-Topic: [PATCH 05/22] quorum: Fix child permissions
Thread-Index: AQHVb8l9/puJteki7kCd8xaUF6KIlKc8UROA
Date: Wed, 25 Sep 2019 11:56:57 +0000
Message-ID: <681d933c-c337-b922-9595-291b5d22249b@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-6-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-6-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::13)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925145655332
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1990949d-d120-42f5-4f46-08d741af7781
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5050; 
x-ms-traffictypediagnostic: DB8PR08MB5050:
x-microsoft-antispam-prvs: <DB8PR08MB505083F2C9713ACBEDB7A4E8C1870@DB8PR08MB5050.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(136003)(366004)(39850400004)(199004)(189003)(186003)(229853002)(6486002)(14454004)(486006)(446003)(476003)(66066001)(2501003)(6506007)(386003)(31696002)(2616005)(11346002)(31686004)(71190400001)(36756003)(71200400001)(256004)(478600001)(305945005)(99286004)(316002)(8936002)(54906003)(5660300002)(110136005)(2906002)(66476007)(7736002)(66446008)(64756008)(66556008)(81166006)(81156014)(8676002)(66946007)(6436002)(26005)(4326008)(6246003)(6512007)(102836004)(86362001)(76176011)(52116002)(4744005)(25786009)(6116002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5050;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pb6NVT4n2S8loBQ+rcPg0A6P8eOLssfsXT8QlL/1CzmTm3ffqis6znM1SICNzRGbkz9M7vLSPBZUXb34eH1N1Vi4ODJPuMreVc9Y2HvRAE7pTbDB5SwkaRfumqSTdtJCAXs9ISrEh6ZZE1plyrQPiGt2qn3hrYa3IJs8vPFrtJuCWFPnjOePic2T1ieIL0qN3cmTJXxJkbEh10k+OKBW+NMxY6tQ5TBZaLaVrec1uCwkvznybwqW+cdrO1C2FhMndlin3a4YYesO+TOwJwCqIUN6xuP0xQqHbPGf5eJPj9uz9q5Q1/NXifIYdgZqOEMfAry8wef452UAK5RfGhebxf3u6LvZUfIcmd6pPePtpStwcAYpv5zw//9hPFkU3SBte/Xq3pJrJIZdsB3o0BJCEp9P6MgxVm7Q96FUOztCQc0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71A756FDE8B234EA3287C53B7B027D9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1990949d-d120-42f5-4f46-08d741af7781
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:56:57.7751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WeqkQ0bnxNNj6qNvIqB9OSXH+F9NiX3QgKjE3NriTI09mvCvUWDUIn6Ht1ip/2yPW0b4n/iQWuhz/zhFvudROWhoiaHnQgVuei7IAZdTFnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.103
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBRdW9ydW0gaXMgbm90IGFjdHVh
bGx5IGEgZmlsdGVyLiAgSXQgY2Fubm90IHNoYXJlIFdSSVRFIG9yIFJFU0laRSBvbiBpdHMNCj4g
Y2hpbGRyZW4uDQoNCkhtbSwgYmFja3VwLXRvcCBkb24ndCB3YW50IHRvIHNoYXJlIFdSSVRFIG9y
IFJFU0laRSB0b28sIGJ1dCBpdCdzIGEgZmlsdGVyIHN0aWxsLi4NCk1heSBpdCBiZSBqdXN0ICJR
dW9ydW0gY2Fubm90IHNoYXJlIFdSSVRFIG9yIFJFU0laRSBvbiBpdHMgY2hpbGRyZW4uIiA/DQoN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


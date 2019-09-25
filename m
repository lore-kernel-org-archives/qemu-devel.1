Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2E9C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7413E21D7A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uFdhTm08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7413E21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5qs-0005Zk-MD
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5pw-0004Qr-14
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD5pv-0005mf-2j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:51:59 -0400
Received: from mail-eopbgr00134.outbound.protection.outlook.com
 ([40.107.0.134]:30476 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD5pu-0005lr-T3; Wed, 25 Sep 2019 07:51:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRUfkotm5I+ttHJeq5TkIuhM0tDs6ivwHclZcGbbqBSMZ56v117VJQ8QXSuwANgIZrJFC04a8jj0yAVIQhrr7V8qvxjrptJQ0VSHOrg/9493w+LOm+f0iSyts7Wgm06l9pFkd+ZDA3862j1U0F8XUDQZoXlKHmjRle8ec2SgeJI5lor0kYrDBuxIn35e4P5oik3xQcABx4rn5dP0wbXgON+YFA2jLKIHB4P6llxiuMfkPckB4RG/0pd7YKF9FUSMuGubZZ8zLTkQqB/qsDRFZYun79DRiG9BbRiXkNrGkLZVes/tawz51aXhZUf6NRkeBW+NvwpfuNcpPjdJtNAbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/8YEB9dYSPPxZowiXftWySKfM74SGOdefOGJ8CPWcI=;
 b=bXUs4aJhxEWGuDRNqrYAZ12RqB24/AtGVBGDSQgzCyyp5Q3mJ6tMSNTDDuk4tgpbhN35GAMNQy5vQezIMSm9OYE7crjIB91bogaqQcl/a0sx7JY/Ft5VDoUUQ0x6g7WHMtyU05zoaFfTPrqN/edFppTbQnfWzg5ra8GukAI6SC/hR9wI+HQVRXjEY/aSKC2sh1glv5YuNv1S+8VQk+MrU5KmgQdSBJRGEOrOD+YuR00nyzjKZ1cMG909puVPZmnmFrk8Qxnwnl2OzfMbsoKwrymN0r5rFRYp+3WascgHh5Hz8LW0BoyZq4f53vHArsV2pHt62l0tM6/MM17/nsFduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/8YEB9dYSPPxZowiXftWySKfM74SGOdefOGJ8CPWcI=;
 b=uFdhTm08pR8QU2s+tQZYznZ2mjWCeTqYz3uJsjsDb6xi4vWA6i4ugedUjhYdoVh2NZCJeJlbHt58G449xoxTXtXt3cBbT5+0PQ/xPHnzvUnJoYyWPQqw37A3wVCsTymNUPrU8QvGjdrltLrL7KQEHKYsRmp8OjHXHbxOtvZD/yo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8SPR01MB0006.eurprd08.prod.outlook.com (10.255.4.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Wed, 25 Sep 2019 11:51:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 11:51:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 04/22] iotests: Let 041 use -blockdev for quorum children
Thread-Topic: [PATCH 04/22] iotests: Let 041 use -blockdev for quorum children
Thread-Index: AQHVb8toEeAHV2zhcEeVhkSljmyg9ac8T6kA
Date: Wed, 25 Sep 2019 11:51:56 +0000
Message-ID: <30aeebb7-6449-e3e1-a65b-1251fa21e4c2@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-5-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-5-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0009.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::19)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925145154082
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4289162d-c973-4ac8-22c9-08d741aec3f4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8SPR01MB0006; 
x-ms-traffictypediagnostic: DB8SPR01MB0006:
x-microsoft-antispam-prvs: <DB8SPR01MB0006FE3D812F216BD3D07625C1870@DB8SPR01MB0006.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(6486002)(8936002)(66446008)(64756008)(4326008)(76176011)(66946007)(66476007)(52116002)(54906003)(6116002)(71190400001)(71200400001)(478600001)(4744005)(14454004)(99286004)(31696002)(66066001)(110136005)(316002)(66556008)(305945005)(476003)(25786009)(102836004)(386003)(186003)(6506007)(256004)(11346002)(446003)(81156014)(6512007)(5660300002)(2501003)(14444005)(86362001)(2616005)(8676002)(486006)(36756003)(7736002)(31686004)(6436002)(229853002)(6246003)(3846002)(81166006)(26005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8SPR01MB0006;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wlM5JW/msCH8gFB3vmZ3idw0Ihfa+uacEyPPAvijhfSBnwXmdPyGGyYzKZmlYVTzJ/9sVbm4jFCthfBAnikhi/VPVpruW0N/1hjua1tsLvb1vhi1ziiXvcufSGs/RA7YVQkn1Ug7WyJTGtNGrxT2wYgxM0n+6S6vySBdYiVkSDuxDWOQj4H6XlHTc2gy6NjGdrf74LkQFAck+eLy/0fDM81rOz3aIjinwbDRJ1+3GcmGxpHBPTbldV8jDUdFQAY65bd9gfG47rgFRw5zjRJaPxjmQNLirHZnTZH1szOXROxHDSMrQApHXvuGg6j3D2pMnhFYCE7Lq9HvsLVXWxrN40zFQ21nKXWq1W3nTaZR1+NfpPC8c4V49lcom+0zO2/AyhB7XgfJ+PsAINcmR4ahpcm7Yg9GQh4XxrQ1/uOUlek=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B2E1DFF3F4A94D80C6A0B825647353@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4289162d-c973-4ac8-22c9-08d741aec3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 11:51:56.5137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y372rOy7VyDxpy4TgX7MTf1NUK4QCuHrjyFXuhGSeENCwlIhRzBuhGF15pQt+qxlqcebxxIGXWA/DAUHlrESP6faN7q7vd++fA1ui+Mlmaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8SPR01MB0006
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.134
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

MjAuMDkuMjAxOSAxODoyNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBVc2luZyAtZHJpdmUgd2l0aCBk
ZWZhdWx0IG9wdGlvbnMgbWVhbnMgdGhhdCBhIHZpcnRpby1ibGsgZHJpdmUgd2lsbCBiZQ0KPiBj
cmVhdGVkIHRoYXQgaGFzIHdyaXRlIGFjY2VzcyB0byB0aGUgdG8tYmUgcXVvcnVtIGNoaWxkcmVu
LiAgUXVvcnVtDQo+IHNob3VsZCBoYXZlIGV4Y2x1c2l2ZSB3cml0ZSBhY2Nlc3MgdG8gdGhlbSwg
c28gd2Ugc2hvdWxkIHVzZSAtYmxvY2tkZXYNCj4gaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


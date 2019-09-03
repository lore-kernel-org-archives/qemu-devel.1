Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE989C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFD922DBF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 09:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kd+xs2+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFD922DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54yI-0007Ju-T3
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 05:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i54xU-0006qS-Of
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i54xT-000153-7b
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 05:18:40 -0400
Received: from mail-eopbgr130123.outbound.protection.outlook.com
 ([40.107.13.123]:60036 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i54xS-000141-Ju; Tue, 03 Sep 2019 05:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTim+7LwQqkokKDNgQP6QOC+tM0zjMT8WCxr6EX95DMnSBHCMFycp7qxmZAoasdOznIhCHFK84tU1lCqeIoOATq12jYzfVLIPjuE7JntIHJgdw+h9SCP4WRQ+GYnn1lo1h6P8UKFhYni3CGBFF8uPjn9M8WpdV6mWJJI+Q8ZsWLZZbRrplitmrTXphh9jm64kq2dbm566RoQ9A96Yuoe+r9RneSXnBHPL1p3NzQuz6LrhUT7Kxc3SZTWuYTLziHu2OB192FXo241c1u9mbdNzN/iD8Y0Czj8gmvxsMZirs1XIbg2D+cfjQKE8ggzhg0MHMg6UDHZmdXgD+sdOpBvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOx5qVWoVLcGKQw7VsZgRD5w+iAP/LDh6/liGPJqgsU=;
 b=f3yeycl7txIVibzXuuD1tlZ46RHnhInMPv58UCVnclJlE/x7dGpv+enD/fTT39rTQTWB1w6BbzKy7c0btY1Be/vh2m0eYoTFKaVkDb0FgLCpUYhqsllB64ihPutfKn/YnMl7m6vTrMhARWW2+1D/nZOd6CbpuMCG0LjJK/R9AiXOAsSgGc9apDH236I6bd3NuV1GWlOHk2MFOczoqhAvlENr2LGBZ/Ij8agNIiwzsD8nxIMuUEpyU1ZaDFH2OdSAkYfq/CcTBEy9VnNJ97m9sceDObLhBPwiXDkWkPsiZ07H8uiN1OLDjfMzEWXgnO8CHYFobZh8BfX97T5R1ZSPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOx5qVWoVLcGKQw7VsZgRD5w+iAP/LDh6/liGPJqgsU=;
 b=kd+xs2+f0+b3fDNqUdpCjoq8fVLQXdFxIva8IlZP9L6pdJ9E2PorCQP0le/oAR5aAMqkCuy1DnWwyvAqHf33llRlEu6bF1utPA/isEGIsvZxCO4CcKtI5uH9cl87bjWkmKXG5gAYTJml0cNyOjMffM8tiefEjoo3gzUzZSegPNo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4089.eurprd08.prod.outlook.com (20.179.9.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 09:18:35 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 09:18:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 42/42] iotests: Test committing to overridden backing
Thread-Index: AQHVTs26rO86bLu8zUqMBjZ9yxtWZKcZ04AA
Date: Tue, 3 Sep 2019 09:18:35 +0000
Message-ID: <8220a2b6-ce22-c14a-8feb-e66e6737209c@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-43-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-43-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0344.eurprd05.prod.outlook.com
 (2603:10a6:7:92::39) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190903121832107
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3366d98-822a-4a83-ea92-08d7304fb273
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4089; 
x-ms-traffictypediagnostic: DB8PR08MB4089:
x-microsoft-antispam-prvs: <DB8PR08MB4089BAF5BE68D747EEFA03D0C1B90@DB8PR08MB4089.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(4326008)(66946007)(8936002)(26005)(99286004)(76176011)(110136005)(3846002)(316002)(66476007)(66556008)(64756008)(6246003)(81166006)(81156014)(53936002)(8676002)(66446008)(52116002)(6116002)(6486002)(54906003)(31686004)(5660300002)(186003)(25786009)(486006)(71190400001)(446003)(31696002)(86362001)(478600001)(14454004)(2501003)(2616005)(66066001)(6506007)(558084003)(6512007)(2906002)(386003)(7736002)(305945005)(256004)(476003)(102836004)(11346002)(71200400001)(36756003)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4089;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kwi8zMs5i621IL1hpQAMxJFdPm/TE6SRkeUMSezd6PSzaobRVON7ynxaX8JB/Rr0u5MP2uDWqnMgOqejlELMhqXtCP6xvQ5oqIPviX1MP00ESKZ3mF+fqR/NjPmWCWkIi1fxtiO7bL0maiMiXn4mm69HL4E7ypvBBBPPxyqQxKIXjOuz3hsAtV31l1/LTbVZWGaqtZ90MEYZxwPP+4y0pYeHXoF1u7iATaV1wjMhuxYLEGB5II8gN0Tno+nTcPsajy8jROcTQ4MES2OYEEBeGspa/wTvx33CZV9ol/3HYV5clZw5sBg2ecApi5h8dwUBs7sppdxHZt5uewuoMQSL7xWbqFf+7qk+nnn9K94c4fz/6XAH6nXCnGrIQ37XiXQQ9hurVGuiihOnNEHTQ7W9c2+LwZJX1cqYYbuse/UTN9k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F819B84E4597C94098A9CDF3B9BDBE07@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3366d98-822a-4a83-ea92-08d7304fb273
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 09:18:35.3317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7qIAVvs3hVOS8MQKEeYaz4RSwsxqoBh3GgV6MCFrZhh4J/4bVhz4U4qpJnKNeg9SrnKPVxdOXWTX8y98mpHN5hw29dYv/dRZWDJAq0JrLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4089
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.123
Subject: Re: [Qemu-devel] [PATCH v6 42/42] iotests: Test committing to
 overridden backing
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

MDkuMDguMjAxOSAxOToxNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHo8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRz
b3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==


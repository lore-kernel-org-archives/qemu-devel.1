Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B8C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F85B20872
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eUsDIRKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F85B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjeO-0007EU-BP
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXjdh-0006lL-3N
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXjdf-0003SF-6l
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:24:40 -0500
Received: from mail-eopbgr150117.outbound.protection.outlook.com
 ([40.107.15.117]:7662 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXjde-0003QY-Bk; Thu, 21 Nov 2019 05:24:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNOdMB2CucbtPnbNAK89IYXNAxhPE6U9wbCbK5eNvoK4kN0WF2UxQUiOsqVVYnVmrJqMcPIgw4QoWT5fzft7/VOF53+/cZVchK13wnENtrhdCOuMAIomEjGwCa8nXPMUNy8uZjmzXftO/2F9Ai0+x+BLNTylwFNZiyd8L9mCQIVaCNE9zz4PlVqNdwlOkbbqr+tHELKVSlhXdM1Nbh5YgdXy/84yO/l412LHWDfFeonVTcW4Zko4BogzQaSe+12hnCrqOStozdEGgIOjawmRRtlLpMwe4EXENMoi5r0LrfClsdKmOYpLWOtJlfyOLjY60s+QpCBe2+S+baoFHduAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsuSf1R8ctPnKaC5lo4ZrCj4aGNk+wYvh8WFNlPYNT0=;
 b=MO52bs3hH5mvUTPAQmNCOYNbcEcMJZ/xzGmX4oJD0e7jCsJW1n5gvzQoRlOhRvg4oQhbqZdkn1b7Tqbyj3rnHgxMkUqwDnxRv108P5I26jJxWJPCNRWEXTTTccNCSLqR6N/kZZbrlvw0bermaBgsRhe3q3hUT7EuEdk7NXMo4Tcl0ndxvMULLnKb8vyd5kKEtbbGrlYlS5FmCU5mZ4q0dA3+q9cEW9EWUByxJs8ssgNSCsiswSH7Oh6EhuUiEHI1Ow18sg8j6QmIMqRpRFZQ+SZPib6mILRccswQA8i9PD7fAmbsr4hrfHw1KLmPAofNndN6TwJpf0hKEQCdX3Cmfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsuSf1R8ctPnKaC5lo4ZrCj4aGNk+wYvh8WFNlPYNT0=;
 b=eUsDIRKa+BmjB5AKDFwp9bIggp2gbehn0b0okHqI7LPGX0y+VEqypAtdn75yyU+JJLQ+diDRV8zcNQRqU1yjJV8N1c8GYiZnS3U43Nhgej4ER2RLL4ywB+H+S0B+EF9iY21ag3WXSI8DSW3xiwIex6o118k3wNChmEP4aseAtas=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3320.eurprd08.prod.outlook.com (52.135.165.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 10:24:35 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 10:24:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Topic: [PATCH v2 6/6] iotests: Test committing to short backing file
Thread-Index: AQHVn9KxRltA7uNPbUqM02ssz4EKHKeVbBaA
Date: Thu, 21 Nov 2019 10:24:35 +0000
Message-ID: <10cfda6f-0d42-3ef3-950b-e4c3e3b13e39@virtuozzo.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-7-kwolf@redhat.com>
In-Reply-To: <20191120184501.28159-7-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0167.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::15) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191121132433194
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c962ac-f86c-4bc3-d153-08d76e6d0172
x-ms-traffictypediagnostic: AM6PR08MB3320:
x-microsoft-antispam-prvs: <AM6PR08MB3320CB739104EDFD8BB8D293C14E0@AM6PR08MB3320.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(316002)(81166006)(2906002)(102836004)(81156014)(25786009)(86362001)(31696002)(256004)(446003)(2616005)(66476007)(66556008)(186003)(66446008)(64756008)(26005)(14454004)(99286004)(8936002)(305945005)(8676002)(66946007)(7736002)(6246003)(6512007)(478600001)(66066001)(5660300002)(76176011)(52116002)(2501003)(229853002)(36756003)(110136005)(71190400001)(71200400001)(3846002)(6116002)(11346002)(31686004)(6486002)(4326008)(54906003)(558084003)(386003)(6436002)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3320;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wH3K/QVe2n7ITCNUpsCY13H2nS97doxn570dOjNOuijF64wldwF6EjPmYEE5UGIvHY/YUFD2gvmJUUPLrVHPSbbK/dsO8g5+jfnLz+ZDckLHyeRmq6IS9XSg2O3z9PqzHy9094i0uBKh24jWdgBTYubT8EQy5hin0drww/QA4ZhDmHo0TISOvfdNfxASHhlv6c7DFk5xbrJjCPLzfOMjqU4KApDrq2B4tf0XMUHKRQNpLaKVsDVQlzAc2yYpC/n/fgEU+xN8rH+rA7CilUT4U2W9oQR56nmNJglEenjBtV9gFtAf5FtOnZux/o1HqX5dy4etKjniclq7toRZ4VQmjsU60aWsbDJhyOgt4tjUoCNsJ3Vnb+FxE7A68AlbJSB7ng0gZRjlHiI7n8zaFCzfhm/XyVWX0PeNBg3SPkUovd1fkc20YDTBt+BYJgd+6/u
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <2A9FFBED1648C44B91E00C9691AD8C6C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c962ac-f86c-4bc3-d153-08d76e6d0172
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 10:24:35.2646 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOqZ4SMv0Uey2utqJOoyO27lE1miWEp0ucDQkHm3hIlEk0sunP/pAZLV+ufYVvkXyJiIXHpUI3j1upzIVNQvzqs84qwQnNXEUIQsm7KtYd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3320
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.117
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.11.2019 21:45, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir


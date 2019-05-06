Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51609C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1893E20578
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XR4972oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58682 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNg3v-00009T-6f
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:01:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNg1u-0007Oq-5z
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNg1t-0005lG-81
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:59:50 -0400
Received: from mail-mr2fra01on071e.outbound.protection.outlook.com
	([2a01:111:f400:7e19::71e]:63488
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNg1r-0005iy-6O; Mon, 06 May 2019 11:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=LxduW7+UHd/LcPzq9o20V+gqZEOdHcc9Fiimf9PcDZE=;
	b=XR4972oe4U/0g6S2ufSbgvCMzba7P/3/dSZ8IMkfhl+Xt2R6AisO6hTCBzwaTpqQSoYvHlzVqTHdOeqQQuA0glTykHlZO0zerzJx5U2VOd8b09ounlozhg2VCuQDzVAi93sIHmPv/It0tPQp7iPcGILfvGcGEoONv0Wuus8ROjU=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4875.eurprd08.prod.outlook.com (52.133.111.15) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.12; Mon, 6 May 2019 15:59:44 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 15:59:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 5/5] qcow2: Remove
	BDRVQcow2State.cluster_sectors
Thread-Index: AQHVAEpAZr9BQuN8f0K5K+sckR8m9qZeSNoA
Date: Mon, 6 May 2019 15:59:44 +0000
Message-ID: <8f11aaf4-4115-a5d6-a92b-00dde298eb13@virtuozzo.com>
References: <cover.1556732434.git.berto@igalia.com>
	<6026d9eb2851d22f6ff031e208120735361ea606.1556732434.git.berto@igalia.com>
In-Reply-To: <6026d9eb2851d22f6ff031e208120735361ea606.1556732434.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P195CA0010.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::20)
	To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506185942780
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a97fae4c-ff85-4e33-0590-08d6d23bdb61
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4875; 
x-ms-traffictypediagnostic: PR2PR08MB4875:
x-microsoft-antispam-prvs: <PR2PR08MB48752B55961B07E594757FC0C1300@PR2PR08MB4875.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(346002)(39850400004)(136003)(396003)(199004)(189003)(76176011)(8936002)(81166006)(6506007)(36756003)(25786009)(5660300002)(386003)(446003)(8676002)(478600001)(2501003)(71200400001)(71190400001)(256004)(99286004)(52116002)(81156014)(68736007)(7736002)(66066001)(305945005)(31696002)(102836004)(4326008)(31686004)(186003)(229853002)(6512007)(2906002)(86362001)(6486002)(316002)(53936002)(6436002)(54906003)(110136005)(64756008)(66446008)(66556008)(3846002)(66476007)(6116002)(73956011)(486006)(66946007)(6246003)(476003)(2616005)(26005)(11346002)(14454004)(558084003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4875;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TvQZAltPoEhV/bVrcecTXr2f6/TXAkTvZ8JvtUSooae7LLaeAL05QjrUic9LGiaapv2IvqsL/MQWy9GFNoSkvT/Oirv2K50sU3K63n80umX3VAjHVbZzBABi928DlhzTUK61FneriCNQC/XcSKWWXyJdTYZXayKZhufiJIGJG43Y6yP2BfgGOyc3DeZo7HqRUxtfOIXdXXYMKDbqrjsQOqmf1ulfx1UZix466ntyLsGxsx+NTZUe1aPM4SdyGIOdAZwsAblZEe2ys3wfyUEyHvbEfVFfH0WCWDBT6+5tNCRQCv53mqEMGyVOLZJB9SF+cGoS0jkul1oFha7iXtaHfO9g5RCryrXhNDa08q/6wv64WnBGG3CGcNUKszZwI4T7q2WeX2p9Vr5ev9gSwW0ew4DPFCIcB3ukcBsbi7PFQBo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D3CAA83D58DFC41822086B0661EDAE4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97fae4c-ff85-4e33-0590-08d6d23bdb61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 15:59:44.7147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4875
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e19::71e
Subject: Re: [Qemu-devel] [PATCH v2 5/5] qcow2: Remove
 BDRVQcow2State.cluster_sectors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDUuMjAxOSAyMToxMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IFRoZSBsYXN0IHVzZXIg
b2YgdGhpcyBmaWVsZCBkaXNhcHBlYXJlZCB3aGVuIHdlIHJlcGxhY2UgdGhlDQo+IHNlY3Rvci1i
YXNlZCBiZHJ2X3dyaXRlKCkgd2l0aCB0aGUgYnl0ZS1iYXNlZCBiZHJ2X3B3cml0ZSgpLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQoNCg0K
UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


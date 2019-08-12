Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE730C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 11:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF00206DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 11:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="v0/Ev9MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF00206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx8vW-0001Q3-TJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 07:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37873)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hx8us-0000pt-IZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 07:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hx8ur-0008G2-H1
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 07:55:10 -0400
Received: from mail-eopbgr10127.outbound.protection.outlook.com
 ([40.107.1.127]:55526 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hx8up-0008Ck-JF; Mon, 12 Aug 2019 07:55:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkVP9HfGHVmsGrZdzeUA+Nh0bb8Jh9T3YPn0K8ao1p0DvBNFAXmXsw1IjEjDMRU++MGTozvJCAgwHJkrLxLfGftainvY/K4qo2p6kzOb1lbGNacpVD0WEgON1h+J+y1uHFXFraXWPJlKpXPE4jqx0CF0btBcjPCAUrGrGymSgH7qOEOJhqW4MGOIrhuHnZz6Na7kY+RqwVSYXFoTmdTmBq92CYjsqVBWn3Xgp2/DKvhssQzWcVeMrAofXTbAOeNyxbCWHRuCbNdmiF8TWml7hqoZuxwpB7grDyybRO9HOC6AK8I9KlA5CR99Tz7m1psiYfw6SxDEuUzaNNGtqAJZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePraJtzD9J07Po2yMoMmBx69PuD437vL2ktPxfPwlSM=;
 b=h9YDO1yfnEGO/+UrXVyhUVZ7lWKVjCWDTUvr6MMWu7W38pMnnLtKSjE38ZJ3Ujdml4SHO3Fq+6AojjXZJ7CkXGs5PjRPR5GKXyR14fC/JKsxTDfcJNJhFQVysR3lIJx8bMrDzcRPS8lxsjAth4iVOlmSQ32Qopk2h5kGNz6GAmAyMt+ut1IL4yW//82DcavQ+O2jWKSZjh76B8PC4QsM9PlRrgEvpR0n5H2gS0DXrizfGTWEk+IAMjeHUlL+caeKReB8mvgiIrFr75eByab2K+Ooixa/kHPTBQG/SJWXgri2LrsVLaTArwj8R2WANubuFblSjCM35scFZN88GPO+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePraJtzD9J07Po2yMoMmBx69PuD437vL2ktPxfPwlSM=;
 b=v0/Ev9MHnvV+shmgtkWtlzAtyXW8Ew07TRDvWqsWs+3ZxvcCkvszdnDv+uu3JbCR8M/ci+ufxdKiLf+d/W40CfxF3pf7NBGrAMRv5wk+PvyQ1tIY0hc7Y/ATlqQtCPQiQzYZ1GPNPeP/kY4Q/snQADdByLp0H0Sph2Q5bF1y3DY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5274.eurprd08.prod.outlook.com (10.255.17.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 11:55:03 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 11:55:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 28/42] stream: Deal with filters
Thread-Index: AQHVTs2k4w369nw0SUCmgfgx1zGbGKb3a+4A
Date: Mon, 12 Aug 2019 11:55:03 +0000
Message-ID: <599e6dcf-d997-c635-97fe-641a38ff8aca@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-29-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::20) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812145500141
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 713a45b3-c9c9-4013-eb34-08d71f1be90e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5274; 
x-ms-traffictypediagnostic: DB8PR08MB5274:
x-microsoft-antispam-prvs: <DB8PR08MB5274BB30CA692D17B00F2CD4C1D30@DB8PR08MB5274.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39840400004)(199004)(189003)(110136005)(256004)(66556008)(66476007)(71200400001)(305945005)(11346002)(7736002)(52116002)(66446008)(64756008)(99286004)(2501003)(229853002)(5660300002)(4744005)(316002)(6436002)(6486002)(14454004)(66946007)(54906003)(6512007)(71190400001)(478600001)(86362001)(66066001)(31696002)(476003)(81166006)(53936002)(102836004)(186003)(486006)(2616005)(25786009)(31686004)(2906002)(26005)(76176011)(446003)(4326008)(36756003)(8676002)(6506007)(386003)(6116002)(8936002)(6246003)(3846002)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5274;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OilATg/kLdd8XOOZW5vPZhDBU/2fp2P9QYoV8X1CScACwjiU0wrcWmo1I9QKNUUIYc29Comrqj6l30BMg2SNlWuJ6u1DxDNTgS1g2QeBwrjX3us45zir0yRFgZEOA+4KRio7hG2pwdpr2T57wUrx8flVtcDolgZOjn765leZQpV7UzsofAoZE1Epb0ODf+Zc3/Wm31E1eHEYHGOHpE4ZYDcDXGpAGxWozIzsJ6npWN90DlSXPrZebHMOT2mJulLbPSnIDaRggLWsnZAa4uacFwPY2haxfhBoG4RAzfqvsN19TLLqrQk9oljGIqvKpAj7JV5w082Z0aDKQZRA2GY3PSnZuDUysOteqX8NykxaPNoOZy//339ovz6JgM0ZrJSq4TqLKg8cxY1WXHuZhJNNVX5MYQirZSNS3SbFkRxgCNI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDC59DA46C695147B1C6243C7B91CF97@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a45b3-c9c9-4013-eb34-08d71f1be90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 11:55:03.2512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SauayMXpJQeFg1LyHFyfokgBQhj6DSxpupakp7SEmCoenVpabR5b6XcBXMOudSvJ57cwD0Xhrl7eMDVV2ZpVxsQybRmrVOC8nAQloVn5qtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5274
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.127
Subject: Re: [Qemu-devel] [PATCH v6 28/42] stream: Deal with filters
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

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBCZWNhdXNlIG9mIHRoZSByZWNl
bnQgY2hhbmdlcyB0aGF0IG1ha2UgdGhlIHN0cmVhbSBqb2IgaW5kZXBlbmRlbnQgb2YNCj4gdGhl
IGJhc2Ugbm9kZSBhbmQgaW5zdGVhZCB0cmFjayB0aGUgbm9kZSBhYm92ZSBpdCwgd2UgaGF2ZSB0
byBzcGxpdCB0aGF0DQo+ICJib3R0b20iIG5vZGUgaW50byB0d28gY2FzZXM6IFRoZSBib3R0b20g
Q09XIG5vZGUsIGFuZCB0aGUgbm9kZSBkaXJlY3RseQ0KPiBhYm92ZSB0aGUgYmFzZSBub2RlICh3
aGljaCBtYXkgYmUgYW4gUi9XIGZpbHRlciBvciB0aGUgYm90dG9tIENPVyBub2RlKS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJldmlld2Vk
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


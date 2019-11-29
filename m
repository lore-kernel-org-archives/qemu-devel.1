Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A99C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403C621774
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 08:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SLNVC/WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403C621774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iabzb-0004Ph-Hz
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 03:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iabu2-0002A6-Bo
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iabtw-0003Sy-JW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:45:22 -0500
Received: from mail-eopbgr10116.outbound.protection.outlook.com
 ([40.107.1.116]:44934 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iabtw-0003K0-3d
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:45:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIZtGe4WLl/WNCHNWeL2hx6WvXioweMGTNsE0pEASbPSahrWvMsAbybamtzcCfsJLtQCbUecLgodESF0vjcj5YQso6yF+nnaKx4jZeFAr0EipKC7hlABl0Q+Op1n/LnAnJT3aEIJjJa9qDPcdp6jcoKDHvZKiF5XZMuv5IaFtnHPuvuMYDEycCXBWXBGzNNW3BB20AM3iqsDwsy+UThHVa+tWcQ0xXxeR/1A4cFoZaBR6W6vV9p2vnHP5iMHMr/DpCOjw4AqZokw35IxzZNKetklBTER9HldkkfdosofA3MCKjSG0wizE5ZYRsudJ+kUq1EAhda06qtRhq3NtexTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICRMolxCQkQGR2l2vbiLHOuNXvmf9gVW1lMUtyiP5Ow=;
 b=Xi9HgUwzsl8f+DwOPr74XohXliuTuFj26wP4+YT3PTXRowFMNSJQ5S7HMYV083nowY2KnYH+m/rcfsMZQVHaVsUWlZiJ/YAmy07XdJH1nMsjv4OLxvU8v38Z0x3zAovhjrGw+P/kjukMu80APb4MU8ywKI22GqBxS2v2Qo30yjfgMHKvYtYB0ws5S4eoCfeUAJPEzl1MG9oEnJGnNCi0f/byiumS/g4ELwQOvJ/hQJuwO/oNT7HZUza7SIwLNPjZk+dn55rqgNxE0tV9MPNoqmYAORvm/E6JHG5u3pRn2BhhHoUU8MlfXeS0paJpeFyHHCSxXP16ZfgSD0m7ppa3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICRMolxCQkQGR2l2vbiLHOuNXvmf9gVW1lMUtyiP5Ow=;
 b=SLNVC/WK97Un94oRSS2Wb1KUe9nhPhWy84JuE/ENeHRDqNuc+8XluIYFZ3Ur1wRZEaO4PkLCM0HPZhYkxSF21Bs1j7/ilWYQz/2Je917FU4gOjvUpXzyNuDS0kOcqLpuzXNFM2IJfI/hHMaJk6xx49gvm7GJP0mSpcP4ng0FCxE=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3781.eurprd08.prod.outlook.com (20.178.90.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 29 Nov 2019 08:45:06 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 08:45:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Thread-Topic: [PATCH v6] error: rename errp to errp_in where it is IN-argument
Thread-Index: AQHVpVGz6p/zLL3Qt0SjF9DL93KD5KegpCn6gAAIsQCAAF2o1YAAzXEA
Date: Fri, 29 Nov 2019 08:45:06 +0000
Message-ID: <530fb6c3-55b4-5c11-6888-be4dff693909@virtuozzo.com>
References: <20191127183704.14825-1-vsementsov@virtuozzo.com>
 <878so05bca.fsf@dusky.pond.sub.org>
 <f901e0db-61df-898f-ce18-096bfeadf525@virtuozzo.com>
 <87mucf218w.fsf@dusky.pond.sub.org>
In-Reply-To: <87mucf218w.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0025.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::35) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129114504349
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3938d3ba-795b-4e73-b0cf-08d774a86f24
x-ms-traffictypediagnostic: AM6PR08MB3781:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <AM6PR08MB378133920E91482DFDC6FB26C1460@AM6PR08MB3781.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(346002)(39840400004)(199004)(189003)(81156014)(8676002)(6116002)(966005)(52116002)(66946007)(66446008)(64756008)(81166006)(5660300002)(6436002)(8936002)(305945005)(99286004)(66476007)(2906002)(7736002)(3846002)(66556008)(66066001)(54906003)(36756003)(386003)(6306002)(76176011)(102836004)(6486002)(2616005)(71190400001)(71200400001)(478600001)(11346002)(316002)(6512007)(446003)(6916009)(31686004)(31696002)(25786009)(86362001)(256004)(6506007)(4326008)(186003)(14454004)(6246003)(26005)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3781;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DQR/GPO2/BUXGXX3sBVWGcYz7pYBZaw5ESXGYahORhKGWBl4Ncd5CWmmcVokcnpo5HtnzBxXV4CyPgvHcv3UBjArwKZUyzEjgAdB3NfPZ1FeW687zO1Ne0M69LES07BXbnExoBHLc7d2xQkEAmmzREVG/MqSh32jCWN5RdFrzwiSaFvBuLTO+u67U4kpZhnUCEuVvNpRQketu5buM4gyJHNdCiSMcMQ5jf09CcDmfnqbLKlkzr2cUdYb5+uj06TJqYFPeLwCb51nwj5YTwyoIU1R4BlsZiszVd70bbfLfiPPluhXCRppy7P5IgbIwc0/b2Hvv9i3m8tQRRzvwxAmbnARkAopMNiZ9TmJDB8MOS7r3o8PiegMreA9fYyxZgKadeZ99mQBPP2yBtnueDJjjYwXuOT9jmBP4JLPb8gk3k7oQIPz+WADCm5Y1mtZnDLM/HnL6SHji24EtDXkhuhBOsPZ8A6vA8stF9BNbz3rdIE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D7C282A500E314E9A5A46233530839D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3938d3ba-795b-4e73-b0cf-08d774a86f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 08:45:06.6996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q12C5b0PaO9OS577ROCwnYGhcy6ejSjE99JwEqkIIRrOHKwIAA0RSMoabiD5jsxU1HxVKiGKSpgyksmAzAJa+Jk6w8parlgxt4498WaJUSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3781
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.116
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
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTEuMjAxOSAyMzoyOSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4gICAgICAgW1BB
VENIIHY2XSBibG9jay9zbmFwc2hvdDogcmVuYW1lIEVycm9yICoqIHBhcmFtZXRlciB0byBtb3Jl
IGNvbW1vbiBlcnJwDQo+Pj4gICAgICAgW1BBVENIIHY2XSBody9pMzg2L2FtZF9pb21tdTogcmVu
YW1lIEVycm9yICoqIHBhcmFtZXRlciB0byBtb3JlIGNvbW1vbiBlcnJwDQo+Pj4gICAgICAgW1BB
VENIIHY2XSBxZ2E6IHJlbmFtZSBFcnJvciAqKiBwYXJhbWV0ZXIgdG8gbW9yZSBjb21tb24gZXJy
cA0KPj4+ICAgICAgIFtQQVRDSCB2Nl0gbW9uaXRvci9xbXAtY21kczogcmVuYW1lIEVycm9yICoq
IHBhcmFtZXRlciB0byBtb3JlIGNvbW1vbiBlcnJwDQo+Pj4gICAgICAgW1BBVENIIHY2XSBody9z
MzkweDogcmVuYW1lIEVycm9yICoqIHBhcmFtZXRlciB0byBtb3JlIGNvbW1vbiBlcnJwDQo+Pj4g
ICAgICAgW1BBVENIIHY2XSBody9zZDogZHJvcCBleHRyYSB3aGl0ZXNwYWNlIGluIHNkaGNpX3N5
c2J1c19yZWFsaXplKCkgaGVhZGVyDQo+Pj4gICAgICAgW1BBVENIIHY2XSBody90cG06IHJlbmFt
ZSBFcnJvciAqKiBwYXJhbWV0ZXIgdG8gbW9yZSBjb21tb24gZXJycA0KPj4+ICAgICAgIFtQQVRD
SCB2Nl0gaHcvdXNiOiByZW5hbWUgRXJyb3IgKiogcGFyYW1ldGVyIHRvIG1vcmUgY29tbW9uIGVy
cnANCj4+PiAgICAgICBbUEFUQ0ggdjZdIGluY2x1ZGUvcW9tL29iamVjdC5oOiByZW5hbWUgRXJy
b3IgKiogcGFyYW1ldGVyIHRvIG1vcmUgY29tbW9uIGVycnANCj4+PiAgICAgICBbUEFUQ0ggdjZd
IGJhY2tlbmRzL2NyeXB0b2RldjogZHJvcCBsb2NhbF9lcnIgZnJvbSBjcnlwdG9kZXZfYmFja2Vu
ZF9jb21wbGV0ZSgpDQo+Pj4gICAgICAgW1BBVENIIHY2XSBody92ZmlvL2FwOiBkcm9wIGxvY2Fs
X2VyciBmcm9tIHZmaW9fYXBfcmVhbGl6ZQ0KPj4gLi4gMTkgcGF0Y2hlcy4uIHNob3VsZCBiZSAy
MS4NCj4+DQo+PiBJdCdzIHJlYWxseSBzaW1wbGUgZm9yIG1lIHRvIHJlc2VuZCB0aGVtIGFsbCBp
biBvbmUgdjcgc2VyaWVzLiBTaG91bGQgST8NCj4gTWlnaHQgYWRkIHRvIHRoZSBjb25mdXNpb24u
ICBHb3QgYSBicmFuY2ggSSBjYW4gcHVsbD8NCj4gDQoNCnByZXBhcmF0aW9ucyAjIHY2Og0KDQpo
dHRwczovL3NyYy5vcGVudnoub3JnL3NjbS9+dnNlbWVudHNvdi9xZW11LmdpdCB1cC1hdXRvLWxv
Y2FsLWVyci1wcmVwYXJhdGlvbnMtdjYNCmh0dHBzOi8vc3JjLm9wZW52ei5vcmcvdXNlcnMvdnNl
bWVudHNvdi9yZXBvcy9xZW11L2Jyb3dzZT9hdD1yZWZzJTJGdGFncyUyRnVwLWF1dG8tbG9jYWwt
ZXJyLXByZXBhcmF0aW9ucy12Ng0KDQp0aGUgd2hvbGUgc2VyaWVzICMgdjU6DQoNCmh0dHBzOi8v
c3JjLm9wZW52ei5vcmcvc2NtL352c2VtZW50c292L3FlbXUuZ2l0IHVwLWF1dG8tbG9jYWwtZXJy
LXY1DQpodHRwczovL3NyYy5vcGVudnoub3JnL3VzZXJzL3ZzZW1lbnRzb3YvcmVwb3MvcWVtdS9i
cm93c2U/YXQ9cmVmcyUyRnRhZ3MlMkZ1cC1hdXRvLWxvY2FsLWVyci12NQ0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=


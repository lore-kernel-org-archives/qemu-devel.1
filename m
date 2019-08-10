Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EDC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 15:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D05208C3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 15:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Nparw9M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D05208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwTAY-0001X4-IT
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 11:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwT9y-0000Q0-7A
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 11:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwT9x-0000O6-5D
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 11:19:58 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:57666 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwT9w-0000LM-Ir; Sat, 10 Aug 2019 11:19:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xf9e+5m2vVOvYTR1FLEfDgHFYJTLGj9ivls3oxJKOw/+/WE/fTrGh2Dq0ExfJ4j+ya2VWDwRKqSzDHEgScwwPduiJDM7txp4lwQkNH4qjyE9sCGjYA6QIGKjVHWCFAkiBKPuUR6f7uyB6sNebU6q5a4m2PQImaFVKD4nOsWtnRBelutZ2E9+QvehK9vP+zx3ZoySWZxewn8LNvlZYWQrdEZCTrjkov+ffxua2cgXjXHXvOMEtFGDAw94A4WUxvGODQk9p8nLfwxxYwXgDSeHszRpzzwLc1qQV4dT1I3Adqoqqt340WVvGiY6DvltyYDmvS/p+W0PENl1GMIkNJnq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VvBFnIuB+z5DzmugwswHLgKkTOniXTwWgzQTCbcw9w=;
 b=VBz6koZjrxLAXemF0SOLMQGlpvxi6lLHsCdPpJDxOqUqJDCqB2VSfn0py/gAoQczPf1GPUb75HQiGAGRB7GXcoH8M+eUHvxcNxDyi4+yeOA0PCy+la6pc6mWK0YWDwDo6YT3aMNDq38vZhh/GyHAyx6eAYDMxS6PQmnmj5ujUXRck3k3WgZlycwe5tDfitTsm4LTzM0RCKwRzvNQJHUUIuxaXJQPH2PrfA6tdnGoCfgCSUi7FIwSNjZHmXPx+TYPGiRP/q+K609dlY/QX+F3A6M/zvzYhnU44KFuhYO0M7PxtCK+szBaCDLRRd4fwtBu/+/VMAvthjA6R53JSwamOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VvBFnIuB+z5DzmugwswHLgKkTOniXTwWgzQTCbcw9w=;
 b=Nparw9M57WwYG1E+tyg4s9BKIN4ovzsKJWpmFyjRT8ha2JOL0CuukmAI0pnWZBwUY9hvalkWJMNsylVw4YJgaJ6LT7W+qCtJ51snAFqrYLYx2w9He+GYSn40XZ+kqRXBJ9N0z/1wfPiuD6g/N8oDcngKGhkuskktN9jeQGsSlHg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3996.eurprd08.prod.outlook.com (20.179.9.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Sat, 10 Aug 2019 15:19:52 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 15:19:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 14/42] block: Use CAFs when working with backing chains
Thread-Index: AQHVTs2Or0azIbBsoECzsEoZ7BECiab0gH6A
Date: Sat, 10 Aug 2019 15:19:52 +0000
Message-ID: <3c09b93d-23a0-2ed5-2084-bcceedc79d10@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-15-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-15-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0049.eurprd04.prod.outlook.com
 (2603:10a6:3:19::17) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810181949898
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14f6967b-ef15-4dca-b4be-08d71da63108
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3996; 
x-ms-traffictypediagnostic: DB8PR08MB3996:
x-microsoft-antispam-prvs: <DB8PR08MB3996A2BA8FCFE83C9EFFDACCC1D10@DB8PR08MB3996.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:324;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(376002)(396003)(346002)(39840400004)(189003)(199004)(476003)(446003)(53936002)(66946007)(71190400001)(71200400001)(52116002)(4326008)(2616005)(316002)(11346002)(2501003)(8936002)(25786009)(5660300002)(486006)(26005)(186003)(102836004)(386003)(6506007)(6246003)(76176011)(14444005)(256004)(3846002)(99286004)(558084003)(36756003)(6116002)(31696002)(86362001)(66066001)(2906002)(478600001)(31686004)(110136005)(54906003)(81156014)(8676002)(81166006)(66446008)(305945005)(66476007)(64756008)(66556008)(14454004)(7736002)(6436002)(6486002)(6512007)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3996;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GwidVim6YybAw5Qr34fV8qr8RE4SmiUYwu6yM29STOXUTWbH4RLlvWfvL5CPDx2T+EfHWc1iMHiRPe2yN9dHha+eZblVw5ykAV0MkHgQa+5sRvRwKhhk8D+vLklIxocQb5HTe7G5bzXUeOkVt5iIKInwf91Fi2xm5WacrqvTnSL6DkL2avXmILGv+Q+jHklhrAl8L0LFnGCIAZl+RQRI9ssRJ20z8BgFZxEPS4rSsYv/RX7qmBgvPnE4oppY7s7PIgzP9X9hQKIEfxd8NAdGzbwKdRkbpcGd5dt35O7PyYmuqHbVq9rBIpPgMttXb3tc1EVUUhDWf276ZCiMpiS8UY4jTQEEEBUXX+8qhRdvzcX8PE6Ft9O1O6nnw+aOiN8v393e9lVFz9xr3/cEARB0kgf9iPeBTfQIYRh7/GiyxKw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A864BD6C980474C9BB71DD4555C9E0A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f6967b-ef15-4dca-b4be-08d71da63108
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 15:19:52.3597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ml/nx1sknPD3z36e85dJkgltdXz3gmUpYR8yW+vqBnPL+wMHdl/2tVaXbxs8PtGRGDoolZwvDicjOeCgInRjfJ+uuv0Q3g7XxnrApzQGHd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3996
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.117
Subject: Re: [Qemu-devel] [PATCH v6 14/42] block: Use CAFs when working with
 backing chains
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

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBVc2UgY2hpbGQgYWNjZXNzIGZ1
bmN0aW9ucyB3aGVuIGl0ZXJhdGluZyB0aHJvdWdoIGJhY2tpbmcgY2hhaW5zIHNvDQo+IGZpbHRl
cnMgZG8gbm90IGJyZWFrIHRoZSBjaGFpbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0
eiA8bXJlaXR6QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K


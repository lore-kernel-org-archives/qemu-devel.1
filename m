Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D9C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 17:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCA320644
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 17:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lQ8qGDqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCA320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDu1-0003is-LR
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 13:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60532)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDtb-0003CI-05
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxDtZ-0006An-Se
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 13:14:10 -0400
Received: from mail-eopbgr50125.outbound.protection.outlook.com
 ([40.107.5.125]:55782 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxDtZ-0006AA-Le; Mon, 12 Aug 2019 13:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL2Tz/IUxvVxTRL8yLZXbcqnX8M72gM8qwchEgOQUu85Zvsae0zzHMmXopFV9YJPP0HZvoEuXpacU/PZYw1YudJP1kBA/+YMh6QtkztP+ojSjUdnvhq8yEKTJbnE/nO8S92mrrDynNNe7XWLMePh+pYrKCiwjcyicI+4hf7e3KArWBTCTjUbt6YZv0DhCvaMQci+iGWKcU5BWe8MRG0cl1MWoCAiUA0Vcvf7GGnl3nmsVzJORIAWsF9cTyL1BizFoR+HU3H7rZjJUh1Oa9eJV8PdRTiRqjYlW71mgZuNnAQhTlrQJBqaDG5gwh1plDmA2t6lpO53tb4vU9BXO0X3pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjN+begmDkr+ZNGajw2TTotGtOu0FYOxFgTqBKqTtAA=;
 b=Q3u0trl5jK9HXY8+aidchrXyqdD3Iq7BLS2iqD0dOAtMK7YCBHGRxJ/pO9w0wnicRewbRbsUz1sI5v0nmLWXOcNgTCjNaNq1HGa612wx6YA1ESfxAP6AizcLWIBGBLx66QkfEtCPXAxm0SBfuIWEMg+NsV479eGCiS+9JgyZJJjOB3tneSFKb5Yv+3oHTS8Uw5zakeLAa4bGl6LFifxYcUhdUDvn8qf8/U9m0n61sPKqu2fuj/wr/92Won3PrxHrgUMWCu9nEqPn7zNOUeXe3pgxC6saT2OeoWW+XOmRetzSlPjhDG1ROb/JW/+Pyur8ljX/MYy3O95ljrxDU1ECaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjN+begmDkr+ZNGajw2TTotGtOu0FYOxFgTqBKqTtAA=;
 b=lQ8qGDqVlrcEEp762sV9nwiZSzM5qogQjC5ZzvWgH3lc2x0tjLs1w14wkmemID7qOfOMGyO8KaR0GGF3vTY7GWWH+n6AB9PMv3ZfTqNeijpMd9A/YfXNYXwKO9bLykmk92i7+fnlElLNztJQ4CtbE6VCxp+IrnIINIv1jKMJ/nI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5308.eurprd08.prod.outlook.com (10.255.185.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 17:14:07 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 17:14:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
Thread-Index: AQHVTs2Z4sBlL0bNk0yfK96bh7A+Bab0lzYAgALpq4CAAEQyAA==
Date: Mon, 12 Aug 2019 17:14:07 +0000
Message-ID: <994ec2e4-23fe-58d2-bc4e-120ec1e89d25@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <c5571509-98ed-b99d-37fe-39a1067105cd@virtuozzo.com>
 <4a2b0a48-5ee0-85b7-7519-a3633cefd803@redhat.com>
In-Reply-To: <4a2b0a48-5ee0-85b7-7519-a3633cefd803@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0180.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::28) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812201404625
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ec55066-c5cb-4817-7ac1-08d71f487bbe
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5308; 
x-ms-traffictypediagnostic: DB8PR08MB5308:
x-microsoft-antispam-prvs: <DB8PR08MB53089F2F1A708C6B463CE321C1D30@DB8PR08MB5308.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(5660300002)(476003)(11346002)(229853002)(7736002)(14454004)(2501003)(6512007)(3846002)(25786009)(110136005)(54906003)(2616005)(316002)(446003)(86362001)(31696002)(26005)(36756003)(8936002)(53936002)(66066001)(6246003)(2906002)(256004)(81156014)(4326008)(71200400001)(186003)(71190400001)(53546011)(8676002)(66556008)(66446008)(102836004)(66946007)(64756008)(66476007)(31686004)(99286004)(81166006)(478600001)(386003)(6506007)(76176011)(6486002)(52116002)(6116002)(486006)(305945005)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5308;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yd8+QcK0YA17njdruvOKbvAFcShi1Z01z61uYepQxj2s5AHGKVc79YuRsnPir+8J2E+62wfdyMeX8/Pryxr63w1LbUk454+uSpY2zvzSPtVhzDRU5b2o/GcC7zsQYe9LlXJLrsIG0d1fUi0qqnp8Eq0ROOoqq7MKRsY3sMF7lGrZUgMEKVc1NSmWZxAeVGvFSgJa4i+rhFZYTXE5cpdHXjd6eD6MgXqlcoXPNY1pK1t9mTLp/e4DJHo/l0wPmWp8hd/cztF80jWS34GIyVcSdNRyzBT2aUcKP1Y/rI2gTltUVI2elq2DGPT7MVuEcjkLJFT7UWU1kHBYNu8t5YF3vsiuCaSfX7de8Tqz0jm4HbqRJv3+32qPQMbqiYr1nfjIjvBgmmcszLgoeDR5H+qlX7tGob7WMfc2tx8wveOtPn8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <150688DF7291C04DA0B30100EA4E3AD2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec55066-c5cb-4817-7ac1-08d71f487bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 17:14:07.2062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FEuNtLLgxO3tmn293ljVMYiWGkVJh1KJvc//tT9TrhUY2Fj944OEb23+taSK7/zrfcisvMRZHtPY1F4N8807m2mHZ9UYZpqnGm/HhLn1zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5308
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.125
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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

MTIuMDguMjAxOSAxNjowOSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMC4wOC4xOSAxODo0MSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA5LjA4LjIwMTkgMTk6MTMs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBJZiB0aGUgZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudCBi
ZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKCksIHdlDQo+Pj4gc2hvdWxkIGZhbGwgYmFjayB0
byBjdW11bGF0aW5nIHRoZSBhbGxvY2F0ZWQgc2l6ZSBvZiBhbGwgbm9uLUNPVw0KPj4+IGNoaWxk
cmVuIGluc3RlYWQgb2YganVzdCBicy0+ZmlsZS4NCj4+Pg0KPj4+IFN1Z2dlc3RlZC1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+
IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+
Pj4gICAgYmxvY2suYyB8IDIyICsrKysrKysrKysrKysrKysrKysrLS0NCj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYg
LS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPj4+IGluZGV4IDEwNzBhYTFiYTkuLjZlMWRkYWIw
NTYgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2suYw0KPj4+ICsrKyBiL2Jsb2NrLmMNCj4+PiBAQCAt
NDY1MCw5ICs0NjUwLDI3IEBAIGludDY0X3QgYmRydl9nZXRfYWxsb2NhdGVkX2ZpbGVfc2l6ZShC
bG9ja0RyaXZlclN0YXRlICpicykNCj4+PiAgICAgICAgaWYgKGRydi0+YmRydl9nZXRfYWxsb2Nh
dGVkX2ZpbGVfc2l6ZSkgew0KPj4+ICAgICAgICAgICAgcmV0dXJuIGRydi0+YmRydl9nZXRfYWxs
b2NhdGVkX2ZpbGVfc2l6ZShicyk7DQo+Pj4gICAgICAgIH0NCj4+PiAtICAgIGlmIChicy0+Zmls
ZSkgew0KPj4+IC0gICAgICAgIHJldHVybiBiZHJ2X2dldF9hbGxvY2F0ZWRfZmlsZV9zaXplKGJz
LT5maWxlLT5icyk7DQo+Pj4gKw0KPj4+ICsgICAgaWYgKCFRTElTVF9FTVBUWSgmYnMtPmNoaWxk
cmVuKSkgew0KPj4+ICsgICAgICAgIEJkcnZDaGlsZCAqY2hpbGQ7DQo+Pj4gKyAgICAgICAgaW50
NjRfdCBjaGlsZF9zaXplLCB0b3RhbF9zaXplID0gMDsNCj4+PiArDQo+Pj4gKyAgICAgICAgUUxJ
U1RfRk9SRUFDSChjaGlsZCwgJmJzLT5jaGlsZHJlbiwgbmV4dCkgew0KPj4+ICsgICAgICAgICAg
ICBpZiAoY2hpbGQgPT0gYmRydl9maWx0ZXJlZF9jb3dfY2hpbGQoYnMpKSB7DQo+Pj4gKyAgICAg
ICAgICAgICAgICAvKiBJZ25vcmUgQ09XIGJhY2tpbmcgZmlsZXMgKi8NCj4+PiArICAgICAgICAg
ICAgICAgIGNvbnRpbnVlOw0KPj4+ICsgICAgICAgICAgICB9DQo+Pj4gKw0KPj4+ICsgICAgICAg
ICAgICBjaGlsZF9zaXplID0gYmRydl9nZXRfYWxsb2NhdGVkX2ZpbGVfc2l6ZShjaGlsZC0+YnMp
Ow0KPj4+ICsgICAgICAgICAgICBpZiAoY2hpbGRfc2l6ZSA8IDApIHsNCj4+PiArICAgICAgICAg
ICAgICAgIHJldHVybiBjaGlsZF9zaXplOw0KPj4+ICsgICAgICAgICAgICB9DQo+Pj4gKyAgICAg
ICAgICAgIHRvdGFsX3NpemUgKz0gY2hpbGRfc2l6ZTsNCj4+PiArICAgICAgICB9DQo+Pj4gKw0K
Pj4+ICsgICAgICAgIHJldHVybiB0b3RhbF9zaXplOw0KPj4+ICAgICAgICB9DQo+Pj4gKw0KPj4+
ICAgICAgICByZXR1cm4gLUVOT1RTVVA7DQo+Pj4gICAgfQ0KPj4+ICAgIA0KPj4+DQo+Pg0KPj4g
SG1tLi4NCj4+DQo+PiAxLiBObyBjaGlsZHJlbiAtPiAtRU5PVFNVUA0KPj4gMi4gT25seSBjb3cg
Y2hpbGQgLT4gMA0KPj4gMy4gU29tZSBub24tY293IGNoaWxkcmVuIC0+IFNVTQ0KPj4NCj4+IEl0
J3MgYWxsIGFyZ3VhYmxlICh0aGUgc3RyaWN0ZXN0IHdheSBpcyAtRU5PVFNVUCBpbiBlaXRoZXIg
Y2FzZSksDQo+PiBidXQgaWYgd2Ugd2FudCB0byBmYWxsYmFjayB0byBTVU0gb2Ygbm9uLWNvdyBj
aGlsZHJlbiwgMS4gYW5kIDIuIHNob3VsZCByZXR1cm4NCj4+IHRoZSBzYW1lLg0KPiANCj4gSSBk
b27igJl0IHRoaW5rIDIgaXMgcG9zc2libGUgYXQgYWxsLiAgSWYgeW91IGhhdmUgYSBDT1cgY2hp
bGQsIHlvdSBuZWVkDQo+IHNvbWUgb3RoZXIgY2hpbGQgdG8gQ09XIHRvLg0KPiANCj4gQW5kIGlu
IHRoZSB3ZWlyZCAoYW5kIHByb2JhYmx5IGltcG9zc2libGUpIGNhc2Ugd2hlcmUgYSBub2RlIHJl
YWxseSBvbmx5DQo+IGhhcyBhIENPVyBjaGlsZCwgSeKAmWQgc2F5IGl04oCZcyBjb3JyZWN0IHRo
YXQgaXQgaGFzIGEgZGlzayBzaXplIG9mIDAg4oCTDQo+IGJlY2F1c2UgaXQgaGFzbuKAmXQgQ09X
ZWQgYW55dGhpbmcgeWV0LiAgKEp1c3QgbGlrZSBhIG5ldyBxY293MiBpbWFnZSB3aXRoDQo+IGEg
YmFja2luZyBmaWxlIG9ubHkgaGFzIGl0cyBtZXRhZGF0YSBhcyBpdHMgZGlzayBzaXplLikNCj4g
DQoNCkFncmVlZC4gVGhlbiwgd2h5IG5vdCByZXR1cm4gMCBvbiBbMV0gPw0KDQpBbHNvLCBhbm90
aGVyIGlkZWE6IHNob3VsZG4ndCB3ZSByZXR1cm4gMCBmb3IgZmlsdGVycywgaS5lLiBza2lwIGZp
bHRlcmVkX3J3X2NoaWxkIHRvbz8NClthcyBmaWx0ZXJlZC1jaGlsZCBpcyBtb3JlIGxpa2UgYmFj
a2luZyBjaGlsZCB0aGFuIGZpbGUgb25lLCBpdCdzICJsZXNzIG93bmVkIiBieSBpdHMgcGFyZW50
XQ0KDQp3aXRoIG9yIHdpdGhvdXQgYW55IG9mIHRoZXNlIHN1Z2dlc3Rpb25zOg0KUmV2aWV3ZWQt
Ynk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNv
bT4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


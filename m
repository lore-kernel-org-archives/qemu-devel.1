Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742C4C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C7621920
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MnjGXssr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C7621920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdjb-0005JZ-Qw
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAcqR-0005Lj-BH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAcqO-0001FI-JF
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:30:19 -0400
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:1606 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAcqN-0001Dw-W8; Wed, 18 Sep 2019 12:30:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9EIX8YSBCCVoLYNJ0GwxDuBZp1kmfGWr0W/MZaLbuXbI/tljM68SExkZm2Q7eMlWvVsoap6D7f0gHR+UvK46wexay9Cqo1TSPAdR2HrPTpSRpze1PmbTr7THa0aitv972AM9mXcHG6lgoztjtEQpDNAoACXpHGLRNSxm2YBVjNJdTDp3OsqGB5+yyCidb4L/Q6fsDhw3/ZxPonr+Qu2/hjC122/Ujh6+cwc34SQSmlcBKJ2osmdvAjQ6YtD/HcP/8wbbYxP9/zgSizzlRN676wLbQAf0mxaN1SdEeQRN1vdDgpuF5lRX9fd0hAbsz6Z0ciQQUQtDijXMpCVnaCFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irAJ5S8PRnpu2Q75SotJBIkdq0jZz1A6M/srI4x9HuE=;
 b=bJx5cSKtNDaveeKXqUPm1E++hQjgzOS9+4DSYBUS9JeO/FJpjZeyHDTutmqnfZHaY+AT2vQHt/UZ2Of5pZJ6HE2GATRTGaBg5G/LUEPm5oKQ+yNW8LjowfpHIKRS4dWDYmheyFWXBy5j4NrnP0YStAijX7dEPJNWyvk9HhzDjWI3KzL5SNtkLv0tw0hOTVyYt8jIGBDM1s6qjjVDmBtdKEtOvlIw8gCLNs/JYetAIdSeh6TdkHvkivj9cR8ODJ40to/pzFnnH8NZekZA7oUV19ShDt4rx83geudIvPJ4qMKTnOr6FXTn2YL/ij/D+YcjgLfswoTBNntJpZ2e+Sa9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irAJ5S8PRnpu2Q75SotJBIkdq0jZz1A6M/srI4x9HuE=;
 b=MnjGXssrpAzOxW72qqTfMibFz2m95BJcRFRX9L8qk74GVuVQeKZdPrFfIa0bhbGV+jShYepK8LJEFs/huJpsBW2RjXhUoBZVhvXeKOgezb5qUHA5Nvc+uv5JDjBob1flQLMSKs5s2umQib9C4MLXfjT4ZH39pxmM37QK6O9BxZU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5322.eurprd08.prod.outlook.com (10.255.185.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Wed, 18 Sep 2019 16:30:13 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 16:30:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
Thread-Index: AQHVaXUjK8AjziD5Y0Klk3y7b6bIcqcxqcMA
Date: Wed, 18 Sep 2019 16:30:13 +0000
Message-ID: <19f8eac0-7722-4894-72bb-df7501ca20ef@virtuozzo.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-5-mreitz@redhat.com>
In-Reply-To: <20190912135632.13925-5-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0008.eurprd03.prod.outlook.com
 (2603:10a6:3:76::18) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190918193010246
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f6c005-6d50-42d3-889e-08d73c557b36
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5322; 
x-ms-traffictypediagnostic: DB8PR08MB5322:
x-microsoft-antispam-prvs: <DB8PR08MB532206CF0178B1CFFABDB7BFC18E0@DB8PR08MB5322.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39850400004)(376002)(136003)(396003)(346002)(189003)(199004)(26005)(31686004)(386003)(6506007)(186003)(36756003)(86362001)(54906003)(99286004)(8936002)(102836004)(52116002)(2906002)(81166006)(81156014)(8676002)(110136005)(5660300002)(71190400001)(31696002)(71200400001)(76176011)(316002)(3846002)(6116002)(66446008)(64756008)(66556008)(486006)(2501003)(6512007)(476003)(2616005)(11346002)(446003)(66476007)(14444005)(256004)(66946007)(7736002)(478600001)(25786009)(229853002)(6436002)(14454004)(66066001)(6486002)(4326008)(305945005)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5322;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q8d60j5AvymEmQusMw/74JiQ0CG0fmSzhDSMH93NZGgYlkx/IL/r+y6nFZ0J1u/kXUEYNt+lJqwZC4t++LPXfD/z6hCY8aCi5JXH3pSmOWc8pPXkvN7ao1chaesbmbkPjJPTtgkOIFnZMARfkMlcpiEVYHZYUsFlG/LW8cn3Oc9b5ymmVE1wIWfj5w3Vs1so285f1Ase9vic32ZO/t5nG0RRd+40r+IyXyyjTfzXiw4ywqmZ084Ks1g7aOaBjJSMduBxFYH9lnjbliA01wSapvYavkPLq7AfIhkYU37inBdVzgtMRoYYIJbYwqmsIG9rOCxhHgy2kxBLltYMkFC226pAXF3AIc58uIhNb8AhsCWFWj2Ifb/0YYxeN345Gc088G069HDmFCwcAhOmVjk/VUi1siXvGgv60+gJBsl1v5g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <507DFE54A3EA754681137E41F77E66FF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f6c005-6d50-42d3-889e-08d73c557b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 16:30:13.4683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0Nq+lZbH4m1TRAA8dLKFihm+sVQTXEx566w9ZBBPzv1P9JSdBzCkmygqd/4DzCvSbU8erAJ78rhY6flWCNkyLcCxT37XiyGCJ0O/3MV8VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5322
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDkuMjAxOSAxNjo1NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
UmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MDQxICAgICB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzA0MS5vdXQgfCAgNCArKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA0NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wNDEgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDQxDQo+IGluZGV4IDg1
Njg0MjYzMTEuLjg0YmM2ZDY1ODEgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8w
NDENCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MQ0KPiBAQCAtMTEyMSw2ICsxMTIxLDUw
IEBAIGNsYXNzIFRlc3RPcnBoYW5lZFNvdXJjZShpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhcmdldD0nZGVzdC1ybycpDQo+ICAgICAgICAg
ICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAnZXJyb3IvY2xhc3MnLCAnR2VuZXJpY0Vycm9yJykN
Cj4gICANCj4gKyAgICBkZWYgdGVzdF9mYWlsaW5nX3Blcm1pc3Npb25faW5fY29tcGxldGUoc2Vs
Zik6DQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X25vX2FjdGl2ZV9ibG9ja19qb2JzKCkNCj4gKw0K
PiArICAgICAgICAjIFVuc2hhcmUgY29uc2lzdGVudC1yZWFkIG9uIHRoZSB0YXJnZXQNCj4gKyAg
ICAgICAgIyAoVGhlIG1pcnJvciBqb2IgZG9lcyBub3QgY2FyZSkNCj4gKyAgICAgICAgcmVzdWx0
ID0gc2VsZi52bS5xbXAoJ2Jsb2NrZGV2LWFkZCcsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRyaXZlcj0nYmxrZGVidWcnLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBub2RlX25hbWU9J2Rlc3QtcGVybScsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGltYWdlPSdkZXN0JywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaGFyZV9j
aGlsZF9wZXJtcz1bJ2NvbnNpc3RlbnQtcmVhZCddKQ0KPiArICAgICAgICBzZWxmLmFzc2VydF9x
bXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52
bS5xbXAoJ2Jsb2NrZGV2LW1pcnJvcicsIGpvYl9pZD0nam9iJywgZGV2aWNlPSdzcmMnLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW5jPSdmdWxsJywgdGFyZ2V0PSdkZXN0JywN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmlsdGVyX25vZGVfbmFtZT0nbWlycm9y
LWZpbHRlcicpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7
fSkNCj4gKw0KPiArICAgICAgICAjIFJlcXVpcmUgY29uc2lzdGVudC1yZWFkIG9uIHRoZSBzb3Vy
Y2UNCj4gKyAgICAgICAgIyAoV2UgY2FuIG9ubHkgYWRkIHRoaXMgbm9kZSBvbmNlIHRoZSBqb2Ig
aGFzIHN0YXJ0ZWQsIG9yIGl0DQo+ICsgICAgICAgICMgd2lsbCBjb21wbGFpbiB0aGF0IGl0IGRv
ZXMgbm90IHdhbnQgdG8gcnVuIG9uIG5vbi1yb290IG5vZGVzKQ0KPiArICAgICAgICByZXN1bHQg
PSBzZWxmLnZtLnFtcCgnYmxvY2tkZXYtYWRkJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZHJpdmVyPSdibGtkZWJ1ZycsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IG5vZGVfbmFtZT0nc3JjLXBlcm0nLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bWFnZT0nc3JjJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGFrZV9jaGlsZF9w
ZXJtcz1bJ2NvbnNpc3RlbnQtcmVhZCddKQ0KPiArICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVz
dWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gKyAgICAgICAgIyBXaGlsZSBjb21wbGV0aW5nLCBt
aXJyb3Igd2lsbCBhdHRlbXB0IHRvIHJlcGxhY2Ugc3JjIGJ5DQo+ICsgICAgICAgICMgZGVzdCwg
d2hpY2ggbXVzdCBmYWlsIGJlY2F1c2Ugc3JjLXBlcm0gcmVxdWlyZXMNCj4gKyAgICAgICAgIyBj
b25zaXN0ZW50LXJlYWQgYnV0IGRlc3QtcGVybSBkb2VzIG5vdCBzaGFyZSBpdDsgdGh1cw0KPiAr
ICAgICAgICAjIGFib3J0aW5nIHRoZSBqb2Igd2hlbiBpdCBpcyBzdXBwb3NlZCB0byBjb21wbGV0
ZQ0KPiArICAgICAgICBzZWxmLmNvbXBsZXRlX2FuZF93YWl0KCdqb2InLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbXBsZXRpb25fZXJyb3I9J09wZXJhdGlvbiBub3QgcGVy
bWl0dGVkJykNCj4gKw0KPiArICAgICAgICAjIEFzc2VydCB0aGF0IGFsbCBvZiBvdXIgbm9kZXMg
YXJlIHN0aWxsIHRoZXJlIChleGNlcHQgZm9yIHRoZQ0KPiArICAgICAgICAjIG1pcnJvciBmaWx0
ZXIsIHdoaWNoIHNob3VsZCBiZSBnb25lIGRlc3BpdGUgdGhlIGZhaWx1cmUpDQo+ICsgICAgICAg
IG5vZGVzID0gc2VsZi52bS5xbXAoJ3F1ZXJ5LW5hbWVkLWJsb2NrLW5vZGVzJylbJ3JldHVybidd
DQo+ICsgICAgICAgIG5vZGVzID0gbGlzdChtYXAobGFtYmRhIGltYWdlOiBpbWFnZVsnbm9kZS1u
YW1lJ10sIG5vZGVzKSkNCg0KdXNpbmcgbGlzdCBjb21wcmVoZW5zaW9uIGlzIGEgYml0IG1vcmUg
cHl0aG9uaWM6DQpub2RlcyA9IFtub2RlWydub2RlLW5hbWUnXSBmb3Igbm9kZSBpbiBub2Rlc10N
Cg0KPiArDQo+ICsgICAgICAgIGZvciBleHBlY3QgaW4gWydzcmMnLCAnc3JjLXBlcm0nLCAnZGVz
dCcsICdkZXN0LXBlcm0nXToNCj4gKyAgICAgICAgICAgIHNlbGYuYXNzZXJ0VHJ1ZShleHBlY3Qg
aW4gbm9kZXMsICclcyBkaXNhcHBlYXJlZCcgJSBleHBlY3QpDQo+ICsgICAgICAgIHNlbGYuYXNz
ZXJ0RmFsc2UoJ21pcnJvci1maWx0ZXInIGluIG5vZGVzLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICdNaXJyb3IgZmlsdGVyIG5vZGUgZGlkIG5vdCBkaXNhcHBlYXInKQ0KPiArDQo+ICAg
aWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4gICAgICAgaW90ZXN0cy5tYWluKHN1cHBvcnRl
ZF9mbXRzPVsncWNvdzInLCAncWVkJ10sDQo+ICAgICAgICAgICAgICAgICAgICBzdXBwb3J0ZWRf
cHJvdG9jb2xzPVsnZmlsZSddKQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0
MS5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dA0KPiBpbmRleCAyYzQ0OGI0MjM5Li5m
NDk2YmU5MTk3IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dA0KPiAr
KysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gLS4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KPiArLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLg0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLVJhbiA5MCB0ZXN0cw0KPiArUmFu
IDkxIHRlc3RzDQo+ICAgDQo+ICAgT0sNCj4gDQoNCg0KV2l0aCBvciB3aXRob3V0IG15IHN1Z2dl
c3Rpb246DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVu
dHNvdkB2aXJ0dW96em8uY29tPg0KDQpJIGNoZWNrZWQsIHRoYXQgaXQgcGFzcywgYW5kIHRoYXQg
ZmFpbHMgKGdlbmVyYXRlcyBzZWdmYXVsdCkgaWYgZHJvcCBwYXRjaCAwMToNClRlc3RlZC1ieTog
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


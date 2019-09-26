Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717A221D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rStIzMy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717A221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUp3-0001se-CV
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUnD-00008Q-HG
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDUnA-0002f5-57
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:30:49 -0400
Received: from mail-eopbgr10130.outbound.protection.outlook.com
 ([40.107.1.130]:51550 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDUn7-0002bd-Pl; Thu, 26 Sep 2019 10:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a74I5Ne6dIZ0bX569/2xHF4XhuIqffxKKheeC5E+eZyhtznXPa7dNcKaOdIbbVksvwfpZpIdmbU49NvPgGPOTJ4fvq3XYqWb4gBW+e/00oF+J7HTt0EiYXIxArJkJ3DVxJo/0oZNKZavxIK3ioheyHxbQZcRr+U4JBiXOKdN5vuIpNr3yGSEnaVVLWYn0CAyzxeR38gFSZYFxuSBak065n+dD+HYqQOW/lehKxqoh+a4d+sqk7XGhEigQqMVOk1LBDs9vIJRTf15IckO0zbTaaV7wMQ/RJW93bZvZmXsZ71kX1arDk3DJ4hgHmfZIyiSBjUjk2+Ubodor45/uso7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aE+1Dn5kpJQJJSGPwP+rIjBiUg96aWkbMl4ueYL6cw=;
 b=fCrD9YHS0fQD2qbgCtdtghkxgF7QJwllncnFC4RlV3xhk5NonXm2EWaoPkM1mJU/Bbg/K4PyDLahPBNqCI4bLPG+1CK6JNHD576ajzkDt6f7x7wKl+AXTh7Qq1mze0MdJBcb1QqdYTHwecWn46GrNJaOyoOqk1Me4DX/NBNuHcg6M1NLPYbQEXu1fvR/BSBKcFlTwF5qKfusf7unRAmIdHDtMgfpzxg/mMhoVsHWOec6879mAm15LzVzI68E0bCyGSXXr35/aZd4FSViJL2yPhoDjpnYHIjmmCNK/nkt9RPn90+MTLlS/Chapque1VVFzo2P4LKT4ZUeCKXbfyJawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aE+1Dn5kpJQJJSGPwP+rIjBiUg96aWkbMl4ueYL6cw=;
 b=rStIzMy0qhEa2hYOCloBQ8FQq7/6RsvoRbzeI0NO4gnaXpuCkOWUX/yWEedWjymSghNTyuiuwJz/wehJPOqWC2RAvFNw1deJJtLJTSEzYkX69bap3ag5IJX7k4KEHlreLD8C3iblakBbsMpfSXD+xxCcG7IiTM4GqfXfCMnHD8o=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4156.eurprd08.prod.outlook.com (20.179.11.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Thu, 26 Sep 2019 14:30:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 14:30:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 20/22] iotests: Add tests for invalid Quorum @replaces
Thread-Topic: [PATCH 20/22] iotests: Add tests for invalid Quorum @replaces
Thread-Index: AQHVb86ImJ5Wg2FehkWMfAOWQc9/BKc+DlEA
Date: Thu, 26 Sep 2019 14:30:40 +0000
Message-ID: <0851cb70-6c1c-13f6-43f1-05eca75e64e6@virtuozzo.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-21-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-21-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:7:16::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926173038952
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a716c04-2bd0-4017-8a8a-08d7428e1b41
x-ms-traffictypediagnostic: DB8PR08MB4156:
x-microsoft-antispam-prvs: <DB8PR08MB4156BEA714CE72C2AC6F498AC1860@DB8PR08MB4156.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(346002)(366004)(376002)(136003)(189003)(199004)(478600001)(8936002)(14454004)(81156014)(81166006)(8676002)(31686004)(7736002)(305945005)(2501003)(25786009)(5660300002)(36756003)(2906002)(3846002)(6116002)(110136005)(54906003)(316002)(66946007)(66066001)(66446008)(64756008)(66556008)(66476007)(6512007)(4326008)(229853002)(6486002)(256004)(6436002)(99286004)(6506007)(386003)(52116002)(76176011)(31696002)(446003)(11346002)(71200400001)(26005)(476003)(2616005)(6246003)(486006)(71190400001)(102836004)(86362001)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4156;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMsjs5E0wvhN1fBEeKlM6CYdzQsm2U9n2qneuaodW3aHrL+IMMSKfbnOamOG4nphHp24QDkLZKqjUti4WIcqLX7fvfEA8EdbJsX0fyXaCEC+d8rqv+9ldw5LbFm9Ma+r1Li+lT8fHJ/1Qo77G6jMsNODVs/ecPeCPeUy3avu5FVWPff1Dctb573xIV9A5DE5HyBb05RRanJF9yATWaqLEq+2hKB8LpJqoY5/uEOCTgLtZbkDR+kXQJw598DWWET//U1o6esNUzwwrCYjM3VgSSl7pZH2sb5kobPcB7Gma3ZjkOn8TN103fZGT8/co0fAJKi/PCgRH0N0B7+S41HiFOvPeZxD9UcT0I8bawO5/kbwiZO6VLRwPQrIRMYZHH9/2ti7zCL82i4y0CVJJmpmxZNaxUxmrj9695Li/pC7pAs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D153A53E4C3BB43950AB65E32918A80@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a716c04-2bd0-4017-8a8a-08d7428e1b41
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 14:30:40.7624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwGTCKDZg4ZNbPksvzw6PIwPj3Nb7cwged9O0YfXmCdoxlbws/nU6/6KqhZ0wnc6F/Zz3FUzMKELQTcRcPnsu34LEVrnGcOX97zrn4HSwYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4156
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.130
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

MjAuMDkuMjAxOSAxODoyOCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBBZGQgdHdvIHRlc3RzIHRvIHNl
ZSB0aGF0IHlvdSBjYW5ub3QgcmVwbGFjZSBhIFF1b3J1bSBjaGlsZCB3aXRoIHRoZQ0KPiBtaXJy
b3Igam9iIHdoaWxlIHRoZSBjaGlsZCBpcyBpbiB1c2UgYnkgYSBkaWZmZXJlbnQgcGFyZW50Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0t
DQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA0MSAgICAgfCA1NyArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8wNDEub3V0IHwgIDQg
Ky0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDEgYi90ZXN0cy9xZW11
LWlvdGVzdHMvMDQxDQo+IGluZGV4IDIwYWU5NzUwYjcuLjE0OGRjNDdjZTQgMTAwNzU1DQo+IC0t
LSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDENCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA0
MQ0KPiBAQCAtMzQsNiArMzQsOCBAQCBxdW9ydW1faW1nMyA9IG9zLnBhdGguam9pbihpb3Rlc3Rz
LnRlc3RfZGlyLCAncXVvcnVtMy5pbWcnKQ0KPiAgIHF1b3J1bV9yZXBhaXJfaW1nID0gb3MucGF0
aC5qb2luKGlvdGVzdHMudGVzdF9kaXIsICdxdW9ydW1fcmVwYWlyLmltZycpDQo+ICAgcXVvcnVt
X3NuYXBzaG90X2ZpbGUgPSBvcy5wYXRoLmpvaW4oaW90ZXN0cy50ZXN0X2RpciwgJ3F1b3J1bV9z
bmFwc2hvdC5pbWcnKQ0KPiAgIA0KPiArbmJkX3NvY2tfcGF0aCA9IG9zLnBhdGguam9pbihpb3Rl
c3RzLnRlc3RfZGlyLCAnbmJkLnNvY2snKQ0KPiArDQo+ICAgY2xhc3MgVGVzdFNpbmdsZURyaXZl
KGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICBpbWFnZV9sZW4gPSAxICogMTAyNCAqIDEw
MjQgIyBNQg0KPiAgICAgICBxbXBfY21kID0gJ2RyaXZlLW1pcnJvcicNCj4gQEAgLTkwMSw3ICs5
MDMsOCBAQCBjbGFzcyBUZXN0UmVwYWlyUXVvcnVtKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAg
IA0KPiAgICAgICBkZWYgdGVhckRvd24oc2VsZik6DQo+ICAgICAgICAgICBzZWxmLnZtLnNodXRk
b3duKCkNCj4gLSAgICAgICAgZm9yIGkgaW4gc2VsZi5JTUFHRVMgKyBbIHF1b3J1bV9yZXBhaXJf
aW1nLCBxdW9ydW1fc25hcHNob3RfZmlsZSBdOg0KPiArICAgICAgICBmb3IgaSBpbiBzZWxmLklN
QUdFUyArIFsgcXVvcnVtX3JlcGFpcl9pbWcsIHF1b3J1bV9zbmFwc2hvdF9maWxlLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmJkX3NvY2tfcGF0aCBdOg0KPiAgICAgICAg
ICAgICAgICMgRG8gYSB0cnkvZXhjZXB0IGJlY2F1c2UgdGhlIHRlc3QgbWF5IGhhdmUgZGVsZXRl
ZCBzb21lIGltYWdlcw0KPiAgICAgICAgICAgICAgIHRyeToNCj4gICAgICAgICAgICAgICAgICAg
b3MucmVtb3ZlKGkpDQo+IEBAIC0xMDc1LDYgKzEwNzgsNTggQEAgY2xhc3MgVGVzdFJlcGFpclF1
b3J1bShpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gICAgICAgICAgIHNlbGYuYXNzZXJ0X2hhc19i
bG9ja19ub2RlKCJyZXBhaXIwIiwgcXVvcnVtX3JlcGFpcl9pbWcpDQo+ICAgICAgICAgICBzZWxm
LnZtLmFzc2VydF9ibG9ja19wYXRoKCdxdW9ydW0wL2NoaWxkcmVuLjEnLCAncmVwYWlyMCcpDQo+
ICAgDQo+ICsgICAgJycnDQo+ICsgICAgQ2hlY2sgdGhhdCB3ZSBjYW5ub3QgcmVwbGFjZSBhIFF1
b3J1bSBjaGlsZCB3aGVuIGl0IGhhcyBvdGhlcg0KPiArICAgIHBhcmVudHMuDQo+ICsgICAgJycn
DQoNCnlvdSBjb25zdGFudGx5IHVzZSAnJycsIHdoZW4gUEVQOCByZWNvbW1lbmRzICIiIiBmb3Ig
ZG9jLXN0cmluZ3MuIEkgY2FuJ3QNCmNvbXBsYWluLCBhcyBvdXIgcHl0aG9uIGNvZGUgaXMgc29t
ZXRoaW5nIG5vdCByZWxhdGVkIHRvIFBFUDggdW5mb3J0dW5hdGVseS4uDQoNCj4gKyAgICBkZWYg
dGVzdF93aXRoX290aGVyX3BhcmVudChzZWxmKToNCg0KZG9uJ3Qgd2UgbmVlZA0KICAgICAgICAg
aWYgbm90IGlvdGVzdHMuc3VwcG9ydHNfcXVvcnVtKCk6DQogICAgICAgICAgICAgcmV0dXJuDQps
aWtlIGluIG5laWdoYm9ycz8NCg0KPiArICAgICAgICByZXN1bHQgPSBzZWxmLnZtLnFtcCgnbmJk
LXNlcnZlci1zdGFydCcsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHI9ew0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ3R5cGUnOiAndW5peCcsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnZGF0YSc6IHsncGF0aCc6IG5iZF9zb2Nr
X3BhdGh9DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0pDQo+ICsgICAgICAgIHNl
bGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gKw0KPiArICAgICAgICByZXN1
bHQgPSBzZWxmLnZtLnFtcCgnbmJkLXNlcnZlci1hZGQnLCBkZXZpY2U9J2ltZzEnKQ0KPiArICAg
ICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gKyAgICAg
ICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2RyaXZlLW1pcnJvcicsIGpvYl9pZD0nbWlycm9yJywg
ZGV2aWNlPSdxdW9ydW0wJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3luYz0n
ZnVsbCcsIG5vZGVfbmFtZT0ncmVwYWlyMCcsIHJlcGxhY2VzPSdpbWcxJywNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0PXF1b3J1bV9yZXBhaXJfaW1nLCBmb3JtYXQ9aW90
ZXN0cy5pbWdmbXQpDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdlcnJvci9k
ZXNjJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICJDYW5ub3QgcmVwbGFjZSAnaW1nMScg
YnkgYSBub2RlIG1pcnJvcmVkIGZyb20gIg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIidx
dW9ydW0wJywgYmVjYXVzZSBpdCBjYW5ub3QgYmUgZ3VhcmFudGVlZCB0aGF0IGRvaW5nICINCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICJzbyB3b3VsZCBub3QgbGVhZCB0byBhbiBhYnJ1cHQg
Y2hhbmdlIG9mIHZpc2libGUgZGF0YSIpDQo+ICsNCj4gKyAgICAnJycNCj4gKyAgICBUaGUgc2Ft
ZSBhcyB0ZXN0X3dpdGhfb3RoZXJfcGFyZW50KCksIGJ1dCBhZGQgdGhlIE5CRCBzZXJ2ZXIgb25s
eQ0KPiArICAgIHdoZW4gdGhlIG1pcnJvciBqb2IgaXMgYWxyZWFkeSBydW5uaW5nLg0KPiArICAg
ICcnJw0KPiArICAgIGRlZiB0ZXN0X3dpdGhfb3RoZXJfcGFyZW50c19hZnRlcl9taXJyb3Jfc3Rh
cnQoc2VsZik6DQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCduYmQtc2VydmVyLXN0
YXJ0JywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkcj17DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAndHlwZSc6ICd1bml4JywNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICdkYXRhJzogeydwYXRoJzogbmJkX3NvY2tfcGF0aH0NCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSkNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRf
cW1wKHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiArDQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYu
dm0ucW1wKCdkcml2ZS1taXJyb3InLCBqb2JfaWQ9J21pcnJvcicsIGRldmljZT0ncXVvcnVtMCcs
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN5bmM9J2Z1bGwnLCBub2RlX25hbWU9
J3JlcGFpcjAnLCByZXBsYWNlcz0naW1nMScsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHRhcmdldD1xdW9ydW1fcmVwYWlyX2ltZywgZm9ybWF0PWlvdGVzdHMuaW1nZm10KQ0KPiAr
ICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gKyAg
ICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ25iZC1zZXJ2ZXItYWRkJywgZGV2aWNlPSdpbWcx
JykNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiAr
DQo+ICsgICAgICAgICMgVGhlIGZ1bGwgZXJyb3IgbWVzc2FnZSBnb2VzIHRvIHN0ZGVyciwgc28g
d2UgdW5mb3J0dW5hdGVseQ0KPiArICAgICAgICAjIGNhbm5vdCBjaGVjayBpdCBoZXJlDQoNCldl
IGNhbiwgaW90ZXN0cyAxNjkgYW5kIDI0NSBkbyBpdCB3aXRoIGhlbHAgb2Ygdm0uZ2V0X2xvZygp
DQoNCj4gKyAgICAgICAgc2VsZi5jb21wbGV0ZV9hbmRfd2FpdCgnbWlycm9yJywNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wbGV0aW9uX2Vycm9yPSdPcGVyYXRpb24gbm90
IHBlcm1pdHRlZCcpDQo+ICsNCj4gKyAgICAgICAgIyBTaG91bGQgbm90IGhhdmUgYmVlbiByZXBs
YWNlZA0KPiArICAgICAgICBzZWxmLnZtLmFzc2VydF9ibG9ja19wYXRoKCdxdW9ydW0wL2NoaWxk
cmVuLjEnLCAnaW1nMScpDQo+ICsNCj4gKw0KPiAgICMgVGVzdCBtaXJyb3Jpbmcgd2l0aCBhIHNv
dXJjZSB0aGF0IGRvZXMgbm90IGhhdmUgYW55IHBhcmVudHMgKG5vdCBldmVuIGENCj4gICAjIEJs
b2NrQmFja2VuZCkNCj4gICBjbGFzcyBUZXN0T3JwaGFuZWRTb3VyY2UoaW90ZXN0cy5RTVBUZXN0
Q2FzZSk6DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dCBiL3Rlc3Rz
L3FlbXUtaW90ZXN0cy8wNDEub3V0DQo+IGluZGV4IGY0OTZiZTkxOTcuLmZmYzc3OWI0ZDEgMTAw
NjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDEub3V0DQo+ICsrKyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8wNDEub3V0DQo+IEBAIC0xLDUgKzEsNSBAQA0KPiAtLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLg0KPiArLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uDQo+ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtUmFuIDkxIHRlc3RzDQo+ICtSYW4gOTMgdGVzdHMN
Cj4gICANCj4gICBPSw0KPiANCg0KV2l0aCBzdXBwb3J0c19xdW9ydW0gY2hlY2tlZCBsaWtlIGlu
IG5laWdoYm9yIHRlc3QtY2FzZXMgKG9yIHVzZSBAaW90ZXN0cy5za2lwX2lmX3Vuc3VwcG9ydGVk
KToNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


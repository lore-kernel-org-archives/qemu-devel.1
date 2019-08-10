Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E56BC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 11:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DA021743
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 11:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iZn0oo/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DA021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwPkL-0008Mj-N0
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49258)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwPjP-0007r3-H6
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 07:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwPjN-0001S0-9a
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 07:40:19 -0400
Received: from mail-eopbgr50113.outbound.protection.outlook.com
 ([40.107.5.113]:33862 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwPjJ-0001P7-9D; Sat, 10 Aug 2019 07:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noFZ8Qg+Jtj9aW0kZJYN+/Fn7JAMJG+rOb0PPscG6F3KO5eldVbMKYJqEO230BDpKDaYiAtTuDtlksYQWQ/ghTBq7DzrWzbQCkP803+qo5ropE/uM6cVauQRxm5VWB7oziySkfqD9MjU3tmbodY79O7R7EgFl8XQg0gn6mZ+o5UHgsbWZ1lvhyZro1INdF8Fh/cjIMwclJqNOnMdXKF1TrXKguDu5GAP46ApP/tJVwaSav4Goy1dxrFk0dpPh3guO/Uehcm6ZhLsg+sQQ5X4VdyjLbeftvZonIoXOR8LXFSaq1QUvJkLxHw3CENbMwshbDIFhymomwf7Fyx1i6pBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flhjCzXPyiUy/FeXbPgS6lvjeyhtOL/dAxHY179vrCg=;
 b=OMxoEqRNqmXZIJGEUE/4L/hWVMggn7CrZSPGyc9gG7HHvz6w7JBzRFknyJjrfawRJxZ67p78TT4GG5Vkf1fvl5Lq3hvOngpr6ikUHJXfTlCCVQt5EiHQQJmb+xXHnKpnR3pSfHAN2CnF7opQ3ixAtE/zRbWxTATlbpGNTcSwrEL40L+EmQo2l2FaZeiuM93W3fqykoxXwdFKcfXYt8INArj7Cz2N3Id2HTfujcBJcDFSs3aLgDFuD5WNGizHCKMrpv/2u00cK2KKIBI2A0VRKxNSTHEgXbIt0koRyN2dp3v+i3tZ7NNh8JG21dkbo7U/CHOfYqCQRGBV4SKYBIOmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flhjCzXPyiUy/FeXbPgS6lvjeyhtOL/dAxHY179vrCg=;
 b=iZn0oo/ZoAtx/23qth9zNzQM9oMYirQUNxtRX7w7fcvzkZ4rIXZngwEatvUMS0kNO8zGlYSONqIWYn00LilT1bVK6+fyNs39wsXoyAI90jIYqoIS7g+/D/fy8D904anqP0VA4+uVDBRcboRpCuP1Qw5iCQRd6M8VkGLTIiFQ+yU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5308.eurprd08.prod.outlook.com (10.255.185.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Sat, 10 Aug 2019 11:40:10 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.021; Sat, 10 Aug 2019
 11:40:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] iotests: Fix 141 when run with qed
Thread-Index: AQHVTuOq4lIG++lN6E26bOIYJLF+z6b0QvEA
Date: Sat, 10 Aug 2019 11:40:10 +0000
Message-ID: <a5947c95-8fe0-c93a-0b64-1aaeceea5e3a@virtuozzo.com>
References: <20190809185253.17535-1-mreitz@redhat.com>
In-Reply-To: <20190809185253.17535-1-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0046.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190810144008086
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0181755e-0091-477e-827e-08d71d877fe1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5308; 
x-ms-traffictypediagnostic: DB8PR08MB5308:
x-microsoft-antispam-prvs: <DB8PR08MB5308ADBB4C654FF942FA64F3C1D10@DB8PR08MB5308.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 012570D5A0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(66066001)(102836004)(6512007)(6506007)(386003)(8676002)(76176011)(81156014)(14454004)(5660300002)(31696002)(486006)(26005)(81166006)(66446008)(64756008)(66476007)(66946007)(66556008)(6246003)(31686004)(86362001)(4326008)(25786009)(305945005)(6436002)(53936002)(7736002)(71190400001)(71200400001)(52116002)(6486002)(229853002)(478600001)(3846002)(99286004)(54906003)(110136005)(8936002)(316002)(2501003)(2906002)(11346002)(6116002)(446003)(2616005)(14444005)(476003)(256004)(186003)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5308;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VLwoR0LcQoILDREyq8Ao3CtqUXgYVwtg2SnV8bXvAN9783i+75wrIUKb7ksDUp7ypkup2pJXWLWKQb+NFs0my14QLpCES5Zlwqhfkf/qhIU7mQmKo6n62/1iJCOfvi0x9PHpogwvtixWzjJNK0Gq4e87dckPCSWlmHuJ3BWF0QGRx/sgMULv8Pxh3PM6d32ZGpDg941JfFcO1yIIs+BskTiXhOst+rYPuPUqCqa7NkL3uc+HJIC7dg1Lt66D2+eRiZKaZ6rLsaIsJtCVeBFM85jRZF8q91DvHVXte9JcJRJu2op+9ZiyBiOGd+r0GwnZG/oCe0ZksxN+oODnV2821ggtknwv/9QN/AaZeOe4/zwSiyf2cbSG6yYDCQ7jVW5uU/7YWIisWjoDrSmls3P3KfV9LHi6zmFrLLRssMjH05o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B128326E7E8844891021C0EBEF1F8D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0181755e-0091-477e-827e-08d71d877fe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2019 11:40:10.1031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GL1SOl6xCiyhhKVSCoFngn9z3E3QGdOWTfVAntrtMTc/bnVKFgatwqAKwQBKDUPMhKZaxWTMQ3KfP3E/ahqqGZuQDXjFuUwPkb9wFE3o7es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5308
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.113
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 141 when run with qed
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

MDkuMDguMjAxOSAyMTo1MiwgTWF4IFJlaXR6IHdyb3RlOg0KPiA2OWY0NzUwNWVlIGhhcyBjaGFu
Z2VkIHFjb3cyIGluIHN1Y2ggYSB3YXkgdGhhdCB0aGUgY29tbWl0IGpvYiBydW4gaW4NCj4gdGVz
dCAxNDEgKGFuZCAxNDRbMV0pIHJldHVybnMgYmVmb3JlIGl0IGVtaXRzIHRoZSBSRUFEWSBldmVu
dC4gIEhvd2V2ZXIsDQo+IDE0MSBhbHNvIHJ1bnMgd2l0aCBxZWQsIHdoZXJlIHRoZSBvcmRlciBp
cyBzdGlsbCB0aGUgb3RoZXIgd2F5IGFyb3VuZC4NCj4gSnVzdCBmaWx0ZXIgb3V0IHRoZSB7InJl
dHVybiI6IHt9fSBzbyB0aGUgdGVzdCBwYXNzZXMgZm9yIHFlZCBhZ2Fpbi4NCj4gDQo+IFsxXSAx
NDQgb25seSBydW5zIHdpdGggcWNvdzIsIHNvIGl0IGlzIGZpbmUgYXMgaXQgaXMuDQo+IA0KPiBT
dWdnZXN0ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4gRml4ZXM6IDY5ZjQ3NTA1ZWU2NmFmYWE1MTMzMDVkZTBjMTg5NWEyMjRl
NTJjNDUNCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCg0K
SG0sIG5vdCBleGFjdGx5IHJlbWVtYmVyLCBidXQgdGhlc2UgdGhyZWUgbGluZXMgbG9va3MgbGlr
ZSB5b3UgYXJlIGRvaW5nIG15DQp3b3JrLCBJJ20gc29ycnkgZm9yIHRoaXMgOigNCg0KUmV2aWV3
ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpv
LmNvbT4NCg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTQxICAgICAgICAgICB8IDkg
KysrKysrKy0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE0MS5vdXQgICAgICAgfCA1IC0tLS0t
DQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2NvbW1vbi5maWx0ZXIgfCA1ICsrKysrDQo+ICAgMyBm
aWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNDEgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTQx
DQo+IGluZGV4IDIxOTdhODJkNDUuLjhjMmFlNzlmMmIgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8xNDENCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE0MQ0KPiBAQCAtNTgs
MTYgKzU4LDIxIEBAIHRlc3RfYmxvY2tqb2IoKQ0KPiAgICAgICAgICAgICAgICAgfX19IiBcDQo+
ICAgICAgICAgICAncmV0dXJuJw0KPiAgIA0KPiArICAgICMgSWYgIiQyIiBpcyBhbiBldmVudCwg
d2UgbWF5IG9yIG1heSBub3Qgc2VlIGl0IGJlZm9yZSB0aGUNCj4gKyAgICAjIHsicmV0dXJuIjog
e319LiAgVGhlcmVmb3JlLCBmaWx0ZXIgdGhlIHsicmV0dXJuIjoge319IG91dCBib3RoDQo+ICsg
ICAgIyBoZXJlIGFuZCBpbiB0aGUgbmV4dCBjb21tYW5kLiAgKE5hdHVyYWxseSwgaWYgd2UgZG8g
bm90IHNlZSBpdA0KDQpIZXJlICJpdCIgaXMgbm90IGV2ZW50IGJ1dCAieyJyZXR1cm4iOiB7fX0i
LCB3aGljaCBpcyBhIGJpdCBjb25mdXNpbmcsDQphcyBwcmV2aW91c2x5IHdlIHNwZWFrIGFib3V0
IHNlZWluZyBldmVudC4uDQoNCj4gKyAgICAjIGhlcmUsIHdlIHdpbGwgc2VlIGl0IGJlZm9yZSB0
aGUgbmV4dCBjb21tYW5kIGNhbiBiZSBleGVjdXRlZCwNCj4gKyAgICAjIHNvIGl0IHdpbGwgYXBw
ZWFyIGluIHRoZSBuZXh0IF9zZW5kX3FlbXVfY21kJ3Mgb3V0cHV0LikNCj4gICAgICAgX3NlbmRf
cWVtdV9jbWQgJFFFTVVfSEFORExFIFwNCj4gICAgICAgICAgICIkMSIgXA0KPiAgICAgICAgICAg
IiQyIiBcDQo+IC0gICAgICAgIHwgX2ZpbHRlcl9pbWdfY3JlYXRlDQo+ICsgICAgICAgIHwgX2Zp
bHRlcl9pbWdfY3JlYXRlIHwgX2ZpbHRlcl9xbXBfZW1wdHlfcmV0dXJuDQo+ICAgDQo+ICAgICAg
ICMgV2Ugd2FudCB0aGlzIHRvIHJldHVybiBhbiBlcnJvciBiZWNhdXNlIHRoZSBibG9jayBqb2Ig
aXMgc3RpbGwgcnVubmluZw0KPiAgICAgICBfc2VuZF9xZW11X2NtZCAkUUVNVV9IQU5ETEUgXA0K
PiAgICAgICAgICAgInsnZXhlY3V0ZSc6ICdibG9ja2Rldi1kZWwnLA0KPiAgICAgICAgICAgICAn
YXJndW1lbnRzJzogeydub2RlLW5hbWUnOiAnZHJ2MCd9fSIgXA0KPiAtICAgICAgICAnZXJyb3In
IHwgX2ZpbHRlcl9nZW5lcmF0ZWRfbm9kZV9pZHMNCj4gKyAgICAgICAgJ2Vycm9yJyB8IF9maWx0
ZXJfZ2VuZXJhdGVkX25vZGVfaWRzIHwgX2ZpbHRlcl9xbXBfZW1wdHlfcmV0dXJuDQo+ICAgDQo+
ICAgICAgIF9zZW5kX3FlbXVfY21kICRRRU1VX0hBTkRMRSBcDQo+ICAgICAgICAgICAieydleGVj
dXRlJzogJ2Jsb2NrLWpvYi1jYW5jZWwnLA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rl
c3RzLzE0MS5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTQxLm91dA0KPiBpbmRleCA0ZDcxZDlk
Y2FlLi5kYmQzYmRlZjZjIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMTQxLm91
dA0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTQxLm91dA0KPiBAQCAtMTAsNyArMTAsNiBA
QCBGb3JtYXR0aW5nICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMDQ4NTc2
IGJhY2tpbmdfZmlsZT1URVNUX0RJUi9tLg0KPiAgIEZvcm1hdHRpbmcgJ1RFU1RfRElSL28uSU1H
Rk1UJywgZm10PUlNR0ZNVCBzaXplPTEwNDg1NzYgYmFja2luZ19maWxlPVRFU1RfRElSL3QuSU1H
Rk1UIGJhY2tpbmdfZm10PUlNR0ZNVA0KPiAgIHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogIFRJ
TUVTVEFNUCwgIm1pY3Jvc2Vjb25kcyI6ICBUSU1FU1RBTVB9LCAiZXZlbnQiOiAiSk9CX1NUQVRV
U19DSEFOR0UiLCAiZGF0YSI6IHsic3RhdHVzIjogImNyZWF0ZWQiLCAiaWQiOiAiam9iMCJ9fQ0K
PiAgIHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogIFRJTUVTVEFNUCwgIm1pY3Jvc2Vjb25kcyI6
ICBUSU1FU1RBTVB9LCAiZXZlbnQiOiAiSk9CX1NUQVRVU19DSEFOR0UiLCAiZGF0YSI6IHsic3Rh
dHVzIjogInJ1bm5pbmciLCAiaWQiOiAiam9iMCJ9fQ0KPiAteyJyZXR1cm4iOiB7fX0NCj4gICB7
ImVycm9yIjogeyJjbGFzcyI6ICJHZW5lcmljRXJyb3IiLCAiZGVzYyI6ICJOb2RlIGRydjAgaXMg
aW4gdXNlIn19DQo+ICAgeyJyZXR1cm4iOiB7fX0NCj4gICB7InRpbWVzdGFtcCI6IHsic2Vjb25k
cyI6ICBUSU1FU1RBTVAsICJtaWNyb3NlY29uZHMiOiAgVElNRVNUQU1QfSwgImV2ZW50IjogIkpP
Ql9TVEFUVVNfQ0hBTkdFIiwgImRhdGEiOiB7InN0YXR1cyI6ICJhYm9ydGluZyIsICJpZCI6ICJq
b2IwIn19DQo+IEBAIC0yNyw3ICsyNiw2IEBAIEZvcm1hdHRpbmcgJ1RFU1RfRElSL28uSU1HRk1U
JywgZm10PUlNR0ZNVCBzaXplPTEwNDg1NzYgYmFja2luZ19maWxlPVRFU1RfRElSL3QuDQo+ICAg
eyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAgVElNRVNUQU1QLCAibWljcm9zZWNvbmRzIjogIFRJ
TUVTVEFNUH0sICJldmVudCI6ICJKT0JfU1RBVFVTX0NIQU5HRSIsICJkYXRhIjogeyJzdGF0dXMi
OiAicnVubmluZyIsICJpZCI6ICJqb2IwIn19DQo+ICAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMi
OiAgVElNRVNUQU1QLCAibWljcm9zZWNvbmRzIjogIFRJTUVTVEFNUH0sICJldmVudCI6ICJKT0Jf
U1RBVFVTX0NIQU5HRSIsICJkYXRhIjogeyJzdGF0dXMiOiAicmVhZHkiLCAiaWQiOiAiam9iMCJ9
fQ0KPiAgIHsidGltZXN0YW1wIjogeyJzZWNvbmRzIjogIFRJTUVTVEFNUCwgIm1pY3Jvc2Vjb25k
cyI6ICBUSU1FU1RBTVB9LCAiZXZlbnQiOiAiQkxPQ0tfSk9CX1JFQURZIiwgImRhdGEiOiB7ImRl
dmljZSI6ICJqb2IwIiwgImxlbiI6IDAsICJvZmZzZXQiOiAwLCAic3BlZWQiOiAwLCAidHlwZSI6
ICJtaXJyb3IifX0NCj4gLXsicmV0dXJuIjoge319DQo+ICAgeyJlcnJvciI6IHsiY2xhc3MiOiAi
R2VuZXJpY0Vycm9yIiwgImRlc2MiOiAiTm9kZSAnZHJ2MCcgaXMgYnVzeTogYmxvY2sgZGV2aWNl
IGlzIGluIHVzZSBieSBibG9jayBqb2I6IG1pcnJvciJ9fQ0KPiAgIHsicmV0dXJuIjoge319DQo+
ICAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAgVElNRVNUQU1QLCAibWljcm9zZWNvbmRzIjog
IFRJTUVTVEFNUH0sICJldmVudCI6ICJKT0JfU1RBVFVTX0NIQU5HRSIsICJkYXRhIjogeyJzdGF0
dXMiOiAid2FpdGluZyIsICJpZCI6ICJqb2IwIn19DQo+IEBAIC00Miw3ICs0MCw2IEBAIEZvcm1h
dHRpbmcgJ1RFU1RfRElSL28uSU1HRk1UJywgZm10PUlNR0ZNVCBzaXplPTEwNDg1NzYgYmFja2lu
Z19maWxlPVRFU1RfRElSL3QuDQo+ICAgeyJyZXR1cm4iOiB7fX0NCj4gICB7InRpbWVzdGFtcCI6
IHsic2Vjb25kcyI6ICBUSU1FU1RBTVAsICJtaWNyb3NlY29uZHMiOiAgVElNRVNUQU1QfSwgImV2
ZW50IjogIkpPQl9TVEFUVVNfQ0hBTkdFIiwgImRhdGEiOiB7InN0YXR1cyI6ICJjcmVhdGVkIiwg
ImlkIjogImpvYjAifX0NCj4gICB7InRpbWVzdGFtcCI6IHsic2Vjb25kcyI6ICBUSU1FU1RBTVAs
ICJtaWNyb3NlY29uZHMiOiAgVElNRVNUQU1QfSwgImV2ZW50IjogIkpPQl9TVEFUVVNfQ0hBTkdF
IiwgImRhdGEiOiB7InN0YXR1cyI6ICJydW5uaW5nIiwgImlkIjogImpvYjAifX0NCj4gLXsicmV0
dXJuIjoge319DQo+ICAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAgVElNRVNUQU1QLCAibWlj
cm9zZWNvbmRzIjogIFRJTUVTVEFNUH0sICJldmVudCI6ICJKT0JfU1RBVFVTX0NIQU5HRSIsICJk
YXRhIjogeyJzdGF0dXMiOiAicmVhZHkiLCAiaWQiOiAiam9iMCJ9fQ0KPiAgIHsidGltZXN0YW1w
IjogeyJzZWNvbmRzIjogIFRJTUVTVEFNUCwgIm1pY3Jvc2Vjb25kcyI6ICBUSU1FU1RBTVB9LCAi
ZXZlbnQiOiAiQkxPQ0tfSk9CX1JFQURZIiwgImRhdGEiOiB7ImRldmljZSI6ICJqb2IwIiwgImxl
biI6IDAsICJvZmZzZXQiOiAwLCAic3BlZWQiOiAwLCAidHlwZSI6ICJjb21taXQifX0NCj4gICB7
ImVycm9yIjogeyJjbGFzcyI6ICJHZW5lcmljRXJyb3IiLCAiZGVzYyI6ICJOb2RlICdkcnYwJyBp
cyBidXN5OiBibG9jayBkZXZpY2UgaXMgaW4gdXNlIGJ5IGJsb2NrIGpvYjogY29tbWl0In19DQo+
IEBAIC02MSw3ICs1OCw2IEBAIHdyb3RlIDEwNDg1NzYvMTA0ODU3NiBieXRlcyBhdCBvZmZzZXQg
MA0KPiAgIHsicmV0dXJuIjoge319DQo+ICAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAgVElN
RVNUQU1QLCAibWljcm9zZWNvbmRzIjogIFRJTUVTVEFNUH0sICJldmVudCI6ICJKT0JfU1RBVFVT
X0NIQU5HRSIsICJkYXRhIjogeyJzdGF0dXMiOiAiY3JlYXRlZCIsICJpZCI6ICJqb2IwIn19DQo+
ICAgeyJ0aW1lc3RhbXAiOiB7InNlY29uZHMiOiAgVElNRVNUQU1QLCAibWljcm9zZWNvbmRzIjog
IFRJTUVTVEFNUH0sICJldmVudCI6ICJKT0JfU1RBVFVTX0NIQU5HRSIsICJkYXRhIjogeyJzdGF0
dXMiOiAicnVubmluZyIsICJpZCI6ICJqb2IwIn19DQo+IC17InJldHVybiI6IHt9fQ0KPiAgIHsi
ZXJyb3IiOiB7ImNsYXNzIjogIkdlbmVyaWNFcnJvciIsICJkZXNjIjogIk5vZGUgZHJ2MCBpcyBp
biB1c2UifX0NCj4gICB7InJldHVybiI6IHt9fQ0KPiAgIHsidGltZXN0YW1wIjogeyJzZWNvbmRz
IjogIFRJTUVTVEFNUCwgIm1pY3Jvc2Vjb25kcyI6ICBUSU1FU1RBTVB9LCAiZXZlbnQiOiAiSk9C
X1NUQVRVU19DSEFOR0UiLCAiZGF0YSI6IHsic3RhdHVzIjogImFib3J0aW5nIiwgImlkIjogImpv
YjAifX0NCj4gQEAgLTc3LDcgKzczLDYgQEAgd3JvdGUgMTA0ODU3Ni8xMDQ4NTc2IGJ5dGVzIGF0
IG9mZnNldCAwDQo+ICAgeyJyZXR1cm4iOiB7fX0NCj4gICB7InRpbWVzdGFtcCI6IHsic2Vjb25k
cyI6ICBUSU1FU1RBTVAsICJtaWNyb3NlY29uZHMiOiAgVElNRVNUQU1QfSwgImV2ZW50IjogIkpP
Ql9TVEFUVVNfQ0hBTkdFIiwgImRhdGEiOiB7InN0YXR1cyI6ICJjcmVhdGVkIiwgImlkIjogImpv
YjAifX0NCj4gICB7InRpbWVzdGFtcCI6IHsic2Vjb25kcyI6ICBUSU1FU1RBTVAsICJtaWNyb3Nl
Y29uZHMiOiAgVElNRVNUQU1QfSwgImV2ZW50IjogIkpPQl9TVEFUVVNfQ0hBTkdFIiwgImRhdGEi
OiB7InN0YXR1cyI6ICJydW5uaW5nIiwgImlkIjogImpvYjAifX0NCj4gLXsicmV0dXJuIjoge319
DQo+ICAgeyJlcnJvciI6IHsiY2xhc3MiOiAiR2VuZXJpY0Vycm9yIiwgImRlc2MiOiAiTm9kZSBk
cnYwIGlzIGluIHVzZSJ9fQ0KPiAgIHsicmV0dXJuIjoge319DQo+ICAgeyJ0aW1lc3RhbXAiOiB7
InNlY29uZHMiOiAgVElNRVNUQU1QLCAibWljcm9zZWNvbmRzIjogIFRJTUVTVEFNUH0sICJldmVu
dCI6ICJKT0JfU1RBVFVTX0NIQU5HRSIsICJkYXRhIjogeyJzdGF0dXMiOiAiYWJvcnRpbmciLCAi
aWQiOiAiam9iMCJ9fQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2NvbW1vbi5m
aWx0ZXIgYi90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLmZpbHRlcg0KPiBpbmRleCAzNWZkZGM3
NDZmLi44ZTkyMzVkNmZlIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9u
LmZpbHRlcg0KPiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvY29tbW9uLmZpbHRlcg0KPiBAQCAt
MjE5LDUgKzIxOSwxMCBAQCBfZmlsdGVyX25iZCgpDQo+ICAgICAgICAgICAtZSAncyNcKGZvb1x8
UE9SVC9cP1x8LnNvY2tcKTogRmFpbGVkIHRvIC4qJCNcMSMnDQo+ICAgfQ0KPiAgIA0KPiArX2Zp
bHRlcl9xbXBfZW1wdHlfcmV0dXJuKCkNCj4gK3sNCj4gKyAgICBncmVwIC12ICd7InJldHVybiI6
IHt9fScNCj4gK30NCj4gKw0KPiAgICMgbWFrZSBzdXJlIHRoaXMgc2NyaXB0IHJldHVybnMgc3Vj
Y2Vzcw0KPiAgIHRydWUNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


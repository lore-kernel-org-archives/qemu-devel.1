Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB5C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DE820830
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MYyyq/+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DE820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG1vH-0004lQ-IV
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 10:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG1uT-00045F-Ry
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iG1uS-0007cM-4o
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:16:49 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com
 ([40.107.7.107]:24544 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iG1uN-0007Zd-Rg; Thu, 03 Oct 2019 10:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIUp0PUpD1IPBguOMpUY9Z1rUnLrTgD0ij3+QEVoaKUBE1Q81XT5PU5e0fH9PSUqbqNote34pyti6khsb+Dsht0ppsyBCOEkGi15odCdrS8bUjYNsx+i+GfvyAx8Jlkn3EGfPwDUz4rCQWELjWHgFJL8i4krk3BhdmOGGnwpDnhxIDQJ+SEghuvgj8DHXZqLWQdIHWsPWvH56BiAPtS6h7ynPR75tESCn7NY1HJHw6HtdqN+o+R/+QzwHPJ7V/v2dGmxKi2+GNTXIpMqKygutURJhm/lVfaUHB6EM8zzXZ++M1QiYQ9Khp2BZWDoqDt+XmQ1x10TjBtbw/RX8fTFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbvcpIFhaWQ2zvaL4U0YyEz5jSTwBlFVvK2cJZYZI1s=;
 b=AwpOEYhxmMDHnLiaU9UN/7p4lSQXIXR1fZR1nM0AUMoIFj9pekDiPxmjVMsN7mgxrMSFQTjCZ9ZWaVXC1HO2FnNcm9SyV75ZH9D/wP1dLUMyVe8Ax6/yZkYljnYFtlVRsWw9AB3UATxcYgmzaneUgKEVc+p2ncxl7HyWl19jjD/cFLuY/74c5yOwUMgWJkfL5AwbAVXotbIwn27LM4GjqooW1JeXfq8Q4Kbb4vycfKPZGPMbn2kYENMEqJgtRj98/TTdTIuJwGrtUf0OY10VEf4BdYR2aV/yB+YFvxAOkcaklDq7yEh/RWFOV+FNOknJDqzsEOUG5hpn4w/r+x+jkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbvcpIFhaWQ2zvaL4U0YyEz5jSTwBlFVvK2cJZYZI1s=;
 b=MYyyq/+bKTgKcm/kEmgTYncmnGgTZ1OGcRIoQrq2XxTVXu7nq4J4NcKDtmkTARci8Gttjy1tk8cigFNO1XxavXGaYwyJ1x66KHjcvZpoWXnt7VWjKJeifLzSZlkBFH8dvAp/Lblxx32sjZEGYlJ+aZVg46osGeFp5LkFYmUUp4Y=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5211.eurprd08.prod.outlook.com (10.255.19.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 14:16:40 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 14:16:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/6] qcow2: Allow writing compressed data to multiple
 clusters
Thread-Topic: [PATCH v2 1/6] qcow2: Allow writing compressed data to multiple
 clusters
Thread-Index: AQHVeSzrsVr5G3qB+EKEuP2fulXWwadI9/uA
Date: Thu, 3 Oct 2019 14:16:39 +0000
Message-ID: <e8b7e627-6b0a-9662-5f9a-6afe76a2c2e4@virtuozzo.com>
References: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1570026166-748566-2-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1570026166-748566-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::28)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191003171637122
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f21ac445-7112-46af-9d5c-08d7480c4ee5
x-ms-traffictypediagnostic: DB8PR08MB5211:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5211E805E5AEC923BD87DE70C19F0@DB8PR08MB5211.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(36756003)(6246003)(107886003)(2501003)(71190400001)(71200400001)(66946007)(478600001)(14454004)(66446008)(66556008)(66476007)(64756008)(25786009)(5660300002)(31696002)(7416002)(14444005)(256004)(7736002)(305945005)(86362001)(2201001)(476003)(11346002)(6486002)(52116002)(76176011)(6512007)(446003)(486006)(2616005)(186003)(110136005)(99286004)(6436002)(8936002)(316002)(31686004)(66066001)(2906002)(6116002)(229853002)(26005)(386003)(8676002)(81156014)(81166006)(102836004)(6506007)(3846002)(54906003)(4326008)(21314003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5211;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjsjEKKzOIQOL9Jh8eA3DQaGcq6DRsEJ8RHE0iAK4TkQwJ8Uu+SEVpReZ6TBjZJnggxF8MAL3N+qpgW4TpCGt/M708/JDpPFmBeMrBH51XkpsCO/GEWr+EsI13Z/PuIRRz5eGxJXJpTim/UUZzMmrsZO0ymQSM8VMOreMt0nz/Kti4zSHy9zM7wYBaN3MgdrO4GSupnvJEVJxK09pS59KmkEQMAIY6CuBnFLggsP48mhaJ/becOtlUlQhwY/BBpC7TM3RkVP56x4nvp4r4MC3jNZNZoeVrndfPoY0figuy5WxjZAaIpLupO21gxX/nyo9Al1OnPoprKCSie93MBq8G2gofoBy7dwLO90wxGfHZvs08nIR38Vx69LFzxDNg2loML7GtHt5DW0B1ovHnTGxR3a8p/WZbtBSVdXbWwz1fs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22AC4D83DFB9834FA47AF69E1862A639@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ac445-7112-46af-9d5c-08d7480c4ee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 14:16:39.8734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GO59unGnSVG0xXYcL8R7Aeb3ZflQ8SRXPBji0M3YZqzQiWl46Z/Mpq/il8vV2auh/3rm1GOOa9oC/2p/CPDOrZIVzbufD+e1xTScebxlz1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5211
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.107
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDIuMTAuMjAxOSAxNzoyMiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFFFTVUgY3VycmVu
dGx5IHN1cHBvcnRzIHdyaXRpbmcgY29tcHJlc3NlZCBkYXRhIG9mIHNpemUgbGVzcyB0aGFuIG9y
DQo+IGVxdWFsIHRvIG9uZSBjbHVzdGVyLiBUaGlzIHBhdGNoIGFsbG93cyB3cml0aW5nIFFDT1cy
IGNvbXByZXNzZWQgZGF0YQ0KPiB0aGF0IGV4Y2VlZCBvbmUgY2x1c3Rlci4gVGhlIGltcGxlbWVu
dGF0aW9uIGlzIHNpbXBsZSwgd2Ugc3BsaXQgYnVmZmVyZWQNCj4gZGF0YSBpbnRvIHNlcGFyYXRl
IGNsdXN0ZXJzIGFuZCB3cml0ZSB0aGVtIHVzaW5nIHRoZSBleGlzdGluZw0KPiBmdW5jdGlvbmFs
aXR5LiBGb3IgdW5hbGlnbmVkIHJlcXVlc3RzLCB3ZSB1c2UgYSB3b3JrYXJvdW5kIHRoYXQgd3Jp
dGVzDQo+IHRoZSBkYXRhIHdpdGhvdXQgY29tcHJlc3Npb24uDQo+IA0KPiBTdWdnZXN0ZWQtYnk6
IFBhdmVsIEJ1dHN5a2luIDxwYnV0c3lraW5AdmlydHVvenpvLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2
aXJ0dW96em8uY29tPg0KPiAtLS0NCj4gICBibG9jay9xY293Mi5jIHwgMTEzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZp
bGUgY2hhbmdlZCwgODUgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4gaW5kZXggNzk2MWMwNS4u
NTRjY2FmNiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svcWNvdzIuYw0KPiArKysgYi9ibG9jay9xY293
Mi5jDQo+IEBAIC00MTUyLDEwICs0MTUyLDggQEAgZmFpbDoNCj4gICAgICAgcmV0dXJuIHJldDsN
Cj4gICB9DQo+ICAgDQo+IC0vKiBYWFg6IHB1dCBjb21wcmVzc2VkIHNlY3RvcnMgZmlyc3QsIHRo
ZW4gYWxsIHRoZSBjbHVzdGVyIGFsaWduZWQNCj4gLSAgIHRhYmxlcyB0byBhdm9pZCBsb3Npbmcg
Ynl0ZXMgaW4gYWxpZ25tZW50ICovDQo+ICAgc3RhdGljIGNvcm91dGluZV9mbiBpbnQNCj4gLXFj
b3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF9wYXJ0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAr
cWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2soQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgb2Zmc2V0LCB1aW50
NjRfdCBieXRlcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VSU9W
ZWN0b3IgKnFpb3YsIHNpemVfdCBxaW92X29mZnNldCkNCj4gICB7DQo+IEBAIC00MTY1LDM2ICs0
MTYzLDE0IEBAIHFjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF9wYXJ0KEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPiAgICAgICB1aW50OF90ICpidWYsICpvdXRfYnVmOw0KPiAgICAgICB1aW50NjRf
dCBjbHVzdGVyX29mZnNldDsNCj4gICANCj4gLSAgICBpZiAoaGFzX2RhdGFfZmlsZShicykpIHsN
Cj4gLSAgICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPiAtICAgIH0NCj4gLQ0KPiAtICAgIGlmIChi
eXRlcyA9PSAwKSB7DQo+IC0gICAgICAgIC8qIGFsaWduIGVuZCBvZiBmaWxlIHRvIGEgc2VjdG9y
IGJvdW5kYXJ5IHRvIGVhc2UgcmVhZGluZyB3aXRoDQo+IC0gICAgICAgICAgIHNlY3RvciBiYXNl
ZCBJL09zICovDQo+IC0gICAgICAgIGludDY0X3QgbGVuID0gYmRydl9nZXRsZW5ndGgoYnMtPmZp
bGUtPmJzKTsNCj4gLSAgICAgICAgaWYgKGxlbiA8IDApIHsNCj4gLSAgICAgICAgICAgIHJldHVy
biBsZW47DQo+IC0gICAgICAgIH0NCj4gLSAgICAgICAgcmV0dXJuIGJkcnZfY29fdHJ1bmNhdGUo
YnMtPmZpbGUsIGxlbiwgUFJFQUxMT0NfTU9ERV9PRkYsIE5VTEwpOw0KPiAtICAgIH0NCj4gLQ0K
PiAtICAgIGlmIChvZmZzZXRfaW50b19jbHVzdGVyKHMsIG9mZnNldCkpIHsNCj4gLSAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+IC0gICAgfQ0KPiArICAgIGFzc2VydChieXRlcyA8PSBzLT5jbHVz
dGVyX3NpemUpOw0KDQpJIHRoaW5rIHdlJ2QgYmV0dGVyIGFzc2VydA0KDQphc3NlcnQoYnl0ZXMg
PT0gcy0+Y2x1c3Rlcl9zaXplIHx8IChieXRlcyA8IHMtPmNsdXN0ZXJfc2l6ZSAmJiAob2Zmc2V0
ICsgYnl0ZXMgPT0gYmRydl9nZXRsZW5ndGgoKSkNCg0KdG8gbWF0Y2ggb2xkIGxvZ2ljLmpramtq
DQoNCg0KPiAgIA0KPiAgICAgICBidWYgPSBxZW11X2Jsb2NrYWxpZ24oYnMsIHMtPmNsdXN0ZXJf
c2l6ZSk7DQo+IC0gICAgaWYgKGJ5dGVzICE9IHMtPmNsdXN0ZXJfc2l6ZSkgew0KPiAtICAgICAg
ICBpZiAoYnl0ZXMgPiBzLT5jbHVzdGVyX3NpemUgfHwNCj4gLSAgICAgICAgICAgIG9mZnNldCAr
IGJ5dGVzICE9IGJzLT50b3RhbF9zZWN0b3JzIDw8IEJEUlZfU0VDVE9SX0JJVFMpDQo+IC0gICAg
ICAgIHsNCj4gLSAgICAgICAgICAgIHFlbXVfdmZyZWUoYnVmKTsNCj4gLSAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiAtICAgICAgICB9DQo+ICsgICAgaWYgKGJ5dGVzIDwgcy0+Y2x1c3Rl
cl9zaXplKSB7DQo+ICAgICAgICAgICAvKiBaZXJvLXBhZCBsYXN0IHdyaXRlIGlmIGltYWdlIHNp
emUgaXMgbm90IGNsdXN0ZXIgYWxpZ25lZCAqLw0KPiAgICAgICAgICAgbWVtc2V0KGJ1ZiArIGJ5
dGVzLCAwLCBzLT5jbHVzdGVyX3NpemUgLSBieXRlcyk7DQo+ICAgICAgIH0NCj4gLSAgICBxZW11
X2lvdmVjX3RvX2J1ZihxaW92LCBxaW92X29mZnNldCwgYnVmLCBieXRlcyk7DQo+ICsgICAgcWVt
dV9pb3ZlY190b19idWYocWlvdiwgcWlvdl9vZmZzZXQsIGJ1Ziwgcy0+Y2x1c3Rlcl9zaXplKTsN
Cg0KV2h5IGRpZCB5b3UgY2hhbmdlZCBpdCB0byBzLT5jbHVzdGVyX3NpemU/IGJ5dGVzIG1heSBi
ZSBsZXNzIHRoYW4gY2x1c3Rlcg0KDQo+ICAgDQo+ICAgICAgIG91dF9idWYgPSBnX21hbGxvYyhz
LT5jbHVzdGVyX3NpemUpOw0KPiAgIA0KPiBAQCAtNDIyOCw2ICs0MjA0LDkgQEAgcWNvdzJfY29f
cHdyaXRldl9jb21wcmVzc2VkX3BhcnQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgDQo+ICAg
ICAgIEJMS0RCR19FVkVOVChzLT5kYXRhX2ZpbGUsIEJMS0RCR19XUklURV9DT01QUkVTU0VEKTsN
Cj4gICAgICAgcmV0ID0gYmRydl9jb19wd3JpdGUocy0+ZGF0YV9maWxlLCBjbHVzdGVyX29mZnNl
dCwgb3V0X2xlbiwgb3V0X2J1ZiwgMCk7DQo+ICsgICAgaWYgKHJldCA9PSAtRU5PVFNVUCkgew0K
PiArICAgICAgICByZXQgPSBxY293Ml9jb19wd3JpdGV2X3BhcnQoYnMsIG9mZnNldCwgYnl0ZXMs
IHFpb3YsIHFpb3Zfb2Zmc2V0LCAwKTsNCj4gKyAgICB9DQoNCkl0IHNob3VsZCBub3QgYmUgaGVy
ZToNCjEuIHdyaXRlIHdpbGwgdW5saWtlbHkgcmV0dXJuIEVOT1RTVVANCjIuIGlmIHlvdSBtZWFu
IGZhbGxiYWNrIHRvIG5vcm1hbCB3cml0ZSBpZiB3ZSBmYWlsZWQgdG8gY29tcHJlc3MsIGl0J3Mg
ZG9uZSBhYm92ZSBhbHJlYWR5Lg0KDQoNCj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAgICAg
ICAgIGdvdG8gZmFpbDsNCj4gICAgICAgfQ0KPiBAQCAtNDIzOSw2ICs0MjE4LDg0IEBAIGZhaWw6
DQo+ICAgICAgIHJldHVybiByZXQ7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIGNvcm91dGluZV9m
biBpbnQgcWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2tfZW50cnkoQWlvVGFzayAqdGFz
aykNCj4gK3sNCj4gKyAgICBRY293MkFpb1Rhc2sgKnQgPSBjb250YWluZXJfb2YodGFzaywgUWNv
dzJBaW9UYXNrLCB0YXNrKTsNCj4gKw0KPiArICAgIGFzc2VydCghdC0+Y2x1c3Rlcl90eXBlKTsN
Cg0KYW5kIGFzc2VydCghdC0+bDJtZXRhKQ0KDQo+ICsNCj4gKyAgICByZXR1cm4gcWNvdzJfY29f
cHdyaXRldl9jb21wcmVzc2VkX3Rhc2sodC0+YnMsIHQtPm9mZnNldCwgdC0+Ynl0ZXMsIHQtPnFp
b3YsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHQtPnFp
b3Zfb2Zmc2V0KTsNCj4gK30NCj4gKw0KPiArLyoNCj4gKyAqIFhYWDogcHV0IGNvbXByZXNzZWQg
c2VjdG9ycyBmaXJzdCwgdGhlbiBhbGwgdGhlIGNsdXN0ZXIgYWxpZ25lZA0KPiArICAgdGFibGVz
IHRvIGF2b2lkIGxvc2luZyBieXRlcyBpbiBhbGlnbm1lbnQNCj4gKyAqLw0KPiArc3RhdGljIGNv
cm91dGluZV9mbiBpbnQNCj4gK3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF9wYXJ0KEJsb2Nr
RHJpdmVyU3RhdGUgKmJzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWlu
dDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFFFTVVJT1ZlY3RvciAqcWlvdiwgc2l6ZV90IHFpb3Zfb2Zmc2V0KQ0KPiArew0K
PiArICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gKyAgICBRQ293TDJNZXRh
ICpsMm1ldGEgPSBOVUxMOw0KDQppdCdzIGFsd2F5cyBOVUxMIGFuZCBhY3R1YWxseSB1bnVzZWQu
DQoNCj4gKyAgICBBaW9UYXNrUG9vbCAqYWlvID0gTlVMTDsNCj4gKyAgICB1aW50NjRfdCBjdXJy
X29mZiA9IDA7DQo+ICsgICAgaW50IHJldDsNCj4gKw0KPiArICAgIGlmIChoYXNfZGF0YV9maWxl
KGJzKSkgew0KPiArICAgICAgICByZXR1cm4gLUVOT1RTVVA7DQo+ICsgICAgfQ0KPiArDQo+ICsg
ICAgaWYgKGJ5dGVzID09IDApIHsNCj4gKyAgICAgICAgLyoNCj4gKyAgICAgICAgICogYWxpZ24g
ZW5kIG9mIGZpbGUgdG8gYSBzZWN0b3IgYm91bmRhcnkgdG8gZWFzZSByZWFkaW5nIHdpdGgNCj4g
KyAgICAgICAgICogc2VjdG9yIGJhc2VkIEkvT3MNCj4gKyAgICAgICAgICovDQo+ICsgICAgICAg
IGludDY0X3QgY2x1c3Rlcl9vZmZzZXQgPSBiZHJ2X2dldGxlbmd0aChicy0+ZmlsZS0+YnMpOw0K
DQpIbW0sIEkgbGlrZSBvbGQgdmFyaWFibGUgbmFtZSAnbGVuJyBtb3JlLg0KDQo+ICsgICAgICAg
IGlmIChjbHVzdGVyX29mZnNldCA8IDApIHsNCj4gKyAgICAgICAgICAgIHJldHVybiBjbHVzdGVy
X29mZnNldDsNCj4gKyAgICAgICAgfQ0KPiArICAgICAgICByZXR1cm4gYmRydl9jb190cnVuY2F0
ZShicy0+ZmlsZSwgY2x1c3Rlcl9vZmZzZXQsIFBSRUFMTE9DX01PREVfT0ZGLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBp
ZiAob2Zmc2V0X2ludG9fY2x1c3RlcihzLCBvZmZzZXQpKSB7DQo+ICsgICAgICAgIHJldHVybiAt
RUlOVkFMOw0KPiArICAgIH0NCj4gKw0KPiArICAgIHdoaWxlIChieXRlcyAmJiBhaW9fdGFza19w
b29sX3N0YXR1cyhhaW8pID09IDApIHsNCj4gKyAgICAgICAgdWludDMyX3QgY2h1bmtfc2l6ZSA9
IE1JTihieXRlcywgcy0+Y2x1c3Rlcl9zaXplKTsNCj4gKw0KPiArICAgICAgICBhc3NlcnQoKGN1
cnJfb2ZmICYgKEJEUlZfU0VDVE9SX1NJWkUgLSAxKSkgPT0gMCk7DQo+ICsgICAgICAgIGFzc2Vy
dCgoY2h1bmtfc2l6ZSAmIChCRFJWX1NFQ1RPUl9TSVpFIC0gMSkpID09IDApOw0KDQpmaXJzdDog
YWx3YXlzIHVzZSBRRU1VX0lTX0FMSUdORUQgaW5zdGVhZA0Kc2Vjb25kOiB3aHkgZG8geW91IGFk
ZCB0aGVzZSBhc3NlcnRzLCBkbyB3ZSBuZWVkIHRoZW0/DQoNCj4gKw0KPiArICAgICAgICBpZiAo
IWFpbyAmJiBjaHVua19zaXplICE9IGJ5dGVzKSB7DQo+ICsgICAgICAgICAgICBhaW8gPSBhaW9f
dGFza19wb29sX25ldyhRQ09XMl9NQVhfV09SS0VSUyk7DQo+ICsgICAgICAgIH0NCj4gKw0KPiAr
ICAgICAgICByZXQgPSBxY293Ml9hZGRfdGFzayhicywgYWlvLCBxY293Ml9jb19wd3JpdGV2X2Nv
bXByZXNzZWRfdGFza19lbnRyeSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwg
MCwgb2Zmc2V0ICsgY3Vycl9vZmYsIGNodW5rX3NpemUsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHFpb3YsIHFpb3Zfb2Zmc2V0LCBsMm1ldGEpOw0KPiArICAgICAgICBpZiAocmV0
IDwgMCkgew0KPiArICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgIH0NCj4gKyAgICAgICAg
cWlvdl9vZmZzZXQgKz0gY2h1bmtfc2l6ZTsNCj4gKyAgICAgICAgY3Vycl9vZmYgKz0gY2h1bmtf
c2l6ZTsNCg0KeW91IG1heSBqdXN0IG9mZnNldCArPSBjaHVua19zaXplIGFuZCBkcm9wIGV4dHJh
IHZhcmlhYmxlDQoNCj4gKyAgICAgICAgYnl0ZXMgLT0gY2h1bmtfc2l6ZTsNCj4gKyAgICB9DQo+
ICsNCj4gKyAgICBpZiAoYWlvKSB7DQo+ICsgICAgICAgIGFpb190YXNrX3Bvb2xfd2FpdF9hbGwo
YWlvKTsNCj4gKyAgICAgICAgaWYgKHJldCA9PSAwKSB7DQo+ICsgICAgICAgICAgICByZXQgPSBh
aW9fdGFza19wb29sX3N0YXR1cyhhaW8pOw0KPiArICAgICAgICB9DQo+ICsgICAgICAgIGdfZnJl
ZShhaW8pOw0KPiArICAgIH0NCj4gKw0KPiArICAgIHJldHVybiByZXQ7DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW50IGNvcm91dGluZV9mbg0KPiAgIHFjb3cyX2NvX3ByZWFkdl9jb21wcmVzc2Vk
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NF90IGZpbGVfY2x1c3Rlcl9vZmZzZXQsDQo+IA0KDQpvdmVyYWxsIC0gT0sNCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


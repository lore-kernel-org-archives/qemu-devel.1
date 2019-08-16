Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E61CC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3C020665
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rKnlANtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3C020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyfnq-0007QK-Bu
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 13:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyfn9-0006w0-Q9
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyfn7-0003zE-Jt
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:13:31 -0400
Received: from mail-he1eur04on072d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::72d]:39661
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyfn7-0003xH-8S; Fri, 16 Aug 2019 13:13:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7bVxVQavNSBqy7uUu7QHqOC0om+ZKlFxBd+0HuIiLT9ZHCTpTbgXhS0zTK8XHxZWpfa4KO0epkySZcjXp+5Bav78lRO+q4yEAIeKoVp0rC+4mbZOhBiul2bFAxW7tnKFdoftaJkBDxXBTIMfQ2c5xwKl9sCKOwrjMmyrZtS3rbXMaaKYEWFgEXeVlyb98ywQs56iq9ZIUoaVWFv476/OvtuTa/r134D1A9z/W3Lg4mDWooyRs3AmRTyKx1+nDDkAM3Iq142yA8TYE7EsdoIEo2rugC28E0ACHfLTRIW9y2Za/7Ai/4cqzBeMbVuQRV3iDhqb4P7ti/eYm0Au6YMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGkNgKy9nqJOkZutzD0BBbwjwpaPFjPGKSdxO4HE+d4=;
 b=nnqlBs3ElDSHNjVcnlk6yIbUrUeGsdux9UhmGlfPFqNpk3uMrPdsgHnS7OlI2TSJ/gVp3meRV0X1/J929FgGNC1Gotgd0DUjexseBU9+WKn1F3Z1lO5uicQ3hn6rtgjNTmoUTjUZ6/l8Jo3beaTvLo4lwAXovTVama2pzZekdVsnk3fqMFbeVvpcfP2JXheEDmrGR6lQmDMCCwi14qIFxGGklSyRTnKYTMBOld/5lG25JT/ptVxeTu3I12ykxJbFLRSFirB+ZP7E3XzaljV8qb499qQ+SnDwzQ74q0Ka4CeWw1z3WLZNAC4KOECRogz9+o1zUmN8hzkr1cI0/WAV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGkNgKy9nqJOkZutzD0BBbwjwpaPFjPGKSdxO4HE+d4=;
 b=rKnlANtFC2BG0uvzNfCBO/sTdwT/XfC0LJJvswy/xyy1Nr4F3nczrLHlNwwnoI6v0kgjJtJZLDqxNo5NhWSBpSrsHWaW5U/QV7bASeWAU90Igj9LcJAz/ZFPZ+kmyjN4pBpOOw0ZafC+YuFNQcuSFqLwoYsy7zB6GH2/yhpzxLc=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5146.eurprd08.prod.outlook.com (10.255.17.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 17:13:25 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 17:13:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] job: drop job_drain
Thread-Index: AQHVVFS/cnR6tEAI+E+ZAyi9kUoy8Kb+AlOAgAAA1IA=
Date: Fri, 16 Aug 2019 17:13:25 +0000
Message-ID: <9860a4c5-b27b-9aca-87b7-2a82e8b65b4d@virtuozzo.com>
References: <20190816170457.522990-1-vsementsov@virtuozzo.com>
 <01e7f0b2-910b-246e-4e79-759e05c6533d@virtuozzo.com>
In-Reply-To: <01e7f0b2-910b-246e-4e79-759e05c6533d@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190816201323525
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba4e1bb2-f2b4-4029-7e51-08d7226d0cba
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5146; 
x-ms-traffictypediagnostic: DB8PR08MB5146:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5146554E92C529D7F2BF76D9C1AF0@DB8PR08MB5146.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:198;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39830400003)(136003)(376002)(396003)(366004)(199004)(189003)(86362001)(26005)(6246003)(31686004)(107886003)(31696002)(186003)(71200400001)(66946007)(386003)(6506007)(2501003)(102836004)(36756003)(2351001)(4326008)(6512007)(71190400001)(53936002)(66066001)(5660300002)(25786009)(66556008)(486006)(6436002)(256004)(64756008)(229853002)(66446008)(66476007)(2906002)(476003)(6486002)(446003)(5024004)(2616005)(11346002)(5640700003)(52116002)(14454004)(76176011)(6916009)(316002)(54906003)(478600001)(8676002)(6116002)(305945005)(81156014)(7736002)(81166006)(3846002)(8936002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5146;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 23rgM7oFDaLRSt3LNiINevICgTQeMoPYHGGsJJ4xzbg+YNmYsZ1KbfQIl7RTo1aFmF3sPjiiea7sLMjRANg7lOWDX4ZjyEyNJSdcsSNeyWoTvFzLuqe72x18O4qYYkOpBCErEikyP8YOk0VP0FTLHorl2edqsol7X0uaazVFj1nCiWovnklACMw2Pan0L4aWqxecOT0hS9MJQfCE2BYRnwwe+JT0U6REw2DU1ph0cykrWsDwXlVaVW5m/Dd07EH8FzATQuqxoXx+n+oNdWNyN+yDYXxblFdz4hBbRncTkqoXkMEvjzrYMtDnLmRj8VN2KaAtlZroVM/Or9jLe/QXIH2XF1tqsu4mFgte2oqWUDorxXryyqpl27kaAFaWn2Iz1qAy+9z1Mo0vGciu2A4Dr3DYeIHK9tgC7d2QFpY+HmI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0824A644A21F6245B1BD5BE08A801566@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4e1bb2-f2b4-4029-7e51-08d7226d0cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 17:13:25.8714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiSJE2Cmm65/6vqRy/lkvwh3KFcUrZvjEOoo/8+AoNUbCiFUvRBhiKBE4iepfljRciK3vR62DqjxNcdkFMbnd0Jb+UNEcRpgX0/fxg8AVUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5146
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::72d
Subject: Re: [Qemu-devel] [PATCH] job: drop job_drain
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDguMjAxOSAyMDoxMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTYuMDguMjAxOSAyMDowNCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IEluIGpvYl9maW5pc2hfc3luYyBqb2JfZW50ZXIgc2hvdWxkIGJlIGVub3VnaCBmb3IgYSBqb2Ig
dG8gbWFrZSBzb21lDQo+PiBwcm9ncmVzcyBhbmQgZHJhaW5pbmcgaXMgYSB3cm9uZyB0b29sIGZv
ciBpdC4gU28gdXNlIGpvYl9lbnRlciBkaXJlY3RseQ0KPj4gaGVyZSBhbmQgZHJvcCBqb2JfZHJh
aW4gd2l0aCBhbGwgcmVsYXRlZCBzdGFmZiBub3QgdXNlZCBtb3JlLg0KPj4NCj4+IFN1Z2dlc3Rl
ZC1ieTogS2V2aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+
IC0tLQ0KPj4NCj4+IEl0J3MgYSBjb250aW51YXRpb24gZm9yDQo+PiDCoMKgwqAgW1BBVENIIHY0
XSBibG9ja2pvYjogZHJhaW4gYWxsIGpvYiBub2RlcyBpbiBibG9ja19qb2JfZHJhaW4NCj4+DQo+
PiDCoCBpbmNsdWRlL2Jsb2NrL2Jsb2Nram9iX2ludC5oIHwgMTkgLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPj4gwqAgaW5jbHVkZS9xZW11L2pvYi5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMyAtLS0t
LS0tLS0tLS0tDQo+PiDCoCBibG9jay9iYWNrdXAuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfCAxOSArLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiDCoCBibG9jay9jb21taXQuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgLQ0KPj4gwqAgYmxvY2svbWlycm9yLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjggKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gwqAgYmxvY2svc3RyZWFtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxIC0N
Cj4+IMKgIGJsb2Nram9iLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAx
MyAtLS0tLS0tLS0tLS0tDQo+PiDCoCBqb2IuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAxMiArLS0tLS0tLS0tLS0NCj4+IMKgIDggZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxMDEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvYmxvY2svYmxvY2tqb2JfaW50LmggYi9pbmNsdWRlL2Jsb2NrL2Jsb2Nram9iX2lu
dC5oDQo+PiBpbmRleCBlNGEzMThkZDE1Li5lMjgyNGEzNmE4IDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9ibG9jay9ibG9ja2pvYl9pbnQuaA0KPj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9ja2pv
Yl9pbnQuaA0KPj4gQEAgLTUyLDE3ICs1Miw2IEBAIHN0cnVjdCBCbG9ja0pvYkRyaXZlciB7DQo+
PiDCoMKgwqDCoMKgwqAgKiBiZXNpZGVzIGpvYi0+YmxrIHRvIHRoZSBuZXcgQWlvQ29udGV4dC4N
Cj4+IMKgwqDCoMKgwqDCoCAqLw0KPj4gwqDCoMKgwqDCoCB2b2lkICgqYXR0YWNoZWRfYWlvX2Nv
bnRleHQpKEJsb2NrSm9iICpqb2IsIEFpb0NvbnRleHQgKm5ld19jb250ZXh0KTsNCj4+IC0NCj4+
IC3CoMKgwqAgLyoNCj4+IC3CoMKgwqDCoCAqIElmIHRoZSBjYWxsYmFjayBpcyBub3QgTlVMTCwg
aXQgd2lsbCBiZSBpbnZva2VkIHdoZW4gdGhlIGpvYiBoYXMgdG8gYmUNCj4+IC3CoMKgwqDCoCAq
IHN5bmNocm9ub3VzbHkgY2FuY2VsbGVkIG9yIGNvbXBsZXRlZDsgaXQgc2hvdWxkIGRyYWluIEJs
b2NrRHJpdmVyU3RhdGVzDQo+PiAtwqDCoMKgwqAgKiBhcyByZXF1aXJlZCB0byBlbnN1cmUgcHJv
Z3Jlc3MuDQo+PiAtwqDCoMKgwqAgKg0KPj4gLcKgwqDCoMKgICogQmxvY2sgam9icyBtdXN0IHVz
ZSB0aGUgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBmb3Igam9iX2RyaXZlci5kcmFpbiwNCj4+IC3C
oMKgwqDCoCAqIHdoaWNoIHdpbGwgaW4gdHVybiBjYWxsIHRoaXMgY2FsbGJhY2sgYWZ0ZXIgZG9p
bmcgZ2VuZXJpYyBibG9jayBqb2INCj4+IC3CoMKgwqDCoCAqIHN0dWZmLg0KPj4gLcKgwqDCoMKg
ICovDQo+PiAtwqDCoMKgIHZvaWQgKCpkcmFpbikoQmxvY2tKb2IgKmpvYik7DQo+PiDCoCB9Ow0K
Pj4gwqAgLyoqDQo+PiBAQCAtMTA3LDE0ICs5Niw2IEBAIHZvaWQgYmxvY2tfam9iX2ZyZWUoSm9i
ICpqb2IpOw0KPj4gwqDCoCAqLw0KPj4gwqAgdm9pZCBibG9ja19qb2JfdXNlcl9yZXN1bWUoSm9i
ICpqb2IpOw0KPj4gLS8qKg0KPj4gLSAqIGJsb2NrX2pvYl9kcmFpbjoNCj4+IC0gKiBDYWxsYmFj
ayB0byBiZSB1c2VkIGZvciBKb2JEcml2ZXIuZHJhaW4gaW4gYWxsIGJsb2NrIGpvYnMuIERyYWlu
cyB0aGUgbWFpbg0KPj4gLSAqIGJsb2NrIG5vZGUgYXNzb2NpYXRlZCB3aXRoIHRoZSBibG9jayBq
b2JzIGFuZCBjYWxscyBCbG9ja0pvYkRyaXZlci5kcmFpbiBmb3INCj4+IC0gKiBqb2Itc3BlY2lm
aWMgYWN0aW9ucy4NCj4+IC0gKi8NCj4+IC12b2lkIGJsb2NrX2pvYl9kcmFpbihKb2IgKmpvYik7
DQo+PiAtDQo+PiDCoCAvKioNCj4+IMKgwqAgKiBibG9ja19qb2JfcmF0ZWxpbWl0X2dldF9kZWxh
eToNCj4+IMKgwqAgKg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9qb2IuaCBiL2luY2x1
ZGUvcWVtdS9qb2IuaA0KPj4gaW5kZXggOWU3Y2QxZTRhMC4uMDk3MzliOGRkOSAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvcWVtdS9qb2IuaA0KPj4gKysrIGIvaW5jbHVkZS9xZW11L2pvYi5oDQo+
PiBAQCAtMjIwLDEzICsyMjAsNiBAQCBzdHJ1Y3QgSm9iRHJpdmVyIHsNCj4+IMKgwqDCoMKgwqDC
oCAqLw0KPj4gwqDCoMKgwqDCoCB2b2lkICgqY29tcGxldGUpKEpvYiAqam9iLCBFcnJvciAqKmVy
cnApOw0KPj4gLcKgwqDCoCAvKg0KPj4gLcKgwqDCoMKgICogSWYgdGhlIGNhbGxiYWNrIGlzIG5v
dCBOVUxMLCBpdCB3aWxsIGJlIGludm9rZWQgd2hlbiB0aGUgam9iIGhhcyB0byBiZQ0KPj4gLcKg
wqDCoMKgICogc3luY2hyb25vdXNseSBjYW5jZWxsZWQgb3IgY29tcGxldGVkOyBpdCBzaG91bGQg
ZHJhaW4gYW55IGFjdGl2aXRpZXMNCj4+IC3CoMKgwqDCoCAqIGFzIHJlcXVpcmVkIHRvIGVuc3Vy
ZSBwcm9ncmVzcy4NCj4+IC3CoMKgwqDCoCAqLw0KPj4gLcKgwqDCoCB2b2lkICgqZHJhaW4pKEpv
YiAqam9iKTsNCj4+IC0NCj4+IMKgwqDCoMKgwqAgLyoqDQo+PiDCoMKgwqDCoMKgwqAgKiBJZiB0
aGUgY2FsbGJhY2sgaXMgbm90IE5VTEwsIHByZXBhcmUgd2lsbCBiZSBpbnZva2VkIHdoZW4gYWxs
IHRoZSBqb2JzDQo+PiDCoMKgwqDCoMKgwqAgKiBiZWxvbmdpbmcgdG8gdGhlIHNhbWUgdHJhbnNh
Y3Rpb24gY29tcGxldGU7IG9yIHVwb24gdGhpcyBqb2IncyBjb21wbGV0aW9uDQo+PiBAQCAtNDcw
LDEyICs0NjMsNiBAQCBib29sIGpvYl91c2VyX3BhdXNlZChKb2IgKmpvYik7DQo+PiDCoMKgICov
DQo+PiDCoCB2b2lkIGpvYl91c2VyX3Jlc3VtZShKb2IgKmpvYiwgRXJyb3IgKiplcnJwKTsNCj4+
IC0vKg0KPj4gLSAqIERyYWluIGFueSBhY3Rpdml0aWVzIGFzIHJlcXVpcmVkIHRvIGVuc3VyZSBw
cm9ncmVzcy4gVGhpcyBjYW4gYmUgY2FsbGVkIGluIGENCj4+IC0gKiBsb29wIHRvIHN5bmNocm9u
b3VzbHkgY29tcGxldGUgYSBqb2IuDQo+PiAtICovDQo+PiAtdm9pZCBqb2JfZHJhaW4oSm9iICpq
b2IpOw0KPj4gLQ0KPj4gwqAgLyoqDQo+PiDCoMKgICogR2V0IHRoZSBuZXh0IGVsZW1lbnQgZnJv
bSB0aGUgbGlzdCBvZiBibG9jayBqb2JzIGFmdGVyIEBqb2IsIG9yIHRoZQ0KPj4gwqDCoCAqIGZp
cnN0IG9uZSBpZiBAam9iIGlzICVOVUxMLg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5j
IGIvYmxvY2svYmFja3VwLmMNCj4+IGluZGV4IDcxNWUxZDNiZTguLmQxZWNkZmE5YWEgMTAwNjQ0
DQo+PiAtLS0gYS9ibG9jay9iYWNrdXAuYw0KPj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+IEBA
IC0zMjAsMjEgKzMyMCw2IEBAIHZvaWQgYmFja3VwX2RvX2NoZWNrcG9pbnQoQmxvY2tKb2IgKmpv
YiwgRXJyb3IgKiplcnJwKQ0KPj4gwqDCoMKgwqDCoCBoYml0bWFwX3NldChiYWNrdXBfam9iLT5j
b3B5X2JpdG1hcCwgMCwgYmFja3VwX2pvYi0+bGVuKTsNCj4+IMKgIH0NCj4+IC1zdGF0aWMgdm9p
ZCBiYWNrdXBfZHJhaW4oQmxvY2tKb2IgKmpvYikNCj4+IC17DQo+PiAtwqDCoMKgIEJhY2t1cEJs
b2NrSm9iICpzID0gY29udGFpbmVyX29mKGpvYiwgQmFja3VwQmxvY2tKb2IsIGNvbW1vbik7DQo+
PiAtDQo+PiAtwqDCoMKgIC8qIE5lZWQgdG8ga2VlcCBhIHJlZmVyZW5jZSBpbiBjYXNlIGJsa19k
cmFpbiB0cmlnZ2VycyBleGVjdXRpb24NCj4+IC3CoMKgwqDCoCAqIG9mIGJhY2t1cF9jb21wbGV0
ZS4uLg0KPj4gLcKgwqDCoMKgICovDQo+PiAtwqDCoMKgIGlmIChzLT50YXJnZXQpIHsNCj4+IC3C
oMKgwqDCoMKgwqDCoCBCbG9ja0JhY2tlbmQgKnRhcmdldCA9IHMtPnRhcmdldDsNCj4+IC3CoMKg
wqDCoMKgwqDCoCBibGtfcmVmKHRhcmdldCk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgYmxrX2RyYWlu
KHRhcmdldCk7DQo+PiAtwqDCoMKgwqDCoMKgwqAgYmxrX3VucmVmKHRhcmdldCk7DQo+PiAtwqDC
oMKgIH0NCj4+IC19DQo+PiAtDQo+PiDCoCBzdGF0aWMgQmxvY2tFcnJvckFjdGlvbiBiYWNrdXBf
ZXJyb3JfYWN0aW9uKEJhY2t1cEJsb2NrSm9iICpqb2IsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYm9vbCByZWFkLCBpbnQgZXJyb3IpDQo+PiDCoCB7DQo+PiBAQCAtNDg4
LDEzICs0NzMsMTEgQEAgc3RhdGljIGNvbnN0IEJsb2NrSm9iRHJpdmVyIGJhY2t1cF9qb2JfZHJp
dmVyID0gew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5qb2JfdHlwZcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgPSBKT0JfVFlQRV9CQUNLVVAsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmZy
ZWXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBibG9ja19qb2JfZnJlZSwN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAudXNlcl9yZXN1bWXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ID0gYmxvY2tfam9iX3VzZXJfcmVzdW1lLA0KPj4gLcKgwqDCoMKgwqDCoMKgIC5kcmFpbsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBibG9ja19qb2JfZHJhaW4sDQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgLnJ1bsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ID0gYmFja3VwX3J1biwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuY29tbWl0wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBiYWNrdXBfY29tbWl0LA0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIC5hYm9ydMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPSBiYWNrdXBfYWJv
cnQsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLmNsZWFuwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA9IGJhY2t1cF9jbGVhbiwNCj4+IC3CoMKgwqAgfSwNCj4+IC3CoMKgwqAgLmRy
YWluwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9IGJhY2t1cF9kcmFpbiwNCj4+
ICvCoMKgwqAgfQ0KPj4gwqAgfTsNCj4+IMKgIHN0YXRpYyBpbnQ2NF90IGJhY2t1cF9jYWxjdWxh
dGVfY2x1c3Rlcl9zaXplKEJsb2NrRHJpdmVyU3RhdGUgKnRhcmdldCwNCj4+IGRpZmYgLS1naXQg
YS9ibG9jay9jb21taXQuYyBiL2Jsb2NrL2NvbW1pdC5jDQo+PiBpbmRleCAyYzVhNmQ0ZWJjLi42
OTdhNzc5ZDhlIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svY29tbWl0LmMNCj4+ICsrKyBiL2Jsb2Nr
L2NvbW1pdC5jDQo+PiBAQCAtMjE2LDcgKzIxNiw2IEBAIHN0YXRpYyBjb25zdCBCbG9ja0pvYkRy
aXZlciBjb21taXRfam9iX2RyaXZlciA9IHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuam9iX3R5
cGXCoMKgwqDCoMKgID0gSk9CX1RZUEVfQ09NTUlULA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC5m
cmVlwqDCoMKgwqDCoMKgwqDCoMKgID0gYmxvY2tfam9iX2ZyZWUsDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgLnVzZXJfcmVzdW1lwqDCoCA9IGJsb2NrX2pvYl91c2VyX3Jlc3VtZSwNCj4+IC3CoMKg
wqDCoMKgwqDCoCAuZHJhaW7CoMKgwqDCoMKgwqDCoMKgID0gYmxvY2tfam9iX2RyYWluLA0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIC5ydW7CoMKgwqDCoMKgwqDCoMKgwqDCoCA9IGNvbW1pdF9ydW4s
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLnByZXBhcmXCoMKgwqDCoMKgwqAgPSBjb21taXRfcHJl
cGFyZSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAuYWJvcnTCoMKgwqDCoMKgwqDCoMKgID0gY29t
bWl0X2Fib3J0LA0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL21pcnJvci5jIGIvYmxvY2svbWlycm9y
LmMNCj4+IGluZGV4IDhjYjc1ZmI0MDkuLmI5MWFiZTAyODggMTAwNjQ0DQo+PiAtLS0gYS9ibG9j
ay9taXJyb3IuYw0KPj4gKysrIGIvYmxvY2svbWlycm9yLmMNCj4+IEBAIC02NDQsMTQgKzY0NCwx
MSBAQCBzdGF0aWMgaW50IG1pcnJvcl9leGl0X2NvbW1vbihKb2IgKmpvYikNCj4+IMKgwqDCoMKg
wqAgYmRydl9yZWYobWlycm9yX3RvcF9icyk7DQo+PiDCoMKgwqDCoMKgIGJkcnZfcmVmKHRhcmdl
dF9icyk7DQo+PiAtwqDCoMKgIC8qIFJlbW92ZSB0YXJnZXQgcGFyZW50IHRoYXQgc3RpbGwgdXNl
cyBCTEtfUEVSTV9XUklURS9SRVNJWkUgYmVmb3JlDQo+PiArwqDCoMKgIC8qDQo+PiArwqDCoMKg
wqAgKiBSZW1vdmUgdGFyZ2V0IHBhcmVudCB0aGF0IHN0aWxsIHVzZXMgQkxLX1BFUk1fV1JJVEUv
UkVTSVpFIGJlZm9yZQ0KPj4gwqDCoMKgwqDCoMKgICogaW5zZXJ0aW5nIHRhcmdldF9icyBhdCBz
LT50b19yZXBsYWNlLCB3aGVyZSB3ZSBtaWdodCBub3QgYmUgYWJsZSB0byBnZXQNCj4+IMKgwqDC
oMKgwqDCoCAqIHRoZXNlIHBlcm1pc3Npb25zLg0KPj4gLcKgwqDCoMKgICoNCj4+IC3CoMKgwqDC
oCAqIE5vdGUgdGhhdCBibGtfdW5yZWYoKSBhbG9uZSBkb2Vzbid0IG5lY2Vzc2FyaWx5IGRyb3Ag
cGVybWlzc2lvbnMgYmVjYXVzZQ0KPj4gLcKgwqDCoMKgICogd2UgbWlnaHQgYmUgcnVubmluZyBu
ZXN0ZWQgaW5zaWRlIG1pcnJvcl9kcmFpbigpLCB3aGljaCB0YWtlcyBhbiBleHRyYQ0KPj4gLcKg
wqDCoMKgICogcmVmZXJlbmNlLCBzbyB1c2UgYW4gZXhwbGljaXQgYmxrX3NldF9wZXJtKCkgZmly
c3QuICovDQo+PiAtwqDCoMKgIGJsa19zZXRfcGVybShzLT50YXJnZXQsIDAsIEJMS19QRVJNX0FM
TCwgJmVycm9yX2Fib3J0KTsNCj4+ICvCoMKgwqDCoCAqLw0KPiANCj4gU29tZWhvdyB0aGlzIGh1
bmsgbGl2ZXMgaGVyZSBmcm9tIHRoZSB2ZXJ5IGJlZ2lubmluZyBvZiB0aGlzIHBhdGNoIHZlcnNp
b25pbmcsDQo+IGJ1dCBub2JvZHkgbm90aWNlZCBpdC4gSSdsbCByZXNlbmQuDQoNCkFoIG5vLCBp
dCdzIE9LLCBhcyBtaXJyb3JfZHJhaW4gZG9uJ3QgZXhpc3RzIG5vdy4NCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=


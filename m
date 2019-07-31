Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848FC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABFB206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 10:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ePl8DmdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABFB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hslsM-0006Hw-5q
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 06:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hslrg-0005ao-TY
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hslrg-0005qn-1S
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 06:29:48 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com
 ([40.107.14.105]:19524 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hslrf-0005qN-R4; Wed, 31 Jul 2019 06:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRiUpsontBpkmtSgOJ7XnOCv5l/9g/9Mm1IehHGi9ui1nRfbuQPapgz97QArQhtyL/w0ldWcsGJW2/Y8+Z3UbH8ZQS1m98JgQUkbB0t1uUQQDJvELDMfZ7e3qmOSETxRJuRBrxKy4J42BFksMqNS6MaHUOUYnYdXz+ykj057/1IqIc7+cuMQAWBOk+v3YDBr2HhWHKvVb6TABFkq/C0bAWbUte8kCHUJbxOG7i9fKIo9HtIO1QyZ0o674xhK6Znfr0YoTOIMGCVaxVUwsLU1jTNpeF2A/QHGa0w26m1Px95AyhjtkpJNlgpENvwunf6tJWt6TYT/f6xZ20RzfkG7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XtC5JBbBizM0sbLH/pGvBUHL9o51IFVo/anQdXPaoU=;
 b=FzNILilySwQkYVTuXLtlaGSOWs7Q8KlzSSMeb5oyqad+VG7C0d9RHF7vNtocGZdlBy1J5R0VcKKLo1waxPNfVoqsn7a5M2ObY10PcBKYFc0yxSI90p9i2fawht9yqMYDz8UlrxCeWnvLLa7quRCSyeRZrSklXxkIOUWwoO7g4msq3oJfxgaArjakXZbFWpnjBzVhO9k3F+9YL4ZOrV3WHMJsprjO5uAcFZ/cIif423K8ZY6JSoagqIIHJcjUYRsKd7L0lSlxn6YZ6yZjU8ZqKl58rTNrIx/ddffYiE+GmLwX7V8HkDYAsiGw5NqPnkE3EOu0fOU7oJ6NHBcQH+SREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XtC5JBbBizM0sbLH/pGvBUHL9o51IFVo/anQdXPaoU=;
 b=ePl8DmdXoYx1HUzQw2aLtoon3d/Xc55by3gEvZKXbTPRBeGfwM1kirUHPKvxleIXmU1MOcDRtLmGGUHP5VxyN9DdK0knlxx8TLwKc63nwDannjhdIdk4nXvy8mZUayge4To5sgXZPI/bEZXjOrZNkehSgXQStP2I36A8clhi45o=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5210.eurprd08.prod.outlook.com (10.255.17.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 10:29:45 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 10:29:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/3] backup fixes for 4.1?
Thread-Index: AQHVRvRyrXIzXMdybEik1oRpGnlQWKbjfuUAgAEI7YA=
Date: Wed, 31 Jul 2019 10:29:45 +0000
Message-ID: <877c1717-738e-f3a2-2cb4-3aa11e738fc0@virtuozzo.com>
References: <20190730163251.755248-1-vsementsov@virtuozzo.com>
 <c78b645a-e79b-1335-0e6e-44db4953417d@redhat.com>
In-Reply-To: <c78b645a-e79b-1335-0e6e-44db4953417d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0064.eurprd09.prod.outlook.com
 (2603:10a6:3:45::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190731132943016
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f538fc95-ebcd-4117-60b2-08d715a201a2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5210; 
x-ms-traffictypediagnostic: DB8PR08MB5210:
x-microsoft-antispam-prvs: <DB8PR08MB5210802B078DF8CB07D2C2F7C1DF0@DB8PR08MB5210.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(39850400004)(376002)(346002)(189003)(199004)(53754006)(71200400001)(14454004)(31686004)(102836004)(110136005)(8676002)(8936002)(31696002)(4744005)(71190400001)(81156014)(81166006)(6246003)(26005)(68736007)(99286004)(5660300002)(186003)(4326008)(107886003)(66946007)(54906003)(66556008)(64756008)(66446008)(66476007)(2501003)(6512007)(305945005)(76176011)(3846002)(6116002)(52116002)(486006)(476003)(6486002)(2616005)(66066001)(229853002)(25786009)(53936002)(11346002)(446003)(7736002)(2906002)(6436002)(86362001)(316002)(478600001)(256004)(6506007)(53546011)(36756003)(386003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5210;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wDOieQxFyFmv8WfBLGOBvAXqs9lEc1W1ZlbAqrQ12DS7gxRsTIGdzOsU00NkcwbC2qTOCyKqBEkBwNYIzysOhLbuAOkCm/teG0B1hfkxf21/1KXU4QaBrNtts2BSO7yStBruLyCcz7OztHqGj/eMIdcNBOMPoHv4u60f8dOUZNuDtCaUNv6cV/2OsPbEZZ4ZqurMpg0ovN0mp/XC/exj9yXmTdhCtPq4zUL4lmk6b4IgfoVrXcIVxdrIpe5nPi9sDdjeN9tas+iHfjaWWO4GBsuBphT5q5L2+i0OKjfPbBlEhaCo/0p+lkBxZJ1qw/RI02/I+BV6R6KyM16/fmcdf6+d+2285IJHqV85DSxVpxkTkSPosA3Z+9mEROZYpxGdH1LQeol69mAIeI9MdbxkhG4dDP+YIvecQXfZPT7cdNc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E937FFC55F04E41B46A9699F3FB5100@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f538fc95-ebcd-4117-60b2-08d715a201a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 10:29:45.3379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5210
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.105
Subject: Re: [Qemu-devel] [PATCH 0/3] backup fixes for 4.1?
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
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDcuMjAxOSAyMTo0MSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMzAvMTkg
MTI6MzIgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBIaSBhbGwh
DQo+Pg0KPj4gSGVyZSBhcmUgdHdvIHNtYWxsIGZpeGVzLg0KPj4NCj4+IDAxIGlzIG5vdCBhIGRl
Z3JhZGF0aW9uIGF0IGFsbCwgc28gaXQncyBPSyBmb3IgNC4yDQo+PiAwMiBpcyBkZWdyYWRhdGlv
biBvZiAzLjAsIHNvIGl0J3MgcG9zc2libHkgT0sgZm9yIDQuMiB0b28sDQo+PiAgICAgYnV0IGl0
IHNlZW1zIHRvIGJlIHJlYWwgYnVnIGFuZCBmaXggaXMgdmVyeSBzaW1wbGUsIHNvLA0KPj4gICAg
IG1heSBiZSA0LjEgaXMgYmV0dGVyDQo+Pg0KPj4gT3IgeW91IG1heSB0YWtlIHRoZSB3aG9sZSBz
ZXJpZXMgdG8gNC4xIGlmIHlvdSB3YW50Lg0KPj4NCj4gDQo+IEkgdGhpbmsgKDEpIGFuZCAoMikg
Y2FuIGdvIGluIGZvciBzdGFibGUgYWZ0ZXIgcmV2aWV3LCBidXQgdGhleSdyZSBub3QNCj4gY3J1
Y2lhbCBmb3IgNC4xIGVzcGVjaWFsbHkgYXQgdGhpcyBsYXRlIG9mIGEgc3RhZ2UuIFNob3VsZCBi
ZSBjYXRhY2x5c21zDQo+IG9ubHkgcmlnaHQgbm93Lg0KPiANCj4gLS1qcw0KPiANCg0KSSBjYW4g
cmViYXNlIGl0IHRoYW4gb24geW91ciBiaXRtYXBzIGJyYW5jaC4gT3IsIGlmIHdlIHdhbnQgaXQg
Zm9yIHN0YWJsZSwgbWF5YmUsDQpJIHNob3VsZG4ndD8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpW
bGFkaW1pcg0K


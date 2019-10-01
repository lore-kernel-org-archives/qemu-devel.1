Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA50AECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EAA21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mfiiOz0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EAA21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLnC-0002qD-DN
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFLku-0001BW-TW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFLkt-0005ND-Hh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:08 -0400
Received: from mail-eopbgr40120.outbound.protection.outlook.com
 ([40.107.4.120]:50277 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFLki-0005IL-NY; Tue, 01 Oct 2019 13:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSTqAGHUkcV/Quru/KtMkd5VUhotItQI1AnMgDb+R6y0Ax8IzZNyVw2F23VTdU8+YYhxth1Cn2xAB4+TT5z93FnmJsDFsRiltbhIGGTvK759iStbf8OtH8YGSQsIp+vdQAAU1E+bKzYXv5q37Wr664iaGde8K6rkLv94h/IEKHCYBlM8K8zh9oQl0FL8UT19GokXzWm8oSigTRvxECy26GfgjTNcIBqe/gkNvNUy7S4zWCK8LQRSu2I5q3fPjGER+wcGR7DdzNK04TnFFnwECqy+Rsd0/nU3Ts9LxVqdgOiKg5B+9HyL41/SVjis44mxWQ0c6p+wAqvaiulSxhK/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCmA7XlL2q5pA8xR/ukeEm8nm7IbIm6s3W5rzb6I0+Y=;
 b=XsDIeZOo6Ei1qyiF7c1F6+eX1UzGGNqOxR7yCkAke/MiEGCP4TxVe/yiq7GP6XK13T7T31urY+4pPJNnJSvIEPZIv/t/eBXTGi2RjrpXX/bnRnjRQVjL3En/HG9IOG6kGYr7lTERJrtg3dY9pe3KnoIfjZ0J/fUooINDLudlMJhxRhKQZarqs7OQPeoeou9Bl+cym0XJr/t1T4SdATtw4LzwhFGr8QeJZaFAbZniD0Ir7UH7AH1sYwKYBQxVUiY+5BIsTfS9GmHLAIczqQghFY/p3hIvy7GNGoU0xLXwm5T++lfMwdV7Gh1mA84X0KmAiWaD6k+X2iR3xIlfREcOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCmA7XlL2q5pA8xR/ukeEm8nm7IbIm6s3W5rzb6I0+Y=;
 b=mfiiOz0FYHA+UxTr9YqK9UoEtgjh/ofQJHtOHeaeukh4+94GKk4+fCBNrdV8yMBZz1iSVjbbwgXh6hkDpBksPiZZjM9VwOI7Qe079nVdctUYuoW5m9uKnJ8+suW+L/1L5nj9bH1+/QFP3GxGXj8qkWu05H//ZvEhXo4+CwjAQz4=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5017.eurprd08.prod.outlook.com (10.255.19.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Tue, 1 Oct 2019 17:15:53 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 17:15:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 05/31] scripts: add script to fix
 error_append_hint/error_prepend usage
Thread-Topic: [PATCH v4 05/31] scripts: add script to fix
 error_append_hint/error_prepend usage
Thread-Index: AQHVeHBjzF1lxlZN2U+wmo61d0343KdF/9oAgAAG/YA=
Date: Tue, 1 Oct 2019 17:15:53 +0000
Message-ID: <9bb6f6e6-4e12-191c-7ba9-e9fdd401e792@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-6-vsementsov@virtuozzo.com>
 <5c4788f0-0ba9-94bb-b677-d7d34f064cde@redhat.com>
In-Reply-To: <5c4788f0-0ba9-94bb-b677-d7d34f064cde@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0191.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001201545817
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28cf189b-0a4a-4b05-80e7-08d746930399
x-ms-traffictypediagnostic: DB8PR08MB5017:
x-microsoft-antispam-prvs: <DB8PR08MB5017B06DBECFA9CE0271F994C19D0@DB8PR08MB5017.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(396003)(366004)(39850400004)(51444003)(189003)(199004)(66476007)(66446008)(66556008)(64756008)(53546011)(26005)(66946007)(4326008)(31696002)(7416002)(2616005)(6486002)(6506007)(478600001)(386003)(110136005)(6246003)(99286004)(6512007)(81156014)(81166006)(316002)(86362001)(7406005)(54906003)(14444005)(25786009)(229853002)(256004)(446003)(186003)(8676002)(7736002)(486006)(14454004)(66066001)(36756003)(476003)(71200400001)(5660300002)(3846002)(6116002)(305945005)(102836004)(11346002)(2906002)(52116002)(76176011)(6436002)(71190400001)(31686004)(2501003)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5017;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpyACpsr7EBgC+L5SjNgb/8hNezl8hP2SHKxZFdjDOksyI5YPEBQNX7XmYnAXmASel30WOwU9NSN4MReoicG64CQQr2IFdxL33cSm5WId+wdWCVD4DWyIbwwsow1dFbE9yYRRwugQsR6hhTJVncF/iFXuMXFAjMRvdVzrfWa212hcnTlZQXnoMyehH0/SDeQOe1kIjgr2DiJa/ZMHVoqe7wGtOP+tNZvzxUsvvmcpYVlxC+K1CendwLG/1/l8BgeIzVuEU71iHe8qPPkoIKaPT4QHNj8I86DozKjHHxOTtvUHZukiNPQCRHpPYdE2SB0+x9bzzocWA7DvCyMQKUs+/erc/mANk03XGljO6ID5cnBclewUVzZrIcGMHAZHmpDmfNWN1hynDs/rvaBF7ipdqVOi2ptRjALb0nsVrNRJRU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <948EDDFD062F7C44A0C94261F9D0E92E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cf189b-0a4a-4b05-80e7-08d746930399
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 17:15:53.2003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kC5spa8X2enaV+1vOscMd7A+6PQE836FxQmM2Mh9Q09Nut41w9nf3scRnwzkpqxA5T2LAE0ApVPCbia7zfaF/1t5yAOSTjhjFEOoTAy37s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5017
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.120
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "codyprime@gmail.com" <codyprime@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "arikalo@wavecomp.com" <arikalo@wavecomp.com>,
 "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "joel@jms.id.au" <joel@jms.id.au>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "sw@weilnetz.de" <sw@weilnetz.de>,
 "groug@kaod.org" <groug@kaod.org>,
 "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "integration@gluster.org" <integration@gluster.org>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxOTo1MCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMTAvMS8xOSAxMDo1MiBB
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGVycm9yX2FwcGVuZF9o
aW50IGFuZCBlcnJvcl9wcmVwZW5kIHdpbGwgbm90IHdvcmssIGlmIGVycnAgPT0NCj4+ICZmYXRh
bF9lcnJvciwgYXMgcHJvZ3JhbSB3aWxsIGV4aXQgYmVmb3JlIGVycm9yX2FwcGVuZF9oaW50IG9y
DQo+PiBlcnJvcl9wcmVwZW5kIGNhbGwuIEZpeCB0aGlzIGJ5IHVzZSBvZiBzcGVjaWFsIG1hY3Jv
DQo+PiBFUlJQX0FVVE9fUFJPUEFHQVRFLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0K
Pj4NCj4gDQo+PiArKysgYi9zY3JpcHRzL2NvY2NpbmVsbGUvZml4LWVycm9yLWFkZC1pbmZvLmNv
Y2NpDQo+PiBAQCAtMCwwICsxLDI4IEBADQo+PiArQHJ1bGUwQA0KPj4gKy8vIEFkZCBpbnZvY2F0
aW9uIHRvIGVycnAtZnVuY3Rpb25zDQo+PiAraWRlbnRpZmllciBmbjsNCj4+ICtAQA0KPj4gKw0K
Pj4gKyBmbiguLi4sIEVycm9yICoqZXJycCwgLi4uKQ0KPj4gKyB7DQo+IA0KPiBXaGVuIHJ1bm5p
bmcgdGhpcyBzY3JpcHQsIEkgZ2V0IGxvdHMgb2Ygd2FybmluZ3M6DQo+IA0KPiBpbml0X2RlZnNf
YnVpbHRpbnM6IC91c3IvbGliNjQvY29jY2luZWxsZS9zdGFuZGFyZC5oDQo+IHdhcm5pbmc6IGxp
bmUgNjogc2hvdWxkIGVycnAgYmUgYSBtZXRhdmFyaWFibGU/DQo+IHdhcm5pbmc6IGxpbmUgMTE6
IHNob3VsZCBlcnJwIGJlIGEgbWV0YXZhcmlhYmxlPw0KPiB3YXJuaW5nOiBsaW5lIDEzOiBzaG91
bGQgZXJycCBiZSBhIG1ldGF2YXJpYWJsZT8NCj4gSEFORExJTkc6IGluY2x1ZGUvYmxvY2svbmJk
LmgNCj4gDQo+IFRoaXMgbWVhbnMgd2UgYXJlIHRyeWluZyB0byBwYXRjaCBvbmx5IGFuIGFjdHVh
bCB2YXJpYWJsZSBuYW1lZCAnZXJycCcsIGFuZCBub3QgYSBtZXRhLXZhcmlhYmxlIHJlcHJlc2Vu
dGluZyBhbnkgdmFyaWFibGUgb2YgdHlwZSBFcnJvciAqKiByZWdhcmRsZXNzIG9mIHdoZXRoZXIg
aXQgaXMgbmFtZWQgZXJycCBvciBzb21ldGhpbmcgZWxzZS7CoCBJIHRoaW5rIHRoYXQncyBva2F5
LCBpbiBwYXJ0IGJlY2F1c2UgRVJSUF9BVVRPX1BST1BBR0FURSgpIGV4cGVjdHMgdGhlIGV4YWN0
IG5hbWUgJ2VycnAnIHRvIGJlIGluIHNjb3BlLCBzbyB3ZSBjYW5ub3QgYXBwbHkgaXQgdG8gb3Ro
ZXIgdmFyaWFibGUgbmFtZXMpLsKgIEJ1dCBJIHN0aWxsIGhhdmUgdG8gd29uZGVyIGlmIHRoZXJl
IGlzIGEgd2F5IHRvIHNpbGVuY2UgdGhlIHdhcm5pbmcsIG9yIGlmIHdlIGhhdmUgYW55IG91dGxp
ZXJzIChvdGhlciB0aGFuIHRoZSBpbnRlbnRpb25hbCBFcnJvciAqKmVycnBfaW4gaW4gcGF0Y2gg
MSkgdXNpbmcgYSBkaWZmZXJlbnQgbmFtZSBmb3IgYSBwYXJhbWV0ZXIgb2YgdHlwZSBFcnJvciAq
Kiwgd2hpY2ggc2hvdWxkIGFsc28gYmUgdHdlYWtlZC4NCj4gDQoNCg0KSG1tLCBnb29kIHF1ZXN0
aW9uOg0KDQpnaXQgZ3JlcCAnRXJyb3IgXCpcKicgfCBncmVwIC12ICdcPEVycm9yIFwqXCpcKGVy
cnBcfClcKScNCmJsb2NrL25iZC5jOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IHJldCwgRXJyb3IgKipsb2NhbF9lcnIpDQpibG9jay9xdW9ydW0uYzogICAgLyogWFhYIC0g
d291bGQgYmUgbmljZSBpZiB3ZSBjb3VsZCBwYXNzIGluIHRoZSBFcnJvciAqKg0KYmxvY2svc25h
cHNob3QuYzogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJyKQ0KZG9jcy9k
ZXZlbC9xYXBpLWNvZGUtZ2VuLnR4dDpjb21wbGV4IGFyZ3VtZW50IHR5cGUuICBJdCB0YWtlcyBh
biBhZGRpdGlvbmFsIEVycm9yICoqIGFyZ3VtZW50IGluDQpkb2NzL2RldmVsL3dyaXRpbmctcW1w
LWNvbW1hbmRzLnR4dDozLiBJdCB0YWtlcyBhbiAiRXJyb3IgKioiIGFyZ3VtZW50LiBUaGlzIGlz
IHJlcXVpcmVkLiBMYXRlciB3ZSB3aWxsIHNlZSBob3cgdG8NCmh3L2NvcmUvcWRldi5jOnN0YXRp
YyBib29sIGNoZWNrX29ubHlfbWlncmF0YWJsZShPYmplY3QgKm9iaiwgRXJyb3IgKiplcnIpDQpo
dy9jb3JlL3FkZXYuYzogICAgICAgIEVycm9yICoqbG9jYWxfZXJycCA9IE5VTEw7DQpody9jb3Jl
L3FkZXYuYzpzdGF0aWMgYm9vbCBkZXZpY2VfZ2V0X2hvdHBsdWdnZWQoT2JqZWN0ICpvYmosIEVy
cm9yICoqZXJyKQ0KaHcvaTM4Ni9hbWRfaW9tbXUuYzpzdGF0aWMgdm9pZCBhbWR2aV9yZWFsaXpl
KERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJyKQ0KaHcvczM5MHgvZXZlbnQtZmFjaWxpdHku
YzpzdGF0aWMgYm9vbCBzY2xwX2V2ZW50X2dldF9hbGxvd19hbGxfbWFza19zaXplcyhPYmplY3Qg
Km9iaiwgRXJyb3IgKiplKQ0KaHcvczM5MHgvczM5MC1zdGF0dHJpYi5jOnN0YXRpYyBpbmxpbmUg
Ym9vbCBzMzkwX3N0YXR0cmliX2dldF9taWdyYXRpb25fZW5hYmxlZChPYmplY3QgKm9iaiwgRXJy
b3IgKiplKQ0KaHcvc2Qvc2RoY2kuYzpzdGF0aWMgdm9pZCBzZGhjaV9zeXNidXNfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKiBlcnJwKQ0KaHcvdHBtL3RwbV9lbXVsYXRvci5jOiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycikNCmh3L3VzYi9k
ZXYtbmV0d29yay5jOnN0YXRpYyB2b2lkIHVzYl9uZXRfcmVhbGl6ZShVU0JEZXZpY2UgKmRldiwg
RXJyb3IgKiplcnJycCkNCmluY2x1ZGUvYmxvY2svc25hcHNob3QuaDogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJyKTsNCmluY2x1ZGUvaW8vY2hhbm5lbC5oOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJwKTsNCmluY2x1ZGUvcWFwaS9lcnJvci5oOnZv
aWQgZXJyb3JfcHJvcGFnYXRlKEVycm9yICoqZHN0X2VycnAsIEVycm9yICpsb2NhbF9lcnIpOw0K
aW5jbHVkZS9xYXBpL2Vycm9yLmg6dm9pZCBlcnJvcl9wcm9wYWdhdGVfcHJlcGVuZChFcnJvciAq
KmRzdF9lcnJwLCBFcnJvciAqbG9jYWxfZXJyLA0KaW5jbHVkZS9xb20vb2JqZWN0Lmg6ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgdWludDY0X3QgKnYsIEVycm9yICoq
RXJycCk7DQppbmNsdWRlL3FvbS9vYmplY3QuaDogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCB1aW50NjRfdCAqdiwgRXJyb3IgKipFcnJwKTsNCmpvYi5jOi8q
IEEgd3JhcHBlciBhcm91bmQgam9iX2NhbmNlbCgpIHRha2luZyBhbiBFcnJvciAqKiBwYXJhbWV0
ZXIgc28gaXQgbWF5IGJlDQptb25pdG9yL3FtcC1jbWRzLmM6dm9pZCBxbXBfc3lzdGVtX3Bvd2Vy
ZG93bihFcnJvciAqKmVycCkNCnFnYS9jb21tYW5kcy1wb3NpeC5jOkd1ZXN0VXNlckxpc3QgKnFt
cF9ndWVzdF9nZXRfdXNlcnMoRXJyb3IgKiplcnIpDQpxZ2EvY29tbWFuZHMtd2luMzIuYzpHdWVz
dFVzZXJMaXN0ICpxbXBfZ3Vlc3RfZ2V0X3VzZXJzKEVycm9yICoqZXJyKQ0KcWdhL2NvbW1hbmRz
LmM6R3Vlc3RFeGVjU3RhdHVzICpxbXBfZ3Vlc3RfZXhlY19zdGF0dXMoaW50NjRfdCBwaWQsIEVy
cm9yICoqZXJyKQ0KcWdhL2NvbW1hbmRzLmM6ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAq
KmVycikNCnFnYS9jb21tYW5kcy5jOkd1ZXN0SG9zdE5hbWUgKnFtcF9ndWVzdF9nZXRfaG9zdF9u
YW1lKEVycm9yICoqZXJyKQ0Kc2NyaXB0cy9jb2NjaW5lbGxlL3JlbW92ZV9sb2NhbF9lcnIuY29j
Y2k6IEYoLi4uLCBFcnJvciAqKkVSUlApDQp0ZXN0cy90cG0tdXRpbC5jOiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFNvY2tldEFkZHJlc3MgKiphZGRyLCBHRXJyb3IgKiplcnJvcikNCnRl
c3RzL3RwbS11dGlsLmg6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU29ja2V0QWRkcmVz
cyAqKmFkZHIsIEdFcnJvciAqKmVycm9yKTsNCnV0aWwvZXJyb3IuYzp2b2lkIGVycm9yX3Byb3Bh
Z2F0ZShFcnJvciAqKmRzdF9lcnJwLCBFcnJvciAqbG9jYWxfZXJyKQ0KdXRpbC9lcnJvci5jOnZv
aWQgZXJyb3JfcHJvcGFnYXRlX3ByZXBlbmQoRXJyb3IgKipkc3RfZXJycCwgRXJyb3IgKmVyciwN
Cg0KDQpNeSBmYXZvcml0ZSBpcyBlcnJycCA6KQ0KDQpCdXQgSSB0ZW5kIHRvIG5vdCBkbyBtb3Jl
IGVmZm9ydCwgdW50aWwgSSBkb24ndCBldmVuIGtub3csIHdpbGwgdGhlc2Ugc2VyaWVzIGJlDQph
cHBsaWVkIG9yIG5vdC4gQWxsIHRoZXNlIGNhc2VzIGFyZSB0byBiZSBjaGVja2VkIGFuZCBmaXhl
ZCBieSBoYW5kLCBpdCBtYXkgYmUgZG9uZSBsYXRlci4NCg0KQ2hlY2sgcG9zc2libHkgbWlzc2Vk
IGJ5IHByZXZpb3VzIGdyZXAgdGhpbmdzOg0KDQpnaXQgZ3JlcCAnRXJyb3IgXCpcKicgfCBncmVw
ICdFcnJvciBcKlwqLipFcnJvciBcKlwqJw0KaW5jbHVkZS9xZW11L2pvYi5oOmludCBqb2JfZmlu
aXNoX3N5bmMoSm9iICpqb2IsIHZvaWQgKCpmaW5pc2gpKEpvYiAqLCBFcnJvciAqKmVycnApLCBF
cnJvciAqKmVycnApOw0Kam9iLmM6aW50IGpvYl9maW5pc2hfc3luYyhKb2IgKmpvYiwgdm9pZCAo
KmZpbmlzaCkoSm9iICosIEVycm9yICoqZXJycCksIEVycm9yICoqZXJycCkNCg0KLSBzZWVtcywg
bm90aGluZyBtaXNzZWQuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


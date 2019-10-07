Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30ADC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA4520673
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bi2Bka5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA4520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVi8-0006Sc-47
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVan-0007am-6p
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVak-0000S3-Hg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:10:37 -0400
Received: from mail-eopbgr00123.outbound.protection.outlook.com
 ([40.107.0.123]:26230 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVaK-0000G8-1o; Mon, 07 Oct 2019 12:10:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhM4LtoilpAFZ2fRjra6bxqruWDlNUYRFbCz53FWS8ndujHzC8/jVSPJMHoalvRRd/yPc9Aje/0HDBXiBgSdWLdFw8G1lkPl+JRMuiWJXlbity1LTX/JC2+4O5oFqdPM6eKjSAxnNhtaO00WF2vuLR7kLC9kb3Atdzei3bken/oLL8rv4KpUhfrsbnFD1qgmh3Dj3LhtSs8PRFf7skWoYVWbkx6zLbIg/pqHE8QwVCR2tJsu5Ccuy4cGHfzVQY2UmngwF8iyZQ3wwPLCOy+VuK4btrmbaWlZlIBuNzTiOsH9RRXtC89fRL8lkTNUU4uMPmRL0PMJlXjuCBDhjFJs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjTLlRUotKQdqtnD/1VOuzlJZ0Dq4XxFIh58niAtXpY=;
 b=BO4T2vPxPfRb5kxi7+FfK2vCb4xTIJV3Sey2v2p+1kz5GFNORDAUT9UqqTsYpVQwBZRgmOR3z+vWPJaonVe6n2Jdjl3vWS0jDE37EIfEwrgO4dOI0z6L0K17gVsVWydOLo2LIWmZiIbcPZ80rDFqZqhD0rG00SkMc4QZdEyA8Nx5Jy6MCZYS3IlRPeZ+aC3//9XVH5BWlJyhrKO2jp8xuKOVYd6M/IKig+LNbGpiA2nF2xzCaCS5YK1Ll7Z3hElIiOXtEzSw/6YR0E40cKTwAI22/nlodi3hc9PUJ/4lXcGZMPB5SAXUbYKW/94Dow1yOYvvnSQxzvtgivLSHEVaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjTLlRUotKQdqtnD/1VOuzlJZ0Dq4XxFIh58niAtXpY=;
 b=Bi2Bka5JbQ1ZUq4wjfCx7RLS8wlWK0Ft3hlHtFqKMqCxUGt4J6db58TJvVL80C2PXcFYSpyIF8Hmik2kNkCfS2svW4Gf+9zVevZsFKfou6Zuq6EfPOrsVb4mX7gIc1ex1Sg1bOzmp1fS+jPSCti17yIgDiXQhsmjdOaqoZEfVhs=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5321.eurprd08.prod.outlook.com (52.133.242.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 16:10:02 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 16:10:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 06/31] python: add commit-per-subsystem.py
Thread-Topic: [PATCH v4 06/31] python: add commit-per-subsystem.py
Thread-Index: AQHVeHBj95K2V5GzV0GqFsm4i4IPaqdPXlUAgAAEHAA=
Date: Mon, 7 Oct 2019 16:10:02 +0000
Message-ID: <cc355055-871d-9fb8-6f2d-f75d5cd40a3b@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-7-vsementsov@virtuozzo.com>
 <20191007175514.19360a2b.cohuck@redhat.com>
In-Reply-To: <20191007175514.19360a2b.cohuck@redhat.com>
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
x-tagtoolbar-keys: D20191007190956597
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 034d1634-4eef-4b36-36c8-08d74b40cf1c
x-ms-traffictypediagnostic: DB8PR08MB5321:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB53215F3D10ED8F2C403B22C7C19B0@DB8PR08MB5321.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(39840400004)(396003)(366004)(189003)(199004)(52314003)(66476007)(64756008)(66446008)(4326008)(66946007)(66556008)(26005)(186003)(476003)(2616005)(486006)(446003)(6486002)(66066001)(99286004)(6512007)(6436002)(386003)(6506007)(229853002)(11346002)(6306002)(102836004)(52116002)(36756003)(5660300002)(76176011)(6246003)(86362001)(31696002)(478600001)(6916009)(71200400001)(71190400001)(7406005)(31686004)(3846002)(6116002)(7416002)(7736002)(54906003)(14454004)(305945005)(256004)(8676002)(81166006)(81156014)(25786009)(8936002)(2906002)(316002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5321;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VT4Y2w3IJz4MPjI15Z2DFKf0vgB3RQox1IUI1P8/w/vcl9Wl9CBdZ8CH08Bv17lZlzj/Zpq4ILq5JPIOaR3XkFhW8IspAwgrSPGnXRVjXChPnvLdIWqlqwwlRdCn/2dzgAAkbEXcJ51OObgP0N35q7jQ+4maTas3fsLMoSpzueWtvBp6iIxJcd+H9zCz7maJKocWUyTBYmaO1mh/LwbpbO1hnwsJqS/7wHhDotuosDmC6enA2k/l/eEENyk+i9MYX87TYcqgz7DVVJGLN+knBinO1gxCMQyB1mlWYPdkpcDuA/0Tyrb43qXKi+P917r3Z0LJIu8AUoJJa9CovIg7kBiP8wBxJXGZqSP+kRO32lpTSDP/pe7Gu+WuF3dAyMiCbybUJYD0d29wQGl7AkHOq73BYs7rj+isajgqKhYpweTU9Z4ZJjzmVu371FzzIyQX0fM3MTuZp3+reQyITokTKw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6818C17FECFD15488E41975B2069AB39@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034d1634-4eef-4b36-36c8-08d74b40cf1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 16:10:02.3879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nxpjISz36JBzb/QhKIytHAJyeGnJ1FBkdB6/BHTLJKoew+Et3VNUxiGda9h4cs/EmX/6N0HXBaL4Tz7cffTXzziAbtbr8XUf2q1ZqRik22k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5321
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.123
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
 "andrew@aj.id.au" <andrew@aj.id.au>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTAuMjAxOSAxODo1NSwgQ29ybmVsaWEgSHVjayB3cm90ZToNCj4gT24gVHVlLCAgMSBPY3Qg
MjAxOSAxODo1Mjo1NCArMDMwMA0KPiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+IHdyb3RlOg0KPiANCj4+IEFkZCBzY3JpcHQgdG8gYXV0b21h
dGljYWxseSBjb21taXQgdHJlZS13aWRlIGNoYW5nZXMgcGVyLXN1YnN5c3RlbS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+PiAtLS0NCj4+DQo+PiBDQzoga3dvbGZAcmVkaGF0LmNvbQ0KPj4gQ0M6
IG1yZWl0ekByZWRoYXQuY29tDQo+PiBDQzoganNub3dAcmVkaGF0LmNvbQ0KPj4gQ0M6IGZhbUBl
dXBob24ubmV0DQo+PiBDQzogc3dAd2VpbG5ldHouZGUNCj4+IENDOiBjb2R5cHJpbWVAZ21haWwu
Y29tDQo+PiBDQzogbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tDQo+PiBDQzogcGJvbnppbmlA
cmVkaGF0LmNvbQ0KPj4gQ0M6IGdyb3VnQGthb2Qub3JnDQo+PiBDQzogc3VuZGVlcC5sa21sQGdt
YWlsLmNvbQ0KPj4gQ0M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KPj4gQ0M6IHN0ZWZhbmhh
QHJlZGhhdC5jb20NCj4+IENDOiBwYnVydG9uQHdhdmVjb21wLmNvbQ0KPj4gQ0M6IGFyaWthbG9A
d2F2ZWNvbXAuY29tDQo+PiBDQzogYmVycmFuZ2VAcmVkaGF0LmNvbQ0KPj4gQ0M6IGVoYWJrb3N0
QHJlZGhhdC5jb20NCj4+IENDOiBkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUNCj4+IENDOiBj
bGdAa2FvZC5vcmcNCj4+IENDOiBtc3RAcmVkaGF0LmNvbQ0KPj4gQ0M6IG1hcmNlbC5hcGZlbGJh
dW1AZ21haWwuY29tDQo+PiBDQzogbWFyay5jYXZlLWF5bGFuZEBpbGFuZGUuY28udWsNCj4+IEND
OiB5dXZhbC5zaGFpYUBvcmFjbGUuY29tDQo+PiBDQzogY29odWNrQHJlZGhhdC5jb20NCj4+IEND
OiBmYXJtYW5AbGludXguaWJtLmNvbQ0KPj4gQ0M6IHJ0aEB0d2lkZGxlLm5ldA0KPj4gQ0M6IGRh
dmlkQHJlZGhhdC5jb20NCj4+IENDOiBwYXNpY0BsaW51eC5pYm0uY29tDQo+PiBDQzogYm9ybnRy
YWVnZXJAZGUuaWJtLmNvbQ0KPj4gQ0M6IGtyYXhlbEByZWRoYXQuY29tDQo+PiBDQzogYWxleC53
aWxsaWFtc29uQHJlZGhhdC5jb20NCj4+IENDOiBhbmRyZXdAYWouaWQuYXUNCj4+IENDOiBqb2Vs
QGptcy5pZC5hdQ0KPj4gQ0M6IGVibGFrZUByZWRoYXQuY29tDQo+PiBDQzogYXJtYnJ1QHJlZGhh
dC5jb20NCj4+IENDOiBtZHJvdGhAbGludXgudm5ldC5pYm0uY29tDQo+PiBDQzogcXVpbnRlbGFA
cmVkaGF0LmNvbQ0KPj4gQ0M6IGRnaWxiZXJ0QHJlZGhhdC5jb20NCj4+IENDOiBqYXNvd2FuZ0By
ZWRoYXQuY29tDQo+PiBDQzogcWVtdS1ibG9ja0Bub25nbnUub3JnDQo+PiBDQzogaW50ZWdyYXRp
b25AZ2x1c3Rlci5vcmcNCj4+IENDOiBxZW11LWFybUBub25nbnUub3JnDQo+PiBDQzogcWVtdS1w
cGNAbm9uZ251Lm9yZw0KPj4gQ0M6IHFlbXUtczM5MHhAbm9uZ251Lm9yZw0KPj4NCj4+DQo+PiAg
IHB5dGhvbi9jb21taXQtcGVyLXN1YnN5c3RlbS5weSB8IDY5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHB5dGhvbi9jb21taXQtcGVyLXN1YnN5c3RlbS5weQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9weXRob24vY29tbWl0LXBlci1zdWJzeXN0ZW0ucHkgYi9weXRob24v
Y29tbWl0LXBlci1zdWJzeXN0ZW0ucHkNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+PiBpbmRl
eCAwMDAwMDAwMDAwLi5kODQ0MmQ5ZWEzDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9weXRo
b24vY29tbWl0LXBlci1zdWJzeXN0ZW0ucHkNCj4+IEBAIC0wLDAgKzEsNjkgQEANCj4+ICsjIS91
c3IvYmluL2VudiBweXRob24zDQo+PiArIw0KPj4gKyMgQ29weXJpZ2h0IChjKSAyMDE5IFZpcnR1
b3p6byBJbnRlcm5hdGlvbmFsIEdtYkgNCj4+ICsjDQo+PiArIyBUaGlzIHByb2dyYW0gaXMgZnJl
ZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPj4gKyMg
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBw
dWJsaXNoZWQgYnkNCj4+ICsjIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yDQo+PiArIyAoYXQgeW91ciBvcHRpb24pIGFueSBs
YXRlciB2ZXJzaW9uLg0KPj4gKyMNCj4+ICsjIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBp
biB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLA0KPj4gKyMgYnV0IFdJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4+ICsjIE1F
UkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0
aGUNCj4+ICsjIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQo+
PiArIw0KPj4gKyMgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UNCj4+ICsjIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtLiAgSWYg
bm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KPj4gKyMNCj4+ICsNCj4+
ICtpbXBvcnQgc3VicHJvY2Vzcw0KPj4gK2ltcG9ydCBzeXMNCj4+ICsNCj4+ICsNCj4+ICtkZWYg
Z2l0X2FkZChwYXR0ZXJuKToNCj4+ICsgICAgc3VicHJvY2Vzcy5ydW4oWydnaXQnLCAnYWRkJywg
cGF0dGVybl0pDQo+PiArDQo+PiArDQo+PiArZGVmIGdpdF9jb21taXQobXNnKToNCj4+ICsgICAg
c3VicHJvY2Vzcy5ydW4oWydnaXQnLCAnY29tbWl0JywgJy1tJywgbXNnXSwgY2FwdHVyZV9vdXRw
dXQ9VHJ1ZSkNCj4+ICsNCj4+ICsNCj4+ICttYWludGFpbmVycyA9IHN5cy5hcmd2WzFdDQo+PiAr
bWVzc2FnZSA9IHN5cy5hcmd2WzJdLnN0cmlwKCkNCj4+ICsNCj4+ICtzdWJzeXN0ZW0gPSBOb25l
DQo+PiArDQo+PiArc2hvcnRuYW1lcyA9IHsNCj4+ICsgICAgJ0Jsb2NrIGxheWVyIGNvcmUnOiAn
YmxvY2snLA0KPj4gKyAgICAnQVJNIGNvcmVzJzogJ2FybScsDQo+PiArICAgICdOZXR3b3JrIEJs
b2NrIERldmljZSAoTkJEKSc6ICduYmQnLA0KPj4gKyAgICAnQ29tbWFuZCBsaW5lIG9wdGlvbiBh
cmd1bWVudCBwYXJzaW5nJzogJ2NtZGxpbmUnLA0KPj4gKyAgICAnQ2hhcmFjdGVyIGRldmljZSBi
YWNrZW5kcyc6ICdjaGFyZGV2JywNCj4+ICsgICAgJ1MzOTAgZ2VuZXJhbCBhcmNoaXRlY3R1cmUg
c3VwcG9ydCc6ICdzMzkwJw0KPj4gK30NCj4+ICsNCj4+ICsNCj4+ICtkZWYgY29tbWl0KCk6DQo+
PiArICAgIGlmIHN1YnN5c3RlbToNCj4+ICsgICAgICAgIG1zZyA9IHN1YnN5c3RlbQ0KPj4gKyAg
ICAgICAgaWYgbXNnIGluIHNob3J0bmFtZXM6DQo+PiArICAgICAgICAgICAgbXNnID0gc2hvcnRu
YW1lc1ttc2ddDQo+PiArICAgICAgICBtc2cgKz0gJzogJyArIG1lc3NhZ2UNCj4+ICsgICAgICAg
IGdpdF9jb21taXQobXNnKQ0KPj4gKw0KPj4gKw0KPj4gK3dpdGggb3BlbihtYWludGFpbmVycykg
YXMgZjoNCj4+ICsgICAgZm9yIGxpbmUgaW4gZjoNCj4+ICsgICAgICAgIGxpbmUgPSBsaW5lLnJz
dHJpcCgpDQo+PiArICAgICAgICBpZiBub3QgbGluZToNCj4+ICsgICAgICAgICAgICBjb250aW51
ZQ0KPj4gKyAgICAgICAgaWYgbGVuKGxpbmUpID49IDIgYW5kIGxpbmVbMV0gPT0gJzonOg0KPj4g
KyAgICAgICAgICAgIGlmIGxpbmVbMF0gPT0gJ0YnIGFuZCBsaW5lWzM6XSBub3QgaW4gWycqJywg
JyovJ106DQo+PiArICAgICAgICAgICAgICAgIGdpdF9hZGQobGluZVszOl0pDQo+PiArICAgICAg
ICBlbHNlOg0KPj4gKyAgICAgICAgICAgICMgbmV3IHN1YnN5c3RlbSBzdGFydA0KPj4gKyAgICAg
ICAgICAgIGNvbW1pdCgpDQo+PiArDQo+PiArICAgICAgICAgICAgc3Vic3lzdGVtID0gbGluZQ0K
Pj4gKw0KPj4gK2NvbW1pdCgpDQo+IA0KPiBIbS4uLiBJJ20gbm90IHN1cmUgYWJvdXQgdGhlIHB1
cnBvc2Ugb2YgdGhpcyBzY3JpcHQgKGFuZCBteSBweXRob24gaXMNCj4gcmF0aGVyIHdlYWspLi4u
IGlzIHRoaXMgc3VwcG9zZWQgdG8gY29sbGVjdCBhbGwgY2hhbmdlcyBjb3ZlcmVkIGJ5IGENCj4g
c3Vic3lzdGVtIEY6IHBhdHRlcm4gaW50byBvbmUgcGF0Y2g/DQoNClllcw0KDQo+IElmIHNvLCB3
aGF0IGhhcHBlbnMgdG8gZmlsZXMNCj4gY292ZXJlZCBieSBtdWx0aXBsZSBzZWN0aW9ucz8NCj4g
DQoNCkhtbSwgdGhleSBqdXN0IGdvIHRvIHRoZSBmaXJzdCBvZiB0aGVzZSBzZWN0aW9ucywgbWVu
dGlvbmVkIGluIE1BSU5UQUlORVJTLg0KSXMgaXQgYmFkIEkgZG9uJ3Qga25vdywgYnV0IEkgdHJp
ZWQgdG8gYXV0b21hdGUgaXQgc29tZWhvdy4gQW55d2F5LCBJIG15c2VsZg0KY2FuJ3QgaGF2ZSBi
ZXR0ZXIgaWRlYSBhYm91dCBob3cgdG8gb3JnYW5pemUgcGF0Y2hlcyB0byB0aGUgc3Vic3lzdGVt
cyB3aGljaA0KSSBkb24ndCBrbm93Lg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


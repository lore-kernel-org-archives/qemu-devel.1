Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C36FC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5965206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 08:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sT25Qf3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5965206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9mIq-0005vC-QX
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 04:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9mHW-00054H-Mo
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i9mHV-00009U-1d
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 04:22:46 -0400
Received: from mail-eopbgr150123.outbound.protection.outlook.com
 ([40.107.15.123]:55008 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i9mHU-00008l-Ar; Mon, 16 Sep 2019 04:22:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSnN2XpfT9PXZ9CGutisP1aRjSx759q8ci2/vMueg+WVFz1l1X8qk4ta/oYdIZF2SGV3pFEwZ3/cGodrqbmAPZgfzRzhFWx0HXDeqrmKXnisUIYGuZwYciaHCgr9w0SRgXZKZoesOYsl5nA00YDQ96qkZHa7ob4sAJHMfjxJckJ9wDzsbYX7wIFI+vbDDG+2nkx6DY03ANmqZugv2lRvLe93MLzBdQrE6mp41D/tNP4NJljhZNEuO/XQSDJk8jJiYdZKoGtUenHY0dW6zBQq71JmhZ/SLuuMOQBzbwIlsg2ZoGdpwOJ7D2GNrAi4waTOhroEc4MH4PogF1tHN0Na8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdSxAtKErOh8KMb3AF3xuuD9OHiZdHYccZ8Cdg0Uo60=;
 b=LJpmov7gyO33A/uuxD5EvxU5SJitWxyRPiPdjpu2nkn+yOpQVS/Nx/ySwLlMQIvJWv30W4k/cSp9H61Pkzsw+ClF8ypO2HvOpaf8MM1W+Xh6rBmWOq6thpgmxOcF3BH7iS9soq3I9bpShTtLX+bqQgbtx02w5PxnIkmQFpzMBLbw3/TT/iNmIXfhYFaXvbWVoQok+f4ATsr1Gvm7ciIY7SIwbMKOI4uqbKCNN8T/Vr10NjDHw9h1vgHQBek3J2XP8Yusul3g213VtN1xxvfOwXXsMAMVNJF5spMay/cObb9GSNd9zQqSuWEwggWfLWH29z6iz2lpqTsKy4PcXZ0i0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdSxAtKErOh8KMb3AF3xuuD9OHiZdHYccZ8Cdg0Uo60=;
 b=sT25Qf3XkHUkcQq68Kj90aan9CIKyZX/rjuLGu6hafIPcBRcN/RWyC/cq3AWkSP025DZPXpmG/J2XZ0mOaun0YoIc+pEawCzfQMyrYylKo8puLdoh9sMviYCwuHLkF+NOrJHj+NHAuGt7kgSYn5m1zTYCaS9LFd7YKl2gXn3d40=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4956.eurprd08.prod.outlook.com (10.255.16.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Mon, 16 Sep 2019 08:22:41 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 08:22:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 2/3] block/dirty-bitmap: return int from
 bdrv_remove_persistent_dirty_bitmap
Thread-Index: AQHVaLG/yLxPtq2pgU6tYD8R7zUgjKcqLCsAgAPSPgA=
Date: Mon, 16 Sep 2019 08:22:40 +0000
Message-ID: <69d06705-311d-de6b-97d2-2cf3545acc12@virtuozzo.com>
References: <20190911150054.90936-1-vsementsov@virtuozzo.com>
 <20190911150054.90936-3-vsementsov@virtuozzo.com>
 <717dad2d-3a78-e64d-6155-a062cd2b0df1@redhat.com>
In-Reply-To: <717dad2d-3a78-e64d-6155-a062cd2b0df1@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0247.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190916112238175
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddf30a5d-3ab1-4319-353b-08d73a7f0a6c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4956; 
x-ms-traffictypediagnostic: DB8PR08MB4956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB495619F2EF7E5B4C91BE0BA7C18C0@DB8PR08MB4956.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(76176011)(229853002)(6436002)(6486002)(53546011)(6506007)(386003)(6116002)(3846002)(99286004)(14454004)(52116002)(25786009)(8676002)(81156014)(2906002)(81166006)(2501003)(71200400001)(8936002)(71190400001)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(31686004)(5660300002)(478600001)(7736002)(305945005)(186003)(102836004)(53936002)(486006)(4326008)(14444005)(256004)(26005)(54906003)(110136005)(2616005)(446003)(476003)(36756003)(11346002)(107886003)(6512007)(86362001)(31696002)(6246003)(316002)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4956;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bUaH4cdePZpFwx1DbGFkSMqLY65hj1/+rMwn1wM5w2zJLQHHNDhr4PQHoGHPLt2V1xXsr5hcLXIP1R4XatGmd0itDZbF13jn0Haob97fo6eY5RhOCB89ELwi6mMcjIW2Jjxs3OffEgvFvlSC5nXPnDsvgGtBEbIhjPaRgwNn59pIPmncYztYd+UB9S6KOXg61qLEQN1cx+CNSRlPLi8n7DYplfKlRQtc/gO0Jh9gcumPtKKzQJqY0uHt/HeODZvvE4EZSoVoHCoSsxqhF8mH+jhG88398gXYRuqBPG+d62lQAcC5F6bBbEtgtJgEb15GRFRspXAylM2nLhQObkCY534/QET9BfFwCQck6V5qxZiUHu6kKO8ZLd0FPJBC6SDPV+OF+HSUvE3KEGVazNm+lclQ9fDOz3mM81ivdo211fo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFB5A3BDDFC09B4DAD5105A81C5726F6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf30a5d-3ab1-4319-353b-08d73a7f0a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 08:22:40.9258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4nO0zzBCevvbclUBCvQloOcbG/hNqShfx3asEAgkVywX8cZ42/LLnSvDQ0+NA3E+73L4lYWE8txjUeh5ZVFN4ckrHADx9mVRpNAyN/dJwxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4956
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.123
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/dirty-bitmap: return int from
 bdrv_remove_persistent_dirty_bitmap
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDkuMjAxOSAxOjAxLCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOS8xMS8xOSAx
MTowMCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEl0J3MgbW9y
ZSBjb21mb3J0YWJsZSB0byBub3QgZGVhbCB3aXRoIGxvY2FsX2Vyci4NCj4+DQo+IA0KPiBJIGFn
cmVlLg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9xY293Mi5oICAg
ICAgICAgICAgICAgIHwgIDUgKystLS0NCj4+ICAgaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCAg
ICB8ICA2ICsrKy0tLQ0KPj4gICBpbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1hcC5oIHwgIDUgKyst
LS0NCj4+ICAgYmxvY2svZGlydHktYml0bWFwLmMgICAgICAgICB8ICA5ICsrKysrLS0tLQ0KPj4g
ICBibG9jay9xY293Mi1iaXRtYXAuYyAgICAgICAgIHwgMjAgKysrKysrKysrKystLS0tLS0tLS0N
Cj4+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgICAgICAgICB8ICA3ICsrKy0tLS0NCj4+ICAgNiBm
aWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuaCBiL2Jsb2NrL3Fjb3cyLmgNCj4+IGluZGV4IDk5OGJj
ZGFlZjEuLjk5ZWU4OGY4MDIgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9xY293Mi5oDQo+PiArKysg
Yi9ibG9jay9xY293Mi5oDQo+PiBAQCAtNzQ3LDkgKzc0Nyw4IEBAIGJvb2wgcWNvdzJfY2FuX3N0
b3JlX25ld19kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZSwNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBncmFudWxhcml0eSwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnAp
Ow0KPj4gLXZvaWQgcWNvdzJfcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKEJsb2NrRHJp
dmVyU3RhdGUgKmJzLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICtpbnQgcWNvdzJfcmVtb3ZlX3BlcnNpc3Rl
bnRfZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBjb25zdCBjaGFyICpuYW1lLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJw
KTsNCj4+ICAgDQo+PiAgIHNzaXplX3QgY29yb3V0aW5lX2ZuDQo+PiAgIHFjb3cyX2NvX2NvbXBy
ZXNzKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCB2b2lkICpkZXN0LCBzaXplX3QgZGVzdF9zaXplLA0K
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50LmggYi9pbmNsdWRlL2Jsb2Nr
L2Jsb2NrX2ludC5oDQo+PiBpbmRleCAwNDIyYWNkZjFjLi41MDNhYzllM2NkIDEwMDY0NA0KPj4g
LS0tIGEvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaA0KPj4gKysrIGIvaW5jbHVkZS9ibG9jay9i
bG9ja19pbnQuaA0KPj4gQEAgLTU1Niw5ICs1NTYsOSBAQCBzdHJ1Y3QgQmxvY2tEcml2ZXIgew0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNo
YXIgKm5hbWUsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDMyX3QgZ3JhbnVsYXJpdHksDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+IC0gICAgdm9pZCAoKmJkcnZfcmVt
b3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKShCbG9ja0RyaXZlclN0YXRlICpicywNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFy
ICpuYW1lLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCk7DQo+PiArICAgIGludCAoKmJkcnZfcmVtb3ZlX3BlcnNpc3RlbnRf
ZGlydHlfYml0bWFwKShCbG9ja0RyaXZlclN0YXRlICpicywNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnAp
Ow0KPj4gICANCj4+ICAgICAgIC8qKg0KPj4gICAgICAgICogUmVnaXN0ZXIvdW5yZWdpc3RlciBh
IGJ1ZmZlciBmb3IgSS9PLiBGb3IgZXhhbXBsZSwgd2hlbiB0aGUgZHJpdmVyIGlzDQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCBiL2luY2x1ZGUvYmxvY2svZGly
dHktYml0bWFwLmgNCj4+IGluZGV4IDRiNGI3MzFiNDYuLjA3NTAzYjAzYjUgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1hcC5oDQo+PiArKysgYi9pbmNsdWRlL2Jsb2Nr
L2RpcnR5LWJpdG1hcC5oDQo+PiBAQCAtMzcsOSArMzcsOCBAQCBpbnQgYmRydl9kaXJ0eV9iaXRt
YXBfY2hlY2soY29uc3QgQmRydkRpcnR5Qml0bWFwICpiaXRtYXAsIHVpbnQzMl90IGZsYWdzLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICAgdm9p
ZCBiZHJ2X3JlbGVhc2VfZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCZHJ2RGly
dHlCaXRtYXAgKmJpdG1hcCk7DQo+PiAgIHZvaWQgYmRydl9yZWxlYXNlX25hbWVkX2RpcnR5X2Jp
dG1hcHMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPj4gLXZvaWQgYmRydl9yZW1vdmVfcGVyc2lz
dGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lLA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICtp
bnQgYmRydl9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCk7DQo+PiAgIHZvaWQgYmRydl9kaXNhYmxlX2RpcnR5X2Jp
dG1hcChCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCk7DQo+PiAgIHZvaWQgYmRydl9lbmFibGVfZGly
dHlfYml0bWFwKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwKTsNCj4+ICAgdm9pZCBiZHJ2X2VuYWJs
ZV9kaXJ0eV9iaXRtYXBfbG9ja2VkKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwKTsNCj4+IGRpZmYg
LS1naXQgYS9ibG9jay9kaXJ0eS1iaXRtYXAuYyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+PiBp
bmRleCA4ZjQyMDE1ZGI5Li5hNTJiODNiNjE5IDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svZGlydHkt
Yml0bWFwLmMNCj4+ICsrKyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+PiBAQCAtNDU1LDEzICs0
NTUsMTQgQEAgdm9pZCBiZHJ2X3JlbGVhc2VfbmFtZWRfZGlydHlfYml0bWFwcyhCbG9ja0RyaXZl
clN0YXRlICpicykNCj4+ICAgICogbm90IGZhaWwuDQo+PiAgICAqIFRoaXMgZnVuY3Rpb24gZG9l
c24ndCByZWxlYXNlIGNvcnJlc3BvbmRpbmcgQmRydkRpcnR5Qml0bWFwLg0KPj4gICAgKi8NCj4+
IC12b2lkIGJkcnZfcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3QgY2hhciAqbmFtZSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCkNCj4+ICtpbnQgYmRydl9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9i
aXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGNvbnN0IGNoYXIgKm5hbWUsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICAgew0K
Pj4gICAgICAgaWYgKGJzLT5kcnYgJiYgYnMtPmRydi0+YmRydl9yZW1vdmVfcGVyc2lzdGVudF9k
aXJ0eV9iaXRtYXApIHsNCj4+IC0gICAgICAgIGJzLT5kcnYtPmJkcnZfcmVtb3ZlX3BlcnNpc3Rl
bnRfZGlydHlfYml0bWFwKGJzLCBuYW1lLCBlcnJwKTsNCj4+ICsgICAgICAgIHJldHVybiBicy0+
ZHJ2LT5iZHJ2X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcChicywgbmFtZSwgZXJycCk7
DQo+PiAgICAgICB9DQo+PiArDQo+IA0KPiBCdXQgaXMgaXQgYSBwcm9ibGVtIGlmIHdlIHJldHVy
biBhbiBlcnJvciBjb2RlIHdpdGhvdXQgc2V0dGluZyBlcnJwIG5vdz8NCj4gSWYgdGhpcyBpcyBm
b3IgdGhlIHNha2Ugb2Ygbm90IGhhdmluZyB0byBkZWFsIHdpdGggbG9jYWxfZXJyLCB3ZSBzaG91
bGQNCj4gbWFrZSBzdXJlIHRoYXQgYSBub24temVybyByZXR1cm4gbWVhbnMgdGhhdCBlcnJwIGlz
IHNldC4gUmlnaHQ/DQoNCk9vcHMsIG9mIGNvdXJzZSwgSSBzaG91bGQgc2V0IGVycnAgaGVyZQ0K
DQo+IA0KPj4gKyAgICByZXR1cm4gLUVOT1RTVVA7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIGJvb2wg
YmRydl9jYW5fc3RvcmVfbmV3X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywgY29u
c3QgY2hhciAqbmFtZSwNCj4+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi1iaXRtYXAuYyBiL2Js
b2NrL3Fjb3cyLWJpdG1hcC5jDQo+PiBpbmRleCBiMjQ4NzEwMWVkLi4xYWFlZGIzYjU1IDEwMDY0
NA0KPj4gLS0tIGEvYmxvY2svcWNvdzItYml0bWFwLmMNCj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLWJp
dG1hcC5jDQo+PiBAQCAtMTQwNCwxMSArMTQwNCwxMCBAQCBzdGF0aWMgUWNvdzJCaXRtYXAgKmZp
bmRfYml0bWFwX2J5X25hbWUoUWNvdzJCaXRtYXBMaXN0ICpibV9saXN0LA0KPj4gICAgICAgcmV0
dXJuIE5VTEw7DQo+PiAgIH0NCj4+ICAgDQo+PiAtdm9pZCBxY293Ml9yZW1vdmVfcGVyc2lzdGVu
dF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZSwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiAraW50
IHFjb3cyX3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpi
cywgY29uc3QgY2hhciAqbmFtZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICAgew0KPj4gLSAgICBpbnQgcmV0Ow0KPj4gKyAg
ICBpbnQgcmV0ID0gMDsNCj4gDQo+IEkgd2FzIGdvaW5nIHRvIHNheSBJJ2QgcmF0aGVyIG5vdCBp
bml0aWFsaXplIHRoaXMsIGJ1dCBpcyB0aGlzIHJlbGF0ZWQNCj4gdG8gdWJzYW4gbGludGluZz8N
Cg0KSG1tLCBkb24ndCByZW1lbWJlci4gRm9yIHNvbWUgcmVhc29uIEkgdGhvdWdodCAgaXQncyBu
ZWVkZWQuLg0KV2lsbCBkcm9wIGFuZCBjaGVjayB3aGF0IGNvbXBpbGVyIHNheXMuDQoNCj4gDQo+
PiAgICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFxdWU7DQo+PiAgICAgICBRY293MkJp
dG1hcCAqYm07DQo+PiAgICAgICBRY293MkJpdG1hcExpc3QgKmJtX2xpc3Q7DQo+PiBAQCAtMTQx
NiwxOCArMTQxNSwxOSBAQCB2b2lkIHFjb3cyX3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1h
cChCbG9ja0RyaXZlclN0YXRlICpicywNCj4+ICAgICAgIGlmIChzLT5uYl9iaXRtYXBzID09IDAp
IHsNCj4+ICAgICAgICAgICAvKiBBYnNlbmNlIG9mIHRoZSBiaXRtYXAgaXMgbm90IGFuIGVycm9y
OiBzZWUgZXhwbGFuYXRpb24gYWJvdmUNCj4+ICAgICAgICAgICAgKiBiZHJ2X3JlbW92ZV9wZXJz
aXN0ZW50X2RpcnR5X2JpdG1hcCgpIGRlZmluaXRpb24uICovDQo+PiAtICAgICAgICByZXR1cm47
DQo+PiArICAgICAgICByZXR1cm4gMDsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAgICAgICBibV9s
aXN0ID0gYml0bWFwX2xpc3RfbG9hZChicywgcy0+Yml0bWFwX2RpcmVjdG9yeV9vZmZzZXQsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5iaXRtYXBfZGlyZWN0b3J5X3Np
emUsIGVycnApOw0KPj4gICAgICAgaWYgKGJtX2xpc3QgPT0gTlVMTCkgew0KPj4gLSAgICAgICAg
cmV0dXJuOw0KPj4gKyAgICAgICAgcmV0dXJuIC1FSU87DQo+PiAgICAgICB9DQo+PiAgIA0KPj4g
ICAgICAgYm0gPSBmaW5kX2JpdG1hcF9ieV9uYW1lKGJtX2xpc3QsIG5hbWUpOw0KPj4gICAgICAg
aWYgKGJtID09IE5VTEwpIHsNCj4+IC0gICAgICAgIGdvdG8gZmFpbDsNCj4+ICsgICAgICAgIHJl
dCA9IC1FSU5WQUw7DQo+PiArICAgICAgICBnb3RvIG91dDsNCj4+ICAgICAgIH0NCj4+ICAgDQo+
PiAgICAgICBRU0lNUExFUV9SRU1PVkUoYm1fbGlzdCwgYm0sIFFjb3cyQml0bWFwLCBlbnRyeSk7
DQo+PiBAQCAtMTQzNSwxNCArMTQzNSwxNiBAQCB2b2lkIHFjb3cyX3JlbW92ZV9wZXJzaXN0ZW50
X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCj4+ICAgICAgIHJldCA9IHVwZGF0
ZV9leHRfaGVhZGVyX2FuZF9kaXIoYnMsIGJtX2xpc3QpOw0KPj4gICAgICAgaWYgKHJldCA8IDAp
IHsNCj4+ICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsICJGYWlsZWQgdG8g
dXBkYXRlIGJpdG1hcCBleHRlbnNpb24iKTsNCj4+IC0gICAgICAgIGdvdG8gZmFpbDsNCj4+ICsg
ICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgfQ0KPj4gICANCj4+ICAgICAgIGZyZWVfYml0bWFw
X2NsdXN0ZXJzKGJzLCAmYm0tPnRhYmxlKTsNCj4+ICAgDQo+PiAtZmFpbDoNCj4+ICtvdXQ6DQo+
PiAgICAgICBiaXRtYXBfZnJlZShibSk7DQo+PiAgICAgICBiaXRtYXBfbGlzdF9mcmVlKGJtX2xp
c3QpOw0KPj4gKw0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIA0KPj4gICB2b2lk
IHFjb3cyX3N0b3JlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwcyhCbG9ja0RyaXZlclN0YXRlICpi
cywgRXJyb3IgKiplcnJwKQ0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrZGV2LmMgYi9ibG9ja2Rldi5j
DQo+PiBpbmRleCBmYmVmNjg0NWM4Li4wODEzYWRmYjJiIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2tk
ZXYuYw0KPj4gKysrIGIvYmxvY2tkZXYuYw0KPj4gQEAgLTI5NDAsMTUgKzI5NDAsMTQgQEAgc3Rh
dGljIEJkcnZEaXJ0eUJpdG1hcCAqZG9fYmxvY2tfZGlydHlfYml0bWFwX3JlbW92ZSgNCj4+ICAg
ICAgIH0NCj4+ICAgDQo+PiAgICAgICBpZiAoYmRydl9kaXJ0eV9iaXRtYXBfZ2V0X3BlcnNpc3Rl
bmNlKGJpdG1hcCkpIHsNCj4+ICsgICAgICAgIGludCByZXQ7DQo+PiAgICAgICAgICAgQWlvQ29u
dGV4dCAqYWlvX2NvbnRleHQgPSBiZHJ2X2dldF9haW9fY29udGV4dChicyk7DQo+PiAtICAgICAg
ICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+ICAgDQo+PiAgICAgICAgICAgYWlvX2NvbnRl
eHRfYWNxdWlyZShhaW9fY29udGV4dCk7DQo+PiAtICAgICAgICBiZHJ2X3JlbW92ZV9wZXJzaXN0
ZW50X2RpcnR5X2JpdG1hcChicywgbmFtZSwgJmxvY2FsX2Vycik7DQo+PiArICAgICAgICByZXQg
PSBiZHJ2X3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcChicywgbmFtZSwgZXJycCk7DQo+
PiAgICAgICAgICAgYWlvX2NvbnRleHRfcmVsZWFzZShhaW9fY29udGV4dCk7DQo+PiAgIA0KPj4g
LSAgICAgICAgaWYgKGxvY2FsX2VyciAhPSBOVUxMKSB7DQo+PiAtICAgICAgICAgICAgZXJyb3Jf
cHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+PiArICAgICAgICBpZiAocmV0IDwgMCkgew0K
Pj4gICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4+ICAgICAgICAgICB9DQo+PiAgICAgICB9
DQo+Pg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


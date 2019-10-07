Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833EC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2692067B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qcBNan7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2692067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVzh-000156-8f
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVsq-0003Jx-Lc
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iHVso-0001br-Ro
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:29:16 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com
 ([40.107.2.134]:37006 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iHVsn-0001bA-56; Mon, 07 Oct 2019 12:29:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk1ZvAJTEbeyTnVnLCPfpfKs0r8zCw4tq+Eyh3BIA6sOVZRVdHd3rw2SUy4GdO4WkJW2q/PDnAr90StZio7dh9nyBQRAKaucUL2VSQmA8hemJmSmBYD2m3arF5f0L/TR7pAD7Zxa5GHQbDp4dvYbSAD7idVme5Oed7Xpt1iEO/wfOwA2JUZax5artBh4GpFLI+dydNrqrHQF+Ep9XBzxVZP9+SPsnJ6EAdb1byNQJbIiupqRUUOUJJ0+FZdmYg4E7OIpLsQmuvD70YpdVaKIU4XM+5o+ngIgowjL+Ct2bN7mkR1JUrA2uNkaslAeDnKShhlixmz0QVQCv/yrh0g0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaZ5Iw3Jj0fZz1rf8b/J/jd0TuJKxZ2eU35tJ0dO6JU=;
 b=FLE+Ry5Xejs/D4b/zo7AySglnB2umm1FcXYSjefgXPstDVini8/YGOM8VG9sRHwIYkl33K87j81SObL6c9pnyPJHyw1ndDs6/GUIBRER132wVhGRA5fpwMmPXy3kRpmacYOra6aLqL41PwiivnRYIsEEpVVaWuj6BOP6pC2w8LWsz2oNmb3OYnnWhwhxubAZ7yEtEWgdFUI8z25pCthF7IbQk9HwBiXz+VnYnW8k04vdZwZMR7tQ4I9dQXTp1uZBWg7qheGCNmT/RGktdYkmQNt0sFwL/4IW8SMr39+NAebOd39aHu96adZ6+QVKiphHqi8m67ukdbxL1s0g1mJOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaZ5Iw3Jj0fZz1rf8b/J/jd0TuJKxZ2eU35tJ0dO6JU=;
 b=qcBNan7oXWPilYl5C5dBGdqLSpqJmlh2N2bzge6iq5bMexhRoPdPslK4YlJv216++biU8dEjjTHcgZTC3vcRTnE6ziHVa8taHW3EFmmh6QqHQ+BnBUAUjPSo2qZz45MGkclSv+iMjrZkjGpTVvjfL0J68y7PGWasI82UFVKX/6M=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5355.eurprd08.prod.outlook.com (52.133.240.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Mon, 7 Oct 2019 16:29:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2327.023; Mon, 7 Oct 2019
 16:29:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 3/6] block/block-copy: refactor copying
Thread-Topic: [PATCH 3/6] block/block-copy: refactor copying
Thread-Index: AQHVeg4ysE+4h6fEzkujvuQ2nZFgPadPP9AAgAAkvgA=
Date: Mon, 7 Oct 2019 16:29:09 +0000
Message-ID: <8a394498-f9b9-41d4-de82-600db89b0d6a@virtuozzo.com>
References: <20191003171539.12327-1-vsementsov@virtuozzo.com>
 <20191003171539.12327-4-vsementsov@virtuozzo.com>
 <dacae11a-0da6-d08e-05a7-d605466a5743@redhat.com>
In-Reply-To: <dacae11a-0da6-d08e-05a7-d605466a5743@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0330.eurprd05.prod.outlook.com
 (2603:10a6:7:92::25) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191007192904873
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a472c6f-38e8-4b4d-fe6c-08d74b437acf
x-ms-traffictypediagnostic: DB8PR08MB5355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB535518CC6A8521E616F679DFC19B0@DB8PR08MB5355.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:120;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(6116002)(26005)(31686004)(25786009)(66946007)(66066001)(71190400001)(71200400001)(66446008)(66476007)(66556008)(64756008)(3846002)(6506007)(99286004)(11346002)(7736002)(53546011)(386003)(31696002)(76176011)(86362001)(52116002)(81156014)(102836004)(8676002)(81166006)(8936002)(486006)(446003)(476003)(2616005)(2906002)(186003)(14454004)(305945005)(316002)(54906003)(2501003)(14444005)(110136005)(478600001)(5660300002)(6512007)(6436002)(107886003)(4326008)(6246003)(36756003)(256004)(6486002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5355;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 43A8CqDFkKBO04cyW0HudCvEbzK2IkNkjNCC5Xjh6kOpS2IJskDeDMGqrhbqySIJN6tcukHV8Kt7+ToioWVlPY28+XWejFof37zNNSIW2BnKNW6Wi7cPlifMS1UoM0aMm2GsTLkFiJiclBCtclJgpxiCPuOE5vBJRJc6mQxKqAjpOEkS/v36xqY2HxRvSvtW8pkuFQiOIEI696Wl4Gvo8lcmoS6vhJAhWaZlPIqN/GlHwjRAn8MVq8pZz7jyjcSghS1PL+noEs3yp84DWX+8gfVX6hG3bvDx7k60PX8NiSoguMlcEDWkMu0aJP5Ll5RHC93oBCCokLDvI+oJpRNBtMFHCsaB4iSEsdzhuzgyHl/FWx3fe1e4CgvQAvRoGxMq1/ydoqraftOvA3XpUglepVE27AIhMU7q6OrE0irC1rg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AABF199BB171C444B4024C75D664E7DB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a472c6f-38e8-4b4d-fe6c-08d74b437acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 16:29:09.3349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRq0ulzS7b9oPXGsfNO3FvXj2UclnsChmnPEItoZtyuOJjhDm3LI9bxrjEKWqmQaYwkKuK3p5ILwWxT+Nc/s+YtPc3rOiRB4tls7ELrRq0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5355
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.134
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMTAuMjAxOSAxNzoxNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMy4xMC4xOSAxOToxNSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IE1lcmdlIGNvcHlpbmcgY29k
ZSBpbnRvIG9uZSBmdW5jdGlvbiBibG9ja19jb3B5X2RvX2NvcHksIHdoaWNoIG9ubHkNCj4+IGNh
bGxzIGJkcnZfIGlvIGZ1bmN0aW9ucyBhbmQgZG9uJ3QgZG8gYW55IHN5bmNocm9uaXphdGlvbiAo
bGlrZSBkaXJ0eQ0KPj4gYml0bWFwIHNldC9yZXNldCkuDQo+Pg0KPj4gUmVmYWN0b3IgYmxvY2tf
Y29weSgpIGZ1bmN0aW9uIHNvIHRoYXQgaXQgdGFrZXMgZnVsbCBkZWNpc2lvbiBhYm91dA0KPj4g
c2l6ZSBvZiBjaHVuayB0byBiZSBjb3BpZWQgYW5kIGRvZXMgYWxsIHRoZSBzeW5jaHJvbml6YXRp
b24gKGNoZWNraW5nDQo+PiBpbnRlcnNlY3RpbmcgcmVxdWVzdHMsIHNldC9yZXNldCBkaXJ0eSBi
aXRtYXBzKS4NCj4+DQo+PiBJdCB3aWxsIGhlbHA6DQo+PiAgIC0gaW50cm9kdWNlIHBhcmFsbGVs
IHByb2Nlc3Npbmcgb2YgYmxvY2tfY29weSBpdGVyYXRpb25zOiB3ZSBuZWVkIHRvDQo+PiAgICAg
Y2FsY3VsYXRlIGNodW5rIHNpemUsIHN0YXJ0IGFzeW5jIGNodW5rIGNvcHlpbmcgYW5kIGdvIHRv
IHRoZSBuZXh0DQo+PiAgICAgaXRlcmF0aW9uDQo+PiAgIC0gc2ltcGxpZnkgc3luY2hyb25pemF0
aW9uIGltcHJvdmVtZW50IChsaWtlIG1lbW9yeSBsaW1pdGluZyBpbg0KPj4gICAgIGZ1cnRoZXIg
Y29tbWl0IGFuZCByZWR1Y2luZyBjcml0aWNhbCBzZWN0aW9uIChub3cgd2UgbG9jayB0aGUgd2hv
bGUNCj4+ICAgICByZXF1ZXN0ZWQgcmFuZ2UsIHdoZW4gYWN0dWFsbHkgd2UgbmVlZCB0byBsb2Nr
IG9ubHkgZGlydHkgcmVnaW9uDQo+PiAgICAgd2hpY2ggd2UgaGFuZGxlIGF0IHRoZSBtb21lbnQp
KQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZz
ZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gICBibG9jay9ibG9jay1jb3B5LmMg
fCAxMTMgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAg
IGJsb2NrL3RyYWNlLWV2ZW50cyB8ICAgNiArLS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MyBp
bnNlcnRpb25zKCspLCA2NiBkZWxldGlvbnMoLSkNCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUsIGp1
c3Qgc29tZSBjbGVhbi11cCBwYXRoIG5pdCBwaWNrcyBiZWxvdy4NCj4gDQo+PiBkaWZmIC0tZ2l0
IGEvYmxvY2svYmxvY2stY29weS5jIGIvYmxvY2svYmxvY2stY29weS5jDQo+PiBpbmRleCA3NTI4
N2NlMjRkLi5jYzQ5ZDIzNDVkIDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svYmxvY2stY29weS5jDQo+
PiArKysgYi9ibG9jay9ibG9jay1jb3B5LmMNCj4+IEBAIC0xMjYsMjUgKzEyNiw0MyBAQCB2b2lk
IGJsb2NrX2NvcHlfc2V0X2NhbGxiYWNrcygNCj4+ICAgfQ0KPj4gICANCj4+ICAgLyoNCj4+IC0g
KiBDb3B5IHJhbmdlIHRvIHRhcmdldCB3aXRoIGEgYm91bmNlIGJ1ZmZlciBhbmQgcmV0dXJuIHRo
ZSBieXRlcyBjb3BpZWQuIElmDQo+PiAtICogZXJyb3Igb2NjdXJyZWQsIHJldHVybiBhIG5lZ2F0
aXZlIGVycm9yIG51bWJlcg0KPj4gKyAqIGJsb2NrX2NvcHlfZG9fY29weQ0KPj4gKyAqDQo+PiAr
ICogRG8gY29weSBvZiBjbHVzZXItYWxpZ25lZCBjaHVuay4gQGVuZCBpcyBhbGxvd2VkIHRvIGV4
Y2VlZCBzLT5sZW4gb25seSB0bw0KPj4gKyAqIGNvdmVyIGxhc3QgY2x1c3RlciB3aGVuIHMtPmxl
biBpcyBub3QgYWxpZ25lZCB0byBjbHVzdGVycy4NCj4+ICsgKg0KPj4gKyAqIE5vIHN5bmMgaGVy
ZTogbm9yIGJpdG1hcCBuZWlnaHRlciBpbnRlcnNlY3RpbmcgcmVxdWVzdHMgaGFuZGxpbmcsIG9u
bHkgY29weS4NCj4+ICsgKg0KPj4gKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzLg0KPj4gICAgKi8N
Cj4+IC1zdGF0aWMgaW50IGNvcm91dGluZV9mbiBibG9ja19jb3B5X3dpdGhfYm91bmNlX2J1ZmZl
cihCbG9ja0NvcHlTdGF0ZSAqcywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IHN0YXJ0LA0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3QgZW5kLA0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgKmVycm9yX2lzX3JlYWQpDQo+PiArc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmxvY2tfY29w
eV9kb19jb3B5KEJsb2NrQ29weVN0YXRlICpzLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IHN0YXJ0LCBpbnQ2NF90IGVuZCwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCAqZXJyb3JfaXNfcmVh
ZCkNCj4+ICAgew0KPj4gICAgICAgaW50IHJldDsNCj4+IC0gICAgaW50IG5ieXRlczsNCj4+IC0g
ICAgdm9pZCAqYm91bmNlX2J1ZmZlciA9IHFlbXVfYmxvY2thbGlnbihzLT5zb3VyY2UtPmJzLCBz
LT5jbHVzdGVyX3NpemUpOw0KPj4gKyAgICBpbnQgbmJ5dGVzID0gTUlOKGVuZCwgcy0+bGVuKSAt
IHN0YXJ0Ow0KPj4gKyAgICB2b2lkICpib3VuY2VfYnVmZmVyID0gTlVMTDsNCj4+ICAgDQo+PiAg
ICAgICBhc3NlcnQoUUVNVV9JU19BTElHTkVEKHN0YXJ0LCBzLT5jbHVzdGVyX3NpemUpKTsNCj4+
IC0gICAgYmRydl9yZXNldF9kaXJ0eV9iaXRtYXAocy0+Y29weV9iaXRtYXAsIHN0YXJ0LCBzLT5j
bHVzdGVyX3NpemUpOw0KPj4gLSAgICBuYnl0ZXMgPSBNSU4ocy0+Y2x1c3Rlcl9zaXplLCBzLT5s
ZW4gLSBzdGFydCk7DQo+PiArICAgIGFzc2VydChRRU1VX0lTX0FMSUdORUQoZW5kLCBzLT5jbHVz
dGVyX3NpemUpKTsNCj4+ICsgICAgYXNzZXJ0KGVuZCA8IHMtPmxlbiB8fCBlbmQgPT0gUUVNVV9B
TElHTl9VUChzLT5sZW4sIHMtPmNsdXN0ZXJfc2l6ZSkpOw0KPj4gKw0KPj4gKyAgICBpZiAocy0+
dXNlX2NvcHlfcmFuZ2UpIHsNCj4+ICsgICAgICAgIHJldCA9IGJkcnZfY29fY29weV9yYW5nZShz
LT5zb3VyY2UsIHN0YXJ0LCBzLT50YXJnZXQsIHN0YXJ0LCBuYnl0ZXMsDQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMCwgcy0+d3JpdGVfZmxhZ3MpOw0KPj4gKyAgICAgICAg
aWYgKHJldCA8IDApIHsNCj4+ICsgICAgICAgICAgICB0cmFjZV9ibG9ja19jb3B5X2NvcHlfcmFu
Z2VfZmFpbChzLCBzdGFydCwgcmV0KTsNCj4+ICsgICAgICAgICAgICBzLT51c2VfY29weV9yYW5n
ZSA9IGZhbHNlOw0KPj4gKyAgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiANCj4gTWF5YmUgdGhlIOKAnGZhaWzigJ0gbGFiZWwgc2hvdWxkIGJlIGNhbGxlZCDi
gJ1vdXTigJ0gYW5kIHRoZW4gd2UgY291bGQgZ28gdGhlcmUNCj4gZnJvbSBoZXJlLiAgRG9lc27i
gJl0IG1ha2UgbXVjaCBvZiBhIGRpZmZlcmVuY2UgaGVyZSAoMSBMb0MgZWl0aGVyIHdheSksDQo+
IGJ1dCBtYXliZSBpdOKAmXMgYSBiaXQgY2xlYW5lciB0byBhbHdheXMgdXNlIHRoZSBjbGVhbi11
cCBwYXRoIGluIHRoaXMNCj4gZnVuY3Rpb24gKGV2ZW4gd2hlbiB0aGVyZeKAmXMgbm90aGluZyB0
byBjbGVhbiB1cCkuDQoNCkhtbSwgSSBhbHdheXMgZG8gaW1tZWRpYXRlIHJldHVybiBpZiBwb3Nz
aWJsZSAodGhpbmdzIHdoaWNoIG5lZWRzIGNsZWFudXAgbm90DQp5ZXQgaGFwcGVuZWQpLiBBIGtp
bmQgb2YgdGFzdGUgb2YgY291cnNlLCB5b3UgYXJlIG1haW50YWluZXIsIHNvIGlmIHlvdSBsaWtl
DQphbm90aGVyIHdheSwgSSdsbCBjaGFuZ2UgaXQgdG8gZ290by4NCg0KPiANCj4gKnNocnVnKg0K
PiANCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBib3VuY2VfYnVmZmVy
ID0gcWVtdV9ibG9ja2FsaWduKHMtPnNvdXJjZS0+YnMsIG5ieXRlcyk7DQo+PiAgIA0KPj4gICAg
ICAgcmV0ID0gYmRydl9jb19wcmVhZChzLT5zb3VyY2UsIHN0YXJ0LCBuYnl0ZXMsIGJvdW5jZV9i
dWZmZXIsIDApOw0KPj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4+IC0gICAgICAgIHRyYWNlX2Js
b2NrX2NvcHlfd2l0aF9ib3VuY2VfYnVmZmVyX3JlYWRfZmFpbChzLCBzdGFydCwgcmV0KTsNCj4+
ICsgICAgICAgIHRyYWNlX2Jsb2NrX2NvcHlfcmVhZF9mYWlsKHMsIHN0YXJ0LCByZXQpOw0KPj4g
ICAgICAgICAgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+PiAgICAgICAgICAgICAgICplcnJvcl9p
c19yZWFkID0gdHJ1ZTsNCj4+ICAgICAgICAgICB9DQo+IA0KPiBbLi4uXQ0KPiANCj4+IEBAIC0x
NjMsNDIgKzE4MSwxMiBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBibG9ja19jb3B5X3dpdGhf
Ym91bmNlX2J1ZmZlcihCbG9ja0NvcHlTdGF0ZSAqcywNCj4+ICAgDQo+PiAgICAgICBxZW11X3Zm
cmVlKGJvdW5jZV9idWZmZXIpOw0KPj4gICANCj4+IC0gICAgcmV0dXJuIG5ieXRlczsNCj4+ICsg
ICAgcmV0dXJuIDA7DQo+PiArDQo+PiAgIGZhaWw6DQo+PiAgICAgICBxZW11X3ZmcmVlKGJvdW5j
ZV9idWZmZXIpOw0KPj4gLSAgICBiZHJ2X3NldF9kaXJ0eV9iaXRtYXAocy0+Y29weV9iaXRtYXAs
IHN0YXJ0LCBzLT5jbHVzdGVyX3NpemUpOw0KPj4gLSAgICByZXR1cm4gcmV0Ow0KPj4gLQ0KPj4g
LX0NCj4gDQo+IFdvdWxkbuKAmXQgaXQgYmUgc2ltcGxlciB0byBkcm9wIHRoZSDigJxxZW11X3Zm
cmVlKGJvdW5jZV9idWZmZXIpOyByZXR1cm4NCj4gMDvigJ0gYWJvdmUgdGhlIGZhaWwgbGFiZWwg
YW5kIGp1c3QgZmFsbCB0aHJvdWdoPw0KDQpIbW0geWVzIHRoYXQncyBiZXR0ZXIgYW5kIG1vcmUg
dXN1YWwgcGF0dGVybi4gV2lsbCBkby4NCg0KPiANCj4gSW4gYW55IGNhc2U6DQo+IA0KPiBSZXZp
ZXdlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gDQoNCg0KLS0gDQpCZXN0
IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


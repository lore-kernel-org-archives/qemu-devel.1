Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1A5C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CA421924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lmJiJR0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CA421924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtKP-0003Cr-O5
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAtHj-00015Z-A3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iAtHh-0006n9-MB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:03:35 -0400
Received: from mail-ve1eur02on0721.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::721]:14149
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iAtHT-0006Uc-65; Thu, 19 Sep 2019 06:03:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lS6VPSu27PTaLBGv/KZO6Gnxds/P4iOoXA30j1j0Rp+zDU9HYjsQF2KT9ogkGc++6uvNIVSUQUiOdqSZtcZz4smcjDI0COXiho33Wl2gE/YhniBV95M13yUpuH5XoaX0VT3bmJAopWRSe5TTQJOF+ig5WyO73jUuNlZLANz4Ix5zY3vTpJmJqhEf3OKriGFnNGhtxS+Dj4PU2BsDlOLWSigTGsJSS5UwFlr/DjQw1icZ5KBk5OTLrUo5vp+LejHhWTXfDidgbzEKKiXs+tXT+SpptlHa1d4mMdXHZdANimYRFSPuSFx62mSYhLBpI+T97yA7ZEtg1EZIK1AROhnAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Is9Prz4X/E5bZFdQLg/rrhG9Er/aOtI6c2KJHdePFE=;
 b=Yyk439rQb8dTKfl9MBuvM8GwA2L3SJj9nE6FulCNjoQQwoNc6egXQMSdu+VP7PKqV0ERq+8PJJD5S0LHLrf721mAEtnDDzoNC+b8skl+OkRzhpzpgACGDyBN4qGJWSFKyOCLbbaMqLV4SxRZZiKFgYomyp0DCYmTjA+p812Z4ybnbabifsBpwinyMKh+7XT3LEYLUABJTa9z16QjKWmWuu6YOjVv1EDmHaAaBxEB90SL2Xy7ve2oXJ9sVksfIYAKnL8UDMRh9Ym98GSw/50VdkDvLGVnQ+KHEfNG6IzdATCQ189rDPd9L3EyC8nMExFyoejl16dsTxKqxZEtw2VUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Is9Prz4X/E5bZFdQLg/rrhG9Er/aOtI6c2KJHdePFE=;
 b=lmJiJR0l34YlFB0B+qy9CvSRcRx/MOK7WpWIO8gP5XoKpj77I5ts34Dh/OfYVru+R/syK5BRIIQ/NgAXHIizFDa9K8Yz2I3Tt/rBhojO397EyZYDroP1Whfkru/3jZvk5F58HOaggGJTdv5k9egnaCgutaGup+Qexdt7QqqX1aQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5257.eurprd08.prod.outlook.com (10.255.18.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 10:03:15 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 10:03:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [RFC] error: auto propagated local_err
Thread-Index: AQHVbiFyZhBrSsOpYEOTsgc7Le+SIKcytM4AgAAENQCAAAVFgIAACFkA
Date: Thu, 19 Sep 2019 10:03:15 +0000
Message-ID: <7aa85eb5-d765-d337-7f5d-09d7a981253f@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <d2a793c1-aae7-6e22-8baa-0c403c111e5c@redhat.com>
 <e0ba76d9-19cd-2894-b5d8-a19932e2d69d@virtuozzo.com>
 <9f41abd9-bef6-d7f1-0e52-df14a50cbe38@redhat.com>
In-Reply-To: <9f41abd9-bef6-d7f1-0e52-df14a50cbe38@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0066.eurprd09.prod.outlook.com
 (2603:10a6:3:45::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190919130312094
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 677f59f3-faba-4347-e7bb-08d73ce896d9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5257; 
x-ms-traffictypediagnostic: DB8PR08MB5257:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB5257AEA4D438067DEE434400C1890@DB8PR08MB5257.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(52314003)(53754006)(8676002)(229853002)(54906003)(446003)(76176011)(2501003)(52116002)(71200400001)(66946007)(2906002)(476003)(186003)(2616005)(305945005)(7736002)(31686004)(11346002)(561944003)(26005)(6486002)(25786009)(102836004)(6506007)(386003)(53546011)(8936002)(81166006)(966005)(7416002)(81156014)(14454004)(478600001)(486006)(99286004)(66556008)(7406005)(66476007)(316002)(86362001)(31696002)(3846002)(6246003)(4326008)(64756008)(71190400001)(66446008)(256004)(36756003)(6116002)(110136005)(5660300002)(66066001)(6306002)(6512007)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5257;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n9G7myy5F/rWBggexcZFNLoXX0QRIu9x5q4hGYXZxQt88VE6JXkLrrMpksuvGXqWpm/eBeayzxbMfXD9FSCHFeQrZ4fhpG9XFbHjq3si41Z0a0s4afpQ8ZgxS0UYsfJFljgYCLFerk5nuIYolbgDFhwjFaPumakFcZN6DDDMJjtVqmaPb/1hqfNvfzRzCe4trfgYkXXauck7HQR/i/GJKX83/RIMZaunh/e1tg76D21lRbqRuY5dfXtiy+LlXqtOWD2Mh3vaWMez8YXsUWP77YVjcGCf//HOkW0WORGZliSu7zzlfI2pLNBwGsz62tLuq9Xp/GMq2JMczidLXf3vKTFAPvFD4Njuh5d/Dkl/AU3i90IDe54XYc76NbMPupCfxv8fBGD0jE2xp7ByYtDTOmUqIDB/Wbt3u4lWC3qX+G8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C42384385CECAD46A211AD3157A43535@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f59f3-faba-4347-e7bb-08d73ce896d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 10:03:15.8237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rwk49mwOUuOA8ZeJXTJ9ZL2OIvwEolVyTEkdnb2sR6DH/p9V6YVFRrMzJotQasNGmNJ1UtpMEiyyy8KoA4WFW+9ejGGaHoLScssP4f2f/+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5257
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::721
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMDkuMjAxOSAxMjozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOS4wOS4xOSAxMToxNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE5LjA5LjIwMTkgMTE6NTks
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxOC4wOS4xOSAxNTowMiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gSGkgYWxsIQ0KPj4+Pg0KPj4+PiBIZXJlIGlzIGEg
cHJvcG9zYWwgKHRocmVlIG9mIHRoZW0sIGFjdHVhbGx5KSBvZiBhdXRvIHByb3BhZ2F0aW9uIGZv
cg0KPj4+PiBsb2NhbF9lcnIsIHRvIG5vdCBjYWxsIGVycm9yX3Byb3BhZ2F0ZSBvbiBldmVyeSBl
eGl0IHBvaW50LCB3aGVuIHdlDQo+Pj4+IGRlYWwgd2l0aCBsb2NhbF9lcnIuDQo+Pj4+DQo+Pj4+
IEl0IGFsc28gbWF5IGhlbHAgbWFrZSBHcmVnJ3Mgc2VyaWVzWzFdIGFib3V0IGVycm9yX2FwcGVu
ZF9oaW50IHNtYWxsZXIuDQo+Pj4+DQo+Pj4+IFNlZSBkZWZpbml0aW9ucyBhbmQgZXhhbXBsZXMg
YmVsb3cuDQo+Pj4+DQo+Pj4+IEknbSBjYy1pbmcgdG8gdGhpcyBSRkMgZXZlcnlvbmUgZnJvbSBz
ZXJpZXNbMV0gQ0MgbGlzdCwgYXMgaWYgd2UgbGlrZQ0KPj4+PiBpdCwgdGhlIGlkZWEgd2lsbCB0
b3VjaCBzYW1lIGNvZGUgKGFuZCBtYXkgYmUgbW9yZSkuDQo+Pj4+DQo+Pj4+IFsxXTogaHR0cHM6
Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDkvbXNnMDM0NDku
aHRtbA0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBpbmNsdWRl
L3FhcGkvZXJyb3IuaCB8IDEwMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+Pj4+ICAgIGJsb2NrLmMgICAgICAgICAgICAgIHwgIDYzICsrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tDQo+Pj4+ICAgIGJsb2NrL2JhY2t1cC5jICAgICAgIHwgICA4ICsrKy0NCj4+
Pj4gICAgYmxvY2svZ2x1c3Rlci5jICAgICAgfCAgIDcgKysrDQo+Pj4+ICAgIDQgZmlsZXMgY2hh
bmdlZCwgMTQ0IGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gSWYgdGhl
IGNvbWJpbmF0aW9uIG9mIOKAnGlmIChsb2NhbF9lcnIpIHsgZXJyb3JfcHJvcGFnYXRlKC4uLik7
IC4uLiB94oCdIGlzDQo+Pj4gd2hhdOKAmXMgY3VtYmVyc29tZSwgY2Fu4oCZdCB0aGlzIGJlIGRv
bmUgc2ltcGxlciBieSBhZGRpbmcgYW4NCj4+PiBlcnJvcl9wcm9wYWdhdGUoKSB2YXJpYW50IHdp
dGggYSByZXR1cm4gdmFsdWU/DQo+Pj4NCj4+PiBpLmUuDQo+Pj4NCj4+PiBib29sIGhhc19lcnJv
cl90aGVuX3Byb3BhZ2F0ZShFcnJvciAqKmVycnAsIEVycm9yICplcnIpDQo+Pj4gew0KPj4+ICAg
ICAgIGlmICghZXJyKSB7DQo+Pj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+PiAgICAgICB9
DQo+Pj4gICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQo+Pj4gICAgICAgcmV0dXJu
IHRydWU7DQo+Pj4gfQ0KPj4+DQo+Pj4gQW5kIHRoZW4gdHVybiBhbGwgaW5zdGFuY2VzIG9mDQo+
Pj4NCj4+PiBpZiAobG9jYWxfZXJyKSB7DQo+Pj4gICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAs
IGxvY2FsX2Vycik7DQo+Pj4gICAgICAgLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4gaW50bw0KPj4+DQo+
Pj4gaWYgKGhhc19lcnJvcl90aGVuX3Byb3BhZ2F0ZShlcnJwLCBsb2NhbF9lcnIpKSB7DQo+Pj4g
ICAgICAgLi4uDQo+Pj4gfQ0KPj4+DQo+Pj4gPw0KPj4+DQo+Pj4gTWF4DQo+Pj4NCj4+DQo+PiBO
bywgb3JpZ2luYWxseSBjdW1iZXJzb21lIGlzIGludHJvZHVjaW5nIGxvY2FsX2VyciBpbiBhIGxv
dCBvZiBuZXcgcGxhY2VzIGJ5DQo+PiBHcmVnJ3Mgc2VyaWVzLiBNQUtFX0VSUlBfU0FGRSBtYWNy
byBtYWtlcyBpdCBhcyBzaW1wbGUgYXMgb25lIG1hY3JvIGNhbGwNCj4+IGluc3RlYWQgKGluIGVh
Y2ggZnVuY3Rpb24gd2hlcmUgd2UgbmVlZCBsb2NhbF9lcnIpLg0KPiANCj4gRG9lcyBpdCBuZWVk
IG1vcmUgdGhhbiBvbmUgbG9jYWxfZXJyIHBlciBmdW5jdGlvbj8NCj4gDQo+IEJlY2F1c2UgaWYg
aXQgZGlkbuKAmXQsIEnigJlkIGZpbmQgb25lIOKAnEVycm9yICpsb2NhbF9lcnI74oCdIHNpbXBs
ZXIgdGhhbiBvbmUNCj4gbWFjcm8gaW5jYW50YXRpb24uDQo+IA0KPiAoSXQgaGFzIHRoZSBzYW1l
IExvQywgYW5kIGl0IG1ha2VzIGNvZGUgcmVhZGVycyBhc2sgdGhlIHNhbWUgcXVlc3Rpb246DQo+
IOKAnFdoeSBkbyB3ZSBuZWVkIGl0P+KAnSAgV2hpY2ggaGFzIHRoZSBzYW1lIGFuc3dlciBmb3Ig
Ym90aDsgYnV0IG9uZSBpcw0KPiBpbW1lZGlhdGVseSByZWFkYWJsZSBjb2RlLCB3aGVyZWFzIHRo
ZSBvdGhlciBpcyBhIG1hY3JvLikNCg0KTm90IHRoZSBzYW1lLCB5b3UgZGlkbid0IGNvdW50IGVy
cm9yX3Byb3BhZ2F0ZQ0KDQpBbmQgeW91ciBleGFtcGxlIGRvbid0IG1hdGNoIEdyZWcncyBjYXNl
LCB0aGVyZSBubyAiaWYgKGxvY2FsX2VycikiIGluIGl0LA0KanVzdCAiZXJyb3JfYXBwZW5kX2hp
bnQoZXJycCkiLCB3aGljaCBkb24ndCB3b3JrIGZvciBlcnJvcl9mYXRhbCBhbmQgZXJyb3JfYWJv
cnQNCihZZXMsIEkgYWdyZWUgd2l0aCBLZXZpbiwgdGhhdCBpdCBzaG91bGQgd29yayBvbmx5IGZv
ciBlcnJvcl9mYXRhbCkNCg0KPiANCj4+IEFsc28sIGF1dG8tcHJvcGFnYXRpb24gc2VlbXMgY29y
cmVjdCB0aGluZyB0byBkbywgd2hpY2ggZml0cyBnb29kIGludG8NCj4+IGdfYXV0byBjb25jZXB0
LCBzbyBldmVuIHdpdGhvdXQgYW55IG1hY3JvIGl0IGp1c3QgYWxsb3dzIHRvIGRyb3Agc2V2ZXJh
bCBlcnJvcl9wcm9wYWdhdGUNCj4+IGNhbGxzIChvciBtYXkgYmUgc2V2ZXJhbCBnb3RvIHN0YXRl
bWVudHMgdG8gZG8gb25lIGVycm9yX3Byb3BhZ2F0ZSBjYWxsKSBpbnRvDQo+PiBvbmUgZGVmaW5p
dGlvbnMuIEl0J3MgdGhlIHNhbWUgc3RvcnkgbGlrZSB3aXRoIGdfYXV0b2ZyZWUgdnMgZ19mcmVl
Lg0KPiANCj4gSSBkb27igJl0IHNlZSB0aGUgYWR2YW50YWdlIGhlcmUuICBZb3UgaGF2ZSB0byBk
byB0aGUgaWYgKCkgc3RhdGVtZW50DQo+IGFueXdheSwgc28gaXQgaXNu4oCZdCBsaWtlIHlvdeKA
mXJlIHNhdmluZyBhbnkgTG9DLiAgSW4gYWRkaXRpb24sIEkNCj4gcGVyc29uYWxseSBkb27igJl0
IGZpbmQgY29kZSBoaWRkZW4gdGhyb3VnaCBfX2F0dHJpYnV0ZV9fKChjbGVhbnVwKSkNCj4gZWFz
aWVyIHRvIHVuZGVyc3RhbmQgdGhhbiBleHBsaWNpdGx5IHdyaXR0ZW4gY29kZS4NCj4gDQo+IEl0
IGlzbuKAmXQgbGlrZSBJIGRvbuKAmXQgbGlrZSBfX2F0dHJpYnV0ZV9fKChjbGVhbnVwKSkuICBC
dXQgaXQgZG9lcyBjb3VudA0KPiB1bmRlciDigJxtYWdpY+KAnSBpbiBteSBib29rLCBhbmQgdGh1
cyBJ4oCZZCBhdm9pZCBpdCBpZiBpdCBkb2VzbuKAmXQgYnJpbmcNCj4gYWN0dWFsIGFkdmFudGFn
ZXMuICAoSXQgZG9lcyBicmluZyBhY3R1YWwgYWR2YW50YWdlcyBmb3IgdGhpbmdzIGxpa2UNCj4g
YXV0by1mcmVlaW5nIG1lbW9yeSwgYXV0by1jbG9zaW5nIEZEcywgb3IgemVyb2luZyBzZWNyZXQg
YnVmZmVycyBiZWZvcmUNCj4gZnJlZWluZyB0aGVtLiAgSW4gYWxsIHRob3NlIGNhc2VzLCB5b3Ug
c2F2ZSBMb0MsIGFuZCB5b3UgcHJldmVudA0KPiBhY2NpZGVudGFsIGxlYWthZ2UuICBJIGRvbuKA
mXQgcXVpdGUgc2VlIHN1Y2ggYWR2YW50YWdlcyBoZXJlLCBidXQgSSBtYXkNCj4gd2VsbCBiZSBt
aXN0YWtlbi4pDQo+IA0KPiANCj4gTm93IEtldmluIGhhcyBnaXZlbiBhbiBhY3R1YWwgYWR2YW50
YWdlLCB3aGljaCBpcyB0aGF0IGxvY2FsX2Vycg0KPiBjb21wbGljYXRlcyBkZWJ1Z2dpbmcuICBJ
4oCZdmUgbmV2ZXIgaGFkIHRoYXQgcHJvYmxlbSBteXNlbGYsIGJ1dCB0aGF0DQo+IHdvdWxkIGlu
ZGVlZCBiZSBhbiBhZHZhbnRhZ2UgdGhhdCBtYXkgd2FycmFudCBzb21lIG1hZ2ljLg0KPiANCj4g
TWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


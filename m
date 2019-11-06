Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5322C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 07:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611EE206A3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 07:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oJ3au8tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611EE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSG2x-0002TG-HC
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 02:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iSG1X-0001iX-TR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 02:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iSG1W-0003db-On
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 02:46:39 -0500
Received: from mail-eopbgr50117.outbound.protection.outlook.com
 ([40.107.5.117]:27780 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iSG1S-0003UR-Kd; Wed, 06 Nov 2019 02:46:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0HVZ/k6XoILlxFFoso51RHZY68KyIOLYxniNe7aeZqJDHk/vfawj3ZyntuV1xB0ePP0+Q8/KZ+hry4ZjuyhjqXJw5Cm0+K1ONcRc47yHSftUMNysyEPj1QPMYggoYij4wd922NbVrKvnZgONb8nwjQ+gEsYiFonk/nrNvh5//qWR873FfYYAR1Y95wMadxU8vzkrOO32PTw04pv/4nCYxfMB4eIc7mk0WS3M1EHqIZNBuhNjDifrdNC/sPjP8JLuFA6G4ykKX1TWJiCa6GLFNUZgUXEd6O1Nj+Fk6JQNdK+27TwFnMG3pVEeHMqqBJQIwrIBZmdvmA3sFRxa8I4pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJrqqmeFy6B6xyfmtF7CBW3eYKmgKsaWhqBE+k7R2dY=;
 b=iaEBOsjShMAwljj4+6OwQmD0UnYjhnOFn7FKAJ460ueiYAy6bF71o8WoW0aJzc0bMXDPMKDQs8vsRLbcWwh83XJM+IaD86VKyWJ1UbB30s6FlGVte8BqSd+yEsOudfVO7kdrHhnVW3XFS289vOIpWxfcyX7zwsK8+ZGTb8qf2dKrS9rL8HiLf+67uc9rsQR0jYGjkOIHpi768l8hWyKOewQYnXkhnqMFAuWW9ROHmo2maYjZj3PN5onR0VfY6yyU6Rs991Sq98Je2kR5ZzDLklB9FmB5doJpTUMFRmCnMIm0Ep6gFZRrJbSMFEkR6OZu13Cp0hK5OYncQoT454BCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJrqqmeFy6B6xyfmtF7CBW3eYKmgKsaWhqBE+k7R2dY=;
 b=oJ3au8tOYY9Nvni5DMTY3iEEcbK+3vJ3YSdRrei9y2qfmKxuwfTCTqRhYJRPgfQcyEcqH0jFf66HQcahJfSPx5xvWJ35Kt9z3EFikExYSpmH6YgoQjuaEYZhp8K5qyyakDwHZSySMjUFvvyYr0w1yhV/k5CnirqcG5ZqnBEVDP4=
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.14.92) by
 VI1PR08MB3823.eurprd08.prod.outlook.com (20.178.15.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 07:46:31 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::bcf3:d603:4fb4:162c]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::bcf3:d603:4fb4:162c%6]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 07:46:31 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Thread-Topic: [PATCH v1 1/4] virtio: protect non-modern devices from too big
 virtqueue size setting
Thread-Index: AQHVk/PHh+k1fPVRykKguorzXMLTwqd9DyaAgAC1igA=
Date: Wed, 6 Nov 2019 07:46:31 +0000
Message-ID: <c14296e6-0557-d643-722a-531e3c2f01de@virtuozzo.com>
References: <20191105161105.19016-1-dplotnikov@virtuozzo.com>
 <20191105161105.19016-2-dplotnikov@virtuozzo.com>
 <20191105155357-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191105155357-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0293.eurprd05.prod.outlook.com
 (2603:10a6:7:93::24) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:b9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [178.34.151.79]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d67e4b3-48be-4a05-917f-08d7628d7062
x-ms-traffictypediagnostic: VI1PR08MB3823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB38230C61FC3739F07A7E97C7CF790@VI1PR08MB3823.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(366004)(396003)(39850400004)(136003)(376002)(189003)(199004)(7736002)(305945005)(2906002)(31696002)(256004)(14444005)(36756003)(66476007)(66556008)(64756008)(66446008)(66946007)(6436002)(54906003)(478600001)(229853002)(99286004)(14454004)(66066001)(6116002)(31686004)(3846002)(6486002)(316002)(6512007)(26005)(11346002)(6916009)(186003)(2616005)(476003)(446003)(81166006)(4326008)(8676002)(81156014)(102836004)(486006)(76176011)(86362001)(71200400001)(71190400001)(5660300002)(6506007)(6246003)(25786009)(52116002)(8936002)(386003)(53546011)(107886003)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3823;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUm2aQOlm0u6sYjR7pQ8mNFg/GvFwLZtAJQieQqEItWz8CUdLRk9+Tz+Zj1mCuD8Cgp0q5aZnfc74G3hi3w8VF1PSei6kxOvMBtD0WnjPY1F6FOG24N8Dg1xqlQv6u2YkEUIDDulLgLZmP9rmQZ3ZyZCJxw3ALi5P/gXzvgZiiKQC1p3Hoh50yA3HIzQ1scN6r7azVZtr6sSUi6rIr13phUeNQ9j6aXUv4cOfryuItgCkqOc0W7KRX6QTROQ7iqpDWRNlQZ/pMc21CzyQXv8Syyl8l+d0CG7SvN1v+OIlsSgeMm9vVzFLf5LdtT2k2EYRCsumKcYbAHM2SOARNnYkdtIyJYINVofIGQwKnsP7foYO1JhQaaac4yrDXHEStlRWCnqNolA8RC+qcRLWQ6bfqJADeC/0K+8mttWBTW5rZ3edd3CFu6PXs7L6GyswXTq
Content-Type: text/plain; charset="utf-8"
Content-ID: <958920DDDFCE034CBFCA0D74A4C8A711@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d67e4b3-48be-4a05-917f-08d7628d7062
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 07:46:31.3492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +BZDG2fsecGdYR2CRyqBWKrYwa4p2iYiz2iUkmbc8GHpFTU2vgH3rgmIaDh8Tf5IlWHWwdNmwsanUqQjZn18kdG9wldRXYOpC1LBNpz99mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3823
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.117
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
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAwNS4xMS4yMDE5IDIzOjU2LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+IE9uIFR1
ZSwgTm92IDA1LCAyMDE5IGF0IDA3OjExOjAyUE0gKzAzMDAsIERlbmlzIFBsb3RuaWtvdiB3cm90
ZToNCj4+IFRoZSBwYXRjaCBwcm90ZWN0cyBmcm9tIGNyZWF0aW5nIGlsbGVnYWwgdmlydGlvIGRl
dmljZSBjb25maWd1cmF0aW9uDQo+PiB2aWEgZGlyZWN0IHZpcnRxdWV1ZSBzaXplIHByb3BlcnR5
IHNldHRpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5p
a292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmlydGlvL3ZpcnRpby1ibGstcGNp
LmMgIHwgIDkgKysrKysrKysrDQo+PiAgIGh3L3ZpcnRpby92aXJ0aW8tc2NzaS1wY2kuYyB8IDEw
ICsrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0aW8tYmxrLXBjaS5jIGIvaHcvdmlydGlvL3Zp
cnRpby1ibGstcGNpLmMNCj4+IGluZGV4IDYwYzkxODVjMzkuLjYxNzdmZjFkZjggMTAwNjQ0DQo+
PiAtLS0gYS9ody92aXJ0aW8vdmlydGlvLWJsay1wY2kuYw0KPj4gKysrIGIvaHcvdmlydGlvL3Zp
cnRpby1ibGstcGNpLmMNCj4+IEBAIC00OCw2ICs0OCwxNSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9f
YmxrX3BjaV9yZWFsaXplKFZpcnRJT1BDSVByb3h5ICp2cGNpX2RldiwgRXJyb3IgKiplcnJwKQ0K
Pj4gICB7DQo+PiAgICAgICBWaXJ0SU9CbGtQQ0kgKmRldiA9IFZJUlRJT19CTEtfUENJKHZwY2lf
ZGV2KTsNCj4+ICAgICAgIERldmljZVN0YXRlICp2ZGV2ID0gREVWSUNFKCZkZXYtPnZkZXYpOw0K
Pj4gKyAgICBib29sIG1vZGVybiA9IHZpcnRpb19wY2lfbW9kZXJuKHZwY2lfZGV2KTsNCj4+ICsg
ICAgdWludDMyX3QgcXVldWVfc2l6ZSA9IGRldi0+dmRldi5jb25mLnF1ZXVlX3NpemU7DQo+PiAr
DQo+PiArICAgIGlmICghbW9kZXJuICYmIHF1ZXVlX3NpemUgPiAxMjgpIHsNCj4+ICsgICAgICAg
IGVycm9yX3NldGcoZXJycCwNCj4+ICsgICAgICAgICAgICAgICAgICAgInRvbyBiaWcgcXVldWUg
c2l6ZSAoJXUsIG1heDogMTI4KSAiDQo+PiArICAgICAgICAgICAgICAgICAgICJmb3Igbm9uLW1v
ZGVybiB2aXJ0aW8gZGV2aWNlIiwgcXVldWVfc2l6ZSk7DQo+PiArICAgICAgICByZXR1cm47DQo+
PiArICAgIH0NCj4NCj4gdGhpcyBlbmFibGVzIGZvciB0cmFuc2l0aW9uYWwgc28gc3RpbGwgdmlz
aWJsZSB0byBsZWdhY3kNCj4gaW50ZXJmYWNlLiBJIGFtIGd1ZXNzaW5nIHlvdSB3YW50IHRvIGNo
ZWNrIHdoZXRoZXINCj4gZGV2aWNlIGlzIGFjY2Vzc2VkIHRocm91Z2ggdGhlIG1vZGVybiBpbnRl
cmZhY2UgaW5zdGVhZC4NCg0KTXkgZ29hbCBpcyB0byBub3QgYnJlYWsgc29tZXRoaW5nIHdoZW4g
SSdtIHNldHRpbmcgdGhlIHF1ZXVlIHNpemUgPiAxMjggDQoodGFraW5nIGludG8gYWNjb3VudCB0
aGUgY3VycmVudCBzZWFiaW9zIHF1ZXVlIHNpemUgcmVzdHJpY3Rpb24gdG8gMTI4KS4gDQpJJ20g
bm90IHF1aXRlIHN1cmUgd2hhdCB0byBjaGVjay4gQ291bGQgSSBhc2sgd2h5IG9uZSB3YW50IHRv
IHRoZSBjaGVjayANCndoZXRoZXIgYWNjZXNzaW5nIHRocm91Z2ggdGhlIG1vZGVybiBpbnRlcmZh
Y2UgYW5kIGhvdyBpdCBjb3VsZCBiZSBjaGVja2VkPw0KDQpUaGFua3MhDQoNCkRlbmlzDQoNCj4+
ICAgICAgIGlmICh2cGNpX2Rldi0+bnZlY3RvcnMgPT0gREVWX05WRUNUT1JTX1VOU1BFQ0lGSUVE
KSB7DQo+PiAgICAgICAgICAgdnBjaV9kZXYtPm52ZWN0b3JzID0gZGV2LT52ZGV2LmNvbmYubnVt
X3F1ZXVlcyArIDE7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5j
IGIvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5jDQo+PiBpbmRleCAyODMwODQ5NzI5Li42ZTY3
OTBmZGE1IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1zY3NpLXBjaS5jDQo+PiAr
KysgYi9ody92aXJ0aW8vdmlydGlvLXNjc2ktcGNpLmMNCj4+IEBAIC0xNyw2ICsxNyw3IEBADQo+
PiAgIA0KPj4gICAjaW5jbHVkZSAiaHcvdmlydGlvL3ZpcnRpby1zY3NpLmgiDQo+PiAgICNpbmNs
dWRlICJ2aXJ0aW8tcGNpLmgiDQo+PiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+ICAgDQo+
PiAgIHR5cGVkZWYgc3RydWN0IFZpcnRJT1NDU0lQQ0kgVmlydElPU0NTSVBDSTsNCj4+ICAgDQo+
PiBAQCAtNDcsNiArNDgsMTUgQEAgc3RhdGljIHZvaWQgdmlydGlvX3Njc2lfcGNpX3JlYWxpemUo
VmlydElPUENJUHJveHkgKnZwY2lfZGV2LCBFcnJvciAqKmVycnApDQo+PiAgICAgICBWaXJ0SU9T
Q1NJQ29tbW9uICp2cyA9IFZJUlRJT19TQ1NJX0NPTU1PTih2ZGV2KTsNCj4+ICAgICAgIERldmlj
ZVN0YXRlICpwcm94eSA9IERFVklDRSh2cGNpX2Rldik7DQo+PiAgICAgICBjaGFyICpidXNfbmFt
ZTsNCj4+ICsgICAgYm9vbCBtb2Rlcm4gPSB2aXJ0aW9fcGNpX21vZGVybih2cGNpX2Rldik7DQo+
PiArICAgIHVpbnQzMl90IHZpcnRxdWV1ZV9zaXplID0gdnMtPmNvbmYudmlydHF1ZXVlX3NpemU7
DQo+PiArDQo+PiArICAgIGlmICghbW9kZXJuICYmIHZpcnRxdWV1ZV9zaXplID4gMTI4KSB7DQo+
PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+PiArICAgICAgICAgICAgICAgICAgICJ0b28g
YmlnIHZpcnRxdWV1ZSBzaXplICgldSwgbWF4OiAxMjgpICINCj4+ICsgICAgICAgICAgICAgICAg
ICAgImZvciBub24tbW9kZXJuIHZpcnRpbyBkZXZpY2UiLCB2aXJ0cXVldWVfc2l6ZSk7DQo+PiAr
ICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4gd2h5PyB3aGF0IGlzIGlsbGVnYWwgYWJvdXQg
MjU2IGZvciBsZWdhY3k/DQo+DQo+PiAgIA0KPj4gICAgICAgaWYgKHZwY2lfZGV2LT5udmVjdG9y
cyA9PSBERVZfTlZFQ1RPUlNfVU5TUEVDSUZJRUQpIHsNCj4+ICAgICAgICAgICB2cGNpX2Rldi0+
bnZlY3RvcnMgPSB2cy0+Y29uZi5udW1fcXVldWVzICsgMzsNCj4+IC0tIA0KPj4gMi4xNy4wDQo=


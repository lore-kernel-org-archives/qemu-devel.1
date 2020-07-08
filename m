Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9183FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C93820772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZhXrhSs0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="c5x9H16V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C93820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtISv-0003vK-IG
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtHuY-0004gb-Bg; Wed, 08 Jul 2020 17:47:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45148fd95=Dmitry.Fomichev@wdc.com>)
 id 1jtHuS-0004c9-UB; Wed, 08 Jul 2020 17:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594244841; x=1625780841;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+ehc2wqhXqTZ2yaUCPDeuXCXwCGUtxTBW8zDSEu0eXM=;
 b=ZhXrhSs07Sda6tY9Lw87FWUGehb1IU3Gx8hZuIgeJMhyfdPWeV2F9XNC
 bwHlZhXS8ZEfmyGOJxzzvrq8fyJXLE+VEF8QApQ2LwHnVEdVUqFFonYtq
 OlZyBdXNdoswdyyrLjNXcX4VqH06HzSHzecLt+BWAX/cy/B/b7QEJNrXj
 wYE9+ih6271nH7qvapVoVvXZxfbmhZaSJ6VlE7JB14ahsHgJMT0Ds0xOL
 EV+9J26BsGEZJ4x+y3MorObmSqpPywbFCl3k8iba0E3I6UP8ZBvab07a0
 yX8tX0wSDu6I8OvOcudpdfBO+6KaIFK5D0/kTNDcvamYocKhaRPHAIcsU Q==;
IronPort-SDR: YklcA9ld5xTaGePypMwkgfx/8Wnn6cwFg/P1HA+R7b6zSQ2xuZnEtuCaG6xBjDPsHG+p9QRNTr
 2X03UBb6DuYKFXp6kqCR4naIu8O5mO0JCty2Bq41fOLLtQ6fDZzfXF/uBgE5QHEcKlYNrXlkYC
 YByAlKzvTzDWXNvNgoMWgiyA4KbUv65Bn82mH3WpXMqEI6cELekPAP112S7kYnuYVYzJwV/1WB
 gJRteXI7EJ7DJyDNsdxZPpauX2fT784m2z6S1xpM+iiv8i+PuO7T1HHPxNUKRWrGu50dhPRNOd
 2wY=
X-IronPort-AV: E=Sophos;i="5.75,329,1589212800"; d="scan'208";a="143290038"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2020 05:47:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnV0Sq53JSTRhFMRlMGCMwDcAIINxaF1XZdw7eNVNrhHjfZd8R++4o3QdmgUJ2AxoV4sRmUK5JScy+kfGXBmvcXXEu9cBKDhEPqNV8BbWt5Bjj01QUYVjBx5B60gYuaq15dOyAvRYp6SZYxH1w26YxRdzSopzva1GVsjVQqXCzhJbNuvX3uc5KTOBkn6Yi1ghgnzFCB2UzjfFpniQgrJyUOKvUlooE1eoRobs8ZR4wpZ6tSppF4idZm+ciQKJVDzfozAix0AyS8ARY8VZQWXKDKX+HaGIQTEXoz5w/0tQarzi3Jy4o7REYnktExuYigq4YEBtZcq1E/nlDGrX/fjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ehc2wqhXqTZ2yaUCPDeuXCXwCGUtxTBW8zDSEu0eXM=;
 b=CWLyLBY7moU39oHILZDspGIBsmK8Q37iMFpIW8+QTQh1yBEKLWLC7/Zr8E6LeQo69KzEKSaKkmuYdZKE+3kl/ftXUhrpHC1gq8onI3bnXNp0LhexJytTtw8wftcjp17DGk3UvnahMItf5NTC8vLmP4VYl51FhbNO9DXlup8BXFzFlJwPDVfkqY7B3d6YE2dME8BI5BtiV9GFXTNgZUCjJwwdwkbvKZ2l1Q0aSZhMlbPWPvVr0C5nQvJeFsMP0FkvJy3nhe8Ifup3oRko6TiLyRQo9BrFZfHNGP06W5GzJCapMUY31IhKJB9lyvzN2d07icji+ldtldMzciGARdPNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ehc2wqhXqTZ2yaUCPDeuXCXwCGUtxTBW8zDSEu0eXM=;
 b=c5x9H16VRKSt1r+BISuhef7dKurFiMnyUfKAmh5Lgv6yaU9z6jjGDQqSLwsH6DspshjUJTpUnRRxOmg/5vgBSC9nvlqXiHq5P6vnmSYQfJNGRTGOyxj3dVCNhqjWaQgz0GhjIOLgrTazgGRF42Bl0dVy1JojF7Gt32gYogjnP/U=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5743.namprd04.prod.outlook.com (2603:10b6:208:38::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 8 Jul
 2020 21:47:13 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 21:47:13 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 01/18] hw/block/nvme: bump spec data structures to v1.3
Thread-Topic: [PATCH v3 01/18] hw/block/nvme: bump spec data structures to v1.3
Thread-Index: AQHWU1yMuYc/KnhFe0OWqQA0G0PhQqj+EpGAgAAi6wCAAAQjQA==
Date: Wed, 8 Jul 2020 21:47:12 +0000
Message-ID: <MN2PR04MB59518B3ACCDC857E87D0417DE1670@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-2-its@irrelevant.dk>
 <222a814fdd8a6ca878e04b30d64015ed629bac68.camel@wdc.com>
 <20200708212404.GA1018121@apples.localdomain>
In-Reply-To: <20200708212404.GA1018121@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f463fa89-03c1-4232-94fb-08d82388794c
x-ms-traffictypediagnostic: MN2PR04MB5743:
x-microsoft-antispam-prvs: <MN2PR04MB574333B6FA1AE629659B545CE1670@MN2PR04MB5743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04583CED1A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0KEdNxJbxvW6iQu+bpUgs7RIIW4J7kqnWD/CzXbSIpxYWQwdvAws+XBuKePFe4Mg/RK5vFSuIZH3rtZZaq9npiYTSpbRo4E6Zj+7IJRbgbHkUcEB1IAIjw5ZC68h9ykmZCm47wyO7659KkSAYupSzuPjqBNjttrFYj0KkchoraxMHxa93xb3mA25rByfbrUP1sGgrk2h2U4KIEhcj4yD1/5+N1NzHyJyVZc56VYC3M42h5QwGSB9P52u/GnzeRQbEkpa/4K0+WmToCXmzPmu2ubMCymG/KDm/togj45sVXlRoqqZxv2xD6Lm/P7wCtWFmzibNF98pFMiDFhCt7gsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(71200400001)(478600001)(316002)(86362001)(54906003)(53546011)(6506007)(7696005)(7416002)(66556008)(66446008)(55016002)(76116006)(66476007)(64756008)(66946007)(83380400001)(9686003)(5660300002)(6916009)(8676002)(2906002)(33656002)(52536014)(8936002)(26005)(4326008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: m9xxJcwU3UzvzXB2F2RG/OIRZAYO8lJ120p1H9eMUJ8VHIvtuXsGIFGM4QrMyXIBpsUMgPQKDlAogRBspNv9km2oJ94555B8b1prLAqd5JgFSPwqDJJUXmfZw0dFAJcVeFlNaZBodQHSsVyR4L7k/ZDXW8f1IxW6B4uU3Ax+oZb1uE2gQPKOLUwMxQyHKgrf+tXrI9dasXhw6qtGUnjSNrPH2/LnYC/nwBG/he1xFbO7xuvSWeyLQjROYT3717tHWQuuWCXS4hPZmK6W9lFo1+u/IIsnCFndVUZKlyB0jUZZ5pd3nXij21v/3k1cV97G5HMomKdkHZI8QeR4G3MUPdKEn2pX5Qntxz5/cWF2Q/qw9rol7RESWBokLD4zF33zeWgkbL7Sxxqbj6j+GzomG+dl0w6ld92Os+rOusEX0VgGK/s6og1N5tOHh3jbJmnLWO6FVaD++SsOlW8L7RY/NUsqEfzt5ieoqWOhS0EdqUUpiOeJYZqWekE9WNxc5fHj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f463fa89-03c1-4232-94fb-08d82388794c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 21:47:12.8742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wV2U831PJ2k2YN0Tr/X25hOShb4jk4wHNydjiVJU/LOw92qEdnk9uneBY/YY7yJRta6+2ErVbaERNheLkEAjuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5743
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=45148fd95=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 17:47:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtsYXVzIEplbnNlbiA8aXRz
QGlycmVsZXZhbnQuZGs+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSA4LCAyMDIwIDU6MjQgUE0N
Cj4gVG86IERtaXRyeSBGb21pY2hldiA8RG1pdHJ5LkZvbWljaGV2QHdkYy5jb20+DQo+IENjOiBx
ZW11LWJsb2NrQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgZmFtQGV1cGhvbi5u
ZXQ7DQo+IGphdmllci5nb256QHNhbXN1bmcuY29tOyBrd29sZkByZWRoYXQuY29tOyBtcmVpdHpA
cmVkaGF0LmNvbTsNCj4gbWxldml0c2tAcmVkaGF0LmNvbTsgcGhpbG1kQHJlZGhhdC5jb207IGti
dXNjaEBrZXJuZWwub3JnOw0KPiBrLmplbnNlbkBzYW1zdW5nLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDAxLzE4XSBody9ibG9jay9udm1lOiBidW1wIHNwZWMgZGF0YSBzdHJ1Y3R1cmVz
IHRvDQo+IHYxLjMNCj4gDQo+IE9uIEp1bCAgOCAxOToxOSwgRG1pdHJ5IEZvbWljaGV2IHdyb3Rl
Og0KPiA+IExvb2tzIGdvb2Qgd2l0aCBhIHNtYWxsIG5pdCAoc2VlIGJlbG93KSwNCj4gPg0KPiA+
IFJldmlld2VkLWJ5OiBEbWl0cnkgRm9taWNoZXYgPGRtaXRyeS5mb21pY2hldkB3ZGMuY29tPg0K
PiA+DQo+ID4gPg0KPiA+IE9uIE1vbiwgMjAyMC0wNy0wNiBhdCAwODoxMiArMDIwMCwgS2xhdXMg
SmVuc2VuIHdyb3RlOg0KPiA+ID4gKyNkZWZpbmUgTlZNRV9URU1QX1RNUFRIKHRlbXApICgodGVt
cCA+PiAgMCkgJiAweGZmZmYpDQo+ID4NCj4gPiBUaGVyZSBpcyBhbiBleHRyYSBzcGFjZSBhZnRl
ciB0ZW1wID4+DQo+ID4NCj4gDQo+IEdvb2QgY2F0Y2ghIEkgd29uJ3QgcmVwb3N0IGZvciB0aGlz
IDspIC0gYnV0IEknbGwgZml4IGl0IGFuZCBhZGQgaXQgaW4NCj4gdGhlIHFlbXUtbnZtZSB0cmVl
Lg0KDQpZZXMsIG5vIG5lZWQgdG8gcmVwb3N0IDopIFRoYW5rcyBmb3IgcmV2aWV3aW5nIG91ciBa
TlMgc2VyaWVzISBJIGFtIHdvcmtpbmcNCm9uIGFkZHJlc3NpbmcgeW91ciBjb21tZW50cyBhbmQg
SSBhbSBhbHNvIHN0YXJ0aW5nIHRvIHJldmlldyB5b3VyDQoiQUlPIGFuZCBhZGRyZXNzIG1hcHBp
bmcgcmVmYWN0b3JpbmciIHBhdGNoc2V0Lg0KDQpDaGVlcnMsDQpEbWl0cnkNCg==


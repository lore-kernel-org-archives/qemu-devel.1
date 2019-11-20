Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA0C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC752251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vp3iX/eK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="O3Wkga2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC752251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPWl-0007wm-1N
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXPVF-00076K-4S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXPVE-0006yc-2W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:54:37 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXPVD-0006yT-Q3
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574254475; x=1605790475;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6noMrcov9MsLOjM2+cOVaSuwbbNeOA+hDIHZXKTPZNg=;
 b=Vp3iX/eKJD69pr8dsiLYhNXcxOB/y/2NqSJt2ndnh4rhJMpk7mrBJQzj
 qC9qQclG5mtR+OJQOwLWtoPi26kQmyINqX6Ikpd2mPe5Bbc+G143Y33Hm
 GZaGBwgisig2V8X2G96nsugPSjAfD6I2cbIgs+0imQ0uhXGdspz/zn2f7 c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Nov 2019 04:54:34 -0800
IronPort-SDR: iCjogq1phX7iGdmmRaDZTCsDaX3To4MGZAeGHJtgll1wo9uVpoGP4mGqvLCdQIDZSXmXx4GMQe
 298akTMeTZ2WijcEOw5ViCDp27B8gAc2E+5VVk+kpYoC6pB6MwQCQacmgA4JYgoGfdYsYHBK6G
 8qWV8HndR98g8p2X3f3EmFfGBOBCtf/+OYB5GQ4Xr1pGnvkc/u15O7XcIZrpUgREmvZS1WB4so
 UJ13M+/MANY7Hl7F8Izus7/pIVVtchmqGeETxX3DjvVXMXztTQhvIraKMpT+gSNVkOCrvRcoj9
 aREzAtI01Ei5OYbccpphAOrI
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Nov 2019 04:54:34 -0800
Received: from eusanexr01e.eu.qualcomm.com (10.85.0.100) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 04:54:34 -0800
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 eusanexr01e.eu.qualcomm.com (10.85.0.100) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 04:54:32 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 20 Nov 2019 04:54:32 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5109.namprd02.prod.outlook.com (20.177.125.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:54:31 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 12:54:31 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>
Subject: RE: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Thread-Topic: [PATCH] Hexagon: Swap SIGRGMAX-1 and SIGRTMIN+1
Thread-Index: AQHVnwx8rLIAH0kQNkKw9TSsm/yDb6eS4ccAgADT6ICAACuUgIAAAmWAgAABswCAAB8SUA==
Date: Wed, 20 Nov 2019 12:54:31 +0000
Message-ID: <BYAPR02MB488642577188C95697E72DC3DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574190388-12605-1-git-send-email-tsimpson@quicinc.com>
 <CAFEAcA8AeTgY+3GaN9ZUi-5XtX5jxhqpdOhr3ixYwouWhQOQ5g@mail.gmail.com>
 <e4a52719-fc16-f94a-fb8d-1a4d9e683ce0@vivier.eu>
 <CAFEAcA-tVh9AMucDL4hgQ3ngFZwu4AThcGyhwjVa-LbG8o8-Lg@mail.gmail.com>
 <05b5c1b4-d1dd-7b82-cdf3-a1425edae499@vivier.eu>
 <CAFEAcA-mUps0qe9Ak6VjceZBAe=x9cQ3YPhhT9Qmg-c_XpqcDQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-mUps0qe9Ak6VjceZBAe=x9cQ3YPhhT9Qmg-c_XpqcDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [2605:6000:ee9b:a300:81a3:9afc:12b:5482]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 580c4830-6100-43de-3dd1-08d76db8c92c
x-ms-traffictypediagnostic: BYAPR02MB5109:
x-microsoft-antispam-prvs: <BYAPR02MB51093EBBACCFF2D4D84C4F9BDE4F0@BYAPR02MB5109.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(376002)(346002)(366004)(39860400002)(396003)(136003)(13464003)(189003)(199004)(7696005)(55016002)(66476007)(66556008)(64756008)(6436002)(486006)(46003)(478600001)(14454004)(66446008)(66946007)(76116006)(25786009)(9686003)(81156014)(2906002)(476003)(11346002)(256004)(6116002)(186003)(8676002)(5660300002)(81166006)(86362001)(305945005)(6246003)(102836004)(316002)(71200400001)(71190400001)(110136005)(54906003)(33656002)(7736002)(229853002)(4326008)(446003)(52536014)(8936002)(76176011)(74316002)(6506007)(99286004)(53546011)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5109;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goo734ZsvDAs/cOCGkselZ5SRNMIpLnGB3NIAgWUY4lpLfGobn+MaECf/8y6hIzNMrgdyvJEI5MOsoeGGkmtKTDy2//g0hRB/Nwzj+dmWIpPDRoqrH3PUZjLm3VrwJ82huugWIXdgGCCiBv5JvCNeLdFvdKOW3jY3iLor0VIrk5vus+JE2WNh2RcrZSy+QHP31SNvrPXQfTP8IsPMjKo5AmeTtI5wmiR+Cj1Gv4tdlUp1OohVivpeVuuokVjzkfXFvm/0DMIpdZI6/LfGYnN3QjEqlR61zypBFqE9676/bar0vZNzzB/7QpjwzPBWqDk/lOrbLdkayNwwLguPgmyd9W/gIaSvhZaKiKCl/YdCsSDEIfLj/gO+8GPBV5Q4nRk55j31Bfkkl3G63Vnad0T87xtHI2IfFLx3KgIkR4elVOEemX2w09kyKh2ZdQxF7rz
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXf44nAX3ChlF16TCcx+Qgwa+PHPEkXsIYr7taWWevCmUaQP/20uoolUs8pARJVPFeYpeG9ZtJ63+AESyt0locQRmZiaWiNIsotWglug4zyqgkBHIHH5a4D7RWqjviP5klu5KLFmEfufRmEnfghLqtOOEdvgwRTTEtjKkZ14LfZp58p7gNjwzXU7w1sxvOb7UCXegdtpfiml31WAecHICawpV1/fgo3JKxjG+hu2EkkjbT+qZznRvNS4PxQAjSLkcwQZAjT8vgRQIhwU88a2V4MznuQB6BvMcAenPGxuI1onej/uafdXAfzgTofUEf1aif5hrZTSjvldhJIX9+uuJg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HevPGC44yEDyL6mGh9vB077VcqfnnkJvPZnVQVlQIw=;
 b=JmZuw3exonEf4jwp6v+Xy7L5wurGURcw3Db5m0/j37sqP5z7p+1fcubpXKVP7v6I7hIslOeVW+cDIAbZ2dCETn8tE1Aw21Zcl/MFdZzvMYlrmbfS6Xap3TNB0uUc+4B+PmW1B2wYeddRbAuNabP7gy2AOe3q8a3/wx7boDaasx90Rka4WzdbYBVCHS+6DjZFzaSEVWGpng81MIFigcTqiKXwWnPHc22obSx1reM8ugrq37HTEJCfngy7mA16bZgycnhS6V3GuGGNymTdVB6YNZvnTDgIb9pqLOXos9cuSxF9eAVCXOznjpgcTu6vdUceKEGvFnGXRYRT/S+l47R18Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HevPGC44yEDyL6mGh9vB077VcqfnnkJvPZnVQVlQIw=;
 b=O3Wkga2nzqIdMC36QuaGOWENoUgvHMCYU4OE+7fqYCq8MGYYbPw6eo4Q3a1fID6OFd1P0gfFTVkkLam7xO9e25cSQkDy63Tg2qU4cK8VrUcIIYNlybIGrYtCyR7dazqjmRpvd/QunMY3RmqwoDXRNJc7Ysb/A+Y6NHn8F0WHJWM=
x-ms-exchange-crosstenant-network-message-id: 580c4830-6100-43de-3dd1-08d76db8c92c
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 12:54:31.1035 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: k/LylWhX1VNHDnebkfOZ5it0zQbOpWGF7ITMud6atGurBRhqb8HhKVHHATg/deAPn5tMtlXd8/C40wdcRZwhqw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5109
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SG93IHdhcyB0aGlzIHNvbHZlZCBmb3Igb3RoZXIgdGFyZ2V0cz8NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9y
Zz4NClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMTkgNTowMSBBTQ0KVG86IExhdXJl
bnQgVml2aWVyIDxsYXVyZW50QHZpdmllci5ldT4NCkNjOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBz
b25AcXVpY2luYy5jb20+OyBSaWt1IFZvaXBpbyA8cmlrdS52b2lwaW9AaWtpLmZpPjsgUUVNVSBE
ZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBI
ZXhhZ29uOiBTd2FwIFNJR1JHTUFYLTEgYW5kIFNJR1JUTUlOKzENCg0KDQpPbiBXZWQsIDIwIE5v
diAyMDE5IGF0IDEwOjU0LCBMYXVyZW50IFZpdmllciA8bGF1cmVudEB2aXZpZXIuZXU+IHdyb3Rl
Og0KPiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCwgYW5kIEkgYWdyZWUsIGJ1dCBub3QgYWxsb3dp
bmcgdGhpcyB3aWxsIGJsb2NrDQo+IHRoZSBtZXJnZSBvZiB0aGUgaGV4YWdvbiB0YXJnZXQsIGFu
ZCBJIGRvbid0IHNlZSBhbnkgZml4IGZvciB0aGUNCj4gdW5kZXJseWluZyBwcm9ibGVtIGNvbWlu
ZyBzb29uLg0KPg0KPiBPdGhlciB0YXJnZXRzIHdvcmsgd2l0aG91dCB0aGlzIGNoYW5nZSwgYW5k
IGFkZGluZyB0aGlzIGNoYW5nZSBicmVha3MNCj4gc29tZSB1c2VyIHNwYWNlIGFwcGxpY2F0aW9u
cyAobGlrZSBnbyksIHdoZXJlYXMgYWRkaW5nIHRoaXMgY2hhbmdlIGZvcg0KPiBoZXhhZ29uIHRh
cmdldCBvbmx5IHdpbGwgaW1wcm92ZSB0aGUgc2l0dWF0aW9uIGZvciBpdCAod2l0aCBubw0KPiBy
ZWdyZXNzaW9uLCBhcyBpdCBkb2Vzbid0IHdvcmsgYXQgYWxsIGZvciB0aGUgbW9tZW50KQ0KDQpJ
IGNhcmUgbW9yZSB0aGF0IHdlIHNob3VsZCBmaXggdGhpbmdzIGNvcnJlY3RseSBhbmQgbWFpbnRh
aW4gdGhlIGNvbnNpc3RlbmN5IG9mIGhvdyBvdXIgYXJjaGl0ZWN0dXJlcyBiZWhhdmUgdGhhbiB0
aGF0IHdlIGFyZSBhYmxlIHRvIHF1aWNrbHkgbGFuZCBhIHRhcmdldCBmb3IgYSBmYWlybHkgbWlu
b3IgYXJjaGl0ZWN0dXJlLCB0byBiZSBob25lc3QuIElmIHdlIGxhbmQgaGV4YWdvbiB3aXRoIGhh
Y2tzIGFuZCB3b3JrYXJvdW5kcyB0aGVuIHdlJ3JlIHBvdGVudGlhbGx5IHN0dWNrIHdpdGggdGhh
dCBiZWhhdmlvdXIuDQoNCnRoYW5rcw0KLS0gUE1NDQo=


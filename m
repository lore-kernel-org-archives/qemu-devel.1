Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4537C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7A720872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TzuMDZLK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iAKPmq2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7A720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCirB-0005OJ-NX
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCiov-0004Bw-LF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCiou-0000SB-EM
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:17:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1633f89ff=Anup.Patel@wdc.com>)
 id 1iCioq-0000Pq-HI; Tue, 24 Sep 2019 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569323841; x=1600859841;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iiB4WeFIlQG74LsnyKAe4J40IGn896WARzAOkcbN3Fk=;
 b=TzuMDZLKtcfiOzTmkLZT7dCPiAcEcU3s85urkIdLpT4H5cNWVpOljf65
 ViIah0/8mWFrQd4hWK+fUZSa9khotPpNqzPQ2ix2eNVRx6uAMwi7EtOGv
 hiPLwSszf8iBI5Q1KrcfffYrjGxamBM/wAUrK4JZj75S8Mz1RoG+f1Cdj
 mvIR/5hrYcpAv9sw13hWBzs1hd32DnmQwyX7+i/b3IN8VV0rwceWu2mBV
 7WBj+Nh6JjICNs6oqlNgYhhxgwwTq6FrrUVwEBBGPw7KQUfGSwO93+og2
 Fo5adgcxt46BE3bBMLvjp/EXfrNOJ2oJIOmwRfNJUaReieY/tp+n007Xr A==;
IronPort-SDR: LjSyhLBj2b16vFaCH4393+jr5ME1xDvZVDlFkhL1X2Ms4hoAo6onSfUzq7eYyTjyiP0dSBa4ga
 eY0ZlHSMke7gtsWjcScEKtpV+h3N9HczNLbYdeNzIPwvXlFLTF/JWF337BEbrcst5Pz2gV0V1P
 3L3QeWvH2CDdoxTPEkxnCkClCRVpgm4x+0c8PnF2zHzX0+ksGmhNHEUNTFN+fn10Pxu4+FK1nr
 d3PESs3BmiLzNoKoNgwtAm8t0xHW7DoPrEdslgvwjJoOR/0VodOCk2sfHxPaKdowXa6M2V51qm
 WNU=
X-IronPort-AV: E=Sophos;i="5.64,543,1559491200"; d="scan'208";a="118963691"
Received: from mail-dm3nam03lp2055.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.55])
 by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2019 19:17:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiAoq9PqmZn84hqHgkPmvJuQAn8DMcLFiiVk4mk48sGotMEqcssSsmeLTx7oiLuSSZ6Cx+5Z7qX7ZvahQlJZWNs12gUAPSOCT2bLrFh3o9GD0DRyzBgkoWMuKUdmFQi388ftMfE7OHd25wb6/4px+dHtEwZTOVReFukN4I2GBxbn+J2G3mzJbC0qK2QGEHS37QVMD/xePnDc7Vl0IUHZBhMHIiVYGRg6CLf/Gs92P6BRoGkSt+xGgZqCIXb9zUHjaCEcK9HY17WjuT2FZmJ2mPTFbm2Yx2c7TRD20Oyy2GHqENnebTHgvXrfgKIE/uZuhpL3C/RVFJpswJQjFXzaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiB4WeFIlQG74LsnyKAe4J40IGn896WARzAOkcbN3Fk=;
 b=hwt7caqu3jfCk1rFVOO7gYyab33bQaeaOry5sDz3v0MMwQDmbG/ICvEsTlK6EyRUUc0CGhKK3mSrsrd0iSJKzNsABse3GqYrDHn0ZJyTByEUDYj+9wEQYjiW+zUM+27OPTQ/3bYyYXe6SZH4ExLBWDIVZtV9ZOFYhmhb6k2MYD1GHjSc1gZQ37OcJq9/kAMq2MQC1kpjW+1tLFIhv51H/PUtRtReT4PgZCy0lLveqF9NAh9Fl910k4EO+AYzdkf3bfzNU2IazOlfEGBNd/mcUSJ5gxZDUu2C+miiuOiLpaHwMOMgSInggfRHmg3Ttf+3MdfmHFoeHE4x+eY0dqdDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiB4WeFIlQG74LsnyKAe4J40IGn896WARzAOkcbN3Fk=;
 b=iAKPmq2P+VfjV+AnRPhiUpe/qL6CEW02V4C3KQGaeA+Q9+sj36SnKDZi0s2aQETqdPn3TH1OPTqKEXk4237t63FaokpL2AdpO0QywsduzojLZQfsqmn8cOiP/s/BdpziYJXhj/JZ8bjV64ekVxi3g0a5EABVsp2BFMI1fW5fn20=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5949.namprd04.prod.outlook.com (20.178.255.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 11:17:08 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 11:17:08 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/2] hw: timer: Add Goldfish RTC device
Thread-Topic: [PATCH 1/2] hw: timer: Add Goldfish RTC device
Thread-Index: AQHVcrQNCvgG16FtZEeROSOS3DihBac6lZmAgAAXUFA=
Date: Tue, 24 Sep 2019 11:17:08 +0000
Message-ID: <MN2PR04MB60610CCAEED38F30F9B274208D840@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190924084201.107958-1-anup.patel@wdc.com>
 <20190924084201.107958-2-anup.patel@wdc.com>
 <CAFEAcA-cm2GaKHg7_VcSb-OHp8GA9KuWiyWbc6r3F1p7tLc35A@mail.gmail.com>
In-Reply-To: <CAFEAcA-cm2GaKHg7_VcSb-OHp8GA9KuWiyWbc6r3F1p7tLc35A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 459074b9-a20a-48ed-4b82-08d740e0bcf2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:MN2PR04MB5949; 
x-ms-traffictypediagnostic: MN2PR04MB5949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5949021A33A1811D40250C728D840@MN2PR04MB5949.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(189003)(199004)(13464003)(305945005)(33656002)(66446008)(54906003)(66476007)(256004)(66946007)(99286004)(4326008)(6246003)(64756008)(7696005)(8936002)(66556008)(14444005)(316002)(5660300002)(229853002)(52536014)(74316002)(486006)(6436002)(25786009)(2906002)(102836004)(76176011)(446003)(66066001)(81156014)(81166006)(71190400001)(71200400001)(7736002)(6916009)(53546011)(9686003)(14454004)(26005)(55016002)(186003)(76116006)(55236004)(476003)(6506007)(6116002)(11346002)(3846002)(8676002)(478600001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5949;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JqHj3RX06jR5S3Kk10MP7DjVna7TMS9k3m6lw4d2g4zELDMT87DnlQhKbG/Fv0sqkVIvXa2fNYiDZpBoRMQ5me4S/qL5w2uMVZvsylkZlml9lKaE6VcYqe69anEpLbOvEgKDF4ELx5ZHa5+eHfgfWelfuuNIF9KuvyeMCjyn8BB7whZo4BjD4fss+mm0rZhDe/DY66CFy7bOKH971e+ba87cUeqX0V7ijQ7P6unsuEBxuJFmE9ysEVCu1R/MpGZia7bd+j1UpdXN1Enmv8SQV8TSMkJhgTIy2hWsIChGfGxUZ5F0YKCJzJNndSk49QKr+eO5fQhmiXPBsi0YeXW76hulRnvSBA/n0ziJFkpijrSkXcKIp90qkbt1yViDMVgLJHcCA11WIIIQ19NDiGrrzfx6LbXJhG+ZuCn0M9BmaC4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459074b9-a20a-48ed-4b82-08d740e0bcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 11:17:08.0993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcLrXu0nSoD1XMB2cj5PRyUXKZ+GZujGhLtKr9zd7tRj3bsEq8fa6Jdy4CgFHPmTMERZy7mM/y40vklCbtSHWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5949
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.42
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjQs
IDIwMTkgMzoyMSBQTQ0KPiBUbzogQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3ZGMuY29tPg0KPiBD
YzogUGFsbWVyIERhYmJlbHQgPHBhbG1lckBzaWZpdmUuY29tPjsgQWxpc3RhaXIgRnJhbmNpcw0K
PiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgU2FnYXIgS2FyYW5kaWthciA8c2FnYXJrQGVl
Y3MuYmVya2VsZXkuZWR1PjsNCj4gQmFzdGlhbiBLb3BwZWxtYW5uIDxrYmFzdGlhbkBtYWlsLnVu
aS1wYWRlcmJvcm4uZGU+OyBBdGlzaCBQYXRyYQ0KPiA8QXRpc2guUGF0cmFAd2RjLmNvbT47IHFl
bXUtcmlzY3ZAbm9uZ251Lm9yZzsgcWVtdS0NCj4gZGV2ZWxAbm9uZ251Lm9yZzsgQW51cCBQYXRl
bCA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGh3OiB0
aW1lcjogQWRkIEdvbGRmaXNoIFJUQyBkZXZpY2UNCj4gDQo+IE9uIFR1ZSwgMjQgU2VwIDIwMTkg
YXQgMDk6NDUsIEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBUaGlzIHBhdGNoIGFkZHMgbW9kZWwgZm9yIEdvb2dsZSBHb2xkZmlzaCB2aXJ0dWFsIHBsYXRm
b3JtIFJUQyBkZXZpY2UuDQo+ID4NCj4gPiBXZSB3aWxsIGJlIGFkZGluZyBHb2xkZmlzaCBSVEMg
ZGV2aWNlIHRvIHRoZSBRRU1VIFJJU0MtViB2aXJ0IG1hY2hpbmUNCj4gPiBmb3IgcHJvdmlkaW5n
IHJlYWwgZGF0ZS10aW1lIHRvIEd1ZXN0IExpbnV4LiBUaGUgY29ycmVzcG9uZGluZyBMaW51eA0K
PiA+IGRyaXZlciBmb3IgR29sZGZpc2ggUlRDIGRldmljZSBpcyBhbHJlYWR5IGF2YWlsYWJsZSBp
biB1cHN0cmVhbSBMaW51eC4NCj4gPg0KPiA+IEZvciBub3csIFZNIG1pZ3JhdGlvbiBzdXBwb3J0
IGlzIG5vdCBhdmFpbGFibGUgZm9yIEdvbGRmaXNoIFJUQyBkZXZpY2UNCj4gPiBidXQgaXQgd2ls
bCBiZSBhZGRlZCBsYXRlciB3aGVuIHdlIGltcGxlbWVudCBWTSBtaWdyYXRpb24gZm9yIEtWTSBS
SVNDLQ0KPiBWLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW51cCBQYXRlbCA8YW51cC5wYXRl
bEB3ZGMuY29tPg0KPiA+IC0tLQ0KPiA+ICsNCj4gPiArc3RhdGljIFByb3BlcnR5IGdvbGRmaXNo
X3J0Y19wcm9wZXJ0aWVzW10gPSB7DQo+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UNjQoInRpY2st
b2Zmc2V0IiwgR29sZGZpc2hSVENTdGF0ZSwgdGlja19vZmZzZXQsIDApLA0KPiA+ICsgICAgREVG
SU5FX1BST1BfVUlOVDY0KCJhbGFybS1uZXh0IiwgR29sZGZpc2hSVENTdGF0ZSwgYWxhcm1fbmV4
dCwgMCksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoImFsYXJtLXJ1bm5pbmciLCBHb2xk
ZmlzaFJUQ1N0YXRlLA0KPiBhbGFybV9ydW5uaW5nLCAwKSwNCj4gPiArICAgIERFRklORV9QUk9Q
X1VJTlQzMigiaXJxLXBlbmRpbmciLCBHb2xkZmlzaFJUQ1N0YXRlLCBpcnFfcGVuZGluZywNCj4g
MCksDQo+ID4gKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoImlycS1lbmFibGVkIiwgR29sZGZpc2hS
VENTdGF0ZSwgaXJxX2VuYWJsZWQsDQo+IDApLA0KPiA+ICsgICAgREVGSU5FX1BST1BfRU5EX09G
X0xJU1QoKSwNCj4gPiArfTsNCj4gDQo+IFdoYXQgYXJlIGFsbCB0aGVzZSBwcm9wZXJ0aWVzIHRy
eWluZyB0byBkbyA/DQoNCkFyZ2gsIEkgZm9yZ290IHRvIHJlbW92ZSB0aGVzZSBiZWZvcmUgc2Vu
ZGluZy4NCg0KSSB3aWxsIGRyb3AgdGhlc2UgaW4gbmV4dCByZXZpc2lvbi4NCg0KPiANCj4gPiAr
DQo+ID4gK3N0YXRpYyB2b2lkIGdvbGRmaXNoX3J0Y19jbGFzc19pbml0KE9iamVjdENsYXNzICpr
bGFzcywgdm9pZCAqZGF0YSkgew0KPiA+ICsgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NM
QVNTKGtsYXNzKTsNCj4gPiArICAgIGRjLT5wcm9wcyA9IGdvbGRmaXNoX3J0Y19wcm9wZXJ0aWVz
Ow0KPiANCj4gTWlzc2luZyByZXNldCBmdW5jdGlvbi4NCg0KU3VyZSwgSSB3aWxsIGFkZCBpdC4g
SSBnb3QgY29uZnVzZWQgYmVjYXVzZSBJIHNhdyByZXNldCBmdW5jdGlvbiBpbiBIUEVUDQpidXQg
bm90IGluIFBMMDMxLg0KDQo+IA0KPiBJZiB5b3UgZG9uJ3Qgd2FudCB0byBpbXBsZW1lbnQgbWln
cmF0aW9uIHN1cHBvcnQgbm93IHlvdSBzaG91bGQgYXQgbGVhc3QNCj4gcHV0IGluIHNvbWV0aGlu
ZyB0aGF0IGJsb2NrIG1pZ3JhdGlvbi4NCj4gKFBlcnNvbmFsbHkgSSBwcmVmZXIgdG8ganVzdCB3
cml0ZSB0aGUgdm1zdGF0ZSwgaXQncyBhcyBlYXN5IGFzIHdyaXRpbmcgdGhlIGNvZGUNCj4gdG8g
YmxvY2sgbWlncmF0aW9ucy4pDQoNCk9rYXksIEkgd2lsbCBhZGQgdm1zdGF0ZS4NCg0KSXMgdGhl
cmUgYSB3YXkgdG8gdW5pdCB0ZXN0IHRoZSB2bXN0YXRlIHBhcnQgPw0KT1INCkFyZSB5b3UgZmlu
ZSBpZiB3ZSB0ZXN0LW4tZml4IGl0IGxhdGVyID8NCg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K
DQpSZWdhcmRzLA0KQW51cA0K


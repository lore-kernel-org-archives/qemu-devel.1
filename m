Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF8EC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4561F214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B5eU1Zkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4561F214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKzkB-0003Id-BB
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 02:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iKzjH-0002jE-RC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iKzjG-000671-JN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:57:47 -0400
Received: from mail-eopbgr780057.outbound.protection.outlook.com
 ([40.107.78.57]:63968 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iKzjG-00066E-6r
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcUPs9NYvi6eLP8SuLftHtWk0DNzX6oO6o3biIalhHIspq5z/3C95rRV+mY4aj1s7E+OzBsqaJfgd8OTt2M9D9AsYjstj9htOkemuFuF/9Lcuc+y4/xt+Nf+8Npwzgk0X768cyc6/z/3hECO4+I/WQ8MdLk85WV83yeDg4FMKoELm067njLqUcxocOYVp9KamEeDa/i7GPcAZT/9ruVB1/r4XwX1T/V06P2OktfaspC2OitW2rvTdmmdg666KsB0KwVhaFzziy/ATI8Qq0YYmUGYY+jj0FRie19jLgVkt+I1akXkE16Y88nG6Bwm9URnvG0BnlJ1ZnWlPz8r6ccIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxlXVgq7vZ6IRMftlHORoOIa6CfrBn1JGUd1Xo8O+7k=;
 b=Hrjqh7i1Cvmug7Xk8ymmSVVt3YtOz3hR205/QUv+ss8+lKk6uWYrD68uau2SOlDGikn+qHKRvwIERlsf8kEnVruUs3pvMvy6MUNupCv6gxuFLqmaroqb2jH8+6oGfzboVFjlI34KFBMVKrGgKKjuqbQMpHtu0xskcdpg89gUwPLCuyjfKIZJ9682I7DosODyI6dXhEjFC6BXsq7DCG8lACAPb/WGZdCiL2Qsv+agv5Whh5xcQgvQL0ufDkgzXhxGEqC6tyqMcs+QLrHJefGsUjnwJaY+iHNc8S5LfGGPiMhaUa4D4gTVYAp3QNqzmMIsFONpT00XxEQMZy3NUNXFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxlXVgq7vZ6IRMftlHORoOIa6CfrBn1JGUd1Xo8O+7k=;
 b=B5eU1Zkmn1ZZi4ZKquJmwIqfR9nFlCs6pgSeOoRq04VG2njAteVf720O5u8bHLLtybA/dnl+EG9ru5qScbo5Wk+E0seYwNe3Jd53gW1dLRfQcip9agO9RmVixM9BhmHSpUtsn0kHPWzbK+7AK8J5OU4Gtf5ZvEmopulCbXTuEyA=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6191.namprd02.prod.outlook.com (52.132.173.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 06:57:42 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::512c:df91:18db:e74b]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::512c:df91:18db:e74b%4]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 06:57:42 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: RE: [PATCH] ssi: xilinx_spips: Filter the non spi registers
 transactions
Thread-Topic: [PATCH] ssi: xilinx_spips: Filter the non spi registers
 transactions
Thread-Index: AQHVhHdatlP8U0lyE0C2VOdRAl6zfadeYXVw
Date: Thu, 17 Oct 2019 06:57:42 +0000
Message-ID: <MN2PR02MB59358466BB695C1564F19CE4CA6D0@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <1571035899-9692-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <CAKmqyKPtXc4LOeaSyCdh=T3qgM8e+F=oiasbynH1VfTnofOrVA@mail.gmail.com>
In-Reply-To: <CAKmqyKPtXc4LOeaSyCdh=T3qgM8e+F=oiasbynH1VfTnofOrVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 243429e1-6b61-483a-bc8b-08d752cf4ebe
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR02MB6191:
x-microsoft-antispam-prvs: <MN2PR02MB61918DD48B1ECB646877EDC6CA6D0@MN2PR02MB6191.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(13464003)(199004)(478600001)(7736002)(66066001)(54906003)(25786009)(14454004)(316002)(74316002)(305945005)(33656002)(1411001)(71190400001)(71200400001)(8936002)(81156014)(8676002)(81166006)(99286004)(14444005)(52536014)(3846002)(229853002)(6506007)(53546011)(102836004)(256004)(7696005)(76176011)(6116002)(66476007)(6436002)(5660300002)(64756008)(11346002)(6916009)(86362001)(476003)(486006)(2906002)(26005)(186003)(6246003)(55016002)(66556008)(66446008)(9686003)(4326008)(446003)(76116006)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6191;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yo6Hag4K/23fydCbwkeb1W2zb0b91zuDW33dGHjQtgu2bJeu8Ore5omJWE0Dn664OUSYssi8SR2a9Zo2a91Bvuyhh5jlXLQb04QLelkk3rZ8hV9gs16OrmDnwhSCorqlKLfGF7xrGs0IxQPfzmeQ6S5sWJrzXLKTCPz7GwILoQU8HALd80++3D3GMd6fjvTIFaeJpEv2bRq7lugapwpBth1FnSjLHHQsTxY+xAzSglwBqMGnWAxcfMjHA0+vUWzCWvyyQ0HDRz4akFBP/LzlrtH7To7O37YigEWlT/kjLRZIOo7AbM+dvFf6wwK0D3tu7FRVdtIcMsiLrbUCPgIp7W5UnORGiNOD+j3VX+11kNHTJwmqj89ZUrZX5dMbc8hXhaa/X6IB+RQMr6KALi8LroYh5g3hW30sHSumbUmCyH0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243429e1-6b61-483a-bc8b-08d752cf4ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 06:57:42.7036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ObtLFwfCDk6E3VT5Mz0FalL1cHfbbLzsyT+0VZFC7cOXgtq4dE0GmsI0wux4AtQL3x4lbRb/fQOqq1smUEihSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6191
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.57
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBP
Y3RvYmVyIDE3LCAyMDE5IDQ6MzkgQU0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4
aWxpbnguY29tPg0KPiBDYzogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5t
ZT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZyBEZXZlbG9wZXJzIDxxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBzc2k6IHhpbGlueF9zcGlwczogRmlsdGVyIHRoZSBub24gc3Bp
IHJlZ2lzdGVycyB0cmFuc2FjdGlvbnMNCj4gDQo+IE9uIFN1biwgT2N0IDEzLCAyMDE5IGF0IDEx
OjUxIFBNIFNhaSBQYXZhbiBCb2RkdQ0KPiA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gWnlucU1QL1ZlcnNhbCBzcGVjaWZpYyBxc3BpIHJlZ2lzdGVycyBzaG91
bGQgYmUgaGFuZGxlZCBpbnNpZGUNCj4gPiB6eW5xbXBfcXNwaV9yZWFkL3dyaXRlIGNhbGxzLiBX
aGVuIGZldyBvZiB0aGVzZSB0cmFuc2FjdGlvbnMgYXJlDQo+ID4gaGFuZGxlZCBieSBzcGkgaG9v
a3Mgd2Ugc2VlIHN0YXRlIGNoYW5nZSBpbiBzcGkgYnVzIHVuZXhwZWN0ZWRseS4NCj4gPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNhaSBQYXZhbiBCb2RkdSA8c2FpLnBhdmFuLmJvZGR1QHhpbGlueC5j
b20+DQo+ID4gLS0tDQo+ID4gIGh3L3NzaS94aWxpbnhfc3BpcHMuYyB8IDI2ICsrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3NzaS94aWxpbnhfc3BpcHMu
YyBiL2h3L3NzaS94aWxpbnhfc3BpcHMuYyBpbmRleA0KPiA+IGEzMDljNzEuLjRmOWY4ZTAgMTAw
NjQ0DQo+ID4gLS0tIGEvaHcvc3NpL3hpbGlueF9zcGlwcy5jDQo+ID4gKysrIGIvaHcvc3NpL3hp
bGlueF9zcGlwcy5jDQo+ID4gQEAgLTEwOSw2ICsxMDksNyBAQA0KPiA+ICAjZGVmaW5lIFJfR1BJ
TyAgICAgICAgICAgICAgKDB4MzAgLyA0KQ0KPiA+ICAjZGVmaW5lIFJfTFBCS19ETFlfQURKICAg
ICAgKDB4MzggLyA0KQ0KPiA+ICAjZGVmaW5lIFJfTFBCS19ETFlfQURKX1JFU0VUICgweDMzKQ0K
PiA+ICsjZGVmaW5lIFJfSU9VX1RBUERMWV9CWVBBU1MgKDB4M0MgLyA0KQ0KPiA+ICAjZGVmaW5l
IFJfVFhEMSAgICAgICAgICAgICAgKDB4ODAgLyA0KQ0KPiA+ICAjZGVmaW5lIFJfVFhEMiAgICAg
ICAgICAgICAgKDB4ODQgLyA0KQ0KPiA+ICAjZGVmaW5lIFJfVFhEMyAgICAgICAgICAgICAgKDB4
ODggLyA0KQ0KPiA+IEBAIC0xMzksNiArMTQwLDggQEANCj4gPiAgI2RlZmluZSBSX0xRU1BJX1NU
UyAgICAgICAgICgweEE0IC8gNCkNCj4gPiAgI2RlZmluZSBMUVNQSV9TVFNfV1JfUkVDVkQgICAg
ICAoMSA8PCAxKQ0KPiA+DQo+ID4gKyNkZWZpbmUgUl9EVU1NWV9DWUNMRV9FTiAgICAoMHhDOCAv
IDQpDQo+ID4gKyNkZWZpbmUgUl9FQ08gICAgICAgICAgICAgICAoMHhGOCAvIDQpDQo+ID4gICNk
ZWZpbmUgUl9NT0RfSUQgICAgICAgICAgICAoMHhGQyAvIDQpDQo+ID4NCj4gPiAgI2RlZmluZSBS
X0dRU1BJX1NFTEVDVCAgICAgICAgICAoMHgxNDQgLyA0KQ0KPiA+IEBAIC05MzgsNyArOTQxLDE2
IEBAIHN0YXRpYyB1aW50NjRfdCB4bG54X3p5bnFtcF9xc3BpcHNfcmVhZCh2b2lkDQo+ICpvcGFx
dWUsDQo+ID4gICAgICBpbnQgc2hvcnRmYWxsOw0KPiA+DQo+ID4gICAgICBpZiAocmVnIDw9IFJf
TU9EX0lEKSB7DQo+ID4gLSAgICAgICAgcmV0dXJuIHhpbGlueF9zcGlwc19yZWFkKG9wYXF1ZSwg
YWRkciwgc2l6ZSk7DQo+ID4gKyAgICAgICAgc3dpdGNoIChhZGRyKSB7DQo+ID4gKyAgICAgICAg
Y2FzZSBSX0dQSU86DQo+ID4gKyAgICAgICAgY2FzZSBSX0xQQktfRExZX0FESjoNCj4gPiArICAg
ICAgICBjYXNlIFJfSU9VX1RBUERMWV9CWVBBU1M6DQo+ID4gKyAgICAgICAgY2FzZSBSX0RVTU1Z
X0NZQ0xFX0VOOg0KPiA+ICsgICAgICAgIGNhc2UgUl9FQ086DQo+ID4gKyAgICAgICAgICAgIHJl
dHVybiBzLT5yZWdzW2FkZHIgLyA0XTsNCj4gPiArICAgICAgICBkZWZhdWx0Og0KPiA+ICsgICAg
ICAgICAgICByZXR1cm4geGlsaW54X3NwaXBzX3JlYWQob3BhcXVlLCBhZGRyLCBzaXplKTsNCj4g
DQo+IFRoaXMgZG9lc24ndCBzZWVtIHJpZ2h0LiBUaGlzIHNob3VsZCBoYXZlIG5vIGZ1bmN0aW9u
YWwgY2hhbmdlIGZvciB0aGUgcmVhZA0KPiBmdW5jdGlvbiBhbmQgaGFzIHRoZSBjb25zZXF1ZW5j
ZSBvZiBub3QgcHJpbnRpbmcgdGhlIG1lbW9yeSBhY2Nlc3Nlcy4gSWYNCj4geW91IHRyeSB0byBk
ZWJ1ZyB0aGlzIGNvZGUgbm93IHlvdSB3b24ndCBzZWUgYWxsIG9mIHRoZXNlIG9wZXJhdGlvbnMg
aW4gdGhlDQo+IGxvZy4NCltTYWkgUGF2YW4gQm9kZHVdIFllYWggcmVhZHMgZG8gbm90IGhhdmUg
YW55IGlzc3VlLiBCdXQgSSBzZWUgeW91ciBwb2ludCBvZiBkZWJ1ZyBwcmludHMuDQo+IA0KPiA+
ICsgICAgICAgIH0NCj4gPiAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgc3dpdGNoIChyZWcp
IHsNCj4gPiAgICAgICAgICBjYXNlIFJfR1FTUElfUlhEOg0KPiA+IEBAIC0xMDYzLDcgKzEwNzUs
MTcgQEAgc3RhdGljIHZvaWQgeGxueF96eW5xbXBfcXNwaXBzX3dyaXRlKHZvaWQNCj4gKm9wYXF1
ZSwgaHdhZGRyIGFkZHIsDQo+ID4gICAgICB1aW50MzJfdCByZWcgPSBhZGRyIC8gNDsNCj4gPg0K
PiA+ICAgICAgaWYgKHJlZyA8PSBSX01PRF9JRCkgew0KPiA+IC0gICAgICAgIHhpbGlueF9xc3Bp
cHNfd3JpdGUob3BhcXVlLCBhZGRyLCB2YWx1ZSwgc2l6ZSk7DQo+ID4gKyAgICAgICAgc3dpdGNo
IChyZWcpIHsNCj4gPiArICAgICAgICBjYXNlIFJfR1BJTzoNCj4gPiArICAgICAgICBjYXNlIFJf
TFBCS19ETFlfQURKOg0KPiA+ICsgICAgICAgIGNhc2UgUl9JT1VfVEFQRExZX0JZUEFTUzoNCj4g
PiArICAgICAgICBjYXNlIFJfRFVNTVlfQ1lDTEVfRU46DQo+ID4gKyAgICAgICAgY2FzZSBSX0VD
TzoNCj4gPiArICAgICAgICAgICAgcy0+cmVnc1thZGRyXSA9IHZhbHVlOw0KPiA+ICsgICAgICAg
ICAgICBicmVhazsNCj4gPiArICAgICAgICBkZWZhdWx0Og0KPiA+ICsgICAgICAgICAgICB4aWxp
bnhfcXNwaXBzX3dyaXRlKG9wYXF1ZSwgYWRkciwgdmFsdWUsIHNpemUpOw0KPiA+ICsgICAgICAg
IH0NCj4gDQo+IEZvciB0aGUgd3JpdGUgY29kZSBpdCBsb29rcyBsaWtlIHRoaXMgc2tpcHMgdGhl
ICJub19yZWdfdXBkYXRlIiBnb3RvLg0KPiBNYXliZSB0aGF0IGlzIHRoZSBpc3N1ZSB0aGF0IHlv
dSBhcmUgc2VlaW5nPw0KW1NhaSBQYXZhbiBCb2RkdV0geWVzLCBub19yZWdfdXBkYXRlIHRyaWdn
ZXJzIHVwZGF0ZSBvZiBjcyBsaW5lcy4NCldlIGNhbiBhbHNvIHB1dCBhIGNoZWNrIHRoZXJlIHRv
IHNraXAgbm9fcmVnX3VwZGF0ZSB3aGVuIGl04oCZcyBhIHp5bnFtcCBxc3BpLg0KSSB3aWxsIHRy
eSB0aGF0IGFuZCBzZW5kIGEgVjIuDQoNClRoYW5rcw0KU2FpIFBhdmFuDQo+IA0KPiBBbGlzdGFp
cg0KPiANCj4gPiAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgc3dpdGNoIChyZWcpIHsNCj4g
PiAgICAgICAgICBjYXNlIFJfR1FTUElfQ05GRzoNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCj4g
Pg0K


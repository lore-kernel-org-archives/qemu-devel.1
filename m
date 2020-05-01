Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC4AC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BEC208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="See3bLFi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b5WurGuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BEC208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUV5R-0001yD-BR
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3830f6f88=Anup.Patel@wdc.com>)
 id 1jUV4M-0001DL-AI
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=3830f6f88=Anup.Patel@wdc.com>)
 id 1jUV4L-0004kd-N6
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:47:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:10100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=3830f6f88=Anup.Patel@wdc.com>)
 id 1jUV4G-0004in-NC; Fri, 01 May 2020 08:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588337228; x=1619873228;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=04+ARVJ8QuBhwMUcAQTEjPSKDI9NVXErPPYGz5wl34g=;
 b=See3bLFiyJhIxP4vMOI0SbmeUdI5VGfCfTxLaujecwV+iT82yw6J7oo5
 Rilb9VGf5PwQacn9LFbeZrsFuQkD0tIYrSAEwzf8xzJ0oOfHwSLbTsrei
 iluFJcb4snuSNxcHkvHyPxPf+TLcCcAQVREfjXVmm3RxrjAmWzZpo7TNj
 ggX8W7oIbCkx8/01t1vML2MW9JKhGjB+ocsvqNlsNf22dU7jMGPubbwZL
 f7k16wIaQ6wzWDBj1+WbHtF9pyDy8ZePTwWpTOjfuGxx/tARRNXkYR6Ga
 8YZTkrl4HL4ZHmPif7xSkyZ8YGIHrG8ubgLQrpMHt4JNclkRdOkPO3C/y Q==;
IronPort-SDR: 0bsVi0zBJ9M1rrZklYfOflAOtUvgKy5fL34VK/Q8FGkJwtyqFbvk+Mp1PgrSMT9q9UCKSnSnXN
 gO5YQRZEjycuXbUfm2l7NlLy9X4S7eBGVrO+uPhgFx0ztYueeMhq6dzknTOfzVww4xlingQUFh
 nd+QmW+XlQLm/HMYcxibxM4TiVQEwopr8skxGo9g9gy3WYtvrAytmlfYiiYOvJkLw/0RzCfLPE
 XRtQWk5I4aAbm4+ulddtptq+jQ9t4H+C15wqTRfBEec/msjWtERFTKk76C4lktuTzsYb9ge/zG
 tYg=
X-IronPort-AV: E=Sophos;i="5.73,339,1583164800"; d="scan'208";a="239240880"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
 by ob1.hgst.iphmx.com with ESMTP; 01 May 2020 20:46:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csZu54g4/SSD9W+cBKZsft7lhDJuwuPeAqZ5TqaL6hI/z5+Mdb0MJBX8+HaRYDsHzC8XTFIGPKmE8uBE7sRcrE46ejNchFzt7D5ufS6SOWtr+R/u0XD9Hf7QlWbgXrXyvkDptGfdg1mkx9qrF+8RiCmeQ3DFL+C2YWTjWLEhmV5hzcW7RnGE5YoB9L9nA4q619Poe4Hj67t5vjURfPDyZ08Zzko/vQWG1/LQ8/AYyX0GcKL2u0i/Oj+u+4l38FAAFplZpq9mmab2wW9G1CFUdngj+yea2K0tTVI54SrxNPVwBqWR3ZZAp/ed1eJ9O37c4rjKG+yZCiFJ08J/8LjSCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04+ARVJ8QuBhwMUcAQTEjPSKDI9NVXErPPYGz5wl34g=;
 b=BRuM+350sNT8h6f3S/lykgLljohdEeY2BJUtLCfr1WmvVp3Q3iTSWH57CskXt3sTSLYVZuIw1sOcOFlWCC/eUKBNDfvFZc3BfBMqGlQ2lnOQIHWaFySZSIY0/sQEmsuEievxwXlx5J/WBdOUDnASCxDwWKHjW5Kftx0uDQUdY61Cp0Y3BnZUkN+BXyVWF7RAxXi377Syu62I/2KMUCs6lOsR/QU2t6wE2xqiE2cIQW8ys94QcCjzUwM4MlNoSwhiA5G5LIuHOQGFbL8Ie5mvA8RlVNDbD2dWwYFSDn1Pk5fCE9aTNjp+ZIaOGW/zKfUY89eijKktL9CXU27ZscG4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04+ARVJ8QuBhwMUcAQTEjPSKDI9NVXErPPYGz5wl34g=;
 b=b5WurGuKPk1MCfONYHY4nqBbFa+XE9ZQajp206NxdyJLxMfoOeiXTvavnuU6LitCkud5HMbyh3cDWTwNcK7tpsmdHVUV54gaZVGVWz2HcprXkO6vgYa9aK+ckQTbTMJDBJs/xSALC8tks13ESZVBsxB+mSbIoPt+4FOpEbh9M1k=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7020.namprd04.prod.outlook.com (2603:10b6:5:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 12:46:53 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 12:46:53 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH] riscv/spike: Change the default bios to use plain binary
 image
Thread-Topic: [PATCH] riscv/spike: Change the default bios to use plain binary
 image
Thread-Index: AQHWH7RoT+/US6EDJEiNx4UDS+bbKaiTLCaAgAAA/ICAAABfQA==
Date: Fri, 1 May 2020 12:46:53 +0000
Message-ID: <DM6PR04MB620114F45DB08141CA248C518DAB0@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <1588336185-1051-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy23Xrjfp4NxbwETsd6gG7mbhT5NOjFza6gpd-Rd=RbHEw@mail.gmail.com>
 <CAEUhbmW6BxVoRkKiDn0eJ8+yYmufcs+ou5HvAbb=Ht06NjtiKw@mail.gmail.com>
In-Reply-To: <CAEUhbmW6BxVoRkKiDn0eJ8+yYmufcs+ou5HvAbb=Ht06NjtiKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [49.207.61.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce7422ad-5930-4e07-7678-08d7edcdb982
x-ms-traffictypediagnostic: DM6PR04MB7020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB7020DFF41ADE5D62C31DDD278DAB0@DM6PR04MB7020.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0390DB4BDA
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlHFlBpFkQC3YRgIyg+mBv5G3Wq2/XERaD7BEOdBRAjGmsVA4QgyvQUMPXpW36XcriRr+oNk47V6S0r9nY4TUZ3KXsDzy24FMPS8OCSYduL2qF0J46RA8zDOKQbIcXWBHyIEN1OGMXbYMdoetMjT08LPZjfaomoYSup9CehEMWvwv3Y8IhLaoEsjcW0z93uL/WVbPRAhmxgyoYb8TdHwPUZPF9ZOj1JfQNyX1+x9DhMr4avW9TrgrQf/Ch7YDTB60D3OypLkeLa2BukC5wOmJykVyfXuME1Oe15AAweaRH7qZiKcXfBGr2Q8u+Rsq/qTx8mSL6cBRfexuHHLX57dSzFrEoZ9VzZQUuc/YxwFWiCod0/85TDLd787DDgBn5hld2ucH4eOZFVpTNs36kBrfhJBqhphcMW91rXWKM3+S7TFfzgp7UYmE1t7zeI3Wtkr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(64756008)(66476007)(66446008)(316002)(52536014)(186003)(66946007)(76116006)(26005)(110136005)(33656002)(478600001)(86362001)(4326008)(54906003)(71200400001)(8676002)(7696005)(66556008)(53546011)(2906002)(55236004)(55016002)(6506007)(8936002)(9686003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: CrvifDxjcHqWe55RGlaCkU6mYG7yE2ZggIFocI3gzrUQYU0BG5j3Gjw8F6Wlgh0OtEP2KVvByliFIeqLt6+1KGZEG6XxLNHur/7MEKKhRNRitoXcTS8EKRPxbak52eVYGAF/J8NZe7HhGEOxJTgRXqo5QWEOYUV4MRgTw4xXU7Ff2JIo+5aWuHs73lpXWGZWZ2nFOhPP1GHShzs2GioXSaB3ATSfAhv7khvuF6NTnv0RY92rgF1JKiVogkpOm4m8OuOjk1lp7sYniZU4yGeK/slZfGdfucctnlJYQJ+0/Jz2VaiBlybAOIZi95vC4AtIXLsP1SLYcP17M6QkjDTdB8IO6y6IjNpJ91g3xXoMfwnG2lhzdyqkHVZGKdu4Y6KTFxwJVSYqCsOGAE1+1hvvLDCwj6kF+/p2ZCaHcyuwDe/TDppsT4mu1CL7SYEu2UXWm67FRF77otaNW2JfeZyhnSBCGwI/RvaC+uIszBYKRwrSHOpeff3o1nXs6e8swTNcuKISpl6mSn2uzMDfoNYziXad+cQ6J7/1n18MbA8w61jZSY2SbDWX3Nl/OWvy7m24JGm4mynuhvSgkrjvTX9W74F0SZajZOu1eXMsN9iCgZCUnQdlRuJuhyBxfCuqp4YfodC0FCsNus6drVATU/NZdLhuJtO7RDapGRNdfdb2slC3jOVyctNH/IgkJ1enUP6V6KXKeZy+M2kbbigC+Ny+RgOcJCcO3zgVnEYCTPBsd9NftO1o6vWEFpbc5XItBCNvoTw+A/nNllmC4n04rBRCVaZyto5mY3FIwZ15ASl3Qsk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7422ad-5930-4e07-7678-08d7edcdb982
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2020 12:46:53.0439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LInYm5AcRk/MkWUpDmwXjcl+gGmG2vYEgVuXWqwBhLg4bZQ/uL6sYrF2NfMuWNv5bvX68stOAT/gOxNaEwcviQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7020
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=3830f6f88=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:46:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUWVtdS1yaXNjdiA8cWVt
dS1yaXNjdi0NCj4gYm91bmNlcythbnVwLnBhdGVsPXdkYy5jb21Abm9uZ251Lm9yZz4gT24gQmVo
YWxmIE9mIEJpbiBNZW5nDQo+IFNlbnQ6IDAxIE1heSAyMDIwIDE4OjE1DQo+IFRvOiBBbnVwIFBh
dGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiBDYzogQmluIE1lbmcgPGJpbi5tZW5nQHdpbmRy
aXZlci5jb20+OyBvcGVuIGxpc3Q6UklTQy1WIDxxZW11LQ0KPiByaXNjdkBub25nbnUub3JnPjsg
U2FnYXIgS2FyYW5kaWthciA8c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgQmFzdGlhbg0KPiBL
b3BwZWxtYW5uIDxrYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4uZGU+OyBQYWxtZXIgRGFiYmVs
dA0KPiA8cGFsbWVyZGFiYmVsdEBnb29nbGUuY29tPjsgUUVNVSBEZXZlbG9wZXJzIDxxZW11LQ0K
PiBkZXZlbEBub25nbnUub3JnPjsgQWxpc3RhaXIgRnJhbmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3
ZGMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSByaXNjdi9zcGlrZTogQ2hhbmdlIHRoZSBk
ZWZhdWx0IGJpb3MgdG8gdXNlIHBsYWluIGJpbmFyeQ0KPiBpbWFnZQ0KPiANCj4gT24gRnJpLCBN
YXkgMSwgMjAyMCBhdCA4OjQxIFBNIEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+IHdy
b3RlOg0KPiA+DQo+ID4gT24gRnJpLCBNYXkgMSwgMjAyMCBhdCA2OjAxIFBNIEJpbiBNZW5nIDxi
bWVuZy5jbkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEZyb206IEJpbiBNZW5nIDxi
aW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KPiA+ID4NCj4gPiA+IFRvIGtlZXAgc3luYyB3aXRoIG90
aGVyIFJJU0MtViBtYWNoaW5lcywgY2hhbmdlIHRoZSBkZWZhdWx0IGJpb3MgdG8NCj4gPiA+IHVz
ZSAuYmluIGluc3RlYWQgb2YgdGhlIC5lbGYgaW1hZ2VzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KPiA+ID4gLS0tDQo+ID4g
Pg0KPiA+ID4gIGh3L3Jpc2N2L3NwaWtlLmMgfCA0ICsrLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9ody9yaXNjdi9zcGlrZS5jIGIvaHcvcmlzY3Yvc3Bpa2UuYyBpbmRleA0KPiA+ID4gZDBj
NDg0My4uNjExYTc0MSAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L3Jpc2N2L3NwaWtlLmMNCj4gPiA+
ICsrKyBiL2h3L3Jpc2N2L3NwaWtlLmMNCj4gPiA+IEBAIC00Niw5ICs0Niw5IEBADQo+ID4gPiAg
I2luY2x1ZGUgPGxpYmZkdC5oPg0KPiA+ID4NCj4gPiA+ICAjaWYgZGVmaW5lZChUQVJHRVRfUklT
Q1YzMikNCj4gPiA+IC0jIGRlZmluZSBCSU9TX0ZJTEVOQU1FICJvcGVuc2JpLXJpc2N2MzItc3Bp
a2UtZndfanVtcC5lbGYiDQo+ID4gPiArIyBkZWZpbmUgQklPU19GSUxFTkFNRSAib3BlbnNiaS1y
aXNjdjMyLXNwaWtlLWZ3X2p1bXAuYmluIg0KPiA+ID4gICNlbHNlDQo+ID4gPiAtIyBkZWZpbmUg
QklPU19GSUxFTkFNRSAib3BlbnNiaS1yaXNjdjY0LXNwaWtlLWZ3X2p1bXAuZWxmIg0KPiA+ID4g
KyMgZGVmaW5lIEJJT1NfRklMRU5BTUUgIm9wZW5zYmktcmlzY3Y2NC1zcGlrZS1md19qdW1wLmJp
biINCj4gPiA+ICAjZW5kaWYNCj4gPg0KPiA+IFRoaXMgY2hhbmdlIGJyZWFrcyB0aGUgY29uc29s
ZSBvbiB0aGUgc3Bpa2UgbWFjaGluZSBiZWNhdXNlIEhUSUYNCj4gPiBlbXVsYXRpb24gZGVwZW5k
cyBvbiBFTEYgcGFyc2luZy4NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIGFkZCBzb21lIGNvbW1l
bnRzIGhlcmUuDQoNClN1cmUsIGFkZGluZyBjb21tZW50cyBoZXJlIGFib3V0IEVMRiByZXF1aXJl
bWVudCBpcyBjZXJ0YWlubHkgaGVscGZ1bC4NCg0KPiANCj4gPg0KPiA+IEtlZXBpbmcgaGVyZSBF
TEYgZmlsZXMgd2FzIGludGVudGlvbmFsIGJlY2F1c2UgQklOIGZpbGVzIGRvbnQgd29yayBmb3IN
Cj4gPiBTcGlrZSB0aGUgbWFjaGluZS4NCj4gPg0KPiA+IEFsc28sIG5vdyB0aGF0IE9wZW5TQkkg
Z2VuZXJpYyBwbGF0Zm9ybSBpcyBhdmFpbGFibGUuIFdlIGNhbiB1c2Ugc2FtZQ0KPiA+IE9wZW5T
QkkgZmlybXdhcmUgYmluYXJpZXMvZWxmcyBvbiB2aXJ0LCBzaWZpdmVfdSwgYW5kIHNwaWtlIG1h
Y2hpbmVzDQo+ID4gb2YgUUVNVS4gSSB0aGluazoNCj4gPiAxLiBUaGUgUUVNVSBidWlsZC9tYWtl
ZmlsZSBzY3JpcHRzIGZvciBPcGVuU0JJIHNob3VsZCBiZSB1cGRhdGVkIHRvDQo+ID4gb25seSBi
dWlsZCBPcGVuU0JJIGdlbmVyaWMgcGxhdGZvcm0gZmlybXdhcmVzIDIuIFRoZSBkZWZhdWx0DQo+
ID4gQklPU19GSUxFTkFNRSBpbiBmb3IgdmlydCwgc2lmaXZlX3UsIGFuZCBzcGlrZSBtYWNoaW5l
cyBzaG91bGQgYmUNCj4gPiBjaGFuZ2VkIHRvIHVzZSBPcGVuU0JJIGdlbmVyaWMgcGxhdGZvcm0g
ZmlybXdhcmVzLg0KPiA+DQo+ID4gSXQgd291bGQgYmUgZ3JlYXQgaWYgeW91IGNhbiBkcm9wIHRo
aXMgcGF0Y2ggYW5kIGluc3RlYWQgZG8gYWJvdmUgdHdvDQo+ID4gY2hhbmdlcy4gQWdyZWUgPz8N
Cj4gDQo+IEFncmVlLg0KDQpDb28sIHRoYW5rcy4NCg0KUmVnYXJkcywNCkFudXANCg0K


Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9DEC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4BD20759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="jPOggrmF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ggMRAiJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4BD20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1SU-0007hc-E7
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=536559953=Niklas.Cassel@wdc.com>)
 id 1kO1NI-000200-2l; Thu, 01 Oct 2020 12:24:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:27981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=536559953=Niklas.Cassel@wdc.com>)
 id 1kO1NF-0002Zo-9j; Thu, 01 Oct 2020 12:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601570621; x=1633106621;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=XGZqyFYBwbkgLhWWbozlOK53+WZapxw4Nh3W4Y6Msxo=;
 b=jPOggrmFMiL6/zGVmVm3s/0XxDoH4mbwghBtgnMxJKO1QjIMP2a1D/qY
 +naOAt8dyprafXnuY/2Bip26u0ggMRZlYCFwkC0ZmlP27b4m9F7NriApf
 KLA9sh5nOjmyUiQkQjZxets0lNCAlM42enXilWg2MDIXY/AsEa+Q5H1XS
 3LuElaOU0quagROSP00PO5UlnFv8hrvBVmxcjL78gqfGnbuuAWrIfpgCn
 2GkNoL2AjHvYJUy5dTSepi6FaQIRhS9wXA/HpV9BWK0rhGh8hjTD3rOBf
 Q4sqbJ+xo8pvexI/bFhkMqXex9jbBjSAbvIrVPyh0ShQplsJgBGyU5Oka Q==;
IronPort-SDR: 7VL+Sd1SurthjOaHFXaq+8iEtdjdmlab2QT5zT7fNUwjGgyj16Ek4rSStgAXWKytRwtTkg8uc5
 oPy7jV0ofVGR0ZrvlY+4kExilPGEOhDbYzMusz/142mGYgyI8dpBtSda2S7EuJeaxOY8IcrC22
 J9x20ItA+CJ+6qJD5amXWzh0hJb+jTHXFA6GIuNbCZc5taq9Qc4czFKzVk+SJh9B709AyPgnrd
 kD3CzYZfFhAW7UefKj3f09jrRq2PcuFyqMdYlRz0I5Y3UoKLYt7rtdDtWXtQuKmCQ6l3WYogB4
 kD8=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="252220049"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 00:43:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO5+NHcb6/ZIzIiozSqy43pR7t8UFFNb3SveCmH6XprdyABpWcYuau0MP0OvxidON88rFT8iTJhkHfdwEtDX+Dc2RkEkQlrEKb/4bfjM1WHU5JW4eIJzbSISeBrrF64QeZBOjyq4CYaqpWLxY2DGReaBBMxr3AD+1olH7Zg6uHTcSdVzVJhTA5L0giIBdS2yfJtNliMBd3kpQDt+xVppx5kklkA+rWaO6pOFNx0hM/hwY/E54v+7/mAalixEl7sjpUh0lVy25HYCiO62ZVOUNwqOI0xyfI3AvAsXpvW71XGZjAO6oL8AJzTWnBpwvFePaI/+tdCKWWLCZlLYq4F18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGZqyFYBwbkgLhWWbozlOK53+WZapxw4Nh3W4Y6Msxo=;
 b=c1KzMLmMHDGVm/caogK5NTj6KuT3KZvRaVN1+dxgaahcRGieX3NiYAMXCFVzFUDdZ6Ag8a45GzyX43IpA190DkWf2ynBVZyRaCnpfCK6seWKw7N8rGN5I8eOzoQLAv21lZ7TsPHF8NyZwPrOffPpYVCho9AUhXgHXGGL+lsg2hy4z+FOA+/eiC8TqJugC0ZQu1MeESXxOP7QL02s2T0Mn0g+nRJu3Oth+tTkzdRivNMiiHGefQnCSJ7N+lHmTxPF5RqShCCEfG9GPvEqFBCsxo4ek7yVU+u/POcMBnx6CrjNPF91FzmzQn0WZ6wJIDmUxyplF8+bShvVRyLMu2EWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGZqyFYBwbkgLhWWbozlOK53+WZapxw4Nh3W4Y6Msxo=;
 b=ggMRAiJjPpX+82qRWsP01nG6T7vhy2SeBvSqT8jNF24LqEdn54fF/gZA0JDy2tS3t47oO7xnS8QKV4uSkIhZVuAJwSINiWBfDzFR3Gmf82QBlHsQUyWPsg0Y0gDMnG5g8ELlwuwz4ZdbiEiwKzQlNpPfSNVNKtTyvU40Ako1XNw=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB5202.namprd04.prod.outlook.com (2603:10b6:408:3a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 16:23:56 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 16:23:56 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWlUAVwLU3dDmYeECN1HNLSzDofqmCn96AgABE5wCAAAXtAIAAAoCAgAAG0YA=
Date: Thu, 1 Oct 2020 16:23:56 +0000
Message-ID: <20201001162355.GA339198@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
 <20201001112245.GA316454@localhost.localdomain>
 <20201001152922.GC3343@C02WT3WMHTD6>
 <20201001155034.GA337287@localhost.localdomain>
 <20201001155931.GA564651@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20201001155931.GA564651@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ec43b0bb-4c71-4dce-edce-08d866266557
x-ms-traffictypediagnostic: BN7PR04MB5202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB5202F1F7D4D802BBD7C21771F2300@BN7PR04MB5202.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aMKuDHJpGP0fOMhWk5OAzzL7eMRV92oJXLmgU1cvBVMnIuXsmtwX8EAAnI7nrMmjnfvK2N0kaek7pAvQf9OIlYdppvyxp1R224qI4guQDEr8wxQMH4W/LandNScTTlO/aFUmEWylPC3VClvCy1aJcVzdcaTZhO0xTYVtMuHiefghirfK2K1UnfWQR6LMeBZboOypNo6m9CFudNDXy4oPRXZce4YjoIqCY7yP8uvbBL0rm/HQCD/F5OZnN/Lsl/k0zORznvRT5jrFdI4g9NDclxaxdEZws2AUMwpIS9iTzjQzFUdDagRhc/rjb+IZTMUH90a03g8cZ6n0XhOPCzQKBw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(71200400001)(186003)(54906003)(26005)(2906002)(83380400001)(76116006)(1076003)(91956017)(6506007)(478600001)(33656002)(6916009)(86362001)(6512007)(9686003)(66556008)(5660300002)(8936002)(6486002)(66446008)(8676002)(66476007)(64756008)(4326008)(66946007)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 22j0nMRnd+D9EKOtuArcmCaONkNcppd7MvGAhJM6NLWUoHWI9x5uljd966Osiio+eAkWPHwH5PZwnJzGtd2qGbX+f9kH1ym8XUmnas56SM/NPRi9AhroX5Xhq8O0ul12d63AWLSDUAY5ZfZEAnxKk0l2LONGMe3ky3EMaPMFcWb5WhpGQ1/enOUh2kJkD+Ham9KFf04bp+qrMmv/EBFaptKtNNrW02Lvy8H87MlQLpNUTIx/E0PooYNzT5PauBw5O+uL3mTHusPK6jdrQ/8BacSoEnLWLcexWD2jqgU6bu+dDsIQQKVst8IYE33V0XuSBbJ1unqIAIcR65XT/6pumM5GwRWNWjtWL/+2fFGjm2jaRbnrNTn6Wp3rspv9juxmfmb3v1SwUjaXr0VJEdMbhLq7Z5u7C977mNUenORW8z4DzY0HxfJ2YpP+zLxd8kFDsS09GyQ/4ZEfPHuCR7E5xh0MVpZ/u6BeYbtt0Kpz7hZgeNf2I4UYrbnoV2Ba/20rzHqdn053JqsU67DhGwoaJBrzVIOB9KgfwJtey2LGeeAnWmheMjKf2nnQSChNkb5ioNUJNQoqAdGKSRYRRhtInq5gwi/+i/YiWzyiq924cxDuG2UleHRPJ0jgo+Rlat2jgma+eh9+r4rhj28JfvZD3A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D086E1F020646445BB93E5A8A2FA2C14@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec43b0bb-4c71-4dce-edce-08d866266557
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 16:23:56.5807 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aPaDuaaTHht209lmRZxEz/ZiR+pDrc/dnD67fJ50/RW3Ort4l9wFvjj140fMNOZ2+jZqfsfaljLMdYhIJgoL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5202
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=536559953=Niklas.Cassel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 12:24:01
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMDg6NTk6MzFBTSAtMDcwMCwgS2VpdGggQnVzY2ggd3Jv
dGU6DQo+IE9uIFRodSwgT2N0IDAxLCAyMDIwIGF0IDAzOjUwOjM1UE0gKzAwMDAsIE5pa2xhcyBD
YXNzZWwgd3JvdGU6DQo+ID4gT24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMDk6Mjk6MjJBTSAtMDYw
MCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+ID4gPiBPbiBUaHUsIE9jdCAwMSwgMjAyMCBhdCAxMToy
Mjo0NkFNICswMDAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0KPiA+ID4gPiBPbiBNb24sIFNlcCAy
OCwgMjAyMCBhdCAxMTozNToxOUFNICswOTAwLCBEbWl0cnkgRm9taWNoZXYgd3JvdGU6DQo+ID4g
PiA+ID4gRnJvbTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3NlbEB3ZGMuY29tPg0KPiA+ID4g
PiA+IEBAIC0yMjIyLDYgKzIzMjgsMzAgQEAgc3RhdGljIHZvaWQgbnZtZV93cml0ZV9iYXIoTnZt
ZUN0cmwgKm4sIGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IGRhdGEsDQo+ID4gPiA+ID4gICAgICAg
ICAgYnJlYWs7DQo+ID4gPiA+ID4gICAgICBjYXNlIDB4MTQ6ICAvKiBDQyAqLw0KPiA+ID4gPiA+
ICAgICAgICAgIHRyYWNlX3BjaV9udm1lX21taW9fY2ZnKGRhdGEgJiAweGZmZmZmZmZmKTsNCj4g
PiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICAgaWYgKE5WTUVfQ0NfQ1NTKGRhdGEpICE9IE5W
TUVfQ0NfQ1NTKG4tPmJhci5jYykpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgaWYgKE5WTUVf
Q0NfRU4obi0+YmFyLmNjKSkgew0KPiA+ID4gPiANCj4gPiA+ID4gSSBqdXN0IHNhdyB0aGlzIHBy
aW50IHdoZW4gZG9pbmcgY29udHJvbGxlciByZXNldCBvbiBhIGxpdmUgc3lzdGVtLg0KPiA+ID4g
PiANCj4gPiA+ID4gQWRkZWQgYSBkZWJ1ZyBwcmludDoNCj4gPiA+ID4gbnZtZV93cml0ZV9iYXIg
V1JJVElORzogMHgwIHByZXZpb3VzOiAweDQ2NDA2MQ0KPiA+ID4gPiANCj4gPiA+ID4gc28gdGhl
IHNlY29uZCBpZi1zdGF0ZW1lbnQgaGFzIHRvIGJlOg0KPiA+ID4gPiANCj4gPiA+ID4gICAgIGlm
IChOVk1FX0NDX0VOKG4tPmJhci5jYykgJiYgTlZNRV9DQ19FTihkYXRhKSkgew0KPiA+ID4gPiAN
Cj4gPiA+ID4gU29ycnkgZm9yIGludHJvZHVjaW5nIHRoZSBidWcgaW4gdGhlIGZpcnN0IHBsYWNl
Lg0KPiA+ID4gDQo+ID4gPiBObyB3b3JyaWVzLg0KPiA+ID4gDQo+ID4gPiBJIGRvbid0IHRoaW5r
IHRoZSBjaGVjayBzaG91bGQgYmUgaGVyZSBhdCBhbGwsIHJlYWxseS4gVGhlIG9ubHkgY2hlY2sg
Zm9yIHZhbGlkDQo+ID4gPiBDU1Mgc2hvdWxkIGJlIGluIG52bWVfc3RhcnRfY3RybCgpLCB3aGlj
aCBJIHBvc3RlZCB5ZXN0ZXJkYXkuDQo+ID4gDQo+ID4gVGhlIHJlYXNvbmluZyBmb3IgdGhpcyBh
ZGRpdGlvbmFsIGNoZWNrIGlzIHRoaXM6DQo+ID4gDQo+ID4gRnJvbSBDQy5DQyByZWdpc3RlciBk
ZXNjcmlwdGlvbjoNCj4gPiANCj4gPiAiVGhpcyBmaWVsZCBzaGFsbCBvbmx5IGJlIGNoYW5nZWQg
d2hlbiB0aGUgY29udHJvbGxlcg0KPiA+IGlzIGRpc2FibGVkIChDQy5FTiBpcyBjbGVhcmVkIHRv
IOKAmDDigJkpLiINCj4gPiANCj4gPiBJbiB0aGUgUUVNVSBtb2RlbCwgd2UgaGF2ZSBmdW5jdGlv
bnMsIGUuZy4gbnZtZV9jbWRfZWZmZWN0cygpLA0KPiA+IHRoYXQgdXNlcyBuLT5iYXIuY2MgImF0
IHJ1bnRpbWUiLg0KPiA+IA0KPiA+IFNvIEkgZG9uJ3QgdGhpbmsgdGhhdCBzaW1wbHkgY2hlY2tp
bmcgZm9yIHZhbGlkIENTUyBpbg0KPiA+IG52bWVfc3RhcnRfY3RybCgpIGlzIHN1ZmZpY2llbnQu
DQo+ID4gDQo+ID4gVGhvdWdodHM/DQo+IA0KPiBUaGUgcWVtdSBjb250cm9sbGVyIGFjY2VwdHMg
aG9zdCByZWdpc3RlciB3cml0ZXMgb25seSBmb3IgdmFsaWQgZW5hYmxlDQo+IGFuZCBzaHV0ZG93
biAgYml0IHRyYW5zaXRpb25zLiBPciBhdCBsZWFzdCBpdCBzaG91bGQuIElmIG5vdCwgdGhlbiB3
ZQ0KPiBuZWVkIHRvIGZpeCB0aGF0LCBidXQgdGhhdCdzIG5vdCBzcGVjaWZpYyB0byB0aGUgQ1NT
IGJpdHMuDQoNCkkgc2ltcGx5IGFkZGVkIHRoZSBzZWNvbmQgaWYtc3RhdGVtZW50LCAoaWYgKE5W
TUVfQ0NfRU4obi0+YmFyLmNjKSkpLA0KdGhlIHJlc3Qgb2YgdGhlIE5WTUVfQ0NfQ1NTIHdhcyB3
cml0dGVuIGJ5IHNvbWVvbmUgZWxzZS4NCg0KQnV0IEkgc2VlIHlvdXIgcG9pbnQsIGFsbCBvZiB0
aGlzIGNvZGU6DQoNCiAgICAgICAgaWYgKE5WTUVfQ0NfQ1NTKGRhdGEpICE9IE5WTUVfQ0NfQ1NT
KG4tPmJhci5jYykpIHsNCiAgICAgICAgICAgIGlmIChOVk1FX0NDX0VOKG4tPmJhci5jYykpIHsN
CiAgICAgICAgICAgICAgICBOVk1FX0dVRVNUX0VSUihwY2lfbnZtZV9lcnJfY2hhbmdlX2Nzc193
aGVuX2VuYWJsZWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImNoYW5naW5nIHNl
bGVjdGVkIGNvbW1hbmQgc2V0IHdoZW4gZW5hYmxlZCIpOw0KICAgICAgICAgICAgfSBlbHNlIHsN
CiAgICAgICAgICAgICAgICBzd2l0Y2ggKE5WTUVfQ0NfQ1NTKGRhdGEpKSB7DQogICAgICAgICAg
ICAgICAgY2FzZSBDU1NfTlZNX09OTFk6DQogICAgICAgICAgICAgICAgICAgIHRyYWNlX3BjaV9u
dm1lX2Nzc19udm1fY3NldF9zZWxlY3RlZF9ieV9ob3N0KGRhdGEgJg0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweGZmZmZm
ZmZmKTsNCiAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICBjYXNlIENTU19D
U0k6DQogICAgICAgICAgICAgICAgICAgIE5WTUVfU0VUX0NDX0NTUyhuLT5iYXIuY2MsIENTU19D
U0kpOw0KICAgICAgICAgICAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9jc3NfYWxsX2NzZXRzX3Nl
bF9ieV9ob3N0KGRhdGEgJg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDB4ZmZmZmZmZmYpOw0KICAgICAgICAgICAgICAgICAgICBi
cmVhazsNCiAgICAgICAgICAgICAgICBjYXNlIENTU19BRE1JTl9PTkxZOg0KICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICBkZWZhdWx0Og0KICAgICAgICAgICAgICAg
ICAgICBOVk1FX0dVRVNUX0VSUihwY2lfbnZtZV91Yl91bmtub3duX2Nzc192YWx1ZSwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInVua25vd24gdmFsdWUgaW4gQ0MuQ1NTIGZp
ZWxkIik7DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgfQ0KICAgICAgICB9DQoNCnNo
b3VsZCBzaW1wbHkgYmUgZHJvcHBlZC4NCg0KTm8gbmVlZCB0byBjYWxsIE5WTUVfU0VUX0NDX0NT
UygpIGV4cGxpY2l0bHkuDQoNCkNDLkNTUyBiaXQgd2lsbCBiZSBzZXQgZnV0aGVyIGRvd24gaW4g
dGhpcyBmdW5jdGlvbiBhbnl3YXk6DQoNCiAgICAgICAgaWYgKE5WTUVfQ0NfRU4oZGF0YSkgJiYg
IU5WTUVfQ0NfRU4obi0+YmFyLmNjKSkgew0KICAgICAgICAgICAgbi0+YmFyLmNjID0gZGF0YTsN
Cg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=


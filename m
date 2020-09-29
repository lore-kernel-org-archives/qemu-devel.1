Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE47C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0D4206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RH9qiYdy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pb3I1ay+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0D4206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHqx-0006x0-Bt
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNHmx-0002ni-N7; Tue, 29 Sep 2020 11:43:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=534de8db0=Dmitry.Fomichev@wdc.com>)
 id 1kNHmv-0004IR-4a; Tue, 29 Sep 2020 11:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601394708; x=1632930708;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=maqowfkH4tO1MIePggIrlLTfnbNAiva4fjVmypm0XlA=;
 b=RH9qiYdyHfZved7H19Ap+pzigWJnxNxpp5NTElPweaM6jiH0c9c3j19G
 3qtezzZtSakbsP8ODMbO2XeWREIbgtVdSNYDJ3u6hI0A8HEUMlozvLl/D
 AHxK1TsA7Z6PXGYudvGi5WHYiLj/pTtPIznP9szH4Kv//7AKdBj9iFps9
 1EOBySEIzeT928Y0lQiOntHrWOcJYP11plqkY9nuRH7Nh7ySzuShhzBN5
 86GcLfZKameDK4Tu1aJr95mT/Ka/doGFTVv6YmZy/iW/B64CFqBMGPk3g
 61IGk/C40cviWTu0dUtkGHfNeFSqDoGnswmOTSNmu2jBx/Q74zKazxQCE Q==;
IronPort-SDR: NvrkxmEz0NRv9ia1RZ2i5CFGL2oxnbAAms+oSXhGIAZzeM5dXKDMnAv/LZL+Kr9+nEDFASUGHN
 h8KGpFNfwrRrZB0txmINrvBcvMEufTjl9PsJM0NXAVZAk31m5LSR9L+RmXAIwnF8rt5xuME3ng
 oi0sb55f6EbAn3Jb9m20UUZrIHyi5DxD6c+H1e9PutiATaOS31lAcMUn5Xn2Da4lGdP2tiCdMw
 00btxNCQRWbKQOEIyZlhsRSenFc2eE0UvwU9FHmI/obaQZwWAS/WVyw8NnBe9bGNusQtczC22z
 p48=
X-IronPort-AV: E=Sophos;i="5.77,319,1596470400"; d="scan'208";a="251969662"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2020 23:51:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4owfhDMBZjvzm/O5VtNXwyZ5AJEL+Tm0qqhNQ0e+D9kc030CtmohK+UJJfvRguT/bEPLhSF9Q2zdaSouj9zCPnFjGAd8kFCSzXQDrYCPOkdejnwhbT8SzjmJL4Kc47myAsjz4CxVtxpi2u8++YFrcrK4lMq9RXNwHKTawDki+bbUs+PeRKudC4kyC+wRe4ycW0CudzvNbEUeuEFD4DO8PxZGkZCKMLyeJqVZ6CPbT4zLQsNcDDL65nwZieFboEed5U6J71csOEq/Sns2WZxMxA9oX+pTK3GNVh/MClOt9rKiwqk9dvuzjOXUZm5k3cYg6GGcqycq2a8p22sLl2UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maqowfkH4tO1MIePggIrlLTfnbNAiva4fjVmypm0XlA=;
 b=YDIz51FK07WczU6bhxaiMcnZyZvDXzm7bKDrrBkOySSIxWrnWm64JrbvrtkZVbZP+IkKEvWyI24tsDQEJN22H2xFIeM8+NZapNZY5fwxZvGXjG1S6Is1qFVW3FDIAAp9CYOvKh5kLvtMCNYmARALz1p4ZRZSpUsz+235yFq8X+H/007t/Zh4TRlQ9zG5WiN42aXozbA5FZuClkHUSHB1tUA96yBvuCVDYtyzXvycdcLvz21ZzwkeSoVoC3roezB/2u/vqmc6xZFz8UYuPBD0v4Y0+zFIyTMsZFUnD/GeiQeyv2WmW7GD6XQXSqu16mwCiVvXZkjMkltRY9GqHCtEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maqowfkH4tO1MIePggIrlLTfnbNAiva4fjVmypm0XlA=;
 b=pb3I1ay+o4XuAHn40EaKN/jrMzlbXMu3/pcZcGXhSmLEWvMwSZTxJYTSP0rTHPCDpg6VD70IecPl5dbJetoG5LRU6fJR+v4poqpIOvUq4kN8GpGURdQLxh+TMnDW/0l6SqqbWqMEtL/Peq/yD+TngYhmpma6vCUIlCS1wsknJzE=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5693.namprd04.prod.outlook.com (2603:10b6:208:a0::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 15:43:21 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 15:43:21 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: RE: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v4 00/14] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWkdZJY2r+3+EgB0+n1uDhiCCmB6l/d+uAgABCkxA=
Date: Tue, 29 Sep 2020 15:43:21 +0000
Message-ID: <MN2PR04MB59517FB6076902451F463C5FE1320@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200923182021.3724-1-dmitry.fomichev@wdc.com>
 <20200924210751.GD1738917@apples.localdomain>
 <MN2PR04MB59515B1EA1238861DFF3236AE1350@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200928063648.GA1967@apples.localdomain>
 <20200928212541.GC227320@dhcp-10-100-145-180.wdl.wdc.com>
 <CY4PR04MB3751997C2ED1D5EFB69E32ACE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200929104633.GA179147@apples.localdomain>
In-Reply-To: <20200929104633.GA179147@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc94a354-5007-45ce-0ef5-08d8648e64c5
x-ms-traffictypediagnostic: MN2PR04MB5693:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5693538CB1F5828D5F22B70AE1320@MN2PR04MB5693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z3N60SioO8DdGNIFTKRnGTcDkqT372T2FnkT0ytD5H6HW39tlrwi9/dW0zZfDaXue3GlUpluKeQVnmF/5RaHuEQZi3+6KXqHltimNcbDh7VYZO/nRsoBUQl0tYGNXCvJejvZEZ0ABmqql0KsACkBwt4D3WN63QT+UiMi/4fQObMC0EPTob3GFxu2P5dQGxQfwrv1gU6mgr3PSOxQ1DO+luiy94PMdYEaOpFSfEmkcRXLdWEINiKzuIAzSHdEmQZklN113I4E1lhovKC/CYEWS18unWggQPWCKn3XhVKixCPkUx+0fBJRYQaviaNPHrf9MuerQ42biEnUE+leH7+T1A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(5660300002)(33656002)(76116006)(8936002)(71200400001)(2906002)(6506007)(53546011)(9686003)(55016002)(52536014)(7696005)(186003)(86362001)(478600001)(6636002)(26005)(83380400001)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(110136005)(316002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: unR9D3JAsJp+GvhI1g7Y+5QGCq9Mo7zJfw2hOhyA1tBow7PqjZAhDTkOTiPHZcLXKZSRGK+E+ZepYd2rWo9yBi/IDIMvYhelBG5eUbjJOZteKeYGrNFWKyCNGC41l3HteRsr8IT+QJG8etKLgqhgq7pGmQb7OZc+0PoQPj1XbXN/17mmDw0BkfFR5Y8o9RzqEYHW2fdpbvdLLCUEjAcRNNUzy5OSo+z6DdfhycdgmFeJHKC0pMDHaxqpP+8eh+zKXukXtrhHiCLULnEDGqtKDfS6yugWHf/7LOtvMgBd5QJYu3uh+++L79cS3+Bf4KjZQkoPyrbI9sBJUao+mPNJn4jxk1kREShs83DbsOB0T6sb1jduzUqLjzXahjQWjVNSe5Ixg60b0wSIIF16jxcsEzr/nuczoz6bQ6MMkWwG9U8eH0Tdj145pUkrTNbCuWE4aQz547WPZnINv2Lec3JAT3oMgxO6YMTABkU6aGYCPcekZUY2Bb/w89SmMziVmE9Apy4qY5rHAH/kByiF2qyXB/5gG5Qy/miMrUyySUmTJkBgnwiGvyKpyc7eM+zZwJWesmY3k5ygs/iKe7ORjXcs4SQ9DGnSGIFTF+RBowXU8vNUNsnx7ciBO0aQH2d6BbTn8GThxInD9SXY2Xym8q0gNw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc94a354-5007-45ce-0ef5-08d8648e64c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 15:43:21.0775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4P2DyX4vZyGMFeBHAlDyEW7l4ZP2VaRu0aMqzlIfDDQ23OGwLNCFB8S5F6trHsKB2/3yaWguaqQOjq//xWdRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5693
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=534de8db0=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 11:43:31
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
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWJsb2NrIDxxZW11LWJs
b2NrLQ0KPiBib3VuY2VzK2RtaXRyeS5mb21pY2hldj13ZGMuY29tQG5vbmdudS5vcmc+IE9uIEJl
aGFsZiBPZiBLbGF1cw0KPiBKZW5zZW4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI5LCAy
MDIwIDY6NDcgQU0NCj4gVG86IERhbWllbiBMZSBNb2FsIDxEYW1pZW4uTGVNb2FsQHdkYy5jb20+
DQo+IENjOiBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgS2V2aW4gV29sZiA8a3dvbGZAcmVk
aGF0LmNvbT47IHFlbXUtDQo+IGJsb2NrQG5vbmdudS5vcmc7IE5pa2xhcyBDYXNzZWwgPE5pa2xh
cy5DYXNzZWxAd2RjLmNvbT47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMNCj4gPEFsaXN0YWlyLkZy
YW5jaXNAd2RjLmNvbT47IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IFBoaWxpcHBl
DQo+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT47IE1hdGlhcyBCam9ybGluZw0K
PiA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAv
MTRdIGh3L2Jsb2NrL252bWU6IFN1cHBvcnQgTmFtZXNwYWNlIFR5cGVzDQo+IGFuZCBab25lZCBO
YW1lc3BhY2UgQ29tbWFuZCBTZXQNCj4gDQo+IE9uIFNlcCAyOCAyMjo1NCwgRGFtaWVuIExlIE1v
YWwgd3JvdGU6DQo+ID4gT24gMjAyMC8wOS8yOSA2OjI1LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4g
PiA+IE9uIE1vbiwgU2VwIDI4LCAyMDIwIGF0IDA4OjM2OjQ4QU0gKzAyMDAsIEtsYXVzIEplbnNl
biB3cm90ZToNCj4gPiA+PiBPbiBTZXAgMjggMDI6MzMsIERtaXRyeSBGb21pY2hldiB3cm90ZToN
Cj4gPiA+Pj4gWW91IGFyZSBtYWtpbmcgaXQgc291bmQgbGlrZSB0aGUgZW50aXJlIFdEQyBzZXJp
ZXMgcmVsaWVzIG9uIHRoaXMNCj4gYXBwcm9hY2guDQo+ID4gPj4+IEFjdHVhbGx5LCB0aGUgcGVy
c2lzdGVuY3kgaXMgaW50cm9kdWNlZCBpbiB0aGUgc2Vjb25kIHRvIGxhc3QgcGF0Y2ggaW4gdGhl
DQo+ID4gPj4+IHNlcmllcyBhbmQgaXQgb25seSBhZGRzIGEgY291cGxlIG9mIGxpbmVzIG9mIGNv
ZGUgaW4gdGhlIGkvbyBwYXRoIHRvIG1hcmsNCj4gPiA+Pj4gem9uZXMgZGlydHkuIFRoaXMgaXMg
cG9zc2libGUgYmVjYXVzZSBvZiB1c2luZyBtbWFwKCkgYW5kIEkgZmluZCB0aGUgd2F5DQo+ID4g
Pj4+IGl0IGlzIGRvbmUgdG8gYmUgcXVpdGUgZWxlZ2FudCwgbm90IHVnbHkgOikNCj4gPiA+Pj4N
Cj4gPiA+Pg0KPiA+ID4+IE5vLCBJIHVuZGVyc3RhbmQgdGhhdCB5b3VyIGltcGxlbWVudGF0aW9u
IHdvcmtzIGZpbmUgd2l0aG91dA0KPiA+ID4+IHBlcnNpc3RhbmNlLCBidXQgcGVyc2lzdGFuY2Ug
aXMga2V5LiBUaGF0IGlzIHdoeSBteSBzZXJpZXMgYWRkcyBpdCBpbg0KPiA+ID4+IHRoZSBmaXJz
dCBwYXRjaC4gV2l0aG91dCBwZXJzaXN0ZW5jZSBpdCBpcyBqdXN0IGEgdG95LiBBbmQgdGhlIFFF
TVUNCj4gPiA+PiBkZXZpY2UgaXMgbm90IGp1c3QgYW4gIk5WTWUtdmVyc2lvbiIgb2YgbnVsbF9i
bGsuDQo+ID4gPg0KPiA+ID4gSSByZWFsbHkgdGhpbmsgd2Ugc2hvdWxkIGJlIGEgYml0IG1vcmUg
Y2F1dGlvdXMgb2YgY29tbWl0aW5nIHRvIGFuDQo+ID4gPiBvbi1kaXNrIGZvcm1hdCBmb3IgdGhl
IHBlcnNpc3RlbnQgc3RhdGUuIEJvdGggdGhpcyBhbmQgS2xhdXMnIHBlcnNpc3RlbnQNCj4gPiA+
IHN0YXRlIGZlZWxzIGEgYml0IGFkLWhvYywgYW5kIHdpdGggYWxsIHRoZSBvdGhlciBrbm9icyBw
cm92aWRlZCwgaXQNCj4gPiA+IGxvb2tzIHRvbyBlYXN5IHRvIGhhdmUgb3V0LW9mLXN5bmMgc3Rh
dGVzLCBvciBqdXN0IG5vdCBiZWluZyBhYmxlIHRvDQo+ID4gPiBib290IGF0IGFsbCBpZiBhIHFl
bXUgdmVyc2lvbnMgaGF2ZSBkaWZmZXJlbnQgb24tZGlzayBmb3JtYXRzLg0KPiA+ID4NCj4gPiA+
IElzIGFueW9uZSByZWFsbHkgY29uc2lkZXJpbmcgem9uZSBlbXVsYXRpb24gZm9yIHByb2R1Y3Rp
b24gbGV2ZWwgc3R1ZmYNCj4gPiA+IGFueXdheT8gSSBjYW4ndCBpbWFnaW5lIGEgcmVhbCBzY2Vu
YXJpbyB3aGVyZSB5b3UnZCB3YW50IHB1dCB5b3Vyc2VsZg0KPiA+ID4gdGhyb3VnaCB0aGF0OiB5
b3UgYXJlIGp1c3QgZ2l2aW5nIHlvdXJzZWxmIGFsbCB0aGUgZG93bnNpZGVzIG9mIGEgem9uZWQN
Cj4gPiA+IGJsb2NrIGRldmljZSBhbmQgbm9uZSBvZiB0aGUgYmVuZWZpdHMuIEFGQUlLLCB0aGlz
IGlzIHByb3ZpZGVkIGFzIGENCj4gPiA+IGRldmVsb3BtZW50IHZlaGljbGUsIGNsb3NlciB0byBh
ICJ0b3kiLg0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgd2Ugc2hvdWxkIGNvbnNpZGVyIHRyaW1taW5n
IHRoaXMgZG93biB0byBhIG1vcmUgbWluaW1hbCBzZXQgdGhhdA0KPiA+ID4gd2UgKmRvKiBhZ3Jl
ZSBvbiBhbmQgY29tbWl0IGZvciBpbmNsdXNpb24gQVNBUC4gV2UgY2FuIGl0ZXJhdGUgYWxsIHRo
ZQ0KPiA+ID4gYmVsbHMgJiB3aGlzdGxlcyBhbmQgZmx1c2ggb3V0IHRoZSBtZXRhIGRhdGEncyBk
YXRhIG1hcnNoYWxsaW5nIHNjaGVtZQ0KPiA+ID4gZm9yIHBlcnNpc3RlbmNlIGxhdGVyLg0KPiA+
DQo+ID4gKzEgb24gdGhpcy4gUmVtb3ZpbmcgdGhlIHBlcnNpc3RlbmNlIGFsc28gcmVtb3ZlcyB0
aGUgZGViYXRlIG9uDQo+IGVuZGlhbmVzcy4gV2l0aA0KPiA+IHRoYXQgb3V0IG9mIHRoZSB3YXks
IGl0IHNob3VsZCBiZSBzdHJhaWdodGZvcndhcmQgdG8gZ2V0IGFncmVlbWVudCBvbiBhDQo+IHNl
cmllcw0KPiA+IHRoYXQgY2FuIGJlIG1lcmdlZCBxdWlja2x5IHRvIGdldCBkZXZlbG9wZXJzIHN0
YXJ0ZWQgd2l0aCB0ZXN0aW5nIFpOUw0KPiBzb2Z0d2FyZQ0KPiA+IHdpdGggUUVNVS4gVGhhdCBp
cyB0aGUgbW9zdCBpbXBvcnRhbnQgZ29hbCBoZXJlLiA1LjkgaXMgYXJvdW5kIHRoZSBjb3JuZXIs
DQo+IHdlDQo+ID4gbmVlZCBzb21ldGhpbmcgZm9yIHBlb3BsZSB0byBnZXQgc3RhcnRlZCB3aXRo
IFpOUyBxdWlja2x5Lg0KPiA+DQo+IA0KPiBXYWl0LiBXaGF0LiBOby4gU3RvcCENCj4gDQo+IEl0
IGlzIHVubWlzdGFrYWJseSBjbGVhciB0aGF0IHlvdSBhcmUgaW52YWxpZGF0aW5nIG15IGFyZ3Vt
ZW50cyBhYm91dA0KPiBwb3J0YWJpbGl0eSBhbmQgZW5kaWFubmVzcyBpc3N1ZXMgYnkgc3VnZ2Vz
dGluZyB0aGF0IHdlIGp1c3QgcmVtb3ZlDQo+IHBlcnNpc3RlbnQgc3RhdGUgYW5kIGRlYWwgd2l0
aCBpdCBsYXRlciwgYnV0IHBlcnNpc3RlbmNlIGlzIHRoZSBraWxsZXINCj4gZmVhdHVyZSB0aGF0
IHNldHMgdGhlIFFFTVUgZW11bGF0ZWQgZGV2aWNlIGFwYXJ0IGZyb20gb3RoZXIgZW11bGF0aW9u
DQo+IG9wdGlvbnMuIEl0IGlzIG5vdCBhYm91dCB1c2luZyBlbXVsYXRpb24gaW4gcHJvZHVjdGlv
biAoYmVjYXVzZSB5ZWFoLA0KPiB3aHkgd291bGQgeW91PyksIGJ1dCBwZXJzaXN0ZW5jZSBpcyB3
aGF0IG1ha2VzIGl0IHBvc3NpYmxlIHRvIGRldmVsb3ANCj4gYW5kIHRlc3QgInpvbmVkIEZUTHMi
IG9yIHNvbWV0aGluZyB0aGF0IHJlcXVpcmVzIHJlY292ZXJ5IGF0IHBvd2VyIHVwLg0KPiBUaGlz
IGlzIHdoYXQgYWxsb3dzIHRlc3Rpbmcgb2YgaG93IHlvdXIgaG9zdCBzb2Z0d2FyZSBkZWFscyB3
aXRoIG9wZW5lZA0KPiB6b25lcyBiZWluZyB0cmFuc2l0aW9uZWQgdG8gRlVMTCBvbiBwb3dlciB1
cCBhbmQgdGhlIHBlcnNpc3RlbnQgdHJhY2tpbmcNCj4gb2YgTEJBIGFsbG9jYXRpb24gKGluIG15
IHNlcmllcykgY2FuIGJlIHVzZWQgdG8gcHJvcGVybHkgdGVzdCBlcnJvcg0KPiByZWNvdmVyeSBp
ZiB5b3UgbG9zdCBzdGF0ZSBpbiB0aGUgYXBwLg0KPiANCj4gUGxlYXNlLCB3b3JrIHdpdGggbWUg
b24gdGhpcyBpbnN0ZWFkIG9mIGp1c3QgcmVtb3Zpbmcgc3VjaCBhbiBlc3NlbnRpYWwNCj4gZmVh
dHVyZS4gU2luY2UgcGVyc2lzdGVuY2Ugc2VlbXMgdG8gYmUgdGhlIG9ubHkgdGhpbmcgd2UgYXJl
IHJlYWxseQ0KPiBkaXNjdXNzaW5nLCB3ZSBzaG91bGQgaGF2ZSBwbGVudHkgb2YgdGltZSB1bnRp
bCB0aGUgc29mdC1mcmVlemUgdG8gY29tZQ0KPiB1cCB3aXRoIGEgcHJvcGVyIHNvbHV0aW9uIG9u
IHRoYXQuDQo+IA0KPiBJIGFncmVlIHRoYXQgbXkgdmVyc2lvbiBoYWQgYSBmb3JtYXQgdGhhdCB3
YXMgcHJldHR5IGFkLWhvYyBhbmQgdGhhdA0KPiB3b24ndCBmbHkgLSBpdCBuZWVkcyBtYWdpYyBh
bmQgdmVyc2lvbiBjYXBhYmlsaXRpZXMgbGlrZSBpbiBEbWl0cnkncw0KPiBzZXJpZXMsIHdoaWNo
IGluY2lkZW50aWFsbHkgbG9va3MgYSBsb3QgbGlrZSB3aGF0IHdlIGRpZCBpbiB0aGUNCj4gT3Bl
bkNoYW5uZWwgaW1wbGVtZW50YXRpb24sIHNvIEkgYWdyZWUgd2l0aCB0aGUgc3RyYXRlZ3kuDQoN
CkFyZSB5b3UgaW5zaW51YXRpbmcgdGhhdCBJIHNvbWVob3cgdG9vayBzdHVmZiBmcm9tIE9DU1NE
IGNvZGUgYW5kIHRyeQ0KdG8gY2xhaW0gcHJpb3JpdHkgdGhpcyB3YXk/IEkgYW0gbm90IGF0IGFs
bCB0aGF0IGZhbWlsaWFyIHdpdGggdGhhdCBjb2RlLg0KQW5kIEkndmUgYWxyZWFkeSBzZW50IHlv
dSB0aGUgbGluayB0byB0Y211LXJ1bm5lciBjb2RlIHRoYXQgc2VydmVkIG1lDQphcyBhbiBpbnNw
aXJhdGlvbiBmb3IgaW1wbGVtZW50aW5nIHBlcnNpc3RlbmNlIGluIFdEQyBwYXRjaHNldC4NClRo
YXQgY29kZSBoYXMgYmVlbiBhcm91bmQgZm9yIHllYXJzLCB1c2VzIG1tYXAsIHdvcmtzIGdyZWF0
IGFuZCBoYXMNCm5vdGhpbmcgdG8gZG8gd2l0aCB5b3UuDQoNCj4gDQo+IFpOUy13aXNlLCB0aGUg
b25seSB0aGluZyBteSBpbXBsZW1lbnRhdGlvbiBzdG9yZXMgaXMgdGhlIHpvbmUNCj4gZGVzY3Jp
cHRvcnMgKGluIHNwZWMtbmF0aXZlIGxpdHRsZS1lbmRpYW4gZm9ybWF0KSBhbmQgdGhlIHpvbmUN
Cj4gZGVzY3JpcHRvciBleHRlbnNpb25zLiBTbyB0aGVyZSBhcmUgbm8gZW5kaWFuIGlzc3VlcyB3
aXRoIHRob3NlLiBUaGUNCj4gYWxsb2NhdGlvbiB0cmFja2luZyBiaXRtYXAgaXMgYWx3YXlzIHN0
b3JlZCBpbiBsaXR0bGUgZW5kaWFuLCBidXQNCj4gY29udmVydGVkIHRvIGJpZy1lbmRpYW4gaWYg
cnVubmluZyBvbiBhIGJpZy1lbmRpYW4gaG9zdC4NCj4gDQo+IExldCBtZSBqdXN0IGNvbmp1cmUg
c29tZXRoaW5nIHVwLg0KPiANCj4gICAgICNkZWZpbmUgTlZNRV9QU1RBVEVfTUFHSUMgLi4uDQo+
ICAgICAjZGVmaW5lIE5WTUVfUFNUQVRFX1YxICAgIDENCj4gDQo+ICAgICB0eXBlZGVmIHN0cnVj
dCBOdm1lUHN0YXRlSGVhZGVyIHsNCj4gICAgICAgICB1aW50MzJfdCBtYWdpYzsNCj4gICAgICAg
ICB1aW50MzJfdCB2ZXJzaW9uOw0KPiANCj4gICAgICAgICB1aW50NjRfdCBibGtfbGVuOw0KPiAN
Cj4gICAgICAgICB1aW50OF90ICBsYmFkczsNCj4gICAgICAgICB1aW50OF90ICBpb2NzOw0KPiAN
Cj4gICAgICAgICB1aW50OF90ICByc3ZkMThbMzA1NF07DQo+IA0KPiAgICAgICAgIHN0cnVjdCB7
DQo+ICAgICAgICAgICAgIHVpbnQ2NF90IHpzemU7DQo+ICAgICAgICAgICAgIHVpbnQ4X3QgIHpk
ZXM7DQo+ICAgICAgICAgfSBRRU1VX1BBQ0tFRCB6bnM7DQo+IA0KPiAgICAgICAgIHVpbnQ4X3Qg
IHJzdmQzMDg5WzEwMDddOw0KPiAgICAgfSBRRU1VX1BBQ0tFRCBOdm1lUHN0YXRlSGVhZGVyOw0K
PiANCg0KV2h5IGNvbmp1cmUgc29tZXRoaW5nIHRoYXQgYWxyZWFkeSBleGlzdHMgaW4gV0RDIHBh
dGNoc2V0PyBBbmQgdGhhdCBwYXJ0DQpoYXMgYmVlbiBwdWJsaXNoZWQgaW4gdGhlIHZlcnkgZmly
c3QgdmVyc2lvbiBvZiBvdXIgcGF0Y2hlcywgd2Vla3MgYmVmb3JlDQp5b3VyIGVudGlyZSBaTlMg
c2VyaWVzIHdhcyBwb3N0ZWQuIEFkZCBhbiByc3ZkW10gaGVyZSBhbmQgdGhlcmUgYW5kIHRoYXQg
Y29kZQ0KY2FuIGJlIGFzIHN1aXRhYmxlIHRvIGFjaGlldmUgdGhlIHN0YXRlZCBnb2FscyBhcyB3
aGF0IHlvdSBoYXZlIGFib3ZlLg0KDQo+IFdpdGggc3VjaCBhIGhlYWRlciB3ZSBoYXZlIGFsbCB3
ZSBuZWVkLiBXZSBjYW4gYmFpbCBvdXQgaWYgYW55DQo+IHBhcmFtZXRlcnMgZG8gbm90IG1hdGNo
IGFuZCBzaW1pbGFyIHRvIG52bWUgZGF0YSBzdHJ1Y3R1cmVzIGl0IGNvbnRhaW5zDQo+IHJlc2Vy
dmVkIGFyZWFzIGZvciBmdXR1cmUgdXNlLiBJJ2xsIGJlIHBvc3RpbmcgYSB2MiB3aXRoIHRoaXMu
IElmIHRoaXMNCj4gc3RpbGwgZmVlbHMgdG9vIGFkLWhvYywgd2UgY2FuIGJlIGluc3BpcmVkIGJ5
IFFDT1cyIGFuZCB0aGUgImV4dGVuc2lvbiINCj4gZmVhdHVyZS4NCj4gDQo+IEkgY2FuIGFncmVl
IHRoYXQgd2UgZHJvcCBvdGhlciBvcHRpb25hbCBmZWF0dXJlcyBsaWtlIHpvbmUgZXhjdXJzaW9u
cw0KPiBhbmQgdGhlIHJlc2V0L2ZpbmlzaCByZWNvbW1lbmRlZCBsaW1pdCBzaW11bGF0aW9uLCBi
dXQgUExFQVNFIERPIE5PVA0KPiByZW1vdmUgcGVyc2lzdGVuY2UgYW5kIHVwc3RyZWFtIGEgaGFs
Zi1iYWtlZCB2ZXJzaW9uIHdoZW4gd2UgYXJlIHNvDQo+IGNsb3NlIGFuZCBoYXZlIHRpbWUgdG8g
Z2V0IGl0IHJpZ2h0Lg0KDQpPbmUgaW1wb3J0YW50IHRoaW5nIElNTyBpcyB0byByZWR1Y2UgZnV0
dXJlIG5lZWQgZm9yIG1ldGFkYXRhIHZlcnNpb25pbmcuDQpUaGlzIHJlcXVpcmVzIGEgcmVhbGx5
IGdvb2QgZWZmb3J0IHRvIGRlc2lnbiBhbmQgcmV2aWV3IHRoZSBwcm9wZXIgbWV0YWRhdGENCmZv
cm1hdCB0aGF0IHdvdWxkIGJlY29tZSBzdGFibGUgZm9yIHNvbWUgdGltZS4gVGhpbmsgYWJvdXQg
cG9ydGFiaWxpdHkuDQpUbyBnZXQgb3V0IHNvbWV0aGluZyAiY29uanVyZWQgdXAiIG5vdyBhbmQg
dGhlbiBoYXZlIHRvIG1vdmUgdG8gVjINCm1ldGFkYXRhIGluIHRoZSBuZXh0IHJlbGVhc2UgaXMg
ZXZlbiB3b3JzZSB0aGFuIG5vIHBlcnNpc3RlbmNlIGF0IGFsbC4NClNvIG1heWJlIGlzIG1ha2Vz
IHNlbnNlIHRvIGdvIHdpdGggS2VpdGgncyBzdWdnZXN0aW9uLg0K


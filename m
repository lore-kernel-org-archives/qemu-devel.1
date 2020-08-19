Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE8C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F075E2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="huByzTxe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="vwyNnm/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F075E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8LFb-0001lQ-9A
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Cyril.Jean@microchip.com>)
 id 1k8L5t-0008Us-S1; Wed, 19 Aug 2020 06:13:22 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:29311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Cyril.Jean@microchip.com>)
 id 1k8L5p-00077m-OS; Wed, 19 Aug 2020 06:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1597831998; x=1629367998;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gy7cW+8l2G5/PDLFgkFNBvpmD4mMMlHtxMpS4nmF3yw=;
 b=huByzTxeDOkaMgkb8otH6hCZffzWSzqwwbhgulia/i8usFptqo8z7pP6
 MrMidkPTdUJtE471xEbWvivLJDgQy3CG74lTLpp+ck9oGhCOhUcqWFmfX
 PA2aFm2k2WkpgflaLYJLqgtqtNEYsH85n5mx3p6Son9lfoLDc0tcwn8DD
 FUfpzb1QdGhgcAtluSAchnGRb1WKLsj85DOl4qHOx23mq1GGb8WolVEGf
 +JqKQy/l4oBvR7ptGq8BevOEDukA4DVnUue0Qy9mn4AF47mIGW6NHtRai
 cf7SZoWUh4wZDoUJZ7JcdBOo8XtaEV3/TS8xoh0SnKiELVUl5Ynz30DZH A==;
IronPort-SDR: XLL6WRthFQI89M2Bac4V6XcznVpOlqhYXblMPPRvpInGxKMvP0fg4ItWAbyV7l9lyWlr6gORFZ
 k5Lp6HVZyS3dg9XalMFvHNKn5nnU8o6d48YFjV+x+fQp4lPgyRJFbAjnd6BsIS9/tk4YJki0ij
 Qkab3UxIjKhLX116lkFOUpF3HbfAEWASaPomRo+mfbyE4avKfX1pfbm8p257aj/Jj6siv502m4
 rU4pySSpHO9PUz/25pwgu9R8Y6gi/pXuswqia9wdWBtwlNu+i4AknXxjVxVxJ9Eob+wVmiQokW
 Hzs=
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; d="scan'208";a="87717942"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 19 Aug 2020 03:13:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 03:12:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 19 Aug 2020 03:12:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VY0VAog7RBw23XRCPxtPScwv0b2ut0sSHE8u/qNkAq9mCCb7mhefWmt7Z8eCyF3Q5IUr6cD3vdPrYV9rcPoxsP3Kduva95X79ZmQtY94UUbXgluSh522iUuzsCivQWqRDGfM7DkRjMCwuto/mq84UsQN3rXW/TXVA9qN58K7LdJjxjF1Bi987sgRxlcFaDfuma87t25MhihYwDvRytoKwNftH4avlp9oa1UezsNh5f4ni0+cy/2pYsH5jpbNq0sSYt/frQCN8Aic/7pgmwYRY0oY4Y0kzFMTjTzushb7uQE1V9VgrzCGS4qT3GBrw70KT1+G6rNSkMOVv+K0dnWpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy7cW+8l2G5/PDLFgkFNBvpmD4mMMlHtxMpS4nmF3yw=;
 b=ZN90lFNwQfmS//7Uq1aDfeiajWWj+zCqB0X69hSANP2qd8LgF6sKicFdshTOnsbLgbTjyWRzLGHV/JH5buRB13b5PKZoFnlFxap3Ym9En6FoVhTXMl7efWb0jE+rKMiRkb9WN9XO5o4WMMfDlWGQb2aVIcPD/mR5/IWgY6LmZwWcV+8wvIqZCSK2dZLEC1+SLfr4vBt47kc4iQHBtoip5HLot6zeBfHqm0Qc0ssu8tgENjHEUYTku8dvuR2U+rOjn596UTSLC+/TB58kqYu2oYh6FUV6nteZo53dZJl2h5Gt74z/YOUsKaFKzbY7NP8ieRfNmeaDl5P+iQJVrvvpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy7cW+8l2G5/PDLFgkFNBvpmD4mMMlHtxMpS4nmF3yw=;
 b=vwyNnm/IbXhIzzFr5gJXjko4+zoCcvKYn/t0hjHLbsdxBltIc1eJw1g77P/Q2+XGAG8Zo+eNhttRwfrqRD97th0CxX6DrRAY95SR1YHhmd4i3ZfeqvTMLe4tBlRqpFOeLCqWJo6LYsPQ/rT+ccH7BB7sX0ITAvKTSvDerLOCOnk=
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM6PR11MB4332.namprd11.prod.outlook.com (2603:10b6:5:1dd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 10:13:08 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::e0ca:f0fd:7675:46d7]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::e0ca:f0fd:7675:46d7%4]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 10:13:08 +0000
To: <bmeng.cn@gmail.com>, <anup@brainfault.org>
CC: <alistair23@gmail.com>, <Alistair.Francis@wdc.com>,
 <kbastian@mail.uni-paderborn.de>, <palmerdabbelt@google.com>,
 <sagark@eecs.berkeley.edu>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, 
 <peter.maydell@linaro.org>, <alistair@alistair23.me>,
 <qemu-block@nongnu.org>, <jasowang@redhat.com>, <bin.meng@windriver.com>,
 <pbonzini@redhat.com>, <palmer@dabbelt.com>, <qemu-arm@nongnu.org>,
 <marcandre.lureau@redhat.com>, <edgar.iglesias@gmail.com>,
 <philmd@redhat.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
Thread-Topic: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
Thread-Index: AQHWdIGDfQ2ADX3iMkmaUQkzVWiMJKk8cXaAgAA+ugCAAAcHgIAArjWAgABzR4CAAAy6AIAAwzOAgACRB4A=
Date: Wed, 19 Aug 2020 10:13:08 +0000
Message-ID: <9d6dd97b-20de-2be1-68eb-6ea2cf5b3ffc@microchip.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
 <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
 <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
 <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
 <d3f61c2c-a489-887e-0143-4d9a1e66e6f2@microchip.com>
 <CAAhSdy32owLO0KytyYsg-zH6JyyfNfGofa4vanqTFJLntPq0=g@mail.gmail.com>
 <1f17cc4c-83f8-a024-ebef-79e28fab9a32@microchip.com>
 <CAAhSdy1MTvjfpHZEAs2YVHXdPBaEMQxUNdP_yc7br0C2p9kfng@mail.gmail.com>
 <CAEUhbmUWcTxv70yuLMXwniGXB6zkadcpB4YTq=8F9UcXRK72+g@mail.gmail.com>
In-Reply-To: <CAEUhbmUWcTxv70yuLMXwniGXB6zkadcpB4YTq=8F9UcXRK72+g@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.40.244.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33cce952-2a43-4380-f27e-08d844287877
x-ms-traffictypediagnostic: DM6PR11MB4332:
x-microsoft-antispam-prvs: <DM6PR11MB43320FA330423197BC8F4EB89E5D0@DM6PR11MB4332.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEoCPH3Syssfqit6Gq88jaSGy6X3Qo2jank7ZlVRGsxoRTRIYn88cqYeBlxrFIHUhluD7KNUl0GHr6tvgCx8Dco1G0FxwEOjKtWm5KoCrbMAR0xheDcnVtyZ6UpHbH8u50REGpoaFXRO+HS8lMvUSLruDtbpRrcf8xrrAeQM8gQaGeDBscYFmann7XxRdKBPJCDXhbNTUglAD66+OeqoV1QMz/LnbZdXpFRVy/K4f+5KYqWmVV1TD/HpFaqZUOl4lECuoO99rsjYPbLvNEWb7l6LwyrZjceucjXRxfoKcPU/xuKMDPyzSFjeCe4ic+T16uwGBUkuIwq0emwN7A146g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB3690.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(366004)(376002)(396003)(346002)(39860400002)(36756003)(110136005)(66556008)(4326008)(5660300002)(64756008)(76116006)(186003)(6506007)(54906003)(8936002)(26005)(7416002)(316002)(66476007)(66946007)(86362001)(91956017)(66446008)(53546011)(8676002)(31686004)(71200400001)(6512007)(2616005)(6486002)(2906002)(31696002)(83380400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SFR79RukiOqtFfVuhNrX5iGU7rnGVOj7lT1cMxSg7YoyQJERhxY7Cc59O0cmnNR70CpySBkBenJrSEww47y6EWXRnBS9xQc/2trZ8QgJDOmlEVL5IvM/bFv3Ti3pVmM05OQYvxV9e65xuqYOdX2Bb3iHwXHTAyV7oSNcGe3txIN+qwGlqMpbJlZos/gtOfhGzmbFuCR8USPW+z4XTelIu4x7EZSM5P4/zwokDm9/OHdijrQBSjoxBwlMxqamz9PwakvN2pHTWgWAml587vlOaHjKkYep1GA5Pvde5xlyPp/RmmeDDvYKYeA3KNP/+yKfUwN4MyKMvNVBnygMd8WgxUCnRbahT5FqqMJHTuwMoGOSlhSktM+LLvGkuQrdkHWmtbOSLi1kIPmvpqOwFXI+1sVm08NYvCI3JuloIgNLYdbQPYZW7Yi6NlzprHZiywY/TOaWGnDI7zQvGJw+K1p3lb42t46s6aMEJHDOFhY9ELozLm2m+YcxLWELzmMCPvHUnOXoDTB4VlzhdV2z2R30N9t7PtfHQ4Us5uLghCuUoLuE9u8rdPddU9OnACPRpgB1fsc3WETIIl3Qy9EMH2vwr0Ik/1fihO82vA75hCC2JwhivGvxUwq0XZO3s854NB+XVV1ftosPEB9AnNZY7JDkrw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <237DB52C6609784F980EAEA4C11E971D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cce952-2a43-4380-f27e-08d844287877
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 10:13:08.2143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDu8FIrxPeX4ObT+sX+v5hb9uE3R7hjndafJqXU2MAbQzvjb/dwVDYUn0qTpz+CQNTB48kyrM6EP9HnYEDlT/DvykHkgAX61p4Q4G5H4G/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4332
Received-SPF: pass client-ip=216.71.150.166;
 envelope-from=Cyril.Jean@microchip.com; helo=esa5.microchip.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:13:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: <Cyril.Jean@microchip.com>
From:  via <qemu-devel@nongnu.org>

T24gOC8xOS8yMCAyOjM0IEFNLCBCaW4gTWVuZyB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+DQo+IE9uIFR1ZSwgQXVnIDE4LCAyMDIwIGF0IDk6NTUgUE0gQW51
cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9yZz4gd3JvdGU6DQo+PiBPbiBUdWUsIEF1ZyAxOCwg
MjAyMCBhdCA2OjM5IFBNIDxDeXJpbC5KZWFuQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4+IE9u
IDgvMTgvMjAgNzoxNyBBTSwgQW51cCBQYXRlbCB3cm90ZToNCj4+Pj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IE9uIFR1ZSwgQXVnIDE4LCAyMDIwIGF0IDE6
MjMgQU0gPEN5cmlsLkplYW5AbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4+PiBPbiA4LzE3LzIw
IDg6MjggUE0sIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pj4NCj4+Pj4+PiBPbiBNb24sIEF1ZyAxNywgMjAyMCBh
dCAxMToxMiBBTSB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4gd3JvdGU6DQo+Pj4+Pj4+IEhp
IEFudXAsDQo+Pj4+Pj4+DQo+Pj4+Pj4+IE9uIDgvMTcvMjAgMTE6MzAgQU0sIEJpbiBNZW5nIHdy
b3RlOg0KPj4+Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gSGkgQW51cCwNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBPbiBTYXQsIEF1ZyAxNSwg
MjAyMCBhdCAxOjQ0IEFNIEFudXAgUGF0ZWwgPGFudXBAYnJhaW5mYXVsdC5vcmc+IHdyb3RlOg0K
Pj4+Pj4+Pj4+IE9uIEZyaSwgQXVnIDE0LCAyMDIwIGF0IDEwOjEyIFBNIEJpbiBNZW5nIDxibWVu
Zy5jbkBnbWFpbC5jb20+IHdyb3RlOg0KPj4+Pj4+Pj4+PiBGcm9tOiBCaW4gTWVuZyA8YmluLm1l
bmdAd2luZHJpdmVyLmNvbT4NCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gVGhpcyBhZGRzIHN1cHBv
cnQgZm9yIE1pY3JvY2hpcCBQb2xhckZpcmUgU29DIEljaWNsZSBLaXQgYm9hcmQuDQo+Pj4+Pj4+
Pj4+IFRoZSBJY2ljbGUgS2l0IGJvYXJkIGludGVncmF0ZXMgYSBQb2xhckZpcmUgU29DLCB3aXRo
IG9uZSBTaUZpdmUncw0KPj4+Pj4+Pj4+PiBFNTEgcGx1cyBmb3VyIFU1NCBjb3JlcyBhbmQgbWFu
eSBvbi1jaGlwIHBlcmlwaGVyYWxzIGFuZCBhbiBGUEdBLg0KPj4+Pj4+Pj4+IE5pY2UgV29yayAh
ISEgVGhpcyBpcyB2ZXJ5IGhlbHBmdWwuDQo+Pj4+Pj4+PiBUaGFua3MhDQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4+IFRoZSBNaWNyb2NoaXAgSFNTIGlzIHF1aXRlIGNvbnZvbHV0ZWQuIEl0IGhhczoNCj4+
Pj4+Pj4+PiAxLiBERFIgSW5pdA0KPj4+Pj4+Pj4+IDIuIEJvb3QgZGV2aWNlIHN1cHBvcnQNCj4+
Pj4+Pj4+PiAzLiBTQkkgc3VwcG9ydCB1c2luZyBPcGVuU0JJIGFzIGxpYnJhcnkNCj4+Pj4+Pj4+
PiA0LiBTaW1wbGUgVEVFIHN1cHBvcnQNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEkgdGhpbmsgcG9p
bnQgMSkgYW5kIDIpIGFib3ZlIHNob3VsZCBiZSBwYXJ0IG9mIFUtQm9vdCBTUEwuDQo+Pj4+Pj4+
Pj4gVGhlIHBvaW50IDMpIGNhbiBiZSBPcGVuU0JJIEZXX0RZTkFNSUMuDQo+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+PiBMYXN0bHksZm9yIHBvaW50IDQpLCB3ZSBhcmUgd29ya2luZyBvbiBhIG5ldyBPcGVu
U0JJIGZlYXR1cmUgdXNpbmcNCj4+Pj4+Pj4+PiB3aGljaCB3ZSBjYW4gcnVuIGluZGVwZW5kZW50
IFNlY3VyZSBPUyBhbmQgTm9uLVNlY3VyZSBPUyB1c2luZw0KPj4+Pj4+Pj4+IFUtQm9vdF9TUEwr
T3BlblNCSSAoZm9yIGJvdGggU2lGaXZlIFVubGVhc2hlZCBhbmQgTWljcm9jaGlwDQo+Pj4+Pj4+
Pj4gUG9sYXJGaXJlKS4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IERvIHlvdSBoYXZlIHBsYW5zIGZv
ciBhZGRpbmcgVS1Cb290IFNQTCBzdXBwb3J0IGZvciB0aGlzIGJvYXJkID8/DQo+Pj4+Pj4+PiAr
IEN5cmlsIEplYW4gZnJvbSBNaWNyb2NoaXANCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJIHdpbGwgaGF2
ZSB0byBsZWF2ZSB0aGlzIHF1ZXN0aW9uIHRvIEN5cmlsIHRvIGNvbW1lbnQuDQo+Pj4+Pj4+Pg0K
Pj4+Pj4+PiBJIGN1cnJlbnRseSBkbyBub3QgaGF2ZSBhIHBsYW4gdG8gc3VwcG9ydCBVLUJvb3Qg
U1BMLiBUaGUgaWRlYSBvZiB0aGUNCj4+Pj4+Pj4gSFNTIGlzIHRvIGNvbnRhaW4gYWxsIHRoZSBz
aWxpY29uIHNwZWNpZmljIGluaXRpYWxpemF0aW9uIGFuZA0KPj4+Pj4+PiBjb25maWd1cmF0aW9u
IGNvZGUgd2l0aGluIHRoZSBIU1MgYmVmb3JlIGp1bXBpbmcgdG8gVS1Cb290IFMtbW9kZS4gSQ0K
Pj4+Pj4+PiB3b3VsZCByYXRoZXIga2VlcCBhbGwgdGhpcyB3aXRoaW4gdGhlIEhTUyBmb3IgdGhl
IHRpbWUgYmVpbmcuIEkgd291bGQNCj4+Pj4+Pj4gd2FpdCB1bnRpbCB3ZSByZWFjaCBwcm9kdWN0
aW9uIHNpbGljb24gYmVmb3JlIGF0dGVtcHRpbmcgdG8gbW92ZSB0aGlzIHRvDQo+Pj4+Pj4+IFUt
Qm9vdCBTUEwgYXMgdGhlIEhTUyBpcyBsaWtlbHkgdG8gY29udGFpbiBzb21lIG9wYXF1ZSBzaWxp
Y29uIHJlbGF0ZWQNCj4+Pj4+Pj4gY2hhbmdlcyBmb3IgYW5vdGhlciB3aGlsZS4NCj4+Pj4+PiBU
aGF0IGlzIHVuZm9ydHVuYXRlLCBhIGxvdCBvZiB3b3JrIGhhcyBnb25lIGludG8gbWFraW5nIHRo
ZSBib290IGZsb3cNCj4+Pj4+PiBzaW1wbGUgYW5kIGVhc3kgdG8gdXNlLg0KPj4+Pj4+DQo+Pj4+
Pj4gUUVNVSBub3cgaW5jbHVkZXMgT3BlblNCSSBieSBkZWZhdWx0IHRvIG1ha2UgaXQgZWFzeSBm
b3IgdXNlcnMgdG8gYm9vdA0KPj4+Pj4+IExpbnV4LiBUaGUgSWNpY2xlIEtpdCBib2FyZCBpcyBu
b3cgdGhlIG1vc3QgZGlmZmljdWx0IFFFTVUgYm9hcmQgdG8NCj4+Pj4+PiBib290IExpbnV4IG9u
LiBOb3QgdG8gbWVudGlvbiBpdCBtYWtlcyBpdCBoYXJkIHRvIGltcG9zc2libGUgdG8NCj4+Pj4+
PiBzdXBwb3J0IGl0IGluIHN0YW5kYXJkIHRvb2wgZmxvd3Mgc3VjaCBhcyBtZXRhLXJpc2N2Lg0K
Pj4+Pj4+DQo+Pj4+Pj4gQWxpc3RhaXINCj4+Pj4+IElmIGl0IGlzIHN1Y2ggYSBwcm9ibGVtIHdl
IGNhbiBhZGQgYSBVLUJvb3QgU1BMIHN0YWdlIGFuZCB0aGUgSFNTIGNhbiBiZQ0KPj4+Pj4gdHJl
YXRlZCBhcyBzdGFuZGFyZCBTb0MgUk9NIGNvZGUuDQo+Pj4+IEl0J3Mgbm90IG1hbmRhdG9yeSBm
b3IgVS1Cb290IFNQTCB0byBoYXZlIHN0YWJsZSBEUkFNIGNhbGlicmF0aW9uIHNldHRpbmdzDQo+
Pj4+IGZyb20gdGhlIHN0YXJ0IGl0c2VsZi4gVGhlIGluaXRpYWwgVS1Cb290IFNQTCBzdXBwb3J0
IGZvciBtb3N0DQo+Pj4+IHBsYXRmb3JtcyAoYWNjcm9zcw0KPj4+PiBhcmNoaXRlY3R1cmVzKSB1
c3VhbGx5IGluY2x1ZGUgYmFzaWMgd29ya2luZyBEUkFNIGNhbGlicmF0aW9uIHNldHRpbmdzIHdo
aWNoDQo+Pj4+IGlzIGxhdGVyIG9uIHVwZGF0ZWQgd2l0aCBzZXBhcmF0ZSBwYXRjaGVzLiBBbHNv
LCB3ZSBkb24ndCBuZWVkIGFsbCBVLUJvb3QNCj4+Pj4gZHJpdmVycyB0byBiZSB1cHN0cmVhbWVk
IGluIG9uZS1nbyBhcyB0aGlzIGNhbiBiZSBkb25lIGluIHBoYXNlcy4NCj4+Pj4NCj4+Pj4gVGhl
IGFkdmFudGFnZSB3ZSBoYXZlIHdpdGggUG9sYXJGaXJlIFNvQyBJY2ljbGUgYm9hcmQgaXMgdGhh
dCB3ZSBhbHJlYWR5DQo+Pj4+IGhhdmUgYSBVLUJvb3QgUy1tb2RlLiBhbmQgd2UgYmVsaWV2ZSB0
aGUgT3BlblNCSSBnZW5lcmljIHBsYXRmb3JtIHdpbGwNCj4+Pj4gd29yayBmaW5lIGZvciBQb2xh
ckZpcmUgU29DIEljaWNsZSBib2FyZCBzbyB0aGUgb25seSB0aGluZyBtaXNzaW5nIHJpZ2h0IG5v
dw0KPj4+PiBpcyB0aGUgVS1Cb290IFNQTCBzdXBwb3J0IGZvciBPcGVuU291cmNlIGJvb3QtZmxv
dy4NCj4+Pj4NCj4+Pj4gSXQgd2lsbCBjZXJ0YWlubHkgYWNjZWxlcmF0ZSBvcGVuLXNvdXJjZSBk
ZXZlbG9wbWVudCBpZiB3ZSBoYXZlIGJvb3QtZmxvdw0KPj4+PiBVLUJvb3RfU1BMID0+IE9wZW5T
QkkgKEZXX0RZTkFNSUMpID0+IFUtQm9vdF9TLW1vZGUgd29ya2luZw0KPj4+PiBvbiBQb2xhckZp
cmUgU29DIEljaWNsZSBib2FyZC4gSW5pdGlhbGx5LCB3ZSBqdXN0IG5lZWQgRFJBTSwgU0QvZU1N
QywNCj4+Pj4gYW5kIFNlcmlhbCBwb3J0IHN1cHBvcnQgZm9yIFUtQm9vdCBTUEwgYW5kIFUtQm9v
dCBTLW1vZGUuIExhdGVyIG9uLA0KPj4+PiBtb3JlIHBhdGNoZXMgY2FuIGFkZCBldGhlcm5ldCBh
bmQgb3RoZXIgYm9vdGluZyBkZXZpY2UgZHJpdmVycyB0byBVLUJvb3QuDQo+Pj4+DQo+Pj4+IFJl
Z2FyZGluZyBzZWN1cml0eSBzZXJ2aWNlcyBvZiBIU1MsIHdlIGFyZSB3b3JraW5nIG9uIGEgT3Bl
blNCSQ0KPj4+PiBmZWF0dXJlIHdoaWNoIHdpbGwgYWxsb3cgSFNTIHNlY3VyaXR5IHNlcnZpY2Vz
IHRvIHJ1biBhcyBpbmRlcGVuZGVudA0KPj4+PiBiaW5hcnkgaW4gTS1tb2RlIChub3QgbGlua2Vk
IHRvIE9wZW5TQkkpIGFuZCBPcGVuU0JJIEZXX0RZTkFNSUMNCj4+Pj4gd2lsbCBiZSBhIHNlcGFy
YXRlIGJpbmFyeSBhY3RpbmcgYXMgYSBzZWN1cmUgbW9uaXRvci4NCj4+Pj4NCj4+Pj4gUmVnYXJk
cywNCj4+Pj4gQW51cA0KPj4+IFdoYXQgSSBoYXZlIGluIG1pbmQgaXMgdGhhdCB0aGUgZXh0ZXJu
YWwgbWVtb3J5IHdpbGwgYmUgdXAgYW5kIHJ1bm5pbmcNCj4+PiBieSB0aGUgdGltZSB3ZSBnZXQg
dG8gVS1Cb290IFNQTC4gSW4gdGhlIGNhc2Ugb2YgUG9sYXJGaXJlIFNvQyB0aGUgUk9NDQo+Pj4g
Y29kZSBlcXVpdmFsZW50IGJyaW5ncyB1cCB0aGUgRERSIG1lbW9yeSBpbnRlcmZhY2Ugc28gd2Ug
ZG8gbm90IG5lZWQgdG8NCj4+PiB3b3JyeSBhYm91dCB0aGlzIGFzIHBhcnQgb2YgVS1Cb290Lg0K
Pj4gS2VlcGluZyBEUkFNIGNvbmZpZ3VyYXRpb24gYXMgcGFydCBvZiBhIHNlcGFyYXRlIFJPTSBi
b290aW5nIHN0YWdlIHByaW9yDQo+PiB0byB0aGUgVS1Cb290IFNQTCBzb3VuZHMgZ29vZCB0byBt
ZS4gVGhpcyB3aWxsIGxlYWQgdG8gZm9sbG93aW5nIGJvb3QtZmxvdzoNCj4+DQo+PiBST00vSFNT
IChNLW1vZGUpID0+IFUtQm9vdCBTUEwgKE0tbW9kZSkgPT4gT3BlblNCSSAoTS1tb2RlKSA9PiBV
LUJvb3QgUy1tb2RlDQo+IElmIHdlIHdhbnQgdG8ga2VlcCB0aGUgSFNTLCBtZWFuaW5nIHRoYXQg
RERSIG1lbW9yeSBpcyBhbHJlYWR5DQo+IGluaXRpYWxpemVkLCB0aGVuIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gY3JlYXRlIGFuIGFkZGl0aW9uYWwgc3RlcCBvZg0KPiBVLUJvb3QgU1BMIHBoYXNlLCBi
ZWNhdXNlIHRoZXJlIGlzIG5vIHNpemUgbGltaXRhdGlvbiBhbnkgbW9yZS4NCj4NCj4gUmlnaHQg
bm93LCB0aGUgYm9vdCB3b3JrZmxvdyBvbiBQb2xhckZpcmUgaXM6DQo+DQo+IEhTUyArIE9wZW5T
QkkgKGFzIGEgbGlicmFyeSkgKE0tbW9kZSkgPT4gVS1Cb290IFMtbW9kZQ0KPg0KPiBJdCdzIGp1
c3Qgbm90IHRoZSBjYW5vbmljYWwgd2F5IGJlY2F1c2Ugb2YgdGhlIEhTUyBhbmQgT3BlblNCSSBh
cyBhIGxpYnJhcnkuDQo+DQo+IEEgY2Fub25pY2FsIHdheSBzaG91bGQgYmU6DQo+DQo+IFUtQm9v
dCBTUEwgKE0tbW9kZSkgPT4gT3BlblNCSSBkeW5hbWljIChNLW1vZGUpID0+IFUtQm9vdCBTLW1v
ZGUNCj4NCj4gU28gd2Ugc2hvdWxkIGJlIGFpbWluZyB0byByZXBsYWNlIEhTUyB3aXRoIFUtQm9v
dCBTUEwuDQo+DQo+Pj4gU291bmRzIHRvIG1lIHRoZSBjb21wb25lbnQgdGhhdCBuZWVkcyB0byBi
ZSB1cHN0cmVhbWVkIG5leHQgaXMgdGhlIGVNTUMNCj4+PiBzdXBwb3J0IHNvIHRoYXQgaXQgY2Fu
IGJlIHVzZWQgYXMgcGFydCBvZiBVLUJvb3QgU1BMLiBDb3JyZWN0Pw0KPj4gTWF5YmUgYXMgYSBQ
SEFTRTEgcGF0Y2ggc2VyaWVzIGZvciBQb2xhckZpcmUgVS1Cb290IHN1cHBvcnQgY2FuDQo+PiB0
YXJnZXQgdGhlIGZvbGxvd2luZzoNCj4+IDEuIE1pbmltYWwgVS1Cb290IGJvYXJkIHN1cHBvcnQg
Zm9yIFBvbGFyRmlyZSBJY0ljbGUgQm9hcmQgd2l0aA0KPj4gc2luZ2xlIGRlZmNvbmZpZyB0byBi
dWlsZCBib3RoIFUtQm9vdCBTUEwgYW5kIFUtQm9vdCBTLW1vZGUNCj4+IDIuIFNlcmlhbCBwb3J0
IGRyaXZlciAocHJvYmFibHkgcmUtdXNlIGV4aXN0aW5nIGRyaXZlcikNCj4+IDMuIFNEIGFuZCBl
TU1DIGRyaXZlcg0KPj4NCj4+IFN1cHBvcnRpbmcgU0QgYm9vdGluZyBpcyBoaWdobHkgZGVzaXJh
YmxlIGZvciBQSEFTRTEuIEF0IGxlYXN0LA0KPj4gVS1Cb290IFNQTCwgT3BlblNCSSwgVS1Cb290
IFMtbW9kZSwgYW5kIExpbnV4IHNob3VsZCBjb21lDQo+PiBhcyBzZXBhcmF0ZSBpbWFnZXMgZnJv
bSBTRCBjYXJkLiBUaGUgUk9NL0hTUyBjYW4gcmVzaWRlIGFuZA0KPj4gYm9vdCBmcm9tIG9uLWJv
YXJkIGZsYXNoL2VNTUMuDQo+Pg0KPj4gQWJvdmUgaXMgbXkgc3VnZ2VzdGlvbiBiYXNlZCBvbiBl
eHBlcmllbmNlIHdpdGggU2lGaXZlIFVubGVhc2hlZC4NCj4+DQo+PiBUaGUgZ2VuZXJhbCBpZGVh
IGJlaGluZCBPcGVuU291cmNlIGJvb3QtZmxvdyBpcyB0byBoYXZlIGVhY2gNCj4+IGJvb3Rpbmcg
c3RhZ2UgYXMgYSBzZXBhcmF0ZSBiaW5hcnkgc28gdGhhdCB1c2VycyBjYW4gc2VsZWN0aXZlbHkN
Cj4+IHVwZ3JhZGUgYSBwYXJ0aWN1bGFyIGJvb3Rpbmcgc3RhZ2Ugd2l0aG91dCByZS1jb21waWxp
bmcvcmUtZmxhc2hpbmcNCj4+IG90aGVyIGJvb3Rpbmcgc3RhZ2VzLg0KPj4NCj4+IFZhcmlvdXMg
ZGlzdHJvcyBhbmQgeW9jdG8gYWxyZWFkeSBzdXBwb3J0IGJ1aWxkaW5nIG1vc3Qgb2YgdGhlIGFi
b3ZlDQo+PiBib290aW5nIHN0YWdlcyAoVS1Cb290LCBPcGVuU0JJLCBMaW51eCwgZXRjKSBzbyB3
ZSBjYW4gcmV1c2UgYSBsb3QNCj4+IG9mIGV4aXN0aW5nIHdvcmsuIEV2ZW50dWFsbHksIEkgYW0g
Y29uZmlkZW50IHdlIHdpbGwgZW5kdXAgbW92aW5nDQo+PiBtb3JlIHN0dWZmIGZyb20gUk9NL0hT
UyB0byBVLUJvb3QgU1BMIGZvciBlYXNlIGluIG1haW50ZW5hbmNlLg0KPiBSZWdhcmRzLA0KPiBC
aW4NCg0KSSBhbSBPSyB3aXRoIHN1cHBvcnRpbmcgVS1Cb290IFNQTCBhcyBhIGNvbW11bml0eSBi
b290IGZsb3cgYnV0IHRoZSBIU1MgDQppcyBub3QgZ29pbmcgdG8gZGlzYXBwZWFyIGNvbXBsZXRl
bHkgZm9yIG1hbnkgUG9sYXJGaXJlIFNvQyBkZXBsb3ltZW50cy4gDQpXZSBuZWVkIHRvIGhhdmUg
dGhlIEhTUyBydW5uaW5nIG9uIHRoZSBtb25pdG9yIGNvcmUgYWZ0ZXIgdGhlIHN5c3RlbSBoYXMg
DQpib290ZWQgZm9yIHZhcmlvdXMgcmVhc29ucy4gU29tZSBvZiB0aGUgY3VycmVudCBIU1MgZnVu
Y3Rpb25hbGl0aWVzIGNhbiANCmJlIG1pZ3JhdGVkIGF0IGEgbGF0ZXIgdGltZS4NCg0KVGhlIEhT
UyB3YXMgZGVzaWduZWQgdG8gZWFzaWx5IGVuYWJsZSBhbmQgZGlzYWJsZSBmZWF0dXJlcyB0aHJv
dWdoIA0KS2NvbmZpZyB3aGljaCBzaG91bGQgYWxsb3cgdG8gYXNzaWduIGZlYXR1cmVzIHRvIGRp
ZmZlcmVudCBib290IHN0YWdlcyANCmRlcGVuZGluZyBvbiB0aGUgb3ZlcmFsbCBzeXN0ZW0gZGVw
bG95bWVudC4gS2VlcGluZyB0aGUgSFNTIGFzIFJPTSBjb2RlIA0KY2FwYWJsZSBvZiBzdGFydGlu
ZyB2YXJpb3VzIGVhcmx5IGJvb3Qgc3RhZ2VzIGluIGVpdGhlciBNIG1vZGUgb3IgUyBtb2RlIA0K
YWxsb3dzIHVzIChNaWNyb2NoaXAgZW5naW5lZXJpbmcgYW5kIG5vbiBwdXJlIExpbnV4IHVzZXJz
KSB0byBtaXggDQpkaWZmZXJlbnQgb3BlcmF0aW5nIHN5c3RlbXMgb24gdGhlIHNhbWUgcGxhdGZv
cm0gYW5kIG1vcmUgZWFzaWx5IGRlYnVnIA0KaGFyZHdhcmUgYnJpbmctdXAuDQoNCldoYXQgSSBh
bSB0cnlpbmcgdG8gZ2V0IGF0IGlzIHRoYXQgd2UgbmVlZCB0byBiYWxhbmNlIHRoZSBRRU1VIGVh
c2Ugb2YgDQp1c2Ugd2l0aCB0aGUgYWJpbGl0eSB0byBicmluZy11cCBhbmQgZGVidWcgYWN0dWFs
IGhhcmR3YXJlLiBNeSBwcmVmZXJyZWQgDQphcHByb2FjaCBpcyB0byBrZWVwIGFsbCB0aGUgaGFy
ZHdhcmUgYnJpbmcgdXAgaW4gb25lIHBsYWNlLCB0aGUgSFNTLCBzbyANCnRoYXQgeW91IGRvIG5v
dCBoYXZlIHRvIHdvcnJ5IGFib3V0IG9ic2N1cmUgc2lsaWNvbiBpZGlvc3luY3Jhc2llcyBvbmNl
IA0KeW91IHJlYWNoIHRoZSBvcGVuIHNvdXJjZSBib290IGZsb3cuIFNpbGljb24vYm9hcmQgYnJp
bmcgdXAgDQpzdGVwcy9mZWF0dXJlcyBjYW4gYmUgYnJvdWdodCBvdXQgb2YgdGhlIEhTUyBpbnRv
IHRoZSBvcGVuIHNvdXJjZSBib290IA0Kc3RhZ2VzIG9uY2UgdGhlc2Ugc3RlcHMgYXJlIG1hdHVy
ZS4NCg0KUG9sYXJGaXJlIFNvQyBpcyB0aGUgdGhpcmQgZmFtaWx5IG9mIFNvQyBGUEdBIEkgaGF2
ZSB3b3JrZWQgb24uIFNvIEkgDQpoYXZlIGEgZmFpciBpZGVhIG9mIHRoZSBhbW91bnQgb2YgcGFp
biBpbiBmcm9udCBvZiBtZSB0byBicmluZyB0aGUgDQplbnRpcmUgZGV2aWNlIGZhbWlseSB0byBt
YXJrZXQgOi0pIFdlIGRlY2lkZWQgZWFybHkgb24gaW4gdGhlIA0KYXJjaGl0ZWN0dXJlIG9mIFBv
bGFyRmlyZSBTb0MgdGhhdCB3ZSB3b3VsZCBtYWtlIGFsbCBjb2RlIGV4ZWN1dGluZyBvbiANCnRo
ZSBSSVNDLVYgcHJvY2Vzc29ycyBvcGVuIHNvdXJjZSBhbmQgdXNlciBtb2RpZmlhYmxlLiBUaGlz
IGluY2x1ZGVzIGFsbCANCmNvZGUgdHlwaWNhbGx5IGhpZGRlbiBhd2F5IGluIHlvdXIgdHlwaWNh
bCBTb0MgUk9NIGNvZGUuIFRoaXMgaXMgd2h5IA0KUG9sYXJGaXJlIFNvQyBoYXMgb24tY2hpcCBm
bGFzaCBtZW1vcnkgdXNlZCB0byBzdG9yZSB0aGUgSFNTIGFuZCB3aHkgdGhlIA0KSFNTIHNob3Vs
ZCBiZSB0aG91Z2h0IGFzIGluY2x1ZGluZyBST00gY29kZS4gVGhlIGN1cnJlbnQgSWNpY2xlIEtp
dCB1c2VzIA0KZW5naW5lZXJpbmcgc2FtcGxlcyBmcm9tIHRoZSBmaXJzdCBkZXZpY2UgaW4gdGhl
IFBvbGFyRmlyZSBTb0MgZmFtaWx5LiANClNvIHdlIGFyZSByZWFsbHkgYXQgdGhlIGJlZ2lubmlu
ZyBvZiB0aGUgcHJvY2VzcyBvZiB2YWxpZGF0aW5nIHZlcnkgDQplYXJseSBib290IHN0ZXBzIG9u
IGEgc2lnbmlmaWNhbnQgbnVtYmVyIG9mIGRldmljZXMuIEkgZG8gbm90IHdhbnQgdG8gDQpleHBv
c2UgdGhlIG9wZW4gc291cmNlIGNvbW11bml0eSB0byB0aGUgcGFpbiBvZiBicmluZ2luZyB1cCBh
IGZhbWlseSBvZiANCmRldmljZXMgYmVjYXVzZSBvZiB0aGUgZGVjaXNpb24gdG8gb3BlbiBzb3Vy
Y2UgYWxsIGNvZGUuIFNvIEkgYW0gYXNraW5nIA0KeW91IHRvIG5vdCBydXNoIGluIHRyeWluZyB0
byBtaWdyYXRlIGNvbXBvbmVudHMgZnJvbSB0aGUgSFNTIHRvIGEgbGF0ZXIgDQpib290IHN0YWdl
IGp1c3QgeWV0LiBJdCBjYW4gYmUgZG9uZSBidXQgYmFzZWQgb24gZXhwZXJpZW5jZSBJIHRoaW5r
IHRoYXQgDQpub3cgaXMgbm90IHRoZSByaWdodCB0aW1lIHlldC4NCg0KUmVnYXJkcywNCg0KQ3ly
aWwuDQoNCg==


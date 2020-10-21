Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7533BC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 23:21:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C68522249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 23:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AsMld19F";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BtTA8FH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C68522249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVNPo-0008PC-4L
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 19:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55677d03b=Dmitry.Fomichev@wdc.com>)
 id 1kVNOj-0007gi-VE; Wed, 21 Oct 2020 19:20:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55677d03b=Dmitry.Fomichev@wdc.com>)
 id 1kVNOf-0007My-Fl; Wed, 21 Oct 2020 19:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603322397; x=1634858397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wdwtuysXdxODXe5KxJ78GaKLbpPa4RMR3XrhHzHCLQQ=;
 b=AsMld19FilqUDOPkad0sFDF8o6iAqBxOsVmS802N9KZrB/dNIt/n9xbh
 03SPVNLRTt5Tgbv5nhaR6bkEzHEZctCYRu+SDtZbg+HKzyga3LX4Lp6Fi
 xUIkadBb1d9SQS1IFtnPXxGmVVJVJM3otIur9JGGOBS2ST9bJOvri94AB
 N5zLhKxwul+0JBwaVZ5mSGaQBxCRYxbRg3ApCDi/xgwmAaCdhhu4oEtDT
 iijByMXrkHNjkEVJIfvw43nl5tpctOw13URnlgCJ7j6CKZy/paK0zkA9o
 MmRqnIjY/I1tiAxS6p9cU2VjQsv8NuuHoilr0qMJ5NQ2e7uCRHhfz06Fo Q==;
IronPort-SDR: QZnEz0GrxTKT5Ho36F8XF7S8SycOh5R5ZHcoq5C1/bB6zjP6Ro2uRjrcmLkOaAR5UB4aKgoIQW
 9n9bHruOORhsfJQvxOF2yjyB0YS3M3WpmIpcX3/888ozCeUF1yunBO+6fLK+zYQVHaD+EJGLOc
 bcaaQeJEqhXeYsZWmf2uSCUEsWx36s5D4Q+zSllksO9uRpErxEZD4XJkAr2iTlV+pTgeZ2hvbx
 IfGU+YQhB+K6v27KGCU4Kqr4wa6HSdcNAE7rY0WTgaaz/vRj2wPdb6ULNx3I8e5DL29SzCp+Mo
 4xo=
X-IronPort-AV: E=Sophos;i="5.77,402,1596470400"; d="scan'208";a="260455977"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 07:19:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2z3CCRd/L3mgFpwcDsMr6gT+Nnk0DL1JP4CYEgBqoDiB5hohVGJcmd4kBmgjWU1TnOuFGekiPM4WUR6zGqNN7+cARDvjSIvnt+k4hUGl9LobyH4m1mm25dzVKhalEBM4dYH/xSqLB97KlP2Z+pXwDHD0OqMfydL1pBg797ay7vTJFhM55+A9LAUswiclAuqZmJFEICjTEU7puSgjC/WqCTHkXDAUyiLoCg5/ltBoYTOKmaNbEQ70o+yYqyD2YCyBn66gm6GKnYh9n4IsJwKMzogG8jn16xphVXcQ0cZNKuUIViaoxsCw2KUOoqkxfRQkDajmTAzcwQ84haXGQiVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdwtuysXdxODXe5KxJ78GaKLbpPa4RMR3XrhHzHCLQQ=;
 b=T1QSFT/NIcmmYTnCBs2K/VAAdUg1ytWYzPSDQhxN87SHcQna6Qgoqo4nnVZvP2uxT7uh/6xAHQ5u6AxwPMR1HH4Ky6OfZ7GU3d243WC3gc/UBl2+LcJlHMKLjYkJI+B2XP/dk6vSTdYrWiKEljC015BGZdMRjfNh5BFlxf4TIfpN33OeAXzBwAJZo4GrWLrcasiXfBHR0+ngxAOu7Kom/LX0c9+K0ZjSrwiKz/7BSmENLtNzF5PLKcCDvH5NThnwKo4osyBV/V8XUQ/XcbGpnVISICYsieHn2yLa0l/+Ujau23sbw7wI7NL0B78VUl3b18h36Fb1KxInyPR+b8QUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdwtuysXdxODXe5KxJ78GaKLbpPa4RMR3XrhHzHCLQQ=;
 b=BtTA8FH8gVAQ366cZKp20rg1neNG4dzrcXLIHslX+vzkPNE+qXoD99j9fpGkdAAElh33QAUhHFg2va7hUaacGmRF5l9ZwtqNuDkAZD+Hpc60ACuKNOFc60Hm2hIQkdjPFZxpNwy841FDdLxrtLrvb3fp8BbAf+pZo52MwB3fmVA=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5888.namprd04.prod.outlook.com (2603:10b6:208:a0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 23:19:51 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 23:19:50 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v7 05/11] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWpb4LFowIFpJT7kSydN8ZR95Yxqmh3awAgADWW2A=
Date: Wed, 21 Oct 2020 23:19:50 +0000
Message-ID: <MN2PR04MB5951752FF38921A6516E264AE11C0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-6-dmitry.fomichev@wdc.com>
 <20201021102604.GA276644@apples.localdomain>
In-Reply-To: <20201021102604.GA276644@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63e2fd26-f5e6-41e8-f6fa-08d87617cf71
x-ms-traffictypediagnostic: MN2PR04MB5888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5888692C68C1F335C115A095E11C0@MN2PR04MB5888.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X+X8YpFBzM8zXtbedFHqBf4xct/ZPJ8fo43cOaEi4dC+S5cneCri8EZLdEoKlKAW8KgFdegZh1wSVa72LMDBDUu/wDHF2CVjjwpdswUG7FqddnnpQaiBK3BsHzpdAUz0JRXuZK+WsThLgLurAQePF/k1QqZD6cfQWYJG7fwOvBwtseTU42w+y8mJJHk0PFuz5sh2AXt/2idyYij7X4l/0W2AlCGY+ky7b0/pelrDhuEU8Wyz7s5JJMW57Bjuy9OYb6eKf2VfiVsgWExY9j8jElnM8OLwPrOQCl/ncKFnIKYnCCE9JtOaok64K2lU319C1GmuK5gFqYhd8mPLDuscRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(316002)(54906003)(8676002)(6506007)(8936002)(26005)(86362001)(33656002)(53546011)(186003)(71200400001)(7696005)(66946007)(66446008)(5660300002)(478600001)(52536014)(2906002)(4326008)(6916009)(76116006)(9686003)(83380400001)(64756008)(66476007)(66556008)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2bcjG6ol43WaxHizijPDy8+O6PTk7Io5oXVtrITyDB+7WugkCn99/doseWYhaObQy8bAsVC9t8PMP/EkQGIqfMvOITr0sctN7WXD3JX3BAyB5HFE71KSVNkzuAtDql780lbZkSKANNa8x1I/JxpIQQ/7XTETTxV4rnPyeImNemLLaZjnj2nAMg3cbi/kLexRNYvhauASmO8/rSQEzAK7Wtnh3P+7lt+N+kAnkQkEnKmGeFXnXcwsx5sz5gcvNW97Dx7rYCii06BAVbIZtQdaHU7DaOU1gSx/2KaCbAd3Sz1NN8jf7tWTdIn/x4w6GWGPeZu9r5wzZQGUvBxd0mF4JUAB20zbBIXKqJSlQg1jrWVlgqREiXho/EH6L8iM4MWpMftrIOuNZf7XlPBneR2y6PVV3NGwtCfl7DRHtnOFZPmyQDkCBWU7Zghfjpf/HHZk4BH6+KLlE2O0UyjvcTLff7kpfAHXZ0/K6CMIXJfkJVUkoZnGVB9nbzQy32yCwvnbYiczuDpfbuMXdL3xYO1Jb0+4Zu6sjh6yIUyedNAYmzKvnEgvqiJcIbGCHzhotjPsKNXXg2Y/qpGpFWf/FDCUxgekBNgKaCbxBcmSlkI579Ean90UVrWLlICkLjM2mBP/kgzxWYzRFJ8wM/4CoUCZ7g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e2fd26-f5e6-41e8-f6fa-08d87617cf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 23:19:50.7834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGf96qHyLiE1GdEhU35Ow1nkdMoOFpZeXj0PqqHsWhU54XJy1LYBmESzpz41V1UG/wHElK51NWRzcf2MeT5YUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5888
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=55677d03b=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 19:19:53
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
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjEsIDIwMjAgNjoyNiBB
TQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5z
ZW5Ac2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUN
Cj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kNCj4g
PG1sZXZpdHNrQHJlZGhhdC5jb20+OyBGYW0gWmhlbmcgPGZhbUBldXBob24ubmV0PjsgTmlrbGFz
IENhc3NlbA0KPiA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPjsgRGFtaWVuIExlIE1vYWwgPERhbWll
bi5MZU1vYWxAd2RjLmNvbT47DQo+IHFlbXUtYmxvY2tAbm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBu
b25nbnUub3JnOyBBbGlzdGFpciBGcmFuY2lzDQo+IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+
OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY3IDA1LzExXSBody9ibG9jay9udm1lOiBTdXBwb3J0IFpvbmVkIE5hbWVzcGFj
ZQ0KPiBDb21tYW5kIFNldA0KPiANCj4gT24gT2N0IDE5IDExOjE3LCBEbWl0cnkgRm9taWNoZXYg
d3JvdGU6DQo+ID4gKy8qDQo+ID4gKyAqIENsb3NlIG9yIGZpbmlzaCBhbGwgdGhlIHpvbmVzIHRo
YXQgYXJlIGN1cnJlbnRseSBvcGVuLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgbnZtZV96
b25lZF9jbGVhcl9ucyhOdm1lTmFtZXNwYWNlICpucykNCj4gPiArew0KPiA+ICsgICAgTnZtZVpv
bmUgKnpvbmU7DQo+ID4gKyAgICB1aW50MzJfdCBzZXRfc3RhdGU7DQo+ID4gKyAgICBpbnQgaTsN
Cj4gPiArDQo+ID4gKyAgICB6b25lID0gbnMtPnpvbmVfYXJyYXk7DQo+ID4gKyAgICBmb3IgKGkg
PSAwOyBpIDwgbnMtPm51bV96b25lczsgaSsrLCB6b25lKyspIHsNCj4gPiArICAgICAgICBzd2l0
Y2ggKG52bWVfZ2V0X3pvbmVfc3RhdGUoem9uZSkpIHsNCj4gPiArICAgICAgICBjYXNlIE5WTUVf
Wk9ORV9TVEFURV9JTVBMSUNJVExZX09QRU46DQo+ID4gKyAgICAgICAgICAgIFFUQUlMUV9SRU1P
VkUoJm5zLT5pbXBfb3Blbl96b25lcywgem9uZSwgZW50cnkpOw0KPiA+ICsgICAgICAgICAgICBi
cmVhazsNCj4gPiArICAgICAgICBjYXNlIE5WTUVfWk9ORV9TVEFURV9FWFBMSUNJVExZX09QRU46
DQo+ID4gKyAgICAgICAgICAgIFFUQUlMUV9SRU1PVkUoJm5zLT5leHBfb3Blbl96b25lcywgem9u
ZSwgZW50cnkpOw0KPiA+ICsgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICBjYXNlIE5W
TUVfWk9ORV9TVEFURV9DTE9TRUQ6DQo+ID4gKyAgICAgICAgICAgIC8qIGZhbGwgdGhyb3VnaCAq
Lw0KPiA+ICsgICAgICAgIGRlZmF1bHQ6DQo+ID4gKyAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
ICsgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgaWYgKHpvbmUtPmQud3AgPT0gem9uZS0+
ZC56c2xiYSkgew0KPiA+ICsgICAgICAgICAgICBzZXRfc3RhdGUgPSBOVk1FX1pPTkVfU1RBVEVf
RU1QVFk7DQo+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgc2V0X3N0YXRl
ID0gTlZNRV9aT05FX1NUQVRFX0NMT1NFRDsNCj4gPiArICAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgIHN3aXRjaCAoc2V0X3N0YXRlKSB7DQo+ID4gKyAgICAgICAgY2FzZSBOVk1FX1pPTkVf
U1RBVEVfQ0xPU0VEOg0KPiA+ICsgICAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9jbGVhcl9uc19j
bG9zZShudm1lX2dldF96b25lX3N0YXRlKHpvbmUpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB6b25lLT5kLnpzbGJhKTsNCj4gPiArICAgICAgICAgICAg
UVRBSUxRX0lOU0VSVF9UQUlMKCZucy0+Y2xvc2VkX3pvbmVzLCB6b25lLCBlbnRyeSk7DQo+ID4g
KyAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgIGNhc2UgTlZNRV9aT05FX1NUQVRFX0VN
UFRZOg0KPiA+ICsgICAgICAgICAgICB0cmFjZV9wY2lfbnZtZV9jbGVhcl9uc19yZXNldChudm1l
X2dldF96b25lX3N0YXRlKHpvbmUpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB6b25lLT5kLnpzbGJhKTsNCj4gPiArICAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICAgICAgY2FzZSBOVk1FX1pPTkVfU1RBVEVfRlVMTDoNCj4gPiArICAgICAgICAgICAg
dHJhY2VfcGNpX252bWVfY2xlYXJfbnNfZnVsbChudm1lX2dldF96b25lX3N0YXRlKHpvbmUpLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHpvbmUtPmQuenNs
YmEpOw0KPiA+ICsgICAgICAgICAgICB6b25lLT5kLndwID0gbnZtZV96b25lX3dyX2JvdW5kYXJ5
KHpvbmUpOw0KPiA+ICsgICAgICAgICAgICBRVEFJTFFfSU5TRVJUX1RBSUwoJm5zLT5mdWxsX3pv
bmVzLCB6b25lLCBlbnRyeSk7DQo+ID4gKyAgICAgICAgfQ0KPiANCj4gTm8gbmVlZCBmb3IgdGhl
IHN3aXRjaCBoZXJlIC0ganVzdCBhZGQgdG8gdGhlIGNsb3NlZCBsaXN0IGluIHRoZQ0KPiBjb25k
aXRpb25hbC4NCg0KVGhlIHN3aXRjaCBiZWNvbWVzIGhhbmR5IGxhdGVyIGluIHRoZSBzZXJpZXMs
IHBhcnRpY3VsYXJseSBhZnRlciBhZGRpbmcNCmRlc2NyaXB0b3IgZXh0ZW5zaW9ucy4gRm9yIGVh
c2llciByZXZpZXdpbmcsIGl0IG1ha2VzIHNlbnNlIHRvIGFkZCBpdCBmcm9tDQp0aGUgYmVnaW5u
aW5nIGV2ZW4gdGhvdWdoIGl0IGlzIHJ1ZGltZW50YXJ5IGF0IHRoaXMgcG9pbnQuDQoNCj4gDQo+
IFRoZSBOVk1FX1pPTkVfU1RBVEVfRlVMTCBjYXNlIGlzIHVucmVhY2hhYmxlLg0KDQpJbmRlZWQu
IFRoaXMgc2hvdWxkIGJlIGludHJvZHVjZWQgaW4gdGhlIG5leHQgcGF0Y2guDQoNCk5vdywgSSd2
ZSBsb29rZWQgYXQgdGhpcyBjb2RlIGFnYWluIGFuZCB0aGUgYWN0aXZlL29wZW4gY291bnRpbmcg
aW4gdGhpcw0KZnVuY3Rpb24gZW5kcyB1cCB0byBiZSBub3QgcXVpdGUgcmlnaHQsIEkgYW0gZml4
aW5nIGl0Lg0KDQo+IA0KPiA+ICsNCj4gPiArICAgICAgICB6b25lLT53X3B0ciA9IHpvbmUtPmQu
d3A7DQo+ID4gKyAgICAgICAgbnZtZV9zZXRfem9uZV9zdGF0ZSh6b25lLCBzZXRfc3RhdGUpOw0K
PiA+ICsgICAgfQ0KPiA+ICt9DQo=


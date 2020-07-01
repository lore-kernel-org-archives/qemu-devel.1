Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF96C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD2520771
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Nkl+Y42r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aWCkkYmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD2520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqRHg-00079g-W7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 21:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44418e349=Dmitry.Fomichev@wdc.com>)
 id 1jqRGw-0006Ul-V0; Tue, 30 Jun 2020 21:10:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44418e349=Dmitry.Fomichev@wdc.com>)
 id 1jqRGs-0003X2-2r; Tue, 30 Jun 2020 21:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593565842; x=1625101842;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=saRmb25KNTCItdrTy0wAWcyNFoWQt9JK+Y7561nQfCE=;
 b=Nkl+Y42rGbtqUzMrexsdIZ/PO9d/QOKL0BtPLnoYEdMNSr6TKd5+0C8p
 CwzoN9ClkRDr/ZDbqSoKYG/lzkeo0yXmqP9v4uLdU7hc93yzA2GujZZBm
 GlxyGESQDkcULzFpxGC/0r4UBM+0bp3LkvpmfnD91fuPEXKbiL5AGSMum
 TCXTWqYOsZAzjX5mDdSP13bkP5tfILOjElaxfWu96YerRn6IdK6flx5Wh
 kZq8/ffzZ/0cWu5qtIkmRBxYWjLIGfgHeHEIHIYim998PEb7kaBOjXQaf
 mXQeXAI591K0BAjJskxOZ18V0b3FbeNBLcxVnKPEfaIxdgSFFJ3RLweVM A==;
IronPort-SDR: ksaf8eA/W6B8s1fPAImTlykRRhtAq0cXRRZVtT6khFj+D2LVlhaXWNsifgcZAaihYcqcnlEMc3
 CdlxbO304rz1ZjeTEqXPYyPyo5EmKeOouEoJYYQvZEWiFiRFAbEnKnxfrSdABhsI2GlpogT369
 R6m4+YIpEgcFdJNroK59h/mJiLWtgc6nlZvqFqEH7dQ+Bvm2g0fJw7vS7+Hnv5oYnxwjOOi1JA
 9AgarMwiGYsC9TFRzSMOD2ScA8wqOdDW8qvcqC29GKzU9FDI89qCA1Lz3Vqa/jcF5OiaESipQ5
 vTo=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="142679804"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 09:10:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/eLPxkh2H+wJ0y/u5w0lacDb6mG4WMFm0p9W3MdJHSVREOgSAosn82mtvlJ8/Ut5RpMZgHT2f97aOhSkIB8Bmv+0yX0RYGBqf5EmrH243uKjUtOWGjv9O9paPp98+xVk4DwN855soRjZGgSvQOX8wclUHWlAzXV9RipWSeNCVYYGf+JQnwFJJlEDXRRqxLYs+atObGkp/wTJRcYIYJgE8bMxeMb+IiwjdjS61YjQlDd4CdaMc94sZIhOjvLDdrgAIReYUdg6Nzpo/cdA5gNYxbJwnw1MyMk2mT7i+imTxdoa/Kauh+/xb0LsmfCnByznJp/+ZtjhUaONFJ4IBb5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saRmb25KNTCItdrTy0wAWcyNFoWQt9JK+Y7561nQfCE=;
 b=ZtDA67mvpljchMg3g21csYMTxMzZkaihRIe8+JmttWuO2EzqDcPxDovN2s3Zb/UOKpPEU9WwajpxbOgEP7JHmxb3cg53z5yKR99W3XLolIpIn1gJ4b/PXNmwOvGLzn3/x18y7gMPC6ST3GPcwTomN9pKDohCgJ4p5WWNdWRQd0+7W9itMGW/cjPlX5rVP/gwOmLjbdYYE0GsfZcLspJLuTRRu2Qk527p+Co73aFVw6UI/Qdweiyc6MZI6aPpDQLHztSQ3g8+5dqla1lsq+yRpgMuCVHhTrh45wiLuY196+D2xV6/qe77ZUg74ndS1szvogNWy/GRWeNeOgX0GAuDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saRmb25KNTCItdrTy0wAWcyNFoWQt9JK+Y7561nQfCE=;
 b=aWCkkYmO/Ca+Iu+AFh8uN4fpVezb5s3GGVZnaADuoAnNYz1FQ+d0d3LJpthpyl4ps9JKAzECZEJyruB+E/I1CKBmGIQ2n14vXjDcRtGn0jWdWT+f38HvM9cXmTz9huG2wrCsbrnSw+0hnBVSxTkcSIy+1KvfO4akk3p5yAOLO/k=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5853.namprd04.prod.outlook.com (2603:10b6:208:a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 01:10:34 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 01:10:34 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: RE: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
Thread-Topic: [PATCH 00/10] hw/block/nvme: namespace types and zoned namespaces
Thread-Index: AQHWTsV/GTOpn/aUDkyv9dIVbPCJKqjxHw6AgAB9twCAADshsA==
Date: Wed, 1 Jul 2020 01:10:34 +0000
Message-ID: <MN2PR04MB595168350AC11C9A30604CC7E16C0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
 <20200630202754.bleks4kxagaflg7y@apples.localdomain>
In-Reply-To: <20200630202754.bleks4kxagaflg7y@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89b1a07c-5f07-49e4-6c2c-08d81d5b8ecc
x-ms-traffictypediagnostic: MN2PR04MB5853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58538462A5B997446EBF01CAE16C0@MN2PR04MB5853.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NVb/it+W4AFtWuHEy8Fy0fUPYBULF619eHp+DdtaKw9kcN1+1mcbClqVXgA4zKetZcDKgkqwvQ9SFHbPrtlkOEI7i9XpcXH7BRTAfQKW8E1SMPdTnQxjEQ3Wj4E1XTXghMp6kFRldNyxJRIdzdE091TXlcm5Q5mIT/jijvDb50ue2XIoqtGszC2Y7Ub0543Owq0Lnb4EwQtNg4zu6zcgFGpEEOEjzPyxhIX8uo3z7gg+9paEtQa8Lb7eedOoetnXf+XB1yZx0mGLkIE5CbnTfd50GfCSqtaqZsTWI1X+mXurIYbhTywFfganrXL/a5oDI2AmHXe70Di/Fy4P/bY3UbGcICBkGwyXjswEWZrcLdjcw6I//3WNg2VkTJVqIPrAbqRYnBiN2V2PFYiw0SFYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(7696005)(2906002)(54906003)(66556008)(71200400001)(8936002)(66476007)(8676002)(76116006)(478600001)(186003)(52536014)(966005)(66446008)(64756008)(66946007)(110136005)(6636002)(6506007)(53546011)(86362001)(4326008)(316002)(7416002)(9686003)(83380400001)(55016002)(33656002)(5660300002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 2IIgodVPxodcGlQW5Rvan86l8KF1e+FbrLCFT5btF5TTpa8dK5whrlcMKxyf6LTlO2kqvWm2hmTDBwR50KFYAgvqOEqTqXr8cQVqgQ9gwWTrMCXi1kM6hlX53GplzYOGwe0NDHptoQJCwqstolzTjE2DfRHIEy/pTccrJKdE+7w88kynarfvvxPW03IQKxv2w6NZF/NTetyk5cja2coVqf+lsJE4heUsfdsQqZRvXkUF6HbtoBM3iatWec/WiBlyFm3hk6sdWF9jGQyPMGnzMdTlbIrmIIfaWPLFIsI7HtyoUQZ7qrHJehmcQO7FAFMYFE/OtX3jYaISWxJS++S4GDi3SHl/RsTsEIoXj91t3HNNo27L//PsucTmSfUPXpZskKXGbih72UPLO2dOMr2oqB0Eb2GHDmI+Wl4CYhsrv0RQytzsyBzre+8qJApZVLgqBL8qpc51Ka2WSENzxiKqItOADB79cztsTz4mOWu+yS0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b1a07c-5f07-49e4-6c2c-08d81d5b8ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 01:10:34.6856 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1x+tTZJ4CRoadF1aWns+oUF18icADWyAQhnk05GfeVdFOXr4XS6Y54TUhYsTjoGnkDtoYjMNAC1ilB59+agHiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5853
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=44418e349=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 21:10:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2xhdXMgSmVuc2VuIDxp
dHNAaXJyZWxldmFudC5kaz4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAzMCwgMjAyMCA0OjMwIFBN
DQo+IFRvOiBOaWtsYXMgQ2Fzc2VsIDxOaWtsYXMuQ2Fzc2VsQHdkYy5jb20+DQo+IENjOiBxZW11
LWJsb2NrQG5vbmdudS5vcmc7IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ftc3VuZy5jb20+Ow0K
PiBxZW11LWRldmVsQG5vbmdudS5vcmc7IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47
IE1heCBSZWl0eg0KPiA8bXJlaXR6QHJlZGhhdC5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRo
YXQuY29tPjsgSmF2aWVyIEdvbnphbGV6DQo+IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT47IE1h
eGltIExldml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPjsNCj4gUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgRG1pdHJ5IEZvbWljaGV2DQo+IDxEbWl0cnkuRm9t
aWNoZXZAd2RjLmNvbT47IERhbWllbiBMZSBNb2FsDQo+IDxEYW1pZW4uTGVNb2FsQHdkYy5jb20+
OyBNYXRpYXMgQmpvcmxpbmcgPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDAwLzEwXSBody9ibG9jay9udm1lOiBuYW1lc3BhY2UgdHlwZXMgYW5kIHpvbmVk
DQo+IG5hbWVzcGFjZXMNCj4gDQo+IE9uIEp1biAzMCAxMjo1OSwgTmlrbGFzIENhc3NlbCB3cm90
ZToNCj4gPiBPbiBUdWUsIEp1biAzMCwgMjAyMCBhdCAxMjowMToyOVBNICswMjAwLCBLbGF1cyBK
ZW5zZW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcu
Y29tPg0KPiA+ID4NCj4gPiA+IEhpIGFsbCwNCj4gPg0KPiA+IEhlbGxvIEtsYXVzLA0KPiA+DQo+
IA0KPiBIaSBOaWtsYXMsDQo+IA0KPiA+ID4NCj4gPiA+ICAgKiB0aGUgY29udHJvbGxlciB1c2Vz
IHRpbWVycyB0byBhdXRvbm9tb3VzbHkgZmluaXNoIHpvbmVzICh3cnQuIEZSTCkNCj4gPg0KPiA+
IEFGQUlDVCwgRG1pdHJ5J3MgcGF0Y2hlcyBkb2VzIHRoaXMgYXMgd2VsbC4NCj4gPg0KPiANCj4g
SG1tLCB5ZWFoLiBTb21ldGhpbmcgaXMgZ29pbmcgb24gYXQgbGVhc3QuIEl0J3Mgbm90IHJlYWxs
eSBjbGVhciB0byBtZQ0KPiB3aHkgaXQgd29ya3Mgb3Igd2hhdCBpcyBoYXBwZW5pbmcgd2l0aCB0
aGF0IGFkbWluIGNvbXBsZXRpb24gcXVldWUNCj4gdGltZXIsIGJ1dCBJJ2xsIGRpZyB0aHJvdWdo
IGl0Lg0KPiANCj4gPiA+DQo+ID4gPiBJJ3ZlIGJlZW4gb24gcGF0ZXJuaXR5IGxlYXZlIGZvciBh
IG1vbnRoLCBzbyBJIGhhdm4ndCBiZWVuIGFyb3VuZCB0bw0KPiA+ID4gcmV2aWV3IERtaXRyeSdz
IHBhdGNoZXMsIGJ1dCBJIGhhdmUgc3RhcnRlZCB0aGF0IHByb2Nlc3Mgbm93LiBJIHdvdWxkDQo+
ID4gPiBhbHNvIGJlIGhhcHB5IHRvIHdvcmsgd2l0aCBEbWl0cnkgJiBGcmllbmRzIG9uIG1lcmdp
bmcgb3VyIHZlcnNpb25zIHRvDQo+ID4gPiBnZXQgdGhlIGJlc3Qgb2YgYm90aCB3b3JsZHMgaWYg
aXQgbWFrZXMgc2Vuc2UuDQo+ID4gPg0KPiA+ID4gVGhpcyBzZXJpZXMgYW5kIGFsbCBwcmVwYXJh
dG9yeSBwYXRjaCBzZXRzICh0aGUgb25lcyBJJ3ZlIGJlZW4gcG9zdGluZw0KPiA+ID4geWVzdGVy
ZGF5IGFuZCB0b2RheSkgYXJlIGF2YWlsYWJsZSBvbiBteSBHaXRIdWJbMl0uIFVuZm9ydHVuYXRl
bHkNCj4gPiA+IFBhdGNoZXcgZ290IHNjcmV3ZWQgdXAgaW4gdGhlIG1pZGRsZSBvZiBtZSBzZW5k
aW5nIHBhdGNoZXMgYW5kIGl0DQo+IG5ldmVyDQo+ID4gPiBwaWNrZWQgdXAgdjIgb2YgImh3L2Js
b2NrL252bWU6IHN1cHBvcnQgbXVsdGlwbGUgbmFtZXNwYWNlcyIgYmVjYXVzZQ0KPiBpdA0KPiA+
ID4gd2FzIGdldHRpbmcgbGF0ZSBhbmQgSSBtYWRlIGEgbWlzdGFrZSB3aXRoIHRoZSBDQydzLiBT
byBteSBwb3N0ZWQgc2VyaWVzDQo+ID4gPiBkb24ndCBhcHBseSBhY2NvcmRpbmcgdG8gUGF0Y2hl
dywgYnV0IHRoZXkgYWN0dWFsbHkgZG8gaWYgeW91IGZvbGxvdyB0aGUNCj4gPiA+IEJhc2VkLW9u
J3MgKC4uLiBvciBqdXN0IGdyYWIgWzJdKS4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gICBbMV06IE1l
c3NhZ2UtSWQ6IDwyMDIwMDYxNzIxMzQxNS4yMjQxNy0xLWRtaXRyeS5mb21pY2hldkB3ZGMuY29t
Pg0KPiA+ID4gICBbMl06IGh0dHBzOi8vZ2l0aHViLmNvbS9iaXJrZWx1bmQvcWVtdS90cmVlL2Zv
ci1tYXN0ZXIvbnZtZQ0KPiA+ID4NCj4gPiA+DQo+ID4gPiBCYXNlZC1vbjogPDIwMjAwNjMwMDQz
MTIyLjEzMDcwNDMtMS1pdHNAaXJyZWxldmFudC5kaz4NCj4gPiA+ICgiW1BBVENIIDAvM10gaHcv
YmxvY2svbnZtZTogYnVtcCB0byB2MS40IikNCj4gPg0KPiA+IElzIHRoaXMgdGhlIG9ubHkgcGF0
Y2ggc2VyaWVzIHRoYXQgdGhpcyBzZXJpZXMgZGVwZW5kcyBvbj8NCj4gPg0KPiA+IEluIHRoZSBi
ZWdpbm5pbmcgb2YgdGhlIGNvdmVyIGxldHRlciwgeW91IG1lbnRpb25lZA0KPiA+ICJOVk1lIHYx
LjQgbWFuZGF0b3J5IHN1cHBvcnQiLCAiU0dMcyIsICJtdWx0aXBsZSBuYW1lc3BhY2VzIiwNCj4g
PiBhbmQgImFuZCBtb3N0bHkganVzdCBvdmVyYWxsIGNsZWFuIHVwIi4NCj4gPg0KPiANCj4gTm8s
IGl0cyBhIHN0cmluZyBvZiBzZXJpZXMgdGhhdCBhbGwgaGFzIGEgQmFzZWQtb24gdGFnICh0aGF0
IGlzLCAiW1BBVENIDQo+IDAvM10gaHcvYmxvY2svbnZtZTogYnVtcCB0byB2MS40IiBoYXMgYW5v
dGhlciBCYXNlZC1vbiB0YWcgdGhhdCBwb2ludHMNCj4gdG8gdGhlIGRlcGVuZGVuY3kgb2YgdGhh
dCkuIFRoZSBwb2ludCB3YXMgdG8gaGF2ZSBwYXRjaGV3IG5pY2VseSBhcHBseQ0KPiBldmVyeXRo
aW5nLCBidXQgaXQgYnJva2UgbWlkd2F5Li4uDQo+IA0KPiBBcyBQaGlsaXBwZSBwb2ludGVkIG91
dCwgYWxsIG9mIHRoZSBwYXRjaCBzZXRzIGFyZSBpbnRlZ3JhdGVkIGluIHRoZQ0KPiBHaXRIdWIg
dHJlZSwgYXBwbGllZCB0byBRRU1VIG1hc3Rlci4NCj4gDQo+ID4NCj4gPiBJIHRoaW5rIHRoYXQg
eW91IGhhdmUgZG9uZSBhIGdyZWF0IGpvYiBnZXR0aW5nIHRoZSBOVk1lDQo+ID4gZHJpdmVyIG91
dCBvZiBhIGZyYW5rZW5zdGF0ZSwgYW5kIG1hZGUgaXQgY29tcGxpYW50IHdpdGgNCj4gPiBhIHBy
b3BlciBzcGVjIChOVk1lIDEuNCkuDQo+ID4NCj4gPiBJJ20gYWxzbyBhIGJpZyBmYW4gb2YgdGhl
IHJlZmFjdG9yaW5nIHNvIHRoYXQgdGhlIGRyaXZlcg0KPiA+IGhhbmRsZXMgbW9yZSB0aGFuIG9u
ZSBuYW1lc3BhY2UsIGFuZCB0aGUgbmV3IGJ1cyBtb2RlbC4NCj4gPg0KPiANCj4gV2VsbCwgdGhh
bmtzISA6KQ0KPiANCj4gPiBJIGtub3cgdGhhdCB5b3UgZmlyc3Qgc2VudCB5b3VyDQo+ID4gIm52
bWU6IHN1cHBvcnQgTlZNZSB2MS4zZCwgU0dMcyBhbmQgbXVsdGlwbGUgbmFtZXNwYWNlcyINCj4g
PiBwYXRjaCBzZXJpZXMgSnVseSwgbGFzdCB5ZWFyLg0KPiA+DQo+ID4gTG9va2luZyBhdCB5b3Vy
IG91dHN0YW5kaW5nIHBhdGNoIHNlcmllcyBvbiBwYXRjaHdvcms6DQo+ID4gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvbGlzdC8/c3VibWl0dGVyPTE4ODY3
OQ0KPiA+DQo+ID4gKEZlZWwgZnJlZSB0byBjb3JyZWN0IG1lIGlmIEkgaGF2ZSBtaXN1bmRlcnN0
b29kIGFueXRoaW5nLikNCj4gPg0KPiA+IEkgc2VlIHRoYXQgdGhlc2UgYXJlIHJlbGF0ZWQgdG8g
eW91ciBwYXRjaCBzZXJpZXMgZnJvbSBKdWx5IGxhc3QgeWVhcjoNCj4gPiBody9ibG9jay9udm1l
OiBidW1wIHRvIHYxLjMNCj4gPiBody9ibG9jay9udm1lOiBzdXBwb3J0IHNjYXR0ZXIgZ2F0aGVy
IGxpc3RzDQo+ID4gaHcvYmxvY2svbnZtZTogc3VwcG9ydCBtdWx0aXBsZSBuYW1lc3BhY2VzDQo+
ID4gaHcvYmxvY2svbnZtZTogYnVtcCB0byB2MS40DQo+ID4NCj4gDQo+IFllYWggdGhpcyBzdHVm
ZiBoYXMgYmVlbiBhcm91bmQgZm9yIGEgd2hpbGUgc28gdGhlIGhpc3Rvcnkgb24gcGF0Y2h3b3Jr
DQo+IGlzIGEgbWVzcy4NCj4gDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNlcmllcyBzZWVtcyBtaW5v
ciBhbmQgY291bGQgcHJvYmFibHkgYmUgbWVyZ2VkIGltbWVkaWF0ZWx5Og0KPiA+IGh3L2Jsb2Nr
L252bWU6IGhhbmRsZSB0cmFuc2llbnQgZG1hIGVycm9ycw0KPiA+DQo+IA0KPiBTdXJlLCBidXQg
aXQncyBuaWNlciBpbiBjb21iaW5hdGlvbiB3aXRoIHRoZSBwcmV2aW91cyBzZXJpZXMNCj4gKCJo
dy9ibG9jay9udm1lOiBBSU8gYW5kIGFkZHJlc3MgbWFwcGluZyByZWZhY3RvcmluZyIpLiBXaGF0
IEkgL2Nhbi8gZG8NCj4gaXMgcmlwIG91dCAiaHcvYmxvY2svbnZtZTogYWxsb3cgbXVsdGlwbGUg
YWlvcyBwZXIgY29tbWFuZCIgYXMgdGhhdA0KPiBwYXRjaCBtaWdodCByZXF1aXJlIG1vcmUgdGlt
ZSBmb3IgcmV2aWV3cy4gVGhlIHJlc3Qgb2YgdGhhdCBzZXJpZXMgYXJlDQo+IGNsZWFuIHVwcyBh
bmQgYSBjb3VwbGUgb2YgYnVnIGZpeGVzLg0KPiANCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVz
IGxvb2tzIGEgYml0IHdlaXJkOg0KPiA+IGh3L2Jsb2NrL252bWU6IEFJTyBhbmQgYWRkcmVzcyBt
YXBwaW5nIHJlZmFjdG9yaW5nDQo+ID4NCj4gPiBTaW5jZSBpdCBsb29rcyBsaWtlIGEgVjEgcG9z
dCwgYW5kIHdhcyBmaXJzdCBwb3N0ZWQgeWVzdGVyZGF5Lg0KPiA+IEhvd2V2ZXIsIDIgb3V0IG9m
IHRoZSAxNyBwYXRjaGVzIGluIGFyZSBBY2tlZC1ieTogS2VpdGguDQo+ID4gKFBlcmhhcHMgc29t
ZSBvZiB5b3VyIHByZXZpb3VzbHkgcG9zdGVkIHBhdGNoZXMgd2FzIHB1dCBpbnNpZGUNCj4gPiB0
aGlzIG5ldyBwYXRjaCBzZXJpZXM/KQ0KPiA+DQo+IA0KPiBZZXMgdGhhdCBhbmQgcmV2aWV3ZXJz
IHJlcXVlc3RlZCBhIGxvdCBvZiBzZXBhcmF0aW9uLCBzbyBiYXNpY2FsbHkgdGhlDQo+IHBhdGNo
IHNldCBiYWxsb29uZWQuDQo+IA0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXM6DQo+ID4gaHcv
YmxvY2svbnZtZTogbmFtZXNwYWNlIHR5cGVzIGFuZCB6b25lZCBuYW1lc3BhY2VzDQo+ID4NCj4g
PiBXaGljaCB3YXMgZmlyc3QgcG9zdGVkIHRvZGF5LiBVcCB1bnRpbCBlYXJsaWVyIHRvZGF5LCB3
ZSBoYXZlbid0IHNlZW4NCj4gPiBhbnkgcGF0Y2hlcyBmcm9tIHlvdSByZWxhdGVkIHRvIFpOUyAo
b25seSBvdmVyYWxsIE5WTWUgY2xlYW51cHMpLg0KPiA+IERtaXRyeSdzIFpOUyBwYXRjaGVzIGhh
dmUgYmVlbiBvbiB0aGUgbGlzdCBzaW5jZSAyMDIwLTA2LTE2Lg0KPiA+DQo+IA0KPiBZZWFoLCBh
cyBJIG1lbnRpb25lZCBpbiBteSBjb3ZlciBsZXR0ZXIsIEkgd2FzIG9uIGxlYXZlLCBzbyBJIHdh
c24ndA0KPiBhcm91bmQgZm9yIHRoZSBiaWcgWk5TIHJlbGVhc2UgZGF5IGVpdGhlci4gQnV0LCBo
b25lc3RseSwgSSB0aGluayB0aGlzDQo+IGlzIGlycmVsZXZhbnQgLSBjb2RlIHNob3VsZCBiZSBt
ZXJnZWQgYmFzZWQgb24gdGVjaG5pY2FsIHJlYXNvbnMgKG5vdA0KPiB0ZWNobmljYWxpdGllcyku
DQo+IA0KPiA+DQo+ID4gSnVzdCBhIGZyaWVuZGx5IHN1Z2dlc3Rpb24sIGhvdyBhYm91dDoNCj4g
Pg0KPiA+IDEpIFdlIGdldCB5b3VyDQo+ID4NCj4gPiBody9ibG9jay9udm1lOiBidW1wIHRvIHYx
LjMNCj4gPiBody9ibG9jay9udm1lOiBzdXBwb3J0IHNjYXR0ZXIgZ2F0aGVyIGxpc3RzDQo+ID4g
aHcvYmxvY2svbnZtZTogc3VwcG9ydCBtdWx0aXBsZSBuYW1lc3BhY2VzDQo+ID4gaHcvYmxvY2sv
bnZtZTogYnVtcCB0byB2MS40DQo+ID4NCj4gPiBwYXRjaCBzZXJpZXMgbWVyZ2VkLg0KPiA+DQo+
IA0KPiBCbG93aW5nIG15IG93biBob3JuIGhlcmUsIGJ1dCB5ZWFoLCBpdCBzZWVtcyBsaWtlIGV2
ZXJ5b25lIHdvdWxkIGxpa2UgdG8NCj4gc2VlIHRoaXMgbWVyZ2VkLg0KPiANCj4gPiAyKSBXZSBn
ZXQgRG1pdHJ5J3MgcGF0Y2ggc2VyaWVzIG1lcmdlZC4NCj4gPg0KPiA+IFNoYXJlZCA0OnRoKSBJ
ZiB0aGVyZSBpcyBhbnkgZmVhdHVyZSB0aGF0IHlvdSBtaXNzIGluIERtaXRyeSdzIHBhdGNoIHNl
cmllcywNCj4gPiBwZXJoYXBzIHlvdSBjb3VsZCBzZW5kIHBhdGNoZXMgdG8gYWRkIHdoYXQgeW91
IGFyZSBtaXNzaW5nLg0KPiA+DQo+IA0KPiBMb29rcyBsaWtlIHRoZSB0d28gdmVyc2lvbiBhcmUg
cHJldHR5IG11Y2ggb24gcGFyIGluIHRlcm1zIG9mIGZlYXR1cmVzLg0KPiANCj4gPiBTaGFyZWQg
NDp0aCkgWW91ciBvdGhlciBwYXRjaCBzZXJpZXM6DQo+ID4gaHcvYmxvY2svbnZtZTogQUlPIGFu
ZCBhZGRyZXNzIG1hcHBpbmcgcmVmYWN0b3JpbmcgY291bGQgZ2V0IG1lcmdlZC4NCj4gPg0KPiAN
Cj4gQXMgc3RhdGVkIGFib3ZlIEkgdGhpbmsgaXRzIG9ubHkgYSBzaW5nbGUgY29tbWl0ICgiaHcv
YmxvY2svbnZtZTogYWxsb3cNCj4gbXVsdGlwbGUgYWlvcyBwZXIgY29tbWFuZCIpIHRoYXQgaXMg
Y29udHJvdmVyc2lhbCBpbiB0aGF0IHNlcmllcy4NCj4gDQo+ID4NCj4gPiBQbGVhc2UgZG9uJ3Qg
dGFrZSB0aGlzIHN1Z2dlc3Rpb24gdGhlIHdyb25nIHdheSwgSSdtIHNpbXBseSB0cnlpbmcNCj4g
PiB0byBjb21lIHVwIHdpdGggYSB3YXkgdG8gbW92ZSBmb3J3YXJkIGZyb20gaGVyZS4NCj4gPg0K
PiANCj4gQWJzb2x1dGVseSAtIEkgdG90YWxseSBnZXQgdGhhdCB5b3Ugd2FudCB0byBtb3ZlIGZv
cndhcmQgd2l0aCBEbWl0cnkncw0KPiBzZXJpZXMsIGJ1dCBJJ2QgbGlrZSB0byBmaW5pc2ggbXkg
cmV2aWV3IGJlZm9yZSBjb21taXR0aW5nIHRvIGFueXRoaW5nLg0KPiANCg0KS2xhdXMsDQoNCkkg
c2VlIHRoYXQgWk5TIHNlcmllcyBmcm9tIFdEQyBpcyBwcmV0dHkgbXVjaCBvcnRob2dvbmFsIHRv
IG1vc3Qgb2YgeW91cg0KcGF0Y2hlcyBmcm9tICJidW1wIHRvIDEuMy9idW1wIHRvIDEuNCIgc2Vy
aWVzLi4uIHdpdGggYSBmZXcgbm90YWJsZQ0KZXhjZXB0aW9ucyAtIEkgaGFkIHRvIGFkZCBzdXBw
b3J0IGZvciBHZXQgTG9nIFBhZ2UgY29tbWFuZCwgQ29tbWFuZA0KRWZmZWN0cyBMb2cgYW5kIEFF
UnMgdG8gZnVsZmlsbCBaTlMgcHJvdG9jb2wgcmVxdWlyZW1lbnRzLiBJIHVuZGVyc3RhbmQgdGhh
dA0KeW91J3ZlIGhhZCB0aGF0IGZ1bmN0aW9uYWxpdHkgYWxyZWFkeSBzdGFnZWQgaW4geW91ciAi
YnVtcCB0byAxLjMiDQpwYXRjaHNldCBhbmQgYmV5b25kIGFuZCBJIGRvbid0IGluc2lzdCB0aGF0
IHRoZSBpbXBsZW1lbnRhdGlvbnMgb2YgdGhlc2UNCmZlYXR1cmVzIGZyb20gb3VyIFpOUyBzZXJp
ZXMgYXJlIG5lY2Vzc2FyaWx5IHRvIGJlIHVzZWQuIEkgdGhpbmsgTmlrbGFzJyBwbGFuDQphcHBl
YXJzIHRvIGJlIHF1aXRlIHByb2R1Y3RpdmUgLSBmb3IgdXMgdG8gcmViYXNlIG9uIHRvcCBvZiAi
YnVtcCB0byAxLjMuLjEuNCINCmFuZCByZXZpZXcgdGhlc2UgcGF0Y2hlcyBpbiB0aGUgcHJvY2Vz
cywgYXBwbHkgb3VyIHNlcmllcyBhbmQgdGhlbg0KaW5jb3Jwb3JhdGUgc29tZSBvZiB0aGUgaWRl
YXMgZnJvbSB5b3VyIFpOUy9OU1R5cGVzIHBhdGNoc2V0IG9uIHRvcCBvZiB0aGF0Lg0KVGhpcyB3
YXksIHZlcnkgbGl0dGxlIHdvcmsgd2lsbCBnbyB0byB3YXN0ZS4NCg0KQ2hlZXJzLA0KRG1pdHJ5
DQoNCj4gDQo+IENoZWVycywNCj4gS2xhdXMNCg==


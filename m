Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A1BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28191206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Abt0A06m";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TB4HrrC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28191206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIG8V-0008Jn-3D
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 14:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIG7G-0007bW-Qs; Tue, 15 Sep 2020 14:55:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=520035bb9=Dmitry.Fomichev@wdc.com>)
 id 1kIG7B-00082S-RA; Tue, 15 Sep 2020 14:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600196142; x=1631732142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N18ds2AfeoonkorqbkqUB1EAJuBfvPMPBkR+aoFLlK8=;
 b=Abt0A06mQzlkUfMyn56gQzz8btfwsVPOzEEFpObDr7kWt/c2y8EbtblY
 Hc+ILUY9EWCwn2mbdapJnNY+YD4QU6EI5DlWX109skN860k723Z4Z7bnC
 yc4oBwKKMCEwlJ+ZgzQp2fjGx3Am8rUZCZIMpE3tKteGty+8Z0HncA+9T
 sUDZFvG9qPq0wOFn0SYLkuQtCW3yhuG//KLPdafug8tdoV8IAuozTr25Y
 mrFegK7hAhjKjgl2rNkF5B1CQHj0GCTNv0N0qiki3fXVuSXIEzukqItlY
 n4JzDjeyyh+375tlA3A5AZuryppwCDfyxG/OA50PSPj5+fqXswQmBK9Y/ g==;
IronPort-SDR: PK26eTPuO2v5L6i6p/DMO40jyVlkG/67jF37z3i7b2WaKZk+4aQ36aj+MTnhnQnYptC/ILBlrC
 uVrsR7XOLV4usfg0cscIxhzAREoP36ZnAGK7zunDnEOghBBd1an8AO28JG+1PlrL1LIxqcRdMC
 fOnI9l49a8ga+bF7uHttfDA73mU9PhPP/xZjQ7r/09BabqoWYU9Evg+LbaTM/jsNDyFq3UtBs6
 qKGCkoX52QxFpw8+qiAblmSKXdCfGD+RKNzWZwR99siAbOcUW6Fe5Mh+rAShpJCtd3DoHomtC2
 XS0=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147459873"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 02:55:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9h1LFY+9IdqO8CCCo0X5ZAQ58xCZWzTkBR+I7nL0bdjPxWlsdZdVnDhU2Do1YYd7PVulKYpDVB3lTMluluaUFhbpaAuOMqE9H4eMw39uPHk+NY+OnGfvzCrveaPsLq5obPB7JCt9MIuw+CEe6gmbGzKTHVPMiPp4+nNT+sXOoPAtbWnwq09LMXEV0RrBJxcbgFLEz0pZKFEqhKbo5TSjnq5mhAzUTjzIOWKy9uq0feok0HODYxxGkQCJ5bstPz/2BnZFlc8d31r1Zc//WIkr/TisVtM1B96QKjJ5fn/357CleLHiw9Wb5qxypOVPpfn7EOMahVztUj1Eb1yjiM7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N18ds2AfeoonkorqbkqUB1EAJuBfvPMPBkR+aoFLlK8=;
 b=Bf+Z28gwXkRVhY50wYNBIvSdbcXI9TW7Z13RfBqEefI6cGYfiY1Plnico+tWO9cE+ca3lBQAKvBdFkztqfmrcuq64/9MhUWA2Rs4dcJ9WQ0TdCrAi4rXN2RyGCsRERMT5Yglw76RrXAlOs2nPfD0BBCMGOFTI8IExOoGwW+hFkSpWj8Ztjb0rsXPBfVFpNcjhUeDa9ncTbPLyaVJEy80ve4s0S7cRjb9HCNYWyWgQ2TXlnHlfp1JrT7aNBFuLaXR4mSbF6WJOVfaUWL6PnGSBMxwPIXz6sWnET0RChMB4Q607IihfZ3ydWIjzAof4RpZHjVSyARMEwaNg7VfwHXLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N18ds2AfeoonkorqbkqUB1EAJuBfvPMPBkR+aoFLlK8=;
 b=TB4HrrC/bWO1lF9iHfZqC4MQ7kgvfKakOSkLDTCFhAJyC7sPIuVZ3sp4vqjO4woiYd/CnGDxqyf2XsrSbXkSX0VtK6qWiOtrRH+yfXu9HkDU7xPZm2sqwmN+DzfCNsgCTmsN1ebkn/zjGS2IeC4SDWJZqrQJPkIPUQfx42eYOQc=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB6253.namprd04.prod.outlook.com (2603:10b6:208:d9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 15 Sep
 2020 18:55:34 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 18:55:34 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v2 00/15] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v2 00/15] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWiVezLsHx9+fQQUaMNubEbRyAk6lpVTiAgAC6UoA=
Date: Tue, 15 Sep 2020 18:55:33 +0000
Message-ID: <MN2PR04MB5951445AEDFF95F6D3928079E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
 <20200915074351.GC499689@apples.localdomain>
In-Reply-To: <20200915074351.GC499689@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c9ea5dd-a68f-4764-100f-08d859a8ed46
x-ms-traffictypediagnostic: MN2PR04MB6253:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB62532D18B5F04387D2E54438E1200@MN2PR04MB6253.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9CSgT/WDyhg3Rfw40/ekq/MImUn612BoLL+HpVI99vYKDO423d7Fd4BRVsxa0WVbhN4RvL8H3SHQ1eFPP+teqL8D3VFWy/uFopg6LGV6SbBZJxOfv1vgQh4N4JAmsiAMPULZlcjhLwQxBT8X/9Qrspr0AKykb5bFA26QyMEuP7PIkUuHeaBTF3vdE/MmlbljVa7r64IIhv32GLKYXIDnDW+zyU5GvuQpjITHPDU/4Y++usy2y7V5FM2xIg18vJUwPyOvVrKXIsKlslmxPNsOkGPhmemUkNY5O8cUZ4DC1ozLDY22Wui8e5BVmwU7vnxW0lY+qaXZXrok3MnagQi1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(54906003)(316002)(86362001)(7696005)(186003)(8676002)(33656002)(8936002)(83380400001)(55016002)(2906002)(52536014)(4744005)(76116006)(5660300002)(9686003)(66946007)(6506007)(6916009)(66446008)(64756008)(26005)(71200400001)(53546011)(66556008)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cntXRJ+6WaCtHVJtRbXjhMCCb7U8FG3Ig7V9vahYpV1yBuE3XDFZOSngtq8ZqNLj4Irk3umQ7uc4ZDlmC7xg7MBphyDyAhuWUwGSHpwro+BsL7zFT5i8e2JS74oM9nfXNRxmbi9kGVqzMN+LN7L2qLOpUcduo5/xF6hyeFrrOkDf5L3P7ZyxiwsNUOZvFht0jtpAK9YOIR8AbTAbEm8dz1a9lLN5ukc8fZrjAtOKkjs5UK6edFH0wXU+bj8VUa1J88hYmwSngWm7Jl+nSOsO3anBTWCgmba+UBbCte/b6cQoCIywkZ8eRsvQDWDZOZpXGp1pNS5VTpXwo2rXQYz/LO1m0rnsMHyNMQJ+IU67rwHgydC9UUFGd6Sz7eWIhdvBkZyhiMdvGoZetQH/r0n7NCAOniZJyJ885J0orBui24Zx4aMVWCdvWaCOgy4sf0NeRkQ2L1xVh8iLcwGElqb1J0Tl9OU2dvjHZr4ZBRyrs2B91+J1OI/wDlQcnXd3zGaVDRAXt6TNCF5QuXJydMCdlaBCzlTGJkwbBJbVdxqJkCBOWzXLGjIOMmXzr2XlzE1UfGQh6YQIv3JTuJ8WTbgOllvpVQXGOOElitP9IwjGcEP98uB1IpamPfPBe/7idvPxuvmf8lqXomzOqyflMJAV3g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9ea5dd-a68f-4764-100f-08d859a8ed46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 18:55:34.1395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNvA8JfQgmRKLqgfFHRmvNoaX6PTGA2F8YozawQpghUyuV72DUlHv9JwLN42y2XdVt8TQyCS7rGNKFrYAzB0Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6253
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=520035bb9=Dmitry.Fomichev@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 14:55:38
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
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLbGF1cyBKZW5zZW4gPGl0c0Bp
cnJlbGV2YW50LmRrPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjAgMzo0NCBB
TQ0KPiBUbzogRG1pdHJ5IEZvbWljaGV2IDxEbWl0cnkuRm9taWNoZXZAd2RjLmNvbT4NCj4gQ2M6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz47IEtsYXVzIEplbnNlbg0KPiA8ay5qZW5z
ZW5Ac2Ftc3VuZy5jb20+OyBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgUGhpbGlwcGUN
Cj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgTWF4aW0gTGV2aXRza3kNCj4g
PG1sZXZpdHNreUByZWRoYXQuY29tPjsgRmFtIFpoZW5nIDxmYW1AZXVwaG9uLm5ldD47IE5pa2xh
cyBDYXNzZWwNCj4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IERhbWllbiBMZSBNb2FsIDxEYW1p
ZW4uTGVNb2FsQHdkYy5jb20+Ow0KPiBxZW11LWJsb2NrQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29t
PjsgTWF0aWFzIEJqb3JsaW5nIDxNYXRpYXMuQmpvcmxpbmdAd2RjLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiAwMC8xNV0gaHcvYmxvY2svbnZtZTogU3VwcG9ydCBOYW1lc3BhY2UgVHlw
ZXMNCj4gYW5kIFpvbmVkIE5hbWVzcGFjZSBDb21tYW5kIFNldA0KPiANCj4gT24gU2VwIDEzIDA3
OjU0LCBEbWl0cnkgRm9taWNoZXYgd3JvdGU6DQo+ID4gdjEgLT4gdjI6DQo+ID4NCj4gPiAgLSBJ
bmNvcnBvcmF0ZWQgZmVlZGJhY2sgZnJvbSBLbGF1cyBhbmQgQWxpc3RhaXIuDQo+IA0KPiBTaW5j
ZSBpdCdzIGJlZW4gYSB3aGlsZSBzaW5jZSBJIHJldmlld2VkIHRoaXMsIGl0IHdvdWxkIGhhdmUg
YmVlbiBuaWNlDQo+IGlmIHlvdSBoYWQgbGlzdGVkIHdoYXQgZmVlZGJhY2sgeW91IGluY29ycG9y
YXRlZCA7KQ0KDQpJJ2xsIHRyeSB0byBtYWtlIHRoZSBsaXN0IGFuZCBpbmNsdWRlIGl0IHdpdGgg
djQuLi4NCg==


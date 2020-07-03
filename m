Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD36C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC90D207D4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 00:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PvYtZZ7e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Db3O56Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC90D207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr9tY-0000Ni-60
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 20:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9qH-0002HS-WB; Thu, 02 Jul 2020 20:46:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=446c5dbe3=Dmitry.Fomichev@wdc.com>)
 id 1jr9qF-0006m8-1U; Thu, 02 Jul 2020 20:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593737171; x=1625273171;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fvcd1aGdvHVW2+ZHdD+606wtuJnjye/D0n6plxSY3ck=;
 b=PvYtZZ7e2nThyFUj0fBJ9IIq/f1S/NCdSbH/WtJ0xoZ49MhCABzWeWrS
 47zJ3z4vfJd+BZuJ1n6RRU8Ru7g+7OOzQ1/AEM+tzMjTVVDQziIcDQ/Lv
 0MFi4NkX/mOEQzQ3bXxKvQr4ixpFwrQGyNnd4oeJzarq1T/DRA7/M59ot
 coJAnGMze3RNJM4UzJojNYSTYFMFOKNB0cQPuihRRszYcRpogXKUIR/jt
 Sc0JzTa+xf5uO9DCynfhnBjXY2TCbKcqSfPBc7CA7Kt9uyr1EGF86ZZ6u
 xBm8fxQslF5R7CCI6AaHfqQO+j+uNy1VgLw3SKDLHOBPH2JfBB9UkHhgf Q==;
IronPort-SDR: Uu4ZywV/dvyPu22PfKSlVifpXQP7zIxf7gpSZioQp9JhPUWBXegXIXzGRrvzXUz4uU7vTghr72
 VGIKMejAvSUfSBJ2eu5pVSPd1EMt+XAl/JbEw9yDpnGpBhvGnNvJRQ1Zb9qEUuZW1rS/4lC7FK
 1/Uip+A29YMcdPuHGadxTwqY5sVgIEwGYp118bmDwQziXzAvzmTWe8co23eZr3n8DVGYlBmzgZ
 w26WlRKUHSPli/Gvqd61fN7FRXNqNI3B/vvmQmNOishvapJU2tWKu1NMfBrR8WP7xDrixj8emr
 GjM=
X-IronPort-AV: E=Sophos;i="5.75,306,1589212800"; d="scan'208";a="250767655"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 08:46:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtKdmGuK5LQWqJ5TjaCHttKq6Fw2gWauuhykuecRWxPzryoiPyX02oS6CX2YWT6cUrBS4zy3ZZuZmz2DcvHle99dUfvsHDTIsQzmd052KfUNMJQ05wtrAbj7sF3XEuF1Dt1UG4EBUAkjAJLur80tdJuAP4wE4wtU1wUpnPwNm55GSiALD4A2ijuvPofYknaJIN0Q/0EMdgrYkFMo1CVGNHApk1Q/1M/sOLAu9Im8goQ5RfBYjS1wnjt43qN5sexit68wvKGl61S0zeGsNZRx1ICMukAyGSd2Cmpy9xh59BnB9Oh06BX5u0H5ih70BAZ7H8JxRIfeQsfFgOE2oYy7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvcd1aGdvHVW2+ZHdD+606wtuJnjye/D0n6plxSY3ck=;
 b=DaDu/IqYBmrwrScoV0gUwYSiAKavN1rTTohioKFs6ad0IbVGxMmg9Tnyitk54jLzvAFzlq8sKdEAMgW+5D6cqoeUrLfVnGvqKtn55hHFq5YA2dthHgmVYoICxBpMuMrdFR8mjEfoP79Pvo9RhjoEXQyUq/Y+UGwIO5YUslNWTTpHdeufBEbuG6GVK0d8SO8PLTV6zUEc6GhQg1ij7wg3KdFgXubPumZbOGUZxpuLl2mCQ5kxRuI7Hss8/+DI56/ISzzBR+AVFjHneM2mgsBXokRInLxJQkFxffl/6MNoImgMDLmtbEhtM/iRuzZuD44feh0I+eGH/Wto9rAWKczwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvcd1aGdvHVW2+ZHdD+606wtuJnjye/D0n6plxSY3ck=;
 b=Db3O56CdKPJxx+WIZaFs4quTVVji/u7VGOopQHdergX7VeB0Ib3XuODkpypCA6f3CZxJKlB013+vOw8JwmKV59dgS8fmcw2MRrwY4XjXeDTvVYMF02yWjh3PKwcInSEado4c7Y+7Y2xdrhSKRJH/IuT1KJ6tflhqsOPVW4WhM38=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5552.namprd04.prod.outlook.com (2603:10b6:208:de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 00:46:06 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::60c5:4424:8ce4:59a9%5]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 00:46:06 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 11/17] hw/block/nvme: add remaining mandatory controller
 parameters
Thread-Topic: [PATCH 11/17] hw/block/nvme: add remaining mandatory controller
 parameters
Thread-Index: AQHWTkPoEQS22mG5skitLktvxW2+Maj1CiKA
Date: Fri, 3 Jul 2020 00:46:06 +0000
Message-ID: <d86eb2054e639be258e6d93d35f1e717a4d6fbc7.camel@wdc.com>
References: <20200629182642.1170387-1-its@irrelevant.dk>
 <20200629182642.1170387-12-its@irrelevant.dk>
In-Reply-To: <20200629182642.1170387-12-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [173.70.233.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2746ba2f-3673-4410-6097-08d81eea78ad
x-ms-traffictypediagnostic: MN2PR04MB5552:
x-microsoft-antispam-prvs: <MN2PR04MB555222723727E89921EE3AADE16A0@MN2PR04MB5552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F504LjXI0S77JFjkCFOn7EH1M22IN53ES2woNHZ6ZQihg8lwRHyzS6m/JA4736/QbdStF9HW4aWSyxER3ZyCGdk/pUTQc8yl5rSarmzafGbHYajNYKJ0+8945OCe6lRV+2H7RXStgl8/7E1m/lSWxAwLtLvDAJRDMcNWkFG0/BWe9p0k+AJ/wQijOpz+9YjDq3B0vLaehcLkK2puFts5pxCDSZSKjfZjfStH1q9QhDixww1uyL9kRPNS/ej553K+zfJ7+Pe8NlxzHdEUAfAUzHZMZHP0/icrHrb0+ZTsM/1hpZhZAbJ3BmfSe3hVI4uYF1PbsVKMHSXF4HtYLkuHyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(4326008)(186003)(76116006)(2616005)(83380400001)(6486002)(6512007)(110136005)(66946007)(66476007)(66446008)(54906003)(64756008)(66556008)(36756003)(71200400001)(8936002)(26005)(86362001)(316002)(5660300002)(2906002)(8676002)(478600001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: tj/peCFDeM4s1kvHS6ggkkVcjDtCCY8VvoZeRMEjxZ5ZUOZxJvlUykZbKl/aVUM7R8LySFttnrwnmdUw4oooOG9/l/Eob3mMEg1QzivMyuQrLMm/w3O6lVS3R3ky7utF2de72Rg6ZIz2ym4CwAXw9tFyDURxk7rRqLj17nsj86jA/qu2eL84omorXdm1WLQLVvSCb8A2z7gnw1fQCbITpXnttghBazd/3YeooAmHj2OeOI4E38fPdeune9piO2BD0C8vdOYwquBLRAVv3JtQic5ruIcKmXhkUSZWPWHWIfhim25CEwNSQaX/3Av9Cb1eoqaGb0w5H55/TVoogSZHWRTqUvraHSaYkgGOwQPSismUAvpMhFDuUttm1h8jYHcRu448cuoKNX9QAzpF1xDmO7LRSm2TPVOdm6QgV9hAx8uZxlVQ3U1xCEJfZ2BbDNaRtxu7Rp5Wi6UMnfzlptl+kjxs2dIeLv28zXJI3jxs2liEcp47zXD/Qg2ynmXnzJ0c
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F153492314D6D34EB2A7DC47878399AF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2746ba2f-3673-4410-6097-08d81eea78ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 00:46:06.6835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQ1cQuk9aVzbSw0MV1ypih9LeObmmqmp62y+a1bKzjfC2+yPYlxwhNGIVcOe4NU9ErUZrTbbZSgUbvenpyZbcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5552
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=446c5dbe3=Dmitry.Fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 20:46:09
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TEdUTSB3aXRoIG9uZSBzbWFsbCBuaXQgKHNlZSBiZWxvdykuLi4NCg0KUmV2aWV3ZWQtYnk6IERt
aXRyeSBGb21pY2hldiA8ZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20+DQoNCk9uIE1vbiwgMjAyMC0w
Ni0yOSBhdCAyMDoyNiArMDIwMCwgS2xhdXMgSmVuc2VuIHdyb3RlOg0KPiBGcm9tOiBLbGF1cyBK
ZW5zZW4gPGsuamVuc2VuQHNhbXN1bmcuY29tPg0KPiANCj4gQWRkIHN1cHBvcnQgZm9yIGFueSBy
ZW1haW5pbmcgbWFuZGF0b3J5IGNvbnRyb2xsZXIgb3BlcmF0aW5nIHBhcmFtZXRlcnMNCj4gKGZl
YXR1cmVzKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtsYXVzIEplbnNlbiA8ay5qZW5zZW5Ac2Ft
c3VuZy5jb20+DQo+IC0tLQ0KPiAgaHcvYmxvY2svbnZtZS5jICAgICAgIHwgMzkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ICBody9ibG9jay9udm1lLmggICAgICAg
fCAxOCArKysrKysrKysrKysrKysrKysNCj4gIGh3L2Jsb2NrL3RyYWNlLWV2ZW50cyB8ICAyICsr
DQo+ICBpbmNsdWRlL2Jsb2NrL252bWUuaCAgfCAgNyArKysrKysrDQo+ICA0IGZpbGVzIGNoYW5n
ZWQsIDYwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvYmxvY2svbnZtZS5jIGIvaHcvYmxvY2svbnZtZS5jDQo+IGluZGV4IGRhMTNjYTFkZGI2MC4u
NjQ3ZjQwODg1NGFlIDEwMDY0NA0KPiAtLS0gYS9ody9ibG9jay9udm1lLmMNCj4gKysrIGIvaHcv
YmxvY2svbnZtZS5jDQo+IEBAIC0xMDU3LDggKzEwNTcsMTYgQEAgc3RhdGljIHVpbnQxNl90IG52
bWVfZ2V0X2ZlYXR1cmUoTnZtZUN0cmwgKm4sIE52bWVDbWQgKmNtZCwgTnZtZVJlcXVlc3QgKnJl
cSkNCj4gICAgICB1aW50MzJfdCBkdzEwID0gbGUzMl90b19jcHUoY21kLT5jZHcxMCk7DQo+ICAg
ICAgdWludDMyX3QgZHcxMSA9IGxlMzJfdG9fY3B1KGNtZC0+Y2R3MTEpOw0KPiAgICAgIHVpbnQz
Ml90IHJlc3VsdDsNCj4gKyAgICB1aW50OF90IGZpZCA9IE5WTUVfR0VUU0VURkVBVF9GSUQoZHcx
MCk7DQo+ICsgICAgdWludDE2X3QgaXY7DQo+ICANCj4gLSAgICBzd2l0Y2ggKGR3MTApIHsNCj4g
KyAgICB0cmFjZV9wY2lfbnZtZV9nZXRmZWF0KG52bWVfY2lkKHJlcSksIGZpZCwgZHcxMSk7DQo+
ICsNCj4gKyAgICBpZiAoIW52bWVfZmVhdHVyZV9zdXBwb3J0W2ZpZF0pIHsNCj4gKyAgICAgICAg
cmV0dXJuIE5WTUVfSU5WQUxJRF9GSUVMRCB8IE5WTUVfRE5SOw0KPiArICAgIH0NCj4gKw0KPiAr
ICAgIHN3aXRjaCAoZmlkKSB7DQo+ICAgICAgY2FzZSBOVk1FX1RFTVBFUkFUVVJFX1RIUkVTSE9M
RDoNCj4gICAgICAgICAgcmVzdWx0ID0gMDsNCj4gIA0KPiBAQCAtMTA4OSwxNCArMTA5NywyNyBA
QCBzdGF0aWMgdWludDE2X3QgbnZtZV9nZXRfZmVhdHVyZShOdm1lQ3RybCAqbiwgTnZtZUNtZCAq
Y21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
KG4tPnBhcmFtcy5tYXhfaW9xcGFpcnMgLSAxKSA8PCAxNikpOw0KPiAgICAgICAgICB0cmFjZV9w
Y2lfbnZtZV9nZXRmZWF0X251bXEocmVzdWx0KTsNCj4gICAgICAgICAgYnJlYWs7DQo+ICsgICAg
Y2FzZSBOVk1FX0lOVEVSUlVQVF9WRUNUT1JfQ09ORjoNCj4gKyAgICAgICAgaXYgPSBkdzExICYg
MHhmZmZmOw0KPiArICAgICAgICBpZiAoaXYgPj0gbi0+cGFyYW1zLm1heF9pb3FwYWlycyArIDEp
IHsNCj4gKyAgICAgICAgICAgIHJldHVybiBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1FX0ROUjsN
Cj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgIHJlc3VsdCA9IGl2Ow0KPiArICAgICAgICBp
ZiAoaXYgPT0gbi0+YWRtaW5fY3EudmVjdG9yKSB7DQo+ICsgICAgICAgICAgICByZXN1bHQgfD0g
TlZNRV9JTlRWQ19OT0NPQUxFU0NJTkc7DQo+ICsgICAgICAgIH0NCj4gKw0KPiArICAgICAgICBy
ZXN1bHQgPSBjcHVfdG9fbGUzMihyZXN1bHQpOw0KPiArICAgICAgICBicmVhazsNCj4gICAgICBj
YXNlIE5WTUVfQVNZTkNIUk9OT1VTX0VWRU5UX0NPTkY6DQo+ICAgICAgICAgIHJlc3VsdCA9IGNw
dV90b19sZTMyKG4tPmZlYXR1cmVzLmFzeW5jX2NvbmZpZyk7DQo+ICAgICAgICAgIGJyZWFrOw0K
PiAgICAgIGNhc2UgTlZNRV9USU1FU1RBTVA6DQo+ICAgICAgICAgIHJldHVybiBudm1lX2dldF9m
ZWF0dXJlX3RpbWVzdGFtcChuLCBjbWQpOw0KPiAgICAgIGRlZmF1bHQ6DQo+IC0gICAgICAgIHRy
YWNlX3BjaV9udm1lX2Vycl9pbnZhbGlkX2dldGZlYXQoZHcxMCk7DQo+IC0gICAgICAgIHJldHVy
biBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1FX0ROUjsNCj4gKyAgICAgICAgcmVzdWx0ID0gY3B1
X3RvX2xlMzIobnZtZV9mZWF0dXJlX2RlZmF1bHRbZmlkXSk7DQo+ICsgICAgICAgIGJyZWFrOw0K
PiAgICAgIH0NCj4gIA0KPiAgICAgIHJlcS0+Y3FlLnJlc3VsdCA9IHJlc3VsdDsNCj4gQEAgLTEx
MjUsOCArMTE0NiwxNSBAQCBzdGF0aWMgdWludDE2X3QgbnZtZV9zZXRfZmVhdHVyZShOdm1lQ3Ry
bCAqbiwgTnZtZUNtZCAqY21kLCBOdm1lUmVxdWVzdCAqcmVxKQ0KPiAgew0KPiAgICAgIHVpbnQz
Ml90IGR3MTAgPSBsZTMyX3RvX2NwdShjbWQtPmNkdzEwKTsNCj4gICAgICB1aW50MzJfdCBkdzEx
ID0gbGUzMl90b19jcHUoY21kLT5jZHcxMSk7DQo+ICsgICAgdWludDhfdCBmaWQgPSBOVk1FX0dF
VFNFVEZFQVRfRklEKGR3MTApOw0KPiAgDQo+IC0gICAgc3dpdGNoIChkdzEwKSB7DQo+ICsgICAg
dHJhY2VfcGNpX252bWVfc2V0ZmVhdChudm1lX2NpZChyZXEpLCBmaWQsIGR3MTEpOw0KPiArDQo+
ICsgICAgaWYgKCFudm1lX2ZlYXR1cmVfc3VwcG9ydFtmaWRdKSB7DQo+ICsgICAgICAgIHJldHVy
biBOVk1FX0lOVkFMSURfRklFTEQgfCBOVk1FX0ROUjsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBz
d2l0Y2ggKGZpZCkgew0KPiAgICAgIGNhc2UgTlZNRV9URU1QRVJBVFVSRV9USFJFU0hPTEQ6DQo+
ICAgICAgICAgIGlmIChOVk1FX1RFTVBfVE1QU0VMKGR3MTEpICE9IE5WTUVfVEVNUF9UTVBTRUxf
Q09NUE9TSVRFKSB7DQo+ICAgICAgICAgICAgICBicmVhazsNCj4gQEAgLTExNzMsOCArMTIwMSw3
IEBAIHN0YXRpYyB1aW50MTZfdCBudm1lX3NldF9mZWF0dXJlKE52bWVDdHJsICpuLCBOdm1lQ21k
ICpjbWQsIE52bWVSZXF1ZXN0ICpyZXEpDQo+ICAgICAgY2FzZSBOVk1FX1RJTUVTVEFNUDoNCj4g
ICAgICAgICAgcmV0dXJuIG52bWVfc2V0X2ZlYXR1cmVfdGltZXN0YW1wKG4sIGNtZCk7DQo+ICAg
ICAgZGVmYXVsdDoNCj4gLSAgICAgICAgdHJhY2VfcGNpX252bWVfZXJyX2ludmFsaWRfc2V0ZmVh
dChkdzEwKTsNCj4gLSAgICAgICAgcmV0dXJuIE5WTUVfSU5WQUxJRF9GSUVMRCB8IE5WTUVfRE5S
Ow0KPiArICAgICAgICByZXR1cm4gTlZNRV9GRUFUX05PVF9DSEFOR0FCTEUgfCBOVk1FX0ROUjsN
Cg0KSW4gc3BlYywgaXQgaXMgIkNoYW5nZWFibGUiLCBjb3VsZCBhcyB3ZWxsIGFkZCB0aGF0ICdl
JyBoZXJlDQoNCj4gICAgICB9DQo+ICAgICAgcmV0dXJuIE5WTUVfU1VDQ0VTUzsNCj4gIH0NCj4g
ZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL252bWUuaCBiL2h3L2Jsb2NrL252bWUuaA0KPiBpbmRleCAx
NmEyNTRkMzBiNGUuLmQwNzYzZWI1OWU1ZCAxMDA2NDQNCj4gLS0tIGEvaHcvYmxvY2svbnZtZS5o
DQo+ICsrKyBiL2h3L2Jsb2NrL252bWUuaA0KPiBAQCAtOTAsNiArOTAsMjQgQEAgdHlwZWRlZiBz
dHJ1Y3QgTnZtZUZlYXR1cmVWYWwgew0KPiAgICAgIHVpbnQzMl90ICAgIGFzeW5jX2NvbmZpZzsN
Cj4gIH0gTnZtZUZlYXR1cmVWYWw7DQo+ICANCj4gK3N0YXRpYyBjb25zdCB1aW50MzJfdCBudm1l
X2ZlYXR1cmVfZGVmYXVsdFsweDEwMF0gPSB7DQo+ICsgICAgW05WTUVfQVJCSVRSQVRJT05dICAg
ICAgICAgICA9IE5WTUVfQVJCX0FCX05PTElNSVQsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29u
c3QgYm9vbCBudm1lX2ZlYXR1cmVfc3VwcG9ydFsweDEwMF0gPSB7DQo+ICsgICAgW05WTUVfQVJC
SVRSQVRJT05dICAgICAgICAgICAgICA9IHRydWUsDQo+ICsgICAgW05WTUVfUE9XRVJfTUFOQUdF
TUVOVF0gICAgICAgICA9IHRydWUsDQo+ICsgICAgW05WTUVfVEVNUEVSQVRVUkVfVEhSRVNIT0xE
XSAgICA9IHRydWUsDQo+ICsgICAgW05WTUVfRVJST1JfUkVDT1ZFUlldICAgICAgICAgICA9IHRy
dWUsDQo+ICsgICAgW05WTUVfVk9MQVRJTEVfV1JJVEVfQ0FDSEVdICAgICA9IHRydWUsDQo+ICsg
ICAgW05WTUVfTlVNQkVSX09GX1FVRVVFU10gICAgICAgICA9IHRydWUsDQo+ICsgICAgW05WTUVf
SU5URVJSVVBUX0NPQUxFU0NJTkddICAgICA9IHRydWUsDQo+ICsgICAgW05WTUVfSU5URVJSVVBU
X1ZFQ1RPUl9DT05GXSAgICA9IHRydWUsDQo+ICsgICAgW05WTUVfV1JJVEVfQVRPTUlDSVRZXSAg
ICAgICAgICA9IHRydWUsDQo+ICsgICAgW05WTUVfQVNZTkNIUk9OT1VTX0VWRU5UX0NPTkZdICA9
IHRydWUsDQo+ICsgICAgW05WTUVfVElNRVNUQU1QXSAgICAgICAgICAgICAgICA9IHRydWUsDQo+
ICt9Ow0KPiArDQo+ICB0eXBlZGVmIHN0cnVjdCBOdm1lQ3RybCB7DQo+ICAgICAgUENJRGV2aWNl
ICAgIHBhcmVudF9vYmo7DQo+ICAgICAgTWVtb3J5UmVnaW9uIGlvbWVtOw0KPiBkaWZmIC0tZ2l0
IGEvaHcvYmxvY2svdHJhY2UtZXZlbnRzIGIvaHcvYmxvY2svdHJhY2UtZXZlbnRzDQo+IGluZGV4
IDA5MWFmMTZjYTdkNy4uNDJlNjJmNDY0OWY4IDEwMDY0NA0KPiAtLS0gYS9ody9ibG9jay90cmFj
ZS1ldmVudHMNCj4gKysrIGIvaHcvYmxvY2svdHJhY2UtZXZlbnRzDQo+IEBAIC00Niw2ICs0Niw4
IEBAIHBjaV9udm1lX2lkZW50aWZ5X2N0cmwodm9pZCkgImlkZW50aWZ5IGNvbnRyb2xsZXIiDQo+
ICBwY2lfbnZtZV9pZGVudGlmeV9ucyh1aW50MzJfdCBucykgIm5zaWQgJSJQUkl1MzIiIg0KPiAg
cGNpX252bWVfaWRlbnRpZnlfbnNsaXN0KHVpbnQzMl90IG5zKSAibnNpZCAlIlBSSXUzMiIiDQo+
ICBwY2lfbnZtZV9nZXRfbG9nKHVpbnQxNl90IGNpZCwgdWludDhfdCBsaWQsIHVpbnQ4X3QgbHNw
LCB1aW50OF90IHJhZSwgdWludDMyX3QgbGVuLCB1aW50NjRfdCBvZmYpICJjaWQgJSJQUkl1MTYi
IGxpZCAweCUiUFJJeDgiIGxzcCAweCUiUFJJeDgiIHJhZSAweCUiUFJJeDgiIGxlbiAlIlBSSXUz
MiIgb2ZmICUiUFJJdTY0IiINCj4gK3BjaV9udm1lX2dldGZlYXQodWludDE2X3QgY2lkLCB1aW50
OF90IGZpZCwgdWludDMyX3QgY2R3MTEpICJjaWQgJSJQUkl1MTYiIGZpZCAweCUiUFJJeDgiIGNk
dzExIDB4JSJQUkl4MzIiIg0KPiArcGNpX252bWVfc2V0ZmVhdCh1aW50MTZfdCBjaWQsIHVpbnQ4
X3QgZmlkLCB1aW50MzJfdCBjZHcxMSkgImNpZCAlIlBSSXUxNiIgZmlkIDB4JSJQUkl4OCIgY2R3
MTEgMHglIlBSSXgzMiIiDQo+ICBwY2lfbnZtZV9nZXRmZWF0X3Z3Y2FjaGUoY29uc3QgY2hhciog
cmVzdWx0KSAiZ2V0IGZlYXR1cmUgdm9sYXRpbGUgd3JpdGUgY2FjaGUsIHJlc3VsdD0lcyINCj4g
IHBjaV9udm1lX2dldGZlYXRfbnVtcShpbnQgcmVzdWx0KSAiZ2V0IGZlYXR1cmUgbnVtYmVyIG9m
IHF1ZXVlcywgcmVzdWx0PSVkIg0KPiAgcGNpX252bWVfc2V0ZmVhdF9udW1xKGludCByZXFjcSwg
aW50IHJlcXNxLCBpbnQgZ290Y3EsIGludCBnb3RzcSkgInJlcXVlc3RlZCBjcV9jb3VudD0lZCBz
cV9jb3VudD0lZCwgcmVzcG9uZGluZyB3aXRoIGNxX2NvdW50PSVkIHNxX2NvdW50PSVkIg0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ibG9jay9udm1lLmggYi9pbmNsdWRlL2Jsb2NrL252bWUuaA0K
PiBpbmRleCBjOWYyMzJhNzBlOTguLjY2MmU1MjFjOWU5YiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ibG9jay9udm1lLmgNCj4gKysrIGIvaW5jbHVkZS9ibG9jay9udm1lLmgNCj4gQEAgLTY2Miw2
ICs2NjIsNyBAQCBlbnVtIE52bWVTdGF0dXNDb2RlcyB7DQo+ICAgICAgTlZNRV9GV19SRVFfUkVT
RVQgICAgICAgICAgID0gMHgwMTBiLA0KPiAgICAgIE5WTUVfSU5WQUxJRF9RVUVVRV9ERUwgICAg
ICA9IDB4MDEwYywNCj4gICAgICBOVk1FX0ZJRF9OT1RfU0FWRUFCTEUgICAgICAgPSAweDAxMGQs
DQo+ICsgICAgTlZNRV9GRUFUX05PVF9DSEFOR0FCTEUgICAgID0gMHgwMTBlLA0KPiAgICAgIE5W
TUVfRklEX05PVF9OU0lEX1NQRUMgICAgICA9IDB4MDEwZiwNCj4gICAgICBOVk1FX0ZXX1JFUV9T
VVNZU1RFTV9SRVNFVCAgPSAweDAxMTAsDQo+ICAgICAgTlZNRV9DT05GTElDVElOR19BVFRSUyAg
ICAgID0gMHgwMTgwLA0KPiBAQCAtODY2LDYgKzg2Nyw3IEBAIGVudW0gTnZtZUlkQ3RybExwYSB7
DQo+ICAjZGVmaW5lIE5WTUVfQ1RSTF9TR0xTX0FERFJfT0ZGU0VUICAgICAgICAgICAgICAgKDB4
MSA8PCAyMCkNCj4gIA0KPiAgI2RlZmluZSBOVk1FX0FSQl9BQihhcmIpICAgIChhcmIgJiAweDcp
DQo+ICsjZGVmaW5lIE5WTUVfQVJCX0FCX05PTElNSVQgMHg3DQo+ICAjZGVmaW5lIE5WTUVfQVJC
X0xQVyhhcmIpICAgKChhcmIgPj4gOCkgJiAweGZmKQ0KPiAgI2RlZmluZSBOVk1FX0FSQl9NUFco
YXJiKSAgICgoYXJiID4+IDE2KSAmIDB4ZmYpDQo+ICAjZGVmaW5lIE5WTUVfQVJCX0hQVyhhcmIp
ICAgKChhcmIgPj4gMjQpICYgMHhmZikNCj4gQEAgLTg3Myw2ICs4NzUsOCBAQCBlbnVtIE52bWVJ
ZEN0cmxMcGEgew0KPiAgI2RlZmluZSBOVk1FX0lOVENfVEhSKGludGMpICAgICAoaW50YyAmIDB4
ZmYpDQo+ICAjZGVmaW5lIE5WTUVfSU5UQ19USU1FKGludGMpICAgICgoaW50YyA+PiA4KSAmIDB4
ZmYpDQo+ICANCj4gKyNkZWZpbmUgTlZNRV9JTlRWQ19OT0NPQUxFU0NJTkcgKDB4MSA8PCAxNikN
Cj4gKw0KPiAgI2RlZmluZSBOVk1FX1RFTVBfVEhTRUwodGVtcCkgICgodGVtcCA+PiAyMCkgJiAw
eDMpDQo+ICAjZGVmaW5lIE5WTUVfVEVNUF9USFNFTF9PVkVSICAgMHgwDQo+ICAjZGVmaW5lIE5W
TUVfVEVNUF9USFNFTF9VTkRFUiAgMHgxDQo+IEBAIC05MDIsNiArOTA2LDkgQEAgZW51bSBOdm1l
RmVhdHVyZUlkcyB7DQo+ICAgICAgTlZNRV9TT0ZUV0FSRV9QUk9HUkVTU19NQVJLRVIgICA9IDB4
ODANCj4gIH07DQo+ICANCj4gKyNkZWZpbmUgTlZNRV9HRVRTRVRGRUFUX0ZJRF9NQVNLIDB4ZmYN
Cj4gKyNkZWZpbmUgTlZNRV9HRVRTRVRGRUFUX0ZJRChkdzEwKSAoZHcxMCAmIE5WTUVfR0VUU0VU
RkVBVF9GSURfTUFTSykNCj4gKw0KPiAgdHlwZWRlZiBzdHJ1Y3QgTnZtZVJhbmdlVHlwZSB7DQo+
ICAgICAgdWludDhfdCAgICAgdHlwZTsNCj4gICAgICB1aW50OF90ICAgICBhdHRyaWJ1dGVzOw0K


Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B389C17461
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D9D206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=here.com header.i=@here.com header.b="LIpdWSzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D9D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=here.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyU8-0000NB-DT
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.bonnans@here.com>) id 1iRyT2-0007sO-Al
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.bonnans@here.com>) id 1iRySy-0000T0-Ho
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:01:49 -0500
Received: from mail-eopbgr80132.outbound.protection.outlook.com
 ([40.107.8.132]:35399 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent.bonnans@here.com>)
 id 1iRySy-0000QD-0n; Tue, 05 Nov 2019 08:01:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljCEE+buCc4Oup2PomaVq+BGQ/ArER7d0IUegoShMBUanhcSnnyAxlWbLWH1IFM4ESqHx5XpCB7I02OQhQ6wRgYtcl3+1S9MCSrBPrYxhS6NOb/cVL3ePuolPIQD0c3Ml3vaTBG+x5B5FXvXAt2cVc2v2CpAbc8p/5QBhj+Tu1zZWzs+1W8zQ9LqpjbHhrf0/+jkXSXTmESuiSbUFrRpDVUUFt2oVt18u4+T79A96H5eA1uMcekFGj9Fw+wAVPP7tvJeeomEJd9Ud0sWIQ9Nym2L+VpvQxxaB48vtLjBIASDD/FzUU0v0CuVLabGuQM6jJAmkoPxKPG44MpJDiYm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOOmbuGsaxsoxhOUlBwyBef7yWKEzLJnfHGxf62F6iY=;
 b=lzRdUYVwU3MRRkQ1Xxt03Ao2TYufF1cPZKJiECpCsn9IbpfEYEEnWUNDmk40+8mGFIpqZ4h0GHMhb5/4PRdEqXtjXudTUm4ccWJZ0KVLF0oE/TL3ajzhNw+2QIUAEftRAuT/7Kn4QdtGuaEZ+uIE42qj8SZxul8TA57ILQ4wW3j01TIvKohwU+puMqwibe4qhuTJytd1NgrC+jjDFXKNd59Vh7GLxSSB61q61pm7z6ozFT9xmLG4+fvyzDR6+DWXQcAUXRwvloC/UrBoYwX5/xi5q1DvIf47hHQiaZOwF8oaTCOmJNBoLMiTP/yQlOFpb7W06XYcpeStZ/G/gIyyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=here.com; dmarc=pass action=none header.from=here.com;
 dkim=pass header.d=here.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=here.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOOmbuGsaxsoxhOUlBwyBef7yWKEzLJnfHGxf62F6iY=;
 b=LIpdWSzYQNPqG81igoYcIrQw7fTGpwVE6O65LS7rVHhzm6vfXxGLaU04cQP7p16s8t4LH0s8TzkXUPPG1JT51+Lc2CdB8E4O4wylBAajynyMIchKKv9WpbFwFnjvROYKba8W1YAKSXG8TSn8Bnp96WwfkXk4RwXcmPjCJ59ryGM=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3043.eurprd04.prod.outlook.com (10.173.254.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 13:01:42 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::8ce8:9eaf:3916:4bc9]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::8ce8:9eaf:3916:4bc9%6]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 13:01:42 +0000
From: "Bonnans, Laurent" <laurent.bonnans@here.com>
To: Clement Deschamps <clement.deschamps@greensocs.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup
 routine
Thread-Topic: [PATCH] hw/arm/boot: Set NSACR.{CP11, CP10} in dummy SMC setup
 routine
Thread-Index: AQHVkyLpdZ9C4+vVyUaj7PS7hruIkqd8jA+A
Date: Tue, 5 Nov 2019 13:01:42 +0000
Message-ID: <e04fb8db-6711-df97-50b6-c91bdbdb1219@here.com>
References: <20191104151137.81931-1-clement.deschamps@greensocs.com>
In-Reply-To: <20191104151137.81931-1-clement.deschamps@greensocs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurent.bonnans@here.com; 
x-originating-ip: [131.228.216.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff3cef91-4653-42b4-4188-08d761f04ddd
x-ms-traffictypediagnostic: AM5PR04MB3043:
x-microsoft-antispam-prvs: <AM5PR04MB304346813F8E3BC3E6200A58857E0@AM5PR04MB3043.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(199004)(189003)(54906003)(186003)(31686004)(486006)(86362001)(66066001)(6116002)(11346002)(91956017)(71200400001)(14454004)(66556008)(66946007)(6486002)(14444005)(8676002)(256004)(7736002)(31696002)(66476007)(3846002)(476003)(305945005)(2906002)(6246003)(76176011)(2616005)(71190400001)(229853002)(25786009)(76116006)(81166006)(81156014)(66446008)(4001150100001)(8936002)(99286004)(110136005)(26005)(478600001)(316002)(5660300002)(102836004)(2501003)(36756003)(64756008)(4326008)(6506007)(6512007)(6436002)(446003)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM5PR04MB3043;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: here.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cT7DHPcqgwTLlyaC9Hc+H5gAOvyqL25ls1X5Y2UmIPv1Zw/LGfNWLCGUeToP59cLtQPZrNomQ/5U27QVaTLG142hmREojTWl0+roaXxtDyMvFqRcDMXlqp9TCSniyZBeXXLaOX28l0zchEJL6z//kZCgvHkmHreTyZsCb0qQ0Kx7cAaQhgwS1Y+eH66VAazKgVga0PygRrig5hXPzy7aTY4PKr6R8TC35l+HSztRSv50DUAMsVp4eLxYDCgByz96TCO4yhFDKAMVM+WK3YhCNou4NSPSCmDlL6M+PNbyWKTsGV1URW51U0Fb6zNzp2+TvlthhL/MqC0lR7ZK7UTgM2iHk9TyfoiNtebyHQd5XkgVPYaXtFv14yw4Y2nww9QLTeMJ1/rk9GzOLqJXImuWu1OP5gJMXn8QqEd/VYzFWSyC8y0cfCAcugCKr1R7np1h
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <666D6D0B453F0544893AED044BC8BEEE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3cef91-4653-42b4-4188-08d761f04ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 13:01:42.1106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSRWo25711VWrVURZnVrE9GL0xZ1zwNhi2TZuPFIbcY5mv2iMNhJXP8q8ajJVpOXPI6HnUf4kdgOTQ0AWtaCp1mqNy5WGBFr6tKBNWHu1kE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3043
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.132
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
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTEvNC8xOSA0OjExIFBNLCBDbGVtZW50IERlc2NoYW1wcyB3cm90ZToNCg0KPiBTZXQgdGhl
IE5TQUNSIENQMTEgYW5kIENQMTAgYml0cywgdG8gYWxsb3cgRlBVIGFjY2VzcyBpbiBOb24tU2Vj
dXJlIHN0YXRlDQo+IHdoZW4gdXNpbmcgZHVtbXkgU01DIHNldHVwIHJvdXRpbmUuIE90aGVyd2lz
ZSBhbiBBQXJjaDMyIGtlcm5lbCB3aWxsIFVOREVGIGFzDQo+IHNvb24gYXMgaXQgdHJpZXMgdG8g
dXNlIHRoZSBGUFUuDQo+DQo+IFRoaXMgZml4ZXMga2VybmVsIHBhbmljIHdoZW4gYm9vdGluZyBy
YXNwYmlhbiBvbiByYXNwaTIuDQpJIGNhbiBjb25maXJtIHRoYXQgaXQgc29sdmVzIHRoZSBrZXJu
ZWwgcGFuaWNzIHdlJ3ZlIGhhZCBpbiBvdXIgdGVzdHMgDQp3aGVuIHJ1bm5pbmcgb3VyIHlvY3Rv
LWJ1aWx0IGltYWdlcy4NCg0KVGVzdGVkLWJ5OiBMYXVyZW50IEJvbm5hbnMgPGxhdXJlbnQuYm9u
bmFuc0BoZXJlLmNvbT4NCg0KTGF1cmVudA0KPg0KPiBTdWNjZXNzZnVsbHkgdGVzdGVkIHdpdGg6
DQo+ICAgIDIwMTctMDEtMTEtcmFzcGJpYW4tamVzc2llLWxpdGUuaW1nDQo+ICAgIDIwMTgtMTEt
MTMtcmFzcGJpYW4tc3RyZXRjaC1saXRlLmltZw0KPiAgICAyMDE5LTA3LTEwLXJhc3BiaWFuLWJ1
c3Rlci1saXRlLmltZw0KPg0KPiBTZWUgYWxzbyBjb21taXQgZWNlNjI4ZmNmNiB0aGF0IGZpeGVz
IHRoZSBpc3N1ZSB3aGVuICpub3QqIHVzaW5nIHRoZQ0KPiBkdW1teSBTTUMgc2V0dXAgcm91dGlu
ZS4NCj4NCj4gRml4ZXM6IGZjMTEyMGE3ZjUNCj4gU2lnbmVkLW9mZi1ieTogQ2xlbWVudCBEZXNj
aGFtcHMgPGNsZW1lbnQuZGVzY2hhbXBzQGdyZWVuc29jcy5jb20+DQo+IC0tLQ0KPiAgIGh3L2Fy
bS9ib290LmMgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2h3L2FybS9ib290LmMgYi9ody9hcm0vYm9vdC5jDQo+IGluZGV4IGVm
NjcyNDk2MGMuLjhmYjRhNjM2MDYgMTAwNjQ0DQo+IC0tLSBhL2h3L2FybS9ib290LmMNCj4gKysr
IGIvaHcvYXJtL2Jvb3QuYw0KPiBAQCAtMjQwLDYgKzI0MCw5IEBAIHZvaWQgYXJtX3dyaXRlX3Nl
Y3VyZV9ib2FyZF9zZXR1cF9kdW1teV9zbWMoQVJNQ1BVICpjcHUsDQo+ICAgICAgIH07DQo+ICAg
ICAgIHVpbnQzMl90IGJvYXJkX3NldHVwX2Jsb2JbXSA9IHsNCj4gICAgICAgICAgIC8qIGJvYXJk
IHNldHVwIGFkZHIgKi8NCj4gKyAgICAgICAgMHhlZTExMGY1MSwgLyogbXJjICAgICBwMTUsIDAs
IHIwLCBjMSwgYzEsIDIgIDtyZWFkIE5TQUNSICovDQo+ICsgICAgICAgIDB4ZTM4MDBiMDMsIC8q
IG9yciAgICAgcjAsICMweGMwMCAgICAgICAgICAgICA7c2V0IENQMTEsIENQMTAgKi8NCj4gKyAg
ICAgICAgMHhlZTAxMGY1MSwgLyogbWNyICAgICBwMTUsIDAsIHIwLCBjMSwgYzEsIDIgIDt3cml0
ZSBOU0FDUiAqLw0KPiAgICAgICAgICAgMHhlM2EwMGUwMCArIChtdmJhcl9hZGRyID4+IDQpLCAv
KiBtb3YgcjAsICNtdmJhcl9hZGRyICovDQo+ICAgICAgICAgICAweGVlMGMwZjMwLCAvKiBtY3Ig
ICAgIHAxNSwgMCwgcjAsIGMxMiwgYzAsIDEgO3NldCBNVkJBUiAqLw0KPiAgICAgICAgICAgMHhl
ZTExMGYxMSwgLyogbXJjICAgICBwMTUsIDAsIHIwLCBjMSAsIGMxLCAwIDtyZWFkIFNDUiAqLw==


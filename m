Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE2AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9C12075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k/5AaCNx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pCd2P8CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtju-0001M5-Fy
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdtj3-0000tD-RG; Wed, 27 May 2020 06:55:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdtj1-0000tL-8h; Wed, 27 May 2020 06:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590576968; x=1622112968;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IAYIBoRc7DI8UVxVZ8nElvMEVFV8pUmeQxfxMKKBkiU=;
 b=k/5AaCNx3ZZvgK5ytCPlRASkazo+U2GNaxYx6Id5EQC4FvG/rJh8bPCC
 jRy2pjgNNKKf9NGlokDu0bnbRq2wAWfolG3JXy1vSsMMA3vPPxZX0DyL5
 6i6ERLC4RrohwfcVBRiK4QRcYJgqcjl1eZBDTQkZcJj2B/Wp8KA0/JPhz
 HDe2sYD1ihmwb6TC0yzfNXeWXk2RHgYH5/dSx2neeQTHP8TTHzvh5PLC/
 sDxfLjLv+MttMSJKMZ0Ljxz10Qt1VP8RnM9ebxRvT+LjoxE5RXfY6f2ab
 C990QOaXCg6FwS69fKR8PkLW81vSIGflM9jQtFe+oxQI141lyfRft4l4t Q==;
IronPort-SDR: moBxst1gh0jHHugCCGbDKG2HuGJ1IINBpy/8k+AnpcMAxte6mxGD1c7SzVBDwPpvaYlUM/e00J
 LUy0YSrohO0ywlJ+/3Awx3witQo0/K4qNcOg9magtrIWHfk9EqjixJ28NTKN+1ZU8SasoEcJIR
 0+Uitwd2hckKT+8m/VY7RSzl+KRumfTyEypljdQs4QugDHXzU7OahXa45jntFgIZQlM4SUmOnN
 kuEQKJ5t+IYAF4Q/A2BSwjfF2jxBexVgpr47V6W/kyq2KQf70JeAaTncQdZvtxT8YM9L9n+pW2
 YzA=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; d="scan'208";a="241419062"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 18:56:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WL+4L0htbe2IScOZ9B/MfKA+xq640fSRkBVAX4xvZnTUzVTWLDEEuCDQnI9hAVbiQd5HzgwReQ70K1bIioRU39eph/ME0RtY6h3rt5kfvvBJqr88QzVE5klBI9oI3/ey4NB0sItmZiKwKzon4fzmyYBJNyBgM/NsTUlab5fsR5S6j/WI1l7T5Dhu5LNzen736s33oWRsZdQbZdLeQjg29D/hwtwDMZ2GhFmI9abgMgftxvD+fouXLMuxBUSuug/35HhuBJ2fQEx8aACvmR4kojRLwZbT4E01N0r+o+2fVlj3RKnEhXo+gdj6VKxv741OL/u0a6+86EPSaKnZdYaDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAYIBoRc7DI8UVxVZ8nElvMEVFV8pUmeQxfxMKKBkiU=;
 b=fzPhChp7uo3ODkv1CeODR2JsQr/AjAuhZ4HnuNXpT+kN8fpLaXwaBBLpk9wphGDMdPjqIBoaoKqagJtenkocVTRIbK8YWGlHsdZOaNBFesJDXarziD6kC1udskv1TI/zOGeEap+ieF2z5oLX+yVW8a4I3U+AeDWUfx82iXH/YVCHweip5+dPDCBHsjwR8OE1U7l2CGTRs1kICT1L9FbaCGNleQeleFoHngKTZC8JZ7USrvW3ph5AiNosIP0ru26sITEEJeLFnuP9Qe4SHqrIvKt4L/gp/1Ny5I7WXVWw+ApPXqM17G6MGjJtufbNokTrZ0W1nEKhqmTirsX8dbqtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAYIBoRc7DI8UVxVZ8nElvMEVFV8pUmeQxfxMKKBkiU=;
 b=pCd2P8CKECHrfcg8w25btUC/dQf6avvdBZmoDHbv9lNYMmiz5RFhcLg6OIHhjLBgksTE7eTjRXa+3Q5s3w8JmNog5xgshc2/BOQUK3A8PuXueBrUBJAaW1CW5d0meOm61DAFh4uQnoly+Ckzhua5n4uVj/KJnVfKPZ4Yj1WbVUw=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4026.namprd04.prod.outlook.com (2603:10b6:5:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 10:55:48 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 10:55:48 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Thread-Topic: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Thread-Index: AQHWM+mvNrZ2AnW2EUiBBv/RtOst3ai7nqMAgAAQ0PCAAAF8gIAAAgyAgAAMI4CAAAOZAA==
Date: Wed, 27 May 2020 10:55:48 +0000
Message-ID: <DM6PR04MB6201D327CCDF161798B4F3638DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
 <20200527054226.232103-2-anup.patel@wdc.com>
 <20200527084554.GC2665520@redhat.com>
 <DM6PR04MB6201A8060078D3539BFDE3688DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
 <20200527095123.GH2665520@redhat.com>
 <DM6PR04MB62018CFC12FAAFA39AA667368DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
 <20200527104209.GJ2665520@redhat.com>
In-Reply-To: <20200527104209.GJ2665520@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.30.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00ff88e5-55f8-4d36-8b01-08d8022c83b3
x-ms-traffictypediagnostic: DM6PR04MB4026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB40262B97A67BDE0168DA88CB8DB10@DM6PR04MB4026.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wt84s9rAxThbquVdAnqf1MDpL7N/Ws+2zWEloIVLXReBUIeLrrbKir3Enk1x3GgKbExiPqfgGlKnphpf4UEX8CU/K26keVgl31JL/FA87Fldjb2RvE+Dx2m5Eu8FkKRt9K7NitZ4/06vjmDY1ZaUTyx7vh6vsdqSZDsxlVy6UWpKXfOFOMM9K1hLO4d4slIa3AwPLSmXR4pf1/3A5CQ464XIXDGCftsc9W8xtbRYtMFu/fmuCFRwJoZ7VWvfmkSY4n/JeC0vBe4KATSvuBkuutHpzX2UQ6OeCi5bfoiFxFIzAGsnVtSK0LxuSuqOiphvo+3BKsCdm4zpgq8YvPmzew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(86362001)(52536014)(71200400001)(8936002)(5660300002)(478600001)(316002)(54906003)(26005)(6916009)(83380400001)(66946007)(76116006)(66446008)(186003)(66556008)(64756008)(55236004)(66476007)(7696005)(6506007)(53546011)(33656002)(8676002)(4326008)(55016002)(9686003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cpBW8gAIuHoVO4j9Q8luKCbQhFEwBJBWfDGP+Nt4gd6+WtJ5LQnwRw077TfkZxfF77q+5t1MMcPQUzmXELhqYt13ZIbupM2MPl4/6AmWcLFunjSN6++gq+XepwSFaH+zIchdVHSFiq75titYhxohZC3bFWca5J/X2IZ7Q0JWsHHcby7lUW1HJ22ZLh/eiarditCDAj3Tqu3JBKhZq17w4SOgsa/3CAXnCX0pIvKQmkIulKGN9awAvlf4peuIdJPLXNW9nvTsZWaiYPXEOAV7B3q4Oq6TxJAHcq2ECYbzX2+0Ng+tvyM4jaKYJccTg7PUlKd9aYC3zhkYXWUN9+2E6Kxi5NZK1Ae/X/0+dHLxQTu6vQBnFXqvetaRAqwDfOxpRl0TeRFXDJ1FeT9SWE1uIyeFgMWes1iSj21t2zOdOQdhIOzbxvLjIxqz5zoV9RjeLhUMh2fYzFGfK+piIcm43Ddi6I6ut5ZNxA0ywDsnOC8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ff88e5-55f8-4d36-8b01-08d8022c83b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 10:55:48.0615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckfvOgBmZIfbpUXVFVnfQirvS+NB5B9+94j0T4nal9+SNMwXB7nc/FXcQmDrCXZOgW7JE4nbQYqG4KK4FQfPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4026
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 06:55:51
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogMjcgTWF5IDIwMjAgMTY6MTINCj4g
VG86IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4NCj4gQ2M6IFBldGVyIE1heWRlbGwg
PHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IHFlbXUtcmlzY3ZAbm9uZ251Lm9yZzsNCj4gRWR1
YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPjsgU2FnYXIgS2FyYW5kaWthcg0KPiA8
c2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1PjsgQW51cCBQYXRlbCA8YW51cEBicmFpbmZhdWx0Lm9y
Zz47IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IEF0aXNoIFBhdHJhIDxBdGlzaC5QYXRyYUB3
ZGMuY29tPjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsg
UGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxLzVdIGh3OiBBZGQgc29ja2V0c19zcGVjaWZpZWQgZmllbGQgaW4gQ3B1VG9wb2xvZ3kN
Cj4gDQo+IE9uIFdlZCwgTWF5IDI3LCAyMDIwIGF0IDEwOjAxOjIxQU0gKzAwMDAsIEFudXAgUGF0
ZWwgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+IEZyb206IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+ID4g
PiBTZW50OiAyNyBNYXkgMjAyMCAxNToyMQ0KPiA+ID4gVG86IEFudXAgUGF0ZWwgPEFudXAuUGF0
ZWxAd2RjLmNvbT4NCj4gPiA+IENjOiBFZHVhcmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5j
b20+OyBNYXJjZWwgQXBmZWxiYXVtDQo+ID4gPiA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+
OyBQZXRlciBNYXlkZWxsDQo+ID4gPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgUGFsbWVy
IERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+ID4gPiBBbGlzdGFpciBGcmFuY2lzIDxB
bGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyBTYWdhciBLYXJhbmRpa2FyDQo+ID4gPiA8c2FnYXJr
QGVlY3MuYmVya2VsZXkuZWR1PjsgQXRpc2ggUGF0cmEgPEF0aXNoLlBhdHJhQHdkYy5jb20+Ow0K
PiA+ID4gcWVtdS1yaXNjdkBub25nbnUub3JnOyBxZW11LSBkZXZlbEBub25nbnUub3JnOyBBbnVw
IFBhdGVsDQo+ID4gPiA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS81XSBodzogQWRkIHNvY2tldHNfc3BlY2lmaWVkIGZpZWxkIGluDQo+ID4gPiBD
cHVUb3BvbG9neQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgTWF5IDI3LCAyMDIwIGF0IDA5OjQ4OjM5
QU0gKzAwMDAsIEFudXAgUGF0ZWwgd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBEYW5pZWwgUC4gQmVy
cmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiA+ID4gPiA+IFNlbnQ6IDI3IE1heSAyMDIw
IDE0OjE2DQo+ID4gPiA+ID4gVG86IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4NCj4g
PiA+ID4gPiBDYzogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPjsgTWFyY2Vs
IEFwZmVsYmF1bQ0KPiA+ID4gPiA+IDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47IFBldGVy
IE1heWRlbGwNCj4gPiA+ID4gPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgUGFsbWVyIERh
YmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+ID4gPiA+ID4gQWxpc3RhaXIgRnJhbmNpcyA8
QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgU2FnYXIgS2FyYW5kaWthcg0KPiA+ID4gPiA+IDxz
YWdhcmtAZWVjcy5iZXJrZWxleS5lZHU+OyBBdGlzaCBQYXRyYSA8QXRpc2guUGF0cmFAd2RjLmNv
bT47DQo+ID4gPiA+ID4gcWVtdS1yaXNjdkBub25nbnUub3JnOyBxZW11LSBkZXZlbEBub25nbnUu
b3JnOyBBbnVwIFBhdGVsDQo+ID4gPiA+ID4gPGFudXBAYnJhaW5mYXVsdC5vcmc+DQo+ID4gPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzVdIGh3OiBBZGQgc29ja2V0c19zcGVjaWZpZWQg
ZmllbGQgaW4NCj4gPiA+ID4gPiBDcHVUb3BvbG9neQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24g
V2VkLCBNYXkgMjcsIDIwMjAgYXQgMTE6MTI6MjJBTSArMDUzMCwgQW51cCBQYXRlbCB3cm90ZToN
Cj4gPiA+ID4gPiA+IFdoZW4gInNvY2tldHMiIHN1Yi1vcHRpb24gb2YgIi1zbXAiIG9wdGlvbiBp
cyBub3Qgc3BlY2lmaWVkLA0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBzbXBfcGFyc2Uo
KSBmdW5jdGlvbiB3aWxsIGFzc3VtZSBvbmUgQ1BVIHBlci1zb2NrZXQgYW5kIHNldA0KPiA+ID4g
PiA+ID4gdGhlIG51bWJlciBvZiBzb2NrZXRzIGVxdWFsIHRvIG51bWJlciBvZiBDUFVzLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRoaXMgaXMgY291bnRlci1pbnR1aXRpdmUgYW5kIHdlIHNo
b3VsZCBhbGxvdyBtYWNoaW5lDQo+ID4gPiA+ID4gPiBlbXVsYXRpb24gdG8gZGVjaWRlIGRlZmF1
bHQgbnVtYmVyIG9mIHNvY2tldHMgd2hlbiAic29ja2V0cyINCj4gPiA+ID4gPiA+IHN1Yi1vcHRp
b24gaXMgbm90IHNwZWNpZmllZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgZG9uJ3QgYWdyZWUg
d2l0aCB0aGlzLiAgSGF2aW5nIHRoZSBzZW1hbnRpY3Mgb2YgdGhlIC1zbXANCj4gPiA+ID4gPiBv
cHRpb24gYmUgdGhlIHNhbWUgYWNyb3NzIGFsbCB0YXJnZXRzL21hY2hpbmVzICppcyogaW50dWl0
aXZlLg0KPiA+ID4gPiA+IENoYW5naW5nIHNlbWFudGljcyBvZiAtc21wIHBlci0gbWFjaGluZSB3
aWxsIGNyZWF0ZSBhIHdvcnNlDQo+ID4gPiA+ID4gZXhwZXJpYW5jZSBmb3IgcGVvcGxlIGNvbmZp
Z3VyaW5nIFFFTVUgYXMgdGhlIGNvbmZpZ3VyYXRpb24gd2lsbA0KPiA+ID4gPiA+IG1lYW4gZGlm
ZmVyZW50IHRoaW5ncw0KPiA+ID4gZGVwZW5kaW5nIG9uIHRoZSBtYWNoaW5lIGNob2NlLg0KPiA+
ID4gPg0KPiA+ID4gPiBPa2F5IHRoZW4gd2h5IGRvbid0IHdlIGRlZmF1bHQgdG8gc29ja2V0cz0x
IGluIHNtcF9wYXJzZSgpIHdoZW4NCj4gInNvY2tldHMiDQo+ID4gPiA+IHN1Yi1vcHRpb25zIGlz
IG5vdCBzcGVjaWZpZWQgPz8gVGhpcyB3aWxsIG1ha2UgaXQgdW5pZm9ybSBhY3Jvc3MgbWFjaGlu
ZXMuDQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoZXJlIGEgcmVhc29uIHRvIGJ5IGRlZmF1bHQgaGF2
ZSBzb2NrZXRzPW1heF9jcHVzID8/DQo+ID4gPg0KPiA+ID4gSUlVQyBib3RoIG9mIHRoZXNlIHF1
ZXN0aW9ucyBhcmUgZHVlIHRvIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdpdGgNCj4gPiA+IHBy
ZS0gZXhpc3RpbmcgUUVNVSB2ZXJzaW9ucy4NCj4gPg0KPiA+IEkgc2VlIHRoYXQgaHcveDg2L3Bj
LmMgaW1wbGVtZW50cyBpdCdzIG93biBzbXBfcGFyc2UoKSBjYWxsYmFjay4NCj4gPiBDYW4gd2Ug
dGFrZSB0aGF0IHJvdXRlID8/DQo+ID4NCj4gPiBXZSBuZWVkIHRvIGhhdmUgc29ja2V0cz0xIGJ5
IGRlZmF1bHQgZm9yIFJJU0MtViBtYWNoaW5lcyBiZWNhdXNlIGVhY2gNCj4gPiBzb2NrZXQgaGFz
IGl0J3Mgb3duIGludGVycnVwdCBjb250cm9sbGVyIGFuZCBvdGhlciBwZXJpcGhlcmFscy4NCj4g
DQo+IEkgZ3Vlc3MgdGhlIGZhY3QgdGhhdCBzbXBfcGFyc2UoKSBleGlzdHMgYXMgYSBjYWxsYmFj
ayBwcmV0dHkgbXVjaCBzYXlzIHRoYXQNCj4gYWxsb3dpbmcgbWFjaGluZSB0eXBlIG92ZXJyaWRl
cyBvZiBkZWZhdWx0IHNlbWFudGljcyBpcyBwZXJtaXR0ZWQuIFNvIHllYWgsDQo+IHVzaW5nIGEg
c21wX3BhcnNlIGNhbGxiYWNrIHNlZW1zIHJlYXNvbmFibGUuDQoNClRoYW5rcyBEYW5pZSwgSSB3
aWxsIGRyb3AgdGhpcyBwYXRjaCBhbmQgc2VuZCB2MyB3aXRoIGRpZmZlcmVudCBhcHByb2FjaC4N
Cg0KUmVnYXJkcywNCkFudXANCg==


Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D991DC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 04:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2252064A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 04:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W6m5PP22";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G4panujV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2252064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCyYm-0002aj-L6
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 00:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1646f416f=Anup.Patel@wdc.com>)
 id 1iCyXq-0001zc-1P
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1646f416f=Anup.Patel@wdc.com>)
 id 1iCyXo-0004k8-Ps
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 00:04:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1646f416f=Anup.Patel@wdc.com>)
 id 1iCyXj-0004gE-P6; Wed, 25 Sep 2019 00:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569384284; x=1600920284;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qz9t+6siI3hv7CGhUTqtMcK0OcnVLU6ftOUWShi7hg4=;
 b=W6m5PP22/5Ahqc8EPHHnp5S4d6Zxsh5f61aMxMtsGjmOKcMUhQ7/eKcW
 CueHP4votFFKxtCoCmfJTfqSu+svaerU+Oj3Hm6f95T03WEquXDg0ATOW
 nuRJ71ctudJ8KZwiy6M9WVEGC7XTc8ZBp77tVW3f5LmQWL0ihciwmK/Uv
 EBDwp9yNVwtFBI3hr4h1hS9tvWldfqiUe1MGW1iFqILK0FQODeqVnkirB
 ZyglAfH7sa8kmHA5qK6wzDoYtL/VywbD6vXTk2Hg8reZJa4TD525u35yZ
 xA5BV5qiKoVsO6iziqsSoV0Ipc7IsvGyE+kKzb3nOW6qVcDMuz+DqvQZ0 g==;
IronPort-SDR: 9l0rUgYpAJaMmGzIVAE7ACFhO3D4Go4r2D9uykjGLysNv6/egAC04Du+epqGuooMLILSGpBC7t
 MeOF5ynjBbQhk96shPUXWh2KKTA34uKVo/1k03+FHSIM3eG3B+Y1TmfNZE7FzRmEkE1gMLVUy1
 mWv4Vg4eIA0ut8FuuqiX5weXXyBYedNYAE00qRfojOOfCNpXDqbeZbn2+DxKhR04jtnZl2uZ0N
 lwLu9fBOzhH56NKH2Z+OCHjB2/ljCGVI9UoTAOkTJcsvb1IkOFbSrCcLjQeQfdDhR9XsVgyBWk
 PAA=
X-IronPort-AV: E=Sophos;i="5.64,546,1559491200"; d="scan'208";a="119813865"
Received: from mail-co1nam04lp2058.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.58])
 by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2019 12:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi2/xRxD0RtYHlmn7yX8vx0G2N7486DA7qp5hYjTbvHtOzps42V2yi1lwGQx5vh5MjnHqe3XQ44fQsGaemRR+JNqBBzPzLvUgv35dOKdjcjozDtV5VdYrK1UGIzXmLEIsqnhc4v4tS6EbH1Hh2mKo2SLDR1BoHgNVl5QTnZbbffVQrB0ZgWCq1gg6LkBGd43sTX1DXPpLAIEKnBLIVxF6jD8yKiLFWoTBewbCxFm9kyyBOobfpnMRj2jXkEc1cUMrldsw1EvO/tM2/O1DL8yUk33+trmQZs6X82xsZA5kwRKtu+F2gF8OtFkzFTCDqRs5u4F+wBB/iGWbotlgzs/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz9t+6siI3hv7CGhUTqtMcK0OcnVLU6ftOUWShi7hg4=;
 b=I7saROfoFoYTxOuxgud9OI2AIdF1UdS8dE8hevvp6Zz+C7UZVrDBd8brTJwmKqw3vpF5rA1CYolwnD7TZzl2juv0PRG3eO1ktoTUutOpp7z2FAEDrwiFMxsifhP5ER/Kj6mQBu19YRtLBza+msWCsPlyhHAM4gLcrpDY/kBOa5+ZoV+hxLugPAXr3OLXb7ClYDMJOo11xE/RWCS55ZQSfR8SgrqOmlQDIdkjdwJ8CmEGvJPRRQskFT3BNvq8fnFkRZIADXDsqZJuN03lgbdb2GMimf+UNEnc6g4yp/NvmYbhJqR2C7p4r/wYtflT/NQ8zDmEgkqHhPcpc1g3BXhkpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz9t+6siI3hv7CGhUTqtMcK0OcnVLU6ftOUWShi7hg4=;
 b=G4panujVHsIFlZWAxL1ankB8AY49cJpeyiRgQiTPSNhU77Qw84OmdypRnIckJI76n5C6gdCBrfmb02Kp90I1BiHVXYpD3oQtO3e56d9LyUtWCqdSm+qjZ7hkMTiKfG38MwAWjwEJ8eutT35UdgCq9bsIommW9oD+bjRanTYnsAQ=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6222.namprd04.prod.outlook.com (20.178.246.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 04:04:35 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 04:04:34 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar
 <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>
Subject: RE: [PATCH v2 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH v2 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVctmkW8P3iH8gtEirKQ31pP1PT6c63IIAgADpvaA=
Date: Wed, 25 Sep 2019 04:04:34 +0000
Message-ID: <MN2PR04MB6061A7A7A871CC5095F072FC8D870@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190924131131.118155-1-anup.patel@wdc.com>
 <735d696e-f0dc-cad3-acc3-056cf152cc22@redhat.com>
In-Reply-To: <735d696e-f0dc-cad3-acc3-056cf152cc22@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3f5cd41-f6c3-4f96-656c-08d7416d79f5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:MN2PR04MB6222; 
x-ms-traffictypediagnostic: MN2PR04MB6222:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB622250C78ABBB66EC3747ADD8D870@MN2PR04MB6222.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(189003)(199004)(13464003)(66066001)(478600001)(55016002)(305945005)(6306002)(54906003)(476003)(966005)(110136005)(7736002)(66556008)(229853002)(66446008)(316002)(86362001)(66946007)(81156014)(81166006)(33656002)(6246003)(8676002)(2171002)(5660300002)(66476007)(14444005)(74316002)(64756008)(8936002)(76116006)(6436002)(71200400001)(256004)(102836004)(11346002)(2906002)(6116002)(14454004)(4326008)(52536014)(186003)(71190400001)(26005)(9686003)(76176011)(99286004)(7696005)(25786009)(446003)(6506007)(486006)(3846002)(53546011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6222;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5V32/peZZDdEV+hDFG7t7WWXYz+cHMX4xQZZ9v1CrLBP5wGa4x2dEYWPPmk3VTzmJuA1qqPy/jFbEInAlhAggkQoInCUj66ejNTuUmUr+KJfbk4LZWqnJKXOZ3vgp1Vvy5v+6C079KJKWeRKHoIAOF8c9VbgruMitconO8B/FgRPChP90slG1H6QJGYJRTCEczMoUarwJyNwvfwURfMmD1pr2yscZrYOF0RDTBUMeMQlFK+MtZXh7NNI7Sn4CeO9wy8vWshEht0NTKy9WzjPzQWspXLewmu0hlfu4vjGQJXdrXS12b3LA+n2SmRiN/N2gZ0ieSDFjXdgWs7JMQLmnIKx3szKyMhzq2Kf/zX/WPDImYm4yV+aKnJSokfot/kHOPsCrG7KSJ19TuyPhNqdAJgjieDl0EOY+X96hp8V9J5cTX1pRXoc3yhiodyJ8iicBPPZwVFHchCo99F3HUKTTw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f5cd41-f6c3-4f96-656c-08d7416d79f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 04:04:34.8321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEDRA5lRGp08ikAdZSG31IzG4nOjOpMjhA4BhHjjHBEzi+T6E3hTpgsJQzRjbpaiYqMzjjXT8DDYe4wDHZJ7Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6222
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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
Cc: Atish Patra <Atish.Patra@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MjQsIDIwMTkgNzozNSBQTQ0KPiBUbzogQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3ZGMuY29tPjsg
UGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgUGFsbWVyIERhYmJl
bHQgPHBhbG1lckBzaWZpdmUuY29tPjsgQWxpc3RhaXINCj4gRnJhbmNpcyA8QWxpc3RhaXIuRnJh
bmNpc0B3ZGMuY29tPjsgU2FnYXIgS2FyYW5kaWthcg0KPiA8c2FnYXJrQGVlY3MuYmVya2VsZXku
ZWR1PjsgQmFzdGlhbiBLb3BwZWxtYW5uIDxrYmFzdGlhbkBtYWlsLnVuaS0NCj4gcGFkZXJib3Ju
LmRlPg0KPiBDYzogQXRpc2ggUGF0cmEgPEF0aXNoLlBhdHJhQHdkYy5jb20+OyBxZW11LXJpc2N2
QG5vbmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IEFudXAgUGF0ZWwgPGFudXBA
YnJhaW5mYXVsdC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMC8yXSBSVEMgc3VwcG9y
dCBmb3IgUUVNVSBSSVNDLVYgdmlydCBtYWNoaW5lDQo+IA0KPiBIaSBBbnVwLA0KPiANCj4gT24g
OS8yNC8xOSAzOjExIFBNLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMg
UlRDIGRldmljZSB0byBRRU1VIFJJU0MtViB2aXJ0IG1hY2hpbmUuIFdlIGhhdmUNCj4gPiBzZWxl
Y3RlZCBHb2xkZmlzaCBSVEMgZGV2aWNlIG1vZGVsIGZvciB0aGlzLiBJdCdzIGEgcHJldHR5IHNp
bXBsZQ0KPiA+IHN5bnRoZXRpYyBkZXZpY2Ugd2l0aCBmZXcgTU1JTyByZWdpc3RlcnMgYW5kIG5v
IGRlcGVuZGVuY3kgZXh0ZXJuYWwNCj4gPiBjbG9jay4gVGhlIGRyaXZlciBmb3IgR29sZGZpc2gg
UlRDIGlzIGFscmVhZHkgYXZhaWxhYmxlIGluIExpbnV4IHNvIHdlDQo+ID4ganVzdCBuZWVkIHRv
IGVuYWJsZSBpdCBpbiBLY29uZmlnIGZvciBSSVNDViBhbmQgYWxzbyB1cGRhdGUgTGludXgNCj4g
PiBkZWZjb25maWdzLg0KPiA+DQo+ID4gV2UgaGF2ZSB0ZXN0ZWQgdGhpcyBzZXJpZXMgd2l0aCBM
aW51eC01LjMgcGx1cyBkZWZjb25maWcgY2hhbmdlcw0KPiA+IGF2YWlsYWJsZSBpbiAnZ29sZGZp
c2hfcnRjX3YxJyBicmFuY2ggb2Y6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2F2cGF0ZWwvbGlu
dXguZ2l0DQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ICAtIFJlbW92ZWQgcmVkdW5k
YW50IG9iamVjdCBwcm9wZXJ0aWVzIGZyb20gR29sZGZpc2ggUlRDIGVtdWxhdGlvbg0KPiA+ICAt
IEFkZGVkIHZtc3RhdGUgZm9yIEdvbGRmaXNoIFJUQw0KPiA+DQo+ID4gQW51cCBQYXRlbCAoMik6
DQo+ID4gICBodzogdGltZXI6IEFkZCBHb2xkZmlzaCBSVEMgZGV2aWNlDQo+ID4gICByaXNjdjog
dmlydDogVXNlIEdvbGRmaXNoIFJUQyBkZXZpY2UNCj4gPg0KPiA+ICBody9yaXNjdi9LY29uZmln
ICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgaHcvcmlzY3YvdmlydC5jICAgICAgICAgICAg
ICAgICB8ICAxNSArKw0KPiA+ICBody90aW1lci9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAz
ICsNCj4gPiAgaHcvdGltZXIvTWFrZWZpbGUub2JqcyAgICAgICAgICB8ICAgMSArDQo+ID4gIGh3
L3RpbWVyL2dvbGRmaXNoX3J0Yy5jICAgICAgICAgfCAyNzgNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9ody9yaXNjdi92aXJ0LmggICAgICAgICB8ICAg
MiArDQo+ID4gIGluY2x1ZGUvaHcvdGltZXIvZ29sZGZpc2hfcnRjLmggfCAgNDYgKysrKysrDQo+
IA0KPiBNaW5vciBjb21tZW50LCBpZiBteSBvbmdvaW5nIHNlcmllcyAiU3BsaXQgUlRDIGRldmlj
ZXMgZnJvbSBody90aW1lci8gdG8NCj4gaHcvcnRjLyIgaXMgYWNjZXB0ZWQsIHlvdSdkIGhhdmUg
dG8gcmViYXNlIHRoaXMgaW4gaHcvcnRjL2dvbGRmaXNoX3J0YzoNCj4gaHR0cHM6Ly9saXN0cy5n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDkvbXNnMDMzMzQuaHRtbA0KPiAo
bm8gbG9naWNhbCBjaGFuZ2UgaW52b2x2ZWQpLg0KDQpObyBwcm9ibGVtLCBJIHdpbGwgcmViYXNl
IHRoZXNlIHBhdGNoZXMgb25jZSB5b3VyIHNlcmllcyBhZnRlciBpdCBpcw0KYWNjZXB0ZWQuDQoN
ClJlZ2FyZHMsDQpBbnVwDQo=


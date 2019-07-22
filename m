Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00CEC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 22:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992E921985
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 22:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CDgUV9ek";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iJUFFPT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992E921985
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpgoP-00087Q-T7
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 18:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0991791bd=Alistair.Francis@wdc.com>)
 id 1hpgoE-0007j9-Me
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 18:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0991791bd=Alistair.Francis@wdc.com>)
 id 1hpgo4-0003aZ-2t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 18:29:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0991791bd=Alistair.Francis@wdc.com>)
 id 1hpgnr-0003Ox-TU; Mon, 22 Jul 2019 18:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563834548; x=1595370548;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=V5Lgi4BoTgek2MSJomAzkNQQQbtoy+ujNEvvPLPCP+Y=;
 b=CDgUV9ek9lPQCm7YEsNlHT0DD69ut8gRsZdeiij0kNwq5r5sr40lZzR0
 3cR49SQooZngo945mISSbidUHZSTOvvp4jVimrqYNkrqsv+6B8bNpk2ft
 E6CVdJ57HIbD9T6w6nYwLlYNyuO798LE6hvBEenwyWdHkg17XopDqPDzz
 SiRjwoFoOCZ27yN6k/lZLlQao2N2f+GWk9DbsgH9tiAzAmBmV8+eeaaew
 9kCUQsfnp3e2ApBZiA3OEf826Q1DfW1Wnnmgg1aRDiiduBChPW+WLpFZs
 +WSRDHTe7UdGXOHmlE8Le+ghNPGnTkSZeRtvveUUnn9hqGgODQNFTK319 w==;
IronPort-SDR: V8Tz7MTklIUdSASCAyrFUJL3Oq0wJkT+1Y0Gwvz+WsL4sj8d7kMPf5VzvLVJKTMH87PD4rmaVj
 l9qYqmWh1eyXgeVYmwyGOxJvGFeFKlJnelblFN39ke6tafRRB64g7GwnUFswRTiwLj+XePRzrx
 iw6rfSRDEjilsnt3rGl2UojttIQDxJKqHoYMM2nZ3mfPwaACq2bx6DlAWsv+6FdS+j7JA9sr4N
 sm8qF2L05OHy0Y0/HSJBpe6Ha5wXXam5dyCVyAmGrqATVAqpiiT+XuDv6dFCbHEzVy1QQHlK8m
 JyY=
X-IronPort-AV: E=Sophos;i="5.64,296,1559491200"; d="scan'208";a="115334320"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO
 NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
 by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2019 06:28:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fquhfCCBNhML5VyhYXW27bWpuVv57ZmvNfTrOCocLFgSnQLiMI5oZwNp0ohyGOnDAxoybHviLkSGMsSNOYaj9jILhLAcW6wlggy3D+jGXoHRcxuvfgF2aYyq20BtFYYtuwbweoEzsKwXtsV2nTD6p0kga2sUHlIzzF4LZzLOdk3r9+s1qZIEOzxflOWVZ9GzcCBgxXzjkKPIYjQr+YB/50rEnjlseWSJ2W6rp/KVcF3vXyuhTWMczDOxEJBVIrMcTQoQqmOPEFrl/I/uLxLxC+8YJDjzsBS7/GUvZYHRiaRHQ2j4d6/xJdnG34b3di7dc/CPLrlg6mOwGhCIk+noSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Lgi4BoTgek2MSJomAzkNQQQbtoy+ujNEvvPLPCP+Y=;
 b=Yo309dG7HdxG4BK6FXtjM0xm6OtnfSY292oW95Pon/SKd9PAIB4z2uPy7BDYNyyt6uperaeGt5TMZbzFxNNQSEAbpSP+0lWGsawxvWa5udRKRhbCFo18rlm7dLLPjSMy5vyIIsDs+5M2ToBKmerAXBfdGjL2dlHV7pl2IAyQJOGT0ML/wjILy48FOEBPPI5Di+YymWxIfiWjgQiJGZ8IOb4qNrpQfiu6yMM/Df/12EBEuvLCnEKR8mdU53vQv+Ui2dr5w2KbVgcEfpMONC8uZ2RSRRVMx+xVQF3lr5AI3co5OtAS+i4Qummx36zvkSH47ufITlzd2OfFsqTIOS18vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Lgi4BoTgek2MSJomAzkNQQQbtoy+ujNEvvPLPCP+Y=;
 b=iJUFFPT/IG7sSniSV1ZCpXmIK0lv1iMVfzH6chResHYMazM/IF2GnhXNTMPpYAk6U5YuWh/DXCxLtRsq+r6sVGOQb8XMb2aSejaXpnBiqIwJR4KDr7inDfl+1D3k1VlTUCf9q7fagQVzVkIPYcE04vffOa6ZVL83lDK5IOZ1wPc=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4503.namprd04.prod.outlook.com (52.135.238.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 22 Jul 2019 22:28:57 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::855d:3b3c:6316:5aee]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::855d:3b3c:6316:5aee%3]) with mapi id 15.20.2094.017; Mon, 22 Jul 2019
 22:28:57 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "palmer@sifive.com"
 <palmer@sifive.com>
Thread-Topic: [PATCH 1/3] riscv: sifive_u: Add support for loading initrd
Thread-Index: AQHVPjeVrfeLHxp9TkCXQI9V/0tafabXPGwA
Date: Mon, 22 Jul 2019 22:28:57 +0000
Message-ID: <b8443b9eb0b522a1b72af5522db4335db51dac23.camel@wdc.com>
References: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1563543645-20804-1-git-send-email-linux@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d64ee6ff-5cd3-4480-ed1c-08d70ef3fca6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:BYAPR04MB4503; 
x-ms-traffictypediagnostic: BYAPR04MB4503:
x-microsoft-antispam-prvs: <BYAPR04MB45030D3EDEF58D2C6ABA07F590C40@BYAPR04MB4503.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:64;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(6512007)(81166006)(53936002)(76176011)(2501003)(81156014)(71190400001)(8936002)(186003)(99286004)(478600001)(64756008)(71200400001)(2906002)(26005)(66556008)(8676002)(4326008)(54906003)(6436002)(6486002)(66476007)(476003)(6246003)(86362001)(11346002)(486006)(256004)(25786009)(36756003)(68736007)(14454004)(5660300002)(6116002)(66066001)(305945005)(3846002)(7736002)(6506007)(66446008)(2616005)(66946007)(102836004)(446003)(110136005)(229853002)(316002)(76116006)(118296001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4503;
 H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XF0RRbR1Qyty1kNtdP3nXK0koOgHnFrCJrMmio6v3mDTOCvrhH0ZjNQkvf+8eoKYcrNC3tPkodW6Ohmlgoj/jJ6RJ3GmKWPAvwX0yslvCenJbytOpMJ6MqWM3CUMKFwaWfEFadh9bdUOyXXh6EAYr/DBUJfQIN5WwhfO6XdIF7z0jvLg8eBJZm6suIMJ5Pt/mx4DCT43QMXj6+GuqE7ATuL9YJAurUhUjZmPoCu1vcstv2k1/J1+p/8sszq3Ht2C4meI3dGPo6LunSlQH5fMj1clGQ7vwyUkZqR8VpZDifEPJb6jGcQFDcOnE6aH/UVxboczcMpwjtpsoliOB6apQYmPLMIDOXdmZ5QgLlwZCEglVdIC14eBVasVNa808/BCzzpl+kjwZyPU8VNIwKBw/6nNyfAr3jaJXeabUE/Wos4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF4F7497D3EB924A920B02EADE99CD6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64ee6ff-5cd3-4480-ed1c-08d70ef3fca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 22:28:57.3175 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Alistair.Francis@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4503
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: Re: [Qemu-devel] [PATCH 1/3] riscv: sifive_u: Add support for
 loading initrd
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
Cc: "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gRnJpLCAyMDE5LTA3LTE5IGF0IDA2OjQwIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgbG9hZGluZyBpbml0cmQgd2l0aCAiLWluaXRyZCA8ZmlsZW5hbWU+
Ig0KPiB0byB0aGUgc2lmaXZlX3UgbWFjaGluZS4gVGhpcyBsZXRzIHVzIGJvb3QgaW50byBMaW51
eCB3aXRob3V0DQo+IGRpc2sgZHJpdmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBHdWVudGVyIFJv
ZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lz
IDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+ICBody9y
aXNjdi9zaWZpdmVfdS5jIHwgMjAgKysrKysrKysrKysrKysrKystLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2h3L3Jpc2N2L3NpZml2ZV91LmMgYi9ody9yaXNjdi9zaWZpdmVfdS5jDQo+IGluZGV4IDcxYjgw
ODMuLjA2NTcwNDYgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3NpZml2ZV91LmMNCj4gKysrIGIv
aHcvcmlzY3Yvc2lmaXZlX3UuYw0KPiBAQCAtNjcsNyArNjcsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IE1lbW1hcEVudHJ5IHsNCj4gIA0KPiAgI2RlZmluZSBHRU1fUkVWSVNJT04gICAgICAgIDB4
MTAwNzAxMDkNCj4gIA0KPiAtc3RhdGljIHZvaWQgY3JlYXRlX2ZkdChTaUZpdmVVU3RhdGUgKnMs
IGNvbnN0IHN0cnVjdCBNZW1tYXBFbnRyeQ0KPiAqbWVtbWFwLA0KPiArc3RhdGljIHZvaWQgKmNy
ZWF0ZV9mZHQoU2lGaXZlVVN0YXRlICpzLCBjb25zdCBzdHJ1Y3QgTWVtbWFwRW50cnkNCj4gKm1l
bW1hcCwNCj4gICAgICB1aW50NjRfdCBtZW1fc2l6ZSwgY29uc3QgY2hhciAqY21kbGluZSkNCj4g
IHsNCj4gICAgICB2b2lkICpmZHQ7DQo+IEBAIC0yNDQsMTEgKzI0NCwxNCBAQCBzdGF0aWMgdm9p
ZCBjcmVhdGVfZmR0KFNpRml2ZVVTdGF0ZSAqcywgY29uc3QNCj4gc3RydWN0IE1lbW1hcEVudHJ5
ICptZW1tYXAsDQo+ICAgICAgICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZkdCwgIi9jaG9z
ZW4iLCAiYm9vdGFyZ3MiLA0KPiBjbWRsaW5lKTsNCj4gICAgICB9DQo+ICAgICAgZ19mcmVlKG5v
ZGVuYW1lKTsNCj4gKw0KPiArICAgIHJldHVybiBmZHQ7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2
b2lkIHJpc2N2X3NpZml2ZV91X2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQ0KPiAgew0KPiAg
ICAgIGNvbnN0IHN0cnVjdCBNZW1tYXBFbnRyeSAqbWVtbWFwID0gc2lmaXZlX3VfbWVtbWFwOw0K
PiArICAgIHZvaWQgKmZkdDsNCj4gIA0KPiAgICAgIFNpRml2ZVVTdGF0ZSAqcyA9IGdfbmV3MChT
aUZpdmVVU3RhdGUsIDEpOw0KPiAgICAgIE1lbW9yeVJlZ2lvbiAqc3lzdGVtX21lbW9yeSA9IGdl
dF9zeXN0ZW1fbWVtb3J5KCk7DQo+IEBAIC0yNjksMTMgKzI3MiwyNCBAQCBzdGF0aWMgdm9pZCBy
aXNjdl9zaWZpdmVfdV9pbml0KE1hY2hpbmVTdGF0ZQ0KPiAqbWFjaGluZSkNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbWFpbl9tZW0pOw0KPiAgDQo+ICAgICAgLyogY3JlYXRl
IGRldmljZSB0cmVlICovDQo+IC0gICAgY3JlYXRlX2ZkdChzLCBtZW1tYXAsIG1hY2hpbmUtPnJh
bV9zaXplLCBtYWNoaW5lLQ0KPiA+a2VybmVsX2NtZGxpbmUpOw0KPiArICAgIGZkdCA9IGNyZWF0
ZV9mZHQocywgbWVtbWFwLCBtYWNoaW5lLT5yYW1fc2l6ZSwgbWFjaGluZS0NCj4gPmtlcm5lbF9j
bWRsaW5lKTsNCj4gIA0KPiAgICAgIHJpc2N2X2ZpbmRfYW5kX2xvYWRfZmlybXdhcmUobWFjaGlu
ZSwgQklPU19GSUxFTkFNRSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1l
bW1hcFtTSUZJVkVfVV9EUkFNXS5iYXNlKTsNCj4gIA0KPiAgICAgIGlmIChtYWNoaW5lLT5rZXJu
ZWxfZmlsZW5hbWUpIHsNCj4gLSAgICAgICAgcmlzY3ZfbG9hZF9rZXJuZWwobWFjaGluZS0+a2Vy
bmVsX2ZpbGVuYW1lKTsNCj4gKyAgICAgICAgdWludDY0X3Qga2VybmVsX2VudHJ5ID0gcmlzY3Zf
bG9hZF9rZXJuZWwobWFjaGluZS0NCj4gPmtlcm5lbF9maWxlbmFtZSk7DQo+ICsNCj4gKyAgICAg
ICAgaWYgKG1hY2hpbmUtPmluaXRyZF9maWxlbmFtZSkgew0KPiArICAgICAgICAgICAgaHdhZGRy
IHN0YXJ0Ow0KPiArICAgICAgICAgICAgaHdhZGRyIGVuZCA9IHJpc2N2X2xvYWRfaW5pdHJkKG1h
Y2hpbmUtPmluaXRyZF9maWxlbmFtZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBtYWNoaW5lLT5yYW1fc2l6ZSwNCj4ga2VybmVsX2VudHJ5LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzdGFydCk7DQo+ICsgICAg
ICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiL2Nob3NlbiIsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgImxpbnV4LGluaXRyZC1zdGFydCIsIHN0YXJ0KTsN
Cj4gKyAgICAgICAgICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsICIvY2hvc2VuIiwgImxp
bnV4LGluaXRyZC0NCj4gZW5kIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBlbmQpOw0KPiArICAgICAgICB9DQo+ICAgICAgfQ0KPiAgDQo+ICAgICAgLyogcmVzZXQgdmVj
dG9yICovDQo=


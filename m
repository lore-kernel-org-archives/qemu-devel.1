Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4025C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D543206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Uk1+vi3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D543206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFPL-0000YO-Jn
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAFBb-0005Ou-DC
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iAFBZ-00022P-Mc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:14:34 -0400
Received: from mail-eopbgr50104.outbound.protection.outlook.com
 ([40.107.5.104]:52455 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iAFBX-0001vx-Am; Tue, 17 Sep 2019 11:14:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNGj9L6YfgpB4AIzoGj079G6IMRcanmAMGaYHYZ2XcHP0QYk5A3jle57cg/MGHvoxOu+kMx8X2Y17aApNJD34c+CAK/OVM3ZhWijFOj6WlIv34O5LmcKsJLwpp+DKVr0XFxgGHSXBQfR12TwbI406qZQo9/leJVqcKzoEz8p1NixAhmzM96GzKfKKITmBtXhvLLx+f5U6wnC4DDpgs8XDz2KOsZcIm1EYcP6I7DPtiKNGbnVshX0X6LOqJc4r+63qJRyV6SRWoNTTTSRF2PYJT28Ci1QIMGlMswFF+O4F3ts0GLgLc7BL9KDg8UH2nUKGksytq1SC8QnbQ0TB/41LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4APapOw6BqPZyE+g5JocgI5q77UKK050DYWHO19aDQ=;
 b=hzHxK59mFlY8PdXiL5H6Kno1gMytbZ7qNODDFakY38c6tQQ/vTNsvQoNV86DFliGfAeLb9Dpg/smqEaO5OEyfHHMgGp1CRVnatlMBMv4YAqWP/crUiVFdMFtWMLPMu7dnHW6JpRjlWbQLvM+zEFA15uKOolCjIlFZLctEPzX3mPolyCq34t7TiuzRSU0P4V3hci2NGAEPJ1DImKHNAlxVEGhCvNlA0ZFqhOpicXIs4H5H62HEBRMSsgwhhWs+NYAAS1fTsj+Iifib/cqR9QBk+p5N7hZkus7H8vSX0KuvIDUrux8fPgw/YvHHZP1RNju+BMQ3ziTc5jQrFZX5u9zfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4APapOw6BqPZyE+g5JocgI5q77UKK050DYWHO19aDQ=;
 b=Uk1+vi3JJFKAVfbBjYHzHMXwPBTGSNrtH76pbwZtHQahBkD5nf+4ye6DhF48x2DHcJjgdEpkRbhsD23I67MpJw4tCXMsW1k/zqSGfQsxDAKAdvG79Sq4gqOI7HdoENZ5FOTCB01JaA/rArp5CnTUc3vRDfBNY4deWjM5+9+oGfk=
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com (10.175.33.138) by
 HE1PR0802MB2505.eurprd08.prod.outlook.com (10.175.34.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Tue, 17 Sep 2019 15:14:26 +0000
Received: from HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10]) by HE1PR0802MB2460.eurprd08.prod.outlook.com
 ([fe80::4d31:70d0:5b10:7a10%6]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:14:26 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v4 6/7] iotests: Test driver whitelisting in 136
Thread-Index: AQHVbTksUMi6nx3wvkuucU0J5/FXaqcv+ryA
Date: Tue, 17 Sep 2019 15:14:26 +0000
Message-ID: <5304a0d7-1d77-62e0-ed9d-656e4d4d1e3c@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <20190917092004.999-7-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-7-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::19)
 To HE1PR0802MB2460.eurprd08.prod.outlook.com
 (2603:10a6:3:dd::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbb171dc-b4b5-4bab-dd28-08d73b81ba8f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:HE1PR0802MB2505; 
x-ms-traffictypediagnostic: HE1PR0802MB2505:
x-microsoft-antispam-prvs: <HE1PR0802MB250539EFA657EBBAE173FCA0F48F0@HE1PR0802MB2505.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(39850400004)(346002)(136003)(199004)(189003)(6246003)(476003)(6116002)(6486002)(66066001)(81166006)(7736002)(6436002)(31686004)(26005)(14444005)(386003)(6506007)(2501003)(53546011)(486006)(31696002)(478600001)(4326008)(8936002)(256004)(8676002)(6512007)(14454004)(81156014)(86362001)(102836004)(2616005)(36756003)(446003)(11346002)(229853002)(3846002)(44832011)(186003)(305945005)(2906002)(316002)(64756008)(25786009)(66446008)(66476007)(66556008)(71200400001)(66946007)(71190400001)(76176011)(52116002)(99286004)(5660300002)(110136005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2505;
 H:HE1PR0802MB2460.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SwBUhY9Wng5qeg1wFAw+JELleuVVs++cEd14mMzOyaqD+WEcjHF71VVOboDa5Rn1CQhAawEtsp3m2DHWhi3c8f9HG+eNTCB8axOM4+Z/uApKmsXFJb9//mmHlPrNJLEtftdLyNUTaPmLh8+ePo2bsNJ1U1bKdsTkavTmImAYNTqSHG3JwOuU4lTLtBrGgOO0hYxgIYW4PjWDlNLuWfDU+2hnabZ0eAuTNiID2DTgTMiuHicWLGr21MsOOZrPQjrJhktDUgTA41Fd7PURfmDNbqCImPkZbhJwLbAphrKJzNxlcaX23TmyIpBqPVwa2hJ2MuTB2Fi8t9oCr5YQtyhTDjo97tjBwrc66/5TEnICyiYe3fzqDAyliRGcQht0ibTvI+1zTD6kaBIHQDc17nfmRKNSuri0DsCTNePcH/CV+A4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DBFACB95CBB634E836362C8260EDF20@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb171dc-b4b5-4bab-dd28-08d73b81ba8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:14:26.4704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N0XptHx1FuApz97TIryaKsEam6y8z9gsGGAFZTgFuTJBA8CWrdtsfuf1k7O2NrMauD/UrOZhwSdrDxkxwUclsK1ePbK9/OKajOtpdcb8lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2505
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.104
Subject: Re: [Qemu-devel] [PATCH v4 6/7] iotests: Test driver whitelisting
 in 136
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiAxNy8wOS8yMDE5IDEyOjIwLCBNYXggUmVpdHogd3JvdGU6DQo+IG51bGwtYWlvIG1heSBu
b3QgYmUgd2hpdGVsaXN0ZWQuICBTa2lwIGFsbCB0ZXN0IGNhc2VzIHRoYXQgcmVxdWlyZSBpdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IC0t
LQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8xMzYgfCAxNCArKysrKysrKysrLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xMzYgYi90ZXN0cy9xZW11LWlvdGVzdHMvMTM2
DQo+IGluZGV4IGE0NmE3Yjc2MzAuLjAxMmVhMTExYWMgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8xMzYNCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzEzNg0KPiBAQCAtMzAs
NyArMzAsNyBAQCBiYWRfb2Zmc2V0ID0gYmFkX3NlY3RvciAqIDUxMg0KPiAgIGJsa2RlYnVnX2Zp
bGUgPSBvcy5wYXRoLmpvaW4oaW90ZXN0cy50ZXN0X2RpciwgJ2Jsa2RlYnVnLmNvbmYnKQ0KPiAg
IA0KPiAgIGNsYXNzIEJsb2NrRGV2aWNlU3RhdHNUZXN0Q2FzZShpb3Rlc3RzLlFNUFRlc3RDYXNl
KToNCj4gLSAgICB0ZXN0X2ltZyA9ICJudWxsLWFpbzovLyINCj4gKyAgICB0ZXN0X2RyaXZlciA9
ICJudWxsLWFpbyINCj4gICAgICAgdG90YWxfcmRfYnl0ZXMgPSAwDQo+ICAgICAgIHRvdGFsX3Jk
X29wcyA9IDANCj4gICAgICAgdG90YWxfd3JfYnl0ZXMgPSAwDQo+IEBAIC02Nyw2ICs2NywxMCBA
QCBzZWN0b3IgPSAiJWQiDQo+ICAgJycnICUgKGJhZF9zZWN0b3IsIGJhZF9zZWN0b3IpKQ0KPiAg
ICAgICAgICAgZmlsZS5jbG9zZSgpDQo+ICAgDQo+ICsgICAgZGVmIHJlcXVpcmVkX2RyaXZlcnMo
c2VsZik6DQo+ICsgICAgICAgIHJldHVybiBbc2VsZi50ZXN0X2RyaXZlcl0NCj4gKw0KPiArICAg
IEBpb3Rlc3RzLnNraXBfaWZfdW5zdXBwb3J0ZWQocmVxdWlyZWRfZHJpdmVycykNCj4gICAgICAg
ZGVmIHNldFVwKHNlbGYpOg0KPiAgICAgICAgICAgZHJpdmVfYXJncyA9IFtdDQo+ICAgICAgICAg
ICBkcml2ZV9hcmdzLmFwcGVuZCgic3RhdHMtaW50ZXJ2YWxzLjA9JWQiICUgaW50ZXJ2YWxfbGVu
Z3RoKQ0KPiBAQCAtNzYsOCArODAsOCBAQCBzZWN0b3IgPSAiJWQiDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoc2VsZi5hY2NvdW50X2ZhaWxlZCBhbmQgIm9uIiBvciAib2ZmIikpDQo+
ICAgICAgICAgICBkcml2ZV9hcmdzLmFwcGVuZCgiZmlsZS5pbWFnZS5yZWFkLXplcm9lcz1vbiIp
DQo+ICAgICAgICAgICBzZWxmLmNyZWF0ZV9ibGtkZWJ1Z19maWxlKCkNCj4gLSAgICAgICAgc2Vs
Zi52bSA9IGlvdGVzdHMuVk0oKS5hZGRfZHJpdmUoJ2Jsa2RlYnVnOiVzOiVzJyAlDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChibGtkZWJ1Z19maWxlLCBzZWxm
LnRlc3RfaW1nKSwNCj4gKyAgICAgICAgc2VsZi52bSA9IGlvdGVzdHMuVk0oKS5hZGRfZHJpdmUo
J2Jsa2RlYnVnOiVzOiVzOi8vJyAlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIChibGtkZWJ1Z19maWxlLCBzZWxmLnRlc3RfZHJpdmVyKSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICcsJy5qb2luKGRyaXZlX2FyZ3MpKQ0K
PiAgICAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPiAgICAgICAgICAgIyBTZXQgYW4gaW5pdGlh
bCB2YWx1ZSBmb3IgdGhlIGNsb2NrDQo+IEBAIC0zMzcsNyArMzQxLDkgQEAgY2xhc3MgQmxvY2tE
ZXZpY2VTdGF0c1Rlc3RBY2NvdW50Qm90aChCbG9ja0RldmljZVN0YXRzVGVzdENhc2UpOg0KPiAg
ICAgICBhY2NvdW50X2ZhaWxlZCA9IFRydWUNCj4gICANCj4gICBjbGFzcyBCbG9ja0RldmljZVN0
YXRzVGVzdENvcm91dGluZShCbG9ja0RldmljZVN0YXRzVGVzdENhc2UpOg0KPiAtICAgIHRlc3Rf
aW1nID0gIm51bGwtY286Ly8iDQo+ICsgICAgdGVzdF9kcml2ZXIgPSAibnVsbC1jbyINCj4gICAN
Cj4gICBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOg0KPiArICAgIGlmICdudWxsLWNvJyBub3Qg
aW4gaW90ZXN0cy5zdXBwb3J0ZWRfZm9ybWF0cygpOg0KPiArICAgICAgICBpb3Rlc3RzLm5vdHJ1
bignbnVsbC1jbyBkcml2ZXIgc3VwcG9ydCBtaXNzaW5nJykNCj4gICAgICAgaW90ZXN0cy5tYWlu
KHN1cHBvcnRlZF9mbXRzPVsicmF3Il0pDQo+IA0KDQpSZXZpZXdlZC1ieTogQW5kcmV5IFNoaW5r
ZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQotLSANCldpdGggdGhlIGJl
c3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=


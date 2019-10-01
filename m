Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC546ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F9521855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NohsC5R9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F9521855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLP9-0004Cl-1e
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKvW-0004Rw-5b
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKvU-0000c6-D8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:23:01 -0400
Received: from mail-db5eur03on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::71a]:63104
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKvP-0000V8-Tl; Tue, 01 Oct 2019 12:22:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3t6rR/4bp8pLru5QdkpdRM8o3McEnCeKG4/IntBW2w4iujOLNHmiDBOtjsEVyXa8Fw0lLMIx7CEC5p9L0BPUtqTAS02cH5R+hwDrrU1Bm6VOnJkgQ8RRJCwwnfNjV8efIXXJTejE4PVGk2qpV4lviNp28ZzfDZK4+fPMDoW25GT2CsvKJyUf84Ivv2/M9wZgyyEc34zAP8mlKWOQjdKsTX20mMXwVoe9WcQ1D7T0CwEpf2MWTW/8CLqkmMcHeIyvahN8hSboOEmMztk3FPxsPhF9fGCraibZ7Xq7KFIHpR13bZCNvUpm27idgA5zxsmjIbDzL1CcNTw+20nozTwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jrxJzVF50Kr51MZRs6b2T5nH71VchI6BXG1U2O4BDk=;
 b=irqfDu65oOPibgfHLwIw6mlgn0xuvtn8vFIzOiLaaiqkWSeJJ92KzdxSoxBMh+rbvbdazc2xx3FxWaZihUlgg69ex3C0knJu+WUs2oTlKSHW3t456EnzsEmhU8Kz61+DNJNSUkE/IrDUJu3eiFzLgUggpI8Ihnx+zK30clPsGGeLtI07e/qBpY3kbdy50VZDodr1mZJFbysAfCJSIrN75nBqpHqmf9g4T71ezPHgANzsaxIhtBBjrKsWCqaGS0sKYzXIz/HFJafZaS5Jgu+eKk/u5+R0b8ekLm01bZoTJmW57GNyRGfSPL4YQaSR2+LPZxYtMsFgkarmQNIek6W7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jrxJzVF50Kr51MZRs6b2T5nH71VchI6BXG1U2O4BDk=;
 b=NohsC5R9aqvZJ3u59IQW6n6ouc2a+vVwJVlp6H2LghbDxye+mu+Uk+2A56CTCxJw4zP+Zr934nhjaFvUGfx/6bD0fw4rx+kFhLOOzNqdH0/NrYbJuSDvaoA8LGQCuL/atjzKfoDCsBz8s0X47bgVI2Lbi9o+OUTv8Hdm5RwzvyE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3963.eurprd08.prod.outlook.com (20.179.10.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 1 Oct 2019 16:22:52 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 16:22:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAADoACAAAP3AIAAAg8AgAAJ1gCAAAUFAIAADJUAgAABRwCAAAGDgA==
Date: Tue, 1 Oct 2019 16:22:51 +0000
Message-ID: <e87cb685-2583-2fec-5044-8ace13ebf65b@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
 <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
 <20191001150950.GD4688@linux.fritz.box>
 <d32d21c0-6f18-39ba-6da3-060c865f701a@redhat.com>
 <20191001161250.GF4688@linux.fritz.box>
 <6654acd8-123a-4fa7-e728-102feccd9c05@redhat.com>
In-Reply-To: <6654acd8-123a-4fa7-e728-102feccd9c05@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::11) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001192249892
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed2972f4-2f4f-4b72-3d4f-08d7468b9b66
x-ms-traffictypediagnostic: DB8PR08MB3963:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB39638CC0FC2206E7CAC2C1E0C19D0@DB8PR08MB3963.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39840400004)(396003)(376002)(366004)(189003)(199004)(5024004)(4326008)(86362001)(66476007)(66446008)(6506007)(386003)(14444005)(64756008)(6486002)(2906002)(229853002)(7736002)(53546011)(31696002)(3846002)(6116002)(76176011)(6306002)(478600001)(6512007)(66946007)(36756003)(316002)(8936002)(71200400001)(71190400001)(8676002)(81156014)(81166006)(99286004)(31686004)(66556008)(256004)(52116002)(305945005)(54906003)(476003)(6246003)(446003)(2616005)(11346002)(25786009)(102836004)(110136005)(186003)(26005)(66066001)(5660300002)(14454004)(486006)(6436002)(966005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3963;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvSgHnUD5cw9WzDlV1nPeehMkgVx21MYFMgYoBIsVq/iZoKf2vevoGoZ9pRm2CC7Qrw7auXK9xqU6peeRcuWQep3UKu0oCE/QQbQB7FLzdvUBHVjKnc/C6EMoarHYPNCGNUpJtl7DL2UXnxtdzu+xi8NmgBp8oIGteC1nvmfxaecTdvNQY9SlIYvbm4jUMFSFNfsJQYnz1Oj8zn2b3kjQVjNhZx5k12QSd/NJOnVmE7n2NsGnFdNJBPyIES9syL9HghY3JIl63m0jjxkXfbCOBuUvP1plDs9pW3/FQbAdbAQ++IYVZ26hHDu820ZdYqoLQuEglfxTLmmtFvGxi63/d1+3RV6+z7U7/Itthmvt9PDKutRHcclHo/SRAI7RnQjbQBHiCKqO2i5+ep4nkNCkL9iDjq92Rw8Qkr+EgQyLIsPO6NrZC0hnVHQGLXYtZjOmYmYdiSVFPtpI98weB4rJQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DC42C64DA8DC445BA6E54B249D64BB6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2972f4-2f4f-4b72-3d4f-08d7468b9b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 16:22:52.0664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ze0MG5nWxcnDpMEFuLugZfV1GFpGrzq/KoNeLeStLrEnRJglOPcjNbeyKZ0G2CihAk8jbbQQaKIzL77SsxtI45emi6AGMoqZMevJQxk0C4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3963
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0a::71a
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxOToxNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMC4xOSAxODoxMiwg
S2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDAxLjEwLjIwMTkgdW0gMTc6MjcgaGF0IE1heCBSZWl0
eiBnZXNjaHJpZWJlbjoNCj4+PiBPbiAwMS4xMC4xOSAxNzowOSwgS2V2aW4gV29sZiB3cm90ZToN
Cj4+Pj4gQW0gMDEuMTAuMjAxOSB1bSAxNjozNCBoYXQgTWF4IFJlaXR6IGdlc2NocmllYmVuOg0K
Pj4+Pj4gT24gMDEuMTAuMTkgMTY6MjcsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3Jv
dGU6DQo+Pj4+Pj4gMDEuMTAuMjAxOSAxNzoxMywgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4+PiBP
biAwMS4xMC4xOSAxNjowMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
Pj4+Pj4+IDAxLjEwLjIwMTkgMzowOSwgSm9obiBTbm93IHdyb3RlOg0KPj4+Pj4+Pj4+IEhpIGZv
bGtzLCBJIGlkZW50aWZpZWQgYSBwcm9ibGVtIHdpdGggdGhlIG1pZ3JhdGlvbiBjb2RlIHRoYXQg
UmVkIEhhdCBRRQ0KPj4+Pj4+Pj4+IGZvdW5kIGFuZCB0aG91Z2h0IHlvdSdkIGxpa2UgdG8gc2Vl
IGl0Og0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3No
b3dfYnVnLmNnaT9pZD0xNjUyNDI0I2MyMA0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gVmVyeSwgdmVy
eSBicmllZmx5OiBkcml2ZS1taXJyb3IgaW5zZXJ0cyBhIGZpbHRlciBub2RlIHRoYXQgY2hhbmdl
cyB3aGF0DQo+Pj4+Pj4+Pj4gYmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZSgpIHJldHVybnMs
IHdoaWNoIGNhdXNlcyBhIG1pZ3JhdGlvbiBwcm9ibGVtLg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+PiBJZ25vcmFudCBxdWVzdGlvbiAjMTogQ2FuIHdlIG11bHRpLXBhcmVudCB0aGUg
ZmlsdGVyIG5vZGUgYW5kDQo+Pj4+Pj4+Pj4gc291cmNlLW5vZGU/IEl0IGxvb2tzIGxpa2UgYXQg
dGhlIG1vbWVudCBib3RoIGNvbnNpZGVyIHRoZWlyIG9ubHkgcGFyZW50DQo+Pj4+Pj4+Pj4gdG8g
YmUgdGhlIGJsb2NrLWpvYiBhbmQgZG9uJ3QgaGF2ZSBhIGxpbmsgYmFjayB0byB0aGVpciBwYXJl
bnRzIG90aGVyd2lzZS4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gT3RoZXJ3aXNl
OiBJIGhhdmUgYSBsb3Qgb2YgY2xvdWR5IGlkZWFzIG9uIGhvdyB0byBzb2x2ZSB0aGlzLCBidXQN
Cj4+Pj4+Pj4+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQg
dGhlICJhZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+Pj4+Pj4+PiB0aGUgbm9kZSB0aGUgYml0bWFw
IGlzIGF0dGFjaGVkIHRvLCB3aGljaCB3b3VsZCBiZSB0aGUgbmFtZSBvZiB0aGUgZmlyc3QNCj4+
Pj4+Pj4+PiBhbmNlc3RvciBub2RlIHRoYXQgaXNuJ3QgYSBmaWx0ZXIuIChPUiwgdGhlIG5hbWUg
b2YgdGhlIGJsb2NrLWJhY2tlbmQNCj4+Pj4+Pj4+PiBhYm92ZSB0aGF0IG5vZGUuKQ0KPj4+Pj4+
Pj4NCj4+Pj4+Pj4+IE5vdCB0aGUgbmFtZSBvZiBhbmNlc3RvciBub2RlLCBpdCB3aWxsIGJyZWFr
IG1hcHBpbmc6IGl0IG11c3QgYmUgbmFtZSBvZiB0aGUNCj4+Pj4+Pj4+IG5vZGUgaXRzZWxmIG9y
IG5hbWUgb2YgcGFyZW50IChtYXkgYmUgdGhyb3VnaCBzZXZlcmFsIGZpbHRlcnMpIGJsb2NrLWJh
Y2tlbmQNCj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBBIHNpbXBsZSB3YXkgdG8gZG8g
dGhpcyBtaWdodCBiZSBhICJjaGlsZF91bmZpbHRlcmVkIiBCZHJ2Q2hpbGQgcm9sZQ0KPj4+Pj4+
Pj4+IHRoYXQgc2ltcGx5IGJ5cGFzc2VzIHRoZSBmaWx0ZXIgdGhhdCB3YXMgaW5zZXJ0ZWQgYW5k
IHNlcnZlcyBubyByZWFsDQo+Pj4+Pj4+Pj4gcHVycG9zZSBvdGhlciB0aGFuIHRvIGFsbG93IHRo
ZSBjaGlsZCB0byBoYXZlIGEgcGFyZW50IGxpbmsgYW5kIGZpbmQgd2hvDQo+Pj4+Pj4+Pj4gaXQn
cyAiIiJyZWFsIiIiIHBhcmVudCBpcy4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEJlY2F1c2Ugb2Yg
Zmx1c2hpbmcsIHJlb3Blbiwgc3luYywgZHJhaW4gJmMgJmMgJmMgSSdtIG5vdCBzdXJlIGhvdw0K
Pj4+Pj4+Pj4+IGZlYXNpYmxlIHRoaXMgcXVpY2sgaWRlYSBtaWdodCBiZSwgdGhvdWdoLg0KPj4+
Pj4+Pj4+DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAtIENvcm9sbGFyeSBmaXggIzE6IGNhbGwgZXJy
b3Jfc2V0ZyBpZiB0aGUgYml0bWFwIG5vZGUgbmFtZSB0aGF0J3MgYWJvdXQNCj4+Pj4+Pj4+PiB0
byBnbyBvdmVyIHRoZSB3aXJlIGlzIGFuIGF1dG9nZW5lcmF0ZWQgbm9kZTogdGhpcyBpcyBuZXZl
ciBjb3JyZWN0IQ0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gKFdoeSBub3Q/IGJlY2F1c2UgdGhlIHRh
cmdldCBpcyBpbmNhcGFibGUgb2YgbWF0Y2hpbmcgdGhlIG5vZGUtbmFtZQ0KPj4+Pj4+Pj4+IGJl
Y2F1c2UgdGhleSBhcmUgcmFuZG9tbHkgZ2VuZXJhdGVkIEFORCB5b3UgY2Fubm90IHNwZWNpZnkg
bm9kZS1uYW1lcw0KPj4+Pj4+Pj4+IHdpdGggIyBwcmVmaXhlcyBhcyB0aGV5IGFyZSBlc3BlY2lh
bGx5IHJlc2VydmVkIQ0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gKFRoaXMgcmFpc2VzIGEgcmVsYXRl
ZCBwcm9ibGVtOiBpZiB5b3UgZXhwbGljaXRseSBhZGQgYml0bWFwcyB0byBub2Rlcw0KPj4+Pj4+
Pj4+IHdpdGggYXV0b2dlbmVyYXRlZCBuYW1lcywgeW91IHdpbGwgYmUgdW5hYmxlIHRvIG1pZ3Jh
dGUgdGhlbS4pKQ0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gLS1qcw0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gV2hhdCBhYm91dCB0aGUgZm9sbG93aW5nOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+
IGRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPj4+Pj4+Pj4gaW5kZXggNTk0NDEyNDg0
NS4uNjczOWMxOWJlOSAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2Jsb2NrLmMNCj4+Pj4+Pj4+ICsr
KyBiL2Jsb2NrLmMNCj4+Pj4+Pj4+IEBAIC0xMDA5LDggKzEwMDksMjAgQEAgc3RhdGljIHZvaWQg
YmRydl9pbmhlcml0ZWRfb3B0aW9ucyhpbnQgKmNoaWxkX2ZsYWdzLCBRRGljdCAqY2hpbGRfb3B0
aW9ucywNCj4+Pj4+Pj4+ICAgICAgICAgKmNoaWxkX2ZsYWdzID0gZmxhZ3M7DQo+Pj4+Pj4+PiAg
ICAgfQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+ICtzdGF0aWMgY29uc3QgY2hhciAqYmRydl9jaGlsZF9n
ZXRfbmFtZShCZHJ2Q2hpbGQgKmNoaWxkKQ0KPj4+Pj4+Pj4gK3sNCj4+Pj4+Pj4+ICsgICAgQmxv
Y2tEcml2ZXJTdGF0ZSAqcGFyZW50ID0gY2hpbGQtPm9wYXF1ZTsNCj4+Pj4+Pj4+ICsNCj4+Pj4+
Pj4+ICsgICAgaWYgKHBhcmVudC0+ZHJ2ICYmIHBhcmVudC0+ZHJ2LT5pc19maWx0ZXIpIHsNCj4+
Pj4+Pj4+ICsgICAgICAgIHJldHVybiBiZHJ2X2dldF9wYXJlbnRfbmFtZShwYXJlbnQpOw0KPj4+
Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4+PiArDQo+Pj4+Pj4+PiArICAgIHJldHVybiBOVUxMOw0KPj4+
Pj4+Pj4gK30NCj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2h5IHdvdWxkIHdlIHNraXAg
ZmlsdGVycyBleHBsaWNpdGx5IGFkZGVkIGJ5IHRoZSB1c2VyPw0KPj4+Pj4+Pg0KPj4+Pj4+DQo+
Pj4+Pj4gV2h5IG5vdD8gT3RoZXJ3aXNlIG1pZ3JhdGlvbiBvZiBiaXRtYXBzIHdpbGwgbm90IHdv
cms6IHdlIG1heSBoYXZlIGRpZmZlcmVudCBzZXQNCj4+Pj4+PiBvZiBmaWx0ZXJzIG9uIHNvdXJj
ZSBhbmQgZGVzdGluYXRpb24sIGFuZCB3ZSBzdGlsbCBzaG91bGQgbWFwIG5vZGVzIHdpdGggYml0
bWFwcw0KPj4+Pj4+IGF1dG9tYXRpY2FsbHkuDQo+Pj4+Pg0KPj4+Pj4gV2h5IHdvdWxkIHdlIGhh
dmUgYSBkaWZmZXJlbnQgc2V0IG9mIGV4cGxpY2l0bHkgYWRkZWQgZmlsdGVycyBvbiBzb3VyY2UN
Cj4+Pj4+IGFuZCBkZXN0aW5hdGlvbiBhbmQgYWxsb3cgdGhlbSB0byBiZSBhdXRvbWF0aWNhbGx5
IGNoYW5nZWQgZHVyaW5nDQo+Pj4+PiBtaWdyYXRpb24/ICBTaG91bGRu4oCZdCB1c2VycyBvbmx5
IGNoYW5nZSB0aGVtIHByZSBvciBwb3N0IG1pZ3JhdGlvbj8NCj4+Pj4NCj4+Pj4gV2UgbmV2ZXIg
bWFkZSBhIHJlcXVpcmVtZW50IHRoYXQgdGhlIGJhY2tlbmQgbXVzdCBiZSB0aGUgc2FtZSBvbiB0
aGUNCj4+Pj4gc291cmNlIGFuZCB0aGUgZGVzdGluYXRpb24uIEJhc2ljYWxseSwgbWlncmF0aW9u
IGNvcGllcyB0aGUgc3RhdGUgb2YNCj4+Pj4gZnJvbnRlbmRzIGFuZCB0aGUgdXNlciBpcyByZXNw
b25zaWJsZSBmb3IgaGF2aW5nIHRoZXNlIGZyb250ZW5kcyBjcmVhdGVkDQo+Pj4+IGFuZCBjb25u
ZWN0ZWQgdG8gdGhlIHJpZ2h0IGJhY2tlbmRzIG9uIHRoZSBkZXN0aW5hdGlvbi4NCj4+Pj4NCj4+
Pj4gVXNpbmcgZGlmZmVyZW50IHBhdGhzIG9uIHRoZSBkZXN0aW5hdGlvbiBpcyBhIHZlcnkgb2J2
aW91cyByZXF1aXJlbWVudA0KPj4+PiBmb3IgYmxvY2sgZGV2aWNlcy4gSXQncyBsZXNzIG9idmlv
dXMgZm9yIHRoZSBncmFwaCBzdHJ1Y3R1cmUsIGJ1dCBJDQo+Pj4+IGRvbid0IHNlZSBhIHJlYXNv
biB3aHkgaXQgY291bGRuJ3QgY2hhbmdlIG9uIG1pZ3JhdGlvbi4gU2F5IHdlIHdlcmUNCj4+Pj4g
dXNpbmcgbG9jYWwgc3RvcmFnZSBvbiB0aGUgc291cmNlLCBidXQgbm93IHdlIGRpZCBzdG9yYWdl
IG1pZ3JhdGlvbiB0bw0KPj4+PiBzb21lIG5ldHdvcmsgc3RvcmFnZSwgYWNjZXNzIHRvIHdoaWNo
IHNob3VsZCBiZSB0aHJvdHRsZWQuDQo+Pj4NCj4+PiBJIGRvbuKAmXQgcXVpdGUgc2VlIHdoeSB3
ZSBjb3VsZG7igJl0IGFkZCBzdWNoIGZpbHRlcnMgYmVmb3JlIG9yIGFmdGVyDQo+Pj4gbWlncmF0
aW9uLg0KPj4NCj4+IFBvc3NpYmx5LiBCdXQgd2h5IHdvdWxkIHdlIHdoZW4gdGhlIHNvdXJjZSBk
b2Vzbid0IG5lZWQgdGhlIGZpbHRlcj8gV2UNCj4+IGRvbid0IGNoYW5nZSB0aGUgaW1hZ2UgcGF0
aCBiZWZvcmUgbWlncmF0aW9uIGVpdGhlci4NCj4+DQo+PiBJIHRoaW5rIHRoZSB0cmlja3kgcGFy
dCBpcyBjb21pbmcgdXAgd2l0aCBydWxlcyBhbmQgImtlZXAgdGhlIGZyb250ZW5kDQo+PiB0aGUg
c2FtZSwgdGhlIGJhY2tlbmQgY2FuIGNoYW5nZSBhcmJpdHJhcmlseSIgaXMgYSB2ZXJ5IGVhc3kg
cnVsZS4NCj4gDQo+IE9LLCBpbmRlZWQuDQo+IA0KPj4+IEFuZCBpdCB3YXMgbXkgaW1wcmVzc2lv
biB0aGF0IGJpdG1hcCBtaWdyYXRpb24gd2FzIGEgcHJvYmxlbSBub3cNCj4+PiBwcmVjaXNlbHkg
YmVjYXVzZSBpdCBpcyBib3VuZCB0byB0aGUgZ3JhcGggc3RydWN0dXJlLg0KPj4NCj4+IFNvIGFw
cGFyZW50bHkgSSB3YXNuJ3QgY29tcGxldGVseSB3cm9uZyB3aGVuIEkgcHJlZmVycmVkIGp1c3Qg
d3JpdGluZw0KPj4gYml0bWFwcyBiYWNrIHRvIHRoZSBpbWFnZSBpbnN0ZWFkIG9mIHRyYW5zZmVy
cmluZyB0aGVtIGluIHRoZSBtaWdyYXRpb24NCj4+IHN0cmVhbS4uLg0KPj4NCj4+IEl0J3Mgbm90
IHJlYWxseSBib3VuZCB0byB0aGUgZ3JhcGggc3RydWN0dXJlIHBlciBzZSwgYnV0IHRvIG5vZGUg
bmFtZXMNCj4+IGFuZCBmb3Igbm9uLWFub255bW91cyBCbG9ja0JhY2tlbmRzIHRvIHRoZSBsaW5r
IGJldHdlZW4gdGhlIEJCIGFuZCBpdHMNCj4+IHJvb3Qgbm9kZS4gVGhlIGxhdHRlciBpcyBwYXJ0
IG9mIHRoZSBncmFwaCBzdHJ1Y3R1cmUsIGJ1dCBvbmx5IGEgdmVyeQ0KPj4gc21hbGwgcGFydCwg
YW5kIGl0IGV4aXN0cyBvbmx5IGZvciBsZWdhY3kgKG5vbi1ibG9ja2RldikgY29uZmlndXJhdGlv
bnMuDQo+Pg0KPj4+IEJ1dCBhbnl3YXkuICBJ4oCZbGwgZ2xhZGx5IHJlbW92ZSBteXNlbGYgZnJv
bSB0aGlzIGRpc2N1c3Npb24gYmVjYXVzZSBJDQo+Pj4gZG9u4oCZdCBrbm93IG11Y2ggYWJvdXQg
bWlncmF0aW9uIGFuZCBhY3R1YWxseSBJ4oCZZCBwcmVmZXIgdG8ga2VlcCBpdCB0aGF0DQo+Pj4g
d2F5LiAgKFNvcnJ5LikNCj4+DQo+PiBHb29kIGlkZWEsIGxldCdzIGhhdmUgdGhlIG1pZ3JhdGlv
biBtYWludGFpbmVycyBoYW5kbGUgdGhpcy4NCj4gDQo+IDotKQ0KPiANCj4gVGhhdOKAmXMgYWx3
YXlzIGhvdyBpdCBnb2VzLCBpc27igJl0IGl0PyAgTWlncmF0aW9uIG1haW50YWluZXJzIGRvbuKA
mXQga25vdw0KPiB0aGUgYmxvY2sgc2lkZSwgYW5kIHdlIGRvbuKAmXQga25vdyB0aGUgbWlncmF0
aW9uIHNpZGUuLi4NCg0KSGFoYSwgbHVja2lseSBJJ20gbm90IGEgbWFpbnRhaW5lciA6KQ0KDQo+
IA0KPiBBbnl3YXkuICBJdOKAmXMganVzdCBhIGZhY3QgdGhhdCBJIGRvbuKAmXQgaGF2ZSBtdWNo
IHRvIGFkZCB0byB0aGUNCj4gZGlzY3Vzc2lvbiwgd2hlcmVhcyB0aGVyZSBzZWVtcyB0byBiZSBh
IHByb2R1Y3RpdmUgZGlzY3Vzc2lvbiB3aXRob3V0IG1lDQo+IGFscmVhZHkuDQo+IA0KPiBNYXgN
Cj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


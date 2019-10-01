Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FDECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EF72086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZhikgCZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EF72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJ8Y-0005yR-5n
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFJ7g-0005V2-6E
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFJ7d-0004Y3-CN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:27:26 -0400
Received: from mail-am5eur02on0702.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::702]:49125
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFJ7c-0004UX-LG; Tue, 01 Oct 2019 10:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLud3qjVNeP6WNbRtriCJVSIOVnUag/xAp8oErcxZnmTZ26a2ibITj0gpBQdg+pGiCEuR6t0kK0fAOOuQFPWhlfSZDHEEMrn18Gm2jb3QrD/t4+YvdD/bamo4OJUgslTOFX599k+YKkQOW/iHM7HqaYHPeXK6Lk5wQgsHD9z4uKOoUS1ZkR7UhBw7v2H6CGKxMrBEz17ydR5kKO1rJ+5TX/GYIvyQqgRl9gU+b84e2B/X13vL8/4w0Sq0OhmUGAUy2AqFISjfCDfs1YZgMPwUnj47duY3znFUqnO03fG8PaX72d4XtZBF0izfennWR4DAIo6Rz0Q880cGcUBm3m/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qynWMwvoRa3RT+zbTaUe45kvTCdXV+YUDoVSN7EQ7Mo=;
 b=glaSJoSx03dMXubGXvU/KEIyc41GKj0sV8CMmA78KkR1/xrOGBdJrEWaQOpe2fPqD0pedOixuxV8XvnvXvHEn8Rmnx2CY/E5SVr4qxDdeQeASLED5h238/vMa9AnsUnfUjtFquemhsP5y2gxf9SJ6uGyOpCANhk7DlxcmwEadblG4UxECTnlNbhu1dqsg2nRUy+jvvYcb0hdipOkF9DYR0rupqd6ZkBS17XEQC2R+v3keira5mPzWpKm/nDGVyCnQYn/+NVWRG9+mMs1CqSdPeFlXA9m2W4XbKIwLX0nt5c+YDrFh+QXzrLh53/x6vjGvMpM2V3lHcWv/mwV6aYTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qynWMwvoRa3RT+zbTaUe45kvTCdXV+YUDoVSN7EQ7Mo=;
 b=ZhikgCZveGmPi5CHNfSROlKUBuUc4VqR8s8NQjYf+RhOTsEzKw4Zdto+6GTAlsBd9cEz0mVPrJPZkcygf97CL4GtdUQBvplWBj3xYxHRzGh7vUhojUL1JCNvRbVdB2BcCryzs8j3PBJNQlNlLrKsSZrKqwMrL+n+aC/G3THoK58=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3947.eurprd08.prod.outlook.com (20.179.11.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Tue, 1 Oct 2019 14:27:19 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 14:27:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAADoACAAAP3AA==
Date: Tue, 1 Oct 2019 14:27:18 +0000
Message-ID: <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
In-Reply-To: <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0047.eurprd07.prod.outlook.com
 (2603:10a6:7:66::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001172716533
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04af019c-e42d-4eec-be9e-08d7467b770c
x-ms-traffictypediagnostic: DB8PR08MB3947:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR08MB39475844FA7D6F1903EA8189C19D0@DB8PR08MB3947.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39840400004)(366004)(376002)(136003)(189003)(199004)(71200400001)(14454004)(99286004)(8936002)(4326008)(66066001)(66556008)(54906003)(25786009)(110136005)(6246003)(5024004)(256004)(31686004)(31696002)(316002)(64756008)(66446008)(66476007)(3846002)(6116002)(2906002)(5660300002)(966005)(478600001)(66946007)(71190400001)(476003)(102836004)(11346002)(446003)(186003)(26005)(486006)(6436002)(7736002)(2616005)(36756003)(6486002)(305945005)(8676002)(229853002)(76176011)(6512007)(81166006)(6306002)(52116002)(86362001)(6506007)(386003)(53546011)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3947;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t++Q54nfP8Z6qg8zW3D3gDCWun0GDMd0ocPMgrjA1vgPy/C032rXANOOFXYWMpp4AsJece79a/wlKT6jOlZfg0tk7PH/y7/yZ+xlRLNNaWBr+gcHzrEfdtBlaEhXsygwDoWpnC5W82xrjjBVzZQzXHRnNLA870SOX9ax9uL/V0yuTPEI6gtPUPeT5e+EJkBYUrMFdCPr4Zko6CaJn4AU7VJm21apsv/f5/vHt7PR0c2S/lm6rhcG1NzPCi+/QsXRnaXZ8PdS10r7eIVjqnobTf9sk2p0Epbmi266MAHTVUMYAdVsJ+D1CIkcB0Q2FTHL/M9UbDEdHxFrgoySPxMGtDEcwMydLZjls0Adf63nspPP+FIwP4QmVTkr3ARErwIg2+YihEtwhnkmFyeCu2whljFGem8hkDBuutUtFsTNOAY4N+fIcLYAM/jAagLvGs5GnKmvI2s9HoKRnvp+WAeedQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8AA1A34BBFFD44A8A3696A1956573CD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04af019c-e42d-4eec-be9e-08d7467b770c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 14:27:18.9530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VczpABTnb8hHm91oJ6xrYTPUiqT7ktu0JGspSAzWML3PzHxsGawdXMOoJB7WGXquH30ffe93atq/FRKQ+z27G4qgWH84bTW9tQc9udLe+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3947
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::702
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxNzoxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4xMC4xOSAxNjowMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDAxLjEwLjIwMTkgMzowOSwg
Sm9obiBTbm93IHdyb3RlOg0KPj4+IEhpIGZvbGtzLCBJIGlkZW50aWZpZWQgYSBwcm9ibGVtIHdp
dGggdGhlIG1pZ3JhdGlvbiBjb2RlIHRoYXQgUmVkIEhhdCBRRQ0KPj4+IGZvdW5kIGFuZCB0aG91
Z2h0IHlvdSdkIGxpa2UgdG8gc2VlIGl0Og0KPj4+DQo+Pj4gaHR0cHM6Ly9idWd6aWxsYS5yZWRo
YXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNjUyNDI0I2MyMA0KPj4+DQo+Pj4gVmVyeSwgdmVyeSBi
cmllZmx5OiBkcml2ZS1taXJyb3IgaW5zZXJ0cyBhIGZpbHRlciBub2RlIHRoYXQgY2hhbmdlcyB3
aGF0DQo+Pj4gYmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZSgpIHJldHVybnMsIHdoaWNoIGNh
dXNlcyBhIG1pZ3JhdGlvbiBwcm9ibGVtLg0KPj4+DQo+Pj4NCj4+PiBJZ25vcmFudCBxdWVzdGlv
biAjMTogQ2FuIHdlIG11bHRpLXBhcmVudCB0aGUgZmlsdGVyIG5vZGUgYW5kDQo+Pj4gc291cmNl
LW5vZGU/IEl0IGxvb2tzIGxpa2UgYXQgdGhlIG1vbWVudCBib3RoIGNvbnNpZGVyIHRoZWlyIG9u
bHkgcGFyZW50DQo+Pj4gdG8gYmUgdGhlIGJsb2NrLWpvYiBhbmQgZG9uJ3QgaGF2ZSBhIGxpbmsg
YmFjayB0byB0aGVpciBwYXJlbnRzIG90aGVyd2lzZS4NCj4+Pg0KPj4+DQo+Pj4gT3RoZXJ3aXNl
OiBJIGhhdmUgYSBsb3Qgb2YgY2xvdWR5IGlkZWFzIG9uIGhvdyB0byBzb2x2ZSB0aGlzLCBidXQN
Cj4+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQgdGhlICJh
ZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+PiB0aGUgbm9kZSB0aGUgYml0bWFwIGlzIGF0dGFjaGVk
IHRvLCB3aGljaCB3b3VsZCBiZSB0aGUgbmFtZSBvZiB0aGUgZmlyc3QNCj4+PiBhbmNlc3RvciBu
b2RlIHRoYXQgaXNuJ3QgYSBmaWx0ZXIuIChPUiwgdGhlIG5hbWUgb2YgdGhlIGJsb2NrLWJhY2tl
bmQNCj4+PiBhYm92ZSB0aGF0IG5vZGUuKQ0KPj4NCj4+IE5vdCB0aGUgbmFtZSBvZiBhbmNlc3Rv
ciBub2RlLCBpdCB3aWxsIGJyZWFrIG1hcHBpbmc6IGl0IG11c3QgYmUgbmFtZSBvZiB0aGUNCj4+
IG5vZGUgaXRzZWxmIG9yIG5hbWUgb2YgcGFyZW50IChtYXkgYmUgdGhyb3VnaCBzZXZlcmFsIGZp
bHRlcnMpIGJsb2NrLWJhY2tlbmQNCj4+DQo+Pj4NCj4+PiBBIHNpbXBsZSB3YXkgdG8gZG8gdGhp
cyBtaWdodCBiZSBhICJjaGlsZF91bmZpbHRlcmVkIiBCZHJ2Q2hpbGQgcm9sZQ0KPj4+IHRoYXQg
c2ltcGx5IGJ5cGFzc2VzIHRoZSBmaWx0ZXIgdGhhdCB3YXMgaW5zZXJ0ZWQgYW5kIHNlcnZlcyBu
byByZWFsDQo+Pj4gcHVycG9zZSBvdGhlciB0aGFuIHRvIGFsbG93IHRoZSBjaGlsZCB0byBoYXZl
IGEgcGFyZW50IGxpbmsgYW5kIGZpbmQgd2hvDQo+Pj4gaXQncyAiIiJyZWFsIiIiIHBhcmVudCBp
cy4NCj4+Pg0KPj4+IEJlY2F1c2Ugb2YgZmx1c2hpbmcsIHJlb3Blbiwgc3luYywgZHJhaW4gJmMg
JmMgJmMgSSdtIG5vdCBzdXJlIGhvdw0KPj4+IGZlYXNpYmxlIHRoaXMgcXVpY2sgaWRlYSBtaWdo
dCBiZSwgdGhvdWdoLg0KPj4+DQo+Pj4NCj4+PiAtIENvcm9sbGFyeSBmaXggIzE6IGNhbGwgZXJy
b3Jfc2V0ZyBpZiB0aGUgYml0bWFwIG5vZGUgbmFtZSB0aGF0J3MgYWJvdXQNCj4+PiB0byBnbyBv
dmVyIHRoZSB3aXJlIGlzIGFuIGF1dG9nZW5lcmF0ZWQgbm9kZTogdGhpcyBpcyBuZXZlciBjb3Jy
ZWN0IQ0KPj4+DQo+Pj4gKFdoeSBub3Q/IGJlY2F1c2UgdGhlIHRhcmdldCBpcyBpbmNhcGFibGUg
b2YgbWF0Y2hpbmcgdGhlIG5vZGUtbmFtZQ0KPj4+IGJlY2F1c2UgdGhleSBhcmUgcmFuZG9tbHkg
Z2VuZXJhdGVkIEFORCB5b3UgY2Fubm90IHNwZWNpZnkgbm9kZS1uYW1lcw0KPj4+IHdpdGggIyBw
cmVmaXhlcyBhcyB0aGV5IGFyZSBlc3BlY2lhbGx5IHJlc2VydmVkIQ0KPj4+DQo+Pj4gKFRoaXMg
cmFpc2VzIGEgcmVsYXRlZCBwcm9ibGVtOiBpZiB5b3UgZXhwbGljaXRseSBhZGQgYml0bWFwcyB0
byBub2Rlcw0KPj4+IHdpdGggYXV0b2dlbmVyYXRlZCBuYW1lcywgeW91IHdpbGwgYmUgdW5hYmxl
IHRvIG1pZ3JhdGUgdGhlbS4pKQ0KPj4+DQo+Pj4gLS1qcw0KPj4+DQo+Pg0KPj4gV2hhdCBhYm91
dCB0aGUgZm9sbG93aW5nOg0KPj4NCj4+IGRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0K
Pj4gaW5kZXggNTk0NDEyNDg0NS4uNjczOWMxOWJlOSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrLmMN
Cj4+ICsrKyBiL2Jsb2NrLmMNCj4+IEBAIC0xMDA5LDggKzEwMDksMjAgQEAgc3RhdGljIHZvaWQg
YmRydl9pbmhlcml0ZWRfb3B0aW9ucyhpbnQgKmNoaWxkX2ZsYWdzLCBRRGljdCAqY2hpbGRfb3B0
aW9ucywNCj4+ICAgICAgICAqY2hpbGRfZmxhZ3MgPSBmbGFnczsNCj4+ICAgIH0NCj4+DQo+PiAr
c3RhdGljIGNvbnN0IGNoYXIgKmJkcnZfY2hpbGRfZ2V0X25hbWUoQmRydkNoaWxkICpjaGlsZCkN
Cj4+ICt7DQo+PiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKnBhcmVudCA9IGNoaWxkLT5vcGFxdWU7
DQo+PiArDQo+PiArICAgIGlmIChwYXJlbnQtPmRydiAmJiBwYXJlbnQtPmRydi0+aXNfZmlsdGVy
KSB7DQo+PiArICAgICAgICByZXR1cm4gYmRydl9nZXRfcGFyZW50X25hbWUocGFyZW50KTsNCj4+
ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gTlVMTDsNCj4+ICt9DQo+PiArDQo+IA0KPiBX
aHkgd291bGQgd2Ugc2tpcCBmaWx0ZXJzIGV4cGxpY2l0bHkgYWRkZWQgYnkgdGhlIHVzZXI/DQo+
IA0KDQpXaHkgbm90PyBPdGhlcndpc2UgbWlncmF0aW9uIG9mIGJpdG1hcHMgd2lsbCBub3Qgd29y
azogd2UgbWF5IGhhdmUgZGlmZmVyZW50IHNldA0Kb2YgZmlsdGVycyBvbiBzb3VyY2UgYW5kIGRl
c3RpbmF0aW9uLCBhbmQgd2Ugc3RpbGwgc2hvdWxkIG1hcCBub2RlcyB3aXRoIGJpdG1hcHMNCmF1
dG9tYXRpY2FsbHkuDQoNCkkgbGlrZSBKb2huJ3MgaWRlYSBvZiBleHBsaWNpdGx5IGRlZmluZWQg
bm9kZSBtYXBwaW5nLCBidXQgbm93IHdlIG5lZWQgc2ltcGxlciBmaXgsDQpub3QgaW52b2x2aW5n
IGxpYnZpcnQgY2hhbmdlcyBpZiBwb3NzaWJsZS4NCg0KSG1tLCBvciB5b3UgbWVhbiB0aGF0IGJ5
IHRoaXMgcGF0Y2ggSSB0b3VjaCBub3Qgb25seSBtaWdyYXRpb24gYnV0IGFsbCB1c2VycyBvZg0K
YmRydl9nZXRfZGV2aWNlX29yX25vZGVfbmFtZT8gVGhhbiBJIGNhbid0IHByZWRpY3QgYWxsIHRo
ZSBjb25zZXF1ZW5jZXMuLi4NCg0KSXMgaXQgYmV0dGVyIHRvIGFkZCAuZ2V0X25hbWVfZm9yX2Jp
dG1hcHNfbWlncmF0aW9uIGhhbmRsZXIgKHdpdGggc2ltcGxlciBuYW1lIG9mIGNvdXJzZSk/DQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


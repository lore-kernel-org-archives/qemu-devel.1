Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134F6CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C6A2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="N/hHqoCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C6A2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQaBd-0003u7-Vz
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQaAj-0003BG-SP
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iQaAi-0007kF-78
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:53:13 -0400
Received: from mail-eopbgr50125.outbound.protection.outlook.com
 ([40.107.5.125]:65253 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iQaAh-0007gL-KI; Fri, 01 Nov 2019 12:53:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUbLWCtsZKZmgw3JJk3Q2Va4OKQNUm/xs927rKgjc7XedRAF+3jvgeQ8k1L16G4uYPoeahpavuXLAx2H9xJZfiqgN9f8Yc0P67JBh9WFmt5tSIbu8FDC5/oEMXNpZ+dZF2hDkcNz2+Vpb2MfEZo8ueJSdVRizmsUWn/hewRv96qbKMVNEW9/JWKOQ3mH+NDdT5A8HIQZ7stY1vzoBzWJxLbG+LqxwzT6q9RHqMrL/dRseaERqgk1YfVK3ZGZf54vSVQNz3OqWePuQyLAODIEUcmPRtapFwGXxBvinrUvMSmvECSkagYU7lDjLh8B7ZuTzj0pnWKggzL8ROe/G9opMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpNYH/n09XDDVVVQMtwavB39AVHSYCWCMobo2c9TtMM=;
 b=hUIDpoJ+OZMJRQTfyTCjIU8C9SWqtiKwpx26yKVeqbduk+0k4255ABEYBtKb+t+6Rz4FpacE64DrZ8GCltXjtk+HLnRRkk2BebbdDJeRgBpxSFk0iAIrIOiKfJGSLIhfq4D1ZwnPecqzHzyDHLSugAvsE1xd1GcDw6+airWEQomwIKRB93G3JtAu1PcH3kgARPW9/5DWZvYYw04D4V/ky+4FY3Thb+P+h5w/BDMSKRawaxs/Dn7UGybboYotL43xuIyDcn2ak/gT5pzJYEdZq/QH3yIpM24VKAKVcLigOQgOyCQ0ZHftil455iNTlcQfPxV1+1aiQlWXJ9+Wqq9aBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpNYH/n09XDDVVVQMtwavB39AVHSYCWCMobo2c9TtMM=;
 b=N/hHqoCnaQ3Z7Q0H9ky4RrSyQtbQKdc6vVy/mD3CMslixP9ri7BJMm4c8/+J9qmmz9+2SygHiLrKNYhn2pnYgbzIs8yYT7O0nFM3s8rVN/yNxSxt19xSxhFmYohkhHCeKcxwgukqKvz3G0Hy9b2luLpFVtmCfgtzV+PkHuQF8Oc=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3236.eurprd08.prod.outlook.com (52.134.91.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 1 Nov 2019 16:53:09 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2408.019; Fri, 1 Nov 2019
 16:53:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Subject: Re: bitmaps -- copying allocation status into dirty bitmaps
Thread-Topic: bitmaps -- copying allocation status into dirty bitmaps
Thread-Index: AQHVkMsD74l2GkYcp0KjyQwNU60SGad2iBQA
Date: Fri, 1 Nov 2019 16:53:08 +0000
Message-ID: <65e58f06-583c-e62d-3877-a37e01dc50b6@virtuozzo.com>
References: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
In-Reply-To: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0191.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::15) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191101195306744
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96aa8cde-43b6-407d-0e74-08d75eebf92b
x-ms-traffictypediagnostic: AM0PR08MB3236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3236259812F9B9E4AC674A88C1620@AM0PR08MB3236.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(39850400004)(136003)(366004)(396003)(189003)(199004)(99286004)(66946007)(486006)(31686004)(31696002)(8936002)(2616005)(110136005)(86362001)(54906003)(6486002)(52116002)(6246003)(6506007)(76176011)(81156014)(386003)(476003)(446003)(8676002)(4326008)(2906002)(5660300002)(11346002)(66446008)(66476007)(64756008)(66556008)(14444005)(6512007)(26005)(81166006)(316002)(14454004)(25786009)(36756003)(229853002)(102836004)(7736002)(478600001)(6436002)(305945005)(71200400001)(3846002)(66066001)(6116002)(71190400001)(256004)(186003)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3236;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0MGOTHSbwlHitARMdB8xLm9dWTDBxBLhSTUPggbIR+i6VmhCpSuBhG+qH6cPQXYu65EXMPYr0Rtf0cdY3fx7DoNq58/7ZgKyh69sT8FWKDFpU3OaTBaI0HNG3n8oDfhhqG5a9/sTZ1xu4Rl8jsNEcBapUE0bCIptlvaiOw8yLQOEXwicx8lErtS3UN+V8lPyvL5rv56mzxsWbJXf1b/T5hL1gbnzDJb4rYtfmYa7VHVjF/u5BfvzEHNWvgFtugmbrsH1dV/Ugde+DS7pGsD1WomzNdN2I6OPL7amUqs80UX3eKrhxzbJKuPqCHsuowVtlps69l6D2cDwjImvHBdxMh2v3KDSYs4kgzkukXp6TWr/34fCaTf9hQexEPnCWg//7aBbxD/PXlUYoCBPt/gOERtd0c8ftNQQ/DqW3Lu//KiixelukpjIGu9CNG7JdKE
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DF22CB5DC48DC4588E176C727EE0053@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96aa8cde-43b6-407d-0e74-08d75eebf92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 16:53:08.8357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aR7i/WOLJE/EP3ymDc3//5ZuIj+tA3beZdr6OTclUvSmDIt44ssOfB84bdoJrHXFm+QbURdRKLiwkgTCQotAlHkL9osYn0jNgcg8/udwXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3236
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.125
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTEuMjAxOSAxODo0MiwgSm9obiBTbm93IHdyb3RlOg0KPiBIaSwgaW4gb25lIG9mIG15IGlu
ZmFtb3VzbHkgdW5yZWFkYWJsZSBhbmQgbG9uZyBzdGF0dXMgZW1haWxzLCBJDQo+IG1lbnRpb25l
ZCBwb3NzaWJseSB3YW50aW5nIHRvIGNvcHkgYWxsb2NhdGlvbiBkYXRhIGludG8gYml0bWFwcyBh
cyBhIHdheQ0KPiB0byBlbmFibGUgdXNlcnMgdG8gY3JlYXRlIChleHRlcm5hbCkgc25hcHNob3Rz
IGZyb20gb3V0c2lkZSBvZiB0aGUNCj4gbGlidmlydC9xZW11IGNvbnRleHQuDQo+IA0KPiAoVGhh
dCBpczogdG8gcmVwYWlyIGNoZWNrcG9pbnRzIGluIGxpYnZpcnQgYWZ0ZXIgYSB1c2VyIGV4dGVu
ZGVkIHRoZQ0KPiBiYWNraW5nIGNoYWluIHRoZW1zZWx2ZXMsIHlvdSB3YW50IHRvIHJlc3RvcmUg
Yml0bWFwIGluZm9ybWF0aW9uIGZvcg0KPiB0aGF0IG5vZGUuIENvbnZlbmllbnRseSwgdGhpcyBp
bmZvcm1hdGlvbiBJUyB0aGUgYWxsb2NhdGlvbiBtYXAsIHNvIHdlDQo+IGNhbiBkbyB0aGlzLikN
Cj4gDQo+IEl0IGNhbWUgdXAgYXQgS1ZNIEZvcnVtIHRoYXQgd2UgcHJvYmFibHkgZG8gd2FudCB0
aGlzLCBiZWNhdXNlIG9WaXJ0DQo+IGxpa2VzIHRoZSBpZGVhIG9mIGJlaW5nIGFibGUgdG8gbWFu
aXB1bGF0ZSB0aGVzZSBjaGFpbnMgZnJvbSBvdXRzaWRlIG9mDQo+IGxpYnZpcnQvcWVtdS4NCj4g
DQo+IERlbmlzIHN1Z2dlc3RlZCB0aGF0IGluc3RlYWQgb2YgYSBuZXcgY29tbWFuZCwgd2UgY2Fu
IGNyZWF0ZSBhIHNwZWNpYWwNCj4gbmFtZSAtLSBtYXliZSAiI0FMTE9DQVRFRCIgb3Igc29tZXRo
aW5nIHNpbWlsYXIgdGhhdCBjYW4gbmV2ZXIgYmUNCj4gYWxsb2NhdGVkIGFzIGEgdXNlci1kZWZp
bmVkIGJpdG1hcCBuYW1lIC0tIGFzIGEgc3BlY2lhbCBzb3VyY2UgZm9yIHRoZQ0KPiBtZXJnZSBj
b21tYW5kLg0KPiANCj4gWW91J2QgaXNzdWUgYSBtZXJnZSBmcm9tICIjQUxMT0NBVEVEIiB0byAi
bXlCaXRtYXAwIiB0byBjb3B5IHRoZSBjdXJyZW50DQo+IGFsbG9jYXRpb24gZGF0YSBpbnRvICJt
eUJpdG1hcDAiLCBmb3IgaW5zdGFuY2UuDQoNCkkgY2FuIHN1Z2dlc3QgYWxzbyB0aGUgZm9sbG93
aW5nOg0KDQpXZSBub3cgaGF2ZQ0KDQogICB7ICdhbHRlcm5hdGUnOiAnQmxvY2tEaXJ0eUJpdG1h
cE1lcmdlU291cmNlJywNCiAgICAgJ2RhdGEnOiB7ICdsb2NhbCc6ICdzdHInLA0KICAgICAgICAg
ICAgICAgJ2V4dGVybmFsJzogJ0Jsb2NrRGlydHlCaXRtYXAnIH0gfQ0KDQpXZSBtYXkgYWRkIHNl
cGFyYXRlIHFhcHkgZW51bQ0KDQpCbG9ja1N0YXR1c0JpdG1hcFR5cGUgPSB7J2FsbG9jYXRlZCcs
IC4uLn0NCg0KYW5kIHN0cnVjdA0KDQpCbG9ja1N0YXR1c0JpdG1hcCA9IHsnbm9kZSc6ICdzdHIn
LCAndHlwZSc6IEJsb2NrU3RhdHVzQml0bWFwVHlwZX0NCg0KYW5kIHRoZW4gZXh0ZW5kIEJsb2Nr
RGlydHlCaXRtYXBNZXJnZVNvdXJjZSBsaWtlDQoNCiAgIHsgJ2FsdGVybmF0ZSc6ICdCbG9ja0Rp
cnR5Qml0bWFwTWVyZ2VTb3VyY2UnLA0KICAgICAnZGF0YSc6IHsgJ2xvY2FsJzogJ3N0cicsDQog
ICAgICAgICAgICAgICAnZXh0ZXJuYWwnOiAnQmxvY2tEaXJ0eUJpdG1hcCcsDQogICAgICAgICAg
ICAgICAnc3RhdHVzJzogJ0Jsb2NrU3RhdHVzQml0bWFwJyB9IH0NCg0KU28sIHdlIGNhbiBhdm9p
ZCBzcGVjaWFsIG5hbWUgIiNBTExPQ0FURUQiLCB3aGljaCB3ZSdsbCBoYXZlIHRvIGRlZmluZQ0K
aW4gcWNvdzIgc3BlYyBhbmQgbmJkIHNwZWMuDQoNCj4gDQo+IFNvbWUgdGhvdWdodHM6DQo+IA0K
PiAtIFRoZSBvbmx5IGNvbW1hbmRzIHdoZXJlIHRoaXMgcHNldWRvLWJpdG1hcCBtYWtlcyBzZW5z
ZSBpcyBtZXJnZS4NCj4gZW5hYmxlL2Rpc2FibGUvcmVtb3ZlL2NsZWFyL2FkZCBkb24ndCBtYWtl
IHNlbnNlIGhlcmUuDQo+IA0KPiAtIFRoaXMgcHNldWRvIGJpdG1hcCBtaWdodCBtYWtlIHNlbnNl
IGZvciBiYWNrdXAsIGJ1dCBpdCdzIG5vdCBuZWVkZWQ7DQo+IHlvdSBjYW4ganVzdCBtZXJnZSBp
bnRvIGFuIGVtcHR5L2VuYWJsZWQgYml0bWFwIGFuZCB0aGVuIHVzZSB0aGF0Lg0KPiANCj4gLSBD
cmVhdGluZyBhbiBhbGxvY2F0aW9uIGJpdG1hcCBvbi10aGUtZmx5IGlzIHByb2JhYmx5IG5vdCBw
b3NzaWJsZQ0KPiBkaXJlY3RseSBpbiB0aGUgbWVyZ2UgY29tbWFuZCwgYmVjYXVzZSB0aGUgZGlz
ayBzdGF0dXMgY2FsbHMgbWlnaHQgdGFrZQ0KPiB0b28gbG9uZy4uLg0KPiANCj4gSG0sIGFjdHVh
bGx5LCBJJ20gbm90IHN1cmUgaG93IHRvIHNvbHZlIHRoYXQgb25lLiBNZXJnZSB3b3VsZCBuZWVk
IHRvDQo+IGJlY29tZSBhIGpvYiAob3IgYW4gYXN5bmMgUU1QIGNvbW1hbmQ/KSBvciB3ZSdkIG5l
ZWQgdG8ga2VlcCBhbg0KPiBhbGxvY2F0aW9uIGJpdG1hcCBvYmplY3QgYXJvdW5kIGFuZCBpbi1z
eW5jLiBJIGRvbid0IHJlYWxseSB3YW50IHRvIGRvDQo+IGVpdGhlciwgc28gbWF5YmUgSSdtIG1p
c3NpbmcgYW4gb2J2aW91cy9iZXR0ZXIgc29sdXRpb24uDQo+IA0KPiBBbHNvLCB3aXRoIHJlZ2Fy
ZHMgdG8gaW50cm9zcGVjdGlvbiwgaWYgd2UgZG8gY3JlYXRlIGEgc3BlY2lhbCByZXNlcnZlZA0K
PiBuYW1lIGxpa2UgI0FMTE9DQVRFRCwgd2UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGlzIGlz
IGF2YWlsYWJsZSBhbmQNCj4gb2J2aW91cyB2aWEgdGhlIFFBUEkgc2NoZW1hLg0KPiANCj4gLS1q
cw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04726C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 05:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3321217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 05:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kIbHU+pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3321217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKFe4-0001YL-QH
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 01:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKFdB-0000yc-JP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 01:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iKFd9-0000KW-Ss
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 01:44:25 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
 ([40.107.1.110]:49415 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iKFd7-0000Jp-Sx; Tue, 15 Oct 2019 01:44:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IghHNVjN0RrVUaIvNbJMa9PSqAHphqwo7jRXfZoeMyDz0Lk0LWrCkxxKrCfnhumpKEbKqIsko6dSXmaOf3u2Ocy+8RFCshWN5aKCphxLpU+MwBizMsZKaj578JZHg5YnhG6BT/mzfg8VpMCmodhKRZLAZv11/Ku2UXxAn1fd5rDXKPkZSzjpxRBIyLahlSM+d0Vf8m85Q/tih+yJ+r7BphL/WL3Wd6g6N+qkwQYQheNxBKU0CnYvByq+zczBfIP4DWzfooFT5ugpIqXOl16qjER8VHv8cx2hYF2gE/kBpKRqGyqVhTn1lAkaCyOAvTxgiHNVXJmaM5CTkE7r6hzmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkGfs1tUHYOfxQrmGDniSS+4b01AK9ZvJslU6pHYzoE=;
 b=FDID8F7/7UFp/J+jajlmIuyLFk8H7vUGyp6BZx5s3XjGjX0cC6emwSiRnAkpqxQNAcGeAuKLwGkCVlSnBqbaTOLTkBuxqcfmy0v0krwrWc3G2JIXq0VGfGstiN3TElPnBcA5+BB0eIMLFOw5Q8fRYOCZWrYd46BBE9zXSi0hsLvcJgW/QabkNR/JMYeTMV8vA8B6932eBJykoFqU0auzO/ulFh3IXK2Dre8V6mE3cu8ZCtTwpJsnae5wI7eKMWHgJRPsgiXR+n8qdzUtG5ksaGxw24uVl32Ob/kwEYtf2L7C+OcvrP7AAqiHH8FFZzltm0bavDGi4fIn47yUFZheMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkGfs1tUHYOfxQrmGDniSS+4b01AK9ZvJslU6pHYzoE=;
 b=kIbHU+pwURVW9fSjRjOd4Q4qdkSuTtA6ZxVFAgE5vFAiSa6USElFbbMgC+kjrtyVk7EwUEjkDuNjIpPNavQRVyeEa/IjOU0n1NVgQwH+fa4tz1Mh5KY05pITzmcJpOHbYXLbJQSvC+mBAFx9NeFHUTrf3vn8xDFjmmT5yxaTk3c=
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com (10.170.220.33) by
 DB6PR08MB2917.eurprd08.prod.outlook.com (10.175.235.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Tue, 15 Oct 2019 05:44:18 +0000
Received: from DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::f8d8:53c7:ba52:ad42]) by DB6PR08MB2757.eurprd08.prod.outlook.com
 ([fe80::f8d8:53c7:ba52:ad42%5]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 05:44:18 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 0/7] iotests: Selfish patches
Thread-Topic: [PATCH v4 0/7] iotests: Selfish patches
Thread-Index: AQHVbTkcosH3oMFdlEKptIxctOGwRKdaZXwAgAD3OoA=
Date: Tue, 15 Oct 2019 05:44:17 +0000
Message-ID: <9f3104c6-f5e4-7cdc-7d71-259bed86e028@virtuozzo.com>
References: <20190917092004.999-1-mreitz@redhat.com>
 <80224b65-9741-befb-7a3e-fbc44746efee@redhat.com>
In-Reply-To: <80224b65-9741-befb-7a3e-fbc44746efee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0210.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::34) To DB6PR08MB2757.eurprd08.prod.outlook.com
 (2603:10a6:6:18::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238a4a4e-4506-47dc-b8bc-08d75132b851
x-ms-traffictypediagnostic: DB6PR08MB2917:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB6PR08MB2917727C80B185822F26D1F5F4930@DB6PR08MB2917.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(376002)(366004)(51914003)(199004)(55674003)(189003)(54906003)(110136005)(36756003)(305945005)(256004)(2501003)(31696002)(86362001)(102836004)(31686004)(7736002)(26005)(25786009)(229853002)(8676002)(81156014)(81166006)(6246003)(8936002)(186003)(5660300002)(52116002)(6436002)(6306002)(6512007)(66066001)(386003)(6506007)(2906002)(71200400001)(76176011)(476003)(71190400001)(508600001)(99286004)(6486002)(966005)(53546011)(446003)(2616005)(11346002)(44832011)(4326008)(66446008)(3846002)(6116002)(14454004)(66946007)(66476007)(486006)(66556008)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR08MB2917;
 H:DB6PR08MB2757.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWM7cs/M5L9MHcXnhL7qktNjOV9Yl/pa8VXaoyGyv6zyPcL68fc1R9SSXfjMydrzRT8nktSyv3UECSRc3gM2GvEkGBN5WO5Y0VCTDRMOSpxKxjGLfQcCi7eAnMHs+lgGWjSwhWtj/LBjjdmuKaqA1+8lPaPMTkWvMlt0WtyyBx39H6GtGhu3M/+GK2pea/1l9x7lZzNWkGjhTQPFCQxtugSb/40wafgFD2RoLiNxkIiDsbhw3hg7qA+8vG3fN0fKK6UyudxhFbaq3DuMztVKAY+hTL/fQwnX7bgNMdi7KZDz0vIzc45H60z4bfcEDwYYKktOzPdVPawvqEXh2/S1k4Hk/b/WYG9jVXEQyubS7ZDQ1Ss6goIe+RmDlUC4JKHIUjkwWw/2ZJfpbzpxBaZZoKz5DQKp5OXCRc9LR+KO1Dei5DUVCz9VSDJ3/arCQeUQBvT0HsNw0yvneQW8uDpPSg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <960A8AEDD4EB194FB6D13C3FFD96F61D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238a4a4e-4506-47dc-b8bc-08d75132b851
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 05:44:17.9872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7o4i+YcVAqf2w3pmg4GGfYKEIm5+o1QQNeA8YzxFK8T+xP2bBa3C4m9DXTUga1KzEYL0bi5yxph2J5/qsGDqm69kMEU5Yr+ljJMKR1s7VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2917
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.110
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

DQoNCk9uIDE0LzEwLzIwMTkgMTc6NTksIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMTcuMDkuMTkg
MTE6MTksIE1heCBSZWl0eiB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IEFnYWluLCBsZXQgbWUgc3Rh
cnQgd2l0aCBhIGxpbmsgdG8gYW4gYWN0dWFsbHkgZXhwbGFuYXRvcnkgY292ZXIgbGV0dGVyOg0K
Pj4gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWJsb2NrLzIwMTkt
MDYvbXNnMDExMDIuaHRtbA0KPj4NCj4+IHYzOg0KPj4gaHR0cHM6Ly9saXN0cy5ub25nbnUub3Jn
L2FyY2hpdmUvaHRtbC9xZW11LWJsb2NrLzIwMTktMDgvbXNnMDA5NTAuaHRtbA0KPj4NCj4+IHY0
Og0KPj4gLSBJIG1lcmdlZCB0aGUgb2xkIHBhdGNoIDEgaW4gdGhlIG1lYW50aW1lDQo+Pg0KPj4g
LSBQYXRjaCAyOiBBZGp1c3RlZCB0aGUgY29tbWVudCB0byBtYWtlIGl0IG1vcmUgY2xlYXIgdGhh
dCBpdCBpcw0KPj4gICAgICAgICAgICAgY2FzZV9ub3RydW4oKSBpdHNlbGYgdGhhdCB3aWxsIG5v
dCBza2lwIHRoZSB0ZXN0IGNhc2UsIGFzDQo+PiAgICAgICAgICAgICByZXF1ZXN0ZWQgYnkgQW5k
cmV5IChJIGhvcGUgaXQgZml0cyB3aGF0IGhlIGhhZCBpbiBtaW5kLCBtb3JlDQo+PiAgICAgICAg
ICAgICBvciBsZXNzKTsga2VwdCB0aGUgUi1icywgYmVjYXVzZSBJIHNvbWVob3cgZmVlbCBsaWtl
IHRoYXTigJlzDQo+PiAgICAgICAgICAgICB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gaGVyZS4NCj4+
DQo+PiAtIFBhdGNoIDM6IFRoZSBmdW5jX3dyYXBwZXIgcmV0dXJuZWQgYnkgdGhlIHNraXBfdGVz
dF9kZWNvcmF0b3IgaGFzIGENCj4+ICAgICAgICAgICAgIG1hbmRhdG9yeSBhcmd1bWVudDsgbWFr
ZSB0aGF0IGFuZCBpdHMgcmVxdWlyZWQgdHlwZSBleHBsaWNpdA0KPj4gICAgICAgICAgICAgKHdp
dGggYW4gYW5ub3RhdGlvbiksIGFzIHN1Z2dlc3RlZCBieSBKb2huDQo+PiAgICAgICAgICAgICAo
S2V2aW4gbWFkZSBtZSBhd2FyZSBvZiB0aGUgZmFjdCB0aGF0IGFubm90YXRpb25zIGV4aXN0IHNp
bmNlDQo+PiAgICAgICAgICAgICBQeXRob24gMy4wLCBpdOKAmXMganVzdCB0aGF0IHRoZXkgZGlk
buKAmXQgbWVhbiBhbnl0aGluZyBiYWNrDQo+PiAgICAgICAgICAgICB0aGVuIChuZWl0aGVyIGRv
IHRoZXkgcmVhbGx5IG5vdywgYnV0IHdoYXRldmVyLCBpdOKAmXMgYmV0dGVyDQo+PiAgICAgICAg
ICAgICB0aGFuIGEgY29tbWVudCkpDQo+Pg0KPj4gLSBQYXRjaCA0OiBSZXNvbHZlZCBhIGNvbmZs
aWN0IGJlY2F1c2Ugb2YgdGhlIGNoYW5nZSB0byBwYXRjaCAzDQo+IA0KPiBUaGFua3MgZm9yIHRo
ZSByZXZpZXdzLCBhcHBsaWVkIHRvIG15IGJsb2NrIGJyYW5jaDoNCj4gDQo+IGh0dHBzOi8vZ2l0
LnhhbmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jaw0KPiANCj4gTWF4
DQo+IA0KDQpHb29kDQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2
aWNoDQoNCg==


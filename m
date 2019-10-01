Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E1C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CD320659
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TE747sfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CD320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLLs-0006t5-JX
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKXC-0004lJ-MV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKX9-0001AW-KH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:57:54 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com
 ([40.107.8.111]:57791 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKX8-00019L-TX; Tue, 01 Oct 2019 11:57:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUcMufqPFM4pFoihvEP21Mxy3fLYR3ZfeimLekjiGu6LcmP/NB6It2WPWAdhxmi3Dvs4PoLfmei3ATZI/xPVJ9CqvX5DoK6CYIPsiAInhNvD90vnH0mybfoZ/iuVQhaf3LaduksYl/8HrQyiDqggv0IDTXaXqYNfJBrwMektj9oFNxy5+/Z1zPhgwBaG8T+PKvHI7DNtYorYaP/1yDxhzSHTDDd0EVm9GKyQ1N7OTh75/85YdnHtMP6bDKZgLhAO2BpJX2dzNh5uTUQk6qyH8hhWQ745OROfB4g3OUIj/jBYUWVvwD0K4VfKujLcyaQW50LSw6AugwYqscdpFU/22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH9wmfOZV+aMObncDtDedcgW6ZRLp+UBIZbzFbJIPHo=;
 b=Nrp4sNhQqk10hYUknwrKC+covAcjXp3U6fAtO/uM+fff11WrGMqiMUsBROKE7ntuSM5tyvHRCFR35qv9pox6Myr1bNSct88gmf9T58JXQS2tOpgy/pxPogyrhC0ZNtTe9/dZlMfr1Iug+JT1r6dgyadQPQPO2UzECwvNtxVxCTlGfs4jghAOtB+g0g3QUE7iDaeEdDdZd7sVRhziFDMZb6Z1e9R3os1YDPkSO2RSpbbMDd1I0vL5jk/PKrBhad+zq+SRtAnYKVWUlmkWn3HW0qRJLZDIrhEoPqRxvurfo3iAkY36LGgfZTcML3YX+9APq9vZwndBL+MiDuKBxmoAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KH9wmfOZV+aMObncDtDedcgW6ZRLp+UBIZbzFbJIPHo=;
 b=TE747sfKwH/Rdtl3sYbiEEDhblSecPirGIY2nX30yFWN1YK1kHt4sB7TJu9LCBBzS2si8hZJQtwzPOyeVl0tfKKfsNMFd2btPAsTU7DnHC7IyvkSRnQpi+RXHdn0K+tAs3StgwB/IMbpZlm1py3Bt5jS31ITPlcvKzynWeAQW0M=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5340.eurprd08.prod.outlook.com (52.133.240.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 1 Oct 2019 15:57:48 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 15:57:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Thread-Topic: bitmap migration bug with -drive while block mirror runs
Thread-Index: AQHVd+yDiWNDoVbdB0u/++2NVEJq8qdF0TUAgAAC+ICAAB3ngA==
Date: Tue, 1 Oct 2019 15:57:48 +0000
Message-ID: <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
In-Reply-To: <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0090.eurprd07.prod.outlook.com
 (2603:10a6:3:64::34) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191001185745608
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8358a65-f434-4702-1abe-08d746881b24
x-ms-traffictypediagnostic: DB8PR08MB5340:
x-microsoft-antispam-prvs: <DB8PR08MB534053E4B1B4F409F16D1C3AC19D0@DB8PR08MB5340.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(346002)(136003)(376002)(189003)(199004)(54906003)(6116002)(6506007)(53546011)(7736002)(36756003)(6486002)(229853002)(71200400001)(386003)(2906002)(71190400001)(14454004)(6246003)(102836004)(31696002)(26005)(186003)(6916009)(86362001)(66446008)(64756008)(99286004)(5024004)(52116002)(256004)(486006)(66476007)(8936002)(476003)(3846002)(66556008)(31686004)(76176011)(478600001)(446003)(81156014)(81166006)(6512007)(316002)(11346002)(25786009)(2616005)(4326008)(305945005)(5660300002)(66066001)(6436002)(66946007)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5340;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUhesy7bVZsF532ttV2MEIPsMP9PvpBcXopdSfyhjvMk+A+07QaZS9em/5W5pnQu/SUgS44aeAmzYtuNCPAY0lRbphRs7UUz7iLl5TPFDKOw9bm4msxlR3ctrV+Lv5ADVnf/k6UQAO8A2V9EcPdOSUuvWVJMAsDwkwOpp/KArDxKgoooHwV6OB/xeCS/KUTDG+F1OmBRFzJJWK2QjdQDiNeLTMVuAgLGhhaouVC73SEp0Md6kcSgJ8pd3HFrn/zXlnqkUYGeKVQt5DKCXqjwnavzyLW+UEZY9Z/5FOuUHUknQeeHtj6VYKQSj+c46SpZJ0HkVRTLLLIPzGcR64bvVyGh0cskHVNZHztVCsoq7fb8jo/qeC9jXfHN3NJpzp9zM36iT/WXtIatns6c0garhXM6QttUGaxCaFdrmIlpJXs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C91005392FBCF5408B7187508210DC1B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8358a65-f434-4702-1abe-08d746881b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 15:57:48.2323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9cuFsKvgbLGmR7q+8znvRKVMr6S3qngFtHYxGkw0pSJTKqYEQzi18Gp+Dye1HseHToU+Zz24WmXfu88QMxhRM5ctXKfq81eAr/bHTfl5H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5340
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.111
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
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMTAuMjAxOSAxNzoxMCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDEwLzEvMTkg
MTA6MDAgQU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gT3RoZXJ3
aXNlOiBJIGhhdmUgYSBsb3Qgb2YgY2xvdWR5IGlkZWFzIG9uIGhvdyB0byBzb2x2ZSB0aGlzLCBi
dXQNCj4+PiB1bHRpbWF0ZWx5IHdoYXQgd2Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGZpbmQgdGhl
ICJhZGRyZXNzYWJsZSIgbmFtZSBmb3INCj4+PiB0aGUgbm9kZSB0aGUgYml0bWFwIGlzIGF0dGFj
aGVkIHRvLCB3aGljaCB3b3VsZCBiZSB0aGUgbmFtZSBvZiB0aGUgZmlyc3QNCj4+PiBhbmNlc3Rv
ciBub2RlIHRoYXQgaXNuJ3QgYSBmaWx0ZXIuIChPUiwgdGhlIG5hbWUgb2YgdGhlIGJsb2NrLWJh
Y2tlbmQNCj4+PiBhYm92ZSB0aGF0IG5vZGUuKQ0KPj4gTm90IHRoZSBuYW1lIG9mIGFuY2VzdG9y
IG5vZGUsIGl0IHdpbGwgYnJlYWsgbWFwcGluZzogaXQgbXVzdCBiZSBuYW1lIG9mIHRoZQ0KPj4g
bm9kZSBpdHNlbGYgb3IgbmFtZSBvZiBwYXJlbnQgKG1heSBiZSB0aHJvdWdoIHNldmVyYWwgZmls
dGVycykgYmxvY2stYmFja2VuZA0KPj4NCj4gDQo+IEFoLCB5b3UgYXJlIHJpZ2h0IG9mIGNvdXJz
ZSAtLSBiZWNhdXNlIGJsb2NrLWJhY2tlbmRzIGFyZSB0aGUgb25seQ0KPiAibm9kZXMiIGZvciB3
aGljaCB3ZSBhY3R1YWxseSBkZXNjZW5kIHRoZSBncmFwaCBhbmQgYWRkIHRoZSBiaXRtYXAgdG8N
Cj4gaXRzIGNoaWxkLg0KPiANCj4gU28gdGhlIHJlYWwgYmFjay1yZXNvbHV0aW9uIG1lY2hhbmlz
bSBpczoNCj4gDQo+IC0gRmluZCB0aGUgZmlyc3Qgbm9uLWZpbHRlciBhbmNlc3RvciwgQQ0KPiAt
IGlmIEEgaXMgbm90IGEgYmxvY2stYmFja2VuZCwgd2UgbXVzdCB1c2Ugb3VyIG5vZGUtbG9jYWwg
bmFtZS4NCj4gLSBpZiBBJ3MgbmFtZSBpcyBlbXB0eSwgd2UgbXVzdCB1c2Ugb3VyIG5vZGUtbG9j
YWwgbmFtZS4NCj4gLSBJZiB0aGUgbmFtZSB3ZSBoYXZlIGNob3NlbiBpcyBub3QgaWRfd2VsbGZv
cm1lZCwgd2UgaGF2ZSBubw0KPiBtaWdyYXRpb24tc3RhYmxlIGFkZHJlc3NhYmxlIG5hbWUgZm9y
IHRoaXMgYml0bWFwIGFuZCB0aGUgbWlncmF0aW9uIG11c3QNCj4gZmFpbCENCj4gDQo+IA0KPiBG
b3IgcmVzb2x2aW5nIGJpdG1hcCBhZGRyZXNzZXMgdmlhIFFNUCAobm9kZSwgbmFtZSkgcGFpcnM7
IHRoZQ0KPiByZXNvbHV0aW9uIG1ldGhvZCB3b3VsZCBiZSB0aGlzOg0KPiANCj4gLSBpZiB0aGUg
bm9kZS1uYW1lIE4gaXMgYSBibG9jay1iYWNrZW5kLCBkZXNjZW5kIHRoZSB0cmVlIHVudGlsIHdl
IGZpbmQNCj4gdGhlIGZpcnN0IG5vbi1maWx0ZXIgbm9kZSBWLg0KPiAtIGlmIHRoZSBub2RlLW5h
bWUgTiBpcyBhIEJsb2NrRHJpdmVyU3RhdGUsIHVzZSB0aGlzIG5vZGUgZGlyZWN0bHkuDQo+IA0K
DQpMb29rcyBnb29kIGZvciBtZS4NCg0KSSBhbHNvIHRoaW5rIGlmIG9uIGRlc3RpbmF0aW9uIHdl
IGhhdmUgYm90aCBibG9jay1iYWNrZW5kIHdpdGggbmFtZSBOIGFuZA0KYmxvY2stbm9kZSB3aXRo
IG5hbWUgTiBhbmQgdGhlIGxhdHRlciBpcyBub3QgKGZpbHRlcmVkKSBjaGlsZCBvZiB0aGUgZm9y
bWVyLA0Kd2Ugc2hvdWxkIGZhaWwgbWlncmF0aW9uIG9mIGF0IGxlYXN0IHRoYXQgYml0bWFwLiAo
SG9wZSwgbm9ib2R5IHJldXNlDQpibG9jay1iYWNrZW5kIG5hbWVzIGFzIG5vZGUtbmFtZXMgaW4g
cHJhY3RpY2UuLiAoc2hvdWxkIHdlIHJlc3RyaWN0IGl0DQpleHBsaWNpdGx5ID8pKQ0KDQo+IA0K
PiAoSSBkb24ndCBoYXZlIHRoZSB0aW1lIHRvIGludmVzdGlnYXRlIHRoZSBjb2RlIHNuaXBwZXQg
cmlnaHQgbm93OyBteQ0KPiBhdHRlbnRpb24gaXMgYmVpbmcgcHVsbGVkIHRvIGEgZGlmZmVyZW50
IHByb2plY3QuIHNvcnJ5ISkNCj4gDQoNClNvLCB5b3UgYXJlIG5vdCB3b3JraW5nIG9uIHRoaXM/
IFRoZW4gSSdsbCBtYWtlIHBhdGNoZXMuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXIN
Cg==


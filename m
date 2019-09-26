Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6074C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72361222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 12:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tTDrq+sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72361222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDSZ2-0005nF-TE
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 08:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDSXS-0004bu-6v
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDSXQ-0001N9-Vx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 08:06:26 -0400
Received: from mail-eopbgr60123.outbound.protection.outlook.com
 ([40.107.6.123]:16600 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDSXI-0000hq-C8; Thu, 26 Sep 2019 08:06:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzwoFZDX6wd0uQfj/KoDyK7d1h0TGUhuxT3vB32JyPdO+iTezjqE5wHm2BtE2B/oHjziUi6EhFF+pc9AArojpeuurBypOox9eamgQac0Io7IXZl4iiArsqCbG0PDy5MMDg7t8OFz03enCDnRcHuQv8ME+PRIsqR5rQ4yvT2xTHy0eW+NuYOJzX9kWjD7pI8k7a4aGeClnaZXawxlkGA40dpovd/HFmWaVMrke10tyB8cmYHEvjkMaD0673lg0DwRyisl6HyDAuvFZuLmC0HJWIpRxftwjuToqRriVRgnLNSxDdYOreywmLEt8qRiqs0M+RVk4naAF8VFfl0CxnbMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuuw830LBL35ZBgYCTJcUkI5kz/IovUwFlznvE8HgpE=;
 b=ZO2OmCbNhaluh9ZmDROuyNviKX7r+O/lefZ8EBtlUjg6X2lAJvNNrJw5HCUuV1K1nrnVvumz1ytlZ6JAByVeZsEDWe4yQsbtkE1NQftUphWfxgoNVzHCxOh8ysdOtj7OsBP9IBOwDdFKpnnnofVO65aP1GvClXHjxKNGgBppKgwjemMC75bm4nR1ve7Dd93A5ov8rpCf7CMZxkaYS0wd9UGm8nBUVye5xmoGmXHAIH1toNBlOGnbIvl/TnmT8CsPJL1p+QU3UuadG/cZL//vfxJjh/Y5EjdsbDm9YXlLUrVHcW+OdkJ6zOgfvaCqAFuCKtbqCxRZqY6SV1m3oV2SQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fuuw830LBL35ZBgYCTJcUkI5kz/IovUwFlznvE8HgpE=;
 b=tTDrq+sOhHKVg2Ngrocn4Yxa9XVqlimE1bVmEMT5xLVO25hZZgObHf1k+9PpwvWXpEzhMz0kVBiHmoGAXwqE0DS9OtA35sjrDv++GKgY9vvXFzgqbOgsgpinlbANIA4Py1wHugWK6A3mD1vXqtWD8Ucf7vNccA8SWtztalisnb0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5353.eurprd08.prod.outlook.com (52.133.240.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 12:06:12 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 12:06:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "no-reply@patchew.org"
 <no-reply@patchew.org>, "stefanha@redhat.com" <stefanha@redhat.com>
Subject: Re: [PULL 0/2] Block patches
Thread-Topic: [PULL 0/2] Block patches
Thread-Index: AQHVc8k1k3YXEIerUkem33IUrXFaAqc9fE6AgABhr4A=
Date: Thu, 26 Sep 2019 12:06:11 +0000
Message-ID: <c705d17e-6e39-d9a2-e791-02c4f95c3faf@virtuozzo.com>
References: <156947859030.9841.4795650725800418297@8230166b0665>
In-Reply-To: <156947859030.9841.4795650725800418297@8230166b0665>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0281.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::33) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190926150608985
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f7a552d-eba9-48c5-cfcf-08d74279ec26
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5353; 
x-ms-traffictypediagnostic: DB8PR08MB5353:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB8PR08MB535350E86C2B3B101F1BB676C1860@DB8PR08MB5353.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(36756003)(86362001)(186003)(54906003)(25786009)(6116002)(3846002)(66946007)(2501003)(2906002)(31686004)(5660300002)(11346002)(446003)(66476007)(229853002)(6512007)(386003)(4326008)(6506007)(476003)(14454004)(6306002)(66066001)(2616005)(102836004)(6486002)(486006)(76176011)(305945005)(71190400001)(71200400001)(316002)(26005)(81166006)(8676002)(31696002)(81156014)(7736002)(256004)(110136005)(478600001)(6436002)(2201001)(966005)(64756008)(66446008)(66556008)(8936002)(52116002)(99286004)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5353;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 23QTGtP7ucaC9KmuegM9q3kmKrVwjmmbykjRgZDVZ8ksG7zeLZ2Cvg8tXZXIzFzivjDvKPe8JDg7VSArcF9QHu9IEgbp1BAjeOonjRo6entRpHEINsFHEoRRIT0KFSB8cLXiAOggs7Mi0ddUTp9p+qMNcPBOWCJODyyz0amisRJKKHtsODub35kGzMQsImwNi/S3TpCB4+JB4GDKuf3k3zj9iXceAZ3TKRqZOipMdKFkPCh2h2onPdZMXK28MNdEObGfit53Jb3tOFPNyijr+iTNow9Obmwy/2ru/Hbey1V0TcSoXIeYuQuhJ7pariTKJsoN7RIkdQ/PfPkAYyY2TCwjwWMerAFYe33gGJWNK19o6FZQ3Rk+7mJbbL6GPyHT7FkTY7FPxC+k2piR2TT3D7vqYOy9sXgt/lmWgO/0udhAIzaSQ1akl0e5Ht3rNezMtQNeZPPhL+XMiJtx71wgQg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B69AC6DC3BDD1342A3755B74388EE42D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a552d-eba9-48c5-cfcf-08d74279ec26
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 12:06:11.7788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpDaBOxltgDgk858rmUGIqeXQOZnK+qEAoT8MloGk8JXMI1mpnAHFIvYi8NsldOiXgp51fH0XwHCyEOfiJuuItaigXKemohg+D2/quw4Bfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5353
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.123
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjYuMDkuMjAxOSA5OjE2LCBuby1yZXBseUBwYXRjaGV3Lm9yZyB3cm90ZToNCj4gUGF0Y2hldyBV
Ukw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNTE3NDQwMC44NTc4LTEtc3RlZmFu
aGFAcmVkaGF0LmNvbS8NCj4gDQo+IA0KPiANCj4gSGksDQo+IA0KPiBUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kDQo+IHRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9j
a2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQNCj4gbG9jYWxseS4N
Cj4gDQo+ID09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0NCj4gIyEgL2Jpbi9iYXNoDQo+IGV4cG9y
dCBBUkNIPXg4Nl82NA0KPiBtYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQ0K
PiB0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xDQo+ID09
PSBURVNUIFNDUklQVCBFTkQgPT09DQo+IA0KPiAgICBDQyAgICAgIGF1dGh6L2xpc3Qubw0KPiAg
ICBDQyAgICAgIGF1dGh6L2xpc3RmaWxlLm8NCj4gL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvaW92
LmM6IEluIGZ1bmN0aW9uICdxZW11X2lvdmVjX2luaXRfZXh0ZW5kZWQnOg0KPiAvdG1wL3FlbXUt
dGVzdC9zcmMvdXRpbC9pb3YuYzo0NTE6OTogZXJyb3I6ICdtaWRfaW92JyBtYXkgYmUgdXNlZCB1
bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXpl
ZF0NCj4gICAgICAgICAgIG1lbWNweShwLCBtaWRfaW92LCBtaWRfbmlvdiAqIHNpemVvZigqcCkp
Ow0KPiAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gDQo+IA0KPiBU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0DQo+IGh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwOTI1MTc0NDAwLjg1NzgtMS1zdGVmYW5oYUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1p
bmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLg0KPiAtLS0NCj4gRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLg0KPiBQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ0KPiANCg0KQWN0dWFs
bHkgaXQncyBvYnZpb3VzIHRoYXQgaXQgaXMgaW5pdGlhbGl6ZWQgaGVyZToNCg0KV2UgZ28gaGVy
ZSBvbmx5IGlmIG1pZF9uaW92LCB3aGljaCBtYXkgYmUgc2V0IG9ubHkgaW4gImlmIChtaWRfbGVu
KSIsIGFuZCBtaWRfaW92IGlzIHNldCBpbiBzYW1lICJpZiAobWlkX2xlbikiLg0KDQpNeSBjbGFu
ZyBkb24ndCB3YXJuLg0KDQpTdGlsbCwgd2UgbWF5IGp1c3QgaW5pdGlhbGl6ZSBtaWRfaW92IHRv
IE5VTEwgYW5kIGRvbid0IGNhcmUuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


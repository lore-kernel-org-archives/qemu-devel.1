Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A133C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EF020659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AgL8mrjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EF020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJz20-0007hb-Bl
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJyuO-00011p-PT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iJyuN-0007Je-Jd
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:53:04 -0400
Received: from mail-eopbgr130102.outbound.protection.outlook.com
 ([40.107.13.102]:42932 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iJyuM-0007Hq-Um; Mon, 14 Oct 2019 07:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMdl36XUP03NiSF305gu67ba4rSIMuPjnfraAiwcYL50maIJ53snUn4mwvDh+in7QdRA4USe4GYkh3hPTYXW40GTok9VYdRd/wVXiwdkAyOG6hP0w/+QGPH2dL6cGR+MqPUyE/0eoTfCI5BWWwjk+UlyWlsrf9tluO26vMW6JAHlh3/inn13KVpCZvYWu9lZr3RMw+5PJCPHcxO6sXGvUaobNMFxMxSZ36kjtH5mdKRtN4IxHpixGakw0Jg25/EGhkZqdjhn/w/4HK5JN6J8aS7bWeC0kf0TRFYHXiWOmm4UZMYGg5bTiTxoqDBe314/GmfIxv9Z/Vwr9ZBxXnSzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+9r2bFsrMcKMXOJbsJtXO0XA6pcXKDbXTGuNgb0uWg=;
 b=j+G49/AiCuXgFwRZubhLhATMDKxySW/gOUF0BgJkb5N1PJrPU818uQQXMu2hlyqXpk7oWJ2HrPnoXIowpW+sv7GQXRtQ619Jr4gpLgeQ1x3bffaY/+tRBoBa+OXXpaFHcCwFHwn754tbzXEgLREWziqQ+r0A3qFCnV38hU42wq1z4TmrUbdI2kJlCcMo6IxvBp+iHzVyyz2sTpPCXxjjpSHW1kzVsZbElmvn6H/4x47xRxcR2YguQN4900TcrklLzT/wGWD18BEWK2lu31HqGVriNfK/NaybDN5vkWMFKLGKz4hd+KCgETkTr/RddA1a/rujhcDzGdVhtrRNSGyJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+9r2bFsrMcKMXOJbsJtXO0XA6pcXKDbXTGuNgb0uWg=;
 b=AgL8mrjUogd6Oz5tQgov/QIz0LznWVAIZ19TxOt9KmRYIoWONaA6e5hDBUAY/VwrysdvhcjoEEQMHG2x5OKtZ0bImLAgkGb02AymH5TlXU0KiI1kd26I8W7Am5G3MD7GsK/GjvO+sIm8vSuLrGSUrlGj4j72JwE0n/mbcaO+f4s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4169.eurprd08.prod.outlook.com (20.179.10.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 14 Oct 2019 11:53:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::2856:990a:197a:288f%2]) with mapi id 15.20.2347.021; Mon, 14 Oct 2019
 11:53:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 0/2] fix qcow2_can_store_new_dirty_bitmap
Thread-Topic: [PATCH v2 0/2] fix qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVgoW5R0JiiFjWEkC5eKx2r1dN66daBsuA
Date: Mon, 14 Oct 2019 11:52:59 +0000
Message-ID: <3c08fc07-dff8-0d70-7436-a52d67e9542e@virtuozzo.com>
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191014115126.15360-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::32) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191014145257581
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c199df0-4690-459b-ff79-08d7509d0f91
x-ms-traffictypediagnostic: DB8PR08MB4169:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4169CB45259449E5B0478F08C1900@DB8PR08MB4169.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(346002)(39850400004)(376002)(189003)(199004)(53754006)(71190400001)(71200400001)(86362001)(36756003)(256004)(386003)(6506007)(3846002)(6116002)(2906002)(99286004)(52116002)(76176011)(54906003)(316002)(31696002)(25786009)(4326008)(81166006)(8936002)(186003)(102836004)(476003)(11346002)(2616005)(486006)(5660300002)(81156014)(8676002)(66556008)(446003)(14454004)(6246003)(2501003)(2351001)(7736002)(229853002)(305945005)(107886003)(66066001)(31686004)(66946007)(6916009)(966005)(5640700003)(478600001)(6486002)(66476007)(64756008)(66446008)(6436002)(6306002)(6512007)(26005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4169;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjjkX4G0MFSaKznTp591iMTXEgikuR3XYatQQpYzLS7XYOXDv7fFcCDApVrffagVH/awZa6inZtypn1IU4FGYBOVWB4T+kFpftIeSu1FFnOAJoUqwByxjN15u+JOCJu6tuaEL5KL1P1YAucxfRrJmRG6/2x5D64wIJzsHIZf0zo/ujDDSALFFRhjdlzp44wVtAmcG/BqsPVCH/pgTZ87L1sPoKeBTgnOfnAVUBdNxfS92Lqy1E6jDRkNAgqWUTlNS4qufB+ZUfbirejsk0vNWgnkfGod7N6chPWsQ38IIIHWvKPz9I2BH+4aW5bAXb/nIJwIfKldpgUPGKdCTDSFYspTq+8OOu/pQPxPfT0Qi8UcXvw6Vp1HdirUjC4tW1seX9u4VT3QPn+ZlB1V/TPcqbd0j54iS/nJyBkaXvlBtLz9Q1ano8nLumBmNyP3I1MODa1YRJfvmonsmOnajWEN5A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <304007DCB144DF4A9C9D4ADAF4F4231A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c199df0-4690-459b-ff79-08d7509d0f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 11:52:59.9239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dlp3BpkLlDUdJJrvDClgfrIc5l5bykkdBefCX9I3kbAL0LnaCgvfUEA9MUuHwITjEx3KIJqjPrzJEcVc13/6n0VQ/arCGaIJrRJZuR6G3a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4169
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.102
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMTAuMjAxOSAxNDo1MSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gSGVyZSBpcyBhIGZpeCBmb3IgcGVyc2lzdGVudCBiaXRtYXBzIG1hbmFn
aW5nOiB3ZSBtdXN0IGNoZWNrIGV4aXN0ZW50DQo+IGJ1dCBub3QgeWV0IHN0b3JlZCBiaXRtYXBz
IGZvciBxY293Mi1yZWxhdGVkIGNvbnN0cmFpbnRzLCBsaWtlIG1heGltdW0NCj4gbnVtYmVyIG9m
IGJpdG1hcHMgaW4gcWNvdzIgaW1hZ2UuDQo+IA0KPiB2MjoNCg0KbWFpbiB0aGluZyBiYXNlZCBv
biBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUgYml0bWFwcw0KQmFzZWQtb246IDwyMDE5
MTAxMTIxMjU1MC4yNzI2OS0xLWpzbm93QHJlZGhhdC5jb20+DQoNCj4gDQo+IDAxOiBjaGFuZ2Ug
YXNzZXJ0aW9uIHRvIGVycm9yLXJldHVybiBhdCBmdW5jdGlvbiBzdGFydA0KPiAgICAgIEJlIGZy
ZWUgdG8gYWRkDQo+ICAgICAgUmVwb3J0ZWQtYnk6IGFpaHVhIGxpYW5nIDxhbGlhbmdAcmVkaGF0
LmNvbT4NCj4gICAgICBGaXhlczogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVn
LmNnaT9pZD0xNzEyNjM2DQo+ICAgICAgaWYgaXQncyBhcHByb3ByaWF0ZQ0KPiAwMjogbmV3IHRl
c3QNCj4gICAgICBPaGgsIGl0IHRha2VzIGFib3V0IDQgbWludXRlcy4gQmUgZnJlZSB0byBkcm9w
IGl0LCBhcyBJIGRvdWJ0IHRoYXQNCj4gICAgICBpdCB3b3J0aCB0byBoYXZlLiBUaGUgY2FzZSBp
cyBzaW1wbGUsIHdlIG1heSBsaXZlIHdpdGhvdXQgYQ0KPiAgICAgIHRlc3QuDQo+IA0KPiBWbGFk
aW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgyKToNCj4gICAgcWNvdzItYml0bWFwczogZml4IHFj
b3cyX2Nhbl9zdG9yZV9uZXdfZGlydHlfYml0bWFwDQo+ICAgIGlvdGVzdHM6IGFkZCAyNjkgdG8g
Y2hlY2sgbWF4aW11bSBvZiBiaXRtYXBzIGluIHFjb3cyDQo+IA0KPiAgIGJsb2NrL3Fjb3cyLWJp
dG1hcC5jICAgICAgIHwgNDEgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzI2OSAgICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNjkub3V0IHwgIDMgKysrDQo+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAgfCAgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCA2OSBpbnNlcnRpb25zKCspLCAyMyBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA3
NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2OQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9x
ZW11LWlvdGVzdHMvMjY5Lm91dA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=


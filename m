Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED40DC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F8C218D3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BcOYMhuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F8C218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr3zG-0008SK-Tx
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hr3z3-0007xB-F9
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hr3z0-0006VO-5z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:26:19 -0400
Received: from mail-am5eur02on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe07::71a]:19111
 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hr3yz-0006NZ-J5; Fri, 26 Jul 2019 13:26:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZb8R98FxKVRHxmM4lVY0QS16RbYumvqYCoVTm5T1IjRfRW30G4O9Z0aGxx21R/v11cex2l0TfeHVZqIpF1KIfKJW7KxTxtnLd9lpThCxeEEIrDYNTz5lhw3AC+vO/3M08znJooI5s0hh6sf3kXYl3UPI3Kh/I/ziE04z5ZOcO9SdYnEVyt/e+D46V8RPvVD3OlOgNpQ6t909IYoKzh8ZTRH2kP3AXHeqzVnjK8X1wH6tcyxUJ+IraltdrPlfYFcoUYItPP7VQhwwPkwfbJ9Jqbz+AI0GXE+UYpOMiy49yYDbLiH+6g5Cci5SnIx2s5CRR/3qGpMRx66gTTEybp0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duD6k5hgcUW5LrPzF+U8KULKeUi194oh/uj9LvtvkvM=;
 b=Igpa9P0NXmW1v5sJP/m0x5klrspJNpUVWR+7zL2hW0dQwPBvZWxwjMtoJ/BOcdbeXAeIGFX25dVBDDE6X+wkLPFe8a+b0vWhgg7l56VZcE8g5GKaK/Qteyq1zcfyrYMdCWqjCF16r475rBA8eWxbif9N31sC7TxlxUHyYbwnWmXfMKcW2RCurDmXyUiT1jVT1KbgwWZDKbThdOco17t9XLVDMRe2CcbptKoH8raWfZNoNdC0kiT7Tzc7lHlxho7m5pDJb9iz6Wjrd97IpBASCjFKBH/GLFKZ1CsyAqBSOaHed7PrhECtgVgr+TKBiaY+J/GZMcwxc5m6tsTV8MgVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duD6k5hgcUW5LrPzF+U8KULKeUi194oh/uj9LvtvkvM=;
 b=BcOYMhuWnjTQOOYYaxeBNyXw7SLq2qiOkxJ0QDIDS2n2NBpbeemvnBn1fHixYfv3AmJlfiPgEGaAg0znW7YHI4nx3rqoOH02othZxsSe59ChWf6N7IxiCCvehjs2B0OdYy6n3ssd5FGvLmnSjiOlQlX/uO+tBh7sX2GQsWbEkjI=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3931.eurprd08.prod.outlook.com (20.179.10.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Fri, 26 Jul 2019 17:26:14 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 17:26:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3 0/3] qapi: block-dirty-bitmap-remove
 transaction action
Thread-Index: AQHVNdk4ZPKxooDMyUuWDIX1m9Wf6abMINeAgA2U5QCAABvNAIADcTSA
Date: Fri, 26 Jul 2019 17:26:14 +0000
Message-ID: <869d3a4c-49ba-e74e-001b-edac743ed140@virtuozzo.com>
References: <20190708220502.12977-1-jsnow@redhat.com>
 <bfd251ed-2f86-f463-b682-cd00c1caba51@redhat.com>
 <dc4deae4-d80c-66a2-df4f-4966a6068767@virtuozzo.com>
 <5e8d0302-6a92-30d0-740e-6d70711221fa@redhat.com>
In-Reply-To: <5e8d0302-6a92-30d0-740e-6d70711221fa@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::18)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190726202611485
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3ab522-d34a-4f21-52bf-08d711ee5c2f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3931; 
x-ms-traffictypediagnostic: DB8PR08MB3931:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB8PR08MB39311E0AADAE9D99222D0DEEC1C00@DB8PR08MB3931.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(396003)(366004)(376002)(136003)(52314003)(189003)(199004)(8676002)(81156014)(81166006)(8936002)(5660300002)(31686004)(316002)(68736007)(66556008)(64756008)(2501003)(52116002)(186003)(76176011)(6506007)(102836004)(2201001)(478600001)(966005)(14454004)(66476007)(66946007)(53546011)(561944003)(386003)(66446008)(2616005)(476003)(53936002)(486006)(71190400001)(6116002)(66066001)(31696002)(6512007)(6306002)(14444005)(25786009)(256004)(7736002)(99286004)(7416002)(4326008)(6246003)(3846002)(71200400001)(110136005)(6436002)(54906003)(6486002)(229853002)(26005)(2906002)(36756003)(305945005)(446003)(11346002)(86362001)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3931;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rr4HYwvzt2+pIC84APvoqoWJJurxW8OVoZFfMLb4EtWQwf5cD7irltZsm/ZpUgr5n34hSM4Q1ym4xbAJ2lbDk4L3vuiyWkbT/cKn3tbD7KNRyTIHOOrw/ynEiGy6M1YYDH5ZNyjsOUyz8bv+pWZSTl9wI8lNFydYJtObkTgrlpSaV+7Sy48FQ+9HUL3nE/zvizl+717MOOaq3FHwrJo5wxG/Yx4l5tkZpGbD/5wn7BaDKynMbs2TsCxLLXHf2MEF62R6Gsyt5pHj4HP7FP5GxAWU4wHXpd4MZ4B21HIFZ0upyDXGnSLhse+0UVuZaXm3/CPXiEcLOLzY7eJP+B8UL3CQ0i+uqDIF1/MiIDQxctmogHr35KkXrXpB4jq9Gs61WMu3GFxv7RnAfjfsswKP5jHuueYklglI/Ac0KU8fotI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9C6B813CBAD574B91FF228435BAC7F3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3ab522-d34a-4f21-52bf-08d711ee5c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 17:26:14.4199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3931
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe07::71a
Subject: Re: [Qemu-devel] [PATCH v3 0/3] qapi: block-dirty-bitmap-remove
 transaction action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjQuMDcuMjAxOSAxNTo1MiwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMjQvMTkg
NzoxMiBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE1LjA3LjIw
MTkgMjI6NDgsIEpvaG4gU25vdyB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gNy84LzE5IDY6MDQg
UE0sIEpvaG4gU25vdyB3cm90ZToNCj4+Pj4gSGksIHRoaXMgaXMgYSBwcm9wb3NhbCBiYXNlZCBv
ZmYgb2YgVmxhZGltaXIncyBwYXRjaHNldDoNCj4+Pj4gW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzRd
IHFhcGk6IGJsb2NrLWRpcnR5LWJpdG1hcC1yZW1vdmUgdHJhbnNhY3Rpb24gYWN0aW9uDQo+Pj4+
DQo+Pj4+ID09PQ0KPj4+PiBWMzoNCj4+Pj4gPT09DQo+Pj4+DQo+Pj4+IDAwMS8zOlstLS0tXSBb
LS1dICdibG9ja2RldjogcmVkdWNlIGFpb19jb250ZXh0IGxvY2tlZCBzZWN0aW9ucyBpbiBiaXRt
YXAgYWRkL3JlbW92ZScNCj4+Pj4gMDAyLzM6WzAwMjRdIFtGQ10gJ3FhcGk6IGltcGxlbWVudCBi
bG9jay1kaXJ0eS1iaXRtYXAtcmVtb3ZlIHRyYW5zYWN0aW9uIGFjdGlvbicNCj4+Pj4gMDAzLzM6
Wy0tLS1dIFstLV0gJ2lvdGVzdHM6IHRlc3QgYml0bWFwIG1vdmluZyBpbnNpZGUgMjU0Jw0KPj4+
Pg0KPj4+PiAtIENoYW5nZWQgInNxdWVsY2hfcGVyc2lzdGVuY2UiIHRvICJza2lwX3N0b3JlIg0K
Pj4+PiAtIFVzZSBNYXgncyBzdWdnZXN0aW9uIGZvciByZXR1cm4gZXhwcg0KPj4+Pg0KPj4+PiA9
PT0NCj4+Pj4gVjI6DQo+Pj4+ID09PQ0KPj4+Pg0KPj4+PiBJdCByZXBsYWNlcyBwYXRjaGVzIHR3
byBhbmQgdGhyZWUgd2l0aCBhIG1vZGlmaWVkIHBhdGNoIChub3cgcGF0Y2ggMikNCj4+Pj4gdGhh
dCBmb3JlZ29lcyB0aGUgbmVlZCBmb3IgYSBoaWRlKCkvdW5oaWRlKCkgYml0bWFwIEFQSS4gSSB0
aGluayBpdCdzDQo+Pj4+IHN1aXRhYmxlIGFzIGEgc21hbGxlciBhbHRlcm5hdGl2ZSwgYnV0IEkn
bSBub3Qgc3VyZSBpZiBpdCBjb3ZlcnMgYWxsDQo+Pj4+IG9mIHRoZSB1c2UgY2FzZXMgb2YgdGhl
IG9yaWdpbmFsIHNlcmllcy4NCj4+Pj4NCj4+Pj4gUGF0Y2hlcyAxIGFuZCAzIChmb3JtZXJseSA0
KSBpbmNsdWRlZCBhcy1pcy4NCj4+Pj4NCj4+Pj4gSm9obiBTbm93ICgxKToNCj4+Pj4gICAgIHFh
cGk6IGltcGxlbWVudCBibG9jay1kaXJ0eS1iaXRtYXAtcmVtb3ZlIHRyYW5zYWN0aW9uIGFjdGlv
bg0KPj4+Pg0KPj4+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgyKToNCj4+Pj4gICAg
IGJsb2NrZGV2OiByZWR1Y2UgYWlvX2NvbnRleHQgbG9ja2VkIHNlY3Rpb25zIGluIGJpdG1hcCBh
ZGQvcmVtb3ZlDQo+Pj4+ICAgICBpb3Rlc3RzOiB0ZXN0IGJpdG1hcCBtb3ZpbmcgaW5zaWRlIDI1
NA0KPj4+Pg0KPj4+PiAgICBibG9jay5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0N
Cj4+Pj4gICAgYmxvY2svZGlydHktYml0bWFwLmMgICAgICAgICAgIHwgIDE1ICsrKy0tDQo+Pj4+
ICAgIGJsb2NrZGV2LmMgICAgICAgICAgICAgICAgICAgICB8IDEwNSArKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0NCj4+Pj4gICAgaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCAg
IHwgICAyICstDQo+Pj4+ICAgIG1pZ3JhdGlvbi9ibG9jay1kaXJ0eS1iaXRtYXAuYyB8ICAgMiAr
LQ0KPj4+PiAgICBxYXBpL3RyYW5zYWN0aW9uLmpzb24gICAgICAgICAgfCAgIDIgKw0KPj4+PiAg
ICB0ZXN0cy9xZW11LWlvdGVzdHMvMjU0ICAgICAgICAgfCAgMzAgKysrKysrKysrLQ0KPj4+PiAg
ICB0ZXN0cy9xZW11LWlvdGVzdHMvMjU0Lm91dCAgICAgfCAgODIgKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+PiAgICA4IGZpbGVzIGNoYW5nZWQsIDIwNiBpbnNlcnRpb25zKCspLCAzNCBk
ZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pg0KPj4+IFRoYW5rcywgYXBwbGllZCB0byBteSBiaXRtYXBz
IHRyZWU6DQo+Pj4NCj4+PiBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUvY29tbWl0cy9i
aXRtYXBzDQo+Pj4gaHR0cHM6Ly9naXRodWIuY29tL2puc25vdy9xZW11LmdpdA0KPj4+DQo+Pj4g
LS1qcw0KPj4+DQo+Pj4NCj4+PiAoVmxhZGltaXI6IGlmIHRoaXMgaXNuJ3QgYW1lbmFibGUgdG8g
eW91LCBpdCdzIGdvaW5nIGluIGZvciA0LjIsIHNvIHdlDQo+Pj4gaGF2ZSB1bnRpbCB0aGUgbmV4
dCBmcmVlemUgdG8gY2hhbmdlIGl0LiBMZXQgbWUga25vdywgT0s/KQ0KPj4+DQo+Pg0KPj4NCj4+
IEFuZCBmaW5hbGx5IEknbSBoZXJlIDopDQo+Pg0KPj4gVGhhbmtzIGEgbG90IGZvciBkb2luZyB0
aGlzIGpvYiBhbmQgZm9yIHlvdXIgZXhwbGFuYXRpb25zIGluIG90aGVyIHRocmVhZHMgd2hpY2gN
Cj4+IEknbSByZWFkaW5nIHRvZGF5IGFuZCBzb3JyeSBmb3IgdGhlIGRlbGF5ISBJJ2xsIGxvb2sg
dGhyb3VnaCB0aGVzZSBzZXJpZXMgc29vbi4NCj4+DQo+PiBBY3R1YWxseSwgbXkgc2Vjb25kIGNo
aWxkIChnaXJsOikgd2FzIGJvcm4gYSBtb250aCBhZ28sIGFuZCB0aGVuIGhlciBlbGRlciBicm90
aGVyDQo+PiB3YXMgaWxsLCBzbyBJIHRvb2sgdHdvIHdlZWtzIHNpY2sgbGVhdmUgYWZ0ZXIgYWJv
dXQgdHdvIHdlZWtzIHZhY2F0aW9uIGFuZCBmb3JnZXQNCj4+IGFib3V0IHdvcmsgZm9yIGEgbW9u
dGguDQo+Pg0KPj4gSG1tLiBBbmQgTmlrb2xheSwgd2hvIGRvaW5nIGxpYnZpcnQgcGFydCBpcyBv
biB2b2NhdGlvbiBub3cgKEkgc3RhcnRlZCBiaXRtYXAgcmVtb3ZlDQo+PiB0cmFuc2FjdGlvbiBz
ZXJpZXMgYnkgaGlzIHJlcXVlc3QpLCBzbyBJIGRvbid0IGtub3cgYWJvdXQgdGhlIGVuZCBvZiB0
aGUgc3Rvcnkgd2l0aA0KPj4gcmVsZWFzZSBhbmQgdGhpcyBmdW5jdGlvbmFsaXR5Li4NCj4+DQo+
PiBBbnl3YXksIGl0J3MgY29vbCwgdGhhbmtzIQ0KPj4NCj4gDQo+IFdvdyENCj4gDQo+IENvbmdy
YXR1bGF0aW9ucyBWbGFkaW1pciENCj4gDQoNClRoYW5rIHlvdSENCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K


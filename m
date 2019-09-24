Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54299C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2B62146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XE82+Tzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2B62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfsY-0003i2-4Z
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCfpb-0001H7-4r
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCfpX-0006e0-UF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:05:54 -0400
Received: from mail-eopbgr10098.outbound.protection.outlook.com
 ([40.107.1.98]:40702 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCfpW-0006cG-K1; Tue, 24 Sep 2019 04:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScsF+iB4Cmy1FAdslH8rpEIpOyfCjMB2ilRV2gK0Gs/z04+hytGkwhW4ygJ4NidO+XxxY0EQVFPoraC25C5aVFGQU4nWDMAZo0OdaJDy9PmJYqfRs9/yjdQqHxo2c7zHtAPpoqryhM4fvKvYBNtO4thWq3y8CjljoUu9LIE+I1S6mMShT1T+cNNNjOMNQlCBRxNA5UpokWhmPPi+m1x29lNjmTcjzyPo5anPrVWuNF5YYHcZ2CMDkC6Rb7ATs0JtPGKKEnJvyQhLY0/ziYCjipS78nJzkwr5zJ0ioJNj0ZPEsk7A6uayqKrhLTBZzGRZAOLiaXerz+MO9yXHCHRXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNRCwGmqE8unfbMsT/PkyzjQQWSDs8uM8zFxRWG/C2s=;
 b=WCevQwRo4ktHyl2JVmORNiSX9f4PzIdPoyO7s6baz2xGfkt3lh59rky9swFedWDEAcGagUXcQcqcnt8i1C2Ne0Yz3drqE7Lj6XzyyUlDyCrN60HGM4nZgqL6DKV9j/bY3Gm3jhh1DjFZPuuppGCgph+gwWq9du/wB61prLgMR8m/crwtwm1LCb4FTmDQZDQupJ+yNHe5GiX0G3vIV2oRstvjwgYOHMPcHn4JxbtaVBRDxcpDhdjszMlS8FsRtni9hEww7rEUBi0Qt4V4soxHg/iEvpvBj64ETsPmOWgFJkqXwLmLNXvFs+ndRX0BG6tIxDS2j8DFsZCtcIhmpLlyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNRCwGmqE8unfbMsT/PkyzjQQWSDs8uM8zFxRWG/C2s=;
 b=XE82+Tzqhy0QK++VJzqNfws5JBcQqqy8vX9Js/xUQ5o7yBA+oUXWRndtQy/i8BsH/p8+mGGULlB+Aq5iSkmxrI5nwmHXBQlIVnANIYBg/zwJTETcbznYScPJD9Aptl6ZHxaJh6urRA+/kHNemvHHpqjL/8MrnNDE3OxYSBlBtIY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5131.eurprd08.prod.outlook.com (10.255.4.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 08:05:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:05:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v9 2/3] block/nbd: nbd reconnect
Thread-Topic: [PATCH v9 2/3] block/nbd: nbd reconnect
Thread-Index: AQHVbXs6xebo44JuL0SNVKyAn1qCnac5reaAgADU2QA=
Date: Tue, 24 Sep 2019 08:05:43 +0000
Message-ID: <e65d1cd0-9ed4-698e-16e5-a6e6487d098d@virtuozzo.com>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-3-vsementsov@virtuozzo.com>
 <b4532b07-71a9-1890-949d-a017ede348ee@redhat.com>
In-Reply-To: <b4532b07-71a9-1890-949d-a017ede348ee@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:7:66::11) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190924110540901
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed798635-70d7-4c32-4e3d-08d740c5ff2b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5131; 
x-ms-traffictypediagnostic: DB8PR08MB5131:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5131C161F7F6D7DEF888D7ABC1840@DB8PR08MB5131.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(376002)(346002)(396003)(39840400004)(124014002)(199004)(189003)(6512007)(5024004)(256004)(5660300002)(86362001)(14444005)(2616005)(305945005)(102836004)(476003)(53546011)(25786009)(6506007)(186003)(26005)(386003)(6486002)(8936002)(6246003)(229853002)(81156014)(81166006)(2501003)(446003)(2906002)(107886003)(3846002)(6436002)(486006)(8676002)(7736002)(36756003)(31686004)(52116002)(71200400001)(71190400001)(561944003)(66446008)(99286004)(66946007)(6116002)(66476007)(64756008)(66556008)(76176011)(110136005)(66066001)(316002)(11346002)(54906003)(4326008)(31696002)(478600001)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5131;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FqNvtMIJD3IPHOhInc3d7EozCMRMNAbJfPIeLm5MptjrGL7vj/YEjsMyyssxGcIywT9wJUcM6fd3Qb9RxFtIUceDNeBP9qsKDy3HvKdtN37LxBD0TO76DMWHPf/Yss1BpCXPascEmIQnDEO3ZpinhzdVt4paIDJYaHOV+n+iETr+p/ycPrRBo+1x7Y4lzQQDoI1xfFggUARSmXyPCTzM5uUfGyQsPzch08IiM9/shvZtsrf6DBDEILAsIeyL24qPOV7PU0icA7UYLUUTKbbeXRpq0P8tckPrmOyBcUugcmHHMaQh5k8YzK5hkIClb+QkhnjTpG3BGfQmE0X09JKs9NWGEN8dD/zDn+sml7Ot6B0uMaS6dDVpWfHhyJHaCEYbzWpYrKWMFe3vgj2h9UFBWy08ud9jh3Dm1F/9SMIBLTs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A3A1FA1169EE94DBE6613BD245011FE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed798635-70d7-4c32-4e3d-08d740c5ff2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:05:43.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xfJCei4DoY/mwNN2vYPTk9yitCq5Kwe4qxSdNXRhi5X4krInnD30MNLyH466kW31V0UV4Ey63p8yccbZy+1eTZcWdTSzZEt2hCfd/8PZ6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5131
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.98
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
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDkuMjAxOSAyMjoyMywgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xNy8xOSAxMjoxMyBQ
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEltcGxlbWVudCByZWNv
bm5lY3QuIFRvIGFjaGlldmUgdGhpczoNCj4+DQo+PiAxLiBhZGQgbmV3IG1vZGVzOg0KPj4gICAg
IGNvbm5lY3Rpbmctd2FpdDogbWVhbnMsIHRoYXQgcmVjb25uZWN0aW5nIGlzIGluIHByb2dyZXNz
LCBhbmQgdGhlcmUNCj4+ICAgICAgIHdlcmUgc21hbGwgbnVtYmVyIG9mIHJlY29ubmVjdCBhdHRl
bXB0cywgc28gYWxsIHJlcXVlc3RzIGFyZQ0KPj4gICAgICAgd2FpdGluZyBmb3IgdGhlIGNvbm5l
Y3Rpb24uDQo+PiAgICAgY29ubmVjdGluZy1ub3dhaXQ6IHJlY29ubmVjdGluZyBpcyBpbiBwcm9n
cmVzcywgdGhlcmUgd2VyZSBhIGxvdCBvZg0KPj4gICAgICAgYXR0ZW1wdHMgb2YgcmVjb25uZWN0
LCBhbGwgcmVxdWVzdHMgd2lsbCByZXR1cm4gZXJyb3JzLg0KPj4NCj4+ICAgICB0d28gb2xkIG1v
ZGVzIGFyZSB1c2VkIHRvbzoNCj4+ICAgICBjb25uZWN0ZWQ6IG5vcm1hbCBzdGF0ZQ0KPj4gICAg
IHF1aXQ6IGV4aXRpbmcgYWZ0ZXIgZmF0YWwgZXJyb3Igb3Igb24gY2xvc2UNCj4+DQo+PiBQb3Nz
aWJsZSB0cmFuc2l0aW9ucyBhcmU6DQo+Pg0KPj4gICAgICogLT4gcXVpdA0KPj4gICAgIGNvbm5l
Y3RpbmctKiAtPiBjb25uZWN0ZWQNCj4+ICAgICBjb25uZWN0aW5nLXdhaXQgLT4gY29ubmVjdGlu
Zy1ub3dhaXQgKHRyYW5zaXRpb24gaXMgZG9uZSBhZnRlcg0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICByZWNvbm5lY3QtZGVsYXkgc2Vjb25kcyBpbiBjb25uZWN0aW5nLXdhaXQgbW9kZSkNCj4+
ICAgICBjb25uZWN0ZWQgLT4gY29ubmVjdGluZy13YWl0DQo+Pg0KPj4gMi4gSW1wbGVtZW50IHJl
Y29ubmVjdCBpbiBjb25uZWN0aW9uX2NvLiBTbywgaW4gY29ubmVjdGluZy0qIG1vZGUsDQo+PiAg
ICAgIGNvbm5lY3Rpb25fY28sIHRyaWVzIHRvIHJlY29ubmVjdCB1bmxpbWl0ZWQgdGltZXMuDQo+
Pg0KPj4gMy4gUmV0cnkgbmJkIHF1ZXJpZXMgb24gY2hhbm5lbCBlcnJvciwgaWYgd2UgYXJlIGlu
IGNvbm5lY3Rpbmctd2FpdA0KPj4gICAgICBzdGF0ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+
PiAtLS0NCj4+ICAgYmxvY2svbmJkLmMgfCAzMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjY5IGluc2Vy
dGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+PiArDQo+PiArc3RhdGljIGNvcm91
dGluZV9mbiB2b2lkIG5iZF9yZWNvbm5lY3RfYXR0ZW1wdChCRFJWTkJEU3RhdGUgKnMpDQo+PiAr
ew0KPj4gKyAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+ICsNCj4+ICsgICAgaWYgKCFu
YmRfY2xpZW50X2Nvbm5lY3RpbmcocykpIHsNCj4+ICsgICAgICAgIHJldHVybjsNCj4+ICsgICAg
fQ0KPj4gKw0KPj4gKyAgICAvKiBXYWl0IGZvciBjb21wbGV0aW9uIG9mIGFsbCBpbi1mbGlnaHQg
cmVxdWVzdHMgKi8NCj4+ICsNCj4+ICsgICAgcWVtdV9jb19tdXRleF9sb2NrKCZzLT5zZW5kX211
dGV4KTsNCj4+ICsNCj4+ICsgICAgd2hpbGUgKHMtPmluX2ZsaWdodCA+IDApIHsNCj4+ICsgICAg
ICAgIHFlbXVfY29fbXV0ZXhfdW5sb2NrKCZzLT5zZW5kX211dGV4KTsNCj4+ICsgICAgICAgIG5i
ZF9yZWN2X2Nvcm91dGluZXNfd2FrZV9hbGwocyk7DQo+PiArICAgICAgICBzLT53YWl0X2luX2Zs
aWdodCA9IHRydWU7DQo+PiArICAgICAgICBxZW11X2Nvcm91dGluZV95aWVsZCgpOw0KPj4gKyAg
ICAgICAgcy0+d2FpdF9pbl9mbGlnaHQgPSBmYWxzZTsNCj4+ICsgICAgICAgIHFlbXVfY29fbXV0
ZXhfbG9jaygmcy0+c2VuZF9tdXRleCk7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcWVtdV9j
b19tdXRleF91bmxvY2soJnMtPnNlbmRfbXV0ZXgpOw0KPj4gKw0KPj4gKyAgICBpZiAoIW5iZF9j
bGllbnRfY29ubmVjdGluZyhzKSkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+
PiArDQo+PiArICAgIC8qDQo+PiArICAgICAqIE5vdyB3ZSBhcmUgc3VyZSB0aGF0IG5vYm9keSBp
cyBhY2Nlc3NpbmcgdGhlIGNoYW5uZWwsIGFuZCBubyBvbmUgd2lsbA0KPj4gKyAgICAgKiB0cnkg
dW50aWwgd2Ugc2V0IHRoZSBzdGF0ZSB0byBDT05ORUNURUQuDQo+PiArICAgICAqLw0KPj4gKw0K
Pj4gKyAgICAvKiBGaW5hbGl6ZSBwcmV2aW91cyBjb25uZWN0aW9uIGlmIGFueSAqLw0KPj4gKyAg
ICBpZiAocy0+aW9jKSB7DQo+PiArICAgICAgICBuYmRfY2xpZW50X2RldGFjaF9haW9fY29udGV4
dChzLT5icyk7DQo+PiArICAgICAgICBvYmplY3RfdW5yZWYoT0JKRUNUKHMtPnNpb2MpKTsNCj4+
ICsgICAgICAgIHMtPnNpb2MgPSBOVUxMOw0KPj4gKyAgICAgICAgb2JqZWN0X3VucmVmKE9CSkVD
VChzLT5pb2MpKTsNCj4+ICsgICAgICAgIHMtPmlvYyA9IE5VTEw7DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICsgICAgcy0+Y29ubmVjdF9zdGF0dXMgPSBuYmRfY2xpZW50X2Nvbm5lY3Qocy0+YnMsICZs
b2NhbF9lcnIpOw0KPj4gKyAgICBlcnJvcl9mcmVlKHMtPmNvbm5lY3RfZXJyKTsNCj4+ICsgICAg
cy0+Y29ubmVjdF9lcnIgPSBOVUxMOw0KPj4gKyAgICBlcnJvcl9wcm9wYWdhdGUoJnMtPmNvbm5l
Y3RfZXJyLCBsb2NhbF9lcnIpOw0KPj4gKyAgICBsb2NhbF9lcnIgPSBOVUxMOw0KPj4gKw0KPiAN
Cj4gTG9va3MgbGlrZSBhIGRlYWQgYXNzaWdubWVudCB0byBsb2NhbF9lcnIuIA0KDQpIbW0sIGFn
cmVlLCBpdCdzIGRlYWQuDQoNCj4gQnV0IEkgc2VlIGVsc2V3aGVyZSB5b3UgYWRkDQo+IGl0LCBi
ZWNhdXNlIHlvdSBjb252ZXJ0IHN0cmFpZ2h0LWxpbmUgY29kZSBpbnRvIGxvb3BzIHdoZXJlIGl0
IG1hdHRlcnMuDQo+IA0KPj4gKyAgICBpZiAocy0+Y29ubmVjdF9zdGF0dXMgPCAwKSB7DQo+PiAr
ICAgICAgICAvKiBmYWlsZWQgYXR0ZW1wdCAqLw0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAg
ICB9DQo+PiArDQo+PiArICAgIC8qIHN1Y2Nlc3NmdWxseSBjb25uZWN0ZWQgKi8NCj4+ICsgICAg
cy0+c3RhdGUgPSBOQkRfQ0xJRU5UX0NPTk5FQ1RFRDsNCj4+ICsgICAgcWVtdV9jb19xdWV1ZV9y
ZXN0YXJ0X2FsbCgmcy0+ZnJlZV9zZW1hKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGNvcm91
dGluZV9mbiB2b2lkIG5iZF9yZWNvbm5lY3RfbG9vcChCRFJWTkJEU3RhdGUgKnMpDQo+IA0KPiBD
b3JvdXRpbmUgZnVuY3Rpb25zIHNob3VsZCBnZW5lcmFsbHkgaGF2ZSAnX2NvXycgaW4gdGhlaXIg
bmFtZS4gIEknZA0KPiBwcmVmZXIgbmJkX2NvX3JlY29ubmVjdF9sb29wLg0KDQpPSywgYWdyZWVk
Lg0KDQo+IA0KPj4gK3sNCj4+ICsgICAgdWludDY0X3Qgc3RhcnRfdGltZV9ucyA9IHFlbXVfY2xv
Y2tfZ2V0X25zKFFFTVVfQ0xPQ0tfUkVBTFRJTUUpOw0KPj4gKyAgICB1aW50NjRfdCBkZWxheV9u
cyA9IHMtPnJlY29ubmVjdF9kZWxheSAqIE5BTk9TRUNPTkRTX1BFUl9TRUNPTkQ7DQo+PiArICAg
IHVpbnQ2NF90IHRpbWVvdXQgPSAxICogTkFOT1NFQ09ORFNfUEVSX1NFQ09ORDsNCj4+ICsgICAg
dWludDY0X3QgbWF4X3RpbWVvdXQgPSAxNiAqIE5BTk9TRUNPTkRTX1BFUl9TRUNPTkQ7DQo+PiAr
DQo+PiArICAgIG5iZF9yZWNvbm5lY3RfYXR0ZW1wdChzKTsNCj4+ICsNCj4+ICsgICAgd2hpbGUg
KG5iZF9jbGllbnRfY29ubmVjdGluZyhzKSkgew0KPj4gKyAgICAgICAgaWYgKHMtPnN0YXRlID09
IE5CRF9DTElFTlRfQ09OTkVDVElOR19XQUlUICYmDQo+PiArICAgICAgICAgICAgcWVtdV9jbG9j
a19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSkgLSBzdGFydF90aW1lX25zID4gZGVsYXlfbnMp
DQo+PiArICAgICAgICB7DQo+PiArICAgICAgICAgICAgcy0+c3RhdGUgPSBOQkRfQ0xJRU5UX0NP
Tk5FQ1RJTkdfTk9XQUlUOw0KPj4gKyAgICAgICAgICAgIHFlbXVfY29fcXVldWVfcmVzdGFydF9h
bGwoJnMtPmZyZWVfc2VtYSk7DQo+PiArICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICBxZW11
X2NvX3NsZWVwX25zX3dha2VhYmxlKFFFTVVfQ0xPQ0tfUkVBTFRJTUUsIHRpbWVvdXQsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZzLT5jb25uZWN0aW9uX2NvX3NsZWVw
X25zX3N0YXRlKTsNCj4+ICsgICAgICAgIGlmIChzLT5kcmFpbmVkKSB7DQo+PiArICAgICAgICAg
ICAgYmRydl9kZWNfaW5fZmxpZ2h0KHMtPmJzKTsNCj4+ICsgICAgICAgICAgICBzLT53YWl0X2Ry
YWluZWRfZW5kID0gdHJ1ZTsNCj4+ICsgICAgICAgICAgICB3aGlsZSAocy0+ZHJhaW5lZCkgew0K
Pj4gKyAgICAgICAgICAgICAgICAvKg0KPj4gKyAgICAgICAgICAgICAgICAgKiBXZSBtYXkgYmUg
ZW50ZXJlZCBvbmNlIGZyb20gbmJkX2NsaWVudF9hdHRhY2hfYWlvX2NvbnRleHRfYmgNCj4+ICsg
ICAgICAgICAgICAgICAgICogYW5kIHRoZW4gZnJvbSBuYmRfY2xpZW50X2NvX2RyYWluX2VuZC4g
U28gaGVyZSBpcyBhIGxvb3AuDQo+PiArICAgICAgICAgICAgICAgICAqLw0KPj4gKyAgICAgICAg
ICAgICAgICBxZW11X2Nvcm91dGluZV95aWVsZCgpOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsg
ICAgICAgICAgICBiZHJ2X2luY19pbl9mbGlnaHQocy0+YnMpOw0KPj4gKyAgICAgICAgfQ0KPj4g
KyAgICAgICAgaWYgKHRpbWVvdXQgPCBtYXhfdGltZW91dCkgew0KPj4gKyAgICAgICAgICAgIHRp
bWVvdXQgKj0gMjsNCj4+ICsgICAgICAgIH0NCj4gDQo+IEV4cG9uZW50aWFsIGJhY2t1cCwgb2su
ICBJZiBJIHJlYWQgdGhlIGxvb3AgY29ycmVjdGx5LCB5b3UndmUgaGFyZGNvZGVkDQo+IHRoZSBt
YXhfdGltZW91dCBhdCAxNnMsIHdoaWNoIG1lYW5zIHRoZSBvdmVyYWxsIHRpbWVvdXQgaXMgYWJv
dXQgMzBzDQo+IHdoZW4gYWRkaW5nIGluIHRoZSB0aW1lIG9mIHRoZSBlYXJsaWVyIGl0ZXJhdGlv
bnMuICBEb2VzIHRoYXQgbmVlZCB0byBiZQ0KPiB0dW5hYmxlPyAgQnV0IGZvciBub3cgSSBjYW4g
bGl2ZSB3aXRoIGl0Lg0KDQpJIHRoaW5rLCB3ZSBjYW4gYWRkIGFuIG9wdGlvbiBsYXRlciBpZiBu
ZWVkZWQuDQoNCj4gDQo+PiArDQo+PiArICAgICAgICBuYmRfcmVjb25uZWN0X2F0dGVtcHQocyk7
DQo+PiArICAgIH0NCj4+ICAgfQ0KPj4gICANCj4+ICAgc3RhdGljIGNvcm91dGluZV9mbiB2b2lk
IG5iZF9jb25uZWN0aW9uX2VudHJ5KHZvaWQgKm9wYXF1ZSkNCj4+IEBAIC0xNzcsMTYgKzMzMCwy
NiBAQCBzdGF0aWMgY29yb3V0aW5lX2ZuIHZvaWQgbmJkX2Nvbm5lY3Rpb25fZW50cnkodm9pZCAq
b3BhcXVlKQ0KPj4gICAgICAgICAgICAqIFRoZXJlZm9yZSB3ZSBrZWVwIGFuIGFkZGl0aW9uYWwg
aW5fZmxpZ2h0IHJlZmVyZW5jZSBhbGwgdGhlIHRpbWUgYW5kDQo+PiAgICAgICAgICAgICogb25s
eSBkcm9wIGl0IHRlbXBvcmFyaWx5IGhlcmUuDQo+PiAgICAgICAgICAgICovDQo+PiArDQo+PiAr
ICAgICAgICBpZiAobmJkX2NsaWVudF9jb25uZWN0aW5nKHMpKSB7DQo+PiArICAgICAgICAgICAg
bmJkX3JlY29ubmVjdF9sb29wKHMpOw0KPj4gKyAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAg
aWYgKHMtPnN0YXRlICE9IE5CRF9DTElFTlRfQ09OTkVDVEVEKSB7DQo+PiArICAgICAgICAgICAg
Y29udGludWU7DQo+PiArICAgICAgICB9DQo+IA0KPiBJcyAnY29udGludWUnIHJpZ2h0LCBldmVu
IGlmIHMtPnN0YXRlID09IFFVSVQ/DQoNCk5vIG1hdHRlciwgYXMgd2UganVtcCB0byAid2hpbGUg
KHMtPnN0YXRlICE9IE5CRF9DTElFTlRfUVVJVCkgeyIuDQoNCj4gDQo+PiArDQo+PiAgICAgICAg
ICAgYXNzZXJ0KHMtPnJlcGx5LmhhbmRsZSA9PSAwKTsNCj4+ICAgICAgICAgICByZXQgPSBuYmRf
cmVjZWl2ZV9yZXBseShzLT5icywgcy0+aW9jLCAmcy0+cmVwbHksICZsb2NhbF9lcnIpOw0KPj4g
ICANCj4+ICAgICAgICAgICBpZiAobG9jYWxfZXJyKSB7DQo+PiAgICAgICAgICAgICAgIHRyYWNl
X25iZF9yZWFkX3JlcGx5X2VudHJ5X2ZhaWwocmV0LCBlcnJvcl9nZXRfcHJldHR5KGxvY2FsX2Vy
cikpOw0KPj4gICAgICAgICAgICAgICBlcnJvcl9mcmVlKGxvY2FsX2Vycik7DQo+PiArICAgICAg
ICAgICAgbG9jYWxfZXJyID0gTlVMTDsNCj4gDQo+IENvdWxkIGJlIGZ1biBpbiBjb25jZXJ0IHdp
dGggeW91ciBwcm9wb3NhbCB0byBnZXQgcmlkIG9mIGxvY2FsX2VyciA7KQ0KPiBCdXQgaGVyZSwg
d2UgYXJlbid0IHVzaW5nIGVycm9yX3Byb3BhZ2F0ZSgpLg0KDQpBbmQgd2UgZG9uJ3QgaGF2ZSBF
cnJvciAqKmVycnAgcGFyYW1ldGVyIGhlcmUgdG9vLg0KDQo+IA0KPj4gICAgICAgICAgIH0NCj4+
ICAgICAgICAgICBpZiAocmV0IDw9IDApIHsNCj4+ICAgICAgICAgICAgICAgbmJkX2NoYW5uZWxf
ZXJyb3IocywgcmV0ID8gcmV0IDogLUVJTyk7DQo+PiAtICAgICAgICAgICAgYnJlYWs7DQo+PiAr
ICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICAgfQ0KPj4gICANCj4+ICAgICAgICAg
ICAvKg0KPiANCj4gV2UncmUgZ2V0dGluZyByZWFsbHkgY2xvc2UuICBJZiB5b3UgY2FuIGFuc3dl
ciBteSBxdWVzdGlvbnMgYWJvdmUsIGFuZA0KPiB0aGUgb25seSB0aGluZyBsZWZ0IGlzIGFkZGlu
ZyBfY29fIGluIHRoZSBmdW5jdGlvbiBuYW1lLCBJIGNvdWxkIHR3ZWFrDQo+IHRoYXQgbG9jYWxs
eSB0byBzcGFyZSB5b3UgYSB2MTAuICBBdCBhbnkgcmF0ZSwgSSdtIHRlbnRhdGl2ZWx5IHF1ZXVp
bmcNCj4gdGhpcyBvbiBteSBOQkQgdHJlZTsgSSdsbCBwcm9iYWJseSBkbyBhIHB1bGwgcmVxdWVz
dCB0b2RheSB3aXRob3V0IGl0LA0KPiBhbmQgc2F2ZSBpdCBmb3IgbmV4dCB3ZWVrJ3MgUFIgYWZ0
ZXIgSSd2ZSBoYWQgYSB3ZWVrIHRvIGhhbW1lciBvbiBpdCBpbg0KPiBsb2NhbCB0ZXN0cy4NCj4g
DQoNClRoYW5rIHlvdSEgVGhhdCdzIGdyZWF0IQ0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRp
bWlyDQo=


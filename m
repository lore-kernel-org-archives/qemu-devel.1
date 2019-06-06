Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F68C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687DF20665
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FMEnHo7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687DF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYt4N-0001Ux-7v
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 10:08:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYt3T-00017v-W3
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hYt3S-0007V7-Pi
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:07:47 -0400
Received: from mail-eopbgr140094.outbound.protection.outlook.com
	([40.107.14.94]:37703
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hYt3P-000726-Jx; Thu, 06 Jun 2019 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=YaU7I36Q0Yo+5r86tVLf/ikjd8YubwB5hb220i+5M/Q=;
	b=FMEnHo7F/jNNdJTCorR5GV7qyRViBNns0BQF56AAwJLjI21Hmak23ySnHGEdG0uPwBQ/b+EU+SrdeIKO6HBOMekBxrVayZXeKzwH+1LAnH6abhDGXZcfIzI/a5bqDJOlvqM1oFxMdZRItp6csHvDLbFlQWWusqiG8kzdXNsNQl4=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4241.eurprd08.prod.outlook.com (20.179.32.84) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1965.14; Thu, 6 Jun 2019 14:07:25 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011;
	Thu, 6 Jun 2019 14:07:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/3] block: blk_co_pcache
Thread-Index: AQHVHG6Gw8f3OdFEe0GxA9A7ku3zhaaOpkUAgAADMIA=
Date: Thu, 6 Jun 2019 14:07:25 +0000
Message-ID: <dbacab33-ccb4-0c1e-5ce3-7214bd405701@virtuozzo.com>
References: <20190606134814.123689-1-vsementsov@virtuozzo.com>
	<f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
In-Reply-To: <f92b274d-1949-3afa-7353-d3e3d67ae705@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0011.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:3:f7::21) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190606170723130
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52908cc3-522b-4eb1-876e-08d6ea884d68
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4241; 
x-ms-traffictypediagnostic: AM0PR08MB4241:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB42410176A48D2E762606E676C1170@AM0PR08MB4241.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(376002)(346002)(396003)(39850400004)(366004)(53754006)(189003)(199004)(107886003)(229853002)(6306002)(99286004)(54906003)(14454004)(110136005)(102836004)(14444005)(6512007)(256004)(11346002)(6506007)(386003)(2201001)(73956011)(2616005)(66946007)(66476007)(64756008)(486006)(66556008)(66446008)(478600001)(76176011)(53936002)(52116002)(25786009)(6246003)(31686004)(6486002)(2501003)(4326008)(71200400001)(53546011)(71190400001)(6116002)(3846002)(5660300002)(8936002)(81166006)(8676002)(81156014)(316002)(68736007)(86362001)(26005)(186003)(2906002)(66066001)(6436002)(476003)(36756003)(446003)(305945005)(7736002)(31696002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4241;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PY9SeHo1SK08kWToStnzL5GPntSFNatkjs/6D42KEdKdKlpA1n98ZwX4mhDXkGC9TM/nonQmmuP1v3yoWqyJTf9++KmvskEbiGICIpzOeCJDbV/nhoXJ961xl9GgWglcFDCs7moT14YdMcKIPcjv4aK/QwQsA7IanYOZ8LvYEmKCo0Rk6OqbX9tIv4Gw4VIrSGNQ1lGm3i4zMYVMuUx5h+cxTzY6r56DtizYijjw2XNH9enbMsyFtwDyAOvrBUEqxNZXJLazEgV7kiYa98VdRCJnKlmb+ti/+7pfn7APjpxy1WRt0g8CNZV9XfLmLUkRJ+9HIbZVol6qGiCqOdStwdztrjHGS6vVDcbmo60y8mBBng+0WN+5wQ1IvfWFWT5RlfrcVlENC0K4StNjRI67ViiC10n90rOWtouJw94N0bc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0376084DCBDC6F4E875936ACBE090440@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52908cc3-522b-4eb1-876e-08d6ea884d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 14:07:25.6690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.94
Subject: Re: [Qemu-devel] [PATCH 0/3] block: blk_co_pcache
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDYuMjAxOSAxNjo1NSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNi82LzE5IDg6NDggQU0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiBIaSBhbGwhDQo+Pg0KPj4g
SGVyZSBpcyBzbWFsbCBuZXcgaW8gQVBJOiBibGtfY29fcGNhY2hlLCB3aGljaCBkb2VzIGNvcHkt
b24tcmVhZCB3aXRob3V0DQo+PiBleHRyYSBidWZmZXIgZm9yIHJlYWQgZGF0YS4gVGhpcyBtZWFu
cyB0aGF0IG9ubHkgcGFydHMgdGhhdCBuZWVkcyBDT1INCj4+IHdpbGwgYmUgYWN0dWFsbHkgcmVh
ZCBhbmQgb25seSBjb3JyZXNwb25kaW5nIGJ1ZmZlcnMgYWxsb2NhdGVkLCBubyBtb3JlLg0KPj4N
Cj4+IFRoaXMgYWxsb3dzIHRvIGltcHJvdmUgYSBiaXQgYmxvY2stc3RyZWFtIGFuZCBOQkRfQ01E
X0NBQ0hFDQo+IA0KPiBJJ2QgcmVhbGx5IGxpa2UgdG8gc2VlIHFlbXUtaW8gZ2FpbiBhY2Nlc3Mg
dG8gY2FsbGluZyB0aGlzIGNvbW1hbmQsIHNvDQo+IHRoYXQgd2UgY2FuIGFkZCBpb3Rlc3RzIGNv
dmVyYWdlIG9mIHRoaXMgbmV3IGZlYXR1cmUuIE5vdGUgdGhhdCB0aGUNCj4gaW4tZGV2ZWxvcG1l
bnQgbGlibmJkDQo+IChodHRwczovL2dpdGh1Yi5jb20vbGliZ3Vlc3Rmcy9saWJuYmQvY29tbWl0
cy9tYXN0ZXIpIGlzIGFsc28gdXNhYmxlIGFzDQo+IGFuIE5CRCBjbGllbnQgdGhhdCBjYW4gZHJp
dmUgTkJEX0NNRF9DQUNIRSwgYWx0aG91Z2ggaXQncyBzdGlsbCBuZXcNCj4gZW5vdWdoIHRoYXQg
d2UgcHJvYmFibHkgZG9uJ3Qgd2FudCB0byByZWx5IG9uIGl0IGJlaW5nIGF2YWlsYWJsZSB5ZXQu
DQo+IA0KDQpIbW0sIGRvbid0IHlvdSB0aGluayB0aGF0IGJsa19jb19wY2FjaGUgc2VuZHMgTkJE
X0NNRF9DQUNIRSBpZiBjYWxsZWQgb24gbmJkIGRyaXZlcj8NCkkgZGlkbid0IGltcGxlbWVudCBp
dC4gQnV0IG1heSBiZSBJIHNob3VsZC4uDQoNCk1heSBhaW0gd2FzIG9ubHkgdG8gYXZvaWQgZXh0
cmEgYWxsb2NhdGlvbiBhbmQgdW5uZWNlc3NhcnkgcmVhZHMuIEJ1dCBpZiB3ZSBpbXBsZW1lbnQN
CmZ1bGwtZmVhdHVyZWQgaW8gcmVxdWVzdCwgd2hhdCBzaG91bGQgaXQgZG8/DQoNCk9uIHFjb3cy
IHdpdGggYmFja2luZyBpdCBzaG91bGQgcHVsbCBkYXRhIGZyb20gYmFja2luZyB0byB0b3AsIGxp
a2UgaW4gY29weS1vbi1yZWFkLg0KQW5kIGZvciBuYmQgaXQgd2lsbCBzZW5kIE5CRF9DTURfQ0FD
SEU/DQpUaGVzZSBzZW1hbnRpY3Mgc2VlbXMgZGlmZmVyZW50LCBidXQgd2h5IG5vdD8NCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273FC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A62320663
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 15:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q/wycH2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A62320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYdL-0001HG-AC
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 11:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48209)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYcn-0000bk-Hv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYck-0001Ob-GU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 11:22:12 -0400
Received: from mail-eopbgr130131.outbound.protection.outlook.com
 ([40.107.13.131]:64064 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxYcj-0001MS-MY; Tue, 13 Aug 2019 11:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG4/g2ZE2pXJDPt3F3TfGBwGqnIQ2o7b7LADdJpHF1pw6k4jJgSFkrQ0ixhePsuoVH0Y1Ba7W66DcJCtOP915qAkBmFGzkoVpr9cMJ/TEMiV/Y+ucpZD8mNFWH4/Q1SwHxtFHkKLyihFtAkRU7gd8gzurRDQTj1++VFe/RTXOQNB7RvB6KIB23ApbltxJ0Bn6Af9V428QQq3bnYVWDj5XYNoL/vojpkG+FKsCNI+YvsbddgtxLh5k3xOfjkV5umlboRDILo40zMkvvUHBZGVgOmKcVItHeCV9q84E0uAYzpXSHD9/UBxJXpFcWPk7ewxXQwVdPn5XZQ5tkvbNGaSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxt4STXgHAQRQAD6oJAkYtYEcktsONeNMsotKF7AsP0=;
 b=G0fdYIaEITzVTeACbT0xNbxabLoaXVNTIgIf83fPTcXA0UztUekKXHBS7TViDz/fVJ2NWfZy+wBob3+4sDs/hSuiKT0mqOrP0qKYqt1bxRmMtJzhWJ2zuE4idd5OmXRk7q/tugsYsgZLgW73CiG7lPylR5QXZeBI2hSVt7BeQoCXOOMTZNlz1hrKikd7Z0eg1vinaQCJVJNmvqFsbJ4I/+oZhxE0I10fYd7nSwxAWzJiXlwinK4hounlESwMD2bNHClC4OdsUgO/XUeInc8eTWUnG3XvijIAje6BKgwMS/MDoPJYJxC9SVxtcv3ss/Rmh0L4aLmE6FifnJM5V5PYgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxt4STXgHAQRQAD6oJAkYtYEcktsONeNMsotKF7AsP0=;
 b=q/wycH2hr3M+XM1sgmSfIzCZP24CiXo2CwY4tN2OM9gkBK91JREq1Nn3zrJ4ag1s7xdPzXcD7v/Pcj8S9lyjuVER7lz98C5LuqqtO9HA02s/8BN69xHMOjfsN961WeqUflD/grE//n7RPAns/X44HSrJT4wVwDnZdFtMcda1SO0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5196.eurprd08.prod.outlook.com (10.255.19.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 13 Aug 2019 15:22:06 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 15:22:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
Thread-Index: AQHVUTlsaPHpCWSa5ku4nJrwFG1t86b4600AgAA9SACAAANyAIAAAi+AgAAFDoA=
Date: Tue, 13 Aug 2019 15:22:05 +0000
Message-ID: <8346455b-b250-bffd-c79b-ea8363e2116d@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
 <d0b0fc4e-eb2f-796d-3413-366a6bb5aeca@redhat.com>
In-Reply-To: <d0b0fc4e-eb2f-796d-3413-366a6bb5aeca@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:7:29::42) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813182203390
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d0de58c-caf7-4c51-f3d6-08d72001ffed
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5196; 
x-ms-traffictypediagnostic: DB8PR08MB5196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB51962105C502608B1394C2BBC1D20@DB8PR08MB5196.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(396003)(39840400004)(366004)(346002)(189003)(199004)(31696002)(66946007)(6486002)(76176011)(229853002)(316002)(2906002)(5660300002)(66476007)(6436002)(25786009)(66556008)(6512007)(86362001)(6246003)(107886003)(64756008)(66446008)(110136005)(54906003)(52116002)(4326008)(53936002)(71190400001)(6116002)(186003)(81166006)(305945005)(446003)(2616005)(71200400001)(11346002)(6506007)(102836004)(14454004)(7736002)(14444005)(256004)(66066001)(476003)(53546011)(386003)(486006)(8936002)(26005)(36756003)(99286004)(31686004)(3846002)(478600001)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5196;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g9rcbW3SGxe2VL1auCwMH8QHiNh0wpwGxJxqsPHOZ9nEKm+L3ZA3aLP78MPJkoBk3K/pNbs8bHbJ7XO1hksiCkNrFAW4bdpHURe14NMsJSdLxyF+nFP7GSjwasp0nhgPrQ9yUkLvprnkP038RQbSbF5hd6+bXWfrR+iduy6cULTQezRj1i2i/+ehX2TB1lpuCnj2eB5Tg3lBxa7K/DDh3Stg4sWbG4Uvvb7PZa3Et6/1kk8r4whpzrdAO40gXmKySTTGphDaTbTt1s4JbcRx6S8fbHzfgZ8OCHMmNTtAxMQIEYhPa7bNokuvtD/vJ2/tsdBjYvtjDMXrFk4HJP/5QP+zoP2nCFaz4ZMgNC1rZICcwCfwgcVX5RZm3MTw4yuq7qgkqsViMFZLw5deqM1pqy17THNCgOI1sgDUNFioPsU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BCF72D231820944B89D579C18B99F32@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0de58c-caf7-4c51-f3d6-08d72001ffed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 15:22:05.8105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4My6Sf5mKFlzp3y3kJYI43NWftO3peWaMCYMdVHDVIWUsPwassMQIr/Yiqszok0n6gdnI4ga2u0+B+oXEvwJckyiz/3t9PpKnIZVxcgcTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5196
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.131
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxODowMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxNjo1Niwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA4LjIwMTkgMTc6NDMs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMy4wOC4xOSAxMzowNCwgS2V2aW4gV29sZiB3cm90
ZToNCj4+Pj4gQW0gMTIuMDguMjAxOSB1bSAyMDoxMSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4+IEJEUlZfQkxPQ0tfUkFXIG1ha2VzIGdlbmVyaWMg
YmRydl9jb19ibG9ja19zdGF0dXMgdG8gZmFsbHRocm91Z2ggdG8NCj4+Pj4+IHJldHVybmVkIGZp
bGUuIEJ1dCBpcyBpdCBjb3JyZWN0IGJlaGF2aW9yIGF0IGFsbD8gSWYgcmV0dXJuZWQgZmlsZQ0K
Pj4+Pj4gaXRzZWxmIGhhcyBhIGJhY2tpbmcgZmlsZSwgd2UgbWF5IHJlcG9ydCBhcyB0b3RhbGx5
IHVuYWxsb2NhdGVkIGFuZA0KPj4+Pj4gYXJlYSB3aGljaCBhY3R1YWxseSBoYXMgZGF0YSBpbiBi
b3R0b20gYmFja2luZyBmaWxlLg0KPj4+Pj4NCj4+Pj4+IFNvLCBtaXJyb3Jpbmcgb2YgcWNvdzIg
dW5kZXIgcmF3LWZvcm1hdCBpcyBicm9rZW4uIFdoaWNoIGlzIGlsbHVzdHJhdGVkDQo+Pj4+PiBi
eSBmb2xsb3dpbmcgY29tbWl0IHdpdGggYSB0ZXN0LiBMZXQncyBtYWtlIHJhdy1mb3JtYXQgYmVo
YXZlIG1vcmUNCj4+Pj4+IGNvcnJlY3RseSByZXR1cm5pbmcgQkRSVl9CTE9DS19EQVRBLg0KPj4+
Pj4NCj4+Pj4+IFN1Z2dlc3RlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4NCj4+Pj4gQWZ0ZXIgc29tZSByZWFkaW5nLCBJIHRoaW5r
IEkgY2FtZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0IFJBVyBpcyB0aGUNCj4+Pj4gY29ycmVjdCB0
aGluZyB0byBkby4gVGhlcmUgaXMgaW5kZWVkIGEgcHJvYmxlbSwgYnV0IHRoaXMgcGF0Y2ggaXMg
dHJ5aW5nDQo+Pj4+IHRvIGZpeCBpdCBpbiB0aGUgd3JvbmcgcGxhY2UuDQo+Pj4+DQo+Pj4+IElu
IHRoZSBjYXNlIHdoZXJlIHRoZSBiYWNraW5nIGZpbGUgY29udGFpbnMgc29tZSBkYXRhLCBhbmQg
d2UgaGF2ZSBhDQo+Pj4+ICdyYXcnIG5vZGUgYWJvdmUgdGhlIHFjb3cyIG92ZXJsYXkgbm9kZSwg
dGhlIGNvbnRlbnQgb2YgdGhlIHJlc3BlY3RpdmUNCj4+Pj4gYmxvY2sgaXMgbm90IGRlZmluZWQg
YnkgdGhlIHF1ZXJpZWQgYmFja2luZyBmaWxlIGxheWVyLCBzbyBpdCBpcw0KPj4+PiBjb21wbGV0
ZWx5IGNvcnJlY3QgdGhhdCBiZHJ2X2lzX2FsbG9jYXRlZCgpIHJldHVybnMgZmFsc2UsbGlrZSBp
dCB3b3VsZA0KPj4+PiBpZiB5b3UgcXVlcmllZCB0aGUgcWNvdzIgbGF5ZXIgZGlyZWN0bHkuDQo+
Pj4NCj4+PiBJIGRpc2FncmVlLiAgVGhlIHF1ZXJpZWQgYmFja2luZyBmaWxlIGxheWVyIGlzIHRo
ZSByYXcgbm9kZS4gIEFzIEkgc2FpZCwNCj4+PiBpbiBteSBvcGluaW9uIHJhdyBub2RlcyBhcmUg
bm90IGZpbHRlciBub2RlcywgbmVpdGhlciBpbiBiZWhhdmlvciAodGhleQ0KPj4+IGhhdmUgYW4g
b2Zmc2V0IG9wdGlvbiksIG5vciBpbiBob3cgdGhleSBhcmUgZ2VuZXJhbGx5IHVzZWQgKGFzIGEg
Zm9ybWF0KS4NCj4+Pg0KPj4+IFRoZSByYXcgZm9ybWF0IGRvZXMgbm90IHN1cHBvcnQgYmFja2lu
ZyBmaWxlcy4gIFRoZXJlZm9yZSwgZXZlcnl0aGluZyBvbg0KPj4+IGEgcmF3IG5vZGUgaXMgYWxs
b2NhdGVkLg0KPj4+DQo+Pg0KPj4gQ291bGQgeW91IHRlbGwgbWUgYXQgbGVhc3QsIHdoYXQgbWVh
bnMgImFsbG9jYXRlZCIgPw0KPj4NCj4+IEl0J3MgYSB0ZXJtIHRoYXQgZGVzY3JpYmluZyBhIHJl
Z2lvbiBzb21laG93Li4gQnV0IGhvdz8gQWxsb2NhdGVkIHdoZXJlPw0KPj4gSW4gcmF3IG5vZGUs
IGluIGl0cyBjaGlsZCBvciBib3RoPyBBbSBJIHJpZ2h0IHRoYXQgaWYgcmVnaW9uIGFsbG9jYXRl
ZCBpbg0KPj4gb25lIG9mIG5vbi1jb3cgY2hpbGRyZW4gaXQgaXMgYXNzdW1lZCB0byBiZSBhbGxv
Y2F0ZWQgaW4gcGFyZW50IHRvbz8gT3Igd2hhdD8NCj4+DQo+PiBBbmQgaXQncyB1bnJlbGF0ZWQg
dG8gcmVhbCBkaXNrIGFsbG9jYXRpb24gd2hpY2ggKElNSE8pIGRpcmVjdGx5IHNob3dzIHRoYXQN
Cj4+IHRoaXMgYSBiYWQgdGVybS4NCj4gDQo+IEl04oCZcyBhIHRlcm0gZm9yIENPVyBiYWNraW5n
IGNoYWlucy4gIElmIHNvbWV0aGluZyBpcyBhbGxvY2F0ZWQgb24gYQ0KPiBnaXZlbiBub2RlIGlu
IGEgQ09XIGJhY2tpbmcgY2hhaW4sIGl0IG1lYW5zIGl0IGlzIGVpdGhlciBwcmVzZW50IGluDQo+
IGV4YWN0bHkgdGhhdCBub2RlIG9yIGluIG9uZSBvZiBpdHMgc3RvcmFnZSBjaGlsZHJlbiAoaW4g
Y2FzZSB0aGUgbm9kZSBpcw0KPiBhIGZvcm1hdCBub2RlKS4gIElmIGl0IGlzIG5vdCBhbGxvY2F0
ZWQsIGl0IGlzIG5vdCwgYW5kIHJlYWQgYWNjZXNzZXMNCj4gd2lsbCBiZSBmb3J3YXJkZWQgdG8g
dGhlIENPVyBiYWNraW5nIGNoaWxkLg0KPiANCg0KQW5kIHRoaXMgZGVmaW5pdGlvbiBsZWFkcyBl
eGFjdGx5IHRvIGJ1ZyBpbiB0aGVzZSBzZXJpZXM6DQoNCg0KW3Jhd10NCiAgIHwNCiAgIHxmaWxl
DQogICBWICAgICAgIGZpbGUNCltxY293Ml0tLS0tLS0tLS0+W2ZpbGVdDQogICB8DQogICB8YmFj
a2luZw0KICAgVg0KW2Jhc2VdDQoNCg0KQXNzdW1lIHNvbWV0aGluZyBpcyBhY3R1YWxseSBhbGxv
Y2F0ZWQgaW4gW2Jhc2VdIGJ1dCBub3QgaW4gW3Fjb3cyXS4NClNvLCBbcWNvdzJdIG5vZGUgcmVw
b3J0cyBpdCBhcyB1bmFsbG9jYXRlZC4gU28gbm9iZHkgb2YgW3Jhd10ncyBzdG9yYWdlDQpjaGls
ZHJlbiBjb250YWlucyB0aGlzIGFzIGFsbG9jYXRlZCwgc28gaXQncyB1bmFsbG9jYXRlZCBpbiBb
cmF3XS4NCg0KDQpBbmQgaWYgeW91IHNheSB0aGF0IGxvZ2ljIGlzIGRpZmZlcmVudCBmb3IgcmF3
IGFzIGl0IGRvbid0IGhhdmUgQ09XIGNoaWxkLA0Kd2UgbWF5IHB1dCBxY293MiBpbnN0ZWFkIG9m
IHJhdyBoZXJlIHdpdGggc2FtZSBwcm9ibGVtIFt5ZXMsIHFjb3cyIG9uIHFjb3cyDQppcyBhIGJp
dCBzdHJhbmdlLCBidXQgd2UgdHJ5IHRvIG1ha2Ugc29tZXRoaW5nIGdlbmVyaWNdDQoNCg0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


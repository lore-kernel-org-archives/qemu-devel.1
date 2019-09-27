Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D262C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA34206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fNtivBdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA34206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkhB-0003X3-9O
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDkgG-00032M-No
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iDkgE-0001Fu-Un
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:28:44 -0400
Received: from mail-eopbgr140120.outbound.protection.outlook.com
 ([40.107.14.120]:1902 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iDkgE-0001Dr-3h; Fri, 27 Sep 2019 03:28:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlSUJkrwgGACe4IVClzDg4Xc5N1oX5BKPl0Opw7kUXsA6f1i048wA3kGAeuqU1j3767D9Y1o2WCsEBGqHoCss03G0YBrpfmRiNYAu7KjBHik09DGedeJ1Z4UOlGpGngnVSRGAafv91KoH+eP4IQGsWoBYmk4ZUMt/TWXtML1h4ridetcRXworhH4zrazR8W252lnsWyJmYkihXs9If/haUkNQweHFk6I1YnwsZb7cbaOW/rbP85Uyi5maWmASsSI/ZELCzSJMN2m2oKHz8qYdGiO71n3IS1PSwI0qWnuRr2fO7le3dELmoDcsICl7s4xvqHwKZkPU3K96d9gx0fs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WkEKX3TE6tevtLcyPSKBZsqk1DNFniwWcgcjsgMdqM=;
 b=B39ntOSUR51phahRjYd/iGuvMkf01lr1cUDb8u2//0WpHajVEAlqUftlvdHtULT9+F4/yjnwlg/rENyxZZUzV+TVBU/Sbdr6BuTzGNMTSJkA0tDkv3+SgkkSrYtW+YZUW1XOggeZgsJ6Fvdbcvlc0Cv7FDIrMVWVp9bdvS5g1OXf3wRBrCn03j6W9nsFiC/AEQ0d88QzDcTgDgHB7mU752MxrJFcqOb80DbC79A2oY6lp7xB/2FGIq6ZYALH/HZOztlIwyqSnb/M65YLSC0Jwbj4djunq14LrTd0CgITd3KkjMFKFcWsESYIGdBhpcGDaFkT3tcn6TrieO0C73uVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WkEKX3TE6tevtLcyPSKBZsqk1DNFniwWcgcjsgMdqM=;
 b=fNtivBdHNjv5bTZEZHFbfXXv5IMv1jN5p5IMk9uBMT0R1vsp0J71do7LiyVXOGVOMhpDfvUUOrgUSQGeC1mzgTYAqfJJYz3Z3MrbcziNc2A2aNrfzNkxF1CGndCvGNwbwwL9DUfdWEO34GZ2MY7VQsNMermaG1G4a4JRZ8YYNKA=
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com (52.132.215.9) by
 AM0PR08MB3345.eurprd08.prod.outlook.com (52.134.93.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 27 Sep 2019 07:28:37 +0000
Received: from AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75]) by AM0PR08MB5491.eurprd08.prod.outlook.com
 ([fe80::d552:8bd7:4773:3d75%2]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 07:28:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to
 test reopening qcow2 bitmaps to RW
Thread-Topic: [Qemu-devel] [PATCH v4 03/10] iotests: add test-case to 165 to
 test reopening qcow2 bitmaps to RW
Thread-Index: AQHVTSopNDU5oGi3VU6xm0/sCJBvxac+4RqAgACO6YA=
Date: Fri, 27 Sep 2019 07:28:37 +0000
Message-ID: <0db3ca38-65db-c224-e718-210bb910116b@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
 <20190807141226.193501-4-vsementsov@virtuozzo.com>
 <6c308090-5841-fcba-d319-8b9d65b7d6b8@redhat.com>
In-Reply-To: <6c308090-5841-fcba-d319-8b9d65b7d6b8@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0057.eurprd09.prod.outlook.com
 (2603:10a6:3:45::25) To AM0PR08MB5491.eurprd08.prod.outlook.com
 (2603:10a6:208:189::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190927102835326
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96eab440-b757-4ed3-fa3c-08d7431c4faa
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3345; 
x-ms-traffictypediagnostic: AM0PR08MB3345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3345C6A3B67FC3115856CB28C1810@AM0PR08MB3345.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(376002)(346002)(366004)(189003)(199004)(386003)(36756003)(6116002)(102836004)(76176011)(31686004)(52116002)(53546011)(26005)(66066001)(25786009)(229853002)(6436002)(476003)(6506007)(8676002)(446003)(186003)(5660300002)(81156014)(2501003)(478600001)(2906002)(81166006)(4326008)(2616005)(110136005)(54906003)(14444005)(256004)(107886003)(66446008)(66946007)(11346002)(486006)(14454004)(6486002)(31696002)(316002)(305945005)(66476007)(64756008)(7736002)(86362001)(66556008)(8936002)(99286004)(71200400001)(71190400001)(6512007)(3846002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3345;
 H:AM0PR08MB5491.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dwCvavd0EocVXzFZgo2f5YgFiUHYFFdiVzqkQR0M//JHGi3R2T4+Qj/DMwzoEBq+MrRt6B2Z3BS2BC5M2VxANxb9RZDwYmSe2ZUB+RkK3x1G5HaP1FpKG4Pj6VKMFb5kFT34qgfRmnJbzlLQDyON4mq6NPhmr2ZHpho8EPh38uPC9/mMd+05TLopg3EXTZRhyMfoVKDiw0UaVYebNSMXa076noDzcU3FwNXv8dQZYCLHd+ryytW+CxOOjxJ4dMa7G+8YnqDJw4C401up+ydk578l2CznTB77rps7VOUJ4p/l/2dI8kKXxtxLI3fMF3ykDUlfVL4Fkd/T0UPKzgbsfm97znrIvwe6tDkz6UdAnBMM2jmUXuQ9ZlWi9iIPq26c0BPKfqky8hTXXp1RBnZBqbVJ2Ti4MCR2LKMlidyFSIE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D397A13178206846AFCD1E0D09190016@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96eab440-b757-4ed3-fa3c-08d7431c4faa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:28:37.1815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1dY746s9xE+n1ST/wX753KJ2RuuKmq6U8lceYEItVfZ1yZ8PBvhB9diT2zgfSjeZrGABbBmipGMKDN9dl3WpycbmrEyMqclDmH+FaCHInE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3345
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.120
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjcuMDkuMjAxOSAxOjU3LCBKb2huIFNub3cgd3JvdGU6DQo+IA0KPiANCj4gT24gOC83LzE5IDEw
OjEyIEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gUmVvcGVuaW5n
IGJpdG1hcHMgdG8gUlcgd2FzIGJyb2tlbiBwcmlvciB0byBwcmV2aW91cyBjb21taXQuIENoZWNr
IHRoYXQNCj4+IGl0IHdvcmtzIG5vdy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBT
ZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+
ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NSAgICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTY1Lm91dCB8ICA0ICsr
LS0NCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMTY1IGIvdGVzdHMvcWVt
dS1pb3Rlc3RzLzE2NQ0KPj4gaW5kZXggODhmNjJkM2M2ZC4uZGQ5M2I1YTJkMCAxMDA3NTUNCj4+
IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjUNCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0
cy8xNjUNCj4+IEBAIC00MywxMCArNDMsMTAgQEAgY2xhc3MgVGVzdFBlcnNpc3RlbnREaXJ0eUJp
dG1hcChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4+ICAgICAgICAgICBvcy5yZW1vdmUoZGlzaykN
Cj4+ICAgDQo+PiAgICAgICBkZWYgbWtWbShzZWxmKToNCj4+IC0gICAgICAgIHJldHVybiBpb3Rl
c3RzLlZNKCkuYWRkX2RyaXZlKGRpc2spDQo+PiArICAgICAgICByZXR1cm4gaW90ZXN0cy5WTSgp
LmFkZF9kcml2ZShkaXNrLCBvcHRzPSdub2RlLW5hbWU9bm9kZTAnKQ0KPj4gICANCj4+ICAgICAg
IGRlZiBta1ZtUm8oc2VsZik6DQo+PiAtICAgICAgICByZXR1cm4gaW90ZXN0cy5WTSgpLmFkZF9k
cml2ZShkaXNrLCBvcHRzPSdyZWFkb25seT1vbicpDQo+PiArICAgICAgICByZXR1cm4gaW90ZXN0
cy5WTSgpLmFkZF9kcml2ZShkaXNrLCBvcHRzPSdyZWFkb25seT1vbixub2RlLW5hbWU9bm9kZTAn
KQ0KPj4gICANCj4+ICAgICAgIGRlZiBnZXRTaGEyNTYoc2VsZik6DQo+PiAgICAgICAgICAgcmVz
dWx0ID0gc2VsZi52bS5xbXAoJ3gtZGVidWctYmxvY2stZGlydHktYml0bWFwLXNoYTI1NicsDQo+
PiBAQCAtMTAyLDUgKzEwMiw0NyBAQCBjbGFzcyBUZXN0UGVyc2lzdGVudERpcnR5Qml0bWFwKGlv
dGVzdHMuUU1QVGVzdENhc2UpOg0KPj4gICANCj4+ICAgICAgICAgICBzZWxmLnZtLnNodXRkb3du
KCkNCj4+ICAgDQo+PiArICAgIGRlZiB0ZXN0X3Jlb3Blbl9ydyhzZWxmKToNCj4+ICsgICAgICAg
IHNlbGYudm0gPSBzZWxmLm1rVm0oKQ0KPj4gKyAgICAgICAgc2VsZi52bS5sYXVuY2goKQ0KPj4g
KyAgICAgICAgc2VsZi5xbXBBZGRCaXRtYXAoKQ0KPj4gKw0KPj4gKyAgICAgICAgIyBDYWxjdWxh
dGUgc2hhMjU2IGNvcnJlc3BvbmRpbmcgdG8gcmVnaW9uczENCj4+ICsgICAgICAgIHNlbGYud3Jp
dGVSZWdpb25zKHJlZ2lvbnMxKQ0KPj4gKyAgICAgICAgc2hhMjU2ID0gc2VsZi5nZXRTaGEyNTYo
KQ0KPj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWRpcnR5LWJpdG1hcC1j
bGVhcicsIG5vZGU9J2RyaXZlMCcsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBu
YW1lPSdiaXRtYXAwJykNCj4+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1
cm4nLCB7fSkNCj4+ICsNCj4+ICsgICAgICAgIHNlbGYudm0uc2h1dGRvd24oKQ0KPj4gKw0KPj4g
KyAgICAgICAgc2VsZi52bSA9IHNlbGYubWtWbVJvKCkNCj4+ICsgICAgICAgIHNlbGYudm0ubGF1
bmNoKCkNCj4+ICsNCj4+ICsgICAgICAgICMgV2UndmUgbG9hZGVkIGVtcHR5IGJpdG1hcA0KPj4g
KyAgICAgICAgYXNzZXJ0IHNoYTI1NiAhPSBzZWxmLmdldFNoYTI1NigpDQo+PiArDQo+PiArICAg
ICAgICAjIENoZWNrIHRoYXQgd2UgYXJlIGluIFJPIG1vZGUNCj4+ICsgICAgICAgIHNlbGYud3Jp
dGVSZWdpb25zKHJlZ2lvbnMxKQ0KPj4gKyAgICAgICAgYXNzZXJ0IHNoYTI1NiAhPSBzZWxmLmdl
dFNoYTI1NigpDQo+PiArDQo+IA0KPiB0aGUgSE1QIG1vbml0b3IgbGV0cyB5b3UgYXR0ZW1wdCB3
cml0ZXMgdG8gYSBSZWFkIE9ubHkgZHJpdmUuLi4/IE9yIGRvZXMNCj4gaXQgZXJyb3Igb3V0IGFu
ZCB3ZSBqdXN0IGRvbid0IGNoZWNrIHRoZSByZXBseT8NCg0KSXQgbXVzdCBmYWlsIGFuZCB3ZSBj
aGVjayB0aGlzIGJ5IGNvbXBhcmluZyBkaXJ0eSBiaXRtYXAgaGFzaC4NCg0KPiANCj4gSSB3b3Vs
ZCBwcmVmZXIgd2UgdXNlIGFuIGFjdHVhbCBkaXJ0eSBzZWN0b3IgY291bnQgaGVyZSBpbnN0ZWFk
OyB3ZSBoYXZlDQo+IHRoZSBuZXcgQVBJIHRoYXQgc2hvdWxkIG1ha2UgaXQgZWFzeSB0byBkby4N
Cj4gDQo+IElmIHRoZSBkZWJ1ZyBTSEEgY2hhbmdlcyB0aGlzIG1pZ2h0IGJlIGEgbGl0dGxlIGZy
YWdpbGUuDQoNCkhtbSwgSSBhZ3JlZSB0aGF0IGNoZWNraW5nIHRoYXQgYml0bWFwIGlzIGVtcHR5
IGJ5IGNvbXBhcmluZyB3aXRoIHNvbWUgaGFzaA0KaXMgbm90IHZlcnkgcmVsaWFibGUuIFdpbGwg
ZG8uDQoNCj4gDQo+IEFDSyBvdGhlcndpc2UuDQo+IA0KPj4gKyAgICAgICAgcmVzdWx0ID0gc2Vs
Zi52bS5xbXAoJ3gtYmxvY2tkZXYtcmVvcGVuJywgKip7DQo+PiArICAgICAgICAgICAgJ25vZGUt
bmFtZSc6ICdub2RlMCcsDQo+PiArICAgICAgICAgICAgJ2RyaXZlcic6IGlvdGVzdHMuaW1nZm10
LA0KPj4gKyAgICAgICAgICAgICdmaWxlJzogew0KPj4gKyAgICAgICAgICAgICAgICAnZHJpdmVy
JzogJ2ZpbGUnLA0KPj4gKyAgICAgICAgICAgICAgICAnZmlsZW5hbWUnOiBkaXNrDQo+PiArICAg
ICAgICAgICAgfSwNCj4+ICsgICAgICAgICAgICAncmVhZC1vbmx5JzogRmFsc2UNCj4+ICsgICAg
ICAgIH0pDQo+PiArICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30p
DQo+PiArDQo+PiArICAgICAgICAjIENoZWNrIHRoYXQgYml0bWFwIGlzIHJlb3BlbmVkIHRvIFJX
IGFuZCB3ZSBjYW4gd3JpdGUgdG8gaXQuDQo+PiArICAgICAgICBzZWxmLndyaXRlUmVnaW9ucyhy
ZWdpb25zMSkNCj4+ICsgICAgICAgIGFzc2VydCBzaGEyNTYgPT0gc2VsZi5nZXRTaGEyNTYoKQ0K
Pj4gKw0KPj4gKyAgICAgICAgc2VsZi52bS5zaHV0ZG93bigpDQo+PiArDQo+PiArDQo+PiAgIGlm
IF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+PiAgICAgICBpb3Rlc3RzLm1haW4oc3VwcG9ydGVk
X2ZtdHM9WydxY293MiddKQ0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8xNjUu
b3V0IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NS5vdXQNCj4+IGluZGV4IGFlMTIxM2U2ZjguLmZi
YzYzZTYyZjggMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMTY1Lm91dA0KPj4g
KysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzE2NS5vdXQNCj4+IEBAIC0xLDUgKzEsNSBAQA0KPj4g
LS4NCj4+ICsuLg0KPj4gICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAtUmFuIDEgdGVzdHMNCj4+ICtSYW4g
MiB0ZXN0cw0KPj4gICANCj4+ICAgT0sNCj4+DQo+IA0KPiBUaGlzIGlzIGEgc3VnZ2VzdGlvbiBm
b3IgYW4gZXZlbiBtb3JlIHJpZ29yb3VzIHRlc3Q6DQo+IA0KPiAtIENyZWF0ZSBiaXRtYXANCj4g
LSBXcml0ZSBhIHJlZ2lvbiBvciB0d28NCj4gLSBSZWNvcmQgdGhlIGRpcnR5IGNvdW50IGFuZCB0
aGUgU0hBOyBhc3NlcnQgaXQgaXMgZXF1YWwgdG8ga25vd24gLw0KPiBwcmVkZXRlcm1pbmVkIHZh
bHVlcy4NCj4gLSByZW9wZW4gUk8NCj4gLSB2ZXJpZnkgdGhlIGJpdG1hcCBzdGlsbCBleGlzdHMg
YW5kIHRoYXQgdGhlIGhhc2ggYW5kIGNvdW50IGFyZSB0aGUgc2FtZS4NCj4gLSBTdG9wIHRoZSBW
TQ0KPiAtIFN0YXJ0IHRoZSBWTSBpbiByZWFkb25seSBtb2RlDQo+IC0gdmVyaWZ5IHRoZSBiaXRt
YXAgc3RpbGwgZXhpc3RzIGFuZCB0aGF0IHRoZSBoYXNoIGFuZCBjb3VudCBhcmUgdGhlIHNhbWUu
DQo+IC0gUmVvcGVuLVJXDQo+IC0gdmVyaWZ5IHRoZSBiaXRtYXAgc3RpbGwgZXhpc3RzIGFuZCB0
aGF0IHRoZSBoYXNoIGFuZCBjb3VudCBhcmUgdGhlIHNhbWUuDQo+IC0gV3JpdGUgZnVydGhlciBy
ZWdpb24ocykNCj4gLSBHZXQgdGhlIG5ldyBkaXJ0eSBjb3VudCBhbmQgU0hBLCBhbmQgYXNzZXJ0
IGl0IGlzIGVxdWFsIHRvIGtub3duIC8NCj4gcHJlZGV0ZXJtaW5lZCB2YWx1ZXMuDQo+IA0KDQpP
Sw0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


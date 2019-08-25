Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9ECC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 10:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91E4217D7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 10:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="reNFAMIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91E4217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1pXa-00065t-19
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 06:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1pWQ-0005Dk-Fh
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 06:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1i1pWP-0003BN-GN
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 06:13:18 -0400
Received: from mail-eopbgr10122.outbound.protection.outlook.com
 ([40.107.1.122]:31364 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1i1pWL-00036Y-Mo; Sun, 25 Aug 2019 06:13:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKY4/F2W9Psq29bvkA1pYV4ecuOS66lqmbD73C/NcLZNbqdriCJdHg0F+lEi9YXTr4F+WQNLa29BDnBFovY6HnU3iKSw6boFcHvBHZTmQ4uwa4HQDHz3Yd3f1LcSN9CTzTc5IkipZCSfnlKiDVel1ShAJO2wr8QUkgmDPFeZZvJ2GOMuU1+l+G1RC6JafozuMxueSiRyoetnMekzEoZ8L6cCB+fN5UfDxTaXujLeHycK55I5fip1hhZB/noTE2TiKMNWcG0t5C1l7yxTFCo+hGGhBLpAW8w9CchWPxn0eTCZYrfAmiN/4BpUE7p1YYKimhVvBbN/sjrEfNFCnlGwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9fQQauSnH3oSUZYKkVBj/5edvOBR+iDvq3AfMaE+IM=;
 b=GpE5gdSd3l3yifSQoEq9WEaA+p/wPBJXR1FqssFbnomhzAh2aylCydWKyDljNGDqNbDjjYiPTj3nveDGzNi79FSwqLeQ7/P+30sFbRoEk7Rc30rxmOMvPKhrPpusfhwKxCqNLb4IhUIIxYOOazRqKTe70kWnW4F3XqyKtSQToMhK4WLTyHKihT97qpVK4H/OZPpT/ipysxq3hPkvRyLDgXYlUHWw+iHSnlFuO9xrOIK3JZA0cTczF2P71EPE8HtPwOncMScGz+2271G/tbxvsigbf9PF0afJ4X98Qj44o3lyQ3Ew0TLAPDVW47p6noOXYJfgfhavArfJ+koYk1YIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9fQQauSnH3oSUZYKkVBj/5edvOBR+iDvq3AfMaE+IM=;
 b=reNFAMIx0c5MygAnezwwizRjdEPnKKwG6Y92pZNi9o6O3zHWeRUKlanrdq3jWpoHOZw9fh6hc0XrW/eOwptZf1GW6B5apVGmqplzxv04907d1qeKNZVsB4+Db9ekB+8RcLLTE8ZFQeV87IO9+/C0LhBPYh4WciXr7ZJIMfCEJbU=
Received: from AM6PR08MB4391.eurprd08.prod.outlook.com (20.179.18.138) by
 AM6PR08MB3781.eurprd08.prod.outlook.com (20.178.90.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Sun, 25 Aug 2019 10:13:09 +0000
Received: from AM6PR08MB4391.eurprd08.prod.outlook.com
 ([fe80::b4a9:3275:133d:c5a8]) by AM6PR08MB4391.eurprd08.prod.outlook.com
 ([fe80::b4a9:3275:133d:c5a8%3]) with mapi id 15.20.2178.020; Sun, 25 Aug 2019
 10:13:09 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v5 6/6] iotests: extend sleeping time under
 Valgrind
Thread-Index: AQHVPk9L+aGW2bt4m0G0OQXEvFC84qb9H8GAgA6/AYA=
Date: Sun, 25 Aug 2019 10:13:09 +0000
Message-ID: <8ecff9ab-4265-3024-b3ce-12ba7c9e06f2@virtuozzo.com>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <083ece64-0178-fe4a-45df-331257a115fb@redhat.com>
In-Reply-To: <083ece64-0178-fe4a-45df-331257a115fb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:7:29::47) To AM6PR08MB4391.eurprd08.prod.outlook.com
 (2603:10a6:20b:73::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e355ee26-6095-48bc-6b73-08d72944d414
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM6PR08MB3781; 
x-ms-traffictypediagnostic: AM6PR08MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB3781F1336968DC0B481A7BC6F4A60@AM6PR08MB3781.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:289;
x-forefront-prvs: 01401330D1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(346002)(376002)(136003)(199004)(189003)(31696002)(7736002)(11346002)(86362001)(316002)(14454004)(8936002)(2201001)(8676002)(36756003)(446003)(2501003)(3846002)(6116002)(476003)(2616005)(478600001)(81156014)(71200400001)(71190400001)(66556008)(26005)(102836004)(5660300002)(66476007)(4326008)(486006)(44832011)(66946007)(186003)(229853002)(25786009)(66446008)(64756008)(6512007)(14444005)(53546011)(6436002)(53936002)(6486002)(81166006)(6246003)(386003)(305945005)(52116002)(6506007)(107886003)(66066001)(76176011)(256004)(110136005)(31686004)(54906003)(2906002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3781;
 H:AM6PR08MB4391.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JYULgXp8vDQgig7Nbc4+EseTFdIgz8tVvWJ7vt1Lrwt+BNmvmmjrvVGSNKM55qomfcpkGteIJBtMGqElZg/fS+npFkC6MrhazbSzlxWBJQmNP9XMWmxpVP/+SsFPVWfYp93F6Vt9cKN9Uh9F8bpPpqTye9uYWEJ/Y0lavX28TSDvDEzTrzgXi7b1pqCz4QEg0vZxdFF+w5JUNCvZ4zpeQCDa34odmb9GVQZYpJVYYb7EsiZ1ZGpplz+IOtVPLjY913aGCkqy0CrHkXjwykHxOtIJV+1IGtwE87lmPHp/VHC0DSZ6b50BZ1a9bSWzE/47dF+PvvxTzZdahA6SORopCj/SRWDmNVeowS+C8Thk6m1ICtXp8Qvbs4jliwMo9lH8vT6yU/Aejp1b65BpDS7o7NsFYpM8Vp53Unq9hnbu0tU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F06A56E25B9A0F42AC51099FB063A187@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e355ee26-6095-48bc-6b73-08d72944d414
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2019 10:13:09.0436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnhB7nrFxfUDfdZqo0AEK+1vAu+Ia3SAapd9PF9/f7Goh/ZY4XZZrfLA3aNfVbE3aRQ+dGoWRF/tVfJmTeWuM9Otmwa+YGN0EU40ZQ4CPEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3781
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.122
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 6/6] iotests: extend
 sleeping time under Valgrind
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gMTYvMDgvMjAxOSAwNDowMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDcvMTkv
MTkgMTI6MzAgUE0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gVG8gc3luY2hyb25pemUg
dGhlIHRpbWUgd2hlbiBRRU1VIGlzIHJ1bm5pbmcgbG9uZ2VyIHVuZGVyIHRoZSBWYWxncmluZCwN
Cj4+IGluY3JlYXNlIHRoZSBzbGVlcGluZyB0aW1lIGluIHRoZSB0ZXN0IDI0Ny4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVv
enpvLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzI0NyB8IDYgKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0NyBi
L3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDcNCj4+IGluZGV4IDU0NmE3OTQuLmM4NTNiNzMgMTAwNzU1
DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjQ3DQo+PiArKysgYi90ZXN0cy9xZW11LWlv
dGVzdHMvMjQ3DQo+PiBAQCAtNTcsNyArNTcsMTEgQEAgVEVTVF9JTUc9IiRURVNUX0lNRy40IiBf
bWFrZV90ZXN0X2ltZyAkc2l6ZQ0KPj4gICB7ImV4ZWN1dGUiOiJibG9jay1jb21taXQiLA0KPj4g
ICAgImFyZ3VtZW50cyI6eyJkZXZpY2UiOiJmb3JtYXQtNCIsICJ0b3Atbm9kZSI6ICJmb3JtYXQt
MiIsICJiYXNlLW5vZGUiOiJmb3JtYXQtMCIsICJqb2ItaWQiOiJqb2IwIn19DQo+PiAgIEVPRg0K
Pj4gLXNsZWVwIDENCj4+ICtpZiBbICIke1ZBTEdSSU5EX1FFTVV9IiA9PSAieSIgXTsgdGhlbg0K
Pj4gKyAgICBzbGVlcCAxMA0KPj4gK2Vsc2UNCj4+ICsgICAgc2xlZXAgMQ0KPj4gK2ZpDQo+PiAg
IGVjaG8gJ3siZXhlY3V0ZSI6InF1aXQifScNCj4+ICAgKSB8ICRRRU1VIC1xbXAgc3RkaW8gLW5v
Z3JhcGhpYyAtbm9kZWZhdWx0cyBcDQo+PiAgICAgICAtYmxvY2tkZXYgZmlsZSxub2RlLW5hbWU9
ZmlsZS0wLGZpbGVuYW1lPSRURVNUX0lNRy4wLGF1dG8tcmVhZC1vbmx5PW9uIFwNCj4+DQo+IA0K
PiBUaGlzIG1ha2VzIG1lIG5lcnZvdXMsIHRob3VnaC4gV29uJ3QgdGhpcyByYWNlIHRlcnJpYmx5
PyAoV2FpdCwgd2h5DQo+IGRvZXNuJ3QgaXQgcmFjZSBhbHJlYWR5PykNCj4gDQpJdCBtYXliZSBi
ZXR0ZXIgdG8gcmV3cml0ZSB0aGlzIHRlc3QgaW4gUHl0aG9uLg0KVG8gbGV0IGl0IHdvcmsgdW5k
ZXIgVmFsZ3JpbmQgaW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIEkgcmVzZXJ2ZWQgDQpt
b3JlIHNlY29uZHMuIFdlIGNvdWxkIGhhdmUgdGhpcyB0b2xlcmFuY2UganVzdCBmb3IgdGhlIHRl
c3QuDQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtl
dmljaA0K


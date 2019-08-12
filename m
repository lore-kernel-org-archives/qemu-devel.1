Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B1C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A003520651
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="enOxIO35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A003520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9Dt-000105-T1
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hx9DF-00007y-VI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hx9DE-0000wg-OZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:14:09 -0400
Received: from mail-eopbgr60105.outbound.protection.outlook.com
 ([40.107.6.105]:55264 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hx9DE-0000vj-8G; Mon, 12 Aug 2019 08:14:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBcFP+rHoSCJc22obOGXO41l1B2l7bt5Dzzo+mDlwTSdSTK4iKQtb6ihdtIAgh6ShyvmW5v0So3U3I0RRLrucijQZWPAakKtEPTmQDQCxvInONeV4ZAHOuhpLHHWm88uO5VJurwEBRO8lCYMh7UBHOHMHw1C7IzVdZSDqsXZElcM3qm6MhXjbKfCLCkuFnTXNVMKq+1jyTxCYh/HpY9ZXUzvgdrfB2qNV15lhwpqU50oadm3CIKFf4c+s79qhIR3vCDeiZS9Au+J/rCanragPOBrd9/eXsMVZsK0RSn3aIE3sIP2til/2zWa+kmDsNZ5BU149z1sFyw50fV1/stTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRweDFI/POms1RJwOTRTDYz4nlmP1LftW2FYM4rJO/w=;
 b=XKd0iu1m9jvcu4hh/6MkCDQUNQR0sTENzNL92t3jC7+uNaZCYNi5okKzhov/tqd6p0u2DCiaZqMppsnUjNo6cxBfHglK6m2CgcZxM1jokhO/tB+TSuabXaEtYm+GG6Z43ULyf9ZWz5+R2WEMwjWA+52Sp3hk9+qDbrf5sqFruZqxwJxdUgUxjpUd/6DnmMIjuY64zw/VFnk9oDNB6gVdH7htqxBWHGBs394kxSiI7lKMUU2BuHVCf/aCvLfj8Ny5cFcX3OdRXtBM6zRRHyHNmnziWaLmn+jplDW69+tMpSP6OQKHoMOnloVQDWqOAl+lBeSU+EuPhgU1z/L7BE4UvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRweDFI/POms1RJwOTRTDYz4nlmP1LftW2FYM4rJO/w=;
 b=enOxIO35KbzaTG97Q/9qiZ0ldeo9NftMwPWVUIq3W840nzYTo5j1P24kbx31qmuJb3hqSfwwZsbaDQ6BUmY64AXB1qjxgFKy9ML23zInaSRivw3OUJ7wgISYGiHB64Dg5lo+toc4+9p6Ev01+K+SI9CEewtV0SnPyR+cDGNXYoM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5084.eurprd08.prod.outlook.com (10.255.4.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 12:14:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 12:14:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 30/42] qemu-img: Use child access functions
Thread-Index: AQHVTs2mPQbLcZ69wUy4Q/V/qX6mnab3cT8A
Date: Mon, 12 Aug 2019 12:14:04 +0000
Message-ID: <8970b4b2-a81b-aee2-c422-35f39155aa12@virtuozzo.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-31-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-31-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:7:16::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190812151402145
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0166af99-98e8-40a6-e1e0-08d71f1e912c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5084; 
x-ms-traffictypediagnostic: DB8PR08MB5084:
x-microsoft-antispam-prvs: <DB8PR08MB5084121CC41ECFB302B67D55C1D30@DB8PR08MB5084.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:309;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(39840400004)(396003)(366004)(189003)(199004)(66446008)(186003)(5660300002)(446003)(31696002)(66556008)(66946007)(8936002)(486006)(256004)(476003)(64756008)(2616005)(11346002)(386003)(71190400001)(71200400001)(52116002)(6506007)(6512007)(6116002)(2906002)(26005)(3846002)(102836004)(86362001)(14454004)(66476007)(76176011)(4326008)(6436002)(229853002)(31686004)(8676002)(478600001)(6486002)(81156014)(81166006)(99286004)(36756003)(305945005)(2501003)(7736002)(53936002)(25786009)(66066001)(54906003)(110136005)(316002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5084;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yzVhoJwZMkvOr4HegRnhMqlx6wjGm887zOFoDSEt6utHdoWnnYJNmwOZ8eBLZMiVQrt2kMcJuM3rG31ZMZmeCkVKTdbFJyF/dzqCm9y1Yf7PK1hxwUBZU13nUNfRnXmlFyQKfnEoroS5F7mbHwdnQiRNBiZBvptevdBZsjQQI40nE9rN0sMOYD/Pj6ddgDf+JNw0Jfl5MzwITuzIaJh8B6yOjbligBdgsuLT1R2m77Z+h5f//3qfZ2hTfzNKmKDJ4xiPwnA8sch7W0kwQRQ13u6kjIrfBfsifayJLbHef5UdV+gWxc6Cn11IUw99ZQNedMBl7IXcQye2R+9Ti84c31dd3V9TZZCR7UK2lnShCUJI/ggshmRV9mM4NQvyFQidxPHjgYGUfGin8HDBm/UH1/R1/RW48tVtbYmpgc7ZZ7U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <615236AE949E094988B82D7674A80AA7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0166af99-98e8-40a6-e1e0-08d71f1e912c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 12:14:04.3023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4OjhA3CgjYQUGuyD82MFMPmOvbveFFJ3cfEvNvQIWBIfUiC1fjf+DXPHrfiwMQr0nFfvL05e22Y+64xUmcfyz1QieFXRsIV/OeajuVW23I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5084
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.105
Subject: Re: [Qemu-devel] [PATCH v6 30/42] qemu-img: Use child access
 functions
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxOToxMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUaGlzIGNoYW5nZXMgaW90ZXN0
IDIwNCdzIG91dHB1dCwgYmVjYXVzZSBibGtkZWJ1ZyBvbiB0b3Agb2YgYSBDT1cgbm9kZQ0KPiB1
c2VkIHRvIG1ha2UgcWVtdS1pbWcgbWFwIGRpc3JlZ2FyZCB0aGUgcmVzdCBvZiB0aGUgYmFja2lu
ZyBjaGFpbiAodGhlDQo+IGJhY2tpbmcgY2hhaW4gd2FzIGJyb2tlbiBieSB0aGUgZmlsdGVyKS4g
IFdpdGggdGhpcyBwYXRjaCwgdGhlDQo+IGFsbG9jYXRpb24gaW4gdGhlIGJhc2UgaW1hZ2UgaXMg
cmVwb3J0ZWQgY29ycmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgcWVtdS1pbWcuYyAgICAgICAgICAgICAgICAgfCAz
MyArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVz
dHMvMjA0Lm91dCB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyks
IDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3FlbXUtaW1nLmMgYi9xZW11LWlt
Zy5jDQo+IGluZGV4IDc5OTgzNzcyZGUuLjNiMzBjNWFlNzAgMTAwNjQ0DQo+IC0tLSBhL3FlbXUt
aW1nLmMNCj4gKysrIGIvcWVtdS1pbWcuYw0KPiBAQCAtMTAxMiw3ICsxMDEyLDcgQEAgc3RhdGlj
IGludCBpbWdfY29tbWl0KGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gICAgICAgICAgIC8qIFRo
aXMgaXMgZGlmZmVyZW50IGZyb20gUU1QLCB3aGljaCBieSBkZWZhdWx0IHVzZXMgdGhlIGRlZXBl
c3QgZmlsZSBpbg0KPiAgICAgICAgICAgICogdGhlIGJhY2tpbmcgY2hhaW4gKGkuZS4sIHRoZSB2
ZXJ5IGJhc2UpOyBob3dldmVyLCB0aGUgdHJhZGl0aW9uYWwNCj4gICAgICAgICAgICAqIGJlaGF2
aW9yIG9mIHFlbXUtaW1nIGNvbW1pdCBpcyB1c2luZyB0aGUgaW1tZWRpYXRlIGJhY2tpbmcgZmls
ZS4gKi8NCj4gLSAgICAgICAgYmFzZV9icyA9IGJhY2tpbmdfYnMoYnMpOw0KPiArICAgICAgICBi
YXNlX2JzID0gYmRydl9iYWNraW5nX2NoYWluX25leHQoYnMpOw0KPiAgICAgICAgICAgaWYgKCFi
YXNlX2JzKSB7DQo+ICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZygmbG9jYWxfZXJyLCAiSW1hZ2Ug
ZG9lcyBub3QgaGF2ZSBhIGJhY2tpbmcgZmlsZSIpOw0KPiAgICAgICAgICAgICAgIGdvdG8gZG9u
ZTsNCj4gQEAgLTE2MzIsMTggKzE2MzIsMjAgQEAgc3RhdGljIGludCBjb252ZXJ0X2l0ZXJhdGlv
bl9zZWN0b3JzKEltZ0NvbnZlcnRTdGF0ZSAqcywgaW50NjRfdCBzZWN0b3JfbnVtKQ0KPiAgICAg
ICBpZiAocy0+c2VjdG9yX25leHRfc3RhdHVzIDw9IHNlY3Rvcl9udW0pIHsNCj4gICAgICAgICAg
IHVpbnQ2NF90IG9mZnNldCA9IChzZWN0b3JfbnVtIC0gc3JjX2N1cl9vZmZzZXQpICogQkRSVl9T
RUNUT1JfU0laRTsNCj4gICAgICAgICAgIGludDY0X3QgY291bnQ7DQo+ICsgICAgICAgIEJsb2Nr
RHJpdmVyU3RhdGUgKnNyY19icyA9IGJsa19icyhzLT5zcmNbc3JjX2N1cl0pOw0KPiArICAgICAg
ICBCbG9ja0RyaXZlclN0YXRlICpiYXNlOw0KPiArDQo+ICsgICAgICAgIGlmIChzLT50YXJnZXRf
aGFzX2JhY2tpbmcpIHsNCj4gKyAgICAgICAgICAgIGJhc2UgPSBiZHJ2X2ZpbHRlcmVkX2Nvd19i
cyhiZHJ2X3NraXBfcndfZmlsdGVycyhzcmNfYnMpKTsNCj4gKyAgICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgICAgIGJhc2UgPSBOVUxMOw0KPiArICAgICAgICB9DQo+ICAgDQo+ICAgICAgICAg
ICBkbyB7DQo+ICAgICAgICAgICAgICAgY291bnQgPSBuICogQkRSVl9TRUNUT1JfU0laRTsNCj4g
ICANCj4gLSAgICAgICAgICAgIGlmIChzLT50YXJnZXRfaGFzX2JhY2tpbmcpIHsNCj4gLSAgICAg
ICAgICAgICAgICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1cyhibGtfYnMocy0+c3JjW3NyY19jdXJd
KSwgb2Zmc2V0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
dW50LCAmY291bnQsIE5VTEwsIE5VTEwpOw0KPiAtICAgICAgICAgICAgfSBlbHNlIHsNCj4gLSAg
ICAgICAgICAgICAgICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZShibGtfYnMocy0+c3Jj
W3NyY19jdXJdKSwgTlVMTCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBvZmZzZXQsIGNvdW50LCAmY291bnQsIE5VTEwsDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+IC0gICAgICAgICAgICB9
DQo+ICsgICAgICAgICAgICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZShzcmNfYnMsIGJh
c2UsIG9mZnNldCwgY291bnQsICZjb3VudCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE5VTEwsIE5VTEwpOw0KPiAgIA0KPiAgICAgICAgICAgICAgIGlmIChy
ZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAgICAgIGlmIChzLT5zYWx2YWdlKSB7DQo+IEBAIC0y
NDkwLDcgKzI0OTIsOCBAQCBzdGF0aWMgaW50IGltZ19jb252ZXJ0KGludCBhcmdjLCBjaGFyICoq
YXJndikNCj4gICAgICAgICAgICAqIHMudGFyZ2V0X2JhY2tpbmdfc2VjdG9ycyBoYXMgdG8gYmUg
bmVnYXRpdmUsIHdoaWNoIGl0IHdpbGwNCj4gICAgICAgICAgICAqIGJlIGF1dG9tYXRpY2FsbHkp
LiAgVGhlIGJhY2tpbmcgZmlsZSBsZW5ndGggaXMgdXNlZCBvbmx5DQo+ICAgICAgICAgICAgKiBm
b3Igb3B0aW1pemF0aW9ucywgc28gc3VjaCBhIGNhc2UgaXMgbm90IGZhdGFsLiAqLw0KPiAtICAg
ICAgICBzLnRhcmdldF9iYWNraW5nX3NlY3RvcnMgPSBiZHJ2X25iX3NlY3RvcnMob3V0X2JzLT5i
YWNraW5nLT5icyk7DQo+ICsgICAgICAgIHMudGFyZ2V0X2JhY2tpbmdfc2VjdG9ycyA9DQo+ICsg
ICAgICAgICAgICBiZHJ2X25iX3NlY3RvcnMoYmRydl9maWx0ZXJlZF9jb3dfYnMob3V0X2JzKSk7
DQoNCndoeSBub3Qgc2tpcF9yd19maWx0ZXJzPyBJdCB3aWxsIGZhaWwgaWYgb3V0X2JzIGlzIGZp
bHRlci4uDQoNCj4gICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgIHMudGFyZ2V0X2JhY2tpbmdf
c2VjdG9ycyA9IC0xOw0KPiAgICAgICB9DQo+IEBAIC0yODUzLDYgKzI4NTYsNyBAQCBzdGF0aWMg
aW50IGdldF9ibG9ja19zdGF0dXMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIGludDY0X3Qgb2Zmc2V0
LA0KPiAgIA0KPiAgICAgICBkZXB0aCA9IDA7DQo+ICAgICAgIGZvciAoOzspIHsNCj4gKyAgICAg
ICAgYnMgPSBiZHJ2X3NraXBfcndfZmlsdGVycyhicyk7DQo+ICAgICAgICAgICByZXQgPSBiZHJ2
X2Jsb2NrX3N0YXR1cyhicywgb2Zmc2V0LCBieXRlcywgJmJ5dGVzLCAmbWFwLCAmZmlsZSk7DQo+
ICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+
IEBAIC0yODYxLDcgKzI4NjUsNyBAQCBzdGF0aWMgaW50IGdldF9ibG9ja19zdGF0dXMoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsIGludDY0X3Qgb2Zmc2V0LA0KPiAgICAgICAgICAgaWYgKHJldCAmIChC
RFJWX0JMT0NLX1pFUk98QkRSVl9CTE9DS19EQVRBKSkgew0KPiAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgICAgICAgfQ0KPiAtICAgICAgICBicyA9IGJhY2tpbmdfYnMoYnMpOw0KPiArICAg
ICAgICBicyA9IGJkcnZfZmlsdGVyZWRfY293X2JzKGJzKTsNCj4gICAgICAgICAgIGlmIChicyA9
PSBOVUxMKSB7DQo+ICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4gICAgICAgICAgICAgICBicmVh
azsNCj4gQEAgLTMyMTYsNiArMzIyMCw3IEBAIHN0YXRpYyBpbnQgaW1nX3JlYmFzZShpbnQgYXJn
YywgY2hhciAqKmFyZ3YpDQo+ICAgICAgIHVpbnQ4X3QgKmJ1Zl9vbGQgPSBOVUxMOw0KPiAgICAg
ICB1aW50OF90ICpidWZfbmV3ID0gTlVMTDsNCj4gICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMg
PSBOVUxMLCAqcHJlZml4X2NoYWluX2JzID0gTlVMTDsNCj4gKyAgICBCbG9ja0RyaXZlclN0YXRl
ICp1bmZpbHRlcmVkX2JzOw0KPiAgICAgICBjaGFyICpmaWxlbmFtZTsNCj4gICAgICAgY29uc3Qg
Y2hhciAqZm10LCAqY2FjaGUsICpzcmNfY2FjaGUsICpvdXRfYmFzZWZtdCwgKm91dF9iYXNlaW1n
Ow0KPiAgICAgICBpbnQgYywgZmxhZ3MsIHNyY19mbGFncywgcmV0Ow0KPiBAQCAtMzM1MCw2ICsz
MzU1LDggQEAgc3RhdGljIGludCBpbWdfcmViYXNlKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4g
ICAgICAgfQ0KPiAgICAgICBicyA9IGJsa19icyhibGspOw0KPiAgIA0KPiArICAgIHVuZmlsdGVy
ZWRfYnMgPSBiZHJ2X3NraXBfcndfZmlsdGVycyhicyk7DQo+ICsNCj4gICAgICAgaWYgKG91dF9i
YXNlZm10ICE9IE5VTEwpIHsNCj4gICAgICAgICAgIGlmIChiZHJ2X2ZpbmRfZm9ybWF0KG91dF9i
YXNlZm10KSA9PSBOVUxMKSB7DQo+ICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJJbnZhbGlk
IGZvcm1hdCBuYW1lOiAnJXMnIiwgb3V0X2Jhc2VmbXQpOw0KPiBAQCAtMzM2MSw3ICszMzY4LDcg
QEAgc3RhdGljIGludCBpbWdfcmViYXNlKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gICAgICAg
LyogRm9yIHNhZmUgcmViYXNpbmcgd2UgbmVlZCB0byBjb21wYXJlIG9sZCBhbmQgbmV3IGJhY2tp
bmcgZmlsZSAqLw0KPiAgICAgICBpZiAoIXVuc2FmZSkgew0KPiAgICAgICAgICAgUURpY3QgKm9w
dGlvbnMgPSBOVUxMOw0KPiAtICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpiYXNlX2JzID0gYmFj
a2luZ19icyhicyk7DQo+ICsgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2VfYnMgPSBiZHJ2
X2ZpbHRlcmVkX2Nvd19icyh1bmZpbHRlcmVkX2JzKTsNCj4gICANCj4gICAgICAgICAgIGlmIChi
YXNlX2JzKSB7DQo+ICAgICAgICAgICAgICAgYmxrX29sZF9iYWNraW5nID0gYmxrX25ldyhxZW11
X2dldF9haW9fY29udGV4dCgpLA0KPiBAQCAtMzUxNyw3ICszNTI0LDcgQEAgc3RhdGljIGludCBp
bWdfcmViYXNlKGludCBhcmdjLCBjaGFyICoqYXJndikNCj4gICAgICAgICAgICAgICAgICAgICog
SWYgY2x1c3RlciB3YXNuJ3QgY2hhbmdlZCBzaW5jZSBwcmVmaXhfY2hhaW4sIHdlIGRvbid0IG5l
ZWQNCj4gICAgICAgICAgICAgICAgICAgICogdG8gdGFrZSBhY3Rpb24NCj4gICAgICAgICAgICAg
ICAgICAgICovDQo+IC0gICAgICAgICAgICAgICAgcmV0ID0gYmRydl9pc19hbGxvY2F0ZWRfYWJv
dmUoYmFja2luZ19icyhicyksIHByZWZpeF9jaGFpbl9icywNCj4gKyAgICAgICAgICAgICAgICBy
ZXQgPSBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSh1bmZpbHRlcmVkX2JzLCBwcmVmaXhfY2hhaW5f
YnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZh
bHNlLCBvZmZzZXQsIG4sICZuKTsNCj4gICAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsN
Cj4gICAgICAgICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiZXJyb3Igd2hpbGUgcmVhZGlu
ZyBpbWFnZSBtZXRhZGF0YTogJXMiLA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3Rz
LzIwNC5vdXQgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjA0Lm91dA0KPiBpbmRleCBmM2ExMGZiZTkw
Li42ODQ3NzRkNzYzIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMjA0Lm91dA0K
PiArKysgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjA0Lm91dA0KPiBAQCAtNTksNSArNTksNiBAQCBP
ZmZzZXQgICAgICAgICAgTGVuZ3RoICAgICAgICAgIEZpbGUNCj4gICAweDkwMDAwMCAgICAgICAg
MHgyNDAwMDAwICAgICAgIFRFU1RfRElSL3QuSU1HRk1UDQo+ICAgMHgzYzAwMDAwICAgICAgIDB4
MTEwMDAwMCAgICAgICBURVNUX0RJUi90LklNR0ZNVA0KPiAgIDB4NmEwMDAwMCAgICAgICAweDQw
MDAwMCAgICAgICAgVEVTVF9ESVIvdC5JTUdGTVQNCj4gKzB4NmUwMDAwMCAgICAgICAweDEyMDAw
MDAgICAgICAgVEVTVF9ESVIvdC5JTUdGTVQuYmFzZQ0KPiAgIE5vIGVycm9ycyB3ZXJlIGZvdW5k
IG9uIHRoZSBpbWFnZS4NCj4gICAqKiogZG9uZQ0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=


Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D26C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED1D20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DHqwDse2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED1D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3bo-00032K-Mk
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hg3Zm-0001zu-1C
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hg3Zk-0004qr-7T
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:46:45 -0400
Received: from mail-eopbgr130125.outbound.protection.outlook.com
 ([40.107.13.125]:13988 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hg3Zi-0004f2-Nr; Wed, 26 Jun 2019 04:46:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=MZw0sdAgNVRKdSs5Fz5fovZuAxZcB9iHNDSqyL0+zj7ZEuWunD7Jl3jZnPJGVBROAZleq2kEJ0Z2wZEn/iTp9kaxkcLoMA1p7myMHYJTE62PBDUDKRllz8N0AWBuyoRKoq88gmBZBZQpn2J8q5XzxVrRckyNIRIzJshpWzFgErA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+9TXBc8INZcc2F/fI9ok77on+2nBy3XBxjDdupvdu4=;
 b=Cs+2AT3LjbO/C/ts7xYVtVI3k9fyMfQDsM/7oItgyUXhqYsZM1D/Q8vTnJi+HLusMT13EVvyd/7YDlMuhrm0MyYekmpCvZvX6gLWpozqHo+PGNP3iIhImWFu00el/FybWfB3OkVbNmL8bNrR0DkjTFQwbPz6yGxIqF5j/oz8HOg=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+9TXBc8INZcc2F/fI9ok77on+2nBy3XBxjDdupvdu4=;
 b=DHqwDse2pMIL6cZ22yqri73kx93T148hQA/rU8+MQu1l1t/9A9Kl9LDVfiRAU74ujN3mv4s//relmdfTw40Lvs6LSnSyWg9GaYZC7X5rFL36MMnZJ7Y0x50qygN7+iwd1iJ9ddbtUMEdB4xilpcfDIQKBlXq9N4RilEcZfDb0WU=
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (20.178.22.27) by
 AM0PR08MB3138.eurprd08.prod.outlook.com (52.134.126.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 08:46:27 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::44eb:4518:e1f2:144c%7]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 08:46:27 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf
 <kwolf@redhat.com>
Thread-Topic: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
Thread-Index: AQHUjignkofN8gw/f0Gq8XBVqGcZF6V5+nkAgAEUmYCAAa8WAP//4guAgAG9WoCAi/MFgIAfI2CAgArmNACAcq2uAIAAC++AgATlsYCAAuGBgA==
Date: Wed, 26 Jun 2019 08:46:26 +0000
Message-ID: <08004ed8-73ba-1f36-ff46-ba29aba02c66@virtuozzo.com>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
 <20181207122647.GE5119@linux.fritz.box>
 <bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
 <20181212122457.GB5415@linux.fritz.box>
 <d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
 <20181213122039.GC5427@linux.fritz.box>
 <f2fcbcc2-5e0f-053d-f4c7-fe0f5f6092f0@virtuozzo.com>
 <20190313160412.GF5167@linux.fritz.box>
 <101bbf98-0456-5022-e117-fd6f693a8786@virtuozzo.com>
 <20190409100142.GC6610@localhost.localdomain>
 <20190621091656.GA9744@localhost.localdomain>
 <d2ad5561-1806-d885-350a-b43dd0fe4339@virtuozzo.com>
 <ce694324-a2fd-2f03-351a-e54bc05973f1@virtuozzo.com>
In-Reply-To: <ce694324-a2fd-2f03-351a-e54bc05973f1@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0247.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::23) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2d34d1b-efd5-4f7c-fb35-08d6fa12c68e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB3138; 
x-ms-traffictypediagnostic: AM0PR08MB3138:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB313814E7B027A5CDD36A9E49CFE20@AM0PR08MB3138.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(39850400004)(136003)(346002)(189003)(199004)(53546011)(966005)(99286004)(6486002)(52116002)(26005)(31686004)(110136005)(386003)(6506007)(54906003)(68736007)(76176011)(2906002)(186003)(36756003)(66066001)(81156014)(8936002)(316002)(8676002)(7736002)(305945005)(6306002)(256004)(66946007)(6436002)(102836004)(4326008)(81166006)(6512007)(5660300002)(6246003)(25786009)(446003)(64756008)(66556008)(6116002)(3846002)(71200400001)(229853002)(2616005)(476003)(11346002)(486006)(66476007)(53936002)(14454004)(86362001)(71190400001)(478600001)(73956011)(66446008)(31696002)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3138;
 H:AM0PR08MB3745.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XgJUBuTqTcofhuhQ3GfRT1CGfok60A48fmWLt/ECDksqbonVFWvZm35EKyZzyN2CLHg0V28r52asM1UiVFmgMUEZ74Rkzsp0jQjXiu4F3U65zHYkKoyG2Yjo4TfcbFrpm+Kg/s3pqTswl+R0AJ3u9aY94M03QzF/1J03JcbjMS3VDnZRPiYAfYl//1GsTa6YS8w+damXdnA7XEzYm96iY2+8+qKpmVlqRcbCctgsAwHuCLN87zf4tLeCZbCrXjAhMnwJt67hPFW7Wp1iYh10D7v9KAOSKEmgYl1nM1l1RizY10g5DNaqdZqGU821P3BdM/F4zJoaPoX/ffYBhoZOU7TzD2ulTyym/PJ/DAim3x4CPdr4kGwr6bwgODBJRGObO9sP1ybaeBFZftdDz+g19aDQShbFKyjexyVFosD77I8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D2C424EF5FCB049A3477A0006759127@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d34d1b-efd5-4f7c-fb35-08d6fa12c68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 08:46:27.1136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3138
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.125
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI0LjA2LjIwMTkgMTI6NDYsIERlbmlzIFBsb3RuaWtvdiB3cm90ZToNCj4gDQo+IA0K
PiBPbiAyMS4wNi4yMDE5IDEyOjU5LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3Rl
Og0KPj4gMjEuMDYuMjAxOSAxMjoxNiwgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAwOS4wNC4y
MDE5IHVtIDEyOjAxIGhhdCBLZXZpbiBXb2xmIGdlc2NocmllYmVuOg0KPj4+PiBBbSAwMi4wNC4y
MDE5IHVtIDEwOjM1IGhhdCBEZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+PiBPbiAx
My4wMy4yMDE5IDE5OjA0LCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+Pj4+IEFtIDE0LjEyLjIwMTgg
dW0gMTI6NTQgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+Pj4+Pj4gT24gMTMu
MTIuMjAxOCAxNToyMCwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+Pj4+IEFtIDEzLjEyLjIwMTgg
dW0gMTI6MDcgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+Pj4+Pj4+PiBTb3Vu
ZHMgaXQgc2hvdWxkIGJlIHNvLCBidXQgaXQgZG9lc24ndCB3b3JrIHRoYXQgd2F5IGFuZCB0aGF0
J3Mgd2h5Og0KPj4+Pj4+Pj4+IHdoZW4gZG9pbmcgbWlycm9yIHdlIG1heSByZXN1bWUgcG9zdHBv
bmVkIGNvcm91dGluZXMgdG9vIGVhcmx5IHdoZW4gdGhlDQo+Pj4+Pj4+Pj4gdW5kZXJseWluZyBi
cyBpcyBwcm90ZWN0ZWQgZnJvbSB3cml0aW5nIGF0IGFuZCB0aHVzIHdlIGVuY291bnRlciB0aGUN
Cj4+Pj4+Pj4+PiBhc3NlcnQgb24gYSB3cml0ZSByZXF1ZXN0IGV4ZWN1dGlvbiBhdCBiZHJ2X2Nv
X3dyaXRlX3JlcV9wcmVwYXJlIHdoZW4NCj4+Pj4+Pj4+PiByZXN1bWluZyB0aGUgcG9zdHBvbmVk
IGNvcm91dGluZXMuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBUaGUgdGhpbmcgaXMgdGhhdCB0aGUg
YnMgaXMgcHJvdGVjdGVkIGZvciB3cml0aW5nIGJlZm9yZSBleGVjdXRpb24gb2YNCj4+Pj4+Pj4+
PiBiZHJ2X3JlcGxhY2Vfbm9kZSBhdCBtaXJyb3JfZXhpdF9jb21tb24gYW5kIGJkcnZfcmVwbGFj
ZV9ub2RlIGNhbGxzDQo+Pj4+Pj4+Pj4gYmRydl9yZXBsYWNlX2NoaWxkX25vcGVybSB3aGljaCwg
aW4gdHVybiwgY2FsbHMgY2hpbGQtPnJvbGUtPmRyYWluZWRfZW5kDQo+Pj4+Pj4+Pj4gd2hlcmUg
b25lIG9mIHRoZSBjYWxsYmFja3MgaXMgYmxrX3Jvb3RfZHJhaW5lZF9lbmQgd2hpY2ggY2hlY2sN
Cj4+Pj4+Pj4+PiBpZigtLWJsay0+cXVpZXNjZV9jb3VudGVyID09IDApIGFuZCBydW5zIHRoZSBw
b3N0cG9uZWQgcmVxdWVzdHMNCj4+Pj4+Pj4+PiAoY29yb3V0aW5lcykgaWYgdGhlIGNvdW5kaXRp
b24gaXMgdHJ1ZS4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBIbSwgc28gc29tZXRoaW5nIGlzIG1lc3Nl
ZCB1cCB3aXRoIHRoZSBkcmFpbiBzZWN0aW9ucyBpbiB0aGUgbWlycm9yDQo+Pj4+Pj4+PiBkcml2
ZXIuIFdlIGhhdmU6DQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gICAgICAgICAgYmRydl9kcmFpbmVkX2Jl
Z2luKHRhcmdldF9icyk7DQo+Pj4+Pj4+PiAgICAgICAgICBiZHJ2X3JlcGxhY2Vfbm9kZSh0b19y
ZXBsYWNlLCB0YXJnZXRfYnMsICZsb2NhbF9lcnIpOw0KPj4+Pj4+Pj4gICAgICAgICAgYmRydl9k
cmFpbmVkX2VuZCh0YXJnZXRfYnMpOw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IE9idmlvdXNseSwgdGhl
IGludGVudGlvbiB3YXMgdG8ga2VlcCB0aGUgQmxvY2tCYWNrZW5kIGRyYWluZWQgZHVyaW5nDQo+
Pj4+Pj4+PiBiZHJ2X3JlcGxhY2Vfbm9kZSgpLiBTbyBob3cgY291bGQgYmxrLT5xdWllc2NlX2Nv
dW50ZXIgZXZlciBnZXQgdG8gMA0KPj4+Pj4+Pj4gaW5zaWRlIGJkcnZfcmVwbGFjZV9ub2RlKCkg
d2hlbiB0YXJnZXRfYnMgaXMgZHJhaW5lZD8NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBMb29raW5nIGF0
IGJkcnZfcmVwbGFjZV9jaGlsZF9ub3Blcm0oKSwgaXQgc2VlbXMgdGhhdCB0aGUgZnVuY3Rpb24g
aGFzDQo+Pj4+Pj4+PiBhIGJ1ZzogRXZlbiBpZiBvbGRfYnMgYW5kIG5ld19icyBhcmUgYm90aCBk
cmFpbmVkLCB0aGUgcXVpZXNjZV9jb3VudGVyDQo+Pj4+Pj4+PiBmb3IgdGhlIHBhcmVudCByZWFj
aGVzIDAgZm9yIGEgbW9tZW50IGJlY2F1c2Ugd2UgY2FsbCAuZHJhaW5lZF9lbmQgZm9yDQo+Pj4+
Pj4+PiB0aGUgb2xkIGNoaWxkIGZpcnN0IGFuZCAuZHJhaW5lZF9iZWdpbiBmb3IgdGhlIG5ldyBv
bmUgbGF0ZXIuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gU28gaXQgc2VlbXMgdGhlIGZpeCB3b3VsZCBi
ZSB0byByZXZlcnNlIHRoZSBvcmRlciBhbmQgZmlyc3QgY2FsbA0KPj4+Pj4+Pj4gLmRyYWluZWRf
YmVnaW4gZm9yIHRoZSBuZXcgY2hpbGQgYW5kIHRoZW4gLmRyYWluZWRfZW5kIGZvciB0aGUgb2xk
DQo+Pj4+Pj4+PiBjaGlsZC4gU291bmRzIGxpa2UgYSBnb29kIG5ldyB0ZXN0Y2FzZSBmb3IgdGVz
dHMvdGVzdC1iZHJ2LWRyYWluLmMsIHRvby4NCj4+Pj4+Pj4gWWVzLCBpdCdzIHRydWUsIGJ1dCBp
dCdzIG5vdCBlbm91Z2guLi4NCj4+Pj4+Pg0KPj4+Pj4+IERpZCB5b3UgZXZlciBpbXBsZW1lbnQg
dGhlIGNoYW5nZXMgc3VnZ2VzdGVkIHNvIGZhciwgc28gdGhhdCB3ZSBjb3VsZA0KPj4+Pj4+IGNv
bnRpbnVlIGZyb20gdGhlcmU/IE9yIHNob3VsZCBJIHRyeSBhbmQgY29tZSB1cCB3aXRoIHNvbWV0
aGluZyBteXNlbGY/DQo+Pj4+Pg0KPj4+Pj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Li4uDQo+
Pj4+PiBZZXMsIEkgZGlkIC4uLg0KPj4+Pg0KPj4+PiBJZiB0aGVyZSBhcmUgbW9yZSBxdWVzdGlv
biBvciBwcm9ibGVtcywgY2FuIHlvdSBwb3N0IHRoZSBwYXRjaGVzIGluDQo+Pj4+IHRoZWlyIGN1
cnJlbnQgc2hhcGUgKGFzIGFuIFJGQykgb3IgYSBnaXQgVVJMIHNvIEkgY2FuIHBsYXkgd2l0aCBp
dCBhDQo+Pj4+IGJpdD8gSWYgeW91IGNvdWxkIGluY2x1ZGUgYSBmYWlsaW5nIHRlc3QgY2FzZSwg
dG9vLCB0aGF0IHdvdWxkIGJlIGlkZWFsLg0KPj4+DQo+Pj4gRGVuaXM/IFBsZWFzZT8NCj4+Pg0K
Pj4+IFdlIHJlYWxseSBzaG91bGQgZ2V0IHRoaXMgZml4ZWQgYW5kIEkgd291bGQgYmUgd2lsbGlu
ZyB0byBsZW5kIGEgaGFuZCwNCj4+PiBidXQgaWYgeW91IGtlZXAgeW91ciBwYXRjaGVzIHNlY3Jl
dCwgSSBjYW4ndCByZWFsbHkgZG8gc28gYW5kIHdvdWxkIGhhdmUNCj4+PiB0byBkdXBsaWNhdGUg
eW91ciB3b3JrLg0KPj4+DQo+Pj4gQWxzbywgcGxlYXNlIHNlZSBteSBvbGQgYW5zd2VyIGZyb20g
QXByaWwgYmVsb3cgZm9yIHRoZSBsYXN0IHByb2JsZW0geW91DQo+Pj4gaGFkIHdpdGggaW1wbGVt
ZW50aW5nIHRoZSBjb3JyZWN0IGFwcHJvYWNoLg0KPj4+DQo+Pj4gS2V2aW4NCj4gDQo+IEhpIEtl
dmluLA0KPiBJJ20gc29ycnkgZm9yIG5vdCByZXBseWluZyBmb3Igc28gbG9uZy4gUGxlYXNlLCBn
aXZlIG1lIHNvbWUgdGltZSAoYSBkYXkNCj4gb3IgdHdvKSBzbyBJIGNvdWxkIHJlZnJlc2ggZXZl
cnl0aGluZyBhbmQgc2VuZCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUNCj4gcGF0Y2hlcyBhcyB3
ZWxsIGFzIHRoZSB0ZXN0IGNhc2UgY2hlY2tpbmcgdGhlIGlzc3VlDQoNCkhpIEtldmluLA0KVGhl
IGN1cnJlbnQgc3RhdGUgb2YgdGhlIHBhdGNoZXMgaXMgYXZhaWxhYmxlIGF0IA0KaHR0cHM6Ly9n
aXRodWIuY29tL2RlbmlzLXBsb3RuaWtvdi9xZW11L3RyZWUvcG9zdHBvbmVkLXJlcXVlc3QNCg0K
SSBkaWRuJ3QgbWFuYWdlIHRvIGNyZWF0ZSBhbiBhdXRvbWF0aWMgcmVwcm9kdWNlciBidXQgb25l
IG9mIHRoZSBwYXRjaGVzIA0KY29udGFpbnMgYSBzdGVwLWJ5LXN0ZXAgZGVzY3JpcHRpb24gb2Yg
aG93IHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbS4NCg0KUGxlYXNlIHRha2UgYSBsb29rLiBJJ20g
cmVhZHkgdG8gZGlzY3VzcyB0aGUgd2F5cyB0byBpbXByb3ZlIGl0IGFuZCB3aWxsIA0KcmVwbHkg
YXMgZmFzdCBhcyBJIGNhbi4NCg0KVGhhbmtzIQ0KDQpEZW5pcw0KDQoNCj4gDQo+IERlbmlzDQo+
Pg0KPj4gSGUgaXMgbm90IGF0IHdvcmsgdG9kYXksIEkgdGhpbmsgaGUnbGwgYmUgYWJsZSB0byBh
bnN3ZXIgb24gTW9uZGF5Lg0KPj4NCj4+DQo+IA0KDQotLSANCkJlc3QsDQpEZW5pcw0K


Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF31C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A1F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Kmm8L2BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A1F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZwD-0007xa-Tn
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxZvO-0007SQ-SF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxZvN-0006iX-JX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:45:30 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com
 ([40.107.6.125]:63975 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxZvN-0006gT-30; Tue, 13 Aug 2019 12:45:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHI4mF+KL9gN9XQHeURMg5VXoCq42aINdax7rFW2ipBILhqLlD5FCManerfw3SikxmD5GGeZzHNFu4LFvoisqZtGivrFRHW4hwwbCW7vnY4aIhNI1oCouG/rmaLWaMOqiqiinGi9cJuPC5trjCrm1CCZVaAkE0DZyoxhYRqm8Rpdjk57sctPiYQCdKNML1OhAZ+WoaBRtiFr3+hSxaXASpBXaDBnFNuF2AeKqIvjA1JQTNjqxE+9s+1awaK5hOBzIUnDKb431sMwnOuHX9de/ajjRW8I7p7SU7SX9eo5TJKUSk7USyhfqk1RFMnfmaBBem9xpmxrjhlcWyd0n+XqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPtpg5w6u7+/OkqOZ2Yayz7Qq13y9zu7DPC764Vh4I4=;
 b=f9GfDv/Xb6YKAvHnmk3v1LxQy7wWqL1pCaevHfSnJPwTP0AQUcgrW+Xs9gNqm3RrOAXqKMD8TGSk1MTbZivxACMbSv4nY722ZYw+XytuLCM9UPPcCbyIZ4BGjK1kCqmCxAV4oQeQUV1FF1QnNKFC6OHNnRkyNYPMCpKBtzZPBWGqdxNh0VVfQFE5iifrO+VjbJZfMn4atS0/o/lpI6bKQXtQ+lPt3+Vk0Wzy2+Ryese/xyE5pKQ4vGKZ24/ATReE6apAJ98p756pnfOLujGkFinyDtrpuZmh2d7lDJSM1hyLv9QXc/YztDLJ7If1uhnuQaVF9BPsNel9dOhobcji6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPtpg5w6u7+/OkqOZ2Yayz7Qq13y9zu7DPC764Vh4I4=;
 b=Kmm8L2BTTsIxHF7fO87rgo455E8AtsogzoDtOOC3TGT6mF6PQ7h760D/8hE+3uLyUo0HvArTHfHVjStnkGHgHI2fQeT+dOh+ZqoYbnF/3e+Mq/Sc6zo+Udo/CttVK91Pj7zogNo9EJy+p+ykjJpPWdB46dpvldkAGFNOSmeKV/w=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4938.eurprd08.prod.outlook.com (10.255.16.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Tue, 13 Aug 2019 16:45:26 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 16:45:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwCAAAavAIAABzYAgAFqYoCAAAKCAIAANuAA///SwQCAAADLAIAAAHaAgAAIboCAABArgIAABDQA
Date: Tue, 13 Aug 2019 16:45:26 +0000
Message-ID: <699db7d9-f692-cf2c-259f-238a1dd53f51@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
 <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
 <e05af208-c7cb-31e6-bfab-62a44f5281e7@redhat.com>
 <cf9718b9-f36d-27f3-ad49-4f6fb1e1d7b3@virtuozzo.com>
 <9b7a3060-4880-9ef4-89f2-e8327ce655b8@redhat.com>
 <9479f6b6-3cfe-8594-d8fc-9a66c8f799c1@virtuozzo.com>
 <f331ace9-de9f-e5d9-a569-5f50059a522c@redhat.com>
 <cab80946-e12b-b47b-c825-12aef7cee615@virtuozzo.com>
 <e9e8070a-8c76-c8ef-ccd4-a3761f07f0f9@redhat.com>
In-Reply-To: <e9e8070a-8c76-c8ef-ccd4-a3761f07f0f9@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0022.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::35)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813194524237
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3652f935-1767-43b1-0a13-08d7200da49a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4938; 
x-ms-traffictypediagnostic: DB8PR08MB4938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4938C37A90BD945C859E7DEDC1D20@DB8PR08MB4938.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(366004)(39850400004)(346002)(51234002)(189003)(199004)(52314003)(305945005)(486006)(446003)(76176011)(26005)(53546011)(6506007)(102836004)(7736002)(99286004)(66066001)(81156014)(229853002)(81166006)(6486002)(2616005)(8936002)(386003)(52116002)(36756003)(107886003)(2906002)(6512007)(11346002)(6436002)(53936002)(71200400001)(4326008)(71190400001)(25786009)(14444005)(476003)(2501003)(86362001)(6246003)(256004)(64756008)(31686004)(66946007)(66556008)(66446008)(66476007)(5660300002)(14454004)(478600001)(6116002)(3846002)(8676002)(316002)(186003)(110136005)(54906003)(31696002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4938;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I5hK3PUEV2UeW4fjEyEy7fSRvfKpZbCXUVStmuI+Kbo1JE4BbiqK9d78pk6tZ0guqOw8Ex1H9nGAdPzNMk+6U/lO1yG24vLEtLm00jBzELB88N9shff/aCv6728t8aDyykh/LqHRxSJGMV6JHlieCivnp96QUeYFlYEAy68+iIGs7XloLBCGcoCYtM/MbgR6BVr7K0mSrSXaruxTggioNQi5KvNbt1Oll3V/DXHRQX9jQRMrVgEYRPHEv3iR3vAi9MKgH+c5APwhRugni0J2GynJRn3RBisLxbpiVoJHbLVkGapJkk/0Te9qBWcoKFoBfXW1I/S1zPPQ3oAVsT7YZw0Z9eH9Vbhx7XQPSNdccF+kmZoGtZs475MR0sQdjCqV+d2yXcz8SEze/BnRGYwgva80eY/mIF0YF2ENjghPChU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AAFB3CE158B7244A70EEA755905645B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3652f935-1767-43b1-0a13-08d7200da49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 16:45:26.5947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Amm/0QxdcXHZN2+lhQlUMATzB+vG++mowkm3mWNke6ZwQ/0jyoXi4nnKeusSQWU33LluFGCLSH3knfrPb/tBfN2SrvOv9kbcE8O/QJz9cG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4938
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.125
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxOTozMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxNzozMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA4LjIwMTkgMTg6MDIs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMy4wOC4xOSAxNzowMCwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMTMuMDguMjAxOSAxNzo1NywgTWF4IFJlaXR6IHdy
b3RlOg0KPj4+Pj4gT24gMTMuMDguMTkgMTY6MzksIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgd3JvdGU6DQo+Pj4+Pj4gMTMuMDguMjAxOSAxNzoyMywgTWF4IFJlaXR6IHdyb3RlOg0KPj4+
Pj4+PiBPbiAxMy4wOC4xOSAxNjoxNCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+Pj4+Pj4gQnV0IHN0aWxsLi4NCj4+Pj4+Pj4+DQo+Pj4+
Pj4+PiBTeW5jaHJvbm91cyBtaXJyb3IgYWxsb2NhdGVzIGZ1bGwtcmVxdWVzdCBidWZmZXJzIG9u
IGd1ZXN0IHdyaXRlLiBJcyBpdCBjb3JyZWN0Pw0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IElmIHdlIGFz
c3VtZSB0aGF0IGl0IGlzIGNvcnJlY3QgdG8gZG91YmxlIG1lbW9yeSB1c2FnZSBvZiBndWVzdCBv
cGVyYXRpb25zLCB0aGFuIGZvciBiYWNrdXANCj4+Pj4+Pj4+IHRoZSBwcm9ibGVtIGlzIG9ubHkg
aW4gd3JpdGVfemVybyBhbmQgZGlzY2FyZCB3aGVyZSBndWVzdC1hc3N1bWVkIG1lbW9yeSB1c2Fn
ZSBzaG91bGQgYmUgemVyby4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2VsbCwgYnV0IHRoYXQgaXMgdGhl
IHByb2JsZW0uICBJIGRpZG7igJl0IHNheSBhbnl0aGluZyBpbiB2MiwgYmVjYXVzZSBJDQo+Pj4+
Pj4+IG9ubHkgdGhvdWdodCBvZiBub3JtYWwgd3JpdGVzIGFuZCBJIGZvdW5kIGl0IGZpbmUgdG8g
ZG91YmxlIHRoZSBtZW1vcnkNCj4+Pj4+Pj4gdXNhZ2UgdGhlcmUgKGEgZ3Vlc3Qgd29u4oCZdCBp
c3N1ZSBodWdlIHdyaXRlIHJlcXVlc3RzIGluIHBhcmFsbGVsKS4gIEJ1dA0KPj4+Pj4+PiBkaXNj
YXJkL3dyaXRlLXplcm9lcyBhcmUgYSBkaWZmZXJlbnQgbWF0dGVyLg0KPj4+Pj4+Pg0KPj4+Pj4+
Pj4gQW5kIGlmIHdlIHNob3VsZCBkaXN0aW5ndWlzaCB3cml0ZXMgZnJvbSB3cml0ZV96ZXJvZXMg
YW5kIGRpc2NhcmQsIGl0J3MgYmV0dGVyIHRvIHBvc3Rwb25lIHRoaXMNCj4+Pj4+Pj4+IGltcHJv
dmVtZW50IHRvIGJlIGFmdGVyIGJhY2t1cC10b3AgZmlsdGVyIG1lcmdlZC4NCj4+Pj4+Pj4NCj4+
Pj4+Pj4gQnV0IGRvIHlvdSBuZWVkIHRvIGRpc3Rpbmd1aXNoIGl0PyAgV2h5IG5vdCBqdXN0IGtl
ZXAgdHJhY2sgb2YgbWVtb3J5DQo+Pj4+Pj4+IHVzYWdlIGFuZCBwdXQgdGhlIGN1cnJlbnQgSS9P
IGNvcm91dGluZSB0byBzbGVlcCBpbiBhIENvUXVldWUgb3INCj4+Pj4+Pj4gc29tZXRoaW5nLCBh
bmQgd2FrZSB0aGF0IHVwIGF0IHRoZSBlbmQgb2YgYmFja3VwX2RvX2NvdygpPw0KPj4+Pj4+Pg0K
Pj4+Pj4+DQo+Pj4+Pj4gMS4gQmVjYXVzZSBpZiB3ZSBfY2FuXyBhbGxvdyBkb3VibGluZyBvZiBt
ZW1vcnksIGl0J3MgbW9yZSBlZmZlY3RpdmUgdG8gbm90IHJlc3RyaWN0IGFsbG9jYXRpb25zIG9u
DQo+Pj4+Pj4gZ3Vlc3Qgd3JpdGVzLiBJdCdzIGp1c3Qgc2VlbXMgdG8gYmUgbW9yZSBlZmZlY3Rp
dmUgdGVjaG5pcXVlLg0KPj4+Pj4NCj4+Pj4+IEJ1dCB0aGUgcHJvYmxlbSB3aXRoIGJhY2t1cCBh
bmQgemVybyB3cml0ZXMvZGlzY2FyZHMgaXMgdGhhdCB0aGUgbWVtb3J5DQo+Pj4+PiBpcyBub3Qg
ZG91YmxlZC4gIFRoZSByZXF1ZXN0IGRvZXNu4oCZdCBuZWVkIGFueSBtZW1vcnksIGJ1dCB0aGUg
Q0JXDQo+Pj4+PiBvcGVyYXRpb24gZG9lcywgYW5kIG1heWJlIGxvdHMgb2YgaXQuDQo+Pj4+Pg0K
Pj4+Pj4gU28gdGhlIGd1ZXN0IG1heSBpc3N1ZSBtYW55IHplcm8gd3JpdGVzL2Rpc2NhcmRzIGlu
IHBhcmFsbGVsIGFuZCB0aHVzDQo+Pj4+PiBleGhhdXN0IG1lbW9yeSBvbiB0aGUgaG9zdC4NCj4+
Pj4NCj4+Pj4gU28gdGhpcyBpcyB0aGUgcmVhc29uIHRvIHNlcGFyYXRlIHdyaXRlcyBmcm9tIHdy
aXRlLXplcm9zL2Rpc2NyYWRzLiBTbyBhdCBsZWFzdCB3cml0ZSB3aWxsIGJlIGhhcHB5LiBBbmQg
SQ0KPj4+PiB0aGluayB0aGF0IHdyaXRlIGlzIG1vcmUgb2Z0ZW4gcmVxdWVzdCB0aGFuIHdyaXRl
LXplcm8vZGlzY2FyZA0KPj4+DQo+Pj4gQnV0IHRoYXQgbWFrZXMgaXQgY29tcGxpY2F0ZWQgZm9y
IG5vIHByYWN0aWNhbCBnYWluIHdoYXRzb2V2ZXIuDQo+Pj4NCj4+Pj4+DQo+Pj4+Pj4gMi4gQW55
d2F5LCBJJ2QgYWxsb3cgc29tZSBhbHdheXMtYXZhaWxhYmxlIHNpemUgdG8gYWxsb2NhdGUgLSBs
ZXQgaXQgYmUgb25lIGNsdXN0ZXIsIHdoaWNoIHdpbGwgY29ycmVzcG9uZA0KPj4+Pj4+IHRvIGN1
cnJlbnQgYmVoYXZpb3IgYW5kIHByZXZlbnQgZ3Vlc3QgaW8gaGFuZyBpbiB3b3JzdCBjYXNlLg0K
Pj4+Pj4NCj4+Pj4+IFRoZSBndWVzdCB3b3VsZCBvbmx5IGhhbmcgaWYgaXQgd2UgaGF2ZSB0byBj
b3B5IG1vcmUgdGhhbiBlLmcuIDY0IE1CIGF0DQo+Pj4+PiBhIHRpbWUuICBBdCB3aGljaCBwb2lu
dCBJIHRoaW5rIGl04oCZcyBub3QgdW5yZWFzb25hYmxlIHRvIHNlcXVlbnRpYWxpemUNCj4+Pj4+
IHJlcXVlc3RzLg0KPj4+DQo+Pj4gQmVjYXVzZSBvZiB0aGlzLiAgSG93IGlzIGl0IGJhZCB0byBz
dGFydCBzZXF1ZW50aWFsaXppbmcgd3JpdGVzIHdoZW4gdGhlDQo+Pj4gZGF0YSBleGNlZWRzIDY0
IE1CPw0KPj4+DQo+Pg0KPj4gU28geW91IHdhbnQgdG90YWwgbWVtb3J5IGxpbWl0IG9mIDY0IE1C
PyAod2l0aCBwb3NzaWJsZSBwYXJhbWV0ZXIgbGlrZSBpbiBtaXJyb3IpDQo+Pg0KPj4gQW5kIGFs
bG9jYXRpb24gYWxnb3JpdGhtIHRvIGNvcHkgY291bnQgYnl0ZXM6DQo+Pg0KPj4gaWYgZnJlZV9t
ZW0gPj0gY291bnQ6IGFsbG9jYXRlIGNvdW50IGJ5dGVzDQo+PiBlbHNlIGlmIGZyZWVfbWVtID49
IGNsdXN0ZXI6IGFsbG9jYXRlIGNsdXN0ZXIgYW5kIGNvcHkgaW4gYSBsb29wDQo+PiBlbHNlIHdh
aXQgaW4gY28tcXVldWUgdW50aWwgc29tZSBtZW1vcnkgYXZhaWxhYmxlIGFuZCByZXRyeQ0KPj4N
Cj4+IElzIGl0IE9LIGZvciB5b3U/DQo+IA0KPiBTb3VuZHMgZ29vZCB0byBtZSwgYWx0aG91Z2gg
SSBkb27igJl0IGtub3cgd2hldGhlciB0aGUgc2Vjb25kIGJyYW5jaCBpcw0KPiBuZWNlc3Nhcnku
ICBBcyBJ4oCZdmUgc2FpZCwgdGhlIHRvdGFsIGxpbWl0IGlzIGp1c3QgYW4gaW5zdXJhbmNlIGFn
YWluc3QgYQ0KPiBndWVzdCB0aGF0IGRvZXMgc29tZSBjcmF6eSBzdHVmZi4NCj4gDQoNCkknbSBh
ZnJhaWQgdGhhdCBpZiB0aGVyZSB3b3VsZCBiZSBvbmUgYmlnIHJlcXVlc3QgaXQgbWF5IHdhaXQg
Zm9yZXZlciB3aGlsZSBzbWFsbGVyDQpyZXF1ZXN0cyB3aWxsIGVhdCBtb3N0IG9mIGF2YWlsYWJs
ZSBtZW1vcnkuIFNvIGl0IHdvdWxkIGJlIHVuZmFpciBxdWV1ZTogc21hbGxlcg0KcmVxdWVzdHMg
d2lsbCBoYXZlIGhpZ2hlciBwcmlvcml0eSBpbiBsb3cgbWVtb3J5IGNhc2UuIFdpdGggWzJdIGl0
IGJlY29tZXMgbW9yZSBmYWlyLg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A730C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FB421880
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aA0a+O3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FB421880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTG6-0005FR-9G
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 04:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45648)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htTFf-0004lK-6z
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htTFe-0004kt-61
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:49:27 -0400
Received: from mail-eopbgr140092.outbound.protection.outlook.com
 ([40.107.14.92]:3973 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htTFb-0004iO-PI; Fri, 02 Aug 2019 04:49:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgaXp3DZGvQ3WQgkN36AgyOKKzGD6+XUraL3qg7LTfrmWmEjEWJ7AyeoXHAWaL6V0Fh3s6ntq6DTOGMHAaRWaqtvJdTdYCOznA9qJeg2VEWpEQkFquG9/ctyUzpIHu5IiMeMfXYEfoW4LArAs4SfXo9WuIZur6+J+Wg5P9SRS+ikkoQG3d70ibY0zn5etzg3sqOH0klm5WaTsoGOaqKtnM+uZSXwY6F8+U5hKDa6SGTs5BJBHiitXZOMEDqsN1uE4SSxGUZzqDjH9lCccRq/LLHb7Lno6r8zyuBhIB+nQtjgbUTz7gz5UOxgwie5TzwvAL08sDOG4pELwp4GKjb+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eH4q1tiVJWp8KvoDuFdJWvykFhP0w0xXmU+y69u5Lk=;
 b=nmku2rNoPyTxJ50bNrSqMKexJ5m+J/8CMCLgpF8awnuulvU0qox2PkY9ABV8mMtGP8Yvk1OZ9cRKK2yPx3Z8WlPB9SGaSd4yWzDS/loKXGVffezERKqUwpGuBWDuDVXh3J7VKx54Gp/cjjCQurSZyDj+jJOmjEwIkNivx5t1itygC6GPrlZuvDsSV0jn46EE0TDo24mJdeieCckg25l6o0n54rFPB1ke2h/e1hHOnibw3Vs+7hiei4TohXdDAgkMe9qY1Zr8ZMe5F87IibwHs1FANaK/P/EQDQPja68H4RodMlmIzxzKtIyh1gO9/Zblv9Gvkzy6PHQX/JOYFhJ93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eH4q1tiVJWp8KvoDuFdJWvykFhP0w0xXmU+y69u5Lk=;
 b=aA0a+O3stxFlDQAv//qwdZ1L6GXLTJBuhtCplXrcr0uuYI4upcq2VU6xsRqGYvq13VfN1isYrwHTBktbJy7jvFQRf6HvVz8u7tMmW1UxHJNKFy575IN+6KYHP4Qno9I7lvjQLU7qRBGsZYjZ4Rt4qZtP7JvFCl9yj68VGb9I9v0=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3964.eurprd08.prod.outlook.com (20.179.9.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.11; Fri, 2 Aug 2019 08:49:19 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 08:49:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
Thread-Index: AQHVQsoEzSVYPpC2/ESD+i80Sbskiqbkq/cAgAGx3ACAAFUaAIAA5dMA
Date: Fri, 2 Aug 2019 08:49:19 +0000
Message-ID: <3d5b4842-76c1-1945-408f-3c6c696fe691@virtuozzo.com>
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
 <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
 <db90d600-3336-5791-659b-518e88919014@virtuozzo.com>
 <e4011bd5-7b6b-2bc7-4739-699980abdad6@redhat.com>
In-Reply-To: <e4011bd5-7b6b-2bc7-4739-699980abdad6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0026.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190802114916437
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb90562c-4915-4d73-09aa-08d717264e9b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3964; 
x-ms-traffictypediagnostic: DB8PR08MB3964:
x-microsoft-antispam-prvs: <DB8PR08MB39644C6FEB4225A1FE9A08D3C1D90@DB8PR08MB3964.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(346002)(376002)(39850400004)(189003)(199004)(52116002)(5660300002)(54906003)(316002)(2501003)(6486002)(3846002)(66946007)(476003)(76176011)(6116002)(6436002)(6512007)(26005)(81156014)(102836004)(2201001)(8936002)(99286004)(386003)(53546011)(66556008)(6506007)(31696002)(68736007)(110136005)(66066001)(11346002)(71200400001)(81166006)(8676002)(66476007)(2906002)(186003)(36756003)(107886003)(86362001)(14454004)(14444005)(486006)(2616005)(305945005)(31686004)(25786009)(66446008)(7736002)(53936002)(71190400001)(478600001)(64756008)(229853002)(256004)(4326008)(6246003)(446003)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3964;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lh3x+A5tjSP8MUFL6gC1dy1UfK0Y5c6uMuppaHjQjM0SesWFpjwYsBgk8nFhDHFu/Zv7bFaRrIub95kzTBVlU33gs1vn33HbRdsNL3xyLdspGxHu2WOuah62VDYrNLtoi4flxVlKLzg1x7EnQV2ZDJ8Pvh7xajgGmWNdp8APvp5O7LujHzCdLwKXRv2iPLpuIQ6VgrccjhxTt6IrxBU4Dv8wzj8UMjp+rXAzqHQs3LFz4zZcTniNzBhisEXWwTy6+0Eq0KXNTSJiGPumBDiDWfyf6jxqYJUxYikllUhDXbfRdihZgIhEnwsv9NGGTrGx3hzA0Gtef5Vr83oDtDLlck3+QOpewNDq6EsombIbdsFL6iowsCJXyIdZbt8tUV09+xzUt1ZnMiLkcdw0CEtydjcrdOR/hBq8CeGYEL8ek2o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B3C37C6AACF2448821FA13807A4BAA0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb90562c-4915-4d73-09aa-08d717264e9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 08:49:19.3155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3964
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.92
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
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
 "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAyMjowNiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMS4wOC4xOSAxNjowMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDMxLjA3LjIwMTkgMTU6MDks
IE1heCBSZWl0eiB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+IFNvIC0tIHdpdGhvdXQgaGF2
aW5nIHRyaWVkLCBvZiBjb3Vyc2UgLS0gSSB0aGluayBhIGJldHRlciBkZXNpZ24gd291bGQNCj4+
PiBiZSB0byBsb29rIGZvciBicy0+ZmlsZS0+YnMgaW4gdGhlIFJlb3BlblF1ZXVlLCByZWN1cnNp
dmVseSBhbGwgb2YgaXRzDQo+Pj4gY2hpbGRyZW4sIGFuZCBtb3ZlIGFsbCBvZiB0aG9zZSBlbnRy
aWVzIGludG8gYSBuZXcgcXVldWUsIGFuZCB0aGVuDQo+Pj4gaW52b2tlIGJkcnZfcmVvcGVuX211
bHRpcGxlKCkgb24gdGhhdCBvbmUgZmlyc3QuDQo+Pg0KPj4gV2h5IGFsbCBjaGlsZHJlbiByZWN1
cnNpdmVseT8gU2hvdWxkbid0IHdlIGluc3RlYWQgb25seSBmb2xsb3cgZGVmaW5lZA0KPj4gZGVw
ZW5kZW5jaWVzPw0KPj4gT3IgaXQganVzdCBzZWVtcyBiYWQgdG8gcHV0IG5vdCBmdWxsIHN1YnRy
ZWUgaW50byBiZHJ2X3Jlb3BlbiBtdWx0aXBsZSgpID8NCj4gDQo+IEZvciBleGFtcGxlLCBtYWtp
bmcgYSBub2RlIFJXIHdpdGhvdXQgb3BlbmluZyBpdHMgY2hpbGRyZW4gUlcgc2VlbXMNCj4gd3Jv
bmcuICBXaGVuZXZlciB3ZSByZW9wZW4gYSBub2RlLCB3ZSBzaG91bGQgcmVvcGVuIGFsbCBvZiBp
dHMgY2hpbGRyZW4sDQo+IGlmIHRoZXkgYXJlIGluIHRoZSBxdWV1ZS4NCj4gDQo+Pj4gVGhlIHF1
ZXN0aW9uIHRoZW4gYmVjb21lcyBob3cgdG8gcm9sbCBiYWNrIHRob3NlIGNoYW5nZXMuLi4gIEkg
ZG9u4oCZdA0KPj4+IGtub3cgd2hldGhlciBqdXN0IGhhdmluZyBiZHJ2X3Jlb3BlbigpIHBhcnRp
YWxseSBzdWNjZWVkIGlzIHNvIGJhZC4NCj4+PiBPdGhlcndpc2UsIHdl4oCZZCBuZWVkIGEgZnVu
Y3Rpb24gdG8gdHJhbnNsYXRlIGFuIGV4aXN0aW5nIG5vZGUncyBzdGF0ZQ0KPj4+IGludG8gYSBC
ZHJ2UmVvcGVuUXVldWVFbnRyeSBzbyB3ZSBjYW4gdGh1cyByZXR1cm4gdG8gdGhlIG9sZCBzdGF0
ZS4NCj4+DQo+PiBBbmQgdGhpcyByb2xsYmFjayBtYXkgZmFpbCB0b28gYW5kIHdlIGFyZSBzdGls
bCBpbiBwYXJ0aWFsIHN1Y2Nlc3Mgc3RhdGUuDQo+Pg0KPj4gQnV0IGlmIHdlIHJvbGwtYmFjayBz
aW1wbGUgcm8tPnJ3IHJlb3BlbiBpdCdzIHNhZmUgZW5vdWdoOiBpbiB3b3JzdCBjYXNlDQo+PiBm
aWxlIHdpbGwgYmUgcncsIGJ1dCBtYXJrZWQgcm8sIHNvIFFlbXUgbWF5IGhhdmUgbW9yZSBhY2Nl
c3MgcmlnaHRzIHRoYW4NCj4+IG5lZWRlZCBidXQgd2lsbCBub3QgdXNlIHRoZW0sIHRoaXMgaXMg
d2h5IEkgd2FzIGNvbmNlbnRyYXRpbmcgYXJvdW5kDQo+PiBvbmx5IHJvLT5ydyBjYXNlLi4NCj4g
DQo+IEluIHByYWN0aWNlLCB0aGlzIGlzIGFsd2F5cyBzby4gIFRoZSDigJxjaGlsZHJlbiBuZWVk
IHRvIGJlIHJlb3BlbmVkDQo+IGJlZm9yZSBwYXJlbnTigJ0gY2FzZSBpcyBhbHdheXMgYSBzaWdu
IG9mIG1vcmUgcGVybWlzc2lvbnMgYmVpbmcgdGFrZW47DQo+IHdoZXJlYXMg4oCcY2hpbGRyZW4g
bmVlZCB0byBiZSByZW9wZW5lZCBhZnRlciBwYXJlbnTigJ0gaXMgYSBzaWduIG9mDQo+IHBlcm1p
c3Npb25zIGJlaW5nIHJlbGVhc2VkLg0KPiANCj4gV2hhdCB3ZSB3YW50IHRvIGZpeCBub3cgaXMg
dGhlIGZvcm1lciDigJxyZW9wZW4gY2hpbGRyZW4gYmVmb3JlIHBhcmVudOKAnQ0KPiBjYXNlLiAg
QmVjYXVzZSB0aGlzIGlzIGFsd2F5cyBhIHNpZ24gb2YgdGFraW5nIG1vcmUgcGVybWlzc2lvbnMs
IGENCj4gcGFydGlhbCBzdWNjZXNzL2ZhaWx1cmUgc3RhdGUgbWVhbnMgd2UgYWx3YXlzIGhhdmUg
dGFrZW4gbW9yZQ0KPiBwZXJtaXNzaW9ucyB0aGFuIHdlIG5lZWQgdG8uDQoNCk9LLCBJJ2xsIHRy
eS4NCg0KPiANCj4+IFNvLCB3aGF0IGFib3V0IGdvIHNpbWlsYXIgd2F5IHRvIHRoaXMgcGF0Y2gs
IGkuZS4gb25seSByZW9wZW4gcm8tPnJ3IGNoaWxkcmVuDQo+PiB3aGljaCB3ZSBuZWVkIHRvIGJl
IHJ3LCBub3QgdG91Y2hpbmcgb3RoZXIgZmxhZ3MsIGJ1dCBjaGVjaywgdGhhdCBpbiByZW9wZW4N
Cj4+IHF1ZXVlIHdlIGhhdmUgdGhpcyBjaGlsZCwgYW5kIGl0IGlzIGdvaW5nIHRvIGJlIHJlb3Bl
bmVkIFJXLCBhbmQgaWYgbm90LA0KPj4gcmV0dXJuIGVycm9yIGltbWVkaWF0ZWx5Pw0KPiANCj4g
SWYgdGhlIFJPIC0+IFJXIGNoYW5nZSBmb3IgdGhlIGNoaWxkIGlzIGFjY29tcGFuaWVkIGJ5IG90
aGVyIG9wdGlvbnMNCj4gYmVpbmcgY2hhbmdlZCwgdGhlIHVzZXIgbWF5IGZpbmQgaXQgdml0YWwg
dG8gY2hhbmdlIHRoZXNlIGZsYWdzIGFsb25nDQo+IHdpdGggdGhlIFJPL1JXIGFjY2Vzcy4gIFdl
IHNob3VsZG7igJl0IGlnbm9yZSB0aGVtLg0KPiANCg0KSG1tLCB1bmRlcnN0YW5kLCBPSy4NCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


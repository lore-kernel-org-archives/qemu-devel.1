Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14CDC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4CE20657
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 08:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UXKz880q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4CE20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTCx-0003eN-Ld
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htTBx-0002u4-IB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htTBw-00031V-ET
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 04:45:37 -0400
Received: from mail-eopbgr130137.outbound.protection.outlook.com
 ([40.107.13.137]:31201 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htTBs-0002tu-Ge; Fri, 02 Aug 2019 04:45:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQmRo795MQKjXR3RfuR6JuvAoJKba1dFT54/Oz89AW6xLRfJvPHZZbkb6NgKwkTwabqv4Vxol4E9aFyY78dOmEa2/IGWaha7mW/7W4KHUQxqOmzJM3AkHLpK81F/twNLcRRzUgBOGIbGBGaUBGW+lfbldtukYoVw+o0UAxZvPG+mrCa5n9/rWgUXIgiQCvnd3nKhGbAvknqBv06d7/lsitdnxRpW6RYTsC9e48GgKpLGdc8/29JZlo8VbGBmtNjp1qAVkeEEDHAHi37AlqflZl8vKJYtWcX2mTdUQZRl2hPybNNFtmfACuZhSudzgcjmqwQneXCiK09D/LxsfB0/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u1cEjROLN4syH2fVDuvSJbpQv4HP7tff3L1Wb7Skw4=;
 b=O6IEo+HMSTvJyD0lLZgbknY6f4p8Y+b09bjzFKOYFn43PP2j2L+gwhyCi/O2CSbj2CemWSyro72uBr1yLSVHjuVM8J7CoTtz9+jT7x/48EG4x8R4D7rLSeGYP9BEMbOtG7oewYmvOJpxXINM1GW8SOZvlK/qAxsR/Xnz8ODUSGNgIJZBjeHuzqSIH72po5juaqyYOQSLRHlbvMYGZJr+O2BzAE1Y5jQWlt0XJPTRnpUbm8BmOvvS9H17oFUIeapc/ACK2Tr5sjSRyPH3fpxkkU72V+MbF0XJEba8g6S7tyhWtGWG2qAOP679V0SJYF4y2pGw6J0VDSU+eNwixDEn5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u1cEjROLN4syH2fVDuvSJbpQv4HP7tff3L1Wb7Skw4=;
 b=UXKz880qrBhxc7loZl5QYuFl+vYItOjklEq1hUwhoNldvm4B1DqVMZZopwl+CPIec35pqEtS5RII8nEQ/5W/Ar7MCdLFFqmViCsnMbkynus2WAlNKuAA/aR0+mgQyiFUOVQSXDsKJ3oc9l+oFZdIjo+OTeHOU3M8YJVZjafQZkY=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4057.eurprd08.prod.outlook.com (20.179.9.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 2 Aug 2019 08:45:28 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 08:45:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
Thread-Index: AQHVQgPWOM3rZQFWBkKVwWST3b48QqbjkTMAgAMt8wCAANoUAA==
Date: Fri, 2 Aug 2019 08:45:28 +0000
Message-ID: <fabd6c2e-3996-88a4-1b81-33e65ba92ae7@virtuozzo.com>
References: <20190724094025.12442-1-vsementsov@virtuozzo.com>
 <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
 <7a7c668b-eac0-eadd-7065-689c5eae6ce0@redhat.com>
In-Reply-To: <7a7c668b-eac0-eadd-7065-689c5eae6ce0@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0155.eurprd05.prod.outlook.com
 (2603:10a6:7:28::42) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190802114526091
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58a7251d-b504-488d-ef4b-08d71725c509
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4057; 
x-ms-traffictypediagnostic: DB8PR08MB4057:
x-microsoft-antispam-prvs: <DB8PR08MB4057317545DF1C06F14DE188C1D90@DB8PR08MB4057.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(366004)(396003)(376002)(346002)(189003)(199004)(6506007)(81166006)(99286004)(66066001)(66946007)(26005)(76176011)(36756003)(25786009)(6486002)(2616005)(66446008)(186003)(11346002)(102836004)(64756008)(110136005)(3846002)(6116002)(5660300002)(476003)(446003)(66556008)(52116002)(316002)(86362001)(31696002)(2201001)(486006)(71190400001)(53936002)(305945005)(66476007)(31686004)(2906002)(229853002)(6246003)(7736002)(8936002)(6436002)(14454004)(71200400001)(81156014)(386003)(2501003)(53546011)(256004)(8676002)(4326008)(68736007)(478600001)(6512007)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4057;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fgdrdksLWMSTL8A7kifvzgmhPp+6VsTBEOeCvuzCtEjqEZvo+zKzDwJ6Aszdmj30ftoavlBAHznlcaBsgLG1TTtXSCqyHHG/zfZ9cI+kdrBZ9hB9n0Y5yGnGSpwLI09Mwz8Mh229dMs1jivvJT4FYSak66gwgyWhQiQwub3nr+C2VNxzhe3VloJ21LUjrRbc1NnH45Q7z2yKkAGmydeHj+CnJUr97l3jRIwZCwfr245MDrs0XrG/2fJkGtl6sb3wklwinadlZ1V62DIlNcBL3R80EPV1HFERv8jn6tkBHYPHUOSWxVAIP+Vanf5AVrbpMxL7NTYKXSoEe1AqAK/2Pa9BnpamFOIIQ89f5jMccHC4pPbxzhhoxr6Vm1dXTXqSNovYM7PAVdBaq/y7YQfxTAyoK1S+wvdgzlIF53U9EYA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91EDBFE15BB09D47A1FBBEAB866A1E45@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a7251d-b504-488d-ef4b-08d71725c509
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 08:45:28.5988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4057
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.137
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAyMjo0NCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4wNy4xOSAyMToxMSwg
Sm9obiBTbm93IHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA3LzI0LzE5IDU6NDAgQU0sIFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gSW5zdGVhZCBvZiBkcmFpbmluZyBhZGRp
dGlvbmFsIG5vZGVzIGluIGVhY2ggam9iIGNvZGUsIGxldCdzIGRvIGl0IGluDQo+Pj4gY29tbW9u
IGJsb2NrX2pvYl9kcmFpbiwgZHJhaW5pbmcganVzdCBhbGwgam9iJ3MgY2hpbGRyZW4uDQo+Pj4g
QmxvY2tKb2JEcml2ZXIuZHJhaW4gYmVjb21lcyB1bnVzZWQsIHNvLCBkcm9wIGl0IGF0IGFsbC4N
Cj4+Pg0KPj4+IEl0J3MgYWxzbyBhIGZpcnN0IHN0ZXAgdG8gZmluYWxseSBnZXQgcmlkIG9mIGJs
b2Nram9iLT5ibGsuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+PiB2
MzoganVzdCByZXNlbmQsIGFzIEkndmUgc29tZSBhdXRvIHJldHVybmVkIG1haWxzIGFuZCBub3Qg
c3VyZSB0aGF0DQo+Pj4gICAgICB2MiByZWFjaGVkIHJlY2lwaWVudHMuDQo+Pj4NCj4+PiB2Mjog
YXBwbHkgTWF4J3Mgc3VnZ2VzdGlvbnM6DQo+Pj4gICAtIGRyb3AgQmxvY2tKb2JEcml2ZXIuZHJh
aW4NCj4+PiAgIC0gZG8gZmlydGx5IGxvb3Agb2YgYmRydl9kcmFpbmVkX2JlZ2luIGFuZCB0aGVu
IHNlcGFyYXRlIGxvb3ANCj4+PiAgICAgb2YgYmRydl9kcmFpbmVkX2VuZC4NCj4+Pg0KPj4+ICAg
ICBIbW0sIGEgcXVlc3Rpb24gaGVyZTogc2hvdWxkIEkgY2FsbCBiZHJ2X2RyYWluZWRfZW5kIGlu
IHJldmVyc2UNCj4+PiAgICAgb3JkZXI/IE9yIGl0J3MgT0sgYXMgaXM/DQo+Pj4NCj4+DQo+PiBJ
IHRoaW5rIGl0IHNob3VsZCBiZSBPSy4gVGhlc2Ugbm9kZXMgZG9uJ3QgbmVjZXNzYXJpbHkgaGF2
ZSBhIHdlbGwNCj4+IGRlZmluZWQgcmVsYXRpb25zaGlwIGJldHdlZW4gZWFjaCBvdGhlciwgZG8g
dGhleT8NCj4gDQo+IEl04oCZcyBPSy4gIElmIHRoZXkgZG8gaGF2ZSBhIHJlbGF0aW9uc2hpcCwg
dGhlIGRyYWluIGNvZGUgc29ydHMgaXQgb3V0IGJ5DQo+IGl0c2VsZiBhbnl3YXkuDQo+IA0KPiBb
Li4uXQ0KPiANCj4+IFNlZW1zIG11Y2ggbmljZXIgdG8gbWUuIFdoYXQgYmVjb21lcyBvZiB0aGUg
cmVmL3VucmVmIHBhaXJzPw0KPj4NCj4+IEkgZ3Vlc3Mgbm90IG5lZWRlZCBhbnltb3JlPywgc2lu
Y2Ugam9iIGNsZWFudXAgbmVjZXNzYXJpbHkgaGFwcGVucyBpbg0KPj4gdGhlIG1haW4gbG9vcCBj
b250ZXh0IG5vdyBhbmQgd2UgZG9uJ3QgaGF2ZSBhIGJhY2t1cF9jb21wbGV0ZSBmdW5jdGlvbg0K
Pj4gYW55bW9yZSAuLi4/DQo+Pg0KPj4gSW4gdGhlIGNhc2VzIHdoZXJlIGF1dG9fZmluYWxpemU9
dHJ1ZSwgZG8gd2UgaGF2ZSBhbnkgZ3VhcmFudGVlIHRoYXQgdGhlDQo+PiBjb21wbGV0aW9uIGNh
bGxiYWNrcyBjYW5ub3QgYmUgc2NoZWR1bGVkIHdoaWxlIHdlIGFyZSBoZXJlPw0KPiANCj4gTGV0
IG1lIHRyeSB0byBmaWd1cmUgdGhpcyBvdXQuLi4NCj4gDQo+IFRoZSBvbmx5IGNhbGxlciBvZiBi
bG9ja19qb2JfZHJhaW4oKSBpcyBqb2JfZHJhaW4oKSwgd2hvc2Ugb25seSBjYWxsZXINCj4gaXMg
am9iX2ZpbmlzaF9zeW5jKCkgaW4gYW4gQUlPX1dBSVRfV0hJTEUoKSBsb29wLiAgVGhhdCBsb29w
IGNhbiBvbmx5DQo+IHdvcmsgaW4gdGhlIG1haW4gbG9vcCwgc28gSSBzdXBwb3NlIGl0IGRvZXMg
cnVuIGluIHRoZSBtYWluIGxvb3AgKGFuZA0KPiBjb25zZXF1ZW50aWFsbHksIGJsb2NrX2pvYl9k
cmFpbigpIHJ1bnMgaW4gdGhlIG1haW4gbG9vcCwgdG9vKS4NCj4gDQo+IFRoYXQgQUlPX1dBSVRf
V0hJTEUoKSBsb29wIGRyYWlucyB0aGUgam9iIChzbyBhbGwgbm9kZXMpIGFuZCB3YWl0cyB1bnRp
bA0KPiB0aGUgam9iIGhhcyBjb21wbGV0ZWQuICBUbyBtZSB0aGF0IGxvb2tzIGxpa2UgaXQgaXMg
ZGVzaWduZWQgdG8gaGF2ZSB0aGUNCj4gY29tcGxldGlvbiBjYWxsYmFjayBydW4gYXQgc29tZSBw
b2ludC4uLj8NCj4gDQo+IEkgc3VwcG9zZSBhbnl0aGluZyBsaWtlIHRoYXQgaXMgc2NoZWR1bGVk
IGJ5IGpvYl9lbnRlcigpIGluIGpvYl9kcmFpbigpLA0KPiBuYW1lbHkgdGhlIGFpb19jb19lbnRl
cigpIGluIHRoZXJlLg0KPiANCj4gKEEpIElmIHRoZSBqb2IgcnVucyBpbiB0aGUgbWFpbiBBaW9D
b250ZXh0LCBhaW9fY29fZW50ZXIoKSB3aWxsIGVudGVyDQo+IHRoZSBjb3JvdXRpbmUgaWYgd2Ug
ZG8gbm90IHJ1biBpbiBhIGNvcm91dGluZSByaWdodCBub3cgKHNhZmUpLCBvciBpdA0KPiB3aWxs
IHNjaGVkdWxlIGl0IGZvciBhIGxhdGVyIHBvaW50IGlmIHdlIGRvIHJ1biBpbiBhIGNvcm91dGlu
ZS4gIFRoYXQNCj4gbGF0dGVyIHBhcnQgbWF5IGJlIHVuc2FmZSwgYmVjYXVzZSBJIGd1ZXNzIHNv
bWUgY29yb3V0aW5lIHdvcmsgaW4NCj4gYmRydl9kcmFpbmVkX2JlZ2luKCkgb3IgYmRydl9kcmFp
bmVkX2VuZCgpIG1heSB3YWtlIGl0IHVwLCB3aGljaCBjYW4NCj4gdGhlbiBtZXNzIGV2ZXJ5dGhp
bmcgdXAuDQo+IA0KPiAoQikgSWYgdGhlIGpvYiBydW5zIGluIGFub3RoZXIgY29udGV4dCwgYWlv
X2NvX2VudGVyKCkgd2lsbCBzY2hlZHVsZSB0aGUNCj4gam9iIGltbWVkaWF0ZWx5LCB3aGljaCBJ
IGd1ZXNzIG1lYW5zIHRoYXQgaXQgY2FuIHJ1biBhdCBhbnkgcG9pbnQ/ICBTbw0KPiBpdCBjb3Vs
ZCBjb21wbGV0ZSBhdCBhbnkgcG9pbnQsIGluY2x1ZGluZyBibG9ja19qb2JfZHJhaW4oKS4gIEFo
LCBubywNCj4gYWN0dWFsbHkuICBBSU9fV0FJVF9XSElMRSgpIHdpbGwgaGF2ZSB0aGUgam9i4oCZ
cyBjb250ZXh0IGFjcXVpcmVkIHdoaWxlDQo+IGV2YWx1YXRpbmcgdGhlIGNvbmRpdGlvbiAodGhh
dCBpcywgd2hlbiBjYWxsaW5nIGJsb2NrX2pvYl9kcmFpbigpKS4gIFNvDQo+IHRoaXMgaXMgc2Fm
ZS4NCj4gDQo+IA0KPiBTbywgd2VsbC4gIFVubGVzcyBWbGFkaW1pciBjYW4gZ2l2ZSB5b3UgYSBn
dWFyYW50ZWUgd2h5IGUuZy4NCj4gYmxvY2tfam9iX3JlbW92ZV9hbGxfYmRydigpIHdvbuKAmXQg
cnVuIGR1cmluZyBlLmcuIGJkcnZfZHJhaW5lZF9iZWdpbigpLA0KPiBJIHN1cHBvc2UgeW914oCZ
cmUgcmlnaHQgYW5kIHRoZSBub2RlIGxpc3QgbmVlZHMgdG8gYmUgY29waWVkIGF0IHRoZQ0KPiBi
ZWdpbm5pbmcgb2YgdGhpcyBmdW5jdGlvbiBhbmQgYWxsIG5vZGVzIHNob3VsZCBiZSByZWbigJlk
Lg0KPiANCg0KVGhhbmtzIGEgbG90ISBPSywgSSdsbCByZXNlbmQNCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=


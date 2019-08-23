Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0CDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA36E2166E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NAMdLqpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA36E2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15ml-0003TW-TC
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i15lw-00032b-6p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i15lt-0001H8-Lr
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:22:15 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:4003 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i15ls-0001GM-Mu; Fri, 23 Aug 2019 05:22:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDTg5FxCJoMDjsKYBi22AEPpoA6VzJLcWHmvC3zDcqwrh+njgS2UQstJGc1OGvWSgVve5dC0OtErguX4xABD+6FTugZkwULHPHv2z+01X4nMhj7gcH6h5rznkzEXHeoF1VGlmOh2eDTF8RCVcNmN8ZIIJTIEvuUyBpGH888z7s1Fc/Mms3ybtGenvOmNi1hV+O2LW8FyUeUKXHBled+aR+mITU9fe3zvnsL2jTGg02/4hYoEx1ojzINOq9h2WRKfbngDiRv/VlQ0lPn83XuV/1YIDxYzUd+d+ZTTR4hO5gklL0NYwMf7pMoxLWS4q3UrLhmVLX5Xl+s94w+tBHdJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L7pA+JDjhOjSyi2ZP4mNVitLbAaSkIL4HuEoOo2YEI=;
 b=M63u/2lIhB1XlEYW79QZp/0tUgzIq0/LO2y0homYBs8pCp7Ch0y7G8XOZvd/S1aTEngPPwDif5mZh/ZF/yj9zMbq+gf6nhvn/T1jhR8h++eNkn8GlHnw/vni1wZ50DB65lq65l8AfFCpx2KuTFrFYhuUI5DSu6/7WMnZrnXzfCcWnSaTqdKhvJHXGmiStSzFn6XZrOeZLiG7JAmxZJ3AmCLNTF+wKI5d3KdmPm4qMPxT6NVlsC2rq1z043bXQLzzG7UF2FxD7YIavBF45Wx9Zyan9JNSbNQItMjNot4yvRlxs97WGDs63YdkxqTrgz6UmncVRYYBrTvj9QwPcJHJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L7pA+JDjhOjSyi2ZP4mNVitLbAaSkIL4HuEoOo2YEI=;
 b=NAMdLqpF3w7XcIccolJC6ApkIMOFwqMZlZsI0EO4n4P8T2HU47V6Docu7jD2yHgCwNmBvTuHNMvQBhmo+oASEvpRJLu7ixwAFkaVGrMviKg5wY94EWwd3eujMoNMZQ1+11RhJlJFBIpzUhz3u2IymbkE1BoLEQK+KGHAkNva6Fo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5212.eurprd08.prod.outlook.com (20.179.15.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.20; Fri, 23 Aug 2019 09:22:09 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 09:22:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 2/2] qapi: deprecate implicit filters
Thread-Index: AQHVUogdkuEpfSqLt0qlSVbE/q5j26cIg2YA
Date: Fri, 23 Aug 2019 09:22:09 +0000
Message-ID: <de4667c2-7fd7-932d-6ce3-9844f284a0b4@virtuozzo.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190814100735.24234-3-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0203.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190823122206578
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1e97f01-83d8-4d72-5a4a-08d727ab5f71
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5212; 
x-ms-traffictypediagnostic: DB8PR08MB5212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5212021C4964CB03D97C91CBC1A40@DB8PR08MB5212.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(366004)(376002)(39850400004)(396003)(199004)(189003)(52314003)(8936002)(81166006)(81156014)(478600001)(8676002)(86362001)(36756003)(446003)(305945005)(229853002)(7736002)(2351001)(2616005)(2906002)(256004)(14454004)(14444005)(31696002)(486006)(53936002)(4326008)(6246003)(107886003)(6506007)(386003)(5660300002)(25786009)(31686004)(99286004)(64756008)(66556008)(66476007)(71200400001)(66446008)(71190400001)(76176011)(6486002)(52116002)(66946007)(11346002)(476003)(5640700003)(6512007)(6436002)(2501003)(26005)(186003)(6116002)(3846002)(66066001)(316002)(6916009)(102836004)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5212;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VDZsZhZTLqJRNhqCDrQpCcU0WydpYl+XjiKVSinoynV9aILID8DvwCJoqTo26EhWoh20XSNm1FCd0pquLi6ED0Na2b65cd1HAQwm6fRVR4Dz2jXRxDbKHdlgmGkV1pk4bEYfapZmqxLTnHYT9RNm7kVDi3BXxNAOF50f5tka7Xc35o+fmnk1Jeq2kXEKD0+TqqANbCxGdiWk0mW4Vh7jAA+/Ufyl4BorRyyrBOtPVW4q6yA/ATKOK4ITX+zRdqmSHeu94CkQH/ELqKUVk6wXsLV/J1ecLrOcdkhMc/AChtOP9xBrjfjgx/2aZYXgRlpTraA/Jdra9/fZOQsQcPCiyB3SSOMgOUaVpDxx4SLHfZONtN7bYzuoX8kqlud3abW5Z3TObFKXWrW9LkoRcRvXmuyyKZryiKSneuW9NNvgxdc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7A7D85DB1B63B498EC42C05DBCE7517@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e97f01-83d8-4d72-5a4a-08d727ab5f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 09:22:09.3612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urtjf5QA4C057d7gfJ0y00v1kscVtwEAwC26wsQiNMXtA/MqBG7icFD815nFfsygzGbhuzom+p4WM8ZM5klDgm6qKTONT5KVPc4G8gY4lGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5212
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.117
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDguMjAxOSAxMzowNywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
VG8gZ2V0IHJpZCBvZiBpbXBsaWNpdCBmaWx0ZXJzIHJlbGF0ZWQgd29ya2Fyb3VuZHMgaW4gZnV0
dXJlIGxldCdzDQo+IGRlcHJlY2F0ZSB0aGVtIG5vdy4NCg0KSW50ZXJlc3RpbmcsIGNvdWxkIHdl
IGRlcHJlY2F0ZSBpbXBsaWNpdCBmaWx0ZXIgd2l0aG91dCBkZXByZWNhdGlvbiBvZiB1bm5lY2Vz
c2l0eSBvZg0KcGFyYW1ldGVyPyBBcyBhY3R1YWxseSwgaXQncyBnb29kIHdoZW4gdGhpcyBwYXJh
bWV0ZXIgaXMgbm90IG5lY2Vzc2FyeSwgaW4gbW9zdCBjYXNlcw0KdXNlciBpcyBub3QgaW50ZXJl
c3RlZCBpbiBub2RlLW5hbWUuDQoNCk9idmlvdXNseSB3ZSBjYW4gZG8gdGhlIGZvbGxvd2luZzoN
Cg0KMS4gSW4gNC4yIHdlIGRlcHJlY2F0ZSB1bm5lY2Vzc2l0eSwgd2hpY2ggaW1wbGllcyBkZXBy
ZWNhdGlvbiBvZiBpbXBsaWNpdCBmaWx0ZXJzDQoyLiBBZnRlciBzb21lIHJlbGVhc2VzIGluIDQu
eCB3ZSBjYW4gZHJvcCBkZXByZWNhdGVkIGZ1bmN0aW9uYWxpdHksIHNvIHdlIGRyb3AgaXQgdG9n
ZXRoZXIgd2l0aA0KaW1wbGljaXQgZmlsdGVycy4gQW5kLCBpbiBzYW1lIHJlbGVhc2UgNC54IHdl
IHJldHVybiBpdCBiYWNrIChhcyBpdCdzIGNvbXBhdGlibGUgY2hhbmdlIDopDQpidXQgd2l0aG91
dCBpbXBsaWNpdCBmaWx0ZXJzIChzbywgaWYgZmlsdGVyLW5vZGUtbmFtZSBub3Qgc3BlY2lmaWVk
LCB3ZSBqdXN0IGNyZWF0ZQ0KZXhwbGljaXQgZmlsdGVyIHdpdGggYXV0b2dlbmVyYXRlZCBub2Rl
LW5hbWUpDQoNClNvLCBlZmZlY3RpdmVseSB3ZSBqdXN0IGRyb3AgImRlcHJlY2F0aW9uIG1hcmsi
IHRvZ2V0aGVyIHdpdGggaW1wbGljaXQgZmlsdGVycywgd2hpY2ggaXMgbmljZQ0KYnV0IGFjdHVh
bGx5IGNvbmZ1c2luZy4NCg0KSW5zdGVhZCwgd2UgbWF5IGRvDQoxLiBJbiA0LjIgZGVwcmVjYXRl
DQoyLiBJbiA0LnggZHJvcCBvcHRpb25hbGl0eSB0b2dldGhlciB3aXRoIGltcGxpY2l0IGZpbHRl
cnMNCjMuIEluIDQueSAoeSA+IHggb2YgY291cnNlKSByZXR1cm4gb3B0aW9uYWxpdHkgYmFjaw0K
DQpJdCdzIGEgYml0IHNhZmVyLCBidXQgZm9yIHVzZXJzIHdobyBtaXNzIHJlbGVhc2VzIFs0Lngs
IDQueSkgaXQncyBubyBkaWZmZXJlbmNlLi4NCg0KT3Igd2UganVzdCB3cml0ZSBpbiBzcGVjLCB0
aGF0IGltcGxpY2l0IGZpbHRlcnMgYXJlIGRlcHJlY2F0ZWQ/IEJ1dCB3ZSBoYXZlIG5vdGhpbmcg
YWJvdXQgaW1wbGljaXQNCmZpbHRlcnMgaW4gc3BlYy4gTW9yZSBvdmVyLCB3ZSBkaXJlY3RseSB3
cml0ZSB0aGF0IHdlIGhhdmUgZmlsdGVyLCBhbmQgaWYgcGFyYW1ldGVyIGlzIG9taXR0ZWQNCml0
J3Mgbm9kZS1uYW1lIGlzIGF1dG9nZW5lcmF0ZWQuIFNvIGFjdHVhbGx5LCB0aGUgZmFjdCB0aGUg
ZmlsdGVyIGlzIGhpZGRlbiB3aGVuIGZpbHRlci1ub2RlLW5hbWUgaXMNCnVuc3BlY2lmaWVkIGlz
IF91bmRvY3VtZW50ZWRfLg0KDQpTbywgZmluYWxseSwgaXQgbG9va3MgbGlrZSBub3RoaW5nIHRv
IGRlcHJlY2F0ZWQgaW4gc3BlY2lmaWNhdGlvbiwgd2UgY2FuIGp1c3QgZHJvcCBpbXBsaWNpdCBm
aWx0ZXJzIDopDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+
IC0tLQ0KPiAgIHFlbXUtZGVwcmVjYXRlZC50ZXhpICAgICAgfCAgNyArKysrKysrDQo+ICAgcWFw
aS9ibG9jay1jb3JlLmpzb24gICAgICB8ICA2ICsrKystLQ0KPiAgIGluY2x1ZGUvYmxvY2svYmxv
Y2tfaW50LmggfCAxMCArKysrKysrKystDQo+ICAgYmxvY2tkZXYuYyAgICAgICAgICAgICAgICB8
IDEwICsrKysrKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvcWVtdS1kZXByZWNhdGVkLnRleGkgYi9x
ZW11LWRlcHJlY2F0ZWQudGV4aQ0KPiBpbmRleCAyNzUzZmFmZDBiLi44MjIyNDQwMTQ4IDEwMDY0
NA0KPiAtLS0gYS9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KPiArKysgYi9xZW11LWRlcHJlY2F0ZWQu
dGV4aQ0KPiBAQCAtMTgzLDYgKzE4MywxMyBAQCB0aGUgJ3dhaXQnIGZpZWxkLCB3aGljaCBpcyBv
bmx5IGFwcGxpY2FibGUgdG8gc29ja2V0cyBpbiBzZXJ2ZXIgbW9kZQ0KPiAgIA0KPiAgIFVzZSBi
bG9ja2Rldi1taXJyb3IgYW5kIGJsb2NrZGV2LWJhY2t1cCBpbnN0ZWFkLg0KPiAgIA0KPiArQHN1
YnNlY3Rpb24gaW1wbGljaXQgZmlsdGVycyAoc2luY2UgNC4yKQ0KPiArDQo+ICtNaXJyb3IgYW5k
IGNvbW1pdCBqb2JzIGluc2VydHMgZmlsdGVycywgd2hpY2ggYmVjb21lcyBpbXBsaWNpdCBpZiB1
c2VyDQo+ICtvbWl0dGVkIGZpbHRlci1ub2RlLW5hbWUgcGFyYW1ldGVyLiBTbyBvbWl0dGluZyBp
dCBpcyBkZXByZWNhdGVkLCBzZXQgaXQNCj4gK2Fsd2F5cy4gTm90ZSwgdGhhdCBkcml2ZS1taXJy
b3IgZG9uJ3QgaGF2ZSB0aGlzIHBhcmFtZXRlciwgc28gaXQgd2lsbA0KPiArY3JlYXRlIGltcGxp
Y2l0IGZpbHRlciBhbnl3YXksIGJ1dCBkcml2ZS1taXJyb3IgaXMgZGVwcmVjYXRlZCBpdHNlbGYg
dG9vLg0KPiArDQo+ICAgQHNlY3Rpb24gSHVtYW4gTW9uaXRvciBQcm90b2NvbCAoSE1QKSBjb21t
YW5kcw0KPiAgIA0KPiAgIEBzdWJzZWN0aW9uIFRoZSBodWJfaWQgcGFyYW1ldGVyIG9mICdob3N0
ZndkX2FkZCcgLyAnaG9zdGZ3ZF9yZW1vdmUnIChzaW5jZSAzLjEpDQo+IGRpZmYgLS1naXQgYS9x
YXBpL2Jsb2NrLWNvcmUuanNvbiBiL3FhcGkvYmxvY2stY29yZS5qc29uDQo+IGluZGV4IDRlMzU1
MjY2MzQuLjA1MDVhYzlkOGIgMTAwNjQ0DQo+IC0tLSBhL3FhcGkvYmxvY2stY29yZS5qc29uDQo+
ICsrKyBiL3FhcGkvYmxvY2stY29yZS5qc29uDQo+IEBAIC0xNTk2LDcgKzE1OTYsOCBAQA0KPiAg
ICMgQGZpbHRlci1ub2RlLW5hbWU6IHRoZSBub2RlIG5hbWUgdGhhdCBzaG91bGQgYmUgYXNzaWdu
ZWQgdG8gdGhlDQo+ICAgIyAgICAgICAgICAgICAgICAgICAgZmlsdGVyIGRyaXZlciB0aGF0IHRo
ZSBjb21taXQgam9iIGluc2VydHMgaW50byB0aGUgZ3JhcGgNCj4gICAjICAgICAgICAgICAgICAg
ICAgICBhYm92ZSBAdG9wLiBJZiB0aGlzIG9wdGlvbiBpcyBub3QgZ2l2ZW4sIGEgbm9kZSBuYW1l
IGlzDQo+IC0jICAgICAgICAgICAgICAgICAgICBhdXRvZ2VuZXJhdGVkLiAoU2luY2U6IDIuOSkN
Cj4gKyMgICAgICAgICAgICAgICAgICAgIGF1dG9nZW5lcmF0ZWQuIE9taXR0aW5nIHRoaXMgb3B0
aW9uIGlzIGRlcHJlY2F0ZWQsIGl0IHdpbGwNCj4gKyMgICAgICAgICAgICAgICAgICAgIGJlIHJl
cXVpcmVkIGluIGZ1dHVyZS4gKFNpbmNlOiAyLjkpDQo+ICAgIw0KPiAgICMgQGF1dG8tZmluYWxp
emU6IFdoZW4gZmFsc2UsIHRoaXMgam9iIHdpbGwgd2FpdCBpbiBhIFBFTkRJTkcgc3RhdGUgYWZ0
ZXIgaXQgaGFzDQo+ICAgIyAgICAgICAgICAgICAgICAgZmluaXNoZWQgaXRzIHdvcmssIHdhaXRp
bmcgZm9yIEBibG9jay1qb2ItZmluYWxpemUgYmVmb3JlDQo+IEBAIC0yMjQ5LDcgKzIyNTAsOCBA
QA0KPiAgICMgQGZpbHRlci1ub2RlLW5hbWU6IHRoZSBub2RlIG5hbWUgdGhhdCBzaG91bGQgYmUg
YXNzaWduZWQgdG8gdGhlDQo+ICAgIyAgICAgICAgICAgICAgICAgICAgZmlsdGVyIGRyaXZlciB0
aGF0IHRoZSBtaXJyb3Igam9iIGluc2VydHMgaW50byB0aGUgZ3JhcGgNCj4gICAjICAgICAgICAg
ICAgICAgICAgICBhYm92ZSBAZGV2aWNlLiBJZiB0aGlzIG9wdGlvbiBpcyBub3QgZ2l2ZW4sIGEg
bm9kZSBuYW1lIGlzDQo+IC0jICAgICAgICAgICAgICAgICAgICBhdXRvZ2VuZXJhdGVkLiAoU2lu
Y2U6IDIuOSkNCj4gKyMgICAgICAgICAgICAgICAgICAgIGF1dG9nZW5lcmF0ZWQuIE9taXR0aW5n
IHRoaXMgb3B0aW9uIGlzIGRlcHJlY2F0ZWQsIGl0IHdpbGwNCj4gKyMgICAgICAgICAgICAgICAg
ICAgIGJlIHJlcXVpcmVkIGluIGZ1dHVyZS4gKFNpbmNlOiAyLjkpDQo+ICAgIw0KPiAgICMgQGNv
cHktbW9kZTogd2hlbiB0byBjb3B5IGRhdGEgdG8gdGhlIGRlc3RpbmF0aW9uOyBkZWZhdWx0cyB0
byAnYmFja2dyb3VuZCcNCj4gICAjICAgICAgICAgICAgIChTaW5jZTogMy4wKQ0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9ibG9jay9ibG9ja19pbnQuaCBiL2luY2x1ZGUvYmxvY2svYmxvY2tfaW50
LmgNCj4gaW5kZXggM2FhMWU4MzJhOC4uNjI0ZGEwYjRhMiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ibG9jay9ibG9ja19pbnQuaA0KPiArKysgYi9pbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oDQo+
IEBAIC03NjIsNyArNzYyLDE1IEBAIHN0cnVjdCBCbG9ja0RyaXZlclN0YXRlIHsNCj4gICAgICAg
Ym9vbCBzZzsgICAgICAgIC8qIGlmIHRydWUsIHRoZSBkZXZpY2UgaXMgYSAvZGV2L3NnKiAqLw0K
PiAgICAgICBib29sIHByb2JlZDsgICAgLyogaWYgdHJ1ZSwgZm9ybWF0IHdhcyBwcm9iZWQgcmF0
aGVyIHRoYW4gc3BlY2lmaWVkICovDQo+ICAgICAgIGJvb2wgZm9yY2Vfc2hhcmU7IC8qIGlmIHRy
dWUsIGFsd2F5cyBhbGxvdyBhbGwgc2hhcmVkIHBlcm1pc3Npb25zICovDQo+IC0gICAgYm9vbCBp
bXBsaWNpdDsgIC8qIGlmIHRydWUsIHRoaXMgZmlsdGVyIG5vZGUgd2FzIGF1dG9tYXRpY2FsbHkg
aW5zZXJ0ZWQgKi8NCj4gKw0KPiArICAgIC8qDQo+ICsgICAgICogQGltcGxpY2l0IGZpZWxkIGlz
IGRlcHJlY2F0ZWQsIGRvbid0IHNldCBpdCB0byB0cnVlIGZvciBuZXcgZmlsdGVycy4NCj4gKyAg
ICAgKiBJZiB0cnVlLCB0aGlzIGZpbHRlciBub2RlIHdhcyBhdXRvbWF0aWNhbGx5IGluc2VydGVk
IGFuZCB1c2VyIGRvbid0DQo+ICsgICAgICoga25vdyBhYm91dCBpdCBhbmQgdW5wcmVwYXJlZCBm
b3IgYW55IGVmZmVjdHMgb2YgaXQuIFNvLCBpbXBsaWNpdA0KPiArICAgICAqIGZpbHRlcnMgYXJl
IHdvcmthcm91bmRlZCBhbmQgc2tpcHBlZCBpbiBtYW55IHBsYWNlcyBvZiB0aGUgYmxvY2sNCj4g
KyAgICAgKiBsYXllciBjb2RlLg0KPiArICAgICAqLw0KPiArICAgIGJvb2wgaW1wbGljaXQ7DQo+
ICAgDQo+ICAgICAgIEJsb2NrRHJpdmVyICpkcnY7IC8qIE5VTEwgbWVhbnMgbm8gbWVkaWEgKi8N
Cj4gICAgICAgdm9pZCAqb3BhcXVlOw0KPiBkaWZmIC0tZ2l0IGEvYmxvY2tkZXYuYyBiL2Jsb2Nr
ZGV2LmMNCj4gaW5kZXggMzZlOTM2OGUwMS4uYjNjZmFjY2NlMSAxMDA2NDQNCj4gLS0tIGEvYmxv
Y2tkZXYuYw0KPiArKysgYi9ibG9ja2Rldi5jDQo+IEBAIC0zMjkyLDYgKzMyOTIsMTEgQEAgdm9p
ZCBxbXBfYmxvY2tfY29tbWl0KGJvb2wgaGFzX2pvYl9pZCwgY29uc3QgY2hhciAqam9iX2lkLCBj
b25zdCBjaGFyICpkZXZpY2UsDQo+ICAgICAgIEJsb2NrZGV2T25FcnJvciBvbl9lcnJvciA9IEJM
T0NLREVWX09OX0VSUk9SX1JFUE9SVDsNCj4gICAgICAgaW50IGpvYl9mbGFncyA9IEpPQl9ERUZB
VUxUOw0KPiAgIA0KPiArICAgIGlmICghaGFzX2ZpbHRlcl9ub2RlX25hbWUpIHsNCj4gKyAgICAg
ICAgd2Fybl9yZXBvcnQoIk9taXR0aW5nIGZpbHRlci1ub2RlLW5hbWUgcGFyYW1ldGVyIGlzIGRl
cHJlY2F0ZWQsIGl0ICINCj4gKyAgICAgICAgICAgICAgICAgICAgIndpbGwgYmUgcmVxdWlyZWQg
aW4gZnV0dXJlIik7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIGlmICghaGFzX3NwZWVkKSB7DQo+
ICAgICAgICAgICBzcGVlZCA9IDA7DQo+ICAgICAgIH0NCj4gQEAgLTM5OTAsNiArMzk5NSwxMSBA
QCB2b2lkIHFtcF9ibG9ja2Rldl9taXJyb3IoYm9vbCBoYXNfam9iX2lkLCBjb25zdCBjaGFyICpq
b2JfaWQsDQo+ICAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiAgICAgICBpbnQgcmV0
Ow0KPiAgIA0KPiArICAgIGlmICghaGFzX2ZpbHRlcl9ub2RlX25hbWUpIHsNCj4gKyAgICAgICAg
d2Fybl9yZXBvcnQoIk9taXR0aW5nIGZpbHRlci1ub2RlLW5hbWUgcGFyYW1ldGVyIGlzIGRlcHJl
Y2F0ZWQsIGl0ICINCj4gKyAgICAgICAgICAgICAgICAgICAgIndpbGwgYmUgcmVxdWlyZWQgaW4g
ZnV0dXJlIik7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIGJzID0gcW1wX2dldF9yb290X2JzKGRl
dmljZSwgZXJycCk7DQo+ICAgICAgIGlmICghYnMpIHsNCj4gICAgICAgICAgIHJldHVybjsNCj4g
DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


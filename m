Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D545C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB63824650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DOB7T5tY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB63824650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihsvg-0002KJ-Sm
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihsv1-0001oo-6i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ihsuz-0007zo-QC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:20:30 -0500
Received: from mail-ve1eur01on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::718]:10820
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ihsuy-0007j3-Ub; Thu, 19 Dec 2019 05:20:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkXpO1QNRo/xEHpeIYTX4MfVL2k86svuHGRdHLI31SNXVNzbta+1MF3yebJIeawFQ98hrJeBC8Kyu7YUYjJG30nEx3wajMhKfwcErBebJhnd4RIBzPpMOnza7bKP3Wj9NOkQySNb/3ghhogdfaAc5hBLs48iZerDFZOUn1qOPdAbeSh70lGx+eYuzbEEWQfwfYMnV1irthS9QUF3GOLzqe2AK2jDdY54V5rv0Zf+1NRqHcmxznZCM/oI8+utBgUtRy6nJBcCy2O3VGibm5xf8F76qPSLbFSldIQhFDlPCKQGdCRdWqL92s5a9NX19jTVGRwSSbdOtKPT9kfKKM0D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zDQPN8W1BaP+5FqoejPVi2YelnUjn6OjpLU43z4U58=;
 b=kwRBy5IXqN7eyX4Gxs5HT+zh2Y01jC/oxyCve+g3LwHaoEr+f+Cv+4ub+fMzi5cl47i6MXs/BC+VQNA1JBq2tbOYSCff+yZY3B4r8qPVvbNGQ9yiUSloIm01Ukk5vPxLmqVq34Ih4sOsVqmXWpgjpQkChxoDtoVarbjt7ACg8G/kOter+nlE50SXTo+XPnOTR2m3Ye3U6u0Z8bhHBKe8piMS1nIQSCFCWWCbCjDTO1MHEIkL++g51F4osF/PxiHCaOIzRErSHPEjR8IR59cW5/b0g8LyKgN4lGymhe+CwiA8XuaXJ0tdBWHaL/RzfInTgmtZ56gPA9dNCuIbtl4aCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zDQPN8W1BaP+5FqoejPVi2YelnUjn6OjpLU43z4U58=;
 b=DOB7T5tYfRwlBCXghuMX160pOtgf8YVW9QoPh0W4VV9+gTu+60lonwdHHHgANmdPaQpCg/8WFJxIMlpVL3bXdAFiBqk8moq9ogWv2LWI9ZW05BURLZchF/zkx93X8C+kzc64SVEwfMCUWdgIesI1CzCxvlR2vUOWKcA3s76qLts=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4801.eurprd08.prod.outlook.com (10.255.96.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 19 Dec 2019 10:20:25 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 10:20:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
Thread-Topic: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
Thread-Index: AQHVoU6neqv907dUcE6t1HvrHyi33qezwPUAgA2Yl4CAAA2tAIAAAgKA
Date: Thu, 19 Dec 2019 10:20:25 +0000
Message-ID: <8a7cd617-6d34-8735-45a7-52431db1171c@virtuozzo.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191210174644.GC7103@linux.fritz.box>
 <eed0efba-aa38-4901-8f10-6ec3ee339437@virtuozzo.com>
 <20191219101312.GD5230@linux.fritz.box>
In-Reply-To: <20191219101312.GD5230@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0283.eurprd05.prod.outlook.com
 (2603:10a6:7:93::14) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191219132022991
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffbb6436-a14a-4aef-7a61-08d7846d0ff4
x-ms-traffictypediagnostic: AM6PR08MB4801:
x-microsoft-antispam-prvs: <AM6PR08MB480169CCA820A55C24FE6464C1520@AM6PR08MB4801.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(31696002)(52116002)(6486002)(31686004)(36756003)(6916009)(5660300002)(4326008)(6506007)(316002)(6512007)(54906003)(2616005)(478600001)(86362001)(71200400001)(26005)(8936002)(186003)(2906002)(81156014)(81166006)(66446008)(8676002)(64756008)(66946007)(66556008)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4801;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Pse533peOw6T2IBGwf8fnJPgvzEN6RENo50w7Won6BAOB8IgP4rMNQw+yBLhqmN1IdMgPb8NrqBmvuSPyCRq0sAGdhVKJinJ3udr5tkXe9N1JynLvCn3YljI0qTlMpwLODLqEgQ7RnUr1O7o2gvnPj+6aVdZBBVIK/GA2sDjy4CwHGjdUFZVsPxQWL1GkWIneW8IV4eL4bP2DCWA8tMUaRNTrjtHJ8jycfh/dVRHrEpU4uViQzjjeUjRqoqbKi5X71LAuhAec40aJydWCXNfCPi5IrkWehiMZClwcZt3Ce5QAKQTHZuLflFstJTo782xCoPFtfBd2aFfmCRTiYhyvPf9i1GcZDKWF7pClZDEpRyVgyXAqVjFitkgulSyFK+e1BJkOKnyqDgYGhoQCXFtNUE6o3CqVl8x4z41WYQibyzFmGeP26XLC4Q0O9UmX9Z
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <89581988CF8C544084D29A0599F2F051@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbb6436-a14a-4aef-7a61-08d7846d0ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 10:20:25.1505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V60d8QASFAFC7AS96ztWHnqDpAjbnohcWBqKvIwNnU4XLFVE8qb9APAVu1lAAsdhUAPi04RFw9H/Gp12Sv0Onc3PzEKe8VyhqA+Pb/xKPo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4801
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::718
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
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTkuMTIuMjAxOSAxMzoxMywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTkuMTIuMjAxOSB1bSAx
MDoyNCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDEw
LjEyLjIwMTkgMjA6NDYsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMjIuMTEuMjAxOSB1bSAx
NzowNSBoYXQgS2V2aW4gV29sZiBnZXNjaHJpZWJlbjoNCj4+Pj4gU2VlIHBhdGNoIDQgZm9yIHRo
ZSBkZXNjcmlwdGlvbiBvZiB0aGUgYnVnIGZpeGVkLg0KPj4+DQo+Pj4gSSdtIGFwcGx5aW5nIHBh
dGNoZXMgMyBhbmQgNS03IHRvIHRoZSBibG9jayBicmFuY2ggYmVjYXVzZSB0aGV5IG1ha2UNCj4+
PiBzZW5zZSBvbiB0aGVpciBvd24uDQo+Pj4NCj4+PiBUaGUgcmVhbCBmaXggd2lsbCBuZWVkIGFu
b3RoZXIgYXBwcm9hY2ggYmVjYXVzZSB0aGUgZXJyb3IgaGFuZGxpbmcgaXMNCj4+PiBicm9rZW4g
aW4gdGhpcyBvbmU6IElmIHplcm9pbmcgb3V0IGZhaWxzIChlaXRoZXIgYmVjYXVzZSBvZiBOT19G
QUxMQkFDSw0KPj4+IG9yIGJlY2F1c2Ugb2Ygc29tZSBvdGhlciBJL08gZXJyb3IpLCBiZHJ2X2Nv
X3RydW5jYXRlKCkgd2lsbCByZXR1cm4NCj4+PiBmYWlsdXJlLCBidXQgdGhlIGltYWdlIHNpemUg
aGFzIGFscmVhZHkgYmVlbiBpbmNyZWFzZWQsIHdpdGggcG90ZW50aWFsbHkNCj4+PiBpbmNvcnJl
Y3QgZGF0YSBpbiB0aGUgbmV3IGFyZWEuDQo+Pj4NCj4+PiBUbyBmaXggdGhpcywgd2UgbmVlZCB0
byBtYWtlIHN1cmUgdGhhdCB6ZXJvcyB3aWxsIGJlIHJlYWQgYmVmb3JlIHdlDQo+Pj4gY29tbWl0
IHRoZSBuZXcgaW1hZ2Ugc2l6ZSB0byB0aGUgaW1hZ2UgZmlsZSAoZS5nLiBxY293MiBoZWFkZXIp
IGFuZCB0bw0KPj4+IGJzLT50b3RhbF9zZWN0b3JzLiBJbiBvdGhlciB3b3JkcywgaXQgbXVzdCBi
ZWNvbWUgdGhlIHJlc3BvbnNpYmlsaXR5IG9mDQo+Pj4gdGhlIGJsb2NrIGRyaXZlci4NCj4+Pg0K
Pj4+IFRvIHRoaXMgZWZmZWN0LCBJJ20gcGxhbm5pbmcgdG8gaW50cm9kdWNlIGEgUFJFQUxMT0Nf
TU9ERV9aRVJPX0lOSVQgZmxhZw0KPj4+IHRoYXQgY2FuIGJlIG9yJ2VkIHRvIHRoZSBwcmVhbGxv
Y2F0aW9uIG1vZGUuIFRoaXMgd2lsbCBmYWlsIGJ5IGRlZmF1bHQNCj4+PiBiZWNhdXNlIGl0IGxv
b2tzIGxpa2UganVzdCBhbm90aGVyIHVuaW1wbGVtZW50ZWQgcHJlYWxsb2NhdGlvbiBtb2RlIHRv
DQo+Pj4gYmxvY2sgZHJpdmVycy4gSXQgd2lsbCBiZSByZXF1ZXN0ZWQgZXhwbGljaXRseSBieSBj
b21taXQgam9icyBhbmQNCj4+PiBhdXRvbWF0aWNhbGx5IGFkZGVkIGJ5IGJkcnZfY29fdHJ1bmNh
dGUoKSBpZiB0aGUgYmFja2luZyBmaWxlIHdvdWxkDQo+Pj4gYmVjb21lIHZpc2libGUgKGxpa2Ug
aW4gdGhpcyBzZXJpZXMsIGJ1dCBub3cgZm9yIGFsbCBwcmVhbGxvY2F0aW9uDQo+Pj4gbW9kZXMp
LiBJJ20gcGxhbm5pbmcgdG8gaW1wbGVtZW50IGl0IGZvciBxY293MiBhbmQgZmlsZS1wb3NpeCBm
b3Igbm93LA0KPj4+IHdoaWNoIHNob3VsZCBjb3ZlciBtb3N0IGludGVyZXN0aW5nIGNhc2VzLg0K
Pj4+DQo+Pj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2UgdG8geW91Pw0KPj4NCj4+IFRoaXMgc2hvdWxk
IHdvcmsuIERvIHlvdSBzdGlsbCBoYXZlIHRoaXMgcGxhbiBpbiBhIHRpbWVsaW5lPw0KPiANCj4g
U3RpbGwgcGxhbm5pbmcgdG8gZG8gdGhpcywgYnV0IHRvbW9ycm93IGlzIG15IGxhc3Qgd29ya2lu
ZyBkYXkgZm9yIHRoaXMNCj4geWVhci4gU28gSSBndWVzcyBJJ2xsIGdldCB0byBpdCBzb21ldGlt
ZSBpbiBKYW51YXJ5Lg0KPiANCg0KR29vZC4gSGF2ZSBhIG5pY2UgaG9saWRheSENCg0KDQotLSAN
CkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


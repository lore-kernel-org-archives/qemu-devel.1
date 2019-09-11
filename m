Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0BC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7932089F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aQoSj9lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7932089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i81RW-000115-AH
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i81Qf-0000Y5-KJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i81Qe-0003gM-6u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:08:57 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
 ([40.107.1.114]:43699 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i81Qd-0003cf-JG
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:08:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYEkZ5s1pdekRWm3e/mAnZEvjcin9MeEkw9gc8ug7WUm5EjpVuIVTdgDW9XIH8rP9nOPmMqOf/OFV4uPBATy8G2tv4bHgbalzrrWzPSKDs1mbQOxgnYGu7hfNhoVCYEY5xJah2fKYjNDpYGi54d3CnHTHyM98yp4039P/ZFx9OsBDLRxeeRC7zEnCauz5eQQc+n4aaKv9JmdeT66lQw/cFNAoIymkwrdVeMvLtpyWlteRGltXwKRbcTRhBoREaOwdjN+guCU/TRnp19+MKjtc/ewtWMDHYEt/hZJAruAoH79ixhz3ZEPEFvio9rix26rIMft4GACohbFrFYyI+IyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7nriAFsbGJjv6SCxzdeRkVZt/AXTIS0yjbhkHCvTAs=;
 b=TtUH93lA02C6U6ym9dhEW0Pp3pwzPh9mgJ6sqNCx0kO/6tkf7jchnd9PLh1I8Mtc5pSNH+GWQx/i/YfUXqY+NtucXjvRTlQOaUXiHNNBnltJbAXMjfCFfz3hNnj988Zcbaj9Ltp+RVlRkOSmoMNo7LcCVqM1axozMWdY/R72N8xfOGuQGBsQkn6ax2rPBlcffqg8HSpNpvLO042apeaK73jVpCTlplHbpL/BkcRobjXYRI9D0Tpm7+yjUPf3V0rCfw0xq4IjO/wkNSIpoVVGs7MzhvXwLW9kt5Fg0/G9PmTNyScc7riL8wsMwaDE4BV7iG59F7YCqK+afv0VvaXIkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7nriAFsbGJjv6SCxzdeRkVZt/AXTIS0yjbhkHCvTAs=;
 b=aQoSj9lWwiTs5oPrgs9Vc7q0BmVUvLO2nVDbamEMU4oGrPwxtm9Ivu6MaAiqq2daHHfpJXYexAdZPtmnCwyp1KTykOawVytI8uJSTnNaVpN8GqsJnHatuW2MAMXL4M4JOHYkuun0Hk+G172gfIpmKCXvk7FL3f6zx1k5bKd+UOo=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4027.eurprd08.prod.outlook.com (20.179.9.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Wed, 11 Sep 2019 12:08:49 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Wed, 11 Sep 2019
 12:08:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
Thread-Index: AQHVZ624+BOAzYdX+0uYhM0m3GFuf6ckjQ6AgABjj4CAAXNbgA==
Date: Wed, 11 Sep 2019 12:08:49 +0000
Message-ID: <00357f96-367e-d003-c166-d43083ee60af@virtuozzo.com>
References: <20190910075943.12977-1-vsementsov@virtuozzo.com>
 <20190910080319.GA8215@redhat.com>
 <0e5b08c2-e823-799a-98e3-06174de8d333@redhat.com>
In-Reply-To: <0e5b08c2-e823-799a-98e3-06174de8d333@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0072.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::16) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190911150846978
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f304ef7-20ed-45d3-4073-08d736b0cde4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4027; 
x-ms-traffictypediagnostic: DB8PR08MB4027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4027AD0C4108332EF64FEFD3C1B10@DB8PR08MB4027.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39840400004)(366004)(376002)(396003)(189003)(199004)(53936002)(386003)(6506007)(76176011)(53546011)(102836004)(186003)(229853002)(31696002)(86362001)(11346002)(446003)(2616005)(52116002)(8676002)(476003)(26005)(81156014)(2906002)(486006)(36756003)(8936002)(81166006)(25786009)(66446008)(478600001)(305945005)(7736002)(31686004)(6116002)(3846002)(99286004)(66476007)(66556008)(54906003)(316002)(110136005)(6512007)(6246003)(66066001)(14454004)(256004)(71190400001)(4326008)(66946007)(71200400001)(6436002)(4744005)(6486002)(5660300002)(64756008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4027;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2VhppXobVS2p9pGq+u+oLB4oi474Lho2vA7q4zbPgPmq6bze/jWZur6nieiDxtST47C8Iz9e4a1gXat/lRbf6tRwYglSP2fk49OSq04zlXPG7UpJEJYucaajTnjGQi9w1OgMY500xxGOVPkvvjYbLogzaPCBen+DGr31NCPIXvRZ1cI55eYF6TfVebl36r5/u2pE/ZPHuHQHTlNv8IPiKB3BN7BYC7NgMdoGogZ73FMXVKgROnb3J35s64DQe/BC8iPK5U+4n8AXSnpJdzQcKAe7qkFNIZjm+IJ77se2IfneotyCVKxkOyK4VLG2z38x4Cgy3weLjecCXJwznl/JTa3xevE0BpEa/mQWRhhniestp+d3CTKdGcMAGwGfQ5w0QBnDvoxuyiO0W+ER1kE0++m1vYHIEGcuW5NGyUGXC9A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E39AED963AC2D14DAA2BCCE0393C148D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f304ef7-20ed-45d3-4073-08d736b0cde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 12:08:49.4037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KMgFNx8+U7r0zRWV7Aycc4jPrvWkwefyStFIaSRkMJ5mbLvzrx8gzTMoQ0QaY6965R22uwIdXZWIc457YcqqzwccEHXx2fK4wc/1f3r6X88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4027
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.114
Subject: Re: [Qemu-devel] [PATCH] util/qemu-sockets: fix keep_alive handling
 in inet_connect_saddr
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDkuMjAxOSAxNjo1OSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xMC8xOSAzOjAzIEFN
LCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPj4gT24gVHVlLCBTZXAgMTAsIDIwMTkgYXQg
MTA6NTk6NDNBTSArMDMwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
PiBJbiAiaWYgKHNhZGRyLT5rZWVwX2FsaXZlKSB7IiB3ZSBtYXkgYWxyZWFkeSBiZSBvbiBlcnJv
ciBwYXRoLCB3aXRoDQo+Pj4gaW52YWxpZCBzb2NrIDwgMC4gRml4IGl0IGJ5IHJldHVybmluZyBl
cnJvciBlYXJsaWVyLg0KPj4+DQo+Pj4gUmVwb3J0ZWQtYnk6IENvdmVyaXR5IChDSUQgMTQwNTMw
MCkNCj4+PiBTdWdnZXN0ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4gLS0tDQo+Pj4gICB1dGlsL3FlbXUtc29ja2V0
cy5jIHwgNSArKystLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBSZXZpZXdlZC1ieTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVy
cmFuZ2VAcmVkaGF0LmNvbT4NCj4gDQo+IFRoYW5rcy4gIFdpbGwgcXVldWUgdGhyb3VnaCBteSBO
QkQgdHJlZSwgc2luY2UgdGhhdCdzIHdoZXJlIHRoZSBvcmlnaW5hbA0KPiBwcm9ibGVtIHdhcyBp
bnRyb2R1Y2VkLg0KPiANCg0KUGxlYXNlIGFkZCB3aGVuIHF1ZXVlaW5nOg0KDQpGaXhlczogYWVj
MjFkMzE3NTZjYmQNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


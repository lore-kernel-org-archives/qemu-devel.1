Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2040EC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE847218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kM8cjr7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE847218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7LLR-0000zr-Q8
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7LKf-0000SR-03
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7LKc-0006cg-Fg
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:11:55 -0400
Received: from mail-eopbgr10119.outbound.protection.outlook.com
 ([40.107.1.119]:38444 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7LKb-0006bV-Nm; Mon, 09 Sep 2019 11:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB/Un5A2kTigyuXs5o7Ep2ZpLjfVua+1IiiEZHlNZCCs9wvEaNd/a1fEQzVNOrhrEphoy5QuGPdwhlg+h1L3f/ZNSpG0sTY+FSwslxXJczcKXxfNkfNu+q1MTP/E/B1E0ueb59cdeEJq6YN64/tOP7fjJK6MoV2P0gHzMpQnsI9A5XwyU5mr/nN+Q1+nJf2FvNN8JpcrWygpe4nKO/6doH8f2TQHxkqWqPAVZ7pkywkk9K1pGds6SzQxsLTUAQFyBfUhXZ0jDc5SqlPCd1Xw4efG5WmE3LiuG7WMNmdzvmBZ8e5OOaiyWhhs9/OS85DGBtklwonBnEbQQRq77qLSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTfS5xdjbTLJsi1yH+uWA40IAnf3aq0xnv4NPFbCkdc=;
 b=aoOxEYjhpkOn/CUbE7TEX2luIOlMNSCr1Wf3KxhotSJFk8BnLhLY0rcRhIOEBZYZvI3xcUQgc4A7BtTcNYl5oFmzmmeXthF7FcH5tpyhMcrvD/wiwih4eH5MVPldj6vUKjIWPcRbVXhSfGIRnLIB0UaGtgxq3m2rpy0BgZrmvCPGgMSV1vsIfrNCyAjCQUGArvHRPY48wSGziDWnE3E6osJrEWk57c+2JR5i+yKxL+RyJE47CMQMHHQpf1gL+RE6nqLCplhRU0ZQkzjwSs7V91IiQfY9SkoW0qub/Gn3MEUXkNE1T8fLTPGXJRKJQHfJHHmbTl/rxYcPoj103Njedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTfS5xdjbTLJsi1yH+uWA40IAnf3aq0xnv4NPFbCkdc=;
 b=kM8cjr7sozrnd6xQyBH4twE95ZBMGgPXKqnWRtdrR8IElKhNxQ3V/4nwwrVUkdlUoQKQ2uOFDNz+lZ2z9zD9RcddsiomefvrDrM7nAEmbZZCRPIbcVIWA/Iz+KsNiHQUr8+Tn3/QunF2kCSURF2ToVqXLrC0hyWwtLn7Zycc9oU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3948.eurprd08.prod.outlook.com (20.179.8.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 15:11:51 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 15:11:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v10 04/14] block/backup: introduce BlockCopyState
Thread-Index: AQHVX03FFzbmaM/Nm0mHXVJ2sTGOiKcjXkKAgABGsID//9DwAIAADU8A
Date: Mon, 9 Sep 2019 15:11:51 +0000
Message-ID: <d4b6869a-a711-f911-2b29-c7062aa44aa6@virtuozzo.com>
References: <20190830161228.54238-1-vsementsov@virtuozzo.com>
 <20190830161228.54238-5-vsementsov@virtuozzo.com>
 <ae856032-2d6f-adb8-939b-410708dea596@redhat.com>
 <01bc8974-b9a5-8312-fe24-e2fbe87ab13d@virtuozzo.com>
 <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
In-Reply-To: <e94365cd-3bdf-4055-10de-abad4f65225b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190909181148485
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28c2b680-6bb4-46f6-07d8-08d735380abc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3948; 
x-ms-traffictypediagnostic: DB8PR08MB3948:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB3948EA55B644E8A8ECE1DB4FC1B70@DB8PR08MB3948.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(366004)(136003)(39840400004)(376002)(189003)(199004)(6246003)(6486002)(6436002)(107886003)(7736002)(6512007)(99286004)(31686004)(476003)(256004)(446003)(478600001)(2501003)(2906002)(2616005)(229853002)(11346002)(386003)(6506007)(53546011)(31696002)(36756003)(316002)(52116002)(14454004)(71200400001)(25786009)(26005)(6116002)(3846002)(71190400001)(54906003)(8676002)(305945005)(86362001)(4326008)(5660300002)(66446008)(64756008)(53936002)(66946007)(66476007)(66556008)(76176011)(486006)(186003)(66066001)(14444005)(8936002)(110136005)(7416002)(81166006)(81156014)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3948;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uEsyoimTrQJrj2J4fJj0fThtcXfEhOq3xnC3lnnuaIC2JU/gXckBST6nNJ2OyU+XTUrjvtOxRlyYYLLrhtxpSA1LMqLzWiUxtxWnoGxxi0v5oiG58gQP9YLc+p0vW0n/M5LWd7NEZ/5ug8eKHDLDZvmfxPuDr+ljqvJQW4Xw3VdAaTEhQQYZJfUW8MqPxM6arcIbg0gUGCwz+Rd/Wmokqzcd3UHz5IbSnEEaC7JFQOQwUvf8ExvQ/AdnJ3fJDiz9bse4fYTHVH4H2gvLMXG+Tf1DWtrsOI3yDHkPq0dqDRKx7V94vbiLXxhSgPDVmMtdxtId152faeN+L25GXzoNXNTFXSN8C1nywjlRwEjQGRVTerFInD133a9yxvp7Q9/ICI1h+VqaD2MDiBQnxoYf9qybBBcXyHrIXy68aXpc18U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE588D8487F484449AB85FF6E8F89FDA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c2b680-6bb4-46f6-07d8-08d735380abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 15:11:51.2261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mL3QFIScztdwt+62zjDrQxh+/dycRoZfHwXxNj/tdYMEGwZLi4xwAqPw8FyMsPcIHLe4S80BQDGztsclVhJQ88gIPxiYUIfe86ZDApOkEAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3948
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.119
Subject: Re: [Qemu-devel] [PATCH v10 04/14] block/backup: introduce
 BlockCopyState
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
 "wencongyang2@huawei.com" <wencongyang2@huawei.com>,
 "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDkuMjAxOSAxNzoyNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwOS4wOS4xOSAxNjoxMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA5LjA5LjIwMTkgMTU6NTks
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAzMC4wOC4xOSAxODoxMiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gU3BsaXQgY29weWluZyBjb2RlIHBhcnQgZnJvbSBi
YWNrdXAgdG8gImJsb2NrLWNvcHkiLCBpbmNsdWRpbmcgc2VwYXJhdGUNCj4+Pj4gc3RhdGUgc3Ry
dWN0dXJlIGFuZCBmdW5jdGlvbiByZW5hbWluZy4gVGhpcyBpcyBuZWVkZWQgdG8gc2hhcmUgaXQg
d2l0aA0KPj4+PiBiYWNrdXAtdG9wIGZpbHRlciBkcml2ZXIgaW4gZnVydGhlciBjb21taXRzLg0K
Pj4+Pg0KPj4+PiBOb3RlczoNCj4+Pj4NCj4+Pj4gMS4gQXMgQmxvY2tDb3B5U3RhdGUga2VlcHMg
b3duIEJsb2NrQmFja2VuZCBvYmplY3RzLCByZW1haW5pbmcNCj4+Pj4gam9iLT5jb21tb24uYmxr
IHVzZXJzIG9ubHkgdXNlIGl0IHRvIGdldCBicyBieSBibGtfYnMoKSBjYWxsLCBzbyBjbGVhcg0K
Pj4+PiBqb2ItPmNvbW1lbi5ibGsgcGVybWlzc2lvbnMgc2V0IGluIGJsb2NrX2pvYl9jcmVhdGUg
YW5kIGFkZA0KPj4+PiBqb2ItPnNvdXJjZV9icyB0byBiZSB1c2VkIGluc3RlYWQgb2YgYmxrX2Jz
KGpvYi0+Y29tbW9uLmJsayksIHRvIGtlZXANCj4+Pj4gaXQgbW9yZSBjbGVhciB3aGljaCBicyB3
ZSB1c2Ugd2hlbiBpbnRyb2R1Y2UgYmFja3VwLXRvcCBmaWx0ZXIgaW4NCj4+Pj4gZnVydGhlciBj
b21taXQuDQo+Pj4+DQo+Pj4+IDIuIFJlbmFtZSBzL2luaXRpYWxpemluZ19iaXRtYXAvc2tpcF91
bmFsbG9jYXRlZC8gdG8gc291bmQgYSBiaXQgYmV0dGVyDQo+Pj4+IGFzIGludGVyZmFjZSB0byBC
bG9ja0NvcHlTdGF0ZQ0KPj4+Pg0KPj4+PiAzLiBTcGxpdCBpcyBub3QgdmVyeSBjbGVhbjogdGhl
cmUgbGVmdCBzb21lIGR1cGxpY2F0ZWQgZmllbGRzLCBiYWNrdXANCj4+Pj4gY29kZSB1c2VzIHNv
bWUgQmxvY2tDb3B5U3RhdGUgZmllbGRzIGRpcmVjdGx5LCBsZXQncyBwb3N0cG9uZSBpdCBmb3IN
Cj4+Pj4gZnVydGhlciBpbXByb3ZlbWVudHMgYW5kIGtlZXAgdGhpcyBjb21tZW50IHNpbXBsZXIg
Zm9yIHJldmlldy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAg
YmxvY2svYmFja3VwLmMgICAgIHwgMzU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLQ0KPj4+PiAgICBibG9jay90cmFjZS1ldmVudHMgfCAgMTIgKy0NCj4+Pj4g
ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMzEgaW5zZXJ0aW9ucygrKSwgMTM4IGRlbGV0aW9ucygtKQ0K
Pj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3VwLmMgYi9ibG9jay9iYWNrdXAuYw0K
Pj4+PiBpbmRleCBhYmI1MDk5ZmEzLi4wMDJkZWU0ZDdmIDEwMDY0NA0KPj4+PiAtLS0gYS9ibG9j
ay9iYWNrdXAuYw0KPj4+PiArKysgYi9ibG9jay9iYWNrdXAuYw0KPj4+PiBAQCAtMzUsMTIgKzM1
LDQzIEBAIHR5cGVkZWYgc3RydWN0IENvd1JlcXVlc3Qgew0KPj4+PiAgICAgICAgQ29RdWV1ZSB3
YWl0X3F1ZXVlOyAvKiBjb3JvdXRpbmVzIGJsb2NrZWQgb24gdGhpcyByZXF1ZXN0ICovDQo+Pj4+
ICAgIH0gQ293UmVxdWVzdDsNCj4+Pj4gICAgDQo+Pj4+ICt0eXBlZGVmIHZvaWQgKCpQcm9ncmVz
c0J5dGVzQ2FsbGJhY2tGdW5jKShpbnQ2NF90IGJ5dGVzLCB2b2lkICpvcGFxdWUpOw0KPj4+PiAr
dHlwZWRlZiB2b2lkICgqUHJvZ3Jlc3NSZXNldENhbGxiYWNrRnVuYykodm9pZCAqb3BhcXVlKTsN
Cj4+Pj4gK3R5cGVkZWYgc3RydWN0IEJsb2NrQ29weVN0YXRlIHsNCj4+Pj4gKyAgICBCbG9ja0Jh
Y2tlbmQgKnNvdXJjZTsNCj4+Pj4gKyAgICBCbG9ja0JhY2tlbmQgKnRhcmdldDsNCj4+Pj4gKyAg
ICBCZHJ2RGlydHlCaXRtYXAgKmNvcHlfYml0bWFwOw0KPj4+PiArICAgIGludDY0X3QgY2x1c3Rl
cl9zaXplOw0KPj4+PiArICAgIGJvb2wgdXNlX2NvcHlfcmFuZ2U7DQo+Pj4+ICsgICAgaW50NjRf
dCBjb3B5X3JhbmdlX3NpemU7DQo+Pj4+ICsgICAgdWludDY0X3QgbGVuOw0KPj4+PiArDQo+Pj4+
ICsgICAgQmRydlJlcXVlc3RGbGFncyB3cml0ZV9mbGFnczsNCj4+Pj4gKw0KPj4+PiArICAgIC8q
DQo+Pj4+ICsgICAgICogc2tpcF91bmFsbG9jYXRlZDogaWYgdHJ1ZSwgb24gY29weSBvcGVyYXRp
b24gZmlyc3RseSByZXNldCBhcmVhcw0KPj4+PiArICAgICAqIHVuYWxsb2NhdGVkIGluIHRvcCBs
YXllciBvZiBzb3VyY2UgKGFuZCB0aGVuIG9mIGNvdXJzZSBkb24ndCBjb3B5DQo+Pj4+ICsgICAg
ICogY29ycmVzcG9uZGluZyBjbHVzdGVycykuIElmIHNvbWUgYnl0ZXMgcmVzZXQsIGNhbGwNCj4+
Pj4gKyAgICAgKiBwcm9ncmVzc19yZXNldF9jYWxsYmFjay4NCj4+Pj4gKyAgICAgKi8NCj4+Pg0K
Pj4+IEl0IGlzbuKAmXQgcXVpdGUgY2xlYXIgdGhhdCB0aGlzIHJlZmVycyB0byB0aGUgY29weV9i
aXRtYXAuICBNYXliZQ0KPj4+IHNvbWV0aGluZyBsaWtlDQo+Pj4NCj4+PiDigJxJZiB0cnVlLCB0
aGUgY29weSBvcGVyYXRpb24gcHJlcGFyZXMgYSBzeW5jPXRvcCBqb2I6IEl0IHNjYW5zIHRoZQ0K
Pj4NCj4+IGhtbSwgbm93IGl0J3Mgbm90IHJlZmFjdG9yZWQgdG8gc2NhbiBpdCBiZWZvcmUgY29w
eWluZyBsb29wLCBzbyBpdCdzIG5vdCBwcmVjaXNlDQo+PiB3b3JkaW5nLi4NCj4+DQo+Pj4gc291
cmNlJ3MgdG9wIGxheWVyIHRvIGZpbmQgYWxsIHVuYWxsb2NhdGVkIGFyZWFzIGFuZCByZXNldHMg
dGhlbSBpbiB0aGUNCj4+DQo+PiBOb3QgYWxsLCBidXQgbW9zdGx5IGluc2lkZSBibG9jay1jb3B5
IHJlcXVlc3RlZCBhcmVhIChidXQgbWF5IGJlIG1vcmUpDQo+IA0KPiBTb3JyeSwgSSBtZWFudCBi
YWNrdXAgb3BlcmF0aW9uLg0KPiANCj4+PiBjb3B5X2JpdG1hcCAoc28gdGhleSB3aWxsIG5vdCBi
ZSBjb3BpZWQpLiAgV2hlbmV2ZXIgYW55IHN1Y2ggYXJlYSBpcw0KPj4+IGNsZWFyZWQsIHByb2dy
ZXNzX3Jlc2V0X2NhbGxiYWNrIHdpbGwgYmUgaW52b2tlZC4NCj4+PiBPbmNlIHRoZSB3aG9sZSB0
b3AgbGF5ZXIgaGFzIGJlZW4gc2Nhbm5lZCwgc2tpcF91bmFsbG9jYXRlZCBpcyBjbGVhcmVkDQo+
Pj4gYW5kIHRoZSBhY3R1YWwgY29weWluZyBiZWdpbnMu4oCdDQo+Pg0KPj4gTGFzdCBzZW50ZW5j
ZSBzb3VuZHMgbGlrZSBpdCdzIGEgYmxvY2stY29weSB3aG8gd2lsbCBjbGVhciBza2lwX3VuYWxs
b2NhdGVkLA0KPj4gYnV0IGl0J3Mgbm90IHNvLiBJdCdzIG5vdCB2ZXJ5IGdvb2QgZGVzaWduIGFu
ZCBtYXkgYmUgcmVmYWN0b3JlZCBpbiBmdXR1cmUsDQo+PiBidXQgZm9yIG5vdywgSSdkIGJldHRl
ciBkcm9wIGxhc3Qgc2VudGVuY2UuDQo+IA0KPiBCdXQgd2FzbuKAmXQgdGhhdCB0aGUgcG9pbnQg
b2YgdGhpcyB2YXJpYWJsZT8gIFRoYXQgaXQgZ29lcyBiYWNrIHRvIGZhbHNlDQo+IG9uY2UgdGhl
IGJpdG1hcCBpcyBmdWxseSBpbml0aWFsaXplZD8NCg0KSSBqdXN0IHdhbnQgdG8gc3RyZXNzLCB0
aGF0IGJsb2NrLWNvcHkgaXRzZWxmICh3aGljaCB3aWxsIGJlIGluIGEgc2VwYXJhdGUgZmlsZSwN
CnNvIGl0IHdvdWxkIGJlIGNsZWFuIGVub3VnaCwgd2hhdCBpcyBibG9jay1jb3B5IGFuZCB3aGF0
IGlzIGl0cyB1c2VyKSBkbyBub3QgY2xlYXINCnRoaXMgdmFyaWFibGUuIEl0IG9mIGNvdXJzZSBt
YXkgdHJhY2sgY2FsbHMgdG8gIGJsb2NrX2NvcHlfcmVzZXRfdW5hbGxvY2F0ZWQoKSBhbmQNCmNs
ZWFyIHRoaXMgdmFyaWFibGUgYXV0b21hdGljYWxseSwgYnV0IGl0IGRvbid0IGRvIGl0IG5vdy4g
QW5kIHlvdXIgd29yZGluZyBsb29rcw0KZm9yIG1lIGxpa2UgYmxvY2stY29weSBjb2RlIG1heSBh
dXRvbWF0aWNhbGx5IGNsZWFyIHRoaXMgdmFyaWFibGUNCg0KPiANCj4+Pg0KPj4+IGluc3RlYWQ/
DQo+Pg0KPj4gT3IsIHdoYXQgYWJvdXQgdGhlIGZvbGxvd2luZyBtaXg6DQo+Pg0KPj4gVXNlZCBm
b3Igam9iIHN5bmM9dG9wIG1vZGUuIElmIHRydWUsIGJsb2NrX2NvcHkoKSB3aWxsIHJlc2V0IGlu
IGNvcHlfYml0bWFwIGFyZWFzDQo+PiB1bmFsbG9jYXRlZCBpbiB0b3AgaW1hZ2UgKHNvIHRoZXkg
d2lsbCBub3QgYmUgY29waWVkKS4gV2hlbmV2ZXIgYW55IHN1Y2ggYXJlYSBpcyBjbGVhcmVkLA0K
Pj4gcHJvZ3Jlc3NfcmVzZXRfY2FsbGJhY2sgd2lsbCBiZSBpbnZva2VkLiBVc2VyIGlzIGFzc3Vt
ZWQgdG8gY2FsbCBpbiBiYWNrZ3JvdW5kDQo+PiBibG9ja19jb3B5X3Jlc2V0X3VuYWxsb2NhdGVk
KCkgc2V2ZXJhbCB0aW1lcyB0byBjb3ZlciB0aGUgd2hvbGUgY29waWVkIGRpc2sgYW5kDQo+PiB0
aGVuIGNsZWFyIHNraXBfdW5hbGxvY2F0ZWQsIHRvIHByZXZlbnQgZXh0cmEgZWZmb3J0Lg0KPiAN
Cj4gSSBkb27igJl0IGtub3cuICBUaGUgcG9pbnQgb2YgdGhpcyB2YXJpYWJsZSBpcyB0aGUgaW5p
dGlhbGl6YXRpb24gb2YgdGhlDQo+IGJpdG1hcC4gIGJsb2NrLWNvcHkgb25seSB1c2VzIHRoaXMg
YXMgYSBoaW50IHRoYXQgaXQgbmVlZHMgdG8NCj4gcGFydGljaXBhdGUgaW4gdGhhdCBpbml0aWFs
aXphdGlvbiBwcm9jZXNzLCB0b28sIGFuZCBjYW5ub3QgYXNzdW1lIHRoZQ0KPiBiaXRtYXAgdG8g
YmUgZnVsbHkgYWxsb2NhdGVkLg0KDQpIbW0sIGJ1dCB3aGVyZSBpcyBhIGNvbmZsaWN0IG9mIHRo
aXMgYW5kIG15IHdvcmRpbmc/IElNSE8sIEkganVzdCBkb2N1bWVudGVkDQpleGFjdGx5IHdoYXQn
cyB3cml0dGVuIGluIHRoZSBjb2RlLg0KDQo+IA0KPiBGdXJ0aGVybW9yZSwgaXQgc291bmRzIGEg
Yml0IHN0cmFuZ2UgdG8gaW1wbHkgdGhhdCB0aGVyZeKAmWQgYmUgYSBzdHJpY3QNCj4gc2VwYXJh
dGlvbiBiZXR3ZWVuIGJsb2NrLWNvcHkgYW5kIGl0cyB1c2VyLiAgVGhleSB3b3JrIHRpZ2h0bHkg
dG9nZXRoZXINCj4gb24gdGhpcy4gIEkgZG9u4oCZdCB0aGluayBpdCB3b3VsZCBodXJ0IHRvIGJl
IG1vcmUgY29uY3JldGUgb24gd2hhdCB0aGUNCj4gYmFja3VwIGpvYiBkb2VzIGhlcmUgaW5zdGVh
ZCBvZiBqdXN0IGFsbHVkaW5nIHRvIGl0IGFzIGJlaW5nIOKAnHRoZSB1c2Vy4oCdLg0KDQpIb3dl
dmVyLCBJJ2QgcHJlZmVyIGJsb2NrLWNvcHkgdG8gYmUgc2VwYXJhdGUgZW5vdWdoIGFuZCBoYXZl
IGNsZWFyIGludGVyZmFjZSwNCnN0aWxsIHRoZXNlIHNlcmllcyBkb24ndCBicmluZyBpdCB0byB0
aGlzIGZpbmFsIHBvaW50Lg0KDQo+IA0KPiBbLi4uXQ0KPiANCj4+Pj4gQEAgLTQxNSwxNiArNTM1
LDE2IEBAIHN0YXRpYyB2b2lkIGJhY2t1cF9hYm9ydChKb2IgKmpvYikNCj4+Pj4gICAgc3RhdGlj
IHZvaWQgYmFja3VwX2NsZWFuKEpvYiAqam9iKQ0KPj4+PiAgICB7DQo+Pj4+ICAgICAgICBCYWNr
dXBCbG9ja0pvYiAqcyA9IGNvbnRhaW5lcl9vZihqb2IsIEJhY2t1cEJsb2NrSm9iLCBjb21tb24u
am9iKTsNCj4+Pj4gLSAgICBCbG9ja0RyaXZlclN0YXRlICpicyA9IGJsa19icyhzLT5jb21tb24u
YmxrKTsNCj4+Pj4gKyAgICBCbG9ja0NvcHlTdGF0ZSAqYmNzID0gcy0+YmNzOw0KPj4+PiAgICAN
Cj4+Pj4gLSAgICBpZiAocy0+Y29weV9iaXRtYXApIHsNCj4+Pj4gLSAgICAgICAgYmRydl9yZWxl
YXNlX2RpcnR5X2JpdG1hcChicywgcy0+Y29weV9iaXRtYXApOw0KPj4+PiAtICAgICAgICBzLT5j
b3B5X2JpdG1hcCA9IE5VTEw7DQo+Pj4+IC0gICAgfQ0KPj4+PiArICAgIC8qDQo+Pj4+ICsgICAg
ICogWmVybyBwb2ludGVyIGZpcnN0LCB0byBub3QgaW50ZXJsZWF2ZSB3aXRoIGJhY2t1cF9kcmFp
biBkdXJpbmcgc29tZQ0KPj4+PiArICAgICAqIHlpZWxkLiBUT0RPOiBqdXN0IGJsb2NrX2NvcHlf
c3RhdGVfZnJlZShzLT5iY3MpIGFmdGVyIGJhY2t1cF9kcmFpbg0KPj4+PiArICAgICAqIGRyb3Bw
ZWQuDQo+Pj4+ICsgICAgICovDQo+Pj4NCj4+PiBJIHN1cHBvc2UgdGhhdOKAmHMgbm93LiA6LSkN
Cj4+DQo+PiBIbW0sIGl0J3MgaW4gS2V2aW4ncyBicmFuY2guIFNob3VsZCBJIHJlYmFzZSBvbiBp
dD8NCj4gDQo+IFllcCwgdGhhdOKAmXMgd2hhdCBJIG1lYW50Lg0KPiANCj4gTWF4DQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


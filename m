Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E2DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409972063F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JCz2+Hto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409972063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxwYg-0004Ik-BB
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxwXz-0003ga-Ai
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxwXy-0001l0-3z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:54:51 -0400
Received: from mail-eopbgr50113.outbound.protection.outlook.com
 ([40.107.5.113]:20708 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxwXt-0001hn-VB; Wed, 14 Aug 2019 12:54:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/Bmy0w3OHa55E9Ea6ltwKG4/cu7NUjAG635yrPadPAP1YXE3A2NL0maY0G4q5SnXUTHvPOtu2WCBDLKf8+PjJp9OFwAloc1/tBh1UER7dQ91YcQbAjnlxl3/ASwEkpJsvhq9Zg6hapz+WufpDxvIu+/xPCHoLVkxX9x66bfonQXJm/r/UGL77XoEhkH0/rqD5hRZ5FHrFZh9B7VfKprncAEz3kN4eF8LXh/MBCGWx5FqlOpJfxhP3TdjyauUPyLiEgOJN9ms5ZE5LL/Eza7B9r15MOXsNo0Gmv8gbsIksB3PqdpKLbqW70N6pv02vEBTRdYIXS5JGsr2VCueXWYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3Eg2stMGmFf3dAcI5hxXTnGdBeCfuxGA+9vGemN6Yw=;
 b=ZOvtiupZZlD+pUncGNAAHvnyUyRifKTHiXvUtZ+Hp+HvzT6HRNL/PFlzA88Vt712u7ksj7XNTZUjy6emj0Xtti+iq9AQhr91lvZVjw/JRSVi6UkCP51ljyI1iq5codN9OQQQg7FjZmYnMN0+dPC5SQdH0NFFpLRcjww2sFPk/C1t56peifPOPG+ta1hTfunmA2/XYW9+3mGCt9oK8sLki3JaZdCVxONFWIG2P+x2mF7q+Q0rfqKVVtIsjwUz4ZpL1Tms4URDQFrUaAnj/qVxFYbeqHLGu8n8ozzjPd/axJahwqRBIvBm1pspYLN1k91EblIGuBKX06NvDTyn2jHMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3Eg2stMGmFf3dAcI5hxXTnGdBeCfuxGA+9vGemN6Yw=;
 b=JCz2+HtoBf/3bTTbJ6mkUz9GpTOdEmmQA50odia12oM4oDp8TScChaaFiNK53IlyyAlpSRI2pLIRAsiF57cZBc/Zj4KbqmcquSLl5AL6B+lZzXLP7j60YoqUd5d5Ormy6ZqH2W8lbupTJClf+doYGFoUmce/nBnjxyWn8Xra67o=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5260.eurprd08.prod.outlook.com (10.255.17.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 14 Aug 2019 16:54:43 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 16:54:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/4] backup: fix skipping unallocated clusters
Thread-Index: AQHVUq6iWmNqeubX60mrcacy86ei+6b63ImA
Date: Wed, 14 Aug 2019 16:54:43 +0000
Message-ID: <a018756a-fa67-49fb-a7db-622267b7d4e5@email.android.com>
In-Reply-To: <20190814144315.89729-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0048.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::19) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-android-message-id: <a018756a-fa67-49fb-a7db-622267b7d4e5@email.android.com>
x-originating-ip: [185.79.103.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d5518cc-7681-450e-1cba-08d720d81aca
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5260; 
x-ms-traffictypediagnostic: DB8PR08MB5260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB526035A3CC1FA1A950B735F5C1AD0@DB8PR08MB5260.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:60;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39850400004)(189003)(199004)(53754006)(81686011)(102836004)(81156014)(6436002)(6246003)(54906003)(476003)(5640700003)(14454004)(99286004)(5660300002)(52116002)(386003)(316002)(6506007)(2351001)(2906002)(25786009)(478600001)(66946007)(6486002)(31686004)(11346002)(66446008)(66476007)(64756008)(66556008)(8676002)(71190400001)(9686003)(6512007)(66066001)(86362001)(486006)(53936002)(54896002)(81166006)(186003)(71200400001)(31696002)(256004)(3846002)(26005)(107886003)(305945005)(2501003)(6306002)(229853002)(6916009)(6116002)(7736002)(966005)(8936002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5260;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JeCmFZTH01xiGxvipLZ5M69f3gNrZwZq0ft8BwZreI1J01jvC6ERG6tmi+Ce5cmOBZfQoM9LJmHb5wDc1gSQ28rsuuHT819Z7Rpl24n27p2hU17h99JEEw5PFGaXDzyj7prbF7QdUbJZrmVrpubjK3Fes1QlK8H5Ie+p538YpEG/4xr4CGlv8AJ+nE1WyTiFmdna5LI7lHjRpfDgZwQxWI6G40OHinHVGSYb4b2mgVd/68cEC0iRHvoacpE1/zNyg+w3L0PVsPVy4SstloyVz19YjqJKp1fnVLOkWFcaF3C9tJheDNsm9U4G6bSsQEGejRrDksfP27VjCKZvSbdZ7ZvqXGuCqpeuQBSkUXYUhtX97fuH3klVXthDIlS0ax3wHa3Y4o4jtQNIXxN5w10HceYjNuDxfvvHIbHfxLPVQv8=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5518cc-7681-450e-1cba-08d720d81aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 16:54:43.2133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TTT1FxGg7c5zYRMvEBYCRCJ7qZnvKGBdXVodY8oKyi/ApeHfOldzuPwkkJPDCpns85+YGr7ZwgjUYXZ7/HVvzx3hk+0vBObM53chZTpkzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5260
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.113
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/4] backup: fix skipping unallocated
 clusters
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
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCjE0INCw0LLQsy4gMjAxOSDQsy4gMTc6NDMg0L/QvtC70YzQt9C+0LLQsNGC0LXQu9GMIFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4g0L3Q
sNC/0LjRgdCw0Ls6DQoNCkhpIGFsbCENCg0KVGhlcmUgaXMgYSBidWcgaW4gbm90IHlldCBtZXJn
ZWQgcGF0Y2gNCiJibG9jay9iYWNrdXA6IHRlYWNoIFRPUCB0byBuZXZlciBjb3B5IHVuYWxsb2Nh
dGVkIHJlZ2lvbnMiDQppbiBodHRwczovL2dpdGh1Yi5jb20vam5zbm93L3FlbXUgYml0bWFwcy4g
MDQgZml4ZXMgaXQuIFNvLCBJIHByb3Bvc2UNCnRvIHB1dCAwMS0wMyBzb21ld2hlcmUgYmVmb3Jl
DQoiYmxvY2svYmFja3VwOiB0ZWFjaCBUT1AgdG8gbmV2ZXIgY29weSB1bmFsbG9jYXRlZCByZWdp
b25zIg0KYW5kIHNxdWFzaCAwNCBpbnRvICJibG9jay9iYWNrdXA6IHRlYWNoIFRPUCB0byBuZXZl
ciBjb3B5IHVuYWxsb2NhdGVkIHJlZ2lvbnMiDQoNCkhtbSwgZG9uJ3QgYm90aGVyIHdpdGggaXQu
IFNpbXBsZXIgaXMgZml4IHRoZSBidWcgaW4geW91ciBjb21taXQgYnkganVzdCB1c2Ugc2tpcF9i
eXRlcyB2YXJpYWJsZSB3aGVuIGluaXRpYWxpemluZyBkaXJ0eV9lbmQuDQoNCg0KQmFzZWQtb246
IGh0dHBzOi8vZ2l0aHViLmNvbS9qbnNub3cvcWVtdSBiaXRtYXBzDQoNClZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgKDQpOg0KICBibG9jay9kaXJ0eS1iaXRtYXA6IHN3aXRjaCBfbmV4dF9k
aXJ0eV9hcmVhIGFuZCBfbmV4dF96ZXJvIHRvIGludDY0X3QNCiAgYmxvY2svZGlydHktYml0bWFw
OiBhZGQgX25leHRfZGlydHkgQVBJDQogIGJsb2NrL2JhY2t1cDogdXNlIGJkcnZfZGlydHlfYml0
bWFwX25leHRfZGlydHkNCiAgYmxvY2svYmFja3VwOiBmaXggYW5kIGltcHJvdmUgc2tpcHBpbmcg
dW5hbGxvY2F0ZWQgaW4gYmFja3VwX2RvX2Nvdw0KDQppbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1h
cC5oIHwgIDggKystLQ0KaW5jbHVkZS9xZW11L2hiaXRtYXAuaCAgICAgICB8IDE4ICsrKysrKyst
LQ0KYmxvY2svYmFja3VwLmMgICAgICAgICAgICAgICB8IDMzICsrKysrKysrKystLS0tLS0tDQpi
bG9jay9kaXJ0eS1iaXRtYXAuYyAgICAgICAgIHwgMTIgKysrKy0tDQpibG9jay9taXJyb3IuYyAg
ICAgICAgICAgICAgIHwgIDQgKy0NCnRlc3RzL3Rlc3QtaGJpdG1hcC5jICAgICAgICAgfCAzMiAr
KysrKysrKy0tLS0tLS0tDQp1dGlsL2hiaXRtYXAuYyAgICAgICAgICAgICAgIHwgNzIgKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQpibG9jay90cmFjZS1ldmVudHMgICAgICAg
ICAgIHwgIDEgLQ0KOCBmaWxlcyBjaGFuZ2VkLCAxMDcgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRp
b25zKC0pDQoNCi0tDQoyLjE4LjANCg0KDQo=

Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A858C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C6B20663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 17:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J+XH5AEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C6B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSin-0005RC-9k
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 13:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfShC-0004MT-MU
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfShB-0004DZ-EX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 13:23:58 -0400
Received: from mail-eopbgr20118.outbound.protection.outlook.com
 ([40.107.2.118]:18241 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfSh8-00049b-E9; Mon, 24 Jun 2019 13:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzfXJQAsIE92IbHEao1pwoPaWf8CrzAFhHAjpKEmlhE=;
 b=J+XH5AEMD4v6t83IB/FpNAI/QN0KLOJ0HBKXb2AiVWLgnnGdIRI2E0drkTX7fi7hmG7VVW5ErOin+dIv/ds3sjzWLTOfmyBZ5HPaUr162RF6HN1+avWdtQnRRUTXjiIPPPctlDxWxgmBeIbO0hv5LPVkS/b5yBuqqMdS87Myx28=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB4109.eurprd08.prod.outlook.com (20.178.127.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 17:23:51 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 17:23:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
Thread-Index: AQHVIH/WtZ37DP0CJEiTLkjzsZK8gqaZXjmAgBG8HwCAAAO/gIAABBMA
Date: Mon, 24 Jun 2019 17:23:51 +0000
Message-ID: <789c7c71-fac4-ca61-56b7-ef1cf3a1eea9@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-8-git-send-email-andrey.shinkevich@virtuozzo.com>
 <dc4ae7d2-64bf-ab12-4712-5752f848b5dd@virtuozzo.com>
 <5b57cb61-7eef-b89e-7ea7-053e65c9f227@virtuozzo.com>
 <538b1e90-c5c6-671a-7b73-1833b20982ec@redhat.com>
In-Reply-To: <538b1e90-c5c6-671a-7b73-1833b20982ec@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0026.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::36) To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9835193e-9302-49eb-6e48-08d6f8c8b95a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4109; 
x-ms-traffictypediagnostic: VI1PR08MB4109:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR08MB4109E958E18CF87DF71969FEF4E00@VI1PR08MB4109.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39850400004)(366004)(346002)(396003)(199004)(189003)(2501003)(6246003)(2616005)(5660300002)(4326008)(68736007)(476003)(486006)(11346002)(44832011)(52116002)(31696002)(14454004)(229853002)(305945005)(386003)(6506007)(14444005)(256004)(53546011)(186003)(6306002)(81166006)(53936002)(26005)(2906002)(76176011)(102836004)(6512007)(81156014)(2201001)(86362001)(99286004)(36756003)(110136005)(54906003)(316002)(6116002)(3846002)(6436002)(6486002)(25786009)(71200400001)(71190400001)(7736002)(66066001)(73956011)(8676002)(478600001)(64756008)(66556008)(66446008)(8936002)(66476007)(66946007)(31686004)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4109;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZzkJTgOXUlBcIZcCtQhNvHcsYNw6xyBThn6nGcaW4Mm4DaUGvA5ddRbYOEtdP86WSwS3iShoC/wp4Lz1LV0aoLYDHWjCjZeBR6FjxZdg7TrjbL+JeSTMJF8gKKnlQRhSl2E+wUYnfFB+2IDlHC+oobY2P00KoIEgiAsFthMEehh0G2gsDpKMzePoqIHpSCvh6hq37Mw3QhTBrSit4ggEJxlqhb7P9C4JU4zEiZdsnLLw4FS4/3vb94yONKi2U4ZERjlelWeO6rcfdLTEblGzqSgyFBBzTJmptKdHF/m3SKNRk7Ln9B78/am5dj/clen94KqkM08b68uYwk12JVNtmcxk7m7EoPqJbtHu22z49h8EG+o7YqmlUe/Xm/Z1hXsR8ypXmorEefZG21YlBOcLsAGeNZBRXEk8uG9YijfuNUw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92D27FE8294FAD4A8CC184F30398A353@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9835193e-9302-49eb-6e48-08d6f8c8b95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 17:23:51.1419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4109
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.118
Subject: Re: [Qemu-devel] [PATCH v2 7/7] iotests: new file to suppress
 Valgrind errors
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI0LzA2LzIwMTkgMjA6MDksIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDYvMjQvMTkg
MTE6NTUgQU0sIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPiANCj4+Pj4gKysrIGIvdGVzdHMv
cWVtdS1pb3Rlc3RzL2NvbW1vbi5yYw0KPj4+PiBAQCAtMTcsNiArMTcsOCBAQA0KPj4+PiAgICAg
IyBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2VlIDxodHRwOi8vd3d3LmdudS5v
cmcvbGljZW5zZXMvPi4NCj4+Pj4gICAgICMNCj4+Pj4gICAgIA0KPj4+PiArcmVhZG9ubHkgVkFM
R1JJTkRfU1VQUFJFU1NfRVJST1JTPS4vdmFsZ3JpbmQuc3VwcA0KPj4+DQo+Pj4gV2h5IHJlYWRv
bmx5Pw0KPj4+DQo+Pj4gSSB0aGluayBpdCBzaG91bGQgYmUgZGVmaW5lZCBuZWFyIGFuZCBpbiBz
YW1lIG1hbm5lciBhcyBWQUxHUklORF9MT0dGSUxFLA0KPj4+IHdpdGggdXNlIG9mIFRFU1RfRElS
DQo+Pj4NCj4+DQo+PiBUaGUgbmV3IGZpbGUgJ3ZhbGdyaW5kLnN1cHAnIGlzIGludGVuZGVkIHRv
IGJlIGEgcGFydCBvZiB0aGUgUUVNVQ0KPj4gcHJvamVjdC4gU28sIGl0IHdpbGwgYmUgbG9jYXRl
ZCBpbiB0aGUgdGVzdCBkaXJlY3RvcnkgdGVzdHMvcWVtdS1pb3Rlc3RzLg0KPj4gVGhlIHZhcmlh
YmxlIFRFU1RfRElSIG1heSBjaGFuZ2UgdGhlIHdvcmtpbmcgZGlyZWN0b3J5LiBJbiB0aGF0IGNh
c2UsDQo+PiBtb3ZpbmcgdGhlIHByb2plY3QgZmlsZSB3aWxsIGJlIGEgaGFzc2xlLg0KPiANCj4g
TXkgcGVyc29uYWwgdGhvdWdodHMgYXJlIHRoYXQgbm8gc2VyaW91cyBQT1NJWCBvciBiYXNoIHNo
ZWxsIHNjcmlwdCBldmVyDQo+IHVzZXMgcmVhZG9ubHkgKGl0IG9mZmVycyB0aGUgaWxsdXNpb24g
b2Ygc2VjdXJpdHkgYnV0IGNhbm5vdCBhY3R1YWxseQ0KPiBiYWNrIGl0IHVwLCBhbmQgaW4gcmVh
bGl0eSBlbmRzIHVwIGNhdXNpbmcgbW9yZSBidWdzIHRoYW4gaXQgcHJldmVudHMNCj4gd2hlbiB5
b3VyIHNjcmlwdCBicmVha3MgYmVjYXVzZSB5b3UgdHJpZWQgdG8gbW9kaWZ5IGEgcmVhZG9ubHkN
Cj4gdmFyaWFibGUpLiAgSSd2ZSBvbmx5IGV2ZXIgZGVhbHQgd2l0aCBvbmUgcHJvamVjdCB0aGF0
IHRyaWVkIHRvIHVzZQ0KPiByZWFkb25seSBpbiBlYXJuZXN0ICh0aGUgJ2N5Z3BvcnQnIHNjcmlw
dCBmb3IgYnVpbGRpbmcgQ3lnd2luIHBhY2thZ2VzKQ0KPiBhbmQgaXQgZ290IGluIHRoZSB3YXkg
bW9yZSB0aGFuIGl0IHNhdmVkIG1lIGZyb20gYnVncy4NCj4gDQo+IERlY2xhcmluZyB0aGF0IFZB
TEdSSU5EX1NVUFBSRVNTX0VSUk9SUyBpcyBpbml0aWFsaXplZCBoYXJkLWNvZGVkIHRvIC4vDQo+
IGluc3RlYWQgb2YgcmVsYXRpdmUgdG8gJHtURVNUX0RJUn0gaXMgb3J0aG9nb25hbCB0byB3aGV0
aGVyIHlvdSBkZWNsYXJlDQo+IHRoYXQgdGhlIHZhcmlhYmxlIFZBTEdSSU5EX1NVUFBSRVNTX0VS
Uk9SUyBjYW4gbm8gbG9uZ2VyIGJlIGZ1cnRoZXINCj4gbW9kaWZpZWQgYnkgdGhlIHJlc3Qgb2Yg
dGhlIHNjcmlwdC4NCj4gDQoNClRoYW5rIHlvdSBFcmljLiBJIGFtIGZsZXhpYmxlIG9uIHRoYXQg
c3ViamVjdC4gSWYgdGhlIHBhdGggaXMgcmVsYXRpdmUgDQp0byAke1RFU1RfRElSfSwgc2hvdWxk
IHRoZSBmaWxlIHZhbGdyaW5kLnN1cHAgYmUgY29waWVkIGZyb20gLi8gdG8gdGhlIA0KJHtURVNU
X0RJUn0gYnkgdGhlIHNjcmlwdCBpdHNlbGY/DQoNCkFuZHJleQ0KLS0gDQpXaXRoIHRoZSBiZXN0
IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K


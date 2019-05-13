Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6082C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 10:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E05620989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SjbJxYIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E05620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ83W-0000fG-K5
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 06:19:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQ82S-0008S5-Q2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 06:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hQ7ny-0007F2-1q
	for qemu-devel@nongnu.org; Mon, 13 May 2019 06:03:34 -0400
Received: from mail-eopbgr120121.outbound.protection.outlook.com
	([40.107.12.121]:24241
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hQ7nw-0007DZ-S1; Mon, 13 May 2019 06:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2c8hqeRqF6qQ3AvCorY4kbYmgScWB8vq6O1PI5YfGV4=;
	b=SjbJxYIo7t3PkLwrfRBEJhxhSa2kIWDBPHb67naeP5J7lYkidBSLvz52ttIV9k7GTQFAJrwJRVaFxMRBAmrs+JdR7eF8DNCXSD1SpnOMQ0Nm6rmxtNXfZMp2ZlSbLY3cWg64NYEnvEHZ6lp/kS8RrorLNa75EGwJbI+s/ZAwVw4=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2SPR01MB0002.eurprd08.prod.outlook.com (52.133.108.203) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Mon, 13 May 2019 10:03:29 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1878.024;
	Mon, 13 May 2019 10:03:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH] nbd/server: Nicer spelling of max BLOCK_STATUS reply
	length
Thread-Index: AQHVB0OCRUIno+V6F0mF/Up1/Ona46Zo17CA
Date: Mon, 13 May 2019 10:03:29 +0000
Message-ID: <f72c864a-b695-cf35-f183-f1818fc5609a@virtuozzo.com>
References: <20190510151735.29687-1-eblake@redhat.com>
In-Reply-To: <20190510151735.29687-1-eblake@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0016.eurprd08.prod.outlook.com
	(2603:10a6:3:bd::26) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190513130327403
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44512f46-b220-45f8-b147-08d6d78a3f91
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2SPR01MB0002; 
x-ms-traffictypediagnostic: PR2SPR01MB0002:
x-microsoft-antispam-prvs: <PR2SPR01MB00028448D4CC6682C16AF464C10F0@PR2SPR01MB0002.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(39840400004)(346002)(366004)(376002)(189003)(199004)(55674003)(31686004)(36756003)(14454004)(186003)(4326008)(2906002)(6512007)(478600001)(486006)(86362001)(6116002)(31696002)(110136005)(3846002)(2501003)(25786009)(476003)(11346002)(71190400001)(446003)(2616005)(81166006)(26005)(66066001)(316002)(81156014)(102836004)(52116002)(68736007)(71200400001)(6246003)(8936002)(256004)(76176011)(66946007)(73956011)(66446008)(64756008)(66556008)(66476007)(4744005)(14444005)(99286004)(305945005)(6506007)(386003)(53936002)(5660300002)(8676002)(6436002)(7736002)(229853002)(6486002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2SPR01MB0002;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rKeo3OSNJzw0AK6+SqqkqtVyRDjyK4q+27nDbdvtuSAPCmRItEsdN6oLQCkK854MtKBe2wXlWWUC6741Yap1ldrv+SU6hKwfmh9aaV/UQ8E7s6SQzMigOx8yBg+nAwfPjS7YlNq5FSkAiOZ9sfiIvcQJ0l4q6CcBqNeGz5+JC76DHCURvVTF3bZ1Zqcxk3A5vobyVywr1AXifguo7wL9ZwR+QIO1lv3RoMshaXLRXGTizrfYmjI5akN9+wLuQVPP1750yrKHxXthuaRHwae8u3CUfVrSiSptQbuGk4qy5w/mOnmCBsm/1rurgWhwSA4Rwazr4U3s71uILomvXqMxKlwG0obAFIfWzetHzDIlRvlg3kzQNTyNbgQgj1YJvd9S4z7j4EJA1q4OTpsTspZBLO2wjKNOOhvOU6DyPgJSDXs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26C4C3ACE759E64586381D1C3D13BF35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44512f46-b220-45f8-b147-08d6d78a3f91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 10:03:29.3686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2SPR01MB0002
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.121
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Nicer spelling of max
 BLOCK_STATUS reply length
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDUuMjAxOSAxODoxNywgRXJpYyBCbGFrZSB3cm90ZToNCj4gQ29tbWl0IDNkMDY4YWZmICgz
LjApIGludHJvZHVjZWQgTkJEX01BWF9CSVRNQVBfRVhURU5UUyBhcyBhIGxpbWl0IG9uDQo+IGhv
dyBsYXJnZSB3ZSB3b3VsZCBhbGxvdyBhIHJlcGx5IHRvIE5CRF9DTURfQkxPQ0tfU1RBVFVTIHRv
IGdyb3cgd2hlbg0KPiBpdCBpcyB2aXNpdGluZyBhIHFlbXU6ZGlydHktYml0bWFwOiBjb250ZXh0
LiAgTGF0ZXIsIGNvbW1pdCBmYjdhZmM3OQ0KPiAoMy4xKSByZXVzZWQgdGhlIGNvbnN0YW50IHRv
IGxpbWl0IGJhc2U6YWxsb2NhdGlvbiBjb250ZXh0IHJlcGxpZXMsDQo+IGFsdGhvdWdoIHRoZSBu
YW1lIGlzIG5vdyBsZXNzIGFwcHJvcHJpYXRlIGluIHRoYXQgc2l0dWF0aW9uLg0KPiANCj4gUmVu
YW1lIHRoaW5ncywgYW5kIGltcHJvdmUgdGhlIG1hY3JvIHRvIHVzZSB1bml0cy5oIGZvciBiZXR0
ZXINCj4gbGVnaWJpbGl0eS4gVGhlbiByZWZvcm1hdCB0aGUgY29tbWVudCB0byBjb21wbHkgd2l0
aCBjaGVja3BhdGNoIHJ1bGVzDQo+IGFkZGVkIGluIHRoZSBtZWFudGltZS4gTm8gc2VtYW50aWMg
Y2hhbmdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5j
b20+DQoNCg0KV2l0aCBvciB3aXRob3V0IFN0ZWZhbm8ncyBzdWdnZXN0aW9uOg0KDQpTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


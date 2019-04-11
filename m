Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC05C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F0E2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FJ2pbfvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F0E2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEa5f-00070r-Ab
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 09:50:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEa4b-0006dY-3C
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEa4a-0000Td-8B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:49:01 -0400
Received: from mail-eopbgr10097.outbound.protection.outlook.com
	([40.107.1.97]:37603
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEa4Z-0000Ku-C4; Thu, 11 Apr 2019 09:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=5MB+N0B6LnEvXBdJsOAqk4PGwegbJvouzd/ZZC3zKMw=;
	b=FJ2pbfvGe2+rW87AaSGU4GyweZ1Djh4oFJdO4Rbx7dEsbdwSVGuI+moqKJ9SqkgzbqTOk+SN2FyWslzjhhXsLAHTV8FTsf81ESW1JzaUb1TsXrKQN0IpDTeSzgosR9l6aD4HJ3EdH16QWAAs4AbNo0qGP2O5h+jYjZbe/r0bC+w=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3323.eurprd08.prod.outlook.com (52.134.111.142) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.18; Thu, 11 Apr 2019 13:48:54 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Thu, 11 Apr 2019 13:48:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 1/6] qemu-img: Move quiet into ImgConvertState
Thread-Index: AQHU79/+bqYJGdpKz0Sj/LM91hGVHaY2+teA
Date: Thu, 11 Apr 2019 13:48:53 +0000
Message-ID: <955ec895-5b90-7294-d5e2-41829f56e529@virtuozzo.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
	<20190410205715.2209-2-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0301CA0021.eurprd03.prod.outlook.com
	(2603:10a6:3:76::31) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190411164851684
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1cfc921-f40e-4541-5594-08d6be846f9e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3323; 
x-ms-traffictypediagnostic: DB7PR08MB3323:
x-microsoft-antispam-prvs: <DB7PR08MB33238C929F08D21D19C22366C12F0@DB7PR08MB3323.eurprd08.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(376002)(396003)(39850400004)(346002)(189003)(199004)(6116002)(8676002)(68736007)(99286004)(3846002)(4744005)(6512007)(54906003)(110136005)(305945005)(86362001)(7736002)(31696002)(446003)(14454004)(71190400001)(71200400001)(25786009)(31686004)(76176011)(486006)(106356001)(256004)(5660300002)(8936002)(2501003)(105586002)(4326008)(66066001)(229853002)(2616005)(52116002)(476003)(6246003)(36756003)(11346002)(26005)(97736004)(186003)(6436002)(478600001)(53936002)(2906002)(81166006)(81156014)(316002)(102836004)(386003)(6506007)(6486002)(107886003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3323;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: og0i45ZKkL2Q9GUesKJn0ZnVGqRgh0u8z+6t5v6NjV35ZTvmIU8XrRX78IRiKxIaIVwe1QYFylhIaKH21geeZBCNDGqUmnB76I44AtcwJgImwVdkO10ET9fVfMyaFvDvPKw02xxrmArRYVZBreaWZ/H1xIW1r97A9tU3Ntq4YCzmyC+xI9l2o1JeLrV7v4CxlNHlTS4a3niOyUB+JTlBx+RKGMWD5CoJRUnLlKn3NC/RAWlDGhB/ybRj0z43ZWxJcpS5jFboOyko7vaK3GgrIMADq5jJRmCP/wXHVEwU3UrYIYCrpn6z35yLll2MSuUElArsoJ2ELhrlyE1IIvhPpMbLyAu3H1X834VTOBTHMQoyiOQ623TNighaFyKuSkj6r+X2TyrkMd7+cPjx9r6KwYl1qAc1STue9CBdju/mrys=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <151E35536BC7B24C80A3FFAF4BFD4AE6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cfc921-f40e-4541-5594-08d6be846f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 13:48:53.9033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3323
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.97
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-img: Move quiet into
 ImgConvertState
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411134853.YsuZaM4ROYSBZiO07-TGAywrSz0t2Aku3NtZlF2gtlY@z>

MTAuMDQuMjAxOSAyMzo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBNb3ZlIGltZ19jb252ZXJ0KCkn
cyBxdWlldCBmbGFnIGludG8gdGhlIEltZ0NvbnZlcnRTdGF0ZSBzbyBpdCBpcw0KPiBhY2Nlc3Np
YmxlIGJ5IG5lc3RlZCBmdW5jdGlvbnMuICAtcSBkaWN0YXRlcyB0aGF0IGl0IHN1cHByZXNzZXMg
YW55dGhpbmcNCj4gYnV0IGVycm9ycywgc28gaWYgdGhvc2UgZnVuY3Rpb25zIHdhbnQgdG8gZW1p
dCB3YXJuaW5ncywgdGhleSBuZWVkIHRvDQo+IHF1ZXJ5IHRoaXMgZmxhZyBmaXJzdC4gIChUaGVy
ZSBjdXJyZW50bHkgYXJlIG5vIHN1Y2ggd2FybmluZ3MsIGJ1dCB0aGVyZQ0KPiB3aWxsIGJlIGFz
IG9mIHRoZSBuZXh0IHBhdGNoLikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJl
aXR6QHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


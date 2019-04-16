Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92D6C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF102073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dHxLKIZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF102073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIQ2-0003K1-SK
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:22:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIPB-0002yV-Rd
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIPB-0002Xl-10
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:21:21 -0400
Received: from mail-eopbgr50106.outbound.protection.outlook.com
	([40.107.5.106]:9235
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGIPA-0002Wu-O3; Tue, 16 Apr 2019 03:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=er28Ai2bmE3idRuaWK2jX7jaYNSEJs9Yim7zysz+gp4=;
	b=dHxLKIZVTK3v7MrEy4VT/NX1iMozN+y0vkJVPKsl5sZQuQqamkkHyzIypMPFnc03q58w65BHWBssJt6uMFg9oLAs/sDxMnRJWzUezXyfjetkcIK/Gm9J0FwaW//pw1+m0EskULC4CWsRJrIroq5dhNlTFdmtxaU6wxVVnIM7wEs=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3675.eurprd08.prod.outlook.com (20.177.120.157) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.11; Tue, 16 Apr 2019 07:21:18 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 07:21:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 4/7] blkdebug: Add "none" event
Thread-Index: AQHU8hl9OL+w/b0KpE+tbHvajhA8BqY+ZcCA
Date: Tue, 16 Apr 2019 07:21:18 +0000
Message-ID: <71a0b3c3-7062-0dbd-8c2c-f07ea0f4f949@virtuozzo.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-5-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-5-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0013.eurprd07.prod.outlook.com
	(2603:10a6:7:67::23) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416102115085
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61636aed-6d2d-4045-1eb7-08d6c23c1de9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3675; 
x-ms-traffictypediagnostic: DB7PR08MB3675:
x-microsoft-antispam-prvs: <DB7PR08MB367502BF6B00FB3ADFC964F1C1240@DB7PR08MB3675.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(136003)(366004)(39840400004)(346002)(396003)(199004)(189003)(105586002)(6436002)(229853002)(6486002)(6512007)(14454004)(478600001)(305945005)(31686004)(7736002)(106356001)(68736007)(36756003)(110136005)(97736004)(66066001)(54906003)(316002)(3846002)(76176011)(99286004)(52116002)(2906002)(6116002)(2616005)(26005)(186003)(6506007)(2501003)(386003)(102836004)(446003)(486006)(476003)(11346002)(86362001)(71200400001)(71190400001)(53936002)(4326008)(6246003)(81166006)(25786009)(81156014)(14444005)(256004)(31696002)(4744005)(8676002)(107886003)(5660300002)(8936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3675;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dBAGhvZSqD9Jg0JDtBzEI1yCXcKXjHvN/YZwf1vjvLpxe2vXt5w9hioNcj0fqPjNjX4birVMbYo4WorutgCIvs3yVW+ASQ6kn5NCg9Tuvte0I9LAuIUdR8sKlWfnnnzI+bVOiNwvUtcVUaou/inSeJIk+gVTbNVHfiIvkRiGbivs/9+OTKATULOAjaxxjRCSQBKrrAmPzlkWjKV8UjnhnS9NaDWmtMmpLbgNRxCySPW0FCDpOcaeHbtFzAtqlxztAmbv4JF+v/r5jSr4JVgVmNkcNkLLAiobak/U5YUuVFlIrkvkghgriCCTrIbyGLkVTWuXFzRbayvMdz/z31vZ7oPLpcSanLFONq/TpCnEd+z+E3CbSF46Nf16HVOQ2cFUSslbywhRWz9ftXskFpzn0IWd5r1PpjGVYe8Hc8r/6DE=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <60DD584BEEF17741B0128008DA88AC92@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61636aed-6d2d-4045-1eb7-08d6c23c1de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 07:21:18.4403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3675
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.106
Subject: Re: [Qemu-devel] [PATCH v3 4/7] blkdebug: Add "none" event
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
Message-ID: <20190416072118.2plDUBOgJMY-LK0r7QsU8qtipx3HXtSbQ1ZtN-tx_bY@z>

MTMuMDQuMjAxOSAxOTo1MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBUb2dldGhlciB3aXRoIEBpb3R5
cGVzIGFuZCBAc2VjdG9yLCB0aGlzIGNhbiBiZSB1c2VkIHRvIHRyYXAgZS5nLiB0aGUNCj4gZmly
c3QgcmVhZCBvciB3cml0ZSBhY2Nlc3MgdG8gYSBjZXJ0YWluIHNlY3RvciB3aXRob3V0IGhhdmlu
ZyB0byBrbm93DQo+IHdoYXQgaGFwcGVucyBpbnRlcm5hbGx5IGluIHRoZSBibG9jayBsYXllciwg
aS5lLiB3aGljaCAicmVhbCIgZXZlbnRzDQo+IGhhcHBlbiByaWdodCBiZWZvcmUgc3VjaCBhbiBh
Y2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHo8bXJlaXR6QHJlZGhhdC5jb20+
DQoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


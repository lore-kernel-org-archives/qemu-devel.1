Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C77C43141
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECCC2082C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 09:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QhVh4ECY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECCC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZB7d-00062Z-Qb
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 04:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZB6a-0005XU-26
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZB6Y-0002Yu-1b
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 04:56:26 -0500
Received: from mail-eopbgr50099.outbound.protection.outlook.com
 ([40.107.5.99]:40050 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZB6X-0002Y3-ET; Mon, 25 Nov 2019 04:56:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KD0Lrhw35L4naR9FPcj2YU0Z02dnIrjHtWjHtFedeABzFqcbOcEwyADwKtW695tnROKTFw5Qy3BMoojkYrOEUya8fvmNIpc8IU0EazIDv0n51ZwA6IfkVRUdV/bsLsUBgxK6Kk2wLv0WhePpgEzGux0xlR1can74uCM28MOPOMKOm0xg+QRJbzhDHpw6Ede8ygS2CIP542tjOOSrwhel9BftnPj/Hlj3uLXcnBnOmSktW81QjYRjC5CtfJ7DJZjjm/aULgZH+tKJkuMLDvi+aNaOAMTAgI6vqpgRiR8lIDoeNHLds1VjG5GUatvRrA0ZqOVHpxnj19DQbeS5YKBQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi+BOH/PJjFvEjbb1+ArJ+8pZrNYmOxF/EkGXg+RoNc=;
 b=G1GXGRUnqLb/Us3qIIXyGPL/5q3rcJyPprtjXrYy29bwLvdhcWbco8+Yi+TvUIzgNZ4ZSSAZTeA10cxexwRYhNW5IgI+MCJ6Z69rqyGHXDOSIuAV3RpvyywwnerMAd/SJo8BXI3FdqJeAzpcO1WzwAOU6LKa/DW/XoOzSXo9ED7EyvJYA2xQBTLB1Zva+XSKs+i/+c3j3BnDQi4tO8JogwRpR9K4OCJQafOCE/yE6wE8Wbw/FOzw6PtDw7o6FJ7ZzJ9r5RppJMCNXGPZ/WKHIvBQN0JVFuHuhPx23htg13kQL7Qr5ELtVvJ0kA5tRfPa8oEn/hPCN8Yw/QSwVuIRWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xi+BOH/PJjFvEjbb1+ArJ+8pZrNYmOxF/EkGXg+RoNc=;
 b=QhVh4ECYtdbVog/3aDdvAqRf8lDZ+p5nThXuvaexM9XOyoQX1ns7gjMFSqwuTnYD8J9S+0+XEMTvfgmMZ7E/jRrAkoUvQ8g5KspmiPkKGdTpNMiiKAcJFYueKgzBTg429xGSTGc37nkreF3Tf45H0GLtO1GQyIV6lZ7FhtxjDQo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4916.eurprd08.prod.outlook.com (10.255.98.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 09:56:21 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 09:56:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 8/8] iotests: Test committing to short backing file
Thread-Topic: [PATCH v3 8/8] iotests: Test committing to short backing file
Thread-Index: AQHVoU6yYAAQpxpbhUeog1sSH2ifnqebqo2A
Date: Mon, 25 Nov 2019 09:56:21 +0000
Message-ID: <39007f62-1365-935c-732b-5ce554742de0@virtuozzo.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-9-kwolf@redhat.com>
In-Reply-To: <20191122160511.8377-9-kwolf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0031.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::41) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191125125619125
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cdee85e-988a-4489-75fc-08d7718db994
x-ms-traffictypediagnostic: AM6PR08MB4916:
x-microsoft-antispam-prvs: <AM6PR08MB49163DCC822C6D69C9186F51C14A0@AM6PR08MB4916.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(189003)(199004)(14454004)(66946007)(305945005)(8936002)(2906002)(81166006)(81156014)(6486002)(66476007)(8676002)(25786009)(256004)(229853002)(76176011)(6506007)(54906003)(316002)(6436002)(66556008)(64756008)(66446008)(386003)(52116002)(186003)(99286004)(31686004)(558084003)(110136005)(26005)(5660300002)(478600001)(66066001)(71190400001)(71200400001)(446003)(2616005)(11346002)(6512007)(6116002)(3846002)(86362001)(36756003)(31696002)(4326008)(7736002)(2501003)(6246003)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4916;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xRjZjja4mJ8sb6biReMPGWbnManKzWJFWeXaBbd3FwLLQrWEEWNDpBIsdyStkRC+6/HUFtl91y2BOCJcW58st0XPMCziigska/FC3qfHvZigwvBTGGmccmeLOdE9etFIyerllEqubm9UARwCWpf6plx61oHkjSHOLOZjKGjTKJbY/6J2CwgCcCxVSlVphIhyDVFfg4JIgM/kyM5IT0+vt3aDsxORs68goqijHFI/dkP2Fuf1NuwsTnDvYNj+mPtB8DughJVIo6lKDjVnbfiTNqjOfvTlVL9UlQJ5qVev29Dv1Jy8Rkh1sJGkBetar+zn0R1xZ0dpopSR7de9mhbUJ15LFaR+RbVxlPoi6xDDCSecL5v3cXFAfZnT+ggkBII26/nMWZxcQybl4ZiJqPZp7gEiVn3QUTufIkjKKluoT4xXtbRBRhY+eIvsEi6ANjtl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <58A81603BC96114C80D27D37E9C1EC9C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdee85e-988a-4489-75fc-08d7718db994
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 09:56:21.6165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73Fv1o6sq6PIP9Zr/hPhbtwjaKTejvrSVyAmaF+tRwkCjp8qEj3/1NJIs5go2smK6SRKsMDG/jxFntjVM4WMemcGX8qo064+LOu/pQ7pgVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.99
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
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjIuMTEuMjAxOSAxOTowNSwgS2V2aW4gV29sZiB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTogS2V2
aW4gV29sZiA8a3dvbGZAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVu
dHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NClRlc3RlZC1ieTogVmxh
ZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


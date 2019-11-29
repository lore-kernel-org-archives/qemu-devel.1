Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704132176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JilJLEha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704132176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacyT-0005bw-Ju
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacmF-0006PX-Sg
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iacmC-0002Dh-3X
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:41:25 -0500
Received: from mail-eopbgr30136.outbound.protection.outlook.com
 ([40.107.3.136]:32912 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iacmB-00021a-QA; Fri, 29 Nov 2019 04:41:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfmaHJL56bUOgel7Pgd4w17xPBqI9rQvtKF/UjQepCu7Zas8Lqy9pmwWr68SWTs/cumuM4mfzlj9YBno4jRmp+K5N9ogyQTmo6Ir2n2a2gyBIFKuWKw7z4APaF+yWV3KxFGMslFJ5VW2CHAsG1DalP8Sxhcb2N6qoaZn3Rtx0aWJxVKlxGfxxOJytYqdarC0XmZ3bErT1PL+Nd4hOD2CfCGEWGY/DOHwtdWuMJ/8n1S39rAU0vRsLPKBPNwK9RthnEehMnzFScbhH6TflQfcHlFYHQlBXsF72g1izb82oHJJmjx0Vgja0UUpRfcKFRulEtloJk2TFc1SoAgZc27NkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skgFd5Pdf8yu8/3lWEOr79apkBxzL8+bCXFNFvvJSH4=;
 b=XJ2EeBUtMuBNfA8raSKltDb/PCV6qu/JeBUR5q4qJSDOw2eYzZRIWKcWF+0ZEl3GXppJcOqptw9kK1yO9nm1Wi/61XvBcd5wp7zMIsVyNEnPt7bgMj5A5s55f3z6lCS1ToF5SonOqt5M6/02WWmNN7jDCSGHV/K1ZDKCIldqpy4hCEeD/yDRrXxvuoM9bjwN3n1QBI67LLfWJQ24/KxswQXV8lMsEag0sPBHxP8xxXMqv07gUNaEmQ/ApG2/pu74VL44fwuGQ8P4W0xHmkzIGGamAY+BEGyZde6cUTbGKL7opIpmxF8wEtcZikVYcBDlKFn0dysOiQy6bvM1V11qxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skgFd5Pdf8yu8/3lWEOr79apkBxzL8+bCXFNFvvJSH4=;
 b=JilJLEhakjipP7FFO9rjE+FenltqqKFkZHQt5kzC22L6MIjdlNiLC9zBNxJFtH9w+4J8x6/9KdN+fq+angCLFnav/ieSl/QybA30nuhD9bhWKI0ZjOijAnHB2Z/JRBueMHWVEWepklpdinvHnqYCSq3YI9oY9bGR6yFZ8eHvom0=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3927.eurprd08.prod.outlook.com (20.179.0.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Fri, 29 Nov 2019 09:41:20 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 09:41:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 07/23] blkverify: Implement
 .bdrv_recurse_can_replace()
Thread-Topic: [PATCH for-5.0 v2 07/23] blkverify: Implement
 .bdrv_recurse_can_replace()
Thread-Index: AQHVmKl1rRuH5JUN40KumoalFW71jqeiAPkA
Date: Fri, 29 Nov 2019 09:41:20 +0000
Message-ID: <df7b740c-0afc-6995-f387-82332c87deb4@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-8-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-8-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::40) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191129124118753
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b74610fc-7651-4a93-58bb-08d774b04a26
x-ms-traffictypediagnostic: AM6PR08MB3927:
x-microsoft-antispam-prvs: <AM6PR08MB3927FAEE043F29481B169109C1460@AM6PR08MB3927.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39840400004)(346002)(376002)(396003)(366004)(199004)(189003)(6246003)(31686004)(102836004)(14454004)(4326008)(31696002)(478600001)(6436002)(3846002)(5660300002)(6116002)(66446008)(64756008)(66556008)(66476007)(66946007)(6512007)(2501003)(8936002)(25786009)(7736002)(186003)(2906002)(2616005)(54906003)(8676002)(229853002)(36756003)(99286004)(316002)(110136005)(446003)(11346002)(66066001)(81156014)(6486002)(71190400001)(71200400001)(256004)(558084003)(76176011)(26005)(305945005)(6506007)(386003)(52116002)(86362001)(81166006)(142923001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3927;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHISPKkEm04vo8DXr5uXuuFKhg5jFrhZ0pjXpjmkEO+zqmC4Pv/LVj+rnx+K09uOZMAyqKDewTPb7e0+98TnOGrqNUod9sykSIMMeXE770BegqrQD2BtRbJQhWdjH078ZZo6eVSaDJUal7xJri24PFNiupTmOzDmD40jmxQzKZfxDFbo1hPVIfs6k9mZD9H9jABrbMkvP91NMGVixpuYBBBmPkROxm+yxAauSl5f2eAYCRgm94Oeg+Q3XguE0IdnCwBGV7gjpPWfRDwzuRSuhT8154+JEpLbHmUJD3AUsxEuPuNvbk60YJ5MOcXHkvM5GKNj2AUn+d1cBBCtqtXCbxh0Z9O367KwIaLd8rg/VudbTro2Fsf8TlmCkbr60TP23EW2KU7mb+i++aejqiitu323YK0wiceg9cvG4FXz/xfjg8pl/UwBdjfs72Lmcrrm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CB717C54ED1AB548964858235778D154@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74610fc-7651-4a93-58bb-08d774b04a26
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 09:41:20.5596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyINCSYWj8HdT/DS5OFSAhn2TI1vk0oawEV8fDK4R8SmW+fQnhRP6XPHv7sZmIsWddj5v2jne6txTogHNPEVw45okU2GCm7lB1+7wHWKyks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3927
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.136
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:02, Max Reitz wrote:
> Signed-off-by: Max Reitz<mreitz@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir


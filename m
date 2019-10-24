Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C062CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D3921906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sLecl3yk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D3921906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNg3H-0008Ev-Gj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1iNfNh-00008P-Bp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1iNfNg-0004L8-AQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:50:33 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com
 ([40.107.7.95]:24130 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1iNfNc-0004Fk-JD; Thu, 24 Oct 2019 11:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOd6gij35zQfTBgjuEwsi6fZLfFYLfb3Qytx0xjpDKxj6LSjp/59o5ohsjI+YOEtPnlLVJS4BbxHE4qtdAQKr010SoiCNtjt8mBvdOOdlu8FWJX4CcPo5FfiOkUiOx9bbpPNKeOaWDESzkAL2+8eNmo6VrtKKouZVvo5lhnMpHX2tuvIr8vxUs9sf95OHP4VOT7wHMjwa5f05TKTq6SyWgDnc4JXsZiZHGcxU7ACzwy4OCjeMSYaHqrNxHTPkNSKXnZqavIquFIFa/mQiGBufIE/xaEzRD/DilwTJSUA7xKcMRNzii0itZ6TKLASPZ3RI7Pod2XwCNtwWjH/WlIdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssLprTpIPzTk4UNJqKP1BIVVBKuqM3oEvvbk4SPb0v0=;
 b=gDwGpGaOmyTeziiVfDP9TcUtYMi8VAL4eIwwbHhiC0ad2ls1ee6G8TyunvNivvFce+L2rczowK3iYMbsWTHFcO+55854XmF+GqaAtSzlm7qs+rprMcl4Ga2sb7Vc4U2Palhykw8qA52Oh1Ronw2sFRG/Yst5Bx1PwoVPL+XhpNEsEx7ivZKl1jdtaFPo7WVYCxdSieYLAky2a204jZ9QcUlugPKEvL22ral2rFVXJtqYIJD3IeStRkdMbuC3Y2iMw/pB+KCCYGpV9e1oa7RGx0iSRufLumPsTMwPzEzRA2Ll2qWgci5TzPOETLyZGkczE0nY2LtU0XjBPrFzJ8HoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssLprTpIPzTk4UNJqKP1BIVVBKuqM3oEvvbk4SPb0v0=;
 b=sLecl3ykaXRSWCu1vXbr0n0FnwCaGHlZYQ/B9VB4dVZbO1vRXPteel1Y18X0fkkEPdB0NLkmxjjHZ0dm4CJiXThm1FPl4s9Zo71M9Sy6U38sGjzmVqO+KguxDFg6nnBdBdmbpFwfZJHi3zPuwAgKirHkbkw04XqryVjOPdvEvUo=
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com (10.169.221.21) by
 DB6PR0801MB1846.eurprd08.prod.outlook.com (10.169.224.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 15:50:25 +0000
Received: from DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34]) by DB6PR0801MB1702.eurprd08.prod.outlook.com
 ([fe80::f849:2ba0:2a0b:5b34%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 15:50:24 +0000
From: Denis Lunev <den@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf
 <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 1/2] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Topic: [PATCH v2 1/2] coroutine: Add qemu_co_mutex_assert_locked()
Thread-Index: AQHVinvHzheU/Zbxrkyv2eQrabwWz6dp7HmAgAAECwA=
Date: Thu, 24 Oct 2019 15:50:24 +0000
Message-ID: <c747df79-6ac3-b9b6-5e41-addb66d45eb6@virtuozzo.com>
References: <20191024142658.22306-1-kwolf@redhat.com>
 <20191024142658.22306-2-kwolf@redhat.com>
 <1c120c98-2693-5e92-2dbb-4037d3472b63@virtuozzo.com>
In-Reply-To: <1c120c98-2693-5e92-2dbb-4037d3472b63@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::12) To DB6PR0801MB1702.eurprd08.prod.outlook.com
 (2603:10a6:4:2f::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4aa919ee-89d4-4e6f-148c-08d75899e23a
x-ms-traffictypediagnostic: DB6PR0801MB1846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0801MB18468B905D3D8C15EBDC730EB66A0@DB6PR0801MB1846.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(39840400004)(376002)(136003)(189003)(199004)(81166006)(81156014)(2906002)(3846002)(6116002)(316002)(6436002)(8936002)(229853002)(4326008)(6512007)(71200400001)(71190400001)(86362001)(31696002)(6486002)(66446008)(5660300002)(66476007)(66556008)(64756008)(4744005)(31686004)(66946007)(54906003)(110136005)(486006)(6506007)(36756003)(53546011)(14454004)(386003)(2501003)(11346002)(99286004)(52116002)(476003)(2616005)(186003)(76176011)(478600001)(25786009)(7736002)(66066001)(305945005)(6246003)(26005)(102836004)(256004)(14444005)(8676002)(446003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB6PR0801MB1846;
 H:DB6PR0801MB1702.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKzYYc/PknNFawnrrxQQSbeHe/4fbE4ZRadt6KfHwpmH65xzb/Gl/6DT3yxWGRu0y+WY7Cc8DQcsZsWx09ZcJg07xibO05F4T1ygZut5fmU7fioolcZB9qktgLgmpY1//4ISy8dgj6gHjxMzOWozT91Rait29+knD97hsLnWx2OCy+xGigIOEfaPa5r0+hWQh6hYeXAcl1gCBZ+woWbxFxx7x4JDRDEBOTrSydvusC9RaNhXyo5Eq4UZnPSIsMlAqMqEpj/k6iRUFvEQGWo+tPFctBJRR/MRgUZmG6UUfYZTw6g9uGRsV3pGcgVVyCaMW4woJU9zmHnfrkB1g52kk9Od44osZJtLyF7xTqiiQFatYZyvrLUchIDM4+IvOnCayahh7iHE4j3eN1fOupcZaAUWUS2pMWc4ykUpzv76xSSki///lOJVnvox1Bf9bb1s
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B9147B7120942C4EA7B3B45A2838BF4C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa919ee-89d4-4e6f-148c-08d75899e23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 15:50:24.7081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ps7qIp4vNExGehi5r688woiG+Z4Dt/jaZm/w/O6ck/t6nVz4Yzs1UE45CIyyKblrsrn3x1sNevZD7zob5H/lKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1846
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.95
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
Cc: "psyhomb@gmail.com" <psyhomb@gmail.com>,
 "michael@weiser.dinsnail.net" <michael@weiser.dinsnail.net>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 6:35 PM, Vladimir Sementsov-Ogievskiy wrote:
> 24.10.2019 17:26, Kevin Wolf wrote:
>> Some functions require that the caller holds a certain CoMutex for them
>> to operate correctly. Add a function so that they can assert the lock is
>> really held.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>


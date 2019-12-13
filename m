Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B76EC2D0CB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABE72467F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vrY0kGuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABE72467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjBQ-0004dz-7j
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifjAi-0004E2-53
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ifjAg-0000WW-Qw
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:31:47 -0500
Received: from mail-eopbgr150129.outbound.protection.outlook.com
 ([40.107.15.129]:46502 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ifjAg-0000SK-CI; Fri, 13 Dec 2019 06:31:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZDQdTm/+0H+o2jUxxz4YLC4Z5zELHBvvQf3ADLm0tDVIM7thQfGkOk/DIBmuTJQhqFUCk9oSr/QqkhuTrN+NFjyEBM5gMw76vuLjkm8+rLPrNGVQMUCMNJSlusISCl4Q8Uk2szu2CPQPGE8CeGkoCThjbGZY533lj/Y5ilt7X0kHzb75+KGegFeNLpdiz0o61Km3wbek/XAeQVaVcJfPFUQEyC9cotLUGhkhaEoOQQrHIXYh2Uud75LR/qHNQ8m7BRmMPPBBfj/joJAsnZoh7SY8kKlFEuAZGM92m+4EEiM3x6PmBsqDCBZFIsOSnsI66Gb0gq3bCAxlZUDnG+QJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE3e+hyaSn7GWamRYnOoq7Gg/pm+kv7xxp5UfV/58i0=;
 b=Y2xTd1FIo3WzHH15kLCWsMGhmIo6bkARuqc2gbJjABK+saPYOMjjVRpAHh4w/z64Ib8qXqhv8fZYY686q2USCsttFN2LpdmdbnkutHHp7e88pgmmX438qnHUKc/JpLi9um7TRMzCqVIp++E53HWjd0mzzTEz0vzDQXt6iocQebXd4GuLHQGdmhEcRd8vtRQdVyLEG3omb2lAkZf7ywhkgBG/vA+DKiX9UHwxerIfbcbR4lK1ryhIGAfOaBJgly7fr70sFaQQD0Lvy6hoqN6pQpTu10bFLJlV6E7W5zwAoMLjFi5oJI2P1EA/2wjp/F8wEIVbNCYTN0C7bYU1PNKaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE3e+hyaSn7GWamRYnOoq7Gg/pm+kv7xxp5UfV/58i0=;
 b=vrY0kGuQsW3CWqNPVR+qXLGAGHlVkXL7fGDt/WQDnQUXNBABRLlwsJ9RAYgmMArgPiZRoAd78BE+K+WOpybFUOTgG+WmEYevlV57MLz6BWyD4i1gFCF0ydcZYMhDVgKUL2O6m8wMqKMPKF+1adWAzob2HTJkAuAE29p+wscaLOw=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3079.eurprd08.prod.outlook.com (52.135.163.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 11:31:43 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.020; Fri, 13 Dec 2019
 11:31:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 19/23] iotests: Resolve TODOs in 041
Thread-Topic: [PATCH for-5.0 v2 19/23] iotests: Resolve TODOs in 041
Thread-Index: AQHVmKmNmeJL6G4US0WS+6Oh5cK+GqeovUSA///N8YCACYqFAIAGCrkA
Date: Fri, 13 Dec 2019 11:31:43 +0000
Message-ID: <8b72b979-92c5-d0ce-a34c-052425a2e53f@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-20-mreitz@redhat.com>
 <2416e1d8-c1c3-4c88-6e7b-52670eb23c0e@virtuozzo.com>
 <3be97c8b-fbee-a183-0cd8-dc2e5824efbc@virtuozzo.com>
 <e21bfadf-670f-9c17-71b8-c14a1ed3727c@redhat.com>
In-Reply-To: <e21bfadf-670f-9c17-71b8-c14a1ed3727c@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0208.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::32) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191213143140814
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 454ba24a-77d0-48dd-e2d7-08d77fc00751
x-ms-traffictypediagnostic: AM6PR08MB3079:
x-microsoft-antispam-prvs: <AM6PR08MB30792A07F5435B7B73937AE4C1540@AM6PR08MB3079.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(39840400004)(376002)(366004)(199004)(189003)(53546011)(6506007)(6486002)(31696002)(4744005)(54906003)(5660300002)(2906002)(52116002)(110136005)(66556008)(66946007)(66476007)(66446008)(64756008)(4326008)(86362001)(478600001)(31686004)(6512007)(71200400001)(186003)(8936002)(2616005)(8676002)(36756003)(316002)(81156014)(26005)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3079;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgayushFMCfTe51SFFKDl9cRPjzxoIsVkos6HoplwpzJNZcRBKVrGOIpbZ7rvOBnBlmYNgckCV77Z+zmpgIPb8xc09+Jm3UUfz284VTScdmSJ5THYgjE2vRUQnxGcODyn3Hg3ZKOmUl3zFiR7Iwd9cR5XWUISibupS+z24X86T6Xx3NniDNh9sMeyBtpA+6nqzMLw8mzWGzWdCkzvVBMpyBbSw9NePQN53uTH5T28E1LldBUcKfpN9q9vId1gFVvP7HvFtVRFrZKoh24HOqh4TMsVEc8EhiZ9pRxQOjBHJbC9iDshtbXS/GIBX+ykJxLkdwhDEUIx+XQTMB04+nwPmtxW1c+9EqFLhM9a3td+dzcm2A2cJd8FYkOf4JTLuSrEsnL3KgwN+wqFWC3mLMnJ5CFLVmZwzcKP5+BQHp3Czg2Nx+CffHU7P8PPQGk4gvt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <69015D065E94E546ACC00AFB2575F6D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454ba24a-77d0-48dd-e2d7-08d77fc00751
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 11:31:43.1228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ij576y4gVz78Avf4f+LRC3NXzhEMKA8pOyzB9m/GSc/SO8urox47Rq7f5HHjCC434AJ1QuPab1DkikXSjM+XS0n5Me8TXFHpcIL6G4VhNeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3079
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.129
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

09.12.2019 18:15, Max Reitz wrote:
> On 03.12.19 14:33, Vladimir Sementsov-Ogievskiy wrote:
>> 03.12.2019 16:32, Vladimir Sementsov-Ogievskiy wrote:
>>> 11.11.2019 19:02, Max Reitz wrote:
>>>> Signed-off-by: Max Reitz<mreitz@redhat.com>
>>>
>>>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>
>>
>> Oops, stop. Why do you remove line "self.vm.shutdown()" ?
>=20
> Because we don=92t need it.  tearDown() does it anyway.  I suppose I
> should mention it in the commit message.
>=20

Yes...

But actually, better to remove extra shutdown from all test cases, not from
one, and than it would be separate patch.

Extra shutdown is left in (considering only class TestRepairQuorum):
test_pause
test_cancel_after_ready
test_cancel
test_complete


--=20
Best regards,
Vladimir


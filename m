Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB07FC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95327206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 09:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IFLBPw55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95327206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iU6Kc-0002e4-P9
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 04:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rkagan@virtuozzo.com>) id 1iU6JC-0001ft-Vg
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1iU6JB-00055t-DE
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 04:48:30 -0500
Received: from mail-ve1eur02hn030b.outbound.protection.outlook.com
 ([2a01:111:f400:fe06::30b]:19345
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1iU6JA-00051m-Iy; Mon, 11 Nov 2019 04:48:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nozXAR/VjHr/k2MusZkqfCIQbeIn9xQUKXogrDZ4rS6w3hlcAZ766UIeQmR9eQDx/ud9bauMulae1GXhE1jCA/et75qWPvz+bwDrWZUBmnOD3oduPCi5LRanhvQegXlADDrnNYnrh6wSCoHmIMLYHQA1kgDLLUMu09sMB3TD9syNqttRBjZ+QWGurGu0ztDDP+Pf6TTSeoxtEs3rebzHUa78kYp5pdJSauNYB9omErTDq0OtQ6eagP0z17oL+3bgduvELGMHwnuVVmUmANWL9KQs8HHI05eT3gPMqP8z6gFj0yZNnfjY2V4W0ZTwhu0gSpgbU7zdTpaysb/odpVJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrBY/p3loQlm+kFYc6ftPtWUYu0n8lYDx5o+qOCl+5M=;
 b=Ykrlib9GQlfyLUbyUxSfK0YTQuRHrOfjt/rpaYAT093y8lA9FQ3o++1Qys28RjbHFUF0X7tSaisTg2t5GSc3Jptx8QQAx3dlfjy5SfbTlXNAiSDttI5ZPSun7ObR3441n4Es58mP/S7EPs74X2CcRDf0Bk0DgWng9E04RXzJzGVAdRdJ5yxOpUrEQsY97KxryMAdoy2slr8dq+cw20lLRraVdj/mQh3e2DzsR7s51T+APmQ2O+EdG67pDLoeTPYyV1gcu8jfrhTdsXCV8UH0sO2uhvchrBo8qXO9Rskj9bojpuJQRltAWJBBF+JEpRrU6/CfV5XWLJtT+NXyThpOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrBY/p3loQlm+kFYc6ftPtWUYu0n8lYDx5o+qOCl+5M=;
 b=IFLBPw557CAtk9FaKn/fZ/7pBAj+gqg+swdUcZtPjV84GgV3Ep9Ci/6NiQ+g6SfrVVsUb5+i/wgQZm+DLG1Mk6w5JV0TkGs8y/aeZvCmsXd7EcjnkVcd/f0s68ejovMtpVdk1ZgF8gKGG73gKXpyNRrJ7RPzghaersVlA+887yc=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB5295.eurprd08.prod.outlook.com (20.178.126.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 09:48:25 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::9465:ec66:befb:e8b5]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::9465:ec66:befb:e8b5%3]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 09:48:25 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v3] iotests: Test NBD client reconnection
Thread-Topic: [PATCH v3] iotests: Test NBD client reconnection
Thread-Index: AQHVkNUYkueRQi37cke6mp6VF9z0xKeBVR0AgAAEXYCABGboAIAACEIA
Date: Mon, 11 Nov 2019 09:48:25 +0000
Message-ID: <20191111094822.GA126513@rkaganb.sw.ru>
References: <1572627272-23359-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <feb2b810-3436-6550-43b2-a07ec1fc5280@virtuozzo.com>
 <20191108140527.GA63895@rkaganb.sw.ru>
 <55df73cb-ffe8-e4c6-b97a-346bdf28f1e2@virtuozzo.com>
In-Reply-To: <55df73cb-ffe8-e4c6-b97a-346bdf28f1e2@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>,	Vladimir Sementsov-Ogievskiy
 <vsementsov@virtuozzo.com>,	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,	"kwolf@redhat.com"
 <kwolf@redhat.com>,	Denis Lunev <den@virtuozzo.com>,	"mreitz@redhat.com"
 <mreitz@redhat.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0217.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::17) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f7b99a-2458-4d59-b43c-08d7668c4bef
x-ms-traffictypediagnostic: VI1PR08MB5295:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB5295EAE3E69C26793994D209C9740@VI1PR08MB5295.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(199004)(189003)(6486002)(6436002)(26005)(305945005)(1076003)(54906003)(6306002)(58126008)(71200400001)(71190400001)(6862004)(229853002)(7736002)(99286004)(6512007)(9686003)(316002)(6246003)(6116002)(66066001)(86362001)(3846002)(4326008)(66556008)(8676002)(966005)(476003)(25786009)(2906002)(64756008)(66946007)(11346002)(66476007)(446003)(66446008)(81166006)(81156014)(76176011)(36756003)(186003)(52116002)(5660300002)(102836004)(486006)(53546011)(478600001)(386003)(256004)(6506007)(33656002)(6636002)(14454004)(8936002)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB5295;
 H:VI1PR08MB4608.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aED0zGj6HTWmnXLJa6o3xwybgaZV/xHC/D9jyJHY2CSZ+8+RCN3XRsWkxXoifczuKhrZ0nH3+hk1D8CB0NiIGDbPqA/1KlaL8a0sO1xAOz4enwQIY6YcaWLvA09XUxIb+pJ9XWZz+D4tBCRRsUaTz6h/uvD/NfcDbE0KwkXSY/3jrFbge4mDyYaY3bxleK7Arfs+DJr5Glwmzq0iMjnpIsk5jTyypXWcISljh4h3POyYT3LQSRi0dIncm5lYaeJLDRxxAYZKtf7lhyrvgQbO3olWTT3i7l0nTcCXBWqWi8QHlee5JRY/6POUqsYkxj6nu+EtEtd3qMKXolmzsxkSaakgLW72vnImC/EOiirvn6Ss93B6ZwyihmQCuGvbW38GeB5/DwfgKDXEchdR94EpYgUwQkP+wE3Bj5l21HE9PEQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0964C11C0BEC354C88E04D1A2DA8F88E@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f7b99a-2458-4d59-b43c-08d7668c4bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 09:48:25.3928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZyRZTMFVOgfDNfU9XU21BIQTwiHa56M3fqhLoWEI10pGZQlFuAV1nkFL1FzMX9mXjZ0JZhnlIxkodvmgnOFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5295
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::30b
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 12:18:48PM +0300, Andrey Shinkevich wrote:
> 
> 
> On 08/11/2019 17:05, Roman Kagan wrote:
> > On Fri, Nov 08, 2019 at 01:49:50PM +0000, Vladimir Sementsov-Ogievskiy wrote:
> >> 01.11.2019 19:54, Andrey Shinkevich wrote:
> >>> +def check_proc_NBD(proc, connector):
> >>> +    try:
> >>> +        exitcode = proc.wait(timeout=10)
> >>> +
> >>> +        if exitcode < 0:
> >>> +            log('NBD {}: EXIT SIGNAL {}\n'.format(connector, -exitcode))
> >>> +            log(proc.communicate()[0])
> >>> +        else:
> >>> +            line = proc.stdout.readline()
> >>
> >>
> >> could we use proc.communicate() for both cases, what is the difference?
> > 
> > In fact if proc produces any non-trivial amount of output you are better
> > off using .communicate() otherwise your child may block on output and
> > never exit.  See
> > https://docs.python.org/3/library/subprocess.html#subprocess.Popen.communicate
> > for how to express the above logic correctly.  The exit code *after*
> > .communicate is available in .returncode.
> > 
> 
> The pattern by the link above does not work (Python3):
> 
> proc = subprocess.Popen(...)
> try:
>      outs, errs = proc.communicate(timeout=15)
> except TimeoutExpired:
>      proc.kill()
>      outs, errs = proc.communicate()
> 
> as 'proc' cannot be used for output after being killed. It results in 
> another exception being raised.

Of course it can't.  You need to use the strings returned by
.communicate().

Roman.


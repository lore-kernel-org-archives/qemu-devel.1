Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A74C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A053D20657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="D/y5K9YE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A053D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcrZz-0002kd-VJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcrZD-0001hJ-5K
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcrZB-0002rn-Tx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:20:59 -0400
Received: from mail-db3eur04hn2027.outbound.protection.outlook.com
 ([52.101.138.27]:56889 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcrZB-0002pr-7Q; Mon, 17 Jun 2019 09:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWUsynEssvLd0oU+7yNb+cgM75LrsCu8emi0qf3Pfo0=;
 b=D/y5K9YEn2mLuvGZKzGaneGMkpyx1JSvTl9dLj9LJnOdtAyopEP2vJFUN9X03Qb9cRSfE9lmvzNjc4q1KnHj7Qi5wwFvg5N7pN4R9GYOzGho3GXUIMVVG2TYu0xcVxi8jhiJE+UrFAyXat2m+z9/yqOcXxLqLzIDwFR9TMH55dg=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5164.eurprd08.prod.outlook.com (10.255.19.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 13:20:47 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 13:20:47 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 2/7] iotests: exclude killed processes from running
 under Valgrind
Thread-Index: AQHVIH/Wi8p8J0/z1kCgZMBwauxb2KafutMAgAAR14CAAAnHgIAAB32A
Date: Mon, 17 Jun 2019 13:20:47 +0000
Message-ID: <20190617132043.GE32624@rkaganb.sw.ru>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190617111504.GC7397@linux.fritz.box>
 <20190617121855.GB32624@rkaganb.sw.ru>
 <20190617125355.GH7397@linux.fritz.box>
In-Reply-To: <20190617125355.GH7397@linux.fritz.box>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Kevin Wolf
 <kwolf@redhat.com>,	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0901CA0048.eurprd09.prod.outlook.com
 (2603:10a6:3:45::16) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c445cf70-abd5-4ce5-cd63-08d6f3269bed
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB5164; 
x-ms-traffictypediagnostic: DB8PR08MB5164:|DB8PR08MB5164:
x-microsoft-antispam-prvs: <DB8PR08MB5164662A351183CB53B86514C9EB0@DB8PR08MB5164.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(39840400004)(366004)(199004)(189003)(66476007)(64756008)(66446008)(66556008)(6246003)(1076003)(33656002)(53936002)(52116002)(86362001)(76176011)(26005)(186003)(6916009)(4326008)(58126008)(54906003)(25786009)(107886003)(36756003)(2906002)(14454004)(66946007)(66066001)(73956011)(71200400001)(71190400001)(99286004)(81156014)(81166006)(5660300002)(68736007)(305945005)(3846002)(486006)(6116002)(6486002)(229853002)(8936002)(7736002)(8676002)(446003)(256004)(11346002)(316002)(14444005)(6512007)(9686003)(386003)(6506007)(6436002)(478600001)(476003)(102836004)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5164;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ta++omPfUVR8rORnBTSEnQkr0rQ/qsUJPpnbiQm2Z6DqaQ7Gdvnk9qaqQy5mAalpT3QDoX5IbYYQtqVfVK3rAvwtwoK9O6ZMT23SjcgtYmUCZ0bJYxWdfJJUQyVwVkm1SYmwV5/hk34ngWbeyJd6c4ete230PyaAOz7PoWWuEvBGQTgbJ9LDR+odCmptXpTfmIN967n+KRnbL4WdpLo46ax2DSpdQ7YlCQd9BU+y8rrgugahXlbxW5ifzslbdRZLCe9JIXxZqZh3lGuakEOPGwM3mKOb73BbhWMh2MEugx1WM8EmG6c0oKgf99JcuyOi00YfKlPAWX/opwZxoOWPZsUkp4xdqSvVbzKGuWB8NF/MCjD94fsa9IwuY2C8nN4FQz8QkHOMg4r13pJajET3vZ178zMfK0BX8baPuDE9hkDOa1aVrDJlDhbEXxvr8AtfV+LM4lOM31wxiVx1tTCCudR7n7V245mRCmaKBBEvrh3Yw8bOCAwFV0yKjYkj0QfT
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4493B3E7A9908940AA18545BE0C718E0@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c445cf70-abd5-4ce5-cd63-08d6f3269bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 13:20:47.3521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5164
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.138.27
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iotests: exclude killed processes
 from running under Valgrind
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 02:53:55PM +0200, Kevin Wolf wrote:
> Am 17.06.2019 um 14:18 hat Roman Kagan geschrieben:
> > On Mon, Jun 17, 2019 at 01:15:04PM +0200, Kevin Wolf wrote:
> > > Am 11.06.2019 um 20:02 hat Andrey Shinkevich geschrieben:
> > > > The Valgrind tool fails to manage its termination when QEMU raises the
> > > > signal SIGKILL. Lets exclude such test cases from running under the
> > > > Valgrind because there is no sense to check memory issues that way.
> > > > 
> > > > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > > 
> > > I don't fully understand the reasoning here. Most interesting memory
> > > access errors happen before a process terminates. (I'm not talking about
> > > leaks here, but use-after-free, buffer overflows, uninitialised memory
> > > etc.)
> > 
> > Nothing of the above, and nothing in general, happens in the usermode
> > process upon SIGKILL delivery.
> 
> My point is, the interesting part is what the program does before
> SIGKILL happens. There is value in reporting memory errors as long as we
> can, even if the final check doesn't happen because of SIGKILL.

Agreed in general, but here the testcases that include 'sigraise 9' only
do simple operations before that which are covered elsewhere too.  So
the extra effort on making valgrind work with these testcases arguably
isn't worth the extra value to be gained.

> > > However, I do see that running these test cases with -valgrind ends in a
> > > hang because the valgrind process keeps hanging around as a zombie
> > > process and the test case doesn't reap it. I'm not exactly sure why that
> > > is, but it looks more like a problem with the parent process (i.e. the
> > > bash script).
> > 
> > It rather looks like valgrind getting confused about what to do with
> > raise(SIGKILL) in the multithreaded case.
> 
> Well, valgrind can't do anything with SIGKILL, obviously, because it's
> killed immediately.

Right, but it can do whatever it wants with raise(SIGKILL).  I haven't
looked at valgrind sources, but

  # strace -ff valgind qemu-io -c 'sigraise 9'

shows SIGKILL neither sent nor received by any thread; it just shows the
main thread exit and the second thread getting stuck waiting on a futex.

> But maybe the kernel does get confused for some
> reason. I get the main threads as a zombie, but a second is still
> running. Sending SIGKILL to the second thread, too, makes the test case
> complete successfully.
> 
> So I guess the main question is why the second thread isn't
> automatically killed when the main thread receives SIGKILL.

I don't see any thread receive SIGKILL.  So I tend to think this is
valgrind's bug/feature.

Anyway the problem is outside of QEMU, so I think we need to weigh the
costs of investigating it and implementing a workaround with the
potential benefit.

Roman.


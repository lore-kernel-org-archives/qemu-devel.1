Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B71C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AF420674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 11:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GkFTSyDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AF420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50166 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfNW3-0003uV-Gc
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 07:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hfNV3-00037W-0V
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hfNV1-0005Sg-IT
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:51:04 -0400
Received: from mail-he1eur04hn2012.outbound.protection.outlook.com
 ([52.101.137.12]:52568 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hfNV0-0005Ny-RK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 07:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hXqWV06rbrF78Km5XNcsivjCrHMFp8O/g3LgQE+llU=;
 b=GkFTSyDE/fy6iukxJLAiHAAb/kOeK1fesERcVEz9FJRENaGjFRLwKoP5uVgubv0dDRvWU6Jx/0mqevQJVy3cF7FNUu7mZJqWOWEZLJw7zbcfWK6ATFv8FxG58izBERcpxlUkA08aGyvQtU4xkp6JsFDhndB0uHG9D7j5L73kTe4=
Received: from VI1PR08MB3981.eurprd08.prod.outlook.com (20.178.126.10) by
 VI1PR08MB3229.eurprd08.prod.outlook.com (52.133.15.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 11:50:48 +0000
Received: from VI1PR08MB3981.eurprd08.prod.outlook.com
 ([fe80::70f3:9c8:b21:58]) by VI1PR08MB3981.eurprd08.prod.outlook.com
 ([fe80::70f3:9c8:b21:58%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 11:50:48 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [RFC PATCH 1/2] cpus-common: nuke finish_safe_work
Thread-Index: AQHVEVXwRYejWVDaoEKIMQ4+lvoMHKaq1M+AgAAOooA=
Date: Mon, 24 Jun 2019 11:50:48 +0000
Message-ID: <20190624115045.GA2557@rkaganb.sw.ru>
References: <20190523105440.27045-1-rkagan@virtuozzo.com>
 <20190523105440.27045-2-rkagan@virtuozzo.com>
 <87sgrz1c8g.fsf@zen.linaroharston>
In-Reply-To: <87sgrz1c8g.fsf@zen.linaroharston>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.0 (2019-05-25)
mail-followup-to: =?iso-8859-1?Q?Roman_Kagan_<rkagan@virtuozzo.com>,
 =09Alex_Benn=E9e_<alex.?=
 =?iso-8859-1?Q?bennee@linaro.org>,=09qemu-devel@nongnu.org,_Paolo_Bonzini?=
 =?iso-8859-1?Q?_<pbonzini@redhat.com>?=
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0301CA0008.eurprd03.prod.outlook.com
 (2603:10a6:3:76::18) To VI1PR08MB3981.eurprd08.prod.outlook.com
 (2603:10a6:803:e0::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45a22f4c-068c-4da9-31f2-08d6f89a32ff
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3229; 
x-ms-traffictypediagnostic: VI1PR08MB3229:|VI1PR08MB3229:
x-microsoft-antispam-prvs: <VI1PR08MB3229D8F3A762F05688DF0035C9E00@VI1PR08MB3229.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39840400004)(199004)(189003)(6512007)(9686003)(36756003)(6436002)(64756008)(476003)(486006)(446003)(11346002)(6486002)(256004)(14444005)(5660300002)(66446008)(66946007)(1076003)(73956011)(25786009)(229853002)(66574012)(3846002)(6116002)(478600001)(4326008)(66476007)(66556008)(86362001)(7736002)(76176011)(99286004)(52116002)(186003)(14454004)(305945005)(26005)(8936002)(2906002)(53936002)(6246003)(71200400001)(71190400001)(6916009)(68736007)(386003)(6506007)(33656002)(81166006)(81156014)(8676002)(102836004)(316002)(66066001)(58126008)(54906003)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:VI1PR08MB3229;
 H:VI1PR08MB3981.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FuekvLaAqFYj0ZjeTcgr2EyaDmUVreIU5mg6j/n6f0FFcF97arprZiPqiSOSePJ4UVI9Ui3+PXm8Rshpi0ZZcFDnLJOqQw2tGuLew8daLQVNyCYbumUfNWEgDde1I3xiyAa6ddjSwSmsShEAsMiQVpjJc+nEBMQZb3CvLmAvZGq1w2Unwnug5qzxcItjiJaoWDaP6b/Cf6KQU7BtJIKrzr0C4gYDa6rzdFfBxfGX20BDmJuap9eDkfOH0htzCA+n40NyHDdVDuuLKy1ZBThoqeRHNJv7UQk7soVPGUf8yaPyisLCe5b2takXvHMasFtB8sZ30laOswP1UEZIsellEAp5KqItmRlWQSNqgoMp5aI0k7Fk8BbKM2OMSO7ospyWx32HUhf2xydx7mBiHoai4OCdcvl45iNrf8QV05vNYqHy2CGZhfHtIijdLBIMtsymcYAuzWke+Sf3xJnfxQ7wrA6+kJtCM47u985ulypqBprNV1XCur04h9H2bpWMV7Iw
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6386B3BBD8B6064DA1031DBE273AB9F8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a22f4c-068c-4da9-31f2-08d6f89a32ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 11:50:48.7229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3229
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.137.12
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] cpus-common: nuke finish_safe_work
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 11:58:23AM +0100, Alex Benn=E9e wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
>=20
> > It was introduced in commit b129972c8b41e15b0521895a46fd9c752b68a5e,
> > with the following motivation:
>=20
> I can't find this commit in my tree.

OOPS, that was supposed to be ab129972c8b41e15b0521895a46fd9c752b68a5e,
sorry.

>=20
> >
> >   Because start_exclusive uses CPU_FOREACH, merge exclusive_lock with
> >   qemu_cpu_list_lock: together with a call to exclusive_idle (via
> >   cpu_exec_start/end) in cpu_list_add, this protects exclusive work
> >   against concurrent CPU addition and removal.
> >
> > However, it seems to be redundant, because the cpu-exclusive
> > infrastructure provides suffificent protection against the newly added
> > CPU starting execution while the cpu-exclusive work is running, and the
> > aforementioned traversing of the cpu list is protected by
> > qemu_cpu_list_lock.
> >
> > Besides, this appears to be the only place where the cpu-exclusive
> > section is entered with the BQL taken, which has been found to trigger
> > AB-BA deadlock as follows:
> >
> >     vCPU thread                             main thread
> >     -----------                             -----------
> > async_safe_run_on_cpu(self,
> >                       async_synic_update)
> > ...                                         [cpu hot-add]
> > process_queued_cpu_work()
> >   qemu_mutex_unlock_iothread()
> >                                             [grab BQL]
> >   start_exclusive()                         cpu_list_add()
> >   async_synic_update()                        finish_safe_work()
> >     qemu_mutex_lock_iothread()                  cpu_exec_start()
> >
> > So remove it.  This paves the way to establishing a strict nesting rule
> > of never entering the exclusive section with the BQL taken.
> >
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > ---
> >  cpus-common.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/cpus-common.c b/cpus-common.c
> > index 3ca58c64e8..023cfebfa3 100644
> > --- a/cpus-common.c
> > +++ b/cpus-common.c
> > @@ -69,12 +69,6 @@ static int cpu_get_free_index(void)
> >      return cpu_index;
> >  }
> >
> > -static void finish_safe_work(CPUState *cpu)
> > -{
> > -    cpu_exec_start(cpu);
> > -    cpu_exec_end(cpu);
> > -}
> > -
>=20
> This makes sense to me intellectually but I'm worried I've missed the
> reason for it being introduced. Without finish_safe_work we have to wait
> for the actual vCPU thread function to acquire and release the BQL and
> enter it's first cpu_exec_start().
>=20
> I guess I'd be happier if we had a hotplug test where we could stress
> test the operation and be sure we've not just moved the deadlock
> somewhere else.

Me too.  Unfortunately I haven't managed to come up with an idea how to
do this test.  One of the race participants, the safe work in a vCPU
thread, happens in response to an MSR write by the guest.  ATM there's
no way to do it without an actual guest running.  I'll have a look if I
can make a vm test for it, using a linux guest and its /dev/cpu/*/msr.

Thanks,
Roman.

>=20
> >  void cpu_list_add(CPUState *cpu)
> >  {
> >      qemu_mutex_lock(&qemu_cpu_list_lock);
> > @@ -86,8 +80,6 @@ void cpu_list_add(CPUState *cpu)
> >      }
> >      QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
> >      qemu_mutex_unlock(&qemu_cpu_list_lock);
> > -
> > -    finish_safe_work(cpu);
> >  }
> >
> >  void cpu_list_remove(CPUState *cpu)
>=20
>=20
> --
> Alex Benn=E9e
>=20


Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE61206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QPGtoDU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE61206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb22X-0002Cf-JU
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jb1zf-0000aQ-Dc
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:09:15 -0400
Received: from mout.web.de ([212.227.15.14]:47021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jb1ze-0004Ol-0R
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589893742;
 bh=LpMEMSMq5Jv8CFBhSOaLVllE0uAwzkcaLYAGx83EERc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QPGtoDU+us+jCSKKsdP6yVWRU8FYRXN2dcuu2YMrjtPIuyTfIsAc/W5ZhjKpTo0vM
 ZXWjmXxY6atZwfQJ50fhN/7lBe8+euVo/I4nuExehyZoRpRIGrkL8GWmOqpWaDCfRL
 PbFgeQxsUY+xxGIf12ZSOTO7xtZX08dgM57gGMrA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.149]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHmlu-1jond20e2Q-00EyeJ; Tue, 19
 May 2020 15:09:02 +0200
Date: Tue, 19 May 2020 15:08:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 5/6] migration/qemu-file.c: Don't ratelimit a shutdown fd
Message-ID: <20200519150846.2b0aa66f@luklap>
In-Reply-To: <20200518115534.GD2786@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
 <1dc261c8dce6421b80071c0eb3528afd@huawei.com>
 <20200518115534.GD2786@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/brIqmroYSohKuiwD.WTf4jE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:YNhuJfh65ul/Nj33SB1Mf5ntofnVJN6M8soggGAQnsj6O2/Wu4f
 FCN5OSN78QHMEOKlvR23E+BHHDWNXixFIO+q3KRrRCzYwM4wKYBtUJcmpC7/xmkHOyM7KPn
 2Ku64STCkXWfz2pORwmGocTx2bf6ZPcwMqTz8GLsb6vuKcU6vselbUDFiuiMhM0iXd0JsW0
 O/yUobfEwhCQCwty21VjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gZtd+3q3CEE=:WBznwl8EjvyIfgYGuc7hnS
 6PYnXBy2m/91FHPmriIEtGe4VlVuVf1EXPX95d693nJtcIlRR2XCCUkaw/dlEoa6WcexkHbf6
 pgLlugXrXXWjDpFCXbQSdBLguFj9cYEH1GctlQfn56SnxkNP3W24Q2zLCWWc9Fp/aj/mZpVOy
 kmmdyLf12mWm9U2YUSP+XlwM8MTWFKQVGMMl5VJx11Ye/LQvF0EShuabMQlkie7nPqqnZmruc
 uAKHORVI+6Iwb5VlhcIr64jC7T5dyEwumF4pCD7/jM8aCO9ZLY+psQXhcS1j0S/oubVYESwMe
 tO4XvVWYMm6DnkS+gAK3g0Z7g1jZGBU3QrhSuyShqDpZZYggyqu8OzusN59tKQu5I69D23044
 kOjtO6JyAlY9Oda1MUL6Fo5PQYjzbd0kAlJP+TgrF43TaN+VS4j7TwSNRQkJeZ0CjE3jCe3qL
 9dMsBGxQWtBqr/HaRFwnHIoioMH+B1CCdxPOznCxtPc0CmooiCisSndxzzjUCpVLrh+C4p4wC
 LSTtZKBmLfBW6m7K1qc8lnH9oZMejjadANs4vDv8Fpq2wMCjCK4uFyjNbgWFYIT/BzKId67YY
 7h/QaoLwonOYmTk2FusmKkYCJRTrH6nMzfTaXwVMzSsgHgYRioiMWOdEejchrLexenQXB/Iu0
 8U/pLFGbNBR5Pva1ewTxiRZhK8jwwGsja4XHr0WqPxaZ+rlpEZdSwpurdiqJMyajBT7wq6EyN
 rl9EXNQp59IdNOq+3RgXLJzHxGwGxf/UIuSazqs8O55JlnEHqyg0rVk1focsfjSdp5D5d3oh1
 4qgo4bmhf/6I8ELwHOcGk28JAwk8X8i1lp7EH9hyjFQN2oURZB8ljfqQt/JICJnlaq6qyahot
 CTgO9hxhhyOAkWgPmCWykxxgg10Go+ko4iawVZT2O0aWkJHUdsPZHh/QCIiR8s+z9ZdFCWDa5
 vUZ8IRUwf7gQB1phWQKs3a6nL/nFXPjzMZfYy7mQdgP7lsnvgCeHT6fX/UjcakbpO/kEbx0TS
 YXaIy6LVmPHemEelXUZ/6xLW9T8Q+rAtJCslLLZm1eJf2k7sBsdCC4vG21QQOlH7KZEy39paW
 HADTBGzxARODuI6ZYOk3r9RNn46gKB7O6A6yzbA1PmzoK4FKLnFB4Di/fvYoc3j7pnSY7LVtG
 RrMRMntzTMOVO0lx1PKZXHbm2oSrCYEm7ImzcPDjGYsb9sz331z1H0HVuPM55dNFtBOO5Ilqe
 uu83PnTPrArDBoUMs
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Juan Quintela <quintela@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/brIqmroYSohKuiwD.WTf4jE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2020 12:55:34 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> > > This causes the migration thread to hang if we failover during checkp=
oint. A
> > > shutdown fd won't cause network traffic anyway.
> > >  =20
> >=20
> > I'm not quite sure if this modification can take side effect on normal =
migration process or not,
> > There are several places calling it.
> >=20
> > Maybe Juan and Dave can help ;)
> >  =20
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > >  migration/qemu-file.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c index
> > > 1c3a358a14..0748b5810f 100644
> > > --- a/migration/qemu-file.c
> > > +++ b/migration/qemu-file.c
> > > @@ -660,7 +660,7 @@ int64_t qemu_ftell(QEMUFile *f)  int
> > > qemu_file_rate_limit(QEMUFile *f)  {
> > >      if (f->shutdown) {
> > > -        return 1;
> > > +        return 0;
> > >      } =20
>=20
> This looks wrong to me; I'd be curious to understand how it's hanging
> for you.
> '1' means 'stop what you're doing', 0 means carry on; carrying on with a
> shutdown fd sounds wrong.
>=20
> If we look at ram.c we have:
>=20
>         while ((ret =3D qemu_file_rate_limit(f)) =3D=3D 0 ||
>                 !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
>             int pages;
>         ....
>=20
> so if it returns '1', as it does at the moment it should cause it to
> exit the ram_save_iterate loop - which is what we want if it's failing.
> Thus I think you need to find the actual place it's stuck in this case -
> I suspect it's repeatedly calling ram_save_iterate and then exiting it,
> but if that's happening perhaps we're missing a qemu_file_get_error
> check somewhere.

Hi,
the problem is in ram_save_host_page and migration_rate_limit, here is a ba=
cktrace:

#0  0x00007f7b502921a8 in futex_abstimed_wait_cancelable (private=3D0, abst=
ime=3D0x7f7ada7fb3f0, clockid=3D0, expected=3D0, futex_word=3D0x55bc358b990=
8) at ../sysdeps/unix/sysv/linux/futex-internal.h:208
#1  do_futex_wait (sem=3Dsem@entry=3D0x55bc358b9908, abstime=3Dabstime@entr=
y=3D0x7f7ada7fb3f0, clockid=3D0) at sem_waitcommon.c:112
#2  0x00007f7b502922d3 in __new_sem_wait_slow (sem=3D0x55bc358b9908, abstim=
e=3D0x7f7ada7fb3f0, clockid=3D0) at sem_waitcommon.c:184
#3  0x000055bc3382b6c1 in qemu_sem_timedwait (sem=3D0x55bc358b9908, ms=3D10=
0) at util/qemu-thread-posix.c:306
#4  0x000055bc3363950b in migration_rate_limit () at migration/migration.c:=
3365
#5  0x000055bc332b70d3 in ram_save_host_page (rs=3D0x7f7acc001a70, pss=3D0x=
7f7ada7fb4b0, last_stage=3Dtrue) at /home/lukas/qemu/migration/ram.c:1696
#6  0x000055bc332b71fa in ram_find_and_save_block (rs=3D0x7f7acc001a70, las=
t_stage=3Dtrue) at /home/lukas/qemu/migration/ram.c:1750
#7  0x000055bc332b8bbd in ram_save_complete (f=3D0x55bc36661330, opaque=3D0=
x55bc33fbc678 <ram_state>) at /home/lukas/qemu/migration/ram.c:2606
#8  0x000055bc3364112c in qemu_savevm_state_complete_precopy_iterable (f=3D=
0x55bc36661330, in_postcopy=3Dfalse) at migration/savevm.c:1344
#9  0x000055bc33641556 in qemu_savevm_state_complete_precopy (f=3D0x55bc366=
61330, iterable_only=3Dtrue, inactivate_disks=3Dfalse) at migration/savevm.=
c:1442
#10 0x000055bc33641982 in qemu_savevm_live_state (f=3D0x55bc36661330) at mi=
gration/savevm.c:1569
#11 0x000055bc33645407 in colo_do_checkpoint_transaction (s=3D0x55bc358b984=
0, bioc=3D0x7f7acc059990, fb=3D0x7f7acc4627b0) at migration/colo.c:464
#12 0x000055bc336457ca in colo_process_checkpoint (s=3D0x55bc358b9840) at m=
igration/colo.c:589
#13 0x000055bc336459e4 in migrate_start_colo_process (s=3D0x55bc358b9840) a=
t migration/colo.c:666
#14 0x000055bc336393d7 in migration_iteration_finish (s=3D0x55bc358b9840) a=
t migration/migration.c:3312
#15 0x000055bc33639753 in migration_thread (opaque=3D0x55bc358b9840) at mig=
ration/migration.c:3477
#16 0x000055bc3382bbb5 in qemu_thread_start (args=3D0x55bc357c27c0) at util=
/qemu-thread-posix.c:519
#17 0x00007f7b50288f27 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:479
#18 0x00007f7b501ba31f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:95

It hangs in ram_save_host_page for at least 10 Minutes.

Regards,
Lukas Straub

> Dave
>=20
> > >      if (qemu_file_get_error(f)) {
> > >          return 1;
> > > --
> > > 2.20.1 =20
> >  =20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/brIqmroYSohKuiwD.WTf4jE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7D2l4ACgkQNasLKJxd
slidKBAAhl/RoEkwdTdpEQIL9Mzq3SiuPIiLpAhWXuuGYvVZhVcTdEDoBLASsi6f
B0eNmB/N9ecXihDbUrR6FpIXdZDb7jJ7xg5OOoWQDsC1g7jaAKUBZPQTx8syRwMT
TJ39OFCr+WVD2oGceMusZZtmAuzZeWrxBioHHvPHevFNzM683nBIahtLunRgwlEv
tD0SJm7QgwyRWzvMOMLQx1mL1Oqr/cqKaSZts/Q814My5yARgZkaMWaiYHhxJbJt
pTNmA+QCh40lQpX8S47sECUu3n67yXL6fR7VPtNOvRJ5i7sc3ou2WjrS3ECmqSLu
E7IyrmOudaqixG6rMmeL6jvCLMSqbj5QKbmQKWO99cYHwJ1uebb8KwIlYwJHauxo
XZmBCQDEqaEfsqazi3NZBYaMxupW+OoJxEXYEzaCM2A3xe8LGU7gAFJthjKVsPeQ
mru1+Wo6ArNQQYV7F2NsWoKzf1Kq8XZmbZU7tymDHf6aX0tses23ZI1sGYqcgiol
kC7YA7BQbyvtwLHZu/Qx0lmkp5x3DLlyz3uUk6z2BzPPfG+7B5S8YOtAEWTX+ByU
WtUYa5olZWybfE9CXhleOuN8zdBxi3iAX+3hPh7MYDmZAIVtpDOxPXgICBb2FLXa
tuKWW06Ickewq25EuLoIQ7wQxhOWOyL90hMQiFjrA44hdkKEctI=
=mD5Q
-----END PGP SIGNATURE-----

--Sig_/brIqmroYSohKuiwD.WTf4jE--


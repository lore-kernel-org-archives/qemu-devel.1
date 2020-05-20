Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CCE20823
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="svZbFryD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CCE20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVe1-0001Qv-5M
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 16:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVaI-000836-NA
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:45:02 -0400
Received: from mout.web.de ([212.227.17.11]:43013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVaH-0007Q2-Bi
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007491;
 bh=Z0ZIAPTS2ZPeT3zKUS7gJIPNgM4iQ1Q2zmo8H2josts=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=svZbFryDDTGhlw2oTohy/+vmqpdwrBebr8qsH2dzi4Si6kv7sJQgp+TJ8h5okZqxy
 StoXD2rIjprvOhesypqBIbfNweMmf1i0TWM8BBuAUCwqr/5MOJpe5IhimGibYsE6zt
 WfdVzABKjSTI5KwJjO1i9yumIwOrwnHuEBVQ/YKQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1jWv8k399t-00VJ4p; Wed, 20
 May 2020 22:44:51 +0200
Date: Wed, 20 May 2020 22:44:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 5/6] migration/qemu-file.c: Don't ratelimit a shutdown fd
Message-ID: <20200520224450.5a0bf201@luklap>
In-Reply-To: <20200519145020.GG2798@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <f3ea4250e6982598ffffc73924a6917dbc823c87.1589193382.git.lukasstraub2@web.de>
 <1dc261c8dce6421b80071c0eb3528afd@huawei.com>
 <20200518115534.GD2786@work-vm> <20200519150846.2b0aa66f@luklap>
 <20200519145020.GG2798@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zzml95DMGhwnLGBBuF3NK=A";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:h80tkpZ2qjF27poV1anwByM0hO2bfN5p+1NpW+nNb9qRpdSxK4n
 po+bQcAEmSG3qT+MQhLMHppfcPNc01dLl+vCXVakElTHN2z4S/9qp+RBmH02Eom3rk3gCrr
 d87w0tggqWrxlU1reHWJ9yvOaKYjXY+9wmBQNl6+IGgjjVsQz40VqCMSC8Us68VNDuJdjA1
 Ba3TbONxKX9XAMwMz7vdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WgQr+B4GyQo=:32RvOt8ZNOcIbnKs3DHh/A
 x1EWh9z8r0nfWwlW/CAJM/f8gaxAxide0/QXBx1vcUK1ysLJ39V8ZuVHLwUgSTtF67ZXCVOmq
 4X5r7flH7Xv9+YvfrdwVSNm9AwpyC/AYYISoz+coH4HsiMN+Pdq0GVYgePp9YqZb8nStJzA5z
 a9MAe5whkXe1b4z7ST5TvQLC4Xb6cKlQpRuvkq4FYJY9TnboVb+W3stTwsqhbSbLGDWPiajeb
 uz0WLyM/pKnTebE5J8XWc1KW92VhYdbmoMqnjySCX33wlIYV8FzgeUlgwwuh5G3YdixDtG489
 LaFBxnwP5LKFOgkwngz0VxW+EWiRf0mX2UpP2g0CW5jm3PBsXE8Et6J4WgebSbEK+hzHsrLFS
 50b2Gh2fpx8QIFfHmdwvoO6Pb1B/DV7UdOMuKgxy4zmQgjmqA9O/6HGwyc54TzyNRZLQrUOnt
 kJWHnB7+ED/5OtIb2lrdDSdmmiffFE58o3ikcngRk9qxEbyuwIBhxP3r/dxWrQoUSr6C//5Am
 ANfQJZeUwXPbU/dHMj8wY0BlrhBAkRo//+66NLepciFTlD+eax7nZjBIMdlHAqXvG7LQRIEFP
 IOc8w33eq8bjilaywNlX/97VvlJJM3n5YmuZ8QJSAlLp27DUXpPIqyO1UiLokLdobcwVUizU8
 uo5yy56glghXJnY1GvRPHxh120Oc0v2uzydeFA8idZFHw1FBlfbRcbNHZF7EavzC4I4Dh8MfH
 gPe64zck3jNnKHWUPO+ifZogThOeo+qcM0uQE10M5qPccJ6pjgWzW/pbO8uy7duK+cirq0tEb
 y7MgonYW6V+4det17LpSfb7V0w5AcHiwOv+bV8EBZDMmTeHRKqlkM/gca/h/P/3u+uOmQMp7b
 cjUFNEJVpyKhptEWivdttsekjMU6DcrvBZoV3K6kHnSe0T8JyJ2RUprGbupfNz67/ubs2zno3
 4jaWONXiDnBYSQz5Kz3S6Qvq6xP7RT1h1oeRZEhocZ1dMBXRmT8HULjmQMq+y0YWgJAP9K1kT
 7R/HCNzXgJ0BHNQa7mXTax6vGmO0lySRQ4DZlGV9ifOSN+QOEWbmZXdY6AQ7nTzd3a9Uuk8c0
 c4Cs2STS6WP7yU96Km8GkpLwtxB78DYL6RaxgZwWV88Syf6qcbut++eXZDEE2MLSO1dCZAxmh
 PGKyqEqL0KNz6BS4+/cWZdrTC2rmMwqjuTAsMdBFlXbVK+pjNLYAT1jQ+OjxOsH2nfxF3Fw1S
 J82QHY6415HUllJ31
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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

--Sig_/Zzml95DMGhwnLGBBuF3NK=A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2020 15:50:20 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Straub (lukasstraub2@web.de) wrote:
> > On Mon, 18 May 2020 12:55:34 +0100
> > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >  =20
> > > * Zhanghailiang (zhang.zhanghailiang@huawei.com) wrote: =20
> > > > > This causes the migration thread to hang if we failover during ch=
eckpoint. A
> > > > > shutdown fd won't cause network traffic anyway.
> > > > >    =20
> > > >=20
> > > > I'm not quite sure if this modification can take side effect on nor=
mal migration process or not,
> > > > There are several places calling it.
> > > >=20
> > > > Maybe Juan and Dave can help ;)
> > > >    =20
> > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > > ---
> > > > >  migration/qemu-file.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/migration/qemu-file.c b/migration/qemu-file.c index
> > > > > 1c3a358a14..0748b5810f 100644
> > > > > --- a/migration/qemu-file.c
> > > > > +++ b/migration/qemu-file.c
> > > > > @@ -660,7 +660,7 @@ int64_t qemu_ftell(QEMUFile *f)  int
> > > > > qemu_file_rate_limit(QEMUFile *f)  {
> > > > >      if (f->shutdown) {
> > > > > -        return 1;
> > > > > +        return 0;
> > > > >      }   =20
> > >=20
> > > This looks wrong to me; I'd be curious to understand how it's hanging
> > > for you.
> > > '1' means 'stop what you're doing', 0 means carry on; carrying on wit=
h a
> > > shutdown fd sounds wrong.
> > >=20
> > > If we look at ram.c we have:
> > >=20
> > >         while ((ret =3D qemu_file_rate_limit(f)) =3D=3D 0 ||
> > >                 !QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
> > >             int pages;
> > >         ....
> > >=20
> > > so if it returns '1', as it does at the moment it should cause it to
> > > exit the ram_save_iterate loop - which is what we want if it's failin=
g.
> > > Thus I think you need to find the actual place it's stuck in this cas=
e -
> > > I suspect it's repeatedly calling ram_save_iterate and then exiting i=
t,
> > > but if that's happening perhaps we're missing a qemu_file_get_error
> > > check somewhere. =20
> >=20
> > Hi,
> > the problem is in ram_save_host_page and migration_rate_limit, here is =
a backtrace: =20
>=20
> Ah...
>=20
> > #0  0x00007f7b502921a8 in futex_abstimed_wait_cancelable (private=3D0, =
abstime=3D0x7f7ada7fb3f0, clockid=3D0, expected=3D0, futex_word=3D0x55bc358=
b9908) at ../sysdeps/unix/sysv/linux/futex-internal.h:208
> > #1  do_futex_wait (sem=3Dsem@entry=3D0x55bc358b9908, abstime=3Dabstime@=
entry=3D0x7f7ada7fb3f0, clockid=3D0) at sem_waitcommon.c:112
> > #2  0x00007f7b502922d3 in __new_sem_wait_slow (sem=3D0x55bc358b9908, ab=
stime=3D0x7f7ada7fb3f0, clockid=3D0) at sem_waitcommon.c:184
> > #3  0x000055bc3382b6c1 in qemu_sem_timedwait (sem=3D0x55bc358b9908, ms=
=3D100) at util/qemu-thread-posix.c:306
> > #4  0x000055bc3363950b in migration_rate_limit () at migration/migratio=
n.c:3365 =20
>=20
> OK, so how about:
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index b6b662e016..4e885385a8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3356,6 +3356,10 @@ bool migration_rate_limit(void)
>      bool urgent =3D false;
>      migration_update_counters(s, now);
>      if (qemu_file_rate_limit(s->to_dst_file)) {
> +
> +        if (qemu_file_get_error(mis->from_src_file)) {
> +            return false;
> +        }
>          /*
>           * Wait for a delay to do rate limiting OR
>           * something urgent to post the semaphore.
>=20
> Does that work?

Yes, this works well using s->to_dst_file instead of mis->from_src_file.

Regards,
Lukas Straub

> I wonder if we also need to kick the rate_limit_sem when we yank the
> socket.
>=20
> Dave
>=20
> > #5  0x000055bc332b70d3 in ram_save_host_page (rs=3D0x7f7acc001a70, pss=
=3D0x7f7ada7fb4b0, last_stage=3Dtrue) at /home/lukas/qemu/migration/ram.c:1=
696
> > #6  0x000055bc332b71fa in ram_find_and_save_block (rs=3D0x7f7acc001a70,=
 last_stage=3Dtrue) at /home/lukas/qemu/migration/ram.c:1750
> > #7  0x000055bc332b8bbd in ram_save_complete (f=3D0x55bc36661330, opaque=
=3D0x55bc33fbc678 <ram_state>) at /home/lukas/qemu/migration/ram.c:2606
> > #8  0x000055bc3364112c in qemu_savevm_state_complete_precopy_iterable (=
f=3D0x55bc36661330, in_postcopy=3Dfalse) at migration/savevm.c:1344
> > #9  0x000055bc33641556 in qemu_savevm_state_complete_precopy (f=3D0x55b=
c36661330, iterable_only=3Dtrue, inactivate_disks=3Dfalse) at migration/sav=
evm.c:1442
> > #10 0x000055bc33641982 in qemu_savevm_live_state (f=3D0x55bc36661330) a=
t migration/savevm.c:1569
> > #11 0x000055bc33645407 in colo_do_checkpoint_transaction (s=3D0x55bc358=
b9840, bioc=3D0x7f7acc059990, fb=3D0x7f7acc4627b0) at migration/colo.c:464
> > #12 0x000055bc336457ca in colo_process_checkpoint (s=3D0x55bc358b9840) =
at migration/colo.c:589
> > #13 0x000055bc336459e4 in migrate_start_colo_process (s=3D0x55bc358b984=
0) at migration/colo.c:666
> > #14 0x000055bc336393d7 in migration_iteration_finish (s=3D0x55bc358b984=
0) at migration/migration.c:3312
> > #15 0x000055bc33639753 in migration_thread (opaque=3D0x55bc358b9840) at=
 migration/migration.c:3477
> > #16 0x000055bc3382bbb5 in qemu_thread_start (args=3D0x55bc357c27c0) at =
util/qemu-thread-posix.c:519
> > #17 0x00007f7b50288f27 in start_thread (arg=3D<optimized out>) at pthre=
ad_create.c:479
> > #18 0x00007f7b501ba31f in clone () at ../sysdeps/unix/sysv/linux/x86_64=
/clone.S:95
> >=20
> > It hangs in ram_save_host_page for at least 10 Minutes.
> >=20
> > Regards,
> > Lukas Straub
> >  =20
> > > Dave
> > >  =20
> > > > >      if (qemu_file_get_error(f)) {
> > > > >          return 1;
> > > > > --
> > > > > 2.20.1   =20
> > > >    =20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >  =20
> >  =20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/Zzml95DMGhwnLGBBuF3NK=A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7FlsIACgkQNasLKJxd
sljI9Q//SZIY+NEhG82yDYy89YffPmm/1ZZkX4ftz9dGRlm2i/iJIGmK5nPu/dlP
gGiG8WyYWrkFBmmvHB4jf8s2di/+5lq7etV7peA3SRBx91rDj5xLVDT+UTw5vE+U
sNnehRDGDGuCJ6V5eMoAOnlJx9T2QcxNea97Ca0cMtVeOG4W5wmm4Yi3WxtdyEdS
WiHgfsdt6XOx2m8NQRyjzp+6x0+fEq9pHeUBbHJ5H4l5tq7fAVfNkrWLUYTBlvTN
a2iZ8q6P04DLqj1AcrnpxQy/y6KNg4KWGybhTB6qOyhp48TDvZ/EB8a7RQWIqULd
fzzLuEOOTxXfUfz2EykA3zxTBWEHXaGJsrd4WeMr3sQ3q7vI2K/H+LZReOrkviiC
qW9OxUr9a3+wDlKuWV88fLOBu2CC/pl5ZHrti+DtVIenmk3KyOBtDFPoFzGPAsfw
AniasIrz9SgGzYTx1EvTzGvKIMyDofq+pNjnZ4m06csVsCJ25PPdq/7QOX4msT+B
rvKtEs29x9Yw0ov3dZf0sY7matksP6AFYsBxOmqPll5Z2K6liYkHMRcyRo3vNIZH
JbkwEjefUqCEB76puHu9oN0sxvFzYrt3Ox8Nxw3Bb1QkLqlb+qP1BhVAuybETfay
/LkTVbINAsH6jhPNEsJ5RkiidtZmDcpjE46iE6Enybd9yMJVCN0=
=SzKp
-----END PGP SIGNATURE-----

--Sig_/Zzml95DMGhwnLGBBuF3NK=A--


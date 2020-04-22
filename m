Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9F6C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989312071E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aryA2ORM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989312071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRBxM-00048e-6m
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 05:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jRBs7-00025O-4i
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jRBs5-0006Ys-Sg
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:40:46 -0400
Received: from mout.web.de ([217.72.192.78]:48859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jRBs5-0006Tr-4Q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587548430;
 bh=5bcn+DatzMy5m6CIOMhkFLL9Ccn+4atXUc9D9snmyfs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=aryA2ORM+Tyq/QwD7aGnOKcEdD3Fl/ksDtzM6yWYigLezLq2SSwM/pgnu49S4UM7v
 KrSvnCI+lkRSfY+4n0E7NA1VcXR+GBIoE913ZZjVcwAoD4pH8gqjxXbsmVqWrhIgtE
 7bL39VmmJZmTUG1Mr3X5KV/WcPhkFoQtGAL+sWbM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.91]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ldn6l-1ikBx719Ih-00j3RE; Wed, 22
 Apr 2020 11:40:30 +0200
Date: Wed, 22 Apr 2020 11:40:20 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <20200422114020.3d479899@luklap>
In-Reply-To: <0a075de2dc2f4e8c919478762e9a97da@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
 <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com>
 <20200422104325.64659930@luklap>
 <0a075de2dc2f4e8c919478762e9a97da@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yVfpQnu4iKR5ZifMJO5K22v";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:se4OTynVvPYdVtkj8VSlZgrfYx4ivRHvopko7TwExr+mFkXDYtJ
 77mF12Zl57zuXqC6jIAHwJuI6xsDF0zcLM0M77ioqWWGHm8ND3mgl0kjFlWrJoXlA/umtek
 auPCSvMtwvEJYvQMlMXquRFqZ+AvLR3/AysxoExH4u2epQkNG05tDiTbG0I3UCRThYEMWgb
 Xpznoi7DeOtGr12X8jzAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JWRfYkvPXrs=:saU+/Pe5Uh63D28GvZOAHF
 B7E4j4iVzj3d9TKZjdh2rGatO90+ieq9MN5/EF7KwwKxSqIASyjrxj2WVO8J5xmCRpic4Khog
 Cej/hY9aTw9NWzTsOWBgNfVzrOhuu7abErWShenqWUuLIGZmAOMMAqq/cAgs9o5JeCG2jmH0Y
 HYtOPBMTuUbBX5HbQ9nuiWSlKLW2uEPImE03bzcMHJwwx7sYO/NEZPkicinSyTVVuWl2GDgRi
 nlo1Jze/9CrLOyperchqUb32tQ9wYmtJGL8QC21EZ/zHksDBaSakJbNAZWL6FsvQLiIFyy6eF
 8xD6Qk0F5v0LtM+pNbNZFfu4Sm8REI72lIdV95jtaWibqNvB8nCQjnUCNU5pjZN3MzOxiC7da
 XVYc3S13mTHgJHAXBimpuKSGVwcEhMM8BE03i7Y1mIbNQmTAgxPY86z3bLch25jMonMGJna7W
 sSAsoQBMuascgMCvLpjafzcgn5EMJrJBwJ1/4+vNJKGpQ+532LRuwrJuUHi7SL8bb/ToOLMnF
 dJnFx2oXKg2dCz4O+tbeuRbR1RS5DFjraZPX3XCXRSwUY1ZwQipm8xTAnZFJRg1iDWTA2G80I
 eMfS5sOLOfFjDCd2RhLkXfURnDxQycjJRKiREfuQ588MivwPlutm+2U7JHbhsPiUyLki1uVJS
 Ag+uf1ai34gfO6eaxFl05HTvMc6mAJP7XPmhno3LDwyTenV93BVHDP0Vwan09oTwNHXV1hduu
 0P3BJ5+PgnF4VhKPMi7SPKtEDVBWHS35L4EkHtakXcAi5VjpyS/MqQDvXnkVWSRryhHng7txe
 zUdgbXvbkXlGwB+xBTkpH7Z+RhVCl3yZKeBNXV34o2utRHAWWeuq1PGuPaQ0dT0sdO6iv3MhM
 LRCb2Rw/hdT5e0zos6B63iWRXkCRvSlSuSfYQncUHv3WvJgP7/79v6dQRBvN3N5XqkxS8Y2RY
 MxgWx7GRhgTA4UFRtXaXK1Ai9vYmLG0D+tUuTi7zf0UwA9GjgKt61h8uO5ggB8CNDbfBV+dIk
 9WWC5ikrtIv8d47nzJMpTWZGDCjTGukZneG50c5hqCiUArmT1xCnN+9mRmxfzzDIB/8XEpESA
 ihrSUWxZ23Nnyu1wPeHB4L1dwgMJTgpQQEZT5pWLWrehSMNYftehD+piVEqwXWRl+nhN4ccZq
 /xx30+iq/Lp6cR9RtkWOCKJ1TW5evIsjWHF6yrrROm6Hqevg8mzh5jqkw0y8ZuvYiWXw/dN1a
 ul99XW/nL5dexhQUF
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 05:40:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/yVfpQnu4iKR5ZifMJO5K22v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2020 09:03:00 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Wednesday, April 22, 2020 4:43 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: Re: [PATCH 1/3] net/colo-compare.c: Create event_bh with the r=
ight
> > AioContext
> >=20
> > On Wed, 22 Apr 2020 08:29:39 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > Sent: Thursday, April 9, 2020 2:34 AM
> > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > > > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>
> > > > Subject: [PATCH 1/3] net/colo-compare.c: Create event_bh with the
> > > > right AioContext
> > > >
> > > > qemu_bh_new will set the bh to be executed in the main loop. This
> > > > causes problems as colo_compare_handle_event assumes that it has
> > > > exclusive access the queues, which are also accessed in the
> > > > iothread. It also assumes that it runs in a different thread than
> > > > the caller and takes the appropriate locks.
> > > >
> > > > Create the bh with the AioContext of the iothread to fulfill these
> > > > assumptions.
> > > > =20
> > >
> > > Looks good for me, I assume it will increase performance. Do you have=
 =20
> > related data?
> >=20
> > No, this fixes several crashes because the queues where accessed
> > concurrently from multiple threads. Sorry for my bad wording. =20
>=20
> Can you describe some details about the crash? Step by step?
> Maybe I can re-produce and test it for this patch.

There is no clear test case. For me the crashes happened after 1-20h of run=
time
with lots of checkpoints (800ms) and some network traffic. The coredump alw=
ays
showed that two threads where doing operations on the queues simultaneously.
Unfortunately, I don't have the coredumps anymore.

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>=20
> >=20
> > Regards,
> > Lukas Straub
> >  =20
> > > Thanks
> > > Zhang Chen
> > > =20
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > >  net/colo-compare.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > > > 10c0239f9d..1de4220fe2 100644
> > > > --- a/net/colo-compare.c
> > > > +++ b/net/colo-compare.c
> > > > @@ -890,6 +890,7 @@ static void colo_compare_handle_event(void
> > > > *opaque)
> > > >
> > > >  static void colo_compare_iothread(CompareState *s)  {
> > > > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > >      object_ref(OBJECT(s->iothread));
> > > >      s->worker_context =3D iothread_get_g_main_context(s->iothread);
> > > >
> > > > @@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState =
=20
> > *s) =20
> > > >      }
> > > >
> > > >      colo_compare_timer_init(s);
> > > > -    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
> > > > +    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
> > > >  }
> > > >
> > > >  static char *compare_get_pri_indev(Object *obj, Error **errp)
> > > > --
> > > > 2.20.1 =20
> > > =20
>=20


--Sig_/yVfpQnu4iKR5ZifMJO5K22v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6gEQQACgkQNasLKJxd
slj7XxAAl9sYGKtokkkbRkB+geV5n+q8KJsTKWsPn6pDBk9LUAqpS2jvol1Jiba7
EkchMKTy98zJMXb4IXiBNvPkFdV8uQCjC1iAikgspL3VyM0HHN9tR++e8W/exLTC
jMB3lcrtDM80CpcmbyRmcqeeu+rNjzwaFiPPp6Ytywsfc1vwDfTq7lNrE84vnelB
wX64FldB8ffTG9hysXregqNZq51sPMtaaoCOVM4Pl8JVuR1bpXYxdBjqD9cQWl0L
ALP6Qw2adAUU9f+fkNzylmktD8irA9IfcCEPzQDtThpISvtqetPkcUhAHEUUFdpC
7dNnshf0eEtPQlGwWWaU+WL3cfnO+ABfcjhpIkeyF8eVANtOY62Rwr9LaiflNwNC
+qGXz/C8gR5V9Ans/8sWL6fVcHdFoTvYo9nGTsdzJUOjPpkMnvcNwj/CcMR445S8
Zupo+lidtTDddVf8zyfQYZlLlnsCS+IZiCLk6jx/8i3JA+47dnrONnWiyK/ZI38q
NEQIupyoNoc762KlpoaxsZOAAJVV9o/2HUx9Yt+V1pne4SOLkqksFJNmNS2p0tUH
TdYlbqV3r6HkBl1PdxIG+vVX7mOdvLw2Ji6Z3kT9Famo6/NeGrbWfaG7dZUeKryU
odW96Cs+b7CJBrc8UIIVletcADDYfwCHjvuubql2klro3HFrLek=
=iNtO
-----END PGP SIGNATURE-----

--Sig_/yVfpQnu4iKR5ZifMJO5K22v--


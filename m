Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C94CC55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120CD2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LPZcAi1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120CD2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRB4n-0003TY-Ud
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jRAzF-0002O2-4Q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jRAzE-0003we-6Y
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:44:04 -0400
Received: from mout.web.de ([212.227.15.3]:57269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jRAzD-0003eT-H5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587545023;
 bh=85tEWY6dC+XFXmpWR2XWEU1p0QETJlqg30bz9CPIIG0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LPZcAi1m56eyGSJ5meKALHr1iMO0QVTnEL1hkz8PUKMjCFZ12LwiTnGaQdeUkZr4R
 CESXfvnldtdqrrUbJ+5OFt4VyrlCIoye4p9Hc7C1LA1jxwKBCGnqjExrvPYYcdMJso
 oMCdzUzGP/sGcviFofqmdbffFm6f9o/lU/eAZ7s4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.91]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmxtE-1izqRG3AEe-00h6wt; Wed, 22
 Apr 2020 10:43:42 +0200
Date: Wed, 22 Apr 2020 10:43:25 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Message-ID: <20200422104325.64659930@luklap>
In-Reply-To: <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
 <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C6DkmBY7CeuN9QFR791dHTS";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:X3RkNJOVy4zfQKcYxDaslYHVlULMf72bGzS15cfbOr5msxuiK86
 rUzBbPAiKzAfkuqEm3UHrXOu6Wbso2nc5GDOnvhZ8aHkcdYwdWpUKsGblu/1383M/NjDamz
 I+C6la3bZ4mppdmwFxXGzGh7PjWplckg4yyqOfoPgasFg1jzsUYg8kzZxZwrFoxxR4teKF+
 XSmLHCAhxrbq8XEKXiejw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Iy3JdNPOsKc=:gsYpwhaoVbjL/PJ/p4qe7Z
 /7u5hIp2122YqnupYe/FL4oYoMDd9t4PENQVwGW6dbbAo1H57IESgb3nB2G1RTGSiseU8HPaa
 fnV6OAYa5NTD0ztNZdKWBTBCSVKwX5vaJnaJ8H1uhY+HqATF0VFaexMipzPcC0zS+bVF7LwfY
 pxqMjk9DE3zBWrcNN6gmMXmipame1eLSPHyJCBXdBY3/LwkQZuRFMwQmq+iuzyq7s9r+SVX6/
 p2Tfe0xR67SYZLMgH9d7E3uy+9AXKaXxX4PT5zIkVRW5P8ENUlJIZ/pRaKJMeWSdsoeOdk4ej
 Y6f5zN4rr1Cb6695mUCXqHuacP25l6TQvFblI22Uc252OYYAaxuvMLaisgoIfvnatFIxxJroY
 UHOQwFx+coiMsUal4OADOIMyNa+BXNTD4W4gc0l/hRFYC/pftFxudju7vXpGhPklhgEEW0Auu
 I3JIni42JpnFKe05+jba65rKuDxfyv2WdSB3dLdTeOhYc2kx1r57sIHNdYedaXep76EHvgii5
 iK0psIC9+6eyHzyUo28cARj7z5vK5O6VJrVverVKs8BxdAOdV2qJ0ZS0oSkW+rBFBqxKyHpAO
 mz+xnGx5vpoUria/YhTYceC+KkhXJfmuki1tlLYHF/3tYyp8NyuLuwoqMhm0tJw78YF7lk+3z
 y9lnr7Obl+gM8iq90v27SXi7eabbjhWhZnhEsaTUV7pjsbGg+WqOCx7vr+ubsTxIeon6fev6S
 s2IsH7iWhT+zns2oOaPzgcHrVxpLVy0D5iZWLY9eRfqPfBz0fqNVTUg35vikP4gnTtLXqeBZx
 T6uskmOejvh1lauGiiXkJXA/CJiNHorX22grVqEJjOlQfQEnitUhsdsVeJar/5p4cVDkXuEMU
 HIjExGtcWfm5OJ+lPpCZusnR4Uq1H8yvGpCgxxR+LcksajzPP7/EIPYj8wdHqoK/NRY3Y2y1S
 oHixQCGPsUrO2ZuGGZaGzTZSRamlEgWEU3LRc7o0tCUn6dssiZLPstaLr7TG7SDh4p5FvRfjt
 bponREVuzZSgYlcbVLXIq6rrhlcbx2sLYzX5EhPh+hPnkwdrYosdr9hO+LrFYT24avrDCVnTP
 dZHiE4tdxYBakQg380qWxg7xES58c8ildCOoEzzTywuyDQUbUmsYvAf9f32SH88CCIWGRvJv6
 IO/iN+DUVwCJQxIxsQu4AWwapJbl0AbcEKHYEF6qPEp0sjue5UDtn4kP+sONJVwD8v4MgOJqI
 IK5+r3+cdHPjwh0Ch
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:44:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.15.3
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

--Sig_/C6DkmBY7CeuN9QFR791dHTS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Apr 2020 08:29:39 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Thursday, April 9, 2020 2:34 AM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
> > AioContext
> >=20
> > qemu_bh_new will set the bh to be executed in the main loop. This causes
> > problems as colo_compare_handle_event assumes that it has exclusive
> > access the queues, which are also accessed in the iothread. It also ass=
umes
> > that it runs in a different thread than the caller and takes the approp=
riate
> > locks.
> >=20
> > Create the bh with the AioContext of the iothread to fulfill these
> > assumptions.
> >  =20
>=20
> Looks good for me, I assume it will increase performance. Do you have rel=
ated data?

No, this fixes several crashes because the queues where accessed concurrent=
ly from
multiple threads. Sorry for my bad wording.

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  net/colo-compare.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > 10c0239f9d..1de4220fe2 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -890,6 +890,7 @@ static void colo_compare_handle_event(void
> > *opaque)
> >=20
> >  static void colo_compare_iothread(CompareState *s)  {
> > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> >      object_ref(OBJECT(s->iothread));
> >      s->worker_context =3D iothread_get_g_main_context(s->iothread);
> >=20
> > @@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
> >      }
> >=20
> >      colo_compare_timer_init(s);
> > -    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
> > +    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
> >  }
> >=20
> >  static char *compare_get_pri_indev(Object *obj, Error **errp)
> > --
> > 2.20.1 =20
>=20


--Sig_/C6DkmBY7CeuN9QFR791dHTS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6gA60ACgkQNasLKJxd
sliBNhAAhAmKDPgC47N6qcO+XCLrzGAxL+0w+4DwaG+GEJ+KwwiW/akwjvAM9ya+
ATdwd9ukitII63BKSuKRgiqBrT0VTksaSpm13XfpFcRmswnAoRjbX8c6d9qmm8Aa
U38UGxolmVn5YIlS530UObyw0XJbmt0T80E7Wg648edRkMUHl6BrTFuFING4eN0t
kfEtXaG7ZnHFAVtlRZjCddI25uSSvxFcgr/Fgzs7aIm3ISEoGtRBIljjidLQKn7V
YA4VwD9mSAHYW9ZTcg9pjCn9OIUmnQ9FBLi4DjWJ1zj6InjFMbcbmP19gKvcToRF
n5yHdk1MdmY5Uf+1tp8qQu7fV7l8ehwYaicWZXgDTojZkQPIHJGCKXjIA3aJxmwN
tGCO6thI8AKPYqaBgLkOA9gXxyPVn1S601jfRxrkFTQE7eZB1rANHy+NtMwvy8dS
aUbb1PzL8W7b8mtp6cdRVzsMwTZd++Punn6kA3IPG3DG3dFIk2NytlhTt9wpVe00
VDk5CpJG4YHYu9/+jaf9x8dSopsU8f6y3fWfLL/fUueS/ZCYGIgOLNEAvuZSL6uS
oSOpwHJbcGQEiJdXg5nhJMKWRwaBekcjDaB+fHYonnrmCfjg31Z9MEwl57ybhJys
4/n7YpVAnh90uz3FrlkQsnRdHGVDJUGuEQh336KOTd/Y/p77Bio=
=h8t8
-----END PGP SIGNATURE-----

--Sig_/C6DkmBY7CeuN9QFR791dHTS--


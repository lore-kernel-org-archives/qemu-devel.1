Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E03C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2796A2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="okHbDwWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2796A2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYwwr-0004hh-3j
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYwqj-0002dS-Ky
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:15:25 -0400
Received: from mout.web.de ([212.227.17.11]:37993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYwqi-00060D-LR
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589397313;
 bh=RK/Z3ELekQrCT4lP/dIzoJVtwwmtn6Si5TQdvF3vwhQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=okHbDwWlzV5oiGq4pSjZgScwlc67vfdZaXdN6FjUjTUBRNgf4kv8bkypLjEmLPnDH
 1sNNGvHQpsp6DntYfZgSz8nr6KPxpHR7ja3F8bPAkSzOm2lAVhKgC6wEvWK6RapdQ3
 AUiRWvJo4+CUWYW6NTUmKf1b3Fv7Sk040MeKHUX0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.82]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrgv-1jgsnF3KwX-00Ru7s; Wed, 13
 May 2020 21:15:12 +0200
Date: Wed, 13 May 2020 21:15:11 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/6] migration/colo.c: Use cpu_synchronize_all_states()
Message-ID: <20200513211511.6430f357@luklap>
In-Reply-To: <20200513094702.GC3225@work-vm>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <9675031ce557b73ebd10e7bd20ebbf57f30b177c.1589193382.git.lukasstraub2@web.de>
 <20200513094702.GC3225@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BmLbFJ1jN_HAlI+a44ZzY6X";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ECFjewQ+ZRgBnjiLuYJaw0hkEbXhjHqRNJVJK8BD45cPaVh0iPi
 h0X4JaMu3nn1fagsjigIdkz6opgHRjznkD8LjV52slfm0wh59P+KhmwXS7Qs9ZpU3xGE8z6
 aSX58d+fzqpiyes4hNBbquTL+1mg3Zq6E6HrCW23bElV+jxQ/s6tTgD0w7vArK3Huj8+Arc
 mWQSHWTydKUZqh+n1M4hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gxAm4sglJh8=:t+ryGFZ/vWf1rnPYmU96R1
 HxB5ZlwFKT7JONikPgXdgNPVfW60l5CeJ9mrxqXqhkSXg+gAaAkR2j2pnaBCK+HvMZmVk9IPV
 V5knuDYGq7LdhqdLxD7PvLSDYjhP6JimkevsLoIYyqKTZ/ekA7enVUtN7hlnUiGtlOCRQeBGd
 lsQF/x3NSdw8IpO6QsxiGYTXoDtYhgSmFnocbnkKF18TC8UsfsgUKkZ1Foq8yJz2FfmEA/sd9
 d78l7FI7Rhs6Leao4lgrB9uJS6zYv1QVl68RNEwXXMrsysIJAXErFSAYH/sRXdw+G5KDo/4P0
 zzjMSYf7tz4EPzJD45h0uvkdTayAR/MLn4yrlijcbUb8lNQl1qqdGBLsaTADdeeyuQQUierVb
 TU+GPoC4WNx0VOemKwOGz6uqaklfdOtPSZZypDXAegem7s4qhkgGFb56b608O0T/KxdcoFkoP
 5C8T88zjKM76+vn1g2Dm7BxTeAkLfbE2vbHETOt7HQ6FrsM9FVEBRLOYJpw66K6j1sP1N26qQ
 l2Z2HUoOvWC+afiAtLNj30pU0cEUtOgS3tRK3FtPdsRrrOHtPkFg04x+LGXALkVyAgBKpzPsQ
 hcrJIxT9qeNe4qCVHb8+cOqR5LvpjJmiwlFu8eRAqTXbvlCrQ46UTsGuNA50k/yQ/rJht2D1b
 q9z17zrnne3i8gJSdq7ahFwgcuXNmtEfCgMQwGRJ83eHE7rvklMVf7r6FZ9IepvyEm1gONnQr
 ziZKwTkKJ9uBLR3H6uAhqgUdRPqhNusMRU39nbSkyZnHC0xah6gZIHe4522/7HbXeSzexdmit
 FwwDaB36c6WK26MfNaTdGX35R+hpx8tJNzBqxfsoopOJcobP1Ym1XQAHnsR2tic5K3kiNe7RJ
 KKUE4IFy14aCpE8Zb3wrpFbkQVsgCo/bVHzQtbI+JBHNBPW2fnD9ObKxwC29QyuBZx9lZdPus
 lodQpyNlle3FlwtAcPMPuasIFlie88P08sCdPoHXaCZbdn06FvgmOD9dHTodrkLr+TW9jI1hs
 WXCzn8f7CZJKutHZAj+J66QSMCXZTUa1gZk89mgFmoLERFXSFjTc1by2A1o58sJEnVYQlh2tB
 dxO4laLG0t9miflneVcOcXIJYI0Y4/J7SstdCGQDOky+TQvrWLYAvbxmt106Yee9z5NwDk1+e
 2fHr2hvPyl8DHrgLOkMcle7Le/NBivqO7z7NqPXYuD2lFxX6wu4OSotHWMvxABwsAfrvroLzc
 9JO06fqlTYPZRZXBT
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 12:32:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/BmLbFJ1jN_HAlI+a44ZzY6X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2020 10:47:02 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Straub (lukasstraub2@web.de) wrote:
> > cpu_synchronize_all_pre_loadvm() marks all vcpus as dirty, so the
> > registers are loaded from CPUState before we continue running
> > the vm. However if we failover during checkpoint, CPUState is not
> > initialized and the registers are loaded with garbage. This causes
> > guest hangs and crashes.
> >=20
> > Fix this by using cpu_synchronize_all_states(), which initializes
> > CPUState from the current cpu registers additionally to marking
> > the vcpus as dirty.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> OK, so I think you're saying that if the qemu_loadvm_state_main fails
> because we failover, we now have duff CPU state, where we should just
> carry on running on the secondary with the current state, so yes

Exactly, Sorry for my bad wording.

>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> > ---
> >  migration/colo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/migration/colo.c b/migration/colo.c
> > index 09168627bc..6b2ad35aa4 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -696,7 +696,7 @@ static void colo_incoming_process_checkpoint(Migrat=
ionIncomingState *mis,
> >      }
> > =20
> >      qemu_mutex_lock_iothread();
> > -    cpu_synchronize_all_pre_loadvm();
> > +    cpu_synchronize_all_states();
> >      ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
> >      qemu_mutex_unlock_iothread();
> > =20
> > --=20
> > 2.20.1
> >  =20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/BmLbFJ1jN_HAlI+a44ZzY6X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl68Rz8ACgkQNasLKJxd
sli88RAArINdSMqWl/lLtFyjvSel8nRQs4z+56Hyw/ftsxP4KPaO2/YSfv5qldVJ
BeAeeYjcUPtrK+eqPSo/tCT8tOyjXvIpTU9Jsb9ScKdqzERNcPLLHWeXTVcmHM8q
qc2MKM039oN7SU1swCk43CzV/9BlxI9mjwLFE+ZkLHfc4pwrffCkd+BlJvXz/apv
pkuITqiZFipAp3xyutCmn1U9OZXqJVORnoKVqkZY0K9O0sr4X3jbX54M7qfL+prc
DSGRe0jstkg7fT/L1qryrcknSjyWpBvRA2zXZh0vA+jULSj+q3Cjg7C0BZz5A6EU
0ei3Fc3k4Gfn3e1tbBdtOFT1g1IDE6431SA/vBsfGwV0sFkwNKfUbeNxGi/G1FT3
D34kCRobrI5qIMkKFAvCmx+n5XuLW68rU8aSiLjc9uvI5UpcWvSAlYP3EvnxWd2h
PCUdHioUstxLYUI+MhbIokLaw5PklFQ9V2EdY1SdHlwTaECk8/qJFAd8QbIvHt9T
f9diGGUiw5isvz7l1i8+lECFc41/AQNubPIV3pCOgjLCOqKjMlUdcOsGvreI5wwJ
YGZPdAtXE4vd6dBfcwRMfW7QLhNRyiwzXuTXvorR7U8j9fdcqxugNLIkIPwMMl7c
ZUgokUpz+jTiqUIFNDUY0Mc6uVscqGwux8/Ay0sEhEe3lF7w7W0=
=EcAb
-----END PGP SIGNATURE-----

--Sig_/BmLbFJ1jN_HAlI+a44ZzY6X--


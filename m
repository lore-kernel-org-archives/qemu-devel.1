Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC14C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADC020888
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWJOa5jG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADC020888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZGo-0005eb-6m
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZG7-0004qT-CA; Wed, 17 Jun 2020 10:41:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZG5-0000W3-Rp; Wed, 17 Jun 2020 10:41:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so655482wrm.4;
 Wed, 17 Jun 2020 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yHSsY/mYJuBAJ4v9IJFk56qDIweETBolJgGoG/xtXWU=;
 b=fWJOa5jGPdsHGyhdY40cezjHnMUlDHFFdhpIupbTEK+OXzStj/l/MmqC3SwcjziQgv
 psDMfHW9Ioyw0AeFS5rKI70BfJ4d09Fq71B/rCxRdWjW+j3O8pG3kLRM/5gZap/YIqks
 Np3ROi5DATpuPiHne68PhVoy6haMzgGY5M3uM0/rJYrEJL3jAMo7fbnpmZ7XWWOzqSDI
 fPxK9rCWzMOyhZ6OL0XdBRwMbqQPBx/9UjzSGccFB8Dyr8IPPfaZOAaSD6vCeUIoRFGv
 0wX/j7zshyiKUt+NtLdFuyZE6Mh8QRRGbzPgrAuzTuWFi+X+Ly3xTDXffAQ6dXMrSlJI
 DSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yHSsY/mYJuBAJ4v9IJFk56qDIweETBolJgGoG/xtXWU=;
 b=Jm9Fz1AKbZeYZzlZ1S42WQ2xBI0ZT19QaRCtTLscHUKUBd9F6IeVVNyQfMSgpuMT0Q
 NyqvXQH3vuePofr7A8W5lt2qBMCGy9LlY8rPwVRcW6j4O7BURMoVSVAoMwZp5qOkAm4R
 cDaCOpUCp1+ra29EIsOYCuWtGNcejvB5VpwAn4P7FlIuh8zxA/BuOLSoQ42rD9LAf23c
 hCFZDKGan3pNJ/roTHkFt03Lp3JPRVZzirm0+B8+0PzRbuAPC/m3ZPuEd1aU8kky/Leg
 ETP0LHNqYPdKytO00n0nZ3Jk3Ub6DyLrdnlTItwHNDEJkbptJViLjT43WKTC0HgTfoNC
 OOdw==
X-Gm-Message-State: AOAM532gHO+HEKwSbJoC7R74EospnitjaqbuUu9aMkZMFF22J7HdRCEu
 lNS9UYA9Hk2mqTa9JUzcrdo=
X-Google-Smtp-Source: ABdhPJzV8l5J+SO2pz/4ERhQrB65EYAdqGftHPUDUi3HC5ah149q6B0iB/MbILBGLd6gNtmz0twV4w==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr9005221wrm.168.1592404903898; 
 Wed, 17 Jun 2020 07:41:43 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f13sm602063wmb.33.2020.06.17.07.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:41:42 -0700 (PDT)
Date: Wed, 17 Jun 2020 15:41:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200617144141.GK1728005@stefanha-x1.localdomain>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <20200606213038.43538439@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Jtds+vpI57xq70EV"
Content-Disposition: inline
In-Reply-To: <20200606213038.43538439@luklap>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Jtds+vpI57xq70EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 06, 2020 at 09:30:38PM +0200, Lukas Straub wrote:
> On Mon, 25 May 2020 17:44:12 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > Hello Everyone,
> > In many cases, if qemu has a network connection (qmp, migration, charde=
v, etc.)
> > to some other server and that server dies or hangs, qemu hangs too.
> > These patches introduce the new 'yank' out-of-band qmp command to recov=
er from
> > these kinds of hangs. The different subsystems register callbacks which=
 get
> > executed with the yank command. For example the callback can shutdown()=
 a
> > socket. This is intended for the colo use-case, but it can be used for =
other
> > things too of course.
> >=20
> > Regards,
> > Lukas Straub
>=20
> Hello Everyone,
> Can this be reviewed, it would be cool to have this in qemu 5.1.

Please see my reply to a previous version. Code that executes in the oob
environment needs to take special precautions, this needs to be
documented so that yank API users know what the limitations are.

Stefan

--Jtds+vpI57xq70EV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qK6UACgkQnKSrs4Gr
c8gjzQf/QJ20213uQ4UoGQM1p9gVC+g+9b4q+ce92Exe2oVRPluK81YmQ2fis8lG
CxWAREM0IiLlH3iL44R06+eewQkUSWwGZY5NM0ri2bsO4yT1uIcMBHwEsnDP8zyA
4zcI752bWbjAY14aVNL7Ry7TaND4KMye240mEEJNeXWLHVt7lBebgoP5xNmi5pgS
lk7LUc7NegENWGn8UfAjrAlX5eRWUeYRnztD7jeJhhNmbYqilKxqx9uy8Bs8ITu4
6F7Ubclq8ZBVHTrvoU4hOvlTMVtK1uyhJrzPeou02EKL4q39CuD7/AUAuD44nF7n
TkQsQvl31crdwX40hUCusnimuaCWRw==
=G63M
-----END PGP SIGNATURE-----

--Jtds+vpI57xq70EV--


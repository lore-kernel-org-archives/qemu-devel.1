Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DDDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9836206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDnJU6gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9836206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpS3-0006qt-1q
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iwpRP-0006KU-A3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iwpRN-00078t-Tw
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:39:43 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iwpRN-000763-Jx
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:39:41 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so218239wmi.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pEuIyjgSqvINlCsrDi6c3y1pkd64T9aaQg0crYiCWaI=;
 b=HDnJU6gH6CCKLLwFlRwSkwJ0ubDFo9wYfIzLSiP0Y/Yz4LKys/yQrfz44ZKenYce+b
 kycX2ujsPiUsXc1gN4QBSEmwD0nuA4Qq2B9dvzAmJ7lPRh/4AvgwXbP6/J138gf7/eTv
 9xEnRvRxTgVPnv52zJMJkcwpc9ATY5FJIIEGA/+ToyMh3C/eeGukyLjQdJbErrTyYEqg
 oGktpLOXGWeuKtZyS3GoLvSwKuaH1+lH2cQ56QPhtnkX6avahXF6V12zMixYS2fdnaCe
 hG1rprb8M30TvivljmrzR/zTeI2hBhGwp56hMIT2CXEWGv0Qm77Oz/NoSjkEXX698ec1
 GIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pEuIyjgSqvINlCsrDi6c3y1pkd64T9aaQg0crYiCWaI=;
 b=Wefz0tPG0CAFDS4Ps7rUeKhOvySPuZnmgn54UqpyYjkJ8lqBF02sMmnQIRFKRTc+R1
 h4veWiOujLYJO21fnreWjO1fsGMnrapZBP4AxOWgo6At/yHylqC2+buY/t96vpRRaFbX
 YlfTYeOzOf9eai83dyZ28h1f0mt/rDa1g798qgOAG7+z3yqobSUet/ev3h2omA3imNAH
 oZm+1JwwgoNL4oGVirqbffwl1KILyM668oj32+QvGJP/FOva2ZnoWgdwJ0Xh57kGiiJk
 lDfRcs5Eksnlop0jIuF5n2PXElvDsMsg1HF8oq8EyJUKhu9NIkgtS0DUdEHso+DSu5zd
 ZELw==
X-Gm-Message-State: APjAAAWAKHmbAtBfNJVkzgZNrN2q2AGFx262KUjstcVOIXUKX906+lmZ
 Gos2KMrJ2+vtKZArE7m3x5w=
X-Google-Smtp-Source: APXvYqzbNGJNql+uVFC8fVHmVGoNaRBkQqwYQL7WZBCuq9eH8bc+u+8WqdoBhFx4B26OYMgtBuBVfA==
X-Received: by 2002:a7b:cd14:: with SMTP id f20mr12022121wmj.43.1580312380062; 
 Wed, 29 Jan 2020 07:39:40 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v14sm340400wrq.75.2020.01.29.07.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 07:39:39 -0800 (PST)
Date: Wed, 29 Jan 2020 15:39:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
Message-ID: <20200129153937.GA157595@stefanha-x1.localdomain>
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
 <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
 <20200122112818.GA663955@stefanha-x1.localdomain>
 <CAL1e-=hJ=vD6Ngy0_w-kGA2X4EP-yni+S0ZTkPKW36moqaBozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CAL1e-=hJ=vD6Ngy0_w-kGA2X4EP-yni+S0ZTkPKW36moqaBozg@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2020 at 05:50:24PM +0100, Aleksandar Markovic wrote:
> On Wed, Jan 22, 2020 at 12:28 PM Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> >
> > On Tue, Jan 21, 2020 at 03:07:53PM +0100, Aleksandar Markovic wrote:
> > > On Mon, Jan 20, 2020 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
> > > >
> > > > On Sat, Jan 18, 2020 at 03:08:37PM +0100, Aleksandar Markovic wrote:
> > > > > 3) The community will be given all devised performance measuremen=
t methods in the form of easily reproducible step-by-step setup and executi=
on procedures.
> > > >
> > > > Tracking performance is a good idea and something that has not been=
 done
> > > > upstream yet.
> > >
> > > Thanks for the interest, Stefan!
> > >
> > > >  A few questions:
> > > >
> > > >  * Will benchmarks be run automatically (e.g. nightly or weekly) on
> > > >    someone's hardware or does every TCG architecture maintainer nee=
d to
> > > >    run them manually for themselves?
> > >
> > > If the community wants it, definitely yes. Once the methodology is
> > > developed, it should be straightforward to setup nightly and/or weekly
> > > benchmarks - that could definitely include sending mails with reports
> > > to the entire list or just individuals or subgroups. The recipient
> > > choice is just a matter or having decent criteria about
> > > appropriateness of information within the message (e.g. not to flood
> > > the list with the data most people are not really interested).
> > >
> > > For linux-user tests, they are typically very quick, and nightly tests
> > > are quite feasible to run. On someone hardware, of course, and
> > > consistently always on the same hardware, if possible. If it makes
> > > sense, one could setup multiple test beds with a variety of hardware
> > > setups.
> > >
> > > For system mode tests, I knoe they are much more difficult to
> > > automate, and, on top of that, there could be greater risk of
> > > hangs/crashes Also, considering the number of machines we support,
> > > those tests could consume much more time - perhaps even one day would
> > > not be sufficient, if we have many machines and boot/shutdown
> > > variants. For these reason, perhaps weekly executions would be more
> > > appropriate for them, and, in general, given greater complexity, the
> > > expectation from system-mode performance tests should be better kept
> > > quite low for now.
> > >
> > > >  * Where will the benchmark result history be stored?
> > > >
> > >
> > > If emailing is set up, the results could be reconstructed from emails.
> > > But, yes, it would be better if the result history is kept somewhere
> > > on an internet-connected file server
> >
> > Thanks.  I don't want to overcomplicate this project.  The main thing is
> > to identify the stakeholders (TCG target maintainers?) and make sure
> > they are happy.
> >
>=20
> Yes, Stefan, TCG target maintainers would be the main stakeholders. To
> some extent, various Machine maintainers would also be stakeholders,
> but they will most likely come back to TCG target maintainers looking
> for solution. In a literal sense, a number of maintainers were
> initially going to be very unhappy seeing the results (for example,
> seeing that the machine or entire target performs poorly compared to
> similar machines/targets), but after a while they should and will
> become happy realizing the problem was identified, and the culprit is
> at least approximately determined.
>=20
> I intentionally wanted to keep the project description simple in order
> to be realistic and not develop high expectation among any of us. And
> if the student proved to be capable, it will be very easy to add some
> more useful tasks for him in this area, to be included in his/hers
> GSoC/Outreachy activities.
>=20
> He had just today one case of performance degradation identified manually:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06326.html
>=20
> This project aims to do these kind of things easier, and possibly in
> an automated way. Howard did this by manual measurements for one
> particular setup, but this project will cover much much more.
>=20
> Thanks, Stefan, again for your interest - and everything else!

Please go ahead and add this project idea to the wiki:
https://wiki.qemu.org/Google_Summer_of_Code_2020#How_to_add_a_project_idea

Stefan

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4xpzkACgkQnKSrs4Gr
c8iv4Qf+NEQSVhRv7Tlm4geQ1Dvj1l6zqedHI3YMq5VxqJ73rdzoMzeJZFj+dN6t
nGfIfQeKSwmRXKyou4/KHdqyxe0VXwjKyKlyzj/gbZ1OhFqqoSlQ0PRGV4EgG91U
FCP+FutPsFNYAQ9+wlGJVYLkLkIj+/7uERWy0eWk3Iqb33ACwX0OPPOgsA5vlIHp
cjzSfrEJcViE9LZG5Ci/BN8K8ooXHhz6trE9kCpL+jwzZU/b4NJdyhJlHwdjrZv/
9UJOl5amiQ0y/Mgwb8WDzONQWlrQRaf3sk/wAK5ZpIiAr5+Pejl9O2Fwgy5rAWRq
rB43KZJ0Q+lpNP3/SvSeDKbwMO4jwg==
=7+Ni
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


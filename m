Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC286C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CB42086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh41yg/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CB42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFNT-000112-KB
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBFFV-0000g1-Pw
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:30:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBFFU-00012Q-FR
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:30:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iBFFU-000128-A9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:30:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so1561746wml.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G8RkydC9fyS+9DowRdyR75v2P4QWmuikrazCyvBJfZA=;
 b=fh41yg/sM699N80Twp9hsxAHnC/EZSoGNfeTl16J3BjXdKzheFGQxlAkTUW8PoRdKJ
 rECObB0tWyRyGr8rMbgwl1hNF9DNGnV/L+vH3vQeAyTKX7eA55NI8EaA+3gomHTYPdM8
 ot74DCy+fNcGNl6Fn8Do4W4qUX9FQIVNodnmG9Vw8ZSOGstjhEn8moqKh/dqq2VBy37Y
 lBV6fhLzcG0j/64eHVzErOrs741fF2LmNZtLo4G8b1pDxTaKuGD/PYfoZhnA9Uz4SLbe
 VQnhrYdyNyi51+sSt42T/fi3ezjki+06KH6j3VmOPIXvpxXCimtKzEIWRZeKuVeCgEkL
 r8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G8RkydC9fyS+9DowRdyR75v2P4QWmuikrazCyvBJfZA=;
 b=i99w3i7WuPXGzCN4bgEbS03SH80iBlMOeKSUEXRlUk3OfLebCnCB5GRiWQ7GKjl67C
 97+55yBz4trqfYkAHS9bJsSIzqbFLABgyLYV9JeHdbWmthK23UMU2nYOEOhhkxR5X6CY
 QTwim/ts20593I6nED/DZQ/8bnrYIvgbbvXSSzW4plog7Wv3EZPS7ByNPU6xW1/t0E83
 Dy7QGmGB1hnFqKCdRkbFRWD8Brd8SxA4MKL7gVSoeOPfu2ihskBJ+d/EM09QqFaFn2rE
 kJMTPa5/eNaqHbPLXez+Adzub0MxKyBkDc5S+HtQd7vGLQqWf9g5Ox8VLI/Que8JMOy7
 VZyg==
X-Gm-Message-State: APjAAAWL9c9J7DU/V117WLb2MBYOYMmK4S4WAkTjTpQEbzMjQ2sqqMJL
 JxfYYuHBRwtcglx/y+2Fiog=
X-Google-Smtp-Source: APXvYqwiE10VLIi6pfrkyX3WMSNiY7FO0bqobAgG33T2NTHmOJWSLwda1HVIedq811NKD72cbmv5Dw==
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr2699212wmt.12.1568971842724; 
 Fri, 20 Sep 2019 02:30:42 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y12sm1574380wrn.74.2019.09.20.02.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:30:41 -0700 (PDT)
Date: Fri, 20 Sep 2019 10:30:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [Qemu-devel] [PATCH v3 16/22] fuzz: add fuzzer skeleton
Message-ID: <20190920093040.GJ14365@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-17-alxndr@bu.edu>
 <20190919124824.GQ3606@stefanha-x1.localdomain>
 <8e30396855a53bbc3b1de2468fabef314d1f8f07.camel@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <8e30396855a53bbc3b1de2468fabef314d1f8f07.camel@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 01:49:09PM +0000, Oleinik, Alexander wrote:
> On Thu, 2019-09-19 at 13:48 +0100, Stefan Hajnoczi wrote:
> > > +static void usage(char *path)
> > > +{
> > > +    printf("Usage: %s --FUZZ_TARGET [LIBFUZZER ARGUMENTS]\n",
> > > path);
> > > +    printf("where --FUZZ_TARGET is one of:\n");
> >=20
> > Is the "--" prefix a libfuzzer requirement?  I would have expected
> > either FUZZ_TARGET by itself or --fuzz-target=3DFUZZ_TARGET (a properly
> > formatted long option) so that collisions with other command-line
> > options are not possible.
> Yes libfuzzer will only pass arguments that start with "--". I can
> replace it with --fuzz-target=3DFUZZ_TARGET. Alternatively, I can try to
> build separate binaries for each target. It might waste disk space, but
> we wouldn't need arguments (--trace could be replace with TRACE=3D1 in
> ENV). With this design, I'm not sure what to do with code such as
> i440fx_fuzz.c which re-purposes some functions for multiple different
> fuzz targets.

Building a single fuzzing binary with all targets feels natural.  Please
support the --fuzz-target=3DTARGET syntax though.

> > A cleaner API:
> >=20
> >   /* Each fuzz target implements the following interface: */
> >   typedef struct {
> >       const char *name;        /* command-line option for this target
> > */
> >       const char *description; /* human-readable help text */
> >=20
> >       /* TODO documentation */
> >       void (*pre_main)(void);
> >=20
> >       /* TODO documentation */
> >       void (*pre_fuzz)(QTestState *);
> >=20
> >       /* TODO documentation */
> >       void (*fuzz)(QTestState *, const unsigned char *, size_t);
> >   } FuzzTarget;
>=20
> Sounds good. Should there also be argc and argv here?=20

If they are read-only and provided by the FuzzTarget, then yes.  The
reason I consider this "cleaner" is because the FuzzTarget struct is
stateless and just captures the information about the fuzz target
instead of mixing it with runtime state.  But like I said, I didn't
really understand the design of the struct so maybe I don't understand
the full problem :).

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2EnEAACgkQnKSrs4Gr
c8jIpQgAqQxSRWnibtnoec+sEQY8Imk0MrTC96ckkSQjUiqK5E5JpTbW1alYt228
DWsNhd94bjQu/TX12S6UhUr78escJ2EcSuIMYXbwZV3ZZ7zVkQEW1qPZoM/T9BAc
xc6stb/uiorIQ0z0qOYalShqrX9JUBf22Y6iWDOvGX/6/Ju1TnoYZPBDcL/ct08v
P4kxhk7TKJV83r9OJpifDVEplxXlTI4T/G/HiWOFazfRMhHnrFo73YQ/hUEvXdkK
WlniKEgU1CqVywD785LSP9EuiX/h5imK1Jr90SjcmmVNmO7p2KisTg3O7XSYAXqf
szexV41mEnWLyh8bK6581vGXjt2JXQ==
=cOOr
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--


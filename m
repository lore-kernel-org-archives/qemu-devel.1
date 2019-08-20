Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74E0C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFA822DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HzePCN2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFA822DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyhM-0003d3-V8
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hzyfQ-0001yB-R3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hzyfP-0004fT-BR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:34:56 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49377 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hzyfN-0004Zj-E2; Tue, 20 Aug 2019 03:34:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CMxw6WCkz9s3Z; Tue, 20 Aug 2019 17:34:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566286484;
 bh=7//Bv474f8ItXvZa0vOPz62j1Gmsug5L9GUddrhwoIk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HzePCN2Pm+UvFWhrtxeC5vTdyXL0qNPbc+0tL3Wv6NKcsEcPgMuoEz7cXaLP0HewW
 nzOdSikWstualuGu3ziAawDo2yPLdhqGCDfdPXZJj22rui+4tmwMO1Nc8ktu2pKRd+
 5mC1HZTUfDJmScgL3l4VbiLeb7yA8jKA6qX8NW6U=
Date: Tue, 20 Aug 2019 17:31:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Clarke <pc@us.ibm.com>
Message-ID: <20190820073114.GC20890@umbus>
References: <1565983669-6886-1-git-send-email-pc@us.ibm.com>
 <CAL1e-=jy6vggskJ26rTc8dnaqtqCB0SdfpV9p-NvKdjoBk+Vkw@mail.gmail.com>
 <0cfddc22-92ef-3067-9275-8f4f22ca9805@linaro.org>
 <CAL1e-=h=Hzfm8KZ4ebwaBsS6U=KVcReXpOPT2-vy4OeBktjWkQ@mail.gmail.com>
 <20190819062817.GA24503@umbus.fritz.box>
 <CAL1e-=j0w=OasHidP4W4ND-R3p6Ui7MS0iaj7Wk+c1tVyR09+A@mail.gmail.com>
 <1b486ed4-512f-e5b3-bcd7-9385b689b1cb@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <1b486ed4-512f-e5b3-bcd7-9385b689b1cb@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Three floating point fixes
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2019 at 12:13:34PM -0500, Paul Clarke wrote:
> On 8/19/19 1:44 AM, Aleksandar Markovic wrote:
> > 19.08.2019. 08.30, "David Gibson" <david@gibson.dropbear.id.au> =D1=98=
=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> On Sun, Aug 18, 2019 at 10:59:01PM +0200, Aleksandar Markovic wrote:
> >>> 18.08.2019. 10.10, "Richard Henderson" <richard.henderson@linaro.org>=
 =D1=98=D0=B5
> >>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>>>
> >>>> On 8/16/19 11:59 PM, Aleksandar Markovic wrote:
> >>>>>> From: "Paul A. Clarke" <pc@us.ibm.com>
> >>>> ...
> >>>>>>   ISA 3.0B has xscvdpspn leaving its result in word 1 of the target
> >>>>> register,
> >>>>>>   and mffprwz expecting its input to come from word 0 of the source
> >>>>> register.
> >>>>>>   This sequence fails with QEMU, as a shift is required between
> > those
> >>> two
> >>>>>>   instructions.  However, the hardware splats the result to both
> > word 0
> >>>>> and
> >>>>>>   word 1 of its output register, so the shift is not necessary.
> >>>>>>   Expect a future revision of the ISA to specify this behavior.
> >>>>>>
> >>>>>
> >>>>> Hmmm... Isn't this a gcc bug (using undocumented hardware feature),
> >>> given
> >>>>> everything you said here?
> >>>>
> >>>> The key here is "expect a future revision of the ISA to specify this
> >>> behavior".
> >>>>
> >>>> It's clearly within IBM's purview to adjust the specification to
> > document
> >>> a
> >>>> previously undocumented hardware feature.
> >>>>
> >>>
> >>> By no means, yes, the key is in ISA documentation. But, the impression
> > that
> >>> full original commit message conveys is that the main reason for chan=
ge
> > is
> >>> gcc behavior. If we accepted in general that gcc behavior determines
> > QEMU
> >>> behavior, I am afraid we would be on a very slippery slope - therefor=
e I
> >>> think the commit message (and possible code comment) should, in my
> > opinion,
> >>> mention ISA docs as the central reason for change. Paul, is there any
> >>> tentative release date of the new ISA specification?
> >>
> >> It's not really a question of gcc behaviour, it's a question of actual
> >> cpu behaviour versus ISA document.  Which one qemu should follow is
> >> somewhat debatable, but it sounds here like the ISA will be updated to
> >> match the cpu, which weights it heavily in favour of mimicing the
> >> actual cpu.
> >>
> >=20
> > This sounds right to me.
>=20
> Thanks for the reviews and great discussion.
>=20
> While not yet part of a published version of the ISA, I did find the beha=
vior documented in the User's Manuals for the POWER8 and POWER9 processors:
>=20
> https://www-355.ibm.com/systems/power/openpower/
> "Public Documents"
> - "POWER9 Processor User's Manual"
> - "POWER8 Processor User's Manual for the SCM"
>=20
> POWER9 Processor User's Manual=20
> 4. Power Architecture Compliance
> 4.3 Floating-Point Processor (FP, VMX, and VSX)
> 4.3.7 Floating-Point Invalid Forms and Undefined Conditions
>=20
> POWER8 Processor User's Manual for the Single-Chip Module
> 3. Power Architecture Compliance
> 3.2 Floating-Point Processor (FP, VMX, and VSX)
> 3.2.9 Floating-Point Invalid Forms and Undefined Conditions
>=20
> In a bullet:
> - VSX scalar convert from double-precision to single-precision (xscvdpsp,=
 xscvdpspn).
> VSR[32:63] is set to VSR[0:31].
>=20
> I have not confirmed when the new revision of the ISA will be published, =
but it's on somebody's "to do" list.
>=20
> I will respin the patch as 3 independent patches, and include a reference=
 to the above documents for the change under discussion here.  (The other t=
wo changes may take a bit more time, because like David, I find the FPU emu=
lation code cryptic.  :-/  )
>=20
> These issues were found while running Glibc's test suite for "math",
> and there are still a *LOT* of QEMU-only FAILs, so I may be back
> again with suggested fixes or questions.  :-)

That doesn't greatly surprise me, TCG's ppc target stuff is only so-so
tested, TBH.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1bocIACgkQbDjKyiDZ
s5LRhA//QGTcawA+M2x3owFz0c3fpOBFpe/unIG7yGxX3XkCdkGWqxAKaAuPZP22
1mA67aHgUqfxzslLIe6ywLYwwvwa9XO+0MPTbmBQ3uS23SXcc30r0rCS2Ple1jwj
/0Pz5TLqcqIzznODaFHrXi2ariSLz41DCVZcC1JkUeBtshjDmVn70sVW3KvrKTZt
L94q/Hv3j9bDLdlGhPChiixjHC4/jgI8dHcRBbOfCrvLdcN5H5Fz89tXwAhHQt1q
71V1+exglXaGBjM3Jw5OaifcwG+UNKCUe7uDNeCKvPXfIo7canPzh3rDIrP26r4x
Ucd0QvTCCGFXkDEYU5dPbZ54dM6ZRVTnQPRrP/7i3y7g+Ir7lPiTxCZz8wf4Pe5V
MEoJvjP2V+/SFbEld/FG5QyJfCdQ3CfXouhFJfCX9kUB9i3r8fnTYvH9GaV+Xyy5
VaNknYJLbe2x92+iWhrHG727xB9+j2ThIZTBmQQDE/trfD+wLF28ZidfdGHnSwZX
sZnWk/gPgfiTvcEVoO3Znj5whIVwq2r+4HE+syI0EyCOCzWnhQCIxWkjQZGBixWi
pbE+d9l/vUIoLDsy6Vyin1ih/Rp/vgeLucSY43N9x0gTUn+aDefXZBtUB+YG1KLe
+vQ3ZAQWCnKL5nHjSj6Zx5UUuvzZWEGWv4x09KZwxQKPKeWsPDc=
=MBBv
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--


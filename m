Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB17C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 00:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66445206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 00:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fWSvyqfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66445206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57855 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9f6i-0006hw-Fw
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 20:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i9f5W-0005ZI-Hb
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 20:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i9f5V-0005Av-6u
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 20:41:54 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46723 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i9f5T-0005AP-VS; Sun, 15 Sep 2019 20:41:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46WnVx68MCz9sP6; Mon, 16 Sep 2019 10:41:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568594505;
 bh=F+SKYAUtoXmOyCVb7aOZLPl8/ofr/GkoF83heURRA7c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fWSvyqfLZh+70EgsbY6W3A0GmFAbboLxoBjc2E4j0OaqVgK+m5NGS/Q7SGI6IG9qW
 C3EStN+5ru8x0ZiLgLiLKTjw79IVHy6fB4MlxK3iwxzi1oF81ImYjorFxW62ON5+ru
 taHlCMTicAsQGVmJGVMc6AQAJJnWLXEFbOBR0ODA=
Date: Mon, 16 Sep 2019 10:25:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190916002507.GC2104@umbus.fritz.box>
References: <1568292868-5067-1-git-send-email-pc@us.ibm.com>
 <c39334e3-46f9-1973-11d0-c862ce80cc8b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <c39334e3-46f9-1973-11d0-c862ce80cc8b@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] ppc: Add support for 'mffsce' instruction
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
Cc: qemu-ppc@nongnu.org, "Paul A. Clarke" <pc@us.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2019 at 01:00:21PM -0400, Richard Henderson wrote:
> On 9/12/19 8:54 AM, Paul A. Clarke wrote:
> > From: "Paul A. Clarke" <pc@us.ibm.com>
> >=20
> > ISA 3.0B added a set of Floating-Point Status and Control Register (FPS=
CR)
> > instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> > This patch adds support for 'mffsce' instruction.
> >=20
> > 'mffsce' is identical to 'mffs', except that it also clears the excepti=
on
> > enable bits in the FPSCR.
> >=20
> > On CPUs without support for 'mffsce' (below ISA 3.0), the
> > instruction will execute identically to 'mffs'.
> >=20
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  target/ppc/translate/fp-impl.inc.c | 30 ++++++++++++++++++++++++++++++
> >  target/ppc/translate/fp-ops.inc.c  |  2 ++
> >  2 files changed, 32 insertions(+)
> >=20
> > diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/=
fp-impl.inc.c
> > index 59a4faf..34edc45 100644
> > --- a/target/ppc/translate/fp-impl.inc.c
> > +++ b/target/ppc/translate/fp-impl.inc.c
> > @@ -639,6 +639,36 @@ static void gen_mffsl(DisasContext *ctx)
> >      tcg_temp_free_i64(t0);
> >  }
> > =20
> > +/* mffsce */
> > +static void gen_mffsce(DisasContext *ctx)
> > +{
> > +    TCGv_i64 t0;
> > +    TCGv_i32 mask;
> > +
> > +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> > +        return gen_mffs(ctx);
> > +    }
> > +
> > +    if (unlikely(!ctx->fpu_enabled)) {
> > +        gen_exception(ctx, POWERPC_EXCP_FPU);
> > +        return;
> > +    }
> > +
> > +    t0 =3D tcg_temp_new_i64();
> > +
> > +    gen_reset_fpstatus();
>=20
> Note for future cleanup: we should not need to sprinkle these all over.  =
This
> should be the steady-state condition after softfp exceptions have been
> processed into powerpc exceptions, after every single fp instruction.
>=20
> That said, you're mirroring gen_mffs here, and the cleanup should
> happen globally.

This doesn't apply, presuambly because it's on top of the other
patch.  So I'll wait for the respin that includes the small update
that rtc requested on that one.

>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1+1mEACgkQbDjKyiDZ
s5Iu6BAA4GDX0m6FS6W2UTg0c5uAslYcz2woT6z0dE5+Pg65B21x/xSc2Qw8QMxZ
7SX14vZLZzAkqpjxbL/dMPIR9BYf9+qwQdnLPlb0QMxIVkAPisYhW6394dczyLg6
XfQ3Z1dS71aLSw8uPWGzPF+hNsgrCW70W+SiPr1W0BCON64nFG5BNYVHPwubhSN4
Fupj54igLxo7cWrU99FWWJAErb+Bn75/E47gdLtSyZei+/yZVFerv3Yy7rKsIFmi
WOwWfb13PqKLLjZX8xWPYdNQI4tgXUXbBFqF+zoa8EXkSf6iAeNxje2iAWnyADo5
kmroF5sHMIrrWi5+ZuIpeJpaQHiQPReDh9DFbpBl+YiHvCdy2Xp79ponwVmjYfkZ
wLfKRB3UQBqxSWcMXA0SN9Sl8+qssxJrN82I26kAWNNRLKv4vT23eJDUIc3Ujpbh
i4CO9U1tNHoEm7PmO6QRw3p2thc8ha0ozu2ib+bK9Z5qfFDJc4Vq0VnY8dqurHV8
ooM5Xtqlmt7z31ZZ+NMhxwM5OJBIlUGZP+V7os8bnGm6hFlQ9rrpp8myQ4oM6xJM
fT889HxvMZS8udbAArHTFimXOGjk+2dHzBMqCWd9xJypXDja1+u8quY6YTV1hstG
PzZKUg+Y6njOfchna+w3wUF543WzHduGizCwrteusYJFIMF7SIc=
=2xd5
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--


Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA04C38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B2620746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GAdrlFzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B2620746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXxWI-0003IK-Ca
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUu-0000wY-3I; Sun, 10 May 2020 21:44:48 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51661 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jXxUr-0000el-81; Sun, 10 May 2020 21:44:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49L3dg6WMVz9sSs; Mon, 11 May 2020 11:44:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589161479;
 bh=RCbGGWQa2xpkEY1NpyqGV3zauGWlJOna/SDkXIquvJw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GAdrlFzFWJRpsCOXpNBs4F1bk9CPZizmJv8q5aS+40VYAp/Fvp2O4SpB2Mrattjq6
 dwAteJ+/K4u2Sf7hUh7QgnbPDuSC+q85+ZuvkR/Ikdumjo768IgcAdQk6dG1E3TqfR
 h5FkbJvBItBv46QcqWgmJDBjXKP12Va8N5JGD7Bs=
Date: Mon, 11 May 2020 11:30:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
Message-ID: <20200511013010.GI2183@umbus.fritz.box>
References: <20200507114824.788942-1-npiggin@gmail.com>
 <20200507135154.GA2282@umbus.fritz.box>
 <20200508104305.355e97d8@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <20200508104305.355e97d8@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 10:43:05AM +0200, Greg Kurz wrote:
> On Thu, 7 May 2020 23:51:54 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, May 07, 2020 at 09:48:24PM +1000, Nicholas Piggin wrote:
> > > Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
>=20
> Please note that the culprit patch was merged with a different SHA1:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D01b552b05b0f21f8ff57a50=
8f7ad26f7abbcd123
>=20
> > > SRR1 setting wrong for sresets that hit outside of power-save states.
> > >=20
> > > Fix this, better documenting the source for the bit definitions.
> > >=20
> > > Fixes: a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the
>=20
> Fixes: 01b552b05b0f ("ppc/pnv: Add support for NMI interface")

Updated in my tree, thanks.

>=20
> > > Cc: C=E9dric Le Goater <clg@kaod.org>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >=20
> > Applied to ppc-for-5.1, thanks.
> > > ---
> > >=20
> > > Thanks to Cedric for pointing out concerns with a previous MCE patch
> > > that unearthed this as well. Linux does not actually care what these
> > > SRR1[42:45] bits look like for non-powersave sresets, but we should
> > > follow documented behaviour as far as possible.
> > >=20
> > >  hw/ppc/pnv.c | 26 ++++++++++++++++++++------
> > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > > index a3b7a8d0ff..1b4748ce6d 100644
> > > --- a/hw/ppc/pnv.c
> > > +++ b/hw/ppc/pnv.c
> > > @@ -1986,12 +1986,26 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *c=
s, run_on_cpu_data arg)
> > > =20
> > >      cpu_synchronize_state(cs);
> > >      ppc_cpu_do_system_reset(cs);
> > > -    /*
> > > -     * SRR1[42:45] is set to 0100 which the ISA defines as implement=
ation
> > > -     * dependent. POWER processors use this for xscom triggered inte=
rrupts,
> > > -     * which come from the BMC or NMI IPIs.
> > > -     */
> > > -    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> > > +    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
> > > +        /*
> > > +	 * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
> > > +	 * wakeup reason in SRR1[42:45], system reset is indicated with 0b0=
100
> > > +	 * (PPC_BIT(43)).
> > > +	 */
> > > +        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
> > > +            warn_report("ppc_cpu_do_system_reset does not set system=
 reset wakeup reason");
> > > +            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> > > +        }
> > > +    } else {
> > > +        /*
> > > +	 * For non-powersave system resets, SRR1[42:45] are defined to be
> > > +	 * implementation-dependent. The POWER9 User Manual specifies that
> > > +	 * an external (SCOM driven, which may come from a BMC nmi command =
or
> > > +	 * another CPU requesting a NMI IPI) system reset exception should =
be
> > > +	 * 0b0010 (PPC_BIT(44)).
> > > +         */
> > > +        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
> > > +    }
> > >  }
> > > =20
> > >  static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl64qqIACgkQbDjKyiDZ
s5L1xg/9HkETp8mkJni53fXJ346Nue8JhAYdg77xNPm1Cv/LOnZj3aqkp8hO9YEf
zrHlSTkq2HJ8VON2FocWgdvY60D+OSitj4CM1Ab2ldDnkMK5h0CYsQpoVQW+oLsa
NOpzalxaWUQT67vI1PDdD4SnvIHv+dJqDJ8K24xh9V+yKwNEDdlP8t6kmgEBio45
dvQRCNaRICU9gb3ar3OJW5aWlmFEGWcMWxIy4p79Y8puFp2ZTSJxOFNHxfRhGznB
nJi8RTUVqKmzfCf++UsmfzSu3L9yKRNhGJ0+0++VCWRjoWzpHb39VZsLfBVdFKZR
FfsF4VQU9GPRH+Y+UfRO6bdqT155u6LWoJMPNTM54cAGWgyDS4j3sszWMqwF13RS
Gj0kdso4brrv0Wo25tZeiQ9zTfSqiAHaNgsAiB+lSdc+CNhfySO9SOa5QOtlCvT/
xLXIP0zgst81P3re4zDZEd519Ud1WQw/CYd9bmpQU7AcR5PtHK1dVYxFwjntb8Yt
ZTKDe5fPENMQk9TFFJLBDMl2Zn6BWI8Ils6AssPnZDLFlxqMBbrmFHlyj1Xd/twu
XuNEjr5ydTxSUKEW6M6DtR/0sRTwlotoH65c869T/7DOw8yo8tYxBYDh6o8sjrDb
r5Hb4hmJbD3+5nJTMXVUTq/J3N5wBpGKzWO2rlCR1MNb1fqi0OQ=
=GOeV
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--


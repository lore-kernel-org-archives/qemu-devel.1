Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56541C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ED520714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mdyBD+/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ED520714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MgR-00027K-Fb
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0Mf4-0000uY-Ab; Tue, 28 Jul 2020 06:16:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36465 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0Mez-00085d-Kn; Tue, 28 Jul 2020 06:16:42 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BGCJJ2g9gz9sTK; Tue, 28 Jul 2020 20:16:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595931392;
 bh=71CxD+3qFGsQZR6lzzXOj7xvtbJ/4K1FuQmuu1Ou/14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mdyBD+/XOefqdz7lSXWanaYQvd/9JbDl8dXWP42TLBs7yi6/dgtnxnDZpwym3xreR
 YnwxOlypYFoxj60zPurdQ1ul/hgDQHrOKY3aEKdDV+UuumInsCWRtxnXUlZQbaeIUW
 ZlOCZ87jr2UmIeFWKci6XXjJRu/evCanmF1Mu4vs=
Date: Tue, 28 Jul 2020 20:09:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 for-5.2 1/2] spapr: Use error_append_hint() in
 spapr_caps.c
Message-ID: <20200728100937.GI84173@umbus.fritz.box>
References: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
 <159491947184.188975.5055299566400098290.stgit@bahia.lan>
 <87mu3uciq4.fsf@dusky.pond.sub.org>
 <20200727150425.2c7562ed@bahia.lan>
 <87h7tsf6cv.fsf@dusky.pond.sub.org>
 <20200728110726.5882b046@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <20200728110726.5882b046@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:16:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 11:07:26AM +0200, Greg Kurz wrote:
> On Tue, 28 Jul 2020 09:26:08 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > Greg Kurz <groug@kaod.org> writes:
> >=20
> > > On Mon, 20 Jul 2020 17:24:35 +0200
> > > Markus Armbruster <armbru@redhat.com> wrote:
> > >
> > >> Greg Kurz <groug@kaod.org> writes:
> > >>=20
> > >> > We have a dedicated error API for hints. Use it instead of embeddi=
ng
> > >> > the hint in the error message, as recommanded in the "qapi/error.h"
> > >> > header file.
> > >> >
> > >> > Since spapr_caps_apply() passes &error_fatal, all functions must
> > >> > also call the ERRP_GUARD() macro for error_append_hint() to be
> > >> > functional.
> > >>=20
> > >> This isn't a request for change in this patch, just an attempt to sq=
uash
> > >> possible misunderstandings.
> > >>=20
> > >> It's true that error_append_hint() without ERRP_GUARD() works as lon=
g as
> > >> the caller doesn't pass certain errp arguments.  But the callee shou=
ld
> > >> work for all possible @errp arguments, not just the ones that get pa=
ssed
> > >> today.  That's why error.h wants you to guard *all* uses of
> > >> error_append_hint(errp):
> > >>=20
> > >>  * =3D Why, when and how to use ERRP_GUARD() =3D
> > >>  *
> > >>  * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > >>  * - It must not be dereferenced, because it may be null.
> > >>  * - It should not be passed to error_prepend() or
> > >>  *   error_append_hint(), because that doesn't work with &error_fata=
l.
> > >>  * ERRP_GUARD() lifts these restrictions.
> > >>=20
> > >
> > > Yeah, I just wanted to emphasize that we were precisely in the case
> > > where we _really_ need to lift the restriction, but I'm perfectly fine
> > > with dropping this sentence if you consider it useless.
> >=20
> > I lean towards dropping it.
> >=20
>=20
> David,
>=20
> Do you want me to send an updated version of this patch or can you
> fix this in your tree ?

Updated version please, I'm afraid I've lost track of quite what was
suggested in this thread.

>=20
> > > BTW, should we have a way for CI to ensure that a patch that adds
> > > error_prepend(errp, ...) or error_append_hint(errp, ...) also adds
> > > ERRP_GUARD() ? Not sure that people read error.h that often...
> >=20
> > I don't know.  Wait and see whether it's worth automating?  We didn't
> > automate checking other Error API rules, like "no newlines in error
> > messages".  That one can't crash, though.
> >=20
> > The check would have to look beyond the patch, which checkpatch.pl
> > doesn't do.
> >=20
>=20
> <thinking aloud>
> Maybe checkpatch.pl could be fed with an extended version of the patch
> that has enough context, eg. git show -U$(wc -l ${file}) ${file} ?
> </thinking aloud>
>=20
> > >> No need to make an argument involving the possible arguments (pardon=
 the
> > >> pun).
> > >>=20
> > >
> > > :)
> > >
> > >> [...]
> > >>=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8f+V4ACgkQbDjKyiDZ
s5KPJRAAmWArB19Ohjz0H0SWtgrT8qo71f7oe2EHTxqtZ9RfiF33OIJUV3HuQ/L0
bKuYxivbsK/Dv5r01pLOIULyu87sT+sfkyS/YH0ZO4IMcljOpzW847KRp/W1KpL2
UpRz2z6C9a3kuehQQdV/3zjV4JO9H/sLlnUks252vDyY6M8/h4Z5iOiV2ii5cPVg
86bPb7/AqF5oCuFRVLSfToAZfrOgkDb2+D5Rb7mVuqGGWdOQap4sE7n/XNAusleo
fSCUkZ6bKOp7GqV+OIbXInfaayS6ITo1+pL2rD2hw+L37tErL0rtZwMWUxAjAy6r
7r6fORRA9kZ5MpiXhC8fD2xlqXuT8cUXCCIcsCY5atnok84sMBB6fJdPe9+S1aaA
uRV3WohHIzoLNt2BVu4GIMoZ8tRr21xGqDnB8UMfHNexDLCf3pZf2j4fwveu1X3u
oV0hM6l4O7+Apz33ElFUR3RRZxPVD08kflDXLhfHYV8xX/AEZQtcRbFSgf8HqPkD
3vVwwX5Oxy7PQFOSlGYi3drLG3j5wfXAxMPRjDl9CqI3zsr7M6p6DCS21cL6pEZQ
bmHYSEsY36S7eaAeMA6AYxqGYvidGrN0x06Hay86w+8sc0QJnFEN7FKAmApOwgm7
slkN6YDr4+y7X0xlGeKNERaP5ZluzzNxtBOvE0uDfx9TlaB2gOU=
=341b
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--


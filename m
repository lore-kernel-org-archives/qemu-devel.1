Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2484BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC8E2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XgvYkBPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC8E2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jit0v-0005mJ-5s
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisuW-0003y0-Np
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:04:24 -0400
Received: from ozlabs.org ([203.11.71.1]:35585)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisuV-0006qq-3I
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:04:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZfC03FBz9sSF; Wed, 10 Jun 2020 15:04:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591765459;
 bh=wjy9apfKwnLDqAAEqKzoY2p9Dc4R9HzH01p2fkzCON8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XgvYkBPUFdJ3lwbEyteZZsfMwXo9YId1hAv2dgD1UGzoC8SRlo1pu29BR5yyXLmiS
 /RP861tghL94tJNCi9avfKaldQNVb9G7c6ZFl3DOrWL5HQbHsxMUbw+sPWDsq0oCkr
 gHo+57VzGAmrfrUBU3zzUCgVa4pkL+dWvrCwwIUQ=
Date: Wed, 10 Jun 2020 15:04:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/9] AMD SEV: Cleanup state handling
Message-ID: <20200610050413.GL494336@umbus.fritz.box>
References: <20200604064219.436242-1-david@gibson.dropbear.id.au>
 <d9b13bf3-2b72-1a13-d3c1-2e31c411e236@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline
In-Reply-To: <d9b13bf3-2b72-1a13-d3c1-2e31c411e236@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 00:46:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: brijesh.singh@amd.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, ekabkost@redhat.com,
 philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2020 at 08:37:47PM +0200, Paolo Bonzini wrote:
> On 04/06/20 08:42, David Gibson wrote:
> > This series has an assortment of cleanups to the AMD SEV memory
> > encryption code.  Amongst other things it:
> >   * Removes the confusion between struct SEVState and enum SevState
> >   * Reduces use of global variables
> >   * Unifies some ad-hoc structures with an existing QOM object
> >=20
> > I made these changes along the way to building a framework for common
> > handling of mechanisms for protecting guests from compromised hosts
> > (such as AMD SEV, IBM's PEF and others).  However, I think the changes
> > make sense on their own, so I'm sending them for inclusion now, while
> > finishing the polish on the rest of those patches.
> >=20
> > Please apply.
> >=20
> > David Gibson (9):
> >   target/i386: sev: Remove unused QSevGuestInfoClass
> >   target/i386: sev: Move local structure definitions into .c file
> >   target/i386: sev: Rename QSevGuestInfo
> >   target/i386: sev: Embed SEVState in SevGuestState
> >   target/i386: sev: Partial cleanup to sev_state global
> >   target/i386: sev: Remove redundant cbitpos and reduced_phys_bits
> >     fields
> >   target/i386: sev: Remove redundant policy field
> >   target/i386: sev: Remove redundant handle field
> >   target/i386: sev: Unify SEVState and SevGuestState
> >=20
> >  target/i386/sev.c      | 257 +++++++++++++++++++++++------------------
> >  target/i386/sev_i386.h |  49 --------
> >  2 files changed, 143 insertions(+), 163 deletions(-)
>=20
> Queued, thanks.

Do you have a best guess at when these might merge?  I have another
series based on this one I'd like to move forward with.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gac0ACgkQbDjKyiDZ
s5K14w/7BN3VqI4UvkVfhejLrpsyzwzvkPETQWGydS6CHoRuyRp1C068T1W3Iubh
EnmCrUINgtS8z2zEWqOpKHJ9/++Cwr/oXHJ5AgkVgEOmXTpt+3JpOH/WbLe1eZpq
64s46pxKCI3Ijg5kCO6w/ibYH+PZamBj215G+Mc4Ar/vPlWY1JGK3/LCMmq4gbqk
CNpfQXooi7kAjAEBqr79XH+rk/I03co/xBUfEC+9m2458UYJnOeREsgZeOgDQoRb
DqvZpGk1aEiwWJiDDu1UO41vXXoE3lvMa5pUErX+XwFhTjQI4zaEViAiaBe02RyC
ix1yTOD+/nXV3+BQY+mJktXANuRUcoQQvb2QXY7+2EUaTPMIGInOhBoysA73ei0G
YzTZGggf7LaKHo4K7ExBg6FmtgxGzSRYNpjk17qRmhVv7xtH2xX+xrTaiAZY+8OC
+iMDfMY5Zl2Q0gaDbvGhAV7+xtc5t32L2gm86+WcdfNuAugPSzcl5v1p1e4UxAnz
o68psci9opxLWljRXHxY0Y7Jt64wPV0VwTs7fqh7WCLgSEj3mUs5tIqP1tybQdiS
8dxFouXsFWRMW6eXgNxJzhpIgOzvUu1vl04j9Zp8+4WI1wQPmWZ2Gzi8ceuw85mS
n/Flzkk1Dvf53B4Dl3Yd50CKyjr1jYArIVgZfcIndSHuPi103kM=
=iNZm
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--


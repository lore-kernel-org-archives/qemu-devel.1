Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66986C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 03:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3704620856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 03:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jejDG0iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3704620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAR5m-0004G2-75
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 23:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAR4C-0003HP-Sy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 23:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAR4B-0001yK-CK
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 23:55:44 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46703 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iAR49-0001ub-TX; Tue, 17 Sep 2019 23:55:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Y5jc3LpTz9s4Y; Wed, 18 Sep 2019 13:55:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568778932;
 bh=CFeJ4b8lb2/Ku9xnv6dhbFzheR7iIW6M4eA110XcxNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jejDG0iP4uRwxkCE9HM6MvFJoMOQaBPNEBruvMWfsaB2cfpXL1Dz0K5qvekR2Kigs
 M8pL3t2UPdR2rPQKyxcT1SqJFUSxqQu+HIsz/BY4wCVvaun2/TXq7lWl6ok15jueTX
 GE9PFX0UVLglh16ENvOUKs/7b2a5VNE3SRGCAjl8=
Date: Wed, 18 Sep 2019 10:47:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Clarke <pc@us.ibm.com>
Message-ID: <20190918004750.GD2440@umbus.fritz.box>
References: <1568653344-16881-1-git-send-email-pc@us.ibm.com>
 <77049b6d-92cd-014f-6151-fb8dc4b032c9@linaro.org>
 <d38484cb-8a78-c58c-6ab4-921c9450a346@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <d38484cb-8a78-c58c-6ab4-921c9450a346@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ppc: Add support for 'mffsce'
 instruction
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 04:49:56PM -0500, Paul Clarke wrote:
> On 9/17/19 3:46 PM, Richard Henderson wrote:
> > On 9/16/19 1:02 PM, Paul A. Clarke wrote:
> >> From: "Paul A. Clarke" <pc@us.ibm.com>
> >>
> >> ISA 3.0B added a set of Floating-Point Status and Control Register (FP=
SCR)
> >> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> >> This patch adds support for 'mffsce' instruction.
> >>
> >> 'mffsce' is identical to 'mffs', except that it also clears the except=
ion
> >> enable bits in the FPSCR.
> >>
> >> On CPUs without support for 'mffsce' (below ISA 3.0), the
> >> instruction will execute identically to 'mffs'.
> >>
> >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> >> ---
> >> v2: no changes.
> >>
> >>  target/ppc/translate/fp-impl.inc.c | 30 ++++++++++++++++++++++++++++++
> >>  target/ppc/translate/fp-ops.inc.c  |  2 ++
> >>  2 files changed, 32 insertions(+)
> >=20
> > Didn't I already give a
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >=20
> > for this?
>=20
> You did.  Sorry for the confusion.  I wasn't sure whether to resend
> or not, given the dependence on the other patch and David said he
> would be waiting for the respin.

Please resend for my convenience, but you can fold in the previously
received R-b lines, assuming the patch isn't changing.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2BfrYACgkQbDjKyiDZ
s5L95RAA0RQdhSl3t1ZgI+1UEOp40CWLzP41SrRiQHLx1IGlK4hiAu+zEBANaHmC
olNbdkkH77p/osiuLaUpB5DvJGQaH5404orUxiogYJ/SCRodqQC1z2o6BFtGqDme
k286j5AgrImy12ZWx0mZb+vUp/NY6AnLmC6hnAGiP0QLRVwIOiMFXM46swlo5n9R
3HZ07Kc/fyawPNh/8KRiGK7GCJRQL+L3IjwR9P816pamZ3dco019hQgP3py5z4Xt
pn9gQLc9Aqt6HGe2BP9c53MgXIqru61VLecDkIsIvcLPUBLbgyf3l35bYa34iBgE
62hOmwDxeaBFGv6ybUb5pSuBb66MIHCQd7BOAbfri1FqReEOQfAH/50IeR25qbuv
K3WgrSkOy2Wmso2vBS4nAP6kD0tweGwL8Ae4io6aUZIDuGQAiSN5uodYRybZQR1k
CwKqhAFr3LksYRAy5vvhNqpEA84W/ZYl5j2CAdUCHiHqcSwLlY8a8b2qqrIr3lFl
BlyqQEX0zAXsvKo4ykB0oA3UGqdJnfsHgr7wyMTbOf26YkH9KB8vot2bqDDcLAgi
18+vOyqytO4fwvvmfaFxjw2VB0SrLNk9vezI2b+4gnAFDPPh+ifaooh+B5X6B3ub
d/6rF3ge/Uq5JP+XhVEjzLsz2+8nkWu4I8/R2uMIDbbye8k8fww=
=byNs
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--


Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC70C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C25208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 05:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gIgUMutf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C25208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBtY1-0001X8-M6
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 01:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBtXD-00011e-EN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBtXB-0001mn-IV
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 01:03:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60021 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBtXB-0001aY-4z; Wed, 11 Mar 2020 01:03:57 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48cfxg22yzz9sPk; Wed, 11 Mar 2020 16:03:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583903031;
 bh=k6CnEYuTU51Ggb6MOf6AUCJmMA6Xw9yN1elNkzxobmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gIgUMutfdPkVqzF/tQ5pTj9F39CNOWB6aZBr9TydPtMLMtfSiG6Sy5FUk7S0802LM
 OYl0jFoOh2UQesCf1ieH6JBjWDyw4hNMzwFXTpVrBft8iYdsVE1a1cBH2D/ZsnfcBW
 DAnV3AvnVDpF8796angUhU8yAXM/UulEc+7B3Ae4=
Date: Wed, 11 Mar 2020 16:03:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Program counter stuck at 0xFFFFFFFC when emulating e5500
 processor on T4240-RDB board
Message-ID: <20200311050346.GZ660117@umbus.fritz.box>
References: <CAM2K0npCdHfCeMCKO9TX_ifQGDZFFNyMEKH2qByYL9SnXnaPmw@mail.gmail.com>
 <838be9cf-2d3c-f807-7f1d-6a50f95a5228@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UNifc18z8z6e1QHx"
Content-Disposition: inline
In-Reply-To: <838be9cf-2d3c-f807-7f1d-6a50f95a5228@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Wayne Li <waynli329@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UNifc18z8z6e1QHx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 09:44:13AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hello,
>=20
> On 2/20/20 6:40 AM, Wayne Li wrote:
> > Dear QEMU list members,
>=20
> No subject: it is unlikely your question get noticed...
>=20
> Also you didn't Cc'ed the people who might help you (doing that for you):
>=20
> ./scripts/get_maintainer.pl -f target/ppc/cpu-models.c
> David Gibson <david@gibson.dropbear.id.au> (maintainer:PowerPC TCG CPUs)
> qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
> qemu-devel@nongnu.org (open list:All patches CC here)

Right.  Unfortunately the embedded cpu support is barely maintained,
so there's only a little bit of help I can give.

> > This will kind of be a repost but I'd like to post my question again
> > because I've gained some more knowledge that makes me feel that my
> > question would be easier to answer.=A0 So we developed a custom-made QE=
MU
> > VM that emulates a custom machine that has an e5500 processor.=A0 I'm
> > running this VM on a T4240-RDB board which has an e6500 processor and
> > I'm trying to get the VM running with KVM enabled.=A0 The problem I'm
> > having is the program counter refuses to increment at all.=A0 It just
> > stays at the address 0xFFFFFFFC.=A0 On a run without KVM enabled, the VM
> > will also start executing at this same address but the program counter
> > beings to increment immediately.=A0 I know this is a custom QEMU VM and
> > maybe some of the startup stuff we do could be causing problems, but
> > what could possibly stop the program counter from incrementing
> > altogether?
> >=20
> > Also, I do have another side question.=A0 When running with KVM enabled=
, I
> > see the kernel-level ioctl call KVM_RUN running and then returning over
> > and over again (by the way before the VM kinda grinds to a halt I only
> > see QEMU make the KVM_RUN call twice, but the kernel-level ioctl
> > function is being called over and over again for some reason).=A0 And e=
ach
> > time the KVM_RUN call returns, the return-from-interrupt takes the VM to
> > the address 0xFFFFFFFC.=A0 What is the KVM_RUN ioctl call used for?=A0 =
Why
> > is it being called over and over again?=A0 Maybe if I understood this
> > better I'd be able to figure out what's stopping my program counter from
> > incrementing.

I don't really know if KVM even attempts to support e5500 cpus.  We'd
need to at least know what your host kernel is and what KVM variant it
is using.  What's the instruction at 0xfffffffc which seems not to be
handled here properly?  It sounds like you might be getting some sort
of rolling trap, because KVM isn't handling that instruction correctly.

The KVM_RUN is what causes KVM to actual enter the guest and execute
instructions.  It returns when something triggers a guest exit - a
trap or various other events can do this.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UNifc18z8z6e1QHx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5ocTIACgkQbDjKyiDZ
s5J97A//TaDPrFZNBz/HipR3NS86e1Ly5coZ2TS57+nfLgYt9Cu5nVKDxhs+p3qX
0Qp4aNQ84EPbvZ572oETZACDNCCQjg5dMFR6SighiJos4NJjFiK+WqQ6ESZf6KWy
TRhi/H3xckcCEZEcE+CRGiplZ6NB74VqLq08ru44FtSYltJ9a47dj/OZMTPHj93I
voB5uTZ56BEgxYMDy5hrm7FNRecPGy/RLak8mcypxaKJG2xCtTVYUqDXxEyGWj7Z
xQfggR/Sb5nUesLzBZ4RVagyOynDTvdbhbcS1B2hhBH4iuvx6C2+BKGMejhEC9Vl
ivVsu+lLUT5FKz4iDuoaevZUENwdH09Fvzjay+qANLwl9PM0wF6SIZuSNObXUJaU
MflFXe+9H3EwiGLX99rM9M8NfR6aaW+IdGWkPB/HCNf3Igp9wxd9UG1VIksocsdG
S3mp9O8EEpn0e5P5q7J+LWU9NEej00eo/Z/FnBkHqOYij04SEMgUTVh1pDKd96w4
Y8QO5x/W91t107hkilEbz7SNLGCLIep+JORkXcvH3puHr4At4Ej4/FY3hCGc27lm
P+Vhu7hIl6fvpylq/Isn2/VQe0L9Onh2TInjEwZygn5aG7IiNwEekVK7fSMOjZ0x
rXB86j5gjaFc8HxfZttC2t1mKzJDOm2+8B9rf8lZo3/2KDIR24c=
=vsI4
-----END PGP SIGNATURE-----

--UNifc18z8z6e1QHx--


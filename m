Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F552C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34320795
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HeMcDe0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34320795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDlK-0003FU-3A
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDfw-0006w1-Lo; Thu, 15 Oct 2020 20:32:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34355 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDfo-0000Zj-Ci; Thu, 15 Oct 2020 20:32:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6Yf4P8qz9sTr; Fri, 16 Oct 2020 11:32:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808358;
 bh=IXQSSafvAJXfFXaugRaFsp9KrX8tZ3gG+kcKpBgEaAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HeMcDe0GeCaNNrisT8fx0kWB4bUCVZqfIyRXxZN7pwqDeCkfF++51i8eLA3E/UfkO
 KBc0l6nUeIG3LP/Lh2LgHPmbYzTcfM9hi4fTAdVYjCxgQP4uL+QBb2QhRP3PH8z762
 TrIgRsmO9+BtvSOEUbPIJCHDrp5cwGOOj0kB7qUU=
Date: Fri, 16 Oct 2020 11:32:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
Message-ID: <20201016003218.GF7078@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
 <20201012053001.GD4787@yekko.fritz.box>
 <38d5993e-8a10-0fb1-5263-6531a356fefd@redhat.com>
 <ca54ec71-11b4-70c5-6d48-4e58fb90a545@redhat.com>
 <20201013053250.GV71119@yekko.fritz.box>
 <96fa5d23ca57363e063b9b5006ad8f71e6b1b307.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <96fa5d23ca57363e063b9b5006ad8f71e6b1b307.camel@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:30:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 jasowang@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 07:15:47AM -0700, Elena Afanasova wrote:
> On Tue, 2020-10-13 at 16:32 +1100, David Gibson wrote:
> > On Mon, Oct 12, 2020 at 03:45:02PM +0200, Paolo Bonzini wrote:
> > > On 12/10/20 12:44, Thomas Huth wrote:
> > > > I think this is one of the tasks from:
> > > >=20
> > > > =20
> > > > https://wiki.qemu.org/Contribute/BiteSizedTasks#Compiler-driven_cle=
anups
> > > >=20
> > > > It has been added by Paolo in 2016:
> > > >=20
> > > > =20
> > > > https://wiki.qemu.org/index.php?title=3DContribute/BiteSizedTasks&d=
iff=3D5368&oldid=3D5367
> > > >=20
> > > > ... so maybe Paolo can comment on the size that has been chosen
> > > > here...?
> > >=20
> > > I used 16K, mostly because it is a nice round number.  8k is too
> > > small
> > > due to PATH_MAX-sized variables.  16k seemed to be plenty and
> > > triggered
> > > in few-enough places that the cleanup is viable.
> >=20
> > Ok.  Why are large stack frames bad in qemu?
> >=20
>=20
> I think that the main issue here is alloca() because it can lead to UB.

That's a fair point.  I've applied the patch to ppc-for-5.2, with a
tweak to the commit message.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I6hIACgkQbDjKyiDZ
s5L3Aw//bQBpt7YEIZTtlMVxI0R5OJgnZuTHnV8zqz+ena1SQlzK3PJ+bsF9Fl/x
3Mx5+lKvo9aziKJHun1BsDfoq3YcQQZTeSc0MOzGUcIRMbssMisZZ3aWHIWbUbWy
R9AbTkttnsJn5CRDaqNxjHVMdiGrBkaOg5chqLA2LtqtMdOCTnyOdCGNBV/fS+Um
LL5p60T9S34HyMwx4QsvpSOw/ql7qbMkW4tzv/UWJ3qW4JcunaNFFZbBzIs89i9X
pFyatNFt/Z7zs/Xx7jVU8hiFVz7U/6ACnDWyj90Fl2ayq4w3e3PwVAfx/Kxl2vGi
FU+4HS5qRLa3T13jnkrhFJCJu2QGBKPS4nymFCiCSaLsJr76gpiisz300WrFXjSS
1eH5m5RrmjioZQPcXyu9ikCmrwI4FwDL3AN770ytEsJivLCsr0bTWOGhhTMBSWYZ
iJJJqsDj1qu+93kv89sd7bA5PCFAA16b4YUvMDAr+Z6w1VI5G3hjfkqEU1Z3rjvG
FCW8jkGNBcd1JAYcx9Sg9/8ukeKbeMSJl4Q4cd6xw7NtXFenC8VXVZXjfsK0exV+
+u7RJQjC/DtM9Te5ysVaofcMagCFdGGcJ975+wVnie12EFx5blI1m3U2+4YZ2BQC
LtdFXaxFYvuZMUwJbWbtKkth1K3WLqeIwG83sMTg0UoHxOkzWJQ=
=xxkU
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--


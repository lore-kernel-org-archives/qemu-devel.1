Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F51C2D0C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A229A2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 00:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VrSSdE3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A229A2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieqDa-0005xa-C0
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 19:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC9-0004TK-TD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieqC8-0002If-Bp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 19:49:37 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:58877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieqC7-0002FG-MO; Tue, 10 Dec 2019 19:49:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47XdcB449zz9sR8; Wed, 11 Dec 2019 11:49:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576025370;
 bh=eewYsTL4+1DmBXC+wfdoYRU+hvgNJgSPk5v1I2zuDgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VrSSdE3W/avhpr79r6bhPBIR/542xotPpwRWfo5U8f9zn1SKQ75k88XaQNVbdxAUJ
 uWCsqTVNF58VN+yOz3X8afoiaHeX0WfBN6FbJWb4+KKiYs69DgqdumAdmGGdz1mBB9
 zDCP5GezOil3NQRMXa0OyCPwANymsrCM06amT8FE=
Date: Wed, 11 Dec 2019 10:41:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v1 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191210234132.GL207300@umbus.fritz.box>
References: <20191209070012.14766-1-bharata@linux.ibm.com>
 <20191209070012.14766-3-bharata@linux.ibm.com>
 <20191210032851.GC207300@umbus.fritz.box>
 <20191210035038.GB17552@in.ibm.com>
 <dd94f089-7df8-1a13-f4a6-631e765f6339@ozlabs.ru>
 <20191210050536.GH207300@umbus.fritz.box>
 <20191210065007.GD17552@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline
In-Reply-To: <20191210065007.GD17552@in.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 linuxram@us.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 12:20:07PM +0530, Bharata B Rao wrote:
> On Tue, Dec 10, 2019 at 04:05:36PM +1100, David Gibson wrote:
> > On Tue, Dec 10, 2019 at 03:03:01PM +1100, Alexey Kardashevskiy wrote:
> > >=20
> > >=20
> > > On 10/12/2019 14:50, Bharata B Rao wrote:
> > > > On Tue, Dec 10, 2019 at 02:28:51PM +1100, David Gibson wrote:
> > > >> On Mon, Dec 09, 2019 at 12:30:12PM +0530, Bharata B Rao wrote:
> > > >>> A pseries guest can be run as a secure guest on Ultravisor-enabled
> > > >>> POWER platforms. When such a secure guest is reset, we need to
> > > >>> release/reset a few resources both on ultravisor and hypervisor s=
ide.
> > > >>> This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from =
the
> > > >>> machine reset path.
> > > >>>
> > > >>> As part of this ioctl, the secure guest is essentially transition=
ed
> > > >>> back to normal mode so that it can reboot like a regular guest and
> > > >>> become secure again.
> > > >>>
> > > >>> This ioctl has no effect when invoked for a normal guest.
> > > >>>
> > > >>> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > > >>> ---
> > > >>>  hw/ppc/spapr.c       | 1 +
> > > >>>  target/ppc/kvm.c     | 7 +++++++
> > > >>>  target/ppc/kvm_ppc.h | 6 ++++++
> > > >>>  3 files changed, 14 insertions(+)
> > > >>>
> > > >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > >>> index f11422fc41..4c7ad3400d 100644
> > > >>> --- a/hw/ppc/spapr.c
> > > >>> +++ b/hw/ppc/spapr.c
> > > >>> @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineStat=
e *machine)
> > > >>>      void *fdt;
> > > >>>      int rc;
> > > >>> =20
> > > >>> +    kvmppc_svm_off();
> > > >>
> > > >> If you're going to have this return an error value, you should rea=
lly
> > > >> check it here.
> > > >=20
> > > > I could, by spapr_machine_reset() and the callers don't propagate t=
he
> > > > errors up. So may be I could print a warning instead when ioctl fai=
ls?
> > >=20
> > > An error here means you cannot restart the machine and should probably
> > > suspend, or try until it is not EBUSY (=3D=3Dall threads have stopped=
?).
> >=20
> > Right, if this fails, something has gone badly wrong.  You should
> > absolutely print a message, and in fact it might be appropriate to
> > quit outright.  IIUC the way PEF resets work, a failure here means you
> > won't be able to boot after the reset, since the guest memory will
> > still be inaccessible to the host.
>=20
> Correct. I will send next version with a message and abort() added in
> the ioctl failure path.

abort() or assert() isn't right either - that's reserved for things
that are definitely caused by a qemu code bug.  This should be an
exit(EXIT_FAILURE).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3wLSoACgkQbDjKyiDZ
s5J6Fw//ZulQpPfjthFna8fi04fHaY85pOjnLzwutdcWAwUF5ZZJwepFrxz3DlEy
D/7mdqrQjN+uVO+nY8YrYg+kcQ9e/Lourliv8MBHua2Ar5q/sojugflcKYDl5s/A
FpfuFw0NJemKrAsBTgziatE7Rg6jx2PDARiSsGmJa2K+vOaiu7yMPzHw779609Ay
pNiSWUaLlr1fkkHgKDtqH/g65Kf2pQicZOcBAeEt3gWgWu9etwd4lCT1gpTfmERV
qTmt3n6al+eVBMUyTTaXLJ1nBsXJuwe3BLSo8i9ay/GomZ8eTYCxUGrRVYVpMUXG
BI80ajLzvt32x1PG4BNHiOeftzGWE4GU8RjpsseI1NSozO7Aqarbw1vYYzOWBbgZ
9k9qjTzg6lVwxey6Qm49Wd+dYIQedV2/hdYPiDs29mhGImwsqFgi2IkKED9kS4Yn
qiwVnpRVxM+i6GE8Di06o/RQ4Utg3vpYr5feZ+7yMT/uA0iemXz8cyNRMoR/qWYb
1WBa5zv8rDzYWM15GXuIP3YrYnclx/DJNPdyz/WYW8hR7jEnl7Zl28xuRRT1mOPS
cU5/ozAUwIlDDUZuXJKlB8vlwJEnMCzCUyzufxpUs6FHXbp3Sz+CQSESIR0rmgLm
pIDoqEg5BEHiDmQ5Mj/sU9ZNzFh3Mmq5eCdoML065tzM/9e76lg=
=v8ZV
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--


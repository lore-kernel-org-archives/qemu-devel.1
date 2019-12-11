Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 05:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B837F20836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 05:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z2wAby1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B837F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieupF-0004d5-Qx
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 00:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieuo2-0003xy-8f
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 00:45:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieuo0-0005m0-Ak
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 00:45:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:37485 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieunz-0005ck-6Q; Wed, 11 Dec 2019 00:45:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Xm900wH7z9sR8; Wed, 11 Dec 2019 16:44:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576043092;
 bh=TDTJ4nQZ8x5jcjQXWnHx4fdbw2HpL1Rw5bSDtg9CrS4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z2wAby1hYbzftXCwO6L+Ahl6S3MloQ2dyCtNsLlg6WpuJbZcB1tW8AY37ekf/TZVf
 TMLFYT3DtgJ77aEv5FVNbmVGewFiu3Syb/vwhNaYqJTqPI9B8VOe39P4gdM8OFLwEZ
 BvnTMTnEoUBxKcDniiOFS3yvlAe0ZfE7b0UVnKmE=
Date: Wed, 11 Dec 2019 16:27:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v1 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191211052742.GQ207300@umbus.fritz.box>
References: <20191209070012.14766-1-bharata@linux.ibm.com>
 <20191209070012.14766-3-bharata@linux.ibm.com>
 <20191210032851.GC207300@umbus.fritz.box>
 <20191210035038.GB17552@in.ibm.com>
 <dd94f089-7df8-1a13-f4a6-631e765f6339@ozlabs.ru>
 <20191210050536.GH207300@umbus.fritz.box>
 <20191210065007.GD17552@in.ibm.com>
 <20191210234132.GL207300@umbus.fritz.box>
 <20191211050824.GE17552@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oN4OvwWIcd1E23D1"
Content-Disposition: inline
In-Reply-To: <20191211050824.GE17552@in.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 linuxram@us.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oN4OvwWIcd1E23D1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 10:38:24AM +0530, Bharata B Rao wrote:
> On Wed, Dec 11, 2019 at 10:41:32AM +1100, David Gibson wrote:
> > On Tue, Dec 10, 2019 at 12:20:07PM +0530, Bharata B Rao wrote:
> > > On Tue, Dec 10, 2019 at 04:05:36PM +1100, David Gibson wrote:
> > > > On Tue, Dec 10, 2019 at 03:03:01PM +1100, Alexey Kardashevskiy wrot=
e:
> > > > >=20
> > > > >=20
> > > > > On 10/12/2019 14:50, Bharata B Rao wrote:
> > > > > > On Tue, Dec 10, 2019 at 02:28:51PM +1100, David Gibson wrote:
> > > > > >> On Mon, Dec 09, 2019 at 12:30:12PM +0530, Bharata B Rao wrote:
> > > > > >>> A pseries guest can be run as a secure guest on Ultravisor-en=
abled
> > > > > >>> POWER platforms. When such a secure guest is reset, we need to
> > > > > >>> release/reset a few resources both on ultravisor and hypervis=
or side.
> > > > > >>> This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF f=
rom the
> > > > > >>> machine reset path.
> > > > > >>>
> > > > > >>> As part of this ioctl, the secure guest is essentially transi=
tioned
> > > > > >>> back to normal mode so that it can reboot like a regular gues=
t and
> > > > > >>> become secure again.
> > > > > >>>
> > > > > >>> This ioctl has no effect when invoked for a normal guest.
> > > > > >>>
> > > > > >>> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > > > > >>> ---
> > > > > >>>  hw/ppc/spapr.c       | 1 +
> > > > > >>>  target/ppc/kvm.c     | 7 +++++++
> > > > > >>>  target/ppc/kvm_ppc.h | 6 ++++++
> > > > > >>>  3 files changed, 14 insertions(+)
> > > > > >>>
> > > > > >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > >>> index f11422fc41..4c7ad3400d 100644
> > > > > >>> --- a/hw/ppc/spapr.c
> > > > > >>> +++ b/hw/ppc/spapr.c
> > > > > >>> @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(Machine=
State *machine)
> > > > > >>>      void *fdt;
> > > > > >>>      int rc;
> > > > > >>> =20
> > > > > >>> +    kvmppc_svm_off();
> > > > > >>
> > > > > >> If you're going to have this return an error value, you should=
 really
> > > > > >> check it here.
> > > > > >=20
> > > > > > I could, by spapr_machine_reset() and the callers don't propaga=
te the
> > > > > > errors up. So may be I could print a warning instead when ioctl=
 fails?
> > > > >=20
> > > > > An error here means you cannot restart the machine and should pro=
bably
> > > > > suspend, or try until it is not EBUSY (=3D=3Dall threads have sto=
pped?).
> > > >=20
> > > > Right, if this fails, something has gone badly wrong.  You should
> > > > absolutely print a message, and in fact it might be appropriate to
> > > > quit outright.  IIUC the way PEF resets work, a failure here means =
you
> > > > won't be able to boot after the reset, since the guest memory will
> > > > still be inaccessible to the host.
> > >=20
> > > Correct. I will send next version with a message and abort() added in
> > > the ioctl failure path.
> >=20
> > abort() or assert() isn't right either - that's reserved for things
> > that are definitely caused by a qemu code bug.  This should be an
> > exit(EXIT_FAILURE).
>=20
> Ok, but I see a problem with checking the return value of this
> ioctl from userspace. If this ioctl is run on older kernels that don't
> support this ioctl, we get -ENOTTY as return value. We shouldn't be
> exiting in that case.

Ah, right.  We'll need to check for -ENOTTY specifically and ignore
it, then.  We don't want this spewing warnings on every non-secure
guest.

> It looks like we may need a new KVM capability to advertise the presence
> of KVM_PPC_SVM_OFF ioctl (or more generally, to advertise host kernel's
> capability to support secure guests).

Actually, that's probably a better idea still.

> Paul - Do you think we should add such a KVM capability? Here is the
> summary of the problem:
>=20
> 1. QEMU invokes KVM_PPC_SVM_OFF ioctl from machine reset path and current=
ly
>    we don't check for its return value.
> 2. On host kernels that support secure guests,
>    2a. this ioctl returns 0 for regular guests and has no effect.
>    2b. the ioctl can fail for secure guests and here we could check the
>        return value and exit the guest right away.
> 3. On host kernels that don't support secure guests, ioctl returns -ENOTTY
>    but we ignore the return value and continue the reset as this is
>    for a non-secure guest.
>=20
> If we have such a KVM capability, we could invoke the ioctl only if it
> is supported and handle the return value appropriately.
>=20
> Regards,
> Bharata.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oN4OvwWIcd1E23D1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3wfksACgkQbDjKyiDZ
s5InPg//X++2EOUrUUbgGEYH6ETzBdQet9Getbty/w+O5XWGusx16xuk+IweJy6O
qLXoVp3L332IxM0G641hwSmALMwu/ake9qG9dRSeKRUjK3cXfm+mozH8foXyjATi
cibqTxXfTzZhVC1D92zn3hoNT3Zzb64tWmhrZSXIc75LyErtKytx2pl/HL2nAvog
bCkwvzlo01KeeL23L93KU+1KSHuMGNkXrSV74NMfGM7WQ/PA+mM4wFsder+ArX3S
aIfsbTfm0EBLNT+7pZh1gA4uAG/WAjc+rn8CivUP+b3dX2x5B3eRtcrjmKNCJ8t2
eSUKv5WDrwCu/5MvIR+UuJAwoundVrVLl+oh/zhDSWO6dyhwgZ6z8N+NXt/bNKDt
mHA3S1khxsyUfQf+GqVaKA3qG2BhgIAEZZkc23cH/HSbt17phhP6xs+oD6jCP3+d
Zu5EdUjdTeIEaHtJtBhEyBZlCczc168iO1pWHtKyqz+1eVpNum2goTpu6PCUqOD1
wi05KG4Y8XNa5bEnlsRyaH6ClUuWVkMRxtoewJPF1IRKBo+wcfHRAHZqNT7scUdP
I6ablqZxbWg78rNclVQRa1VMn8++o3XgVeKd33RIhAem65mqU2tikU00h5ZTIVSp
WDCQWyqEKJ7KFcd1I0XEI3Rhu8xS1da7KED2vJxPIPTn95Ey0OY=
=hl4g
-----END PGP SIGNATURE-----

--oN4OvwWIcd1E23D1--


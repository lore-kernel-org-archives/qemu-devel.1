Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C371DC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D462173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eKguB47m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D462173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hndWF-0005Fn-12
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hndVw-0004QZ-HK
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hndVt-0004mO-EN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:34:07 -0400
Received: from ozlabs.org ([203.11.71.1]:46143)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hndVr-0004fH-5v; Wed, 17 Jul 2019 02:34:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pSCR5xPVz9sMQ; Wed, 17 Jul 2019 16:33:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563345235;
 bh=vVsAQCGIeCoEgmT4kAYYby+Of1vlswZUdyAo4QeaN08=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eKguB47mzucuEwajzkDInYHiBrutYvky6J1h9HglXFoNqE40tleeXBZ+jtPZz5yrx
 aSF2Zx7TN2mEKbu4mhttBM7OeI4R3U6OTwWuvLH/7tE1hMQYbksRuCa3nPoth7JqSo
 mLiPtLxSnpqdcp0uJu2Ak+qK+T/z99I/2Zjhe2kM=
Date: Wed, 17 Jul 2019 15:46:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190717054605.GA2663@umbus.fritz.box>
References: <20190701061946.32636-1-sjitindarsingh@gmail.com>
 <20190703061239.GK9442@umbus.fritz.box>
 <1562211719.10832.15.camel@gmail.com>
 <20190704045954.GV9442@umbus.fritz.box>
 <1562644804.2073.7.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <1562644804.2073.7.camel@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v3] powerpc/spapr: Add host
 threads parameter to ibm, get_system_parameter
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2019 at 02:00:04PM +1000, Suraj Jitindar Singh wrote:
> On Thu, 2019-07-04 at 14:59 +1000, David Gibson wrote:
> > On Thu, Jul 04, 2019 at 01:41:59PM +1000, Suraj Jitindar Singh wrote:
> > > On Wed, 2019-07-03 at 16:12 +1000, David Gibson wrote:
> > > > On Mon, Jul 01, 2019 at 04:19:46PM +1000, Suraj Jitindar Singh
> > > > wrote:
> > > > > The ibm,get_system_parameter rtas call is used by the guest to
> > > > > retrieve
> > > > > data relating to certain parameters of the system. The SPLPAR
> > > > > characteristics option (token 20) is used to determin
> > > > > characteristics of
> > > > > the environment in which the lpar will run.
> > > > >=20
> > > > > It may be useful for a guest to know the number of physical
> > > > > host
> > > > > threads
> > > > > present on the underlying system where it is being run. Add the
> > > > > characteristic "HostThrs" to the SPLPAR Characteristics
> > > > > ibm,get_system_parameter rtas call to expose this information
> > > > > to a
> > > > > guest and provide an implementation which determines this
> > > > > information
> > > > > based on the number of interrupt servers present in the device
> > > > > tree.
> > > > >=20
> > > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > >=20
> > > > Hrm, as I said on our call, I have some misgivings about this.
> > > >=20
> > > > Starting with the most general: this again publishes host
> > > > information
> > > > to the guest without filtering, which has caused us problems
> > > > before
> > > > (e.g. security issues with publishing the host serial and model
> > > > information).  Now, I can't immediately see what harm a guest
> > > > could
> > > > do
> > > > with the host # threads (especially since it could in theory
> > > > deduce
> > > > it
> > > > from the PVR, I think) but it still makes me uneasy.
> > >=20
> > > Correct, a guest could pretty reliably determine this information
> > > anyway based on the PVR. It can't account for a POWER8 operating in
> > > split core mode, but I don't know any harm that could be done by
> > > introducing this information.
> > >=20
> > > Additionally it doesn't really tell you anything about how you're
> > > going
> > > to be scheduled (at least on POWER9) since vcpus are scheduled on a
> > > per
> > > thread, not per core basis.
> >=20
> > Hmm.
> >=20
> > > > Secondly, the "HostThrs" tag doesn't seem to be documented in
> > > > PAPR as
> > > > something that this system-parameter will include.  I don't much
> > > > like
> > > > the idea of adding ad-hoc bits of information here without some
> > > > thought going into designing and specifying it first.
> > >=20
> > > This isn't documented in papr, it has been decided that this is how
> > > the
> > > information will be communicated to a guest. This is the most
> > > appropriate place to put this information and the HostThrs name is
> > > consistent with the naming of other information in this property.
> >=20
> > Grr.  If someone can decide this, they can bloody well document it
> > somewhere.
> >=20
> > > We have other non-papr information in qemu, for example hcall
> > > numbers,
> > > so this isn't exactly a precedent.
> >=20
> > I suppose
> >=20
> > > > > ---
> > > > >=20
> > > > > V1 -> V2:
> > > > > - Take into account that the core may be operating in split
> > > > > core
> > > > > mode
> > > > >   meaning a single core may be split into multiple subcores.
> > > > > V2 -> V3:
> > > > > - Add curly braces for single line if statements
> > > > > ---
> > > > >  hw/ppc/spapr_rtas.c | 62
> > > > > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 62 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > > > index 5bc1a93271..1bab71c90c 100644
> > > > > --- a/hw/ppc/spapr_rtas.c
> > > > > +++ b/hw/ppc/spapr_rtas.c
> > > > > @@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong
> > > > > addr, target_ulong len,
> > > > >      return RTAS_OUT_SUCCESS;
> > > > >  }
> > > > > =20
> > > > > +#define CPUS_PATH       "/proc/device-tree/cpus/"
> > > > > +#define
> > > > > SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
> > > > > +
> > > > > +static int rtas_get_num_host_threads(void)
> > > > > +{
> > > > > +    int num_threads =3D -1;
> > > > > +    unsigned long len;
> > > > > +    const char *entry;
> > > > > +    char *buf;
> > > > > +    GDir *dir;
> > > > > +
> > > > > +    if (!kvm_enabled()) {
> > > > > +        return 1;
> > > > > +    }
> > > > > +
> > > > > +    /* Read interrupt servers to determine number of threads
> > > > > per
> > > > > core */
> > > > > +    dir =3D g_dir_open(CPUS_PATH, 0, NULL);
> > > > > +    if (!dir) {
> > > > > +        return -1;
> > > > > +    }
> > > > > +
> > > > > +    while ((entry =3D g_dir_read_name(dir))) {
> > > > > +        if (!strncmp(entry, "PowerPC,POWER",
> > > > > strlen("PowerPC,POWER"))) {
> > > > > +            char *path;
> > > > > +
> > > > > +            path =3D g_strconcat(CPUS_PATH, entry, "/ibm,ppc-
> > > > > interrupt-server#s",
> > > > > +                               NULL);
> > > > > +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> > > > > +                num_threads =3D len / sizeof(int);
> > > > > +                g_free(buf);
> > > > > +            }
> > > > > +
> > > > > +            g_free(path);
> > > > > +            break;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    g_dir_close(dir);
> > > > > +
> > > > > +    /* Check if split core mode in use */
> > > > > +    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
> > > > > +        int subcores =3D g_ascii_strtoll(buf, NULL, 10);
> > > > > +
> > > > > +        if (subcores) {
> > > > > +            num_threads /=3D subcores;
> > > > > +        }
> > > > > +        g_free(buf);
> > > > > +    }
> > > >=20
> > > > Finally, all the logic above is built on the assumption of a ppc
> > > > host
> > > > - and not just that but an IBM POWER host...
> > >=20
> > > RTAS services are defined as being provided by a papr platform, and
> > > the
> > > existence of the ibm,ppc-interrupt-server#s device tree property is
> > > a
> > > requirement of a papr platform. So I don't see this being an issue.
> >=20
> > The *guest* is a PAPR platform, there's no guarantee the host has to
> > be a PAPR platform (in fact it usually won't be, it's just that
> > powernv has a lot of the same device tree properties).
>=20
> Well I think technically the host is a papr platform which supplies an
> environment to the papr guest partition. But the terminology isn't
> really important here.

My point is that host userspace does not necessarily live in a PAPR
environment.

> > > > > +    return num_threads;
> > > > > +}
> > > > > +
> > > > >  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> > > > >                                            SpaprMachineState
> > > > > *spapr,
> > > > >                                            uint32_t token,
> > > > > uint32_t
> > > > > nargs,
> > > > > @@ -250,6 +302,16 @@ static void
> > > > > rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> > > > >                                            current_machine-
> > > > > > ram_size / MiB,
> > > > >=20
> > > > >                                            smp_cpus,
> > > > >                                            max_cpus);
> > > > > +        int num_host_threads =3D rtas_get_num_host_threads();
> > > > > +
> > > > > +        if (num_host_threads > 0) {
> > > >=20
> > > > ... this sort of implements a fallback in other cases (KVM PR
> > > > with a
> > > > non-IBM host, TCG, but the boundary conditions are not really
> > > > well
> > > > defined.
> > >=20
> > > This is essentially catching the error case of
> > > rtas_get_num_host_threads() returning a negative number or not
> > > finding
> > > the required properties (which as mentioned above are required).
> > > The
> > > KVM-PR case will work the same as the KVM-HV case where the host
> > > device
> > > tree will be queried.
> >=20
> > Not if you're using PR on, say, an embedded ppc or an old Apple
> > machine that doesn't have the PAPR-ish properties in the host device
> > tree.
>=20
> In which case we won't find the device tree property and so we don't
> have a reliable way to determine the number of host threads, so we will
> omit the property.
>=20
> >=20
> > > For TCG we just default to 1 since this
> > > information shouldn't be relevant to a TCG guest.
> >=20
> > Uh.. it doesn't though, it omits it entirely.
>=20
> No,
> if (!kvm_enabled()) return 1;
> above
>=20
> >=20
> > Also I don't really understand how it's relevant to a KVM guest in
> > the
> > first place.
>=20
> There are registers which were previously scaled based on the threads
> per core, for example the PURR, but which aren't on POWER9 when running
> in lpar per thread mode and instead count per thread. This will look
> different to a guest OS, and so for whatever reason the guest might
> want to scale these registers based on the host threading mode.

Since apparently POWER's version of "compatibility" is "close but not
quite".

Anyway, after our discussion on Monday, I'm more or less resigned to
the need for HostThrs here.  Still some changes I'd like to see here.

First, I'd like an explanatory comment in get_system_parameter,
explaining what the value is used for.  Mention that it's not in PAPR
and say what little you can about who decided on this representation.

Second, I still really dislike directly grovelling around in the host
device tree.  THe fallbacks you have will probably work in practice,
but I really think it assumes too much about what the host environment
will look like.  Plus it, again, makes a guest visible difference
based on host properties which we want to avoid.  We'd probably get
away with this one (the worst is you'd have messed up PURR scaling
after migration), but still.

I was thinking we could use kvmppc_smt_threads(), but that will be
wrong for POWER9, I think.  Plus it still means guest visible
differences between TCG and KVM (or even different KVM types).

I actually think the right way to do this is to have qemu base it on
the PVR (i.e. look up the information in its internal cpu table).
That way it should give sensible and identical results for KVM and TCG
- with the only KVM dependence being that KVM and -cpu host selects
the exact cpu model for you.

That may give non-1 values for TCG and KVM PR, which could result in
bogus scaling... but AFAICT PURR values will be kind of bogus in those
situations anyway, so I don't know that it matters.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0uthoACgkQbDjKyiDZ
s5LvsQ//fh0mNFirh+Sh+9f6JmRJtbQwL/O2lV17tAeArUn8H0Uq5fYluvkXdrd8
yfCo5lHSu+ML6nnBSK7ca+nfMndA4o8HREpzClQ2oWfzh1lpLPo3BUk7/Mr/BN0S
REpJV3kdj8ZHJgL3e7YSnvfvrx6CnWHLqFtE+CMC/jY3S+qEWZsabKp7NfTBHTKo
E0J97NFQyR2+IqyS3pAB5A+07v969hX2wNhnzzIQrcjOftwaBKZxjsFc3dlDexg1
iNvWZpC/FBRGN8HyywjYvsKp3LsD9M+EXNvyOmFlOqMad+KvJzOAikJOWgWLARCM
NsK/pI0FGpmNCwf2y5Od/ooZW7I1zud512rXMaEKCkrKVQ9ISBNnlAK4uyhWi/yv
IVb4jvZ9PToYWDxsDXqjrO7Du0RbmYmJBsgdKY/7aQK0VRjM6QwIvmnVy5AFoI3d
PeG8s4AfhrZJI5e2ofNMYRfxNvNDnh2kCKlaattufwl2Ay0242QJcCk9vVW+Gfv7
Tfdjp4RlpllBAy3XxZB92NA8+CUXuZmDa1cGakDJnMawBeiBsgPnB2/YCrzK6POa
ISn2CRx+nod/1riHDNAm5X1v9H2pmRTCvsus1jIKEXy/kGPQJfWtfeYU9TZfl2hD
VACnz/hTdeno0BzxVA4wiWl9ZDxgFGabu+kdsaNJAptCrOyaSPQ=
=oqFr
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--


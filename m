Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC5CC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BEF21882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 05:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ChFyoPP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BEF21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hitsg-00073B-8Q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 01:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hitqw-0006Qm-96
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hitqu-0001nP-Bp
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 01:00:14 -0400
Received: from ozlabs.org ([203.11.71.1]:42427)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hitqq-0001kq-DC; Thu, 04 Jul 2019 01:00:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45fQl41L5gz9sNw; Thu,  4 Jul 2019 15:00:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562216400;
 bh=IudaQSbwtjkxduObqSr4h4cGrIQqEGERgzXmie7e/94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ChFyoPP+ix0UEe2S+gl/T2hQ/utjoVk83GEgnArfIXvt2MEm/yL3Wojxo4QwiuTHJ
 fDElyo5LYIv9l4VNDO0dI2v7z/cbbOyiaFwO3Q/f/lAUuu5ay86y/P0UoeuFpdA6WZ
 k1Bb6b1VqmcPjDQWpBu2DrE2PC9ztP++5Zjh8he8=
Date: Thu, 4 Jul 2019 14:59:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190704045954.GV9442@umbus.fritz.box>
References: <20190701061946.32636-1-sjitindarsingh@gmail.com>
 <20190703061239.GK9442@umbus.fritz.box>
 <1562211719.10832.15.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dRgc669pgRVB2OqT"
Content-Disposition: inline
In-Reply-To: <1562211719.10832.15.camel@gmail.com>
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


--dRgc669pgRVB2OqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2019 at 01:41:59PM +1000, Suraj Jitindar Singh wrote:
> On Wed, 2019-07-03 at 16:12 +1000, David Gibson wrote:
> > On Mon, Jul 01, 2019 at 04:19:46PM +1000, Suraj Jitindar Singh wrote:
> > > The ibm,get_system_parameter rtas call is used by the guest to
> > > retrieve
> > > data relating to certain parameters of the system. The SPLPAR
> > > characteristics option (token 20) is used to determin
> > > characteristics of
> > > the environment in which the lpar will run.
> > >=20
> > > It may be useful for a guest to know the number of physical host
> > > threads
> > > present on the underlying system where it is being run. Add the
> > > characteristic "HostThrs" to the SPLPAR Characteristics
> > > ibm,get_system_parameter rtas call to expose this information to a
> > > guest and provide an implementation which determines this
> > > information
> > > based on the number of interrupt servers present in the device
> > > tree.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >=20
> > Hrm, as I said on our call, I have some misgivings about this.
> >=20
> > Starting with the most general: this again publishes host information
> > to the guest without filtering, which has caused us problems before
> > (e.g. security issues with publishing the host serial and model
> > information).  Now, I can't immediately see what harm a guest could
> > do
> > with the host # threads (especially since it could in theory deduce
> > it
> > from the PVR, I think) but it still makes me uneasy.
>=20
> Correct, a guest could pretty reliably determine this information
> anyway based on the PVR. It can't account for a POWER8 operating in
> split core mode, but I don't know any harm that could be done by
> introducing this information.
>=20
> Additionally it doesn't really tell you anything about how you're going
> to be scheduled (at least on POWER9) since vcpus are scheduled on a per
> thread, not per core basis.

Hmm.

> > Secondly, the "HostThrs" tag doesn't seem to be documented in PAPR as
> > something that this system-parameter will include.  I don't much like
> > the idea of adding ad-hoc bits of information here without some
> > thought going into designing and specifying it first.
>=20
> This isn't documented in papr, it has been decided that this is how the
> information will be communicated to a guest. This is the most
> appropriate place to put this information and the HostThrs name is
> consistent with the naming of other information in this property.

Grr.  If someone can decide this, they can bloody well document it
somewhere.

> We have other non-papr information in qemu, for example hcall numbers,
> so this isn't exactly a precedent.

I suppose

> > > ---
> > >=20
> > > V1 -> V2:
> > > - Take into account that the core may be operating in split core
> > > mode
> > >   meaning a single core may be split into multiple subcores.
> > > V2 -> V3:
> > > - Add curly braces for single line if statements
> > > ---
> > >  hw/ppc/spapr_rtas.c | 62
> > > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > > index 5bc1a93271..1bab71c90c 100644
> > > --- a/hw/ppc/spapr_rtas.c
> > > +++ b/hw/ppc/spapr_rtas.c
> > > @@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong
> > > addr, target_ulong len,
> > >      return RTAS_OUT_SUCCESS;
> > >  }
> > > =20
> > > +#define CPUS_PATH       "/proc/device-tree/cpus/"
> > > +#define
> > > SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
> > > +
> > > +static int rtas_get_num_host_threads(void)
> > > +{
> > > +    int num_threads =3D -1;
> > > +    unsigned long len;
> > > +    const char *entry;
> > > +    char *buf;
> > > +    GDir *dir;
> > > +
> > > +    if (!kvm_enabled()) {
> > > +        return 1;
> > > +    }
> > > +
> > > +    /* Read interrupt servers to determine number of threads per
> > > core */
> > > +    dir =3D g_dir_open(CPUS_PATH, 0, NULL);
> > > +    if (!dir) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    while ((entry =3D g_dir_read_name(dir))) {
> > > +        if (!strncmp(entry, "PowerPC,POWER",
> > > strlen("PowerPC,POWER"))) {
> > > +            char *path;
> > > +
> > > +            path =3D g_strconcat(CPUS_PATH, entry, "/ibm,ppc-
> > > interrupt-server#s",
> > > +                               NULL);
> > > +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> > > +                num_threads =3D len / sizeof(int);
> > > +                g_free(buf);
> > > +            }
> > > +
> > > +            g_free(path);
> > > +            break;
> > > +        }
> > > +    }
> > > +
> > > +    g_dir_close(dir);
> > > +
> > > +    /* Check if split core mode in use */
> > > +    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
> > > +        int subcores =3D g_ascii_strtoll(buf, NULL, 10);
> > > +
> > > +        if (subcores) {
> > > +            num_threads /=3D subcores;
> > > +        }
> > > +        g_free(buf);
> > > +    }
> >=20
> > Finally, all the logic above is built on the assumption of a ppc host
> > - and not just that but an IBM POWER host...
>=20
> RTAS services are defined as being provided by a papr platform, and the
> existence of the ibm,ppc-interrupt-server#s device tree property is a
> requirement of a papr platform. So I don't see this being an issue.

The *guest* is a PAPR platform, there's no guarantee the host has to
be a PAPR platform (in fact it usually won't be, it's just that
powernv has a lot of the same device tree properties).

> >=20
> > > +    return num_threads;
> > > +}
> > > +
> > >  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> > >                                            SpaprMachineState
> > > *spapr,
> > >                                            uint32_t token, uint32_t
> > > nargs,
> > > @@ -250,6 +302,16 @@ static void
> > > rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
> > >                                            current_machine-
> > > >ram_size / MiB,
> > >                                            smp_cpus,
> > >                                            max_cpus);
> > > +        int num_host_threads =3D rtas_get_num_host_threads();
> > > +
> > > +        if (num_host_threads > 0) {
> >=20
> > ... this sort of implements a fallback in other cases (KVM PR with a
> > non-IBM host, TCG, but the boundary conditions are not really well
> > defined.
>=20
> This is essentially catching the error case of
> rtas_get_num_host_threads() returning a negative number or not finding
> the required properties (which as mentioned above are required). The
> KVM-PR case will work the same as the KVM-HV case where the host device
> tree will be queried.

Not if you're using PR on, say, an embedded ppc or an old Apple
machine that doesn't have the PAPR-ish properties in the host device
tree.

> For TCG we just default to 1 since this
> information shouldn't be relevant to a TCG guest.

Uh.. it doesn't though, it omits it entirely.

Also I don't really understand how it's relevant to a KVM guest in the
first place.

>=20
> >=20
> > > +            char *hostthr_val, *old =3D param_val;
> > > +
> > > +            hostthr_val =3D g_strdup_printf(",HostThrs=3D%d",
> > > num_host_threads);
> > > +            param_val =3D g_strconcat(param_val, hostthr_val, NULL);
> > > +            g_free(hostthr_val);
> > > +            g_free(old);
> > > +        }
> > >          ret =3D sysparm_st(buffer, length, param_val,
> > > strlen(param_val) + 1);
> > >          g_free(param_val);
> > >          break;
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dRgc669pgRVB2OqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0dh8gACgkQbDjKyiDZ
s5JdSRAAmwiUf+wnvrPIsTAxYF+TfTvhkPugpyM0fEZCmjAjGw16lOrt+1D35Xh+
Kw9BLsntc5rIT+ZlChtGlA2Z0uAQl5eHLz+ozSijwyZErZ8txwXf9UAHYXVSbQ/M
Nf6EHb8CSR+n6sb72YOFzzIzt/uSI0OfHj+QqMAVzf3VhWG+byyHToKB/33vgiao
m4dZs+snCCwGKNkc9PxcA2QI21Hjo/S8ytjJuEIQQpI8Qv8fjvnVMR1H3jdqlJPK
DEhyNAh14UMubiC9Wy0Avqd2J7TC1f/067PkUVvLAWRLBLbkhGYm+SRBjOaAArMY
9wtU5dL8AfUnz9gK7utjDwUQ0CPHRYRByUGbQj9iUajqsnZC17RavPgBCHAKOi3d
AkcKa7uE3QwE2vbG6QhdvvLMXbLRyl3ZGVOy/hA4ciPO+4HcW1J3RrL6u65lVNgI
6skeL1twsbwZDiuvQH6a8/oe1b1SOQB8shIVHeNqFnEqhpx3wEmzx3fpC1Al+b+n
3VzCoOzTjgq7PT9M/1qarSWxfiUhmDi4zhRNWEUJLV7EWC0+ROPx25y5DXuF73SL
QDf1MHFCvxiB5QvTjR0h1MNQy1mAQ6orgMiDGbY4WUFiUPRlDfGOvdYX7pVHb8in
2ilmncASaviEXHBQ69Wa1kMlxtsCvSmTNsvkUA/nrZdGvFnlv7E=
=WXHL
-----END PGP SIGNATURE-----

--dRgc669pgRVB2OqT--


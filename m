Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ABC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F235921880
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gTSxu9c1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F235921880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYXW-00059x-28
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 02:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVy-0003YC-L9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVw-000693-MN
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:10 -0400
Received: from ozlabs.org ([203.11.71.1]:48135)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiYVs-0005v7-R1; Wed, 03 Jul 2019 02:13:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45drPZ6vdNz9s8m; Wed,  3 Jul 2019 16:12:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562134370;
 bh=L0hzMQEO0XtEEAC39b0ZkqGoNcv63Ivk7isOm0lqxgo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gTSxu9c1HwBwzRfxWLRvg3pVPbgs5v+5LFxkCevImWaqxVYy1FIDgsBMkPGP8Q78Q
 eIjivssXPLgEiiEOnYU2+ayPVHPOniNa3Q9KWroDGeVtLVkN4Gm4QTQTtFYb1dyiH8
 Z09HAOGnJFfOGjvw4K3KIGtaEbZ0MLvHLYVtUgUk=
Date: Wed, 3 Jul 2019 16:12:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190703061239.GK9442@umbus.fritz.box>
References: <20190701061946.32636-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <20190701061946.32636-1-sjitindarsingh@gmail.com>
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


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 04:19:46PM +1000, Suraj Jitindar Singh wrote:
> The ibm,get_system_parameter rtas call is used by the guest to retrieve
> data relating to certain parameters of the system. The SPLPAR
> characteristics option (token 20) is used to determin characteristics of
> the environment in which the lpar will run.
>=20
> It may be useful for a guest to know the number of physical host threads
> present on the underlying system where it is being run. Add the
> characteristic "HostThrs" to the SPLPAR Characteristics
> ibm,get_system_parameter rtas call to expose this information to a
> guest and provide an implementation which determines this information
> based on the number of interrupt servers present in the device tree.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Hrm, as I said on our call, I have some misgivings about this.

Starting with the most general: this again publishes host information
to the guest without filtering, which has caused us problems before
(e.g. security issues with publishing the host serial and model
information).  Now, I can't immediately see what harm a guest could do
with the host # threads (especially since it could in theory deduce it
=66rom the PVR, I think) but it still makes me uneasy.

Secondly, the "HostThrs" tag doesn't seem to be documented in PAPR as
something that this system-parameter will include.  I don't much like
the idea of adding ad-hoc bits of information here without some
thought going into designing and specifying it first.

>=20
> ---
>=20
> V1 -> V2:
> - Take into account that the core may be operating in split core mode
>   meaning a single core may be split into multiple subcores.
> V2 -> V3:
> - Add curly braces for single line if statements
> ---
>  hw/ppc/spapr_rtas.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 5bc1a93271..1bab71c90c 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -229,6 +229,58 @@ static inline int sysparm_st(target_ulong addr, targ=
et_ulong len,
>      return RTAS_OUT_SUCCESS;
>  }
> =20
> +#define CPUS_PATH       "/proc/device-tree/cpus/"
> +#define SUBCORE_PATH    "/sys/devices/system/cpu/subcores_per_core"
> +
> +static int rtas_get_num_host_threads(void)
> +{
> +    int num_threads =3D -1;
> +    unsigned long len;
> +    const char *entry;
> +    char *buf;
> +    GDir *dir;
> +
> +    if (!kvm_enabled()) {
> +        return 1;
> +    }
> +
> +    /* Read interrupt servers to determine number of threads per core */
> +    dir =3D g_dir_open(CPUS_PATH, 0, NULL);
> +    if (!dir) {
> +        return -1;
> +    }
> +
> +    while ((entry =3D g_dir_read_name(dir))) {
> +        if (!strncmp(entry, "PowerPC,POWER", strlen("PowerPC,POWER"))) {
> +            char *path;
> +
> +            path =3D g_strconcat(CPUS_PATH, entry, "/ibm,ppc-interrupt-s=
erver#s",
> +                               NULL);
> +            if (g_file_get_contents(path, &buf, &len, NULL)) {
> +                num_threads =3D len / sizeof(int);
> +                g_free(buf);
> +            }
> +
> +            g_free(path);
> +            break;
> +        }
> +    }
> +
> +    g_dir_close(dir);
> +
> +    /* Check if split core mode in use */
> +    if (g_file_get_contents(SUBCORE_PATH, &buf, &len, NULL)) {
> +        int subcores =3D g_ascii_strtoll(buf, NULL, 10);
> +
> +        if (subcores) {
> +            num_threads /=3D subcores;
> +        }
> +        g_free(buf);
> +    }

Finally, all the logic above is built on the assumption of a ppc host
- and not just that but an IBM POWER host...

> +    return num_threads;
> +}
> +
>  static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
>                                            SpaprMachineState *spapr,
>                                            uint32_t token, uint32_t nargs,
> @@ -250,6 +302,16 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU=
 *cpu,
>                                            current_machine->ram_size / Mi=
B,
>                                            smp_cpus,
>                                            max_cpus);
> +        int num_host_threads =3D rtas_get_num_host_threads();
> +
> +        if (num_host_threads > 0) {

=2E.. this sort of implements a fallback in other cases (KVM PR with a
non-IBM host, TCG, but the boundary conditions are not really well defined.

> +            char *hostthr_val, *old =3D param_val;
> +
> +            hostthr_val =3D g_strdup_printf(",HostThrs=3D%d", num_host_t=
hreads);
> +            param_val =3D g_strconcat(param_val, hostthr_val, NULL);
> +            g_free(hostthr_val);
> +            g_free(old);
> +        }
>          ret =3D sysparm_st(buffer, length, param_val, strlen(param_val) =
+ 1);
>          g_free(param_val);
>          break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cR1QACgkQbDjKyiDZ
s5Ly/xAAqNGEvipjwrwJ77b1y1ukUPIsEeDiY6Laglmcq3e/PQkp0ojLdIC0Tkst
38OxnlBnaqthW5eKMwcKlTRlyDygOrJCVKZzr2R2z8sXSlA7tfuaOlp7EEEXRIOr
ylUE2/4n4Ow8W6hzdvKmkjFc2gZ6Fj5sptIzzT0c7sKRSARtxSKQXdDgkUNS41AR
pREFN/pl5P19QWs4NSOftQ47ETa84auyVKt0gNUpf4ONuny2rSo+iapq7KihhicO
6SL/NlVVpWF0w9QpwuYssVIL3VovW48hplhj2YvUZwViF52omG5mXUAjqBTKZe40
FohK9xpacdPnn/KdRXsE1+3ibkOc5m3luOUoIz1IOcnU7pVA+HpS00Rf5a1IPldK
l2Bu9yQMoDlpPPLw03mAXFY+xvRRyXy9EOlEZzX5+gKPFVtjP+V4yNCVD3fjk9/4
leTXG8GRqlVI3bJ03CB5S+UWHPMauCRYhxE+CSciAXTwjkNkle03NJpUjxpPXZsZ
SIvGoWlD6mxh2q5alGJpVWXjptFIlR9kn8mbPd6V0lzN1pO0XbVYbrz6AUWI2heX
XasPfqvs6YU+1eCqL04pf0oaDY/To7mGu6bB5SOlZ38z0MJXXZfpvwUa7VQwUDVy
P58NN7FCs9u/WLjtNnZrVzd+KK50nEwOulIhx32cv8S7mC2xgu4=
=T8+i
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--


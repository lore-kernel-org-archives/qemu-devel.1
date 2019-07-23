Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D0FC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F53D2238E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 05:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CSZP5ZNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F53D2238E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpnE0-0006Yk-3D
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 01:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCh-00013U-V0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpnCg-0003qR-08
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 01:19:11 -0400
Received: from ozlabs.org ([203.11.71.1]:51577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpnCe-0003nC-8V; Tue, 23 Jul 2019 01:19:09 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45t6G84RnVz9sNf; Tue, 23 Jul 2019 15:18:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563859136;
 bh=w8zJ9KNYwObe4DAU4jdOfBJlXQFGD0J+0OxOeh4LdTY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CSZP5ZNUKi4vrsHWCYUlIpHJMot8hkx0YvUkWNfWX7z4bpB5BESPHy294jKf1lfst
 a2f+12Nz/InQ+SDVUXPOsBD+dphNaYaxwUipPCugWngdxlQeDJekQpMkGthtrm0vTz
 Lpyfut2k5P0MHFUXOytt3P3VW/1BSbr7Jwarsn7A=
Date: Tue, 23 Jul 2019 13:52:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190723035229.GP25073@umbus.fritz.box>
References: <20190720012850.14369-1-aik@ozlabs.ru>
 <20190720012850.14369-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+W7ryvxEk4RRyt+P"
Content-Disposition: inline
In-Reply-To: <20190720012850.14369-3-aik@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH qemu RFC 2/4] spapr: Allow bios-less
 configuration
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
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+W7ryvxEk4RRyt+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2019 at 11:28:48AM +1000, Alexey Kardashevskiy wrote:
> The pseries kernel can do either usual prom-init boot or kexec style boot.
> We always did the prom-init which relies on the completeness of
> the device tree (for example, PCI BARs have to be assigned beforehand) and
> the client interface; the system firmware (SLOF) implements this.
>=20
> However we can use the kexec style boot as well. To do that, we can skip
> loading SLOF and jump straight to the kernel. GPR5=3D=3D0 (the client
> interface entry point, SLOF passes a valid pointer there) tells Linux to
> do the kexec boot rather than prom_init so it can proceed to the initramf=
s.
> With few PCI fixes in the guest kernel, it can boot from PCI (via
> petitboot, for example).
>=20
> This adds a "bios" machine option which controls whether QEMU loads SLOF
> or jumps directly to the kernel. When bios=3D=3Doff, this does not copy S=
LOF
> and RTAS into the guest RAM and sets RTAS properties to 0 to bypass
> the kexec user space tool which checks for their presence (not for
> the values though).

BIOS is sometimes used to refer to any machine's firmware, but it's
also used to refer specifically to PC style BIOS.  I think it would be
clearer to be explicit here and call the options "slof" rather than
"bios".

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  include/hw/ppc/spapr.h |  1 +
>  hw/ppc/spapr.c         | 58 ++++++++++++++++++++++++++++++++----------
>  2 files changed, 45 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ff82bb8554e1..7f5d7a70d27e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -160,6 +160,7 @@ struct SpaprMachineState {
>      long kernel_size;
>      bool kernel_le;
>      uint64_t kernel_addr;
> +    bool bios_enabled;
>      uint32_t initrd_base;
>      long initrd_size;
>      uint64_t rtc_offset; /* Now used only during incoming migration */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6d13d65d8996..81ad6a6f28de 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1116,6 +1116,10 @@ static void spapr_dt_rtas(SpaprMachineState *spapr=
, void *fdt)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,lrdr-capacity",
>                       lrdr_capacity, sizeof(lrdr_capacity)));
> =20
> +    /* These are to make kexec-lite happy */
> +    _FDT(fdt_setprop_cell(fdt, rtas, "linux,rtas-base", 0));
> +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", 0));

What exactly is kexec-lite and what does it need here?

>      spapr_dt_rtas_tokens(fdt, rtas);
>  }
> =20
> @@ -1814,7 +1818,11 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>      spapr->fdt_blob =3D fdt;
> =20
>      /* Set up the entry state */
> -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_addr=
);
> +    if (!spapr->bios_enabled) {
> +        spapr_cpu_set_entry_state(first_ppc_cpu, spapr->kernel_addr, fdt=
_addr);
> +    } else {
> +        spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_=
addr);
> +    }
>      first_ppc_cpu->env.gpr[5] =3D 0;
> =20
>      spapr->cas_reboot =3D false;
> @@ -3031,20 +3039,22 @@ static void spapr_machine_init(MachineState *mach=
ine)
>          }
>      }
> =20
> -    if (bios_name =3D=3D NULL) {
> -        bios_name =3D FW_FILE_NAME;
> +    if (spapr->bios_enabled) {
> +        if (bios_name =3D=3D NULL) {
> +            bios_name =3D FW_FILE_NAME;
> +        }
> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (!filename) {
> +            error_report("Could not find LPAR firmware '%s'", bios_name);
> +            exit(1);
> +        }
> +        fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> +        if (fw_size <=3D 0) {
> +            error_report("Could not load LPAR firmware '%s'", filename);
> +            exit(1);
> +        }
> +        g_free(filename);
>      }
> -    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> -    if (!filename) {
> -        error_report("Could not find LPAR firmware '%s'", bios_name);
> -        exit(1);
> -    }
> -    fw_size =3D load_image_targphys(filename, 0, FW_MAX_SIZE);
> -    if (fw_size <=3D 0) {
> -        error_report("Could not load LPAR firmware '%s'", filename);
> -        exit(1);
> -    }
> -    g_free(filename);
> =20
>      /* FIXME: Should register things through the MachineState's qdev
>       * interface, this is a legacy from the sPAPREnvironment structure
> @@ -3266,6 +3276,20 @@ static void spapr_set_kernel_addr(Object *obj, Vis=
itor *v, const char *name,
>      visit_type_uint64(v, name, (uint64_t *)opaque, errp);
>  }
> =20
> +static bool spapr_get_bios_enabled(Object *obj, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->bios_enabled;
> +}
> +
> +static void spapr_set_bios_enabled(Object *obj, bool value, Error **errp)
> +{
> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->bios_enabled =3D value;
> +}
> +
>  static char *spapr_get_ic_mode(Object *obj, Error **errp)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3379,6 +3403,12 @@ static void spapr_instance_init(Object *obj)
>                                      " for -kernel is the default",
>                                      NULL);
>      spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
> +    object_property_add_bool(obj, "bios", spapr_get_bios_enabled,
> +                            spapr_set_bios_enabled, NULL);
> +    object_property_set_description(obj, "bios", "Conrols whether to loa=
d bios",
> +                                    NULL);
> +    spapr->bios_enabled =3D true;
> +
>      /* The machine class defines the default interrupt controller mode */
>      spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+W7ryvxEk4RRyt+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl02hH0ACgkQbDjKyiDZ
s5Jzeg//dQ37hWD9Pvw/mSBZ7fVmpSU3SHHCcCBeK6r9cER+d/XVprQBJKqAE49B
F1yb1wre5plogcsmGZdt1pGTMadkhqsKY5MWzu4NRV5UTmZBtJTp27rd9OVdBCOF
+INLGXfNWRDP7w2VdkH8oLUvh3ZSWd+61zlAm7rs5zYtynw+J9vxI6bLxzJBY3HD
L5sK2FWtr4O284T4k1UPvHTRYEPpyMpojSufQIcyUoWAuxhmEgwpRgWAgfmmcEv3
bDIWbZbAceTJMsh4TauoTyXXk22IwGYivGzC62ImXF46W+LJb9P4CMmBKZ7gPL0a
andCNQPtGRnitVzm3f7NlNQ1zHFUiBr5YX3C7iK9bs4nT0bmDkWumCF2zkdwSm41
d+t1KM2obPiw4J3YrYtsf//GVXPNwAeyvC+oBmyBcX59OPsnz4r4fgY4ymcV4Vvc
PHzILc2H9fClxiK70zo7EaCHKeRF7vH6zMRoruySeUoKbq++ANdFwslHNbr2Et9m
JCyxaG2oKneLbGzCiIwCMSXjV0LyJmsGyr41qWMuP+e0czm1YxwIx21gYYNDMNpp
fuZGv7jF1Vj/i3J7zAkSEQh/lZNf9ihHO0xljBhb4t+m/YTYcnCCxd5fqCIuF6oj
YLWsGnZ3s8F+2WU5mgP8IJDZuHgsfqoLNcJaSd88JjhlDWYlo78=
=P+MP
-----END PGP SIGNATURE-----

--+W7ryvxEk4RRyt+P--


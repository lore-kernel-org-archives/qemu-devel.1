Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAAFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A82E2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YvQZaDSb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A82E2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDeVd-0001ov-9j
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 21:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUm-000067-Lf; Wed, 02 Sep 2020 21:57:00 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53413 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUj-0005bp-0G; Wed, 02 Sep 2020 21:57:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BhkSc75Ddz9sTS; Thu,  3 Sep 2020 11:56:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599098209;
 bh=edv6LMM9HLzKFcIP+RvflRSsamdIAWI6/S3XGluvPHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YvQZaDSbSD/OIc1JzVEeb51KkkKOY2jUfQzDywvrgdrq4rTnw0tT1VH6Cpvjx1NG9
 kVkDICMarNJemDNqZ1Gh8C8Qove6p+fmXRzDVBAR3b3LFWt8/HvFpgmOXEBKuqtsQw
 ScFzLKdaeb6v6sw+na82k2aoC+Mqfli9JYM4bc60=
Date: Thu, 3 Sep 2020 11:34:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 5/7] spapr, spapr_numa: move lookup-arrays handling to
 spapr_numa.c
Message-ID: <20200903013430.GG1897@yekko.fritz.box>
References: <20200901125645.118026-1-danielhb413@gmail.com>
 <20200901125645.118026-6-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <20200901125645.118026-6-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 09:56:43AM -0300, Daniel Henrique Barboza wrote:
> In a similar fashion as the previous patch, let's move the
> handling of ibm,associativity-lookup-arrays from spapr.c to
> spapr_numa.c. A spapr_numa_write_assoc_lookup_arrays() helper was
> created, and spapr_dt_dynamic_reconfiguration_memory() can now
> use it to advertise the lookup-arrays.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr.c              | 25 ++----------------------
>  hw/ppc/spapr_numa.c         | 39 +++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr_numa.h |  2 ++
>  3 files changed, 43 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 172f965fe0..65d2ccd578 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -535,13 +535,10 @@ static int spapr_dt_dynamic_reconfiguration_memory(=
SpaprMachineState *spapr,
>                                                     void *fdt)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> -    int nb_numa_nodes =3D machine->numa_state->num_nodes;
> -    int ret, i, offset;
> +    int ret, offset;
>      uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
>      uint32_t prop_lmb_size[] =3D {cpu_to_be32(lmb_size >> 32),
>                                  cpu_to_be32(lmb_size & 0xffffffff)};
> -    uint32_t *int_buf, *cur_index, buf_len;
> -    int nr_nodes =3D nb_numa_nodes ? nb_numa_nodes : 1;
>      MemoryDeviceInfoList *dimms =3D NULL;
> =20
>      /*
> @@ -582,25 +579,7 @@ static int spapr_dt_dynamic_reconfiguration_memory(S=
paprMachineState *spapr,
>          return ret;
>      }
> =20
> -    /* ibm,associativity-lookup-arrays */
> -    buf_len =3D (nr_nodes * 4 + 2) * sizeof(uint32_t);
> -    cur_index =3D int_buf =3D g_malloc0(buf_len);
> -    int_buf[0] =3D cpu_to_be32(nr_nodes);
> -    int_buf[1] =3D cpu_to_be32(4); /* Number of entries per associativit=
y list */
> -    cur_index +=3D 2;
> -    for (i =3D 0; i < nr_nodes; i++) {
> -        uint32_t associativity[] =3D {
> -            cpu_to_be32(0x0),
> -            cpu_to_be32(0x0),
> -            cpu_to_be32(0x0),
> -            cpu_to_be32(i)
> -        };
> -        memcpy(cur_index, associativity, sizeof(associativity));
> -        cur_index +=3D 4;
> -    }
> -    ret =3D fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", =
int_buf,
> -            (cur_index - int_buf) * sizeof(uint32_t));
> -    g_free(int_buf);
> +    ret =3D spapr_numa_write_assoc_lookup_arrays(spapr, fdt, offset);
> =20
>      return ret;
>  }
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index b8882d209e..9eb4bdbe80 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -75,6 +75,45 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, =
void *fdt,
>                         vcpu_assoc, sizeof(vcpu_assoc));
>  }
> =20
> +
> +int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void =
*fdt,
> +                                         int offset)
> +{
> +    MachineState *machine =3D MACHINE(spapr);
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    int nb_numa_nodes =3D machine->numa_state->num_nodes;
> +    int nr_nodes =3D nb_numa_nodes ? nb_numa_nodes : 1;
> +    uint32_t *int_buf, *cur_index, buf_len;
> +    int ret, i, j;
> +
> +    /* ibm,associativity-lookup-arrays */
> +    buf_len =3D (nr_nodes * MAX_DISTANCE_REF_POINTS + 2) * sizeof(uint32=
_t);
> +    cur_index =3D int_buf =3D g_malloc0(buf_len);
> +    int_buf[0] =3D cpu_to_be32(nr_nodes);
> +     /* Number of entries per associativity list */
> +    int_buf[1] =3D cpu_to_be32(MAX_DISTANCE_REF_POINTS);
> +    cur_index +=3D 2;
> +    for (i =3D 0; i < nr_nodes; i++) {
> +        /*
> +         * For the lookup-array we use the ibm,associativity array,
> +         * from numa_assoc_array. without the first element (size).
> +         */
> +        uint32_t associativity[MAX_DISTANCE_REF_POINTS];
> +
> +        for (j =3D 0; j < MAX_DISTANCE_REF_POINTS; j++) {
> +            associativity[j] =3D smc->numa_assoc_array[i][j + 1];
> +        }
> +
> +        memcpy(cur_index, associativity, sizeof(associativity));

AFAICT, you could just use a single memcpy() to copy from the
numa_assoc_array() into the property here, rather than using a loop
and temporary array.

> +        cur_index +=3D 4;

Shouldn't this be  +=3D MAX_DISTANCE_REF_POINTS?

> +    }
> +    ret =3D fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", =
int_buf,
> +                      (cur_index - int_buf) * sizeof(uint32_t));
> +    g_free(int_buf);
> +
> +    return ret;
> +}
> +
>  /*
>   * Helper that writes ibm,associativity-reference-points and
>   * max-associativity-domains in the RTAS pointed by @rtas
> diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
> index f92fb4f28a..f6127501a6 100644
> --- a/include/hw/ppc/spapr_numa.h
> +++ b/include/hw/ppc/spapr_numa.h
> @@ -22,6 +22,8 @@ void spapr_numa_write_associativity_dt(SpaprMachineStat=
e *spapr, void *fdt,
>                                         int offset, int nodeid);
>  int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>                              int offset, PowerPCCPU *cpu);
> +int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void =
*fdt,
> +                                         int offset);
> =20
> =20
>  #endif /* HW_SPAPR_NUMA_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QSCQACgkQbDjKyiDZ
s5JYlg/+N5M7zI3v19h2hL0EDaPOS91s2ypAltpPwR6ADkYrrPb5vEcSDUdnoA2t
OQaI5ugRNCyUruRxUfPeRTXNTj7+83s+MWX61zoMQliyBjaH526k91AhBQHJzzLa
PdMu6U1pUJMooIlMmmx8geU0XYGkqJ9YFRCJY9b96+pGK2ckWSNC2r17vcAH3AXQ
PQGDGXv1nIOjEbcr0CfZziMLp0EluzQa2clh9izh7EtjQF+6eMQDTm8DzZIMiljc
RwkkPp4jAJXF3mMGlURi3ZmmHb2oYwIDXxuqfr4A06htB71OcTitNRX8lTs5kAJG
Z9F36Co41cPwQ58BeQYAs26jBwhRBCqSbvS6P5GMmz3uPq/kGVoaueDi6j6JNstC
d2xQBURrjJrNRqFeLXRljjkxhdwx0Kr3UaWYl5P9QEWmk/0kyd3H8vztwB9AprbO
ACUOpsw1EIHJjyj+yjDZ5sMHwrGmhTkQBttQdn6CKONzR3ze1yJ1IGA7PDayQNdq
u26dgYD2b5uxIf2Sav1rzrU+jpFB8FtJSYBDOaJSIxxZis90sEmlsn3AyO/m3Rp+
v5XON61kS0UhEGjCDhYSqbeI7j17BtxgKU1nn2ZRPN8lNo+bQ7XmEZRoo9R0UYYY
aBH3Zc6ey2HcFw2gVmbZyaaMADouXYIYDOFf+DqrudCIq5cUMV4=
=pLjN
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--


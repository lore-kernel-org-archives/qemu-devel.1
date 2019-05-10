Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9E7C04AB1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8417A2182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 03:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oATcWBoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8417A2182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOvoC-0004JP-Pn
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 23:02:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjM-0000V6-6v
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOvjK-0001BF-Sc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 22:57:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51951 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOvjK-00019r-6x; Thu, 09 May 2019 22:57:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450ZdM58vzz9sP6; Fri, 10 May 2019 12:57:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557457063;
	bh=WBmjIuWXqGgGR5gxqGAKpovNHnhWLgUpnZfIHRhhCfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oATcWBoAV+itbZMTM8jVZwC2LHYRIDiK1hq2eK/6VloO3fpCa5vpU1rBJTyS0lB6k
	7Pinh7zklLOPMzOV2+Fw1Pszy0mAfbsC1S/Vhw6/UBRztKfrHhTXY5Koh96rX5mxRM
	pELZnZThfbz5O4wZBFmTQ6/kyPuPLziSXlSqPxKU=
Date: Fri, 10 May 2019 12:30:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190510023053.GD20559@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-9-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-9-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 08/13] target/ppc: Implement
 hcall H_SET_PARTITION_TABLE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:11PM +1000, Suraj Jitindar Singh wrote:
> The hcall H_SET_PARTITION_TABLE is used by a guest acting as a nested
> hypervisor to register the partition table entry for one of its guests
> with the real hypervisor.
>=20
> Implement this hcall for a spapr guest.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  hw/ppc/spapr_hcall.c   | 22 ++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  4 +++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4d7fe337a1..704ceff8e1 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1828,6 +1828,25 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, S=
paprMachineState *spapr,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_set_partition_table(PowerPCCPU *cpu,
> +                                          SpaprMachineState *spapr,
> +                                          target_ulong opcode,
> +                                          target_ulong *args)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    target_ulong ptcr =3D args[0];
> +
> +    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) =3D=3D 0) {
> +        return H_FUNCTION;
> +    }
> +
> +    if ((ptcr & PTCR_PATS) > 24)
> +        return H_PARAMETER;
> +
> +    env->spr[SPR_PTCR] =3D ptcr;
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1934,6 +1953,9 @@ static void hypercall_register_types(void)
> =20
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> =20
> +    /* Platform-specific hcalls used for nested HV KVM */
> +    spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_tabl=
e);
> +
>      /* Virtual Processor Home Node */
>      spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
>                               h_home_node_associativity);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 4251215908..e591ee0ba0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -501,7 +501,9 @@ struct SpaprMachineState {
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>  #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> +/* Platform-specific hcalls used for nested HV KVM */
> +#define H_SET_PARTITION_TABLE   0xF800

Urgh, vastly expanding the size of the kvmppc specific hcall table
here.  I guess that can't really be helped.

> +#define KVMPPC_HCALL_MAX        H_SET_PARTITION_TABLE
> =20
>  typedef struct SpaprDeviceTreeUpdateHeader {
>      uint32_t version_id;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzU4l0ACgkQbDjKyiDZ
s5IXMhAAxAZJv/an4HHUQGdokGunv7BYyMkZ34XkxAJMbtQXU5yDm7lZQWj11tBC
/f84CMr048JoBT9HyjnxYGsGnq0jggVxfNDk/E8LXJh0eHg1EHFByeI0TjIHO6QK
uORcwDt9+0mvmbHuwuEPQKDUlFjMKH9QFxHvCY8DOqhrYE2H9vqzxQR34grdnLX1
yMHpSmsqo4XRdvQcuQJ05JVkYyGMfXPXl5AWJvVkEXx6ktIjoNco3TPviKLFvfHU
7+c0osb9sR4S1MK7JSI1uqiTLl8sZvg/aAv5Xlk+awWvEPY+LicDF5jk6VGTeRGD
LCsHzDhrLZar17J3NJxgiS8Pa0p9Jovfpw6fSx3yuhlUzBJXvPTqKY6G/dRkcW9Z
V4g8ZhUnidWFSGW7zKv810IzAVU1fNayfiMPVtRNEUBU6/iMGiaFRhlESbrdOe2z
DmUwhPOYbJxl9hdpLkXbDsMT9clrJV0GIJfzVKmKRB06LPZWrt4ufVqfK6hS6aAJ
o+8I01Lu0OliJrDvd/tiGLlIXIGllfn+zq4EAYJXGv98TakN2NJeAlHo7VNI2R8u
FoDrmn/m5nHp4lelSFY1n8JJaNkZtIKYvdYcahdYSi1JbpOu2kjVQirtLKTxFpqo
dkpXsKSPdIq5Z2LMLBFAdCqgWowYafCU9AUzcmDqRqG//ihkNLA=
=3TJ7
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--


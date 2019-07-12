Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC93C742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A8D2084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Yfj1FQJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A8D2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlqQJ-0008Qc-Cb
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 03:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlqQ7-00080m-SO
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlqQ5-0003Kj-IE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 03:56:43 -0400
Received: from ozlabs.org ([203.11.71.1]:55617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlqQ2-00031M-QM; Fri, 12 Jul 2019 03:56:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lQGy03jWz9sBt; Fri, 12 Jul 2019 17:56:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562918186;
 bh=dVPIone1Y8eo4U070HfMNUfZc/es7yXi1ej8jegO3k4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yfj1FQJC5MNZLTpdnZcvxxvQSBexukQ1JcK1I0vWmBkCdUZVgUPS4u039R/6okqc7
 Su20bfwggs9ptNLYiblsdZBq2p/BBvJ2u904HBH0ZvD7n9Q7vDDXv9M/HuKW1vgVO7
 0kYwnkWnydo0DSFKPhh7591l8pAQ8ioyDvRzqwfE=
Date: Fri, 12 Jul 2019 16:48:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190712064819.GI2561@umbus.fritz.box>
References: <20190711194702.26598-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Content-Disposition: inline
In-Reply-To: <20190711194702.26598-1-maxiwell@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2] migration: Do not re-read the clock on
 pre_save in case of paused guest
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2019 at 04:47:02PM -0300, Maxiwell S. Garcia wrote:
> Re-read the timebase before migrate was ported from x86 commit:
>    6053a86fe7bd: kvmclock: reduce kvmclock difference on migration
>=20
> The clock move makes the guest knows about the paused time between
> the stop and migrate commands. This is an issue in an already-paused
> VM because some side effects, like process stalls, could happen
> after migration.
>=20
> So, this patch checks the runstate of guest in the pre_save handler and
> do not re-reads the timebase in case of paused state (cold migration).
>=20
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>

I've applied this to ppc-for-4.2.  I think it probably is a correct
fix, but this could have subtle impacts on things that are mostly
working at the moment, so I don't want to risk it during hard freeze.

> ---
>  hw/ppc/ppc.c         | 13 +++++++++----
>  target/ppc/cpu-qom.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index a9e508c496..8572e45274 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -1008,6 +1008,8 @@ static void timebase_save(PPCTimebase *tb)
>       * there is no need to update it from KVM here
>       */
>      tb->guest_timebase =3D ticks + first_ppc_cpu->env.tb_env->tb_offset;
> +
> +    tb->runstate_paused =3D runstate_check(RUN_STATE_PAUSED);
>  }
> =20
>  static void timebase_load(PPCTimebase *tb)
> @@ -1051,9 +1053,9 @@ void cpu_ppc_clock_vm_state_change(void *opaque, in=
t running,
>  }
> =20
>  /*
> - * When migrating, read the clock just before migration,
> - * so that the guest clock counts during the events
> - * between:
> + * When migrating a running guest, read the clock just
> + * before migration, so that the guest clock counts
> + * during the events between:
>   *
>   *  * vm_stop()
>   *  *
> @@ -1068,7 +1070,10 @@ static int timebase_pre_save(void *opaque)
>  {
>      PPCTimebase *tb =3D opaque;
> =20
> -    timebase_save(tb);
> +    /* guest_timebase won't be overridden in case of paused guest */
> +    if (!tb->runstate_paused) {
> +        timebase_save(tb);
> +    }
> =20
>      return 0;
>  }
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index be9b4c30c3..5fbcdee9c9 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -201,6 +201,7 @@ typedef struct PowerPCCPUClass {
>  typedef struct PPCTimebase {
>      uint64_t guest_timebase;
>      int64_t time_of_the_day_ns;
> +    bool runstate_paused;
>  } PPCTimebase;
> =20
>  extern const struct VMStateDescription vmstate_ppc_timebase;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0oLTIACgkQbDjKyiDZ
s5KnmxAAl0vergGvnPKmM4Ymb97RF/wERk+vlfkGLWj7rfO4xJLLRciUehKwuIeb
lQJmxAaLvfhhqi7+SiCojdBrQRQfmF5J2xeiW1CLaA2YIHcwbHiphlsYF02YRtJ/
wcMbR7KULOpUo6zvCFh61Nsgs3/7VZ0dkWOHKWjCMw9xGeYc1pCYbEOk+EVrxEvS
9/7xY3y3pRZijH5CrDvmdMTLIVAHGOOYTh8Y9GHWg2n2HaokiwvBi0PCKSj6CUCd
QakAezWWFIqIoLuu5JO8qOamoQTzWhrFBJXbssQa+TPkzHkeppLhzl45FeX22uJp
Tx1Ic+RGQP+z0kYBNz2693VAp+6nhm6DxD8D1KpK1BMVHNMuJyl7/LvAD8UpXTMB
zDDIClcYCVuBGeVF5ns/RfNgpv2/BLTXUIyb5C3UojMppgqNYEvvXRKUn9xKuDKd
m0NjV8A4Soh7Ko0ZO9WiVsT8IagRz7G0b+PyFj+CYo8iRGEeIC0S10JNdp/51xjZ
VxZFJt5fMgQQr7hMZf5LPPnvXTAZjc8ljnO1wvoCSnUH/GtApr/bRoG/lYOyVJ9w
RfJUJbJQM4lv5yYUAXiMEVJ5qy+l8+1igm1qnT7S8C8A2y8aAH62hJBv4dHiVm9W
duNSnrNPFlxg+/rd3qARuRLDJTtnD8O5frFqbX6UBsgiTeTNgSY=
=E9KU
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--


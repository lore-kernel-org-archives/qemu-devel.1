Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7DBC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F5820733
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 23:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UylwImc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F5820733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ485-0007Eq-Lz
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 19:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ46h-0006dR-6b
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jJ46f-0007rs-Lc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 19:46:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54781 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jJ46e-0007Jb-JI; Mon, 30 Mar 2020 19:46:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48rpxl1KB5z9sSJ; Tue, 31 Mar 2020 10:46:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585611963;
 bh=Vj9hmA8Wi41+4MOxbqXt+IkI8gSCzBXepvqTnjthiSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UylwImc95eDZRqENB+4oCEYlAbBx/b0DK4AYGtv6aSiGSCQ0aMmyxCdvka3kF6WB/
 QJN8mn3LibNjd1fMg0bB+K+DH/zP3tyY1rqTT14caH55A0UeprqHWst2o5MLzzwKx3
 r7vn3Hw7WewbCqb6JD0JC0+F/0yHdy1cuNpHGsik=
Date: Tue, 31 Mar 2020 10:41:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.0] hw/ppc/ppc440_uc.c: Remove incorrect iothread
 locking from dcr_write_pcie()
Message-ID: <20200330234112.GA47772@umbus.fritz.box>
References: <20200330125228.24994-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20200330125228.24994-1-peter.maydell@linaro.org>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 01:52:28PM +0100, Peter Maydell wrote:
> In dcr_write_pcie() we take the iothread lock around a call to
> pcie_host_mmcfg_udpate().  This is an incorrect attempt to deal with
> the bug fixed in commit 235352ee6e73d7716, where we were not taking
> the iothread lock before calling device dcr read/write functions.
> (It's not sufficient locking, because although the other cases in the
> switch statement won't assert, there is no locking which prevents
> multiple guest CPUs from trying to access the PPC460EXPCIEState
> struct at the same time and corrupting data.)
>=20
> Unfortunately with commit 235352ee6e73d7716 we are now trying
> to recursively take the iothread lock, which will assert:
>=20
>   $ qemu-system-ppc -M sam460ex --display none
>   **
>   ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1830:qemu_mute=
x_lock_iothread_impl: assertion failed: (!qemu_mutex_iothread_locked())
>   Aborted (core dumped)
>=20
> Remove the locking within dcr_write_pcie().
>=20
> Fixes: 235352ee6e73d7716
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I did a grep of hw/ppc and didn't see anything else that was doing
> its own locking inside a dcr read/write fn.
> ---

Applied to ppc-for-5.0, thanks.

>  hw/ppc/ppc440_uc.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index d5ea962249f..b30e093cbb0 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -13,7 +13,6 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> -#include "qemu/main-loop.h"
>  #include "qemu/module.h"
>  #include "cpu.h"
>  #include "hw/irq.h"
> @@ -1183,9 +1182,7 @@ static void dcr_write_pcie(void *opaque, int dcrn, =
uint32_t val)
>      case PEGPL_CFGMSK:
>          s->cfg_mask =3D val;
>          size =3D ~(val & 0xfffffffe) + 1;
> -        qemu_mutex_lock_iothread();
>          pcie_host_mmcfg_update(PCIE_HOST_BRIDGE(s), val & 1, s->cfg_base=
, size);
> -        qemu_mutex_unlock_iothread();
>          break;
>      case PEGPL_MSGBAH:
>          s->msg_base =3D ((uint64_t)val << 32) | (s->msg_base & 0xfffffff=
f);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Cg5UACgkQbDjKyiDZ
s5IrvA/9GZmbCx2dnnyUkxMUbZy6MmaiaFOhSD0rb4K2s+Jem1BgPNu0ZWpMQOwb
io7PYQI+pAJ0/ppvrqdvoHPQ3Jl5efXXvRoKl+RQ4aFym61wuXQlhjT18K7rPatv
h3yk0uxNDS6p3zJDCxCuaWtrRfCs2oci3Hkychjuztfz1Zx9kWv/3xWBbvOOwyWe
oQ+DDzfbHpwZGEP7ltdoMEp1KlXlrxTqFlach5IIe8lxzUEHEAIGKSmgsZbKHBv3
Q/czg/jXMaFvTdPkdez6AeDXR9D9MbXEjNdhV0/bKvY26EwwvHQ9C8AAxNZ4db+7
C5zaPwu9y30lXI8qV/4nX+JtNGjEKHx1CFwSUTwiBw4UxJfqyI4GBi8VkPYgaZ7Q
mOIS/PFQofVoOkf9CRUfzN5ou6NOg0w0GajXaZXpbu9etyMQ+pCdU4tgtvdLsTGC
nNbk7UzHUBXLCW9XJOAVmLPAD69D/Z8a0z5EHJVWSOp/4uzxD9vk6f1o8Oc35qcX
k0wy/00qNYg6qhTQfgd2lR8NLdtmURoT9dgS03caTfxVelQE6a03GOLtjndsJ/RD
XKTBOvcheDF9hXnwGrQXTAAmYTJPLJQs44IJcQDf07KisSNp59uLsb3oHl3w4IqV
PeWUUM+ljv1GbEQLJ9b4KmNl1hK+V6mUZTLCcq34JsgrA0sHCfY=
=BqYG
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA428C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBB02146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="INy06ubt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBB02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihQ58-0005Wq-74
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ihQ3e-000475-23
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ihQ3c-0005S8-RL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:31:30 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:60243 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ihQ3a-0005N1-OJ; Tue, 17 Dec 2019 22:31:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47d0sk59Jxz9sS3; Wed, 18 Dec 2019 14:31:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576639882;
 bh=UPv3C9EtJxOYHbL7no6TBGRBeicxu1y3iMAGE332nV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=INy06ubtXJAIlePRmgH74trC0+V1kkEnAfr05zSr7f0+3ITwkHBw333fkRATijWAM
 L0QzKm+dIUBGFmR7wrMMXY8MN1MlRlxltGYgSNnL1HMHY3+I3tG2JmnUqPhe+tM7gU
 HS/AhiZOWqtcpr+M4hIOGB8TyfT1zLBEj+suJgik=
Date: Wed, 18 Dec 2019 13:59:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Remove unused PPC_INPUT_INT defines
Message-ID: <20191218025951.GO6242@umbus.fritz.box>
References: <20191218014616.686124-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HxQt9wRz9wbL5Edg"
Content-Disposition: inline
In-Reply-To: <20191218014616.686124-1-farosas@linux.ibm.com>
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


--HxQt9wRz9wbL5Edg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 10:46:16PM -0300, Fabiano Rosas wrote:
> They were added in "16415335be Use correct input constant" with a
> single use in kvm_arch_pre_run but that function's implementation was
> removed by "1e8f51e856 ppc: remove idle_timer logic".
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

Applied to ppc-for-5.0, thanks.

> ---
>  target/ppc/kvm.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7406d18945..b19555e97e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1325,12 +1325,6 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq,=
 int level)
>      return 0;
>  }
> =20
> -#if defined(TARGET_PPC64)
> -#define PPC_INPUT_INT PPC970_INPUT_INT
> -#else
> -#define PPC_INPUT_INT PPC6xx_INPUT_INT
> -#endif
> -
>  void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>  {
>      return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HxQt9wRz9wbL5Edg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl35liUACgkQbDjKyiDZ
s5KCFxAAqgVGOw7Nj1Gyngt5G/lJdA0b3OKWaopDMy+Pbui8puQF3/gWu+zeCY8N
hNFr94gKIdvOmmb75shKAIP0fWJP4ZaQLzXowhHdMC24uKymkRkjArc2GPzVxkqZ
Zg8nVBl37gHy+GDk0Jal2bZcs8Lbl9ETxPRa7Zfblrr5HW+WFvdK4NVNrY0E0A1t
OS1/deobtLSi5ZxHexH2PfEae8A3Uqt2IGe5n+3hXHkj6tumIvkwZXuDBjAJrtU4
5IgG+N7kYgHCvrsFzI//VboJQUWcWi6MpbfdpPSOpRzxabGct/XnY2AWydBHeX3Q
SrPQvZkC9l4it0zyMDFGGkYPX7zJypIypHC6i/in8zSHctBycm/4jMp9+mGAqmN3
kxAOiehGSBA93om57Ng0KvMpjmuakzkUUFMKhdN5DzRXpvTjhyBUPkWpsk2shGcS
xGt3FOw4d8+hETbSfdOQCooJ2sDDfLXjre6NYfHF2GxlqI3GVIuCxmCjVqlWBpvz
79d5NwojrXpXWeAKImcShNBQ+7dCjReOP1PG3jjOyOGG2xvoO+UA0AHuLGXAq7QH
y48EaxXnxFqIeJQCYDPLsEPUn4EslJwzDg7SBNOqTvoPjTFoMB9uWde6ynv7zZ7w
aH7djtyIP2ALU4RleLeeH5it1qMdjIeNM9cOJVOs8YYEsqEOZ7g=
=k2iM
-----END PGP SIGNATURE-----

--HxQt9wRz9wbL5Edg--


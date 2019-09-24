Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027ECC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31FE214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dGYHUXW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31FE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCldY-0003Ox-8S
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iCkqX-00072s-3y
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iCkqU-0000tI-Vi
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:27:12 -0400
Received: from ozlabs.org ([203.11.71.1]:34151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iCkqT-0000sA-O4; Tue, 24 Sep 2019 09:27:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46d26K0jQpz9sNF; Tue, 24 Sep 2019 23:27:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569331625;
 bh=T23ROiABDOWmOiOQpgIeYfIGI6vYcq4OXKmzZbrwkwc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dGYHUXW1FE+4d6if//nkYBEOqNZZ+JzGhoBYBBmcKV5XdvV+LbEpA10Ks1Qp2e6s9
 ISZPoJ6qUtEqZK1YplJZwkIa1DZ7/cly0Ts39tTMLA/atD1/tAgCNUTUPeTljk05hl
 R7GGmavxTUIJcavqwh2xtudWhV/qfCJSt6Yy0bjA=
Date: Tue, 24 Sep 2019 23:18:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] ppc/kvm: Skip writing DPDES back when in run time
 state
Message-ID: <20190924131836.GD17405@umbus>
References: <20190923084110.34643-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <20190923084110.34643-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 06:41:10PM +1000, Alexey Kardashevskiy wrote:
> On POWER8 systems the Directed Privileged Door-bell Exception State
> register (DPDES) stores doorbell pending status, one bit per a thread
> of a core, set by "msgsndp" instruction. The register is shared among
> threads of the same core and KVM on POWER9 emulates it in a similar way
> (POWER9 does not have DPDES).
>=20
> DPDES is shared but QEMU assumes all SPRs are per thread so the only safe
> way to write DPDES back to VCPU before running a guest is doing so
> while all threads are pulled out of the guest so DPDES cannot change.
> There is only one situation when this condition is met: incoming migration
> when all threads are stopped. Otherwise any QEMU HMP/QMP command causing
> kvm_arch_put_registers() (for example printing registers or dumping memor=
y)
> can clobber DPDES in a race with other vcpu threads.
>=20
> This changes DPDES handling so it is not written to KVM at runtime.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-4.2, thanks.

> ---
>  target/ppc/kvm.c                | 5 +++++
>  target/ppc/translate_init.inc.c | 9 ++++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8c5b1f25cc95..820724cc7d15 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -993,6 +993,10 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          }
> =20
>          kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &env->tb_env->tb_offs=
et);
> +
> +        if (level > KVM_PUT_RUNTIME_STATE) {
> +            kvm_put_one_spr(cs, KVM_REG_PPC_DPDES, SPR_DPDES);
> +        }
>  #endif /* TARGET_PPC64 */
>      }
> =20
> @@ -1297,6 +1301,7 @@ int kvm_arch_get_registers(CPUState *cs)
>          }
> =20
>          kvm_get_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &env->tb_env->tb_offs=
et);
> +        kvm_get_one_spr(cs, KVM_REG_PPC_DPDES, SPR_DPDES);
>  #endif
>      }
> =20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 0fb11c7ac6da..ba726dec4d00 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8200,11 +8200,10 @@ static void gen_spr_power8_dpdes(CPUPPCState *env)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      /* Directed Privileged Door-bell Exception State, used for IPI */
> -    spr_register_kvm_hv(env, SPR_DPDES, "DPDES",
> -                        SPR_NOACCESS, SPR_NOACCESS,
> -                        &spr_read_generic, SPR_NOACCESS,
> -                        &spr_read_generic, &spr_write_generic,
> -                        KVM_REG_PPC_DPDES, 0x00000000);
> +    spr_register(env, SPR_DPDES, "DPDES",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, SPR_NOACCESS,
> +                 0x00000000);
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2KF6kACgkQbDjKyiDZ
s5Kg0w//SnRk0IJmHuyOA6R8y4pqGXSO+qKvn5dUeYUki3FQKgYuuGDnQeCT7IB8
onl2htYlFsx24e6uQVqPIsiS8b/NnqqqalrIrioYs4oTkFRZuYhA2frAujzkIR8/
cs6Jdxvhhm5ZZUO54T2vL+5j387k0hkJzEGN961yPsccmomksZjwRn5aMJqoCkyM
f5yCOaev13coarGV+S119JqMRJPtZt0ZyVhCIbnzanwJRenu4ncdc1U1Z1BQ+BnV
7yOlsNgdWyaY+CUKTgZbkNuCOXH06AJDr9CP3aHK8PsPEuk4khdlQtiHkWYMsJ5O
/CSkK5qaHejRe+0sHv63sgRYzLtYG5vCidxlpqBV/nm6Cbq6PZHoBNRZfiF/I5hq
bwzxK0Y+TXFFAqlBFBwKLO7iBnPv1OJzlN46w5b2yu/cBCSwJ+VEfXrPpneewOCk
oW2Naqjrx+kp4SWBcVBuKA9lH6AO2ORXb+JPGB9A9y66I+O+6QrHQ+VyEfjshQ2f
v/V2abVzbhN6z5fy7WxZGHY4RZFQDaAbWAjlUMMAV8EQpKbulTZK18alnsiKT+Wj
TL+b9wOokx9r6iAVk/aawFdX/tBzfNcnzOZi4FtCUKVAB7KmuEXZWrYyar3oBTjy
FbhCDqmXNTb2ohbCtqwvmxVl3O8z2QXyFaNEi0PDWFp4XFsbWo0=
=PfQn
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--


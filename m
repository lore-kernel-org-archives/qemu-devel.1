Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA149C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9238320659
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aphceDyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9238320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnjuv-0002Cb-K2
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnjuj-0001ht-Ie
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnjug-0000Hl-Gk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:24:09 -0400
Received: from ozlabs.org ([203.11.71.1]:54025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnjud-00006z-Pd; Wed, 17 Jul 2019 09:24:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pdJG31kwz9sDB; Wed, 17 Jul 2019 23:23:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563369822;
 bh=WTNV/IQBTZ9yT85QOrEPtbwfMFFiKrgTRU3cXr8ruuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aphceDyt01FwUdDgXZJ7+qCz7R5rB6MrtiCrDvKBSWwLwx3USyQFrWblDXvuXbUyl
 k5xUGZZ2H6J0WJjZsg/mDMMaiEqN3WBqoUp5f8PLrs3nry63moWvRYivA7WmBNHSS0
 eKAiNbdaq5B2Qgahrt/re3G7bGiPtW1JyjozV9OI=
Date: Wed, 17 Jul 2019 21:48:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190717114854.GA8468@umbus.fritz.box>
References: <20190717054655.14104-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20190717054655.14104-1-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH] Implement qemu_thread_yield for posix,
 use it in mttcg to handle EXCP_YIELD
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:46:55PM +1000, Nicholas Piggin wrote:
> This is a bit of proof of concept in case mttcg becomes more important
> yield could be handled like this. You can have by accident or deliberately
> force vCPUs onto the same physical CPU and cause inversion issues when the
> lock holder was preempted by the waiter. This is lightly tested but not
> to the point of measuring performance difference.
>=20
> I really consider the previous confer/prod patches more important just to
> provide a more complete guest environment and better test coverage, than
> performance, but maybe someone wants to persue this.
>=20
> Thanks,
> Nick
> ---
>  cpus.c                   |  6 ++++++
>  hw/ppc/spapr_hcall.c     | 14 +++++++-------
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c |  5 +++++
>  util/qemu-thread-win32.c |  4 ++++
>  5 files changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/cpus.c b/cpus.c
> index 927a00aa90..f036e062d9 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1760,6 +1760,12 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
>                  qemu_mutex_unlock_iothread();
>                  cpu_exec_step_atomic(cpu);
>                  qemu_mutex_lock_iothread();
> +                break;
> +            case EXCP_YIELD:
> +                qemu_mutex_unlock_iothread();
> +                qemu_thread_yield();
> +                qemu_mutex_lock_iothread();
> +                break;
>              default:
>                  /* Ignore everything else? */
>                  break;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57c1ee0fe1..9c24a64dfe 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1162,13 +1162,13 @@ static target_ulong h_confer(PowerPCCPU *cpu, Spa=
prMachineState *spapr,
>              return H_SUCCESS;
>          }
> =20
> -        /*
> -         * The targeted confer does not do anything special beyond yield=
ing
> -         * the current vCPU, but even this should be better than nothing.
> -         * At least for single-threaded tcg, it gives the target a chanc=
e to
> -         * run before we run again. Multi-threaded tcg does not really do
> -         * anything with EXCP_YIELD yet.
> -         */
> +       /*
> +        * The targeted confer does not do anything special beyond yieldi=
ng
> +        * the current vCPU, but even this should be better than nothing.
> +        * For single-threaded tcg, it gives the target a chance to run
> +        * before we run again, multi-threaded tcg will yield the CPU to
> +        * another vCPU.
> +        */

Uh.. this looks like a whitespace fixup leaked in from your other patches.

>      }
> =20
>      cs->exception_index =3D EXCP_YIELD;
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 55d83a907c..8525b0a70a 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -160,6 +160,7 @@ void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  void qemu_thread_exit(void *retval);
>  void qemu_thread_naming(bool enable);
> +void qemu_thread_yield(void);
> =20
>  struct Notifier;
>  /**
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 1bf5e65dea..91b12a1082 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -573,3 +573,8 @@ void *qemu_thread_join(QemuThread *thread)
>      }
>      return ret;
>  }
> +
> +void qemu_thread_yield(void)
> +{
> +    pthread_yield();
> +}
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 572f88535d..72fe406bef 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -442,3 +442,7 @@ bool qemu_thread_is_self(QemuThread *thread)
>  {
>      return GetCurrentThreadId() =3D=3D thread->tid;
>  }
> +
> +void qemu_thread_yield(void)
> +{
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0vCyQACgkQbDjKyiDZ
s5KhnBAAzQam8G/fRlMgDHLeAtWJajb1fc5HemVbXPLBVMvxyg5tDbYqG0Z+mwM8
a91iwmMcbw6fj7pPau+fI2iRHrpEyhdjWF0J+MxjfVRD2QSmiWHdnxpuvtrZu4nP
AtUi5mS3AsVy5wKI5SKgq4AQETTRRf04XkBSNOEQN4+IXrJxguYUW6s0xaljGgwf
R2LORV3lHTUhFkl/dlh67U5M48hghHfp+ZcnnrV3N291aVvt0oeFT6hIcyAfjbg7
jeNlQn4Em4O69K5u/PclPxoq418K95lBSOYS6Tp2A5zyGIHAe85OLrQZzbAmnDpP
QwP32shAmGjgFcgj8lxn9Ez22h83vditHavZ4oVYbYdYEfAKcejTRMU8zFbxJjas
Fz2267cCaNSVufcp+2NMAv7rXC5mctJ9yYNSAdzSB9IWF7b1aSnV7NMbSDkGf/3g
mqKqdwPv18Q0A/sZJ839pn/Xlmjztv2/SgcTKNL7a0s1VeCcp6JeaKvPJTO2yTIw
qzg//qOEPAA+fqd5VE/JkAtsTAiwBXPHRZfV2LNubnDLST975C5JyxaI8vmKynZA
0TL/iPK5HQdLEDS3i2DWuFRsXwDORz+TdFMNIHfz9y3DwA0ZX06WDlA7FguG6C2C
pg5maOZidpKjgR6nFiszHfH4DxKkzkY+26iB/aQDNBEMgkVLHTU=
=BCao
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


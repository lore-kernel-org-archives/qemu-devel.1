Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044AC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A9820724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 06:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bHXIiHZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A9820724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEoUD-0000H5-P0
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 02:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jEoTT-000868-NC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jEoTS-0004FZ-6O
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 02:16:11 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jEoTR-0004AX-6q; Thu, 19 Mar 2020 02:16:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48jc9K0L5lz9sRY; Thu, 19 Mar 2020 17:16:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584598565;
 bh=1kJa1h1Pk6NFiplL8k2R/HLr6Dj2e+3d0d8zSMPJIFM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bHXIiHZlwZ+FXpibB0MHJ1V3ziL4KutA1qMYB1NDJgMDsokJQwfJsx25/ANQMf9Vt
 hmJjrZNjTKDoHit8h/m6KNp2ZSkpKlvA0GJAnwIyjH1f1SdRALYpQHa41jVKxTbYT+
 R3am4XlJLjWT1ZldnGo9d/ZACPKKxrnj0gKl9U6A=
Date: Thu, 19 Mar 2020 16:35:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Vincent Fazio <vfazio@xes-inc.com>
Subject: Re: [PATCH v2 1/1] target/ppc: don't byte swap ELFv2 signal handler
Message-ID: <20200319053513.GH628315@umbus.fritz.box>
References: <20200318170116.1922-1-vfazio@xes-inc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <20200318170116.1922-1-vfazio@xes-inc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Vincent Fazio <vfazio@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 12:01:16PM -0500, Vincent Fazio wrote:
> From: Vincent Fazio <vfazio@gmail.com>
>=20
> Previously, the signal handler would be byte swapped if the target and
> host CPU used different endianness. This would cause a SIGSEGV when
> attempting to translate the opcode pointed to by the swapped address.
>=20
>  Thread 1 "qemu-ppc64" received signal SIGSEGV, Segmentation fault.
>  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/includ=
e/qemu/bswap.h:351
>  351        __builtin_memcpy(&r, ptr, sizeof(r));
>=20
>  #0  0x00000000600a9257 in ldl_he_p (ptr=3D0x4c2c061000000000) at qemu/in=
clude/qemu/bswap.h:351
>  #1  0x00000000600a92fe in ldl_be_p (ptr=3D0x4c2c061000000000) at qemu/in=
clude/qemu/bswap.h:449
>  #2  0x00000000600c0790 in translator_ldl_swap at qemu/include/exec/trans=
lator.h:201
>  #3  0x000000006011c1ab in ppc_tr_translate_insn at qemu/target/ppc/trans=
late.c:7856
>  #4  0x000000006005ae70 in translator_loop at qemu/accel/tcg/translator.c=
:102
>=20
> Now, no swap is performed and execution continues properly.

Patch is good, but the message still needs some work.  It should point
out that the necessary swap is already done at sigaction() time by the
__get_user().

>=20
> Signed-off-by: Vincent Fazio <vfazio@gmail.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
> Changes since v1:
> - Drop host/target endianness callouts
> - Drop unnecessary pointer cast
> - Clarify commit message
>=20
>  linux-user/ppc/signal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
> index 5b82af6cb6..b8613c5e1b 100644
> --- a/linux-user/ppc/signal.c
> +++ b/linux-user/ppc/signal.c
> @@ -567,10 +567,8 @@ void setup_rt_frame(int sig, struct target_sigaction=
 *ka,
>          env->nip =3D tswapl(handler->entry);
>          env->gpr[2] =3D tswapl(handler->toc);
>      } else {
> -        /* ELFv2 PPC64 function pointers are entry points, but R12
> -         * must also be set */
> -        env->nip =3D tswapl((target_ulong) ka->_sa_handler);
> -        env->gpr[12] =3D env->nip;
> +        /* ELFv2 PPC64 function pointers are entry points. R12 must also=
 be set. */
> +        env->gpr[12] =3D env->nip =3D ka->_sa_handler;
>      }
>  #else
>      env->nip =3D (target_ulong) ka->_sa_handler;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5zBI4ACgkQbDjKyiDZ
s5I/9hAA2uxLh3c3Dckg4o1lHXcf3bkxiRDVC7Us+yuddW9yRjOln91jcKITAlJp
8+i0/DMQOzw/0bquQzJ28gWpm9om3yylvdrVe0OTx2/UCVUdmWPwEE5J+EWrsPeD
8lp+6lB38hXUxl0NzU4ifS8+9LVXc01tYaiSwd382wNswUlELjPQPo+zRdp9Kba/
DrK41tB/9Daa6OZ8yf8h57owrAYfcbSuF86px47BfvBFgS/lswmEQ1xn9lrwYjAJ
G8IKf3Z+ZqsEREqcESbKNYXPIPu9uV9YfGtJxTUdZeuUQqoLIbHXouslLVXAJbK7
6jz1u4f+2Z/K9rVXEm+7W26sgXm4ppJD5HyIZGUTxfrPaFl6IsccvgM7sUG7XyXA
zCkJnj93FfNBZjvxkKVnkme1rTJKTp7kCApX5xhZvg+RFF4dNFi2afXeVIdP86GB
GUZXK5lkQxaAqV0Jzs2yaPUMIc4A4s6vGDgwVT3azrr+6JfE2vKH4Huy1IYmlzh3
S6Ow07NdsWQZG8L28Xyf5N8rqK/FnJj1p3sUfPpgh4GhJ6zK6PDCHuRJUjKMN0SO
ChLQ48etQT5Q9mmXynzET7FtyNHBJiOTjhVYTUVpTsm676x2LLsWqb6joJ7/a3uS
wwqPwLOYKn+AvLUs+FMuvoF9qlMgDQc0L57o7OyLUhskfaoYpVg=
=YjmD
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--


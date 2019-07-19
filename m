Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CC4C76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 14:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F5A217F5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WjId3KOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F5A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoq2A-0000q0-C6
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 10:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hoq1g-0007Sl-RX
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 10:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hoq1f-0002hd-KZ
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 10:07:52 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55119 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hoq1c-0002Yk-7U; Sat, 20 Jul 2019 10:07:49 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45rV7Z1347z9sND; Sun, 21 Jul 2019 00:07:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563631658;
 bh=h5M4InZyFVSUm5hrtlnO0lyZF/37ZLdE0Icb09Gw9wg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WjId3KOlfDiee67qxTNAsw1mv/rmdkBLu4LRsvHAXfaiZmjXQ0aWhiYQg3/o5H7Uf
 i7yF7FkyQ8tgKtTsBU/WkU9A5a6eqfoi4ZpTUckK/zF6g9WP7uj8yzVxnVWqSQwmI8
 SN1zKM+8MeCUusIYuMdGAt6W6H8peWZONer/aodk=
Date: Sat, 20 Jul 2019 00:20:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190719142013.GA4174@umbus.fritz.box>
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20190719131425.10835-6-philmd@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH-for-4.1? 5/7] target/ppc: Rewrite a fall
 through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 03:14:23PM +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=3D2:
>=20
>   target/ppc/mmu_helper.c: In function =E2=80=98dump_mmu=E2=80=99:
>   target/ppc/mmu_helper.c:1349:12: error: this statement may fall through=
 [-Werror=3Dimplicit-fallthrough=3D]
>    1349 |         if (ppc64_v3_radix(env_archcpu(env))) {
>         |            ^
>   target/ppc/mmu_helper.c:1356:5: note: here
>    1356 |     default:
>         |     ^~~~~~~
>   cc1: all warnings being treated as errors
>=20
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.
>=20
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/mmu_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 261a8fe707..862824b073 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -98,7 +98,7 @@ static int pp_check(int key, int pp, int nx)
>          case 0x1:
>          case 0x2:
>              access |=3D PAGE_WRITE;
> -            /* No break here */
> +            /* fall through */
>          case 0x3:
>              access |=3D PAGE_READ;
>              break;
> @@ -706,7 +706,7 @@ static int mmu40x_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>              if (pr !=3D 0) {
>                  goto check_perms;
>              }
> -            /* No break here */
> +            /* fall through */
>          case 0x3:
>              /* All accesses granted */
>              ctx->prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> @@ -720,7 +720,7 @@ static int mmu40x_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>                  ret =3D -2;
>                  break;
>              }
> -            /* No break here */
> +            /* fall through */
>          case 0x1:
>          check_perms:
>              /* Check from TLB entry */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0x0ZsACgkQbDjKyiDZ
s5KbeA//eNhI6t5lEAiabvUksdMjLfEN2Wfj0pCqo8uqOsZXrtx8z/zuMTtn47MS
2PaBZrNI0iZepxb8j8Atw3zTKxj8QWmKhJWvMYRiWh3eVGgZcY8re3fw1irGzxIB
lWMxE7eU63aekd/pRhXV67MxSZ+eNlPnsuN1LJ33rVfdRrlCOjhFdfsO4YxdGXU7
8WobfNztR1Zi6Jhcy8R7RBeM9Inc5LvxFLoAUNCqN/WPhVqNUuIBn3XR1AHQ85tS
I5lEk5lUQ2nRUzP0lTOPUn9vLid3HrsjankXvE6k0aRwtkdLi5TfTrbzNYPJcwmN
ey7MKdB7rW4tUnc/Yupa1RfBBTtGRAwSncQBPg3Xqk8Jntc9Bae6JlN7JJvbHJ79
iy8XhyCXMMq5dpZHRrYCL91iMiwwIvD/erc9JMtWincjPpesj2AMtOrHVY9KNg4H
37RSw1jFGo3ZiNA/dE/My07h4T1+sOMpJzWhefX1psrreDFoapfrqxNYJAYxRCYp
gz5X5sxM3flGY3x8BCnigAIMDSB6JiQYgrfWKE2dhzpIk8SWEYY+f0uKDZFYpYq2
6RgtYHY7YcgBoWwIaC/kNh9ZcYnL5QQkv0LVDq4a/5eiulI4uERyA8nuridXZWpu
/2sMO//j0xiS5X7sqHV7z5oE3X/STLstZqPCB8ep2JB0mlfJjD0=
=PRvI
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


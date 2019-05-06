Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2186C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD9F2087F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MAhZ34Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD9F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNXVh-0001Bv-VI
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 02:54:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRg-0005Od-22
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRe-00067h-Tj
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNXRd-00064Y-Gs; Mon, 06 May 2019 02:49:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yCyv2rPyz9sB8; Mon,  6 May 2019 16:49:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557125383;
	bh=vrAqGnCrBjXP7KOKtIiyulQcnHHCtBGcFb21fHSQS3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAhZ34LysdwR6AjqwIbmQ10oIWQ/PlQiqBaeLXeiXIzOAa5RV4o8ljJKiFk/liAoN
	EpUvpkSReRGT7q4Mf5q1t5iCdFQq/K6jhVJ0dePLDC0eO3ghcjyAX3THB72qgYV33G
	AY2VbNBSXrvYEfJAWdb0Y4AAVOGgaik8fjsyce2I=
Date: Mon, 6 May 2019 16:16:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190506061643.GI6790@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
	<20190503055316.6441-4-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-4-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 03/13] target/ppc: Add SPR ASDR
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


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:06PM +1000, Suraj Jitindar Singh wrote:
> The Access Segment Descriptor Register (ASDR) provides information about
> the storage element when taking a hypervisor storage interrupt. When
> performing nested radix address translation, this is normally the guest
> real address. This register is present on POWER9 processors and later.
>=20
> Implement the ADSR, note read and write access is limited to the
> hypervisor.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h                | 1 +
>  target/ppc/translate_init.inc.c | 6 ++++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 19b3e1de0e..8d66265e5a 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1797,6 +1797,7 @@ void ppc_compat_add_property(Object *obj, const cha=
r *name,
>  #define SPR_MPC_MD_DBRAM1     (0x32A)
>  #define SPR_RCPU_L2U_RA3      (0x32B)
>  #define SPR_TAR               (0x32F)
> +#define SPR_ASDR              (0x330)
>  #define SPR_IC                (0x350)
>  #define SPR_VTB               (0x351)
>  #define SPR_MMCRC             (0x353)
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 9cd33e79ef..a0cae58e19 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8243,6 +8243,12 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
>                          SPR_NOACCESS, SPR_NOACCESS,
>                          &spr_read_generic, &spr_write_ptcr,
>                          KVM_REG_PPC_PTCR, 0x00000000);
> +    /* Address Segment Descriptor Register */
> +    spr_register_hv(env, SPR_ASDR, "ASDR",
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    SPR_NOACCESS, SPR_NOACCESS,
> +                    &spr_read_generic, &spr_write_generic,
> +                    0x0000000000000000);
>  #endif
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzP0UsACgkQbDjKyiDZ
s5JqmBAAsNkqwn0DbMURbWZqmjLDrH08HyFf3TRTrdjZLqqR0mra4e99AxM6aItX
OhGUkAEXQOf+q5OzgaG9y0IRS9NrVlARG6gg2tRMjDtZBDQyzxZpuN/UlTWyLkjK
cUX7Ap9PFzDGHPu9gglZjdVDf46g3QAmFBtxdhKWzUVuUVcBVqf+9npjjg4Krezm
8ItaYvbwsZ90/kwtC5K4OBCOwlLQapJquoY6PsER70ZcJxLSNf0v4fXe5gFQSaAn
v/xu5/nKvtwJEYeGP6rweoriGfFUtys/iXkJ0RCjQAaVwNGXnvoYFKY9fv3V4WC9
R902KTBwclG+w+PzK+zyhqKkrrWDNZnI71rJYGDOpeOedOEQotexNSGRkkjfrisQ
zmcHs0zoQwDavMqDvsDhgS/w/rFomQcS8C0PQg63jEsg0ptVgkZOfCrnEmX+JqKR
JPX52HRN4Z3A3U8KqJax3yy+4kPLiFT7V7t12KfolAhmRgC0gIetH6hC0z16aDs2
2Hpctcnus95AGjyb/yJU9hx8nmtIv2Pz4m1Vs/H71AiLZFeMr1zo8DMD1r8La6Y3
CSjEHDh+dAiQvUD0azS6kF8+nLf8d9L7VsT4Dp5dpu7o1hT5kSGC3dovg9tmdHtc
DFcDhLbTUz0H4tLZvZOpsnjyuXpsjw2NnmazjEitR/7MsCo9UWI=
=IH7w
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--


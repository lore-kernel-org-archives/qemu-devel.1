Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA6CC2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B15A20709
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 01:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VDud/r8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie7UP-0000rQ-8Q
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 20:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7QU-0007mk-Lb
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ie7QT-0007Op-7B
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:26 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ie7QS-0007In-2v
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 20:01:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47WPyg3v9Cz9sR4; Mon,  9 Dec 2019 12:01:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575853275;
 bh=vvxyOztkiVTGg82fOHE0r69GY394ZGr0accZXCDbHVE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VDud/r8eYODa9N0jHZGVXER0TkOWqP3qK9jHTwfxl3th7ZKxR3OcFVApzc4cpe9FJ
 3u93JLip0wwRLNfqERa1VXWkvzxc6gccvHqsXBfr0d7XYaf8q9Ig2mGP6bS4h+YODI
 TCEeGrSAaIXKdcvIgtgFLmhjTdXpP+3c07dGmS7c=
Date: Mon, 9 Dec 2019 11:51:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 2/3] cpu: Introduce cpu_class_set_parent_reset()
Message-ID: <20191209005134.GC2482@umbus.fritz.box>
References: <157565782864.3897844.627720481210693346.stgit@bahia.lan>
 <157565784026.3897844.6515055734977835356.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <157565784026.3897844.6515055734977835356.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 07:44:00PM +0100, Greg Kurz wrote:
> Similarly to what we already do with qdev, use a helper to overload the
> reset QOM methods of the parent in children classes, for clarity.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/core/cpu.c         |    8 ++++++++
>  include/hw/core/cpu.h |    4 ++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/hw/core/cpu.c b/hw/core/cpu.c
> index db1a03c6bbb3..6dad2c8488a9 100644
> --- a/hw/core/cpu.c
> +++ b/hw/core/cpu.c
> @@ -239,6 +239,14 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
>      }
>  }
> =20
> +void cpu_class_set_parent_reset(CPUClass *cc,
> +                                CPUReset child_reset,
> +                                CPUReset *parent_reset)
> +{
> +    *parent_reset =3D cc->reset;
> +    cc->reset =3D child_reset;
> +}
> +
>  void cpu_reset(CPUState *cpu)
>  {
>      CPUClass *klass =3D CPU_GET_CLASS(cpu);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 047e3972ecaf..6680f4b047f4 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1137,6 +1137,10 @@ void cpu_exec_unrealizefn(CPUState *cpu);
>   */
>  bool target_words_bigendian(void);
> =20
> +void cpu_class_set_parent_reset(CPUClass *cc,
> +                                CPUReset child_reset,
> +                                CPUReset *parent_reset);
> +
>  #ifdef NEED_CPU_H
> =20
>  #ifdef CONFIG_SOFTMMU
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3tmpYACgkQbDjKyiDZ
s5Ld7RAA0ewD1cwDz+C9cs5ofFslay1l9jmaBWCqmopFutZ6YNx5xi4w6/mVTMzj
NGFeVYqWHyBHqjKDRfWhAjQHZ9Ueq8Rcjo3jDvsYcAAy2le1YrHHNVPAF5uMbL44
TA5ebeFRfDcu+wShRX85wbfD8d2cZXTtXce5rl8GsefJsmK0rIrcEk2Otz3HHHxn
zfYQ6yLs21rU0LC1RAs/H3GZtTGIwPz3+2PRvr3nqdB12BtuV5NxT8srFFODhSoS
2CWhEanUjCImJ4jpgJ5vb9Fc//xesmK0nU2LGqT5wL50KzYGnBuwtfuiOW677UxG
DRJG0GVC65nHl4I3MPwj9VRyu7ztIIuguVahLwIps6Vkryxviuitj9Xhcs/hjL19
Q1CgBYoqzTAKfLJV4G+nNIXfMzfgyl6B01IROo6f6+UbTL/R9xVzV7f2bZfiE1vI
suBPrp6DCXlXk23QVnoVQZL269Ww8I57ILb91vkcGmceHgaLBGYUJaIgNb1Yvlie
T/hDvRAvExMz3yN7hlSIH90+cSLppc/Mq1xcy2Lq8Rsb2ukYB1aIojDZRgxmXhYS
4CQKSxWyNeC9tu7a+C6pQ5oI2749F7wPtW2C4zv5D/XBU+YihJIDdtqUx2S76PwN
MYYr4mvISBzQz3/wz5EPbIjkElKkYStodbJz0QDTjCspHwrERwU=
=MWBt
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--


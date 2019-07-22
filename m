Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EC3C76194
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF532190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PcbLPXwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF532190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW16-0005C1-JY
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40816)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0A-0001XH-33
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW08-0007UQ-PE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:06 -0400
Received: from ozlabs.org ([203.11.71.1]:56663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW06-0007NH-7r; Mon, 22 Jul 2019 06:57:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpg24Wvz9sMQ; Mon, 22 Jul 2019 20:56:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793019;
 bh=g/4VldMbHDdoF+MiUuvuqAj1tI7uXe0eTkx6KJV+HZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PcbLPXwmerQ84rriHxBeZs7GU3pLdpMle579eLgmsFuZqmGlPNxgPS/ivnMtcuqF7
 OJXvHwHfCZb2eFVmI0sLIxzx1clOhfOFfyhBzdko3PqT/mN0KU7SBvUpKYt8BeWmSZ
 5x6PSw+jVX5AlCmgD1b98aab+vJlkbA/6YBxby3A=
Date: Mon, 22 Jul 2019 18:38:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20190722083855.GE25073@umbus.fritz.box>
References: <20190722061752.22114-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Content-Disposition: inline
In-Reply-To: <20190722061752.22114-1-npiggin@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2 2/3] i386: use machine class ->wakeup
 method
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
Cc: "Liu, Jinsong" <jinsong.liu@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Luiz Capitulino <lcapitulino@redhat.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2019 at 04:17:51PM +1000, Nicholas Piggin wrote:
> Move the i386 suspend_wakeup logic out of the fallback path, and into
> the new ->wakeup method.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c | 8 ++++++++
>  vl.c         | 2 --
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 549c437050..78c03d7f9d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2828,6 +2828,13 @@ static void pc_machine_reset(MachineState *machine)
>      }
>  }
> =20
> +static void pc_machine_wakeup(MachineState *machine)
> +{
> +    cpu_synchronize_all_states();
> +    pc_machine_reset(machine);
> +    cpu_synchronize_all_post_reset();
> +}
> +
>  static CpuInstanceProperties
>  pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  {
> @@ -2940,6 +2947,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      mc->block_default_type =3D IF_IDE;
>      mc->max_cpus =3D 255;
>      mc->reset =3D pc_machine_reset;
> +    mc->wakeup =3D pc_machine_wakeup;
>      hc->pre_plug =3D pc_machine_device_pre_plug_cb;
>      hc->plug =3D pc_machine_device_plug_cb;
>      hc->unplug_request =3D pc_machine_device_unplug_request_cb;
> diff --git a/vl.c b/vl.c
> index 45ea034410..3f50dd685b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1567,8 +1567,6 @@ static void qemu_system_wakeup(void)
> =20
>      if (mc && mc->wakeup) {
>          mc->wakeup(current_machine);
> -    } else {
> -        qemu_system_reset(SHUTDOWN_CAUSE_NONE);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01dh8ACgkQbDjKyiDZ
s5Ljag//as6bEUGoZr5QZnb67Iabeqf2t4xhhyTiTl2saIPG28eLGPQJNYKNjaeK
5XTfAM1ilAwc7Hz9aoq2M5fpEGIBugLIY3PS9iMfUuIjZKElGBbTRBiiRBEunyIs
G/oA3AdeENO64HaMY+ItxcJCx7AWsE1JYn3BTNpXnm2EuHi/zk4q5Ua0TvpOa5AS
zitxbWkSxY1W2ch9S5ZLt9Ehw6YZ8kBhMrZT/HkOiIv+75+NFCF/zvM42kHNfOjE
pTVMghBm6GcCAffshCwF2eK89104zC05SVDaXyi/WG+MvNcEVjT+MXg3yq6ewUgO
qeXEu8s+cjXi2wpWPuZA0asb2e+WaAbpqsqdsChpAUd6q0qskz4pMeG44MITKIEO
osAQNdUEkZEaKjUQxaD2/51rc27P0tGxhBYlCXLYR7stZ/0P4jptxwda1zbg6tCN
PFP6XFtcOgb5W18RiY90fgJYmfG1fWDWMS3vHvZpikTN2Y5SiV/Cxj8FI7tw0Glp
WTqG1ZMQHIqqwa2oEIrpmPXEUW+iF+6XeFg2GgqxupOyvLRK66GF5np3HqTb+az6
3VxdbxI0nn/C3lVfOUDIZdRdKhVUfBWN+5jZe+d68gxj4TStq2XE/3oSu+V2v/Ur
HoCiYDmG+i5GT2dvXFQOYXfQYJuAdy2sMBkPPpiFwsmUxGcvVvc=
=fTv2
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--


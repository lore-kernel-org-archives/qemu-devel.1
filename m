Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22CFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC7620702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IwNn7lOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC7620702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uZS-0000gP-Fm
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 20:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8uXH-0007ep-Ir; Thu, 20 Aug 2020 20:03:59 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8uXC-0008I7-Sm; Thu, 20 Aug 2020 20:03:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXhZF0d6Sz9sTR; Fri, 21 Aug 2020 10:03:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597968229;
 bh=k8y2MiCws5R904jtNepHL4vmI8Dy5BhZecPbzoNzai8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IwNn7lOr7/l/LRQU5+f8ZXykfsKcH/OxkIgQMXk88946zufRQSwV3XKuVuttOE9dB
 cyHZe9deGQ8DTzZ/kDuaz/gZnn9uNaoOzXTWuA0s8l5Rr/6O3HpCxQ0NN7Mr1xkrKc
 +Jh+n53uUoMJbFErE4LDFV46bp7ahlleOCFaqg/Y=
Date: Fri, 21 Aug 2020 09:21:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 1/1] spapr_vscsi: do not allow device hotplug
Message-ID: <20200820232111.GT271315@yekko.fritz.box>
References: <20200820190635.379657-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qKhyKP9HH88saeqA"
Content-Disposition: inline
In-Reply-To: <20200820190635.379657-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


--qKhyKP9HH88saeqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 04:06:35PM -0300, Daniel Henrique Barboza wrote:
> We do not implement hotplug in the vscsi bus, but we forgot to
> tell qdev about it. The result is that users are able to hotplug
> devices in the vscsi bus, the devices appear in qdev, but they
> aren't usable by the guest OS unless the user reboots it first.
>=20
> Setting qbus hotplug_handler to NULL will tell qdev-monitor, via
> qbus_is_hotpluggable(), that we do not support hotplug operations
> in spapr_vscsi.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1862059
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

That was much easier than I feared.  Nice!

Applied to ppc-for-5.2.

> ---
>  hw/scsi/spapr_vscsi.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> index d17dc03c73..57f0a1336f 100644
> --- a/hw/scsi/spapr_vscsi.c
> +++ b/hw/scsi/spapr_vscsi.c
> @@ -1219,6 +1219,9 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev=
, Error **errp)
> =20
>      scsi_bus_new(&s->bus, sizeof(s->bus), DEVICE(dev),
>                   &vscsi_scsi_info, NULL);
> +
> +    /* ibmvscsi SCSI bus does not allow hotplug. */
> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
>  }
> =20
>  void spapr_vscsi_create(SpaprVioBus *bus)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qKhyKP9HH88saeqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8/BWUACgkQbDjKyiDZ
s5IaexAA1f77VZXDTysMRF2aHZah4O+Ibsbzfj3srWB3xYGFf2K5QK2CnG9jWJML
G3NAtFrYAFsfqomrAYS6gBgBFlMM1ryMjVo0pxxJfbw7KkP8kSJYCNT/KpK/kzty
CjSSjAWkinLeBqo13iiTgMWPL6UqvowmMXFe3+10n8LhnrYbSFTXXZNpSAmFgZLs
DS4fcoC4WbAtcfPgvtu1EV1BYLWVaG1Fnxt2HDfYoepn0TjGDZu+budUM5FBHZLL
bNoh1P+XH6L7auU7/WAW4MWbPpCZh8Vn+4G3YNUFGwtrj/E0g6dj1qUMVFxES97I
fQIJOllz0PWhUbUw89SELKqCNmlH1vCPE7xWqZisZQluPazE+MW1urZ2j/btjiUl
e4/dxrJPCaR7GJB4vRjiKWBQ1shxpZqiChguMD7Iqr51C/wXHkTDnpakwE0/Vx4W
XSqtFoRpefvf/uQwt4L9FLouCogiR0Q649qvhwMVgD7irhKAg9CweaKqT+VjCxfi
wyRCZUwyGyp5UesI4KfPrcJU7wZ3HK1qn422dlVVaRa+YeP0cKq1VZxB+JKDAgMV
1E3zg0/Zcsn3KCh6SYe0X4/fdA0gtDI7H2ji7g/xAiOIxp4GuuAMtZgJPGgn8lVI
VmHo9jsPieAwx6pL50WUMujsO+Iw2J16j0hCvHimBC+lbvh6iEc=
=v9tq
-----END PGP SIGNATURE-----

--qKhyKP9HH88saeqA--


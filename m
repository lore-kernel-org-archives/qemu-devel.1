Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D46C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 04:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913F820890
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 04:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ty7HzoUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913F820890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm8Ql-0007td-Px
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 00:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm8Q8-0007Ik-AV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 00:14:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54043 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm8Q4-0005WR-KZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 00:14:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49p56L6769z9sRk; Fri, 19 Jun 2020 14:14:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592540058;
 bh=LfEePlG/mcY9taFnPF//9oIvIWUP6ntYIzNZfysCYpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ty7HzoUxSoyy3A7Ek5I2ds6rVA/t8ejuWv1eQ9ilXKQrAKECgX6I2QJZQnV8OWypX
 MoLCgSFqM9Xxa/Vxdb7EPfcT7B9MaYecffMgMSORYpcoRH9c+BnTe/8huCV1Upkqd7
 f0zZ9Y+rx6ens6Vt5znX7epRwlYH14w2yg6zqleI=
Date: Fri, 19 Jun 2020 14:13:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Memory leak in spapr_machine_init()?
Message-ID: <20200619041334.GI17085@umbus.fritz.box>
References: <874kr8uakm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="byLs0wutDcxFdwtm"
Content-Disposition: inline
In-Reply-To: <874kr8uakm.fsf@dusky.pond.sub.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 00:14:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <dgibson@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--byLs0wutDcxFdwtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 08:55:53AM +0200, Markus Armbruster wrote:
> Either I'm confused (quite possible), or kvmppc_check_papr_resize_hpt()
> can leak an Error object on failure.  Please walk through the code with
> me:
>=20
>         kvmppc_check_papr_resize_hpt(&resize_hpt_err);
>=20
> This sets @resize_hpt_err on failure.
>=20
>         if (spapr->resize_hpt =3D=3D SPAPR_RESIZE_HPT_DEFAULT) {
>             /*
>              * If the user explicitly requested a mode we should either
>              * supply it, or fail completely (which we do below).  But if
>              * it's not set explicitly, we reset our mode to something
>              * that works
>              */
>             if (resize_hpt_err) {
>                 spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DISABLED;
>                 error_free(resize_hpt_err);
>                 resize_hpt_err =3D NULL;
>=20
> Case 1: failure and SPAPR_RESIZE_HPT_DEFAULT; we free @resize_hpt_err.
> Good.
>=20
>             } else {
>                 spapr->resize_hpt =3D smc->resize_hpt_default;
>             }
>         }
>=20
>         assert(spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DEFAULT);
>=20
>         if ((spapr->resize_hpt !=3D SPAPR_RESIZE_HPT_DISABLED) && resize_=
hpt_err) {
>             /*
>              * User requested HPT resize, but this host can't supply it. =
 Bail out
>              */
>             error_report_err(resize_hpt_err);
>             exit(1);
>=20
> Case 2: failure and not SPAPR_RESIZE_HPT_DISABLED; fatal.  Good.
>=20
>         }
>=20
> What about case 3: failure and SPAPR_RESIZE_HPT_DISABLED?
>=20
> Good if we get here via case 1 (we freed @resize_hpt_err).
>=20
> Else, ???

I think you're right, and we leak it in this case - I think I forgot
that in the DISABLED case we still (unnecessarily) ask the kernel if
it can do it.

Of course, it will only happen once per run, so it's not like it's a
particularly noticeable leak.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--byLs0wutDcxFdwtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sO2sACgkQbDjKyiDZ
s5JxwA//ZPOZIn+BPG64G0z7MGMbI4Fdf6FIUB4R43jXdeS0OwCyvxlKeGuW8xoS
JET+EjpdewJpQb9KSm689Yb3vJ2DFqit2al7/rFPCRRUBjNmI68I4MsFNsZAE2tt
Hj/KtqPwLvzB9DW+KCerWwDE/aZfaQDDTzLaTHiWRTSQgSGhIvRssr50o37N7BN6
5THzY37P7FQOknkVtff82GjtrbhX+Y9xewedtzWcMKWwAE/ujwqF2JVFfSmEot33
CanDqPyYbCPoIoKhVBFb67bIMg7YTkjbhwCf8lRQActHqffJroyfdyEgt2MVgqkm
vMgEu3YcjSmi/4uhyykdkrRlHJSXOG2YIjYTyg2XudZVfRq2SflpO7pvSb7wL75T
Hj0i5tQKqfEAO77zvyJVz6V8kk6ncBJywCRy9X0yNQBt9DXTEvrw/4eTyrkk1On8
9HnJAMtMZlA8Wuzf3GW+USebAz/o9wuSLbG6P/a9+Xjck9IwKNeZfsjFftbZ0WEm
DQrb6/1BE/w3xZ8xTouqn5eVRq6CXx0d/C7gryEz9fhnCZIP4I9e8b5oaunDR6FU
+HtlTprrI1hp7dE/aBv9QBiXMlQkzJ5cGCniKxo7jsjNnd1XK+3WwOT405wKsWxP
YErPtJtd8ZTvHaLr/lR3FmjpRI76jwgShhxEYS7OMIkXNu7jIp0=
=cjNq
-----END PGP SIGNATURE-----

--byLs0wutDcxFdwtm--


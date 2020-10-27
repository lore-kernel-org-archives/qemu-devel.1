Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C8C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5182076B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 02:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g4HY+Ztj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5182076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXEML-0007PI-4v
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 22:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKu-0005sU-V4; Mon, 26 Oct 2020 22:03:46 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42897 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXEKq-0001Vu-UV; Mon, 26 Oct 2020 22:03:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CKw3V5MKJz9sSn; Tue, 27 Oct 2020 13:03:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603764214;
 bh=pTfsGKx+kYVm/2z38L4L+T5ruMToOgT5A/O1r75DjgA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g4HY+Ztjh0uDqzs6jDuXmSm7hUDQ45lnOB8dDeCHIl0DB7g04CaFt5T8rIfR/RomF
 cTrFwpyjSUTVRpP+Xv5af/q1tytilV08ytzpDNAbcjuG25naPZyiOw+4wVAo1/9tvc
 5wmH9BXqTGFt2lFAlpzRSiKHO2nf+21KgrB5fdyQ=
Date: Tue, 27 Oct 2020 12:57:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 2/4] spapr: Use error_append_hint() in
 spapr_reallocate_hpt()
Message-ID: <20201027015734.GC4671@yekko.fritz.box>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371604030.305923.17464161378167312662.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <160371604030.305923.17464161378167312662.stgit@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:40:40PM +0100, Greg Kurz wrote:
> Hints should be added with the dedicated error_append_hint() API
> because we don't want to print them when using QMP. This requires
> to insert ERRP_GUARD as explained in "qapi/error.h".
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2.

> ---
>  hw/ppc/spapr.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f098d0ee6d98..f51b663f7dcb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1486,6 +1486,7 @@ void spapr_free_hpt(SpaprMachineState *spapr)
>  void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
>                            Error **errp)
>  {
> +    ERRP_GUARD();
>      long rc;
> =20
>      /* Clean up any HPT info from a previous boot */
> @@ -1500,17 +1501,18 @@ void spapr_reallocate_hpt(SpaprMachineState *spap=
r, int shift,
> =20
>      if (rc < 0) {
>          /* kernel-side HPT needed, but couldn't allocate one */
> -        error_setg_errno(errp, errno,
> -                         "Failed to allocate KVM HPT of order %d (try sm=
aller maxmem?)",
> +        error_setg_errno(errp, errno, "Failed to allocate KVM HPT of ord=
er %d",
>                           shift);
> +        error_append_hint(errp, "Try smaller maxmem?\n");
>          /* This is almost certainly fatal, but if the caller really
>           * wants to carry on with shift =3D=3D 0, it's welcome to try */
>      } else if (rc > 0) {
>          /* kernel-side HPT allocated */
>          if (rc !=3D shift) {
>              error_setg(errp,
> -                       "Requested order %d HPT, but kernel allocated ord=
er %ld (try smaller maxmem?)",
> +                       "Requested order %d HPT, but kernel allocated ord=
er %ld",
>                         shift, rc);
> +            error_append_hint(errp, "Try smaller maxmem?\n");
>          }
> =20
>          spapr->htab_shift =3D shift;
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Xfo4ACgkQbDjKyiDZ
s5JLeA/+K5ArytDawtb3/h820l9E6tytq+a71Ppyn0yGoDw6stD8mq8p7p/v0M42
0O7Ag3MsztNFE6+xWlmZzxx9Omsg7fiqJseDnq/OkHOK6lzNSoW+ABraPe/OMBEf
viW4oFuOf0rw/W0bRZFizjOIdwpwENmJ1nEX9MqktB4s8Q65HNa/+hSTevRcdUHo
JrDCQatBf4HB3hqctWI6+ro7M87c3dyqsONghdNVXM2epD6BxNwndBxWeaR0QiYE
5vOd42g8e8GUrXzwOoajHkh5Eg8nmkY+ofvnWu4ae9p5tNsrLep3fkmw0yFkSBrJ
lfvg8/+FbgumFNlkvD/TXlV7QiBYalzUyb+jjrcLHITpB2ZkHW0+bjBe0cD24hmm
cPQYE1OfrjqAvlcXdyg/hfFOk45NafhTbJpKXsTD7NAzAfzg7BH90zqQxq2cFi3T
xIJmiDDHEWclyrWsYHYEWp6Yoz/eBYFpsIn/ItkHkNunn7w8Q1aQX40COUPl0BxV
P+FBXHM1XKGAerG+AO0iVF7QZ3df0Im9B7oaJDuhDJQxPb/WnhKXHH95yyumcdcM
Y+7FFa+XGLQ/EV2tZgRaD+qQEZ3CLqaX2+NELhQPyDdHDWPxdgOkr8MzTML/69an
NmWkTqG6CZHqoYhySFEH27kj1xm1lfJUCkuMj/HB5eGE0AhYCj0=
=9Nng
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--


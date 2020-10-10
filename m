Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F28DC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 06:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F552078B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 06:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D3gZKWZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F552078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR8Sy-0005KI-9o
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 02:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kR8Rw-0004YL-V0; Sat, 10 Oct 2020 02:33:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:57417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kR8Ru-0006dz-3q; Sat, 10 Oct 2020 02:33:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C7Zrn3VqWz9sSG; Sat, 10 Oct 2020 17:33:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602311609;
 bh=ad2uiQiSUQX7woB1EbG9IOtUlgA6aFkF1ziq9rsnbdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D3gZKWZpvzBZDouXhepCEybFonq/Tepl7N9wybDEne2qfXiy2lEfr4osTknN96Yan
 jG61NA7y1D/MxsG1xpTHCRu+T13XTebl5jUfIRA3Vg8RcLM6z9qM9uFGe6TR20rUA1
 Z7RbfT8Rz1+meLCPF0XWyyXFmgRi0ubS74u5PjOQ=
Date: Sat, 10 Oct 2020 17:07:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
Message-ID: <20201010060745.GK1025389@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Content-Disposition: inline
In-Reply-To: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
> >From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
> From: Elena Afanasova <eafanasova@gmail.com>
> Date: Fri, 9 Oct 2020 06:41:36 -0700
> Subject: [PATCH] hw/net: move allocation to the heap due to very large st=
ack
>  frame

Patch looks fine, but some more details of the motivation would be
nice.  I wouldn't have thought that the size of a network packet
counted as a "very large" stack frame by userspace standards.

> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  hw/net/spapr_llan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 2093f1bad0..581320a0e7 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cp=
u,
>      SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
>      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
>      unsigned total_len;
> -    uint8_t *lbuf, *p;
> +    uint8_t *p;
> +    g_autofree uint8_t *lbuf =3D NULL;
>      int i, nbufs;
>      int ret;
> =20
> @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cp=
u,
>          return H_RESOURCE;
>      }
> =20
> -    lbuf =3D alloca(total_len);
> +    lbuf =3D g_malloc(total_len);
>      p =3D lbuf;
>      for (i =3D 0; i < nbufs; i++) {
>          ret =3D spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+BT68ACgkQbDjKyiDZ
s5LjDRAAy2mjxrF0LAoBSmnlpWxZKUIoBJ30kntx/cOBeyLYEad71jaHb7StaqVi
xWeopMRQJCy56wRpiw6/nRFqSj/vfcK7yMQv8oW6FrBIhOMTGfQnVDGf/7ld9qKu
y6G78PAolh44gjF8YVvfupR14HpWeHPzOWtjm17gW2GLLXVU/cLCJpsdTpZrWW72
TMU+5GGpvxA1cWFLQc4XLc19icxV9LHfIkz1Tu9pU3LG+W5swnG+qdGZm2T9VlZP
l96r2Gy9UZKz6vsDFjwzgjU2Q4mgNe9JSGDaAz/6TEUpEvf/Q02gH/IvwzhSL3Wu
Yw8l1ZpRUd9B2HokU7iMXJAjPCkPKUszn4kD4hKGbfq/iO//TaDkHyNY1o0ssqPl
CIGdFm2y3Lzsod1UwTCjcoN7Lym1cwDMY9JAz1EpiSf8QoE8xv+dzAUIxnjEd2kX
DBedswV43HQj6ccHdbmfLqURpXQDad1+e9z5Iyji9XqC15XoxWVwN3uZNJPX0Ag+
74y2qFrGVng1RBis6f/Y3fukumew/PeGemnbeQolvgmdF0OdRzjIJA6AVmK/4VOt
DhaYcLjcdEoduf+XzcFVT4myc0RyNbdVrPf+oTPybXfHJ3eC+foMV9sRnYkN9f8l
/M/XFw1hmNzT8lzUui/XEwM20RAy032Ibef2MMdLlyPpt4utjOk=
=rKco
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--


Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B37B2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 05:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IFC9M8K8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B37B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0eeI-0004oI-Fm
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 01:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0edQ-0003xd-Lz; Wed, 29 Jul 2020 01:28:12 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:39875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0edN-00013O-MC; Wed, 29 Jul 2020 01:28:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BGhrt3vlpz9sSy; Wed, 29 Jul 2020 15:27:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596000478;
 bh=2oJ2Yi+4iUTO/YFIP4ufXzEc8QHI71RDRpjt5dOCmhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IFC9M8K8evoU0LdU+dRnK2Isme3RpjEuy23E3m40zxxbUbL7WbFMwInW+EMa8kOnm
 Dyz7DCbfHlXyn/kFsBRr/KRDvIbIyyGMskRNIWe560J52YRdB/zDI3G535438vhZ7e
 AyUfK5utb3TFpPV//86ZjN66CoUan6J9y2mK8Xbc=
Date: Wed, 29 Jul 2020 12:54:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH for-5.2] spapr: Avoid some integer conversions in
 spapr_phb_realize()
Message-ID: <20200729025441.GJ84173@umbus.fritz.box>
References: <159592765385.99837.12059368746532345109.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <159592765385.99837.12059368746532345109.stgit@bahia.lan>
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
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 11:14:13AM +0200, Greg Kurz wrote:
> Without this patch, the irq number gets converted uselessly from int
> to int32_t, back and forth.
>=20
> This doesn't fix an actual issue, it's just to make the code neater.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-5.2, thanks.

> ---
>=20
> This is a follow-up to my previous "spapr: Simplify error handling in
> spapr_phb_realize()" patch. Maybe worth squashing it there ?
> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 59441e2117f3..0a418f1e6711 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1964,7 +1964,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
> =20
>      /* Initialize the LSI table */
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> -        int32_t irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS +=
 i;
> +        int irq =3D SPAPR_IRQ_PCI_LSI + sphb->index * PCI_NUM_PINS + i;
> =20
>          if (smc->legacy_irq_allocation) {
>              irq =3D spapr_irq_findone(spapr, errp);
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8g5O4ACgkQbDjKyiDZ
s5L+Iw/+NLWdKJTDz9TmhYIFELM/iKzSrU6Y3b+j7CC/zV2+YtXwWZSll315Lspj
V3rWDvcgvKPwt6XTl/Q0O8F1MU5feKElvYk8PxIAz2pkW/Cf+8u+YjXKG5Vh1gbu
XQ+cJ7/9USLHJ7OYhayjYwHipIdu+ZnRCcVqRWWUZh2UsMFdpV9W+OddsNyl61p5
b1tDe8s2P1Op92sQW5uBOu8iAtuOEQTxVMZZeC01v13UDzU0HdafwfSaL5MAMAIY
DPf2TfwPH3XObkZWsU1Vf8nqXJqZftv0GeSVZ2YzXui4xdD0M2h+WNHUh+JCHM2W
w7CLj8jjNAmNUSAdNGSD2t/rAc7e/hqDtzWPDAuFP7VW0XueRBcdZjKlfXx8GsH8
DTTexyYf3QpxD8PIS7Hsf9ZmSQCp7tE291cxRnzmh1fzBsNgikTq61m3HrPHKSk5
Ee5+SH11S7pHSOUVaR4rgFTvp5usEkjW6spnwATMN431EFn3ntGMmIyQZKj45c8v
iC+vMVTF7MXT+8EFEDPzR2/1Tc7Zv9+ZPli+xJAhcjxuDwv4y4JG4j6zBGy53bmA
DxRSCu4WFstP7a6RSbgcrY408YLOfZYlAFBeay1vganSCMeabFb3aal1Rs/bjcky
Mo8nMt9zd8ege3a5P8fFvm0FSSs5LsGEYfmm9yrdDG7LncN16Tg=
=t81G
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--


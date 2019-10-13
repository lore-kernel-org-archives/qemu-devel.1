Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E33C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 23:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9AE206A3
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 23:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="blu3Xbfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9AE206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJncC-0000kj-RX
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 19:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJnbF-0008Qc-BW
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 19:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJnbE-0004QQ-4R
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 19:48:33 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34185)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJnb9-0004Km-MG; Sun, 13 Oct 2019 19:48:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46rz0P0Pl1z9sPT; Mon, 14 Oct 2019 10:48:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571010501;
 bh=Pp3p9N2Nb23e+wArhuIV/kXQEFRhcrgh+P8qkGdmvOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=blu3XbfhDQnzBaNZW9mwoXMKDmk/TTZnotvMyFeEr0/37jmAwZQIhrdxRfprCLvzX
 sK4lVHK59H5m11WZVYKA5X3iyUePHPO3zjScj3J/UeJG1odzscgAPnUSu96hD2ykiX
 FcmgYJJedYLiAYG6R3enLlmpV/LUpdrZaW5C8ZIY=
Date: Mon, 14 Oct 2019 10:36:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Message-ID: <20191013233622.GK4080@umbus.fritz.box>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-2-richardw.yang@linux.intel.com>
 <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOhpupldhMlYbdva"
Content-Disposition: inline
In-Reply-To: <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
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
Cc: fam@euphon.net, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, den@openvz.org,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 ehabkost@redhat.com, sw@weilnetz.de, dgilbert@redhat.com,
 yuval.shaia@oracle.com, alex.williamson@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org,
 Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BOhpupldhMlYbdva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2019 at 11:56:35AM -0400, Richard Henderson wrote:
> On 10/12/19 10:11 PM, Wei Yang wrote:
> > Use ROUND_UP() to define, which is a little bit easy to read.
> >=20
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > ---
> >  include/exec/cpu-all.h | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> > index ad9ab85eb3..255bb186ac 100644
> > --- a/include/exec/cpu-all.h
> > +++ b/include/exec/cpu-all.h
> > @@ -220,7 +220,7 @@ extern int target_page_bits;
> > =20
> >  #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
> >  #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
> > -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TAR=
GET_PAGE_MASK)
> > +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
> > =20
> >  /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
> >   * when intptr_t is 32-bit and we are aligning a long long.
> > @@ -228,9 +228,8 @@ extern int target_page_bits;
> >  extern uintptr_t qemu_host_page_size;
> >  extern intptr_t qemu_host_page_mask;
> > =20
> > -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qe=
mu_host_page_mask)
> > -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size=
 - 1) & \
> > -                                    qemu_real_host_page_mask)
> > +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> > +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_pag=
e_size)
>=20
>=20
> No, please.
>=20
> (1) The compiler does not know that qemu_*host_page_size is a power of 2,=
 and
> will generate a real division at runtime.  The same is true for
> TARGET_PAGE_SIZE when TARGET_PAGE_BITS_VARY.

Ouch, good point, I didn't think of that when I gave an R-b.

> (2) The first hunk conflicts with an in-flight patch of mine:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04526.html
>=20
>=20
> r~
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOhpupldhMlYbdva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2jtPQACgkQbDjKyiDZ
s5IEsw//ftKuQboc8ntKEGJFGNJza6JgIgcbNUaew/8J0/HS16Jub+gBT2lCeES1
xrK43Si7T6ZPHIRrVGvDPLCx4vboRnfuWkxL550XAHtUwN6h/rVI2NnHG5PzxBjq
yDeCxc2fyr+sP/bDG7878ooNtGrRAUJNCttfkL9ebi6jck0ll1FX3o2wO2G53xQa
ay0qIGJUUCpHlPELZCerNexNgbLaB6EdkFhLJq2U7sqenjc7Fqdc8Fd1fynKf7kn
7fX9JPEEE132D8faEgog2VUfMnZjgnLL9LV/xx91f+1ffD9VOoyBDdnt/FHU8ovd
WqXnEgHsz1zJALUBfFyJwsN1QNfpG97gj9zlAbO2RQWul54YafB3WBAhOr3UkMkH
n8EZ/HEsQLIRJMZnOxFjsb+ghniHXR9c9z/4wbIgkE8XTUjgWoVZYkJLfoKJYfa0
WxOyk7KZRWrEH4/jVSKUjPTHuP3A+wJ9bllet2JzqRE/f1rXUSriPkkEv8MRKywT
6B4XBK8z9F5BS0HmU8k8JXuWh+OHHB000oo3TsydR57NiMz2w578MVOhx12tLQQn
jLwSCJGn0ItS/ipvrCsWuy18Uau9XgvY32oyMJZ7w1+/EBThTYefXt+p7a1CsSeM
GVSlbqj2jgfPyZfnkuQIqXsPr4BguaV38xKYdyBlvQZJxbeqBVk=
=2kt0
-----END PGP SIGNATURE-----

--BOhpupldhMlYbdva--


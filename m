Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0538BC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 04:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37C22077B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 04:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B34k2Y/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37C22077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieWwT-0008Kk-Sf
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 23:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieWvQ-0007K8-00
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 23:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieWvO-0007ya-OX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 23:15:03 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60353 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieWvN-0007vU-Lh; Mon, 09 Dec 2019 23:15:02 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47X6Cj5MjPz9sP6; Tue, 10 Dec 2019 15:14:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575951297;
 bh=1RV5HCKYRZdkfpMExGY1W0h+9hklz0+HBY4S17Kw7pc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B34k2Y/vj1bqSUyHJ6DQ81F4mQsdyWqktEGf8VNoZlp+4gU2bJl+JrfoQCCF5u8fX
 o9rzgbmO+tRbe0ADYQpVPrKBytnQKOVIU2g2wTb8+TtC5CSvcrslW6+EgByQn1QJBy
 xBfNCQOVc+PcxaSUNzpc9DPNGyb2eeXK9sJ47OVA=
Date: Tue, 10 Dec 2019 14:58:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [for-5.0 1/4] spapr,ppc: Simplify signature of kvmppc_rma_size()
Message-ID: <20191210035856.GG207300@umbus.fritz.box>
References: <20191129013504.145455-1-david@gibson.dropbear.id.au>
 <20191129013504.145455-2-david@gibson.dropbear.id.au>
 <375755db-f76f-508b-6b8e-f8ae19d83aff@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <375755db-f76f-508b-6b8e-f8ae19d83aff@kaod.org>
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
Cc: aik@ozlabs.ru, lvivier@redhat.com, qemu-ppc@nongnu.org, groug@kaod.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 07:18:52PM +0100, C=E9dric Le Goater wrote:
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index c77f9848ec..09b3bd6443 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2101,7 +2101,7 @@ void kvmppc_hint_smt_possible(Error **errp)
> > =20
> > =20
> >  #ifdef TARGET_PPC64
> > -uint64_t kvmppc_rma_size(uint64_t current_size, unsigned int hash_shif=
t)
> > +uint64_t kvmppc_vrma_limit(unsigned int hash_shift)
> >  {
> >      struct kvm_ppc_smmu_info info;
> >      long rampagesize, best_page_shift;
> > @@ -2128,8 +2128,7 @@ uint64_t kvmppc_rma_size(uint64_t current_size, u=
nsigned int hash_shift)
> >          }
> >      }
> > =20
> > -    return MIN(current_size,
> > -               1ULL << (best_page_shift + hash_shift - 7));
> > +    return 1ULL << (best_page_shift + hash_shift - 7));
>=20
> The closing ')' should be removed.

Oops, that's embarrassing.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3vGAAACgkQbDjKyiDZ
s5Kuiw/9H95x40SpKBr2HPbXg1YTuptbH++I4j7odQeckkaTHm/2LwHsd4PxEXkP
1sfRCF0SReMQnoq8jfHdy/HcaNNYAbtWnNEcXqJWX4OvbJ8hd4Rsg/VQTCOpdH7H
kDNhUUbeUbl4EUopc02RQ2IumnvRRkjDX56o/8t+59M2HrPTZQvmadGNh/j1dg8E
/8vDTGnw+h0ggmLLuUNJ7SP64nlp7HTeXzyrR6ojRclTRy8Cgo7Do/6QtSEkGi3q
TWUIdV3sUbbHBj5mSjlRl3GdTQ1rzMhvLJZ/SGbyCh6cJMWRd6jR1dPedkOi8Yqq
JndFknpaiSGMWuMj2YWURINsFrxrygzAi2IygPqUOU9JWkFAgM0c+ZtOmSz7c0SD
jLH9amBp6lyxalETKv0rdFDX6nptlUkUUFYX8bNfnMBj9NiRZFtZYXs77BirK8yh
D3JBnGqjuU3RKb1ySL9C65ktumOywLFS766vbIbhLpLlAUDhJtoBEue5alXcPGVN
wsXYwzn/uN87v8idS5Ld/T+b/PDQwND/CkqqVz2I/I9FpGIt1nLk4azX+8w18pJP
QnMbnqvkljljeq7P/vMZZ9NJ8D6csIFy1InwS8X+B47ZZvra7qBN7IntkI/zcE8U
8gA0ORiYLR/4WJJ56fToWvW0894srvXpF/rx0e0xTpiYM0u4tYo=
=EFpU
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--


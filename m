Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E8EECE587
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 09:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA6F20679
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 09:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZMQM43PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA6F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJaFK-0005Rm-0W
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 05:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iJaE4-0004Ns-JR
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 05:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iJaE3-0003g2-Is
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 05:31:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44611 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iJaDz-0003b4-Vb; Sun, 13 Oct 2019 05:31:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46rbzl4Sbfz9sP4; Sun, 13 Oct 2019 20:31:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570959091;
 bh=i5xS6cPr2WJVD3/YqmmPSLVsXZ5M8GbGBm7P0cdXklU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZMQM43PJjVgP7i63eZxa7Ra+RGIxXqCY0k0darmsdyDGmOBILIozLNv+Ig8U6Bk1h
 A6fh3OZW+P2gEEjyX0ROLCNNScY7AfUuQZVPQQ5jxhNZRp6IZP74F9o5o+cIrHBuB8
 D3tHrQj29ANQECYJWpvaNYKBCZbVMfr/cbK+1ro8=
Date: Sun, 13 Oct 2019 20:28:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/2] core: replace getpagesize() with
 qemu_real_host_page_size
Message-ID: <20191013092841.GG4080@umbus.fritz.box>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <20191013021145.16011-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2019 at 10:11:45AM +0800, Wei Yang wrote:
> There are three page size in qemu:
>=20
>   real host page size
>   host page size
>   target page size
>=20
> All of them have dedicate variable to represent. For the last two, we
> use the same form in the whole qemu project, while for the first one we
> use two forms: qemu_real_host_page_size and getpagesize().
>=20
> qemu_real_host_page_size is defined to be a replacement of
> getpagesize(), so let it serve the role.
>=20
> [Note] Not fully tested for some arch or device.
>=20
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Although the chances of someone messing this up again are almost 100%.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2i7kkACgkQbDjKyiDZ
s5L5RA//fSeFYUbSHTX8CMa1bv1+lCy+cczMxZeOo0BSSRNNYXDhFgdJN4/GEo2r
+2zVy/3qiuwYLPRb+KkuLwX/C42GhLWJuzcoMxm00BlaujRk9W9MMKTkGYBqkKkE
Up/MgLeJcXx0UrcRVVKadCZd4jw7IeC0q9skTlTxCCIoXka8VvCmPsiKu5w/kHpt
NHR1CJ4fFxSMyLbu4ZiuYZOFBSxozoY3eEu4hFolljHEyLBT6gBdPzGmkZ+5ygc7
DxeFbhQjashtQvF4UKOxIRAAchoD9YvvPIbNaRbMpqzYU5EoQGmQH4xw6Dna6oKD
WnjxYSbTd/a48a0bNqzr+nBGmszeZQ2Ab7yWGWliAbTooL73VKz2tn2A31GnF6Ks
/gK19Ap1zuZZ1EsRwBmHY+7EoUiNzd/huTOYnATWbpLRixA/ybpy1ceQCbNOYYEk
/uvurC+IO6HYtm7AKHSosjGjgTl2WalaOBcdnv6wLVokj93UTRrwpwwGD+Oc7uCN
DfrtuomVxqsywtEkcFbfuNmyHuudY5C+4CbOxqowSLPABy3TbCSSE0zXRbUSODLG
JLZFsrXzQ5lFQnoOrsWSJq4qWbcLdZltbIVjnDlm03MFiPzNh0xp74d3evu0gim+
7gnFT3z1QqhF+s/gpeadN5eJ3pIF+BZnYaT68yk8tlDgWkuP88o=
=aM3A
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--


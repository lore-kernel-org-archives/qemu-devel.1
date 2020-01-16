Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A8C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE39D2081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="V7LEhfnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39D2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruYu-0002QN-C4
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iruUR-00059P-5N
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iruUO-0007Zl-Vo
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:02:30 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44989 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iruUO-0007Xg-9s; Wed, 15 Jan 2020 21:02:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ynWh3qFKz9sRX; Thu, 16 Jan 2020 13:02:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579140144;
 bh=UvgGRA4SqQyTnsGRLjS4QbiNZDpLyJWmDs5e+oZJ6K0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V7LEhfnh0V90sn4d3YP2EYxJnuDHPQrYBzUOBZ0nynPGPNLIDnXcGhFxXMJjuKlfu
 BAW2ndoe9FwQhcIZmtN5N26d6iEhGj3R6y/Xk+M6EoZBFvJVd4cUSdz+HV9bG2JM+r
 HvhpraZ8NozyQlKyJnvqyjHzqjDGduP5pqb/sJ6Y=
Date: Thu, 16 Jan 2020 12:02:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 62/86] ppc:mac_oldworld: use memdev for RAM
Message-ID: <20200116020211.GG54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-63-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KR/qxknboQ7+Tpez"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-63-git-send-email-imammedo@redhat.com>
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
Cc: qemu-ppc@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KR/qxknboQ7+Tpez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:17PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KR/qxknboQ7+Tpez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4fxCMACgkQbDjKyiDZ
s5LQRw//cTU1g+EDpO0EO3ULMfA1Sqa6OCfcKRBo22QliyEDy3cj9D/lmsMq/U62
eeetwvVdE80NHcyLeuZhVh9jXGNavVva0CCjeahn9r98mehNpPKVSxB73FPBR5Ru
tjYFo18V/rqC+lh655p7NEaOSa5BaxjW0erBDbALb9BUkYAENBKKzDVkO0zmSTow
INNkyizp5YeUqR9sp7POwAbavaIUmU+98oWSCEUYMXpuYbi2IGebG+3H4p4Oj5jV
dFGkAVHANtAtwlCed9z9YLHWwCyrUiwJH/uqzjLJV6N32LBgCmRDYjp1jgLgKv9y
QA7ouOQiVYkaRk2GzCMq0CcC33IhbPxa4IyoqWxzvxkfgsdtxiHIO9jNf5653RBt
N0qRXa1rlrQO3gILuZu5udX3d0cxc2qJFf/SqZTivX5jMZeN0paOLRpItA3Iy/nD
4fSWcjchGnqygApO5JAs7N/DPZRkv3trYLs5N1YXidneI8kEeleRUQZFyyqDDMlH
XHBNJPnGLZVA5H4o/1Ruut65rrJsjn8M+PDNfnpbNWMGFRmJjR8TQO+4DrfTPx1j
3Gp2WKOdPFjKMdO+YqgSfzp8Y3RWtbr4K7CbBYlbLj5vvHbRzPEMMM0Su7LoC73b
uTshvgG+GrkW0jeCPaKBtMjlSfmGfzabQxQbJm6wGmKvd7vn+4k=
=/2ua
-----END PGP SIGNATURE-----

--KR/qxknboQ7+Tpez--


Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF05BC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD5820859
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W7ANajur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD5820859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0jM-0007mw-L5
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iI0hU-0006sp-Jj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iI0hT-0003pW-2O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:23:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55353 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iI0hS-0003hc-2E; Tue, 08 Oct 2019 21:23:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46nxLL6Z5rz9sPJ; Wed,  9 Oct 2019 12:23:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570584202;
 bh=omIesLsWrUzHgJILZD31gwleqws9rHdnQ+vQwxmJ3TI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W7ANajurC0e1PrfZMmfMsKv9hWeSk0pJtnKiK/37q6WqSJMdEuYuQIJhNBTEsmrrA
 5Bbaks2ejFImjFOtLrjngYSpJg6klPMpmieHXs5duYoAa+We+a9uZJfP/KamRfQJLK
 cJTE0G4a6jSu+JooT2yucAi6xU8rcQRi0by1X484=
Date: Wed, 9 Oct 2019 12:21:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/3] ppc: rs6000_mc: drop usage of
 memory_region_allocate_system_memory()
Message-ID: <20191009012106.GB14281@umbus.fritz.box>
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-3-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20191008113318.7012-3-imammedo@redhat.com>
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 hpoussin@reactos.org, qemu-ppc@nongnu.org, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 07:33:17AM -0400, Igor Mammedov wrote:
> rs6000mc_realize() violates memory_region_allocate_system_memory() contra=
ct
> by calling it multiple times which could break -mem-path. Replace it with
> plain memory_region_init_ram() instead.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Or would you like me to merge this through my tree?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2dNgIACgkQbDjKyiDZ
s5L+bg/+MzXKQscvVmmiS9X/Ll6d+3blgWNj0kmOxd+xEiJJ0izDbRGpmqTr++Im
nXOi7RqQwOX4lMO1tdx5PP2GRqyQ2spUFJw4SYOLlmIiltAkJ5Go7m4PJT09dS0Z
ucOuvYr/d2W1HcYwEfTPC/xIXQ5W5RHFHRjXZ6gXW+AVNwz+2lkp0P+VUTuE95gD
HF48galqAxoi0/Gtbs8AGinfiTOqgCpKRqTrs7Vj4x0xdIumvlyB0bZJZ02mHNv/
eTW2YbpiEzuSuvIiQEpe5/OsqoiXdT5xHM2bbqI8PQcPgSC9+eXOam9fqyttfRjP
xq9FV6yS98csCNMqBRlTsdhT1xHQVZYrfGkWEk0Qz9E3p5DCy0Y+s1Z+hgrogGIr
7Pr7M7U8R0O1F4URAGzmxKlpn92c8hXuDOxqtGDpUH0WvCxcnuGFbYx2OzJqsp1N
DxrVfHKWMi8JHAXizMJbJitFkJEdhRuxVlgVfVg4pp0L5Pq//unB09Dh+RVEd5Gv
LLonYjNrteBtRHasClgRui/dQyppdtGwQWSvqQ9NOC4EbPH/f8ubr8QaIDqt8mEl
AQOkxvwW3Il02XwFt7EzKxEcbKv9TE10eis+JETpc2WNUY1V53JwR7a6U2PFbYQ6
hTLgJsiDrA0yO0DDUzb2fm0IDprXwsySoQr/XB1ZJwe8hQ1hlhc=
=Zrnw
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--


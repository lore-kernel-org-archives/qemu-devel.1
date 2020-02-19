Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79B7C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5DB207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jVhPZ0j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5DB207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Esr-00041L-Nj
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 21:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4Erx-0003ag-TB
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4Erw-0000Yi-F0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:13:45 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:34949)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4Erv-0000UE-7y; Tue, 18 Feb 2020 21:13:44 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Mh8x22Vwz9sRm; Wed, 19 Feb 2020 13:13:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582078417;
 bh=6TqhvC1xJL5opg/J2526jkYsZnBJdoO1j2svJyDHZ2E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jVhPZ0j6n3hGrX18Ev35R3PnQoBp/TeK8bzIJgvnVyCzIDpXh1R62zzed60LpO1qZ
 YtNCvbLCIXqoYTCKGhpe8+mXYtISp06aeRH/lGTDP5eLegg5kgjHhsuG4r3ZId6/0T
 p4GRGcDyhskpiuGZhvy+CwP6UnHBhwbFFBMAuRyM=
Date: Wed, 19 Feb 2020 13:11:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: groug@kaod.org, philmd@redhat.com, qemu-devel@nongnu.org, clg@kaod.org
Subject: Re: [PATCH v3 00/12] target/ppc: Correct some errors with real mode
 handling
Message-ID: <20200219021155.GH1764@umbus.fritz.box>
References: <20200219005414.15635-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
In-Reply-To: <20200219005414.15635-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, paulus@samba.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 aik@ozlabs.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 11:54:02AM +1100, David Gibson wrote:
> POWER "book S" (server class) cpus have a concept of "real mode" where
> MMU translation is disabled... sort of.  In fact this can mean a bunch
> of slightly different things when hypervisor mode and other
> considerations are present.
>=20
> We had some errors in edge cases here, so clean some things up and
> correct them.

Duh.  Forgot to run checkpatch, new version coming shortly.

>=20
> Changes since v2:
>  * Removed 32-bit hypervisor stubs more completely
>  * Minor polish based on review comments
> Changes since RFCv1:
>  * Add a number of extra patches taking advantage of the initial
>    cleanups
>=20
> David Gibson (12):
>   ppc: Remove stub support for 32-bit hypervisor mode
>   ppc: Remove stub of PPC970 HID4 implementation
>   target/ppc: Correct handling of real mode accesses with vhyp on hash
>     MMU
>   target/ppc: Introduce ppc_hash64_use_vrma() helper
>   spapr, ppc: Remove VPM0/RMLS hacks for POWER9
>   target/ppc: Remove RMOR register from POWER9 & POWER10
>   target/ppc: Use class fields to simplify LPCR masking
>   target/ppc: Streamline calculation of RMA limit from LPCR[RMLS]
>   target/ppc: Correct RMLS table
>   target/ppc: Only calculate RMLS derived RMA limit on demand
>   target/ppc: Streamline construction of VRMA SLB entry
>   target/ppc: Don't store VRMA SLBE persistently
>=20
>  hw/ppc/spapr_cpu_core.c         |   6 +-
>  target/ppc/cpu-qom.h            |   1 +
>  target/ppc/cpu.h                |  25 +--
>  target/ppc/mmu-hash64.c         | 329 ++++++++++++--------------------
>  target/ppc/translate_init.inc.c |  60 ++++--
>  5 files changed, 175 insertions(+), 246 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5MmWgACgkQbDjKyiDZ
s5JmrQ//erxTm0guIDSdE2JlHDBBNDrmYYoUh2bt/GpXfe9R01APaAvs3W83ocg9
+mpqe3h+a/oHCRoKRcfkj0Q2bZkqZG0/YTx7rZGfhzzk6l3XF3Z4kAMlxrJTRz42
t2fXM7NWZXZDFUsjwriy8M9NfW976AtP1kDwmk6Uh2xe7jTq2wY/83LWD8r50UJZ
9A4iFupqjn/bn9ej7O6snLOA3ZjDnypgVUStrYAz02nNZM2ArcUko4UPUTjzHIFy
D/+ffhDcZPRK6LEtaA2Wem3N9AsCgXwpP1egIH5zEs/HhVvGH/CWWjTLW/wkv7fT
Ot3lJ9V6tohT7G83NR7gpGEV621HdxDKfDTr3GMNR+QL/AS91eDc7DNWiOCIoY7m
2z2uL8UhvlU3gEobGWR4LPi1G5Yd83TsaPyoFh8/rVDiqBwrvoh7ZBoXTUpE5SaD
QbBTkqUSMexm8KMbQK1r+2OoSha2Pr0LSHzcL7Nfho0qRbjzP7n6nYT/zIlVkcJR
mLGu06V8M9w/SZgEgy7mlgSfqxnP41NKDV9RkafN4O4K9Yd2w8xdR/DDp+GF3f3m
eUGyCI+fmDUg6VgowC1y/Xv79/EaJQG4ZOYmF/T7L3ufxzuxVmVwLCtlVfg70LO0
Jab0p8JvO0PwBtn/Adi0vUWIkdcA0iN1uWmxgkENJCpl7+8rRdY=
=PqVX
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--


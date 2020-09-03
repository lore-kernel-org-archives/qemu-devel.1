Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC6DC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC962072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 01:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ezKEcMMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC962072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDeX9-0004pZ-0m
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 21:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUm-000068-N5; Wed, 02 Sep 2020 21:57:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42721 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDeUj-0005br-1k; Wed, 02 Sep 2020 21:57:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BhkSd0dTVz9sRK; Thu,  3 Sep 2020 11:56:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599098209;
 bh=L9kjWlEMacwJHYyvVJfSDJzzmqnQf5QZ7rGLPn2+aGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ezKEcMMHL0N3wBWI6vtWNUV+JVkiJEPV847NBFfkgs702CnvcObX8Egw9u85zvLZq
 aBeePFnuGlrW1nnzSZ48zFLlTe0FMol9+gkXbY2H0EUPU+c3D2fCWCMsuTisQRnFPu
 xR3HJKEW0SDkk1bv+DQtGsZFP0HMXMlGnUKBkpJM=
Date: Thu, 3 Sep 2020 11:35:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 0/7] pseries NUMA distance rework
Message-ID: <20200903013539.GH1897@yekko.fritz.box>
References: <20200901125645.118026-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 20:05:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2020 at 09:56:38AM -0300, Daniel Henrique Barboza wrote:
> Hi,
>=20
> Following the reviews of the first version [1], specially this
> reply from David [2], I decided to take a step back and refactor
> all the code in hw/ppc/spapr* that operates with ibm,associativity,
> ibm,associativity-reference-points and ibm,max-associativity-domains.
>=20
> A new file named 'spapr_numa.c' was created to gather all the
> associativity related code into helpers that write NUMA/associativity
> related info to the FDT. These helpers are then used in other
> spapr_* files. This allows us to change NUMA related code in a
> single location, instead of searching every file to see where is
> associativity being written and how, and all the soon to get
> more complex logic can be contained in spapr_numa.c. I consider
> the end result to be better than what I ended up doing in v1.
>=20
> Unlike v1, there is no NUMA distance change being done in this series.
> Later on, the hub of the new NUMA distance calculation will be
> spapr_numa_associativity_init(), where we'll take into consideration
> user input from numa_states, handle sizes to what the PAPR kernel
> understands and establish assoaciativity domains between the NUMA
> nodes.

Patches 1..4 applied to ppc-for-5.2.  Patch 5 has some nits I've
commented on.

>=20
>=20
> Changes from v1:
> - all the patches that did guest visible changes were removed. They
> will be re-submitted in a follow-up series after this one.
> - patch 02 from v1 will be reworked and reposted in the follow-up
> series as well.
> - version 1 link:
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03169.html
>=20
>=20
>=20
> These patches were rebased using David's ppc-for-5.2 tree. Github
> repo with the patches applied:
>=20
> https://github.com/danielhb/qemu/tree/spapr_numa_v2
>=20
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03169.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg04661.html
> =20
> Daniel Henrique Barboza (7):
>   ppc: introducing spapr_numa.c NUMA code helper
>   ppc/spapr_nvdimm: turn spapr_dt_nvdimm() static
>   spapr: introduce SpaprMachineClass::numa_assoc_array
>   spapr, spapr_numa: handle vcpu ibm,associativity
>   spapr, spapr_numa: move lookup-arrays handling to spapr_numa.c
>   spapr_numa: move NVLink2 associativity handling to spapr_numa.c
>   spapr_hcall: h_home_node_associativity now reads numa_assoc_array
>=20
>  hw/ppc/meson.build            |   3 +-
>  hw/ppc/spapr.c                |  91 +++---------------
>  hw/ppc/spapr_hcall.c          |  16 +++-
>  hw/ppc/spapr_numa.c           | 172 ++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_nvdimm.c         |  37 ++++----
>  hw/ppc/spapr_pci.c            |   9 +-
>  hw/ppc/spapr_pci_nvlink2.c    |  19 +---
>  include/hw/ppc/spapr.h        |  13 ++-
>  include/hw/ppc/spapr_numa.h   |  32 +++++++
>  include/hw/ppc/spapr_nvdimm.h |   3 +-
>  10 files changed, 268 insertions(+), 127 deletions(-)
>  create mode 100644 hw/ppc/spapr_numa.c
>  create mode 100644 include/hw/ppc/spapr_numa.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QSGsACgkQbDjKyiDZ
s5IRBBAAw2oHsCgOwOxhYGHAPkoaqxMJVSfU1awPOLRkmU+6VoCWE2moTkQU0+dV
NtSFS+ruednclmUrp8vkNfC9BSZe45BttpTLOH7c/1RRrr01GVhy1ZNY1HU0csZS
Hvquuwvy7L/JGrCWMhMv1Uj54SBOJPQgshRGRCIzsGaSpfJlRqSuxU1/82H6vpEc
PBg17SjPOKRTmUlFbEdcCsT3U+Kkv6wzWaOYdxsQ/ktjrOyX8nsKre6K20iKvPvv
ynvILr75BKobBSdLCDQwwdTV1RyVyxm1MKcwtXpEdVzoVosl52K1Xd3jswRDEJFg
tpfHFaJATiDgmtl58c+cKNhzuTSwFU3fqje6CofbAMjUiUD4xlf9qO/wHTsK2wKT
9kENcuHLxZSDJZadUuH0TCD/60KmusxS6Y5kIxsbGzl73d+4gAJn+KrVS1UfA5OY
7ZbqCcIjgP73dNA/Lxr1zzKG/G7Zekndsj43kyBJOb3sz9oUY5bOe1s5ltyuFAnI
/XnaxD62cvIlIXvHqqvxeCx/7/x5IuuL/E/vTRaeTFQsysNQAW4dIoRZDIh4RPso
0ocGDaXIHAJAahdiEeC5j9+MiWHMFr0r2s9txxOabORbbNUxFkTGeQDlpYMuBHat
VtidE3fHCR+amgcMNpxN4fq5nwkwDxvG0FoZqD5maioK443McEM=
=N/8A
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--


Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60BC04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB802082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 06:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lejz+OgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB802082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNXTK-0006cj-RQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 02:51:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRg-0005Oe-2J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hNXRe-00067R-N9
	for qemu-devel@nongnu.org; Mon, 06 May 2019 02:49:52 -0400
Received: from ozlabs.org ([203.11.71.1]:60841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hNXRd-00064y-Im; Mon, 06 May 2019 02:49:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44yCyv3TZvz9s9y; Mon,  6 May 2019 16:49:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557125383;
	bh=5AzrpMq+qrs/WeOSFFlAEtQzl8VSuHv0A8UfCl95Z7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lejz+OgVxpaVVbpKC7t3sUl8g2aEPWkomT2M/KoMaemfuMoGH7hL4JsgHL9ldg0oc
	lXnnenY+t1Ee7dhxwqHfEWalUOm9Rkt/Z2vxIq4MTr4INgVohmw9bHrBX5sSO4CMkf
	X9FM7AaXqIDbT0rly0vNM7+sFkmhU1o71FfIM/7Y=
Date: Mon, 6 May 2019 16:20:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <20190506062023.GK6790@umbus.fritz.box>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cy+5HEalSgyXkpVS"
Content-Disposition: inline
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 00/13] target/ppc: Implement KVM
 support under TCG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Cy+5HEalSgyXkpVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2019 at 03:53:03PM +1000, Suraj Jitindar Singh wrote:
> This patch series adds the necessary parts so that a tcg guest is able to=
 use
> kvm facilities. That is a tcg guest can boot its own kvm guests.

The topic line is a bit hard to parse.  IIUC there are basically two
things in this series:

1) Implement / fix TCG emulation of TCG hypervisor facilities, so that
   a TCG powernv machine can use them to run KVM guests.

2) Have the pseries machine under TCG implement the paravirtualized
   interfaces to allow nested virtualizationm therefore allowing TCG
   pseries machines to run KVM guests

Is that right?

> The main requirements for this were a few registers and instructions as w=
ell as
> some hcalls and the addition of partition scoped translation in the radix=
 mmu
> emulation.
>=20
> This can be used to boot a kvm guest under a pseries tcg guest:
> Use power9_v2.2 cpu and add -machine cap-nested-hv=3Don for the first gue=
st.
> Then inside that guest boot a kvm guest as normal.
> This takes advantage of the new hcalls with qemu emulating them as a norm=
al
> hypervisor would on a real machine.
>=20
> This can also be used to boot a kvm guest under a powernv tcg guest:
> Use any power9 cpu type.
> This takes advantage of the new hv register access added.
> Note that for powernv there is no xive interrupt excalation for KVM which=
 means
> that while the guest will boot, it won't receive any interrupts.
>=20
> Suraj Jitindar Singh (13):
>   target/ppc: Implement the VTB for HV access
>   target/ppc: Work [S]PURR implementation and add HV support
>   target/ppc: Add SPR ASDR
>   target/ppc: Add SPR TBU40
>   target/ppc: Add privileged message send facilities
>   target/ppc: Enforce that the root page directory size must be at least
>     5
>   target/ppc: Handle partition scoped radix tree translation
>   target/ppc: Implement hcall H_SET_PARTITION_TABLE
>   target/ppc: Implement hcall H_ENTER_NESTED
>   target/ppc: Implement hcall H_TLB_INVALIDATE
>   target/ppc: Implement hcall H_COPY_TOFROM_GUEST
>   target/ppc: Introduce POWER9 DD2.2 cpu type
>   target/ppc: Enable SPAPR_CAP_NESTED_KVM_HV under tcg
>=20
>  hw/ppc/ppc.c                    |  46 ++++-
>  hw/ppc/spapr_caps.c             |  22 ++-
>  hw/ppc/spapr_cpu_core.c         |   1 +
>  hw/ppc/spapr_hcall.c            | 409 ++++++++++++++++++++++++++++++++++=
+++++
>  include/hw/ppc/ppc.h            |   4 +-
>  include/hw/ppc/spapr.h          |   7 +-
>  linux-user/ppc/cpu_loop.c       |   5 +
>  target/ppc/cpu-models.c         |   2 +
>  target/ppc/cpu-models.h         |   1 +
>  target/ppc/cpu.h                |  70 +++++++
>  target/ppc/excp_helper.c        |  79 +++++++-
>  target/ppc/helper.h             |   9 +
>  target/ppc/misc_helper.c        |  46 +++++
>  target/ppc/mmu-radix64.c        | 412 ++++++++++++++++++++++++++++------=
------
>  target/ppc/mmu-radix64.h        |   4 +
>  target/ppc/timebase_helper.c    |  20 ++
>  target/ppc/translate.c          |  28 +++
>  target/ppc/translate_init.inc.c | 107 +++++++++--
>  18 files changed, 1115 insertions(+), 157 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cy+5HEalSgyXkpVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzP0icACgkQbDjKyiDZ
s5Jluw/+NQl+tk7l/S2Zmq43Qdt1kIUuXmJZcJ8iYLdIYzMa5p6PVNYvh0l+vuTd
hN3oXFzuMJaHKwdwaJEfmvuM0+c7sy08Fq12MzBmuVqGM1QjArs7m/GUXASvH1R/
7G6ZVdQZ5VCQM+kHsZZMMfW/PZQWMwFG5HfaPcBlxDjmucVCbGI73fCyD/ah3vPg
m/YaZrT9IXyhrjc18YDpbfU8euQyp4VbDSSyjNAQJWLcGdH/6k7VJmzKFR+4K/f4
0kYxZwDFkMd+OCtqlU4Mc7LHvSm2np2TTEbs2mVA8LWllt2n0f5V6zUa0liz0nUZ
376N6Rz7SwenVNQYeILax1QQ37pO463TCLXZcU+Ds7p36QmVnLBaLMqVV6s6etT8
jCpUvTdHYv3Es6mIEWzTNnwlPKqSzHj9RszVNCcy0Suux3W6Q0JFVsIq5Nokdrrj
1dwz2JBLhm8JhFu3oXS/CkDstM+FVlspfNUY99rmqUc5SEX4VruZf+6gjuL+n0Ky
INzAQIhRCAFycNJINI4jIczjaV+Gc1Cfze0xjs0+BoKVEiTD//nvAIi06hXU/+Mr
rzVg17grsnfb61M1h+6D2AVR09jQBZ6Al/AHgKMIv3g1wOL+WXf8bqtAF5k3MJhK
F2A3LmAk1DEFCCyP84MR/msslYspddZpuQ7kkUf5Mn/9ung0jq4=
=FRms
-----END PGP SIGNATURE-----

--Cy+5HEalSgyXkpVS--


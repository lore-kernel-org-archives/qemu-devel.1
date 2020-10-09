Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 00:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B89A22253
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 00:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z0wXBeQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B89A22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQgDv-0002R7-US
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 20:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQgCH-0001rI-F5; Thu, 08 Oct 2020 20:23:46 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQgCE-00028m-KR; Thu, 08 Oct 2020 20:23:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C6phQ5GdQz9sTL; Fri,  9 Oct 2020 11:23:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602203014;
 bh=eZyZ7FinAJn+aSBNCJkunlG5RQml7mt7/AxIurY1wyw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0wXBeQqImi8i+KMAzTxj2EHo9ovwUTnMlHDEg5kbw9cIlSMSzOql7xinBRpLjxu8
 sQ44Xrcb2b9K6JMxJdZINvEuTdL+FojLJpM2KKxXcojJ9SzPPieOMMQ2HFE/FxAQ3+
 8JQc6YgSKIVx1IGDDMYd8PjgPqEc1asFZvQjmNrU=
Date: Fri, 9 Oct 2020 11:23:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 0/6] spapr/xive: Activate StoreEOI in P10 compat guests
Message-ID: <20201009002326.GB1025389@yekko.fritz.box>
References: <20201005165147.526426-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20201005165147.526426-1-clg@kaod.org>
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 06:51:41PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
> When an interrupt has been handled, the OS notifies the interrupt
> controller with an EOI sequence. On the XIVE interrupt controller
> (POWER9 and POWER10), this can be done with a load or a store
> operation on the ESB interrupt management page of the interrupt. The
> StoreEOI operation has less latency and improves interrupt handling
> performance but it was deactivated during the POWER9 DD2.0 time-frame
> because of ordering issues. POWER9 systems use the LoadEOI instead.
> POWER10 has fixed the issue with a special load command which enforces
> Load-after-Store ordering and StoreEOI can be safely used.

Do you mean that ordering is *always* enforced on P10?  Or it's a
special form of load that has the ordering?

Also, weirdly, despite the series being addressed to me, only some of
the patches ended up in my inbox, rather than the list folder :/.

> These changes add a new StoreEOI capability which activate StoreEOI
> support in the flags returned by the hcall H_INT_GET_SOURCE_INFO. When
> the machine is using an emulated interrupt controller, TCG or without
> kernel IRQ chip, there are no limitations and activating StoreEOI is
> not an issue. However, when running with a kernel IRQ chip, some
> verification needs to be done on the host. This is done through the
> DT, which tells us that firmware has configured the HW for StoreEOI,
> but a new KVM capability would be cleaner.
>=20
> The last patch introduces a new 'cas' value to the capability which
> lets the hypervisor decide at CAS time if StoreEOI should be
> advertised to the guest OS. P10 compat kernel are considered safe
> because the OS enforces load-after-store ordering but not with P9.
>=20
> The StoreEOI capability is a global setting and does not take into
> account the characteristics of a single source. It could be an issue
> if StoreEOI is not supported on a specific source, of a passthrough
> device for instance. In that case, we could either introduce a new KVM
> ioctl to query the characteristics of the source at the HW level (like
> in v1) or deactivate StoreEOI on the machine.
>=20
> We are using these patches today on P10 and P9 (with a custom FW
> activating StoreEOI) systems to benchmark interrupt performance on
> large guests but there's no hurry to take them. Let's discuss this new
> approach.
>=20
> Thanks,
>=20
> C.
>=20
> Changes in v2:
>=20
>  - completely approach using a capability
>=20
> C=E9dric Le Goater (6):
>   spapr/xive: Introduce a StoreEOI capability
>   spapr/xive: Add a warning when StoreEOI is activated on POWER8 CPUs
>   spapr/xive: Add a warning when StoreEOI is activated on POWER9 CPUs
>   spapr/xive: Enforce load-after-store ordering
>   spapr/xive: Activate StoreEOI at the source level
>   spapr/xive: Introduce a new CAS value for the StoreEOI capability
>=20
>  include/hw/ppc/spapr.h      |  5 +++-
>  include/hw/ppc/spapr_xive.h |  1 +
>  include/hw/ppc/xive.h       |  8 +++++
>  target/ppc/kvm_ppc.h        |  6 ++++
>  hw/intc/spapr_xive.c        | 10 +++++++
>  hw/intc/spapr_xive_kvm.c    | 12 ++++++++
>  hw/intc/xive.c              |  6 ++++
>  hw/ppc/spapr.c              |  1 +
>  hw/ppc/spapr_caps.c         | 60 +++++++++++++++++++++++++++++++++++++
>  hw/ppc/spapr_hcall.c        |  7 +++++
>  hw/ppc/spapr_irq.c          |  6 ++++
>  target/ppc/kvm.c            | 18 +++++++++++
>  12 files changed, 139 insertions(+), 1 deletion(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9/rXkACgkQbDjKyiDZ
s5KiAhAAm6s6EUIjOjma0r4Ko4eVOa8Tdtrk2UzKuPrh2EmfU/keVSZWplNhwQiT
FBbbqEe6fRwcusNrz8Eo+aqdKd1D+lQxYy7NOdOqrbL+k2w5hiA+3GDAE/tjFz9u
K6T1QeFKVi9Mpt1BS9Eboi+6bQSs6SGjTn/OKSuF3JuFhFtB24QfgnnZMxI2uvjY
IQVrB/9gwAZ2iT5UbAlYWG0wU1nN3iQ1hUc0FDdHFobwkgcA6o+Eb1CsrKqtifmu
rxiHs2xgZ7TR9YsY6+10OXxg7Kt1HeMcZtM+wAcm1xfknzM+fezM5OqZSyppxT18
lw5I2BAi68x3gV5p69Iy0lO/9tiJU1FXNeqtObE0zwN7kY3gUFo2W+7yNGN2dgHE
uja3uZJFhBs7mNfrTjR1qxbvRmbVOdy7h6Ho5FgLJVllTHeBqqstdcC6MoOkdNsX
3jBhkl6UMzs7vMJZM54jZuVji48rRhsNxB9jQc/mw58gjUjb765fdLNCwhrz6Kzr
AZg/KgGhxlx65Hx4nHQ4hkrbjLm8F9CsKeQsZNbNojMNNM2H2rpyHP8Ybvo5hmYV
mXxPwlr3+twwK2CMjThUBR7VwCQ+ReAweYoYxk/5MLNbKvhURNu9a1MLYtjl4dso
Or1DCACfzWHitr800bcp256y4CQKmI4qC7DOPO0BRmg0JvPH22Y=
=GSNv
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--


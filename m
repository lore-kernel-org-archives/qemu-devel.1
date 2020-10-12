Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63894C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B640E2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 05:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C3H/Kjkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B640E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRqj0-0006kq-NJ
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 01:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRqiB-000606-SH; Mon, 12 Oct 2020 01:49:31 -0400
Received: from ozlabs.org ([203.11.71.1]:33673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kRqi8-0007Ix-PR; Mon, 12 Oct 2020 01:49:31 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C8nn04GKKz9sT6; Mon, 12 Oct 2020 16:49:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602481764;
 bh=5myDoT9glAj6UIQl/rhiWg36DL4weyBKQNx5WXxr/44=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C3H/Kjkn7nz+f2bicfCqvKL0Nks0AGD1K2SxU26O+BH9CSfSPX4UWoWu9KEElrMcw
 pKXBMnnrqcBZ84O9COeyhjbNQfKPWfWOMhoZ9o0ThR93wJ92JWuoUwLfJNSqBB+B+P
 a4QkhopqRN1TBY50ltNvJKLQoW+E5bryXzbGxvI4=
Date: Mon, 12 Oct 2020 16:38:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 0/6] spapr/xive: Activate StoreEOI in P10 compat guests
Message-ID: <20201012053846.GE4787@yekko.fritz.box>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201009002326.GB1025389@yekko.fritz.box>
 <5a3af480-8e84-ddb8-e40e-e3050f6c2978@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <5a3af480-8e84-ddb8-e40e-e3050f6c2978@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2020 at 07:57:32AM +0200, C=E9dric Le Goater wrote:
> On 10/9/20 2:23 AM, David Gibson wrote:
> > On Mon, Oct 05, 2020 at 06:51:41PM +0200, C=E9dric Le Goater wrote:
> >> Hello,
> >>
> >> When an interrupt has been handled, the OS notifies the interrupt
> >> controller with an EOI sequence. On the XIVE interrupt controller
> >> (POWER9 and POWER10), this can be done with a load or a store
> >> operation on the ESB interrupt management page of the interrupt. The
> >> StoreEOI operation has less latency and improves interrupt handling
> >> performance but it was deactivated during the POWER9 DD2.0 time-frame
> >> because of ordering issues. POWER9 systems use the LoadEOI instead.
> >> POWER10 has fixed the issue with a special load command which enforces
> >> Load-after-Store ordering and StoreEOI can be safely used.
> >=20
> > Do you mean that ordering is *always* enforced on P10?  Or it's a
> > special form of load that has the ordering?
>=20
> It's a special form of load that has the ordering, only on available=20
> on P10. It's a no-op on P9.

no-op as in the load will have regular semantics, or as in the whole
load won't do anything?

I assume this meanse XIVE code needs to be updated to use that special
load for all accesses to XIVE registers...=20

> Linux commit b1f9be9392f0 ("powerpc/xive: Enforce load-after-store =20
> ordering when StoreEOI is active") introduced the Load-after-Store=20
> ordering offset and P10 support was added in the same 5.8 release.

=2E. which I guess this does?

> This is why StoreEOI should be advertised on P10 compat kernels only.=20
> I would have preferred to introduce some extra CAS bits. that would=20
> have been cleaner than mix the two.

Ok.

> The basic requirement is to advertise StoreEOI when the CPU compat
> allows it. I have used the capabilities to toggle the feature on/off.
> It seemed a clean way to cover all the extra needs :=20
>=20
>  - switch it off on P10 if needed
>  - switch it on on P9 for tests

Ok, seems reasonable

> > Also, weirdly, despite the series being addressed to me, only some of
> > the patches ended up in my inbox, rather than the list folder :/.
>=20
>=20
> Yes. I have received a few ot these :=20
> =20
> The original message was received at Mon, 5 Oct 2020 12:51:56 -0400
> from m0098419.ppops.net [127.0.0.1]
>=20
>    ----- The following addresses had permanent fatal errors -----
> <david@gibson.dropbear.id.au>

Drat, I guess ozlabs.org fell off the net for a while.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+D6+UACgkQbDjKyiDZ
s5L8rBAA1jUJoHK/udp5MMWNfZ8SztIMFgni7muInfQ5eHvl3ZW0rmCgqPYxTR35
Hgsc3gMwgVmWuBLEMXrkUhIuP+q5PDDUPKxkjsNFS3tdoKyU7KBMxJ9FVQAWGptx
k21lBxRt6ORJrYUysmEuNJp4DW5RIxwLXe1i/UzMC+cmx58Ca3L4AD8/8nYjwnVM
DzhFw9RZ0L7NfH+dKOoN4TqVADLdSPW+t46TsGXBr6OzYouH+I2fbrvQvaCEXodS
EbEUZglW9sMFDaVOlqxLBI3WM483Q7F6KG6DE2KKJ6MnNHVkIkhrqo67Dq2OoCzS
T2QXpdBdKsJ1oc3ztmBR8XEaiObUAYdxKKNL/RLzp4pqU7bE2oh0D9728h1EXLrI
JoPx7dJ9ojEaZB8z2QuuFJGs3RG6LbHkfPajK7JP5xeNo1A8DHfyxtWeGAhlKQhO
CBs+aujpsUevpHxBaO1DJ0kH7DcLF6kuzmYEvdBIr2zSM4VILrEqcj5D9JJgXryk
WsBFCjbAzgU4530akOviIkwE/4foYaXNbaBIIX3mhV2g8VD2nsr7Q+C8OqFAp827
oIiPyGGNVOTm9prnQKI903d7ZjyhUHtejk3O+6ydYcFKxh3G9SzZ2+84Lj9TjJjM
JFAPokNFE5SKmvRxIiHu7trT9xgw0C/YUqnFm4zAT2j7Tw7eWJ8=
=vnGP
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--


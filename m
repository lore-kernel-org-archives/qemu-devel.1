Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02987C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A04206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 05:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="D9lFVuMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A04206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic0MV-0000Gt-SV
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 00:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ic0KX-0007Oy-9L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ic0KV-00049f-Is
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 00:02:32 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40273)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ic0KU-0003pA-DC; Tue, 03 Dec 2019 00:02:31 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Rqbd72Jmz9sPc; Tue,  3 Dec 2019 16:02:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575349341;
 bh=JjFoV+RXokaAW4KKNxbvYftke8uAdxpm3p7e36LKn6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D9lFVuMOAQtUmTjvGBt1cxekT8C4i91jP8Rq2u6qMi5qXaJCQ5/UWPecOOsrxGzB2
 +djaPkVPUAQQLqqLJxXLK+2bgvfKnsQdqk0snvoEuCQ1ttsapK/NhyK8yIXXAmR70y
 6m4E9OwKCHUJExVLjp1FfLIbp4cJRwHSmIMfafw4=
Date: Tue, 3 Dec 2019 16:00:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [for-5.0 0/4] spapr: Improvements to CAS feature negotiation
Message-ID: <20191203050055.GF37909@umbus.fritz.box>
References: <20191129053356.232413-1-david@gibson.dropbear.id.au>
 <d2be7503-63d6-c8aa-16ba-b9483106481c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
In-Reply-To: <d2be7503-63d6-c8aa-16ba-b9483106481c@kaod.org>
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 groug@kaod.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2019 at 08:05:13AM +0100, C=E9dric Le Goater wrote:
> On 29/11/2019 06:33, David Gibson wrote:
> > This series contains several cleanups to the handling of the
> > ibm,client-architecture-support firmware call used for boot time
> > feature negotiation between the guest OS and the firmware &
> > hypervisor.
> >=20
> > Mostly it's just internal polish, but one significant user visible
> > change is that we no longer generate an extra CAS reboot to switch
> > between XICS and XIVE interrupt modes (by far the most common cause of
> > CAS reboots in practice).
>=20
>=20
> I love it. thanks for removing this extra reboot.

Glad you like it.  I've folded this into ppc-for-5.0 now.

>=20
> C.=20
>=20
>=20
> >=20
> > David Gibson (4):
> >   spapr: Don't trigger a CAS reboot for XICS/XIVE mode changeover
> >   spapr: Improve handling of fdt buffer size
> >   spapr: Fold h_cas_compose_response() into
> >     h_client_architecture_support()
> >   spapr: Simplify ovec diff
> >=20
> >  hw/ppc/spapr.c              | 92 +++----------------------------------
> >  hw/ppc/spapr_hcall.c        | 90 +++++++++++++++++++++++++-----------
> >  hw/ppc/spapr_ovec.c         | 30 ++++--------
> >  include/hw/ppc/spapr.h      |  4 +-
> >  include/hw/ppc/spapr_ovec.h |  4 +-
> >  5 files changed, 83 insertions(+), 137 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3l7AQACgkQbDjKyiDZ
s5Kj5Q/+NOhDlKPpYuwANUNZYzzsOqzT6LT++/6hPuo3OUi4kj55i68tGQ/0nkNQ
b/MvwDJQIATgPn5z3PJQhtwvLFAJli0Gg5ZNlOuby3P+BOaqI4k2qB5vhr7VgCHV
BUIVUiE57cbZ+iscO0hTpXVVcNzLx6VPtWIyjgNQp3iQtwnTPa4ffZJtCJICIeae
SuL+i7+u0Ij+MrRYcir/v+kuCpAZQdrr55IDuo1OxU2GVPefRPF0J6ki/1kSWf7U
4sa7zYtkOM9POYUKrLSBA9eXE/vlX3iWYV0NgRKHqCT/CmuyZlacRX73c4Y6MwFN
hIE9Rf24N6q2/Wc8thaY1n8sNIlWJiH4umulTNjXymjKF2cz1PDwy0iTXoKa5kio
TvphOkyJj2WqbprQtkMp2vxaQsrVZ/P5PkF0//xDA5qGufptnMZKr35J+FASwJob
NjIIRDu4fACnxAD10FyfzvY9ZyvOctD0rYhBUGcLN6mLJANEOdSMrRCmXa1hEclj
wb/gXHq3d2hmphECSj3Yz7FgnHVKVB0HqaiBnCIlxesO+1qF7BBOw3lwWm5c4qjA
NUQ6ipoUUGpbsKTnSH4uA+q4PMKWaO2PyqiJZad5KaKtjOTrrM33OKMQGhPCOTz2
TsOA/lm7EOxlf1Z2vKScjjAGCgj/S9nJxr3RR3oDBlEh3RE8Abs=
=vF6n
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--


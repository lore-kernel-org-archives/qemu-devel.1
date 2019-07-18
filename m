Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F9C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942722173E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 06:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FpoDl4gO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942722173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnzUR-0003Bh-DJ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 02:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41770)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSw-0006p2-8r
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnzSv-0004Gt-1D
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 02:00:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50799 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnzSu-0004Dy-Dp; Thu, 18 Jul 2019 02:00:28 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45q3QC3kXBz9sP2; Thu, 18 Jul 2019 16:00:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563429619;
 bh=uRbvMadIOUDNc2xjUds8EQdtFeCFH46l0RRHao+iwoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FpoDl4gOKO/hlwcX8GpecFfym9yp+Gq7KrujtXKkl3QjvKz8Ut4FguWaccxDlZSPU
 uqi64APrWYZEX9iR/eRzXt5kY0uAJ9LBvc4VM+6xvrPju9KpU/NcxozLoffH6j8OGQ
 MTsxdxOe9hRyleUODXrDPOqdcJEPr+4yY3DELGiM=
Date: Thu, 18 Jul 2019 14:37:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190718043743.GJ8468@umbus.fritz.box>
References: <20190717205842.17827-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYo4Elh1vtcYNvbq"
Content-Disposition: inline
In-Reply-To: <20190717205842.17827-1-mdroth@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH for-4.2 v2 0/2] spapr: Implement H_TPM_COMM
 for accessing host TPM device
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zYo4Elh1vtcYNvbq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:58:40PM -0500, Michael Roth wrote:
> These patches are based on ppc-for-4.2 and are also available at:
>=20
>   https://github.com/mdroth/qemu/commits/spapr-tpm-hcall-v2
>=20
> This patchset implements the H_TPM_COMM hypercall, which provides a way
> for an Ultravisor to pass raw TPM commands on to a host's TPM device,
> either directly or through a TPM Resource Manager (needed to support
> multiple guests).
>=20
> Secure VMs running on an Ultravisor have a symmetric key that is
> encrypted using a public key that is bound to a trusted host's TPM
> hardware. This hypercall provides a means to decrypt the symmetric
> key on behalf of a Secure VMs using the host's TPM hardware.
>=20
> More details are provided in the spec summary introduced in patch 1.

LGTM, applied to ppc-for-4.2.

>=20
> Changes since v1:
>  - use separate hcall table for SVM hcall range (David)
>  - document reserved hcall range in ppc-spapr-uv-hcalls.txt
>=20
> Changes since RFC/v0:
>  - configure TPM path via -device spapr-tpm-proxy instead of -machine (Da=
vid)
>  - return H_FUNCTION (not H_RESOURCE) if TPM has not been configured (Dav=
id)
>  - drop use of global for storing TPM FD (David)
>  - fix checkpatch errors relating to case statement indents, newlines in
>    error_report(), and lines over 80.
>  - fix some minor typos in documentation
>  - rebased on ppc-for-4.2
>=20
>  docs/specs/ppc-spapr-uv-hcalls.txt |  76 +++++++++++++++++++++++++++
>  hw/ppc/Makefile.objs               |   1 +
>  hw/ppc/spapr.c                     |  33 +++++++++++-
>  hw/ppc/spapr_hcall.c               |  13 +++++
>  hw/ppc/spapr_tpm_proxy.c           | 176 +++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++
>  hw/ppc/trace-events                |   4 ++
>  include/hw/ppc/spapr.h             |  11 ++++
>  include/hw/ppc/spapr_tpm_proxy.h   |  31 +++++++++++
>  8 files changed, 344 insertions(+), 1 deletion(-)
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zYo4Elh1vtcYNvbq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0v95cACgkQbDjKyiDZ
s5Jacw/+PWzg7MhVKJcdzuTDI1EJbxiR+wL9xkfwh3RhFiDCVmxh1Z67LFx3imZg
SecG31rX0ca36eNvTwEzRvzT9BOV4kEVwURmdYjeJs3e2VTWZuIrTJ9Z5Fab6bD5
XVOruNi+hfegMBb2DN/H6i9ZRdHFM0AtoNXd1WRe3HRJ24gtl3mWy1cjG3tLPzw/
W3ZxwjKXHWyhAdNVZHISBugKtxePYUBkjXFwL5n76JARi+Uoadr/9GwhcCzlwDZm
CsgKSGPMbrWng7zUZQAiIeXo6FKaHlz8V5upMk7LecArgYMMe0B+Mlxibs9xlbET
Ni0uxoq1NC9D4nP1cB4K11elqy35msk1MUfI2F46qwkNAnJN+9gdb3MEBvtfKgD2
BQvojRXEuHnhYsXD1gquJMWcqq/imR7Z9Ynoohx0LOC7l/c435KYxxa/vRkLCwql
IXJMO+tuBbcxmJ3AJwELSxUecVHLvysZaGAaqpU24d9AHd05CSug+HXdGNVCPQCl
rwIEQNBvdXpArvgym/2XReLHr3Q2zrOiig6DQmYSAa6GR6YnCqPHTt40RvKp7JP3
L8PW+piXaAgv21AfpJRr9EeBxMKq6qxTnG1wv0u6w+4V//pqbJd1tfZSwHmTGjry
LxupZkDuhHIhgC3aJY1aTKSwxdFxbIYfdkvJxp7Fs35p3RRwS2c=
=Tx7G
-----END PGP SIGNATURE-----

--zYo4Elh1vtcYNvbq--


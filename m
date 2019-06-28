Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222C5C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 05:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A4F2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 05:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZcvTmxpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A4F2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgjhL-0002YG-LT
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 01:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59245)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hgjet-0001uv-9R
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 01:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hgjer-0002Si-Rn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 01:42:51 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56433 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hgjeo-0002Nb-O8; Fri, 28 Jun 2019 01:42:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Zlyt244nz9s9h; Fri, 28 Jun 2019 15:42:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561700550;
 bh=R+M9t5t2RitVBAOlYO59XECQWoLbmBKbkrVGcvOgSg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZcvTmxpgW6P6GYqyDq+HNgcrbZyodj+eSY7DVUPa9Mc/pDBxz/ZA8le7ZENWpxDML
 ocNTZyJPR2PLAg6AnBtSzCHuCwa1LxNHO0VUaAhgROCxUTzqmYIS/KFdcpWoFiSCuq
 EMhdzwEtEXrMCvqURtZk4LaIces1Hdaeq/0wkhOo=
Date: Fri, 28 Jun 2019 12:33:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org
Message-ID: <20190628023343.GE3340@umbus.fritz.box>
References: <20190626051903.26829-1-sjitindarsingh@gmail.com>
 <156152750324.6332.18067610008811555832@c4a48874b076>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <156152750324.6332.18067610008811555832@c4a48874b076>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v2] powerpc/spapr: Add host
 threads parameter to ibm, get_system_parameter
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
Cc: qemu-ppc@nongnu.org, groug@kaod.org, sjitindarsingh@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2019 at 10:38:24PM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190626051903.26829-1-sjitindarsin=
gh@gmail.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:

Suraj, please fix up these style errors.

>=20
> Message-id: 20190626051903.26829-1-sjitindarsingh@gmail.com
> Type: series
> Subject: [Qemu-devel] [QEMU-PPC] [PATCH v2] powerpc/spapr: Add host threa=
ds parameter to ibm, get_system_parameter
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Switched to a new branch 'test'
> 83350a8 powerpc/spapr: Add host threads parameter to ibm, get_system_para=
meter
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> ERROR: braces {} are necessary for all arms of this statement
> #42: FILE: hw/ppc/spapr_rtas.c:243:
> +    if (!kvm_enabled())
> [...]
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #47: FILE: hw/ppc/spapr_rtas.c:248:
> +    if (!dir)
> [...]
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #72: FILE: hw/ppc/spapr_rtas.c:273:
> +        if (subcores)
> [...]
>=20
> total: 3 errors, 0 warnings, 71 lines checked
>=20
> Commit 83350a8ff0c8 (powerpc/spapr: Add host threads parameter to ibm, ge=
t_system_parameter) has style problems, please review.  If any of these err=
ors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20190626051903.26829-1-sjitindarsingh@gmail.com/t=
esting.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0VfIQACgkQbDjKyiDZ
s5Know/+LAxuWBA6z13RHtMpIyEyS2DUawjvtKj2gUjs9RVcbvkihbRTLt9cVl3+
K1Oz0cjEe/GKRwZcn6CN3Th0BYBNO77KoyZ460O/GUmPQ/DPWd1y6+Yuja73cm38
tu6LKbhYjELzQGUqi9d/XR4m8kpHkWqz0PbK8gfDxKtxL/wApPq5ijkQLMbj0HfY
w366wCkB6SWb1nN3lGoKIAvv+Wr5/zM9MGExzV+tii/1vi5NuB/DiWMsNvTsPgQG
DymdlwxYPz72XNzjskymRFnyzI0Y2qbFWhH7JsP72GruNePS/fLBLV3HRUcGbcjy
gePxhDsexbQRfPI/RzH7Rf/a3SxAXXdxA7SKP3b9O8Sm2gWkJHdMo0AqjCJaAAio
mNqcL2/rb00/ZekDj/MpwsT6OUVIYSEIdgQ1B2gw75J3bEm6OS+O+Z42rgN9RKB/
Iyrc6l/UbkTjLyIpuYUmuFpP5znHoeGcU9jtYCXParyF3iCv3jdJ3SMff7J21wo9
/fShCPRKVigj5ZEUZT4ZIk4qEKLXLfLPJ6Ohn7he52Jq2HOZQedvzMp63d0WcNwB
GZlyhBJuooAnjMDP/f2SYgdFH25wwLo9N5yTGNgL9yx7AESwr77MsvOsqso+WSQj
6itgh1mEqkHklziEl+3ZlOOVCfkpV3C/2Dvggf02w4PgpW8SF+U=
=lXr5
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--


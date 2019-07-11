Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9FDC74A41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606B720838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KN3J0QGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606B720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlP3p-0008HC-M1
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 22:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlP2l-000732-Dj
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlP2k-00070l-1V
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:42:47 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42675)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlP2i-0006tv-LC; Wed, 10 Jul 2019 22:42:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45kgMC2Lhxz9sNg; Thu, 11 Jul 2019 12:42:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562812951;
 bh=L36pk57Ays0W3IeGJUyNi4oUwm9EpnL5Xz2FF9hJoVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KN3J0QGL9Jn4CkQqMNza/F5AGjyJE+rll7YKhrfm80bSh27IJxPWOoHygU3Z2N9yE
 qmYGHwhV0Hoj510YJl6USvuVIZFecAZql9TFErF8FdMmc84OSzjuOcj8iVk7GD50To
 NWi8KVphxDu13BWKsRlc3BvuYsmUgRgnZgD3FTxw=
Date: Thu, 11 Jul 2019 11:31:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-devel@nongnu.org
Message-ID: <20190711013116.GD13271@umbus.fritz.box>
References: <20190710060621.16430-1-bharata@linux.ibm.com>
 <156273913241.3386.15746188914180946036@c4a48874b076>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <156273913241.3386.15746188914180946036@c4a48874b076>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v0] ppc/spapr: Support reboot of secure
 pseries guest
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
Cc: qemu-ppc@nongnu.org, linuxram@us.ibm.com, bharata@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2019 at 11:12:13PM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190710060621.16430-1-bharata@linu=
x.ibm.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 20190710060621.16430-1-bharata@linux.ibm.com
> Type: series
> Subject: [Qemu-devel] [PATCH v0] ppc/spapr: Support reboot of secure pser=
ies guest
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
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20190710060621.16430-1-bharata@linux.i=
bm.com -> patchew/20190710060621.16430-1-bharata@linux.ibm.com
> Switched to a new branch 'test'
> 636a27f80f ppc/spapr: Support reboot of secure pseries guest
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> ERROR: code indent should never use tabs
> #79: FILE: target/ppc/kvm_ppc.h:207:
> +^Ireturn 0;$

Ah, yeah, fix this too, please.

> total: 1 errors, 0 warnings, 42 lines checked
>=20
> Commit 636a27f80f0d (ppc/spapr: Support reboot of secure pseries guest) h=
as style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20190710060621.16430-1-bharata@linux.ibm.com/test=
ing.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0mkWMACgkQbDjKyiDZ
s5IHNA/9HVRJG2L+mwnxvmU1xiFlcsij1Shw08gGGZcP694TwwR5itqWddk6AMxa
C/Wwrs8LBhxDfr37wef+vI8d0oTt0XLL46mRAcpsIMtqXIunCGxuDzX06YAtAFLH
PaffKGcxgzD++5sDSbpFaWFOwvOXNkuCt1kXlU+Z8JANhdOucCH1ohf/q8CrgJ/E
ZmYcQd0ER8BqLI/Ds7Ha6G5bKaqc9CsCygvIi4TLsY6BE/7XxVwBs0tlggVW7Ux5
PIhMBK+LnaPBMdn1Gv7ZG42cAeocf44pwo+czr8nBjh17H8JfQ3rCsk2B06Ryt4+
QSmlc5J6jMIE8KbU/0YbC35/EQ5pM96dh+whvQ8YYVd+eOWlarpzvYvuHz8d4Bgo
W6meGBbkCOlshYdnfK9uAj5UqLdyxEYmSp1Bw+gKIx6GAmS1/htchwIxKtqEpn2Y
i2sGG4iXnuFxIZ8fSKMG8RjGsvuhL0Z86m/NOpEKaPiMpElE2c/MsUgXTuYoxubj
iK+TaGMVr0kzSBOpLhT/XkVcjsdSc6D9LS0lJnXPH+TW9gwInvpMmZhRw3FVBeEh
Go6vokJLChzAJCwJn8QDbSnPdQ9fYE6O0/6ehTsdQ0G+jUX3oBwpd/hPXfYndtQc
1P7a24WPQBX0ooREahQC4MWLkiFMd5QZE4xndjYeTB5DQW2pHlY=
=xO/a
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--


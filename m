Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A53CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EFC20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 07:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eO+57xzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EFC20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMp2e-0003pQ-L9
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 03:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iMp1K-0002Bv-9h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iMp1I-0005Zm-8s
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 03:55:58 -0400
Received: from ozlabs.org ([203.11.71.1]:42045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iMp1E-0005Vx-JS; Tue, 22 Oct 2019 03:55:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46y5R86Vzzz9sCJ; Tue, 22 Oct 2019 18:55:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571730948;
 bh=n0n+iXEVMVOLgS82o4zGz9wZMzeFPz5IgxjHQQqhDHI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eO+57xzrWSQyT5K+nu3iSl6IwHcMkyJ9DCSY23/q+Yx8YBHSQvtd+IyNJHtiapr3N
 SFCglTUpV5HmIGS7MoRsiZgGLYxhfwsvWEzbTaIe3gTFvaFZTC/Nhw40mPdlRYe3+g
 sP9XrPdP3PiZH2hLbVQLijb0f2kIJ0LZZHF7AiI8=
Date: Tue, 22 Oct 2019 18:55:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Marty E. Plummer" <hanetzer@startmail.com>
Subject: Re: qemu/powernv: coreboot support?
Message-ID: <20191022075523.GK6439@umbus.fritz.box>
References: <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
 <20191021053439.GA6439@umbus.fritz.box>
 <f196a1a6-fcbf-f409-e7e7-95b42135c0be@kaod.org>
 <20191022003209.6ssq2ojiv57ixeyd@proprietary-killer>
 <20191022014032.GH6439@umbus.fritz.box>
 <20191022021754.eliz2epsusf4qbdl@proprietary-killer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <20191022021754.eliz2epsusf4qbdl@proprietary-killer>
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 09:17:55PM -0500, Marty E. Plummer wrote:
> On Tue, Oct 22, 2019 at 12:40:32PM +1100, David Gibson wrote:
> > On Mon, Oct 21, 2019 at 07:32:09PM -0500, Marty E. Plummer wrote:
> > > On that note, is qemu-ppc64 currently capable of running LE
> > > firmware?
> >=20
> > Well.. "qemu-ppc64" as such isn't capable of running either LE or
> > firmware, since that's the Linux userspace emulator.
> > qemu-system-ppc64 *is* capable of running both LE and BE firmwares thou=
gh.
> >=20
> Ah. yeah, that's what I meant. Good to know.

Paul Mackerras came up with some magic code that can get you from an
unknown endian state to a known state.

> > Your firmware will, however, need a tiny BE shim to switch the cpu
> > into LE mode.
> >=20
> Yeah, I figured as much, and was planning to have a shim available for
> 'real' hardware in the event a user wants to run coreboot in LE mode
> after both work properly (though somewhere in the OpenPOWER spec it is
> stated firmware must be BE).

TBH, it makes no sense to specify the endianness of the firmware -
it's an internal detail.  The endianness of the firmware *interfaces*
needs to be fixed of course, but not the endianness of the
implementation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2utesACgkQbDjKyiDZ
s5KKRhAAhzbYlSKD/ViieNZ1fr+ZcLd0uKemJ+ZHybD+ROGG+JJkscP+Xwn13Nb3
m/ZDwbGFSDGRK87h47DNVbiFs+kxqRv8tWBQ3MYIIY1VJgL5DPCmzCa4BF4/vxxH
jaiAFpWxVGDHc3G0+m22xq3EIMpx9lCSPCDIteuqUOIkrk2Q//8AKSxCXEZmrDIM
vv5WKTgsjXibzxZrtOjIHekeP6KH/nymHRoT2UnD1dWx3iB/VxbzFdLTeM8SB1CG
wTZvgK5HRQgQSe1Q2E1B8o0LKqpZRB1fQ48wScCUxoVhzTqAee0wnakXzPEJpthi
lUayAKMMwLo+hsvscXAv7WYXsSSDliIJ3Q1++HGxkBVyQD4T6+gTUSygUAyurdR1
TuWAWML5DVOKabYudwIyU1jefa6eYbWLRK23dLSHia21wdwhyI1x/EUIswVs0m0u
253sXkqALl+LooWp4c34oTHbWSfig8F3zWN/rV6M6yIaIlMChnVYcrSqiBDK8OFG
q5on3lg95dV0GySWMOUElkYbq9HDiybYQdNezLcrKornRgyuCgRk8veJcQtQZtdQ
hZuK0rS4ONltqRLR/eloM9JuAtFmkiWsobJLAX/hOCj089lHS/apGR/wsyEnJ3wm
NHq5wU5hErXyy9AQKIHsK64nD3Ud5JbRgwLF7Saxt//7a8ufrIw=
=JKWg
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--


Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FC6C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BCB20862
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 06:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R0ad9FUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BCB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTKTR-0000Ri-RV
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 02:11:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTKSY-00089k-3u
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTKSW-0007x9-Up
	for qemu-devel@nongnu.org; Wed, 22 May 2019 02:10:42 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41653 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTKSV-0007s0-GF; Wed, 22 May 2019 02:10:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4582LL6bHrz9s6w; Wed, 22 May 2019 16:10:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558505434;
	bh=1nhZucqTdtvmS5K4Wz9GNmXKZJLxZ9WXf4I/MrjYIEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0ad9FUG0ETltp3NpR0bC7w2ZCheXJdPCmpmKW9MsgA8Iznzm77NM6RePgSBbkOch
	eT/JKTmHWmnEAFVdBNpeRdUYVgxaY3L+gyvfi9sFAVggaJMtuUGLzX/tZ7H4ObeWd3
	y7dFYNcDkSEek3QDe9G3GlazR0FCbI9AMGEkUPuc=
Date: Wed, 22 May 2019 16:10:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190522061030.GG30423@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<c1d2a4cf-a9a7-4dfa-ed80-987118043f08@ilande.co.uk>
	<20190522061112.3accdb76@kryten>
	<20190522004924.GF30423@umbus.fritz.box>
	<566efe93-c7a5-b821-dcb3-8577d168ea5a@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <566efe93-c7a5-b821-dcb3-8577d168ea5a@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, f4bug@amsat.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	Anton Blanchard <anton@ozlabs.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 05:37:47AM +0100, Mark Cave-Ayland wrote:
> On 22/05/2019 01:49, David Gibson wrote:
>=20
> > On Wed, May 22, 2019 at 06:11:12AM +1000, Anton Blanchard wrote:
> >> Hi,
> >>
> >>> I've now had a bit of time to look through this and I believe it is
> >>> correct, so:
> >>>
> >>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>
> >> Thanks Mark. David: any chance we could get this merged? I can't run a
> >> recent Ubuntu image successfully without it. sshd hangs when I try to
> >> ssh into it.
> >=20
> > I had a comment that was never addressed - it didn't look like the xth
> > and xtl temporaries were initialized after the patch.
>=20
> If it helps, here was my analysis at the time (looks like you were also i=
ncluded on
> the reply?): https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg015=
15.html.

Sorry, I missed that.  Looks reasonable, I think I failed to spot the
generated load instructions which effectively initialize the temps.

This is all at some remove now, can you resend the patch on top of the
latest tree please and I'll apply.  It's missed the pull request I
sent today, obviously, but I know I have some other stuff I want to
get in pretty soon, so I expect to send another one relatively soon.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzk59MACgkQbDjKyiDZ
s5KsVg//czhWoVuPc95xX+XbrMZY7hnccmnx9ylDj0RgJRpJserngqM//FQCL1yu
6w9kgKmntdykK1luFfhyWpK7THtu00rpcztxtyNeDr3TrS0Epwv4fNCAmX+DRX0i
STjFLFyH44qIQevF2fzj7LAMJ9pfp+kf+JxOM58JbJjg9XBJGroTUs3D+w9xHs+x
EGrxSjN9LePRNU4lrovr+XERvPoLux/2/N131vdJmPpu1jJ7al+P+Po2rQK1oblL
RNFF7LzUvFZcnieQXPVV8nRJHKKLLjDk9bw6qy9LU3qy+B2SBlRADvQU+y0g8Reo
yXwQf3zWSBlfZ43pHuHNReqa+sAoqvi/vvTt80cCyGbCLltHcTmnzvOyhxWj73vN
t2nTsyOYBYzAM3CEpn6Lr7p5bNjaeeV4uqMqi+Wfwd0Yfdt0m5ZWDjlDrWgtI6rs
aM2ipsU+ZieMSs9wwc9+tFmf44mMVP2odeQGe4W/CMwhzl7aXxmOi6S6YQP80Blm
FyADwwLTCVspbeGhqrHerdKixZp9ilWEmkTiwiNrl+s245OFFG8GWIEN6wT08rl6
Q21Jb7r6JyEB7ZUknmVQqlow0MdzGUIPF865S8Kl/Faks2+k58hgZQ+FduCmVcYB
s126+Z3+kD9/S9b1Csy2Ebv4n7owSONsjmzkPAo2EkWfShkEbX4=
=V9Mc
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--


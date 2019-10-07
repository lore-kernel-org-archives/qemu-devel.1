Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636AECE58C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 00:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A57E20867
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 00:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A57E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHdDv-00064z-3o
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 20:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iHdC8-0004lh-QM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iHdC6-0006qb-Ux
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 20:17:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48059 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iHdC6-0006ns-45; Mon, 07 Oct 2019 20:17:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46nHwm5szTz9sP7; Tue,  8 Oct 2019 11:17:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570493848;
 bh=w6az1+tXnqrOojP9fY0JZEc37cO536cBdEcbDJQZKuM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i8JVb0DYPDwVUwMeNpKx3IJnfIZtxru8wATBV/Pj3akMj0WeaojNl3TGeD5H5C1uF
 QtSPTWVUsm7Eoe+vC708qTOHwOmDMpl9WufrSkA+Sj0jcLjHFnKY8oWOzZwrSa17yt
 o6dV3FQFDPr//zhvDmNLcBlE7kjREAp0R9uC+Xh0=
Date: Tue, 8 Oct 2019 01:49:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/2] xics, xive: Add some missing comments
Message-ID: <20191007144905.GB18815@umbus.fritz.box>
References: <157045577839.865784.6865959617322519030.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <157045577839.865784.6865959617322519030.stgit@bahia.lan>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 03:42:58PM +0200, Greg Kurz wrote:
> As noted by Markus, the reason why a device type isn't user creatable
> should be documented.
>=20
> These patches can be squashed into the ones that made the devices
> non user-creatable, or applied as follow-ups, at the discretion of
> the maintainer.

Applied and squashed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2bUF8ACgkQbDjKyiDZ
s5JO5w/8C9YTVze16X2LSiH79vupha1Hv5FbN6TCEU2BITbOd54Uay4kgZvFQY6i
7VxoFwTP60nu+5BTn4aViXWvciqFA5SJFQ+W9W9ANYiepBFoOGZdkI9ZckfZIJj3
Dhi706IKQnR9hg2MQ6XRylmZxkxXWNm9TbhPH7Xmghh1eqx3RKqiHgZ2hGICQbcR
Z/0zUT+10u2PiC43XMwqi2SfEhy88lyj5q71sHbsx8NcXx4odAgTotAUSGWiwvK/
utPcVjNB4Ldzjc8U0knA/gbJxLshofdy5+br7aG/p0l3d7fW5eS6awGRBAxzigmT
VMS0V4hHsM6BnysrglYsz0DMz2Q5NcH1pCQa16CGvYaJE9Ra4zm2OiNXGzPoop6c
vyvgzfGnRlzri+ngmWhe65ovVctnMvhP0E5VOmRDJdozzrzQNl4G0XQ0MB41eHRb
FzcAXtW6Jecageu2IAqCQ1oZFl5oR6OxaK/S2c4/t/MqKlMNB87uxweT7Bbfy7DF
dn/qTpmZCM2H9hTpz2nPgdttnWOl7UgswtU5Ez5zP3hFd+JvinszerYtokDfvvNu
N2rn6DyrhNkBie4m0no1bDT84BCZ0EtiytVTwzWdgmq/9HqxJugdWyi2BmepMImH
p1Lncy9hfqE3IbJJi1nc8eUnHcS8Mjuswn0vNColH3oU0yZaZ2k=
=yNN0
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--


Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6BC282DC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 01:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DE427A5D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 01:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PY2mZphD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DE427A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXbTK-0008Jt-DG
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 21:09:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hXbSP-0007xN-4J
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 21:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hXbSN-0006xb-Le
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 21:08:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54983 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hXbSL-0006md-9K; Sun, 02 Jun 2019 21:08:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45HH3S1YnNz9s6w; Mon,  3 Jun 2019 11:07:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559524068;
	bh=DfvDd53JysoWY/e8vExYKB/ePF0lZfka7miP3k+6OPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PY2mZphDj//ffFj4SbEJV6bO59OdVTVTqkzIV22w6YZLkbS72i3tYc/RbVKNg8RaR
	Gh0kQi+81/tTvhpdlK7qQhGR5yS6YKbNgfBlgB07WwT9V/FPRw7uMWg215tV7PRNHZ
	iZyRn4Cmd3uLrNhqL97gVyEwSOKb4Sy1G/d3m71Y=
Date: Mon, 3 Jun 2019 10:48:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190603004827.GA3411@umbus.fritz.box>
References: <20190524065345.25591-1-mark.cave-ayland@ilande.co.uk>
	<20190528010937.GD11618@umbus.fritz.box>
	<9146443d-c5cd-e255-6a18-6bba23b30ec3@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <9146443d-c5cd-e255-6a18-6bba23b30ec3@ilande.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Fix lxvw4x,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2019 at 01:13:44PM +0100, Mark Cave-Ayland wrote:
> On 28/05/2019 02:09, David Gibson wrote:
>=20
> > On Fri, May 24, 2019 at 07:53:45AM +0100, Mark Cave-Ayland wrote:
> >> From: Anton Blanchard <anton@ozlabs.org>
> >>
> >> During the conversion these instructions were incorrectly treated as
> >> stores. We need to use set_cpu_vsr* and not get_cpu_vsr*.
> >>
> >> Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h=
}() helpers for VSR register access")
> >> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> >> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> Tested-by: Greg Kurz <groug@kaod.org>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >=20
> > Applied, thanks.
>=20
> I'm in the process of preparing a VSX fixes branch to send over to qemu-s=
table@ so
> that Anton's patches make the next 4.0 stable release, however I can't fi=
nd this
> patch in your ppc-for-4.1 branch? Did it get missed somehow?

Oops.  I think I must have botched a rebase and removed it
accidentally.  I've re-applied it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlz0blgACgkQbDjKyiDZ
s5IWUQ/7BvFdLTVlVszYEMrkm/9cL+JwvCd5PGfzrgWqgLdXchtm1AAgNpzzcnuH
qREOrR9iIcH/4kDywpCCDbat/831hjptcNOqZaoiuaqO2EXY6QISoSujwn5i8Lpc
j0oHIu854Q7li5mYVgK3pZTU7ImWtNmvIqe+WOPTRntkt8BhaMqeAvNyNrChIurw
NSmJj9ctGczIetZuicv6v5xcIGTmB4Wgv1XWhSST6HbtuVxGqeBqk9zrpM8E/2mJ
MoB7vPZPOhxCkJDqoWsTwvI+YJ2dlxExCdTohAGFRigDXXzf9l9iPV9Ir8zTCTdj
83GmpxJBN8sJJow6CZ30soF/G0CT2FmPnlCXDS+qgqBX9NvOa6PTafg5ithF2E3n
4wc8yCMJ5RQDkHkuF4OZvAjC2dhu45YtT642E/IW1k0WVt7PWex0ZYdgwc6GlRFv
dAjCGj+Aq2lvyU8JCbPQkmlCGGe53acV+80lZfi2lfBRFReKtzrpLvMtCjDaB3/w
a1G63JrateowBZB9MVHehNahAPnUssTfdNW94XF9vITOKUvDW85uEJprGHRenrNX
+6EygNJaPj0znSmhREzeQBv9i/+Ik8aQk6U27uFh65+FXoWRJi89wABsRpAP3HVJ
vjg4qZqQimaAGvjbCvPU/9LXMrmyTmzPvi48ZfIi+EXgX769n0I=
=HY9C
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


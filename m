Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB771C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 03:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7388020714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 03:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Uerv3OL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7388020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGadn-0005Rs-M1
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 23:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGad3-00050k-9O
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGad1-0007vP-VR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 23:53:25 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40981)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGad0-0007lf-Uk; Mon, 23 Mar 2020 23:53:23 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mcm74HMKz9sSJ; Tue, 24 Mar 2020 14:53:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585021991;
 bh=AymHSjGnpuaQEkvvXhDQELtZls3etQ32tkIf4PwTjdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uerv3OL6Hnt8mqAxtoqyFDlp4aMTh7AyD9mgBXoN/qei23iLoZIard0M20z3A6O+0
 LGnCBH9ab13QKUaKV/C/tmoxTSY3joHcXOPeFwfR5sCr19E2wvjbji9Pg/PhTXXPeh
 95N9B6tkov0P9AdzzvtFjlsW91QrtBXuFNjk6t4o=
Date: Tue, 24 Mar 2020 14:44:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH 1/1] spapr/rtas: Add MinMem to ibm,get-system-parameter
 RTAS call
Message-ID: <20200324034404.GC36889@umbus.fritz.box>
References: <20200321003921.434620-1-leonardo@linux.ibm.com>
 <20200323032457.GE2213@umbus.fritz.box>
 <53408dd722b86c69e8b44ba1881bc2053f4ec36f.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <53408dd722b86c69e8b44ba1881bc2053f4ec36f.camel@linux.ibm.com>
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
Cc: ricardom@linux.ibm.com, danielhb@linux.ibm.com, lagarcia@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 07:07:21PM -0300, Leonardo Bras wrote:
> On Mon, 2020-03-23 at 14:24 +1100, David Gibson wrote:
> > On Fri, Mar 20, 2020 at 09:39:22PM -0300, Leonardo Bras wrote:
> > > Add support for MinMem SPLPAR Characteristic on emulated
> > > RTAS call ibm,get-system-parameter.
> > >=20
> > > MinMem represents Minimum Memory, that is described in LOPAPR as:
> > > The minimum amount of main store that is needed to power on the
> > > partition. Minimum memory is expressed in MB of storage.
> >=20
> > Where exactly does LoPAPR say that?  The version I'm looking at
> > doesn't describe MinMem all that clearly, other than to say it must be
> > <=3D DesMem, which currently has the same value here.
>=20
> Please look for "Minimum Memory". It's on Table 237. SPLPAR Terms.=20

Ah, thanks.

Hm, yes.  In the way we manage VMs with KVM and qemu, I don't think we
cal really draw any meaningful distinction between MinMem and DesMem,
so it's reasonble for them to have the same value.

> > > This  provides a way for the OS to discern hotplugged LMBs and
> > > LMBs that have started with the VM, allowing it to better provide
> > > a way for memory hot-removal.
> >=20
> > This seems a bit dubious.  Surely we should have this information from
> > the dynamic-reconfiguration-memory stuff already?  Trying to discern
> > this from purely a number seems very fragile - wouldn't that mean
> > making assumptions about how qemu / the host is laying out it's fixed
> > and dynamic memory which might not be justified?
>=20
> I agree.=20
> I previously sent a RFC proposing the usage of a new flag for this same
> reason [1], which I thank you for positive feedback.
>=20
> Even though I think using a flag is a better solution, I am also
> working in this other option (MinMem), that would use parameter already
> available on the platform, in case the new flag don't get approved.
>=20
> So far, using MinMem looks like a very complex solution on kernel side,
> and I think it's a poor solution.
>=20
> I decided to send this patch because it's a simple change to the
> platform support, that should cause no harm and could even be useful to
> other OSes.

Hm, ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl55ggEACgkQbDjKyiDZ
s5IkVw//e/Kv3KzC8iQop4r0d81NnfgnodQt0ZcQXttjrXrn351ygUDSonr+qZiZ
4O5LuQREo6tqEyw/0HsWs+rWpH4embkpt5DoZ2+8e3bG5zcjVYt7aPuPPF6AK6Vc
z11IbXhqOwgjcO6UjZXsvfGwHx/va1Rmx0fWZrBwEIvhOow65ITvtf/lHkD0pRtY
DsFoZMMaUGwONFmeXEQ+VbieXBsCJeMmUROFJzRAnFaaU77ym4LWDZtTzEhNmQ3/
RySYB+2ikR6zjzImzyva5inJMZqkMe6eHAhodaiY+1kUJrbirVJLNLrLIlaiHyhL
GQrJ+WdZ7SdzLNAJPu1zhx94BEmokAPoOJu9cJqJP5e7pTgJjRdXu0DL3Rjp/w9q
G0d/4yOqX96y/MREKwGvSae/7qHixO/D4jo+RTwptIe/rR6YDW7cE//cYYkDOD6W
K7GkPk/p7+RqjqmmvHkfJmQPIG5bb7RHa40n1IwKgimVt4BBeSAdOVI/ZydG8miI
rI6L0LiKeOZYTr4U4PYqyo9p+vT94ASIeKtx4Isba5UW4FBGJMFo9YCjcQZYxLob
Y5Li98TqiW26+YwcxhwPgPCjCGC50PgnDxXJUS/ZIX1D2TPaa8CeqSHJSFtZgtP2
2laTeYZLOd9mQqrFJ5laL5pd8qKIRrvPRWLZz2f1San5/ATg3Jw=
=vfpI
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--


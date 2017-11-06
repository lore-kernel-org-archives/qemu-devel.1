Received: from eggs.gnu.org ([2001:4830:134:3::10]:57512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBmxj-00051H-Dr
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eBmxg-0000bk-7v
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eBmxf-0000bL-Uz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:21:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C842C5F152
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 19:21:30 +0000 (UTC)
References: <20171106185411.19551-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae73f31f-749a-e02e-d04b-1090e350619e@redhat.com>
Date: Mon, 6 Nov 2017 13:21:27 -0600
MIME-Version: 1.0
In-Reply-To: <20171106185411.19551-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BWpN00LnDIURmO3sesA06hb3FfA4QFQxc"
Subject: Re: [Qemu-devel] [PATCH] .gitignore: remove vscclient
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BWpN00LnDIURmO3sesA06hb3FfA4QFQxc
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <ae73f31f-749a-e02e-d04b-1090e350619e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] .gitignore: remove vscclient
References: <20171106185411.19551-1-marcandre.lureau@redhat.com>
In-Reply-To: <20171106185411.19551-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/06/2017 12:54 PM, Marc-Andr=C3=A9 Lureau wrote:
> It was removed with libcacard.

which was back in which commit?  I'm trying to get an idea of how long
this entry has been stale.

I'm not opposed to this patch, but I personally like to leave .gitignore
entries in place for several releases after they are last useful, to
make incremental builds easier when jumping around between old and new
branches across the point where the file was removed (as long as the new
branch still ignores the file, then building the file in the old branch
doesn't hurt the new branch).  Of course, if I'm that involved in
backporting madness across branches, I'm also fine updating my own
=2Egit/info/exclude for cruft that is built in only one of two branches,
rather than relying on per-branch .gitignore to do it for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BWpN00LnDIURmO3sesA06hb3FfA4QFQxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloAtjcACgkQp6FrSiUn
Q2pJqwgAlQHwC9qyCWRKyRhZYeQizAByGndtoHQ8PbV8In5Ptfgwc9a9Kz+ZjGoI
wFGF7HwwxJxIZqryVkCX19AjYXSVw9NY9X/xcJCFxqBokzDRTIBycXfcB9j1vXIw
97hPeMjJ/au7ET9hh/XTcWO9MuMeqPN4i+f/t5xW60OFFsARzUMQRgG1HW1HDgJL
YMYW6sS8G4bICXenkvhzdm/LbUcc/wtcejeQwi5v0TC2G3ZFFim+Wt4zMqhuEgGC
ElTSeXXAAvMCF9np28xVIdco64oSbstyow4+qkX1JgCn9XrjLajhKjEiX6+ics6D
G7JyjQWJLY4UyPIG/FAO8Aax9Pn9ag==
=nRC9
-----END PGP SIGNATURE-----

--BWpN00LnDIURmO3sesA06hb3FfA4QFQxc--

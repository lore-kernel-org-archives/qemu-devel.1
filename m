Received: from eggs.gnu.org ([2001:4830:134:3::10]:38401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9BT8-0006GJ-Am
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9BT4-0003Ku-DC
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:27:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9BT4-0003Jk-4z
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A5C64074450
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:27:22 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97a758db-dee1-7c23-27db-8b58d6f5d22e@redhat.com>
Date: Thu, 19 Apr 2018 10:27:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180419150145.24795-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hMVOzrheM16r7GyvufnrCoOMo7Wu5SOpf"
Subject: Re: [Qemu-devel] [PATCH v6 3/5] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hMVOzrheM16r7GyvufnrCoOMo7Wu5SOpf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <97a758db-dee1-7c23-27db-8b58d6f5d22e@redhat.com>
Subject: Re: [PATCH v6 3/5] qobject: replace qobject_incref/QINCREF
 qobject_decref/QDECREF
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
 <20180419150145.24795-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180419150145.24795-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> Now that we can safely call QOBJECT() on QObject * as well as its
> subtypes, we can have macros qobject_ref() / qobject_unref() that work
> everywhere instead of having to use QINCREF() / QDECREF() for QObject
> and qobject_incref() / qobject_decref() for its subtypes.
>=20
> Note that the new macros evaluate their argument exactly once, thus no
> need to shout them.
>=20

It's still useful information to include in the commit message that you
did the substitution by sed, then fixed up compiler warnings that
resulted from the new macro implementation being slightly more
type-safe, as well as fixing up a long line.  That way, if someone
backports this patch, they know how to resolve conflicts and/or check
that they are not missing a conversion.

Writing good commit messages is an art form - but in general, if
something was questioned during review of a previous revision, then it's
never a bad idea to beef up the commit message to answer that question
in advance for the next reviewer.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hMVOzrheM16r7GyvufnrCoOMo7Wu5SOpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYtVYACgkQp6FrSiUn
Q2rZEAgAkhWt1rReefQdyNxODUZTznl0CEi5jk/4c6jGNvE8bSqXw8yGfu3dQK/P
Ql4D5lpclcNsDDo1zhmahmHD6CYqDoICF5NSJOnLpm8Ytc2iDwrg8BZlcvBxjWmJ
sUJxyOY/ZWW6E5FunPRmEPudOzjgNFlt/AmPuHWLQ1e35T7ki4PkLFJqNUFY+qfB
Td0UTbgGlYuoayp9+C7o8ssnYLvD1OEb/M1okgCB9EXaOAhp1UNQQ0+8C8a5KS7A
WVCNtv5+CFUMpDq46bJ6tP056jkIn9lmsqwsLX6/xLWShZQiDgsf/IFmf/6GFoQ0
SIkgUj8r62BI3EHOYSfoh5eWZ9RNYQ==
=fEez
-----END PGP SIGNATURE-----

--hMVOzrheM16r7GyvufnrCoOMo7Wu5SOpf--

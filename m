Received: from eggs.gnu.org ([2001:4830:134:3::10]:34232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cer0R-0007rf-MS
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cer0M-0006M6-Om
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:27:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cer0M-0006Kp-GD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 17:27:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 701CA8553F
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 22:27:54 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-25-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ade6214-3ec8-162c-55aa-e71f44a99009@redhat.com>
Date: Fri, 17 Feb 2017 16:27:51 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-25-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oNnHFw0rKqFSh85jRH9Axpel3duoALrAM"
Subject: Re: [Qemu-devel] [PATCH 24/24] QemuOpts: Fix checking of sizes for
 overflow and trailing crap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oNnHFw0rKqFSh85jRH9Axpel3duoALrAM
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <5ade6214-3ec8-162c-55aa-e71f44a99009@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 24/24] QemuOpts: Fix checking of sizes for
 overflow and trailing crap
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-25-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-25-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:26 AM, Markus Armbruster wrote:
> parse_option_size()'s checking for overflow and trailing crap is
> wrong.  Has always been that way.  qemu_strtosz() gets it right, so
> use that.
>=20
> This adds support for size suffixes 'P', 'E', and ignores case for all
> suffixes, not just 'k'.

Yay! Be liberal in what you accept!  (I've always been annoyed that '-m
1g' complains, forcing me to us '-m 1G').

Okay, we're at the end of the series, and I've pointed out other
possible improvements.  As mentioned elsewhere, it might be nice to add
a 25/24 to match coreutils, which allows 'm' and 'mib' to mean
1024*1024, vs. 'mb' to mean 1000*1000.  Right now, all clients of
qemu_strtosz() are stuck to one scale, vs. letting the user choose a
scale by their choice of suffix.  But it does not hold up this series if
you don't like the idea.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qemu-opts.c | 21 +++++++++------------
>  util/qemu-option.c     | 41 +++++++++++++----------------------------
>  2 files changed, 22 insertions(+), 40 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oNnHFw0rKqFSh85jRH9Axpel3duoALrAM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp3jnAAoJEKeha0olJ0NqBigH/R7vn4he7id25dysoYDalts3
wwxBS6nVxG1NIhqZX2WCmiS1/dKHQFxAGUJUr7xwuLqB+++TLGJ4iqLPXd9qwoi2
OWTvBkDazExvRjwhv+nz6MFBE/v1yPhsL5DNf/wd21vJkH9DXKH70hPAq2/UzjNo
lbw3mRdhiHTeJS+f2FTTYIGVlSPt4ueCOlYZOwXmHWFZgICqAZJl5DOprP3BwIG3
+aXQj41k1ZakrJz41S3k0O4zee/ZSvRtameOa/KIIsk36aosAksty3oJweMlq5b/
yFdLGGwOm1reqsS9jZm2SJ8vGvC7cItRc3RJEP0i+BqYduhBPTOXhMw4GjTiMkg=
=RhUp
-----END PGP SIGNATURE-----

--oNnHFw0rKqFSh85jRH9Axpel3duoALrAM--

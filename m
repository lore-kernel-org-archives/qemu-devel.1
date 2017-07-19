Received: from eggs.gnu.org ([2001:4830:134:3::10]:46471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXlUO-0002oA-7U
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXlUN-0007Ft-BX
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:41:52 -0400
Date: Wed, 19 Jul 2017 11:41:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170719094142.GC4617@noname.redhat.com>
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
	<20170719092102.dg6g3qxg6zbmijq4@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20170719092102.dg6g3qxg6zbmijq4@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10] block: Skip implicit
 nodes in query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com, nsoffer@redhat.com, qemu-stable@nongnu.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Cc: qemu-stable ]

Am 19.07.2017 um 11:21 hat Manos Pitsidianakis geschrieben:
> On Wed, Jul 19, 2017 at 10:44:47AM +0200, Kevin Wolf wrote:
> >Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> >nodes above the top layer of mirror and commit block jobs. The
> >assumption made there was that since libvirt doesn't do node-level
> >management of the block layer yet, it shouldn't be affected by added
> >nodes.
> >
> >This is true as far as commands issued by libvirt are concerned. It only
> >uses BlockBackend names to address nodes, so any operations it performs
> >still operate on the root of the tree as intended.
> >
> >However, the assumption breaks down when you consider query commands,
> >which return data for the wrong node now. These commands also return
> >information on some child nodes (bs->file and/or bs->backing), which
> >libvirt does make use of, and which refer to the wrong nodes, too.
> >
> >One of the consequences is that oVirt gets wrong information about the
> >image size and stops the VM in response as long as a mirror or commit
> >job is running:
> >
> >https://bugzilla.redhat.com/show_bug.cgi?id=1470634
> >
> >This patch fixes the problem by hiding the implict nodes created
> s/implict/implicit

Fixed.

> Also, it seems like qemu-stable wasn't successfully CC'd (the patch
> is not in the list archives either).

Ah yes, forgot to actually CC it on the mail. Adding it to this mail.

> Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Thanks!

Kevin

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZbylWAAoJEH8JsnLIjy/WfzYP/igZcFtXH5GU8uRuuUZ41Ano
rKSv7+3tZncV+4wIwe+5qWLsqObUFAOUYCi1XQtrvtsD65vTLC+3KNsTTX4QQBaW
NR3HmWzujRGFmJI/U+EzON85Ut//07XmWG30Cln8IsZv+RI7hhFgdGfPjhzZvWZQ
T7AuLC5AGr5qzU5AeM0mL8t4D6NHcTY27Gluba05jirB584oWX6S8FFULyAogJkN
S/yAhXXlyux55O6o8v6+5pNrbdPc5zwoi9rjSI92Vkitnc9Ct85NVcaa8jBkTjUx
cKkhakp50RJWAF4ckMBXOvirWKKgWzL4ifWRenwdeCCWevRs/Q5Xw+w77GoV0zoq
cArnaqqoptriMvE97lkSo1GBG0AHbBVLDlLqg1OTgqRUMGBsJNgd2eEtLW6haXVZ
9I8UoW5ILkVt8cjXOsJkjS2vv0GSVpY+oF74drJoHLuwdVOHxYFjScF/yUW+TOYK
1BK3v+Mxw8vsmYEzTzqU0XIBEcrIFAAqeRuY65pi6Id8N4Sh6kxypCAiDtFXlDrF
UqNiBLDjQqjKWfwlldnExJ7VMdc4VW0lOPrpKzk6F3AFJlj7bGKrWj3+HG56CHxM
keDnxW0PGgVOVp+EDU9ZD/w7Pob++wVEH0r7nHhP+ybDar1tHwbglAtGmb/gC+fb
8pOdET69dcPFUHhp+WoV
=0C53
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

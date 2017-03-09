Received: from eggs.gnu.org ([2001:4830:134:3::10]:56725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cm24K-0007lZ-U3
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cm24K-0008Li-0x
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:41:40 -0500
Date: Thu, 9 Mar 2017 18:41:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170309174129.GD4910@noname.redhat.com>
References: <1489059542-14232-1-git-send-email-kwolf@redhat.com>
	<8d8b28b7-fd17-64c9-e305-59092f1f5749@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <8d8b28b7-fd17-64c9-e305-59092f1f5749@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] block: More op blocker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.03.2017 um 15:23 hat Eric Blake geschrieben:
> On 03/09/2017 05:38 AM, Kevin Wolf wrote:
> > Kevin Wolf (6):
> >   block: Remove check_new_perm from bdrv_replace_child()
> >   block: Request block status from *file for BDRV_BLOCK_RAW
> >   commit: Implement bdrv_commit_top.bdrv_co_get_block_status
> >   block: Refresh filename after changing backing file
> >   mirror: Implement .bdrv_refresh_filename
> >   commit: Implement .bdrv_refresh_filename
> >=20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Applied to the block branch.

Kevin

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYwZPJAAoJEH8JsnLIjy/WD64QAMgUUCUoFJEJy+xAP8YprpEl
zzUbpuLPVPLq24NV52u2ZwgGT67dPlYgQFmzdu8W7NCEf3qT6N7TcswUZycWEsRL
jj48ZcrTF4kxPtVoOV9ut/Ebxhj1jEMqT8if8k1lYU7CWMhDzzvHE4+TpAW1AGOu
bxDx8hvIw/3Po8cN4cFOiuDgictG47Xm0/fpXQb28nJBpbypzfnEJGCVEsn/0XZ8
r5Fby3VGA+1b/c+Nda8TsLhNcVvTtjcjB+sw1i3ODn56t8VMcVphFmv7AED7oS5A
fLBYT9LUwWkPwYmKIPkr8mwos1miIGTBbuW2ChE+0z0bxHcEI8Gli6tejCVOFk9X
S5vdMPhIdVDdadPBnzZIQlFP05LRpoSsVNNJlhgFLcqmNMB1ztv+xud/6ZwXP1v+
X/som/Cg6HfmO8nZVPhSe3I65c2/4ThK0zcvhyYzZg9EXbeWRVVZdT2zDjN5yZ6x
vGD+9dh0JChJI1uXzzRe7Z8P8kTqOCdhU8u6Hg7NewZv/pTKz7y7tiKnQYCaUBZd
VNBlnfs1RuukleIkyqNzWLyDC3iPdnSLRobqrLL6PfZGbJMLvIRj69CxrE2ZoPqn
5us6s7eSOBVMNAGGZ7XGtp/kaVGGZcp7GHp0Mxx4keXrYavdteDCi0X8ccacJSnS
yLFCZMTKVqwEbKy3VYgM
=Qsrx
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

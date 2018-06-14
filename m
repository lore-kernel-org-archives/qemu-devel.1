Received: from eggs.gnu.org ([2001:4830:134:3::10]:43472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTO7y-0001k1-A0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fTO7s-0002C3-I2
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:01:10 -0400
Date: Thu, 14 Jun 2018 11:00:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180614090055.GB8564@localhost.localdomain>
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
	<20180613154711.12977-3-dplotnikov@virtuozzo.com>
	<ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
	<b78d2918-9ba8-5f4d-0953-bf2420aabae0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <b78d2918-9ba8-5f4d-0953-bf2420aabae0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v0 2/2] qmp: add block-set-copy-on-read
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-block@nongnu.org, armbru@redhat.com, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com, berto@igalia.com


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.06.2018 um 18:41 hat Max Reitz geschrieben:
> On 2018-06-13 18:02, Eric Blake wrote:
> > On 06/13/2018 10:47 AM, Denis Plotnikov wrote:
> >> The command enables/disables copy-on-read mode for VM's disk while
> >> VM is running.
> >>
> >> This is needed when using external disk readers to shape access pattern
> >> to the disk backend.
> >>
> >> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> >> ---
> >=20
> > Deferring thoughts on the actual design for later;
>=20
> But why? ;-)
>=20
> This patch would definitely be superseded by a block reconfiguration
> command (i.e. presumably one that makes reopen accessible over QMP).
> With such a command, you could insert or remove a copy-on-read filter
> node at any point in time.
>=20
> Since we definitely want block graph configuration, I don't think we
> want to add special commands now.

I agree, and it seems that we get more and more use cases for a block
reconfiguration commands. Only yesterday we talked about the "true"
blockdev way for libvirt to implement I/O throttling. The result was
that without reopen, we still need to use the old QMP command to set
BlockBackend-based I/O throttling instead of using a filter node.

So I'm eagerly awaiting Berto's promised patches for it.

Kevin

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbIi7HAAoJEH8JsnLIjy/WAN4QAIF/7nvDdH6JSd9eIh0GvITj
I5shA4B9JTIXb7PH2xhHpTuG5nGdXkIuBuKlN/zyXq1oAt2rhNlVqMyX32EQu2OA
DBSwx6YNxbShaCQobyONwz0QRnlL/JS39q9BxWyT77LbTp3v6ar6y7bPFkeTUpXE
48l4ZNrl3L5ZaxAbZYR5mOShujbP4lxLun6bh0d8KFPLAaBn3IaRfXkV/MGNn8pR
8mWOKRFmVlTV0Wb3msDCdnC06wnioqeItp/wKpntLmXWCHcMcv74Ur7bMCmzIrPV
c5RUmPghPQ0mURqCa8BJHBUT7vkrrW3KmJV6obNqF8smHj5uifPpun8X+A7Rzvpg
pLxvatzl41dhNcm0ih9KcZgIeQ8cgZsswWDSG3iuAsnDJS5hneT0StQEXK1CUqKr
V5qx+cL30eicjXNsmqLsdxCjFgonwA0Lx4bvVwERRgbuuJdaWJYH4pAY+hk6gBPs
XUMOJr7m4YKrDJGPMuHRGz7dnZOWt4ji6AGbq77qsI9l98zKFmFiTMdTSTJse9LE
6COtlrIsXiSXoxdVCrcSkCVt5hsuoKhlP+B2WUGTByW94UmdwKshxB5+B5/MrXfW
6J6/FcftP1Q8sbB6c/XVLlY7KvulG7hAYg9Rsc4OdfihhlWW26+Wal2spJkhumoa
A/sgXEc6OJEAwikFWKrk
=OXL9
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

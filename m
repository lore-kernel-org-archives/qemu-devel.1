Received: from eggs.gnu.org ([2001:4830:134:3::10]:55445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gX0NI-00048F-Rr
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gX0NC-0002kB-LU
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:00:12 -0500
Date: Wed, 12 Dec 2018 09:59:51 +0100
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20181212085951.GA7604@aepfle.de>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20181102110412.GD7521@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [Xen-devel] xen_disk qdevification (was: [PATCH
 0/3] Performance improvements for xen_disk v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Tim Smith <tim.smith@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Nov 02, Kevin Wolf wrote:

> A while ago, a downstream patch review found out that there are some QMP
> commands that would immediately crash if a xen_disk device were present
> because of the lacking qdevification. This is not the code quality
> standard I envision for QEMU. It's time for non-qdev devices to go.

Do you have that backwards by any chance? IMO the presence of assert()
contributes to bad code quality, not the drivers that trigger those
asserts. It is bad enough that two QEMU releases went out while being in
bad shape.

Anyway, hopefully Paul or whoever will find the time and energy to
convert the code at some point.

Olaf

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXBDOBAAKCRBdQqD6ppg2
flgGAJ9WXSO2VhOaGfhsfJ9KkXKAyXmKPACeK/AMD6NcJF0i7xTcABZXPyfNRaI=
=eLgW
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

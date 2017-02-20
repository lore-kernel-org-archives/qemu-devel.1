Received: from eggs.gnu.org ([2001:4830:134:3::10]:38300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfpuu-0000pE-OQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:30:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfput-0001pT-TF
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:30:20 -0500
Date: Mon, 20 Feb 2017 15:30:12 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170220153012.GK21255@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7Ke/meiCZutM6I/"
Content-Disposition: inline
Subject: [Qemu-devel] blockdev-add I/O throttling parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, berto@igalia.com


--C7Ke/meiCZutM6I/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I/O throttling parameters are missing from blockdev-add.  Is this
intentional?

I can imagine two solutions that do not need these parameters in
blockdev-add:

1. I/O throttling is implemented by a BlockDriver.  Users are expected
   to create the BDS themselves.  This is a little awkward since
   query-block *does* include the throttling parameters in its output
   and we must preserve this behavior for existing users.

2. block_set_io_throttle must be used after blockdev-add.  Suboptimal
   because issuing two commands is not atomic (use transaction?).

Thoughts?

Stefan

--C7Ke/meiCZutM6I/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYqwuEAAoJEJykq7OBq3PINncH/RMxNMdOCEx1XpDYGtYgW0SQ
PAKLuBpGwXvNaxJCfia44JXMrc5JmV1ntKYu6RSPP66jpRG6IWbS2/DhMf1pZN0C
aAswBSLI6v1NqbbZrRKeVs4mjJ+lbwXCujZUfqjWL6qaRDKQ4MHOWZBnxoLxZ00m
tGccdIFzfedbixTpeFTQkpOmtgxgOqYPgTzz3jLPzcqgqDKgpMj7WVTmt5Om4rRR
wADN27R0FKdvLIZTvryxBaRk6cIh+g2lWvYFUqHcuHhV+olX0FrcryJSeGmSSHSf
3gccPIYh0RjSxSrTsFRzHW6FwYQdAD+r7pbbItM7TZTiQNiE7gj3upKVKfuCrzY=
=71Vl
-----END PGP SIGNATURE-----

--C7Ke/meiCZutM6I/--

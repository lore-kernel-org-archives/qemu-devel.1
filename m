Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYAqa-0003LM-HT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYAqW-0001vq-G3
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:46:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dYAqW-0001vV-9S
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:46:24 -0400
Date: Thu, 20 Jul 2017 13:46:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170720124618.GD32383@stefanha-x1.localdomain>
References: <1500318936-14106-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <1500318936-14106-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v6] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2017 at 12:45:36AM +0530, Ishani Chugh wrote:

This looks good.  I think it makes sense to include this patch with the
patch series that adds the qemu-backup command.  That way the command
and its man page will be merged together.

> +@item qemu-backup guest add --guest guestname --qmp socketpath [--tcp]

For consistency I suggest following QEMU chardev syntax for the socket
path.  This also allows you to drop --tcp.

UNIX domain sockets look like this:

  unix:/path/to/socket

TCP addresses look like this:

  tcp:127.0.0.1:1234

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcKYaAAoJEJykq7OBq3PIcZMIAI2BJkEu0Sn0N8YJCf6SF7yp
DhrJaQ2Q64vRQdIgAWuwPpJiXeMGSSKNMsN3KL5wfQMMJOWH0n0OMMmbpf3w9gnn
PRlOShC/rxPrxk0QHPnik3lrCMFjXJMx+gT133lCnsCG40PUxzKKsDzD1OGhC08X
7OJ6j+rPwQu3lzWFZlvX25hdMAV9tS/rmQ0bjePBz0LS9Nj7+yS91rsaxOAXgxKV
fZONlHMQ4EJozblZ2OJrEPM9Yg/z1KKOaFMwUKI4FB35EXaHLbO0rT6OIPXdPTUA
wuf+KC5WTnrBAeth6Moop1/UOqNVFLwDNmRN4PiAKCTOA/43xZT+JWHsxJ8fmxM=
=c6gk
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

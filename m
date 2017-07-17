Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX69f-00062G-5c
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dX69c-0006Wi-2U
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dX69b-0006WW-Ra
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:33:39 -0400
Date: Mon, 17 Jul 2017 14:33:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170717133332.GP7163@stefanha-x1.localdomain>
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170717071835.GD22872@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PdAWLd+WEPmMbsbx"
Content-Disposition: inline
In-Reply-To: <20170717071835.GD22872@lemon>
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org, jsnow@redhat.com


--PdAWLd+WEPmMbsbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 03:18:35PM +0800, Fam Zheng wrote:
> On Sun, 07/16 02:13, Ishani Chugh wrote:
> > +"""
> > +This file is an implementation of backup tool
> > +"""
> > +from argparse import ArgumentParser
> > +import os
> > +import errno
> > +from socket import error as socket_error
> > +import configparser
>=20
> Python2 has ConfigParser while python3 has configparser. Please be specif=
ic
> about the python compatibility level of this script - my system (Fedora) =
has
> python2 as /usr/bin/python, so the shebang and your example command in the
> commit message don't really work. "six" module can handle python 2/3
> differentiations, or you can use '#!/usr/bin/env python2' to specify a py=
thon
> version explicitly.

I haven't compared Python 2 ConfigParser and Python 3 configparser in
detail, but I they have a common API subset.  It should be possible to
do something like:

  try:
      from configparser import ConfigParser # Python 3
  except ImportError:
      from ConfigParser import ConfigParser # Python 2

> > +from qmp import QEMUMonitorProtocol
> > +
> > +
> > +class BackupTool(object):
> > +    """BackupTool Class"""
> > +    def __init__(self, config_file=3D'backup.ini'):
>=20
> Is it better to put this in a more predictable place such as
> "$HOME/.qemu-backup.ini" and/or make it a command line option?

Yes, it's common to take a configuration file path on the command-line
with a default value of $HOME/.program-name if no command-line option
was given.

--PdAWLd+WEPmMbsbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZbLysAAoJEJykq7OBq3PIvlEH/2nCEpxDbLdyeuBPzPS7GQeb
oGTCy24AEeweh0Agwn9ouuyezbKWu/EBPPYl7d/9xWyymRYdESnz9J0g7/zCzbHf
lwXyWc+a1J/vsCUEgmDgC7GP4QCW+K+/i3msm2Ra95nMTzvCK5LnwJ4qGHHkMvWg
qIRu1QRY4ZhxJyJfhRbnYXUR9FjHDNlOK4Q8v26cVkHjmXyJk24kMDQZ3Oz2SIVm
FMY6x+dZsf7qTbGOG2C+ccoKJXM/TLPHWKDPlaeZ6gJ71zw7UkOBmIfy2KYYjds5
sFDzAQs3gAwPb1SNc5jUr+tzupKywst++zAhW3bVVAgBPb0RZc3YHoH6cxYlyNw=
=kLrE
-----END PGP SIGNATURE-----

--PdAWLd+WEPmMbsbx--

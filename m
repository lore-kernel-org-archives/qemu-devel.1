Received: from eggs.gnu.org ([2001:4830:134:3::10]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX5ps-0006ff-NY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gX5pn-0000FE-2K
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:50:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gX5pl-0000E0-Pa
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:49:58 -0500
Date: Wed, 12 Dec 2018 14:49:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181212144954.GA11292@stefanha-x1.localdomain>
References: <20181210173151.16629-1-dgilbert@redhat.com>
	<20181212123059.GD31033@redhat.com> <20181212135203.GD2370@work-vm>
	<20181212135825.GE31033@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20181212135825.GE31033@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, sweil@redhat.com, swhiteho@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 01:58:25PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Dec 12, 2018 at 01:52:03PM +0000, Dr. David Alan Gilbert wrote:
> IMHO we need something whose support status is on a par with what you'd
> get if we had the impl in-process for the main QEMU system emulator.

I agree.  Now that virtio-fs has been released we're working on todo
items that will make the libfuse code production-quality, including
security auditing and jailing of the process.

Once we're confident that this is a production-quality file server it's
a matter of moving it out of example/ or contrib/.  We might find that
the scope of a production-quality file server exceeds libfuse's example/
anyway and need to move it to a new home.

Stefan

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcESASAAoJEJykq7OBq3PIgwgIAMV2GK4BJAO5xTDXRVZJXOFG
USz5WmA2tU9l1+hhu38ZHTcpdgJ+w11qSRdt0X98cbfNBpDPGCJ5lTpYbtr9i5o+
n2+CjyoudKFVQj6z3l17SE/JWIqGHTHxvt1nVP+29GUdKEZSorl+qkpfNCJjciPW
+4b1v7zneKFMcqUb04Lh4QvpE7t/LSyu3yaf0CVLiidjOUCYkEs6eaq/dqeAF2jV
YxEWGbtwK+Y+cUpU982hfZYObdOup+WG2EJRAfni9bJjdPRiMziLV33P76xVB4l3
/XFBn+0OZYqAEDJ7AFwYsEIEP5oVV6iQWT3Ckkiezjns0mXlKZYr/voLX5dh/YY=
=kn3S
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

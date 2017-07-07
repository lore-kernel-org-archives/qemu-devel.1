Received: from eggs.gnu.org ([2001:4830:134:3::10]:55297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaFz-0005HF-U6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTaFw-0000ns-Rk
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:53:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dTaFw-0000nb-HX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 16:53:40 -0400
References: <cover.1498222907.git.tgolembi@redhat.com>
	<7e2e1329dbe5a6d93c3d58eb2251b8862e2d1340.1498222907.git.tgolembi@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <912a31de-a26b-9267-a5ea-9f1f9ffa04bd@redhat.com>
Date: Fri, 7 Jul 2017 15:53:37 -0500
MIME-Version: 1.0
In-Reply-To: <7e2e1329dbe5a6d93c3d58eb2251b8862e2d1340.1498222907.git.tgolembi@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="69124rbb4F27473NIm7THRtwiWHUTwR3F"
Subject: Re: [Qemu-devel] [RFC 1/3] qemu-ga: add support for events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--69124rbb4F27473NIm7THRtwiWHUTwR3F
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Message-ID: <912a31de-a26b-9267-a5ea-9f1f9ffa04bd@redhat.com>
Subject: Re: [Qemu-devel] [RFC 1/3] qemu-ga: add support for events
References: <cover.1498222907.git.tgolembi@redhat.com>
 <7e2e1329dbe5a6d93c3d58eb2251b8862e2d1340.1498222907.git.tgolembi@redhat.com>
In-Reply-To: <7e2e1329dbe5a6d93c3d58eb2251b8862e2d1340.1498222907.git.tgolembi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2017 08:02 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> Events can play an integral role when monitoring internal state of the
> guest OS. This patch adds the core functionality for adding events to
> QEMU Guest Agent.

Will sending events confuse existing clients that aren't expecting them?
Do we need to add some sort of protocol handshake when the client first
connects so that we know whether the client is able to parse events
(including ignoring unknown events)?  (It's a shame that events were
built into QMP from the beginning, so we've never had to figure out how
to portably hand-shake a client/server negotiation on additional
features to be used across the wire)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--69124rbb4F27473NIm7THRtwiWHUTwR3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZX/TRAAoJEKeha0olJ0NqbHYH/AzYev6lkmfQHs78U5pcqpaN
l5ihU+S2CCdN9vOga8fMNDfRJ2JKSbVKcgZEeBeCTnPX5HPBG4upc87xbV26Zfig
J+s+SkPHSOA8VYWPutXa+iGYsGt3sNAVvILYK7hkA/hAMjSATXtGUKLh//47qmPS
//QEcObj8Q0ayHzIAc1gvhvhY8zkq/oZdgXJQyB0E+1M7tZMJXcU/gccEYe53So+
SH2y+eYUSFQ+wx6GNJryRCwNKOnOijWwV4ubwCeR+1dyeZCsqdgnryzDBTNsOVV+
VH9PACg4LW+kqs/HiU062s61MgbX6o7zGgad82T1cRA+Bv7h6wq1DKoMY6CqnyE=
=uwEx
-----END PGP SIGNATURE-----

--69124rbb4F27473NIm7THRtwiWHUTwR3F--

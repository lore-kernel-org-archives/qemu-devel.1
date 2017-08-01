Received: from eggs.gnu.org ([2001:4830:134:3::10]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcTm1-0007n4-RX
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcTlz-0002na-8X
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:47:33 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcTly-0002n0-Rl
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:47:31 -0400
Received: by mail-wm0-x241.google.com with SMTP id y206so2162218wmd.5
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 02:47:30 -0700 (PDT)
Date: Tue, 1 Aug 2017 10:47:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801094726.GD13521@stefanha-x1.localdomain>
References: <20170731160135.12101-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <20170731160135.12101-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] trace-events: print 0x before hex
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com, cohuck@redhat.com


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2017 at 07:01:31PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> It is hard to read logs, when there are hex and dec numbers in one line, =
when
> hex number doesn't contain any letters and don't have '0x' prefix.
>=20
> So, here is a complete solution for the problem:
>=20
> - add information into CODING_STYLE
> - add a check into checkpatch.pl
> - fix current state
>=20
> The new rule for the style is:
>=20
> Hex numbers should be prefixed by '0x', except groups of numbers,
> separated by symbols ' ', '.', ':', '/', however '0x' can be used for
> numbers in such groups too. Flag '#' in number format is not allowed.
>=20
> Note: checkpatch fails on checkpatch change (03) due to long lines.
> It is because checkpatch.pl is indented by tabs and when it checks
> for long lines it consider tabs as 8 spaces. Looks like nobody cares,
> so do I. I see two ways here:
>  -  s/\t/    /g
>  -  make exclusion in checkpatch.pl for checkpatch.pl to consider tabs
>     as 4 spaces, not 8.  However I don't want to fix it in the context
>     of these series.
>=20
> v3: 01 - rewording
>     02 - adjust commit message - add two printf flags "'I" into a check
>          add Stefan's and Eric's r-bs
>     03 - fix commit message s/Accordingly/According/
>          add Stefan's r-b
>     04 - add Stefan's r-b
>          add Cornelia's a-b
> v2: almost everything (style, checkpatch, excluding number groups)
> V1: was a draft of the idea using two sed commands.
>=20
> Vladimir Sementsov-Ogievskiy (4):
>   coding_style: add point about 0x in trace-events
>   trace-events: fix code style: %# -> 0x%
>   checkpatch: check trace-events code style
>   trace-events: fix code style: print 0x before hex numbers
>=20
>  CODING_STYLE              |  35 +++++++++
>  accel/tcg/trace-events    |   2 +-
>  audio/trace-events        |   4 +-
>  block/trace-events        |  28 ++++----
>  hw/audio/trace-events     |   4 +-
>  hw/char/trace-events      |  12 ++--
>  hw/display/trace-events   |  14 ++--
>  hw/dma/trace-events       |  20 +++---
>  hw/i386/xen/trace-events  |  26 +++----
>  hw/input/trace-events     |   6 +-
>  hw/intc/trace-events      | 176 +++++++++++++++++++++++-----------------=
------
>  hw/isa/trace-events       |   4 +-
>  hw/misc/trace-events      |  78 ++++++++++----------
>  hw/net/trace-events       |  52 +++++++-------
>  hw/nvram/trace-events     |   2 +-
>  hw/pci/trace-events       |   4 +-
>  hw/ppc/trace-events       |  64 ++++++++---------
>  hw/s390x/trace-events     |  20 +++---
>  hw/scsi/trace-events      | 118 +++++++++++++++----------------
>  hw/sd/trace-events        |   4 +-
>  hw/timer/trace-events     |  20 +++---
>  hw/usb/trace-events       |  56 +++++++--------
>  hw/vfio/trace-events      |  44 ++++++------
>  hw/virtio/trace-events    |   6 +-
>  hw/xen/trace-events       |   8 +--
>  linux-user/trace-events   |  10 +--
>  migration/trace-events    |  36 +++++-----
>  nbd/trace-events          |  18 ++---
>  net/trace-events          |   4 +-
>  scripts/checkpatch.pl     |  19 +++++
>  target/arm/trace-events   |  10 +--
>  target/s390x/trace-events |   2 +-
>  target/sparc/trace-events |  30 ++++----
>  trace-events              |  20 +++---
>  34 files changed, 505 insertions(+), 451 deletions(-)
>=20
> --=20
> 2.11.1
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgE4uAAoJEJykq7OBq3PIiLMIAIBXIrerb6rItwlYBcmQoXRb
0tZ+6OmJFZULAmDb1X9v2D+q/u7EONlw7dHFqWGolrVgFjrNVbSJ27H0by8Z35Ql
0SxXVmlkcisHKPvzxt1YPHKwzXtEjJNHG9fTnxmiNiEY6ARRvtmtxAUV4x2uOeUk
Yu0vrrM8EDvvtGA4yNrVmf6g2TJG6yUjg53n1QWQs+JHaF15esK2VdbfYCYTHyE+
LJhUSS3a8OzYe7rymZ6K/c9Aen/++xS5HjHGoJQLdTeywtb5YhWEmkVVCeJzW/IJ
3nNYwU9hKCUFMgbeFwx7rk7Ffg8R4PfY0FrAKmudz3wmuiaF1kfkIsZZkV5ichQ=
=zqU6
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--

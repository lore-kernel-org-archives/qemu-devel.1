Received: from eggs.gnu.org ([209.51.188.92]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpJKL-0001sa-Mu
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpJKK-0000FI-IS
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:52:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gpJKK-00007z-96
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 15:52:48 -0500
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-8-yuval.shaia@oracle.com>
	<42ba3330-f7ca-b5c5-126f-8dd97e343d51@redhat.com>
	<20190131200816.GA2838@lap1>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3557b3f3-cec5-fcb1-1527-e613fa446b89@redhat.com>
Date: Thu, 31 Jan 2019 14:52:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190131200816.GA2838@lap1>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rFauGL7UuQwLhpXKvPd9pM74RZ3yEAxoz"
Subject: Re: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device
 statistics counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: dgilbert@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rFauGL7UuQwLhpXKvPd9pM74RZ3yEAxoz
From: Eric Blake <eblake@redhat.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: dgilbert@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <3557b3f3-cec5-fcb1-1527-e613fa446b89@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] monitor: Expose pvrdma device
 statistics counters
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
 <20190131130850.6850-8-yuval.shaia@oracle.com>
 <42ba3330-f7ca-b5c5-126f-8dd97e343d51@redhat.com>
 <20190131200816.GA2838@lap1>
In-Reply-To: <20190131200816.GA2838@lap1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/31/19 2:08 PM, Yuval Shaia wrote:
> On Thu, Jan 31, 2019 at 07:17:16AM -0600, Eric Blake wrote:
>> On 1/31/19 7:08 AM, Yuval Shaia wrote:
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> ---
>>>  hmp-commands-info.hx | 14 ++++++++++++++
>>>  monitor.c            |  6 ++++++
>>>  2 files changed, 20 insertions(+)
>=20
> Hi Eric,
>=20
>>
>> Commit message should state WHY this is being added as an HMP-only
>> command, and does not have a QMP counterpart.  It may be okay if the
>> interface is only designed to be useful to developers, but having that=

>> justification in the git log is important.
>=20
> Thanks for your review.
>=20
> See, i need this interface mainly for development/debug purposes, to he=
lp
> troubleshot problems and to give insights to what device "is doing".
>=20
> Trace points are great but not effective in high load.
> QMP as i see it, and correct me if i'm wrong, is used to report managem=
ent
> events etc and also here, is not effective in high load.
>=20
> I choose this interface as it is interactive, i.e. whenever i need the =
info
> i trigger 'info pvrdmastats' command from the monitor console.
>=20
> During my research i notice that some devices (or families) have nice u=
ser
> interface via virsh (blkstat, ifstat, memstat etc). Is it the preferred=
 way
> for non-devel/debug purposes?

Using existing HMP-only debug interfaces as the design you copied is
indeed acceptable justification for making yours HMP-only as well.  So
now you just need to copy the rationale from this email into your commit
message, so it doesn't get lost.

>=20
> If this is the correct method for this purpose then let me know and i'l=
l
> update the git log message accordingly.
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rFauGL7UuQwLhpXKvPd9pM74RZ3yEAxoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxTYBMACgkQp6FrSiUn
Q2qjpgf/Sy161mCfyeFQ/m49mNAToanNhqAxjAgV9DPor2OiqLSwtM6cGj0GqGpF
qUJVubxxSwfciTtdePj1ufHsx9IzHdTR4CYvVRavx+MPxx5+I7Q/40Bx+yeb1GB/
/275l30XO1+sb8IV9r2DhWbVMMXCM1f/MrStcTfQbPjkxuRaOf4Can24ZzfeKqbv
7odMK69oQgVOVndh/Z9DFuhUcssS3C7SzkyWeMO3mfiixD+e02FEUr+1IrsD6NS7
F09iIruPnMTImT/H/4lYFaBIYwlynnAcF+mLlIIwdpxQkhRt8fstpZOZ9CdaCuVW
5PTzOdzxwHDpYg9HjsmDYdiNl4S3Bw==
=7u7/
-----END PGP SIGNATURE-----

--rFauGL7UuQwLhpXKvPd9pM74RZ3yEAxoz--

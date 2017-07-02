Received: from eggs.gnu.org ([2001:4830:134:3::10]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRf2h-0003SA-Ez
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dRf2g-00045V-Dc
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 09:36:03 -0400
References: <20170621133023.27627-1-mreitz@redhat.com>
	<20170621133023.27627-2-mreitz@redhat.com>
	<748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
	<6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
	<7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <355f4801-b8a6-cf7c-6de0-8bd3a7eb9a19@redhat.com>
Date: Sun, 2 Jul 2017 15:35:51 +0200
MIME-Version: 1.0
In-Reply-To: <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HQwesgHTiHDJVp8TAFvhjWT4sr471fljg"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] iotests: Use absolute paths for
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HQwesgHTiHDJVp8TAFvhjWT4sr471fljg
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <355f4801-b8a6-cf7c-6de0-8bd3a7eb9a19@redhat.com>
Subject: Re: [PATCH v4 1/2] iotests: Use absolute paths for executables
References: <20170621133023.27627-1-mreitz@redhat.com>
 <20170621133023.27627-2-mreitz@redhat.com>
 <748b90f3-8f89-59ea-4a65-69e938747c0b@redhat.com>
 <6179c9e2-5486-0ff6-927d-da144c178e93@redhat.com>
 <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
In-Reply-To: <7fa30bfe-d1b4-0aeb-b90e-ae91f9467749@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-30 21:41, Eric Blake wrote:
> On 06/29/2017 09:46 PM, Max Reitz wrote:
>=20
>>>> +++ b/tests/qemu-iotests/common.config
>>>> @@ -103,6 +103,12 @@ if [ -z "$QEMU_VXHS_PROG" ]; then
>>>>      export QEMU_VXHS_PROG=3D"`set_prog_path qnio_server`"
>>>>  fi
>>>> =20
>>>> +export QEMU_PROG=3D$(realpath -- "$(type -p "$QEMU_PROG")")
>>>
>>> ...now that you updated per my review to favor 'type' over 'which'?
>>> Otherwise, the R-b stands.
>>
>> Thanks, will fix and apply then...
>>
>> ...and done, applied to my block branch:
>>
>> https://github.com/XanClic/qemu/commits/block
>=20
> Sorry for not noticing sooner, but you'll need to replace v4 (commit
> 0f0fec82 on your branch) with a fix, because now your branch does the
> following on all iotests for me:
>=20
> 068 3s ... - output mismatch (see 068.out.bad)
> --- /home/eblake/qemu/tests/qemu-iotests/068.out	2017-06-26
> 22:02:56.057734882 -0500
> +++ 068.out.bad	2017-06-30 14:35:28.720241398 -0500
> @@ -1,4 +1,5 @@
>  QA output created by 068
> +realpath: '': No such file or directory

Oops.

> The culprit? $QEMU_VXHS_PROG is empty for me, which means `set_prog_pat=
h
> qnio_server` found nothing to use.  You'll have to add in a safety valv=
e
> that only calls 'type' if operating on a non-empty path in the first pl=
ace.

Sure, will drop the patches and send a v5.

Thanks!

Max


--HQwesgHTiHDJVp8TAFvhjWT4sr471fljg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWPa3EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPza
B/9IQPu5v+SaTUIDJ1X5eHJn/2qJLOmnYdmPgy8yESQChz6kOVcc4Y/33FNEbCJv
/HdSjtnrnSDNIanl5NGTnEVKKMx1jAcxwmYtOUhZvnNg+KS8yAKgcfEB6D+kY0qU
FD4bOSl0yUYmRclyFR4bquQzUulQMZ5oA9Fs/+VzwbZRTSkT0zuQ238WQpEYAsXu
EMwvUfPtSCwE+j6LsMpLZPw6vvAKLJj0ersZP8hb2oav8RUR9b5vs+8CP+zuHJ08
TRdBYOHvm6gBoQ2q6//gbv82Pxo38EfSl7zjKcUVMJZsAwqccZ7sdmYt9MiOkrHq
5BbrqWCi/JFPUky+5zXIPYh4
=N2pk
-----END PGP SIGNATURE-----

--HQwesgHTiHDJVp8TAFvhjWT4sr471fljg--

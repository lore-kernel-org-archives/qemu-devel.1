Received: from eggs.gnu.org ([209.51.188.92]:54179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Vur-00013C-DY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Vup-0007q1-5Z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:44:57 -0500
References: <20190301160929.19892-1-stefanha@redhat.com>
	<bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
	<20190306101811.GJ22159@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1aab9bb5-a8a1-b0c8-af6f-909631e9ce2f@redhat.com>
Date: Wed, 6 Mar 2019 06:44:42 -0600
MIME-Version: 1.0
In-Reply-To: <20190306101811.GJ22159@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FhYRnWoFjMG8OVsB5T1FupPuAwnb93Ohi"
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Neil Skrypuch <neil@tembosocial.com>, Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FhYRnWoFjMG8OVsB5T1FupPuAwnb93Ohi
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Neil Skrypuch <neil@tembosocial.com>,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <1aab9bb5-a8a1-b0c8-af6f-909631e9ce2f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: add drop-cache=on|off option
References: <20190301160929.19892-1-stefanha@redhat.com>
 <bd5824cb-7adb-1e96-fbd2-eb666288c253@redhat.com>
 <20190306101811.GJ22159@stefanha-x1.localdomain>
In-Reply-To: <20190306101811.GJ22159@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 3/6/19 4:18 AM, Stefan Hajnoczi wrote:

>> Question - if we used qapi's 'if':COND to only declare the field on
>> platforms where we know at compile time that we can support it, would
>> that be enough for libvirt to introspect that if the field exists then=

>> migration is safe, without having to rely on an query-qemu-features co=
mmand?
>=20
> Yes, although this raises another question:
>=20
> The drop-cache implementation is not #ifdefed in file-posix.c.  If we
> make the QMP schema conditional, should we also #ifdef the command-line=

> option in raw_runtime_opts[] to prevent QEMU from silently ignoring thi=
s
> option?

Yes, that would make sense to me - if we don't advertise the feature,
then we should not silently ignore it on the command line.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FhYRnWoFjMG8OVsB5T1FupPuAwnb93Ohi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/wLoACgkQp6FrSiUn
Q2qM6Af/XuaPPEH1lPsett6iLP0z247rNLOisLguFVLxKUlm0G/WMcm9Z65j00Zk
mQf9P1/0o//lM8e0Dg94zxGKZciV4PLoFVb0a9iGh0FC8Q7h9RtJPNofM65OxXp8
3Y0/GoSa8f/KLvrZsd/iDoak1UfVw8mJ/ggGfxUiYQVFIbdlFbxJ8DqV0JJA2OJo
uIwbJm2mYQn9nD9QZJtSnj82f/aqbtCOpnfZix4Cwn5FvJoMDHtPbgkFTdsbVran
KI7z1P2vNUW2ROtT0nD7pTWuwdCCWxUC4/nzBUGezrVkAU2qisnC5u5ex8WHXhS0
Bpr3i9CD3FUg+9RQEC4h63n+jzzHhg==
=7zEn
-----END PGP SIGNATURE-----

--FhYRnWoFjMG8OVsB5T1FupPuAwnb93Ohi--

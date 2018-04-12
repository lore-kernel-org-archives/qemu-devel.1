Received: from eggs.gnu.org ([2001:4830:134:3::10]:44709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6e3J-0003Cs-FR
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6e3E-0003o2-Q7
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:22:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6e3E-0003n5-Kv
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 632CE4074450
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 15:22:12 +0000 (UTC)
References: <20180412061108.10875-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42c09e77-d6f3-6e2a-ade7-968def9668b9@redhat.com>
Date: Thu, 12 Apr 2018 10:22:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180412061108.10875-1-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TNaX13HzJ66DqlK7T9piV4rPXnCeXR4tm"
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TNaX13HzJ66DqlK7T9piV4rPXnCeXR4tm
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <42c09e77-d6f3-6e2a-ade7-968def9668b9@redhat.com>
Subject: Re: [PATCH v3] monitor: let cur_mon be per-thread
References: <20180412061108.10875-1-peterx@redhat.com>
In-Reply-To: <20180412061108.10875-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 01:11 AM, Peter Xu wrote:
> In the future the monitor iothread may be accessing the cur_mon as
> well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> Out-Of-Band command, let's convert the cur_mon variable to be a
> per-thread variable to make sure there won't be a race between threads.=

>=20
> Note that thread variables are not initialized to a valid value when ne=
w
> thread is created.  However for our case we don't need to set it up,
> since the cur_mon variable is only used in such a pattern:
>=20
>   old_mon =3D cur_mon;
>   cur_mon =3D xxx;
>   (do something, read cur_mon if necessary in the stack)
>   cur_mon =3D old_mon;
>=20
> It plays a role as stack variable, so no need to be initialized at all.=

> We only need to make sure the variable won't be changed unexpectedly by=

> other threads.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TNaX13HzJ66DqlK7T9piV4rPXnCeXR4tm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPeZgACgkQp6FrSiUn
Q2p5+gf9GMsYrBs88Jo/aT3U17vqls3uPfTqzdIEWckHGG/V0/Bez/r7KhPMB1P6
DNVR4M+yHk+rqxpRYqfm09GSrx/zA4XCtJKeq5gCv9ftOTtsWKCtQ8oatvks2dTY
DB79NkiCvqVerSHT20L0wRTbNh9argjCexlBU029az9ebq0K8sM75UyBoNOZejMH
WNAjgGTBJuWh9ClkdDpPqgQz+Op4VyBajEYOnoM/C4u3zNZFMFzfexoIBiqORYNy
Le8ZEeCT5erYwIieZYUTIDbflGEJuFXKMVuI8ejRd7pT407CBgr3xsloiTKTDvOw
Gw5jcG1LrVA5hWb24FczJyvgVzQNWA==
=9x9S
-----END PGP SIGNATURE-----

--TNaX13HzJ66DqlK7T9piV4rPXnCeXR4tm--

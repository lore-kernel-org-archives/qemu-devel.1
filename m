Received: from eggs.gnu.org ([2001:4830:134:3::10]:44955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxhV-00074X-C4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxhR-0003WC-C0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:40:45 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:41252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxhR-0003Vb-3m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:40:41 -0500
Received: by mail-qt0-x231.google.com with SMTP id i40so5646605qti.8
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:40:41 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <15903ee0-e76c-6d57-d757-3a3060af85ea@amsat.org>
Date: Fri, 12 Jan 2018 08:40:34 -0300
MIME-Version: 1.0
In-Reply-To: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="OUTKOwBJMiYvTbdI6w4IFPIDsRpVFwi4z"
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUTKOwBJMiYvTbdI6w4IFPIDsRpVFwi4z
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
Message-ID: <15903ee0-e76c-6d57-d757-3a3060af85ea@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 08:11 AM, Paolo Bonzini wrote:
> Using "fedora:latest" makes behavior different depending on when you
> actually pulled the image from the docker repository.  In my case,
> the supposedly "latest" image was a Fedora 25 download from 8 months
> ago, and the new "test-debug" test was failing.

Checking git log, this file was updated in a2bd7252fe8b to support
Fedora 24, not even 25 :)

I suppose a8f159d45bcb was to have Fedora 25 working.

>=20
> Use "27" to improve reproducibility and make it clear when the image
> is obsolete.


--OUTKOwBJMiYvTbdI6w4IFPIDsRpVFwi4z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpYnrIACgkQ4+MsLN6t
wN7blRAAybEEC49/PqZNKMSN/QJ1MqYkgKWkEVJkMUAK+ikB9iDXfhGdhVds5zC2
P6HvCLZQ7hyV+b3cL09Cng0N9N5Yc9d6cXsrY5wxGz6Tjd4PwIjMB15l+lyuGAqQ
vKE9nj6DKsGdJMd7kTCEAxsxObsOPn4tDjDRRXMled5WAIPN4ihZXpMQPrKZTRgX
oCPMH7iHRl/g7GTJddCSWKz7Dv+X1LYadhb9EkUUKaTP2Y7CPg18cGqZI7fl7i2m
Pm+AdYmBG6bIDiOlbIsKMuV+MNAAinkxZRCX4dzJLUu4CecN0qf8fjgSY8Cpbr8P
OXNOmx6YAEgRdcwE2RQoTRnDriwtZ99XBD2n2vBYKqIW4KAW/AMWwRJbM8HosSP+
12F4UiwwjDJjJLpZIkXO7ssylXxRw0bmfIxmD8XceyySfVFRpdklk/uaAB4eCnDc
qhMISonsLWSIRvDcQU8+28U01BJWkzzjiyIzU1J5Za1jKQZKb0FAo/kMI+JrMk01
tPKZu9q49516C/k2pwlPQvpuZGEEVKckKjg7MQ/7JWIOC9bi74fnOdszhRfjnEDn
3k9jJbHqkirpx4S/nHFgpQz/PfnILOJjCiiqvxXlz56WJcqqAQ8FJwaV3QGreMIH
JnZLTdIlcihhsun3wO94SzK+T5e//D39s55Usg6itmR1sOVXIo0=
=IfES
-----END PGP SIGNATURE-----

--OUTKOwBJMiYvTbdI6w4IFPIDsRpVFwi4z--

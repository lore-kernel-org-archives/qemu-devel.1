Received: from eggs.gnu.org ([2001:4830:134:3::10]:40637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX9pd-0008AQ-Es
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX9pa-0006VN-3J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:29:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dX9pZ-0006UR-Qm
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:29:14 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
Date: Mon, 17 Jul 2017 12:29:08 -0500
MIME-Version: 1.0
In-Reply-To: <20170717164641.GA31820@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AkGIoq79O0frcGLXVncVxnx8aiar4HCIT"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AkGIoq79O0frcGLXVncVxnx8aiar4HCIT
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
References: <20170407143847.GM2138@work-vm>
 <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
 <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
 <6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
 <39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
 <20170717164641.GA31820@work-vm>
In-Reply-To: <20170717164641.GA31820@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 11:46 AM, Dr. David Alan Gilbert wrote:

>> +++ w/hw/usb/bus.c
>> @@ -407,8 +407,9 @@ void usb_register_companion(const char *masterbus,=

>> USBPort *ports[],
>>  void usb_port_location(USBPort *downstream, USBPort *upstream, int po=
rtnr)
>>  {
>>      if (upstream) {
>> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",=

>> -                 upstream->path, portnr);
>> +        int l =3D snprintf(downstream->path, sizeof(downstream->path)=
,
>> "%s.%d",
>> +                         upstream->path, portnr);
>> +        assert(l < sizeof(downstream->path));
>=20
> You may find this doesn't help in some windows builds;  the assert
> functions aren't always marked as noreturn (because they pop up a dialo=
g
> that asks you whether you want to run into a debugger etc).

How would it not help?  Are we using gcc 7 on windows builds?  Adding
the assert is enough to shut up new gcc; old gcc was already silent; and
if mingw is still on old gcc, it doesn't matter whether assert() is
marked noreturn for what this patch is doing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AkGIoq79O0frcGLXVncVxnx8aiar4HCIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls8+QACgkQp6FrSiUn
Q2pYxQf/aFGg67Y6l1fzxcS+19Fbe8LTf+LMvzahhCQ/0V6DWgz14N/ByLAX+U6Q
3U+lU04Xe/aIxqZl+9+zOZWjK7p4Y5Cskf4n6slAbOg6G/kGkjQ85dRe7SlrA81V
V73m+GyNE3f/NLXoZ6CVWYt6ADIBPyYvHb7yNXA5JJEWYE+XZm5Yt3K5xSEuwHhP
/EtdxZ5CXffCVilPEwV5u6hI1x8YnRstepbL3O2q0sr1xUnaC8XEitQjKRTa6dkR
lK5Ie/siDPY+585LzvA0N3LWa92qxEXJi2v76rX6U+d4jDXRiWqozMlhyRmZnDGw
eJIaUBJznONO5MVWuHhMh9m4z7j3nw==
=GYuV
-----END PGP SIGNATURE-----

--AkGIoq79O0frcGLXVncVxnx8aiar4HCIT--

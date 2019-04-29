Received: from eggs.gnu.org ([209.51.188.92]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6E9-0001HD-Q6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6E8-0006wA-NA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hL6E8-0006vj-Eg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:21:48 -0400
References: <20180830143348.10595-1-marcandre.lureau@redhat.com>
	<20181213032452.GA25689@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0942d4a4-f264-fd42-0b2d-994c331a000c@redhat.com>
Date: Mon, 29 Apr 2019 15:21:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181213032452.GA25689@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz"
Subject: Re: [Qemu-devel] [PATCH] seccomp: check TSYNC host capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: otubo@redhat.com, qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/12/2018 04.24, David Gibson wrote:
> On Thu, Aug 30, 2018 at 04:33:48PM +0200, Marc-Andr=E9 Lureau wrote:
>> Remove -sandbox option if the host is not capable of TSYNC, since the
>> sandbox will fail at setup time otherwise. This will help libvirt, for=

>> ex, to figure out if -sandbox will work.
>>
>> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> This seems to have introduced a regression, which I found when
> preparing a ppc pull request.  Specifically when running with RHEL7 on
> a POWER host, using "-sandbox off" which one of my tests did, causes a
> cryptic error followed by a SEGV:
>=20
> $ ./ppc64-softmmu/qemu-system-ppc64 -sandbox off
> qemu-system-ppc64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
>=20
> I think the problem is that while this wrapped one use of the sandbox
> option group to produce a sensible error, it didn't do the same for
> another call to qemu_opts_parse_noisily():
>=20
> (gdb) bt
> #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffffa=
b5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
>     at util/qemu-option.c:829
> #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized ou=
t>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qe=
mu-option.c:890
> #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:3589
>=20
> I'm guessing RHEL7 triggers it because that has a version of
> libseccomp that doesn't support the feature needed to complete
> registration (maybe on ppc host only; I haven't had a chance to try on
> an x86 RHEL7 host).

Andrea reported the same issue again today with QEMU v4.0 ...
Marc-Andr=E9, have you ever had another look into this issue?

 Thomas



--OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcxvpkAAoJEC7Z13T+cC21GDAQAI0wQTB/cTSp52kJW+pesPkp
MXGBy2jfe9T/3hSJg7dRIpkq2AfKoGG9ORSKo6Dztlh+k5GlJGv5MWfy1eNjCRqT
diJgadtpmbxa+ntrLZR90eqYI4aHEqbpbsZsSMBhEbfSRyZCoY6R6DIhih/coCx2
85NasoXBybzYNvHFNNmpr0tzFMIFI+huW5tmv62Gsq4HiF47XchXBAccQKINteP/
OhWN5XJWDl/AP/zhC+us43DvpLglGrN2cYSvxtLnQQo5TY+ZvTBEMqiXzaWTzUbA
OIgcW8SAS0NrP8/0RUsgDug7PsGzq76tG3O6hUL8Gux560v/sp4eEfaSjdC6U3xs
VA4ft+ggtUI4zInQUIDyw/QAzKd27nmPlwgDSO6zowwk5pPFON+7qp2UoJuYiIDN
qvKYLttvBLrTa1vE7eMVHaTn2SKpQ+4jbGCFU7tI6EZJ0REpDgkng9UrniC6Goam
L6ZdldkTWxPl/swEYY89n1M3DrvhJ5LMM157EXN/9YxmqbNCqoSkNyi1iGiDAUEZ
RuQX1heQssKMuDU653+SxKWqW/YnHSZYbFkb4wgt8CIbOKAwKtk//VEamYLzEaqt
7ga47EFdgpi0HcZovhdJKonZfoJcrnaEgNak//SvK4OIs8gkairK1Ai7OfQxeGk5
upLG9vctfsd0a5Hd9RYD
=BuqW
-----END PGP SIGNATURE-----

--OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz--

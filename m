Received: from eggs.gnu.org ([2001:4830:134:3::10]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick@advancedtelematic.com>) id 1dtrPO-0006c7-4s
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick@advancedtelematic.com>) id 1dtrPK-000067-0T
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:28:02 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:49965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick@advancedtelematic.com>)
	id 1dtrPJ-00089s-KV
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:27:57 -0400
Received: by mail-wm0-x22b.google.com with SMTP id e71so367731wmg.4
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 01:27:56 -0700 (PDT)
From: Patrick Vacek <patrick@advancedtelematic.com>
References: <2385fc24-dbc3-ba7c-948f-b986edb27c7a@advancedtelematic.com>
	<CAJ+F1C+TZy=DY1d4qTf75iqkJ=-0nuOADa-h1SD1ZR3uj-BVTg@mail.gmail.com>
Message-ID: <5d65e10d-de1c-b67e-326c-3964f3676d92@advancedtelematic.com>
Date: Mon, 18 Sep 2017 10:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+TZy=DY1d4qTf75iqkJ=-0nuOADa-h1SD1ZR3uj-BVTg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AdPJjXNf9dpgXK0V9a84Pk8wMsDJgNa7K"
Subject: Re: [Qemu-devel] Trying to use ccid-card-emulated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AdPJjXNf9dpgXK0V9a84Pk8wMsDJgNa7K
From: Patrick Vacek <patrick@advancedtelematic.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Message-ID: <5d65e10d-de1c-b67e-326c-3964f3676d92@advancedtelematic.com>
Subject: Re: [Qemu-devel] Trying to use ccid-card-emulated
References: <2385fc24-dbc3-ba7c-948f-b986edb27c7a@advancedtelematic.com>
 <CAJ+F1C+TZy=DY1d4qTf75iqkJ=-0nuOADa-h1SD1ZR3uj-BVTg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+TZy=DY1d4qTf75iqkJ=-0nuOADa-h1SD1ZR3uj-BVTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Marc-Andr=C3=A9,

Thanks for your message!

On 14.09.2017 00:13, Marc-Andr=C3=A9 Lureau wrote:
> Hi Patrick
>
> On Wed, Sep 6, 2017 at 5:04 PM Patrick Vacek
> <patrick@advancedtelematic.com <mailto:patrick@advancedtelematic.com>>
> wrote:
>
>     Hello,
>
>     I'm trying to emulate a smartcard. I found section 4 of docs/ccid.t=
xt,
>     which appears to do exactly what I'm interested in. However, that
>     document is a few years old and references CoolKey, which at this
>     point
>     seems obsolete, with OpenSC being the preferred succcessor. I've
>     followed the rest of steps with success, and tried registering Open=
SC
>     with NSS (i.e. modutil -dbdir /etc/pki/nssdb -add "CAC Module"
>     -libfile
>     /usr/lib/opensc-pkcs11.so), but I'm still not seeing my three
>     certificates listed on the device as I'd expect.
>
>     I'm using QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3ubuntu2.3)=
=2E
>     I've also tried using QEMU emulator version 2.10.0 (built from
>     source),
>     but the interface has changed and the commands from the documentati=
on
>     don't work anymore.
>
>     1. Am I correct to assume that OpenSC is the logical successor to
>     CoolKey, and should I expect a simple substitution such as that to
>     work?
>
>
>  That's my understanding too, and it seems Fedora 26 deprecated
> coolkey. However, when I tried opensc a few years with qemu/libcacard,
> it didn't work. I haven't looked further since.
>
>     2. Are there other steps I might be overlooking with OpenSC or with=

>     getting the certificates recognized on the device?
>
>
> I would first try to get coolkey module to work, before debuging
> opensc. Ideally get some help from opensc developper since qemu should
> still work with coolkey.

I haven't had great success with OpenSC yet, so I finally took the time
to write a coolkey recipe for Yocto. The recipe seems to work and
coolkey appears to be installed on my device, but it does not work
entirely as desired. Specifically, when I run `modutil -dbdir
sql:/etc/pki/nssdb -add "CAC Module" -libfile
/usr/lib/pkcs11/libcoolkeypk11.so`, I get this: "ERROR: Failed to add
module "CAC Module". Probable cause : "A PKCS #11 module returned
CKR_GENERAL_ERROR, indicating that an unrecoverable error has
occurred."." That's a pretty vague message and I haven't been able to
find anything further to help guide me to a resolution. Do you have any
ideas?

The one thing that has occurred to me is that nss seems to require a
password for a database before being able to do anything meaningful with
it. When I tried to reproduce the steps of docs/ccid.txt item 4 entirely
locally (but with two separate databases), I had no problem with the
modutil command, but when I tried to import the certificates with
`certutil -A -d sql:./temp/ -i fake-smartcard-ca.cer -t TC,TC,TC -n
fake-smartcard-ca`, I got this: "certutil: could not authenticate to
token NSS Certificate DB.: SEC_ERROR_IO: An I/O error occurred during
security authorization." When I recreated the second database manually
and provided a password, that step worked fine and the output of listing
the certificates worked as expected.

Of course, on the device, I can recreate the database at /etc/pki/nssdb
with a password, but that erases the existing contents, which means the
certificates that were supposed to be initialized on the device wouldn't
be there, so that defeats the whole purpose, right? Is there a way to
specify a password for the nss database when launching qemu? In any
case, that probably won't fix the modutil error, but it's the only
thought I've had so far.

>
>     3. If, as I suspect, that document is no longer up to date, what
>     do the
>     steps currently look like to get smartcard emulation working?
>
>
> They look still pretty ok to me. certutil usage may have changes, but
> qemu & coolkey didn't change I think.
>
> What problems did you have when trying to setup following
> docs/ccid.txt ? we may want to update the doc.

In item 2, the necessary nss package on Ubuntu 17.04 is libnss3-tools.
In item 4, I think it might be best to prefix all database paths on the
device with "sql:" as is done with the host commands.
In item 8, docs/libcacard.txt no longer exists, as it is now in a
separate package.
And of course there's the fact that the modutil command doesn't work for
me, but I can't say why or what should change yet.

>
> Thanks
> --=20
> Marc-Andr=C3=A9 Lureau

Thanks,
Patrick

--=20
Patrick Vacek
ATS Advanced Telematic Systems GmbH
Kantstra=C3=9Fe 162, 10623 Berlin
HRB 151501 B, Amtsgericht Charlottenburg
Vertreten durch die Gesch=C3=A4ftsf=C3=BChrer
Dirk P=C3=B6schl, Armin G. Schmidt


--AdPJjXNf9dpgXK0V9a84Pk8wMsDJgNa7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZv4OJAAoJEJPafbf+QhyowvkP/3HAICabTh6XANZC4Xlwy+MY
jemjd3RRUaIWW+7dbWFIKBg+bguBU8e56E1voovaN2jxNFETPnW2U0Dt/6TyJWhr
quPVX/5JEWOUoAecfXUNpeF64aYTK4TUy5skU9Rbt/W7frEfqGWxPI6sNwtz/aI8
bEaFBC6GSaoxZg3d1dMe8ioTbTewUb3gH+VPwm/laJGuKjOJOb6Y0ZrgeMwZs1uJ
KZ4f19yF8DKshrG8+U5rPqeGsyN+bsySQob6ML728uylwUFjpDttJQvmXO9blSuQ
FWDAS0kcl77LvsL/zapWcZRcvUIFLOtq++M6vhsmSRieduHpek1ERTUANmUiXEds
Sh8jhrmDjrVmLH8zkaqoAuuFkKwmkrDEExoad2Qo+JjCCSwKSesG6P2c0Y6kOATP
EsZzlODN+Onll5JtKlesd5DA0oyiRnojGy/qKHieBq/OqXg781hjQDkfZSkk+gL1
3/BGwhnDT/PAYIpWaO/4uPI2wYwt4jl9//CmL/zqTlOoPjHYBJ4P7KV/h7F5oRM+
rSjKfT7ofmFx0lXqaBDVt8cESZ1phIQBbcXF767YMm8xXZKRHxi5JNcNgpe5Tzv3
K5iqz7DSMRe35vp0/6/mu2tt8XSs/ougde+JUBxcz8polatXd4FY0EHhWsEvTem1
1VTP+6eCZ+1KjmHuByjU
=C5/S
-----END PGP SIGNATURE-----

--AdPJjXNf9dpgXK0V9a84Pk8wMsDJgNa7K--

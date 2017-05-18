Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBAcK-0004Q2-6S
	for qemu-devel@nongnu.org; Wed, 17 May 2017 21:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBAcJ-0004Pi-7z
	for qemu-devel@nongnu.org; Wed, 17 May 2017 21:52:40 -0400
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39e1208c-9ed4-6c56-76d1-e5a7e46a409d@redhat.com>
Date: Wed, 17 May 2017 20:52:29 -0500
MIME-Version: 1.0
In-Reply-To: <684185116.2952708.1495044580181@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ab7OoWov7s3lQXSlLpw97E9oBWsMWiKi5"
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ab7OoWov7s3lQXSlLpw97E9oBWsMWiKi5
From: Eric Blake <eblake@redhat.com>
To: John Bradley <flypie1@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Geert Martin Ijewski <gm.ijewski@web.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <39e1208c-9ed4-6c56-76d1-e5a7e46a409d@redhat.com>
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom Perhiperals
 for ARM.
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
 <684185116.2952708.1495044580181@mail.yahoo.com>
In-Reply-To: <684185116.2952708.1495044580181@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 01:09 PM, John Bradley via Qemu-devel wrote:
> Also available at=20
>=20
> https://www.dropbox.com/s/gwuquw0kirstw7a/0001-Add-Markus-Armbrusters-c=
ode-for-Broadcom-Perhiperals.patch?dl=3D0
>=20
> Following suggestions split my original patch up. This the largest mono=
lithic chunk is=20
> additional BCM device support from Markus Armbruster.
>=20
>=20
>>From 0b39a04030d5a2cea4fcd2159d365580ca155b78 Mon Sep 17 00:00:00 2001
> From: John Bradley <flypie@rocketmail.com>
> Date: Wed, 17 May 2017 18:57:21 +0100
> Subject: [PATCH] Add Markus Armbrusters code for Broadcom Perhiperals f=
or ARM.
>=20
> Signed-off-by: John Bradley <flypie@rocketmail.com>
> ---

After a break from the keyboard (always a good idea), I've re-read my
comments on this thread so far.  As usual, email is a lousy medium for
conveying emotion and intent, and I can see how my curt replies merely
pointing out ways that you can improve your patch can easily be
misconstrued as negative advice or rejection of the idea in general.  So
let me take this time to apologize if I've come across as over-harsh,
and give you a big thanks for your efforts to contribute; your additions
have the potential to make qemu better.  I hope that we do not scare you
off with advice on improving your contributions up to community
standard, but that you feel welcome to contribute to the community, as
well as using the give-and-take iteration of review to make your first
patch great.  Writing a first patch series can be especially daunting
when you are new to an unfamiliar process, and while we were all once at
your point, it takes effort to remember that not everyone is as familiar
with open source ways, and how it felt on our own first patch submission.=


A big hint: the great way to get a patch accepted on ANY project is to
first offer reviews on other patches being submitted to the list.
Review backlog is always present, but it gets especially bad if there
are more contributors than reviewers.  Plus, reviewing code that other
people write can give you a feel for what constitutes a typical patch
for the project, which will let you model your own submissions in the
same style.

Good luck!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ab7OoWov7s3lQXSlLpw97E9oBWsMWiKi5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHP5dAAoJEKeha0olJ0Nq974H/i6CnFdxCx6faHkmGafVXGOG
4BVlU3ZYSS40FERS5stGkss3T4DDmZ9l1WYa60YoTCXpYKlvDRcouKUay0tD9anA
ticiQQ8jvRRDOVLhtd11Gn6ZGOIxgVD010qNt3tRal+yRgNZmbbnm9Ss8OiAx+Vk
411b6uxgwm9IMNLFjjLVRtW+AkRYx6Z6+lxLXLTljB2tCudSCF67kfn0U0/WHu0+
FY8d56VIrn7vUg88TiqDvV8fzfdVkaWs2QZcuXmy29F/x67QLJugj0yUsLfwpE7l
/DsF6QS/9+HhZZyxemEds+iyfGGPxl16eCZuLyQwmZhTCoNweV9Han+4wEWRmZY=
=Mqhi
-----END PGP SIGNATURE-----

--Ab7OoWov7s3lQXSlLpw97E9oBWsMWiKi5--

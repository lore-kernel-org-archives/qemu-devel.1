Received: from eggs.gnu.org ([2001:4830:134:3::10]:45446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbSrc-0007A6-Cq
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbSrb-0006hS-CG
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:04:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cbSrb-0006gq-4Q
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:04:51 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21E2F804F0
	for <qemu-devel@nongnu.org>; Wed,  8 Feb 2017 14:04:51 +0000 (UTC)
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
	<20170207232226.5557.42629.malone@wampee.canonical.com>
	<8fccd2e6-43ff-d684-d300-253fb4a4306c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61123a62-8649-cbb4-37be-5fd6953de439@redhat.com>
Date: Wed, 8 Feb 2017 15:04:42 +0100
MIME-Version: 1.0
In-Reply-To: <8fccd2e6-43ff-d684-d300-253fb4a4306c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0x70lJJpH4BegQpBn72aGBGlBQPWllIDF"
Subject: Re: [Qemu-devel] [Bug 1662468] Re: [feature request] qemu-img
 convert should respond to control-T like dd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0x70lJJpH4BegQpBn72aGBGlBQPWllIDF
From: Max Reitz <mreitz@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Message-ID: <61123a62-8649-cbb4-37be-5fd6953de439@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1662468] Re: [feature request] qemu-img convert
 should respond to control-T like dd
References: <20170207100302.3995.67911.malonedeb@chaenomeles.canonical.com>
 <20170207232226.5557.42629.malone@wampee.canonical.com>
 <8fccd2e6-43ff-d684-d300-253fb4a4306c@redhat.com>
In-Reply-To: <8fccd2e6-43ff-d684-d300-253fb4a4306c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[removed LP from CC, but kept qemu-devel because everyone is interested]

On 08.02.2017 02:29, Laszlo Ersek wrote:
> On 02/08/17 00:22, Max Reitz wrote:
>> That should be simple enough to implement considering we have this
>> behavior already on SIGUSR1. Unfortunately, I wouldn't be able to test=

>> it because Linux apparently doesn't implement SIGINFO...
>>
>> Max
>>
>>
>> PS: By the way, thanks for the information. I didn't know about SIGINF=
O at all. Well, now I have mapped Ctrl-T to SIGUSR1 in my terminal emulat=
or so I don't have to feel quite as inferior...
>>
>=20
> By that you may have lost the following Readline action:
>=20
>        transpose-chars (C-t)
>               Drag the character before point forward over the charac-
>               ter at point, moving point forward as well.  If point is
>               at  the  end  of  the line, then this transposes the two
>               characters before point.   Negative  arguments  have  no
>               effect.
>=20
> I'm sure you've been using that all the time... ;)

More importantly, I forgot that C-T is my shortcut in vim for going back
the cscope stack. I accidentally killed vim twice until I figured out
what "Vim: Caught deadly signal USR1" means.

I then put it on Ctrl-Alt-T. :-)

Max


--0x70lJJpH4BegQpBn72aGBGlBQPWllIDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibJXoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfMYIAMElISAubmICoSXDOEKM9EW67Au4X3Wa
R70yYVkCd2K9/yDnEbvGgUMlyhnbgB/OzMtn6O4wVMcYcU+SYHBi/4k/AqaUwkht
6b3JtsaFcCG3nYZoCFgQCuf+hZzq6iKN52h4fuxKLg/yjMjT90yVhDhOVRdExrIa
3SgfxCJEqNw2oTl8Xvt/LIRqzk4/cqrd/D0keS5UyeJyVB6JCMR7VQgJw2zzQ1Gx
c2708Uc308eqICrp6rGQM+JsHkSUgXj3DnhLJ5nEUceuh7vlImt+fCC4WoqMqH46
toDxYdLMpAEmD7dL2N8kZ5Vxylj/di2Jb6in/kN+eZK3TGiHdIsEv6k=
=FkiW
-----END PGP SIGNATURE-----

--0x70lJJpH4BegQpBn72aGBGlBQPWllIDF--

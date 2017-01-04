Received: from eggs.gnu.org ([2001:4830:134:3::10]:59168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cOnp1-0001aI-SC
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cOnoy-0003wa-Q4
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:49:51 -0500
Received: from ignoranthack.me ([199.102.79.106]:59335
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cOnoy-0003w5-HY
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 10:49:48 -0500
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
	<5540064c-613c-c0df-ae69-d41d45b4501d@freebsd.org>
	<ad4e7809-93e9-b5fa-a6a2-763fa8f1c97a@tuxfamily.org>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <6d7ed825-b712-62db-a6de-e42eece27075@freebsd.org>
Date: Wed, 4 Jan 2017 08:49:43 -0700
MIME-Version: 1.0
In-Reply-To: <ad4e7809-93e9-b5fa-a6a2-763fa8f1c97a@tuxfamily.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="aim6NvhtQes64r5djG26G8TAm2xpWTKQX"
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aim6NvhtQes64r5djG26G8TAm2xpWTKQX
From: Sean Bruno <sbruno@freebsd.org>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <6d7ed825-b712-62db-a6de-e42eece27075@freebsd.org>
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
 <5540064c-613c-c0df-ae69-d41d45b4501d@freebsd.org>
 <ad4e7809-93e9-b5fa-a6a2-763fa8f1c97a@tuxfamily.org>
In-Reply-To: <ad4e7809-93e9-b5fa-a6a2-763fa8f1c97a@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/03/17 23:53, Thomas Huth wrote:
> On 03.01.2017 18:11, Sean Bruno wrote:
>>
>>
>> On 01/03/17 09:18, Sean Bruno wrote:
>>>
>>> I'm pondering where to start with getting FreeBSD's bsd-user code int=
o
>>> shape so it could actually be reviewed and accepted now that its sort=
 of
>>> working again (signal handling fixed finally).
>>>
>>> I almost feel like the existing code should be purged, except that it=

>>> gives a good history (and this seems lazy to me).
>>>
>>> As a first pass, I guess, I'd like to at least make i386 user run on
>>> x86_64.  What would you folks like to see in a first pass?
>>>
>>> sean
>>>
>>> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user
>>>
>>
>> Primitive example of what I think I should base my patchset on.  Its
>> invasive and large.
>>
>> https://github.com/seanbruno/qemu-bsd-user/tree/merge1
>>
>> That branch, is all the bsd-user changes that are pending in one large=

>> "splat".  It excludes the new architectures (arm, aarch64, mips, mips6=
4)
>> that we are actively using.  i386-bsd-user when compiled statically on=

>> x86_64 will run a static (rescue) sh ... so, I think that's good.
>> x86_64 running on x86_64 just blows up.
>>
>> As for sparc/sparc64 ... I'm tempted to delete them as nobody in freeb=
sd
>> is actively maintaining them nor do we have any expectation that they
>> will work someday.
>=20
> It's broken ... nobody maintains it ... and we've got too many
> unmaintained bit-rotten files in the QEMU tree, so IMHO just go ahead
> and send a patch to remove the bsud-user sparc support. If anybody ever=

> needs it again, they can revert the commit or simply submit a patch wit=
h
> the fixed code.
>=20
>  Thomas
>=20
>=20
>=20

I agree with the exception that its way easier to nuke the sparc/64 code
after I update bsd-user.  Right now, its a tangle of #ifdef in a couple
of files that I'd like to un-tangle first.

Regardless, I can maintain the sparc/64 bsd-user target outside of qemu
until such time as someone wants to make it work or the heat death of
the universe occurs.

sean


--aim6NvhtQes64r5djG26G8TAm2xpWTKQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhtGZdfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmSRgAgAiAq79x6ks5nYnQr1AIO2P0dUDp2bUkpHdAY9XIhaAJDF2NVOObZ4K7KD
TAtUZ2v5VxhuOLsiEz5ls/u3v6V1q4rWHWADpiRyWvvrb3p1ypo5eKCS3Gx23lye
1kdBBZOEKn8l5HkPglKg5SnnrD+cJ2+xHu3TY0k7Twz3lKiz2wX4o0qdvgR6j68i
JHvcAmWi4y1Ery2pCpieYDtR9tWRimfAr82lpqpvpj/C32p6yJoWNVnXXghEuW8w
pa/KUXmDUTldeYzcqHMHxnKjB4vh/y2A/g1ORcJ5sQHTieya/tC2gdF5LIrz58BZ
BjhgPHBA3eJCjJUDQ9BVsM66DZfoMQ==
=YNPm
-----END PGP SIGNATURE-----

--aim6NvhtQes64r5djG26G8TAm2xpWTKQX--

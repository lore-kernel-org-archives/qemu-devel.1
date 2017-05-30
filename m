Received: from eggs.gnu.org ([2001:4830:134:3::10]:51378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFi06-0004sU-Fm
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFi02-00053e-DV
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFi02-00053P-4O
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:19:54 -0400
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
	<8737cbv53y.fsf@dusky.pond.sub.org>
	<CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <731948bf-cd1d-5244-4a4f-dad2b14b85f3@redhat.com>
Date: Tue, 30 May 2017 09:19:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DqHXklRI23pGID1N9wGlGIBQbPm9AbFsf"
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqHXklRI23pGID1N9wGlGIBQbPm9AbFsf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <731948bf-cd1d-5244-4a4f-dad2b14b85f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-5-marcandre.lureau@redhat.com>
 <8737cbv53y.fsf@dusky.pond.sub.org>
 <CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 02:32 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, May 11, 2017 at 6:30 PM Markus Armbruster <armbru@redhat.com> w=
rote:
>=20
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>>
>>> + *
>>> + * This work is licensed under the terms of the GNU LGPL, version 2.=
1
>> or later.
>>> + * See the COPYING.LIB file in the top-level directory.
>>> + */
>>> +
>>> +#ifndef QNUM_H
>>> +#define QNUM_H
>>> +
>>> +#include "qapi/qmp/qobject.h"
>>> +
>>> +typedef enum {
>>> +    QNUM_I64,
>>> +    QNUM_DOUBLE
>>> +} QNumType;
>>
>> Not bool because you're going to add to it.  Good.
>>
>>
> Hmm? There is no plan to add bool there so far, I am not sure that make=
s
> sense.

I think the intent was more along these lines:

"Using a two-element enum instead of a bool because a later patch will
add to the enum" (with the implication that an enum is better for
representing tri-state than a pair of bools).

At any rate, the only change I'd make is to add the trailing comma to
QNUM_DOUBLE (C99 permits trailing commas, and consistently using them
makes for less churn down the road when extending an enum).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DqHXklRI23pGID1N9wGlGIBQbPm9AbFsf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLX+HAAoJEKeha0olJ0NqhtwIAIUnUYH9VgAQwfQg7E92IY4V
5N0oH0gHviMkZYZybtjohepo/sh2lBP5Gaf22CL7CNmIxoKOyKfrwVt0Q0msBlee
gh9HJDtYJOPHpN7QMQBk39TV8iX1H1X38Qwhhgl901/uFR1qgqdQvW2erTvT1c0S
sLIfxn7rVx7GQiOXu70RmtjrphljcuH1pRYg2DvUvxJ73QkjByLLRQHkipOiEzsq
tOOg1upEyp6bJbwvivXVYTYOvDTkNG7Tjci/WES9vWx5pS02zTVcs4m7xBiwDlzp
Ni2RddQCMzrGClxDHuaovoMjmZ6GKOSWuRwIvylKsS3JPFRc4+ZaFWlUWlBTbJI=
=8pdY
-----END PGP SIGNATURE-----

--DqHXklRI23pGID1N9wGlGIBQbPm9AbFsf--

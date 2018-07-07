Received: from eggs.gnu.org ([2001:4830:134:3::10]:46739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbrUJ-0004vb-AN
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fbrUG-0000oC-A1
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:59:15 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:45953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fbrUF-0000mg-Ve
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 13:59:12 -0400
Received: by mail-pl0-x242.google.com with SMTP id bi1-v6so4241681plb.12
	for <qemu-devel@nongnu.org>; Sat, 07 Jul 2018 10:59:11 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-4-mdavidsaver@gmail.com>
	<20180706033942.GN3450@umbus.fritz.box>
	<b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
Message-ID: <a9bbb6ec-ebe1-65aa-07df-abb1b2853e52@gmail.com>
Date: Sat, 7 Jul 2018 10:59:07 -0700
MIME-Version: 1.0
In-Reply-To: <b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tPfajKKpBTgYhBX7J4IzLWtRsrBUO41sv"
Subject: Re: [Qemu-devel] [PATCH 03/14] timer: ds1338 persist 12-hour mode
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tPfajKKpBTgYhBX7J4IzLWtRsrBUO41sv
From: Michael Davidsaver <mdavidsaver@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org
Message-ID: <a9bbb6ec-ebe1-65aa-07df-abb1b2853e52@gmail.com>
Subject: Re: [PATCH 03/14] timer: ds1338 persist 12-hour mode selection
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
 <20180705182001.16537-4-mdavidsaver@gmail.com>
 <20180706033942.GN3450@umbus.fritz.box>
 <b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
In-Reply-To: <b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/05/2018 09:35 PM, Michael Davidsaver wrote:
> Also, I though I had test coverage of this bug.  That's actually how I
> noticed it to begin with.  But it seems my later change to allow for a
> slow test runner also stopped testing readback of the 12/24 hour mode b=
it.
> It just silently uses whichever it reads.  I'll be re-issuing an update=
d
> version which restores this check.  Then you will be able to easily
> see the effect of reverting 'timer: ds1338 persist 12-hour mode selecti=
on'.

I've posted revised versions of two of the three test patches #6 and #7
(which I've hopefully posted correctly...).  #6 again tests for this issu=
e.
So you can demonstrate the problem by either applying 1,2,4-6, or just 1 =
and 6
to see that the issue is present in the original implementation.

The test failure should be:

> test_rtc_set: assertion failed (mode_expect =3D=3D mode_actual): (1 =3D=
=3D 0)

Which shows that a write with 12 hour mode is read back as 24 hour mode.

Similarly, omitting patch #5 will cause the tests added in #7 to fail.


--tPfajKKpBTgYhBX7J4IzLWtRsrBUO41sv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEYyRdrpxuENu06SOrlAHmyz1/GOoFAltA/2sACgkQlAHmyz1/
GOouzg//Snr4NjSJJ28JXP7Z7lX/q8V/vP7NAaw0B8cWbICcAWTi8rnt40/ZubTb
jps/YqE4YJljV2DHwGh+8sQbXqTAG1UjyJHJNVPQiWiuXAtZ/nnJpoheM6iWqb4L
I+KX/F1atosFiMkzEzG6qRcRRGOkbg9Ee2FHJwKitqQ41//azmdXQBpF6hiWOnea
IAXw6D+I+uPbJ7ooz2Jg+rQCVAZhXxQEKSk6n9dY+iUxFjFWsSALTx9ML92eW+yn
9VTwKLp+fj/6EM0fWtvP7X5lb3XqwcmaLf0oh77EJlA4lpkJtRr+fybNTdFD7Gsz
R176seM9Fym/E1kk33NIjP9M9EjW0OJmD8U0aA8WBOkLPru2ExFJ6r+jtVCwnX1C
cM8DNItbaB9bh+R5Cam+1lQ7/MU0AkC/H59FcgpWdFEBfWU7mUkFv4hpTXdin9XS
pIvcPWtpn55eU7hJtKKCv8uyvfS3RmnvZM59B5QAmgI1AXtjAB+mCGLVmT0C8pAY
tla1WSWsHy2/ov2y6BIIixL71sgTBuYfmHaT1U7w430x5MKEejuLlXJaQFmRfOkJ
KXeCWBwQMxeXr6WgMfrlRaq53rjoG9amGY/zfbGCvS3bCijFa0xXKpW/y3z7I77+
kRZyZUMtyrkbrz1SPclKKe6xQxxCTJ9dOBw6Avs6mX9fMYcRUZo=
=0TEz
-----END PGP SIGNATURE-----

--tPfajKKpBTgYhBX7J4IzLWtRsrBUO41sv--

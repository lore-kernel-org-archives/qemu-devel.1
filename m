Received: from eggs.gnu.org ([2001:4830:134:3::10]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEhvf-0001KB-De
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEhve-0006IJ-CS
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 15:35:31 -0500
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
	<CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
	<94700229-5afe-159f-9453-f507b9c83085@redhat.com>
	<0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
	<9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
	<1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
	<20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
	<e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <89062bb7-f2fa-db5e-d799-c61e1daa6b99@redhat.com>
Date: Tue, 14 Nov 2017 21:35:18 +0100
MIME-Version: 1.0
In-Reply-To: <e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cMR9u3SeDosC5OBJdJPuvPtLaC3MsRQCj"
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow
 v1 to v2 creates a qcow v3 file?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cMR9u3SeDosC5OBJdJPuvPtLaC3MsRQCj
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Message-ID: <89062bb7-f2fa-db5e-d799-c61e1daa6b99@redhat.com>
Subject: Re: [Qemu-devel] using "qemu-img convert -O qcow2" to convert qcow v1
 to v2 creates a qcow v3 file?
References: <CAFEAcA_bXripv8_O8aRuDbdYQ3oWeVzdb8GO=o9j2oddYrg-0A@mail.gmail.com>
 <CAFEAcA9DK=rb-9Jei+U3xhcVM_oscpY09nANoy4QUpfNeqOMVA@mail.gmail.com>
 <94700229-5afe-159f-9453-f507b9c83085@redhat.com>
 <0c42f84d-9096-3f7b-c71d-664a119bc8a2@redhat.com>
 <9ab7ae12-730d-a4d4-287c-64dcd509b680@redhat.com>
 <1fa78bdf-65e2-c216-49a2-7277231a7141@redhat.com>
 <20253223-df8f-162d-b8c8-dfa56af9fffd@redhat.com>
 <e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
In-Reply-To: <e76811c5-6a5a-cf5e-2571-9e112e609740@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-14 21:30, John Snow wrote:
>=20
>=20
> On 11/14/2017 01:46 PM, Max Reitz wrote:
>> On 2017-11-14 19:45, Thomas Huth wrote:
>>> On 14.11.2017 14:32, Max Reitz wrote:
>>> [...]
>>>> Well, do you want to document it?  I'd rather deprecate it altogethe=
r.
>>>
>>> Maybe a first step could be to change qemu-img so that it refuses to
>>> create new qcow1 images (but still can convert them into other format=
s).
>>> So basically make qcow1 read-only?
>>
>> Yep, and the actual first step to that is to make it issue a deprecati=
on
>> warning when creating qcow v1 images (which is what I proposed). :-)
>>
>> Max
>>
>=20
> Deprecation warning is good.
>=20
> In future versions you can shimmy it behind a
> --no-really-I-want-this-old-format option, I think we ought to support
> creating the images for as long as is technologically convenient.

Well, at some point you can also demand from users to just dig out some
old version of qemu-img to convert their qcow v1 images to qcow2.  It's
not like they are going to miss out on anything.

(If you deprecate emulated hardware, users may complain that they don't
get the newest qemu features/bugfixes/... while continuing to use that
hardware, so I can see that it's a tough decision whether to deprecate
that.  But it's not like you are going to lose any features or anything
if you convert your dusty images to qcow2.  On the contrary, we're
helping you to get more performance out of them.  Maybe qemu should just
silently convert qcow v1 images to qcow2 without asking the user, like
Apple did...)

Max


--cMR9u3SeDosC5OBJdJPuvPtLaC3MsRQCj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLU4YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4DYIAMQj+RhpU2tC+mpc3b36UP0xG8YYucgK
H8wQIDH/8IMe+nMhlBT0y2FwAN9Buv/8kOEB+q2/e6uCPjIKlAlK0FHVpdENEycM
q4PZypm5abrpKBBtE3b0BXkhxqSB8Ukm181nNtto4I31cz3XFSA763S1AurDVYxR
7b6QIPY/AN4j7+yzvuh67RtGBm4nw5JLXtHtcE7DJvvUqxmqnI6+BtCM245FC1ot
es8yzaS22kE0faj1RzTaH1jWR2G1CCFJ9fQ5VBM6Reqx8Kzf87Om+MnQnlJYoqvN
cYnT19n1e2oxj9tdNwipnJyE0Rq/GqszbNREvpIyMa/1uB32wJQK6dM=
=YMF5
-----END PGP SIGNATURE-----

--cMR9u3SeDosC5OBJdJPuvPtLaC3MsRQCj--

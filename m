Received: from eggs.gnu.org ([2001:4830:134:3::10]:41770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRZJ-0007PW-Kf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRZI-0003Mm-QN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:59:45 -0400
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-2-mreitz@redhat.com>
	<CAJ+F1CJtT6u6ejLwmTTRWz96c6QW13pZVMF1+hTLXxD1qeV1XQ@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bcedefc0-e29e-02f8-f450-3b955b677636@redhat.com>
Date: Fri, 19 Oct 2018 11:59:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJtT6u6ejLwmTTRWz96c6QW13pZVMF1+hTLXxD1qeV1XQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pDWCXBJ6S58euYgb00ovbSdFqDJu1vWhH"
Subject: Re: [Qemu-devel] [PATCH 1/5] option: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pDWCXBJ6S58euYgb00ovbSdFqDJu1vWhH
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <bcedefc0-e29e-02f8-f450-3b955b677636@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] option: Make option help nicer to read
References: <20181015172817.19796-1-mreitz@redhat.com>
 <20181015172817.19796-2-mreitz@redhat.com>
 <CAJ+F1CJtT6u6ejLwmTTRWz96c6QW13pZVMF1+hTLXxD1qeV1XQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJtT6u6ejLwmTTRWz96c6QW13pZVMF1+hTLXxD1qeV1XQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 08:46, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Oct 15, 2018 at 9:34 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> This adds some whitespace into the option help (including indentation)=

>> and replaces '=3D' by ': ' (not least because '=3D' should be used for=

>> values, not types).
>=20
> Without strong preference, I like the '=3D' better: it's the expected
> syntax for the command line argument. (also, --help and man pages
> describe options with "foo=3Dtype", not "foo: type")

Define "strong".  I do believe that types are different from values, and
that '=3D' is reserved for values and never used with types.

It's not like I'll die when we keep '=3D', though, but it's definitely no=
t
what I'd use.  Maybe "foo=3D<str>", but that feels overly cluttered when
compared to "foo: str".  (Especially when it comes to things like
"iothread=3D<link<iothread>>".)

>> Furthermore, the list name is no longer printed as
>> part of every line, but only once in advance, and only if the caller d=
id
>> not print a caption already.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> looks good to me otherwise

Well, if '=3D' is the only trouble, that's good. :-)

Max


--pDWCXBJ6S58euYgb00ovbSdFqDJu1vWhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJqv4ACgkQ9AfbAGHV
z0BT8wf7BxqmxabuKUIBBvFWurInvNqyItEvBHZFiiJdWfXsc/S3qdOWpST3je1U
Wo7brDqVgcxd/jTiYmc3hku1OpPxJ9NRL56QGSwN2wrGqXB2DxFRF11XHPIgyqSm
+40bHrT2z/ZgLjjnnBBdEWCW4jwNN0EM0ylYL0xqdvIWaCnDWm7+5yXbTMLHcxWS
3yQSaMippocwLcwQ6OCYlcGdFBPLBDXGQnnedQg/NNVPqGgUPjxXTvA3BxEyWt82
3CnVcGqzE1DjEZXO2MxeUiwdW6oVANcv4VF+nARBAxLrlTm8jknXTJUFHaKe1c4l
3i5Br1eWAYcLNCQo5vs13wA3LxdWhQ==
=dSro
-----END PGP SIGNATURE-----

--pDWCXBJ6S58euYgb00ovbSdFqDJu1vWhH--

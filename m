Received: from eggs.gnu.org ([2001:4830:134:3::10]:38935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMzQC-0003vW-9g
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMzQB-0006Cu-H0
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:53:16 -0500
References: <20171207084453.23773-1-famz@redhat.com>
	<20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c49bb9b8-a314-88d2-841e-8748d32c6777@redhat.com>
Date: Thu, 7 Dec 2017 10:53:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rkHAnxLx7tQ6MpVhqNmQcoOMnxr68KaWv"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Document
 --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rkHAnxLx7tQ6MpVhqNmQcoOMnxr68KaWv
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <c49bb9b8-a314-88d2-841e-8748d32c6777@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Document
 --force-share / -U
References: <20171207084453.23773-1-famz@redhat.com>
 <20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
In-Reply-To: <20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 04:58 AM, Kashyap Chamarthy wrote:
> On Thu, Dec 07, 2017 at 04:44:53PM +0800, Fam Zheng wrote:
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>>  qemu-img.texi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index fdcf120f36..3aa63aad55 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -57,6 +57,14 @@ exclusive with the @var{-O} parameters. It is curre=
ntly required to also use
>>  the @var{-n} parameter to skip image creation. This restriction may b=
e relaxed
>>  in a future release.
>> =20
>> +@item --force-share (-U)
>> +
>> +If specified, qemu-img will open the image with shared permissions, w=
hich makes
>=20
> Does 'texi' requires to quote tools like `qemu-img` (or single quotes),=

> to highlight them in documentation?

Our usual markup appears to be:

@code{qemu-img}

>=20
>> +it less likely to conflict with a running guest's permissions due to =
image
>> +locking. For example, this can be used to get the image information (=
with
>> +'info' subcommand) when the image is used by a running guest. Note th=
at this
>> +could produce inconsistent result because of concurrent metadata chan=
ges, etc..
>=20
> Super nit-pick:  an ellipsis[*] is three dots :-), so, when applying yo=
u
> might want to: s/../.../
>=20
> [*] https://dictionary.cambridge.org/dictionary/english/ellipsis

Except that both "etc." and "..." independently convey a sense of
continuation, which means that using both at once is both redundant
(just one will do) and difficult to argue how to typeset (since 'etc.'
is often written with an explicit '.' to emphasize that is an
abbreviation, does that mean you have to write 'etc.''...' for a total
of 4 dots?).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rkHAnxLx7tQ6MpVhqNmQcoOMnxr68KaWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlopce4ACgkQp6FrSiUn
Q2pdeAgAkXYch5/tccqJqnxQqgWiPvjRAo+Bgaf5UmE2cEOzif95N25SXf1lUGK3
xvHFpOLSvVV3jJJQR47dgJSyCXtiQTFEmBtnPhFZN5NQTM34IgNDIjUEIPNZd8rb
UDIdjXudLGgLQWkwHkDaItL7nQ/7RWBmgnlgsiq9qPWM50rgC0gGHV9Y6hk2LFyW
rv7VTNtcghC3R/rNo6hG538oaHPkAns2xfN0lwYK4V88E2gWiuhG+albAswkwCEe
/nOBRs2YF1mVl4tXcOCmzVcyMgchKIMbAqD5hEEew8jFIblhFocvzeMy1hIEGnn6
DvAop/H8xPGnX/MuqSNUQyPgBAGZ2Q==
=Uo8k
-----END PGP SIGNATURE-----

--rkHAnxLx7tQ6MpVhqNmQcoOMnxr68KaWv--

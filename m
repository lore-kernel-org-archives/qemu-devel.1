Received: from eggs.gnu.org ([2001:4830:134:3::10]:46789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0zB-0000yg-Nt
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dS0zA-00011T-LR
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:01:53 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-4-mreitz@redhat.com>
	<a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <414fd97a-a243-8ab2-1cea-03ca9add6fab@redhat.com>
Date: Mon, 3 Jul 2017 15:01:17 +0200
MIME-Version: 1.0
In-Reply-To: <a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GRG7tFi6MJp52nhaQJGw69xV8P1rMiXAA"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GRG7tFi6MJp52nhaQJGw69xV8P1rMiXAA
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <414fd97a-a243-8ab2-1cea-03ca9add6fab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-4-mreitz@redhat.com>
 <a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
In-Reply-To: <a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-03 14:51, Eric Blake wrote:
> On 07/03/2017 07:25 AM, Max Reitz wrote:
>> Currently, bdrv_reopen_prepare() assumes that all BDS options are
>> strings. However, this is not the case if the BDS has been created
>> through the json: pseudo-protocol or blockdev-add.
>>
>> Note that the user-invokable reopen command is an HMP command, so you
>=20
> s/invokable/invocable/

I was asking this myself when writing this commit message and actually
consulted Wiktionary: https://en.wiktionary.org/wiki/invokable

>> can only specify strings there. Therefore, specifying a non-string
>> option with the "same" value as it was when originally created will no=
w
>> return an error because the values are supposedly similar (and there i=
s
>> no way for the user to circumvent this but to just not specify the
>> option again -- however, this is still strictly better than just
>> crashing).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>=20
>> +            /* TODO: When using -drive to specify blockdev options, a=
ll values
>> +             * will be strings; however, when using -blockdev, blockd=
ev-add or
>> +             * filenames using the json:{} pseudo-protocol, they will=
 be
>> +             * correctly typed.
>> +             * In contrast, reopening options are (currently) always =
strings
>> +             * (because you can only specify them through qemu-io; al=
l other
>> +             * callers do not specify any options).
>> +             * Therefore, when using anything other than -drive to cr=
eate a BDS,
>> +             * this cannot detect non-string options as unchanged, be=
cause
>> +             * qobject_is_equal() always returns false for objects of=
 different
>> +             * type.  In the future, this should be remedied by corre=
ctly typing
>> +             * all options.  For now, this is not too big of an issue=
 because
>> +             * the user simply can not specify options which cannot b=
e changed
>=20
> Seeing "can not" usually looks wrong for "cannot"; but here, it is
> grammatically correct.  But better would be "the user can simply not
> specify" or "the user can simply avoid specifying options".

Awww, I deliberately designed the sentence so I could use "can not". :-)

(and even contrast it with the following "cannot"!)

>> +             * anyway, so they will stay unchanged. */
>=20
> The grammar tweak is minor, so:
> Reviewed-by: Eric Blake <eblake@redhat.com>
Please let me keep it :-)

Max


--GRG7tFi6MJp52nhaQJGw69xV8P1rMiXAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZWkAdEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQATx
B/9orRbQE34nD92d2tuzusBzy3BJH28z7WUHImtDjjUjn7HAv4/ZW5c/S0sCBq50
8UnhFVOnJxxOKJzw5Bmnw6WnldKPftsCDFdwfpDG+rkQxHSy4Vb1lh7oFlluBlfw
27H9RkTpWT3v8Llet1ngaDygBLo77sKz1CgMPegT5elj6EUF6Aant7W4tRXcgOvr
mgjvFWOLttqwBwKyz8OErHMtLNCx6NKHYLulbfsEvoQY2LHRtSh20EEPyF16sGED
DKc+DTSlNkPDEneIzkNuqadXyJmTDtRsMoqCEC05M33+7ihDnT2uEpvCgrV/8tvx
YzUP5srohKrbhyE0Mv07CQLE
=bIln
-----END PGP SIGNATURE-----

--GRG7tFi6MJp52nhaQJGw69xV8P1rMiXAA--

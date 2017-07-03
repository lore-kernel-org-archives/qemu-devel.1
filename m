Received: from eggs.gnu.org ([2001:4830:134:3::10]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS2MP-0000YS-Qr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS2MO-0005iK-SW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:29:57 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-4-mreitz@redhat.com>
	<a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
	<414fd97a-a243-8ab2-1cea-03ca9add6fab@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fa3df9b2-f502-91d8-7588-181ea2b3f259@redhat.com>
Date: Mon, 3 Jul 2017 09:29:49 -0500
MIME-Version: 1.0
In-Reply-To: <414fd97a-a243-8ab2-1cea-03ca9add6fab@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Arh53fmte4tateOdfxHnIEBtCVqpVDSht"
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Arh53fmte4tateOdfxHnIEBtCVqpVDSht
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <fa3df9b2-f502-91d8-7588-181ea2b3f259@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-4-mreitz@redhat.com>
 <a36ef7da-de27-6cc7-5194-d343d05497c1@redhat.com>
 <414fd97a-a243-8ab2-1cea-03ca9add6fab@redhat.com>
In-Reply-To: <414fd97a-a243-8ab2-1cea-03ca9add6fab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 08:01 AM, Max Reitz wrote:
> On 2017-07-03 14:51, Eric Blake wrote:
>> On 07/03/2017 07:25 AM, Max Reitz wrote:
>>> Currently, bdrv_reopen_prepare() assumes that all BDS options are
>>> strings. However, this is not the case if the BDS has been created
>>> through the json: pseudo-protocol or blockdev-add.
>>>
>>> Note that the user-invokable reopen command is an HMP command, so you=

>>
>> s/invokable/invocable/
>=20
> I was asking this myself when writing this commit message and actually
> consulted Wiktionary: https://en.wiktionary.org/wiki/invokable

My intuitive reasoning for favoring 'c' is that we spell it
"invocation", not "invokation", even if the short form is "invoke".

But I also consulted dictionary.com before writing my original reply:
http://www.dictionary.com/browse/invocable
which pulls up "invoke" as the primary, and only lists "invocable" (and
not "invokable") as the related form adjective.

Meanwhile, you are correct that wiktionary does list both forms as
alternates of one another, so I can live with the 'k' even though it
looks odd.


>>> +             * all options.  For now, this is not too big of an issu=
e because
>>> +             * the user simply can not specify options which cannot =
be changed
>>
>> Seeing "can not" usually looks wrong for "cannot"; but here, it is
>> grammatically correct.  But better would be "the user can simply not
>> specify" or "the user can simply avoid specifying options".
>=20
> Awww, I deliberately designed the sentence so I could use "can not". :-=
)
>=20
> (and even contrast it with the following "cannot"!)

Maybe it's just that I'm being thrown off by the placement of 'simply';
as a native speaker, I have an easier time parsing "can simply not" than
I do "simply can not", maybe because of where the emphasis of "simply"
is falling.  Which is perhaps weird, because in the infinitive form
(coming up with a construct that uses "to" instead of "can"), I note
that "it is possible to simply not specify options" is a split
infinitive (which style guides tell you to avoid, even though I think it
is acceptable); while "it is possible simply to not specify options"
satisfies more style guides.

But since you are intentionally doing it for the play on words,

>=20
>>> +             * anyway, so they will stay unchanged. */
>>
>> The grammar tweak is minor, so:
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> Please let me keep it :-)

you can keep it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Arh53fmte4tateOdfxHnIEBtCVqpVDSht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWlTdAAoJEKeha0olJ0Nq7HQH/0kK7T9/HC7V15naqWP2NmCg
Oa0eOz8LgBiB3wefhC+j8+WhcDTRUkfQ1HUjVezMN9WgsNvE8drRtoqIsR/nurQs
n1pnO+/7kWv0SSGNC1UEccBu8M0RAFfuHPnIXYyRRD4AIjGQUGpthu1eJUX+i5m0
NvyX3qzoML+2PhDMt0tcHyF5q/EEOZu0xyATY7tY5aCE8iBS9p9/8cK+7CFmEkoA
J3SryQWscovKigi6Tnm3GGCYm4FwMYHZC6EYnwgBPG9jC4TtWmx/qQoeUOAeo4L9
0N1vWvCxPqGAfI3FiuWNlvAALwCavFBGJOGOU4tWT77+yuUvc/HiQuNRx5YS6GA=
=lfAg
-----END PGP SIGNATURE-----

--Arh53fmte4tateOdfxHnIEBtCVqpVDSht--

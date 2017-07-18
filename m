Received: from eggs.gnu.org ([2001:4830:134:3::10]:45508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYSd-0000ns-Du
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXYSc-0003Xh-Ak
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:47:11 -0400
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
	<c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
	<87y3rlrct2.fsf@dusky.pond.sub.org> <87lgnlcyz7.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e69c0e46-8470-c994-0caa-3498d1f429c2@redhat.com>
Date: Tue, 18 Jul 2017 14:47:01 -0500
MIME-Version: 1.0
In-Reply-To: <87lgnlcyz7.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OGpRKo8aiSnWOD011l5N02TTRg86Sd8lK"
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OGpRKo8aiSnWOD011l5N02TTRg86Sd8lK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com
Message-ID: <e69c0e46-8470-c994-0caa-3498d1f429c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first class
 'null' type
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
 <1500385286-21142-4-git-send-email-armbru@redhat.com>
 <e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
 <c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
 <87y3rlrct2.fsf@dusky.pond.sub.org> <87lgnlcyz7.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgnlcyz7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 02:43 PM, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 07/18/2017 09:53 AM, Eric Blake wrote:
>>>> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>>>>> I expect the 'null' type to be useful mostly for members of alterna=
te
>>>>> types.
>>>>>
>>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>> ---
>>>>
>>>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>> Actually, do we need to update any qapi docs to mention the new built=
in
>>> type?
>>
>> Yes, we do.  I'll give it a shot.
>=20
> Incremental patch appended.  May I keep your R-by?
>=20
>=20
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.tx=
t
> index 52e3874..6d8e00c 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -283,6 +283,7 @@ The following types are predefined, and map to C as=
 follows:
>                         accepts size suffixes
>    bool      bool       JSON true or false
>    any       QObject *  any JSON value
> +  null      QNull *    JSON null
>    QType     QType      JSON string matching enum QType values

I might have grouped 'null' next to 'bool', but your layout is also
okay.  Yes, my R-b is still valid with this addition.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OGpRKo8aiSnWOD011l5N02TTRg86Sd8lK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluZbUACgkQp6FrSiUn
Q2pHsAf+O3FmjjnFGLquSIoA5GbUhuJ/OEa9YmGScxiv9m8ffZ4z0o63Zlqzz49K
EWmdowVdfoNBSW+b9Kdx6dt9qE1akav5JkNJhnqYR0m42EeJKMpD+Che9izBq6TG
zj28HUNLlhmgnqz4u3L/oqTh4egUpSm7YzblIA5azorVxjTVdt8LE/+eJpNdI9aQ
mk3MIRnx6E/rkF5BgUu5/1peOe0SQ5WCORWhbdRUYUbiVuW7k7P6TRmNd2jve7YD
507g6mpwYED9ivYNXHxM8QsqBjEIQyygp5OiL/AVPzpsgTS0ed2h7CawpJ0NWqy3
ea7FYXuChxSoL4ACjHGk1D6ZnQXqxA==
=d6C2
-----END PGP SIGNATURE-----

--OGpRKo8aiSnWOD011l5N02TTRg86Sd8lK--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:32877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUg4-0002aP-Vr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXUg3-0008W6-RE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:44:49 -0400
References: <20170718003422.4497-1-jsnow@redhat.com>
	<20170718003422.4497-3-jsnow@redhat.com>
	<c04b638b-1f22-91ce-5297-1bb713f7f1e6@redhat.com>
	<e5627ad4-89bc-a25e-3d14-12abc82f4e64@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <215d40eb-09d5-ad9f-1f91-f3ddb683a7dc@redhat.com>
Date: Tue, 18 Jul 2017 10:44:39 -0500
MIME-Version: 1.0
In-Reply-To: <e5627ad4-89bc-a25e-3d14-12abc82f4e64@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vUkSThXgjxj2XopdqtMdnJvaekG3D7Bwh"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] qemu-img: Check for backing image
 if specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vUkSThXgjxj2XopdqtMdnJvaekG3D7Bwh
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <215d40eb-09d5-ad9f-1f91-f3ddb683a7dc@redhat.com>
Subject: Re: [PATCH v5 2/2] qemu-img: Check for backing image if specified
 during create
References: <20170718003422.4497-1-jsnow@redhat.com>
 <20170718003422.4497-3-jsnow@redhat.com>
 <c04b638b-1f22-91ce-5297-1bb713f7f1e6@redhat.com>
 <e5627ad4-89bc-a25e-3d14-12abc82f4e64@redhat.com>
In-Reply-To: <e5627ad4-89bc-a25e-3d14-12abc82f4e64@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 10:33 AM, John Snow wrote:
>=20
>=20
> On 07/18/2017 08:51 AM, Eric Blake wrote:
>> On 07/17/2017 07:34 PM, John Snow wrote:
>>> Or, rather, force the open of a backing image if one was specified
>>> for creation. Using a similar -unsafe option as rebase, allow qemu-im=
g
>>> to ignore the backing file validation if possible.

>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Really? It seems like you've changed since v4.
>>
>=20
> Duh. I missed this because the patchset grew to two patches, same with
> revising the message. I'm sorry about that.

Kevin's got it on his block branch, with that fixed already. No problem.

>>>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
>>
>> On v4, we talked about making this use qemu_opt_get_size(, -1) to make=

>> it less confusing about how qemu_opt_get_size() refers back to a
>> caller-provided default embedded in QemuOpt (rather than the parameter=
).>
>=20
> I actually got scared away from this because of the get_size signature,=

> is it safe to pass -1 here?

I'm posting a separate patch for that now (yours is fine left alone,
because it is pre-existing).

>=20
>>> +        if (!bs && size !=3D -1) {
>>> +            /* Couldn't open BS, but we have a size, so it's nonfata=
l */
>>> +            error_reportf_err(local_err,
>>> +                              "Warning: could not verify backing ima=
ge. "
>>> +                              "This may become an error in future ve=
rsions.\n");
>>
>> Patchew rightly complained here about the trailing newline. Also, we
>> have the new warning* functions merged in, this should probably be usi=
ng
>> those (see commit 3dc6f869, for example)
>>
>=20
> I tried omitting it, but the printing looked wrong, and the test would
> mash input against the tail of the sentence.

Kevin adjusted it slightly on the block branch. If patchew still
complains, we may need to fix checkpatch.pl (the semantics of
error_reportf_err() are slightly different than error_setg(), after all).=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vUkSThXgjxj2XopdqtMdnJvaekG3D7Bwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlluLOcACgkQp6FrSiUn
Q2oUeQf/X5Ckby8taxdOtZg0KnQ2HoA1PljmY/NBSH3DzRrdKqC6SegUKNqNT2iq
hQkvFCPcahJ/ntk+krIDc/rn8tVQ35/Y84PGFZFJOJgx02iSzosNeiCJqxxbrDwC
WEr+b6e3dH6pXg3JiosGHGNUF5lTPzUO5jQ/VATHzjslIlPOAtp8flcmIx+OWAfv
e3/NoI6bs0QWLOIFDeOmaTWM1mH2iUv9xgtLhhQ/004/S+IOo8WjPA3svfqMJ0EH
Hai99hXq3qpcuwoLtidIBnKf0EhSID6IVV1IRMR/QWWGBHXQh7nNRUjAG/prVA3o
cyHyW47y4qPRiWd+hdW3KZnFE6zG7w==
=+58K
-----END PGP SIGNATURE-----

--vUkSThXgjxj2XopdqtMdnJvaekG3D7Bwh--

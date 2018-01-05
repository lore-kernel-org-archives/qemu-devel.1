Received: from eggs.gnu.org ([2001:4830:134:3::10]:41971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUkK-0002xj-Oc
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:21:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXUkH-0000LO-Hh
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:21:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXUkH-0000K8-7F
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:21:25 -0500
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131650eucas1p183c745b845ded5e02e842582bb44fd7b@eucas1p1.samsung.com>
	<1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
	<64a69d83-c575-5bd2-66f4-5b88172418a2@redhat.com>
	<83b57241-63b2-c4c2-8b37-9fc288de53f6@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e05d57c3-cb27-a9be-83f2-4c54b3a96372@redhat.com>
Date: Fri, 5 Jan 2018 10:21:19 -0600
MIME-Version: 1.0
In-Reply-To: <83b57241-63b2-c4c2-8b37-9fc288de53f6@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5iTtsOytBmVAHFrN2BOoOYyaCEXgRXN7V"
Subject: Re: [Qemu-devel] [PATCH v12 6/6] migration: add postcopy total
 blocktime into query-migrate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5iTtsOytBmVAHFrN2BOoOYyaCEXgRXN7V
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com, i.maximets@samsung.com
Message-ID: <e05d57c3-cb27-a9be-83f2-4c54b3a96372@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 6/6] migration: add postcopy total
 blocktime into query-migrate
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
 <CGME20171030131650eucas1p183c745b845ded5e02e842582bb44fd7b@eucas1p1.samsung.com>
 <1509369390-8285-7-git-send-email-a.perevalov@samsung.com>
 <64a69d83-c575-5bd2-66f4-5b88172418a2@redhat.com>
 <83b57241-63b2-c4c2-8b37-9fc288de53f6@samsung.com>
In-Reply-To: <83b57241-63b2-c4c2-8b37-9fc288de53f6@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 06:15 AM, Alexey Perevalov wrote:
> On 01/03/2018 12:26 AM, Eric Blake wrote:
>> On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
>>> Postcopy total blocktime is available on destination side only.
>>> But query-migrate was possible only for source. This patch
>>> adds ability to call query-migrate on destination.
>>> To be able to see postcopy blocktime, need to request postcopy-blockt=
ime
>>> capability.
>> Why not display the stats unconditionally when they are available,
>> instead of having to set a capability knob to request them?
> That knob necessary to avoid regression if this information
> is not necessary, we decided during so long discussion in previous
> version of the patch set - it's not necessary always.
> But if user requested blocktime and host can't calculate it,
> e.g. due to appropriate feature isn't supported in host kernel,
> yes, the value will be 0.
>=20

>>> =C2=A0 #
>>> +# @postcopy-blocktime: total time when all vCPU were blocked during
>>> postcopy
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 live m=
igration (Since 2.11)
>> 2.12 now.
>>
>> Should this mention the capability knob needed to enable this stat (or=

>> else get rid of the capability knob and always expose this when
>> possible)?
>>

Okay, so you've explained that the knob is necessary because there is a
noticeable performance difference for users that don't care about the
statistic; in which case, we DO need a followup patch (or a v2 of Juan's
pull request) that documents that this statistic is useless unless you
set the migration capability.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5iTtsOytBmVAHFrN2BOoOYyaCEXgRXN7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPpf8ACgkQp6FrSiUn
Q2oeuQgAhBpc0LOfKjM1be/GLyLGIAFiIrcwxYfiz7GOl+lZ/rlwvYQTkLijh8QG
8Bafcn19a4noOv2nEmSyEHX/eagttn427L2fyp7oFpWk7t5m3VP+FicXcHr6ZapS
s5kWuXMcrnHKjosPKRYso9froRdCK2vpdRHiCTz6RuUNDpKA2j5G0P/4zZgJVAAt
csqCWtlJ+dEO6KUdjwh0SsxrCy06lkfqTRVm1khAi3wxrBFLzEkUkLxYgA2etMX/
OSRgzLnpUDlv+PeMQGoXNlxk8eq/h6CGm95j9G5pQJjCLvvmbCQzn6GS810RTKES
t1F5ts+wmnbn6TUB61x3UiYCHZ1iTw==
=L0Ou
-----END PGP SIGNATURE-----

--5iTtsOytBmVAHFrN2BOoOYyaCEXgRXN7V--

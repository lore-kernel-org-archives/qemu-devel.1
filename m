Received: from eggs.gnu.org ([2001:4830:134:3::10]:40234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLB7-0000RO-2P
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLB2-00065o-PK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:12:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLB2-00065R-G0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:12:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F8078046A
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:12:31 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-5-kraxel@redhat.com>
	<85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
	<20170726120819.GH7620@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <89ba674e-77f6-5859-bb17-1ffc1099a5eb@redhat.com>
Date: Wed, 26 Jul 2017 07:12:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170726120819.GH7620@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xkWmjkOoISmj93fj0InQdAWQU6I3G5N4f"
Subject: Re: [Qemu-devel] [PATCH 4/5] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xkWmjkOoISmj93fj0InQdAWQU6I3G5N4f
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <89ba674e-77f6-5859-bb17-1ffc1099a5eb@redhat.com>
Subject: Re: [PATCH 4/5] ui: add multimedia keys
References: <20170726115637.21558-1-kraxel@redhat.com>
 <20170726115637.21558-5-kraxel@redhat.com>
 <85e9156c-1a11-4757-996d-877e40e316bc@redhat.com>
 <20170726120819.GH7620@redhat.com>
In-Reply-To: <20170726120819.GH7620@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 07:08 AM, Daniel P. Berrange wrote:
> On Wed, Jul 26, 2017 at 07:02:48AM -0500, Eric Blake wrote:
>> On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
>>> Add multimedia keys to QKeyCodes and to the keymaps.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>>  ui/input-keymap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>  qapi-schema.json  | 17 ++++++++++++++++-
>>>  2 files changed, 60 insertions(+), 1 deletion(-)

>>> +# @ac_*: since 2.10
>>
>> Borderline between bug-fix and new feature (arguing that the bug is th=
at
>> we don't represent all keys).  Does this need to be 2.11 instead?
>=20
> It is really fixing a bug introduced in the PS2 driver in 2.8.0.  It
> roundtrips via QKeyCode now, so any key where there is an AT Set 1
> scancode defined, but for which we lack a QKeyCode can't be sent to
> guests since QEMU 2.8.0 onwards.

Sounds good to me, although that would be worth mentioning in the commit
message.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xkWmjkOoISmj93fj0InQdAWQU6I3G5N4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4hyoACgkQp6FrSiUn
Q2oFdgf+O6JKBAbbxfezzWeMTog89l3/uxEtXtG2wsq/Fd8RJlZZNQyTIlXCP/6T
Bo5jFXiN/qhl7tlOBbxQewLsQ74XNAzh8qgSFiP/GgRWy4YeHiatysWXd4HieK8c
zVlTP1Y7r3myP/DkKehlTt5MLrvxj+B9YfBr4H41lBZg7XKpipH0QlaSNcKjccFD
5WZtbNrKaB7CK3oGI3xKoXX1GyfMPR/zC+tuqcJBIa7qGTZQ1QA3u44YiOwg7CeF
beHKGyQAGCZaeEmdh+FgujL5/o8XhQOkuqS+D5WcV+EI0lAXbzc0J3M27k91M7Jl
vHbocLNnl73l9KpVtle9XKBH+U3ePw==
=bwN8
-----END PGP SIGNATURE-----

--xkWmjkOoISmj93fj0InQdAWQU6I3G5N4f--

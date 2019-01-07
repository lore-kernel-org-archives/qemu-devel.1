Received: from eggs.gnu.org ([209.51.188.92]:44037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggXjU-0002Fp-Uo
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:26:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggXjT-0000rn-RU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:26:32 -0500
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <03844308-4cd4-5e95-9173-3f6317a40596@redhat.com>
Date: Mon, 7 Jan 2019 10:26:23 -0600
MIME-Version: 1.0
In-Reply-To: <87o98sii5b.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="on2OmBl4JRVr2VeoRcD04NXZIVKosF4dP"
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--on2OmBl4JRVr2VeoRcD04NXZIVKosF4dP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <03844308-4cd4-5e95-9173-3f6317a40596@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
References: <20190102140535.11512-1-cfergeau@redhat.com>
 <20190102180158.GA6015@natto.ory.fergeau.eu>
 <4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
 <87o98sii5b.fsf@dusky.pond.sub.org>
In-Reply-To: <87o98sii5b.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/7/19 9:47 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 1/2/19 12:01 PM, Christophe Fergeau wrote:
>>> Adding Markus to cc: list, I forgot to do it when sending the patch.
>>
>> Also worth backporting via qemu-stable, now in cc.
>>
>>>
>>> Christophe
>>>
>>> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
>>>> commit 8bca4613 added support for %% in json strings when interpolat=
ing,
>>>> but in doing so, this broke handling of % when not interpolating as =
the
>>>> '%' is skipped in both cases.
>>>> This commit ensures we only try to handle %% when interpolating.
>=20
> Impact?
>=20
> If you're unable to assess, could you give us at least a reproducer?

Another thread pointed out that Spice passwords involving % get corrupted=
=2E

>=20
>>>> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
>>>> ---
>>>>  qobject/json-parser.c | 10 ++++++----
>>>>  tests/check-qjson.c   |  5 +++++
>>>>  2 files changed, 11 insertions(+), 4 deletions(-)
>>>>
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Patch looks good to me, but I'd like us to improve the commit message.

Indeed.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--on2OmBl4JRVr2VeoRcD04NXZIVKosF4dP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwzfa8ACgkQ3g5py3or
ov3dzQgAhBH08KrBcAxAjSyEmltmUWeXBIFZIiftjDjZ3bxXmUlTANEws+XAfoLx
zNFy0VPuYc8w5xkOBXfsfKuSuGMIcMQxpMKL3UbYt61fLDXtehjMZDO8dUsJHrZi
niWh+Hh/ty52TnDKS4g9V7KbsMD/Znfwd1D/lFyFP907CH2046x210rE+hC1Tq3x
hhZAkewjrqUGbNdXE32A06G+tuS0oLLNmQ2KlIGc3NGRbO94sA7kOW3bBoITa7zs
PxtB/Isr9JEqCK90FVBVUqK7eWgJLSZX4+GgHZgfUJtRFJOMjM7r1yPSD+d6ZAVV
VrAjac1nMI31sBNUGoZH4uhT6PlOAg==
=s/ca
-----END PGP SIGNATURE-----

--on2OmBl4JRVr2VeoRcD04NXZIVKosF4dP--

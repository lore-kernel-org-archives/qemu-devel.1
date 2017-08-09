Received: from eggs.gnu.org ([2001:4830:134:3::10]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfU0z-0005jk-Ir
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfU0y-0002a1-DN
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:39:25 -0400
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-17-eblake@redhat.com>
	<87zib8n3zv.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92fc08b3-1559-c619-c1ed-cccad8956cc9@redhat.com>
Date: Wed, 9 Aug 2017 11:39:13 -0500
MIME-Version: 1.0
In-Reply-To: <87zib8n3zv.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gOJ251iRUxLCC5B2qI6pTUqbcIkFRhhME"
Subject: Re: [Qemu-devel] [PATCH v4 16/22] libqtest: Add qmp_cmd() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, "open list:IDE" <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gOJ251iRUxLCC5B2qI6pTUqbcIkFRhhME
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>,
 "open list:IDE" <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?=
 <afaerber@suse.de>
Message-ID: <92fc08b3-1559-c619-c1ed-cccad8956cc9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 16/22] libqtest: Add qmp_cmd() helper
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-17-eblake@redhat.com>
 <87zib8n3zv.fsf@dusky.pond.sub.org>
In-Reply-To: <87zib8n3zv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:40 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Now that we've asserted that all of our interpolated QMP commands
>> include 'execute', we can reduce some of the caller boilerplate
>> by providing a helpr function to wrap commands with no arguments
>=20
> helper
>=20
> I don't get the dependency on asserting "contains 'execute'".

As mentioned elsewhere, the assertions helped me make sure I converted
all qmp() callers, but I'm fine not having it (and therefore adjusting
this commit message) in the next spin.

>> +void qmp_cmd_async(const char *cmd)
>> +{
>> +    qtest_qmp_send(global_qtest, "{'execute':%s}", cmd);
>> +}
>> +
>=20
> Hmm.  A possibly saner naming scheme:
>=20
>     FOO_send(): send a command
>     FOO_receive(): receive a reply
>     FOO: both

Yes, I like it.  That means s/FOO_async/FOO_send/.  And to some extent,
I already did that - as the name qmp_cmd() was temporary until I could
get rid of all older qmp() semantics, and then end with s/qmp_cmd/qmp/
in 22/22.  And since I'm already touching pretty much every client, it's
no worse churn to do a sane rename in the process.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gOJ251iRUxLCC5B2qI6pTUqbcIkFRhhME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLOrEACgkQp6FrSiUn
Q2oupgf9GuFmZjT24WByblxQwAwsQzlX1fKwJ1TgbjJKRJGMVknCGlK6MqIvm3ff
uh52JAsrSfqzNII580KfA788kTrxjZ4uDvfhIiA4D4jojUoVtvdsz92j+3wD4yGG
gc4VB06fluy2xZczT2vMZg3iCKFyaKnzNUFVRyJlSXhc6S7517UcaJyTMEbM8Yhn
thjQh2mEfTUx4dCaZ7KDXp4CtBEAw7wE1weoTteqPT2EZTBrxUZZiCzEvL6AJP2z
S3ud4u/9jeP9M4ago0Zp6FPAydQiZZsIQS0LfMTFYmlzzzAYq/aJXCCN5IPVrpgI
KtAcuCJ6Kf+6dhmL6aT6HMOzKd+tzw==
=G0xV
-----END PGP SIGNATURE-----

--gOJ251iRUxLCC5B2qI6pTUqbcIkFRhhME--

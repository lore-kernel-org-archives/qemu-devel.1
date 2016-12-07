Received: from eggs.gnu.org ([2001:4830:134:3::10]:44231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEePh-0003tV-Iu
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEePg-0000xN-92
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:45:45 -0500
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
	<20161206100457.GI12630@stefanha-x1.localdomain>
	<f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
	<9f10d665-2fc4-8804-a620-f9433b9e524a@redhat.com>
	<20161207100824.GB4773@noname.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2f3ecb0-7b8c-fc77-ce6e-05592b2878bb@redhat.com>
Date: Wed, 7 Dec 2016 09:45:26 -0600
MIME-Version: 1.0
In-Reply-To: <20161207100824.GB4773@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AFJdupT5O5eWbbnb8t5WUiRDTjpCOhbun"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>, stefanha@redhat.com, peter.maydell@linaro.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AFJdupT5O5eWbbnb8t5WUiRDTjpCOhbun
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <e2f3ecb0-7b8c-fc77-ce6e-05592b2878bb@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PULL for-2.8 0/3] Block patches for
 -rc3
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
 <20161206100457.GI12630@stefanha-x1.localdomain>
 <f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
 <9f10d665-2fc4-8804-a620-f9433b9e524a@redhat.com>
 <20161207100824.GB4773@noname.str.redhat.com>
In-Reply-To: <20161207100824.GB4773@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 04:08 AM, Kevin Wolf wrote:

>>  # Since: 2.7
>>  ##
>> @@ -2148,25 +2205,163 @@
>>    'data': { 'volume': 'str',
>>              'path': 'str',
>>              'server': ['GlusterServer'],
>> -            '*debug-level': 'int' } }
>> +            '*debug': 'int',
>> +            '*logfile': 'str' } }
>>
>> So I was right after all - this IS a backwards-incompatible change (an=
d
>> NOT something that was introduced only in 2.8) - but I still argue tha=
t
>> the change is appropriate NOW (but not later) because blockdev-add is
>> the only client of this type in QMP, and that command changed
>> backwards-incompatibly at the same time.
>=20
> I don't completely understand the change anyway. 'debug-level' is the
> better name,

Perhaps so, but 2.7 already used 'debug' on the command line, and
released libvirt already targets the command line. Changing the command
line to accept 'debug-level' in addition to 'debug' is the only way to
not break existing libvirt usage.  What's more, we have several
instances of 'debug' in other spots of blockdev-add; either they should
all be consistently named 'debug-level', or none of them; we made the
switch to none of them, as it was easier.

> and if the command line doesn't agree, change that one or
> grudgingly accept both. But I think we can just change the command line=
,
> it's only a debug option.

It may only be a debug option, but for good or bad, libvirt is already
targetting it by its current spelling of 'debug'.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--AFJdupT5O5eWbbnb8t5WUiRDTjpCOhbun
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSC6WAAoJEKeha0olJ0NqmVYH/jXrtu2BCD9VdvdzqaOsJyhA
paF88Iz8BxQsa/mKnT1fB1HGWpRpP/BbNYX5JES4lBg8EYdMYzKBHOiuH8If0tpH
bojWYJOeyrxXj5sJipKauZ5f4xU5y/jhV1xB/2XiNrPfHCqvE5/G9ccBltPHitB6
75oCANl6vtO4O338klRGgM0n5yUA5AjbyQXEHov65wy42JFapcQxrmMlX5o+1C0S
K4t65PM9IXP0VpYb8n2yivI1itZv8J+BgSrSt6FrTr6tFZfr43y5p24oxAZqjZAI
ftOkMeYlu2jYtxFcNK9Vg9Lbzt8aX+mpTx06HcMtaq9zsAKeWFqxh/UfdYAL/go=
=+Wui
-----END PGP SIGNATURE-----

--AFJdupT5O5eWbbnb8t5WUiRDTjpCOhbun--

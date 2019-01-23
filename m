Received: from eggs.gnu.org ([209.51.188.92]:57097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmPDe-00027w-Sz
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmPDd-0001x5-Ts
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:33:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gmPDd-0001wG-J2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:33:53 -0500
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<82a755097c6aaa16363348599110f9af3bb07583.1547681517.git.DirtY.iCE.hu@gmail.com>
	<20190117100334.vh3nbg4pjfwo4eye@sirius.home.kraxel.org>
	<23779539-c590-3910-7cf3-8e2de29ab9b9@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <620cb622-56a6-5020-f152-1291840c3ca7@redhat.com>
Date: Wed, 23 Jan 2019 14:33:48 -0600
MIME-Version: 1.0
In-Reply-To: <23779539-c590-3910-7cf3-8e2de29ab9b9@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="60k4hB8rLY9Yax7vWzT7pIof7xJE6eGCf"
Subject: Re: [Qemu-devel] [PATCH v3 47/50] paaudio: channel-map option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--60k4hB8rLY9Yax7vWzT7pIof7xJE6eGCf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <620cb622-56a6-5020-f152-1291840c3ca7@redhat.com>
Subject: Re: [PATCH v3 47/50] paaudio: channel-map option
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
 <82a755097c6aaa16363348599110f9af3bb07583.1547681517.git.DirtY.iCE.hu@gmail.com>
 <20190117100334.vh3nbg4pjfwo4eye@sirius.home.kraxel.org>
 <23779539-c590-3910-7cf3-8e2de29ab9b9@gmail.com>
In-Reply-To: <23779539-c590-3910-7cf3-8e2de29ab9b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 2:13 PM, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 wrote:

>>>  { 'struct': 'AudiodevPaPerDirectionOptions',
>>>    'data': {
>>> -    '*name': 'str' } }
>>> +    '*name':        'str',
>>> +    '*channel-map': 'str' } }
>>
>> Ah, I see.  Thats why patch #1 creates a AudiodevPaPerDirectionOptions=

>> struct with just one field ...
>=20
> Yes, I was bitten by it too during a refactor, probably I should write =
a
> few words about it in the commit message.

Yes, a good commit message tries to anticipate the questions the
reviewer will ask. The "what" is easy to see (read the patch), but the
"why" is the one that determines whether the patch is worth including.

>=20
> However, this is the exact reason I'd recommend nested structs instead
> of randomly flattening it when we can.  This way, if we later have to
> add an extra option, we don't end up in a problematic situation, since
> we can't easily change things like 'dev-in' to a structure without
> breaking backward compatibility.

We can support QAPI Alternates, accepting either a string or a struct
for a given member name like 'dev-in'. Admittedly, it's a bit harder to
write C code interfacing with a QAPI alternate type, but at least it is
possible and allows for back-compatibility.  Then again, getting the
struct right in the first place is even nicer than having to make
back-compat tweaks.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--60k4hB8rLY9Yax7vWzT7pIof7xJE6eGCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIz6wACgkQp6FrSiUn
Q2of7wf+PytlshL9npqqID8r91ovJmh6x1R9ErV3mzYW9JkhSw7ptI/AGRRveKvD
8KSFyEg0iBiHifp6x0SGPa9Kfiq1oNPFQIK4VZ+JZgggZhQgySEbjVMSgNPghZna
aSGpXhicdV5VtEVo8F2QuvwOXNcGSiMGa5GgzVpDJt0FuZRA9W+gUyHSm8qCCpgi
0rrBpEsfeI7PV+lfyaQGKAZNNzzld+yqv4Hql/eAid5qw1tlBttn/9qUv8LRKjwI
9TTIUZrRQaAUFDqn/i6dJfQkFTPALEANk9Vb3Ya0EXTGH6OEKrJJfkptCyJSk8ms
hjirTDLmqgtHcq/Ia189CEbb8eICnA==
=nrI/
-----END PGP SIGNATURE-----

--60k4hB8rLY9Yax7vWzT7pIof7xJE6eGCf--

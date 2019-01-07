Received: from eggs.gnu.org ([209.51.188.92]:34188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggVzZ-0001GK-SR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggVzZ-0004lk-2O
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:35:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ggVzY-0004iw-Nz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:35:00 -0500
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<11a6562f583531e5a5473716bea44ee3ae7be120.1545598229.git.DirtY.iCE.hu@gmail.com>
	<66e793ef-dd32-eb81-14f5-cf59ca8c73bb@amsat.org>
	<980b862a-9c2d-8ab7-2937-846524399148@gmail.com>
	<42f870e2-97bc-1028-3587-d9ae31537a13@amsat.org>
	<20a6e023-89be-f2e1-aa11-0686a1dfe021@gmail.com>
	<3ff67b65-935e-9149-05a7-543752723b06@amsat.org>
	<c82a6572-bcb7-3577-7332-5420c8cfdbb0@gmail.com>
	<20190107095454.cokxnwinrqmtsfl5@sirius.home.kraxel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92d80605-62f8-9b1a-b583-1d44b290a1ea@redhat.com>
Date: Mon, 7 Jan 2019 08:26:15 -0600
MIME-Version: 1.0
In-Reply-To: <20190107095454.cokxnwinrqmtsfl5@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jU7efdJbpPveakDvtQZsew05ydXNBf6eQ"
Subject: Re: [Qemu-devel] [PATCH v2 23/52] audio: remove audio_MIN, audio_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jU7efdJbpPveakDvtQZsew05ydXNBf6eQ
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?=
 <dirty.ice.hu@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Message-ID: <92d80605-62f8-9b1a-b583-1d44b290a1ea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 23/52] audio: remove audio_MIN, audio_MAX
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
 <11a6562f583531e5a5473716bea44ee3ae7be120.1545598229.git.DirtY.iCE.hu@gmail.com>
 <66e793ef-dd32-eb81-14f5-cf59ca8c73bb@amsat.org>
 <980b862a-9c2d-8ab7-2937-846524399148@gmail.com>
 <42f870e2-97bc-1028-3587-d9ae31537a13@amsat.org>
 <20a6e023-89be-f2e1-aa11-0686a1dfe021@gmail.com>
 <3ff67b65-935e-9149-05a7-543752723b06@amsat.org>
 <c82a6572-bcb7-3577-7332-5420c8cfdbb0@gmail.com>
 <20190107095454.cokxnwinrqmtsfl5@sirius.home.kraxel.org>
In-Reply-To: <20190107095454.cokxnwinrqmtsfl5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/7/19 3:54 AM, Gerd Hoffmann wrote:
>> The first one is fixable with an explicit cast (ugly but works), but t=
he
>> second one is more problematic. It means we can't write stuff like
>>
>> USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
>>
>> when not in a function. So we either need a dumb version of MIN/MAX, o=
r
>> scrape the idea altogether.
>=20
> const_max() for stuff which is a compile time constant maybe?

The conversation on MIN/MAX has been extracted to a new thread:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00727.html
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00695.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jU7efdJbpPveakDvtQZsew05ydXNBf6eQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwzYYcACgkQ3g5py3or
ov0B0gf9HlYpnrMDVddJnMMHmQbxPPygebTzRGYiVbZA3p9NnaKdkZxXqxP7BhSI
ysngSfme4e+zsWbdqL33AZJZDN1lKYEqTbkDgTs2lCfwt/IB1cxnkS03Cmh07coI
DgaEvNjfqhbzfICgp1BqQF0/RV+jtFOaM4cS2IXvPyUFRSB9H++xdI9BpOnUhWvj
BAVTBHfc+O1oi7x1BNzaYhoAc+v+0bcIk0w8wSwYyIC+UE6nvAwJoRpHLPibQR02
OX1QYdgEfKicqa8pYa6L6cyEb0csC5I2j2DWLg7gFdYVRMsvDHQ+YTYXJEUuldw0
JYTlzdxNqKBHtbeS1AIPy63KkYsomQ==
=zPyF
-----END PGP SIGNATURE-----

--jU7efdJbpPveakDvtQZsew05ydXNBf6eQ--

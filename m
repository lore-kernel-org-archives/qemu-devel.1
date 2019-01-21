Received: from eggs.gnu.org ([209.51.188.92]:49480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glfX6-0003wf-BJ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glfX5-0008BT-GM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:46:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glfX5-0008Am-8A
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:46:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so24779071wrw.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 11:46:55 -0800 (PST)
References: <20190121181030.2112-1-philmd@redhat.com>
	<76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
Date: Mon, 21 Jan 2019 20:46:52 +0100
MIME-Version: 1.0
In-Reply-To: <76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3kUzrw1owajuw55Npc6blQYM02lsEjMVC"
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3kUzrw1owajuw55Npc6blQYM02lsEjMVC
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>
Message-ID: <5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
References: <20190121181030.2112-1-philmd@redhat.com>
 <76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
In-Reply-To: <76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/21/19 8:22 PM, Eric Blake wrote:
> On 1/21/19 12:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Commit 2974e916df8 introduced the VirtioNetRscChain structure which
>> refer to a VirtIONet, declared later, thus required VirtIONet typedef
>> to be declarated forward.
>=20
> s/be declarated forward/use a forward declaration/

Thanks Eric.

Thomas, do you mind fixing this if you take this patch?

>> However, when compiling with Clang in -std=3Dgnu99 mode, this triggers=

>> the following warning/error:
>>
>>     CC      hw/net/virtio-net.o
>>   In file included from qemu/hw/net/virtio-net.c:22:
>>   include/hw/virtio/virtio-net.h:189:3: error: redefinition of typedef=
 'VirtIONet' is a C11 feature [-Werror,-Wtypedef-redefinition]
>>   } VirtIONet;
>>     ^
>>   include/hw/virtio/virtio-net.h:110:26: note: previous definition is =
here
>>   typedef struct VirtIONet VirtIONet;
>>                            ^
>>   1 error generated.
>>   make: *** [rules.mak:69: hw/net/virtio-net.o] Error 1
>>
>> Fix it by removing the duplicate typedef definition.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  include/hw/virtio/virtio-net.h | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20


--3kUzrw1owajuw55Npc6blQYM02lsEjMVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlxGIawACgkQoqP9bt6t
wN524w/8DqW2J8ys8SJ7aTLNe2A8frq5SKHXjti3+3pRntiVedjJehVP8T3dlc3t
S8+XgcjFHaAbuf1SL44Rw96DzUleiV/AshKNWGsolr0p/2bByHzrAXFHzEH6Nyuc
pGy+bihc9wMK8+St7SzhnZZ3avT2ddtB4Ix2ZSUJvmyLPAXo7rUy6rYv0OMV0zaE
joFx3Ed9Q3lp2zSHMiWN/Aq19Bacu5pkrCDi/hZ/COLwiLbYnoNQQ4ySwK2bqkWs
sYNQ9ihk92AB72Bas+rp8nTt57qEnOOgirusnQlJp34GwOL5XmN97tm1LvxHbgj8
bHiqm/ayZxcc28oY2nPWosC9LTKyzC02UNYKJW/D28IgpwLF4F4CYciwAhYY2n9z
sy3/0sDSgvuzjFTm7t3OG2iU2fwjd2rXfiyDfELxxcVUqKi2XTyie4yYNgnAxiBR
7RrqW2zWWIwOSuErmAGwYM0pVNKCEPmlhQoyhQGs7glLNulPBLNhXBrdBRg+4ZvC
plyEyhOyE28hkEbx0Vs8pCipUVFOBPigLjkuQ2nHGZDMl1JpEnO9gntkXanqZVUo
mlo3zgIpQu3qOZKYvzvCKYid3FeNl9BQUTbfQZfL0M9MpNpxSSK/0z1zA5HC7sQc
SovensW6sZYO5+V23t99M2xXMNv59fyR1VNANEXSeNPwKzKCQYk=
=Xaou
-----END PGP SIGNATURE-----

--3kUzrw1owajuw55Npc6blQYM02lsEjMVC--

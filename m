Received: from eggs.gnu.org ([2001:4830:134:3::10]:53042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmhNr-0008U3-B3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dmhNh-0002w2-O7
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:20:51 -0400
Date: Tue, 29 Aug 2017 15:20:36 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170829142036.GD25801@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170828113737.12199-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170828113737.12199-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix incorrect size_t format in
 benchmark-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Longpeng <longpeng2@huawei.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Mon, Aug 28, 2017 at 08:37:37AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
>   $ make check-speed
>   tests/benchmark-crypto-hash.c: In function 'test_hash_speed':
>   tests/benchmark-crypto-hash.c:44:5: error: format '%ld' expects argum=
ent of type 'long int', but argument 2 has type 'size_t' [-Werror=3Dforma=
t=3D]
>        g_print("Testing chunk_size %ld bytes ", chunk_size);
>        ^
>   tests/benchmark-crypto-hash.c: In function 'main':
>   tests/benchmark-crypto-hash.c:62:9: error: format '%lu' expects argum=
ent of type 'long unsigned int', but argument 4 has type 'size_t' [-Werro=
r=3Dformat=3D]
>            snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
>            ^
>   cc1: all warnings being treated as errors
>   rules.mak:66: recipe for target 'tests/benchmark-crypto-hash.o' faile=
d
>   make: *** [tests/benchmark-crypto-hash.o] Error 1
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> testing v2.10.0-rc4
>=20
>  tests/benchmark-crypto-cipher.c | 4 ++--
>  tests/benchmark-crypto-hash.c   | 4 ++--
>  tests/benchmark-crypto-hmac.c   | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Thanks, added to my crypto queue, unless it merges through -trivial
first.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

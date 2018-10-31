Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1gHodD-0003vK-6k
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1gHod8-0006p3-8N
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:25:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1gHod7-0006JL-Ug
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:25:46 -0400
References: <20181031104136.9953-1-marcandre.lureau@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <761c7de1-2e95-b657-e6bb-7190aa8813e4@redhat.com>
Date: Wed, 31 Oct 2018 12:25:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181031104136.9953-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user-bridge: fix "unknown type name"
 compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, victork@redhat.com, cota@braap.org

On 10/31/2018 11:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> osdep.h should be included first:
>=20
>   CC      tests/vhost-user-bridge.o
> In file included from /home/elmarco/src/qemu/tests/vhost-user-bridge.c:=
32:
> /home/elmarco/src/qemu/include/qemu/atomic.h:480:1: error: unknown type=
 name =E2=80=98int64_t=E2=80=99
>  int64_t  atomic_read_i64(const int64_t *ptr);
>  ^~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:480:32: error: unknown typ=
e name =E2=80=98int64_t=E2=80=99
>  int64_t  atomic_read_i64(const int64_t *ptr);
>                                 ^~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:481:1: error: unknown type=
 name =E2=80=98uint64_t=E2=80=99
>  uint64_t atomic_read_u64(const uint64_t *ptr);
>  ^~~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:481:32: error: unknown typ=
e name =E2=80=98uint64_t=E2=80=99
>  uint64_t atomic_read_u64(const uint64_t *ptr);
>                                 ^~~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:482:21: error: unknown typ=
e name =E2=80=98int64_t=E2=80=99
>  void atomic_set_i64(int64_t *ptr, int64_t val);
>                      ^~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:482:35: error: unknown typ=
e name =E2=80=98int64_t=E2=80=99
>  void atomic_set_i64(int64_t *ptr, int64_t val);
>                                    ^~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:483:21: error: unknown typ=
e name =E2=80=98uint64_t=E2=80=99
>  void atomic_set_u64(uint64_t *ptr, uint64_t val);
>                      ^~~~~~~~
> /home/elmarco/src/qemu/include/qemu/atomic.h:483:36: error: unknown typ=
e name =E2=80=98uint64_t=E2=80=99
>  void atomic_set_u64(uint64_t *ptr, uint64_t val);
>                                     ^~~~~~~~
>=20
> (regression from 782da5b2921c4d18777d5d5bd9385b9f7beae360)
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/vhost-user-bridge.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Funny, I was just looking into this right now :-)

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRg1m-0007Oj-Aa
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRg1j-0005l6-EZ
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:11:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRg1j-0005jy-7z
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:11:23 -0500
References: <20171103152824.21948-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9feece12-7197-1c6b-82dc-9b04eea134a5@redhat.com>
Date: Wed, 20 Dec 2017 16:11:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171103152824.21948-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mux chardev events regression fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kirill.shutemov@linux.intel.com

On 03/11/2017 16:28, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> The following patches fix and test the behaviour of mux chardev
> events, after a regression introduced in qemu 2.8.0.
>=20
> v1->v2:
> - fix incompatible pointer type warning spotted by patchew
>=20
> Marc-Andr=C3=A9 Lureau (2):
>   chardev: fix backend events regression with mux chardev
>   test: add some chardev mux event tests
>=20
>  include/chardev/char.h |  1 +
>  chardev/char-mux.c     |  8 ++++++++
>  chardev/char.c         | 18 ++++++++++++------
>  tests/test-char.c      | 17 +++++++++++++++++
>  4 files changed, 38 insertions(+), 6 deletions(-)
>=20

Queued, thanks.

Paolo

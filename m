Received: from eggs.gnu.org ([2001:4830:134:3::10]:50830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKRpR-0004EB-Cf
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKRpO-0000Ly-2g
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dKRpN-0000Le-TI
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:04:30 -0400
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e20350b-aac2-b099-ebac-03e61ad1d79e@redhat.com>
Date: Mon, 12 Jun 2017 18:04:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170608115939.30985-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] char: fix chardev aliases regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com



On 08/06/2017 13:59, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> The patch "char: move CharBackend handling in char-fe unit" broke
> chardev aliases. Here is a small series to fix it, and add a simple
> unit test to check the alias keep working.
>=20
> v2:
> - move HAVE_CHARDEV_* in osdep.h (Markus Armbruster)
> - add r-b tags from Eric for the patches that didn't change
>=20
> Marc-Andr=C3=A9 Lureau (3):
>   char: fix alias devices regression
>   chardev: don't use alias names in parse_compat()
>   test-char: start a /char/serial test
>=20
>  include/chardev/char-parallel.h |  5 -----
>  include/chardev/char-serial.h   |  8 --------
>  include/qemu/osdep.h            | 13 +++++++++++++
>  chardev/char.c                  |  4 ++--
>  tests/test-char.c               | 30 ++++++++++++++++++++++++++++++
>  5 files changed, 45 insertions(+), 15 deletions(-)
>=20

Queued, thanks.

Paolo

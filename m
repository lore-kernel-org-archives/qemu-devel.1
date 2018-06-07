Received: from eggs.gnu.org ([2001:4830:134:3::10]:45955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQnlC-0007aT-LO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQnl9-0003I5-I9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:46:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQnkn-000324-SO
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 01:46:55 -0400
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce021a92-50a8-df9d-75a2-44b178bb63bb@redhat.com>
Date: Thu, 7 Jun 2018 07:46:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180606173233.28080-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] glib: bump min required glib
 library version to 2.40
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 06.06.2018 19:32, Daniel P. Berrang=C3=A9 wrote:
> Per supported platforms doc, the various min glib on relevant distros i=
s:
>=20
>   RHEL-7: 2.50.3
>   Debian (Stretch): 2.50.3
>   Debian (Jessie): 2.42.1
>   OpenBSD (Ports): 2.54.3
>   FreeBSD (Ports): 2.50.3
>   OpenSUSE Leap 15: 2.54.3
>   Ubuntu (Xenial): 2.48.0
>   macOS (Homebrew): 2.56.0
>=20
> This suggests that a minimum glib of 2.42 is a reasonable target.
>=20
> The GLibC compile farm, however, uses Ubuntu 14.04 (Trusty) which only
> has glib 2.40.0, and this is needed for testing during merge. Thus an
> exception is made to the documented platform support policy to allow fo=
r
> all three current LTS releases to be supported.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  configure               |   6 +-
>  crypto/hash-glib.c      |   4 -
>  crypto/hmac-glib.c      |  36 -----
>  include/glib-compat.h   | 319 ----------------------------------------
>  qga/commands.c          |  11 +-
>  tests/ivshmem-test.c    |   6 -
>  tests/test-qmp-event.c  |   8 +-
>  tests/tpm-emu.h         |   4 +-
>  tests/vhost-user-test.c |  26 +---
>  trace/simple.c          |   6 +-
>  util/osdep.c            |  14 --
>  11 files changed, 11 insertions(+), 429 deletions(-)

Great diffstat!

And the changes look fine to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>

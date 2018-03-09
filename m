Received: from eggs.gnu.org ([2001:4830:134:3::10]:55733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euIgv-00030Q-Gk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:08:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1euIgr-0008Fa-MB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:08:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1euIgr-0008FI-I0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:08:09 -0500
References: <20180309135945.20436-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6df623d1-d171-a208-dde4-0a6a7d0d9426@redhat.com>
Date: Fri, 9 Mar 2018 15:08:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180309135945.20436-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] build: try improve handling of clang
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>

On 09.03.2018 14:59, Gerd Hoffmann wrote:
> This patch disables the pragma diagnostic -Wunused-but-set-variable for
> clang in util/coroutine-ucontext.c.
>=20
> This in turn allows us to remove it from the configure check, so the
> CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE will succeed for clang.
>=20
> With that in place clang builds (linux) will use -Werror by default,
> which breaks the build due to warning about unaligned struct members.
>=20
> Just turning off this warning isn't a good idea as it indicates
> portability problems.  So make it a warning again, using
> -Wno-error=3Daddress-of-packed-member.  That way it doesn't break the
> build but still shows up in the logs.
>=20
> Now clang builds qemu without errors.  Well, almost.  There are some
> left in the rdma code.  Leaving that to the rdma people.  All others ca=
n
> use --disable-rdma to workarounds this.
>=20
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure                 | 2 +-
>  util/coroutine-ucontext.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

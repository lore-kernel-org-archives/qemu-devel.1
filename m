Received: from eggs.gnu.org ([2001:4830:134:3::10]:52649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVf3-0006pS-5s
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVf1-0000EE-79
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:07:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsVf1-0000Dd-0x
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:07:07 -0400
Date: Wed, 22 Aug 2018 17:06:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822160657.GR12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822154030.14911-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822154030.14911-1-otubo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, marcandre.lureau@redhat.com

Please don't merge this PULL request - the behaviour of the 3rd patch
is still being debated.

On Wed, Aug 22, 2018 at 05:40:27PM +0200, Eduardo Otubo wrote:
> The following changes since commit 13b7b188501d419a7d63c016e00065bcc693=
b7d4:
>=20
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-r=
equest' into staging (2018-08-21 15:57:56 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20180822
>=20
> for you to fetch changes up to 2131f3e6e98195b4ce43a87c78cd9d8cb9f4da2c=
:
>=20
>   seccomp: set the seccomp filter to all threads (2018-08-22 17:35:34 +=
0200)
>=20
> ----------------------------------------------------------------
> pull-seccomp-20180822
>=20
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (3):
>       seccomp: use SIGSYS signal instead of killing the thread
>       seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>       seccomp: set the seccomp filter to all threads
>=20
>  qemu-options.hx |  2 ++
>  qemu-seccomp.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>  2 files changed, 95 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.17.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

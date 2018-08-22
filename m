Received: from eggs.gnu.org ([2001:4830:134:3::10]:51506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsVc3-00048c-QM
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsVc0-0006m0-Jz
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:04:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fsVc0-0006lk-E6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:04:00 -0400
References: <20180822154030.14911-1-otubo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <906f9e42-a3b7-a76d-433d-c11d94c1b12d@redhat.com>
Date: Wed, 22 Aug 2018 11:03:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180822154030.14911-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

On 08/22/2018 10:40 AM, Eduardo Otubo wrote:
> The following changes since commit 13b7b188501d419a7d63c016e00065bcc693=
b7d4:
>=20
>    Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-=
request' into staging (2018-08-21 15:57:56 +0100)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/otubo/qemu.git tags/pull-seccomp-20180822
>=20
> for you to fetch changes up to 2131f3e6e98195b4ce43a87c78cd9d8cb9f4da2c=
:
>=20
>    seccomp: set the seccomp filter to all threads (2018-08-22 17:35:34 =
+0200)
>=20
> ----------------------------------------------------------------
> pull-seccomp-20180822
>=20
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (3):
>        seccomp: use SIGSYS signal instead of killing the thread
>        seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>        seccomp: set the seccomp filter to all threads

Let's hold off on this pull request until the technical debate on 3/3=20
has settled (namely, there's no point in letting the process continue if=20
tsync fails on older OS, because it is NOT providing the security that=20
it claims).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVuF-0005VE-L0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVuB-00010c-Ts
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:20:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYVuB-000107-P1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:20:07 -0400
References: <20180628110254.6725-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2487eb62-8a0b-bfce-4b49-4f0ebfb16763@redhat.com>
Date: Thu, 28 Jun 2018 07:19:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180628110254.6725-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 06/28/2018 06:02 AM, Daniel P. Berrang=C3=A9 wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31=
b1f1:
>=20
>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-=
20180626' into staging (2018-06-26 18:23:49 +0100)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/berrange/qemu tags/qio-next-pull-request
>=20
> for you to fetch changes up to 39321d9ed89eccdde73bb7b20cb834506c3bd750=
:
>=20
>    Delete AF_UNIX socket after close (2018-06-28 11:59:51 +0100)
>=20
> ----------------------------------------------------------------
> Merge qio 2018-06-28
>=20
> Misc bug fixes for sockets channels
>=20
> ----------------------------------------------------------------
>=20
> Pavel Balaev (1):
>    Delete AF_UNIX socket after close

Replying here to catch Peter's attention - based on comments on 2/2, Dan=20
will be submitting a v2 pull request.

>=20
> linzhecheng (1):
>    socket: dont't free msgfds if error equals EAGAIN

Dan - while you're at it, s/dont't/don't/

>=20
>   chardev/char-socket.c |  4 ++--
>   io/channel-socket.c   | 18 +++++++++++++++++-
>   2 files changed, 19 insertions(+), 3 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziVD-0002fb-MP
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fziVA-0003BC-JX
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:14:47 -0400
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13256e6e-cdac-59e2-ecf2-9f295a7d390d@redhat.com>
Date: Tue, 11 Sep 2018 15:14:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180831145314.14736-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 31/08/2018 16:53, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> Here are a few PID file related patches extracted from "[PATCH v4
> 00/29] vhost-user for input & GPU" series, with suggestions from
> Daniel Berrang=C3=A9.
>=20
> thanks
>=20
> Marc-Andr=C3=A9 Lureau (3):
>   util: add qemu_write_pidfile()
>   util: use fcntl() for qemu_write_pidfile() locking
>   RFC: delete PID file on exit
>=20
>  include/qemu/osdep.h  |  3 +-
>  os-posix.c            | 24 --------------
>  os-win32.c            | 25 ---------------
>  qga/main.c            | 54 ++++++--------------------------
>  scsi/qemu-pr-helper.c | 40 +++---------------------
>  util/oslib-posix.c    | 73 +++++++++++++++++++++++++++++++++++++++++++
>  util/oslib-win32.c    | 27 ++++++++++++++++
>  vl.c                  | 15 +++++++--
>  8 files changed, 129 insertions(+), 132 deletions(-)
>=20

Queued 1-2, thanks.

Paolo

Received: from eggs.gnu.org ([209.51.188.92]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grnFz-0001AC-GZ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1grnFy-0006ht-U8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:14:35 -0500
Date: Thu, 7 Feb 2019 18:14:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190207181415.07d0d7ae.cohuck@redhat.com>
In-Reply-To: <20190206174328.9736-4-marcandre.lureau@redhat.com>
References: <20190206174328.9736-1-marcandre.lureau@redhat.com>
	<20190206174328.9736-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/6] terminal3270: do not use backend
 timer sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open
	list:S390" <qemu-s390x@nongnu.org>

On Wed,  6 Feb 2019 18:43:25 +0100
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> terminal3270 uses the front-end side of the chardev. It shouldn't
> create sources from backend side context (with backend
> functions).
>=20
> send_timing_mark_cb calls qemu_chr_fe_write_all() which should be
> thread safe.
>=20
> This partially reverts changes from commit
> 2c716ba1506769c9be2caa02f0f6d6e7c00f4304.
>=20
> CC: Peter Xu <peterx@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/char/terminal3270.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

I've verified that 3270 continues to work as before.

Acked-by: Cornelia Huck <cohuck@redhat.com>

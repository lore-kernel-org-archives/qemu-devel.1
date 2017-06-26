Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dPbaL-00035k-RF
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dPbaL-0005h2-5G
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:30:17 -0400
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<5a22e3c4-040f-52e0-caad-51ba186be2e5@openvz.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <332a6eae-e0c7-9686-535a-ac7500af2014@redhat.com>
Date: Mon, 26 Jun 2017 23:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <5a22e3c4-040f-52e0-caad-51ba186be2e5@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org

On 06/26/17 22:30, Denis V. Lunev wrote:

>  3.
>=20
>     _zstd is multi-threaded, and it=E2=80=99s dangerous_
>=20
> libzstd is single-threaded.
> There is a multi-thread extension, which is enabled in the CLI, but not
> in the library.
> There is also an experimental target which makes it possible to produce
> a MT-enabled library.
> Even in this case, the API remains single-threaded by default.
> It=E2=80=99s necessary to use dedicated entry points to enable multi-th=
reading.
> TL;DR : zstd supports multithreading, but is single threaded by default=
.

That's a relief (to me anyway).

Thanks
Laszlo

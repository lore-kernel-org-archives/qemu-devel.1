Received: from eggs.gnu.org ([2001:4830:134:3::10]:44306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gRgLA-00019e-P8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gRgL7-0003p1-ND
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:36:00 -0500
Date: Tue, 27 Nov 2018 09:35:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181127093552.4f53790d@x1.home>
In-Reply-To: <20181125205000.10324-14-philmd@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-14-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 13/25] MAINTAINERS: Add missing
 entries to VFIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Sun, 25 Nov 2018 21:49:48 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bfe71f2555..e124792557 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1326,6 +1326,8 @@ M: Alex Williamson <alex.williamson@redhat.com>
>  S: Supported
>  F: hw/vfio/*
>  F: include/hw/vfio/
> +F: include/qemu/vfio-helpers.h

This misses util/vfio-helpers.c, both of which are contributed by Fam
and currently only used by nvme.  I really haven't done anything with
them, so they should probably be under the NVMe block driver, but if it
makes more sense for me to look after them, I can start paying more
attention to them.  I'm not sure signing someone up for new files
they've never touched counts as trivial ;)  Thanks,

Alex

> +F: docs/igd-assign.txt
> =20
>  vfio-ccw
>  M: Cornelia Huck <cohuck@redhat.com>

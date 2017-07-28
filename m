Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1db8Qc-0004ZB-1C
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1db8Qb-0002eY-9Y
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:47:54 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170728053610.15770-46-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-46-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 28 Jul 2017 09:47:16 -0700
Message-ID: <CAKmqyKNdP8aHTWo1XdAqjQt4tXXNOn4ORaXgcZKa=+zxSY-CVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 45/47] MAINTAINERS: add missing entries
 for loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Jul 27, 2017 at 10:36 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>
> RFC because I'm not sure 'loader' is the same goal than 'generic-loader'

loader.c is not the same, it is the core loading framework for QEMU
while generic-loader is just something that uses it. This greatly
increases the amount on maintainership here.

In saying that if no one else wants it I can maintain it.

Thanks,
Alistair

>
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dc1a69051c..224890643d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1196,6 +1196,8 @@ M: Alistair Francis <alistair.francis@xilinx.com>
>  S: Maintained
>  F: hw/core/generic-loader.c
>  F: include/hw/core/generic-loader.h
> +F: docs/generic-loader.txt
> +F: hw/core/loader.c
>
>  CHRP NVRAM
>  M: Thomas Huth <thuth@redhat.com>
> --
> 2.13.3
>
>

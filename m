Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcd7-0006yl-Qx
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcd7-00016h-2P
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:37:13 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170623164557.11636-3-f4bug@amsat.org>
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623164557.11636-3-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 26 Jun 2017 15:36:41 -0700
Message-ID: <CAKmqyKN7QXYQrP1_LgDoRe6SFkrx=Ogvt2N9CgW8QOaZ5RkMrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/core: fix missing return value in
 load_image_targphys_as()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Jun 23, 2017 at 9:45 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  hw/core/loader.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 094f24627f..e137e772ae 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -150,7 +150,9 @@ int load_image_targphys_as(const char *filename,
>          return -1;
>      }
>      if (size > 0) {
> -        rom_add_file_fixed_as(filename, addr, -1, as);
> +        if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> +            return -1;
> +        }
>      }
>      return size;
>  }
> --
> 2.13.1
>
>

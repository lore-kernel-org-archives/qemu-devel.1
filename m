Received: from eggs.gnu.org ([2001:4830:134:3::10]:34508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcZz-0006Hq-Es
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcZy-0008M9-ND
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:33:59 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dPcZy-0008LF-Gt
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:33:58 -0400
Received: by mail-wm0-x243.google.com with SMTP id y5so2732575wmh.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 15:33:55 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170623164557.11636-1-f4bug@amsat.org>
References: <20170623164557.11636-1-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 26 Jun 2017 15:33:24 -0700
Message-ID: <CAKmqyKMVQkqoXKbPbo17tN2NGtmfRcEDMho5MW2Eq+z0OmYKQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/core: minor fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Fri, Jun 23, 2017 at 9:45 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Sorry to spam so many people, there is no entries in MAINTAINERS for
> hw/core/loader.c and hw/core/qdev.c, any volunters?

If no one else wants to I could maintain hw/core/loader.c. It's pretty
similar to the generic-loader which I already maintain.

Thanks,
Alistair

>
> Philippe Mathieu-Daud=C3=A9 (3):
>   elf-loader: warn about invalid endianess
>   hw/core: fix missing return value in load_image_targphys_as()
>   hw/core: report an error if invalid gpio is used
>
>  hw/core/loader.c | 5 ++++-
>  hw/core/qdev.c   | 6 +++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> --
> 2.13.1
>
>

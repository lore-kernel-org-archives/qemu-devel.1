Received: from eggs.gnu.org ([2001:4830:134:3::10]:42628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e1i1K-0003Z8-4N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e1i1J-0003xX-8t
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:03:38 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171006235023.11952-45-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-45-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 9 Oct 2017 17:03:01 -0700
Message-ID: <CAKmqyKOYNUQnUeLhrTWOQprsDaQxo=0RGpNnCwS5bswTZBSZ4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 44/88] hw/core/loader: use g_new() family
 of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Oct 6, 2017 at 4:49 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  hw/core/loader.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4593061445..def4766dbb 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -899,7 +899,7 @@ int rom_add_file(const char *file, const char *fw_dir=
,
>          return -1;
>      }
>
> -    rom =3D g_malloc0(sizeof(*rom));
> +    rom =3D g_new0(Rom, 1);
>      rom->name =3D g_strdup(file);
>      rom->path =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, rom->name);
>      rom->as =3D as;
> @@ -996,7 +996,7 @@ MemoryRegion *rom_add_blob(const char *name, const vo=
id *blob, size_t len,
>      Rom *rom;
>      MemoryRegion *mr =3D NULL;
>
> -    rom           =3D g_malloc0(sizeof(*rom));
> +    rom           =3D g_new0(Rom, 1);
>      rom->name     =3D g_strdup(name);
>      rom->as       =3D as;
>      rom->addr     =3D addr;
> @@ -1039,7 +1039,7 @@ int rom_add_elf_program(const char *name, void *dat=
a, size_t datasize,
>  {
>      Rom *rom;
>
> -    rom           =3D g_malloc0(sizeof(*rom));
> +    rom =3D g_new0(Rom, 1);
>      rom->name     =3D g_strdup(name);
>      rom->addr     =3D addr;
>      rom->datasize =3D datasize;
> --
> 2.14.2
>
>

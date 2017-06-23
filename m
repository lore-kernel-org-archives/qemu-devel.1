Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOS7D-0006iZ-Rv
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 13:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOS7D-0006nS-3U
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 13:11:27 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOS7C-0006lj-SB
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 13:11:27 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c11so74013447wrc.3
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 10:11:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170623164557.11636-2-f4bug@amsat.org>
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623164557.11636-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2017 18:11:03 +0100
Message-ID: <CAFEAcA_MwaYkN8tS0U9nkkic9VrEtppCm_bCS=2pWyKfgUSr-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] elf-loader: warn about invalid
 endianess
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On 23 June 2017 at 17:45, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> fprintf(stderr) is how errors are reported in this file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/loader.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index f72930ca4a..094f24627f 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -478,6 +478,7 @@ int load_elf_ram(const char *filename,
>      }
>
>      if (target_data_order !=3D e_ident[EI_DATA]) {
> +        fprintf(stderr, "%s: wrong endianess\n", filename);

"endianness" (two 'n's).

>          ret =3D ELF_LOAD_WRONG_ENDIAN;
>          goto fail;
>      }
> --
> 2.13.1

thanks
-- PMM

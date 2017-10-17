Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4Lf2-0007am-69
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4Lex-0004Ou-A6
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 02:47:32 -0400
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-40-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <349eda7b-b812-7df7-0a1c-34f1b262625f@redhat.com>
Date: Tue, 17 Oct 2017 08:47:13 +0200
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-40-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 39/39] hw/dma/i8257: rename DMA_init()
 to i8257_dma_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 02:12, Philippe Mathieu-Daud=C3=A9 wrote:
> - move the header from hw/isa/ to hw/dma/
> - remove the old i386/pc dependency
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/{isa/i8257.h =3D> dma/i8257_dma.h} | 6 ++++++
>  include/hw/isa/isa.h                        | 2 --
>  hw/dma/i82374.c                             | 3 ++-
>  hw/dma/i8257.c                              | 4 ++--
>  hw/i386/pc.c                                | 3 ++-
>  hw/mips/mips_fulong2e.c                     | 3 ++-
>  hw/mips/mips_jazz.c                         | 3 ++-
>  hw/mips/mips_malta.c                        | 3 ++-
>  hw/sparc/sun4m.c                            | 4 ----
>  hw/sparc64/sun4u.c                          | 4 ----
>  10 files changed, 18 insertions(+), 17 deletions(-)
>  rename include/hw/{isa/i8257.h =3D> dma/i8257_dma.h} (86%)
>=20
> diff --git a/include/hw/isa/i8257.h b/include/hw/dma/i8257_dma.h
> similarity index 86%
> rename from include/hw/isa/i8257.h
> rename to include/hw/dma/i8257_dma.h

I think you could drop the "_dma" suffix from the name - it is already
in a folder called "dma", so the context of this file should be clear
already.

 Thomas

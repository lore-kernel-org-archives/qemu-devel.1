Received: from eggs.gnu.org ([2001:4830:134:3::10]:37899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gH82W-0003wP-3E
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gH82S-0003at-Ky
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:57:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gH82S-0003Z9-GS
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:57:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id p3-v6so4942978qkb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 06:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181029135049.12552-1-pbonzini@redhat.com>
In-Reply-To: <20181029135049.12552-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 29 Oct 2018 17:56:51 +0400
Message-ID: <CAMxuvaxY1Nap6bW+=G8FH_4CFiLB1DNguGzyWaf-vBXN63dREA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/dump-guest-memory: Synchronize
 with guest_phys_blocks_region_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bonzini, Paolo" <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On Mon, Oct 29, 2018 at 5:50 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Recent patches have removed ram_device and nonvolatile RAM
> from dump-guest-memory's output.  Do the same for dumps
> that are extracted from a QEMU core file.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/dump-guest-memory.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 5a857cebcf..f04697b1dd 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -417,7 +417,9 @@ def get_guest_phys_blocks():
>          memory_region =3D flat_range["mr"].dereference()
>
>          # we only care about RAM
> -        if not memory_region["ram"]:
> +        if not memory_region["ram"] \
> +           or memory_region["ram_device"] \
> +           or memory_region["nonvolatile"]:
>              continue
>
>          section_size =3D int128_get64(flat_range["addr"]["size"])
> --
> 2.17.1
>

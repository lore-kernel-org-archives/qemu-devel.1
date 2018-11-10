Received: from eggs.gnu.org ([2001:4830:134:3::10]:60184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLalX-0005tP-HY
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLalT-0005nw-IO
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:26:03 -0500
MIME-Version: 1.0
References: <20181021190721.2148-1-hpoussin@reactos.org>
In-Reply-To: <20181021190721.2148-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Sat, 10 Nov 2018 22:25:46 +0100
Message-ID: <CAAdtpL7nBbM515WApJcXpfQ--6MT2OT8TcATzssDiBvr1=Vm1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ps2kbd: default to scan enabled after reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Geoffrey McRae <geoff@hostfission.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>

Hi Herv=C3=A9,

On Sun, Oct 21, 2018 at 9:12 PM Herv=C3=A9 Poussineau <hpoussin@reactos.org=
> wrote:
> A check for scan_enabled has been added to ps2_keyboard_event in commit
> 143c04c7e0639e53086519592ead15d2556bfbf2 to prevent stream corruption.
> This works well as long as operating system is resetting keyboard, or ena=
bling it.
>
> This fixes IBM 40p firmware, which doesn't bother sending KBD_CMD_RESET,
> KBD_CMD_ENABLE or KBD_CMD_RESET_ENABLE before trying to use the keyboard.
>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/input/ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index fdfcadf9a1..eded4f0f8d 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -938,7 +938,7 @@ static void ps2_kbd_reset(void *opaque)
>
>      trace_ps2_kbd_reset(opaque);
>      ps2_common_reset(&s->common);
> -    s->scan_enabled =3D 0;
> +    s->scan_enabled =3D 1;
>      s->translate =3D 0;
>      s->scancode_set =3D 2;
>      s->modifiers =3D 0;
> --
> 2.11.0
>

I think QOM'ifying this device would force a cleanup of those various
reset functions.
Then ps2_kbd_reset could call ps2_reset_keyboard.

In the meantime this patch makes sense as a bugfix.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Regards,

Phil.

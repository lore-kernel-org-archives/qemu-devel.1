Received: from eggs.gnu.org ([209.51.188.92]:50066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxih-0001x8-EJ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxig-00060c-5j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:23:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghxic-0005rm-Gf
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:23:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so2552916wmc.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:23:30 -0800 (PST)
References: <20190111140457.2935-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <459c5b99-253a-9eac-deec-2d093b7fc28d@redhat.com>
Date: Fri, 11 Jan 2019 15:23:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190111140457.2935-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/33] typedefs: Remove scarcely used
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Artyom Tarasenko <atar4qemu@gmail.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org

On 1/11/19 3:04 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Since this file became a hot topic [*], I took previous cleanups
> from last year and continue to clean it.
> 
> Regards,
> 
> Phil.
> 
> [*] "HACKING: Clarify the paragraph about typedefs"
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02132.html
> [*] "Fix duplicated typedefs to be able to compile with Clang in gnu99 mode"
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02117.html
> 
> Eric Blake (1):
>   typedefs: (Re-)sort entries alphabetically
> 
> Frediano Ziglio (1):
>   spice: Remove unused include
> 
> Gerd Hoffmann (6):
>   egl-headless: add egl_create_context
>   keymaps: remove modifiers include
>   keymaps: drop nl-be map
>   keymaps: remove common include
>   keymaps: drop support for include files
>   usb-audio: ignore usb packages with wrong size
> 
> Li Qiang (1):
>   ioapic: use TYPE_FOO MACRO than constant string
> 
> Marc-André Lureau (1):
>   configure: bump spice-server required version to 0.12.5
> 
> Peter Maydell (2):
>   ui/console: Remove qemu_create_display_surface_guestmem()
>   linux-user: make pwrite64/pread64(fd, NULL, 0, offset) return 0
> 
> Philippe Mathieu-Daudé (15):
>   hw/input/ps2: Remove PS2State from "qemu/typedefs.h"
>   hw/pcmcia: Remove PCMCIACardState from "qemu/typedefs.h"
>   hw/ssi: Remove SSIBus from "qemu/typedefs.h"
>   hw/ide/ahci: Remove AllwinnerAHCIState from "qemu/typedefs.h"
>   hw/nvram/fw_cfg: Remove various typedefs from "qemu/typedefs.h"
>   hw/i2c/smbus: Remove SMBusDevice from "qemu/typedefs.h"
>   hw/bt: Remove HCIInfo from "qemu/typedefs.h"
>   hw/char/serial: Remove SerialState from "qemu/typedefs.h"
>   hw/i386: Remove PCMachineClass from "qemu/typedefs.h"
>   range: Remove Range from "qemu/typedefs.h"
>   audio: Remove AudioState from "qemu/typedefs.h"
>   ui/console: Remove MouseTransformInfo from qemu/typedefs.h
>   ui/console: Remove QemuDmaBuf from "qemu/typedefs.h"
>   ui/console: Remove DisplayState/DisplaySurface from "qemu/typedefs.h"
>   RFC ui/console: Add "ui/pixelformat.h" to declare PixelFormat
> 
> Priit Laes (1):
>   qom: Include qemu/fprintf-fn.h in cpu.h
> 
> Thomas Huth (3):
>   hw/audio/marvell: Don't include unnecessary i2c.h header file
>   trivial: Don't include isa.h if it is not really necessary
>   hw/audio/marvell: Don't include unnecessary i2c.h header file
> 
> Tom Deseyn (1):
>   Add getsockopt for settable SOL_IPV6 options
> 
> Wainer dos Santos Moschetta (1):
>   hw/core: fix whitespace in a sentence

Please ignore this cover, I learned git publish use 'master' branch as
base, while I'm custom to track 'origin/master'.

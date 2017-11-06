Received: from eggs.gnu.org ([2001:4830:134:3::10]:36160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBfjE-0001Lw-3k
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBfjD-0000xW-BW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:38:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBfjD-0000xA-51
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:38:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id y83so13451474wmc.4
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 03:38:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106005328.GB84093@humpty.home.comstyle.com>
References: <20171106005328.GB84093@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 11:37:45 +0000
Message-ID: <CAFEAcA_3ZeQnsin-_ycGaRyxmqTxSFyyeGVrQYmQt2myxPemBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Deal with OpenBSD/i386
 emulation linker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 November 2017 at 00:53, Brad Smith <brad@comstyle.com> wrote:
> OpenBSD/i386 uses elf_i386_obsd for the emulation linker.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
>
>
> diff --git a/configure b/configure
> index dd73cce62f..02799d38ac 100755
> --- a/configure
> +++ b/configure
> @@ -5159,9 +5159,9 @@ if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
>          "$targetos" != "Darwin" -a "$targetos" != "SunOS" -a \
>          "$softmmu" = yes ; then
>      # Different host OS linkers have different ideas about the name of the ELF
> -    # emulation. Linux and OpenBSD use 'elf_i386'; FreeBSD uses the _fbsd
> -    # variant; and Windows uses i386pe.
> -    for emu in elf_i386 elf_i386_fbsd i386pe; do
> +    # emulation. Linux uses 'elf_i386'; FreeBSD uses the _fbsd variant;
> +    # OpenBSD uses the _obsd variant; and Windows uses i386pe.
> +    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
>          if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$"; then
>              ld_i386_emulation="$emu"
>              roms="optionrom"

My OpenBSD/x86-64's ld supports both "elf_i386" and "elf_i386_obsd" --
which should we be using in this case? With your change we'll
still prefer elf_i386 if the linker handles both.

Do you know what the difference between the two is?

thanks
-- PMM

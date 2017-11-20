Received: from eggs.gnu.org ([2001:4830:134:3::10]:51783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGmPy-0003VE-4U
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGmPx-0007CS-3g
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:47:22 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGmPw-0007BH-RZ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:47:21 -0500
Received: by mail-wm0-x244.google.com with SMTP id 128so10313181wmo.3
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 05:47:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171107234608.GA395@humpty.home.comstyle.com>
References: <20171107234608.GA395@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 13:46:59 +0000
Message-ID: <CAFEAcA-15KQdCaemdtAva9EA0YPPC3j1sYuHt1OBrTo_BHEO-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] configure: Deal with OpenBSD/i386
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

On 7 November 2017 at 23:46, Brad Smith <brad@comstyle.com> wrote:
> OpenBSD/i386 uses elf_i386_obsd for the emulation linker.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
>
>
> diff --git a/configure b/configure
> index dd73cce62f..c9dd747283 100755
> --- a/configure
> +++ b/configure
> @@ -5159,9 +5159,9 @@ if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
>          "$targetos" != "Darwin" -a "$targetos" != "SunOS" -a \
>          "$softmmu" = yes ; then
>      # Different host OS linkers have different ideas about the name of the ELF
> -    # emulation. Linux and OpenBSD use 'elf_i386'; FreeBSD uses the _fbsd
> -    # variant; and Windows uses i386pe.
> -    for emu in elf_i386 elf_i386_fbsd i386pe; do
> +    # emulation. Linux and OpenBSD/amd64 use 'elf_i386'; FreeBSD uses the _fbsd
> +    # variant; OpenBSD/i386 uses the _obsd variant; and Windows uses i386pe.
> +    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
>          if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$"; then
>              ld_i386_emulation="$emu"
>              roms="optionrom"

Hi; just a reminder that this patch is still blocked on getting
an answer to why the correct answer for OpenBSD/x86_64 is
"elf_i386" and not "elf_i386_obsd"...

thanks
-- PMM

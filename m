Received: from eggs.gnu.org ([2001:4830:134:3::10]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eCkcW-0002G1-4m
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eCkcS-0003Bd-3e
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:03:40 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eCkcR-0003BN-TR
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:03:36 -0500
Received: by mail-wm0-x243.google.com with SMTP id s66so16098474wmf.5
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 03:03:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171107235131.GB395@humpty.home.comstyle.com>
References: <20171106005328.GB84093@humpty.home.comstyle.com>
	<CAFEAcA_3ZeQnsin-_ycGaRyxmqTxSFyyeGVrQYmQt2myxPemBQ@mail.gmail.com>
	<20171107235131.GB395@humpty.home.comstyle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2017 11:03:13 +0000
Message-ID: <CAFEAcA8gqfX7wHkprpGmj3GKRCUJA-0Z00Mf9Y0aj05zU5KDkg@mail.gmail.com>
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

On 7 November 2017 at 23:51, Brad Smith <brad@comstyle.com> wrote:
> On Mon, Nov 06, 2017 at 11:37:45AM +0000, Peter Maydell wrote:
>> On 6 November 2017 at 00:53, Brad Smith <brad@comstyle.com> wrote:
>> > OpenBSD/i386 uses elf_i386_obsd for the emulation linker.
>> >
>> > Signed-off-by: Brad Smith <brad@comstyle.com>
>> >
>> >
>> > diff --git a/configure b/configure
>> > index dd73cce62f..02799d38ac 100755
>> > --- a/configure
>> > +++ b/configure
>> > @@ -5159,9 +5159,9 @@ if test \( "$cpu" = "i386" -o "$cpu" = "x86_64" \) -a \
>> >          "$targetos" != "Darwin" -a "$targetos" != "SunOS" -a \
>> >          "$softmmu" = yes ; then
>> >      # Different host OS linkers have different ideas about the name of the ELF
>> > -    # emulation. Linux and OpenBSD use 'elf_i386'; FreeBSD uses the _fbsd
>> > -    # variant; and Windows uses i386pe.
>> > -    for emu in elf_i386 elf_i386_fbsd i386pe; do
>> > +    # emulation. Linux uses 'elf_i386'; FreeBSD uses the _fbsd variant;
>> > +    # OpenBSD uses the _obsd variant; and Windows uses i386pe.
>> > +    for emu in elf_i386 elf_i386_fbsd elf_i386_obsd i386pe; do
>> >          if "$ld" -verbose 2>&1 | grep -q "^[[:space:]]*$emu[[:space:]]*$"; then
>> >              ld_i386_emulation="$emu"
>> >              roms="optionrom"
>>
>> My OpenBSD/x86-64's ld supports both "elf_i386" and "elf_i386_obsd" --
>> which should we be using in this case? With your change we'll
>> still prefer elf_i386 if the linker handles both.
>
> I sent a second rev of the diff with slightly tweaked comment.
>
> OpenBSD/amd64 uses elf_i386. OpenBSD/i386 uses elf_i386_obsd.
>
>> Do you know what the difference between the two is?
>
> No.

...then how do we know that elf_i386 is the right one to use
for 32-bit linking when checking on an OpenBSD/amd64 system?

thanks
-- PMM

Received: from eggs.gnu.org ([208.118.235.92]:51359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf36h-0005Pe-Be
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf36c-0008QS-By
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:32:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf36c-0008Nx-67
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:32:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so29304113wmh.4
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 05:32:13 -0800 (PST)
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a08068ab-88ae-4068-d4d6-3a3c4a968893@redhat.com>
Date: Thu, 3 Jan 2019 14:32:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Xb1DeTTus7vwfQXDGC8ETR5a9Egg4nVN=+cLy0xm2dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/44] MIPS pull request for December
 2018 - v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 1/3/19 2:23 PM, Peter Maydell wrote:
> On Mon, 31 Dec 2018 at 14:56, Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
>> MIPS queue for December 2018 - v2
[...]
> Hi; I'm afraid this doesn't build on all my test hosts:
> 
> target/mips/translate.c: In function ‘gen_mxu_Q8MAX_Q8MIN’:
> target/mips/translate.c:25092:9: error: ‘for’ loop initial
> declarations are only allowed in C99 mode
>          for (int i = 2; i >= 0; i--) {
>          ^
> target/mips/translate.c:25092:9: note: use option -std=c99 or
> -std=gnu99 to compile your code
> target/mips/translate.c:25129:9: error: ‘for’ loop initial
> declarations are only allowed in C99 mode
>          for (int i = 2; i >= 0; i--) {
>          ^
> 
> (This probably only shows up on builds with older versions
> of gcc which don't default to c99.)
> 
> We don't use variable-declaration-in-for-loop.

Hmmm I wonder if we shouldn't relax that now than all supported
compilers do support C99.
Rational is having cleaner function declarations lead to easier reviews.

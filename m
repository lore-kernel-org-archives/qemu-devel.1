Received: from eggs.gnu.org ([2001:4830:134:3::10]:50170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cn232-0007rl-DQ
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cn231-00052Y-1x
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:52:28 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cn230-00052A-Qa
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 07:52:26 -0400
Received: by mail-wr0-x22e.google.com with SMTP id u48so88427785wrc.0
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 04:52:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <22858FDC-B303-45A6-803D-C3F9DDCC931D@gmail.com>
References: <22858FDC-B303-45A6-803D-C3F9DDCC931D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Mar 2017 12:52:04 +0100
Message-ID: <CAFEAcA9K-EmxMt+7mNsJ0xD_qkdWXnfEAPxRDdr3Zi+crzjAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Risu and the PowerPC 970
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 12 March 2017 at 06:10, G 3 <programmingkidx@gmail.com> wrote:
> Does Risu support the PowerPC 970? I tried compiling it but I saw this
> error:
>
> gcc  -Wall -D_GNU_SOURCE -DARCH=ppc64 -g  -o risu.o -c risu.c
> In file included from risu.c:29:
> risu.h:27:30: error: risu_reginfo_ppc64.h: No such file or directory
> make: *** [Makefile:44: risu.o] Error 1
>
> The PowerPC 970 is a 64-bit PowerPC CPU.

It doesn't support ppc64 bigendian yet, only little endian.
(There's some patches on list for the BE support which I
haven't yet got to.)

thanks
-- PMM

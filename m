Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHg1T-00008I-A4
	for qemu-devel@nongnu.org; Sat, 12 May 2018 21:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHg1Q-0003JV-7h
	for qemu-devel@nongnu.org; Sat, 12 May 2018 21:42:03 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHg1Q-0003JM-2g
	for qemu-devel@nongnu.org; Sat, 12 May 2018 21:42:00 -0400
Received: by mail-qt0-x243.google.com with SMTP id m16-v6so11936044qtg.13
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 18:41:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180510222601.19944-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5bb5d7df-2f38-4e24-c227-8a84cc42ece2@amsat.org>
Date: Sat, 12 May 2018 22:41:54 -0300
MIME-Version: 1.0
In-Reply-To: <20180510222601.19944-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] linux-user: move socket.h definitions
 to CPU directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

On 05/10/2018 07:25 PM, Laurent Vivier wrote:
> Splitting out socket.h definitions helps to read the code
> and to fix the bugs...
> 
> No code change, except for the last one that ports
> definitions from linux for sparc as the values are not the
> correct ones.
> 
> Laurent Vivier (5):
>   linux-user: move mips socket.h definitions to mips/sockbits.h
>   linux-user: move alpha socket.h definitions to alpha/sockbits.h
>   linux-user: move sparc/sparc64 socket.h definitions to
>     sparc/sockbits.h
>   linux-user: move ppc socket.h definitions to ppc/sockbits.h

^ patches 1-4:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>   linux-user: copy sparc/sockbits.h definitions from linux
> 
>  linux-user/alpha/sockbits.h   | 113 ++++++++++++++++++
>  linux-user/mips/sockbits.h    | 110 ++++++++++++++++++
>  linux-user/mips64/sockbits.h  |   1 +
>  linux-user/ppc/sockbits.h     |  58 ++++++++++
>  linux-user/socket.h           | 261 +-----------------------------------------
>  linux-user/sparc/sockbits.h   | 111 ++++++++++++++++++
>  linux-user/sparc64/sockbits.h |   1 +
>  7 files changed, 397 insertions(+), 258 deletions(-)
>  create mode 100644 linux-user/alpha/sockbits.h
>  create mode 100644 linux-user/mips/sockbits.h
>  create mode 100644 linux-user/mips64/sockbits.h
>  create mode 100644 linux-user/ppc/sockbits.h
>  create mode 100644 linux-user/sparc/sockbits.h
>  create mode 100644 linux-user/sparc64/sockbits.h
> 

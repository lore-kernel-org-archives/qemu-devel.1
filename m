Received: from eggs.gnu.org ([2001:4830:134:3::10]:54131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcIrl-0002FT-HI
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 19:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fcIrk-0003Uc-K9
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 19:13:17 -0400
References: <20180706155127.7483-1-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <091df2fb-b3a0-ef4f-f401-ec5a4e58fab8@vivier.eu>
Date: Mon, 9 Jul 2018 01:12:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180706155127.7483-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/3] Sanitize linux-user stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org

Le 06/07/2018 à 17:51, Philippe Mathieu-Daudé a écrit :
> Hi Laurent,
> 
> Here 3 trivial patches, the first one resolves this launchpad issue:
> https://bugs.launchpad.net/qemu/+bug/1777226, then the following two
> sanitize a bit further.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (3):
>   linux-user: Do not report "Unsupported syscall" by default
>   linux-user: Do not report "syscall not implemented" by default
>   linux-user: Report error message on stderr, rather than stdout
> 
>  linux-user/alpha/cpu_loop.c      | 2 +-
>  linux-user/cris/cpu_loop.c       | 2 +-
>  linux-user/cris/signal.c         | 4 ++--
>  linux-user/microblaze/cpu_loop.c | 6 +++---
>  linux-user/microblaze/signal.c   | 4 ++--
>  linux-user/nios2/signal.c        | 2 +-
>  linux-user/sh4/cpu_loop.c        | 2 +-
>  linux-user/sparc/cpu_loop.c      | 2 +-
>  linux-user/sparc/signal.c        | 4 ++--
>  linux-user/syscall.c             | 2 +-
>  10 files changed, 15 insertions(+), 15 deletions(-)
> 

I have queued the series for the next pull request.

I think you can also replace the gemu_log("Unknown QEMU_IFLA..."),
qemu_log("Unknown host ..") and qemu_log("Unknown target ...") from the
netlink part in syscall.c with qemu_log_mask(LOG_UNIMP, ...).

Thanks,
Laurent

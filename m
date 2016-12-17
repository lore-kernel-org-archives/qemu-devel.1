Received: from eggs.gnu.org ([2001:4830:134:3::10]:38453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cIDet-0008Jt-4d
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 07:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cIDes-0005gZ-F3
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 07:00:11 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:34387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cIDes-0005g2-AY
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 07:00:10 -0500
Received: by mail-vk0-x22e.google.com with SMTP id x186so101311092vkd.1
	for <qemu-devel@nongnu.org>; Sat, 17 Dec 2016 04:00:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161216191405.9473-2-rth@twiddle.net>
References: <20161216191405.9473-1-rth@twiddle.net>
	<20161216191405.9473-2-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Dec 2016 11:59:49 +0000
Message-ID: <CAFEAcA-MaPLfz213o=z-_dEkAp8m6SYPskGSOYbY2hOfJ6Gq-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 01/26] Revert "Remove remainders of HPPA
 backend"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 December 2016 at 19:13, Richard Henderson <rth@twiddle.net> wrote:
> This reverts commit d41f3c3cc7a5fb9de144cc4022da14a9ff010671.

Missing signed-off-by.

> ---
>  configure                 |    5 +
>  disas.c                   |    2 +
>  disas/Makefile.objs       |    1 +
>  disas/hppa.c              | 2832 +++++++++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h |    4 +-
>  5 files changed, 2842 insertions(+), 2 deletions(-)
>  create mode 100644 disas/hppa.c
>
> diff --git a/configure b/configure
> index f2ba343..6a3ecff 100755
> --- a/configure
> +++ b/configure
> @@ -511,6 +511,8 @@ elif check_define __arm__ ; then
>    cpu="arm"
>  elif check_define __aarch64__ ; then
>    cpu="aarch64"
> +elif check_define __hppa__ ; then
> +  cpu="hppa"
>  else
>    cpu=$(uname -m)
>  fi

This if-ladder is for detecting hppa host CPUs, so you
don't want it for just adding the hppa target support.
Or do you clean this up later in the series so that this
commit is a pure revert?

thanks
-- PMM

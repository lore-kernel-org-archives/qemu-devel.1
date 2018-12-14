Received: from eggs.gnu.org ([2001:4830:134:3::10]:56188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXkZB-00084y-NQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXkZA-0006OT-Os
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:19:33 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXkZA-0006NW-GP
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:19:32 -0500
Received: by mail-oi1-x243.google.com with SMTP id u18so4116416oie.10
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 02:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20181212132735.16080-1-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 10:19:19 +0000
Message-ID: <CAFEAcA-zn7hUx9-mL9nq8JLfJBxZpA2imsDLOJS8igyxFSuM6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/41] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 12 Dec 2018 at 13:27, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 14a8882c0d6660684a0ec7e90cc75d4f38b07f0d:
>
>   iotests: make 235 work on s390 (and others) (2018-12-12 12:22:31 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Decompression worker threads
> - dmg: lzfse compression support
> - file-posix: Simplify delegation to worker thread
> - Don't pass flags to bdrv_reopen_queue()
> - iotests: make 235 work on s390 (and others)


Hi; I get a new warning on FreeBSD, NetBSD, OpenBSD and OSX:
block/file-posix.c:1155:12: warning: 'handle_aiocb_ioctl' defined but
not used [-Wunused-function]
 static int handle_aiocb_ioctl(void *opaque)
            ^

This function is used only from code guarded by #ifdef __linux__
but the function definition itself is not ifdeffed.

thanks
-- PMM

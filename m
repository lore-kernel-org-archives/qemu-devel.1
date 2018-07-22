Received: from eggs.gnu.org ([2001:4830:134:3::10]:36285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fhJt8-0006eW-C1
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fhJt4-0003AT-D1
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:19:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51189)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fhJt4-00039u-2h
	for qemu-devel@nongnu.org; Sun, 22 Jul 2018 15:19:22 -0400
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-11-git-send-email-stefan.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3f90cb11-31be-e303-7843-b8985d576d14@vivier.eu>
Date: Sun, 22 Jul 2018 21:18:40 +0200
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-11-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 10/11] linux-user: Update MIPS syscall
 numbers up to kernel 4.18 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: pburton@wavecomp.com, smarkovic@wavecomp.com, riku.voipio@iki.fi, richard.henderson@linaro.org, philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

Le 19/07/2018 à 14:52, Stefan Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Synchronize content of linux-user/mips/syscall_nr.h and
> linux-user/mips64/syscall_nr.h with Linux kernel 4.18 headers.
> This adds 7 new syscall numbers, the last being NR_statx.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/mips/syscall_nr.h   |  7 +++++++
>  linux-user/mips64/syscall_nr.h | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ePsMc-0003ar-HI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ePsMY-00005H-HX
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:57:30 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:62617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ePsMY-0008Te-6i
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:57:26 -0500
References: <1513351080-25917-1-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d2092e0b-e019-db09-c62c-086f8dfa9d1a@vivier.eu>
Date: Fri, 15 Dec 2017 16:57:15 +0100
MIME-Version: 1.0
In-Reply-To: <1513351080-25917-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Translate flags argument to
 dup3 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Bruno Haible <bruno@clisp.org>

Le 15/12/2017 à 16:18, Peter Maydell a écrit :
> The third argument to dup3() is a flags word which may be
> O_CLOEXEC. We weren't translating this flag from target to
> host value, which meant that if the target used a different
> value from the host (eg sparc guest and x86 host) the dup3()
> call would fail EINVAL. Do the correct translation.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1704658
> Reported-by: Bruno Haible  <bruno@clisp.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

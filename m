Received: from eggs.gnu.org ([2001:4830:134:3::10]:38873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOr22-0003bD-O4
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOr1z-0003qD-NH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:52:18 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOr1z-0003mx-Bx
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:52:15 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-4-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1c041859-c639-98b7-5424-0815800043ad@vivier.eu>
Date: Fri, 1 Jun 2018 22:52:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180531224911.23725-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] linux-user: Check is_hostfd in
 do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

Le 01/06/2018 à 00:49, Richard Henderson a écrit :
> This is the vast majority of all fd inputs, but not all.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 303 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 280 insertions(+), 23 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

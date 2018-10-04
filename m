Received: from eggs.gnu.org ([2001:4830:134:3::10]:60564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g86v2-0000FV-Qp
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g86uu-0003W7-U9
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:56:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g86uu-0003Ux-KV
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:56:00 -0400
References: <20180928142533.8451-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <52177933-047f-d99b-e7d7-2a85e4c8d59c@vivier.eu>
Date: Thu, 4 Oct 2018 18:55:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180928142533.8451-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Suppress
 address-of-packed-member warnings in __get/put_user_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, patches@linaro.org

Le 28/09/2018 à 16:25, Peter Maydell a écrit :
> Our __get_user_e() and __put_user_e() macros cause newer versions
> of clang to generate false-positive -Waddress-of-packed-member
> warnings if they are passed the address of a member of a packed
> struct (see https://bugs.llvm.org/show_bug.cgi?id=39113).
> Suppress these using the _Pragma() operator.
> 
> To put in the pragmas we need to convert the macros from
> expressions to statements, but all the callsites effectively
> treat them as statements already so this is OK.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/qemu.h | 57 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 19 deletions(-)
> 

Applied to my linux-user branch.

Thanks,
Laurent

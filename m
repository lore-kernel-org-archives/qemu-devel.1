Received: from eggs.gnu.org ([2001:4830:134:3::10]:50902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYY2-0002Nr-T9
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYXw-0006Tr-CD
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:15:42 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:36681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPYXw-0006TL-8D
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:15:36 -0400
Received: by mail-qk0-x22b.google.com with SMTP id p21so7854859qke.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 11:15:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-3-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f76e1a00-2421-c92c-e4d9-bdbec8382f57@twiddle.net>
Date: Mon, 26 Jun 2017 11:15:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170625192125.9992-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/m68k: add fmovecr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/25/2017 12:21 PM, Laurent Vivier wrote:
> fmovecr moves a floating point constant from the
> FPU ROM to a floating point register.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/fpu_helper.c | 30 ++++++++++++++++++++++++++++++
>   target/m68k/helper.h     |  1 +
>   target/m68k/translate.c  | 13 ++++++++++++-
>   3 files changed, 43 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

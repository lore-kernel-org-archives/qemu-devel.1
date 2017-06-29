Received: from eggs.gnu.org ([2001:4830:134:3::10]:50736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQd3g-0002Tg-FI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQd3d-0007T7-9u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:16:48 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQd3d-0007St-5O
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 13:16:45 -0400
Received: by mail-qt0-x236.google.com with SMTP id 32so79954944qtv.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 10:16:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170628204241.32106-1-laurent@vivier.eu>
	<20170628204241.32106-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0c2bacd3-7337-b394-b8f9-fcd0904bc6cb@twiddle.net>
Date: Thu, 29 Jun 2017 10:16:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170628204241.32106-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/7] target/m68k: add fscc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/28/2017 01:42 PM, Laurent Vivier wrote:
> use DisasCompare with FPU conditions in fscc and fbcc.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/translate.c | 210 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 131 insertions(+), 79 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

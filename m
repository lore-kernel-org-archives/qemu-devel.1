Received: from eggs.gnu.org ([2001:4830:134:3::10]:53561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNRyX-0004pW-Ru
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNRyU-0000ug-QF
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:50:21 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:32785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNRyU-0000uc-Ll
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:50:18 -0400
Received: by mail-qt0-x235.google.com with SMTP id u12so145067842qth.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:50:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <22b78092-4929-b51e-8e57-47ccb6cefc29@twiddle.net>
Date: Tue, 20 Jun 2017 15:50:15 -0700
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/6] target-m68k: move fmove CR to a
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/20/2017 01:51 PM, Laurent Vivier wrote:
> Move code of fmove to/from control register to a function
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/translate.c | 56 +++++++++++++++++++++++++++----------------------
>   1 file changed, 31 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

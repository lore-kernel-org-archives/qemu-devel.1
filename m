Received: from eggs.gnu.org ([2001:4830:134:3::10]:55178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNS40-0008Vo-Vx
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:56:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNS3x-0002tE-W6
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:56:01 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:34744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNS3x-0002t1-Rd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:55:57 -0400
Received: by mail-qk0-x232.google.com with SMTP id d14so69604937qkb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:55:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-6-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b36c1ed3-d5aa-3417-da3d-d8ec2a1e9540@twiddle.net>
Date: Tue, 20 Jun 2017 15:55:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 5/6] target-m68k: add FPCR and FPSR
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
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/cpu.c        |   2 +-
>   target/m68k/cpu.h        |  43 +++++-
>   target/m68k/fpu_helper.c | 117 +++++++++++++---
>   target/m68k/helper.c     |  22 ++-
>   target/m68k/helper.h     |   5 +-
>   target/m68k/translate.c  | 351 +++++++++++++++++++++++++++++++++++------------
>   6 files changed, 421 insertions(+), 119 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

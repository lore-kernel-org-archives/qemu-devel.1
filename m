Received: from eggs.gnu.org ([2001:4830:134:3::10]:44005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZrd-0004vP-JM
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZrZ-0007fq-O5
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:21 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:36258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbZrZ-0007fi-Js
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:17 -0500
Received: by mail-it0-x244.google.com with SMTP id f200so320970itf.3
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:33:17 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-4-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <29bc76ee-70e2-6cd6-f9ae-654268423aa7@twiddle.net>
Date: Wed, 8 Feb 2017 13:33:09 -0800
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-4-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/16] target-m68k: move FPU helpers to
 fpu_helper.c
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

On 02/06/2017 04:59 PM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/Makefile.objs |   2 +-
>  target/m68k/fpu_helper.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/helper.c      |  88 ------------------------------------
>  3 files changed, 113 insertions(+), 89 deletions(-)
>  create mode 100644 target/m68k/fpu_helper.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

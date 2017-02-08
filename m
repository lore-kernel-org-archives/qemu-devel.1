Received: from eggs.gnu.org ([2001:4830:134:3::10]:43934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZrR-0004nY-RH
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZrN-0007dj-Pz
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:09 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbZrN-0007da-LT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:33:05 -0500
Received: by mail-io0-x244.google.com with SMTP id 101so277095iom.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:33:05 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-3-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <af1506e2-b97e-caf4-032d-1846217ccb4e@twiddle.net>
Date: Wed, 8 Feb 2017 13:32:57 -0800
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/16] softloat: disable
 floatx80_invalid_encoding() for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Andreas Schwab <schwab@linux-m68k.org>, Aurelien Jarno <aurelien@aurel32.net>

On 02/06/2017 04:59 PM, Laurent Vivier wrote:
> According to the comment, this definition of invalid encoding is given
> by intel developer's manual, and doesn't work with the behavior
> of 680x0 FPU.
>
> CC: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

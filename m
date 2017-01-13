Received: from eggs.gnu.org ([2001:4830:134:3::10]:35939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS64a-0004OB-Mx
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS64Z-0007cj-R9
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:55:32 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS64Z-0007cc-MX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:55:31 -0500
Received: by mail-yw0-x243.google.com with SMTP id a10so4249524ywa.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 09:55:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-2-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <099ce4bd-8256-c797-16f8-74d3ee5833ff@twiddle.net>
Date: Fri, 13 Jan 2017 09:55:27 -0800
MIME-Version: 1.0
In-Reply-To: <1484311923-28637-2-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target-m68k: fix bit operation with
 immediate value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 04:51 AM, Laurent Vivier wrote:
> M680x0 bit operations with an immediate value use 9 bits of the 16bit
> value, while coldfire ones use only 8 bits.

I don't see that in the reference manual.  Where do you get this from?


r~

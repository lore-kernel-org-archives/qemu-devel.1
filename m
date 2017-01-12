Received: from eggs.gnu.org ([2001:4830:134:3::10]:58799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cRmhV-0003W9-Tk
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cRmhS-0006le-Ov
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:14:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cRmhS-0006kn-ID
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:14:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so6642365wmi.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 13:14:21 -0800 (PST)
References: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
	<1484252284-29291-6-git-send-email-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <624520be-c04b-7a89-1c00-101912752b02@tuxfamily.org>
Date: Thu, 12 Jan 2017 22:14:19 +0100
MIME-Version: 1.0
In-Reply-To: <1484252284-29291-6-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target-m68k: increment/decrement with
 SP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: rth@twiddle.net

On 12.01.2017 21:18, Laurent Vivier wrote:
> Address Register indirect With postincrement:
> 
> When using the stack pointer (A7) with byte size data, the register
> is incremented by two.
> 
> Address Register indirect With predecrement:
> 
> When using the stack pointer (A7) with byte size data, the register
> is decremented by two.

I think this is only valid for the full 680x0 CPUs. According to
http://www.nxp.com/assets/documents/data/en/reference-manuals/CFPRM.pdf
the stack pointer behaves differently on ColdFire:

"2.2.5 Address Register Indirect with Predecrement Mode [...]
Note that the stack pointer (A7) is treated just like the other address
registers."

 Thomas

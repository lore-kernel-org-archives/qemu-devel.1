Received: from eggs.gnu.org ([2001:4830:134:3::10]:47014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ0lP-0002bL-DJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJ0lL-00043V-9Z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:58:27 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJ0lL-00043K-4s
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:58:23 -0400
Received: by mail-qt0-x244.google.com with SMTP id w1so9455571qtg.0
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:58:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170607225212.23714-1-bobby.prani@gmail.com>
	<20170607225212.23714-4-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7e1288f4-8f85-a92b-d92d-2608e29a13c2@twiddle.net>
Date: Thu, 8 Jun 2017 09:58:19 -0700
MIME-Version: 1.0
In-Reply-To: <20170607225212.23714-4-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] tcg/aarch64: Remove code buffer
 size limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 06/07/2017 03:52 PM, Pranith Kumar wrote:
> This enables indirect jump on aarch64 hosts. Tested by booting an x86 guest on aarch64 host.

This patch is doing too many things.

One patch should be the switch to indirect chaining (which should also squash 
in the 2/3 patch, otherwise tcg_out_insn_3305 is unused and therefore provokes 
a Werror).

Second, you should consider merely softening the code buffer size limitation to 
2GB.  At that point, we still use just ADRP+ADD to form the return address for 
exit_tb.

Third, if you want to go beyond 2GB to no limit at all, then we need to 
consider reserving a register to contain the return address back to the epilogue.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ewVgE-0007HG-VK
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ewVgA-0000FM-2g
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:24:38 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ewVg9-0000Es-Rz
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 12:24:33 -0400
Received: by mail-pf0-x242.google.com with SMTP id a16so3007711pfn.9
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 09:24:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180312202728.23790-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7d6d23cf-f4cc-998a-6a7f-2ba805273c57@twiddle.net>
Date: Fri, 16 Mar 2018 00:24:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180312202728.23790-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/11] implement 680x0 FPU (part 5)
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

On 03/13/2018 04:27 AM, Laurent Vivier wrote:
> I have compared results of these instructions from a real m68040 and from
> QEMU, and they match (sincos differs [1] because in QEMU we compute it as
> sin and cos, and on m68040 sin and cos results differ also with
> sincos results. It looks like a rounding problem, perhaps a bug in m68040
> FPU? or in my test program?)
> 
> I know this will need more work, but for the moment I only would
> like to provide these new instructions to the maintream of QEMU.
> 
> [1] Example:
> 
> sincos -6.125952 -> (0.156586, 0.987664)
> 
> QEMU:
> 
>   sincos c0010000c407cd1182c2bb27 -> 3ffc0000a05812beea449a4d
>                                      3ffe0000fcd791d65887d19a
>   sin c0010000c407cd1182c2bb27    -> 3ffc0000a05812beea449a4d
>   cos c0010000c407cd1182c2bb27    -> 3ffe0000fcd791d65887d19a
> 
> m68040:
> 
>   sincos c0010000c407cd1182c2bb27 -> 3ffc0000a05812beea449a4d
>                                      3ffe0000fcd791d65887d199 <<--
>   sin c0010000c407cd1182c2bb27    -> 3ffc0000a05812beea449a4d
>   cos c0010000c407cd1182c2bb27    -> 3ffe0000fcd791d65887d19a

Wow, this does seem like a processor bug.

Anyway, I've looked through the patch set and nothing stands out,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

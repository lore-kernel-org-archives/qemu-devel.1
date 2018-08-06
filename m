Received: from eggs.gnu.org ([2001:4830:134:3::10]:53595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fmn60-0007B4-DD
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 17:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fmn5w-00035n-GH
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 17:31:20 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36825
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fmn5w-00030O-7S
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 17:31:16 -0400
References: <20180806012723.5639-1-richard.henderson@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9c0ca738-16ef-1d28-7282-9fdb6f753216@ilande.co.uk>
Date: Mon, 6 Aug 2018 22:30:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180806012723.5639-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/ppc: Fixes for my fpu cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au

On 06/08/18 02:27, Richard Henderson wrote:

> David, please squash these with the patches you already
> have on your ppc-for-3.1 branch.
> 
> The first fixes fp division within the vector insns.
> The second fixes some typos within the load/store converters
> as reported by Mark Cave-Ayland.

I've just given David's updated ppc-for-3.1 branch a spin with my 
OpenBIOS test images and it looks like MacOS 9 is working again, and no 
obvious regressions spotted so far - thanks a lot!


ATB,

Mark.

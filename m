Received: from eggs.gnu.org ([2001:4830:134:3::10]:43544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnUg-0005xK-NL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnUc-0007aQ-L0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:11:54 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnUc-0007aM-GU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:11:50 -0400
Received: by mail-qk0-x244.google.com with SMTP id y128so13380857qka.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:11:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-18-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <865f56fd-ea73-d960-e431-b3f5893434fc@twiddle.net>
Date: Tue, 30 May 2017 13:11:45 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-18-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/29] target/s390x: fix COMPARE LOGICAL
 LONG EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> There are multiple issues with the COMPARE LOGICAL LONG EXTENDED
> instruction:
> - The test between the two operands is inverted, leading to an inversion
>    of the cc values 1 and 2.
> - The address and length of an operand continue to be decreased after
>    reaching the end of this operand. These values are then wrong write
>    back to the registers.
> - We should limit the amount of bytes to process, so that interrupts can
>    be served correctly.
> 
> At the same time rename dest into src1 and src into src3 to match the
> operand names and make the code less confusing.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 54 ++++++++++++++++++++++++++++++++---------------
>   target/s390x/translate.c  | 20 +++++++++++++-----
>   2 files changed, 52 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

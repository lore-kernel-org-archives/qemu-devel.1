Received: from eggs.gnu.org ([2001:4830:134:3::10]:49611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CBk-00039L-8k
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CBj-0004MZ-KW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:56:56 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CBj-0004MS-Gp
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:56:55 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so1902084qkh.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 13:56:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-4-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <eefc8ccf-0188-90f3-e0b3-12ca580df085@twiddle.net>
Date: Tue, 9 May 2017 13:56:51 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/14] target/sh4: do not include
 DELAY_SLOT_TRUE in the TB state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> DELAY_SLOT_TRUE is used as a dynamic condition for the branch after the
> delay slot instruction. It is not used in code generation, so there is
> no need to including in the TB state.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/cpu.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

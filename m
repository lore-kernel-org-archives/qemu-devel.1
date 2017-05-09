Received: from eggs.gnu.org ([2001:4830:134:3::10]:50852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CEB-0005EL-KU
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CEA-0005O0-PB
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:59:27 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CEA-0005Nm-LA
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:59:26 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so1910275qkh.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 13:59:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-5-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <987e9c0a-019b-a717-455e-4f5ec992df23@twiddle.net>
Date: Tue, 9 May 2017 13:59:23 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-5-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/14] target/sh4: move DELAY_SLOT_TRUE
 flag into a separate global
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
> Instead of using one bit of the env flags to store the condition of the
> next delay slot, use a separate global. It simplifies reading and
> writing the flags variable and also removes some confusion between
> ctx->envflags and env->flags.
> 
> Note that the global is first transfered to a temp in order to be
> able to discard the global before the brcond.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/cpu.h       | 10 ++--------
>   target/sh4/helper.c    |  2 +-
>   target/sh4/translate.c | 22 +++++++++++++---------
>   3 files changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

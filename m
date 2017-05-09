Received: from eggs.gnu.org ([2001:4830:134:3::10]:49440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CBS-0002rV-L8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CBR-0004HA-SJ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:56:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CBR-0004Gy-NS
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:56:37 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so1600994qtb.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 13:56:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-3-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c8eee3cf-fdad-82b4-8fd6-e9a3874e05a5@twiddle.net>
Date: Tue, 9 May 2017 13:56:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/14] target/sh4: get rid of
 DELAY_SLOT_CLEARME
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
> Now that ctx->flags has been split, it becomes clear that
> DELAY_SLOT_CLEARME has not impact on the code generation: in both case
> ctx->envflags is cleared, either by clearing all the flags, or by
> setting it to 0. This is left-over from pre-TCG era.
> 
> Reviewed-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/cpu.h       |  3 +--
>   target/sh4/helper.c    |  2 --
>   target/sh4/translate.c | 17 +++++------------
>   3 files changed, 6 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~

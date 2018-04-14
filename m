Received: from eggs.gnu.org ([2001:4830:134:3::10]:38833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7PC8-0000mc-3G
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 13:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f7PC5-00038C-H5
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 13:42:36 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:36172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f7PC5-00037i-BE
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 13:42:33 -0400
Received: by mail-pl0-x244.google.com with SMTP id 91-v6so7780675pld.3
	for <qemu-devel@nongnu.org>; Sat, 14 Apr 2018 10:42:33 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-16-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a5cff7c-16e4-24f1-f2ea-574974cf9354@linaro.org>
Date: Fri, 13 Apr 2018 18:05:47 -1000
MIME-Version: 1.0
In-Reply-To: <1522980788-1252-16-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 15/17] cputlb: remove tb_lock from
 tlb_flush functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04/05/2018 04:13 PM, Emilio G. Cota wrote:
> The acquisition of tb_lock was added when the async tlb_flush
> was introduced in e3b9ca810 ("cputlb: introduce tlb_flush_* async work.")
> 
> tb_lock was there to allow us to do memset() on the tb_jmp_cache's.
> However, since f3ced3c5928 ("tcg: consistently access cpu->tb_jmp_cache
> atomically") all accesses to tb_jmp_cache are atomic, so tb_lock
> is not needed here. Get rid of it.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/cputlb.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

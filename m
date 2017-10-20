Received: from eggs.gnu.org ([2001:4830:134:3::10]:48554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5Mvo-0005Ko-Ea
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5Mvk-0006Ic-BJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:21:04 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:56054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5Mvk-0006Ha-3n
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 22:21:00 -0400
Received: by mail-pf0-x241.google.com with SMTP id 17so8797248pfn.12
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 19:20:59 -0700 (PDT)
References: <1508445114-4717-1-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aff65410-d804-36c5-1d97-83c50625e36f@linaro.org>
Date: Thu, 19 Oct 2017 19:20:56 -0700
MIME-Version: 1.0
In-Reply-To: <1508445114-4717-1-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] translate-all: exit from
 tb_phys_invalidate if qht_remove fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/19/2017 01:31 PM, Emilio G. Cota wrote:
> Two or more threads might race while invalidating the same TB. We currently
> do not check for this at all despite taking tb_lock, which means we would
> wrongly invalidate the same TB more than once. This bug has actually been
> hit by users: I recently saw a report on IRC, although I have yet to see
> the corresponding test case.
> 
> Fix this by using qht_remove as the synchronization point; if it fails,
> that means the TB has already been invalidated, and therefore there
> is nothing left to do in tb_phys_invalidate.
> 
> Note that this solution works now that we still have tb_lock, and will
> continue working once we remove tb_lock.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> ---
> This patch applies on top of the "[PATCH v6 00/50] tcg tb_lock removal" series:
> https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03612.html
> ---
>  accel/tcg/translate-all.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.


r~

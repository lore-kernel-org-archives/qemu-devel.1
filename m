Received: from eggs.gnu.org ([2001:4830:134:3::10]:38366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXlK-0006nF-5X
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXlJ-0004hs-6I
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:19:54 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:50968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCXlI-0004hE-WD
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:19:53 -0500
Received: by mail-wm0-x241.google.com with SMTP id s66so13064813wmf.5
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 13:19:52 -0800 (PST)
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3388bfb4-256f-e145-1521-7ac7dd1aa5b7@linaro.org>
Date: Wed, 8 Nov 2017 22:19:49 +0100
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] linux-user/ppc: Report correct fault
 address for data faults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 11/06/2017 07:33 PM, Peter Maydell wrote:
> For faults on loads and stores, ppc_cpu_handle_mmu_fault() in
> target/ppc/user_only_helper.c stores the offending address
> in env->spr[SPR_DAR]. Report this correctly to the guest
> in si_addr, rather than incorrectly using the address of the
> instruction that caused the fault.
> 
> This fixes the test case in
> https://bugs.launchpad.net/qemu/+bug/1077116
> for ppc, ppc64 and ppc64le.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

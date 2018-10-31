Received: from eggs.gnu.org ([2001:4830:134:3::10]:45878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzTR-00058x-FO
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHzTN-00087W-BP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:00:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHzTK-00082z-OT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 19:00:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id h2-v6so12805492wmb.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 16:00:16 -0700 (PDT)
References: <20181031213550.4544-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13f47aff-593a-e35e-959b-4ddd9f6c6121@linaro.org>
Date: Wed, 31 Oct 2018 23:00:12 +0000
MIME-Version: 1.0
In-Reply-To: <20181031213550.4544-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: drop num_[core_]regs from
 dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 10/31/18 9:35 PM, Max Filippov wrote:
> gdb_regmap::num_core_regs field is initialized incorrectly in the dc232b
> and dc233c configurations. As a result the following message is
> displayed when attaching to an xtensa linux-user process:
> 
>   "Register 105 is not available",
> 
> and gdb is unable to control the inferior.
> 
> Now that xtensa_count_regs does the right thing, remove manual
> initialization of these fields from the affected configurations and let
> xtensa_finalize_config initialize them.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/core-dc232b.c | 2 --
>  target/xtensa/core-dc233c.c | 2 --
>  2 files changed, 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

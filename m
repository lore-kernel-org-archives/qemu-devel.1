Received: from eggs.gnu.org ([2001:4830:134:3::10]:33544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNoEZ-0006qO-NF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNoEV-00020U-KE
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:36:23 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNoEV-00020F-FV
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:36:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id r62so17729276qkf.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 15:36:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
	<1498040401-16361-12-git-send-email-yang.zhong@intel.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8827f1a5-6ddd-d032-5d89-34567ead5d43@twiddle.net>
Date: Wed, 21 Jun 2017 15:36:15 -0700
MIME-Version: 1.0
In-Reply-To: <1498040401-16361-12-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/15] tcg: split
 cpu_set_mxcsr()/cpu_set_fpuc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org, a.rigo@virtualopensystems.com

On 06/21/2017 03:19 AM, Yang Zhong wrote:
> Split the cpu_set_mxcsr()/cpu_set_fpuc() with specific tcg code.
> tcg_update_mxcsr()/tcg_set_fpuc() need be implemented in tcg-stub.c
> file if tcg is disabled.
> 
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>   accel/stubs/tcg-stub.c   |  8 ++++++++
>   target/i386/cpu.h        | 15 +++++++++++++--
>   target/i386/fpu_helper.c |  8 +++-----
>   3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
> index dafb1d0..91625a8 100644
> --- a/accel/stubs/tcg-stub.c
> +++ b/accel/stubs/tcg-stub.c
> @@ -75,6 +75,14 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
>   {
>   }
>   
> +void tcg_update_mxcsr(CPUX86State *env)
> +{
> +}
> +
> +void tcg_set_fpuc(CPUX86State *env)
> +{
> +}

Do not put x86-specific functions in what is clearly a target-independent file.
Paolo gave you one way of doing that for this case.


r~

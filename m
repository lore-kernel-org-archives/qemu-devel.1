Received: from eggs.gnu.org ([2001:4830:134:3::10]:34062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gThOQ-00014o-R5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gThON-00069l-LR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:07:42 -0500
References: <20181130192216.26987-1-richard.henderson@linaro.org>
	<20181130192216.26987-2-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <57ecd585-2e85-6f5a-5276-3d1a84b13e27@redhat.com>
Date: Mon, 3 Dec 2018 07:07:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181130192216.26987-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.0 1/2] target/s390x:
 Move TOD_UNIX_EPOCH to cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com

On 2018-11-30 20:22, Richard Henderson wrote:
> We will need this from CONFIG_USER_ONLY as well,
> which cannot access include/hw/.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/hw/s390x/tod.h | 3 ---
>  target/s390x/cpu.h     | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
> index 413c0d7c02..6ec4fb426c 100644
> --- a/include/hw/s390x/tod.h
> +++ b/include/hw/s390x/tod.h
> @@ -44,9 +44,6 @@ typedef struct S390TODClass {
>      void (*set)(S390TODState *td, const S390TOD *tod, Error **errp);
>  } S390TODClass;
>  
> -/* The value of the TOD clock for 1.1.1970. */
> -#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
> -
>  /* Converts ns to s390's clock format */
>  static inline uint64_t time2tod(uint64_t ns)
>  {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 8c2320e882..d8049d181a 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -797,4 +797,7 @@ void s390_init_sigp(void);
>  /* outside of target/s390x/ */
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
>  
> +/* The value of the TOD clock for 1.1.1970. */
> +#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
> +
>  #endif
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

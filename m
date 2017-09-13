Received: from eggs.gnu.org ([2001:4830:134:3::10]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds8dQ-00028R-7o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds8dP-0000H2-Bg
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ds8dP-0000Gc-5L
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:27:23 -0400
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d75bd287-b96f-6e18-5d2b-3f024354eeab@redhat.com>
Date: Wed, 13 Sep 2017 16:27:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170913132417.24384-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 07/22] target/s390x: move some s390x
 typedefs to cpu-qom.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 13.09.2017 15:24, David Hildenbrand wrote:
> This allows us to drop inclusion of cpu_models.h in cpu-qom.h, and
> prepares for using cpu-qom.h as a s390 specific version of typedefs.h
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu-qom.h    | 5 ++++-
>  target/s390x/cpu.h        | 5 +++--
>  target/s390x/cpu_models.h | 8 ++++----
>  3 files changed, 11 insertions(+), 7 deletions(-)
[...]
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 372f7d8885..4a0a59dfbc 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -25,6 +25,7 @@
>  
>  #include "qemu-common.h"
>  #include "cpu-qom.h"
> +#include "cpu_models.h"

Do we really need to include cpu_models.h here? Looking at your changes
below, it does not seem to be necessary?

>  #define TARGET_LONG_BITS 64
>  
> @@ -80,7 +81,7 @@ typedef struct MchkQueue {
>      uint16_t type;
>  } MchkQueue;
>  
> -typedef struct CPUS390XState {
> +struct CPUS390XState {
>      uint64_t regs[16];     /* GP registers */
>      /*
>       * The floating point registers are part of the vector registers.
> @@ -174,7 +175,7 @@ typedef struct CPUS390XState {
>      /* currently processed sigp order */
>      uint8_t sigp_order;
>  
> -} CPUS390XState;
> +};
>  
>  static inline CPU_DoubleU *get_freg(CPUS390XState *cs, int nr)
>  {

 Thomas

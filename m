Received: from eggs.gnu.org ([2001:4830:134:3::10]:52359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewYEJ-0003tU-Q4
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ewYEG-0007JY-H2
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ewYEG-0007Ix-BG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:07:56 -0400
Date: Thu, 15 Mar 2018 16:07:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180315190753.GG28578@localhost.localdomain>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
	<1520888449-4352-2-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520888449-4352-2-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/5] target/i386: Generalize some of the
 macro definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, rkrcmar@redhat.com, Thomas.Lendacky@amd.com, brijesh.singh@amd.com, kvm@vger.kernel.org, kash@tripleback.net, mtosatti@redhat.com, Gary.Hook@amd.com, qemu-devel@nongnu.org

Hi,

Sorry for not reviewing the previous versions of this series
(making it miss soft freeze).


On Mon, Mar 12, 2018 at 05:00:45PM -0400, Babu Moger wrote:
> Generalize some of the macro definitions which are generic cache
> properties that are common between CPUID 4 and CPUID 0x8000001D
> in preparation for adding support for 0x8000001D.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  target/i386/cpu.c | 52 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b5e431e..42dd381 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -66,22 +66,22 @@
>  #define CPUID_2_L3_16MB_16WAY_64B 0x4d
>  
>  
> -/* CPUID Leaf 4 constants: */
> +/* Cache specific constants: */

We have too many CPUID leaves that describe caches, so I would
like to explicitly document on which CPUID leaves these macros
can be used.  I suggest:

  /* Macros for CPUID[4] and CPUID[0x8000001D] */


>  
>  /* EAX: */
> -#define CPUID_4_TYPE_DCACHE  1
> -#define CPUID_4_TYPE_ICACHE  2
> -#define CPUID_4_TYPE_UNIFIED 3
> +#define TYPE_DCACHE  1
> +#define TYPE_ICACHE  2
> +#define TYPE_UNIFIED 3

TYPE_* can be confused with QOM type names, I'd use something
else.  Maybe CACHE_TYPE_D, CACHE_TYPE_I, CACHE_TYPE_UNIFIED?


>  
> -#define CPUID_4_LEVEL(l)          ((l) << 5)
> +#define CACHE_LEVEL(l)          ((l) << 5)
>  
> -#define CPUID_4_SELF_INIT_LEVEL (1 << 8)
> -#define CPUID_4_FULLY_ASSOC     (1 << 9)
> +#define CACHE_SELF_INIT_LEVEL (1 << 8)
> +#define CACHE_FULLY_ASSOC     (1 << 9)
>  
>  /* EDX: */
> -#define CPUID_4_NO_INVD_SHARING (1 << 0)
> -#define CPUID_4_INCLUSIVE       (1 << 1)
> -#define CPUID_4_COMPLEX_IDX     (1 << 2)
> +#define CACHE_NO_INVD_SHARING (1 << 0)
> +#define CACHE_INCLUSIVE       (1 << 1)
> +#define CACHE_COMPLEX_IDX     (1 << 2)
>  
>  #define ASSOC_FULL 0xFF
>  
[...]

-- 
Eduardo
